# free5GC Webconsole 一鍵 mock 部署核准

本次變更在現有 Webconsole submodule 加入共用授權服務、角色/Agent 管理、部署請求頁、核准 API、自動 mock worker 與 stdio MCP。人類按一次「核准並部署」即可排入工作，網頁自動更新，Agent 查詢同一個 job；不再要求 CLI 核准或「繼續」Prompt。

操作、初始化、MCP、角色遷移與測試方式請見 [Webconsole README](webconsole/README-RBAC.md)。

## 真實 Codex Agent Team

新增 `/agent-team`：在 Webconsole 直接輸入 Prompt，真實 Codex Coordinator 分派 Installer/Troubleshooter，顯示每個角色真正取得的 MCP 工具清單、選擇、參數、授權與結果。使用既有 Codex ChatGPT 登入，不另需 API key。安裝工具只有 plan-only handler，不執行系統安裝。

操作与限制見 [Agent Team README](webconsole/README-AGENT-TEAM.md)，[實際模型／MCP 驗收](webconsole/docs/team-evidence/README.md)。既有 demo launcher 已同時啟用 Team；完整 Webconsole 可使用 `bash scripts/rbac/agent-team-webconsole.sh` opt-in。原 `/deployments` 保持 mock 部署工作，與真實 Team 決策頁分開。

## 本機試用

使用已安裝的 Go/Node/Yarn/MongoDB，不執行 quick-setup.sh：

```bash
export PATH=/usr/local/go/bin:$PATH
bash scripts/rbac/build.sh
cd webconsole
python3 tools/mock_demo.py --state-dir /tmp/free5gc-rbac-demo-local
```

第一次設定 demo owner；之後用相同 state-dir 重啟不重設帳密。開啟 `http://127.0.0.1:5080/deployments`，Agent 授權主機填 `mock-demo-host`。這是獨立 demo，資料與服務不連到既有 free5GC 或兩個 PoC。

主 repo 整合檔案：

| 檔案 | 用途 |
|---|---|
| `scripts/rbac/agent-team-webconsole.sh` | opt-in 真實 Codex Team，安裝工具僅產生計畫 |
| `scripts/rbac/build.sh` | 僅建置 Webconsole、bootstrap、demo 與前端 |
| `scripts/rbac/mock-webconsole.sh` | opt-in mock 設定；固定目前 checkout commit/腳本 SHA256 |
| `scripts/rbac/webconsole-mock.service.example` | 非 root systemd 範本，沒有自動安裝 |
| `scripts/rbac/webconsole-mock.env.example` | 可檢阅的 mock 配置範本 |

## 環境保留與範圍

開工時主 repo 在 `main`；Webconsole 基底是規格指定的 `c40b94b6896109e90e46e59d57ebc5f7fa4c32a2`，沒有降版或替換 checkout。既有 `cert/nrf.pem`、AMF/SMF/UPF 配置、備份、free-ran-ue 與 session 文件保留，未納入本次功能 commit。

已閱讀 `/home/ubuntu/free5gc-approval-poc` 和 `/home/ubuntu/free5gc-real-deploy-poc` 的來源、worker 與 README。它們與 `/opt` 執行版本分開，沒有覆寫、重啟或停用現有服務，也沒有清理 `/home/ubuntu/go`、gtp5g 或 `/var/lib` 部署產物。

開工只讀查詢確認舊真實工作 `req-043fc3344924` 已是 `succeeded`，exit code 0，broker 回報安裝檢查通過；沒有驗證 NF 啟動或 UE 上網。此結果是舊 PoC 的工作，不是新 Webconsole 的部署測試。

新整合預設關閉；opt-in 也只提供 mock。真實 worker、受保護固定腳本與 upstream main 解析尚未接上。沒有執行安裝、sudoers、UFW 或系統權限變更。systemd 範本僅是 reviewable artifact，不代表服務已安裝。

Webconsole 與主 repo 分別保存在本機 commit，主 repo 指向修改後 submodule commit；沒有推送、發布或 merge。若轉交到另一個 clone，需要同時轉交 Webconsole branch/commit，僅主 repo 的 gitlink 不包含 submodule 內容。

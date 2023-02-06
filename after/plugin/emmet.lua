local emmet_status_ok, emmet = pcall(require, "emmet-vim")
if not emmet_status_ok then
  return
end

emmet.setup {}


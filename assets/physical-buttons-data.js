window.FLOWSYNC_PHYSICAL_BUTTON_CATEGORIES = [
  { id: "control", title: "Control Buttons", count: 6 },
  { id: "dev", title: "Developer Buttons", count: 6 },
  { id: "media", title: "Media Buttons", count: 5 },
  { id: "commerce", title: "Commerce Buttons", count: 5 },
  { id: "creative", title: "Creative Buttons", count: 4 },
  { id: "security", title: "Security Buttons", count: 4 }
];

window.FLOWSYNC_PHYSICAL_BUTTONS = [
  { id:"pb-01", category:"control", title:"Power Press", desc:"A physical power button that sinks, glows, and changes state.", off:"Power Off", on:"Power On", iconOff:"○", iconOn:"⏻", cls:"fp-power" },
  { id:"pb-02", category:"control", title:"Launch Key", desc:"A raised launch key with safety-arm state.", off:"Standby", on:"Launched", iconOff:"◇", iconOn:"◆", cls:"fp-launch" },
  { id:"pb-03", category:"control", title:"Confirm Stamp", desc:"A stamp-like button that presses down and marks confirmed.", off:"Confirm", on:"Confirmed", iconOff:"?", iconOn:"✓", cls:"fp-stamp" },
  { id:"pb-04", category:"control", title:"Hold Switch Button", desc:"Button locks down physically after first click.", off:"Hold", on:"Locked", iconOff:"⌁", iconOn:"■", cls:"fp-hold" },
  { id:"pb-05", category:"control", title:"Start Engine", desc:"Engine-style button with vibration pulse after activation.", off:"Start", on:"Running", iconOff:"↻", iconOn:"⚡", cls:"fp-engine" },
  { id:"pb-06", category:"control", title:"Emergency Soft", desc:"Soft danger button that becomes safe on second state.", off:"Stop", on:"Safe", iconOff:"!", iconOn:"✓", cls:"fp-emergency" },

  { id:"pb-07", category:"dev", title:"Deploy Button", desc:"Dev button moves from draft to deployed.", off:"Deploy", on:"Deployed", iconOff:"⌘", iconOn:"↗", cls:"fp-deploy" },
  { id:"pb-08", category:"dev", title:"Run Build", desc:"Terminal key that changes into build running.", off:"Run Build", on:"Built", iconOff:">", iconOn:"✓", cls:"fp-build" },
  { id:"pb-09", category:"dev", title:"Merge Key", desc:"Git-style button with branch merge state.", off:"Merge", on:"Merged", iconOff:"⑂", iconOn:"⑃", cls:"fp-merge" },
  { id:"pb-10", category:"dev", title:"Debug Punch", desc:"Debug button punches inward and turns trace mode on.", off:"Debug", on:"Tracing", iconOff:"⚙", iconOn:"⌁", cls:"fp-debug" },
  { id:"pb-11", category:"dev", title:"API Connect", desc:"Connector button that physically snaps into connected state.", off:"Connect", on:"Connected", iconOff:"○", iconOn:"●", cls:"fp-api" },
  { id:"pb-12", category:"dev", title:"Copy Token", desc:"Copy button changes into copied with tactile press.", off:"Copy Token", on:"Copied", iconOff:"□", iconOn:"✓", cls:"fp-copy" },

  { id:"pb-13", category:"media", title:"Play Plate", desc:"Raised media plate that changes play to pause.", off:"Play", on:"Pause", iconOff:"▶", iconOn:"Ⅱ", cls:"fp-play" },
  { id:"pb-14", category:"media", title:"Record Button", desc:"Physical record button with red live state.", off:"Record", on:"Recording", iconOff:"●", iconOn:"●", cls:"fp-record" },
  { id:"pb-15", category:"media", title:"Mute Button", desc:"Audio button with mute/sound state.", off:"Mute", on:"Sound", iconOff:"♪", iconOn:"♫", cls:"fp-mute" },
  { id:"pb-16", category:"media", title:"Replay Button", desc:"Replay button rotates on state change.", off:"Replay", on:"Again", iconOff:"↻", iconOn:"↺", cls:"fp-replay" },
  { id:"pb-17", category:"media", title:"Live Button", desc:"Broadcast button becomes live with pulse.", off:"Go Live", on:"Live", iconOff:"○", iconOn:"●", cls:"fp-live" },

  { id:"pb-18", category:"commerce", title:"Checkout Press", desc:"Premium checkout button that depresses into paid state.", off:"Checkout", on:"Paid", iconOff:"◆", iconOn:"✓", cls:"fp-checkout" },
  { id:"pb-19", category:"commerce", title:"Add Cart", desc:"Cart button becomes added with a physical slide.", off:"Add Cart", on:"Added", iconOff:"+", iconOn:"✓", cls:"fp-cart" },
  { id:"pb-20", category:"commerce", title:"Reserve Seat", desc:"Reservation button locks into reserved state.", off:"Reserve", on:"Reserved", iconOff:"◇", iconOn:"◆", cls:"fp-reserve" },
  { id:"pb-21", category:"commerce", title:"Upgrade Button", desc:"Upgrade button lifts then locks to Pro.", off:"Upgrade", on:"Pro Active", iconOff:"↑", iconOn:"✦", cls:"fp-upgrade" },
  { id:"pb-22", category:"commerce", title:"Claim Deal", desc:"Deal button stamps into claimed state.", off:"Claim", on:"Claimed", iconOff:"%", iconOn:"✓", cls:"fp-claim" },

  { id:"pb-23", category:"creative", title:"Render Key", desc:"Creator render button changes into rendered.", off:"Render", on:"Rendered", iconOff:"◇", iconOn:"✧", cls:"fp-render" },
  { id:"pb-24", category:"creative", title:"Export Press", desc:"Export button presses inward and becomes exported.", off:"Export", on:"Exported", iconOff:"⇣", iconOn:"✓", cls:"fp-export" },
  { id:"pb-25", category:"creative", title:"Palette Button", desc:"Color button blooms after activation.", off:"Palette", on:"Styled", iconOff:"◌", iconOn:"✺", cls:"fp-palette" },
  { id:"pb-26", category:"creative", title:"Publish Button", desc:"Publication button changes from draft to published.", off:"Publish", on:"Published", iconOff:"✎", iconOn:"↗", cls:"fp-publish" },

  { id:"pb-27", category:"security", title:"Unlock Button", desc:"Security button physically opens lock state.", off:"Unlock", on:"Unlocked", iconOff:"🔒", iconOn:"🔓", cls:"fp-unlock" },
  { id:"pb-28", category:"security", title:"Verify Button", desc:"Verification button turns into verified shield.", off:"Verify", on:"Verified", iconOff:"?", iconOn:"✓", cls:"fp-verify" },
  { id:"pb-29", category:"security", title:"Trust Device", desc:"Device trust button turns into trusted state.", off:"Trust", on:"Trusted", iconOff:"◇", iconOn:"◈", cls:"fp-trust" },
  { id:"pb-30", category:"security", title:"Encrypt Button", desc:"Privacy button clamps into encrypted mode.", off:"Encrypt", on:"Encrypted", iconOff:"□", iconOn:"▣", cls:"fp-encrypt" }
];

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09CA91A60A
	for <lists+bpf@lfdr.de>; Sat, 11 May 2019 03:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbfEKBDT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 May 2019 21:03:19 -0400
Received: from www62.your-server.de ([213.133.104.62]:44102 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbfEKBDT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 May 2019 21:03:19 -0400
Received: from [178.199.41.31] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hPGQ0-0004Op-ST; Sat, 11 May 2019 03:03:16 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     ast@kernel.org
Cc:     jakub.kicinski@netronome.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf 1/2] bpf: fix out of bounds backwards jmps due to dead code removal
Date:   Sat, 11 May 2019 03:03:09 +0200
Message-Id: <20190511010310.17323-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25445/Fri May 10 09:58:32 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

systemtap folks reported the following splat recently:

  [ 7790.862212] WARNING: CPU: 3 PID: 26759 at arch/x86/kernel/kprobes/core.c:1022 kprobe_fault_handler+0xec/0xf0
  [...]
  [ 7790.864113] CPU: 3 PID: 26759 Comm: sshd Not tainted 5.1.0-0.rc7.git1.1.fc31.x86_64 #1
  [ 7790.864198] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS[...]
  [ 7790.864314] RIP: 0010:kprobe_fault_handler+0xec/0xf0
  [ 7790.864375] Code: 48 8b 50 [...]
  [ 7790.864714] RSP: 0018:ffffc06800bdbb48 EFLAGS: 00010082
  [ 7790.864812] RAX: ffff9e2b75a16320 RBX: 0000000000000000 RCX: 0000000000000000
  [ 7790.865306] RDX: ffffffffffffffff RSI: 000000000000000e RDI: ffffc06800bdbbf8
  [ 7790.865514] RBP: ffffc06800bdbbf8 R08: 0000000000000000 R09: 0000000000000000
  [ 7790.865960] R10: 0000000000000000 R11: 0000000000000000 R12: ffffc06800bdbbf8
  [ 7790.866037] R13: ffff9e2ab56a0418 R14: ffff9e2b6d0bb400 R15: ffff9e2b6d268000
  [ 7790.866114] FS:  00007fde49937d80(0000) GS:ffff9e2b75a00000(0000) knlGS:0000000000000000
  [ 7790.866193] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [ 7790.866318] CR2: 0000000000000000 CR3: 000000012f312000 CR4: 00000000000006e0
  [ 7790.866419] Call Trace:
  [ 7790.866677]  do_user_addr_fault+0x64/0x480
  [ 7790.867513]  do_page_fault+0x33/0x210
  [ 7790.868002]  async_page_fault+0x1e/0x30
  [ 7790.868071] RIP: 0010:          (null)
  [ 7790.868144] Code: Bad RIP value.
  [ 7790.868229] RSP: 0018:ffffc06800bdbca8 EFLAGS: 00010282
  [ 7790.868362] RAX: ffff9e2b598b60f8 RBX: ffffc06800bdbe48 RCX: 0000000000000004
  [ 7790.868629] RDX: 0000000000000004 RSI: ffffc06800bdbc6c RDI: ffff9e2b598b60f0
  [ 7790.868834] RBP: ffffc06800bdbcf8 R08: 0000000000000000 R09: 0000000000000004
  [ 7790.870432] R10: 00000000ff6f7a03 R11: 0000000000000000 R12: 0000000000000001
  [ 7790.871859] R13: ffffc06800bdbcb8 R14: 0000000000000000 R15: ffff9e2acd0a5310
  [ 7790.873455]  ? vfs_read+0x5/0x170
  [ 7790.874639]  ? vfs_read+0x1/0x170
  [ 7790.875834]  ? trace_call_bpf+0xf6/0x260
  [ 7790.877044]  ? vfs_read+0x1/0x170
  [ 7790.878208]  ? vfs_read+0x5/0x170
  [ 7790.879345]  ? kprobe_perf_func+0x233/0x260
  [ 7790.880503]  ? vfs_read+0x1/0x170
  [ 7790.881632]  ? vfs_read+0x5/0x170
  [ 7790.882751]  ? kprobe_ftrace_handler+0x92/0xf0
  [ 7790.883926]  ? __vfs_read+0x30/0x30
  [ 7790.885050]  ? ftrace_ops_assist_func+0x94/0x100
  [ 7790.886183]  ? vfs_read+0x1/0x170
  [ 7790.887283]  ? vfs_read+0x5/0x170
  [ 7790.888348]  ? ksys_read+0x5a/0xe0
  [ 7790.889389]  ? do_syscall_64+0x5c/0xa0
  [ 7790.890401]  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe

After some debugging, turns out that the logic in 2cbd95a5c4fb
("bpf: change parameters of call/branch offset adjustment") has
a bug that is exposed after 52875a04f4b2 ("bpf: verifier: remove
dead code") in that we miss some of the jump offset adjustments
after code patching when we remove dead code, more concretely,
upon backward jump spanning over the area that is being removed.

BPF insns of a case that was hit pre 52875a04f4b2:

  [...]
  676: (85) call bpf_perf_event_output#-47616
  677: (05) goto pc-636
  678: (62) *(u32 *)(r10 -64) = 0
  679: (bf) r7 = r10
  680: (07) r7 += -64
  681: (05) goto pc-44
  682: (05) goto pc-1
  683: (05) goto pc-1

BPF insns afterwards:

  [...]
  618: (85) call bpf_perf_event_output#-47616
  619: (05) goto pc-638
  620: (62) *(u32 *)(r10 -64) = 0
  621: (bf) r7 = r10
  622: (07) r7 += -64
  623: (05) goto pc-44

To illustrate the bug, situation looks as follows:
     ____
  0 |    | <-- foo: [...]
  1 |____|
  2 |____| <-- pos / end_new  ^
  3 |    |                    |
  4 |    |                    |  len
  5 |____|                    |  (remove region)
  6 |    | <-- end_old        v
  7 |    |
  8 |    | <-- curr  (jmp foo)
  9 |____|

The condition curr >= end_new && curr + off + 1 < end_new in the
branch delta adjustments is never hit because curr + off + 1 <
end_new is compared as unsigned and therefore curr + off + 1 >
end_new in unsigned realm as curr + off + 1 becomes negative
since the insns are memmove()'d before the offset adjustments.

Correct BPF insns after this fix:

  [...]
  618: (85) call bpf_perf_event_output#-47216
  619: (05) goto pc-578
  620: (62) *(u32 *)(r10 -64) = 0
  621: (bf) r7 = r10
  622: (07) r7 += -64
  623: (05) goto pc-44

Note that unprivileged case is not affected from this.

Fixes: 52875a04f4b2 ("bpf: verifier: remove dead code")
Fixes: 2cbd95a5c4fb ("bpf: change parameters of call/branch offset adjustment")
Reported-by: Frank Ch. Eigler <fche@redhat.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 kernel/bpf/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 3ba56e73c90e..242a643af82f 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -338,7 +338,7 @@ int bpf_prog_calc_tag(struct bpf_prog *fp)
 }
 
 static int bpf_adj_delta_to_imm(struct bpf_insn *insn, u32 pos, s32 end_old,
-				s32 end_new, u32 curr, const bool probe_pass)
+				s32 end_new, s32 curr, const bool probe_pass)
 {
 	const s64 imm_min = S32_MIN, imm_max = S32_MAX;
 	s32 delta = end_new - end_old;
@@ -356,7 +356,7 @@ static int bpf_adj_delta_to_imm(struct bpf_insn *insn, u32 pos, s32 end_old,
 }
 
 static int bpf_adj_delta_to_off(struct bpf_insn *insn, u32 pos, s32 end_old,
-				s32 end_new, u32 curr, const bool probe_pass)
+				s32 end_new, s32 curr, const bool probe_pass)
 {
 	const s32 off_min = S16_MIN, off_max = S16_MAX;
 	s32 delta = end_new - end_old;
-- 
2.17.1


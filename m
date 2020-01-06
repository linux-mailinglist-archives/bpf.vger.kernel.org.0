Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D470E131AB6
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2020 22:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgAFVwJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Jan 2020 16:52:09 -0500
Received: from www62.your-server.de ([213.133.104.62]:32854 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgAFVwJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Jan 2020 16:52:09 -0500
Received: from 51.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.51] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1ioaIB-0000Op-F6; Mon, 06 Jan 2020 22:52:07 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     ast@kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        anatoly.trosinenko@gmail.com,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf] bpf: Fix passing modified ctx to ld/abs/ind instruction
Date:   Mon,  6 Jan 2020 22:51:57 +0100
Message-Id: <20200106215157.3553-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25686/Mon Jan  6 10:55:07 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Anatoly has been fuzzing with kBdysch harness and reported a KASAN
slab oob in one of the outcomes:

  [...]
  [   77.359642] BUG: KASAN: slab-out-of-bounds in bpf_skb_load_helper_8_no_cache+0x71/0x130
  [   77.360463] Read of size 4 at addr ffff8880679bac68 by task bpf/406
  [   77.361119]
  [   77.361289] CPU: 2 PID: 406 Comm: bpf Not tainted 5.5.0-rc2-xfstests-00157-g2187f215eba #1
  [   77.362134] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
  [   77.362984] Call Trace:
  [   77.363249]  dump_stack+0x97/0xe0
  [   77.363603]  print_address_description.constprop.0+0x1d/0x220
  [   77.364251]  ? bpf_skb_load_helper_8_no_cache+0x71/0x130
  [   77.365030]  ? bpf_skb_load_helper_8_no_cache+0x71/0x130
  [   77.365860]  __kasan_report.cold+0x37/0x7b
  [   77.366365]  ? bpf_skb_load_helper_8_no_cache+0x71/0x130
  [   77.366940]  kasan_report+0xe/0x20
  [   77.367295]  bpf_skb_load_helper_8_no_cache+0x71/0x130
  [   77.367821]  ? bpf_skb_load_helper_8+0xf0/0xf0
  [   77.368278]  ? mark_lock+0xa3/0x9b0
  [   77.368641]  ? kvm_sched_clock_read+0x14/0x30
  [   77.369096]  ? sched_clock+0x5/0x10
  [   77.369460]  ? sched_clock_cpu+0x18/0x110
  [   77.369876]  ? bpf_skb_load_helper_8+0xf0/0xf0
  [   77.370330]  ___bpf_prog_run+0x16c0/0x28f0
  [   77.370755]  __bpf_prog_run32+0x83/0xc0
  [   77.371153]  ? __bpf_prog_run64+0xc0/0xc0
  [   77.371568]  ? match_held_lock+0x1b/0x230
  [   77.371984]  ? rcu_read_lock_held+0xa1/0xb0
  [   77.372416]  ? rcu_is_watching+0x34/0x50
  [   77.372826]  sk_filter_trim_cap+0x17c/0x4d0
  [   77.373259]  ? sock_kzfree_s+0x40/0x40
  [   77.373648]  ? __get_filter+0x150/0x150
  [   77.374059]  ? skb_copy_datagram_from_iter+0x80/0x280
  [   77.374581]  ? do_raw_spin_unlock+0xa5/0x140
  [   77.375025]  unix_dgram_sendmsg+0x33a/0xa70
  [   77.375459]  ? do_raw_spin_lock+0x1d0/0x1d0
  [   77.375893]  ? unix_peer_get+0xa0/0xa0
  [   77.376287]  ? __fget_light+0xa4/0xf0
  [   77.376670]  __sys_sendto+0x265/0x280
  [   77.377056]  ? __ia32_sys_getpeername+0x50/0x50
  [   77.377523]  ? lock_downgrade+0x350/0x350
  [   77.377940]  ? __sys_setsockopt+0x2a6/0x2c0
  [   77.378374]  ? sock_read_iter+0x240/0x240
  [   77.378789]  ? __sys_socketpair+0x22a/0x300
  [   77.379221]  ? __ia32_sys_socket+0x50/0x50
  [   77.379649]  ? mark_held_locks+0x1d/0x90
  [   77.380059]  ? trace_hardirqs_on_thunk+0x1a/0x1c
  [   77.380536]  __x64_sys_sendto+0x74/0x90
  [   77.380938]  do_syscall_64+0x68/0x2a0
  [   77.381324]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
  [   77.381878] RIP: 0033:0x44c070
  [...]

After further debugging, turns out while in case of other helper functions
we disallow passing modified ctx, the special case of ld/abs/ind instruction
which has similar semantics (except r6 being the ctx argument) is missing
such check. Modified ctx is impossible here as bpf_skb_load_helper_8_no_cache()
and others are expecting skb fields in original position, hence, add
check_ctx_reg() to reject any modified ctx. Issue was first introduced back
in f1174f77b50c ("bpf/verifier: rework value tracking").

Fixes: f1174f77b50c ("bpf/verifier: rework value tracking")
Reported-by: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/verifier.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6f63ae7a370c..ce85e7041f0c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6264,6 +6264,7 @@ static bool may_access_skb(enum bpf_prog_type type)
 static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 {
 	struct bpf_reg_state *regs = cur_regs(env);
+	static const int ctx_reg = BPF_REG_6;
 	u8 mode = BPF_MODE(insn->code);
 	int i, err;
 
@@ -6297,7 +6298,7 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	}
 
 	/* check whether implicit source operand (register R6) is readable */
-	err = check_reg_arg(env, BPF_REG_6, SRC_OP);
+	err = check_reg_arg(env, ctx_reg, SRC_OP);
 	if (err)
 		return err;
 
@@ -6316,7 +6317,7 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 		return -EINVAL;
 	}
 
-	if (regs[BPF_REG_6].type != PTR_TO_CTX) {
+	if (regs[ctx_reg].type != PTR_TO_CTX) {
 		verbose(env,
 			"at the time of BPF_LD_ABS|IND R6 != pointer to skb\n");
 		return -EINVAL;
@@ -6329,6 +6330,10 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 			return err;
 	}
 
+	err = check_ctx_reg(env, &regs[ctx_reg], ctx_reg);
+	if (err < 0)
+		return err;
+
 	/* reset caller saved regs to unreadable */
 	for (i = 0; i < CALLER_SAVED_REGS; i++) {
 		mark_reg_not_init(env, regs, caller_saved[i]);
-- 
2.20.1


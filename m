Return-Path: <bpf+bounces-55898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC6DA88DB2
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 23:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 655953B2048
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 21:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B148B1DE3B5;
	Mon, 14 Apr 2025 21:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="VeOgAIwC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA1B2DFA4E
	for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 21:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744665800; cv=none; b=VSnOL74fYKnMwBHgXNSF6xpuyaFbEfzNpiZ8El7FACFBzEzRpCMrH0XsMDCUvTq0n7g9gagW/DzME69aNaleB/crYCdGQcvRU8ksg86928Jwwud7FZ+ykUVbE4taYZ6g7Lhr9pOCgP8SdQKhoT8TN6dWfIW8QBQdFZrfEkOEYl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744665800; c=relaxed/simple;
	bh=OqrecK6IcIXOJNg0u2iA8KqeOZXNf11McXkj9FfaY2c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NAo+EHo+7fV4eRfm4GU4rTpkCigFjAi4UK3+ueLZsfavadbYPHRVptDu6rWalyP8cx9tJAmSTUP6lw5DOAOh7E/H7872y5rdNnUVROIH298OdGmwZ4YwKiSAzlcIF0r9ZmNOueRv7hPW+Ud9VoOxmdPTU42y+ixCmIcjGN+UpuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=VeOgAIwC; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744665798; x=1776201798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NBRHz4AusrCKm7ihflRP7LnL5BzUn3AxeCf2WUEZiP4=;
  b=VeOgAIwCynEcMm2gKiz+xvMNDh8r/JfFBwg+tkN9niHP4aR9g3KaQ7wp
   EXXuMndaKcbvcya9NB2F2LhMvUYXkeL+KBGWW65/I/JhfdKlluvidjn5m
   uo2zi8lwuOOrK/kpb9xLoE2nJPspTCcLto0eYL8QgiIXh0ZfiKnnt1Nl5
   Q=;
X-IronPort-AV: E=Sophos;i="6.15,212,1739836800"; 
   d="scan'208";a="480345857"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 21:23:15 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:3541]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.226:2525] with esmtp (Farcaster)
 id fb05f9a1-31d7-458c-9859-63af1bd9b8bd; Mon, 14 Apr 2025 21:23:14 +0000 (UTC)
X-Farcaster-Flow-ID: fb05f9a1-31d7-458c-9859-63af1bd9b8bd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 21:23:14 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 21:23:10 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
CC: Shahab Vahedi <list+bpf@vahedi.org>, Russell King <linux@armlinux.org.uk>,
	Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>, Johan Almbladh
	<johan.almbladh@anyfinetworks.com>, Paul Burton <paulburton@kernel.org>,
	"Hari Bathini" <hbathini@linux.ibm.com>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=
	<bjorn@kernel.org>, Luke Nelson <luke.r.nels@gmail.com>, Xi Wang
	<xi.wang@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens
	<hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, "David S. Miller"
	<davem@davemloft.net>, Wang YanQing <udknight@gmail.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<bpf@vger.kernel.org>, syzkaller <syzkaller@googlegroups.com>
Subject: [PATCH v1 bpf 2/2] bpf: Set -ENOMEM to err in bpf_int_jit_compile().
Date: Mon, 14 Apr 2025 14:21:50 -0700
Message-ID: <20250414212207.63163-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414212207.63163-1-kuniyu@amazon.com>
References: <20250414212207.63163-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB002.ant.amazon.com (10.13.138.89) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

syzkaller reported a splat below. [0]

It always followed another splat by fault injection in
bpf_int_jit_compile(). [1]

Instead of proceeding with __bpf_prog_ret0_warn() and seeing
a splat later, let's return -ENOMEM to userspace.

[0]:
WARNING: CPU: 1 PID: 36 at kernel/bpf/core.c:2357 __bpf_prog_ret0_warn+0xa/0x10 kernel/bpf/core.c:2357
Modules linked in:
CPU: 1 UID: 0 PID: 36 Comm: kworker/1:1 Not tainted 6.14.0-13344-ga9843689e2de #28 PREEMPT(voluntary)  167b7ecb8f281ed56016416cdf1d8bb342db88fc
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Workqueue: mld mld_ifc_work
RIP: 0010:__bpf_prog_ret0_warn+0xa/0x10 kernel/bpf/core.c:2357
Code: ff eb 84 e8 b8 cf ee ff e9 7a ff ff ff e8 ae cf ee ff e9 70 ff ff ff 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa e8 97 cf ee ff 90 <0f> 0b 90 31 c0 c3 f3 0f 1e fa 55 48 89 e5 41 57 41 56 41 55 41 54
RSP: 0000:ffa0000000267050 EFLAGS: 00010293
RAX: ffffffff81881569 RBX: ffa0000000393030 RCX: ff11000100dc4500
RDX: 0000000000000000 RSI: ffa0000000393048 RDI: ff1100010b812a00
RBP: 0000000000000000 R08: 0000000000000002 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff0e5ef77 R12: 0000000000000000
R13: dffffc0000000000 R14: ff1100010b812a00 R15: ffa0000000393048
FS:  0000000000000000(0000) GS:ff11000192213000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff451d686ec CR3: 00000001037eb004 CR4: 0000000000771ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000600
PKRU: 55555554
Call Trace:
 <TASK>
 bpf_dispatcher_nop_func include/linux/bpf.h:1316 [inline]
 __bpf_prog_run include/linux/filter.h:718 [inline]
 bpf_prog_run include/linux/filter.h:725 [inline]
 bpf_prog_run_pin_on_cpu include/linux/filter.h:742 [inline]
 bpf_prog_run_clear_cb+0x7f/0x140 include/linux/filter.h:983
 run_filter+0x156/0x260 net/packet/af_packet.c:2135
 packet_rcv+0x491/0x15b0 net/packet/af_packet.c:2208
 dev_queue_xmit_nit+0xc27/0xcb0 net/core/dev.c:2592
 xmit_one net/core/dev.c:3831 [inline]
 dev_hard_start_xmit+0x1d5/0x720 net/core/dev.c:3851
 sch_direct_xmit+0x242/0x4a0 net/sched/sch_generic.c:343
 __dev_xmit_skb net/core/dev.c:4127 [inline]
 __dev_queue_xmit+0x186d/0x37a0 net/core/dev.c:4654
 dev_queue_xmit include/linux/netdevice.h:3355 [inline]
 neigh_hh_output include/net/neighbour.h:523 [inline]
 neigh_output include/net/neighbour.h:537 [inline]
 ip6_finish_output2+0x11f3/0x16e0 net/ipv6/ip6_output.c:141
 dst_output include/net/dst.h:459 [inline]
 NF_HOOK+0x160/0x470 include/linux/netfilter.h:314
 mld_sendpack+0x7f7/0xd70 net/ipv6/mcast.c:1868
 mld_send_cr net/ipv6/mcast.c:2169 [inline]
 mld_ifc_work+0x835/0xde0 net/ipv6/mcast.c:2702
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xa77/0x16a0 kernel/workqueue.c:3319
 worker_thread+0x8b6/0xd50 kernel/workqueue.c:3400
 kthread+0x413/0x870 kernel/kthread.c:464
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:245
 </TASK>

[1]:
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 1
CPU: 1 UID: 0 PID: 4562 Comm: syz.4.1225 Not tainted 6.14.0-13344-ga9843689e2de #28 PREEMPT(voluntary)  167b7ecb8f281ed56016416cdf1d8bb342db88fc
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xfa/0x120
 should_fail_ex+0x501/0x610
 should_failslab+0xba/0x120
 __kmalloc_cache_noprof+0x5d/0x310
 bpf_int_jit_compile+0x1292/0x18b0
 bpf_prog_select_runtime+0x439/0x780

Fixes: fa9dd599b4da ("bpf: get rid of pure_initcall dependency to enable jits")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 arch/arc/net/bpf_jit_core.c      | 19 ++++++++++++-------
 arch/arm/net/bpf_jit_32.c        |  8 +++++++-
 arch/arm64/net/bpf_jit_comp.c    |  8 +++++++-
 arch/loongarch/net/bpf_jit.c     |  8 +++++++-
 arch/mips/net/bpf_jit_comp.c     | 13 ++++++++++---
 arch/parisc/net/bpf_jit_core.c   |  8 +++++++-
 arch/powerpc/net/bpf_jit_comp.c  |  8 +++++++-
 arch/riscv/net/bpf_jit_core.c    |  8 +++++++-
 arch/s390/net/bpf_jit_comp.c     |  7 ++++++-
 arch/sparc/net/bpf_jit_comp_64.c |  8 +++++++-
 arch/x86/net/bpf_jit_comp.c      |  9 ++++++++-
 arch/x86/net/bpf_jit_comp32.c    |  7 ++++++-
 12 files changed, 91 insertions(+), 20 deletions(-)

diff --git a/arch/arc/net/bpf_jit_core.c b/arch/arc/net/bpf_jit_core.c
index 146bc0606f18..8a77317d60c0 100644
--- a/arch/arc/net/bpf_jit_core.c
+++ b/arch/arc/net/bpf_jit_core.c
@@ -1335,7 +1335,7 @@ static int jit_patch_relocations(struct jit_context *ctx)
  * to get the necessary data for the real compilation phase,
  * jit_compile().
  */
-static struct bpf_prog *do_normal_pass(struct bpf_prog *prog)
+static struct bpf_prog *do_normal_pass(struct bpf_prog *prog, int *err)
 {
 	struct jit_context ctx;
 
@@ -1343,13 +1343,17 @@ static struct bpf_prog *do_normal_pass(struct bpf_prog *prog)
 	if (!prog->jit_requested)
 		return prog;
 
-	if (jit_ctx_init(&ctx, prog)) {
+	*err = jit_ctx_init(&ctx, prog);
+	if (*err) {
 		jit_ctx_cleanup(&ctx);
 		return prog;
 	}
 
 	/* Get the lengths and allocate buffer. */
-	if (jit_prepare(&ctx)) {
+	*err = jit_prepare(&ctx);
+	if (*err) {
+		if (*err != -ENOMEM)
+			*err = 0;
 		jit_ctx_cleanup(&ctx);
 		return prog;
 	}
@@ -1374,7 +1378,7 @@ static struct bpf_prog *do_normal_pass(struct bpf_prog *prog)
  * again to get the newly translated addresses in order to resolve
  * the "call"s.
  */
-static struct bpf_prog *do_extra_pass(struct bpf_prog *prog)
+static struct bpf_prog *do_extra_pass(struct bpf_prog *prog, int *err)
 {
 	struct jit_context ctx;
 
@@ -1382,7 +1386,8 @@ static struct bpf_prog *do_extra_pass(struct bpf_prog *prog)
 	if (check_jit_context(prog))
 		return prog;
 
-	if (jit_ctx_init(&ctx, prog)) {
+	*err = jit_ctx_init(&ctx, prog);
+	if (*err) {
 		jit_ctx_cleanup(&ctx);
 		return prog;
 	}
@@ -1417,9 +1422,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 
 	/* Was this program already translated? */
 	if (!prog->jited)
-		return do_normal_pass(prog);
+		return do_normal_pass(prog, err);
 	else
-		return do_extra_pass(prog);
+		return do_extra_pass(prog, err);
 
 	return prog;
 }
diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 81d6af62d47d..d257805e149c 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -2164,8 +2164,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 	 */
 	tmp = bpf_jit_blind_constants(prog);
 
-	if (IS_ERR(tmp))
+	if (IS_ERR(tmp)) {
+		if (PTR_ERR(tmp) == -ENOMEM)
+			*err = -ENOMEM;
 		return orig_prog;
+	}
 	if (tmp != prog) {
 		tmp_blinded = true;
 		prog = tmp;
@@ -2180,6 +2183,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 	 */
 	ctx.offsets = kcalloc(prog->len, sizeof(int), GFP_KERNEL);
 	if (ctx.offsets == NULL) {
+		*err = -ENOMEM;
 		prog = orig_prog;
 		goto out;
 	}
@@ -2214,6 +2218,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 	if (ctx.imm_count) {
 		ctx.imms = kcalloc(ctx.imm_count, sizeof(u32), GFP_KERNEL);
 		if (ctx.imms == NULL) {
+			*err = -ENOMEM;
 			prog = orig_prog;
 			goto out_off;
 		}
@@ -2239,6 +2244,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 	 * we must fall back to the interpretation
 	 */
 	if (header == NULL) {
+		*err = -ENOMEM;
 		prog = orig_prog;
 		goto out_imms;
 	}
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index cf88f174a145..46c1923b27ab 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1843,8 +1843,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 	/* If blinding was requested and we failed during blinding,
 	 * we must fall back to the interpreter.
 	 */
-	if (IS_ERR(tmp))
+	if (IS_ERR(tmp)) {
+		if (PTR_ERR(tmp) == -ENOMEM)
+			*err = -ENOMEM;
 		return orig_prog;
+	}
 	if (tmp != prog) {
 		tmp_blinded = true;
 		prog = tmp;
@@ -1854,6 +1857,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 	if (!jit_data) {
 		jit_data = kzalloc(sizeof(*jit_data), GFP_KERNEL);
 		if (!jit_data) {
+			*err = -ENOMEM;
 			prog = orig_prog;
 			goto out;
 		}
@@ -1875,6 +1879,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 
 	ctx.offset = kvcalloc(prog->len + 1, sizeof(int), GFP_KERNEL);
 	if (ctx.offset == NULL) {
+		*err = -ENOMEM;
 		prog = orig_prog;
 		goto out_off;
 	}
@@ -1914,6 +1919,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 					      sizeof(u32), &header, &image_ptr,
 					      jit_fill_hole);
 	if (!ro_header) {
+		*err = -ENOMEM;
 		prog = orig_prog;
 		goto out_off;
 	}
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 437e5e1130a0..23eaeb2238fd 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1209,8 +1209,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 	 * we must fall back to the interpreter. Otherwise, we save
 	 * the new JITed code.
 	 */
-	if (IS_ERR(tmp))
+	if (IS_ERR(tmp)) {
+		if (PTR_ERR(tmp) == -ENOMEM)
+			*err = -ENOMEM;
 		return orig_prog;
+	}
 
 	if (tmp != prog) {
 		tmp_blinded = true;
@@ -1221,6 +1224,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 	if (!jit_data) {
 		jit_data = kzalloc(sizeof(*jit_data), GFP_KERNEL);
 		if (!jit_data) {
+			*err = -ENOMEM;
 			prog = orig_prog;
 			goto out;
 		}
@@ -1240,6 +1244,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 
 	ctx.offset = kvcalloc(prog->len + 1, sizeof(u32), GFP_KERNEL);
 	if (ctx.offset == NULL) {
+		*err = -ENOMEM;
 		prog = orig_prog;
 		goto out_offset;
 	}
@@ -1266,6 +1271,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 	header = bpf_jit_binary_alloc(image_size, &image_ptr,
 				      sizeof(u32), jit_fill_hole);
 	if (header == NULL) {
+		*err = -ENOMEM;
 		prog = orig_prog;
 		goto out_offset;
 	}
diff --git a/arch/mips/net/bpf_jit_comp.c b/arch/mips/net/bpf_jit_comp.c
index deb6bf7150bc..eacc7d3edbb9 100644
--- a/arch/mips/net/bpf_jit_comp.c
+++ b/arch/mips/net/bpf_jit_comp.c
@@ -932,8 +932,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 	 * the new JITed code.
 	 */
 	tmp = bpf_jit_blind_constants(prog);
-	if (IS_ERR(tmp))
+	if (IS_ERR(tmp)) {
+		if (PTR_ERR(tmp) == -ENOMEM)
+			*err = -ENOMEM;
 		return orig_prog;
+	}
 	if (tmp != prog) {
 		tmp_blinded = true;
 		prog = tmp;
@@ -948,8 +951,10 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 	 */
 	ctx.descriptors = kcalloc(prog->len + 1, sizeof(*ctx.descriptors),
 				  GFP_KERNEL);
-	if (ctx.descriptors == NULL)
+	if (ctx.descriptors == NULL) {
+		*err = -ENOMEM;
 		goto out_err;
+	}
 
 	/* First pass discovers used resources */
 	if (build_body(&ctx) < 0)
@@ -991,8 +996,10 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 	 * Not able to allocate memory for the structure then
 	 * we must fall back to the interpretation
 	 */
-	if (header == NULL)
+	if (header == NULL) {
+		*err = -ENOMEM;
 		goto out_err;
+	}
 
 	/* Actual pass to generate final JIT code */
 	ctx.target = (u32 *)image_ptr;
diff --git a/arch/parisc/net/bpf_jit_core.c b/arch/parisc/net/bpf_jit_core.c
index 0c74306cb392..fb36753a99cb 100644
--- a/arch/parisc/net/bpf_jit_core.c
+++ b/arch/parisc/net/bpf_jit_core.c
@@ -54,8 +54,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 		return orig_prog;
 
 	tmp = bpf_jit_blind_constants(prog);
-	if (IS_ERR(tmp))
+	if (IS_ERR(tmp)) {
+		if (PTR_ERR(tmp) == -ENOMEM)
+			*err = -ENOMEM;
 		return orig_prog;
+	}
 	if (tmp != prog) {
 		tmp_blinded = true;
 		prog = tmp;
@@ -65,6 +68,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 	if (!jit_data) {
 		jit_data = kzalloc(sizeof(*jit_data), GFP_KERNEL);
 		if (!jit_data) {
+			*err = -ENOMEM;
 			prog = orig_prog;
 			goto out;
 		}
@@ -82,6 +86,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 	ctx->prog = prog;
 	ctx->offset = kcalloc(prog->len, sizeof(int), GFP_KERNEL);
 	if (!ctx->offset) {
+		*err = -ENOMEM;
 		prog = orig_prog;
 		goto out_offset;
 	}
@@ -117,6 +122,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 						     sizeof(long),
 						     bpf_fill_ill_insns);
 			if (!jit_data->header) {
+				*err = -ENOMEM;
 				prog = orig_prog;
 				goto out_offset;
 			}
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index ede2462f3653..2c7320bc3fe2 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -155,8 +155,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp, int *err)
 		return org_fp;
 
 	tmp_fp = bpf_jit_blind_constants(org_fp);
-	if (IS_ERR(tmp_fp))
+	if (IS_ERR(tmp_fp)) {
+		if (PTR_ERR(tmp_fp) == -ENOMEM)
+			*err = -ENOMEM;
 		return org_fp;
+	}
 
 	if (tmp_fp != org_fp) {
 		bpf_blinded = true;
@@ -167,6 +170,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp, int *err)
 	if (!jit_data) {
 		jit_data = kzalloc(sizeof(*jit_data), GFP_KERNEL);
 		if (!jit_data) {
+			*err = -ENOMEM;
 			fp = org_fp;
 			goto out;
 		}
@@ -195,6 +199,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp, int *err)
 
 	addrs = kcalloc(flen + 1, sizeof(*addrs), GFP_KERNEL);
 	if (addrs == NULL) {
+		*err = -ENOMEM;
 		fp = org_fp;
 		goto out_addrs;
 	}
@@ -246,6 +251,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp, int *err)
 	fhdr = bpf_jit_binary_pack_alloc(alloclen, &fimage, 4, &hdr, &image,
 					      bpf_jit_fill_ill_insns);
 	if (!fhdr) {
+		*err = -ENOMEM;
 		fp = org_fp;
 		goto out_addrs;
 	}
diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index 11fa033ec666..1f6ab1ddeb2c 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -55,8 +55,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 		return orig_prog;
 
 	tmp = bpf_jit_blind_constants(prog);
-	if (IS_ERR(tmp))
+	if (IS_ERR(tmp)) {
+		if (PTR_ERR(tmp) == -ENOMEM)
+			*err = -ENOMEM;
 		return orig_prog;
+	}
 	if (tmp != prog) {
 		tmp_blinded = true;
 		prog = tmp;
@@ -66,6 +69,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 	if (!jit_data) {
 		jit_data = kzalloc(sizeof(*jit_data), GFP_KERNEL);
 		if (!jit_data) {
+			*err = -ENOMEM;
 			prog = orig_prog;
 			goto out;
 		}
@@ -85,6 +89,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 	ctx->prog = prog;
 	ctx->offset = kcalloc(prog->len, sizeof(int), GFP_KERNEL);
 	if (!ctx->offset) {
+		*err = -ENOMEM;
 		prog = orig_prog;
 		goto out_offset;
 	}
@@ -128,6 +133,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 							  &jit_data->header, &jit_data->image,
 							  bpf_fill_ill_insns);
 			if (!jit_data->ro_header) {
+				*err = -ENOMEM;
 				prog = orig_prog;
 				goto out_offset;
 			}
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 3d875ff21362..85178209649c 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2274,8 +2274,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp, int *err)
 	 * If blinding was requested and we failed during blinding,
 	 * we must fall back to the interpreter.
 	 */
-	if (IS_ERR(tmp))
+	if (IS_ERR(tmp)) {
+		if (PTR_ERR(tmp) == -ENOMEM)
+			*err = -ENOMEM;
 		return orig_fp;
+	}
 	if (tmp != fp) {
 		tmp_blinded = true;
 		fp = tmp;
@@ -2285,6 +2288,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp, int *err)
 	if (!jit_data) {
 		jit_data = kzalloc(sizeof(*jit_data), GFP_KERNEL);
 		if (!jit_data) {
+			*err = -ENOMEM;
 			fp = orig_fp;
 			goto out;
 		}
@@ -2301,6 +2305,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp, int *err)
 	memset(&jit, 0, sizeof(jit));
 	jit.addrs = kvcalloc(fp->len + 1, sizeof(*jit.addrs), GFP_KERNEL);
 	if (jit.addrs == NULL) {
+		*err = -ENOMEM;
 		fp = orig_fp;
 		goto free_addrs;
 	}
diff --git a/arch/sparc/net/bpf_jit_comp_64.c b/arch/sparc/net/bpf_jit_comp_64.c
index 0e5aa8535a27..0995297b5c92 100644
--- a/arch/sparc/net/bpf_jit_comp_64.c
+++ b/arch/sparc/net/bpf_jit_comp_64.c
@@ -1496,8 +1496,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 	/* If blinding was requested and we failed during blinding,
 	 * we must fall back to the interpreter.
 	 */
-	if (IS_ERR(tmp))
+	if (IS_ERR(tmp)) {
+		if (PTR_ERR(tmp) == -ENOMEM)
+			*err = -ENOMEM;
 		return orig_prog;
+	}
 	if (tmp != prog) {
 		tmp_blinded = true;
 		prog = tmp;
@@ -1507,6 +1510,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 	if (!jit_data) {
 		jit_data = kzalloc(sizeof(*jit_data), GFP_KERNEL);
 		if (!jit_data) {
+			*err = -ENOMEM;
 			prog = orig_prog;
 			goto out;
 		}
@@ -1528,6 +1532,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 
 	ctx.offset = kmalloc_array(prog->len, sizeof(unsigned int), GFP_KERNEL);
 	if (ctx.offset == NULL) {
+		*err = -ENOMEM;
 		prog = orig_prog;
 		goto out_off;
 	}
@@ -1570,6 +1575,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 	header = bpf_jit_binary_alloc(image_size, &image_ptr,
 				      sizeof(u32), jit_fill_hole);
 	if (header == NULL) {
+		*err = -ENOMEM;
 		prog = orig_prog;
 		goto out_off;
 	}
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 313e68414486..0906b0cdc4a0 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3522,8 +3522,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 	 * If blinding was requested and we failed during blinding,
 	 * we must fall back to the interpreter.
 	 */
-	if (IS_ERR(tmp))
+	if (IS_ERR(tmp)) {
+		if (PTR_ERR(tmp) == -ENOMEM)
+			*err = -ENOMEM;
 		return orig_prog;
+	}
 	if (tmp != prog) {
 		tmp_blinded = true;
 		prog = tmp;
@@ -3533,6 +3536,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 	if (!jit_data) {
 		jit_data = kzalloc(sizeof(*jit_data), GFP_KERNEL);
 		if (!jit_data) {
+			*err = -ENOMEM;
 			prog = orig_prog;
 			goto out;
 		}
@@ -3548,6 +3552,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 				      2 * PRIV_STACK_GUARD_SZ;
 		priv_stack_ptr = __alloc_percpu_gfp(priv_stack_alloc_sz, 8, GFP_KERNEL);
 		if (!priv_stack_ptr) {
+			*err = -ENOMEM;
 			prog = orig_prog;
 			goto out_priv_stack;
 		}
@@ -3569,6 +3574,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 	}
 	addrs = kvmalloc_array(prog->len + 1, sizeof(*addrs), GFP_KERNEL);
 	if (!addrs) {
+		*err = -ENOMEM;
 		prog = orig_prog;
 		goto out_addrs;
 	}
@@ -3635,6 +3641,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 							   &image, align, &rw_header, &rw_image,
 							   jit_fill_hole);
 			if (!header) {
+				*err = -ENOMEM;
 				prog = orig_prog;
 				goto out_addrs;
 			}
diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index 628a96c12091..4b682ef029e8 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -2538,8 +2538,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 	 * If blinding was requested and we failed during blinding,
 	 * we must fall back to the interpreter.
 	 */
-	if (IS_ERR(tmp))
+	if (IS_ERR(tmp)) {
+		if (PTR_ERR(tmp) == -ENOMEM)
+			*err = -ENOMEM;
 		return orig_prog;
+	}
 	if (tmp != prog) {
 		tmp_blinded = true;
 		prog = tmp;
@@ -2547,6 +2550,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 
 	addrs = kmalloc_array(prog->len, sizeof(*addrs), GFP_KERNEL);
 	if (!addrs) {
+		*err = -ENOMEM;
 		prog = orig_prog;
 		goto out;
 	}
@@ -2589,6 +2593,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 			header = bpf_jit_binary_alloc(proglen, &image,
 						      1, jit_fill_hole);
 			if (!header) {
+				*err = -ENOMEM;
 				prog = orig_prog;
 				goto out_addrs;
 			}
-- 
2.49.0



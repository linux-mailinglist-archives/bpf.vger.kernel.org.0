Return-Path: <bpf+bounces-67567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8580DB45A48
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 16:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D89D5A7D7D
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 14:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5159A372894;
	Fri,  5 Sep 2025 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qRIHHclB"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BBF36CE10
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 14:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082147; cv=none; b=O54dov15EARNMHKga67ycgAAJMp/k+517hbfn0BkiP/g+8fvuVodudgdq8XMo8x8FgtZeU4Lq0xQgZILlCWaRJUyL73Vw9LwsY+xwisFBiQ6T3fbUtdHd0Y2HAP0kRccwxiMU9s5tPASI1tmKiTVa5e0i7iODDcVKbrSzVzp0y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082147; c=relaxed/simple;
	bh=ONnMV058P5BMH34XDRwHK9ENh9LY6sMyjIvUgyMdezY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z1S9B2yX9WrIbqtFANhrD384YJRiNRRTuGjd1Kw/crG/uawnU/Ebfx+lH4cwoRBwYofgh4323CPfhwG4zrcEPr5l4I/iLMeVhaGSIRbzTQfx8H91/zjKMHDWDY2x3yRBKoJRyYWMAsC0jXGKsspUCWEtHiRegXOQbR6AjA2kQu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qRIHHclB; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757082143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vGTXnum32HI+3GAb2G2ocDG1pk6+G/eUlmoEbdzl3IE=;
	b=qRIHHclBH8yxDnpu712WPerA/8fgT9tKpqI0MEryuemk1emYa01dZzLo2cEtVbG+ijYJ4o
	vuWqAk5DABZjoqsYKyl5QlqZ1tCjLhOrs2thP+y6ZN4vt58bEv5OB7CF8vFVrJf7v83gjl
	d5bGhUb1iOi7GVzwSXrfxCn+7WlySZ4=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 1/2] bpf: Reject bpf_timer for PREEMPT_RT
Date: Fri,  5 Sep 2025 22:22:04 +0800
Message-ID: <20250905142206.88132-2-leon.hwang@linux.dev>
In-Reply-To: <20250905142206.88132-1-leon.hwang@linux.dev>
References: <20250905142206.88132-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When enable CONFIG_PREEMPT_RT, the kernel will panic when run timer
selftests by './test_progs -t timer':

[   35.955287] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
[   35.955312] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 120, name: test_progs
[   35.955315] preempt_count: 1, expected: 0
[   35.955316] RCU nest depth: 0, expected: 0
[   35.955317] 2 locks held by test_progs/120:
[   35.955319]  #0: ffffffff8f1c3720 (rcu_read_lock_trace){....}-{0:0}, at: bpf_prog_test_run_syscall+0xc9/0x240
[   35.955358]  #1: ffff9155fbd331c8 ((&c->lock)){+.+.}-{3:3}, at: ___slab_alloc+0xb0/0xd20
[   35.955388] irq event stamp: 100
[   35.955389] hardirqs last  enabled at (99): [<ffffffff8dfcd890>] do_syscall_64+0x30/0x2d0
[   35.955414] hardirqs last disabled at (100): [<ffffffff8d4a9baa>] __bpf_async_init+0xca/0x310
[   35.955428] softirqs last  enabled at (0): [<ffffffff8d296cbb>] copy_process+0x9db/0x2000
[   35.955449] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   35.955482] CPU: 1 UID: 0 PID: 120 Comm: test_progs Tainted: G           OE       6.17.0-rc1-gc5f5af560d8a #30 PREEMPT_{RT,(full)}
[   35.955487] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   35.955488] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   35.955491] Call Trace:
[   35.955493]  <TASK>
[   35.955499]  dump_stack_lvl+0x73/0xb0
[   35.955514]  dump_stack+0x14/0x20
[   35.955518]  __might_resched+0x167/0x230
[   35.955537]  rt_spin_lock+0x66/0x180
[   35.955543]  ? ___slab_alloc+0xb0/0xd20
[   35.955549]  ? bpf_map_kmalloc_node+0x7c/0x200
[   35.955560]  ___slab_alloc+0xb0/0xd20
[   35.955575]  ? __lock_acquire+0x43d/0x2590
[   35.955601]  __kmalloc_node_noprof+0x10b/0x410
[   35.955605]  ? __kmalloc_node_noprof+0x10b/0x410
[   35.955607]  ? bpf_map_kmalloc_node+0x7c/0x200
[   35.955616]  bpf_map_kmalloc_node+0x7c/0x200
[   35.955624]  __bpf_async_init+0xf8/0x310
[   35.955633]  bpf_timer_init+0x37/0x40
[   35.955637]  bpf_prog_2287350dd5909839_start_cb+0x5d/0x91
[   35.955642]  bpf_prog_0d54653d8a74e954_start_timer+0x65/0x8a
[   35.955650]  bpf_prog_test_run_syscall+0x111/0x240
[   35.955660]  __sys_bpf+0x81c/0x2ab0
[   35.955665]  ? __might_fault+0x47/0x90
[   35.955700]  __x64_sys_bpf+0x1e/0x30
[   35.955703]  x64_sys_call+0x171d/0x20d0
[   35.955715]  do_syscall_64+0x6a/0x2d0
[   35.955722]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   35.955728] RIP: 0033:0x7fee4261225d
[   35.955734] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8b bb 0d 00 f7 d8 64 89 01 48
[   35.955736] RSP: 002b:00007fee424e5bd8 EFLAGS: 00000202 ORIG_RAX: 0000000000000141
[   35.955742] RAX: ffffffffffffffda RBX: 00007fee424e6cdc RCX: 00007fee4261225d
[   35.955744] RDX: 0000000000000050 RSI: 00007fee424e5c20 RDI: 000000000000000a
[   35.955745] RBP: 00007fee424e5bf0 R08: 0000000000000003 R09: 00007fee424e5c20
[   35.955747] R10: 00007fffc266f910 R11: 0000000000000202 R12: 00007fee424e66c0
[   35.955748] R13: ffffffffffffff08 R14: 0000000000000016 R15: 00007fffc266f650
[   35.955766]  </TASK>

In order to avoid such panic, reject bpf_timer in verifier when
PREEMPT_RT is enabled.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b9394f8fac0ed..8ca9d20ab61f4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8552,6 +8552,10 @@ static int process_timer_func(struct bpf_verifier_env *env, int regno,
 		verifier_bug(env, "Two map pointers in a timer helper");
 		return -EFAULT;
 	}
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		verbose(env, "bpf_timer cannot be used for PREEMPT_RT.\n");
+		return -EOPNOTSUPP;
+	}
 	meta->map_uid = reg->map_uid;
 	meta->map_ptr = map;
 	return 0;
-- 
2.50.1



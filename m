Return-Path: <bpf+bounces-62398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBE4AF9141
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 13:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ED50565F7D
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 11:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3DB2C08AE;
	Fri,  4 Jul 2025 11:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="SUOYCk86"
X-Original-To: bpf@vger.kernel.org
Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A905285C9F;
	Fri,  4 Jul 2025 11:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.188.205.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751627787; cv=none; b=OyNnTNFmrW/F1Lly383DAcdWrEeDEXY0QjrpySFGNIx0eDDJISC4dz83cxzM19W0l5O4vLEDoLbaddJN2qb4GWY9bNjxa4S/cnXSshXl6lf7A0nu5V3Xka+wb0yRtH1NqOscCKVlIt2o6fgR9o/k7Dt57irqNtJlSjv/eqg6auY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751627787; c=relaxed/simple;
	bh=QkzF9v0JtK+J9zdf0mskE+qnDwEhUeZEuDR6yZ7/7bw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HbjgmgoDcWroETvxDEdS9L1xxElr+m4B0+Uvu2/V6h1rk1OqO0nlkQrulXGORSTXcF+enXGSZv+Y7wq9y8UkwBlIcsb3qvAFaTue14bI9rtCjsOjhuHg149wp1WaCbfBfPJXF51TzYTsxRKZI5Ill06jlp9bZxhfKLahmEFk9Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=SUOYCk86; arc=none smtp.client-ip=93.188.205.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1751627778;
	bh=QkzF9v0JtK+J9zdf0mskE+qnDwEhUeZEuDR6yZ7/7bw=;
	h=From:To:Cc:Subject:Date:From;
	b=SUOYCk86TCIBqp9OXBNKVEMf08UiN7a2feyK37rbVIq3KuYP4/2Kj3If3+4oiLeLG
	 Lv9HuWOrkSFFsViuQrJMtieb5SV2+Fv6hQNoz6JPnZzJV5kmulF9HfBQIAeskcBbbr
	 QCG8sJW7M/RGRXkezuHGSPLBc7gmIpQ3bbW2lYzDOhhq5wnn5zk2DY4oY5kWbJRFk5
	 wk3YQ3dMt9+jRjpLLMEEeMnpQ+xlyPz5YAiZbVY7zgHM/I4XPDY1F5l0tlVfAwcFJt
	 /G0TcBCL4Rc78+cFUqk/ySOVhozlZR4SU8bPMUzUZmmGMOBLj8X5A5pzIk01Ad4AAW
	 nB0bQF5Caqhvw==
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id 169141F98F;
	Fri,  4 Jul 2025 14:16:18 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.177.185.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Fri,  4 Jul 2025 14:16:16 +0300 (MSK)
Received: from localhost.localdomain (unknown [10.198.20.23])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4bYWJv6p1Vz16Hnq;
	Fri,  4 Jul 2025 14:15:43 +0300 (MSK)
From: Anastasia Belova <abelova@astralinux.ru>
To: stable@vger.kernel.org,
	"Greg Kroah-Hartman ." <gregkh@linuxfoundation.org>
Cc: Anastasia Belova <abelova@astralinux.ru>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Petar Penkov <ppenkov@google.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Hao Sun <sunhao.th@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10] bpf: Reject variable offset alu on PTR_TO_FLOW_KEYS
Date: Fri,  4 Jul 2025 14:15:33 +0300
Message-ID: <20250704111535.34760-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2025/07/04 10:48:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: abelova@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 63 0.3.63 9cc2b4b18bf16653fda093d2c494e542ac094a39, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, lore.kernel.org:7.1.1;new-mail.astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 194551 [Jul 03 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2025/07/04 07:50:00 #27617035
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/07/04 10:48:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Hao Sun <sunhao.th@gmail.com>

[ Upstream commit 22c7fa171a02d310e3a3f6ed46a698ca8a0060ed ]

For PTR_TO_FLOW_KEYS, check_flow_keys_access() only uses fixed off
for validation. However, variable offset ptr alu is not prohibited
for this ptr kind. So the variable offset is not checked.

The following prog is accepted:

  func#0 @0
  0: R1=ctx() R10=fp0
  0: (bf) r6 = r1                       ; R1=ctx() R6_w=ctx()
  1: (79) r7 = *(u64 *)(r6 +144)        ; R6_w=ctx() R7_w=flow_keys()
  2: (b7) r8 = 1024                     ; R8_w=1024
  3: (37) r8 /= 1                       ; R8_w=scalar()
  4: (57) r8 &= 1024                    ; R8_w=scalar(smin=smin32=0,
  smax=umax=smax32=umax32=1024,var_off=(0x0; 0x400))
  5: (0f) r7 += r8
  mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1
  mark_precise: frame0: regs=r8 stack= before 4: (57) r8 &= 1024
  mark_precise: frame0: regs=r8 stack= before 3: (37) r8 /= 1
  mark_precise: frame0: regs=r8 stack= before 2: (b7) r8 = 1024
  6: R7_w=flow_keys(smin=smin32=0,smax=umax=smax32=umax32=1024,var_off
  =(0x0; 0x400)) R8_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=1024,
  var_off=(0x0; 0x400))
  6: (79) r0 = *(u64 *)(r7 +0)          ; R0_w=scalar()
  7: (95) exit

This prog loads flow_keys to r7, and adds the variable offset r8
to r7, and finally causes out-of-bounds access:

  BUG: unable to handle page fault for address: ffffc90014c80038
  [...]
  Call Trace:
   <TASK>
   bpf_dispatcher_nop_func include/linux/bpf.h:1231 [inline]
   __bpf_prog_run include/linux/filter.h:651 [inline]
   bpf_prog_run include/linux/filter.h:658 [inline]
   bpf_prog_run_pin_on_cpu include/linux/filter.h:675 [inline]
   bpf_flow_dissect+0x15f/0x350 net/core/flow_dissector.c:991
   bpf_prog_test_run_flow_dissector+0x39d/0x620 net/bpf/test_run.c:1359
   bpf_prog_test_run kernel/bpf/syscall.c:4107 [inline]
   __sys_bpf+0xf8f/0x4560 kernel/bpf/syscall.c:5475
   __do_sys_bpf kernel/bpf/syscall.c:5561 [inline]
   __se_sys_bpf kernel/bpf/syscall.c:5559 [inline]
   __x64_sys_bpf+0x73/0xb0 kernel/bpf/syscall.c:5559
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x63/0x6b

Fix this by rejecting ptr alu with variable offset on flow_keys.
Applying the patch rejects the program with "R7 pointer arithmetic
on flow_keys prohibited".

Fixes: d58e468b1112 ("flow_dissector: implements flow dissector BPF hook")
Signed-off-by: Hao Sun <sunhao.th@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Link: https://lore.kernel.org/bpf/20240115082028.9992-1-sunhao.th@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
Backport fix for CVE-2024-26589
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 75251870430e..2a3b5e4276ba 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6280,6 +6280,10 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		verbose(env, "R%d pointer arithmetic on %s prohibited, null-check it first\n",
 			dst, reg_type_str[ptr_reg->type]);
 		return -EACCES;
+	case PTR_TO_FLOW_KEYS:
+		if (known)
+			break;
+		fallthrough;
 	case CONST_PTR_TO_MAP:
 		/* smin_val represents the known value */
 		if (known && smin_val == 0 && opcode == BPF_ADD)
-- 
2.43.0



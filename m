Return-Path: <bpf+bounces-77160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E61BECD0730
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 16:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 411AF30B8B6D
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 15:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F55C32AAA9;
	Fri, 19 Dec 2025 15:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mB3chJjg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2262868B5
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 15:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766156716; cv=none; b=IWJAMe7oYcv2NvbprzbWczThuRSJJvdB6k5/wHNJ5NTuX8sm8oS2Z0BT6T+7EJ84NbS+tAMyQzPBT5n6nk65NXmKAE28zJ7m9DFJd9nmjcJatV1lfElKLg/VJ8nHaIKjNk/hMeN7YXpNRXL0AqskgIctXEQfBnao0G+a2T076B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766156716; c=relaxed/simple;
	bh=hGjYfTPZVpLjfYpJDfuQ8wmqEFOpDaT5M488rWNUYoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=THACi4oqDE5taOS25oFV/9cibZyhaFmlDghxX2YaSAP5FOEApJhWnO0i+iehYRiuRNVu/jFVZRNCGGRjx8z/tSDDSvWD6jJxjto7geMlb3Qy4MPrk1gqmfYJJ0i1qiagdXgi/WgX0R3pChnXl1Nu9CR4EU7Xll+Pg2V+1Pzh+lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mB3chJjg; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-78e7ba9fc29so17100227b3.2
        for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 07:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766156714; x=1766761514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d8S9arpnQbQKRrRPutZ5MVC6WeUVyaLDfqwrd6H6Lag=;
        b=mB3chJjgFlhBy8ODFO9zMLjj31fdnu82PsYKSMql5+4P1xOrEMaKD3l2knKvFtswhJ
         nowvKIEhG2Ec3ofo2+Bmr6MZjLvhTgYcm3s2n0Xoq5yi/9i5KIkKDmkg9lXP5jKIeUlK
         v2UcJNvt8oV/0YXnQf97p8qwlU4smy3Gc545XFlXf0B2briUQLJMzSvfrIZFgpvBhdhr
         jXzULupGQuXInVVmRn4KHexWHcwilaMQGZkZS0GQLUerH5dJSmWiAx+i5wi93QOFvTsY
         v4DthoJWyqtqi/omjd2MhaZ0hZM9dsvhjd8mhBp5Xmb3lqEYlrWipdpmxgshYZ0orQtT
         lINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766156714; x=1766761514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8S9arpnQbQKRrRPutZ5MVC6WeUVyaLDfqwrd6H6Lag=;
        b=KDdafhe0wkVau2GhU0AAOVAGwIx7k0nbxLnbU05LqkWQZE3PCsfQVjolhdGl99GRlM
         v3RUAT6q8ouHU64T0hynyYZCgn6ca6w/4z2YxlazgpyB/0NIxOYL89nDqYjIyEy+rm4O
         /BW+ODwY1k6Ye9dvSLq/PuvQGpjnLsDvSCGmj+HrucsIXqUrsNycb3bZiEigAXlVeQyh
         B/YDrTQtOS4/rkUiLBuKcpcDUscZvcAqrIRQzeud38lilGYCyHfGVWCKa1tcvHz/odyr
         dVDl0afYKlj6zVRKm/M0PtHIqr3K24nkSmUjP+zd6KZCKRvikZka2rR2raVmwB3jRHYs
         yAKw==
X-Forwarded-Encrypted: i=1; AJvYcCUEHQp/iawCn50FCzWUTxVzq5y5aHWymohXky1C2fYQVO6rpRwdcKGcxiNfjXeUSD+74bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwifhRC8ZUqMqDvXO3iQeByATpUTywTRGE5SVWdwv3B6jBS6xgo
	NuxwpMaFL+BO/QJ6I98KcnN7j9bZmi/KilqCYFJvFIt0VtnhYzGsbIlYwFsR9Z+iAJI=
X-Gm-Gg: AY/fxX6ppPE1wa/ScTeTdVKX9hjEEYPXwiBCZbCGB2q0DQflzTEJioX4SJjTd0ualTw
	0+nhUwXBxECirh3+0xhWHC1+tUWTH5MeuFpN6+o0qx+MAIt36ykg/V7ugvPkXQCEhj4Y8r+xxYC
	xPi2ODkRYtseDJzfOVm889bWg1Wha6Xo4deyQQt0htj928BINkUQJJ8bazSlyviBfQjL2Z62VtO
	KaKFRewEoj3PxOGWWM0OXIFIbaw8SwVSUr4gFJePLkMmnTJtQaH2Tc8JBnBCNSQAIbMDOEBGxbm
	Xaz2PbTchRNqFCgiOYB3AMCiGGiMhAfQTnz3uPhIHyB/ZLjcmQ5noUfrmax+1te9N0vqudCZFZR
	lOd6QSS7LLLIAfkPyu+EtQ9PIL9Rp29ZKxapmZqO6FVPrxmwAyV1cwYesH4au0jkxavfdmsVkfG
	BKY0IfKzGbrcErM8ghPMtLTA==
X-Google-Smtp-Source: AGHT+IGA2/j7Dp0GcCqLOtCuhTofXascKJCOpzP4V5d1jVIW4N3VAzOMwjEDO8OdEOpYvh5aBfsBIA==
X-Received: by 2002:a05:6a20:3d0a:b0:34e:eb6a:c765 with SMTP id adf61e73a8af0-376aa5008bamr2997142637.37.1766150181401;
        Fri, 19 Dec 2025 05:16:21 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e9224d9e5sm2346819a91.17.2025.12.19.05.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 05:16:20 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bjorn@kernel.org,
	pulehui@huawei.com,
	puranjay@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	menglong8.dong@gmail.com,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND bpf] riscv, bpf: fix incorrect usage of BPF_TRAMP_F_ORIG_STACK
Date: Fri, 19 Dec 2025 21:16:09 +0800
Message-ID: <20251219131609.176911-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The usage of BPF_TRAMP_F_ORIG_STACK in __arch_prepare_bpf_trampoline() is
wrong, and it should be BPF_TRAMP_F_CALL_ORIG, which caused crash as
Andreas reported:

  Insufficient stack space to handle exception!
  Task stack:     [0xff20000000010000..0xff20000000014000]
  Overflow stack: [0xff600000ffdad070..0xff600000ffdae070]
  CPU: 1 UID: 0 PID: 1 Comm: systemd Not tainted 6.18.0-rc5+ #15 PREEMPT(voluntary)
  Hardware name: riscv-virtio qemu/qemu, BIOS 2025.10 10/01/2025
  epc : copy_from_kernel_nofault+0xa/0x198
   ra : bpf_probe_read_kernel+0x20/0x60
  epc : ffffffff802b732a ra : ffffffff801e6070 sp : ff2000000000ffe0
   gp : ffffffff82262ed0 tp : 0000000000000000 t0 : ffffffff80022320
   t1 : ffffffff801e6056 t2 : 0000000000000000 s0 : ff20000000010040
   s1 : 0000000000000008 a0 : ff20000000010050 a1 : ff60000083b3d320
   a2 : 0000000000000008 a3 : 0000000000000097 a4 : 0000000000000000
   a5 : 0000000000000000 a6 : 0000000000000021 a7 : 0000000000000003
   s2 : ff20000000010050 s3 : ff6000008459fc18 s4 : ff60000083b3d340
   s5 : ff20000000010060 s6 : 0000000000000000 s7 : ff20000000013aa8
   s8 : 0000000000000000 s9 : 0000000000008000 s10: 000000000058dcb0
   s11: 000000000058dca7 t3 : 000000006925116d t4 : ff6000008090f026
   t5 : 00007fff9b0cbaa8 t6 : 0000000000000016
  status: 0000000200000120 badaddr: 0000000000000000 cause: 8000000000000005
  Kernel panic - not syncing: Kernel stack overflow
  CPU: 1 UID: 0 PID: 1 Comm: systemd Not tainted 6.18.0-rc5+ #15 PREEMPT(voluntary)
  Hardware name: riscv-virtio qemu/qemu, BIOS 2025.10 10/01/2025
  Call Trace:
  [<ffffffff8001a1f8>] dump_backtrace+0x28/0x38
  [<ffffffff80002502>] show_stack+0x3a/0x50
  [<ffffffff800122be>] dump_stack_lvl+0x56/0x80
  [<ffffffff80012300>] dump_stack+0x18/0x22
  [<ffffffff80002abe>] vpanic+0xf6/0x328
  [<ffffffff80002d2e>] panic+0x3e/0x40
  [<ffffffff80019ef0>] handle_bad_stack+0x98/0xa0
  [<ffffffff801e6070>] bpf_probe_read_kernel+0x20/0x60

Just fix it.

Fixes: 47c9214dcbea ("bpf: fix the usage of BPF_TRAMP_F_SKIP_FRAME")
Reported-by: Andreas Schwab <schwab@linux-m68k.org>
Closes: https://lore.kernel.org/bpf/874ipnkfvt.fsf@igel.home/
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 arch/riscv/net/bpf_jit_comp64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 5f9457e910e8..09b70bf362d3 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1134,7 +1134,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	store_args(nr_arg_slots, args_off, ctx);
 
 	/* skip to actual body of traced function */
-	if (flags & BPF_TRAMP_F_ORIG_STACK)
+	if (flags & BPF_TRAMP_F_CALL_ORIG)
 		orig_call += RV_FENTRY_NINSNS * 4;
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-- 
2.52.0



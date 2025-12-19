Return-Path: <bpf+bounces-77156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 957FFCD04D1
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 15:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C6BA3003DA1
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 14:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C98318146;
	Fri, 19 Dec 2025 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1IKnljR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com [209.85.167.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070A21A840A
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 14:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766155042; cv=none; b=rSBqf5Wc6rKvtnztfW2+9QcEogruGH4p8dtuT8lNGzUxD1XqVF1q7GR8CX3awCafqHD2msNtOtSEVem0jYApn/kRe+jNAQowUjgKidYiCx2gfzQTp1DBzKKNBB3uGFfGsU9WzGNoTT/kjRenmc3JRxezA1CdrH17PMlZ91NhoRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766155042; c=relaxed/simple;
	bh=hGjYfTPZVpLjfYpJDfuQ8wmqEFOpDaT5M488rWNUYoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aEOBkH9QzL49S3nAMDK6ycXKcaQF3JyhAnT2toceJfi3OVniQTNoTazrQuQnbiaGJGiyL8AT4J4QTMpaYwkx++oBHVleb3RsTAt2I89AAbRB7KraUd1v+GO0iZXQLt/IPsWvAvCCqU+rJ0TScZbA/iOAsoi5wEUwbdrvE71GNsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1IKnljR; arc=none smtp.client-ip=209.85.167.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f196.google.com with SMTP id 5614622812f47-4507605e19aso1120273b6e.2
        for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 06:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766155040; x=1766759840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d8S9arpnQbQKRrRPutZ5MVC6WeUVyaLDfqwrd6H6Lag=;
        b=L1IKnljRQv2Qsadx56hcwQo4pEXaoo7R8JzT3HEdqh5zpPNF8fV2tsW3ViLgkIZceH
         AyDDfW4umq3yazpkiYRLtipab3p0taA/ztShxuZdF0E/DYOAjDHpEZ53TsqUw8SGGzP/
         5gYZabogsW9ie5Eb0GHOPKSlLFxwezwtFZ6KYWQuzUmgxOV8DuhVplWArt0v8+fuRBer
         5pl5v4oCkMZa2hPD5fPnjwJ4ytXwFbijbBZ/gE0g6GxU/dR323I5TL3SpeCTpUP6jzQI
         V3pIU//NzJJiXr46pPjXY4t+6PJQEnGB4wrF6Dz2tsfVQuphD6hTbvBVcR+BfNtRg7uj
         AhYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766155040; x=1766759840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8S9arpnQbQKRrRPutZ5MVC6WeUVyaLDfqwrd6H6Lag=;
        b=WbobeoBnYe+YL2Eu7TN2iR6BDDm164pzrCK0BIbbJlBoWxE+IFKdcGgDCAnWSdXfFY
         M0n074k6ghCofneic1CUU0gSzPae6YsX+bQpwT6tX7RworVMU/7ly/0hwkqCKilAYMYN
         n9YCZuzFMfH0uAIP8WfbzddWfPMp/2Es/rcd6pHt1sNQVj0lMqYtzF3ZfDrXaT4scWau
         P7yOnYcGS3ixO9m4me829nRFx4bKam5B91ZD7P0MQQXXgfF3IcOzOJjv2+o7jNBPEjD0
         hv7iyRy0YGZ1FwLMXmGH9lB7xY13Wv+guqig4EsOQB7rCAkz8BFvdZcgLibDp6tulcLg
         xlVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsHYukg3gFyoIiDw3EugU0SGsGQZFcvIzmPL9c2y2J0nW5wcrFBt6Hk7EC4MLnBKLstJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQSMlBwS/c9KJN+1OwcEDs9mAqgzwuC0X1zWjccoAT5e1A2CJB
	2djJLD4KK8a5/GTnEV3lltPsGGyAjplFm002JCc51bJzFZUunbQ5kVhJ4D8BsTEMHFM=
X-Gm-Gg: AY/fxX6YjaUZMgfpGoFc1jnJZRIYgS8wmEdVP9StM73bpY6UfZrbjmlOM6TFLEnMDOM
	XpEtmjEyoF8pk7CKdTGKVx/GuuiL909X/PrVHT1N7zCfWEbTSW9uxbQqV7GWASKYOfRnOJeJVuD
	STHb2AV8yyN+ybjxE7koOwPf4jpvUM53NI9rsMn6in9SfL6FadWbPQPTbVrZFnCZVSd2/irwbb/
	+udeo9T3HTafciVPanoawQu8rXhUafff2zLNzVmeUECZCol6/1ekwZb5zR/asygVS7y8ZDqDq+4
	EqNwPS5H42RbGA80DYlbr/snKfxcECganfgxA0Tu9aa6gmKAgLZqkditEZBh/zcetPPOl5UpvfX
	k3xdtjS0SlZnkKcdMDA6tJIeWyvryIrSFBRux9XsI8XEHGWXCItMRIAyFBHqq9WQy3XkEukx9W8
	DYR+FYGhrMFvI=
X-Google-Smtp-Source: AGHT+IE+veN2yrrZeFF1UwlrVEnWYNBAeihhpAYdak+7pFIePoIXcnPL+veHjarmZ99tXTrQ3zfZ4g==
X-Received: by 2002:a05:6a20:e293:b0:341:d5f3:f1ac with SMTP id adf61e73a8af0-376a9de5b1fmr2872897637.41.1766148481835;
        Fri, 19 Dec 2025 04:48:01 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7961fbb9sm2110688a12.2.2025.12.19.04.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 04:48:01 -0800 (PST)
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
Subject: [PATCH bpf] riscv, bpf: fix incorrect usage of BPF_TRAMP_F_ORIG_STACK
Date: Fri, 19 Dec 2025 20:47:48 +0800
Message-ID: <20251219124748.81133-1-dongml2@chinatelecom.cn>
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



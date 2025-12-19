Return-Path: <bpf+bounces-77163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E81CD0F26
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 17:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B804B309E305
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 16:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E582A362157;
	Fri, 19 Dec 2025 16:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpuW5wf5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC905362150
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 16:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766161790; cv=none; b=PkrL24YrD1VXXfUf7XaYUChfkPaIa9giC1NXBR8yEz0dIdcG1W4pt5ZXbHN7nZUoaBAuD0QtMkWmtbOQz0cZ87NuBkg3nX2Mkr9w7xrfn8L5rDClEESiN94BwBSu6KrHUyF6gSnpTQLr5RNAJX42oxaF6Z7swytbUo5q5qxN0wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766161790; c=relaxed/simple;
	bh=cB3UAVw4AnK+AP0ieow7TbChOsK4vAiQbdu+PfJgSDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VTUZ2gZp5Gptc7uURcqkvxibnXGfxrTYxfTQg/b9yNtzOtPMyOJ+0F3bNQPJ5qTrcb5LVBSOWMxMqCck9WWgcRjfr0ekNgbrVySSuIFB7AV/rRO3O63ewWZBi+gRK3E6jRYqy9IG2VwTbcltedG0O9LyGdr9gLc8SqtlYIR0pJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpuW5wf5; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-88888c41a13so21408056d6.3
        for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 08:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766161788; x=1766766588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Edwd8UY5a1jD2Jxp69UFc+WzgBkBRj9goxSodHca6Sw=;
        b=IpuW5wf5aJAQF5syvh9bP2rdp0do73ORAatD0A67jxmELOKUdtUW7ePQl3qwlajbma
         BFb+c3zocF/jJxIlFmarqTMxTYlS/iGGxzcitn+4WMbs1m/mWC93BoYEzw7/DNllP62D
         Ih63ZM3ZPDX6bRZFL0PuCO2rR78rKGZcRbDcSUa9nIObdUzr7prwFKgTc5bC50HR2RPW
         O+kxoV/AoWKR207kfM2EC2j+XuM0qDzuJCx4hX3k9ya4L3I7MOR2qbkYjBgUUMg9G+YB
         yO4kyd8ghP+C0CVoyzJ8SvRN24YnMLyht4NDH+UB2SQtZEFU2ZOzdyvy7QrpFyi5AsPD
         oC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766161788; x=1766766588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Edwd8UY5a1jD2Jxp69UFc+WzgBkBRj9goxSodHca6Sw=;
        b=AOHH5wquVAxLriShFZZhlYiyeg0jokZtqE2lix/zdoSdlBd5uzPNtNyllBAiO0pboK
         x8CWDzuH8RRoL2zgBUUUIC5bhzulr+4H9FFGLtwADAQR1v3CYIE1OVZ5rOn6diuL6DKh
         Ph5foiVyWTSIW1rzLfmU4ZqtCdnNV1Su/V/PpdwBgf6VlG3fPVXnDxGgGSOzNQbFfIqf
         4E5/MMIiyOb8n737YPa0gLDWs1pLkm1h9vDD+sMql2zNfU70nEqNzMIgdGzen0xm6o0P
         82OeANff5UM1pWhdiLR2vs3AB7Hhkf/N5pGM0xqBYAMzl+Hz8ndlSIDDW28FQgwZBNI7
         t7BA==
X-Forwarded-Encrypted: i=1; AJvYcCV01GECmtAcOIXeSvHUA7BKYx0lHQe7NmBP5fwgLTm1zraGYg78xGQMXEA9UTNzWYRanp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBUlxNkIPUBc7LtliG3EEEZ+7+KpDzs/FChSGqlDuDQyMF/3HE
	P+g0JP3AcApMR2Tqgn52KSnKl50mxNWhlAI4MktGE+/2qfByzvXs5AITq/H/W2Yt1xM=
X-Gm-Gg: AY/fxX711rU2pfzFL/9XJucYV8rwOCHjCo4qp03irXZHabappQjpN5LPd15XFuQIYHI
	Y1Cp60EyQExbgS34fTewZEz6++8qdr6P9o++Cye8SPQLMSPxFS3XX8PZDHwsFrLYMS8f8qwBPwB
	aU+lSsgmjrXjlbkhtjvntCKuP+4xWmffQ7b1xAX0Ba6R16FSV9Pf7cdEpKsti1OT/DD9Iey6C9Q
	qu4ineUmgsCIO3rz3EX0S8VOtImH2AllOxnSH5LEnYKIYqY3c+iJXb6Lc3VlBSwofibwwmauj2I
	AY1U+cyueZeLP9s8Dr5su0iRtTrnWio3gAI7lw3Tq/yiuBTcH0Zakh5GvuyvlcLxR7z9H0DHggC
	1YwDhV/w3qmDzIhi+hKnBuHwvmDLFBwGshV3t5Yi0sPHw313Vkp3hCrsWOnLTanTN1KDcXgKVaJ
	CiCw6xyeeOMzg=
X-Google-Smtp-Source: AGHT+IFq5oWI2daMug51YuI+nmWHxSg6/yFeviCCy4ETMjX2vXEJi5/nbTSyTXuKWJ73d/ANbQ0DVQ==
X-Received: by 2002:a17:902:fc43:b0:29d:9b39:c05f with SMTP id d9443c01a7336-2a2f22026camr31186615ad.10.1766154600996;
        Fri, 19 Dec 2025 06:30:00 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c6a769sm24607575ad.7.2025.12.19.06.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 06:30:00 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	schwab@linux-m68k.org
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
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v2] riscv, bpf: fix incorrect usage of BPF_TRAMP_F_ORIG_STACK
Date: Fri, 19 Dec 2025 22:29:48 +0800
Message-ID: <20251219142948.204312-1-dongml2@chinatelecom.cn>
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
v2:
- merge the code
---
 arch/riscv/net/bpf_jit_comp64.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 5f9457e910e8..37888abee70c 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1133,10 +1133,6 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 
 	store_args(nr_arg_slots, args_off, ctx);
 
-	/* skip to actual body of traced function */
-	if (flags & BPF_TRAMP_F_ORIG_STACK)
-		orig_call += RV_FENTRY_NINSNS * 4;
-
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		emit_imm(RV_REG_A0, ctx->insns ? (const s64)im : RV_MAX_COUNT_IMM, ctx);
 		ret = emit_call((const u64)__bpf_tramp_enter, true, ctx);
@@ -1171,6 +1167,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	}
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
+		/* skip to actual body of traced function */
+		orig_call += RV_FENTRY_NINSNS * 4;
 		restore_args(min_t(int, nr_arg_slots, RV_MAX_REG_ARGS), args_off, ctx);
 		restore_stack_args(nr_arg_slots - RV_MAX_REG_ARGS, args_off, stk_arg_off, ctx);
 		ret = emit_call((const u64)orig_call, true, ctx);
-- 
2.52.0



Return-Path: <bpf+bounces-78935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEB7D2031B
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 17:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACAA9305498B
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 16:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60053A35BF;
	Wed, 14 Jan 2026 16:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvHQ02lh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC283A35BE
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768407488; cv=none; b=oAtxs8xGTUnFxsJTdoeade5LHXhlYNHGSzFYLWeK2UuZJJAJvv/5Kb05dXBOWdbQ/C67ub1HpRVGyG0PhoFgj4Iz+z6qwxGpXjKKiTHachfVEPM3m/BnbXEj0G7/GoXL02LUwTtNr/MuI/4k7p2dUlhFhP/R3WPSxhCfEsybYI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768407488; c=relaxed/simple;
	bh=jOu9G/UQ+6FwVr3IkgrcQVjZRJVAO1oyLQcGWQFQons=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c/mrtLZJSc2Uc0Giy7sCTG3apVglANhb3qjV/mzfAx4tOkPvRTV4l/ystzZOaT4sMbscx0KrMeYbojgen/ovm+//VS37HGIZ0xBJ84/Xyp1TvXbiLFGKmmbnCWa5oJCF86ghT+WTymRHiS3hC5IVxOYcvUHlMrua1iFUUDKZECI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvHQ02lh; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so817866b.2
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 08:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768407485; x=1769012285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJjlX2v8hKg/ceJ4Ebh4oWGVOGYZAXY/OOW3orCK/WY=;
        b=OvHQ02lhgpeDki3WpwKBs4v+jUikmN84ZOlSOJyxK6Potsab8t0/fosToYcIwJpOlk
         Rwf/TJZCTdgBFhFkYt/TCbbGGrFNHWrvE1GSuXrETfVjjBO4OdtiFv2zftsT7XTYnGGM
         9gkRrATPWZYOOknoV21ZgDuc8V5gqEa1CqDEaZt0V38a8YZTaPB3pGe0br45aWJRzK7c
         OG/LXmjys3PsXZyB7E9UWw7CJXFJeDa3XMcHmwVcZnHpYEQOsJzj8UNOPcOyLGfdKI6I
         YjN7M4LNj8GBVVv0Y4f/hjCabcIk4ygDQFxNhqPtPhKBSSn4YmOR7Q75yq8i+gOGmMNV
         28Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768407485; x=1769012285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CJjlX2v8hKg/ceJ4Ebh4oWGVOGYZAXY/OOW3orCK/WY=;
        b=Rw3b88P81J97NEcaRXqRnSrgm8fjBbXQtNx5ABRLW6ae5sO9c8fQ/UTPYL3lcdVo50
         d7gXFUEY6Mvro00Jo2zMC3JqVt7k9A5yEBugebZ+k9/BiAMnIR9kbpISSx7gYIAHlw1x
         2MYypD2cJaYg7L60fEsC6zZgqjkbvoALLILxgwy1wh8OVe1L7HeuSnJrHpAoxqN0OB2j
         hFrZ5ueLYs1XZILxFkKFkFjJOupBKmzy6bEfpmPiIKmxhvt48aY8IYAHDOH57o+slZMR
         tGBZ0PeOD1FM3u5cjueIPMVvMAdIjwynqGVJaG33nT0/PqpBv9DJTV+VAX6HYABT+h4D
         rIog==
X-Gm-Message-State: AOJu0YzreO3AZCXPvXhT3Mx/3yKmJJIxxd2gv9CKste7bo7arX4JMh+U
	g0Tt8vO/DolTZ6lk4Y3IYmubsvVQEN7ZH7fiUa8roggUMe6NY68FVGmYEDZUxw==
X-Gm-Gg: AY/fxX5n5+limr8haIw+3TxImFRfZXQSlLRUkeGA4aYzGyap5I/x+YtcCq5IoYHCnrH
	qjW/rLHuvCF0u39V7wWhnKqHzeZh6BEERg2fxkK9CsvQAOropT0vSlBNbBgHqpgzVnQmeAYpI4y
	V02lNCIm6OgRzaLg3s/KAKD7NBJNpp1Gbl6aTxlUKpCAuEXIBCeoXhEUA3Wxpe3r4mVWJX62IVe
	4mKbhmqvIryEWb3sof/UwvJL1xlnEiMaCejG0fEQuOy5tisWcb33VV6nPF6VFwHgjaxANUByMDD
	wt9ZaYmYdXynPiAf5rPUFtLkc/SJ/zBN00OGY0LRnl6+/cesvCOPdZYaGMqof1KGFDVxTJFTLCW
	BZ4nD5laYBsw6np2/qkX6SDTK7WA5KLZjiKZUdZfWn+4diU5Id9snwZEj2zz0CNoCCRE3CJ7cK4
	Fao6cUcj3Np1y0serFXUOsy0FO2zMU74Rk8FbuhTgT
X-Received: by 2002:a17:907:3f91:b0:b87:fad:442f with SMTP id a640c23a62f3a-b87612a7b75mr287824866b.42.1768407484794;
        Wed, 14 Jan 2026 08:18:04 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8713416418sm1055553866b.49.2026.01.14.08.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 08:18:02 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v2 bpf-next 2/2] selftests/bpf: Extend live regs tests with a test for gotox
Date: Wed, 14 Jan 2026 16:25:44 +0000
Message-Id: <20260114162544.83253-3-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114162544.83253-1-a.s.protopopov@gmail.com>
References: <20260114162544.83253-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test which checks that the destination register of a gotox
instruction is marked as used and that the union of jump targets
is considered as live.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 .../bpf/progs/compute_live_registers.c        | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/compute_live_registers.c b/tools/testing/selftests/bpf/progs/compute_live_registers.c
index 6884ab99a421..f05e120f3450 100644
--- a/tools/testing/selftests/bpf/progs/compute_live_registers.c
+++ b/tools/testing/selftests/bpf/progs/compute_live_registers.c
@@ -431,6 +431,47 @@ __naked void subprog1(void)
 		::: __clobber_all);
 }
 
+#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
+
+SEC("socket")
+__log_level(2)
+__msg("2: .1........ (07) r1 += 8")
+__msg("3: .1........ (79) r2 = *(u64 *)(r1 +0)")
+__msg("4: ..2....... (b7) r3 = 1")
+__msg("5: ..23...... (b7) r4 = 2")
+__msg("6: ..234..... (0d) gotox r2")
+__msg("7: ...3...... (bf) r0 = r3")
+__msg("8: 0......... (95) exit")
+__msg("9: ....4..... (bf) r0 = r4")
+__msg("10: 0......... (95) exit")
+__naked
+void gotox(void)
+{
+	asm volatile (
+	".pushsection .jumptables,\"\",@progbits;"
+"jt0_%=: .quad l0_%= - socket;"
+	".quad l1_%= - socket;"
+	".size jt0_%=, 16;"
+	".global jt0_%=;"
+	".popsection;"
+
+	"r1 = jt0_%= ll;"
+	"r1 += 8;"
+	"r2 = *(u64 *)(r1 + 0);"
+	"r3 = 1;"
+	"r4 = 2;"
+	".8byte %[gotox_r2];"
+"l0_%=:  r0 = r3;"
+	"exit;"
+"l1_%=:  r0 = r4;"
+	"exit;"
+	:
+	: __imm_insn(gotox_r2, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_2, BPF_REG_0, 0, 0))
+	: __clobber_all);
+}
+
+#endif /* __TARGET_ARCH_x86 || __TARGET_ARCH_arm64 */
+
 /* to retain debug info for BTF generation */
 void kfunc_root(void)
 {
-- 
2.34.1



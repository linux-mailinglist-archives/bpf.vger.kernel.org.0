Return-Path: <bpf+bounces-54097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 774A7A6289B
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 09:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1988F7A7865
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 08:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D29218A6DF;
	Sat, 15 Mar 2025 08:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTtIuHQp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09911624DF
	for <bpf@vger.kernel.org>; Sat, 15 Mar 2025 08:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742025811; cv=none; b=E83DX1ZO96K5+txeDzbmkvm+a1T8VUY1b+b9xOS4eM0/otjcrf9e3WwKH3RJw/qqoRhKlK8O7k4iVQScKXnljSw5nOSwwMLdMpgayIPxYr93u32FrC/C6o4+Bw7vg6KDEe5nmabfnC7MKyZLQzuDQQheXm0Ik9HTBtP3gIRGtCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742025811; c=relaxed/simple;
	bh=cK7X+ekj65GDPa3Y3otbIX2aFl4VQDsKw9VVrWlksIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k2EG+Ae/bfJDXnkgPMicPPH6+CkHyxG/MqaDVBERvu6r14VZEO1YX3ZwpnaV7Bvyy+jR8eYdZl4JHXK0JSrGDZ4kKX51/mt6ECgK/eW2RnOK8shM/CVyDkmGxsGnx5jRq3jPHvRRm3p1sHlDIo9D5zrDqNxB8iphzjnc5lh+8gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTtIuHQp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2239c066347so58629055ad.2
        for <bpf@vger.kernel.org>; Sat, 15 Mar 2025 01:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742025809; x=1742630609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MsBMohK1J5AZoR8f2vnP4yTF9NYNvX08pUGvJRqOXzk=;
        b=bTtIuHQp/xNycPlMDgWbpKfEgL1rHGZhhUOueKK2hxE7LOeKGPrP3rsbhyOv7vDM0T
         T3a1H1CxhyYVg2bt5LpYZzY3b3NYsCycRAcaK4mFPrlbEyN0HRkmMVttd1iDACVo3MAU
         JR3wcank2j07N46G32/cRhdCYcKKyCR1O3uPAdYZdCR1RmdSa2YD521lU4VX2cWkGD2e
         qvrf0Jc0tNr6BKdw29ShYsCsitluZ0S+yA/CoAfxdA+e5GPswTXEC7jUDkYR7NBPQ69m
         55vdZN0Ahgq5eC4ZbUsODEhO7GV9NP84DYf106yNVXVRQGczcs0OyaY3BNvBH6OBmslR
         nmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742025809; x=1742630609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MsBMohK1J5AZoR8f2vnP4yTF9NYNvX08pUGvJRqOXzk=;
        b=tpUYPh8yt+8mDujPaIR8r5x66p6WwH+/3ZMcgpsbycU9bXWfExtxvhIriTinI9mhGK
         H9CRXiWYPXTYELTzHUdnyAMTh5nGK926cZemlv68oHFDZyr/+GoaBZi1R/ykwwhDDn3B
         tCELRnN83cgRSZiLnq6fk15xAtwNZcorUqO77mcN2GJOy/urFVaoNRKUErYhQnEaCCJ2
         ps2Ea41KEwuaTaPPo+ADN8MuKEr7WUAcNRSB7LsRt1rnUGChhBRzlp3sfUxNcO7ffVVI
         RXCmA4jvRn5p8hTnN2+QD98/ze7vSlrvyv8PA96+wf7rlZas4umVupITXbLsFQlny2yU
         cl/w==
X-Forwarded-Encrypted: i=1; AJvYcCWpVfz2isr1ntssmBp6FvedIml26GZpRamLeUPo31uJAdaxmBe8DfyJT6Osq9U5HiPP4JU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj5q4EleBypYwhqxPTkFS2W9Y44Lp72dsq5ANKifXsxqBXLcbB
	XrSe035wof6EaN8f2u5r9ZOevMGr1JmU4DxofIGDUx8Wp6po5tLu
X-Gm-Gg: ASbGncv8IdjWgudN4Gd8+uKsyzfaOT1vY1RQx7RCDsYuNLyzywiWP3sziY+6osCQr/U
	nBOu7hoxwCJv4aWdyHG/HvYkcd5YyEk8OaarQttHgQtCzlhWrt9cfN2hadm4dfApatrXzq2/j3w
	T0uHWNqRf+ppGqDC/onK4XHdO10g0xTVIXvcljcZodJ7mfTej5bSxwAhBADaPmgiEvfjEGUp7cF
	NwmC2fGdNbEhsPFhH5C/EhZGFqXM3mfIkmtvb2LiaIsRv8fWK+fw07Bk9NkMM0+zuSVv4d802CU
	KmKR8XlC0Nf5oTL6y9NHBVDb5TUpyYoC00n8+sX1BlDypdUBSVrxklvlmGZDV4R4vYTI7XLScDf
	FfKpkaQ==
X-Google-Smtp-Source: AGHT+IEHVcuvOSaQ9YBO8ax6PXV3hpfu6w1q13nBl2BZtcvzWwDaa3+1um1+XUscvYqwwvNKOrpVZA==
X-Received: by 2002:a05:6a20:9148:b0:1f1:b69:9bdd with SMTP id adf61e73a8af0-1f5c1311632mr6046505637.37.1742025808748;
        Sat, 15 Mar 2025 01:03:28 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.34])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-af56ea7bd01sm3190508a12.61.2025.03.15.01.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 01:03:28 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: loongarch@lists.linux.dev,
	bpf@vger.kernel.org
Cc: yangtiezhu@loongson.cn,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Vincent Li <vincent.mc.li@gmail.com>
Subject: [PATCH] LoongArch: BPF: Fix off by one error in build_prologue()
Date: Sat, 15 Mar 2025 08:03:20 +0000
Message-ID: <20250315080320.4193821-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Vincent reported that running BPF progs with tailcalls on LoongArch
causes kernel hard lockup. Debugging the issues shows that the JITed
image missing a jirl instruction at the end of the epilogue.

There are two passes in JIT compile, the first pass set the flags and
the second pass generates JIT code based on those flags. With BPF progs
mixing bpf2bpf and tailcalls, build_prologue() generates N insns in the
first pass and then generates N+1 insns in the second pass. This makes
epilogue_offset off by one and we will jump to some unexpected insn and
cause lockup. Fix this by inserting a nop insn.

Fixes: 5dc615520c4d ("LoongArch: Add BPF JIT support")
Fixes: bb035ef0cc91 ("LoongArch: BPF: Support mixing bpf2bpf and tailcalls")
Reported-by: Vincent Li <vincent.mc.li@gmail.com>
Closes: https://lore.kernel.org/loongarch/CAK3+h2w6WESdBN3UCr3WKHByD7D6Q_Ve1EDAjotVrnx6Or_c8g@mail.gmail.com/
Closes: https://lore.kernel.org/bpf/CAK3+h2woEjG_N=-XzqEGaAeCmgu2eTCUc7p6bP4u8Q+DFHm-7g@mail.gmail.com/
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 arch/loongarch/include/asm/inst.h | 5 +++++
 arch/loongarch/net/bpf_jit.c      | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index 3089785ca97e..d61b356170fe 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -695,6 +695,11 @@ static inline void emit_jirl(union loongarch_instruction *insn,
 	insn->reg2i16_format.rj = rj;
 }
 
+static inline void emit_nop(union loongarch_instruction *insn)
+{
+	insn->word = INSN_NOP;
+}
+
 #define DEF_EMIT_REG2BSTRD_FORMAT(NAME, OP)				\
 static inline void emit_##NAME(union loongarch_instruction *insn,	\
 			       enum loongarch_gpr rd,			\
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index ea357a3edc09..2346c0b55043 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -142,6 +142,8 @@ static void build_prologue(struct jit_ctx *ctx)
 	 */
 	if (seen_tail_call(ctx) && seen_call(ctx))
 		move_reg(ctx, TCC_SAVED, REG_TCC);
+	else
+		emit_insn(ctx, nop);
 
 	ctx->stack_size = stack_adjust;
 }
-- 
2.43.5



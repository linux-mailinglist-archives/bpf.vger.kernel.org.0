Return-Path: <bpf+bounces-74624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B216CC5FE37
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 03:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 8D72D2419E
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 02:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812FC1FCFFC;
	Sat, 15 Nov 2025 02:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7VkYkNp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A522E1FBC92
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 02:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763173582; cv=none; b=lA0GO/4XKrDRIAG60VXzktXYs9mVPv1UcQ63XqjK1BYKFZ0NVnYwVgUCWHyQC8IknOfcozAKGggthnLe4bprroMS1uuxdnuNvjn6hoTOp+EEr5U9ITcwrWTr7/vT3LljVJb0uo69AKXHayZkwwEW5/JUEcBbemAcWxDpS4JL0H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763173582; c=relaxed/simple;
	bh=2JRz98L/X4J1/7s/INiuMS0uj/Cxzt2tyKvKgaEgvys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bug8vr7OFeM/qwp3EeSre0xQDL1c1H8R6/wxjvDHGxK9XNcTnQDloE2Sq/wMelvz1rUTeSScnvt9woL+wbAPHJaA5daOfN/OGfxLkYMOo4oCKCigR2ADBV2YopHGsLEQrQ2fuQb+fauNmaDwnh0v8NxG8rJ9T4NjbJ7vayhlf68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7VkYkNp; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34372216275so2980371a91.2
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 18:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763173580; x=1763778380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxPT9UhCi8aCP6tdRDy3fIrULkn1E4KC08krXo7/Dno=;
        b=m7VkYkNp3CjqEim7FE+jHLA/25nc7rKR8oWLe3tdr1kE+P7XZSoXg1ZrMNdPp1/icL
         amRmAPTT/BfPR9cpNn50dY/48GaWn+CywwacwkXDaCn5cDCSmZsKBU/7km8sffdg0oZV
         W0Zpo4uHLDzI1ljMO2nIxrGsMK3r4nmQdjYyW63wqOdQbzPgssCdn24ylinxbMPx83iH
         mTzSLDoeYiq5mWr3gH5e9Pf3nVZ8imCV8gFj93x6HeUX6L+OdDp9IG4bByh5lnagKIaP
         u/VRLYNF+QfQAU7MsXCPANxzbXMxNnYwLfyv4UVGNpDa4fsq8lGBctQDnLyHqKEUwfpm
         uAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763173580; x=1763778380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RxPT9UhCi8aCP6tdRDy3fIrULkn1E4KC08krXo7/Dno=;
        b=bdq8TVM3AfEhjx7Dp7oS3cVQ3OwCpgI/GjG8vuwkXvuDgwAy5P5x3coceqB6qbzSh7
         GODBfON1U4+/df2a+xzJoqALk08GdIGptWVnP2KcZMv2I97Zr1QJko5syhrE4OFX0H/Y
         LbfblSOq5fJgBckk1S0F9a3P708pODHtNLgwxGytFpSuxQsFdMBQoes+7GWujdvSXTjs
         BMRBAssBSNBpShK+piqMilrYrWRjkkI9d4xDMI4PHdmLVRnwi59r1v3Jx12nShxJu4G4
         I1DY0EtYGxS1jydDlExRs6ZlXyaotHik93h5C3PxJOHUBasj5Bo3sqczy+zcR+B9qU09
         F+YQ==
X-Gm-Message-State: AOJu0YxjH4V+/5sfaOD/rz7Fdw7WbuCm0+W/bDlMR+z4KrojJ0Z/nxUQ
	zQycYEIMDzlim5WYTFXpDmaaKJGwqULKimz9L5zLbIc+CyJsooT5qxKwdvt5uQ==
X-Gm-Gg: ASbGncvppMNzyeCSh6bTqvIgXUMHdSM/zvAShcLoyNIPl0ZbaX+BMbUtapPQ2JprK2c
	gfBEH/6YiFz2LLdlaQkHQ+fgnoqhv7XbQDCY492pxDWPz2YqfOqCdS5smMxFV8Afoh5COUF3yxS
	E4MiVZsPbrIiFVgs9pX9rLizAJsVv2DIOpyEoObxZ+oAguv0ZSOAT8vIQ9uKunlfwkaBgYaz7qA
	1eA2pRYziAOHvjBe1VbREnef8S6Tshr3Ikpv86oIds743uGAIBleOBh9GbnmSPYuP9crIa9pNde
	tC9SVHhqaI+BN6oB+3YW5ONTJ7zalHXP4SCPJVKLwAmkQqq/bihluDV2UEiIiDs1BrVTzSk8GgP
	5HnEWio5N4u0koa9RJTKsRt6YAlRNy3NLb0cmoTQzdms1ovYh3ICpBgyucBxhG1/iwo1zSHVCoM
	XC3khSAuv8hUnby6sHtuD/iMnSVw3X7np/2cPL2HCOdeJOLbn6AHCPtWY=
X-Google-Smtp-Source: AGHT+IHYwCIG8f57LIdCg7pHh2OM+6I5tW0tnajzsVDiPSb3lm69yciyPh8/RH44LZXv3NX+NiFQFg==
X-Received: by 2002:a17:90b:2b8b:b0:313:1c7b:fc62 with SMTP id 98e67ed59e1d1-343fa634737mr4879395a91.22.1763173579657;
        Fri, 14 Nov 2025 18:26:19 -0800 (PST)
Received: from localhost.localdomain ([2601:600:837f:c6b0:18cf:ab6c:cac0:3007])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3456511845asm1899366a91.4.2025.11.14.18.26.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Nov 2025 18:26:19 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	sunhao.th@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v2 bpf-next 2/2] selftests/bpf: Add tests for s>>=31 and s>>=63
Date: Fri, 14 Nov 2025 18:26:11 -0800
Message-ID: <20251115022611.64898-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251115022611.64898-1-alexei.starovoitov@gmail.com>
References: <20251115022611.64898-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add tests for special arithmetic shift right.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_subreg.c     | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_subreg.c b/tools/testing/selftests/bpf/progs/verifier_subreg.c
index 8613ea160dcd..0b572c067276 100644
--- a/tools/testing/selftests/bpf/progs/verifier_subreg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_subreg.c
@@ -670,4 +670,47 @@ __naked void ldx_w_zero_extend_check(void)
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("s>>=31")
+__success __success_unpriv __retval(0)
+__naked void arsh_31(void)
+{
+	/* Below is what LLVM generates in cilium's bpf_wiregard.o */
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w2 = w0;					\
+	w2 s>>= 31;					\
+	w2 &= -134; /* w2 becomes 0 or -134 */		\
+	if w2 s> -1 goto +2;				\
+	if w2 != -136 goto +1;				\
+	w0 /= 0;					\
+	w0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("s>>=63")
+__success __success_unpriv __retval(0)
+__naked void arsh_63(void)
+{
+	/* Copy of arsh_31 with s/w/r/ */
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r2 = r0;					\
+	r2 <<= 32;					\
+	r2 s>>= 63;					\
+	r2 &= -134;					\
+	if r2 s> -1 goto +2;				\
+	if r2 != -136 goto +1;				\
+	r0 /= 0;					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.3



Return-Path: <bpf+bounces-33418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A8591CBF0
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 11:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 665991C213DA
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 09:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110D63BBEB;
	Sat, 29 Jun 2024 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Exl3IffD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F4339AFD
	for <bpf@vger.kernel.org>; Sat, 29 Jun 2024 09:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719654491; cv=none; b=hYXaKC5rH/OE1yZZ1m1jlcmLVT17BsZAcnVeYeBgS6EriidJoDa8Lk3IFXeUvWer72hr5oIaGrIxJ0p3FhA8/7pNmq5vHNY9WGoLf+CiF+qhZk2XNSs9uc/xR9Ucwj4xOQBJmLz2PCOW/Q9qyawltQupHl55L8z0YL5RCAUiwdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719654491; c=relaxed/simple;
	bh=wW6VTQHBN1F8s86TJZF8xTChvV6uDYYIZg55KlKFRIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FI05rFYbXdlsaKqD6A4opgSaHLYGiO0blgzh3xI1w4MuoWiWJMfV0LceiztU898TLUNrvMSlOEfmjM+5RD4sIMAGsfDFuJdhSk/lMnm1lTvlrMSeZpGbR5/JPRndT7GKXnZQHl1J+M5tTJyxRY26NuNwZUOAYYzrme1ER/o31oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Exl3IffD; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6f8d0a00a35so1293129a34.2
        for <bpf@vger.kernel.org>; Sat, 29 Jun 2024 02:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719654489; x=1720259289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9n72pGCNJB6/flRjs1h8f3ESxisHAQzCEWPPFbEsaoY=;
        b=Exl3IffDr3tn3AmgEDs1lYTC+iG4Mw7mESmU2gDHA+z7b7J1UEhImdEnC7SYBUxiJr
         S6jUvNDUKDKXKSH1bJQ4cHkEBvhsN8/BkH7SoVbsWXMH4qGlxBoVBSPk7D1fEFA5/1vY
         9JVtDF1apLxHBSwQb1hDPjx7OXFiR9jWZWbqDbwFATlMtTjfD0RI8v2Okl5irWvgqvhj
         VelNnCssNCusqGNgAXK3ebuBeEvbkHzRV2Poj4l3VMGQFONrjAa90pQlK0bJEam5pMjp
         7NRG/pHd+ANUX8BDS9YX/8//lQzs4ZAutYTNJ9CuPdDgLrptdcu+WkAurpTzdlnZpCOZ
         hTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719654489; x=1720259289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9n72pGCNJB6/flRjs1h8f3ESxisHAQzCEWPPFbEsaoY=;
        b=L69Oso9MKk6gpMGqt4c3MZ8zRdHcqJaX8lQPV37OFymXjhG9NeVNEY3Unkzxq/JNNp
         2s/KOwCFFgHHCpKoU+AzcVe2QRgV/YceYVD2FhR3Am3VCJR8aMgfhxBxKsB4iSub9mWV
         dSl1OJIrviXOf99BcaMinKrJnNqYjJVwvCV6Uw2V7gTRHbAEmbLadfZMRPhB0oQVBuU2
         FpwyKv8T9SZKGEXbWag3dUmANI19eNexT4vGQb3RGRQqless2QswD0sUv4QH/QVR7fDq
         Pfhhw7n2aMgRMKloWrrm6eQY7YzVIXXPnLfYiiKiKdgG2To3OxSLkXOVL36YWaJlNIpb
         zoIg==
X-Gm-Message-State: AOJu0Yx3ZtLbsS9e2wkldT8uOWp12lEwQ1Qu0X1w8OmgLcp9bCT1923i
	9K5GQsGViB7apTiQrznhNF1L/scUHzYLb0DA2PsujP4wWG5nyR9buKU8zQ==
X-Google-Smtp-Source: AGHT+IGe1tf+3uz9E+eQrEITRLTqkkg3lD2v2ZsHFVwBGz6gNkD7TdDGMTk2tKs2SzPYmz+hE0Txzg==
X-Received: by 2002:a05:6830:94:b0:6fa:732b:862e with SMTP id 46e09a7af769-7020763c466mr587307a34.9.1719654488862;
        Sat, 29 Jun 2024 02:48:08 -0700 (PDT)
Received: from badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804989f5asm2948932b3a.195.2024.06.29.02.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 02:48:08 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	jose.marchesi@oracle.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next v1 3/8] bpf, x86: no_caller_saved_registers for bpf_get_smp_processor_id()
Date: Sat, 29 Jun 2024 02:47:28 -0700
Message-ID: <20240629094733.3863850-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240629094733.3863850-1-eddyz87@gmail.com>
References: <20240629094733.3863850-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On x86 verifier replaces call to bpf_get_smp_processor_id() with a
sequence of instructions that modify only R0.
This satisfies attribute no_caller_saved_registers contract.
Allow rewrite of no_caller_saved_registers patterns for
bpf_get_smp_processor_id() in order to use this function
as a canary for no_caller_saved_registers tests.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/helpers.c  |  1 +
 kernel/bpf/verifier.c | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 229396172026..1df01f454590 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -158,6 +158,7 @@ const struct bpf_func_proto bpf_get_smp_processor_id_proto = {
 	.func		= bpf_get_smp_processor_id,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
+	.nocsr		= true,
 };
 
 BPF_CALL_0(bpf_get_numa_node_id)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1340d3e60d30..d68ed70186c8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16030,7 +16030,14 @@ static u8 get_helper_reg_mask(const struct bpf_func_proto *fn)
  */
 static bool verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
 {
-	return false;
+	switch (imm) {
+#ifdef CONFIG_X86_64
+	case BPF_FUNC_get_smp_processor_id:
+		return env->prog->jit_requested && bpf_jit_supports_percpu_insn();
+#endif
+	default:
+		return false;
+	}
 }
 
 /* If 'insn' is a call that follows no_caller_saved_registers contract
@@ -20666,7 +20673,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 #ifdef CONFIG_X86_64
 		/* Implement bpf_get_smp_processor_id() inline. */
 		if (insn->imm == BPF_FUNC_get_smp_processor_id &&
-		    prog->jit_requested && bpf_jit_supports_percpu_insn()) {
+		    verifier_inlines_helper_call(env, insn->imm)) {
 			/* BPF_FUNC_get_smp_processor_id inlining is an
 			 * optimization, so if pcpu_hot.cpu_number is ever
 			 * changed in some incompatible and hard to support
-- 
2.45.2



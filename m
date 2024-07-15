Return-Path: <bpf+bounces-34855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 044A9931D6D
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 01:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F271282BA7
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 23:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCA4143C7E;
	Mon, 15 Jul 2024 23:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTAhmS2i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735B9143892
	for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 23:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721084552; cv=none; b=XrthHTUuDd4RKRJSIqe5dSxQ2hUTLXJiDEwrn3A21uzK9F5ag8tLxKEJbqpmAF5OA0TarhC9VoYQjt/ITzGd2Dl4f0CvWitZ31Q+xZeQIH7rSXF6Bb/8uzTR0rRu5ULuAjIXZpgQHOpQhHeAPyYaJqifyEPjazdfLBQjiv5fvD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721084552; c=relaxed/simple;
	bh=CAnlWEKZ3l2x0UK3l9LyFi6XfFtVv2r33jVfpRuutK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0ZfQjma3bB6BcJ5wDhwYDPIxG90I81CGLXyugjYULDiLUQyW81m7hsNzlwxhJ70k27tbzyTP035/M4OTVuQRaF7h6pboWN5RGvE/5HImAsc99DAPZbu5en4d+4bfLhM/WR5307EEKOw9J0bO8eklzzpQoN4STtyFz4Ayw4F88U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTAhmS2i; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-25e2cc76becso2281641fac.3
        for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 16:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721084550; x=1721689350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8u0f4ksXPNvwIFN8EtLn7J6PYIR0lZP9WxJGDTeEJ0o=;
        b=LTAhmS2iAzXOGgwCH8gNWsjqSEjwZtqPD71Clszso96jMEaF0zTWsrFEjefTAeE3U9
         0hi56BTmN7Sf720GhQcEw3vq0QaKmM/zT4vCqSARmzCkLGHY/WLSFAJGgZxKwPE72IiD
         meNWL5UjorxjMlo1b0W/i59EURdpm1tGZDUXgSh6pACnhbI++MT3mnThbUvci3+E0uMF
         fU0B7MMENpAtoVbapzu9BDY1tLlzYVYtLsSkY2I5uetkrb5Lu0Ci+Gw+w4Y39c65r1tY
         H5ZKv+jaDvxQjNwMsghyjEYiTq76PNgcuUKgG1Nm7Y+v+I+U9zZIOEAMrD1qxeyhspw2
         zAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721084550; x=1721689350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8u0f4ksXPNvwIFN8EtLn7J6PYIR0lZP9WxJGDTeEJ0o=;
        b=ZFxUwb+LwJ0cxzL+HQolOcWyHlyKK7nVc/+4Oj5yvf7eMCD3/SqeMSgyXqmHYx9SpW
         V0QXrecJD5FhZQfup3Erg5TCAtuE0ZFqQLGwtdcUgE5YZnuQSQgQeQGQSON9gCKhMGUc
         cVOo/gRYeUHERx9BeDiba2s6CvFhEq73KX9SpgvxDm1jArFeH+vjrEYKhlOUBzttOWFs
         EEHYjatMwIqXbx29EKArVam8eNdIywAgTHZOVkLnos+zYl+fcfb1pNNTf97FbvyHDOs3
         rv0X2RA3ILiu2kb60TjSG0hEHhvAKQXhyhdUfr1/QL52noVW69KXGT5Fv+ls6hD2W1it
         oAYA==
X-Gm-Message-State: AOJu0YwRY5c+JkvjJVzUJPg3QKyKw1v4AX27ztyb08PS4sqWj/z03Xnn
	PFl6KLH5rRUSo6BJxRBc9UDeQxO5EsS36Y3D7dFgediVmykYSh6uBJLaCQ==
X-Google-Smtp-Source: AGHT+IH1meRgy2NORA38EcaoJ/g2uyvTAraCmVGxLE3bOAq8G6r666QcX816dEXZMDqcEu827ktA2g==
X-Received: by 2002:a05:6870:50:b0:25e:b8a5:7b02 with SMTP id 586e51a60fabf-260bdddd8f1mr153142fac.29.1721084550120;
        Mon, 15 Jul 2024 16:02:30 -0700 (PDT)
Received: from badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ecc9d36sm4915344b3a.205.2024.07.15.16.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 16:02:29 -0700 (PDT)
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
Subject: [bpf-next v3 03/12] bpf, x86, riscv, arm: no_caller_saved_registers for bpf_get_smp_processor_id()
Date: Mon, 15 Jul 2024 16:01:52 -0700
Message-ID: <20240715230201.3901423-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240715230201.3901423-1-eddyz87@gmail.com>
References: <20240715230201.3901423-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function bpf_get_smp_processor_id() is processed in a different
way, depending on the arch:
- on x86 verifier replaces call to bpf_get_smp_processor_id() with a
  sequence of instructions that modify only r0;
- on riscv64 jit replaces call to bpf_get_smp_processor_id() with a
  sequence of instructions that modify only r0;
- on arm64 jit replaces call to bpf_get_smp_processor_id() with a
  sequence of instructions that modify only r0 and tmp registers.

These rewrites satisfy attribute no_caller_saved_registers contract.
Allow rewrite of no_caller_saved_registers patterns for
bpf_get_smp_processor_id() in order to use this function as a canary
for no_caller_saved_registers tests.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/helpers.c  |  1 +
 kernel/bpf/verifier.c | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 5241ba671c5a..e7b4c059ebaf 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -158,6 +158,7 @@ const struct bpf_func_proto bpf_get_smp_processor_id_proto = {
 	.func		= bpf_get_smp_processor_id,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
+	.allow_nocsr	= true,
 };
 
 BPF_CALL_0(bpf_get_numa_node_id)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 163b6b0f2fa7..438daf36a694 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16014,7 +16014,14 @@ static u32 helper_nocsr_clobber_mask(const struct bpf_func_proto *fn)
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
 
 /* GCC and LLVM define a no_caller_saved_registers function attribute.
@@ -20716,7 +20723,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 #if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
 		/* Implement bpf_get_smp_processor_id() inline. */
 		if (insn->imm == BPF_FUNC_get_smp_processor_id &&
-		    prog->jit_requested && bpf_jit_supports_percpu_insn()) {
+		    verifier_inlines_helper_call(env, insn->imm)) {
 			/* BPF_FUNC_get_smp_processor_id inlining is an
 			 * optimization, so if pcpu_hot.cpu_number is ever
 			 * changed in some incompatible and hard to support
-- 
2.45.2



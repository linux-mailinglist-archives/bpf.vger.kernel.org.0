Return-Path: <bpf+bounces-71684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F77BFAC1E
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 10:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 927EC507003
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 08:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A49301715;
	Wed, 22 Oct 2025 08:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C51GemWG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F162FFFA4
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 08:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120140; cv=none; b=CTKnw2myIx+XHAC5xsquhbvof99SOMSWiX9OI31v3/HlzFSIJEMylmZ4Hs/mcqjZ4BFTKf90SrcxFMtWkkljFh1NP9SSWY6glRcZLMrQL11YQ3RH6715Cryqp79GZJUJnIPkjKGj5eSMSJVFJUnX/Jbk9ZeARYCheI38rGoZ3Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120140; c=relaxed/simple;
	bh=exu1mvnQm0kIn1FVfpxwss/HOq/X3Jlmc2D+MxgxLiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QKpk5EAKDbw48HwyhdyN0nfgsJ4/JpUoFNx7LfQv5kR+K/8j6ZaCG4kT2lBStVIDErcqE7Yv1k69W9aw/7Ssjqmw94BxfRq1jk2NBdzsGf9rQtx+JG4mYDVzeEhPEWPDsqmXqTXOYRsO+Z2cv1A4UzFD/1cWQrptr2denM2nR6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C51GemWG; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-26a0a694ea8so46780555ad.3
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 01:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761120135; x=1761724935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyLcSwWt/RyeJ0fqwSXrGKxxaJ4cRG7bePVSrf3PDAg=;
        b=C51GemWGDO69r2ujKvp85HGNaLMjub/Hml33nCioN+ohEZyJMOnD7f1IdROO8mKzo+
         DW4BdhLtZ0JwZqPyw8WTazPVwuUAXOMocPx8mDGBD2hJ8VT6fv+2qs1lvWZSavuYRUsz
         f+jGrgiuXgYYDyc9iBD4+2lCYkeJ+otOCzvbKBU9uoV/1SGguqg/yvv9kjtaYiVHGzFo
         fSl5KuoorvaVZ7rsH3amTsBhl99G2k2qrf+tVJ0C5LBLwbVwT9UCTlLSgkOGPOk4dKCU
         uVjBMzmZnjlK7xM2/LHk6fgeLNEShCuD3FBmkdMjGQ8EwmUuqNUNRuoxS9nKFnWOwtAS
         hzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120135; x=1761724935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cyLcSwWt/RyeJ0fqwSXrGKxxaJ4cRG7bePVSrf3PDAg=;
        b=YMD5l0cqC7Su0E0yWWqfcY1npbiJ2/ouODW3m/5oGoET4laOR8YmFaoAuLM94TDelv
         jV7idc7O2cFBwmInq+dhldQRC/FjoMqKL8SgWrFCi/hwTgPXILQtsVayBw/j9YVoxeec
         wSvc2rnRr20YU6U92VPz1yjxGRaXiGdD19fWnbHu+EWOH7Ye7k0msKDCET3PYYPwt2Dp
         4ZZCwO3Rw8K4C1k0gpdwB3cL4gH56CYSBCJz/P6k6bUIvDcRhE+WBHk9f3lLWZd0CqZ3
         WCFrbXkaag8l3Uoo4pyJBsb86L9SB+2k78eoPBpyp52WWVLVtsPbq/69ukMQPu2u+gH3
         WR/g==
X-Forwarded-Encrypted: i=1; AJvYcCURPOOcnSyqObt+kTihlowM3eIucJMTQZGQOhOkOBBSi/dloMhPkIVzT0bNhMvRt5KkgVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ7pXZc1Vdrx1wqtes1QjVDqKcWD7AFAH2yHc7aSlPCndlAQGQ
	Byydlajl1VKZnvX82RXC73zQL9BsxRWKqJarLt9w63CHqm7G4hopa+Xm
X-Gm-Gg: ASbGncs0S8TJui7yQhZ5Q3CGAhsR6TjLzNv+GIYZfFUG3EaCMjvAdL6twj8rHzE/yEt
	+lCrKLt7dFfihHaOuGP1iSiR3N762TrSMcro1YfFoYAp4jPNnZ4PQyjTNGRDCml4PzMVevYl3cI
	ZjwbsMhC9a5h6IXI+HWj9uah/Qnmd5OEBL22PlPkoWYUp23i2D6/4J88+wItEjLKiI4rOMndBI9
	IdYPeXI1W54z8bga9n5fwSb1tpMBZMICPYkZuF+2H46ucc4hPVHNMByzhOeug3DCpoQ4JZxykcc
	jxwi3uv3UCD0z2pmeJT8eqMR6GsdhoGDweohnraWxqR0YaUrunYsj+lZ3lrW3O/IxkLLCIzs187
	X6gQ31JceDlc6NsmM9lP8tM6PdHvEna/1FMGR6/JXmo8x5TRwqkfjUCrTuuKGxEkuhdyP7158mn
	6152EPoiQ=
X-Google-Smtp-Source: AGHT+IFX/jM0vnbQUgGJ/nXZFkQeysbaBfwzLdTss7L4EJDRkAcM12qHXUwOvdatEqwNfLv5tXDGmQ==
X-Received: by 2002:a17:903:b90:b0:290:bd15:24a8 with SMTP id d9443c01a7336-290c9c89fa6mr247202645ad.11.1761120134699;
        Wed, 22 Oct 2025 01:02:14 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d7e41sm131947785ad.57.2025.10.22.01.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:02:14 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	jolsa@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	leon.hwang@linux.dev,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 01/10] bpf: add tracing session support
Date: Wed, 22 Oct 2025 16:01:50 +0800
Message-ID: <20251022080159.553805-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251022080159.553805-1-dongml2@chinatelecom.cn>
References: <20251022080159.553805-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tracing session is something that similar to kprobe session. It allow
to attach a single BPF program to both the entry and the exit of the
target functions.

While a non-zero value is returned by the fentry, the fexit will be
skipped, which is similar to kprobe session.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 arch/arm64/net/bpf_jit_comp.c                        |  3 +++
 arch/loongarch/net/bpf_jit.c                         |  3 +++
 arch/powerpc/net/bpf_jit_comp.c                      |  3 +++
 arch/riscv/net/bpf_jit_comp64.c                      |  3 +++
 arch/s390/net/bpf_jit_comp.c                         |  3 +++
 arch/x86/net/bpf_jit_comp.c                          |  3 +++
 include/linux/bpf.h                                  |  1 +
 include/uapi/linux/bpf.h                             |  1 +
 kernel/bpf/btf.c                                     |  2 ++
 kernel/bpf/syscall.c                                 |  2 ++
 kernel/bpf/trampoline.c                              |  5 ++++-
 kernel/bpf/verifier.c                                | 12 +++++++++---
 net/bpf/test_run.c                                   |  1 +
 net/core/bpf_sk_storage.c                            |  1 +
 tools/include/uapi/linux/bpf.h                       |  1 +
 .../selftests/bpf/prog_tests/tracing_failure.c       |  2 +-
 16 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index ab83089c3d8f..06f4bd6c6755 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2788,6 +2788,9 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_image,
 	void *image, *tmp;
 	int ret;
 
+	if (tlinks[BPF_TRAMP_SESSION].nr_links)
+		return -EOPNOTSUPP;
+
 	/* image doesn't need to be in module memory range, so we can
 	 * use kvmalloc.
 	 */
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index cbe53d0b7fb0..ad596341658a 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1739,6 +1739,9 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_image,
 	void *image, *tmp;
 	struct jit_ctx ctx;
 
+	if (tlinks[BPF_TRAMP_SESSION].nr_links)
+		return -EOPNOTSUPP;
+
 	size = ro_image_end - ro_image;
 	image = kvmalloc(size, GFP_KERNEL);
 	if (!image)
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 88ad5ba7b87f..bcc0ce09f6fa 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -1017,6 +1017,9 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 	void *rw_image, *tmp;
 	int ret;
 
+	if (tlinks[BPF_TRAMP_SESSION].nr_links)
+		return -EOPNOTSUPP;
+
 	/*
 	 * rw_image doesn't need to be in module memory range, so we can
 	 * use kvmalloc.
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 45cbc7c6fe49..55b0284bf177 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1286,6 +1286,9 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_image,
 	struct rv_jit_context ctx;
 	u32 size = ro_image_end - ro_image;
 
+	if (tlinks[BPF_TRAMP_SESSION].nr_links)
+		return -EOPNOTSUPP;
+
 	image = kvmalloc(size, GFP_KERNEL);
 	if (!image)
 		return -ENOMEM;
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index cf461d76e9da..3f25bf55b150 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2924,6 +2924,9 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
 	struct bpf_tramp_jit tjit;
 	int ret;
 
+	if (tlinks[BPF_TRAMP_SESSION].nr_links)
+		return -EOPNOTSUPP;
+
 	/* Compute offsets, check whether the code fits. */
 	memset(&tjit, 0, sizeof(tjit));
 	ret = __arch_prepare_bpf_trampoline(im, &tjit, m, flags,
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index d4c93d9e73e4..389c3a96e2b8 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3478,6 +3478,9 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 	int ret;
 	u32 size = image_end - image;
 
+	if (tlinks[BPF_TRAMP_SESSION].nr_links)
+		return -EOPNOTSUPP;
+
 	/* rw_image doesn't need to be in module memory range, so we can
 	 * use kvmalloc.
 	 */
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 204f9c759a41..3f6cad5df2db 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1270,6 +1270,7 @@ enum bpf_tramp_prog_type {
 	BPF_TRAMP_FENTRY,
 	BPF_TRAMP_FEXIT,
 	BPF_TRAMP_MODIFY_RETURN,
+	BPF_TRAMP_SESSION,
 	BPF_TRAMP_MAX,
 	BPF_TRAMP_REPLACE, /* more than MAX */
 };
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 6829936d33f5..79ba3023e8be 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1133,6 +1133,7 @@ enum bpf_attach_type {
 	BPF_NETKIT_PEER,
 	BPF_TRACE_KPROBE_SESSION,
 	BPF_TRACE_UPROBE_SESSION,
+	BPF_TRACE_SESSION,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0de8fc8a0e0b..2c1c3e0caff8 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6107,6 +6107,7 @@ static int btf_validate_prog_ctx_type(struct bpf_verifier_log *log, const struct
 		case BPF_TRACE_FENTRY:
 		case BPF_TRACE_FEXIT:
 		case BPF_MODIFY_RETURN:
+		case BPF_TRACE_SESSION:
 			/* allow u64* as ctx */
 			if (btf_is_int(t) && t->size == 8)
 				return 0;
@@ -6704,6 +6705,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			fallthrough;
 		case BPF_LSM_CGROUP:
 		case BPF_TRACE_FEXIT:
+		case BPF_TRACE_SESSION:
 			/* When LSM programs are attached to void LSM hooks
 			 * they use FEXIT trampolines and when attached to
 			 * int LSM hooks, they use MODIFY_RETURN trampolines.
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8a129746bd6c..cb483701fe39 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3564,6 +3564,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	case BPF_PROG_TYPE_TRACING:
 		if (prog->expected_attach_type != BPF_TRACE_FENTRY &&
 		    prog->expected_attach_type != BPF_TRACE_FEXIT &&
+		    prog->expected_attach_type != BPF_TRACE_SESSION &&
 		    prog->expected_attach_type != BPF_MODIFY_RETURN) {
 			err = -EINVAL;
 			goto out_put_prog;
@@ -4337,6 +4338,7 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
 	case BPF_TRACE_RAW_TP:
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+	case BPF_TRACE_SESSION:
 	case BPF_MODIFY_RETURN:
 		return BPF_PROG_TYPE_TRACING;
 	case BPF_LSM_MAC:
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 5949095e51c3..f6d4dea3461e 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -111,7 +111,7 @@ bool bpf_prog_has_trampoline(const struct bpf_prog *prog)
 
 	return (ptype == BPF_PROG_TYPE_TRACING &&
 		(eatype == BPF_TRACE_FENTRY || eatype == BPF_TRACE_FEXIT ||
-		 eatype == BPF_MODIFY_RETURN)) ||
+		 eatype == BPF_MODIFY_RETURN || eatype == BPF_TRACE_SESSION)) ||
 		(ptype == BPF_PROG_TYPE_LSM && eatype == BPF_LSM_MAC);
 }
 
@@ -418,6 +418,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	tr->flags &= (BPF_TRAMP_F_SHARE_IPMODIFY | BPF_TRAMP_F_TAIL_CALL_CTX);
 
 	if (tlinks[BPF_TRAMP_FEXIT].nr_links ||
+	    tlinks[BPF_TRAMP_SESSION].nr_links ||
 	    tlinks[BPF_TRAMP_MODIFY_RETURN].nr_links) {
 		/* NOTE: BPF_TRAMP_F_RESTORE_REGS and BPF_TRAMP_F_SKIP_FRAME
 		 * should not be set together.
@@ -515,6 +516,8 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
 		return BPF_TRAMP_MODIFY_RETURN;
 	case BPF_TRACE_FEXIT:
 		return BPF_TRAMP_FEXIT;
+	case BPF_TRACE_SESSION:
+		return BPF_TRAMP_SESSION;
 	case BPF_LSM_MAC:
 		if (!prog->aux->attach_func_proto->type)
 			/* The function returns void, we cannot modify its
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9b4f6920f79b..3ffdf2143f16 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17281,6 +17281,7 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 			break;
 		case BPF_TRACE_RAW_TP:
 		case BPF_MODIFY_RETURN:
+		case BPF_TRACE_SESSION:
 			return 0;
 		case BPF_TRACE_ITER:
 			break;
@@ -22736,6 +22737,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		if (prog_type == BPF_PROG_TYPE_TRACING &&
 		    insn->imm == BPF_FUNC_get_func_ret) {
 			if (eatype == BPF_TRACE_FEXIT ||
+			    eatype == BPF_TRACE_SESSION ||
 			    eatype == BPF_MODIFY_RETURN) {
 				/* Load nr_args from ctx - 8 */
 				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
@@ -23677,7 +23679,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 		if (tgt_prog->type == BPF_PROG_TYPE_TRACING &&
 		    prog_extension &&
 		    (tgt_prog->expected_attach_type == BPF_TRACE_FENTRY ||
-		     tgt_prog->expected_attach_type == BPF_TRACE_FEXIT)) {
+		     tgt_prog->expected_attach_type == BPF_TRACE_FEXIT ||
+		     tgt_prog->expected_attach_type == BPF_TRACE_SESSION)) {
 			/* Program extensions can extend all program types
 			 * except fentry/fexit. The reason is the following.
 			 * The fentry/fexit programs are used for performance
@@ -23692,7 +23695,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			 * beyond reasonable stack size. Hence extending fentry
 			 * is not allowed.
 			 */
-			bpf_log(log, "Cannot extend fentry/fexit\n");
+			bpf_log(log, "Cannot extend fentry/fexit/session\n");
 			return -EINVAL;
 		}
 	} else {
@@ -23776,6 +23779,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 	case BPF_LSM_CGROUP:
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+	case BPF_TRACE_SESSION:
 		if (!btf_type_is_func(t)) {
 			bpf_log(log, "attach_btf_id %u is not a function\n",
 				btf_id);
@@ -23942,6 +23946,7 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 		case BPF_TRACE_FEXIT:
 		case BPF_MODIFY_RETURN:
 		case BPF_TRACE_ITER:
+		case BPF_TRACE_SESSION:
 			return true;
 		default:
 			return false;
@@ -24023,9 +24028,10 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 			tgt_info.tgt_name);
 		return -EINVAL;
 	} else if ((prog->expected_attach_type == BPF_TRACE_FEXIT ||
+		   prog->expected_attach_type == BPF_TRACE_SESSION ||
 		   prog->expected_attach_type == BPF_MODIFY_RETURN) &&
 		   btf_id_set_contains(&noreturn_deny, btf_id)) {
-		verbose(env, "Attaching fexit/fmod_ret to __noreturn function '%s' is rejected.\n",
+		verbose(env, "Attaching fexit/session/fmod_ret to __noreturn function '%s' is rejected.\n",
 			tgt_info.tgt_name);
 		return -EINVAL;
 	}
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 73d5f0d9f5f4..f7f0fd5383c4 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -685,6 +685,7 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
 	switch (prog->expected_attach_type) {
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+	case BPF_TRACE_SESSION:
 		if (bpf_fentry_test1(1) != 2 ||
 		    bpf_fentry_test2(2, 3) != 5 ||
 		    bpf_fentry_test3(4, 5, 6) != 15 ||
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index d3fbaf89a698..8da8834aa134 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -365,6 +365,7 @@ static bool bpf_sk_storage_tracing_allowed(const struct bpf_prog *prog)
 		return true;
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+	case BPF_TRACE_SESSION:
 		return !!strncmp(prog->aux->attach_func_name, "bpf_sk_storage",
 				 strlen("bpf_sk_storage"));
 	default:
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 6829936d33f5..79ba3023e8be 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1133,6 +1133,7 @@ enum bpf_attach_type {
 	BPF_NETKIT_PEER,
 	BPF_TRACE_KPROBE_SESSION,
 	BPF_TRACE_UPROBE_SESSION,
+	BPF_TRACE_SESSION,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
index 10e231965589..58b02552507d 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
@@ -73,7 +73,7 @@ static void test_tracing_deny(void)
 static void test_fexit_noreturns(void)
 {
 	test_tracing_fail_prog("fexit_noreturns",
-			       "Attaching fexit/fmod_ret to __noreturn function 'do_exit' is rejected.");
+			       "Attaching fexit/session/fmod_ret to __noreturn function 'do_exit' is rejected.");
 }
 
 void test_tracing_failure(void)
-- 
2.51.1.dirty



Return-Path: <bpf+bounces-71278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5D6BED13B
	for <lists+bpf@lfdr.de>; Sat, 18 Oct 2025 16:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A933BF023
	for <lists+bpf@lfdr.de>; Sat, 18 Oct 2025 14:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356CF288C2B;
	Sat, 18 Oct 2025 14:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtyLwIdN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F042868A6
	for <bpf@vger.kernel.org>; Sat, 18 Oct 2025 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760797304; cv=none; b=hd5PmIgS1QFUs0/diOE68SYsJTn+kQO0RdJ5U12IbuMNQhD3BGlpFDq2/kePzbevOLepUaWyGtp5tO+G5q/BZM8QB/i9FbT0/Gvyptp6JvbFie3kjAlYD2Rf/CYL5CmBP66loLfbim+RkY49Ks5SZfROAsGUTUk2pPOd650S6R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760797304; c=relaxed/simple;
	bh=j4FoV6+5qJQDy+qnJ1ZhU8GvU8qSxrOVwW4PgSBB4+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BVDFQO+rJvYraBtWT+u8NtSWIe4tPTnBuwDClQLK9Se8b8hLCmGQENWCj7S0jy59c4oO06SHfgmxf9nfKupwaX7/uzaL9oJUAjcHcMib2/WMhf+Yp9VmUxkdulTajOxhaXu1/1s6mUzuM2Ak9eBk/9VwFDdKXjlfD1eRDwImNKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtyLwIdN; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-781251eec51so2414260b3a.3
        for <bpf@vger.kernel.org>; Sat, 18 Oct 2025 07:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760797302; x=1761402102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFo/rBG24KK8EblRFPIaZrGm9X7amIHu1zrb5RTdJ5g=;
        b=dtyLwIdN9U8nVF4z0tGhCtvJrdRRQZe1n/uuiWlDVIhFY8hT8Jj/FSnq39tddB614X
         jI+DwfzT9IR4OUDgB2/DvPQ/mqzf8Uu3ObBxbYxzxb/2u9zPUv1rNySxBbBOcy2l4r9/
         FCAhqyR88Rii3AZw+T3haaxagm6ur6gzhNimE9/K1jfOsg1vsGh7WNkwZC/IwQy8TwQt
         aoryyCjzdB+0Vp1wYS6ElfS2toupfy41GPOnnPpgn1vLGQIpuYOjNVZNJr/6/TEEbFNp
         2zeyRpoZUL09c1li2npLP+s8vYAQF+wTg6xUunohbG6uah8xOwCWSlMGNpHRhR1VU7km
         tQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760797302; x=1761402102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KFo/rBG24KK8EblRFPIaZrGm9X7amIHu1zrb5RTdJ5g=;
        b=mPbtdTeslT6bw4ImmBx6AZefgUk6fkRZ0/PhUU9SbKMxuNDck0uBnNNWTvIKHCN4GE
         xL9XUu0lV5Gn3HFTOehU18M0ITN9ImyM3j7L7n80OND7AuMG/UfLOob/k/K1SJAcSw7v
         xDHsBybtZS7S3yNseWZBA3EWTuT3lNnEMT1RdgzcCHh9rWq9nUr+J0z7mJry/0oCHiF3
         ol7chlvxT1VbaDuvE0Nreg/ctT3l9Srfil1F+swRx2FT84Hu0oqBXkLG/RK0oxeXAn5c
         OFq0C2D/KJWnYP80+nSuqgLaKsgCFj6+/W17ap6W/QuQdCVoWma8GEG7wlKFCUbwmoKl
         eeLg==
X-Forwarded-Encrypted: i=1; AJvYcCXdw3kIwtvfhTqCT4vzwrRvd36VXhFzUoqpd8aUK7eo/cDPDFGY1Rd4ASeTShboNYaEMR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGJQtXHn0sXe4Btf0zyDYcZxWtWSo7koQQS5GGBGoqhrw1oLHl
	wzfHyi9qnA8AMPtMiKOkvkizarOQPWoEA8TQ8JxXetadM+r6yq9oLfdv
X-Gm-Gg: ASbGncu0tzTzDJ4X2WZp4tI0oDXhaP143qEPLdR/vWnvUoy6zFYKJbnBSpQJqiURkNA
	f25zOmY2mXgaIHywhl7f3eJZ/dlyVFPlAjFenuyWF8mWZ/jRUFiCeh5Zmts80Yw2YI/5DImtdfh
	enhmkwDbrdlFScI8iVqw+/IpafMYgk32qsxbZqZOtvnz0VWAjxEX7GyjiHeqnMLGEm/vNQthDmU
	irZf67Ora3zj6VnSDygPZUbfoM3jeQvELbkIAsWLY/XFk7v2ojLlzMeuKL6lu92k5jF9FXa2YW7
	rh170WVd+XZymFmNeMaIEOkPdYt7m9pcvNHxoQsIxqOWVbnMgkpEGWVIIFhgvT1diPxMgK76TML
	VyJz6HV32sUyKE0jTU0BfBCdI+Gv5Zd5LkUKLCuwW1K3yeVAIU4P0t7bOjI6HUBxpqNsIOp3uA3
	c/Or9aKYe4jPk=
X-Google-Smtp-Source: AGHT+IFRhX3XY3uOEHTyrIWY0QhaxXyizShmzTfEyYUzW7jXb7ZaXfHCLMSHap1oXfphklzQDRm5Ig==
X-Received: by 2002:a05:6a00:4602:b0:77f:324a:6037 with SMTP id d2e1a72fcca58-7a220a59102mr7392649b3a.7.1760797302078;
        Sat, 18 Oct 2025 07:21:42 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010d818sm2913589b3a.53.2025.10.18.07.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 07:21:41 -0700 (PDT)
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
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH RFC bpf-next 1/5] bpf: add tracing session support
Date: Sat, 18 Oct 2025 22:21:20 +0800
Message-ID: <20251018142124.783206-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018142124.783206-1-dongml2@chinatelecom.cn>
References: <20251018142124.783206-1-dongml2@chinatelecom.cn>
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
 arch/arm64/net/bpf_jit_comp.c   |  3 +++
 arch/loongarch/net/bpf_jit.c    |  3 +++
 arch/powerpc/net/bpf_jit_comp.c |  3 +++
 arch/riscv/net/bpf_jit_comp64.c |  3 +++
 arch/s390/net/bpf_jit_comp.c    |  3 +++
 include/linux/bpf.h             |  1 +
 include/uapi/linux/bpf.h        |  1 +
 kernel/bpf/btf.c                |  2 ++
 kernel/bpf/syscall.c            |  2 ++
 kernel/bpf/trampoline.c         |  5 ++++-
 kernel/bpf/verifier.c           | 12 +++++++++---
 net/bpf/test_run.c              |  1 +
 net/core/bpf_sk_storage.c       |  1 +
 tools/include/uapi/linux/bpf.h  |  1 +
 14 files changed, 37 insertions(+), 4 deletions(-)

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
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 86afd9ac6848..aa9f02b56edd 100644
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
index 2a9456a3e730..15ce86b19ca4 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3549,6 +3549,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	case BPF_PROG_TYPE_TRACING:
 		if (prog->expected_attach_type != BPF_TRACE_FENTRY &&
 		    prog->expected_attach_type != BPF_TRACE_FEXIT &&
+		    prog->expected_attach_type != BPF_TRACE_SESSION &&
 		    prog->expected_attach_type != BPF_MODIFY_RETURN) {
 			err = -EINVAL;
 			goto out_put_prog;
@@ -4322,6 +4323,7 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
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
index c908015b2d34..40e3274e8bc2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17272,6 +17272,7 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 			break;
 		case BPF_TRACE_RAW_TP:
 		case BPF_MODIFY_RETURN:
+		case BPF_TRACE_SESSION:
 			return 0;
 		case BPF_TRACE_ITER:
 			break;
@@ -22727,6 +22728,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		if (prog_type == BPF_PROG_TYPE_TRACING &&
 		    insn->imm == BPF_FUNC_get_func_ret) {
 			if (eatype == BPF_TRACE_FEXIT ||
+			    eatype == BPF_TRACE_SESSION ||
 			    eatype == BPF_MODIFY_RETURN) {
 				/* Load nr_args from ctx - 8 */
 				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
@@ -23668,7 +23670,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 		if (tgt_prog->type == BPF_PROG_TYPE_TRACING &&
 		    prog_extension &&
 		    (tgt_prog->expected_attach_type == BPF_TRACE_FENTRY ||
-		     tgt_prog->expected_attach_type == BPF_TRACE_FEXIT)) {
+		     tgt_prog->expected_attach_type == BPF_TRACE_FEXIT ||
+		     tgt_prog->expected_attach_type == BPF_TRACE_SESSION)) {
 			/* Program extensions can extend all program types
 			 * except fentry/fexit. The reason is the following.
 			 * The fentry/fexit programs are used for performance
@@ -23683,7 +23686,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			 * beyond reasonable stack size. Hence extending fentry
 			 * is not allowed.
 			 */
-			bpf_log(log, "Cannot extend fentry/fexit\n");
+			bpf_log(log, "Cannot extend fentry/fexit/session\n");
 			return -EINVAL;
 		}
 	} else {
@@ -23767,6 +23770,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 	case BPF_LSM_CGROUP:
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+	case BPF_TRACE_SESSION:
 		if (!btf_type_is_func(t)) {
 			bpf_log(log, "attach_btf_id %u is not a function\n",
 				btf_id);
@@ -23933,6 +23937,7 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 		case BPF_TRACE_FEXIT:
 		case BPF_MODIFY_RETURN:
 		case BPF_TRACE_ITER:
+		case BPF_TRACE_SESSION:
 			return true;
 		default:
 			return false;
@@ -24014,9 +24019,10 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
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
index 05e30ff5b6f9..aa2b5b17a7c7 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -696,6 +696,7 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
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
 
-- 
2.51.0



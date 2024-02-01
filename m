Return-Path: <bpf+bounces-20898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7962845028
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 05:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBE211C22EE1
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 04:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B2E3C08E;
	Thu,  1 Feb 2024 04:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vi9cBRVK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352D01EF15
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 04:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706761289; cv=none; b=EjSGrntQFJXF7euEaDsIWRlx+2bHKdYJpm2vgtHMFWGvACpxbQZWgJeJ1OBdOVaPnvRsNCvXlKKoxQRSQOU5e9gH+F9KuaPhRclTg5GZUQtI7jPRH3XXVyjHq3YDShvvh+53k3ZEKKhvXB6gi930vQ7u0djMc2Avuls4FJh4JK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706761289; c=relaxed/simple;
	bh=CXqh0gEVtnrZu0eS4CU8N1pndmxwXNh+IddwyXYewsc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tFxAtoZN2IiRrQqGKrkXXXVCs+FNka3W8dedX3NcCaXwU3Q3p6tv8LhhS7QA3JmSrbRDnw3P6elxpT3vkiu2VzHXXPUUmiQ3XzPpioAdrkP6rouXyrsRsgB8GAqP3XyYvt1ImHSIkkmmjq3MBpT6eQJQQcCJ+UMksA45Z/k+NNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vi9cBRVK; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-5111c7d40deso763483e87.1
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 20:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706761285; x=1707366085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzuiAPjE4eXQhj+Wjpkpb2ptqxxi7MZnbXgTNeQLKsM=;
        b=Vi9cBRVKYeUWYuY9WZNt8unEXz3iEtvMVoMv3o8Je+RxueqoQFdV60CU+JiNFMoF5a
         Q+AEw1rPNJDu//+hRzuJ6EkjCQpqb5EOpnwiVMEvPmzt3Hg4dm4UKqi8p0U8VWor8uUn
         DOQ2U+sjAv/E/shIj2s8b3/Q4GAkFWu+VKQZQpTOtPwZx2asjdgFJOT4BCCnrW/frknN
         H5xdBG3FIuGbxJg0QtfJpSLoT5gi9bAgxJFqnDIxm/edfSFTuYH4TJ7xa14Zel9mGq90
         S9g90n3PySqsBg2+mYejfl8J6I8jdi74nseiVpvjbWiQg5+zC/UBVAoQVf5enwrFPhZn
         HxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706761285; x=1707366085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NzuiAPjE4eXQhj+Wjpkpb2ptqxxi7MZnbXgTNeQLKsM=;
        b=tAwoSSoU01xYdyJBl8NP2HkHIBq8uTS7tOGkCwCYP2mS3BlwEJLB2yBdC2Lhc3WJU3
         KNzXDInLUw4phIx7GY9q1Ho4+36p+B39GCvV4A1hUxb4WKVWrBUEHv/8rpzfyazEIkpU
         4mwSvvJvOBWIHcZx+VvqIk55S2bDLx+xDrBrPr/93TA7HPbgr5QQG/rmJXisvTDgWivq
         /QUGtGovPzxF9g2ASIA2dwkOexr/DXxC+EDYFIrgaPtxk/gTpjLc9fy+7RTyhH55eKeM
         OAwYi1U7XTAQ2zKTWZHh2sZhiBxLI53Bq6L5KnEbfyyb6WD1XEBZiNCPj+N3evr5vKh/
         5PZA==
X-Gm-Message-State: AOJu0YzWU7eWe5ScVZSZVwl8uWm7Iq0bqB/sk7lfuB01fcUxogprruj/
	oB+MQ9IefcmPr8Yb3q1LqehaEJWeN2V/+Z/F2zGCuB9M9XlvveuYoRhTJ/5XN0g=
X-Google-Smtp-Source: AGHT+IE619EEUEIhqoOTJWExPSF+oh9lbR08Myw+g2n8auaExEUazvNbPTR2XG5X6xgzp1Wg9y+BvA==
X-Received: by 2002:ac2:485b:0:b0:511:169c:8f59 with SMTP id 27-20020ac2485b000000b00511169c8f59mr878828lfy.56.1706761284715;
        Wed, 31 Jan 2024 20:21:24 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ll9-20020a170907190900b00a3664259b81sm1436220ejc.134.2024.01.31.20.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 20:21:24 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>,
	Raj Sahu <rjsu26@vt.edu>,
	Dan Williams <djwillia@vt.edu>,
	Rishabh Iyer <rishabh.iyer@epfl.ch>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Subject: [RFC PATCH v1 09/14] bpf, x86: Fix up pc offsets for frame descriptor entries
Date: Thu,  1 Feb 2024 04:21:04 +0000
Message-Id: <20240201042109.1150490-10-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240201042109.1150490-1-memxor@gmail.com>
References: <20240201042109.1150490-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4340; i=memxor@gmail.com; h=from:subject; bh=CXqh0gEVtnrZu0eS4CU8N1pndmxwXNh+IddwyXYewsc=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBluxwP/lJs/ypdoqKR5uKdM6KC4gz0KqVZ0tX7w F26E0WlVIiJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZbscDwAKCRBM4MiGSL8R ykxXD/9Jnp+wShaVfQo2xiXK5SudSK7DqpxcezSLY2JTdVpJ1EBwdTotSf9pU3e2K6nxxh9Doky mg9H+uCGbbHtV47EH1KzemcN5KeHXAdHgDnslzPMdrlZyVXftTKv1wNIvjF4ExvGTzcqr/n0WHP WyHvtDn6iM4YNzGUbDG5kVE5fdirJab0RsBxcjFHRcPYptHGjT7rwXsRFNLAwqTKe2KLvc6MaNe q6BfvbCuVEE78raB2/IMEoBbutfjtt5cfB3rvCP8gXTw99gCIkOCy35Fy0K/4rzHOKGvvd/GP3k XVktcOnAkem160qLgXx4o4ZVoya/yB/19gWC9OxfPnt/cJ+TQeYvDwJQz6x0ii8xAhjRzYPaO8S WZbT489aX4tIuT42xvzNGOjKME8xZojJ/3WB+o8PnGkgb+O0A/hNBrFsR843Xo6o7cK0Jo3PWpa 7DyBds+XAOr5jdJ1XTH3yDBkyXvT5cAlPO67dFlobUXm/sb0fzPxN6B+yxJYKzoBbZJoR3pbPcV FYMXKzzJc6ugAQAkGci4QsuN9uwxO1Kt/Q6fk1HSZHyIrAS7BQuIuUxsvs1ejQ356QFcMtXSSpM re2lWyW3nyBrVNoD69YQIZS1MbU23e93Vn5FAilPpS5WOO7XOlzbfICTXTrkny3AjRGhCzPU6ag Md6+RMINVEnWB9Q==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Until now, the program counter value stored in frame descriptor entries
was the instruction index of the BPF program's insn and callsites when
going down the frames in a call chain. However, at runtime, the program
counter will be the pointer to the next instruction, and thus needs to
be computed in a position independent way to tally it at runtime to find
the frame descriptor when unwinding.

To do this, we first convert the global instruction index into an
instruction index relative to the start of a subprog, and add 1 to it
(to reflect that at runtime, the program counter points to the next
instruction). Then, we modify the JIT (for now, x86) to convert them
to instruction offsets relative to the start of the JIT image, which is
the prog->bpf_func of the subprog in question at runtime.

Later, subtracting the prog->bpf_func pointer from runtime program
counter will yield the same offset, and allow us to figure out the
corresponding frame descriptor entry.

Note that we have to mark a frame descriptor entry as 'final' because
bpf_int_jit_compile can be called multiple times, and we would try to
convert our already converted pc values again, therefore once we do the
conversion remember it and do not repeat it.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 11 +++++++++++
 include/linux/bpf.h         |  2 ++
 kernel/bpf/verifier.c       | 15 +++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 87692d983ffd..0dd0791c6ee0 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3112,6 +3112,17 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		prog = orig_prog;
 	}
 
+	if (prog->aux->fdtab && !prog->aux->fdtab->final && image) {
+		struct bpf_exception_frame_desc_tab *fdtab = prog->aux->fdtab;
+
+		for (int i = 0; i < fdtab->cnt; i++) {
+			struct bpf_exception_frame_desc *desc = fdtab->desc[i];
+
+			desc->pc = addrs[desc->pc];
+		}
+		prog->aux->fdtab->final = true;
+	}
+
 	if (!image || !prog->is_func || extra_pass) {
 		if (image)
 			bpf_prog_fill_jited_linfo(prog, addrs + 1);
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4ac6add0cec8..e310d3ceb14e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1460,6 +1460,7 @@ struct bpf_prog_aux {
 	bool xdp_has_frags;
 	bool exception_cb;
 	bool exception_boundary;
+	bool bpf_throw_tramp;
 	bool callee_regs_used[4];
 	/* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
 	const struct btf_type *attach_func_proto;
@@ -3395,6 +3396,7 @@ struct bpf_exception_frame_desc {
 
 struct bpf_exception_frame_desc_tab {
 	u32 cnt;
+	bool final;
 	struct bpf_exception_frame_desc **desc;
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index aeaf97b0a749..ec9acadc9ea8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19514,6 +19514,20 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->exception_cb = env->subprog_info[i].is_exception_cb;
 		if (!i)
 			func[i]->aux->exception_boundary = env->seen_exception;
+		if (i == env->bpf_throw_tramp_subprog)
+			func[i]->aux->bpf_throw_tramp = true;
+		/* Fix up pc of fdtab entries to be relative to subprog start before JIT. */
+		if (env->subprog_info[i].fdtab) {
+			for (int k = 0; k < env->subprog_info[i].fdtab->cnt; k++) {
+				struct bpf_exception_frame_desc *desc = env->subprog_info[i].fdtab->desc[k];
+				/* Add 1 to point to the next instruction, which will be the PC at runtime. */
+				desc->pc = desc->pc - subprog_start + 1;
+			}
+		}
+		/* Transfer fdtab to subprog->aux */
+		func[i]->aux->fdtab = env->subprog_info[i].fdtab;
+		env->subprog_info[i].fdtab = NULL;
+
 		func[i] = bpf_int_jit_compile(func[i]);
 		if (!func[i]->jited) {
 			err = -ENOTSUPP;
@@ -19604,6 +19618,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	prog->aux->real_func_cnt = env->subprog_cnt;
 	prog->aux->bpf_exception_cb = (void *)func[env->exception_callback_subprog]->bpf_func;
 	prog->aux->exception_boundary = func[0]->aux->exception_boundary;
+	prog->aux->fdtab = func[0]->aux->fdtab;
 	bpf_prog_jit_attempt_done(prog);
 	return 0;
 out_free:
-- 
2.40.1



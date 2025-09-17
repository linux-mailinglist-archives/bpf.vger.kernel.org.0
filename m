Return-Path: <bpf+bounces-68613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70064B7F2FB
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 15:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80BE8527066
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 03:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6580E2F60A3;
	Wed, 17 Sep 2025 03:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9GMCQz/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBE020408A
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 03:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758079681; cv=none; b=mH3Jo3R32JQfh2Bhf4g4ahEsFJytPtCjnNdBybYjbwAG2H4cZ5kR1qMyaY/9rvFeYlgAdZKJ/0e2uz1Akm1D5VLC3sS348QfCrQtwWJ7q2Ooba9PBp8JUnzJUvG6YPI33TWJqrH7SexA6SvtePG5zpx5WCr8fsOAGy1YobyYFBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758079681; c=relaxed/simple;
	bh=xoUFrmY6q+WTy5CkAUuc9GkLm4ObtbH/Nvfq8vioJIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thD00paklUXcBj41oaKNsSBFc3NaYy8cwwJASzZx9HZq8K6AOPsEa9Su50nv2MgmRV1aISLZMEqsYIF/cfoM4QK09T6NtqH3ytpSOnrVVtIDOcARCBil+UCow/7LuLDH/q+lSNkmqepj0zgSZ0rN/B+omQrEKBovzjIkKk3rKmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9GMCQz/; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-45f29dd8490so31642615e9.1
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 20:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758079678; x=1758684478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVsURkyvAdNfYD8UfWh/3LHWgg9fbvg4dWpuIf3iSqc=;
        b=g9GMCQz/ZSe7yrtpu/ERAtIdqWSJvy9bjS5Wb1JEDCiJrxod2ah2k6/+JP3Xxm/Fpu
         /mC4YpmGL/EyBWHkaJyd/3hqiibAopXG3rB3ECBGz4+IMXNbNz96jkuAKahUBbzlZy98
         zCkr+Iz6/B8Isz8VUfAaM9ZPvHNlXyK5fSFGMhr3Imvb70g0h/bwe1/NZjrG38jZLWp3
         jlHjro8MXKGRkXBh/olQgwY+LxTr0hg2SFyIiRCDRTm//wioNEe8yI4nhBmCBEUDkN+3
         Xf8AYK5OrliZdRZ2cFNYdSSPmqstvuFqeCjVEoeHmL1d0aQJLmgmr+r8oSrDyfStxyeh
         dSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758079678; x=1758684478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVsURkyvAdNfYD8UfWh/3LHWgg9fbvg4dWpuIf3iSqc=;
        b=XyHALXwmGIx/o2pYg8VV1kp86y55TlDZh5cr1hCdTqmeVJvp9BY7IGIc2ePHzqY8UT
         ZWvm/NQ7Fd5SAfMOFODUQMdmzbzX51O9B61qRTvDmwKBSrqSNmOI+cSp2QEUaG09n+Bv
         WtYEObR9W4x9nXuR+8Uh93ru9+URdhjek/d9mJA5mUeuYtHw+Ulw3ZQf6QPbgCme7Fvx
         /LlDtBdlyOQVG4YQhvDEOH/Sg/A4TNRQBsCTf0OUJugd67QtiVOCvKYh/PRSdwmnz1d0
         i1pxa2qEvTngJDiDiRugJOzXaK4+runGcZ+5jcjbX5xIWqyF5S9iGUpBC3pJtfajR5Ah
         qK6Q==
X-Gm-Message-State: AOJu0Yxbdeei0qHqXiOlP2fQPAbSNyeani0RKXI3XrqTl9bilgkHeF0C
	rFkfsO8BsPG29+iIIhV3wWaF5Z4uYRql7gTsXVjlrGtR6MN1oi5GSZMqAIPsvzyE
X-Gm-Gg: ASbGnctr4BKqeC6HiF5EEWghC6bX/qrhSaHyeDJOYz/BAfEBmPRSvbieXmPbZTCcpLd
	XwdGDlkoZXipq261LYvu4qT+AfcMaTBmN99Z2d7O0iAKqv1mK1rj5lMvB98BxFDxdwz7oc9OWuQ
	EaY7Xt/+pAiQRLKnDjsNQ3MN5Jne8pgoup7DVq86ezthXQ3aU/IgU6D0lgSKzCg67eppn6CMZ3V
	T2sC/sA+P50FqPPMaG4zIDqdBn3GluMy7oc7DfvKyzeWAMAxbLvIdQxVQ/5XNg/TL12T1dkAgtn
	AyhUANqe/Gnzq7ngWDnrO0YmhI/Ezpt1A0CXzYAr69F5vsqjg+TkRLgsu/hRkn+Dlit5YkQNmk9
	dKtLR65aXpBMEciiQsQFdhQjcv36/6sWP+AfADBiHGKo6
X-Google-Smtp-Source: AGHT+IF9q8mkAhgfFHEM4p3ZMvQ2ByhkTkJKakblqIV/sH5EmPN8CRj3wNCE5M9nt21W/x+zfoX78Q==
X-Received: by 2002:a05:600c:314b:b0:459:d3ce:2cbd with SMTP id 5b1f17b1804b1-46202bf8474mr3175155e9.13.1758079677980;
        Tue, 16 Sep 2025 20:27:57 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3e7607cd4cdsm24224578f8f.37.2025.09.16.20.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 20:27:57 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrea Righi <arighi@nvidia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 1/2] bpf: Enforce RCU protection for KF_RCU_PROTECTED
Date: Wed, 17 Sep 2025 03:27:54 +0000
Message-ID: <20250917032755.4068726-2-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917032755.4068726-1-memxor@gmail.com>
References: <20250917032755.4068726-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6239; i=memxor@gmail.com; h=from:subject; bh=xoUFrmY6q+WTy5CkAUuc9GkLm4ObtbH/Nvfq8vioJIc=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBoyiqtwmCMAS/6uUOsF0RxfF2om+8rzlvGl3oxh Vc9PgWZDWSJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaMoqrQAKCRBM4MiGSL8R ysilEADBZYFUpYSOvR8LnRSRGhlGhxEKEWn/sNlkmiPBiTlyWYIRDj0JgzpDCZRorYmPaI9AF3F MNo2IcGMaY+Ew+qQtgWxUsx2g10JOz71zI+aiW96WqHBztvGSRSxgDfMuU/Cp8aVw3fGugHb2T1 JabuJY9bwn8MMPdILZUPMiSYf8PfgJqYeemC5Hc1aIHY3+J+F34rh6hunl53Eq0CbEyv8/ah3Fl BdITA690c+FTDKrWbQijPFgIY4PoNNl46QBt5Gia6JmZBQ/bfgNJonwTyGtrIQy/eL7CDAQtlPh n6URkAVcBR5NbBXr76pajdVmSYR1PCDcFuipR6yFVYscIFRV39AWl3zMvkXNCJjlc10OPPmnK02 DdrIgdmdwf6yHAT8g35755MNm3RfGm2tY0PuOjXrTdIHdPOO7ilaAHiXoeqCq2dgw9JYepqbf6c 9dEkQIVUoYVr1FNRCMKBzlv6NO8BwMYuN0y2bQWXAz/1A2lNNIgMhSFreq3wWrj56uDKnjgpCMH AxobZoVXeNdKUb5JQSEy8dT41X6TTVRV8cr624fKOhbxdptDsxedSP7SCjAw4qv1PJB8vJMlnku 20dRsgWkeO6md0tVVzjpNPKnQ1gjZ1J9ZpugmGChuUFXDQDM0EQSjQhVG2KxUiKAIIpgGTzloVP Vbpo400yhLO5u2w==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Currently, KF_RCU_PROTECTED only applies to iterator APIs and that too
in a convoluted fashion: the presence of this flag on the kfunc is used
to set MEM_RCU in iterator type, and the lack of RCU protection results
in an error only later, once next() or destroy() methods are invoked on
the iterator. While there is no bug, this is certainly a bit
unintuitive, and makes the enforcement of the flag iterator specific.

In the interest of making this flag useful for other upcoming kfuncs,
e.g. scx_bpf_cpu_curr() [0][1], add enforcement for invoking the kfunc
in an RCU critical section in general.

This would also mean that iterator APIs using KF_RCU_PROTECTED will
error out earlier, instead of throwing an error for lack of RCU CS
protection when next() or destroy() methods are invoked.

In addition to this, if the kfuncs tagged KF_RCU_PROTECTED return a
pointer value, ensure that this pointer value is only usable in an RCU
critical section. There might be edge cases where the return value is
special and doesn't need to imply MEM_RCU semantics, but in general, the
assumption should hold for the majority of kfuncs, and we can revisit
things if necessary later.

  [0]: https://lore.kernel.org/all/20250903212311.369697-3-christian.loehle@arm.com
  [1]: https://lore.kernel.org/all/20250909195709.92669-1-arighi@nvidia.com

Tested-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 Documentation/bpf/kfuncs.rst                  | 19 ++++++++++++++++++-
 kernel/bpf/verifier.c                         | 10 ++++++++++
 .../selftests/bpf/progs/cgroup_read_xattr.c   |  2 +-
 .../selftests/bpf/progs/iters_task_failure.c  |  4 ++--
 4 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index ae468b781d31..e38941370b90 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -335,9 +335,26 @@ consider doing refcnt != 0 check, especially when returning a KF_ACQUIRE
 pointer. Note as well that a KF_ACQUIRE kfunc that is KF_RCU should very likely
 also be KF_RET_NULL.
 
+2.4.8 KF_RCU_PROTECTED flag
+---------------------------
+
+The KF_RCU_PROTECTED flag is used to indicate that the kfunc must be invoked in
+an RCU critical section. This is assumed by default in non-sleepable programs,
+and must be explicitly ensured by calling ``bpf_rcu_read_lock`` for sleepable
+ones.
+
+If the kfunc returns a pointer value, this flag also enforces that the returned
+pointer is RCU protected, and can only be used while the RCU critical section is
+active.
+
+The flag is distinct from the ``KF_RCU`` flag, which only ensures that its
+arguments are at least RCU protected pointers. This may transitively imply that
+RCU protection is ensured, but it does not work in cases of kfuncs which require
+RCU protection but do not take RCU protected arguments.
+
 .. _KF_deprecated_flag:
 
-2.4.8 KF_DEPRECATED flag
+2.4.9 KF_DEPRECATED flag
 ------------------------
 
 The KF_DEPRECATED flag is used for kfuncs which are scheduled to be
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1029380f84db..5f9ee5bbd0ff 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13916,6 +13916,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return -EACCES;
 	}
 
+	if (is_kfunc_rcu_protected(&meta) && !in_rcu_cs(env)) {
+		verbose(env, "kernel func %s requires RCU critical section protection\n", func_name);
+		return -EACCES;
+	}
+
 	/* In case of release function, we get register number of refcounted
 	 * PTR_TO_BTF_ID in bpf_kfunc_arg_meta, do the release now.
 	 */
@@ -14029,6 +14034,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			/* Ensures we don't access the memory after a release_reference() */
 			if (meta.ref_obj_id)
 				regs[BPF_REG_0].ref_obj_id = meta.ref_obj_id;
+
+			if (is_kfunc_rcu_protected(&meta))
+				regs[BPF_REG_0].type |= MEM_RCU;
 		} else {
 			mark_reg_known_zero(env, regs, BPF_REG_0);
 			regs[BPF_REG_0].btf = desc_btf;
@@ -14037,6 +14045,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 			if (meta.func_id == special_kfunc_list[KF_bpf_get_kmem_cache])
 				regs[BPF_REG_0].type |= PTR_UNTRUSTED;
+			else if (is_kfunc_rcu_protected(&meta))
+				regs[BPF_REG_0].type |= MEM_RCU;
 
 			if (is_iter_next_kfunc(&meta)) {
 				struct bpf_reg_state *cur_iter;
diff --git a/tools/testing/selftests/bpf/progs/cgroup_read_xattr.c b/tools/testing/selftests/bpf/progs/cgroup_read_xattr.c
index 092db1d0435e..88e13e17ec9e 100644
--- a/tools/testing/selftests/bpf/progs/cgroup_read_xattr.c
+++ b/tools/testing/selftests/bpf/progs/cgroup_read_xattr.c
@@ -73,7 +73,7 @@ int BPF_PROG(use_css_iter_non_sleepable)
 }
 
 SEC("lsm.s/socket_connect")
-__failure __msg("expected an RCU CS")
+__failure __msg("kernel func bpf_iter_css_new requires RCU critical section protection")
 int BPF_PROG(use_css_iter_sleepable_missing_rcu_lock)
 {
 	u64 cgrp_id = bpf_get_current_cgroup_id();
diff --git a/tools/testing/selftests/bpf/progs/iters_task_failure.c b/tools/testing/selftests/bpf/progs/iters_task_failure.c
index 6b1588d70652..fe3663dedbe1 100644
--- a/tools/testing/selftests/bpf/progs/iters_task_failure.c
+++ b/tools/testing/selftests/bpf/progs/iters_task_failure.c
@@ -15,7 +15,7 @@ void bpf_rcu_read_lock(void) __ksym;
 void bpf_rcu_read_unlock(void) __ksym;
 
 SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
-__failure __msg("expected an RCU CS when using bpf_iter_task_next")
+__failure __msg("kernel func bpf_iter_task_new requires RCU critical section protection")
 int BPF_PROG(iter_tasks_without_lock)
 {
 	struct task_struct *pos;
@@ -27,7 +27,7 @@ int BPF_PROG(iter_tasks_without_lock)
 }
 
 SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
-__failure __msg("expected an RCU CS when using bpf_iter_css_next")
+__failure __msg("kernel func bpf_iter_css_new requires RCU critical section protection")
 int BPF_PROG(iter_css_without_lock)
 {
 	u64 cg_id = bpf_get_current_cgroup_id();
-- 
2.51.0



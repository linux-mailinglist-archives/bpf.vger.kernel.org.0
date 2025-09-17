Return-Path: <bpf+bounces-68610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1035DB7E67A
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04D313257C1
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 03:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B4F29293D;
	Wed, 17 Sep 2025 03:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cm/ObdsB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C748199385
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 03:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758079221; cv=none; b=HDGWlqjX7AgXZcSVscID8gv17onTsOLzxoajDYLVToOeo9tKoif+ZN2xv9Q04zEAbheoCWS54NW+ZINrOHaaOv8WlWT/DjTBFY5cJc9gv6EBydLXifAASHQ+PBdgzmqm3qfAiOEV+MkDA7EU91R5kXufsLNZ7E10ccTJcQMlhDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758079221; c=relaxed/simple;
	bh=QkpnbbH4gkhcEk+SsNtCTFpJZuB6ECuHPqdeJ5akfaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLwBkbjaTJ6KmLAE37I0IyRAnVSgZTVXQ7L2WmvIYMDxpGcZK0PyhBTdgxkKvTNVhG3MU+E5MXSS662Rn8h7ySpq/6ZfD2jmcSqc/F8oxjyy5X0X3PV4tkPsi/JuN7OGxU5p+RNcVkFbUwkgs4JbEASRUP75pAJRPe1qUzW6/WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cm/ObdsB; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-45ed646b656so52817715e9.3
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 20:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758079218; x=1758684018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bOsoYfE4HpkQ9MoPVWW+zV9/Fyc06X0mVoQBtFsUxk=;
        b=cm/ObdsB48p94k32zZUKMIXjOTAslUTrE8Db3zI57X2u8upSW45XxFai/w9XujqVaZ
         dvvlIYvbQy+sh6K2aPME/phQIeBFxPEa17d0Xm+hNF+LDks3QQIVPhzpXVu3IxI+OgJp
         mXJ57/C3E05feuZdpZYcNs9T2X76xzKg/RFtKaSqHi2zU3rhe8Mtd0tsxfmK/Wu0wowQ
         z7IOzl8CTH3WjDN2NmjF38r8eDFGeMbec8uuP7fVZuK4/ITJ1TXfysm/SFacSCWqXGAg
         LzAdgeZBXUjxbdp39jmlLnSSl4RWa7SNRNRaPtsRJxFYjKwl+DzLeOMfjhJ7+h7UdeT1
         sLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758079218; x=1758684018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bOsoYfE4HpkQ9MoPVWW+zV9/Fyc06X0mVoQBtFsUxk=;
        b=gPk2e0eRycLwbAJb9uKftiIbTFmQpXfLXgwfEkJmhAmiKQNLcbcxORVtzsYT55YvCJ
         LvaZNjVa+0VW4w8ZTD9ZC0htIT85Def8rL5iTqMfD9cGixRCacH0oMZ9gGmFx9dRQG7y
         f2OFlj/Ix3FH8OCgj5cMshjEdX/7G6PG3t2DmPxGp9RlQt4xVZsMAQqCShegeQN90T4R
         mTRigd5sZHlVYEJ4ReB2+ukv97zDkIAhPEhS5jQAZbBUUn6ka8MqnYC696aWnbFVDd3d
         ImW9qMUK2xrzdEGqRdwKvydXHKpeSEN/zFYiQcbvLToS2zDeXY3aM44Ir86PsH67+nfM
         WfXw==
X-Gm-Message-State: AOJu0YzbarC1nrbTtPzTTRHZvhLmGon4FpfQLH4RVLa80BRuGD/yR3C+
	jRFKGq5J/zVmxNSIVZbZp9ShujgAi+i9fgCLu8btj4jscUEHeoJMsDYZfGuOdyex
X-Gm-Gg: ASbGncv6qvJvu6nRgZAd3ZvGQUO2a8nRRh/B1uZFBZSrkYEjr8mFpymhQxJPFf4CKhZ
	yp3aRaOJLW+oraT04hzJFimpQwHIR1ZaaUCUigMHTSe2RHMqbHchee3ueFioQNyxKTGrb3yMuhz
	L/o7ONrxJc4iuRZwaLThIqKNQw2zJFIAQMcK+l6neU5et5auHexwTP3SZgs6uxlFPu2Aw2NcJOf
	5x7G23oRHbc2sqVAZGJo1NOcemlXbKPnrz0OfyjTAtEH7x4RuY/RDjumMeUvID6ZPkIGk9E1F7G
	SYRmMYeskJ1iOt7nOnYyuaI+/Z60yawfm31ONnPa5a1dwnV7GYZSlJU9WYctGflCdX+OYNxIF/z
	hkdiOjE2AdxmOYnbM+1YjDRtxy/gWDGsXXSMj7IoSIFDs
X-Google-Smtp-Source: AGHT+IGDPyoFN8/yMM+Y9iYBelfj73EXNLos1Nh1duWY6fTP4x0Dr3z6EIjM1mLmG0XX2iEqYxGa5g==
X-Received: by 2002:a05:6000:4011:b0:3e8:b4cb:c3dc with SMTP id ffacd0b85a97d-3ecdf9b1598mr489011f8f.3.1758079217696;
        Tue, 16 Sep 2025 20:20:17 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3e7607cd6absm24364280f8f.34.2025.09.16.20.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 20:20:17 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 1/2] bpf: Enforce RCU protection for KF_RCU_PROTECTED
Date: Wed, 17 Sep 2025 03:20:13 +0000
Message-ID: <20250917032014.4060112-2-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917032014.4060112-1-memxor@gmail.com>
References: <20250917032014.4060112-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6074; i=memxor@gmail.com; h=from:subject; bh=QkpnbbH4gkhcEk+SsNtCTFpJZuB6ECuHPqdeJ5akfaA=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBoyiieL721BpvUM2tlDnkf4FcbvV5LIev1l9prf NUgL1qFrmOJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaMoongAKCRBM4MiGSL8R ymqzD/4jY17zsC2D5L49jrwBFGZRz2nNhArX7vl18jyrItf3VrbD8036wEztE26+ZnApaMIhBsL 5xhL5O4E+2dq4VAQpe26gRhu8+D40e57lkKdTqVFiQNoT4VPoIYMBr1rr87+tHh05pmDGn3mqfa iYkKf49DOJhXFLRMdwDq7NSogxE7KdSVXjuaLMEx3Q1ajgkcn39+JH52PE2CcJSfKGBBeGGri38 o45AhnXx8tpORdhZWDcLEUW/ORYz2sCFnZR17Y+toiC7UOGFvwp60GlngSIkY/XwN/y5O9Oi5Bq 5lh0InTD3oKttSNJmWbK3Krls7Ks7jH62/BHn+619/8eF8ZP3d4ulPiHR7pnaIzGLqdPqy82TrU /X/zqAO3URmfGAxQDDhguKuv78qavaJAu803IzyfgVy5eirX9xRPrD19jTswfy/f6VNBr/7sqDW jbjzWShTcqo1qvHZisgvMHK8Pu+3xENgVbBDY2Mupx1kHGScRMc4z9QaWnIdJOn1tDGFe5Hy5no 9R2le6pGrrz7FM3NS2v7so61O+vL/KI5zINzl9Ya0EbUSCH4Rh9qnWGhcJKA7mWrhZ15RuCG6g3 HFYxmmPd1qlsltbFmVVVmoXK2y13BOhri57mcNlpTQl8pXzV3HDNIwGUSbWfeveDXPJ8H+WNeRN k+ouk8c/Pd5tXwA==
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
 Documentation/bpf/kfuncs.rst                        | 13 ++++++++++++-
 kernel/bpf/verifier.c                               | 10 ++++++++++
 .../testing/selftests/bpf/progs/cgroup_read_xattr.c |  2 +-
 .../selftests/bpf/progs/iters_task_failure.c        |  4 ++--
 4 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index ae468b781d31..18ba1f7c26b3 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -335,9 +335,20 @@ consider doing refcnt != 0 check, especially when returning a KF_ACQUIRE
 pointer. Note as well that a KF_ACQUIRE kfunc that is KF_RCU should very likely
 also be KF_RET_NULL.
 
+2.4.8 KF_RCU_PROTECTED flag
+---------------------------
+
+The KF_RCU_PROTECTED flag is used to indicate that the kfunc must be invoked in
+an RCU critical section. This is assumed by default in non-sleepable programs,
+and must be explicitly ensured by calling ``bpf_rcu_read_lock`` for sleepable
+ones. The flag is distinct from the ``KF_RCU`` flag, which only ensures that its
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



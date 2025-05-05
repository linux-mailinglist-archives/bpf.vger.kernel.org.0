Return-Path: <bpf+bounces-57403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C5AAAA59D
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 01:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B66807ADB09
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 23:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C3D314416;
	Mon,  5 May 2025 22:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwTYpfAb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB50314407;
	Mon,  5 May 2025 22:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484241; cv=none; b=cAzJKPr2F3E8F0UwQxCtfnLeVXqMjghGiV+4Sjeysa3pzSXcWlmtumEn48fzFT5jVnV0os3HA0b6FfI+wXZ0dY8XE3FW/tvjt/TVp0Z54790JFK/+VA+MkO1ElVVFJkE+d1lCNLTfsNUlBxdqmxAHwzUmNdziNTTjV/kdrbBF/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484241; c=relaxed/simple;
	bh=kC+v/c4j7TFaDOunHRudJUgpVFOc4RqLB4Jd/KJ2/Rs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RvukP7sUcok/HCcJqmfjqrfJ1/P8IHusDe7u/8Hpk3HG+udTUJMCewH4t+/yoda/nXpaAc+xt20NW0Mx1coxmKIkEg/y0aJS28L5FqxPlf4NQ2QXCHLB+fRKVFx28QHfheh1aUmKe9JUTOkXL3OTR33+brLahqctEzx82uhNJZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwTYpfAb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A41DC4CEE4;
	Mon,  5 May 2025 22:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484241;
	bh=kC+v/c4j7TFaDOunHRudJUgpVFOc4RqLB4Jd/KJ2/Rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HwTYpfAb1IVN822ulmoIOkwlZMRCMA5rqnGK4Jy6L7rFUT696G2+MwCYATij+ma9f
	 kZ5bJ+o/OwnM9pr/SbChaoMBrhpaGN5VBGugsYE4i9UJ+ypJC14crqOf2iTwqa0cw7
	 i7ZEhIdtGx8D3Sl0ibqn5y3Js12ze4nW+Z4SzS1iiDFUzKJ6Dv8mMaPbv6FXEytdhS
	 zN5umnCiB6NJRM2j5KuPltUo2p6xzax8g9B0ZAKfIE1d62IU2LuVaCqdHeStacQQi5
	 dxuvnURI0k5IrbRVxDwtQO42Pa4P5UPoFPzCAs6nEb2h2d2E6i3QDa6DerxKJAWdVx
	 1ogi+wfEfL4vQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Amery Hung <ameryhung@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 406/642] bpf: Make every prog keep a copy of ctx_arg_info
Date: Mon,  5 May 2025 18:10:22 -0400
Message-Id: <20250505221419.2672473-406-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Amery Hung <ameryhung@gmail.com>

[ Upstream commit 432051806f614ca512da401b80257b95b2a2241e ]

Currently, ctx_arg_info is read-only in the view of the verifier since
it is shared among programs of the same attach type. Make each program
have their own copy of ctx_arg_info so that we can use it to store
program specific information.

In the next patch where we support acquiring a referenced kptr through a
struct_ops argument tagged with "__ref", ctx_arg_info->ref_obj_id will
be used to store the unique reference object id of the argument. This
avoids creating a requirement in the verifier that "__ref" tagged
arguments must be the first set of references acquired [0].

[0] https://lore.kernel.org/bpf/20241220195619.2022866-2-amery.hung@gmail.com/

Signed-off-by: Amery Hung <ameryhung@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://lore.kernel.org/r/20250217190640.1748177-2-ameryhung@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf.h   |  7 +++++--
 kernel/bpf/bpf_iter.c | 13 ++++++-------
 kernel/bpf/syscall.c  |  1 +
 kernel/bpf/verifier.c | 22 ++++++++++++----------
 4 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f3f50e29d6392..f4df39e8c7357 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1507,7 +1507,7 @@ struct bpf_prog_aux {
 	u32 max_rdonly_access;
 	u32 max_rdwr_access;
 	struct btf *attach_btf;
-	const struct bpf_ctx_arg_aux *ctx_arg_info;
+	struct bpf_ctx_arg_aux *ctx_arg_info;
 	void __percpu *priv_stack_ptr;
 	struct mutex dst_mutex; /* protects dst_* pointers below, *after* prog becomes visible */
 	struct bpf_prog *dst_prog;
@@ -1945,6 +1945,9 @@ static inline void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_op
 
 #endif
 
+int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
+			       const struct bpf_ctx_arg_aux *info, u32 cnt);
+
 #if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_LSM)
 int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
 				    int cgroup_atype);
@@ -2546,7 +2549,7 @@ struct bpf_iter__bpf_map_elem {
 
 int bpf_iter_reg_target(const struct bpf_iter_reg *reg_info);
 void bpf_iter_unreg_target(const struct bpf_iter_reg *reg_info);
-bool bpf_iter_prog_supported(struct bpf_prog *prog);
+int bpf_iter_prog_supported(struct bpf_prog *prog);
 const struct bpf_func_proto *
 bpf_iter_get_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog);
 int bpf_iter_link_attach(const union bpf_attr *attr, bpfptr_t uattr, struct bpf_prog *prog);
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 106735145948b..380e9a7cac75d 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -335,7 +335,7 @@ static void cache_btf_id(struct bpf_iter_target_info *tinfo,
 	tinfo->btf_id = prog->aux->attach_btf_id;
 }
 
-bool bpf_iter_prog_supported(struct bpf_prog *prog)
+int bpf_iter_prog_supported(struct bpf_prog *prog)
 {
 	const char *attach_fname = prog->aux->attach_func_name;
 	struct bpf_iter_target_info *tinfo = NULL, *iter;
@@ -344,7 +344,7 @@ bool bpf_iter_prog_supported(struct bpf_prog *prog)
 	int prefix_len = strlen(prefix);
 
 	if (strncmp(attach_fname, prefix, prefix_len))
-		return false;
+		return -EINVAL;
 
 	mutex_lock(&targets_mutex);
 	list_for_each_entry(iter, &targets, list) {
@@ -360,12 +360,11 @@ bool bpf_iter_prog_supported(struct bpf_prog *prog)
 	}
 	mutex_unlock(&targets_mutex);
 
-	if (tinfo) {
-		prog->aux->ctx_arg_info_size = tinfo->reg_info->ctx_arg_info_size;
-		prog->aux->ctx_arg_info = tinfo->reg_info->ctx_arg_info;
-	}
+	if (!tinfo)
+		return -EINVAL;
 
-	return tinfo != NULL;
+	return bpf_prog_ctx_arg_info_init(prog, tinfo->reg_info->ctx_arg_info,
+					  tinfo->reg_info->ctx_arg_info_size);
 }
 
 const struct bpf_func_proto *
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8c42c094f0d1e..32a8d5fd98612 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2314,6 +2314,7 @@ static void __bpf_prog_put_noref(struct bpf_prog *prog, bool deferred)
 	kvfree(prog->aux->jited_linfo);
 	kvfree(prog->aux->linfo);
 	kfree(prog->aux->kfunc_tab);
+	kfree(prog->aux->ctx_arg_info);
 	if (prog->aux->attach_btf)
 		btf_put(prog->aux->attach_btf);
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0752e8e556389..4392436ba7511 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22429,6 +22429,15 @@ static void print_verification_stats(struct bpf_verifier_env *env)
 		env->peak_states, env->longest_mark_read_walk);
 }
 
+int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
+			       const struct bpf_ctx_arg_aux *info, u32 cnt)
+{
+	prog->aux->ctx_arg_info = kmemdup_array(info, cnt, sizeof(*info), GFP_KERNEL);
+	prog->aux->ctx_arg_info_size = cnt;
+
+	return prog->aux->ctx_arg_info ? 0 : -ENOMEM;
+}
+
 static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 {
 	const struct btf_type *t, *func_proto;
@@ -22509,17 +22518,12 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 		return -EACCES;
 	}
 
-	/* btf_ctx_access() used this to provide argument type info */
-	prog->aux->ctx_arg_info =
-		st_ops_desc->arg_info[member_idx].info;
-	prog->aux->ctx_arg_info_size =
-		st_ops_desc->arg_info[member_idx].cnt;
-
 	prog->aux->attach_func_proto = func_proto;
 	prog->aux->attach_func_name = mname;
 	env->ops = st_ops->verifier_ops;
 
-	return 0;
+	return bpf_prog_ctx_arg_info_init(prog, st_ops_desc->arg_info[member_idx].info,
+					  st_ops_desc->arg_info[member_idx].cnt);
 }
 #define SECURITY_PREFIX "security_"
 
@@ -22996,9 +23000,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 		prog->aux->attach_btf_trace = true;
 		return 0;
 	} else if (prog->expected_attach_type == BPF_TRACE_ITER) {
-		if (!bpf_iter_prog_supported(prog))
-			return -EINVAL;
-		return 0;
+		return bpf_iter_prog_supported(prog);
 	}
 
 	if (prog->type == BPF_PROG_TYPE_LSM) {
-- 
2.39.5



Return-Path: <bpf+bounces-51771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB6EA38C0B
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 20:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A7AF3AD8C2
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 19:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881FC236A74;
	Mon, 17 Feb 2025 19:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLn2S2bk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820C823643F
	for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 19:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739819214; cv=none; b=TNq5tmbCeCzRZfFc9ys/o5/hVTI1NAlqMJwf4zuqptdsHGh07gG8aT8B8BXIhVQrpFEc8GPwRBioN71mGHZIKX1UTmS3swvTXOt9Joa+7WpflIFkQmZ6gohO9OAJ/VKKLTbWzbX2Vj+baeSkoZSpIjAiP7Hjkx2Z0hzzbSG349U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739819214; c=relaxed/simple;
	bh=AXs1vMpS5puVH3gRD2HYaBGRK+z9Oe/x1iYt0Js5h9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O+wvfcAyZhAu49t9oWTrNTXyBM/Gl3VvZKJ53vioccdeBFdpi745a7dRurB53Lr2a/cqsv76t62STyfbbvlU5DABO2TyBiGiwNORSgg4iqtAeBmWTB1T+TCKowc0rXo93hOOV4MgffTzqjGPdM0Ilzb4M1tFTvF2cx0flGpyNog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLn2S2bk; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220f4dd756eso55752125ad.3
        for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 11:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739819211; x=1740424011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOgJ1UPS895ITVQ/ZOF6JfvrUTf4B+UKNzz9zkfZopc=;
        b=iLn2S2bkAK//d5+9qZg1z1nh1M2eUWUd4U6CAplhGcAH43zslBuJw9VKQBYrSESatW
         97KATTljDtdxXac845f4bEV6wHw+8gjmD7alqKU9TuvanoTl1qLF++Nuf/0R5gv+05cO
         2nf4mznbcrfp52U+WcSm8m0fTcsId6OJhK3iyh3XKJkLfHt8EA+vmQJDenFnqt57Jrg9
         7ZlLwjSWx2Er5HlWEE2CuzXPvcpWseXIKdxmTHPttMF8RraXLXTfaErwpz5oyE5pBcbl
         S+vqs/qpAOb92efZ6oev7V/oCcG4z6wA15gPPG0vrXsgXUJJu5G3tuwDEHAGCNVyFDXy
         f0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739819211; x=1740424011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOgJ1UPS895ITVQ/ZOF6JfvrUTf4B+UKNzz9zkfZopc=;
        b=QwhpjQyWiSNd82SfxPScRCZINQJpUZrT7SoRyYNdbhdhpB0J2Pk8ewxpCXEuIdwhmm
         VgdrV8+/rgrtHNUiVgQwVm0aLK4GGd3YtBCkZlgnF77J21D2z+xUy7C01+Pk38mdSTHe
         NS4fjbNcqbBCzLdFGahB/uKoeLdQDWZck+BXXiOuHXtLz8S35rCp+MFz4v//QwrwofIs
         nvxkzydlwYgh3zT1K1/B+tQAvVbtoA3v8P8ddUircj0LJTjZ/29hyVQzSbsP1jKdT/Sc
         xox7GucjuBXRccpWhev5VI8O715X3w8QNL8GXGviyEwAbodI0IG4zWQbxvmL+I+C584i
         tXEA==
X-Gm-Message-State: AOJu0YwFXIkOL67HERKXM2JwpfzO3Saxrh706luZI3ze85/SuEkrprH9
	20i+wdY4pi1Z2S2bY8sNmiERq7SoI0e+/Ta6yPCBWwgkwyz0ex1QSNR63A==
X-Gm-Gg: ASbGncsepmlTe6KpZ7Qif9PxnwbbOiYn0MDBL3oGVE6jCgT+kYVVC0Z5AI1BpbkYTnC
	QLX8FFUVWJm0aRSqfnT43QDjC1mHnq4RuVSV4GsefMBGRNx3BCJB0ZNDg2DMxJybRvEpgxprXnH
	5yG3ZXj6uRW7XqpXR1WMpPxMq79ILChWS1wzsGqko/KytrUR9C14NA7StirGfTEwx2BI6qKnyVQ
	1fzMMyp8jOjQH73EyzfvtVpneZQn1iMR+gF6Fb9l2Xo/QOhw4JJIZ7fNID3PxM2yhHjXT48Eg4b
	3s1fo7g3+NXCBOJ79S54KzDkog8MGxGom8lNVSFyI7JoUHUxXmMNtNXpuI4Q0Stmew==
X-Google-Smtp-Source: AGHT+IGLfbrMqCN6WtP1iK0WPPnoTi3avN8lOjHfN5I2pdEZbLFXOUlsKZpFjo97nT4s3NhTOaEFFg==
X-Received: by 2002:a05:6a00:3c88:b0:730:9752:d034 with SMTP id d2e1a72fcca58-73261778d10mr15629665b3a.1.1739819211222;
        Mon, 17 Feb 2025 11:06:51 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73265f98e18sm5039118b3a.106.2025.02.17.11.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 11:06:50 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 1/5] bpf: Make every prog keep a copy of ctx_arg_info
Date: Mon, 17 Feb 2025 11:06:36 -0800
Message-ID: <20250217190640.1748177-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250217190640.1748177-1-ameryhung@gmail.com>
References: <20250217190640.1748177-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 include/linux/bpf.h   |  7 +++++--
 kernel/bpf/bpf_iter.c | 13 ++++++-------
 kernel/bpf/syscall.c  |  1 +
 kernel/bpf/verifier.c | 22 ++++++++++++----------
 4 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f3f50e29d639..f4df39e8c735 100644
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
index 106735145948..380e9a7cac75 100644
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
index c420edbfb7c8..4b89a5df8ebc 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2313,6 +2313,7 @@ static void __bpf_prog_put_noref(struct bpf_prog *prog, bool deferred)
 	kvfree(prog->aux->jited_linfo);
 	kvfree(prog->aux->linfo);
 	kfree(prog->aux->kfunc_tab);
+	kfree(prog->aux->ctx_arg_info);
 	if (prog->aux->attach_btf)
 		btf_put(prog->aux->attach_btf);
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9971c03adfd5..851bcaeaaddf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22377,6 +22377,15 @@ static void print_verification_stats(struct bpf_verifier_env *env)
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
@@ -22457,17 +22466,12 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
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
 
@@ -22917,9 +22921,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
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
2.47.1



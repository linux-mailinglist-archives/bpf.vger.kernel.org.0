Return-Path: <bpf+bounces-51008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6FDA2F581
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 18:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11A8B1884B78
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 17:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB03255E5F;
	Mon, 10 Feb 2025 17:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3ItClt9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965AC255E33;
	Mon, 10 Feb 2025 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209430; cv=none; b=R8LWZG2u5K487eIznpExHnB5hc2rvN/GIq4IL27G5OCB0zIloRld5NaLyZyOLpVAVUTyCUCSsZaqBa5Xd9LBZ8rbG8YTeO/EgwSyYSQ1mAsNYU7CTByWvK5zX1hofGnWyVe6OkB1ahNEdFtN1Pu+TIkgxIDHvPoRYBLFWTd5CzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209430; c=relaxed/simple;
	bh=T6e3c/PMYgXS4OKgRSQdlouBBcdvjHT4HakbLjxQBZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u7Hll8lUg1lXqyKAzrzUKJE0lLP3V4SH1EbZ7pBFS0dTk5LHIRl7/6TEJWI69NglrenDzPGmHpm3dCzsE8Wg1VYNG5JpGEKBBO707Ub6zWqoJBcV8O7vIYgk+gRJZbnfTsJAIbwYDjMXvn1Q0lx4R4+t7UKpguDE0+H6FWGQQME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3ItClt9; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f9bac7699aso6826494a91.1;
        Mon, 10 Feb 2025 09:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739209428; x=1739814228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97lx6pYZgJTlQmKaYcz/MNGoRDCTIp3Q81k8vsbjFMQ=;
        b=B3ItClt9F/vHdCEUta6j2ZhLlYNB7uFKqtJj9POw1tuH+Isx9sX8ymwoAn4Eckbe9U
         SE9frsE6q6GU6cqtbHCI2zMfzUN4n3yoZ6/b6yWVqEidqccl39UDUyXYOJpZdVj0t5+D
         35KFpcofJXYM7scrmo5l+RGWt6KLag/xNp7IoOoCA4eJmGaJTkar9DxzF8duM7b2f7j4
         YtEuKLdeHXefuB2AVZhWJR8bowVC9nVtslhFpYf/RWX94tlFnv3Pcl/OAhTk3Avb7AvP
         z2kyNG5skE/lUHGmdKxdrctbhE/vpKQmp12ygWsPSrP4+kAffCgWTv92e/hjkcBY2y4M
         uTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739209428; x=1739814228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97lx6pYZgJTlQmKaYcz/MNGoRDCTIp3Q81k8vsbjFMQ=;
        b=qldTSme5H1jmRv5cY+4iTLflB4par7ebmI8Qy21duN/GllEQdPAkRprR6iv/4xgXl0
         UNM0x9C/Ihvsej33X3UXR1GfuwLLl8l/cS00ZHzGzga5xetZiIVedTPnKQumCfHAg+qV
         +J/F6B+62U9NNilPBWt8Fa3DxBoxHpYkRU/qASPitn3z15vKpT+UTnaKeVnXMPwOAZa9
         pIF+zjB1QuKq1zqwSSiplnQLPTJmRtA+CNnmSMpSXgY6cq/I4TGRHR4Ptb4wK0AjUXGB
         Jpha9HoUgxkgxFTqWBvmvzeQPOxWx6e5JfpbDtqNqCfDrNXDpneIEsOyP+0bCLUGC7pF
         k57A==
X-Gm-Message-State: AOJu0YwZX5rudiqvF4SHEJTnN2vduYzljcvFnMoU3LAtnMDJ2EIO9ase
	u7/pek6wC779gwO9FinbMRfHOgMsQhr38rY7F4Ghb0E94LJKMLMgyPLc+8Dt
X-Gm-Gg: ASbGncvkAO0Yk4OWvStpPuBS3rnnBk8mAJy3OBv18PYQxseOxf27RTqnhEQRS6L/1Jk
	9ZoaMnFnlAE0wyaqLq/uH+THM5BSsUqH6mo1ZGNKChjKDQnNGdARTEZ0GMJcyZw2WvpXpJc5yrv
	BEnTPQ24aPEI3ln4+7H/w7A4FyCEvIg/22+uvli/3mDwAXLtsEmRO+gjoFB6YQTkH+sO1AH6P4O
	SWzDJrlYsFfZbZu2v8nD3xZopO9lTICsLne5OPolbGUgemJOXTdc+wkuJyw7X+pU5l2FMIdZ8J3
	lRKgCziKOADvOAmbUogQXlvkEYU8k70KTgUFvAoEDyZLPJzQM3dMSEeKrzUPCxdMwA==
X-Google-Smtp-Source: AGHT+IFIO3TkyEZrtc6D2jlRpAD3Rc/qSd+vcW8XfYQ5NgtcW76LUcNKoN7UcfkqwMTceJfcPIpG/A==
X-Received: by 2002:a17:90b:548b:b0:2f4:47fc:7f18 with SMTP id 98e67ed59e1d1-2fa9ed7b2b1mr626002a91.10.1739209427538;
        Mon, 10 Feb 2025 09:43:47 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa3fb55dcasm5554961a91.4.2025.02.10.09.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 09:43:47 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	kuba@kernel.org,
	edumazet@google.com,
	xiyou.wangcong@gmail.com,
	cong.wang@bytedance.com,
	jhs@mojatatu.com,
	sinquersw@gmail.com,
	toke@redhat.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 01/19] bpf: Make every prog keep a copy of ctx_arg_info
Date: Mon, 10 Feb 2025 09:43:15 -0800
Message-ID: <20250210174336.2024258-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210174336.2024258-1-ameryhung@gmail.com>
References: <20250210174336.2024258-1-ameryhung@gmail.com>
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
---
 include/linux/bpf.h   |  7 +++++--
 kernel/bpf/bpf_iter.c | 13 ++++++-------
 kernel/bpf/verifier.c | 25 +++++++++++++++----------
 3 files changed, 26 insertions(+), 19 deletions(-)

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
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9971c03adfd5..a41ba019780f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22377,6 +22377,18 @@ static void print_verification_stats(struct bpf_verifier_env *env)
 		env->peak_states, env->longest_mark_read_walk);
 }
 
+int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
+			       const struct bpf_ctx_arg_aux *info, u32 cnt)
+{
+	prog->aux->ctx_arg_info = kcalloc(cnt, sizeof(*info), GFP_KERNEL);
+	if (!prog->aux->ctx_arg_info)
+		return -ENOMEM;
+
+	memcpy(prog->aux->ctx_arg_info, info, sizeof(*info) * cnt);
+	prog->aux->ctx_arg_info_size = cnt;
+	return 0;
+}
+
 static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 {
 	const struct btf_type *t, *func_proto;
@@ -22457,17 +22469,12 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
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
 
@@ -22917,9 +22924,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
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



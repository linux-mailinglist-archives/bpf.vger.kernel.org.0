Return-Path: <bpf+bounces-51575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1682EA36360
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 17:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F1EC3A5C87
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 16:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA29267739;
	Fri, 14 Feb 2025 16:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJ1/1Ekx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBDB264FA9
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 16:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739551533; cv=none; b=kdgSLBadNSIWPyzglAImQXz0vgdT/5d8X60/Q+2NCIwepvEAsQpgWtbDAnNokEKAXohQLo6L9MnZbS4IUAFE6/iqyZrT8mDZIDlxpJS8+8k9i6YQThezfvOVh0bxwF+eLPpxlqZHyApSDAE+bDFcM2L4g4nSpq8/hvzsJyf/xKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739551533; c=relaxed/simple;
	bh=F1LqcDnRgUym3jCFdQfnlgIgsLietRoBiVkYd8ua0Wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oA5hJ5zLCTiTk7808Qbxp5zGssvxXFlgbcQIZC//4yWY3jWwn4dWqrHkGhLST9Jjpv8By2hZnARZ08ufRfi3Ifb6W35+zfofip22fptQawhrTUccdAu0Gnu0oDZdL2Vc/IhNGB82zN3zGVyNs3v2RnjTgctctdwH/cPy/KL/1uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJ1/1Ekx; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21f6d2642faso61428365ad.1
        for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 08:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739551530; x=1740156330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2VNl9RoDF4qcMk8lDzfqgVHsgyUHTU4tSw9Z2ZI42WM=;
        b=XJ1/1EkxLix55Ss6HA0qOu/01dQYuR8wY8ooQuTVtf4+aRvri+WqkmxeoMs2NgULkg
         /ur7hAQguAkXERc4vOmzpApSeQvrhquTW/WF+YDcad+JZBDU2IMLn+1GKwAYk+LfAeMS
         PyE/s5W20UxPtN7fjhBQXCxm4uTHt2vsHVDMwiKUHd7EpXWS8sYZf6et11+Af915U+M2
         SiMquxkQpzxIM73/skaLQx1RbkFhlggnuoFWBQtQkxvDxZItO0YZOrAP9ySLQrOXxdAK
         67cIqriwv3KBHNhqhtm8YWlX6TLFOXNFWV7o+ryrKjk7kMj5j0LZSJB2xGvI5C5V1HlC
         kO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739551530; x=1740156330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2VNl9RoDF4qcMk8lDzfqgVHsgyUHTU4tSw9Z2ZI42WM=;
        b=VlliSAh/FYSInn10zKaYGGXyXXQLOrgJGJdKb4thuDq7f5JG4nlu6USEO7J2nmear6
         eB5WCYWJ0AXPXyD4zTfVmPMBSmLNB6ozMnsPxgYceqdWFbOoVpl/Dpt/6MKwTy/PyTIX
         P1g6aycB3IvAFgKHg7+Up3T78H1sOrMWszl7ObwzT+IDEHPPiVAasAEEgaQWANwkCO0E
         djPM5vNEEgXKVl6DJuWZ5QlZGs6whmcOQWS8wAdC2M7WeJPQBtWY5f0u/NPwFeBIZHbN
         CsuRV3VTiMWn07rcqr45wNlSNbhYXNGvAgvFUQbieThgmTnq7fFuw2Av4kCncoP4McHo
         Ci4w==
X-Gm-Message-State: AOJu0YxuEgW2PkGH1LmDs77BD7bzt8Mngp8SQaiVrSOxBdfNpDR1Yfi0
	4wX1IA2WyRPVOyLH1a6tOoBRG/DAIiFYc7e3HEfSx/qoQH1OEM4w4d32sg==
X-Gm-Gg: ASbGnct2mxyxX+fqUSg0/eXLm0kIBlWu/43EtBS8nNCij458Hoew9KKpD3syisARG1g
	g3MsWxoTwg52nnYAilfijA0Fy5lTUcP2K2Mz92CeN1lSjFFJuZPmQhvudu7vWpwBYjdQOfhbWlx
	CVptpIAv3qSa/WrZdQz1YbetDQLVF1lIk380X1Hu21ECkuiUsmG5tWPPLU+GiJ4/RInWKk2d/hi
	1kYvtfa1EeLROvmfWZUEL2y5XCtY4dYx4lqNeEOJ6rgcYkw04eefxJWOVDHNNkUHKhFQnd3o96y
	p42GiF0Lsgmx8NV4ptTL8POpkKlELf/OLp6wcaVCXRefEQSnLIXcfr4zQl9WVETeJg==
X-Google-Smtp-Source: AGHT+IHwEGCTLmHOB8cPiU3P95bHyn26BDUXZU68QjyVWNQAUIuZjvgBv6fREq2rhDG/MIj/HvMKQw==
X-Received: by 2002:a05:6a21:6e47:b0:1ee:6fec:3e5c with SMTP id adf61e73a8af0-1ee8caab660mr304502637.7.1739551530378;
        Fri, 14 Feb 2025 08:45:30 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adbf21517eesm2223346a12.13.2025.02.14.08.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 08:45:30 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/5] bpf: Make every prog keep a copy of ctx_arg_info
Date: Fri, 14 Feb 2025 08:45:16 -0800
Message-ID: <20250214164520.1001211-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250214164520.1001211-1-ameryhung@gmail.com>
References: <20250214164520.1001211-1-ameryhung@gmail.com>
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
 kernel/bpf/syscall.c  |  2 ++
 kernel/bpf/verifier.c | 25 +++++++++++++++----------
 4 files changed, 28 insertions(+), 19 deletions(-)

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
index c420edbfb7c8..598f19e6ebd2 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2315,6 +2315,8 @@ static void __bpf_prog_put_noref(struct bpf_prog *prog, bool deferred)
 	kfree(prog->aux->kfunc_tab);
 	if (prog->aux->attach_btf)
 		btf_put(prog->aux->attach_btf);
+	if (prog->aux->ctx_arg_info)
+		kfree(prog->aux->ctx_arg_info);
 
 	if (deferred) {
 		if (prog->sleepable)
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



Return-Path: <bpf+bounces-62261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DB7AF73AD
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 14:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 584F8565608
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 12:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F432E9EC3;
	Thu,  3 Jul 2025 12:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdt/GENv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045B62E92AA;
	Thu,  3 Jul 2025 12:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751545054; cv=none; b=MkNDWGF1zxw9S2dGha8F/xt6w+Xsvqge/msgtey+Tsq8Rs/Cf3G7OVcyGmvb0eKrUdoFTlT6kTh5jg5mN/QyUS761Z5/Qilo+TB6KGBhnrFl4vlLsbQyMQMIkUM4RQ4C4q9k7a8+Sa5IHTcfM/E4IhlTtzFp0rO/vmJLvKtNaXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751545054; c=relaxed/simple;
	bh=jap0Ed9EgWc2RapbFILfBOQj/uza9Go++xuSohd34U0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZD+5AOOcdWZV25EWHN9bkzApsQsnNeaH1wgB3I8XuwRNi+4+d7SMYClUunQbXiXu/R3I1nSu+4Jn/SPfmZSLebFV3yino/ZeyVmaQTk+q6ou62m4NSkcMPXWvP2phIJQ3jm1JKDCG9+ZXkDCmDYnOjGJPciifJyXKlJfT7WQHhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdt/GENv; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so8448632b3a.0;
        Thu, 03 Jul 2025 05:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751545051; x=1752149851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFKz3mPgSNjSMlPTd/tbucVXMH3JLrryPtuCUJ1bbAo=;
        b=kdt/GENvxkNUtWYzogqw2YzQQDabVGhN0wJCzyGLSTt0WuYb046Z2xxIK8zApIvzUR
         UD1onDqSXb+aM5hciRlieRB5eiZU3qvTpyEXyY2eDFJYSjti1MxOTGRs5sCUPrcUNNBi
         iLSWaBQr6VmMghpPsrCvGx9UmCXSAc1b4otBVbExGv5/f/Ls2s52fSgzrs20fP0gla04
         7ufxhZjKsn66Dyznlu0B8NlxVwa5+dMHkdW3dNvccpLQZTQZC1CsTJFYwUSSi3/JwL+6
         d9Ui7v2iEJIS6/poPhTLgpK7RqOM1Ov9YN6CgGCZbSvIZAh7p8Y79R+hn8k/q8fm3H/7
         lH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751545051; x=1752149851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFKz3mPgSNjSMlPTd/tbucVXMH3JLrryPtuCUJ1bbAo=;
        b=klUg3CgK39iJKaTFVUH7+9yCpkzQ2gKiwUlcExOV+mkWnimea24vZqvTtUCmcxQXPp
         ejJVacY02r367e19f45CTb4wjaCJQiUTknncnletV6vU6phmG+dQpy78Mh9XXJEGBs6o
         PurslhyovlSLIvQT06EuSptKCB+F+J/xEqzBWBMmF6kURtsrrWP9fjUWYSW3lpF9EgW1
         EYEnRHwW08/Gw3TkC/d3zDfxe2NOrVO1+0hd9/fO8Vl6DwpIpYHiqhDf52EZ3WjBdGLr
         6TWyxNwMZKEv3v8VMISsysdtYWtznx1+J+w7cFO3Ib5Lyut4HHrU2a832YUEXCojwT9z
         OGrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWE01TtElCKx/Pv363SWZ6M3VyWd+AgBs+D+BM65cTKXACxLBKj2h80i03Ss1+/+kYgQ+1E9X0n+0lAAiM=@vger.kernel.org, AJvYcCX2L1fDyh3j0s9Tcik3rM2iPjcZd6fueThR9bsmEhdwcWBHOl2HwNTW/VMhQ7p95WwbqVMKSKlR@vger.kernel.org
X-Gm-Message-State: AOJu0YwHKsqa/sSvhzOrpTP1CdwwD2GQDIVAFU97l08md65icmIxWop+
	gAP/bdx596LDLVRxQ6yyTxBBCHhJiUnSS+SFjIItg0C5dTdbPr+S08MC
X-Gm-Gg: ASbGncuz1rnL+UwtltFkKfNKA1PHrl3RHYY8RcwiUC6OUG7WuVfMtvsqE785ItqV5Zn
	xQ2KREY2dXaQ8auju7RH3OXA0iXYPPmMFU82T5hiDGeojN6udryoqvUbJgtDHcYNV2l6EpoBeYq
	T5MXbwLhwR9oFGxM/T57/UyP7CaGUF+EOJRnqqtoJlxF4X5qQNbUQD4Oh03p/fFp1KQQq3BeysM
	hoxjHmma3nYWYLXjXFOKh4y9tjT/jLx032nzB9B9+CLAJLRrcb4AB9XJep+AsgDbqOErP0WXOcr
	RWNNCnH7XicdM25IMfJng+uBc9mYp0BxsKBmpwHWV/Ifqt7KUe28zy2z1fj2Wpz9h2188rIsBOe
	BvUY=
X-Google-Smtp-Source: AGHT+IEw+8oWxj9erH87qMNnEWjrlT/DYligwiN4ZkjfE+nL2ZvXPWBYvNsfd+m8VbF/vLGxaVyqMw==
X-Received: by 2002:a05:6a21:62c6:b0:21f:ef96:49ab with SMTP id adf61e73a8af0-222d7e9bef2mr11781812637.27.1751545051158;
        Thu, 03 Jul 2025 05:17:31 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5575895sm18591081b3a.94.2025.07.03.05.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 05:17:30 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v2 06/18] bpf: tracing: add support to record and check the accessed args
Date: Thu,  3 Jul 2025 20:15:09 +0800
Message-Id: <20250703121521.1874196-7-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this commit, we add the 'accessed_args' field to struct bpf_prog_aux,
which is used to record the accessed index of the function args in
btf_ctx_access().

Meanwhile, we add the function btf_check_func_part_match() to compare the
accessed function args of two function prototype. This function will be
used in the following commit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/bpf.h   |   4 ++
 include/linux/btf.h   |   3 +-
 kernel/bpf/btf.c      | 108 +++++++++++++++++++++++++++++++++++++++++-
 net/sched/bpf_qdisc.c |   2 +-
 4 files changed, 113 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 70bf613d51d0..5e6d83750d39 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1605,6 +1605,7 @@ struct bpf_prog_aux {
 	const struct btf_type *attach_func_proto;
 	/* function name for valid attach_btf_id */
 	const char *attach_func_name;
+	u64 accessed_args;
 	struct bpf_prog **func;
 	void *jit_data; /* JIT specific data. arch dependent */
 	struct bpf_jit_poke_descriptor *poke_tab;
@@ -2790,6 +2791,9 @@ struct bpf_reg_state;
 int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog);
 int btf_check_type_match(struct bpf_verifier_log *log, const struct bpf_prog *prog,
 			 struct btf *btf, const struct btf_type *t);
+int btf_check_func_part_match(struct btf *btf1, const struct btf_type *t1,
+			      struct btf *btf2, const struct btf_type *t2,
+			      u64 func_args);
 const char *btf_find_decl_tag_value(const struct btf *btf, const struct btf_type *pt,
 				    int comp_idx, const char *tag_key);
 int btf_find_next_decl_tag(const struct btf *btf, const struct btf_type *pt,
diff --git a/include/linux/btf.h b/include/linux/btf.h
index a40beb9cf160..b2b56249ce11 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -524,7 +524,8 @@ bool btf_param_match_suffix(const struct btf *btf,
 			    const char *suffix);
 int btf_ctx_arg_offset(const struct btf *btf, const struct btf_type *func_proto,
 		       u32 arg_no);
-u32 btf_ctx_arg_idx(struct btf *btf, const struct btf_type *func_proto, int off);
+u32 btf_ctx_arg_idx(struct btf *btf, const struct btf_type *func_proto,
+		    int off, int *aligned_idx);
 
 struct bpf_verifier_log;
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 05fd64a371af..853ca19bbe81 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6404,19 +6404,24 @@ static bool is_void_or_int_ptr(struct btf *btf, const struct btf_type *t)
 }
 
 u32 btf_ctx_arg_idx(struct btf *btf, const struct btf_type *func_proto,
-		    int off)
+		    int off, int *aligned_idx)
 {
 	const struct btf_param *args;
 	const struct btf_type *t;
 	u32 offset = 0, nr_args;
 	int i;
 
+	if (aligned_idx)
+		*aligned_idx = -ENOENT;
+
 	if (!func_proto)
 		return off / 8;
 
 	nr_args = btf_type_vlen(func_proto);
 	args = (const struct btf_param *)(func_proto + 1);
 	for (i = 0; i < nr_args; i++) {
+		if (aligned_idx && offset == off)
+			*aligned_idx = i;
 		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
 		offset += btf_type_is_ptr(t) ? 8 : roundup(t->size, 8);
 		if (off < offset)
@@ -6684,7 +6689,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			tname, off);
 		return false;
 	}
-	arg = btf_ctx_arg_idx(btf, t, off);
+	arg = btf_ctx_arg_idx(btf, t, off, NULL);
 	args = (const struct btf_param *)(t + 1);
 	/* if (t == NULL) Fall back to default BPF prog with
 	 * MAX_BPF_FUNC_REG_ARGS u64 arguments.
@@ -6694,6 +6699,9 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		/* skip first 'void *__data' argument in btf_trace_##name typedef */
 		args++;
 		nr_args--;
+		prog->aux->accessed_args |= (1 << (arg + 1));
+	} else {
+		prog->aux->accessed_args |= (1 << arg);
 	}
 
 	if (arg > nr_args) {
@@ -7553,6 +7561,102 @@ int btf_check_type_match(struct bpf_verifier_log *log, const struct bpf_prog *pr
 	return btf_check_func_type_match(log, btf1, t1, btf2, t2);
 }
 
+static u32 get_ctx_arg_total_size(struct btf *btf, const struct btf_type *t)
+{
+	const struct btf_param *args;
+	u32 size = 0, nr_args;
+	int i;
+
+	nr_args = btf_type_vlen(t);
+	args = (const struct btf_param *)(t + 1);
+	for (i = 0; i < nr_args; i++) {
+		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
+		size += btf_type_is_ptr(t) ? 8 : roundup(t->size, 8);
+	}
+
+	return size;
+}
+
+/* This function is similar to btf_check_func_type_match(), except that it
+ * only compare some function args of the function prototype t1 and t2.
+ */
+int btf_check_func_part_match(struct btf *btf1, const struct btf_type *func1,
+			      struct btf *btf2, const struct btf_type *func2,
+			      u64 func_args)
+{
+	const struct btf_param *args1, *args2;
+	u32 nargs1, i, offset = 0;
+	const char *s1, *s2;
+
+	if (!btf_type_is_func_proto(func1) || !btf_type_is_func_proto(func2))
+		return -EINVAL;
+
+	args1 = (const struct btf_param *)(func1 + 1);
+	args2 = (const struct btf_param *)(func2 + 1);
+	nargs1 = btf_type_vlen(func1);
+
+	for (i = 0; i <= nargs1; i++) {
+		const struct btf_type *t1, *t2;
+
+		if (!(func_args & (1 << i)))
+			goto next;
+
+		if (i < nargs1) {
+			int t2_index;
+
+			/* get the index of the arg corresponding to args1[i]
+			 * by the offset.
+			 */
+			btf_ctx_arg_idx(btf2, func2, offset, &t2_index);
+			if (t2_index < 0)
+				return -EINVAL;
+
+			t1 = btf_type_skip_modifiers(btf1, args1[i].type, NULL);
+			t2 = btf_type_skip_modifiers(btf2, args2[t2_index].type,
+						     NULL);
+		} else {
+			/* i == nargs1, this is the index of return value of t1 */
+			if (get_ctx_arg_total_size(btf1, func1) !=
+			    get_ctx_arg_total_size(btf2, func2))
+				return -EINVAL;
+
+			/* check the return type of t1 and t2 */
+			t1 = btf_type_skip_modifiers(btf1, func1->type, NULL);
+			t2 = btf_type_skip_modifiers(btf2, func2->type, NULL);
+		}
+
+		if (t1->info != t2->info ||
+		    (btf_type_has_size(t1) && t1->size != t2->size))
+			return -EINVAL;
+		if (btf_type_is_int(t1) || btf_is_any_enum(t1))
+			goto next;
+
+		if (btf_type_is_struct(t1))
+			goto on_struct;
+
+		if (!btf_type_is_ptr(t1))
+			return -EINVAL;
+
+		t1 = btf_type_skip_modifiers(btf1, t1->type, NULL);
+		t2 = btf_type_skip_modifiers(btf2, t2->type, NULL);
+		if (!btf_type_is_struct(t1) || !btf_type_is_struct(t2))
+			return -EINVAL;
+
+on_struct:
+		s1 = btf_name_by_offset(btf1, t1->name_off);
+		s2 = btf_name_by_offset(btf2, t2->name_off);
+		if (strcmp(s1, s2))
+			return -EINVAL;
+next:
+		if (i < nargs1) {
+			t1 = btf_type_skip_modifiers(btf1, args1[i].type, NULL);
+			offset += btf_type_is_ptr(t1) ? 8 : roundup(t1->size, 8);
+		}
+	}
+
+	return 0;
+}
+
 static bool btf_is_dynptr_ptr(const struct btf *btf, const struct btf_type *t)
 {
 	const char *name;
diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 7ea8b54b2ab1..4ce395a72996 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -38,7 +38,7 @@ static bool bpf_qdisc_is_valid_access(int off, int size,
 	struct btf *btf = prog->aux->attach_btf;
 	u32 arg;
 
-	arg = btf_ctx_arg_idx(btf, prog->aux->attach_func_proto, off);
+	arg = btf_ctx_arg_idx(btf, prog->aux->attach_func_proto, off, NULL);
 	if (prog->aux->attach_st_ops_member_off == offsetof(struct Qdisc_ops, enqueue)) {
 		if (arg == 2 && type == BPF_READ) {
 			info->reg_type = PTR_TO_BTF_ID | PTR_TRUSTED;
-- 
2.39.5



Return-Path: <bpf+bounces-34779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A928D930B0F
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 19:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 233B61F21D0B
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 17:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D67D13CA81;
	Sun, 14 Jul 2024 17:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5hqoMjD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA81282FA;
	Sun, 14 Jul 2024 17:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720979495; cv=none; b=E8ukYh4xxVL8fIPrvdND0UbUFpU75GImXf2XyWtVmfGo4xRjKxh9A6kSpDnAW3lhdCzVCGCaRGWFwquQPz+L4XDc1cdFy/ryArRBkgoW2oiYd7/64vTL0eQPTbJzV9kjFBdM9iikp1qxVne4hIM6gQ0DOawrjfii1EjOsCZW180=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720979495; c=relaxed/simple;
	bh=uVKDn9PByunNEKw0VV6NvzeWZlExf66uTkq6tuyFiGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gA37D+H2W5o9lDmiGMgY8pNJ4TfdaFbTqTwVuEtweqsqU6m1MohtjksaBiqN71BjBiWcO9nv+wU6bN+ZjE98Ya16Eiu3BsifoVfsErJdi8ASQvNxhcJaUdaSl6Ar8ttXddUU2L+WEqoS5yhC+dm0V3kNFneMJ1J9ZuSNDm/DSKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5hqoMjD; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-44f5df38e64so7616901cf.3;
        Sun, 14 Jul 2024 10:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720979492; x=1721584292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmEz/IGn/SjAsGtTZZV0MCY8TFL8b4oCXPsRsze76Jg=;
        b=B5hqoMjDXYqNgqknbilw0l4gRTPrjyajMyj/f/f1BL9w1DJ92gyjvj4yXB9Lxltwqw
         u3FcOASnAlwm9IiP1ofSveNolCvTuSlI9oi8/UhvxxpFK8KlPDFkVqlthx2Qiyika5i4
         JSMe4nO3TRzLwc71jPVytqRLHPf8BngLRld5jiXeSL+CNErHzJbAc4nURc/vWyNJmZdl
         PwkETfO1nS2O6FTZA8qOiLKjzbygiO1LSQdHBJnEv2b+aShGrjHUuIwQPMrGC2LNVdcN
         pMdryJxvXVafzxpFE7EGYKuUCCZ3ovLqMuV8fx2o81i8Jf83B7RwV573KhAIhyPknLct
         aQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720979492; x=1721584292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmEz/IGn/SjAsGtTZZV0MCY8TFL8b4oCXPsRsze76Jg=;
        b=SkpK5TSVmqFxvc9VLWnvjKCXcCSUQ2THsKoY7DVQtpv7yt4m9WNudypQBINbU2FBW4
         1vIvOoJcCchjCjQNH/VkvQf03nPWj/V/heCXGwVNdfYLGXNHJQtmwinJMTfC2r3SGh+P
         JwUXIzoz90ZSWL4Grp9/GQz3zZkg4fqFhWm1M8yFFRFjNwSglb6HGev5ykh727fyBUIA
         jLzHTGqCkFdrdfL7Hx/1zjCQGOtJuxGB7403I6xC1y+i8jeGj0ZRNjkHhjbWvvstySF3
         S+D04OTexeBgUUEsA/ygR5UNaRurCcQCDRDdCDmWuFc0O8ICtypM8G0TR9iMjbxJ7XqI
         ZJVA==
X-Gm-Message-State: AOJu0Yz8PL62T97nchqHmJ1wLTtGN97JMqIqw0ONx8aLjwUk9lVJaDdI
	h0OAaNzmP6r+cjnhP235P2ckP/jg9MwZb4ewtM8Lz6btvK1jEKH4G9JUeg==
X-Google-Smtp-Source: AGHT+IEKMXizeG1La1QNp+zFvN85OwgJqX7J2fwlrTww7/GrmAQnin981aPFPE81sUS19HKwsdM6tw==
X-Received: by 2002:a05:622a:7719:b0:447:f4b9:2524 with SMTP id d75a77b69052e-447fa9088dcmr154616461cf.24.1720979492010;
        Sun, 14 Jul 2024 10:51:32 -0700 (PDT)
Received: from n36-183-057.byted.org ([147.160.184.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f5b7e1e38sm17010481cf.25.2024.07.14.10.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 10:51:31 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	yangpeihao@sjtu.edu.cn,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	sdf@google.com,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com
Subject: [RFC PATCH v9 01/11] bpf: Support getting referenced kptr from struct_ops argument
Date: Sun, 14 Jul 2024 17:51:20 +0000
Message-Id: <20240714175130.4051012-2-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240714175130.4051012-1-amery.hung@bytedance.com>
References: <20240714175130.4051012-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows struct_ops programs to acqurie referenced kptrs from arguments
by directly reading the argument.

The verifier will automatically acquire a reference for struct_ops
argument tagged with "__ref" in the stub function. The user will be
able to access the referenced kptr directly by reading the context
as long as it has not been released by the program.

This new mechanism to acquire referenced kptr (compared to the existing
"kfunc with KF_ACQUIRE") is introduced for ergonomic and semantic reasons.

In the first use case, Qdisc_ops, an skb is passed to .enqueue in the
first argument. The qdisc becomes the sole owner of the skb and must
enqueue or drop the skb. Representing skbs in bpf qdisc as referenced
kptrs makes sure 1) qdisc will always enqueue or drop the skb in .enqueue,
and 2) qdisc cannot make up invalid skb pointers in .dequeue. The new
mechanism provides a natural way for users to get a referenced kptr in
struct_ops programs.

More importantly, we would also like to make sure that there is only a
single reference to the same skb in qdisc. Since in the future,
skb->rbnode will be utilized to support adding skb to bpf list and rbtree,
allowing multiple references may lead to racy accesses to this field when
the user adds references of the skb to different bpf graphs. The new
mechanism provides a better way to enforce such unique ptr semantic than
forbidding users to call a KF_ACQUIRE kfunc multiple times.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 include/linux/bpf.h         |  3 +++
 kernel/bpf/bpf_struct_ops.c | 26 ++++++++++++++++++++------
 kernel/bpf/btf.c            |  1 +
 kernel/bpf/verifier.c       | 34 +++++++++++++++++++++++++++++++---
 4 files changed, 55 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cc460786da9b..3891e45ded4e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -924,6 +924,7 @@ struct bpf_insn_access_aux {
 		struct {
 			struct btf *btf;
 			u32 btf_id;
+			u32 ref_obj_id;
 		};
 	};
 	struct bpf_verifier_log *log; /* for verbose logs */
@@ -1427,6 +1428,8 @@ struct bpf_ctx_arg_aux {
 	enum bpf_reg_type reg_type;
 	struct btf *btf;
 	u32 btf_id;
+	u32 ref_obj_id;
+	bool refcounted;
 };
 
 struct btf_mod_pair {
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 0d515ec57aa5..05f16f21981e 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -145,6 +145,7 @@ void bpf_struct_ops_image_free(void *image)
 }
 
 #define MAYBE_NULL_SUFFIX "__nullable"
+#define REFCOUNTED_SUFFIX "__ref"
 #define MAX_STUB_NAME 128
 
 /* Return the type info of a stub function, if it exists.
@@ -206,9 +207,11 @@ static int prepare_arg_info(struct btf *btf,
 			    struct bpf_struct_ops_arg_info *arg_info)
 {
 	const struct btf_type *stub_func_proto, *pointed_type;
+	bool is_nullable = false, is_refcounted = false;
 	const struct btf_param *stub_args, *args;
 	struct bpf_ctx_arg_aux *info, *info_buf;
 	u32 nargs, arg_no, info_cnt = 0;
+	const char *suffix;
 	u32 arg_btf_id;
 	int offset;
 
@@ -240,12 +243,19 @@ static int prepare_arg_info(struct btf *btf,
 	info = info_buf;
 	for (arg_no = 0; arg_no < nargs; arg_no++) {
 		/* Skip arguments that is not suffixed with
-		 * "__nullable".
+		 * "__nullable or __ref".
 		 */
-		if (!btf_param_match_suffix(btf, &stub_args[arg_no],
-					    MAYBE_NULL_SUFFIX))
+		is_nullable = btf_param_match_suffix(btf, &stub_args[arg_no],
+						     MAYBE_NULL_SUFFIX);
+		is_refcounted = btf_param_match_suffix(btf, &stub_args[arg_no],
+						       REFCOUNTED_SUFFIX);
+		if (!is_nullable && !is_refcounted)
 			continue;
 
+		if (is_nullable)
+			suffix = MAYBE_NULL_SUFFIX;
+		else if (is_refcounted)
+			suffix = REFCOUNTED_SUFFIX;
 		/* Should be a pointer to struct */
 		pointed_type = btf_type_resolve_ptr(btf,
 						    args[arg_no].type,
@@ -253,7 +263,7 @@ static int prepare_arg_info(struct btf *btf,
 		if (!pointed_type ||
 		    !btf_type_is_struct(pointed_type)) {
 			pr_warn("stub function %s__%s has %s tagging to an unsupported type\n",
-				st_ops_name, member_name, MAYBE_NULL_SUFFIX);
+				st_ops_name, member_name, suffix);
 			goto err_out;
 		}
 
@@ -271,11 +281,15 @@ static int prepare_arg_info(struct btf *btf,
 		}
 
 		/* Fill the information of the new argument */
-		info->reg_type =
-			PTR_TRUSTED | PTR_TO_BTF_ID | PTR_MAYBE_NULL;
 		info->btf_id = arg_btf_id;
 		info->btf = btf;
 		info->offset = offset;
+		if (is_nullable) {
+			info->reg_type = PTR_TRUSTED | PTR_TO_BTF_ID | PTR_MAYBE_NULL;
+		} else if (is_refcounted) {
+			info->reg_type = PTR_TRUSTED | PTR_TO_BTF_ID;
+			info->refcounted = true;
+		}
 
 		info++;
 		info_cnt++;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index de15e8b12fae..52be35b30308 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6516,6 +6516,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			info->reg_type = ctx_arg_info->reg_type;
 			info->btf = ctx_arg_info->btf ? : btf_vmlinux;
 			info->btf_id = ctx_arg_info->btf_id;
+			info->ref_obj_id = ctx_arg_info->ref_obj_id;
 			return true;
 		}
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 37053cc4defe..f614ab283c37 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1367,6 +1367,17 @@ static int release_reference_state(struct bpf_func_state *state, int ptr_id)
 	return -EINVAL;
 }
 
+static bool find_reference_state(struct bpf_func_state *state, int ptr_id)
+{
+	int i;
+
+	for (i = 0; i < state->acquired_refs; i++)
+		if (state->refs[i].id == ptr_id)
+			return true;
+
+	return false;
+}
+
 static void free_func_state(struct bpf_func_state *state)
 {
 	if (!state)
@@ -5587,7 +5598,7 @@ static int check_packet_access(struct bpf_verifier_env *env, u32 regno, int off,
 /* check access to 'struct bpf_context' fields.  Supports fixed offsets only */
 static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int off, int size,
 			    enum bpf_access_type t, enum bpf_reg_type *reg_type,
-			    struct btf **btf, u32 *btf_id)
+			    struct btf **btf, u32 *btf_id, u32 *ref_obj_id)
 {
 	struct bpf_insn_access_aux info = {
 		.reg_type = *reg_type,
@@ -5606,8 +5617,16 @@ static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int off,
 		*reg_type = info.reg_type;
 
 		if (base_type(*reg_type) == PTR_TO_BTF_ID) {
+			if (info.ref_obj_id &&
+			    !find_reference_state(cur_func(env), info.ref_obj_id)) {
+				verbose(env, "bpf_context off=%d ref_obj_id=%d is no longer valid\n",
+					off, info.ref_obj_id);
+				return -EACCES;
+			}
+
 			*btf = info.btf;
 			*btf_id = info.btf_id;
+			*ref_obj_id = info.ref_obj_id;
 		} else {
 			env->insn_aux_data[insn_idx].ctx_field_size = info.ctx_field_size;
 		}
@@ -6878,7 +6897,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 	} else if (reg->type == PTR_TO_CTX) {
 		enum bpf_reg_type reg_type = SCALAR_VALUE;
 		struct btf *btf = NULL;
-		u32 btf_id = 0;
+		u32 btf_id = 0, ref_obj_id = 0;
 
 		if (t == BPF_WRITE && value_regno >= 0 &&
 		    is_pointer_value(env, value_regno)) {
@@ -6891,7 +6910,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			return err;
 
 		err = check_ctx_access(env, insn_idx, off, size, t, &reg_type, &btf,
-				       &btf_id);
+				       &btf_id, &ref_obj_id);
 		if (err)
 			verbose_linfo(env, insn_idx, "; ");
 		if (!err && t == BPF_READ && value_regno >= 0) {
@@ -6915,6 +6934,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 				if (base_type(reg_type) == PTR_TO_BTF_ID) {
 					regs[value_regno].btf = btf;
 					regs[value_regno].btf_id = btf_id;
+					regs[value_regno].ref_obj_id = ref_obj_id;
 				}
 			}
 			regs[value_regno].type = reg_type;
@@ -20897,6 +20917,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 {
 	bool pop_log = !(env->log.level & BPF_LOG_LEVEL2);
 	struct bpf_subprog_info *sub = subprog_info(env, subprog);
+	struct bpf_ctx_arg_aux *ctx_arg_info;
 	struct bpf_verifier_state *state;
 	struct bpf_reg_state *regs;
 	int ret, i;
@@ -21004,6 +21025,13 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 		mark_reg_known_zero(env, regs, BPF_REG_1);
 	}
 
+	if (env->prog->type == BPF_PROG_TYPE_STRUCT_OPS) {
+		ctx_arg_info = (struct bpf_ctx_arg_aux *)env->prog->aux->ctx_arg_info;
+		for (i = 0; i < env->prog->aux->ctx_arg_info_size; i++)
+			if (ctx_arg_info[i].refcounted)
+				ctx_arg_info[i].ref_obj_id = acquire_reference_state(env, 0);
+	}
+
 	ret = do_check(env);
 out:
 	/* check for NULL is necessary, since cur_state can be freed inside
-- 
2.20.1



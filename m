Return-Path: <bpf+bounces-50223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB00A24342
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 20:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB40018895A4
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 19:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF051F37DA;
	Fri, 31 Jan 2025 19:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NR6ExAz4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB6E1F151B;
	Fri, 31 Jan 2025 19:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738351766; cv=none; b=Pbfs7Nx1j5J6AAKsBF7SRvNi17qvvmN+0pQKgnPAnehMbVAQZc6+8klHgWYhMvH6Jz+wHgw98mHaWY5fJAGwPX3k+/4bQMTvQ4D2ThLOeYf77PdYw2mxA4IEwZC5FYS1hraDGQ4KVNSku536vto+Vjmuuy9kQgq6EXgxbkCf1OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738351766; c=relaxed/simple;
	bh=GD7R+Fz4eBNAaJo5wZU20CAbH/D/Hyf5K5x+UBCLZX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHIaEQYvzk0vFu6v5Y5KIhTF0tCZHuelXqi2mp/0mtHhKCRhPDjR1ISyPWRxueC3QpXW15Zv+QgJJxk4qAC9ZDPE3PxnvjNsi1CvcgugV3NRKmdE0uxvXaOWk9T7MmgxJeLsskUUNtZ6KoQ06EH4tLtS1Kck9uj8TvX6o2BnqW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NR6ExAz4; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ee51f8c47dso3251273a91.1;
        Fri, 31 Jan 2025 11:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738351764; x=1738956564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+ZK19OjatDB2LUHgojb+T0W7QGgqPbstXnyVAy8ynY=;
        b=NR6ExAz4jGwfdjj0nlxUAkeXgHcCeU7SSeKoxbjGS04mjH1JniI8aodziath0O3YIq
         O03lrdMHaSN3s93RYH9qpFMKn2RkdTA1TivlSm4+oZ6K+1NeP7l57Lb0sK2tBy4Sz1v3
         w5QPKWyWT+FUCa7rWg9OLjhLpzAj+Np3Dy53EoVtdV3DY0AqpY4wBeWythYIsQXJBt7u
         52nzj0lVIhqMXsRIEtSIEdnZtNwERn5Gq25RRtgYy5929GmSsH/hF6IuT07Llrddn+4r
         UuQGWpwT0/T9UhNNKwkkETsK+okV0WrCymbqVkWAZW8Mz5slPtV27elAs8M5OgUUEfQq
         q4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738351764; x=1738956564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S+ZK19OjatDB2LUHgojb+T0W7QGgqPbstXnyVAy8ynY=;
        b=I4uIht1vAw1Dr56FR/xkyUU4zSy07cztj06KfzPgfJ0utZV0iATJyZQ4QksMz1E5e3
         lKK6XBidBC4aHdbKVNmzL5U7+zpPGQpra5+fwDqeIoWjQA0h5Yu2Wi8I5raFL9IQOcNl
         ewtxegxi2UDWogL6RDsi2dJQe5owSSluvPuc/FI9zqYTQYUHJj02L2TIk1oE4XerK4TC
         pAmBn63qviYguklfICflPcnJcUw5ZRpFIWGnb7UwqJwiWvvFLnPzsk0NG3Q9qLwna6vp
         WiPJMRQDCUbvJeCO96HCEk48iWyUGgwpnzefz42PS72OMshl7jMc94gqEUc1eWA2MKUV
         9j/A==
X-Gm-Message-State: AOJu0Yy2jwfsQN+XGSgAuBnRzLSpEN62Z/Et4+31wi7UP/bOMNmTwZSk
	l+FORYHShgCZ/LmtlnQzBmHPQ0r8DFsi6dB8o+Lcu7lD5GLZ5XTYhUcBrGQHf9o=
X-Gm-Gg: ASbGnctHqr6BFz4ISL5z52z7XSFvPKp4/AAay86NitmVqK5sNH77DlMbwVwYsi3awdA
	RmfEXtnJfxE5z24LMmeor1N3lYkDfqt1dwln+fFBS6xeP7wnw0VdLhCQVv+iph0JHdr17RBKfeF
	3OMBqSQUzIR29lxrrVFK6ipePcN1w9q94fLZLD/Gknb0DkDWTU/MTwYhXhEmk3XD62ASVWNL0kc
	ncKfqhJ/GnUqibxpxNrryoY2FNMVWzOXd0f2W2pkIv1w4Klupxp1/2f2iBiN4DJW2C/Gu/nuvUK
	U8H3UNKoRuB8CmqAxZ1SR5brPvQ1OXBI4IYzjYNqsJ5TEFwK9fhUdcoMJqEnyPG+Tg==
X-Google-Smtp-Source: AGHT+IGLJvi91GSVyozQ9nuQWbP2qMuqj9BBtTq02cmSKq08T21U4bZpAk+VbUD358Gowfy+JEvfbQ==
X-Received: by 2002:a17:90b:2702:b0:2ee:f440:53ed with SMTP id 98e67ed59e1d1-2f83ac83923mr16580288a91.31.1738351763959;
        Fri, 31 Jan 2025 11:29:23 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f8489d3707sm4072471a91.23.2025.01.31.11.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 11:29:23 -0800 (PST)
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
	ming.lei@redhat.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 02/18] bpf: Support getting referenced kptr from struct_ops argument
Date: Fri, 31 Jan 2025 11:28:41 -0800
Message-ID: <20250131192912.133796-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131192912.133796-1-ameryhung@gmail.com>
References: <20250131192912.133796-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amery Hung <amery.hung@bytedance.com>

Allows struct_ops programs to acqurie referenced kptrs from arguments
by directly reading the argument.

The verifier will acquire a reference for struct_ops a argument tagged
with "__ref" in the stub function in the beginning of the main program.
The user will be able to access the referenced kptr directly by reading
the context as long as it has not been released by the program.

This new mechanism to acquire referenced kptr (compared to the existing
"kfunc with KF_ACQUIRE") is introduced for ergonomic and semantic reasons.
In the first use case, Qdisc_ops, an skb is passed to .enqueue in the
first argument. This mechanism provides a natural way for users to get a
referenced kptr in the .enqueue struct_ops programs and makes sure that a
qdisc will always enqueue or drop the skb.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 include/linux/bpf.h         |  3 +++
 kernel/bpf/bpf_struct_ops.c | 26 ++++++++++++++++++++------
 kernel/bpf/btf.c            |  1 +
 kernel/bpf/verifier.c       | 35 ++++++++++++++++++++++++++++++++---
 4 files changed, 56 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f4df39e8c735..15164787ce7f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -968,6 +968,7 @@ struct bpf_insn_access_aux {
 		struct {
 			struct btf *btf;
 			u32 btf_id;
+			u32 ref_obj_id;
 		};
 	};
 	struct bpf_verifier_log *log; /* for verbose logs */
@@ -1481,6 +1482,8 @@ struct bpf_ctx_arg_aux {
 	enum bpf_reg_type reg_type;
 	struct btf *btf;
 	u32 btf_id;
+	u32 ref_obj_id;
+	bool refcounted;
 };
 
 struct btf_mod_pair {
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 9b7f3b9c5262..68df8d8b6db3 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -146,6 +146,7 @@ void bpf_struct_ops_image_free(void *image)
 }
 
 #define MAYBE_NULL_SUFFIX "__nullable"
+#define REFCOUNTED_SUFFIX "__ref"
 
 /* Prepare argument info for every nullable argument of a member of a
  * struct_ops type.
@@ -174,11 +175,13 @@ static int prepare_arg_info(struct btf *btf,
 			    struct bpf_struct_ops_arg_info *arg_info)
 {
 	const struct btf_type *stub_func_proto, *pointed_type;
+	bool is_nullable = false, is_refcounted = false;
 	const struct btf_param *stub_args, *args;
 	struct bpf_ctx_arg_aux *info, *info_buf;
 	u32 nargs, arg_no, info_cnt = 0;
 	char ksym[KSYM_SYMBOL_LEN];
 	const char *stub_fname;
+	const char *suffix;
 	s32 stub_func_id;
 	u32 arg_btf_id;
 	int offset;
@@ -223,12 +226,19 @@ static int prepare_arg_info(struct btf *btf,
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
@@ -236,7 +246,7 @@ static int prepare_arg_info(struct btf *btf,
 		if (!pointed_type ||
 		    !btf_type_is_struct(pointed_type)) {
 			pr_warn("stub function %s has %s tagging to an unsupported type\n",
-				stub_fname, MAYBE_NULL_SUFFIX);
+				stub_fname, suffix);
 			goto err_out;
 		}
 
@@ -254,11 +264,15 @@ static int prepare_arg_info(struct btf *btf,
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
index 9de6acddd479..fd3470fbd144 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6677,6 +6677,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			info->reg_type = ctx_arg_info->reg_type;
 			info->btf = ctx_arg_info->btf ? : btf_vmlinux;
 			info->btf_id = ctx_arg_info->btf_id;
+			info->ref_obj_id = ctx_arg_info->refcounted ? ctx_arg_info->ref_obj_id : 0;
 			return true;
 		}
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a41ba019780f..a0f51903e977 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1543,6 +1543,17 @@ static void release_reference_state(struct bpf_verifier_state *state, int idx)
 	return;
 }
 
+static bool find_reference_state(struct bpf_verifier_state *state, int ptr_id)
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
 static int release_lock_state(struct bpf_verifier_state *state, int type, int id, void *ptr)
 {
 	int i;
@@ -5981,7 +5992,8 @@ static int check_packet_access(struct bpf_verifier_env *env, u32 regno, int off,
 /* check access to 'struct bpf_context' fields.  Supports fixed offsets only */
 static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int off, int size,
 			    enum bpf_access_type t, enum bpf_reg_type *reg_type,
-			    struct btf **btf, u32 *btf_id, bool *is_retval, bool is_ldsx)
+			    struct btf **btf, u32 *btf_id, bool *is_retval, bool is_ldsx,
+			    u32 *ref_obj_id)
 {
 	struct bpf_insn_access_aux info = {
 		.reg_type = *reg_type,
@@ -6003,8 +6015,16 @@ static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int off,
 		*is_retval = info.is_retval;
 
 		if (base_type(*reg_type) == PTR_TO_BTF_ID) {
+			if (info.ref_obj_id &&
+			    !find_reference_state(env->cur_state, info.ref_obj_id)) {
+				verbose(env, "invalid bpf_context access off=%d. Reference may already be released\n",
+					off);
+				return -EACCES;
+			}
+
 			*btf = info.btf;
 			*btf_id = info.btf_id;
+			*ref_obj_id = info.ref_obj_id;
 		} else {
 			env->insn_aux_data[insn_idx].ctx_field_size = info.ctx_field_size;
 		}
@@ -7367,7 +7387,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 		struct bpf_retval_range range;
 		enum bpf_reg_type reg_type = SCALAR_VALUE;
 		struct btf *btf = NULL;
-		u32 btf_id = 0;
+		u32 btf_id = 0, ref_obj_id = 0;
 
 		if (t == BPF_WRITE && value_regno >= 0 &&
 		    is_pointer_value(env, value_regno)) {
@@ -7380,7 +7400,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			return err;
 
 		err = check_ctx_access(env, insn_idx, off, size, t, &reg_type, &btf,
-				       &btf_id, &is_retval, is_ldsx);
+				       &btf_id, &is_retval, is_ldsx, &ref_obj_id);
 		if (err)
 			verbose_linfo(env, insn_idx, "; ");
 		if (!err && t == BPF_READ && value_regno >= 0) {
@@ -7411,6 +7431,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 				if (base_type(reg_type) == PTR_TO_BTF_ID) {
 					regs[value_regno].btf = btf;
 					regs[value_regno].btf_id = btf_id;
+					regs[value_regno].ref_obj_id = ref_obj_id;
 				}
 			}
 			regs[value_regno].type = reg_type;
@@ -22148,6 +22169,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 {
 	bool pop_log = !(env->log.level & BPF_LOG_LEVEL2);
 	struct bpf_subprog_info *sub = subprog_info(env, subprog);
+	struct bpf_prog_aux *aux = env->prog->aux;
 	struct bpf_verifier_state *state;
 	struct bpf_reg_state *regs;
 	int ret, i;
@@ -22255,6 +22277,13 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 		mark_reg_known_zero(env, regs, BPF_REG_1);
 	}
 
+	/* Acquire references for struct_ops program arguments tagged with "__ref" */
+	if (!subprog && env->prog->type == BPF_PROG_TYPE_STRUCT_OPS) {
+		for (i = 0; i < aux->ctx_arg_info_size; i++)
+			aux->ctx_arg_info[i].ref_obj_id = aux->ctx_arg_info[i].refcounted ?
+							  acquire_reference(env, 0) : 0;
+	}
+
 	ret = do_check(env);
 out:
 	/* check for NULL is necessary, since cur_state can be freed inside
-- 
2.47.1



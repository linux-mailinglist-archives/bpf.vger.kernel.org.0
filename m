Return-Path: <bpf+bounces-47469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D556A9F9AC4
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 20:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFE441898094
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 19:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B52225A2A;
	Fri, 20 Dec 2024 19:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vuq2+3dL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF452253E7;
	Fri, 20 Dec 2024 19:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734724592; cv=none; b=fuKUX/RlNA9LZNnPbpOf0c8giRJUB7zH9ARtC3rAbRTZKNMYFpF0Zgdxl8oKID/j3IcgjW+vDcVw2q6RUL4jV7Iq/WKybvvpYCIA8pgEl7K+t4PLyDoufcbTfWHW49ytxd0O6FQQGjgKqdioQZMhIKrbEPEAseV9ykJR9HsU7D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734724592; c=relaxed/simple;
	bh=myi40Nh8v64VFaHkmVIShZ8caoMm3/T6dlJdNLjNHEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MAnkR70MNlN3dVSfWAq+duusPubX3ZzJBh6hp7xB7UjyTyQEeXAXt25IFOqf+6If6SNwh16bZq0gf8+MACEozJb0xJ5m1lWO3WwEQ1qpvMwgS5yVH/Ts16/v3CZKgRkcEnVb+drUYaVBmK92zW0Hubt6rVO+MygyG0Fq9dYOvUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vuq2+3dL; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7fd51285746so1477596a12.3;
        Fri, 20 Dec 2024 11:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734724590; x=1735329390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFA6erE2CmR1ftMlIX2fPD8J/Ca+GzqoMDbQfYyUDV4=;
        b=Vuq2+3dLwXAxW9bYVbdvZaV/M5P63lt69Lp7Z+KXTQSb6MOf7B14m38NCE6guCj7vN
         aOJ6QnalQsXjffu5sA++mMFgSpnBCVY8kCPDc5vFzcBlA2HqhmjIx7qDIcKVQIVU77R0
         LQBEOg1ktWnGBBwmViKZ5xkwfpHZJSIuMD/duBQpCdnp9TN/L0RorSkG9zctfuIOx/9a
         +bj+vvmHe/464zwYwepfZUinT3WaG+0QxdtGF8Ni3Ynoeg2QMUNzy0gwv4NFbdB63GLa
         Bj6uS8CCuKL1drfAIhK1eFJTlRyg0SS6bRIQlw0UygRdMYU60hb7/EBBPWTP/pY/e2RE
         ylsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734724590; x=1735329390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFA6erE2CmR1ftMlIX2fPD8J/Ca+GzqoMDbQfYyUDV4=;
        b=DBanfIgNAk3wYlprGWF5bbdSbwclJP56S64w8BljLtsK7/KEmN2L68Y32Ciz5+0yrR
         plGrRlWMps4eLiHhda93azdA4BXefRMVX6ZZP8TBbRalsuFPgtaleiEhSRBVy8VykYRq
         WTtxJ7beOawFrZ8/i45aP+iattoucjTYQ7CmPjcYMARpJnxpAEjlrKgpK2T1BIbQt89g
         UeFoBxDRYMslqQGvqC+dn2O4JdO69VRDosyL7qLCkC4kObkSb3nA5SoUMRRULXBrxRya
         AggkVBfNmTt2GEAbBa9wu69AMz5hGSoKS87mKmpa1tuAwtEuRw0CCsOlGgbkPTUYNhYj
         yBPg==
X-Gm-Message-State: AOJu0YyRbdP1y4JbFlE62+jxsmsFgLTfLRUK9UgOCK74eQS17qmNknYO
	le0NZBHw9KF+60yf2VbGJ90T2lJwKUJoqMh6jg7WDao0Q1WiEfWunGHBUw==
X-Gm-Gg: ASbGncvCQMSSqFMVWN0kvsqumhnOU1R4AhHLBgAJ3jSE6LbNqxMLWbbd+L6AW1/hU6d
	0HLi31p5G0ZOaRtimXmGX5KU2+9YsE33DPZ1geQVS112tp2sNBuNX/tAjhDc9CPhObcKK7TzfEe
	dnsZ8+hW5k/efMeLjZvbbz3kqskgsk63cCwv1i8JCCXWwYlxmrOB4WjzHLbg6USljKJSgLOyCtb
	K9a3hhHEJhO4U2Vp+u0tSJWlkBgI7KIK3imZlKiXAGSJP0RzYZ81W6KYUwbg5/bUXT4cohCG7KT
	nXhB7Ou9UabjNehCQCL1wS9cREBBIfn6
X-Google-Smtp-Source: AGHT+IHW40CsNcWYIjdG4pIllm1X25htXClnzKZd0E3yWM5CsHJ240/E/Hd2oTU0WfFmgnPhfsdatw==
X-Received: by 2002:a05:6a20:d499:b0:1d9:c615:d1e6 with SMTP id adf61e73a8af0-1e5dfb65989mr6866348637.0.1734724589665;
        Fri, 20 Dec 2024 11:56:29 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b17273dasm3240342a12.19.2024.12.20.11.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 11:56:29 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	amery.hung@bytedance.com
Subject: [PATCH bpf-next v2 01/14] bpf: Support getting referenced kptr from struct_ops argument
Date: Fri, 20 Dec 2024 11:55:27 -0800
Message-ID: <20241220195619.2022866-2-amery.hung@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241220195619.2022866-1-amery.hung@gmail.com>
References: <20241220195619.2022866-1-amery.hung@gmail.com>
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
 include/linux/bpf.h         |  2 ++
 kernel/bpf/bpf_struct_ops.c | 26 ++++++++++++++++++++------
 kernel/bpf/btf.c            |  3 ++-
 kernel/bpf/verifier.c       | 37 ++++++++++++++++++++++++++++++++++---
 4 files changed, 58 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index feda0ce90f5a..2556f8043276 100644
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
@@ -1481,6 +1482,7 @@ struct bpf_ctx_arg_aux {
 	enum bpf_reg_type reg_type;
 	struct btf *btf;
 	u32 btf_id;
+	bool refcounted;
 };
 
 struct btf_mod_pair {
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 606efe32485a..d9e0af00580b 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -146,6 +146,7 @@ void bpf_struct_ops_image_free(void *image)
 }
 
 #define MAYBE_NULL_SUFFIX "__nullable"
+#define REFCOUNTED_SUFFIX "__ref"
 #define MAX_STUB_NAME 128
 
 /* Return the type info of a stub function, if it exists.
@@ -207,9 +208,11 @@ static int prepare_arg_info(struct btf *btf,
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
 
@@ -241,12 +244,19 @@ static int prepare_arg_info(struct btf *btf,
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
@@ -254,7 +264,7 @@ static int prepare_arg_info(struct btf *btf,
 		if (!pointed_type ||
 		    !btf_type_is_struct(pointed_type)) {
 			pr_warn("stub function %s__%s has %s tagging to an unsupported type\n",
-				st_ops_name, member_name, MAYBE_NULL_SUFFIX);
+				st_ops_name, member_name, suffix);
 			goto err_out;
 		}
 
@@ -272,11 +282,15 @@ static int prepare_arg_info(struct btf *btf,
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
index 28246c59e12e..c2f4f84e539d 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6546,7 +6546,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 	const struct btf_param *args;
 	bool ptr_err_raw_tp = false;
 	const char *tag_value;
-	u32 nr_args, arg;
+	u32 nr_args, arg, nr_ref_args = 0;
 	int i, ret;
 
 	if (off % 8) {
@@ -6682,6 +6682,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			info->reg_type = ctx_arg_info->reg_type;
 			info->btf = ctx_arg_info->btf ? : btf_vmlinux;
 			info->btf_id = ctx_arg_info->btf_id;
+			info->ref_obj_id = ctx_arg_info->refcounted ? ++nr_ref_args : 0;
 			return true;
 		}
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f27274e933e5..26305571e377 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1542,6 +1542,17 @@ static void release_reference_state(struct bpf_verifier_state *state, int idx)
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
@@ -5980,7 +5991,8 @@ static int check_packet_access(struct bpf_verifier_env *env, u32 regno, int off,
 /* check access to 'struct bpf_context' fields.  Supports fixed offsets only */
 static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int off, int size,
 			    enum bpf_access_type t, enum bpf_reg_type *reg_type,
-			    struct btf **btf, u32 *btf_id, bool *is_retval, bool is_ldsx)
+			    struct btf **btf, u32 *btf_id, bool *is_retval, bool is_ldsx,
+			    u32 *ref_obj_id)
 {
 	struct bpf_insn_access_aux info = {
 		.reg_type = *reg_type,
@@ -6002,8 +6014,16 @@ static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int off,
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
@@ -7369,7 +7389,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 		struct bpf_retval_range range;
 		enum bpf_reg_type reg_type = SCALAR_VALUE;
 		struct btf *btf = NULL;
-		u32 btf_id = 0;
+		u32 btf_id = 0, ref_obj_id = 0;
 
 		if (t == BPF_WRITE && value_regno >= 0 &&
 		    is_pointer_value(env, value_regno)) {
@@ -7382,7 +7402,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			return err;
 
 		err = check_ctx_access(env, insn_idx, off, size, t, &reg_type, &btf,
-				       &btf_id, &is_retval, is_ldsx);
+				       &btf_id, &is_retval, is_ldsx, &ref_obj_id);
 		if (err)
 			verbose_linfo(env, insn_idx, "; ");
 		if (!err && t == BPF_READ && value_regno >= 0) {
@@ -7413,6 +7433,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 				if (base_type(reg_type) == PTR_TO_BTF_ID) {
 					regs[value_regno].btf = btf;
 					regs[value_regno].btf_id = btf_id;
+					regs[value_regno].ref_obj_id = ref_obj_id;
 				}
 			}
 			regs[value_regno].type = reg_type;
@@ -22161,6 +22182,16 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 		mark_reg_known_zero(env, regs, BPF_REG_1);
 	}
 
+	/* Acquire references for struct_ops program arguments tagged with "__ref".
+	 * These should be the earliest references acquired. btf_ctx_access() will
+	 * assume the ref_obj_id of the n-th __ref-tagged argument to be n.
+	 */
+	if (!subprog && env->prog->type == BPF_PROG_TYPE_STRUCT_OPS) {
+		for (i = 0; i < env->prog->aux->ctx_arg_info_size; i++)
+			if (env->prog->aux->ctx_arg_info[i].refcounted)
+				acquire_reference(env, 0);
+	}
+
 	ret = do_check(env);
 out:
 	/* check for NULL is necessary, since cur_state can be freed inside
-- 
2.47.0



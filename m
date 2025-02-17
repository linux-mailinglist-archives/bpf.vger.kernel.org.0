Return-Path: <bpf+bounces-51772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0D0A38BF5
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 20:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7F7616DC29
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 19:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7141236A8B;
	Mon, 17 Feb 2025 19:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcOFEJlV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858F3236A68
	for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 19:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739819215; cv=none; b=FBr4L5WXh6hOhghl/P6SadBnqArc+YIFm2UITXsc1qkbzwD3zJbv9UPIkPlg4JJN4g7Fxyg7vZ65z0APE0egLoo7b0p59Io26Djbe7vHcreknL1NzfHxaWRaD1R6VJ641/rJVcRHN0j5EpHDZ64+8P1sc9aNR9yjwhxz0bqOV/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739819215; c=relaxed/simple;
	bh=ODPBYV298PYkcQfCLWEggs3KJ05N5DTIJR0AaHwN66o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aguo+1yqEWyxVjQqrbYUL+h4BhOFsmYTK/O6sELp/nSZ6t2uEP+LvQAXC1ZgyheTVTjv0r9GBxHXTXSttlOCQ/wUm0XtamLgCxVPxcZdcTbB6w88qsOZQaUxN+SayJfgo9uCYQhFg63MEVhwqfAjNAJCI0tnaoVqfIvraXvs8f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcOFEJlV; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fc3fa00323so4856131a91.3
        for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 11:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739819212; x=1740424012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubN0oF4291dYn/aGRjYnV4QAGKceabmyOp6gsdx0Svs=;
        b=JcOFEJlVqf5lY/AM79QG4P217EDqg9062VRmbvD8i2K8MSBY7bd0aOk2Ke+/7TTvJw
         K0RgDlujZAfe1+oZuX3DI3bx8FxZWepYYVS8zzcXazng6l91nWzZt30U0erWU5EWHyO3
         7Q6qKulwZEOT8ekRySRVqy0KhS4LUiot0aGt1sH3hkV5bVO8jCFUsJEQMAm9/9YaVYOR
         NmrbubuadnOzXsT+Opxb2DLmGvsn/i1zJz7dcCOydkwKpTDxMWxa4fkVMgmI+CpO42Rc
         oTVB+ErJH7KIw4ydSZ2IlRaonKUNCnsNmbsulptQ7X5UXhz3ruyLZc0RyDi4UVXZ3ofR
         gXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739819212; x=1740424012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubN0oF4291dYn/aGRjYnV4QAGKceabmyOp6gsdx0Svs=;
        b=f/6oBUZC1whiZRuAd4jGLkfT+o4GRsoJIUVO/cozQdfkotDH1nhMXxyfT02DlBYi6b
         yp+XC0zbdt2uplwxG3AebdsyiUNExY96ee2820F9+hiVuYROptb68CPfeIH/7LjtE0NA
         reYPPk+yqcZlQfkgZuSFUf8noHzCFq4iWfNm6nbeXozRCFcPvNGxImHULW+yD9/qTSVP
         kG1vAcnACCaWdbKsJJJx6uBiz5ALTx4iqaRRz2kMBw0kSNyF1zBWp+y+VSFZq978LUJJ
         KSmEADBlc2ZSha7iBGCQQ8kPU+Xv9xWP3BW9dkRr1HoNQaC1U4Q3/FypZQZ0k+L5BWio
         YCSA==
X-Gm-Message-State: AOJu0YyrTlCCdB13KNEF1uhpv2qhmqTupg4gXTkemkb6WHUwaFlEcJhP
	UfSyAl7ISGQRPrTkAKxq1A9B5JunP6+yrYEiceNxYueK17qRsv1gxF6Rpw==
X-Gm-Gg: ASbGncvuLFqvX/x2TA92fJ6ByqAwd+byoZn6oKyoTO4dPKcW02TzyrzxK/n1Tzc2NfK
	G3umCJQ8DIe8WWS/wvRSaB2toHq3xuvz77mzeFVXUXAJoY45OfOfwzSos8lDPfhwwyqRQpVaW4y
	u/5XQTb8hnsw69W9cXV1CzWTBC0Tv6H/SupgcUKsYes54ISwLUmmXmAVJQSsa9bwwzxIg0Q29El
	9peL8a4it/5YURrNVJhl8bRZQunrA7Bw7IWPpPpd37NM9UbMW6lcUr7Pu4IA8I8zUqCwCS2awqD
	Vf+Tyuy3M0CeG8YAfkAT11752RNhDp9KQbcWZQl0s1jSnvp2Q4tcz3aRKtAsq5+Xvw==
X-Google-Smtp-Source: AGHT+IFdVkXFqwj89ttHaG4BQlr4SkplbeVOcSFscLL9K/RFaiv3KE4VjOAiKX3JcukPHNBCjq7gnA==
X-Received: by 2002:a05:6a00:18a4:b0:732:5696:51db with SMTP id d2e1a72fcca58-732618f5719mr19741632b3a.24.1739819212534;
        Mon, 17 Feb 2025 11:06:52 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73265f98e18sm5039118b3a.106.2025.02.17.11.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 11:06:51 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 2/5] bpf: Support getting referenced kptr from struct_ops argument
Date: Mon, 17 Feb 2025 11:06:37 -0800
Message-ID: <20250217190640.1748177-3-ameryhung@gmail.com>
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
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 include/linux/bpf.h         |  3 +++
 kernel/bpf/bpf_struct_ops.c | 27 +++++++++++++++++++++------
 kernel/bpf/btf.c            |  1 +
 kernel/bpf/verifier.c       | 35 ++++++++++++++++++++++++++++++++---
 4 files changed, 57 insertions(+), 9 deletions(-)

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
index 9b7f3b9c5262..0ef00f7f64c9 100644
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
@@ -223,10 +226,18 @@ static int prepare_arg_info(struct btf *btf,
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
+
+		if (is_nullable)
+			suffix = MAYBE_NULL_SUFFIX;
+		else if (is_refcounted)
+			suffix = REFCOUNTED_SUFFIX;
+		else
 			continue;
 
 		/* Should be a pointer to struct */
@@ -236,7 +247,7 @@ static int prepare_arg_info(struct btf *btf,
 		if (!pointed_type ||
 		    !btf_type_is_struct(pointed_type)) {
 			pr_warn("stub function %s has %s tagging to an unsupported type\n",
-				stub_fname, MAYBE_NULL_SUFFIX);
+				stub_fname, suffix);
 			goto err_out;
 		}
 
@@ -254,11 +265,15 @@ static int prepare_arg_info(struct btf *btf,
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
index 9de6acddd479..7a7e02dcde84 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6677,6 +6677,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			info->reg_type = ctx_arg_info->reg_type;
 			info->btf = ctx_arg_info->btf ? : btf_vmlinux;
 			info->btf_id = ctx_arg_info->btf_id;
+			info->ref_obj_id = ctx_arg_info->ref_obj_id;
 			return true;
 		}
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 851bcaeaaddf..9941ce754134 100644
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



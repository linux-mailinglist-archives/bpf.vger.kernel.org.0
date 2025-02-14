Return-Path: <bpf+bounces-51576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE629A36361
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 17:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C16623A6E38
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 16:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC090267AE8;
	Fri, 14 Feb 2025 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUXjVLL6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F1126772F
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 16:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739551534; cv=none; b=ckKX713OjUkVvRsvdL2SvCuCbJsQgOWpTvRRAMKHGFLqqCs+IJUcky1PGvKk/KbyNWrmd6fC5N80gIGtVpXw5eBeojQ8/S9unFsf4XPM3uG0BjjbCxkGZrEioIQC9B8hFnfgOOPtzj6bUPJdt7fFqOESElcdVwUadxQDxrVY++0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739551534; c=relaxed/simple;
	bh=yeZJv/5oACo15YEXXmcTwVJDy89oXjHZmA6y15XJmEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h742AU7FQWrAT/biwlWK6JNYYdGjZPaQRwlWolzN62gUv5ZLd4YPG9QENKqBG7IgC2ld7yZWHXgJWtx/py+c1QI41a7LKgCnOyZDj78XG4OgDG3O3SSrrhpzJ7DJpN+E8JZEdeRhygSMBCffNTrMVr7lBfcKEAsWUjlRSewCak4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUXjVLL6; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220c8f38febso42926105ad.2
        for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 08:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739551532; x=1740156332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eol6oaMq93kxYk9VK5G7LDWWkiciy0WsGg/oN96JGJ0=;
        b=iUXjVLL6vgDgGHe4IPgVR/2iypEg3nfKMvqB5g7NrB5ti7w4LzjfpdMymxb/RGQdq8
         OkKsvkSdOLj2lCi1vnP6g5N8b7IUpeoz2cZucHwDP6ojCHUB5GDFxKq94DgweYLljuAD
         e8KD/CuyWMiaLXql4DrpIlhXP+zZp+avBMJE3hkr2bshLYbb1z646i6SYH/I/j8YZGKl
         C5zu7gGWXZj4UpU9+/zUxa3vWdp0B1scWKJUpFye+TBJfAQFxFW5CHn6qYAaU4AxEbmP
         R2yxeAWDcN5wgT1k4fAzwQJ76iHPFs8Wl66xBpkDFshoaAckB6w58jQNExOts85j55VR
         Tr3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739551532; x=1740156332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eol6oaMq93kxYk9VK5G7LDWWkiciy0WsGg/oN96JGJ0=;
        b=w5ik6Zens3JqfTTBmXlfCmDStOqYMbpl9zBhl0znNfegYYT7J5W7dwYuoPHzfI8XO0
         S77YDPZu6sQtDhH+mx8XH5SGSwIaN6/BvEkcWPhs2Yazhltzg5X37yYgkYj/4XjR170v
         GVaq2MsdL9hkgAvhwPEzkVNOMV1ceukjE7XWGbAoL36gJBZAdyKnO2o6+d7kgzsQm3EX
         3VPNBu0aPpZHHf4Tf5OZQAMleQVRgH0o6sr7rV91XbG3gTWrR63atjtJs+aDykECVi57
         n3A0A3m8z29Tu+3AfTIu54ifD/KumVU7VqcTF/I5AKENHybhWqBGe2Jlw/CE0m+satWN
         qSmA==
X-Gm-Message-State: AOJu0YyzVhjtdmm2rbXKW9BZE23jQgeY7GQNDiZA2GdPLXxR0YSD/6hk
	cIGz8S9ELss0GqW1g5slA23WG+Dq+JwJF31SYSQBkP0tGs8NaAMNuNIPBQ==
X-Gm-Gg: ASbGncuvum9G/cSe6tP2fo39Rzvv7PwEk9jil4D4DYEW7jDQzeBdEGafYPRElCNaVwW
	3liopNndD5l0M91ItKEGHvqUBHasjztDeX73tnCq47xl4pzIpjrv7oh3TskqE6QpBTc+wNrRHAw
	WER1f0btteoPNjeXBEJYnSA8mXiQvRc1jTwdGeQwCl7QEI4tR8/AWvuf27+4aYBaIW75cFXl1Wp
	4tHm4nAgRw9xwJaADHvSnbFNFR4Vjl0iHP1zVKyXiSWeg963SaucNuUJ7gLAiJfp63WFQaTqlna
	rsp7RT8UfsYx29+QD0l/Gjh1HbDQM2tF/w95P1XPTUFKhgJKFygTk+pPRW+++t/Rgg==
X-Google-Smtp-Source: AGHT+IHx70eukTkuSZewCWhp6flSXMfPbZUKfdgvZ+9watd4UMOcsNIIENE6UlglBoW6M2hlmCC68w==
X-Received: by 2002:a05:6a20:43a0:b0:1e6:5323:58cb with SMTP id adf61e73a8af0-1ee8cb8141amr244870637.23.1739551531528;
        Fri, 14 Feb 2025 08:45:31 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adbf21517eesm2223346a12.13.2025.02.14.08.45.30
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
Subject: [PATCH bpf-next v1 2/5] bpf: Support getting referenced kptr from struct_ops argument
Date: Fri, 14 Feb 2025 08:45:17 -0800
Message-ID: <20250214164520.1001211-3-ameryhung@gmail.com>
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



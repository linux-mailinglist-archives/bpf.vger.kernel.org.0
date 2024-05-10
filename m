Return-Path: <bpf+bounces-29520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D4A8C2A77
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 21:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAEA51C2172A
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 19:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C944AEC1;
	Fri, 10 May 2024 19:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYgJDVCs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402BB47A70;
	Fri, 10 May 2024 19:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715369056; cv=none; b=qysCPhXR7Uynr33oz5wnEtiqL9e8PlyUsPGElcBXjrt78rm9WiWbw+i9RJzf1JkuKPw4Y+TORAjrqi/EL5pQPgAT0vlkPwRoM5GGhc7GcUOcrnu7CwaLJQrzQ2e6v5Los/rpPIPU/ETzYNOJ3lin/tf89cMYrMfCIr+D+lzypJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715369056; c=relaxed/simple;
	bh=ZBOPkre873D94fGleWP36Xr4oz1szFk7Gu9NStRGk9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cmkqn39QJwkFPiCxsZtceXgR16AiWK9Oo3ig43bvSZuJjyElRTsNhbwAiWL9XY68ZGsM+3wMoHQC2/86psY42q60B5JPPHb4Dqhud341R1HL7bbpbvzncdsCFYBdnfVglUbMUS3xq2Li1c43UEKpmgW4KEkke8kqdRL0vaU6RkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYgJDVCs; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-43d269fa3bbso7246691cf.0;
        Fri, 10 May 2024 12:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715369054; x=1715973854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOuXQAEhKw3rJutNx8xAD21JV3BngUmgn6O7AAvUwcw=;
        b=VYgJDVCsmDbgMNXK/3QZ7gxsIadvThj79hlSodw94o+oo/BuB02VvCEbFHkdB89k/e
         2BdgN/2Sxm2Zr2gt/93EJLyw2f2SDmFxsKU/0jwp8SUZybpl/CgIHWy0uceVqJli6Cmn
         FggDcYmUGwiLXfM5mOw2cWTa84W7yz4YVmRV8U+wt3rCr9kaMoDSCy3qMaIrZjLfiLxA
         gelc8F/ztpdDYdRMwxyDAV9zXOJPdDU3fezM+W4wMIzx/ILjeq2oJ9QdElh1mrHrivdN
         /AG1+/kEax2bEW2w4prVQpbltwPpnUo9ZmXqypofTFxXJ5dUaFnUxGl7C5gWskVj93mB
         qQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715369054; x=1715973854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOuXQAEhKw3rJutNx8xAD21JV3BngUmgn6O7AAvUwcw=;
        b=lFc5Tj969M+HgwP6hiO4QeJA2te4npB0S8RSSCbz56exolWSMVpPxMPKCdzKoQEcx1
         3F06v+JgGkyAXiiqGJVsudsv3pUpFaIEARHCFuWGX8DHgktDsBiTDs4bq9YM5IGh+WUr
         N3kCAUGlKXRJfNdsXUWMi1Xt5CTokxsPDfBvA6G1UVGSbkcmJq4YK6M43uEciG8e7y5b
         AX64b8gkfKIaaYo2oJkHL2lSa9llX+sERZk26LhI3G0kST90pUd+yZemKIn9z6G+O3jW
         tVvnF2r2XCVPfOW69ZsHd/Sy6tHY2KPj2c9oOLpew89uJzayO7NiFv27KgHDRYubGtiO
         Di9Q==
X-Gm-Message-State: AOJu0YzXFoUolx6fWZjE9cpqwANOuCVoCgDsmMrZ9ERbD45Eefr56kxL
	CmYziUiO3Vt5LSl4HyS169HVgEnxScrKemPMHtztE0EEPc/QdrMYJDEQhg==
X-Google-Smtp-Source: AGHT+IF+TR7y7y+YfoQgO3rr6IK1e5lnG8WwMNIpDcLKo8V6nkfCKRzb1tyC1J3SYinSqV1dkv6Wkw==
X-Received: by 2002:a05:622a:14b:b0:439:8bae:6ab2 with SMTP id d75a77b69052e-43dfdac0abamr51650031cf.17.1715369054118;
        Fri, 10 May 2024 12:24:14 -0700 (PDT)
Received: from n36-183-057.byted.org ([147.160.184.83])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df5b46a26sm23863251cf.80.2024.05.10.12.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 12:24:13 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	yangpeihao@sjtu.edu.cn,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	sdf@google.com,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com
Subject: [RFC PATCH v8 01/20] bpf: Support passing referenced kptr to struct_ops programs
Date: Fri, 10 May 2024 19:23:53 +0000
Message-Id: <20240510192412.3297104-2-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240510192412.3297104-1-amery.hung@bytedance.com>
References: <20240510192412.3297104-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch supports struct_ops programs that acqurie referenced kptrs
throguh arguments. In Qdisc_ops, an skb is passed to ".enqueue" in the
first argument. The qdisc becomes the sole owner of the skb and must
enqueue or drop the skb. This matches the referenced kptr semantic
in bpf. However, the existing practice of acquiring a referenced kptr via
a kfunc with KF_ACQUIRE does not play well in this case. Calling kfuncs
repeatedly allows the user to acquire multiple references, while there
should be only one reference to a unique skb in a qdisc.

The solutioin is to make a struct_ops program automatically acquire a
referenced kptr through a tagged argument in the stub function. When
tagged with "__ref_acquired" (suggestion for a better name?), an
reference kptr (ref_obj_id > 0) will be acquired automatically when
entering the program. In addition, only the first read to the arguement
is allowed and it will yeild a referenced kptr.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 include/linux/bpf.h         |  3 +++
 kernel/bpf/bpf_struct_ops.c | 17 +++++++++++++----
 kernel/bpf/btf.c            | 10 +++++++++-
 kernel/bpf/verifier.c       | 16 +++++++++++++---
 4 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9c6a7b8ff963..6aabca1581fe 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -914,6 +914,7 @@ struct bpf_insn_access_aux {
 		struct {
 			struct btf *btf;
 			u32 btf_id;
+			u32 ref_obj_id;
 		};
 	};
 	struct bpf_verifier_log *log; /* for verbose logs */
@@ -1416,6 +1417,8 @@ struct bpf_ctx_arg_aux {
 	enum bpf_reg_type reg_type;
 	struct btf *btf;
 	u32 btf_id;
+	u32 ref_obj_id;
+	bool ref_acquired;
 };
 
 struct btf_mod_pair {
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 86c7884abaf8..bca8e5936846 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -143,6 +143,7 @@ void bpf_struct_ops_image_free(void *image)
 }
 
 #define MAYBE_NULL_SUFFIX "__nullable"
+#define REF_ACQUIRED_SUFFIX "__ref_acquired"
 #define MAX_STUB_NAME 128
 
 /* Return the type info of a stub function, if it exists.
@@ -204,6 +205,7 @@ static int prepare_arg_info(struct btf *btf,
 			    struct bpf_struct_ops_arg_info *arg_info)
 {
 	const struct btf_type *stub_func_proto, *pointed_type;
+	bool is_nullable = false, is_ref_acquired = false;
 	const struct btf_param *stub_args, *args;
 	struct bpf_ctx_arg_aux *info, *info_buf;
 	u32 nargs, arg_no, info_cnt = 0;
@@ -240,8 +242,11 @@ static int prepare_arg_info(struct btf *btf,
 		/* Skip arguments that is not suffixed with
 		 * "__nullable".
 		 */
-		if (!btf_param_match_suffix(btf, &stub_args[arg_no],
-					    MAYBE_NULL_SUFFIX))
+		is_nullable = btf_param_match_suffix(btf, &stub_args[arg_no],
+						     MAYBE_NULL_SUFFIX);
+		is_ref_acquired = btf_param_match_suffix(btf, &stub_args[arg_no],
+						       REF_ACQUIRED_SUFFIX);
+		if (!(is_nullable || is_ref_acquired))
 			continue;
 
 		/* Should be a pointer to struct */
@@ -269,11 +274,15 @@ static int prepare_arg_info(struct btf *btf,
 		}
 
 		/* Fill the information of the new argument */
-		info->reg_type =
-			PTR_TRUSTED | PTR_TO_BTF_ID | PTR_MAYBE_NULL;
 		info->btf_id = arg_btf_id;
 		info->btf = btf;
 		info->offset = offset;
+		if (is_nullable) {
+			info->reg_type = PTR_TRUSTED | PTR_TO_BTF_ID | PTR_MAYBE_NULL;
+		} else if (is_ref_acquired) {
+			info->reg_type = PTR_TRUSTED | PTR_TO_BTF_ID;
+			info->ref_acquired = true;
+		}
 
 		info++;
 		info_cnt++;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8c95392214ed..e462fb4a4598 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6316,7 +6316,8 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 
 	/* this is a pointer to another type */
 	for (i = 0; i < prog->aux->ctx_arg_info_size; i++) {
-		const struct bpf_ctx_arg_aux *ctx_arg_info = &prog->aux->ctx_arg_info[i];
+		struct bpf_ctx_arg_aux *ctx_arg_info =
+			(struct bpf_ctx_arg_aux *)&prog->aux->ctx_arg_info[i];
 
 		if (ctx_arg_info->offset == off) {
 			if (!ctx_arg_info->btf_id) {
@@ -6324,9 +6325,16 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 				return false;
 			}
 
+			if (ctx_arg_info->ref_acquired && !ctx_arg_info->ref_obj_id) {
+				bpf_log(log, "cannot acquire a reference to context argument offset %u\n", off);
+				return false;
+			}
+
 			info->reg_type = ctx_arg_info->reg_type;
 			info->btf = ctx_arg_info->btf ? : btf_vmlinux;
 			info->btf_id = ctx_arg_info->btf_id;
+			info->ref_obj_id = ctx_arg_info->ref_obj_id;
+			ctx_arg_info->ref_obj_id = 0;
 			return true;
 		}
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9f867fca9fbe..06a6edd306fd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5557,7 +5557,7 @@ static int check_packet_access(struct bpf_verifier_env *env, u32 regno, int off,
 /* check access to 'struct bpf_context' fields.  Supports fixed offsets only */
 static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int off, int size,
 			    enum bpf_access_type t, enum bpf_reg_type *reg_type,
-			    struct btf **btf, u32 *btf_id)
+			    struct btf **btf, u32 *btf_id, u32 *ref_obj_id)
 {
 	struct bpf_insn_access_aux info = {
 		.reg_type = *reg_type,
@@ -5578,6 +5578,7 @@ static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int off,
 		if (base_type(*reg_type) == PTR_TO_BTF_ID) {
 			*btf = info.btf;
 			*btf_id = info.btf_id;
+			*ref_obj_id = info.ref_obj_id;
 		} else {
 			env->insn_aux_data[insn_idx].ctx_field_size = info.ctx_field_size;
 		}
@@ -6833,7 +6834,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 	} else if (reg->type == PTR_TO_CTX) {
 		enum bpf_reg_type reg_type = SCALAR_VALUE;
 		struct btf *btf = NULL;
-		u32 btf_id = 0;
+		u32 btf_id = 0, ref_obj_id = 0;
 
 		if (t == BPF_WRITE && value_regno >= 0 &&
 		    is_pointer_value(env, value_regno)) {
@@ -6846,7 +6847,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			return err;
 
 		err = check_ctx_access(env, insn_idx, off, size, t, &reg_type, &btf,
-				       &btf_id);
+				       &btf_id, &ref_obj_id);
 		if (err)
 			verbose_linfo(env, insn_idx, "; ");
 		if (!err && t == BPF_READ && value_regno >= 0) {
@@ -6870,6 +6871,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 				if (base_type(reg_type) == PTR_TO_BTF_ID) {
 					regs[value_regno].btf = btf;
 					regs[value_regno].btf_id = btf_id;
+					regs[value_regno].ref_obj_id = ref_obj_id;
 				}
 			}
 			regs[value_regno].type = reg_type;
@@ -20426,6 +20428,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 {
 	bool pop_log = !(env->log.level & BPF_LOG_LEVEL2);
 	struct bpf_subprog_info *sub = subprog_info(env, subprog);
+	struct bpf_ctx_arg_aux *ctx_arg_info;
 	struct bpf_verifier_state *state;
 	struct bpf_reg_state *regs;
 	int ret, i;
@@ -20533,6 +20536,13 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 		mark_reg_known_zero(env, regs, BPF_REG_1);
 	}
 
+	if (env->prog->type == BPF_PROG_TYPE_STRUCT_OPS) {
+		ctx_arg_info = (struct bpf_ctx_arg_aux *)env->prog->aux->ctx_arg_info;
+		for (i = 0; i < env->prog->aux->ctx_arg_info_size; i++)
+			if (ctx_arg_info[i].ref_acquired)
+				ctx_arg_info[i].ref_obj_id = acquire_reference_state(env, 0);
+	}
+
 	ret = do_check(env);
 out:
 	/* check for NULL is necessary, since cur_state can be freed inside
-- 
2.20.1



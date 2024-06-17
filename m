Return-Path: <bpf+bounces-32300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B59490B1F3
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 16:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F5551C21834
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 14:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2101B1410;
	Mon, 17 Jun 2024 13:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZjS8279Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACD119B3D2
	for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 13:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718631847; cv=none; b=DrPLMVp3Ik+wc0gkwHy6QldG6x+G8pepgvliRy475P6qbDwVWHw1HXikPOKam/bd/NWPqiQ2GzeUX+MDMC+qT2Jp13Y3bLvTQqVwQw88JcNNlhCJ0TkkWa0bsR4kNmKdjQeJ/syaN1XynCfGmN39Sa50WTsmUt8J0tkKLMB8PMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718631847; c=relaxed/simple;
	bh=z6pT2uBX6gghrIIVN/jHhS1/mG/CROaVARmefHCzEBs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RbIvApwsCnKmuaigKf2JC7Z1SWSqW3LHUjUUVZzKgRwnochn/NDSlZAs3YI7PNGdW6h72AMeDw72Us6+Uf2vDkepHFD9X8S2e8WYeK0gMs5wSVSAIV+Ejw+/Y7fJRbuT/wuyUjzAou/XGCyoePG26JtgqIAU25JVstDPCFgV6RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZjS8279Y; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6f177b78dcso560616966b.1
        for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 06:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718631842; x=1719236642; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2GYK/kWGcnypuzcH/Fb5Y24D9dBQGcoMpcQ9bG1BJ4U=;
        b=ZjS8279Y6jav8ZpeBat8KqGcf3UvwS+yKHg6668w10o8z9pNOgHNfyqaycf2ucjCpi
         irV20YV3CHUhIG+aLbtaUn+FxzAC7jdlXx2qhl4YwGdo6Q78LOMVbEINzirIXfXlgJRg
         zAwqF4KMfdigVuOudYJMf32J6uCngflbK2F0sjI+artuLOa4brvZz2zz/5ZM0HpwLdy7
         KnLCl7K811nX5w2wgyseA0p/TQgy5sKVr/bc9aclnHxRgX4N7Nm2MuWwDrvb6jQpo6no
         Fw7fyu3zgKEY/PilyI+7NzXyxdKNfQ2Uq5ctM7ha7/mpempxksXkfZsdcey3lF3770TG
         Kuvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718631842; x=1719236642;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2GYK/kWGcnypuzcH/Fb5Y24D9dBQGcoMpcQ9bG1BJ4U=;
        b=m7tLZdO9/xYYhTeVBYwvasdq4+ZgoSKoyzk0XmM9/poeO5N3zbEGUcZSHoMhdxvTMk
         jXbwfLsCgZKF18Sb+S7+IOzV4rctB7y1ZqmF1+6MSyuaKQrl/M42s6ZpumGxeAsEwzO2
         0H7vyMsLm4Ho1bgCrHa5Xz1rSzMDMKKbRThcAhBIZrGaSYtOucOoKg4tilXwqtvDXS+p
         /5z2fRINEjhtT/ZmCcjhk+NfhfK5m91urERxZrzxOYAgaQVbDdSnvBKbC7QlrP0jwHMT
         Wiz9cPBRbyTH+Ktg6e+/lwU6RffmkwaV+tgaBWCmArorRltTBEha0j8OaLh+VQBP57Ho
         qruw==
X-Gm-Message-State: AOJu0Yz/wfXXYFIExqNjC2ojY4AQyKr25lib3aKVJ8hfAFhFEhUfBzXS
	vyZjji8je9Gio9VZgx8l1+VYpNkNhlhr4rt6rzb646/csNLmVCGNVBUMRZvWVW/2eWmLXE5wttI
	9bw==
X-Google-Smtp-Source: AGHT+IEJPPlpkTOSydjwIqUGxpScfKOJDPv49PwZ5ESP7I1fTxgLsXEcO6MjFGeYrJNi7R+uqxBRJw==
X-Received: by 2002:a17:906:7f82:b0:a6f:10a5:1ac2 with SMTP id a640c23a62f3a-a6f60dc2063mr565884366b.56.1718631841633;
        Mon, 17 Jun 2024 06:44:01 -0700 (PDT)
Received: from google.com (140.20.91.34.bc.googleusercontent.com. [34.91.20.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72e9115sm6472171a12.46.2024.06.17.06.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:44:01 -0700 (PDT)
Date: Mon, 17 Jun 2024 13:43:57 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	song@kernel.org, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, memxor@gmail.com, void@manifault.com,
	jolsa@kernel.org
Subject: [PATCH 1/2] bpf: relax zero fixed offset constraint on trusted
 pointer arguments
Message-ID: <ZnA9ndnXKtHOuYMe@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Currently, BPF helpers and kfuncs which take trusted pointer arguments
i.e. those flagged w/ KF_TRUSTED_ARGS, KF_RELEASE, OBJ_RELEASE, all
require an original/unmodified trusted pointer argument to be supplied
to them. By original/unmodified, it means that the backing register
holding the trusted pointer argument that is to be supplied to the BPF
helper/kfunc must have its fixed offset set to zero, or else the BPF
verifier will outright reject the BPF program load. However, this
fixed offset constraint of zero enforced by the BPF verifier onto the
trusted pointer arguments is rather unnecessary at times and limiting
from a usability point of view, as it completely eliminates the
possibility of constructing a derived trusted pointer from an original
trusted pointer. A derived trusted pointer is simply a pointer
pointing to one of the nested member fields of the object being
pointed to by the original trusted pointer.

This patch relaxes the zero fixed offset constraint that is enforced
upon trusted pointer arguments such that the constraint is now only
strictly enforced on a case-by-case basis. The updated semantics of
when the zero fixed offset constraint is enforced and in turn relaxed
may be summarized as follows:

* For OBJ_RELEASE and KF_RELEASE BPF helpers and kfuncs:

 * If the expected argument type is of an untyped pointer i.e. void *,
   then we continue to enforce a zero fixed offset as we need to
   ensure that the correct referenced pointer is handed off correctly
   to the relevant deallocation routine

 * If the expected argument is backed by BTF, then we relax the strict
   zero fixed offset and allow it only if we successfully type matched
   between the register and argument. A failed type match between
   register and argument will result in the legacy strict zero offset
   semantics

* For KF_TRUSTED_ARGS BPF kfuncs:

 * The fixed zero offset constraint has been lifted, such that
   KF_TRUSTED_ARGS BPF kfuncs can now accept a trusted pointer
   argument with a non-zero fixed offset providing that register and
   argument BTF has type matched successfully

With these new fixed offset semantics in-place for trusted pointer
arguments, we now have more flexibility when it comes to the BPF
kfuncs that we're able to introduce moving forward, and increase the
overall usability of BPF helpers and kfuncs that make use of trusted
pointer arguments.

For some early discussions covering the possibility of relaxing the
zero fixed offset constraint can be found using the link below. This
will provide more context on where all this has stemmed from:

* https://lore.kernel.org/bpf/ZhkbrM55MKQ0KeIV@google.com/

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 kernel/bpf/verifier.c                         | 235 +++++++++++++-----
 .../selftests/bpf/prog_tests/linked_list.c    |   2 +-
 .../bpf/progs/local_kptr_stash_fail.c         |   2 +-
 .../bpf/progs/nested_trust_failure.c          |   8 -
 .../bpf/progs/nested_trust_success.c          |   8 +
 .../selftests/bpf/progs/user_ringbuf_fail.c   |   4 +-
 .../bpf/progs/verifier_ref_tracking.c         |   2 +-
 .../selftests/bpf/progs/verifier_ringbuf.c    |   2 +-
 .../selftests/bpf/progs/verifier_sock.c       |   6 +-
 tools/testing/selftests/bpf/verifier/calls.c  |   4 +-
 10 files changed, 198 insertions(+), 75 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dcbbf5f64c5d..a5d18c742bdf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8375,21 +8375,25 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 		}
 
 		if (!arg_btf_id) {
-			if (!compatible->btf_id) {
-				verbose(env, "verifier internal error: missing arg compatible BTF ID\n");
-				return -EFAULT;
-			}
-			arg_btf_id = compatible->btf_id;
+			verbose(env,
+				"verifier internal error: missing BTF ID for BPF helper argument %d of type %d\n",
+				regno - BPF_REG_1, base_type(arg_type));
+			return -EFAULT;
 		}
 
+		/* arg_btf_id is allowed to be BPF_PTR_POISON at this point as
+		 * map_kptr_match_type() dynamically fetches the BTF ID for the
+		 * backing argument via the kptr_field residing in
+		 * bpf_call_arg_meta.
+		 */
 		if (meta->func_id == BPF_FUNC_kptr_xchg) {
 			if (map_kptr_match_type(env, meta->kptr_field, reg, regno))
 				return -EACCES;
 		} else {
 			if (arg_btf_id == BPF_PTR_POISON) {
-				verbose(env, "verifier internal error:");
-				verbose(env, "R%d has non-overwritten BPF_PTR_POISON type\n",
-					regno);
+				verbose(env,
+					"verifier internal error: BPF helper argument %d has non-overwritten BPF_PTR_POISON type\n",
+					regno - BPF_REG_1);
 				return -EACCES;
 			}
 
@@ -8445,41 +8449,121 @@ reg_find_field_offset(const struct bpf_reg_state *reg, s32 off, u32 fields)
 	return field;
 }
 
-static int check_func_arg_reg_off(struct bpf_verifier_env *env,
-				  const struct bpf_reg_state *reg, int regno,
-				  enum bpf_arg_type arg_type)
+static int check_release_arg_reg_off(struct bpf_verifier_env *env,
+				     const enum bpf_arg_type arg_type,
+				     const struct btf *arg_btf,
+				     const u32 *arg_btf_id, const int regno,
+				     const struct bpf_reg_state *reg,
+				     const bool strict_type_match)
 {
-	u32 type = reg->type;
+	int ret;
+	bool fixed_off_ok;
+	const struct btf_type *arg_ref_t;
 
-	/* When referenced register is passed to release function, its fixed
-	 * offset must be 0.
-	 *
-	 * We will check arg_type_is_release reg has ref_obj_id when storing
-	 * meta->release_regno.
+	/* ARG_PTR_TO_DYNPTR with OBJ_RELEASE is a bit special, as it may not
+	 * directly point to the object being released, but to a dynptr pointing
+	 * to such object, which might be at some offset on the stack. In that
+	 * case, we simply to fallback to the default handling.
 	 */
-	if (arg_type_is_release(arg_type)) {
-		/* ARG_PTR_TO_DYNPTR with OBJ_RELEASE is a bit special, as it
-		 * may not directly point to the object being released, but to
-		 * dynptr pointing to such object, which might be at some offset
-		 * on the stack. In that case, we simply to fallback to the
-		 * default handling.
-		 */
-		if (arg_type_is_dynptr(arg_type) && type == PTR_TO_STACK)
-			return 0;
+	if (arg_type_is_dynptr(arg_type) && reg->type == PTR_TO_STACK)
+		return 0;
 
-		/* Doing check_ptr_off_reg check for the offset will catch this
-		 * because fixed_off_ok is false, but checking here allows us
-		 * to give the user a better error message.
-		 */
+	if (!reg->ref_obj_id) {
+		verbose(env,
+			"R%d must be referenced when passed to a OBJ_RELEASE/KF_RELEASE flagged BPF helper/kfunc\n",
+			regno);
+		return -EINVAL;
+	}
+
+	if (!arg_btf_id || arg_btf_id == BPF_PTR_POISON) {
 		if (reg->off) {
-			verbose(env, "R%d must have zero offset when passed to release func or trusted arg to kfunc\n",
+			verbose(env,
+				"R%d must have a fixed offset of 0 when passed to a OBJ_RELEASE/KF_RELEASE flagged BPF helper/kfunc which takes a void *\n",
 				regno);
 			return -EINVAL;
 		}
-		return __check_ptr_off_reg(env, reg, regno, false);
+		/* We have no suporting BTF type ID to work with, so just
+		 * perform the conventional pointer offset register checks.
+		 */
+		return check_ptr_off_reg(env, reg, regno);
 	}
 
-	switch (type) {
+	arg_btf = !arg_btf ? btf_vmlinux : arg_btf;
+	arg_ref_t = btf_type_skip_modifiers(arg_btf, *arg_btf_id, NULL);
+	if (!arg_ref_t) {
+		verbose(env,
+			"verifier internal error: failed to get argument BTF type information for BTF type ID %d",
+			*arg_btf_id);
+		return -EFAULT;
+	}
+
+	/* For OBJ_RELEASE/KF_RELEASE flagged BPF helpers and kfuncs which
+	 * take a void pointer as an argument, we must ensure that the supplied
+	 * pointer is in its original unmodified form, or else we could end up
+	 * in a situation where we pass the wrong pointer into the callee.
+	 */
+	if (reg->off && btf_type_is_void(arg_ref_t)) {
+		verbose(env,
+			"R%d must have a fixed offset of 0 when passed to a OBJ_RELEASE/KF_RELEASE flagged BPF helper/kfunc which takes a void *\n",
+			regno);
+		return -EINVAL;
+	}
+
+	fixed_off_ok = false;
+	/* Don't attempt to perform a btf_struct_ids_match() on a MEM_ALLOC
+	 * tagged register type as it will always result in a failed match. This
+	 * is due to using 2 different BTF sources, being local and kernel.
+	 */
+	if (reg->off && ((base_type(reg->type) == PTR_TO_BTF_ID ||
+			  reg2btf_ids[reg->type]) &&
+			 !type_is_alloc(reg->type))) {
+		u32 reg_btf_id;
+		const struct btf *reg_btf;
+
+		if (base_type(reg->type) == PTR_TO_BTF_ID) {
+			reg_btf = reg->btf;
+			reg_btf_id = reg->btf_id;
+		} else {
+			reg_btf = btf_vmlinux;
+			reg_btf_id = *reg2btf_ids[reg->type];
+		}
+
+		fixed_off_ok = btf_struct_ids_match(&env->log, reg_btf,
+						    reg_btf_id, reg->off,
+						    arg_btf, *arg_btf_id,
+						    strict_type_match);
+	}
+
+	ret = __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
+	if (reg->off && ret) {
+		verbose(env,
+			"R%d must have a fixed offset of 0 when passed to a OBJ_RELEASE/KF_RELEASE flagged BPF helper/kfunc which takes a void *\n",
+			regno);
+	}
+	return ret;
+}
+
+static int check_func_arg_reg_off(struct bpf_verifier_env *env,
+				  const u32 func_id,
+				  const enum bpf_arg_type arg_type,
+				  const struct btf *arg_btf,
+				  const u32 *arg_btf_id, const u8 regno,
+				  const struct bpf_reg_state *reg)
+{
+	const u32 reg_type = reg->type;
+
+	if (arg_type_is_release(arg_type)) {
+		/* BPF_FUNC_sk_release is rather polymorphic as it can accept
+		 * mulitple types. Therefore, we make an exception for it when
+		 * determining whether we should enforce strict type matching
+		 * between BPF helper/kfunc argument and register.
+		 */
+		return check_release_arg_reg_off(
+			env, arg_type, arg_btf, arg_btf_id, regno, reg,
+			func_id != BPF_FUNC_sk_release);
+	}
+
+	switch (reg_type) {
 	/* Pointer types where both fixed and variable offset is explicitly allowed: */
 	case PTR_TO_STACK:
 	case PTR_TO_PACKET:
@@ -8630,6 +8714,33 @@ static int check_reg_const_str(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static int *get_helper_arg_btf_id(const struct bpf_func_proto *fn,
+				  const struct bpf_call_arg_meta *meta,
+				  const u32 arg,
+				  const enum bpf_arg_type arg_type)
+{
+	u32 *arg_btf_id = NULL;
+	const enum bpf_arg_type base_arg_type = base_type(arg_type);
+
+	if (base_arg_type == ARG_PTR_TO_BTF_ID ||
+	    base_arg_type == ARG_PTR_TO_SPIN_LOCK) {
+		arg_btf_id = fn->arg_btf_id[arg];
+	}
+
+	if (arg_btf_id == BPF_PTR_POISON &&
+	    meta->func_id == BPF_FUNC_kptr_xchg) {
+		arg_btf_id = &meta->kptr_field->kptr.btf_id;
+	}
+
+	if (!arg_btf_id) {
+		const struct bpf_reg_types *reg_types =
+			compatible_reg_types[base_arg_type];
+		if (reg_types)
+			arg_btf_id = reg_types->btf_id;
+	}
+	return arg_btf_id;
+}
+
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			  struct bpf_call_arg_meta *meta,
 			  const struct bpf_func_proto *fn,
@@ -8639,7 +8750,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
 	enum bpf_arg_type arg_type = fn->arg_type[arg];
 	enum bpf_reg_type type = reg->type;
-	u32 *arg_btf_id = NULL;
+	u32 *arg_btf_id;
 	int err = 0;
 
 	if (arg_type == ARG_DONTCARE)
@@ -8676,16 +8787,13 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		 */
 		goto skip_type_check;
 
-	/* arg_btf_id and arg_size are in a union. */
-	if (base_type(arg_type) == ARG_PTR_TO_BTF_ID ||
-	    base_type(arg_type) == ARG_PTR_TO_SPIN_LOCK)
-		arg_btf_id = fn->arg_btf_id[arg];
-
+	arg_btf_id = get_helper_arg_btf_id(fn, meta, arg, arg_type);
 	err = check_reg_type(env, regno, arg_type, arg_btf_id, meta);
 	if (err)
 		return err;
 
-	err = check_func_arg_reg_off(env, reg, regno, arg_type);
+	err = check_func_arg_reg_off(env, meta->func_id, arg_type, btf_vmlinux,
+				     arg_btf_id, regno, reg);
 	if (err)
 		return err;
 
@@ -9433,6 +9541,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 		u32 regno = i + 1;
 		struct bpf_reg_state *reg = &regs[regno];
 		struct bpf_subprog_arg_info *arg = &sub->args[i];
+		const u32 arg_btf_id = arg->btf_id;
 
 		if (arg->arg_type == ARG_ANYTHING) {
 			if (reg->type != SCALAR_VALUE) {
@@ -9440,7 +9549,9 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 				return -EINVAL;
 			}
 		} else if (arg->arg_type == ARG_PTR_TO_CTX) {
-			ret = check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE);
+			ret = check_func_arg_reg_off(env, /*func_id=*/0,
+						     ARG_DONTCARE, btf,
+						     &arg_btf_id, regno, reg);
 			if (ret < 0)
 				return ret;
 			/* If function expects ctx type in BTF check that caller
@@ -9451,7 +9562,9 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 				return -EINVAL;
 			}
 		} else if (base_type(arg->arg_type) == ARG_PTR_TO_MEM) {
-			ret = check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE);
+			ret = check_func_arg_reg_off(env, /*func_id=*/0,
+						     ARG_DONTCARE, btf,
+						     &arg_btf_id, regno, reg);
 			if (ret < 0)
 				return ret;
 			if (check_mem_reg(env, reg, regno, arg->mem_size))
@@ -9485,7 +9598,11 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 
 			memset(&meta, 0, sizeof(meta)); /* leave func_id as zero */
 			err = check_reg_type(env, regno, arg->arg_type, &arg->btf_id, &meta);
-			err = err ?: check_func_arg_reg_off(env, reg, regno, arg->arg_type);
+			err = err   ?:
+				      check_func_arg_reg_off(env, /*func_id=*/0,
+							     arg->arg_type, btf,
+							     &arg_btf_id, regno,
+							     reg);
 			if (err)
 				return err;
 		} else {
@@ -11281,6 +11398,16 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
 	bool struct_same;
 	u32 reg_ref_id;
 
+	/*
+	 * For a BPF kfunc that posseses KF_RELEASE semantics, we should only
+	 * allow a register with a non-zero fixed offset to be accepted if we
+	 * can successfully type match between the type held by the register and
+	 * the type associated with the given BPF kfunc argument.
+	 */
+	WARN_ON_ONCE(is_kfunc_release(meta) && btf_type_is_void(ref_t) &&
+		     (reg->off || !tnum_is_const(reg->var_off) ||
+		      reg->var_off.value));
+
 	if (base_type(reg->type) == PTR_TO_BTF_ID) {
 		reg_btf = reg->btf;
 		reg_ref_id = reg->btf_id;
@@ -11318,8 +11445,6 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
 	    btf_type_ids_nocast_alias(&env->log, reg_btf, reg_ref_id, meta->btf, ref_id))
 		strict_type_match = true;
 
-	WARN_ON_ONCE(is_kfunc_trusted_args(meta) && reg->off);
-
 	reg_ref_t = btf_type_skip_modifiers(reg_btf, reg_ref_id, &reg_ref_id);
 	reg_ref_tname = btf_name_by_offset(reg_btf, reg_ref_t->name_off);
 	struct_same = btf_struct_ids_match(&env->log, reg_btf, reg_ref_id, reg->off, meta->btf, ref_id, strict_type_match);
@@ -11884,6 +12009,13 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			}
 			meta->map.ptr = reg->map_ptr;
 			meta->map.uid = reg->map_uid;
+
+			/* If a BPF kfunc argument in suffixed with __map,
+			 * expect a struct bpf_map *.
+			 */
+			ref_id = *reg2btf_ids[CONST_PTR_TO_MAP];
+			ref_t = btf_type_by_id(btf_vmlinux, ref_id);
+			ref_tname = btf_name_by_offset(btf, ref_t->name_off);
 			fallthrough;
 		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
 		case KF_ARG_PTR_TO_BTF_ID:
@@ -11900,12 +12032,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 					return -EINVAL;
 				}
 			}
-
 			fallthrough;
 		case KF_ARG_PTR_TO_CTX:
-			/* Trusted arguments have the same offset checks as release arguments */
-			arg_type |= OBJ_RELEASE;
-			break;
 		case KF_ARG_PTR_TO_DYNPTR:
 		case KF_ARG_PTR_TO_ITER:
 		case KF_ARG_PTR_TO_LIST_HEAD:
@@ -11918,7 +12046,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
 		case KF_ARG_PTR_TO_CONST_STR:
 		case KF_ARG_PTR_TO_WORKQUEUE:
-			/* Trusted by default */
 			break;
 		default:
 			WARN_ON_ONCE(1);
@@ -11927,7 +12054,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 
 		if (is_kfunc_release(meta) && reg->ref_obj_id)
 			arg_type |= OBJ_RELEASE;
-		ret = check_func_arg_reg_off(env, reg, regno, arg_type);
+		ret = check_func_arg_reg_off(env, /*func_id=*/0, arg_type, btf,
+					     &ref_id, regno, reg);
 		if (ret < 0)
 			return ret;
 
@@ -12103,11 +12231,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				return ret;
 			break;
 		case KF_ARG_PTR_TO_MAP:
-			/* If argument has '__map' suffix expect 'struct bpf_map *' */
-			ref_id = *reg2btf_ids[CONST_PTR_TO_MAP];
-			ref_t = btf_type_by_id(btf_vmlinux, ref_id);
-			ref_tname = btf_name_by_offset(btf, ref_t->name_off);
-			fallthrough;
 		case KF_ARG_PTR_TO_BTF_ID:
 			/* Only base_type is checked, further checks are done here */
 			if ((base_type(reg->type) != PTR_TO_BTF_ID ||
diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools/testing/selftests/bpf/prog_tests/linked_list.c
index 77d07e0a4a55..559abab81d0f 100644
--- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
+++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
@@ -67,7 +67,7 @@ static struct {
 	{ "obj_type_id_oor", "local type ID argument must be in range [0, U32_MAX]" },
 	{ "obj_new_no_composite", "bpf_obj_new/bpf_percpu_obj_new type ID argument must be of a struct" },
 	{ "obj_new_no_struct", "bpf_obj_new/bpf_percpu_obj_new type ID argument must be of a struct" },
-	{ "obj_drop_non_zero_off", "R1 must have zero offset when passed to release func" },
+	{ "obj_drop_non_zero_off", "R1 must have a fixed offset of 0 when passed to a OBJ_RELEASE/KF_RELEASE flagged BPF helper/kfunc which takes a void *" },
 	{ "new_null_ret", "R0 invalid mem access 'ptr_or_null_'" },
 	{ "obj_new_acq", "Unreleased reference id=" },
 	{ "use_after_drop", "invalid mem access 'scalar'" },
diff --git a/tools/testing/selftests/bpf/progs/local_kptr_stash_fail.c b/tools/testing/selftests/bpf/progs/local_kptr_stash_fail.c
index fcf7a7567da2..829b726b6383 100644
--- a/tools/testing/selftests/bpf/progs/local_kptr_stash_fail.c
+++ b/tools/testing/selftests/bpf/progs/local_kptr_stash_fail.c
@@ -63,7 +63,7 @@ long stash_rb_nodes(void *ctx)
 }
 
 SEC("tc")
-__failure __msg("R1 must have zero offset when passed to release func")
+__failure __msg("R1 must have a fixed offset of 0 when passed to a OBJ_RELEASE/KF_RELEASE flagged BPF helper/kfunc")
 long drop_rb_node_off(void *ctx)
 {
 	struct map_value *mapval;
diff --git a/tools/testing/selftests/bpf/progs/nested_trust_failure.c b/tools/testing/selftests/bpf/progs/nested_trust_failure.c
index ea39497f11ed..3568ec450100 100644
--- a/tools/testing/selftests/bpf/progs/nested_trust_failure.c
+++ b/tools/testing/selftests/bpf/progs/nested_trust_failure.c
@@ -31,14 +31,6 @@ int BPF_PROG(test_invalid_nested_user_cpus, struct task_struct *task, u64 clone_
 	return 0;
 }
 
-SEC("tp_btf/task_newtask")
-__failure __msg("R1 must have zero offset when passed to release func or trusted arg to kfunc")
-int BPF_PROG(test_invalid_nested_offset, struct task_struct *task, u64 clone_flags)
-{
-	bpf_cpumask_first_zero(&task->cpus_mask);
-	return 0;
-}
-
 /* Although R2 is of type sk_buff but sock_common is expected, we will hit untrusted ptr first. */
 SEC("tp_btf/tcp_probe")
 __failure __msg("R2 type=untrusted_ptr_ expected=ptr_, trusted_ptr_, rcu_ptr_")
diff --git a/tools/testing/selftests/bpf/progs/nested_trust_success.c b/tools/testing/selftests/bpf/progs/nested_trust_success.c
index 833840bffd3b..2b66953ca82e 100644
--- a/tools/testing/selftests/bpf/progs/nested_trust_success.c
+++ b/tools/testing/selftests/bpf/progs/nested_trust_success.c
@@ -32,3 +32,11 @@ int BPF_PROG(test_skb_field, struct sock *sk, struct sk_buff *skb)
 	bpf_sk_storage_get(&sk_storage_map, skb->sk, 0, 0);
 	return 0;
 }
+
+SEC("tp_btf/task_newtask")
+__success
+int BPF_PROG(test_nested_offset, struct task_struct *task, u64 clone_flags)
+{
+	bpf_cpumask_first_zero(&task->cpus_mask);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c b/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
index 11ab25c42c36..2d0ae76083d8 100644
--- a/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
+++ b/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
@@ -146,7 +146,7 @@ try_discard_dynptr(struct bpf_dynptr *dynptr, void *context)
  * not be able to read past the end of the pointer.
  */
 SEC("?raw_tp")
-__failure __msg("cannot release unowned const bpf_dynptr")
+__failure __msg("R1 must be referenced when passed to a OBJ_RELEASE/KF_RELEASE flagged BPF helper/kfunc")
 int user_ringbuf_callback_discard_dynptr(void *ctx)
 {
 	bpf_user_ringbuf_drain(&user_ringbuf, try_discard_dynptr, NULL, 0);
@@ -166,7 +166,7 @@ try_submit_dynptr(struct bpf_dynptr *dynptr, void *context)
  * not be able to read past the end of the pointer.
  */
 SEC("?raw_tp")
-__failure __msg("cannot release unowned const bpf_dynptr")
+__failure __msg("R1 must be referenced when passed to a OBJ_RELEASE/KF_RELEASE flagged BPF helper/kfunc")
 int user_ringbuf_callback_submit_dynptr(void *ctx)
 {
 	bpf_user_ringbuf_drain(&user_ringbuf, try_submit_dynptr, NULL, 0);
diff --git a/tools/testing/selftests/bpf/progs/verifier_ref_tracking.c b/tools/testing/selftests/bpf/progs/verifier_ref_tracking.c
index c4c6da21265e..5195857dcfd0 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ref_tracking.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ref_tracking.c
@@ -1288,7 +1288,7 @@ l1_%=:	r1 = r6;					\
 
 SEC("tc")
 __description("reference tracking: bpf_sk_release(listen_sk)")
-__failure __msg("R1 must be referenced when passed to release function")
+__failure __msg("R1 must be referenced when passed to a OBJ_RELEASE/KF_RELEASE flagged BPF helper/kfunc")
 __naked void bpf_sk_release_listen_sk(void)
 {
 	asm volatile (
diff --git a/tools/testing/selftests/bpf/progs/verifier_ringbuf.c b/tools/testing/selftests/bpf/progs/verifier_ringbuf.c
index ae1d521f326c..2052facaa383 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ringbuf.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ringbuf.c
@@ -12,7 +12,7 @@ struct {
 
 SEC("socket")
 __description("ringbuf: invalid reservation offset 1")
-__failure __msg("R1 must have zero offset when passed to release func")
+__failure __msg("R1 must have a fixed offset of 0 when passed to a OBJ_RELEASE/KF_RELEASE flagged BPF helper/kfunc which takes a void *")
 __failure_unpriv
 __naked void ringbuf_invalid_reservation_offset_1(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools/testing/selftests/bpf/progs/verifier_sock.c
index ee76b51005ab..ff5e954bb6eb 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sock.c
@@ -600,7 +600,7 @@ l2_%=:	r0 = *(u32*)(r0 + %[bpf_tcp_sock_snd_cwnd]);	\
 
 SEC("tc")
 __description("bpf_sk_release(skb->sk)")
-__failure __msg("R1 must be referenced when passed to release function")
+__failure __msg("R1 must be referenced when passed to a OBJ_RELEASE/KF_RELEASE flagged BPF helper/kfunc")
 __naked void bpf_sk_release_skb_sk(void)
 {
 	asm volatile ("					\
@@ -617,7 +617,7 @@ l0_%=:	r0 = 0;						\
 
 SEC("tc")
 __description("bpf_sk_release(bpf_sk_fullsock(skb->sk))")
-__failure __msg("R1 must be referenced when passed to release function")
+__failure __msg("R1 must be referenced when passed to a OBJ_RELEASE/KF_RELEASE flagged BPF helper/kfunc")
 __naked void bpf_sk_fullsock_skb_sk(void)
 {
 	asm volatile ("					\
@@ -641,7 +641,7 @@ l1_%=:	r1 = r0;					\
 
 SEC("tc")
 __description("bpf_sk_release(bpf_tcp_sock(skb->sk))")
-__failure __msg("R1 must be referenced when passed to release function")
+__failure __msg("R1 must be referenced when passed to a OBJ_RELEASE/KF_RELEASE flagged BPF helper/kfunc")
 __naked void bpf_tcp_sock_skb_sk(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index ab25a81fd3a1..316534b860ae 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -76,7 +76,7 @@
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.result = REJECT,
-	.errstr = "R1 must have zero offset when passed to release func or trusted arg to kfunc",
+	.errstr = "arg#0 expected pointer to ctx, but got PTR",
 	.fixup_kfunc_btf_id = {
 		{ "bpf_kfunc_call_test_pass_ctx", 2 },
 	},
@@ -132,7 +132,7 @@
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.result = REJECT,
-	.errstr = "R1 must have zero offset when passed to release func",
+	.errstr = "R1 must have a fixed offset of 0 when passed to a OBJ_RELEASE/KF_RELEASE flagged BPF helper/kfunc which takes a void *",
 	.fixup_kfunc_btf_id = {
 		{ "bpf_kfunc_call_test_acquire", 3 },
 		{ "bpf_kfunc_call_memb_release", 8 },
-- 
2.45.2.627.g7a2c4fd464-goog

/M


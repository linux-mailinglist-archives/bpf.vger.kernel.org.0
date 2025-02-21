Return-Path: <bpf+bounces-52207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4F7A3FE0A
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 18:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51173427272
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 17:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7630224FC1E;
	Fri, 21 Feb 2025 17:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZb9T+NC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FEF36AF5
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 17:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740160639; cv=none; b=dCGr4UjVIWW66wzJZejDp2EGpbRny7cgAdLnQ4vtU/Ub8O0i3mtYKvtbCy0agUfF7mHFDzEJOUjDd4PimLP1dZMkRXMPh5G7cK3aKFh07yvJcD8BFYhJ9YbURwQ1tcY+j7Cmq4/PhGoUeHLu2K2haXT3f9q6ihw1N6rmqVCXLlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740160639; c=relaxed/simple;
	bh=aEc0nhS8jnNZ9GCV3azUoolBQuPOFiuWzTyzyejIRRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rvHOclG3PvHFv/LupIZahXfYjlCXo/MS39FnJi57WkGGoWW5lEjV1KwfpRxeGKyXOfEGPBAJUJgZ6LNK0666UG11BuvH6ir0FFVcSqyCQJkJ7Mo8qGzQcgDfNdxJ6xgEtjgP2tJ8eVhTXUjaqytnCOGpmnxQfSo/cuDjqSpA3nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZb9T+NC; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2210d92292eso73691335ad.1
        for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 09:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740160633; x=1740765433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oQO5Hum2iR9rBBddheqDvA5rHtRM6GiavxU+MEnf0eg=;
        b=HZb9T+NC2nWw0cKIsTIg/1F2PMmJY+NJR5LeyNXsBeK7PFe46r9viBXD3JWBM/k0Bb
         p4U+koyM4yms6UztiroR3/D1uH1XBzbC8Cl268vcVXy5jm/puS+CYZCPd4I1qDVAXX9a
         eYgN7USW/s5/r2NKOSBBh4nUzl+/ar9wXkl+3fbilk3WGvt1jKym5+uERSeJ5SamKRR8
         JBp7O0cn/iCw7bur1He5u0Aua5Bcz9DWzHsXx/MOF0TMbkFkTruMW9Au3lD6gYfsVfX5
         o462D0IhZ0jnm/TClUIK0gfQNcBYPEo79fnCkSIMKl0QUrR9zD2ZSrCpypX+EdbwPevt
         C6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740160633; x=1740765433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oQO5Hum2iR9rBBddheqDvA5rHtRM6GiavxU+MEnf0eg=;
        b=ryiU1OnbxfTbna9YNwIBYxqgNAQu671quMze2Y6PTgpCbHYq4KTovMu6qtJt5RtCst
         dju5u6jMtE5OCFojokhMGDMf/HQhnIOWwgJVG8fNXmwDHX0umJiit3kENkOzaNWbCvj5
         t71/DnSAYWXPEJDOGe2+KkiXfOhVbVPMg9vA43pi6lHauukaDdlLSgHFMcs1Fn5hBLnj
         JrqlUoOxRk1NM25U8TFBta+ncdOrNL2+Erl/oQpM+vBKZe+pE900rb+amiE23EsxVBjN
         pSkl+/re2XPL7SRwUPoxwJBQUF4uLcCbmdyFG3e6YsUjSnvmkpWowuAEnGW98Eq30KCi
         VVTA==
X-Gm-Message-State: AOJu0YyGzxtJKZbsnTbgzt8kVNeBijQJsH1e1iaV6rnXarLSGPgD7GkB
	BCuRh40ICY/+jdbURBHGObDUhqT2iOCzqBIUEsUi/7lTiawuQ383xQU33Q==
X-Gm-Gg: ASbGncvagVMJ0XqdKL/FuBD5iQE7Kx/r1U/Gbha6Y2HFcnOCNyaRdlgPqnPbTOaNgeZ
	rg2JgGBEmXileohBghO//EvToF4MPjD2sgPwVueCg5bQ49oDMT0Ut7/pEdTVAOGCTjgW/BVzPdv
	iUvOQC8qmS79erkDW3lS6S9n4MQ8oqOcp4+aCHFWu0aEUB3V/a2bHJebboeR3j0MME5w1GJS07w
	MyCyY53PAgofMCrsAjlmKy9UgMJXjgKyxsLYaJJDod4/3v47OYXqZM2X713n9aKTCm15h3/fX0+
	hkXCUVTXj3mXE+7G2pIgiKiWBhChfCMCsCfNZ8gP69eV+8kscqIB8q2XJvCB6Nz4m/pLTaCsLYE
	h
X-Google-Smtp-Source: AGHT+IHeYE3xKpIFuBbScw/puXfz+nxy0cBXXFwG/x0jQ/WaDJgcHwYCjktGkXcCDRvNMUNCcOYAbQ==
X-Received: by 2002:a17:902:da88:b0:21f:164d:93fe with SMTP id d9443c01a7336-221a000aa36mr71275195ad.53.1740160633527;
        Fri, 21 Feb 2025 09:57:13 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7327367a960sm10806416b3a.150.2025.02.21.09.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 09:57:13 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH] bpf: Refactor check_ctx_access()
Date: Fri, 21 Feb 2025 09:56:44 -0800
Message-ID: <20250221175644.1822383-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reduce the variable passing madness surrounding check_ctx_access().
Currently, check_mem_access() passes many pointers to local variables to
check_ctx_access(). They are used to initialize "struct
bpf_insn_access_aux info" in check_ctx_access() and then passed to
is_valid_access(). Then, check_ctx_access() takes the data our from
info and write them back the pointers to pass them back. This can be
simpilified by moving info up to check_mem_access().

No functional change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 56 ++++++++++++++++---------------------------
 1 file changed, 20 insertions(+), 36 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 212b487fd39d..98a376bd7287 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6006,19 +6006,10 @@ static int check_packet_access(struct bpf_verifier_env *env, u32 regno, int off,
 
 /* check access to 'struct bpf_context' fields.  Supports fixed offsets only */
 static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int off, int size,
-			    enum bpf_access_type t, enum bpf_reg_type *reg_type,
-			    struct btf **btf, u32 *btf_id, bool *is_retval, bool is_ldsx,
-			    u32 *ref_obj_id)
+			    enum bpf_access_type t, struct bpf_insn_access_aux *info)
 {
-	struct bpf_insn_access_aux info = {
-		.reg_type = *reg_type,
-		.log = &env->log,
-		.is_retval = false,
-		.is_ldsx = is_ldsx,
-	};
-
 	if (env->ops->is_valid_access &&
-	    env->ops->is_valid_access(off, size, t, env->prog, &info)) {
+	    env->ops->is_valid_access(off, size, t, env->prog, info)) {
 		/* A non zero info.ctx_field_size indicates that this field is a
 		 * candidate for later verifier transformation to load the whole
 		 * field and then apply a mask when accessed with a narrower
@@ -6026,22 +6017,15 @@ static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int off,
 		 * will only allow for whole field access and rejects any other
 		 * type of narrower access.
 		 */
-		*reg_type = info.reg_type;
-		*is_retval = info.is_retval;
-
-		if (base_type(*reg_type) == PTR_TO_BTF_ID) {
-			if (info.ref_obj_id &&
-			    !find_reference_state(env->cur_state, info.ref_obj_id)) {
+		if (base_type(info->reg_type) == PTR_TO_BTF_ID) {
+			if (info->ref_obj_id &&
+			    !find_reference_state(env->cur_state, info->ref_obj_id)) {
 				verbose(env, "invalid bpf_context access off=%d. Reference may already be released\n",
 					off);
 				return -EACCES;
 			}
-
-			*btf = info.btf;
-			*btf_id = info.btf_id;
-			*ref_obj_id = info.ref_obj_id;
 		} else {
-			env->insn_aux_data[insn_idx].ctx_field_size = info.ctx_field_size;
+			env->insn_aux_data[insn_idx].ctx_field_size = info->ctx_field_size;
 		}
 		/* remember the offset of last byte accessed in ctx */
 		if (env->prog->aux->max_ctx_offset < off + size)
@@ -7398,11 +7382,12 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 		if (!err && value_regno >= 0 && (t == BPF_READ || rdonly_mem))
 			mark_reg_unknown(env, regs, value_regno);
 	} else if (reg->type == PTR_TO_CTX) {
-		bool is_retval = false;
 		struct bpf_retval_range range;
-		enum bpf_reg_type reg_type = SCALAR_VALUE;
-		struct btf *btf = NULL;
-		u32 btf_id = 0, ref_obj_id = 0;
+		struct bpf_insn_access_aux info = {
+			.reg_type = SCALAR_VALUE,
+			.is_ldsx = is_ldsx,
+			.log = &env->log,
+		};
 
 		if (t == BPF_WRITE && value_regno >= 0 &&
 		    is_pointer_value(env, value_regno)) {
@@ -7414,8 +7399,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 		if (err < 0)
 			return err;
 
-		err = check_ctx_access(env, insn_idx, off, size, t, &reg_type, &btf,
-				       &btf_id, &is_retval, is_ldsx, &ref_obj_id);
+		err = check_ctx_access(env, insn_idx, off, size, t, &info);
 		if (err)
 			verbose_linfo(env, insn_idx, "; ");
 		if (!err && t == BPF_READ && value_regno >= 0) {
@@ -7423,8 +7407,8 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			 * PTR_TO_PACKET[_META,_END]. In the latter
 			 * case, we know the offset is zero.
 			 */
-			if (reg_type == SCALAR_VALUE) {
-				if (is_retval && get_func_retval_range(env->prog, &range)) {
+			if (info.reg_type == SCALAR_VALUE) {
+				if (info.is_retval && get_func_retval_range(env->prog, &range)) {
 					err = __mark_reg_s32_range(env, regs, value_regno,
 								   range.minval, range.maxval);
 					if (err)
@@ -7435,7 +7419,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			} else {
 				mark_reg_known_zero(env, regs,
 						    value_regno);
-				if (type_may_be_null(reg_type))
+				if (type_may_be_null(info.reg_type))
 					regs[value_regno].id = ++env->id_gen;
 				/* A load of ctx field could have different
 				 * actual load size with the one encoded in the
@@ -7443,13 +7427,13 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 				 * a sub-register.
 				 */
 				regs[value_regno].subreg_def = DEF_NOT_SUBREG;
-				if (base_type(reg_type) == PTR_TO_BTF_ID) {
-					regs[value_regno].btf = btf;
-					regs[value_regno].btf_id = btf_id;
-					regs[value_regno].ref_obj_id = ref_obj_id;
+				if (base_type(info.reg_type) == PTR_TO_BTF_ID) {
+					regs[value_regno].btf = info.btf;
+					regs[value_regno].btf_id = info.btf_id;
+					regs[value_regno].ref_obj_id = info.ref_obj_id;
 				}
 			}
-			regs[value_regno].type = reg_type;
+			regs[value_regno].type = info.reg_type;
 		}
 
 	} else if (reg->type == PTR_TO_STACK) {
-- 
2.47.1



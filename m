Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3143850D55D
	for <lists+bpf@lfdr.de>; Sun, 24 Apr 2022 23:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239675AbiDXVwC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 24 Apr 2022 17:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235710AbiDXVwC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 24 Apr 2022 17:52:02 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A06644EC
        for <bpf@vger.kernel.org>; Sun, 24 Apr 2022 14:48:59 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 15so3498986pgf.4
        for <bpf@vger.kernel.org>; Sun, 24 Apr 2022 14:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7sBUFSZjz+Wnc6yenCih9AZWIddazbfpXwPWiXUE5BQ=;
        b=h2nErujVDjtmnYJOVYYK14/OLRpuD9cMvNYnQ8ds0Lj9TEICA67U8jesfjLuIFcNa4
         LkAIFzhKdEsQWD+sqZZMOYtgHG9BAhD3CaCXTdCn2zGUQgg6DQerr4VHkXU/lXieHnbI
         ZLAsJcNjHHdidazOCR1KbmCh98F9vJn11uEx+KyVqfEPV3FqTO8Ry4nbsH2h5GJoJtvL
         DnEQRMGHXMcNu0XuuOJmKBOqrHtB/Jg4GmPxLMNYRYbjCtcNWtikQoFyQwOLwPTXXSI4
         SKtjxkH0OavEVNEGpjeDs/BGqWnr7bZ2UkzPE3/KVmgQXPxBwCyDyMYw12dw75HJH/u+
         k4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7sBUFSZjz+Wnc6yenCih9AZWIddazbfpXwPWiXUE5BQ=;
        b=pLDWM8fJLOe3/PBaRSYUUCALr1uNmk+3+4tSiOB6tt3xQbpfAYlllrwF2oRxVXIlGa
         n3rU6z391LplTYF9OCk/CPxQa61wINkJtU1z79/mBpplq5h05bzaBFyw6VsOPnXNCJZY
         tVOz1C/Np61Fo682ClJiPsLT0sFySaK9/JtRC8HMpsRnRtwh7Dg0/ECYgi3gIp8ziASR
         kCMtTJ48H6puYsNINvKF8FO77KwtbGqnbOVyZ5FN6+Zo9X75yf+S7F6phiURGl6jBvN2
         MtIyVA1JwdYbRccfsoELSKSXtzpk46zvL0/iFfEy71CnOuJbdmxWr9vGedAYhM9UbmKw
         rIwA==
X-Gm-Message-State: AOAM531L6slHSpoPLtrNEnSXqsOCsJvAzsJIIuElo/0a4qzMv1nktuDv
        ZcFVBon95GpItYsk8BKcCrLKSwXtaDY=
X-Google-Smtp-Source: ABdhPJx9VA7Y4NEAVCjEyVdSmbW211NO5zXwdDnd+4o4qvzUtV6Q0IS80t7eo+cxEm9gHiSmvmQEEw==
X-Received: by 2002:a05:6a00:2349:b0:4fa:934f:f6db with SMTP id j9-20020a056a00234900b004fa934ff6dbmr15811901pfj.44.1650836938960;
        Sun, 24 Apr 2022 14:48:58 -0700 (PDT)
Received: from localhost ([157.49.66.127])
        by smtp.gmail.com with ESMTPSA id z28-20020a62d11c000000b0050d2daec38esm3812029pfg.113.2022.04.24.14.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 14:48:58 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v6 04/13] bpf: Prevent escaping of kptr loaded from maps
Date:   Mon, 25 Apr 2022 03:18:52 +0530
Message-Id: <20220424214901.2743946-5-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220424214901.2743946-1-memxor@gmail.com>
References: <20220424214901.2743946-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6430; h=from:subject; bh=xs91Gq6d98ZmuL6fw0l/UEqWCmvDymDUCPwOCYGvBt0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiZcTLCDyPbrbjtkYdLfuE/DeCYyr64jMV8CPhCSBa 5jSCMeOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYmXEywAKCRBM4MiGSL8RyjN6EA CtTpNnoE9MchmhEbfSHLDt9Pe21SJh11uAP7U3FuG2YJ5BcokyGp34LSK+XlfAI8wv78HYQC5WQCIB t3DE8xRKQvTsawtIc/rO6RHYS2IcPHWO5sT5C7eZiRNIXtUio0fxPphujP05ZvBdbtAgOzXwHsDi/Z HBEFxwssrHNLLSIQuDZ6dHVwV7GdksWIrSmsknL8qnjnVdE3zNSBaJJHhrhkoiXEdLtOd9XF3jiuip 03isOBtlxUjYIYfuGYZpo9YODeh4hPN7oGa8k/RJrLuaG4qOHQ1sEF94wFBK57AYmF+blK60HukF3Y ZbM3n84uO5FkQahvL9R/m4vz+Tt5oPfL1jINtjHJkX0yCrGY68LL2jfYQ5tGX6LkSAB8g2VtYnRtxF JMtNTfQaKdUj9ul4MmfSggN+SKPOUA9Q0n/37kphbUwyMO+Lf3bDueunyyDJ23wtziMNHbyLr1pSBz wS9QX8kQX2cWCXrthUd8w6NXoDZXanSgzg35qqzH5kpD65ZytTWVaPrW2fRy2U8/R9Psr8lGGmuX0H u0yoW7/Tc5bzqr1snXn/EI+JyI8FYivTR56tVVA1QxtajkAO1pAb1T64O2mJ+v1uuXekjFs0IKMwu3 slzLnGlPxH4/ZHttUHv/NBMlxXpE2DzTucnSk+aqGSFTzRT4sYX20AKrHZ/g==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

While we can guarantee that even for unreferenced kptr, the object
pointer points to being freed etc. can be handled by the verifier's
exception handling (normal load patching to PROBE_MEM loads), we still
cannot allow the user to pass these pointers to BPF helpers and kfunc,
because the same exception handling won't be done for accesses inside
the kernel. The same is true if a referenced pointer is loaded using
normal load instruction. Since the reference is not guaranteed to be
held while the pointer is used, it must be marked as untrusted.

Hence introduce a new type flag, PTR_UNTRUSTED, which is used to mark
all registers loading unreferenced and referenced kptr from BPF maps,
and ensure they can never escape the BPF program and into the kernel by
way of calling stable/unstable helpers.

In check_ptr_to_btf_access, the !type_may_be_null check to reject type
flags is still correct, as apart from PTR_MAYBE_NULL, only MEM_USER,
MEM_PERCPU, and PTR_UNTRUSTED may be set for PTR_TO_BTF_ID. The first
two are checked inside the function and rejected using a proper error
message, but we still want to allow dereference of untrusted case.

Also, we make sure to inherit PTR_UNTRUSTED when chain of pointers are
walked, so that this flag is never dropped once it has been set on a
PTR_TO_BTF_ID (i.e. trusted to untrusted transition can only be in one
direction).

In convert_ctx_accesses, extend the switch case to consider untrusted
PTR_TO_BTF_ID in addition to normal PTR_TO_BTF_ID for PROBE_MEM
conversion for BPF_LDX.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h   | 10 +++++++++-
 kernel/bpf/verifier.c | 35 ++++++++++++++++++++++++++++-------
 2 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 24310837bafc..e13a5cbd4ebb 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -375,7 +375,15 @@ enum bpf_type_flag {
 	/* Indicates that the argument will be released. */
 	OBJ_RELEASE		= BIT(5 + BPF_BASE_TYPE_BITS),
 
-	__BPF_TYPE_LAST_FLAG	= OBJ_RELEASE,
+	/* PTR is not trusted. This is only used with PTR_TO_BTF_ID, to mark
+	 * unreferenced and referenced kptr loaded from map value using a load
+	 * instruction, so that they can only be dereferenced but not escape the
+	 * BPF program into the kernel (i.e. cannot be passed as arguments to
+	 * kfunc or bpf helpers).
+	 */
+	PTR_UNTRUSTED		= BIT(6 + BPF_BASE_TYPE_BITS),
+
+	__BPF_TYPE_LAST_FLAG	= PTR_UNTRUSTED,
 };
 
 /* Max number of base types. */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c9ee44efed89..955c3125576a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -567,6 +567,8 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
 		strncpy(prefix, "user_", 32);
 	if (type & MEM_PERCPU)
 		strncpy(prefix, "percpu_", 32);
+	if (type & PTR_UNTRUSTED)
+		strncpy(prefix, "untrusted_", 32);
 
 	snprintf(env->type_str_buf, TYPE_STR_BUF_LEN, "%s%s%s",
 		 prefix, str[base_type(type)], postfix);
@@ -3504,9 +3506,14 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 			       struct bpf_reg_state *reg, u32 regno)
 {
 	const char *targ_name = kernel_type_name(off_desc->kptr.btf, off_desc->kptr.btf_id);
+	int perm_flags = PTR_MAYBE_NULL;
 	const char *reg_name = "";
 
-	if (base_type(reg->type) != PTR_TO_BTF_ID || type_flag(reg->type) != PTR_MAYBE_NULL)
+	/* Only unreferenced case accepts untrusted pointers */
+	if (off_desc->type == BPF_KPTR_UNREF)
+		perm_flags |= PTR_UNTRUSTED;
+
+	if (base_type(reg->type) != PTR_TO_BTF_ID || (type_flag(reg->type) & ~perm_flags))
 		goto bad_type;
 
 	if (!btf_is_kernel(reg->btf)) {
@@ -3553,7 +3560,12 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 bad_type:
 	verbose(env, "invalid kptr access, R%d type=%s%s ", regno,
 		reg_type_str(env, reg->type), reg_name);
-	verbose(env, "expected=%s%s\n", reg_type_str(env, PTR_TO_BTF_ID), targ_name);
+	verbose(env, "expected=%s%s", reg_type_str(env, PTR_TO_BTF_ID), targ_name);
+	if (off_desc->type == BPF_KPTR_UNREF)
+		verbose(env, " or %s%s\n", reg_type_str(env, PTR_TO_BTF_ID | PTR_UNTRUSTED),
+			targ_name);
+	else
+		verbose(env, "\n");
 	return -EINVAL;
 }
 
@@ -3577,9 +3589,11 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
 		return -EACCES;
 	}
 
-	/* We cannot directly access kptr_ref */
-	if (off_desc->type == BPF_KPTR_REF) {
-		verbose(env, "accessing referenced kptr disallowed\n");
+	/* We only allow loading referenced kptr, since it will be marked as
+	 * untrusted, similar to unreferenced kptr.
+	 */
+	if (class != BPF_LDX && off_desc->type == BPF_KPTR_REF) {
+		verbose(env, "store to referenced kptr disallowed\n");
 		return -EACCES;
 	}
 
@@ -3589,7 +3603,7 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
 		 * value from map as PTR_TO_BTF_ID, with the correct type.
 		 */
 		mark_btf_ld_reg(env, cur_regs(env), value_regno, PTR_TO_BTF_ID, off_desc->kptr.btf,
-				off_desc->kptr.btf_id, PTR_MAYBE_NULL);
+				off_desc->kptr.btf_id, PTR_MAYBE_NULL | PTR_UNTRUSTED);
 		/* For mark_ptr_or_null_reg */
 		val_reg->id = ++env->id_gen;
 	} else if (class == BPF_STX) {
@@ -4358,6 +4372,12 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 	if (ret < 0)
 		return ret;
 
+	/* If this is an untrusted pointer, all pointers formed by walking it
+	 * also inherit the untrusted flag.
+	 */
+	if (type_flag(reg->type) & PTR_UNTRUSTED)
+		flag |= PTR_UNTRUSTED;
+
 	if (atype == BPF_READ && value_regno >= 0)
 		mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id, flag);
 
@@ -13076,7 +13096,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 		if (!ctx_access)
 			continue;
 
-		switch (env->insn_aux_data[i + delta].ptr_type) {
+		switch ((int)env->insn_aux_data[i + delta].ptr_type) {
 		case PTR_TO_CTX:
 			if (!ops->convert_ctx_access)
 				continue;
@@ -13093,6 +13113,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			convert_ctx_access = bpf_xdp_sock_convert_ctx_access;
 			break;
 		case PTR_TO_BTF_ID:
+		case PTR_TO_BTF_ID | PTR_UNTRUSTED:
 			if (type == BPF_READ) {
 				insn->code = BPF_LDX | BPF_PROBE_MEM |
 					BPF_SIZE((insn)->code);
-- 
2.35.1


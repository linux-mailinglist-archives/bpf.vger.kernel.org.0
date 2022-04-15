Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40F9502D72
	for <lists+bpf@lfdr.de>; Fri, 15 Apr 2022 18:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355699AbiDOQGy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Apr 2022 12:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355698AbiDOQGx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Apr 2022 12:06:53 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6B87662
        for <bpf@vger.kernel.org>; Fri, 15 Apr 2022 09:04:24 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id 2so7939045pjw.2
        for <bpf@vger.kernel.org>; Fri, 15 Apr 2022 09:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lExf1LlxsEHZR1RTuXEEruuZFq14HzvYVZd180kTAFc=;
        b=pmfV8WksjyknYHr6WsfI+bWP7/U8cvssq8wa/BkBk7mIfxodJiYQ63yc3Kk24h95He
         gj3RBxyacuPTYjJZtFaMxiytWr/oFt3xbhdRC56KGVJt1QQ6F4mTpWtyR1hgri96LHZc
         iogsuaBZlwF6bxmUjhARZ/I/ZXb9h2Xyd3i54u1uIHqguxLbckGiASgxfIk29srmYxut
         0mo45VTC5+AJdowmmHU521JrRXD6NPpUNSgWGPwUju74CrWdbROca4OaolIQzUjZFyyI
         f7cYU1qSRjSDMSQHbeKl4ljWXFXaho0OLENXNYmzB8/GPtLG7lhcg4pohB4jdHCS8COw
         n44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lExf1LlxsEHZR1RTuXEEruuZFq14HzvYVZd180kTAFc=;
        b=3oxThGHuzeqhqtBBbKY90dwKqm0HTLVCMHtWMcVTDcWT2mB1sZsZhEERySGTC8iwr8
         LVFPBrrdT4IYPVRCdCCg/ccdRdrNGYp7HAn387rfsSEXpShupaqhxwE+en6m/Uew5r/G
         QhXwFSQFqlNhpKQmiOh72zf01z85B9gc1AkD2heUxc6nmb5i1dN3R7tVY++jE5PLZ6H2
         fLY83nUj8/kUIi4dP9XmbjwVtq9T8QxqpvKxa9CPN/DMB4eGWI60r9Y/SHIQ4Z1SKciu
         m3zHSqcAoiSJmWdnLxGRnPExw6TstxndEzhU+N7wHzmfZ4vgPx7zT9elWPRnS/1hb5dw
         wz6w==
X-Gm-Message-State: AOAM532xfjo9k2svyHPWk1JfwdinXjw6WFfHCRyTxfExM4E+h4mSTs5m
        UF8pG3DQFR4EL4WCC0O7qpV8FI/DZ0k=
X-Google-Smtp-Source: ABdhPJyzakfaXGu+xkwiRneTTPx0oD60MYyuk25mvRS+ZoPedbphD/+XwCm1ph6pKPJGW/28g0mEXw==
X-Received: by 2002:a17:902:7088:b0:156:1aa9:79eb with SMTP id z8-20020a170902708800b001561aa979ebmr52265163plk.71.1650038664106;
        Fri, 15 Apr 2022 09:04:24 -0700 (PDT)
Received: from localhost ([112.79.166.196])
        by smtp.gmail.com with ESMTPSA id f192-20020a636ac9000000b0039836edcf42sm4841275pgc.85.2022.04.15.09.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 09:04:23 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v5 06/13] bpf: Prevent escaping of kptr loaded from maps
Date:   Fri, 15 Apr 2022 21:33:47 +0530
Message-Id: <20220415160354.1050687-7-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415160354.1050687-1-memxor@gmail.com>
References: <20220415160354.1050687-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6518; h=from:subject; bh=ArWYG3W4SQ6jWPLk+poW1xgtjsD94I89QD3Oey3fsfw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiWZdCass8tc+8KDFoefRKm4iaAQ8mvvTFVttGPUYA +vrDGMGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYlmXQgAKCRBM4MiGSL8RykJlD/ 951BnYCi0FtJGoBtcr6ZnsbX/fker77MkiLMUnBS/L/vtjjkXM9hRj2JQx5g8jSLV5zMngozfv4snm YHUeMSo6dZ0jZvh5yUU1K7xDsHw9UqNg+H7Kx2atZO2PMnshTTctniFdQ80bj8TMdn9m3cl4juNdbe Yv7POBZg/tPy/uQL8ikvNf1GE2V8+8js43UJmheknYB9LCFfuo9YiBYVtOHbCHWKeyJy9OyRqQRRJ2 6ryPpP9aZZ4NmtflCyUAmxwvYc6RkBoABwTLWbYVDQOmDp3gQrcJpGpZQ7J0XXEeZQTqtqhlt7HfcE M3LOHmqWsGeWnXoOF4tOVJJr6AFccBhUl+uWwu4Q7ywhB3znnU71hpzHl72sf6gvfXTt257hwtBFHD DFmeyjCrF8kog8xF6sNJfHMMJuKEDOnusiKRswoKaLtJuSo6sWhuMUzNguGDeEinYIh8JfG9ixSxyI YhHsg/LuIGrkXR929VQMzkvkux+bs345MJvUn69aDyUzRCiSkl7NlitibBwe+5Rh3eL23duj4Zctyf G0Lj6+ajc92oVUK0sgVRfRv6s18vhnU97wf7N00BysxuCv8579p9SmZ1b1vErRf6hpFbm/HruXMgMZ E3jbS8Gk22HRJ4HgBfj7k9LPqNvqxfQapBSZjuZHn3Ti2BPmTN4vbrdCBD0w==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 61f83a23980f..7e2ac2a26bdb 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -375,7 +375,15 @@ enum bpf_type_flag {
 	/* Indicates that the pointer argument will be released. */
 	PTR_RELEASE		= BIT(5 + BPF_BASE_TYPE_BITS),
 
-	__BPF_TYPE_LAST_FLAG	= PTR_RELEASE,
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
index aa5c0d1c8495..3b89dc8d41ce 100644
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
+	if (off_desc->type == BPF_MAP_OFF_DESC_TYPE_UNREF_KPTR)
+		perm_flags |= PTR_UNTRUSTED;
+
+	if (base_type(reg->type) != PTR_TO_BTF_ID || (type_flag(reg->type) & ~perm_flags))
 		goto bad_type;
 
 	if (!btf_is_kernel(reg->btf)) {
@@ -3532,7 +3539,12 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 bad_type:
 	verbose(env, "invalid kptr access, R%d type=%s%s ", regno,
 		reg_type_str(env, reg->type), reg_name);
-	verbose(env, "expected=%s%s\n", reg_type_str(env, PTR_TO_BTF_ID), targ_name);
+	verbose(env, "expected=%s%s", reg_type_str(env, PTR_TO_BTF_ID), targ_name);
+	if (off_desc->type == BPF_MAP_OFF_DESC_TYPE_UNREF_KPTR)
+		verbose(env, " or %s%s\n", reg_type_str(env, PTR_TO_BTF_ID | PTR_UNTRUSTED),
+			targ_name);
+	else
+		verbose(env, "\n");
 	return -EINVAL;
 }
 
@@ -3556,9 +3568,11 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
 		return -EACCES;
 	}
 
-	/* We cannot directly access kptr_ref */
-	if (off_desc->type == BPF_MAP_OFF_DESC_TYPE_REF_KPTR) {
-		verbose(env, "accessing referenced kptr disallowed\n");
+	/* We only allow loading referenced kptr, since it will be marked as
+	 * untrusted, similar to unreferenced kptr.
+	 */
+	if (class != BPF_LDX && off_desc->type == BPF_MAP_OFF_DESC_TYPE_REF_KPTR) {
+		verbose(env, "store to referenced kptr disallowed\n");
 		return -EACCES;
 	}
 
@@ -3568,7 +3582,7 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
 		 * value from map as PTR_TO_BTF_ID, with the correct type.
 		 */
 		mark_btf_ld_reg(env, cur_regs(env), value_regno, PTR_TO_BTF_ID, off_desc->kptr.btf,
-				off_desc->kptr.btf_id, PTR_MAYBE_NULL);
+				off_desc->kptr.btf_id, PTR_MAYBE_NULL | PTR_UNTRUSTED);
 		val_reg->id = ++env->id_gen;
 	} else if (class == BPF_STX) {
 		val_reg = reg_state(env, value_regno);
@@ -4336,6 +4350,12 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
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
 
@@ -13054,7 +13074,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 		if (!ctx_access)
 			continue;
 
-		switch (env->insn_aux_data[i + delta].ptr_type) {
+		switch ((int)env->insn_aux_data[i + delta].ptr_type) {
 		case PTR_TO_CTX:
 			if (!ops->convert_ctx_access)
 				continue;
@@ -13071,6 +13091,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			convert_ctx_access = bpf_xdp_sock_convert_ctx_access;
 			break;
 		case PTR_TO_BTF_ID:
+		case PTR_TO_BTF_ID | PTR_UNTRUSTED:
 			if (type == BPF_READ) {
 				insn->code = BPF_LDX | BPF_PROBE_MEM |
 					BPF_SIZE((insn)->code);
-- 
2.35.1


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5AA4E1C67
	for <lists+bpf@lfdr.de>; Sun, 20 Mar 2022 16:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244429AbiCTP5E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Mar 2022 11:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245410AbiCTP5E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Mar 2022 11:57:04 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F5354194
        for <bpf@vger.kernel.org>; Sun, 20 Mar 2022 08:55:41 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s72so5952160pgc.5
        for <bpf@vger.kernel.org>; Sun, 20 Mar 2022 08:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nYf48VEX3+P4bixfCnu0l75BtD8ZTpoiibp1OpdQj2I=;
        b=LrNV5Ne7dD0sFo84fyDb5MnZCbh5gzawC4iz1FGBwqTm7q9Hti9xtmmYtev3QS+p4i
         JbjoBgGu0zXbcoBXBT/gUxCd6/JeEIIXMewFCoiWwDxXnQKXpSxQGpKDe94Gc+XaJ+ME
         iDmWwV9oubS3Bey2lXfBo6bRXDMN0dms4IiZyveoVJMXsVGrhhUb+JS34rZI6Pmxg8Cc
         6A9XmkdHDFD4xfk2BZrcKhtYktimZ/4sQLvcnGuXHUA6GRHLaOfzBgAIFW6BNyPLQmPW
         p0/9ldx9p6Q0ODLmgKpF/0Zovn6Tw7qWkxmVwl+Lv2kzE3Je01CFS4XIR9IIQm1GJCEr
         3m3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nYf48VEX3+P4bixfCnu0l75BtD8ZTpoiibp1OpdQj2I=;
        b=mcOQaboNXLdSQ6cqC+Rv4eEQwj/Z4JiGyZoK6yNN+bNK/aDlCtTvt9bZChMXJ890Ha
         QuwXkV76/8OIbJ2z5xqF3zsmfxyJI+Znftl3a7CGtzrvtMQ4FyaC1DgO2XTFjhb4xCAR
         TZsLtc8iKLD7fwvLoqwCg7L+51d/jfsUzXRQMfpRyHSh4TsS6I5FR8gbGkcshD8Agr3n
         DPQCBkJE/sZngWu/mgRSeMwlc27DDVd+X9FWMEfc8cNMZKybttzdB59YGJ3m3+yYkXm7
         dOmG5ScM/pyWZDK8CaxgZmz7epD2wErSJ5Cl+qsd2fgUQQs0+llDjefAUYMutzqcDzMW
         d+Sw==
X-Gm-Message-State: AOAM5311RGvq/o77j2IbEpYtp/yy9H7Q7KpoUWPOsYkKQMJbQlY+CpbG
        k76ubcdZDkBCRrTyhnV1wyuZ/NCERh0=
X-Google-Smtp-Source: ABdhPJxyi84SRB7VJQBuMX7ujJJmO3aZi6jQlZaVsWbdy7uT8x4r94sAujoyQf/875hxPCfsgXia4w==
X-Received: by 2002:a63:ea51:0:b0:380:7c35:188e with SMTP id l17-20020a63ea51000000b003807c35188emr15143886pgk.607.1647791740661;
        Sun, 20 Mar 2022 08:55:40 -0700 (PDT)
Received: from localhost ([14.139.187.71])
        by smtp.gmail.com with ESMTPSA id j23-20020a17090a841700b001c678ac3b4bsm10528299pjn.14.2022.03.20.08.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 08:55:40 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v3 06/13] bpf: Prevent escaping of kptr loaded from maps
Date:   Sun, 20 Mar 2022 21:25:03 +0530
Message-Id: <20220320155510.671497-7-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220320155510.671497-1-memxor@gmail.com>
References: <20220320155510.671497-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6017; h=from:subject; bh=KAUHyNQY0gWctZKJXveg9zTRVc8SubaUYgGT8dpTKCc=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiN00yretAtcKT6OQVTbUkuEa+MqFR5sIMFQtFQJj1 8gFzo1iJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYjdNMgAKCRBM4MiGSL8RysD0D/ 4xsOi4u6npSmhNpM9NSwi8TB5X4eTg+R16MGaeRmtn1ZhVJf5at+/EGCMShlbcWq9pZrjccQIzP2oe sT6ybQyBUIZQBylxayQGBCMN27I1ldVBIrRt7TaRY7vR3fUvPbISXiI7xYUgsz0cF8VTgZA1res7gn Zgt9mpU7rgloptxhm6Q9EibH48sJ4V9Kq60YX2T8n80sj1raagHS+PShhwenTs08Ew7CRrXEW2ZGeP +XZ2sGX6SoFWGV/1fI+ACJzLYzWYMMLYATRDiC0vcfdrJdk6xbGUOtCL1JUrGgemA/P4byx1BUqsT2 yc1ad00VJ04dJZQZ9hzbnyqi7fx1wewKpaudhrtVPNj22GUgFGtyhf6FgeutQBX/aZQEVRN83eoDva DjyfN9fJgmk0btzuiwSPyycK5neBX8GcWf3Aj05mVEF9TZzG/HzV5Xj7D2SMR9A/1nJQW6GVfGU4xJ L4MH2MYH9QqR2jPFi8df61xCQPVTNQfqfuFG8SDT+LlRAINff/3Mtng8PLqikxUVfXjMDOFaGaHkqt 2aao+eF2Hc2CaF+aoCADzTzJB+Rd0htW04vp9VD3SHdbHmV2kJLaZCfG+zHs09qQd09oXnU38jHZCR iOzQ69WhDkOd30KUADACJhOmtp1UVqNU59Wd1GnAiZej+/ZlHD6PRYq94wbg==
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
 kernel/bpf/verifier.c | 34 +++++++++++++++++++++++++++-------
 2 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6814e4885fab..9d424d567dd3 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -369,7 +369,15 @@ enum bpf_type_flag {
 	 */
 	MEM_PERCPU		= BIT(4 + BPF_BASE_TYPE_BITS),
 
-	__BPF_TYPE_LAST_FLAG	= MEM_PERCPU,
+	/* PTR is not trusted. This is only used with PTR_TO_BTF_ID, to mark
+	 * unreferenced and referenced kptr loaded from map value using a load
+	 * instruction, so that they can only be dereferenced but not escape the
+	 * BPF program into the kernel (i.e. cannot be passed as arguments to
+	 * kfunc or bpf helpers).
+	 */
+	PTR_UNTRUSTED		= BIT(5 + BPF_BASE_TYPE_BITS),
+
+	__BPF_TYPE_LAST_FLAG	= PTR_UNTRUSTED,
 };
 
 /* Max number of base types. */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f731a0b45acb..9c5c72ea1d98 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -579,6 +579,8 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
 		strncpy(prefix, "user_", 32);
 	if (type & MEM_PERCPU)
 		strncpy(prefix, "percpu_", 32);
+	if (type & PTR_UNTRUSTED)
+		strncpy(prefix, "untrusted_", 32);
 
 	snprintf(env->type_str_buf, TYPE_STR_BUF_LEN, "%s%s%s",
 		 prefix, str[base_type(type)], postfix);
@@ -3520,8 +3522,17 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 	const char *reg_name = "";
 	bool fixed_off_ok = true;
 
-	if (reg->type != PTR_TO_BTF_ID && reg->type != PTR_TO_BTF_ID_OR_NULL)
-		goto bad_type;
+	if (off_desc->flags & BPF_MAP_VALUE_OFF_F_REF) {
+		if (reg->type != PTR_TO_BTF_ID &&
+		    reg->type != (PTR_TO_BTF_ID | PTR_MAYBE_NULL))
+			goto bad_type;
+	} else { /* only unreferenced case accepts untrusted pointers */
+		if (reg->type != PTR_TO_BTF_ID &&
+		    reg->type != (PTR_TO_BTF_ID | PTR_MAYBE_NULL) &&
+		    reg->type != (PTR_TO_BTF_ID | PTR_UNTRUSTED) &&
+		    reg->type != (PTR_TO_BTF_ID | PTR_MAYBE_NULL | PTR_UNTRUSTED))
+			goto bad_type;
+	}
 
 	if (!btf_is_kernel(reg->btf)) {
 		verbose(env, "R%d must point to kernel BTF\n", regno);
@@ -3592,9 +3603,11 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
 	if (BPF_MODE(insn->code) != BPF_MEM)
 		goto end;
 
-	/* We cannot directly access kptr_ref */
-	if (off_desc->flags & BPF_MAP_VALUE_OFF_F_REF) {
-		verbose(env, "accessing referenced kptr disallowed\n");
+	/* We only allow loading referenced kptr, since it will be marked as
+	 * untrusted, similar to unreferenced kptr.
+	 */
+	if (class != BPF_LDX && (off_desc->flags & BPF_MAP_VALUE_OFF_F_REF)) {
+		verbose(env, "store to referenced kptr disallowed\n");
 		return -EACCES;
 	}
 
@@ -3604,7 +3617,7 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
 		 * value from map as PTR_TO_BTF_ID, with the correct type.
 		 */
 		mark_btf_ld_reg(env, cur_regs(env), value_regno, PTR_TO_BTF_ID, off_desc->btf,
-				off_desc->btf_id, PTR_MAYBE_NULL);
+				off_desc->btf_id, PTR_MAYBE_NULL | PTR_UNTRUSTED);
 		val_reg->id = ++env->id_gen;
 	} else if (class == BPF_STX) {
 		val_reg = reg_state(env, value_regno);
@@ -4369,6 +4382,12 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
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
 
@@ -13065,7 +13084,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 		if (!ctx_access)
 			continue;
 
-		switch (env->insn_aux_data[i + delta].ptr_type) {
+		switch ((int)env->insn_aux_data[i + delta].ptr_type) {
 		case PTR_TO_CTX:
 			if (!ops->convert_ctx_access)
 				continue;
@@ -13082,6 +13101,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			convert_ctx_access = bpf_xdp_sock_convert_ctx_access;
 			break;
 		case PTR_TO_BTF_ID:
+		case PTR_TO_BTF_ID | PTR_UNTRUSTED:
 			if (type == BPF_READ) {
 				insn->code = BPF_LDX | BPF_PROBE_MEM |
 					BPF_SIZE((insn)->code);
-- 
2.35.1


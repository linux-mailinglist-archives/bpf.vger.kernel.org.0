Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE774629AF
	for <lists+bpf@lfdr.de>; Tue, 30 Nov 2021 02:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236288AbhK3BdO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Nov 2021 20:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236282AbhK3BdO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Nov 2021 20:33:14 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58434C061574
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 17:29:56 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id j6-20020a17090276c600b0014377d8ede3so7281806plt.21
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 17:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cNX39YmimwuX4mdXBgMYmfyTx7hzHdSKI43Z5rrPPBA=;
        b=eWnxmrJ8HsAvvpVZ0nyg0cw31RqVgXGSVXZ/c+ljm4dTyZpBt9B7XW0VUqrrgC2mC1
         AnXi0ESreHA7zqsSpsj+iZssDo60W8+XBDX4qg9xsciSLorrVfNj4stMejy0fmKfr4hp
         pN+g5hbw6sqs5yxxVj/Sa45tKFNBOhH4vmQBDelKmR7U3s5/gw+IJ5zQV27+dj3l31CO
         Gl3OyBdbHcP4SIQJTx1xGeyA5bFhn/tjD21xAnf2omthfcqSLd9OC+8ulsnh4mbA8PBI
         BmRwnwdXBG5YVpQVe8l3jnjECiTrZhTEs9vtvvArlVoNHjts1RI1wbCqQ7J/Co1XVJDv
         t4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cNX39YmimwuX4mdXBgMYmfyTx7hzHdSKI43Z5rrPPBA=;
        b=HK2O1xKmNFrMaxwAEsN/cCMGeY0z69q8HglI9gT0BRAf7di2bQqfdGrAv1yT/8DSjo
         cI0fdTmaknkAr0PmBRghrka7eE8FK37aMg0ldnfzgxE5WiLroQCneOtVpi+jZgSSk35F
         JFBcmqEpgVvNSquPwqlwcuV7UCsl+GL9Z9glF8YgIenidR/W+xCSFoQYP8tgTcb61Ohf
         BJuTWYQOwY+2U5gcBqA+9rx+GNZYIT16cGFOkeBVwd9SlJ6tBXt5LLwq9guCZY6STtBa
         G6+/N99OA2nbhzsozqF+tb+BRrHJrtQpJUQx5/jDcfMVT1xcdW9vXcDVIMiPPmNtjt88
         lI/g==
X-Gm-Message-State: AOAM532xlBtyCL0wSf052GDyRWwiUC6Q9Q7o44TLWqn7pVd7eM13GwgY
        BfFGBAHA0H/Ew32N6hL6PGsEmfjlz1k=
X-Google-Smtp-Source: ABdhPJzCUUwsHuYCXYCHfg/4DPK7WiwDtk2Fw+XOK87kM4e9rBJ/c76sSmV1CN925Bg9kvBmWUIqJOHbu7A=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:bbf5:5c09:9dfe:483c])
 (user=haoluo job=sendgmr) by 2002:a17:90b:4c85:: with SMTP id
 my5mr2120747pjb.26.1638235795706; Mon, 29 Nov 2021 17:29:55 -0800 (PST)
Date:   Mon, 29 Nov 2021 17:29:40 -0800
In-Reply-To: <20211130012948.380602-1-haoluo@google.com>
Message-Id: <20211130012948.380602-2-haoluo@google.com>
Mime-Version: 1.0
References: <20211130012948.380602-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.0.384.gca35af8252-goog
Subject: [RFC PATCH bpf-next v2 1/9] bpf: Introduce composable reg, ret and
 arg types.
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        bpf@vger.kernel.org, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There are some common properties shared between bpf reg, ret and arg
values. For instance, a value may be a NULL pointer, or a pointer to
a read-only memory. Previously, to express these properties, enumeration
was used. For example, in order to test whether a reg value can be NULL,
reg_type_may_be_null() simply enumerates all types that are possibly
NULL. The problem of this approach is that it's not scalable and causes
a lot of duplication. These properties can be combined, for example, a
type could be either MAYBE_NULL or RDONLY, or both.

This patch series rewrites the layout of reg_type, arg_type and
ret_type, so that common properties can be extracted and represented as
composable flag. For example, one can write

 ARG_PTR_TO_MEM | PTR_MAYBE_NULL

which is equivalent to the previous

 ARG_PTR_TO_MEM_OR_NULL

The type ARG_PTR_TO_MEM are called "base types" in this patch. Base
types can be extended with flags. A flag occupies the higher bits while
base types sits in the lower bits.

This patch in particular sets up a set of macro for this purpose. The
followed patches rewrites arg_types, ret_types and reg_types
respectively.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 include/linux/bpf.h | 50 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cc7a0c36e7df..b592b3f7d223 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -297,6 +297,37 @@ bool bpf_map_meta_equal(const struct bpf_map *meta0,
 
 extern const struct bpf_map_ops bpf_map_offload_ops;
 
+/* bpf_type_flag contains a set of flags that are applicable to the values of
+ * arg_type, ret_type and reg_type. For example, a pointer value may be null,
+ * or a memory is read-only. We classify types into two categories: base types
+ * and extended types. Extended types are base types combined with a type flag.
+ *
+ * Currently there are no more than 32 base types in arg_type, ret_type and
+ * reg_types.
+ */
+#define BPF_BASE_TYPE_BITS	8
+
+enum bpf_type_flag {
+	/* PTR may be NULL. */
+	PTR_MAYBE_NULL		= BIT(0 + BPF_BASE_TYPE_BITS),
+
+	__BPF_TYPE_LAST_FLAG	= PTR_MAYBE_NULL,
+};
+
+#define BPF_BASE_TYPE_MASK	GENMASK(BPF_BASE_TYPE_BITS, 0)
+
+/* Max number of base types. */
+#define BPF_BASE_TYPE_LIMIT	(1UL << BPF_BASE_TYPE_BITS)
+
+/* Max number of all types. */
+#define BPF_TYPE_LIMIT		(__BPF_TYPE_LAST_FLAG | (__BPF_TYPE_LAST_FLAG - 1))
+
+/* extract base type. */
+#define BPF_BASE_TYPE(x)	((x) & BPF_BASE_TYPE_MASK)
+
+/* extract flags from an extended type. */
+#define BPF_TYPE_FLAG(x)	((enum bpf_type_flag)((x) & ~BPF_BASE_TYPE_MASK))
+
 /* function argument constraints */
 enum bpf_arg_type {
 	ARG_DONTCARE = 0,	/* unused argument in helper function */
@@ -343,7 +374,13 @@ enum bpf_arg_type {
 	ARG_PTR_TO_CONST_STR,	/* pointer to a null terminated read-only string */
 	ARG_PTR_TO_TIMER,	/* pointer to bpf_timer */
 	__BPF_ARG_TYPE_MAX,
+
+	/* This must be the last entry. Its purpose is to ensure the enum is
+	 * wide enough to hold the higher bits reserved for bpf_type_flag.
+	 */
+	__BPF_ARG_TYPE_LIMIT	= BPF_TYPE_LIMIT,
 };
+static_assert(__BPF_ARG_TYPE_MAX <= BPF_BASE_TYPE_LIMIT);
 
 /* type of values returned from helper functions */
 enum bpf_return_type {
@@ -359,7 +396,14 @@ enum bpf_return_type {
 	RET_PTR_TO_MEM_OR_BTF_ID_OR_NULL, /* returns a pointer to a valid memory or a btf_id or NULL */
 	RET_PTR_TO_MEM_OR_BTF_ID,	/* returns a pointer to a valid memory or a btf_id */
 	RET_PTR_TO_BTF_ID,		/* returns a pointer to a btf_id */
+	__BPF_RET_TYPE_MAX,
+
+	/* This must be the last entry. Its purpose is to ensure the enum is
+	 * wide enough to hold the higher bits reserved for bpf_type_flag.
+	 */
+	__BPF_RET_TYPE_LIMIT	= BPF_TYPE_LIMIT,
 };
+static_assert(__BPF_RET_TYPE_MAX <= BPF_BASE_TYPE_LIMIT);
 
 /* eBPF function prototype used by verifier to allow BPF_CALLs from eBPF programs
  * to in-kernel helper functions and for adjusting imm32 field in BPF_CALL
@@ -461,7 +505,13 @@ enum bpf_reg_type {
 	PTR_TO_FUNC,		 /* reg points to a bpf program function */
 	PTR_TO_MAP_KEY,		 /* reg points to a map element key */
 	__BPF_REG_TYPE_MAX,
+
+	/* This must be the last entry. Its purpose is to ensure the enum is
+	 * wide enough to hold the higher bits reserved for bpf_type_flag.
+	 */
+	__BPF_REG_TYPE_LIMIT	= BPF_TYPE_LIMIT,
 };
+static_assert(__BPF_REG_TYPE_MAX <= BPF_BASE_TYPE_LIMIT);
 
 /* The information passed from prog-specific *_is_valid_access
  * back to the verifier.
-- 
2.34.0.384.gca35af8252-goog


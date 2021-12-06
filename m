Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D3D46AE57
	for <lists+bpf@lfdr.de>; Tue,  7 Dec 2021 00:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343821AbhLFX0C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Dec 2021 18:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242479AbhLFX0C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Dec 2021 18:26:02 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD9EC061746
        for <bpf@vger.kernel.org>; Mon,  6 Dec 2021 15:22:33 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id b26-20020aa7951a000000b004a815eb3a3aso7416596pfp.16
        for <bpf@vger.kernel.org>; Mon, 06 Dec 2021 15:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=E21RldZfy03eyCEIqqzDfAZe2+SS0wPacoHltYAwiG8=;
        b=g2/DMWBuIngBWHMY4tcr6K/wQ329mTY64H70g7ZQncijP7q6o4a1rkfAC2OXHaKRZO
         kunsnYhCnWsI8zcp8O8Rq+Va94gH+If7qnPQO8GQU7ihS9FI6EoKfnSoGG+cN4fIJQEM
         QpIPUpvp7Bo3yFh1o9Mq3ZueB6chhe2VZC49fHUITKyljvPPhjYsbQnRHDNlZuV6iFdF
         yPfsm/VHM2rQXGSPpCpPEH+m2jh9pCN9OYFJj4J964t7FDqYy5ZPto086Rv9DqZMtHC8
         mtwtDwG7s/2zfUIzaHDlykxPYX/C6XSDCrCsGdnzySq+epGVbZkDfeNZJ6jQfqgouzRJ
         b2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=E21RldZfy03eyCEIqqzDfAZe2+SS0wPacoHltYAwiG8=;
        b=Hv8TcRn90HUDL8JT1qZoqaDy0BOTBZ9KT9pcLUUPCJX8b1dDTBloygr6u3Qjb4wEt/
         QovZVLdAFwnD+mv90nQJ7+9i5giaS8rJHgPuYv88Q4/vNKpCtCxhivqEFKJeddmSaknQ
         Zxe7h6BBFiW2Phv2LC9C13fOECSGjcURIT+yGr2LNvPghogqWADSpFVH7t8Zmw2ZP004
         Y2OtMRMq/g+3CoX84tjTn719/hy/DFJkRDsHk1s+msav3v5NOw1vCeEKgDh0sk7IgPmj
         ySf9qUzsOGYG7k2AO8oka12a/e+i6gAHv9OSQVHtToMWx+o/gAutk5KrbjFNs1ykvXYY
         L0Fg==
X-Gm-Message-State: AOAM530fy+MsXaOrUNyqcgpZ+Q7JdejHX9QWQDQV8ALk4+exBNMEm3X6
        p22c0ZREmINaMWIU6J20pmA16inQzIA=
X-Google-Smtp-Source: ABdhPJxkSBVjAwin6+43Urghnd1WyBgqYpCfB0CL+L2968RX1rHD9MsqirQMQUWYi3FQLZ7aZoRM5JjbJC8=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:2977:d88c:3c3:c52a])
 (user=haoluo job=sendgmr) by 2002:a17:902:9684:b0:143:cc70:6472 with SMTP id
 n4-20020a170902968400b00143cc706472mr47389006plp.70.1638832952798; Mon, 06
 Dec 2021 15:22:32 -0800 (PST)
Date:   Mon,  6 Dec 2021 15:22:19 -0800
In-Reply-To: <20211206232227.3286237-1-haoluo@google.com>
Message-Id: <20211206232227.3286237-2-haoluo@google.com>
Mime-Version: 1.0
References: <20211206232227.3286237-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH bpf-next v1 1/9] bpf: Introduce composable reg, ret and arg types.
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

The type ARG_PTR_TO_MEM are called "base type" in this patch. Base
types can be extended with flags. A flag occupies the higher bits while
base types sits in the lower bits.

This patch in particular sets up a set of macro for this purpose. The
following patches will rewrite arg_types, ret_types and reg_types
respectively.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 include/linux/bpf.h          | 42 ++++++++++++++++++++++++++++++++++++
 include/linux/bpf_verifier.h | 13 +++++++++++
 2 files changed, 55 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cc7a0c36e7df..d8e6f8cd78a2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -297,6 +297,29 @@ bool bpf_map_meta_equal(const struct bpf_map *meta0,
 
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
+/* Max number of base types. */
+#define BPF_BASE_TYPE_LIMIT	(1UL << BPF_BASE_TYPE_BITS)
+
+/* Max number of all types. */
+#define BPF_TYPE_LIMIT		(__BPF_TYPE_LAST_FLAG | (__BPF_TYPE_LAST_FLAG - 1))
+
 /* function argument constraints */
 enum bpf_arg_type {
 	ARG_DONTCARE = 0,	/* unused argument in helper function */
@@ -343,7 +366,13 @@ enum bpf_arg_type {
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
@@ -359,7 +388,14 @@ enum bpf_return_type {
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
@@ -461,7 +497,13 @@ enum bpf_reg_type {
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
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c8a78e830fca..0840c3025822 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -529,5 +529,18 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    struct bpf_attach_target_info *tgt_info);
 void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab);
 
+#define BPF_BASE_TYPE_MASK	GENMASK(BPF_BASE_TYPE_BITS - 1, 0)
+
+/* extract base type from bpf_{arg, return, reg}_type. */
+static inline u32 base_type(u32 type)
+{
+	return type & BPF_BASE_TYPE_MASK;
+}
+
+/* extract flags from an extended type. See bpf_type_flag in bpf.h. */
+static inline u32 type_flag(u32 type)
+{
+	return type & ~BPF_BASE_TYPE_MASK;
+}
 
 #endif /* _LINUX_BPF_VERIFIER_H */
-- 
2.34.1.400.ga245620fadb-goog


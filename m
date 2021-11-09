Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBC044A47F
	for <lists+bpf@lfdr.de>; Tue,  9 Nov 2021 03:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238818AbhKICTV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Nov 2021 21:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbhKICTU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Nov 2021 21:19:20 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCCAC061570
        for <bpf@vger.kernel.org>; Mon,  8 Nov 2021 18:16:35 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id z2-20020a254c02000000b005b68ef4fe24so28182635yba.11
        for <bpf@vger.kernel.org>; Mon, 08 Nov 2021 18:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Xui5NGx6xZn80XKPeiu19bYnbiMY+6CPwqtc3BJKfHI=;
        b=g5bIU6Iy8gqCP1bazuL6Ub1KtLhDPFLL+Pupkz8fK2pLy78esO2SkpCqM3HBnPFerE
         Z6Gnqsnj51wKk0NbNkzf2ZWBwRMK2SqqyK4MNewQ+uPGJB+XUd1cn3E4h6Py6fJPv/bl
         qa8N2NM5oKkERPIX4uJNjjq7TexjCpBABagd0/XU7hk9nV0M7TEUe2vJBjdJh93aM6d/
         gMbMpzTNJHCWW/KCa5yKmCICUuQKzbzV/gdHthd0k0LrSnWg4XMBbZSjIwFcqiSe5dWB
         d84ITyxVatMTqcMtlZfplm+noDQ0Glo5eMd064+/+rIkt3yerj+un5RydeWtuRUttMkb
         0naQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Xui5NGx6xZn80XKPeiu19bYnbiMY+6CPwqtc3BJKfHI=;
        b=pRuWPBu8HMGn2JPjVOWUHKtTrXgcPRdSCz+JzdkdO+JEha7kCBkGgrqGAblTBbu3Gk
         B9EHx98YDr/nUYiPOvPlMjtqAtTUu9oSyvu4njOFbOdrnhD1ha+mFDWE6t1/K63ieUvv
         LMvB4SsQjMgk5MV6ywD3zanVFlg2xFy1ok4s3H56WMqcUxSHksh1d4y3fcuF170QL6fJ
         5GquOLm2JKmVA9ew0//KxxA1c2rwt0WAkjNTxitLkITufSaNhHUELj9BtvHXjuIER/zZ
         s3nJj4lVFw6cG0CiMDNRrOsO0HW6uRiXWxU2u+a2a3qLo9WnmUrPNz7i9Skjkn7e3yqS
         WOww==
X-Gm-Message-State: AOAM530g2mwKoDezRUXe11i5/R9nb6kaW4HfYCgOhZtemi9EsZxavQmF
        WMasJ5JahFcgBrLbfctOr9XG/v8hwMo=
X-Google-Smtp-Source: ABdhPJwNHpysoocGpL915610yEPa7xlHyOkNWUM3D4qrryw2LKkNS9C+b8Pz5Fw2r/+2G8enRDSzLHBRUHs=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:4c6:4bbe:e4c5:ff76])
 (user=haoluo job=sendgmr) by 2002:a25:5402:: with SMTP id i2mr4515093ybb.312.1636424194951;
 Mon, 08 Nov 2021 18:16:34 -0800 (PST)
Date:   Mon,  8 Nov 2021 18:16:17 -0800
In-Reply-To: <20211109021624.1140446-1-haoluo@google.com>
Message-Id: <20211109021624.1140446-3-haoluo@google.com>
Mime-Version: 1.0
References: <20211109021624.1140446-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [RFC PATCH bpf-next 2/9] bpf: Remove ARG_PTR_TO_MAP_VALUE_OR_NULL
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

Remove ARG_PTR_TO_MAP_VALUE_OR_NULL and use flag to mark that
the argument may be null.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 include/linux/bpf.h            |  6 +++++-
 kernel/bpf/bpf_inode_storage.c |  5 ++++-
 kernel/bpf/bpf_task_storage.c  |  5 ++++-
 kernel/bpf/verifier.c          | 11 +++++------
 net/core/bpf_sk_storage.c      | 15 ++++++++++++---
 5 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 287d819e73f8..d8de8f00e40d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -297,6 +297,9 @@ bool bpf_map_meta_equal(const struct bpf_map *meta0,
 
 extern const struct bpf_map_ops bpf_map_offload_ops;
 
+/* argument may be null or zero */
+#define ARG_FLAG_MAYBE_NULL	1
+
 /* function argument constraints */
 struct bpf_arg_type {
 	enum {
@@ -309,7 +312,6 @@ struct bpf_arg_type {
 		ARG_PTR_TO_MAP_KEY,	/* pointer to stack used as map key */
 		ARG_PTR_TO_MAP_VALUE,	/* pointer to stack used as map value */
 		ARG_PTR_TO_UNINIT_MAP_VALUE,	/* pointer to valid memory used to store a map value */
-		ARG_PTR_TO_MAP_VALUE_OR_NULL,	/* pointer to stack used as map value or NULL */
 
 		/* the following constraints used to prototype bpf_memcmp() and other
 		 * functions that access data on eBPF program stack
@@ -345,6 +347,8 @@ struct bpf_arg_type {
 		ARG_PTR_TO_TIMER,	/* pointer to bpf_timer */
 		__BPF_ARG_TYPE_MAX,
 	} type;
+
+	u8 flag;
 };
 
 /* type of values returned from helper functions */
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index 091352613225..acb566a3b37f 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -265,7 +265,10 @@ const struct bpf_func_proto bpf_inode_storage_get_proto = {
 	.arg1		= { .type = ARG_CONST_MAP_PTR, }
 	.arg2		= { .type = ARG_PTR_TO_BTF_ID, }
 	.arg2_btf_id	= &bpf_inode_storage_btf_ids[0],
-	.arg3		= { .type = ARG_PTR_TO_MAP_VALUE_OR_NULL, }
+	.arg3		= {
+		.type = ARG_PTR_TO_MAP_VALUE,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	}
 	.arg4_type	= { .type = ARG_ANYTHING, }
 };
 
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index 04bb681edc78..bdc0925c2fd3 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -324,7 +324,10 @@ const struct bpf_func_proto bpf_task_storage_get_proto = {
 	.arg1	 = { .type = ARG_CONST_MAP_PTR },
 	.arg2	 = { .type = ARG_PTR_TO_BTF_ID },
 	.arg2_btf_id = &btf_task_struct_ids[0],
-	.arg3	 = { .type = ARG_PTR_TO_MAP_VALUE_OR_NULL },
+	.arg3	 = {
+		.type = ARG_PTR_TO_MAP_VALUE,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 	.arg4	 = { .type = ARG_ANYTHING },
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1f2aaa2214d9..f55967f92d22 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -480,7 +480,7 @@ static bool arg_type_may_be_refcounted(struct bpf_arg_type arg)
 
 static bool arg_type_may_be_null(struct bpf_arg_type arg)
 {
-	return arg.type == ARG_PTR_TO_MAP_VALUE_OR_NULL ||
+	return arg.flag & ARG_FLAG_MAYBE_NULL ||
 	       arg.type == ARG_PTR_TO_MEM_OR_NULL ||
 	       arg.type == ARG_PTR_TO_CTX_OR_NULL ||
 	       arg.type == ARG_PTR_TO_SOCKET_OR_NULL ||
@@ -5089,7 +5089,6 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 	[ARG_PTR_TO_MAP_KEY]		= &map_key_value_types,
 	[ARG_PTR_TO_MAP_VALUE]		= &map_key_value_types,
 	[ARG_PTR_TO_UNINIT_MAP_VALUE]	= &map_key_value_types,
-	[ARG_PTR_TO_MAP_VALUE_OR_NULL]	= &map_key_value_types,
 	[ARG_CONST_SIZE]		= &scalar_types,
 	[ARG_CONST_SIZE_OR_ZERO]	= &scalar_types,
 	[ARG_CONST_ALLOC_SIZE_OR_ZERO]	= &scalar_types,
@@ -5209,8 +5208,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg_num,
 	}
 
 	if (arg.type == ARG_PTR_TO_MAP_VALUE ||
-	    arg.type == ARG_PTR_TO_UNINIT_MAP_VALUE ||
-	    arg.type == ARG_PTR_TO_MAP_VALUE_OR_NULL) {
+	    arg.type == ARG_PTR_TO_UNINIT_MAP_VALUE) {
 		err = resolve_map_arg_type(env, meta, &arg);
 		if (err)
 			return err;
@@ -5286,9 +5284,10 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg_num,
 					      meta->map_ptr->key_size, false,
 					      NULL);
 	} else if (arg.type == ARG_PTR_TO_MAP_VALUE ||
-		   (arg.type == ARG_PTR_TO_MAP_VALUE_OR_NULL &&
-		    !register_is_null(reg)) ||
 		   arg.type == ARG_PTR_TO_UNINIT_MAP_VALUE) {
+		if ((arg.flag & ARG_FLAG_MAYBE_NULL) && register_is_null(reg))
+			return err;
+
 		/* bpf_map_xxx(..., map_ptr, ..., value) call:
 		 * check [value, value + map->value_size) validity
 		 */
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 81f8529c0169..22fdbe3d68e3 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -357,7 +357,10 @@ const struct bpf_func_proto bpf_sk_storage_get_proto = {
 	.ret_type	= RET_PTR_TO_MAP_VALUE_OR_NULL,
 	.arg1		= { .type = ARG_CONST_MAP_PTR },
 	.arg2		= { .type = ARG_PTR_TO_BTF_ID_SOCK_COMMON },
-	.arg3		= { .type = ARG_PTR_TO_MAP_VALUE_OR_NULL },
+	.arg3		= {
+		.type = ARG_PTR_TO_MAP_VALUE,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 	.arg4		= { .type = ARG_ANYTHING },
 };
 
@@ -367,7 +370,10 @@ const struct bpf_func_proto bpf_sk_storage_get_cg_sock_proto = {
 	.ret_type	= RET_PTR_TO_MAP_VALUE_OR_NULL,
 	.arg1		= { .type = ARG_CONST_MAP_PTR },
 	.arg2		= { .type = ARG_PTR_TO_CTX }, /* context is 'struct sock' */
-	.arg3		= { .type = ARG_PTR_TO_MAP_VALUE_OR_NULL },
+	.arg3		= {
+		.type = ARG_PTR_TO_MAP_VALUE,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 	.arg4		= { .type = ARG_ANYTHING },
 };
 
@@ -438,7 +444,10 @@ const struct bpf_func_proto bpf_sk_storage_get_tracing_proto = {
 	.arg1		= { .type = ARG_CONST_MAP_PTR },
 	.arg2		= { .type = ARG_PTR_TO_BTF_ID },
 	.arg2_btf_id	= &btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON],
-	.arg3		= { .type = ARG_PTR_TO_MAP_VALUE_OR_NULL },
+	.arg3		= {
+		.type = ARG_PTR_TO_MAP_VALUE,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 	.arg4		= { .type = ARG_ANYTHING },
 	.allowed	= bpf_sk_storage_tracing_allowed,
 };
-- 
2.34.0.rc0.344.g81b53c2807-goog


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E97E44A482
	for <lists+bpf@lfdr.de>; Tue,  9 Nov 2021 03:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhKICT1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Nov 2021 21:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238836AbhKICT0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Nov 2021 21:19:26 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADDCC061570
        for <bpf@vger.kernel.org>; Mon,  8 Nov 2021 18:16:41 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id v18-20020a170902e8d200b00141df2da949so7653660plg.10
        for <bpf@vger.kernel.org>; Mon, 08 Nov 2021 18:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Hr+wzLJaJv9mNlYaiZKEYC36LQnuHRG9zrvQaabYIiY=;
        b=YDr1IZGokEZecCjrwDWZw+2m3b25mWyGGhXrrfqoza+vxrzmxY3wm34+nqrKzKrBr5
         aVrS1J0SCRF6IKxIDjlHXcGQhsyHOhIVW9CfAKTjw8zMkSaIPUYu7m+HYawOHBOx7UTh
         8t619nWd9ajsvxm3bN5XXpOLOzM7kH/IIMPbJw+vhX+sFd7+D8w1haFfjc8jn+roaHh/
         giz9DikKMW+/iWAdZ+paA2Ea6SsZTKwByLFks19RQs/SOS0lmqzlWZfw3HGzeFJi5rTp
         COMw5rv2Xn+6yr5qWRccCheMuwPo+B7XTKpa7Y6bcFrAr+aZ7sgMWk074yHYD47gQ5E/
         7WpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Hr+wzLJaJv9mNlYaiZKEYC36LQnuHRG9zrvQaabYIiY=;
        b=Xl+5OYKtX1qJHnV46yIfb1yQeV0ZW0mfOTiiRkh9217lfg/XC59RzvMQ8km0AbDbcl
         bsgCMlXnnNlx5Fc2oAgSf4J0kMwVFY3Hd10Qh468mHJsOgEH2Ys3OdlBFtKNA+nQVU5h
         z2C1VBvkRAOqtDbYffFGG5Yg0ASFg18unPTiNz24O/BjUzpGySm9PZfhQYv01F22c3IB
         qfc3QCTWL8IiwGW79iQP3dDBMmFIFhlB/agNyw/ydEu9WizAysYht6oRij9dYG3G0W8s
         JuO1k8QuzwkgRQqrvyFomv7SU9MaNZAzhZxmsbkDwC8eaAT+k7BFyrYe8q9pDPN+IgfM
         d+mg==
X-Gm-Message-State: AOAM532xnKePceoglpfosxUdABxLCBcwZ0fqOGY/GmeHuzmtD4G56Jit
        KSO8W2LihW5cnV8XAOEacYtWBrEG5S4=
X-Google-Smtp-Source: ABdhPJynUr4JU3K8qUJHaeqs+BuC8QZ4GD0ZI8/h0CN8Fd/cRhO422Eg0V0h5GERuXcl4MsyGg27AaxNVE0=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:4c6:4bbe:e4c5:ff76])
 (user=haoluo job=sendgmr) by 2002:a62:8f93:0:b0:49f:ed44:54ac with SMTP id
 n141-20020a628f93000000b0049fed4454acmr4217402pfd.72.1636424201127; Mon, 08
 Nov 2021 18:16:41 -0800 (PST)
Date:   Mon,  8 Nov 2021 18:16:20 -0800
In-Reply-To: <20211109021624.1140446-1-haoluo@google.com>
Message-Id: <20211109021624.1140446-6-haoluo@google.com>
Mime-Version: 1.0
References: <20211109021624.1140446-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [RFC PATCH bpf-next 5/9] bpf: Remove ARG_PTR_TO_CTX_OR_NULL
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

Remove ARG_PTR_TO_CTX_OR_NULL and use flag to mark that the argument
may be null.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 include/linux/bpf.h   |  1 -
 kernel/bpf/cgroup.c   |  5 ++++-
 kernel/bpf/verifier.c |  2 --
 net/core/filter.c     | 20 ++++++++++++++++----
 4 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 27f81989f992..27bf974ea6b5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -324,7 +324,6 @@ struct bpf_arg_type {
 
 		ARG_CONST_SIZE,		/* number of bytes accessed from memory */
 		ARG_PTR_TO_CTX,		/* pointer to context */
-		ARG_PTR_TO_CTX_OR_NULL,	/* pointer to context or NULL */
 		ARG_ANYTHING,		/* any (initialized) argument is ok */
 		ARG_PTR_TO_SPIN_LOCK,	/* pointer to bpf_spin_lock */
 		ARG_PTR_TO_SOCK_COMMON,	/* pointer to sock_common */
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index ce4de222605f..a0b431be46f8 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1888,7 +1888,10 @@ static const struct bpf_func_proto bpf_get_netns_cookie_sockopt_proto = {
 	.func		= bpf_get_netns_cookie_sockopt,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
-	.arg1		= { .type = ARG_PTR_TO_CTX_OR_NULL },
+	.arg1		= {
+		.type = ARG_PTR_TO_CTX,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 };
 #endif
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1a4830ad2be2..07b93bfd3518 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -481,7 +481,6 @@ static bool arg_type_may_be_refcounted(struct bpf_arg_type arg)
 static bool arg_type_may_be_null(struct bpf_arg_type arg)
 {
 	return arg.flag & ARG_FLAG_MAYBE_NULL ||
-	       arg.type == ARG_PTR_TO_CTX_OR_NULL ||
 	       arg.type == ARG_PTR_TO_SOCKET_OR_NULL ||
 	       arg.type == ARG_PTR_TO_ALLOC_MEM_OR_NULL ||
 	       arg.type == ARG_PTR_TO_STACK_OR_NULL;
@@ -5090,7 +5089,6 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 	[ARG_CONST_ALLOC_SIZE_OR_ZERO]	= &scalar_types,
 	[ARG_CONST_MAP_PTR]		= &const_map_ptr_types,
 	[ARG_PTR_TO_CTX]		= &context_types,
-	[ARG_PTR_TO_CTX_OR_NULL]	= &context_types,
 	[ARG_PTR_TO_SOCK_COMMON]	= &sock_types,
 #ifdef CONFIG_NET
 	[ARG_PTR_TO_BTF_ID_SOCK_COMMON]	= &btf_id_sock_common_types,
diff --git a/net/core/filter.c b/net/core/filter.c
index 5e0f726a9bcd..2575460c054f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4691,7 +4691,10 @@ static const struct bpf_func_proto bpf_get_netns_cookie_sock_proto = {
 	.func		= bpf_get_netns_cookie_sock,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
-	.arg1		= { .type = ARG_PTR_TO_CTX_OR_NULL },
+	.arg1		= {
+		.type = ARG_PTR_TO_CTX,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 };
 
 BPF_CALL_1(bpf_get_netns_cookie_sock_addr, struct bpf_sock_addr_kern *, ctx)
@@ -4703,7 +4706,10 @@ static const struct bpf_func_proto bpf_get_netns_cookie_sock_addr_proto = {
 	.func		= bpf_get_netns_cookie_sock_addr,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
-	.arg1		= { .type = ARG_PTR_TO_CTX_OR_NULL },
+	.arg1		= {
+		.type = ARG_PTR_TO_CTX,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 };
 
 BPF_CALL_1(bpf_get_netns_cookie_sock_ops, struct bpf_sock_ops_kern *, ctx)
@@ -4715,7 +4721,10 @@ static const struct bpf_func_proto bpf_get_netns_cookie_sock_ops_proto = {
 	.func		= bpf_get_netns_cookie_sock_ops,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
-	.arg1		= { .type = ARG_PTR_TO_CTX_OR_NULL },
+	.arg1		= {
+		.type = ARG_PTR_TO_CTX,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 };
 
 BPF_CALL_1(bpf_get_netns_cookie_sk_msg, struct sk_msg *, ctx)
@@ -4727,7 +4736,10 @@ static const struct bpf_func_proto bpf_get_netns_cookie_sk_msg_proto = {
 	.func		= bpf_get_netns_cookie_sk_msg,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
-	.arg1		= { .type = ARG_PTR_TO_CTX_OR_NULL },
+	.arg1		= {
+		.type = ARG_PTR_TO_CTX,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 };
 
 BPF_CALL_1(bpf_get_socket_uid, struct sk_buff *, skb)
-- 
2.34.0.rc0.344.g81b53c2807-goog


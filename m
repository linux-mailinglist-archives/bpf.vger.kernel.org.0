Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8471B44A483
	for <lists+bpf@lfdr.de>; Tue,  9 Nov 2021 03:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238877AbhKICT3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Nov 2021 21:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238894AbhKICT2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Nov 2021 21:19:28 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B233BC061570
        for <bpf@vger.kernel.org>; Mon,  8 Nov 2021 18:16:43 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id h35-20020a63f923000000b002d5262fdfc4so7405206pgi.2
        for <bpf@vger.kernel.org>; Mon, 08 Nov 2021 18:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bA52GRwUI+wYtAbCTfElgrva8CaHE3Bel6vGjs3Uixg=;
        b=MR2GsHswQ4r4QxDjn17VnwuU1YcQ614lpydSJ8/qpOUZ9Gb0Uw3UuNzpBwBgM4m1u4
         EocTapztjD4cWYL9ERjsEP5f3F3IR2+OP394YsSPgiSZXEEVYDChMga8alUqnWJCPZo9
         KkQ3BHiv78m7g6Z5uD9YOfGO4jI3PLo4swjVtQfPa8Uqu+yfzgAkGJIL6J44MvBt7j1w
         ZDmJkF6ZDiwD02C86ZuYM/tRl0JhiPNOBA8WN4U33HzDzBPMGCnWs5Q2QtDhQfftvBdN
         8X8fSxDFGAiMnW18DirTjqcU3MNSPIzE1G/3k42WNvYhG7QyStad937YQ5g1jOCt+rj4
         MGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bA52GRwUI+wYtAbCTfElgrva8CaHE3Bel6vGjs3Uixg=;
        b=xMwV8hBXHNFflN/hMu7/5g3X0D43EMOTzqqKhL5Pr7yUB/qWJ2DxBnNotmpC1Dwwsa
         l+7DRaq95psg6Z/n0U5ucP6y69Tng093BJQFzwQqiHzCwrj2ScqhEW4H9pPxmQT+EmLB
         laU6RDjt1TNPGD6kQpfG59n3CEfqPGzQVwsZwmq7+lIKDhe+MNmg0JYwLz8dSqbNgvdd
         cjZbmYqF3gqxpi7PozmwVWjEcIY+X1GG7tR4ddEbq+5FWfifXqFe9Jfos8P1MStuRYr5
         9rpQifvFGzCjkGfxBBnZIoSLgeOuakC8oSBs0Ik6I09U1NcWzZto+JxR29Kuj3tSttEY
         5QjA==
X-Gm-Message-State: AOAM531RvL4inxG8ULsmDaI9u+jDOiB0ejTkFs8+oJo0OkyVzXrLqfI4
        CTv9jUyz3jJdBltDVLVKU6XNVbK88no=
X-Google-Smtp-Source: ABdhPJxq1pybk0XVx6EWD5pru5rOF1pxj0qqhgv86hxogv+lK0Fa7z8v+84m+is4I8l34R9L79rizrloR7w=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:4c6:4bbe:e4c5:ff76])
 (user=haoluo job=sendgmr) by 2002:a63:6a05:: with SMTP id f5mr3202355pgc.97.1636424203193;
 Mon, 08 Nov 2021 18:16:43 -0800 (PST)
Date:   Mon,  8 Nov 2021 18:16:21 -0800
In-Reply-To: <20211109021624.1140446-1-haoluo@google.com>
Message-Id: <20211109021624.1140446-7-haoluo@google.com>
Mime-Version: 1.0
References: <20211109021624.1140446-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [RFC PATCH bpf-next 6/9] bpf: Remove ARG_PTR_TO_SOCKET_OR_NULL
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

Remove ARG_PTR_TO_SOCKET_OR_NULL and use flag to mark that the
argument may be null.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 include/linux/bpf.h   | 1 -
 kernel/bpf/verifier.c | 2 --
 net/core/filter.c     | 5 ++++-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 27bf974ea6b5..94eb776c925a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -330,7 +330,6 @@ struct bpf_arg_type {
 		ARG_PTR_TO_INT,		/* pointer to int */
 		ARG_PTR_TO_LONG,	/* pointer to long */
 		ARG_PTR_TO_SOCKET,	/* pointer to bpf_sock (fullsock) */
-		ARG_PTR_TO_SOCKET_OR_NULL,	/* pointer to bpf_sock (fullsock) or NULL */
 		ARG_PTR_TO_BTF_ID,	/* pointer to in-kernel struct */
 		ARG_PTR_TO_ALLOC_MEM,	/* pointer to dynamically allocated memory */
 		ARG_PTR_TO_ALLOC_MEM_OR_NULL,	/* pointer to dynamically allocated memory or NULL */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 07b93bfd3518..f89cf2a59c82 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -481,7 +481,6 @@ static bool arg_type_may_be_refcounted(struct bpf_arg_type arg)
 static bool arg_type_may_be_null(struct bpf_arg_type arg)
 {
 	return arg.flag & ARG_FLAG_MAYBE_NULL ||
-	       arg.type == ARG_PTR_TO_SOCKET_OR_NULL ||
 	       arg.type == ARG_PTR_TO_ALLOC_MEM_OR_NULL ||
 	       arg.type == ARG_PTR_TO_STACK_OR_NULL;
 }
@@ -5094,7 +5093,6 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 	[ARG_PTR_TO_BTF_ID_SOCK_COMMON]	= &btf_id_sock_common_types,
 #endif
 	[ARG_PTR_TO_SOCKET]		= &fullsock_types,
-	[ARG_PTR_TO_SOCKET_OR_NULL]	= &fullsock_types,
 	[ARG_PTR_TO_BTF_ID]		= &btf_ptr_types,
 	[ARG_PTR_TO_SPIN_LOCK]		= &spin_lock_types,
 	[ARG_PTR_TO_MEM]		= &mem_types,
diff --git a/net/core/filter.c b/net/core/filter.c
index 2575460c054f..3ad3595a191e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -10489,7 +10489,10 @@ static const struct bpf_func_proto bpf_sk_lookup_assign_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1		= { .type = ARG_PTR_TO_CTX },
-	.arg2		= { .type = ARG_PTR_TO_SOCKET_OR_NULL },
+	.arg2		= {
+		.type = ARG_PTR_TO_SOCKET,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 	.arg3		= { .type = ARG_ANYTHING },
 };
 
-- 
2.34.0.rc0.344.g81b53c2807-goog


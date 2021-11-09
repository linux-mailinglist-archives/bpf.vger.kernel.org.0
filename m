Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE0A44A480
	for <lists+bpf@lfdr.de>; Tue,  9 Nov 2021 03:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238856AbhKICTY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Nov 2021 21:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbhKICTW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Nov 2021 21:19:22 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F728C061570
        for <bpf@vger.kernel.org>; Mon,  8 Nov 2021 18:16:37 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id m5-20020a170902bb8500b0013a2b785187so7653461pls.11
        for <bpf@vger.kernel.org>; Mon, 08 Nov 2021 18:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tnpzuiBMM4gtcGLMa6Ad04JIjQCqqdttngTqZ/oQlBU=;
        b=Lr0sTc4BzgNHQoFDmUOpz6TSWbW7XeGpFoEJX8HVnfhDJKGUi+Dc6KRe68yZIyyfvf
         z0ThnVOa5mUwyt9XENlG63oE2pwgxMJMz5RQMLMBMtBvWuNgs6TwwxdPpo2zhwJAOSOe
         biEqpwKvJrMUgxLPMkj3gCgvF691Q6N9ERdCwAPs6ezP0b7SrD2wRyIQdxt2UkDs18nx
         l+GOq0Bc0rzUb6ONBuNeJZCDfcfMrxqFcjTzdFh6yOGmCAA0/hhD7rNJMuHIQcnqgVZT
         4sOLn4ZV1HfIDIDeSD+M1pv/qRFTgm5tBPaPa4GGAn0u1s1tBL+zaaCIdJy45y7oiQV3
         5pDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tnpzuiBMM4gtcGLMa6Ad04JIjQCqqdttngTqZ/oQlBU=;
        b=fiZJNyrPYaI8GM3RNPacMvbvCImzk5KByHmJMDrvmkTnnDf5wbTrNbXQ0zm5sdRJxh
         QTnIIaPnC0ecJ1EmHW7AlK/FJzOcRt7pzKkTJ7BRz8umBEDC6cGcMKllvmNJdPsLj1NS
         BPfHzeNC5nFawpznP7N+2tT8Abr0OgnOJVZ3CqgofoG8KwyqEYdjYcjq82UMJFoKgLbn
         J3y3Fdc+soZInb7Gs0Np0hdhc10djLJ5Mg708jLElmvtzuFwKyvIN1oJzyZvX/FZM8Ga
         uvNsOdtDGSiJnFaNdzFMftnmmsrzIja3ew7W8ElZljThvu7hWclDI8LmytlYmtsW+geu
         Hqrw==
X-Gm-Message-State: AOAM530NJeINs+EFvQCE7fUZHfHr6u13NpcUJUw6i1Yd00Odur3LG7/e
        MguVs2wLyUwdHQy+gmzCvaHbA3X+qY8=
X-Google-Smtp-Source: ABdhPJwEfzF0lhvGE0Jz+tQeWYY3K3nRvXJFUp82JRnFO7mLtKw3yHKPtjvycN4F4/Yg48VPi0jHkMkfRGU=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:4c6:4bbe:e4c5:ff76])
 (user=haoluo job=sendgmr) by 2002:a17:902:c404:b0:142:28c5:5416 with SMTP id
 k4-20020a170902c40400b0014228c55416mr4016439plk.62.1636424196965; Mon, 08 Nov
 2021 18:16:36 -0800 (PST)
Date:   Mon,  8 Nov 2021 18:16:18 -0800
In-Reply-To: <20211109021624.1140446-1-haoluo@google.com>
Message-Id: <20211109021624.1140446-4-haoluo@google.com>
Mime-Version: 1.0
References: <20211109021624.1140446-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [RFC PATCH bpf-next 3/9] bpf: Remove ARG_PTR_TO_MEM_OR_NULL
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

Remove ARG_PTR_TO_MEM_OR_NULL and use flag to mark that the
argument may be null.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 include/linux/bpf.h      |  1 -
 kernel/bpf/helpers.c     | 10 ++++++++--
 kernel/bpf/verifier.c    |  3 ---
 kernel/trace/bpf_trace.c | 15 ++++++++++++---
 net/core/filter.c        | 15 ++++++++++++---
 5 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d8de8f00e40d..dd92418814b5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -317,7 +317,6 @@ struct bpf_arg_type {
 		 * functions that access data on eBPF program stack
 		 */
 		ARG_PTR_TO_MEM,		/* pointer to valid memory (stack, packet, map value) */
-		ARG_PTR_TO_MEM_OR_NULL, /* pointer to valid memory or NULL */
 		ARG_PTR_TO_UNINIT_MEM,	/* pointer to memory does not need to be initialized,
 					 * helper function must fill all bytes or clear
 					 * them in error case.
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index d68c70f4b4b6..cd792777afb2 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1008,10 +1008,16 @@ const struct bpf_func_proto bpf_snprintf_proto = {
 	.func		= bpf_snprintf,
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
-	.arg1		= { .type = ARG_PTR_TO_MEM_OR_NULL },
+	.arg1		= {
+		.type = ARG_PTR_TO_MEM,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 	.arg2		= { .type = ARG_CONST_SIZE_OR_ZERO },
 	.arg3		= { .type = ARG_PTR_TO_CONST_STR },
-	.arg4		= { .type = ARG_PTR_TO_MEM_OR_NULL },
+	.arg4		= {
+		.type = ARG_PTR_TO_MEM,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 	.arg5		= { .type = ARG_CONST_SIZE_OR_ZERO },
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f55967f92d22..eb69b8bddee5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -481,7 +481,6 @@ static bool arg_type_may_be_refcounted(struct bpf_arg_type arg)
 static bool arg_type_may_be_null(struct bpf_arg_type arg)
 {
 	return arg.flag & ARG_FLAG_MAYBE_NULL ||
-	       arg.type == ARG_PTR_TO_MEM_OR_NULL ||
 	       arg.type == ARG_PTR_TO_CTX_OR_NULL ||
 	       arg.type == ARG_PTR_TO_SOCKET_OR_NULL ||
 	       arg.type == ARG_PTR_TO_ALLOC_MEM_OR_NULL ||
@@ -4951,7 +4950,6 @@ static int process_timer_func(struct bpf_verifier_env *env, int regno,
 static bool arg_type_is_mem_ptr(struct bpf_arg_type arg)
 {
 	return arg.type == ARG_PTR_TO_MEM ||
-	       arg.type == ARG_PTR_TO_MEM_OR_NULL ||
 	       arg.type == ARG_PTR_TO_UNINIT_MEM;
 }
 
@@ -5104,7 +5102,6 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 	[ARG_PTR_TO_BTF_ID]		= &btf_ptr_types,
 	[ARG_PTR_TO_SPIN_LOCK]		= &spin_lock_types,
 	[ARG_PTR_TO_MEM]		= &mem_types,
-	[ARG_PTR_TO_MEM_OR_NULL]	= &mem_types,
 	[ARG_PTR_TO_UNINIT_MEM]		= &mem_types,
 	[ARG_PTR_TO_ALLOC_MEM]		= &alloc_mem_types,
 	[ARG_PTR_TO_ALLOC_MEM_OR_NULL]	= &alloc_mem_types,
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 6e0b17637787..086889a29ca7 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -452,7 +452,10 @@ static const struct bpf_func_proto bpf_trace_vprintk_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1		= { .type = ARG_PTR_TO_MEM },
 	.arg2		= { .type = ARG_CONST_SIZE },
-	.arg3		= { .type = ARG_PTR_TO_MEM_OR_NULL },
+	.arg3		= {
+		.type = ARG_PTR_TO_MEM,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 	.arg4		= { .type = ARG_CONST_SIZE_OR_ZERO },
 };
 
@@ -494,7 +497,10 @@ static const struct bpf_func_proto bpf_seq_printf_proto = {
 	.arg1_btf_id	= &btf_seq_file_ids[0],
 	.arg2		= { .type = ARG_PTR_TO_MEM },
 	.arg3		= { .type = ARG_CONST_SIZE },
-	.arg4		= { .type = ARG_PTR_TO_MEM_OR_NULL },
+	.arg4		= {
+		.type = ARG_PTR_TO_MEM,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 	.arg5		= { .type = ARG_CONST_SIZE_OR_ZERO },
 };
 
@@ -1435,7 +1441,10 @@ static const struct bpf_func_proto bpf_read_branch_records_proto = {
 	.gpl_only       = true,
 	.ret_type       = RET_INTEGER,
 	.arg1	      = { .type = ARG_PTR_TO_CTX },
-	.arg2	      = { .type = ARG_PTR_TO_MEM_OR_NULL },
+	.arg2	      = {
+		.type = ARG_PTR_TO_MEM,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 	.arg3	      = { .type = ARG_CONST_SIZE_OR_ZERO },
 	.arg4	      = { .type = ARG_ANYTHING },
 };
diff --git a/net/core/filter.c b/net/core/filter.c
index 90fa7f67f3c2..81c6638ffc2a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2018,9 +2018,15 @@ static const struct bpf_func_proto bpf_csum_diff_proto = {
 	.gpl_only	= false,
 	.pkt_access	= true,
 	.ret_type	= RET_INTEGER,
-	.arg1		= { .type = ARG_PTR_TO_MEM_OR_NULL },
+	.arg1		= {
+		.type = ARG_PTR_TO_MEM,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 	.arg2		= { .type = ARG_CONST_SIZE_OR_ZERO },
-	.arg3		= { .type = ARG_PTR_TO_MEM_OR_NULL },
+	.arg3		= {
+		.type = ARG_PTR_TO_MEM,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 	.arg4		= { .type = ARG_CONST_SIZE_OR_ZERO },
 	.arg5		= { .type = ARG_ANYTHING },
 };
@@ -2541,7 +2547,10 @@ static const struct bpf_func_proto bpf_redirect_neigh_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1		= { .type = ARG_ANYTHING },
-	.arg2		= { .type = ARG_PTR_TO_MEM_OR_NULL },
+	.arg2		= {
+		.type = ARG_PTR_TO_MEM,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 	.arg3		= { .type = ARG_CONST_SIZE_OR_ZERO },
 	.arg4		= { .type = ARG_ANYTHING },
 };
-- 
2.34.0.rc0.344.g81b53c2807-goog


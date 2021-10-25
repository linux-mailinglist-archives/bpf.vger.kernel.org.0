Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9888143A804
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 01:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbhJYXP3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 19:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbhJYXP2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Oct 2021 19:15:28 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9283C061745
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 16:13:05 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id w196-20020a627bcd000000b0047c07de537aso867024pfc.6
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 16:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IyRfP/b4ge8j+g+G8W/A3ZJlY+yOBfcu89IbY5D9Syg=;
        b=kNYvIKCs7yfoOT7dBLJL7n4CNGPSGuy0zZpdsAqy5vs0j4buzMz2MtzFLIJXIkqDJa
         IuWwp/M1Y5g1C9eD67CfSQxizFaQGqFUOZaFigxasWzTHitPIGFwlqxBLV2KQymN33uh
         DmE44yjmZ79MrSntPZEybdriPkp2LWo233vKMM2IklvoJFu5QUWHzCjbJbbE7m6QTnug
         CuuT/ub27L5dZQxmOmdL6rrn/7NU2anB/hE+l5Oc3jv7yu9LIbkIH2M8x8sXf10n9Yiw
         m4NBahtk8nC6NCdL34gfcQvajn18L/omy8kNRR2aYfwKLIAnk9WYZxvQmVYKjiOns6jc
         arvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IyRfP/b4ge8j+g+G8W/A3ZJlY+yOBfcu89IbY5D9Syg=;
        b=LQ6t8ceveyPkq+daT5tJOEdKfJ3Xh6sRq/PhxEQseYVPOU4dLReQZ2zxIXbnyVtDE+
         JhyABCk2Q/xFAPFa+tQ5raSNjnDGVYfz4sLCouftfC54IMYZcJpUWP6TAynGWcXq0mqM
         t5JGTwBxPkHR64TFtoQoV1KbU5LuCxOr2mkKmntsd8m0mMtl+gHHs5Eu6O0aHmzWdv8V
         D5nt6F3FCrwS5KOOmRhAGbvLPqxhZWTf31aH52Ppy05V+h0LmdRElv6h9/XNSK3HypzM
         m/yC00ec48NrKjryu8CLOYn85CUSVsz6teBgSptJ73zC5xArpVV5altD30l2WaliYgLK
         wAig==
X-Gm-Message-State: AOAM531inmgUn3VKW9LjzbEZTY26PLez3dJK0vFwFipHj6Pa8cfnfC9M
        rFDfpMpIVERPuzQEH2tgZnRdt9SZ3V0=
X-Google-Smtp-Source: ABdhPJw6ZUyTrqJpLXcSR1z/FYmCc/5KGbkCmngzhcM+QCVWNuzH77/5tQwPWvR+qOSOfBal7YiWlV82fmI=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:b4ab:b78c:418f:ca5c])
 (user=haoluo job=sendgmr) by 2002:a17:90b:60d:: with SMTP id
 gb13mr200420pjb.0.1635203585127; Mon, 25 Oct 2021 16:13:05 -0700 (PDT)
Date:   Mon, 25 Oct 2021 16:12:55 -0700
In-Reply-To: <20211025231256.4030142-1-haoluo@google.com>
Message-Id: <20211025231256.4030142-3-haoluo@google.com>
Mime-Version: 1.0
References: <20211025231256.4030142-1-haoluo@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH bpf-next v2 2/3] bpf: Introduce ARG_PTR_TO_WRITABLE_MEM
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some helper functions may modify its arguments, for example,
bpf_d_path, bpf_get_stack etc. Previously, their argument types
were marked as ARG_PTR_TO_MEM, which is compatible with read-only
mem types, such as PTR_TO_RDONLY_BUF. Therefore it's legitimate
to modify a read-only memory by passing it into one of such helper
functions.

This patch introduces a new arg type ARG_PTR_TO_WRITABLE_MEM to
annotate the arguments that may be modified by the helpers. For
arguments that are of ARG_PTR_TO_MEM, it's ok to take any mem type,
while for ARG_PTR_TO_WRITABLE_MEM, readonly mem reg types are not
acceptable.

In short, when a helper may modify its input parameter, use
ARG_PTR_TO_WRITABLE_MEM instead of ARG_PTR_TO_MEM.

So far the difference between ARG_PTR_TO_MEM and ARG_PTR_TO_WRITABLE_MEM
is PTR_TO_RDONLY_BUF and PTR_TO_RDONLY_MEM. PTR_TO_RDONLY_BUF is
only used in bpf_iter prog as the type of key, which hasn't been
used in the affected helper functions. PTR_TO_RDONLY_MEM currently
has no consumers.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 Changes since v1:
  - new patch, introduced ARG_PTR_TO_WRITABLE_MEM to differentiate
    read-only and read-write mem arg types.

 include/linux/bpf.h      |  9 +++++++++
 kernel/bpf/cgroup.c      |  2 +-
 kernel/bpf/helpers.c     |  2 +-
 kernel/bpf/verifier.c    | 18 ++++++++++++++++++
 kernel/trace/bpf_trace.c |  6 +++---
 net/core/filter.c        |  6 +++---
 6 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7b47e8f344cb..586ce67d63a9 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -341,6 +341,15 @@ enum bpf_arg_type {
 	ARG_PTR_TO_STACK_OR_NULL,	/* pointer to stack or NULL */
 	ARG_PTR_TO_CONST_STR,	/* pointer to a null terminated read-only string */
 	ARG_PTR_TO_TIMER,	/* pointer to bpf_timer */
+	ARG_PTR_TO_WRITABLE_MEM,	/* pointer to valid memory. Compared to
+					 * ARG_PTR_TO_MEM, this arg_type is not
+					 * compatible with RDONLY memory. If the
+					 * argument may be updated by the helper,
+					 * use this type.
+					 */
+	ARG_PTR_TO_WRITABLE_MEM_OR_NULL,   /* pointer to memory or null, similar to
+					    * ARG_PTR_TO_WRITABLE_MEM.
+					    */
 	__BPF_ARG_TYPE_MAX,
 };
 
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 03145d45e3d5..683269b7cd92 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1666,7 +1666,7 @@ static const struct bpf_func_proto bpf_sysctl_get_name_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_WRITABLE_MEM,
 	.arg3_type	= ARG_CONST_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 };
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 14531757087f..db98385ee7af 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1008,7 +1008,7 @@ const struct bpf_func_proto bpf_snprintf_proto = {
 	.func		= bpf_snprintf,
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_PTR_TO_MEM_OR_NULL,
+	.arg1_type	= ARG_PTR_TO_WRITABLE_MEM_OR_NULL,
 	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg3_type	= ARG_PTR_TO_CONST_STR,
 	.arg4_type	= ARG_PTR_TO_MEM_OR_NULL,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ae3ff297240e..d8817c3d990e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -486,6 +486,7 @@ static bool arg_type_may_be_null(enum bpf_arg_type type)
 	       type == ARG_PTR_TO_CTX_OR_NULL ||
 	       type == ARG_PTR_TO_SOCKET_OR_NULL ||
 	       type == ARG_PTR_TO_ALLOC_MEM_OR_NULL ||
+	       type == ARG_PTR_TO_WRITABLE_MEM_OR_NULL ||
 	       type == ARG_PTR_TO_STACK_OR_NULL;
 }
 
@@ -4971,6 +4972,8 @@ static bool arg_type_is_mem_ptr(enum bpf_arg_type type)
 {
 	return type == ARG_PTR_TO_MEM ||
 	       type == ARG_PTR_TO_MEM_OR_NULL ||
+	       type == ARG_PTR_TO_WRITABLE_MEM ||
+	       type == ARG_PTR_TO_WRITABLE_MEM_OR_NULL ||
 	       type == ARG_PTR_TO_UNINIT_MEM;
 }
 
@@ -5075,6 +5078,19 @@ static const struct bpf_reg_types mem_types = {
 		PTR_TO_MEM,
 		PTR_TO_RDONLY_BUF,
 		PTR_TO_RDWR_BUF,
+		PTR_TO_RDONLY_MEM,
+	},
+};
+
+static const struct bpf_reg_types writable_mem_types = {
+	.types = {
+		PTR_TO_STACK,
+		PTR_TO_PACKET,
+		PTR_TO_PACKET_META,
+		PTR_TO_MAP_KEY,
+		PTR_TO_MAP_VALUE,
+		PTR_TO_MEM,
+		PTR_TO_RDWR_BUF,
 	},
 };
 
@@ -5125,6 +5141,8 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 	[ARG_PTR_TO_UNINIT_MEM]		= &mem_types,
 	[ARG_PTR_TO_ALLOC_MEM]		= &alloc_mem_types,
 	[ARG_PTR_TO_ALLOC_MEM_OR_NULL]	= &alloc_mem_types,
+	[ARG_PTR_TO_WRITABLE_MEM]	= &writable_mem_types,
+	[ARG_PTR_TO_WRITABLE_MEM_OR_NULL] = &writable_mem_types,
 	[ARG_PTR_TO_INT]		= &int_ptr_types,
 	[ARG_PTR_TO_LONG]		= &int_ptr_types,
 	[ARG_PTR_TO_PERCPU_BTF_ID]	= &percpu_btf_ptr_types,
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index cbcd0d6fca7c..5815845222de 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -945,7 +945,7 @@ static const struct bpf_func_proto bpf_d_path_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
 	.arg1_btf_id	= &bpf_d_path_btf_ids[0],
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_WRITABLE_MEM,
 	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
 	.allowed	= bpf_d_path_allowed,
 };
@@ -1002,7 +1002,7 @@ const struct bpf_func_proto bpf_snprintf_btf_proto = {
 	.func		= bpf_snprintf_btf,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_PTR_TO_MEM,
+	.arg1_type	= ARG_PTR_TO_WRITABLE_MEM,
 	.arg2_type	= ARG_CONST_SIZE,
 	.arg3_type	= ARG_PTR_TO_MEM,
 	.arg4_type	= ARG_CONST_SIZE,
@@ -1433,7 +1433,7 @@ static const struct bpf_func_proto bpf_read_branch_records_proto = {
 	.gpl_only       = true,
 	.ret_type       = RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_CTX,
-	.arg2_type      = ARG_PTR_TO_MEM_OR_NULL,
+	.arg2_type      = ARG_PTR_TO_WRITABLE_MEM_OR_NULL,
 	.arg3_type      = ARG_CONST_SIZE_OR_ZERO,
 	.arg4_type      = ARG_ANYTHING,
 };
diff --git a/net/core/filter.c b/net/core/filter.c
index 8e8d3b49c297..7dadabe12ceb 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5639,7 +5639,7 @@ static const struct bpf_func_proto bpf_xdp_fib_lookup_proto = {
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_CTX,
-	.arg2_type      = ARG_PTR_TO_MEM,
+	.arg2_type      = ARG_PTR_TO_WRITABLE_MEM,
 	.arg3_type      = ARG_CONST_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 };
@@ -5694,7 +5694,7 @@ static const struct bpf_func_proto bpf_skb_fib_lookup_proto = {
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_CTX,
-	.arg2_type      = ARG_PTR_TO_MEM,
+	.arg2_type      = ARG_PTR_TO_WRITABLE_MEM,
 	.arg3_type      = ARG_CONST_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 };
@@ -6977,7 +6977,7 @@ static const struct bpf_func_proto bpf_sock_ops_load_hdr_opt_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_WRITABLE_MEM,
 	.arg3_type	= ARG_CONST_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 };
-- 
2.33.0.1079.g6e70778dc9-goog


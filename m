Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD64449F8F
	for <lists+bpf@lfdr.de>; Tue,  9 Nov 2021 01:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241224AbhKIAeA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Nov 2021 19:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbhKIAeA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Nov 2021 19:34:00 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C344C061570
        for <bpf@vger.kernel.org>; Mon,  8 Nov 2021 16:31:15 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 76-20020a63054f000000b002c9284978aaso11024207pgf.10
        for <bpf@vger.kernel.org>; Mon, 08 Nov 2021 16:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jPEAqm5a5YbAbVoPbTEgyp45CYtDhxOF+BIWYl2q+hI=;
        b=emf5FhVY0gQQ5QvsIKxwjCei4QFd1qcdHYWgUak1A64SVlgpI2NqIb7P2Xf1N+nsFQ
         fhLV0/POCduRlDBZNCXN9012odTie6GmGsaSUqZH/sZWtc2P5t1WSBbEoGqeaqMg2+MZ
         Jf5VsD8pe3iYM35kYRRQ1YGPNvjx2uPIcSXK5FOqczHgvDkc9HRGkiXCnGpYKwsp7Krj
         drbaig5+EqUJISjca73FT14zdvOZdbP9WTxpE1qC6nmyeOUSK0l7B5jRzQeaTeuTZUbA
         KY3BKAPi3uwIksvIV9FIwQUF/Ek1yi1xltGlxG9f9I+lV0L5zNErvI14XB+QeUVkgkZ5
         Er6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jPEAqm5a5YbAbVoPbTEgyp45CYtDhxOF+BIWYl2q+hI=;
        b=2wIKN6fX/KCj1NNi+S52JzY2shHjIzj7kKgSv8TdXc07Vno4BqEnnjIAXcc8dUaVkr
         5PLx2mENu4sK4LEUivGxYpQo0eGK3ZjhPkD07EQmsxWORtccdIy0bxZF6LTdwfFP7HOu
         0tSxcXlmWbAcbDcxgIp65onkmDhr6R1teGp7s3wj4UFwsWnXvvQXxfOg+R6/5ef8D2y2
         xdk91eFcr2MYLXIo0+trLbo7CsOFoe61qs4BWf+WskDH33w1t9qcka4DCeCmiI6+boNv
         RaGhE+K+IllP+NJcXy2fsyDi+jJOaXoD3omWsMYEh4f8eviyqH+R+bbvCDnPCtt/5drL
         aCPw==
X-Gm-Message-State: AOAM533+OYP6FYB3B/YLKprWlTl34+KunbLvT/3/JGyC0MiWiVcw+yLe
        Vn3SBwHVZpF0ZMq1RXDubrVgff2/o0Y=
X-Google-Smtp-Source: ABdhPJyRi6qw09U/4We0DBqfaxXOAjCz1zPMvRuRU/Bi39cr0QbyEa8gcYDctiDHo7+TbWVk9yTWkiVxCCg=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:4c6:4bbe:e4c5:ff76])
 (user=haoluo job=sendgmr) by 2002:a17:902:e84e:b0:141:e3f2:36c5 with SMTP id
 t14-20020a170902e84e00b00141e3f236c5mr3430674plg.74.1636417874672; Mon, 08
 Nov 2021 16:31:14 -0800 (PST)
Date:   Mon,  8 Nov 2021 16:30:51 -0800
In-Reply-To: <20211109003052.3499225-1-haoluo@google.com>
Message-Id: <20211109003052.3499225-3-haoluo@google.com>
Mime-Version: 1.0
References: <20211109003052.3499225-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v3 bpf-next 2/3] bpf: Introduce ARG_CONST_PTR_TO_MEM
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

This patch excludes those read-only memory from ARG_PTR_TO_MEM and
introduces a new arg type ARG_CONST_PTR_TO_MEM. Argument types that
are marked as ARG_CONST_PTR_TO_MEM gives promise that the helper
function does not modify that argument, therefore it's compatible
with both read-only and writable memories.

The helper functions that previously modify their arguments will
continue using ARG_PTR_TO_MEM, but limited to modifible memories.
Helper functions that do not modify their arguments are replaced
to use ARG_CONST_PTR_TO_MEM.

So far the difference between ARG_PTR_TO_MEM and ARG_CONST_PTR_TO_MEM
is PTR_TO_RDONLY_BUF and PTR_TO_RDONLY_MEM. PTR_TO_RDONLY_BUF is
only used in bpf_iter prog as the type of key, which hasn't been
used in the affected helper functions. PTR_TO_RDONLY_MEM has
currently no consumers.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 Changes since v2:
  - Introduce ARG_CONST_PTR_TO_MEM and limit the previous
    ARG_PTR_TO_MEM to writable memory.

 Changes since v1:
  - new patch, introduced ARG_PTR_TO_WRITABLE_MEM to differentiate
    read-only and read-write mem arg types.

 include/linux/bpf.h      | 14 ++++++++-
 kernel/bpf/btf.c         |  2 +-
 kernel/bpf/cgroup.c      |  2 +-
 kernel/bpf/helpers.c     |  8 ++---
 kernel/bpf/ringbuf.c     |  2 +-
 kernel/bpf/syscall.c     |  2 +-
 kernel/bpf/verifier.c    | 24 +++++++++++++--
 kernel/trace/bpf_trace.c | 26 ++++++++--------
 net/core/filter.c        | 64 ++++++++++++++++++++--------------------
 9 files changed, 87 insertions(+), 57 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 64494d5964fa..3486debc0753 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -313,7 +313,13 @@ enum bpf_arg_type {
 	/* the following constraints used to prototype bpf_memcmp() and other
 	 * functions that access data on eBPF program stack
 	 */
-	ARG_PTR_TO_MEM,		/* pointer to valid memory (stack, packet, map value) */
+	ARG_PTR_TO_MEM,		/* pointer to valid memory (stack, packet, map value).
+				 * This arg_type isn't compatible with read-only
+				 * memory. It marks that the helper may modify
+				 * the memory this arg points to. If the helper doesn't
+				 * modify its memory and expects to take a read-only
+				 * memory, use ARG_CONST_PTR_TO_MEM instead.
+				 */
 	ARG_PTR_TO_MEM_OR_NULL, /* pointer to valid memory or NULL */
 	ARG_PTR_TO_UNINIT_MEM,	/* pointer to memory does not need to be initialized,
 				 * helper function must fill all bytes or clear
@@ -342,6 +348,12 @@ enum bpf_arg_type {
 	ARG_PTR_TO_STACK_OR_NULL,	/* pointer to stack or NULL */
 	ARG_PTR_TO_CONST_STR,	/* pointer to a null terminated read-only string */
 	ARG_PTR_TO_TIMER,	/* pointer to bpf_timer */
+	ARG_CONST_PTR_TO_MEM,	/* pointer to valid memory. CONST means the helper won't
+				 * write into the memory.
+				 */
+	ARG_CONST_PTR_TO_MEM_OR_NULL,   /* pointer to memory or null, similar to
+					 * ARG_CONST_PTR_TO_MEM.
+					 */
 	__BPF_ARG_TYPE_MAX,
 };
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index cdb0fba65600..2c3add7eeced 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6336,7 +6336,7 @@ const struct bpf_func_proto bpf_btf_find_by_name_kind_proto = {
 	.func		= bpf_btf_find_by_name_kind,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_PTR_TO_MEM,
+	.arg1_type	= ARG_CONST_PTR_TO_MEM,
 	.arg2_type	= ARG_CONST_SIZE,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_ANYTHING,
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 03145d45e3d5..7c4e81120901 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1753,7 +1753,7 @@ static const struct bpf_func_proto bpf_sysctl_set_new_value_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_CONST_PTR_TO_MEM,
 	.arg3_type	= ARG_CONST_SIZE,
 };
 
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 14531757087f..fae555b3c2a3 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -530,7 +530,7 @@ const struct bpf_func_proto bpf_strtol_proto = {
 	.func		= bpf_strtol,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_PTR_TO_MEM,
+	.arg1_type	= ARG_CONST_PTR_TO_MEM,
 	.arg2_type	= ARG_CONST_SIZE,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_PTR_TO_LONG,
@@ -558,7 +558,7 @@ const struct bpf_func_proto bpf_strtoul_proto = {
 	.func		= bpf_strtoul,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_PTR_TO_MEM,
+	.arg1_type	= ARG_CONST_PTR_TO_MEM,
 	.arg2_type	= ARG_CONST_SIZE,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_PTR_TO_LONG,
@@ -630,7 +630,7 @@ const struct bpf_func_proto bpf_event_output_data_proto =  {
 	.arg1_type      = ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_CONST_MAP_PTR,
 	.arg3_type      = ARG_ANYTHING,
-	.arg4_type      = ARG_PTR_TO_MEM,
+	.arg4_type      = ARG_CONST_PTR_TO_MEM,
 	.arg5_type      = ARG_CONST_SIZE_OR_ZERO,
 };
 
@@ -1011,7 +1011,7 @@ const struct bpf_func_proto bpf_snprintf_proto = {
 	.arg1_type	= ARG_PTR_TO_MEM_OR_NULL,
 	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg3_type	= ARG_PTR_TO_CONST_STR,
-	.arg4_type	= ARG_PTR_TO_MEM_OR_NULL,
+	.arg4_type	= ARG_CONST_PTR_TO_MEM_OR_NULL,
 	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 9e0c10c6892a..b515ce10e5ed 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -444,7 +444,7 @@ const struct bpf_func_proto bpf_ringbuf_output_proto = {
 	.func		= bpf_ringbuf_output,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_CONST_MAP_PTR,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_CONST_PTR_TO_MEM,
 	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 };
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 50f96ea4452a..379f17719c3b 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4757,7 +4757,7 @@ static const struct bpf_func_proto bpf_sys_bpf_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_ANYTHING,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_CONST_PTR_TO_MEM,
 	.arg3_type	= ARG_CONST_SIZE,
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index eb3ae4a140ac..d219dac006f2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -486,7 +486,8 @@ static bool arg_type_may_be_null(enum bpf_arg_type type)
 	       type == ARG_PTR_TO_CTX_OR_NULL ||
 	       type == ARG_PTR_TO_SOCKET_OR_NULL ||
 	       type == ARG_PTR_TO_ALLOC_MEM_OR_NULL ||
-	       type == ARG_PTR_TO_STACK_OR_NULL;
+	       type == ARG_PTR_TO_STACK_OR_NULL ||
+	       type == ARG_CONST_PTR_TO_MEM_OR_NULL;
 }
 
 /* Determine whether the function releases some resources allocated by another
@@ -4971,6 +4972,8 @@ static bool arg_type_is_mem_ptr(enum bpf_arg_type type)
 {
 	return type == ARG_PTR_TO_MEM ||
 	       type == ARG_PTR_TO_MEM_OR_NULL ||
+	       type == ARG_CONST_PTR_TO_MEM ||
+	       type == ARG_CONST_PTR_TO_MEM_OR_NULL ||
 	       type == ARG_PTR_TO_UNINIT_MEM;
 }
 
@@ -5078,6 +5081,19 @@ static const struct bpf_reg_types mem_types = {
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
 
@@ -5123,11 +5139,13 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 	[ARG_PTR_TO_SOCKET_OR_NULL]	= &fullsock_types,
 	[ARG_PTR_TO_BTF_ID]		= &btf_ptr_types,
 	[ARG_PTR_TO_SPIN_LOCK]		= &spin_lock_types,
-	[ARG_PTR_TO_MEM]		= &mem_types,
-	[ARG_PTR_TO_MEM_OR_NULL]	= &mem_types,
+	[ARG_PTR_TO_MEM]		= &writable_mem_types,
+	[ARG_PTR_TO_MEM_OR_NULL]	= &writable_mem_types,
 	[ARG_PTR_TO_UNINIT_MEM]		= &mem_types,
 	[ARG_PTR_TO_ALLOC_MEM]		= &alloc_mem_types,
 	[ARG_PTR_TO_ALLOC_MEM_OR_NULL]	= &alloc_mem_types,
+	[ARG_CONST_PTR_TO_MEM]		= &mem_types,
+	[ARG_CONST_PTR_TO_MEM_OR_NULL]	= &mem_types,
 	[ARG_PTR_TO_INT]		= &int_ptr_types,
 	[ARG_PTR_TO_LONG]		= &int_ptr_types,
 	[ARG_PTR_TO_PERCPU_BTF_ID]	= &percpu_btf_ptr_types,
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 390176a3031a..f585c61c4418 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -345,7 +345,7 @@ static const struct bpf_func_proto bpf_probe_write_user_proto = {
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_ANYTHING,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_CONST_PTR_TO_MEM,
 	.arg3_type	= ARG_CONST_SIZE,
 };
 
@@ -394,7 +394,7 @@ static const struct bpf_func_proto bpf_trace_printk_proto = {
 	.func		= bpf_trace_printk,
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_PTR_TO_MEM,
+	.arg1_type	= ARG_CONST_PTR_TO_MEM,
 	.arg2_type	= ARG_CONST_SIZE,
 };
 
@@ -450,9 +450,9 @@ static const struct bpf_func_proto bpf_trace_vprintk_proto = {
 	.func		= bpf_trace_vprintk,
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_PTR_TO_MEM,
+	.arg1_type	= ARG_CONST_PTR_TO_MEM,
 	.arg2_type	= ARG_CONST_SIZE,
-	.arg3_type	= ARG_PTR_TO_MEM_OR_NULL,
+	.arg3_type	= ARG_CONST_PTR_TO_MEM_OR_NULL,
 	.arg4_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
@@ -492,9 +492,9 @@ static const struct bpf_func_proto bpf_seq_printf_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
 	.arg1_btf_id	= &btf_seq_file_ids[0],
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_CONST_PTR_TO_MEM,
 	.arg3_type	= ARG_CONST_SIZE,
-	.arg4_type      = ARG_PTR_TO_MEM_OR_NULL,
+	.arg4_type      = ARG_CONST_PTR_TO_MEM_OR_NULL,
 	.arg5_type      = ARG_CONST_SIZE_OR_ZERO,
 };
 
@@ -509,7 +509,7 @@ static const struct bpf_func_proto bpf_seq_write_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
 	.arg1_btf_id	= &btf_seq_file_ids[0],
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_CONST_PTR_TO_MEM,
 	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
@@ -533,7 +533,7 @@ static const struct bpf_func_proto bpf_seq_printf_btf_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
 	.arg1_btf_id	= &btf_seq_file_ids[0],
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_CONST_PTR_TO_MEM,
 	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 };
@@ -694,7 +694,7 @@ static const struct bpf_func_proto bpf_perf_event_output_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_CONST_MAP_PTR,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_MEM,
+	.arg4_type	= ARG_CONST_PTR_TO_MEM,
 	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
@@ -1004,7 +1004,7 @@ const struct bpf_func_proto bpf_snprintf_btf_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_MEM,
 	.arg2_type	= ARG_CONST_SIZE,
-	.arg3_type	= ARG_PTR_TO_MEM,
+	.arg3_type	= ARG_CONST_PTR_TO_MEM,
 	.arg4_type	= ARG_CONST_SIZE,
 	.arg5_type	= ARG_ANYTHING,
 };
@@ -1289,7 +1289,7 @@ static const struct bpf_func_proto bpf_perf_event_output_proto_tp = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_CONST_MAP_PTR,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_MEM,
+	.arg4_type	= ARG_CONST_PTR_TO_MEM,
 	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
@@ -1515,7 +1515,7 @@ static const struct bpf_func_proto bpf_perf_event_output_proto_raw_tp = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_CONST_MAP_PTR,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_MEM,
+	.arg4_type	= ARG_CONST_PTR_TO_MEM,
 	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
@@ -1569,7 +1569,7 @@ static const struct bpf_func_proto bpf_get_stack_proto_raw_tp = {
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_CONST_PTR_TO_MEM,
 	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 };
diff --git a/net/core/filter.c b/net/core/filter.c
index 8e8d3b49c297..24177fbcd028 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1713,7 +1713,7 @@ static const struct bpf_func_proto bpf_skb_store_bytes_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_PTR_TO_MEM,
+	.arg3_type	= ARG_CONST_PTR_TO_MEM,
 	.arg4_type	= ARG_CONST_SIZE,
 	.arg5_type	= ARG_ANYTHING,
 };
@@ -2018,9 +2018,9 @@ static const struct bpf_func_proto bpf_csum_diff_proto = {
 	.gpl_only	= false,
 	.pkt_access	= true,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_PTR_TO_MEM_OR_NULL,
+	.arg1_type	= ARG_CONST_PTR_TO_MEM_OR_NULL,
 	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
-	.arg3_type	= ARG_PTR_TO_MEM_OR_NULL,
+	.arg3_type	= ARG_CONST_PTR_TO_MEM_OR_NULL,
 	.arg4_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg5_type	= ARG_ANYTHING,
 };
@@ -2541,7 +2541,7 @@ static const struct bpf_func_proto bpf_redirect_neigh_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_ANYTHING,
-	.arg2_type      = ARG_PTR_TO_MEM_OR_NULL,
+	.arg2_type      = ARG_CONST_PTR_TO_MEM_OR_NULL,
 	.arg3_type      = ARG_CONST_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 };
@@ -4174,7 +4174,7 @@ static const struct bpf_func_proto bpf_skb_event_output_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_CONST_MAP_PTR,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_MEM,
+	.arg4_type	= ARG_CONST_PTR_TO_MEM,
 	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
@@ -4188,7 +4188,7 @@ const struct bpf_func_proto bpf_skb_output_proto = {
 	.arg1_btf_id	= &bpf_skb_output_btf_ids[0],
 	.arg2_type	= ARG_CONST_MAP_PTR,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_MEM,
+	.arg4_type	= ARG_CONST_PTR_TO_MEM,
 	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
@@ -4371,7 +4371,7 @@ static const struct bpf_func_proto bpf_skb_set_tunnel_key_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_CONST_PTR_TO_MEM,
 	.arg3_type	= ARG_CONST_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 };
@@ -4397,7 +4397,7 @@ static const struct bpf_func_proto bpf_skb_set_tunnel_opt_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_CONST_PTR_TO_MEM,
 	.arg3_type	= ARG_CONST_SIZE,
 };
 
@@ -4567,7 +4567,7 @@ static const struct bpf_func_proto bpf_xdp_event_output_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_CONST_MAP_PTR,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_MEM,
+	.arg4_type	= ARG_CONST_PTR_TO_MEM,
 	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
@@ -4581,7 +4581,7 @@ const struct bpf_func_proto bpf_xdp_output_proto = {
 	.arg1_btf_id	= &bpf_xdp_output_btf_ids[0],
 	.arg2_type	= ARG_CONST_MAP_PTR,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_MEM,
+	.arg4_type	= ARG_CONST_PTR_TO_MEM,
 	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
@@ -5067,7 +5067,7 @@ const struct bpf_func_proto bpf_sk_setsockopt_proto = {
 	.arg1_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON,
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_MEM,
+	.arg4_type	= ARG_CONST_PTR_TO_MEM,
 	.arg5_type	= ARG_CONST_SIZE,
 };
 
@@ -5101,7 +5101,7 @@ static const struct bpf_func_proto bpf_sock_addr_setsockopt_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_MEM,
+	.arg4_type	= ARG_CONST_PTR_TO_MEM,
 	.arg5_type	= ARG_CONST_SIZE,
 };
 
@@ -5135,7 +5135,7 @@ static const struct bpf_func_proto bpf_sock_ops_setsockopt_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_MEM,
+	.arg4_type	= ARG_CONST_PTR_TO_MEM,
 	.arg5_type	= ARG_CONST_SIZE,
 };
 
@@ -5310,7 +5310,7 @@ static const struct bpf_func_proto bpf_bind_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_CONST_PTR_TO_MEM,
 	.arg3_type	= ARG_CONST_SIZE,
 };
 
@@ -5898,7 +5898,7 @@ static const struct bpf_func_proto bpf_lwt_in_push_encap_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_PTR_TO_MEM,
+	.arg3_type	= ARG_CONST_PTR_TO_MEM,
 	.arg4_type	= ARG_CONST_SIZE
 };
 
@@ -5908,7 +5908,7 @@ static const struct bpf_func_proto bpf_lwt_xmit_push_encap_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_PTR_TO_MEM,
+	.arg3_type	= ARG_CONST_PTR_TO_MEM,
 	.arg4_type	= ARG_CONST_SIZE
 };
 
@@ -5951,7 +5951,7 @@ static const struct bpf_func_proto bpf_lwt_seg6_store_bytes_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_PTR_TO_MEM,
+	.arg3_type	= ARG_CONST_PTR_TO_MEM,
 	.arg4_type	= ARG_CONST_SIZE
 };
 
@@ -6039,7 +6039,7 @@ static const struct bpf_func_proto bpf_lwt_seg6_action_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_PTR_TO_MEM,
+	.arg3_type	= ARG_CONST_PTR_TO_MEM,
 	.arg4_type	= ARG_CONST_SIZE
 };
 
@@ -6264,7 +6264,7 @@ static const struct bpf_func_proto bpf_skc_lookup_tcp_proto = {
 	.pkt_access	= true,
 	.ret_type	= RET_PTR_TO_SOCK_COMMON_OR_NULL,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_CONST_PTR_TO_MEM,
 	.arg3_type	= ARG_CONST_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
@@ -6283,7 +6283,7 @@ static const struct bpf_func_proto bpf_sk_lookup_tcp_proto = {
 	.pkt_access	= true,
 	.ret_type	= RET_PTR_TO_SOCKET_OR_NULL,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_CONST_PTR_TO_MEM,
 	.arg3_type	= ARG_CONST_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
@@ -6302,7 +6302,7 @@ static const struct bpf_func_proto bpf_sk_lookup_udp_proto = {
 	.pkt_access	= true,
 	.ret_type	= RET_PTR_TO_SOCKET_OR_NULL,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_CONST_PTR_TO_MEM,
 	.arg3_type	= ARG_CONST_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
@@ -6339,7 +6339,7 @@ static const struct bpf_func_proto bpf_xdp_sk_lookup_udp_proto = {
 	.pkt_access     = true,
 	.ret_type       = RET_PTR_TO_SOCKET_OR_NULL,
 	.arg1_type      = ARG_PTR_TO_CTX,
-	.arg2_type      = ARG_PTR_TO_MEM,
+	.arg2_type      = ARG_CONST_PTR_TO_MEM,
 	.arg3_type      = ARG_CONST_SIZE,
 	.arg4_type      = ARG_ANYTHING,
 	.arg5_type      = ARG_ANYTHING,
@@ -6362,7 +6362,7 @@ static const struct bpf_func_proto bpf_xdp_skc_lookup_tcp_proto = {
 	.pkt_access     = true,
 	.ret_type       = RET_PTR_TO_SOCK_COMMON_OR_NULL,
 	.arg1_type      = ARG_PTR_TO_CTX,
-	.arg2_type      = ARG_PTR_TO_MEM,
+	.arg2_type      = ARG_CONST_PTR_TO_MEM,
 	.arg3_type      = ARG_CONST_SIZE,
 	.arg4_type      = ARG_ANYTHING,
 	.arg5_type      = ARG_ANYTHING,
@@ -6385,7 +6385,7 @@ static const struct bpf_func_proto bpf_xdp_sk_lookup_tcp_proto = {
 	.pkt_access     = true,
 	.ret_type       = RET_PTR_TO_SOCKET_OR_NULL,
 	.arg1_type      = ARG_PTR_TO_CTX,
-	.arg2_type      = ARG_PTR_TO_MEM,
+	.arg2_type      = ARG_CONST_PTR_TO_MEM,
 	.arg3_type      = ARG_CONST_SIZE,
 	.arg4_type      = ARG_ANYTHING,
 	.arg5_type      = ARG_ANYTHING,
@@ -6404,7 +6404,7 @@ static const struct bpf_func_proto bpf_sock_addr_skc_lookup_tcp_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_PTR_TO_SOCK_COMMON_OR_NULL,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_CONST_PTR_TO_MEM,
 	.arg3_type	= ARG_CONST_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
@@ -6423,7 +6423,7 @@ static const struct bpf_func_proto bpf_sock_addr_sk_lookup_tcp_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_PTR_TO_SOCKET_OR_NULL,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_CONST_PTR_TO_MEM,
 	.arg3_type	= ARG_CONST_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
@@ -6442,7 +6442,7 @@ static const struct bpf_func_proto bpf_sock_addr_sk_lookup_udp_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_PTR_TO_SOCKET_OR_NULL,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_CONST_PTR_TO_MEM,
 	.arg3_type	= ARG_CONST_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
@@ -6755,9 +6755,9 @@ static const struct bpf_func_proto bpf_tcp_check_syncookie_proto = {
 	.pkt_access	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_CONST_PTR_TO_MEM,
 	.arg3_type	= ARG_CONST_SIZE,
-	.arg4_type	= ARG_PTR_TO_MEM,
+	.arg4_type	= ARG_CONST_PTR_TO_MEM,
 	.arg5_type	= ARG_CONST_SIZE,
 };
 
@@ -6824,9 +6824,9 @@ static const struct bpf_func_proto bpf_tcp_gen_syncookie_proto = {
 	.pkt_access	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_CONST_PTR_TO_MEM,
 	.arg3_type	= ARG_CONST_SIZE,
-	.arg4_type	= ARG_PTR_TO_MEM,
+	.arg4_type	= ARG_CONST_PTR_TO_MEM,
 	.arg5_type	= ARG_CONST_SIZE,
 };
 
@@ -7055,7 +7055,7 @@ static const struct bpf_func_proto bpf_sock_ops_store_hdr_opt_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_CONST_PTR_TO_MEM,
 	.arg3_type	= ARG_CONST_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 };
-- 
2.34.0.rc0.344.g81b53c2807-goog


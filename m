Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9976844A481
	for <lists+bpf@lfdr.de>; Tue,  9 Nov 2021 03:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbhKICTY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Nov 2021 21:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhKICTY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Nov 2021 21:19:24 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7E6C061570
        for <bpf@vger.kernel.org>; Mon,  8 Nov 2021 18:16:39 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id x9-20020a056a00188900b0049fd22b9a27so3048954pfh.18
        for <bpf@vger.kernel.org>; Mon, 08 Nov 2021 18:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XmP2B7rbxa18um0t1mESk3xyMBid0PlfcDFl48NO3Hs=;
        b=G4jT392X2evxt6bwGFo9jMcHOafmFhfvPtmRoHlkGqplw8RsvHVN1Z5QhhyY2rq5nH
         plPezqSui/j4XptkcxLzW3gNuJXgvRSxoJ+lxze7GkFg44HXa3nb8TGmNEil4UvrXrE3
         vcW2K/dvLu9U+CgcIUYcO2lOrZCEuvN3uMszJ50ejGQwKkSjBkEBFZ1X4mi0xQk4C+xw
         G9xFApURHQDznntbDMMT9O9/+TKNyuDTypaDIWPiLiq66rgVFtjc+p02Kh06JWPuEaof
         vc+upqx+pfLhT5UcOaBT5Mb71GpnX/WyDI2Oe6XOoSrKxp5NNxdRYqlhRtnNw373fvxk
         t6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XmP2B7rbxa18um0t1mESk3xyMBid0PlfcDFl48NO3Hs=;
        b=lMaWm7MZ81l2aj9xKzX7chQceext4qzdgRr8PFVYY622AYToAAEAsxhlpzFno+Uz/k
         G415SncopKWxrIKKZavmoHMndy19ESixJaocArA5vhAAMs3yAEx7WM+NYHhpHEmXF4Jp
         AnBZo1VyRjgTdDiIFbsrWNJftRcEQez8/f+EgAUWDOZm0ZkJDDC4TWpqlIy0A+OpCY1t
         PmyD46jWKuekebQtzPXdRSKjets2IgKtVRhYZc0bKoEQeZjEDcigXD+Z8d0HzFsYekXg
         jnBkH4T0unYhQWcK3863f1x50Pf+advxP4HOZfaR66JcPt7ZpWjkXmWhqruOkoYwdcXk
         lK9Q==
X-Gm-Message-State: AOAM531u396ojz1CAU9vdaFaG7GJlqS7zwDzXVfJqB0RyrOMpSyit2Lo
        bTSMDLdau5zLcMAe66Xn6qYRYRZl8pY=
X-Google-Smtp-Source: ABdhPJwiL2LC8fHRn8PHoeolHTFt2pF+7fEYTnLmtxSEDjhTTRuvJ8/2BKSXDTkt7n5d1m17BIdkd73hH9w=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:4c6:4bbe:e4c5:ff76])
 (user=haoluo job=sendgmr) by 2002:aa7:914f:0:b0:44d:6f5e:f11a with SMTP id
 15-20020aa7914f000000b0044d6f5ef11amr3941883pfi.10.1636424199017; Mon, 08 Nov
 2021 18:16:39 -0800 (PST)
Date:   Mon,  8 Nov 2021 18:16:19 -0800
In-Reply-To: <20211109021624.1140446-1-haoluo@google.com>
Message-Id: <20211109021624.1140446-5-haoluo@google.com>
Mime-Version: 1.0
References: <20211109021624.1140446-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [RFC PATCH bpf-next 4/9] bpf: Remove ARG_CONST_SIZE_OR_ZERO
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

Remove ARG_CONST_SIZE_OR_ZERO and use flag to mark that the
argument may be zero.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 include/linux/bpf.h      |  2 -
 kernel/bpf/helpers.c     | 20 +++++++--
 kernel/bpf/ringbuf.c     |  5 ++-
 kernel/bpf/stackmap.c    | 15 +++++--
 kernel/bpf/verifier.c    |  8 ++--
 kernel/trace/bpf_trace.c | 90 ++++++++++++++++++++++++++++++++--------
 net/core/filter.c        | 35 ++++++++++++----
 7 files changed, 135 insertions(+), 40 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index dd92418814b5..27f81989f992 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -323,8 +323,6 @@ struct bpf_arg_type {
 					 */
 
 		ARG_CONST_SIZE,		/* number of bytes accessed from memory */
-		ARG_CONST_SIZE_OR_ZERO,	/* number of bytes accessed from memory or 0 */
-
 		ARG_PTR_TO_CTX,		/* pointer to context */
 		ARG_PTR_TO_CTX_OR_NULL,	/* pointer to context or NULL */
 		ARG_ANYTHING,		/* any (initialized) argument is ok */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index cd792777afb2..082a8620f666 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -631,7 +631,10 @@ const struct bpf_func_proto bpf_event_output_data_proto =  {
 	.arg2		= { .type = ARG_CONST_MAP_PTR },
 	.arg3		= { .type = ARG_ANYTHING },
 	.arg4		= { .type = ARG_PTR_TO_MEM },
-	.arg5		= { .type = ARG_CONST_SIZE_OR_ZERO },
+	.arg5		= {
+		.type = ARG_CONST_SIZE,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 };
 
 BPF_CALL_3(bpf_copy_from_user, void *, dst, u32, size,
@@ -652,7 +655,10 @@ const struct bpf_func_proto bpf_copy_from_user_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1		= { .type = ARG_PTR_TO_UNINIT_MEM },
-	.arg2		= { .type = ARG_CONST_SIZE_OR_ZERO },
+	.arg2		= {
+		.type = ARG_CONST_SIZE,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 	.arg3		= { .type = ARG_ANYTHING },
 };
 
@@ -1012,13 +1018,19 @@ const struct bpf_func_proto bpf_snprintf_proto = {
 		.type = ARG_PTR_TO_MEM,
 		.flag = ARG_FLAG_MAYBE_NULL,
 	},
-	.arg2		= { .type = ARG_CONST_SIZE_OR_ZERO },
+	.arg2		= {
+		.type = ARG_CONST_SIZE,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 	.arg3		= { .type = ARG_PTR_TO_CONST_STR },
 	.arg4		= {
 		.type = ARG_PTR_TO_MEM,
 		.flag = ARG_FLAG_MAYBE_NULL,
 	},
-	.arg5		= { .type = ARG_CONST_SIZE_OR_ZERO },
+	.arg5		= {
+		.type = ARG_CONST_SIZE,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 };
 
 /* BPF map elements can contain 'struct bpf_timer'.
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index bf29de9c4a2d..a8af9c7c6423 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -445,7 +445,10 @@ const struct bpf_func_proto bpf_ringbuf_output_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1		= { .type = ARG_CONST_MAP_PTR },
 	.arg2		= { .type = ARG_PTR_TO_MEM },
-	.arg3		= { .type = ARG_CONST_SIZE_OR_ZERO },
+	.arg3		= {
+		.type = ARG_CONST_SIZE,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 	.arg4		= { .type = ARG_ANYTHING },
 };
 
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index ae7bfc278443..496baa1b8def 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -464,7 +464,10 @@ const struct bpf_func_proto bpf_get_stack_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1		= { .type = ARG_PTR_TO_CTX },
 	.arg2		= { .type = ARG_PTR_TO_UNINIT_MEM },
-	.arg3		= { .type = ARG_CONST_SIZE_OR_ZERO },
+	.arg3		= {
+		.type = ARG_CONST_SIZE,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 	.arg4		= { .type = ARG_ANYTHING },
 };
 
@@ -491,7 +494,10 @@ const struct bpf_func_proto bpf_get_task_stack_proto = {
 	.arg1		= { .type = ARG_PTR_TO_BTF_ID },
 	.arg1_btf_id	= &btf_task_struct_ids[0],
 	.arg2		= { .type = ARG_PTR_TO_UNINIT_MEM },
-	.arg3		= { .type = ARG_CONST_SIZE_OR_ZERO },
+	.arg3		= {
+		.type = ARG_CONST_SIZE,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 	.arg4		= { .type = ARG_ANYTHING },
 };
 
@@ -554,7 +560,10 @@ const struct bpf_func_proto bpf_get_stack_proto_pe = {
 	.ret_type	= RET_INTEGER,
 	.arg1		= { .type = ARG_PTR_TO_CTX },
 	.arg2		= { .type = ARG_PTR_TO_UNINIT_MEM },
-	.arg3		= { .type = ARG_CONST_SIZE_OR_ZERO },
+	.arg3		= {
+		.type = ARG_CONST_SIZE,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 	.arg4		= { .type = ARG_ANYTHING },
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index eb69b8bddee5..1a4830ad2be2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2493,7 +2493,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx,
  * r5 += 1
  * ...
  * call bpf_perf_event_output#25
- *   where .arg5 = ARG_CONST_SIZE_OR_ZERO
+ *   where .arg5 = ARG_CONST_SIZE
  *
  * and this case:
  * r6 = 1
@@ -4955,8 +4955,7 @@ static bool arg_type_is_mem_ptr(struct bpf_arg_type arg)
 
 static bool arg_type_is_mem_size(struct bpf_arg_type arg)
 {
-	return arg.type == ARG_CONST_SIZE ||
-	       arg.type == ARG_CONST_SIZE_OR_ZERO;
+	return arg.type == ARG_CONST_SIZE;
 }
 
 static bool arg_type_is_alloc_size(struct bpf_arg_type arg)
@@ -5088,7 +5087,6 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 	[ARG_PTR_TO_MAP_VALUE]		= &map_key_value_types,
 	[ARG_PTR_TO_UNINIT_MAP_VALUE]	= &map_key_value_types,
 	[ARG_CONST_SIZE]		= &scalar_types,
-	[ARG_CONST_SIZE_OR_ZERO]	= &scalar_types,
 	[ARG_CONST_ALLOC_SIZE_OR_ZERO]	= &scalar_types,
 	[ARG_CONST_MAP_PTR]		= &const_map_ptr_types,
 	[ARG_PTR_TO_CTX]		= &context_types,
@@ -5326,7 +5324,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg_num,
 		 */
 		meta->raw_mode = (arg.type == ARG_PTR_TO_UNINIT_MEM);
 	} else if (arg_type_is_mem_size(arg)) {
-		bool zero_size_allowed = (arg.type == ARG_CONST_SIZE_OR_ZERO);
+		bool zero_size_allowed = (arg.flag & ARG_FLAG_MAYBE_NULL);
 
 		/* This is used to refine r0 return value bounds for helpers
 		 * that enforce this value as an upper bound on return values.
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 086889a29ca7..7d6b51ed3292 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -171,7 +171,10 @@ const struct bpf_func_proto bpf_probe_read_user_proto = {
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1		= { .type = ARG_PTR_TO_UNINIT_MEM },
-	.arg2		= { .type = ARG_CONST_SIZE_OR_ZERO },
+	.arg2		= {
+		.type = ARG_CONST_SIZE,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 	.arg3		= { .type = ARG_ANYTHING },
 };
 
@@ -208,7 +211,10 @@ const struct bpf_func_proto bpf_probe_read_user_str_proto = {
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1		= { .type = ARG_PTR_TO_UNINIT_MEM },
-	.arg2		= { .type = ARG_CONST_SIZE_OR_ZERO },
+	.arg2		= {
+		.type = ARG_CONST_SIZE,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 	.arg3		= { .type = ARG_ANYTHING },
 };
 
@@ -234,7 +240,10 @@ const struct bpf_func_proto bpf_probe_read_kernel_proto = {
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1		= { .type = ARG_PTR_TO_UNINIT_MEM },
-	.arg2		= { .type = ARG_CONST_SIZE_OR_ZERO },
+	.arg2		= {
+		.type = ARG_CONST_SIZE,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 	.arg3		= { .type = ARG_ANYTHING },
 };
 
@@ -269,7 +278,10 @@ const struct bpf_func_proto bpf_probe_read_kernel_str_proto = {
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1		= { .type = ARG_PTR_TO_UNINIT_MEM },
-	.arg2		= { .type = ARG_CONST_SIZE_OR_ZERO },
+	.arg2		= {
+		.type = ARG_CONST_SIZE,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 	.arg3		= { .type = ARG_ANYTHING },
 };
 
@@ -289,7 +301,10 @@ static const struct bpf_func_proto bpf_probe_read_compat_proto = {
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1		= { .type = ARG_PTR_TO_UNINIT_MEM },
-	.arg2		= { .type = ARG_CONST_SIZE_OR_ZERO },
+	.arg2		= {
+		.type = ARG_CONST_SIZE,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 	.arg3		= { .type = ARG_ANYTHING },
 };
 
@@ -308,7 +323,10 @@ static const struct bpf_func_proto bpf_probe_read_compat_str_proto = {
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1		= { .type = ARG_PTR_TO_UNINIT_MEM },
-	.arg2		= { .type = ARG_CONST_SIZE_OR_ZERO },
+	.arg2		= {
+		.type = ARG_CONST_SIZE,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 	.arg3		= { .type = ARG_ANYTHING },
 };
 #endif /* CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE */
@@ -456,7 +474,10 @@ static const struct bpf_func_proto bpf_trace_vprintk_proto = {
 		.type = ARG_PTR_TO_MEM,
 		.flag = ARG_FLAG_MAYBE_NULL,
 	},
-	.arg4		= { .type = ARG_CONST_SIZE_OR_ZERO },
+	.arg4		= {
+		.type = ARG_CONST_SIZE,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 };
 
 const struct bpf_func_proto *bpf_get_trace_vprintk_proto(void)
@@ -501,7 +522,10 @@ static const struct bpf_func_proto bpf_seq_printf_proto = {
 		.type = ARG_PTR_TO_MEM,
 		.flag = ARG_FLAG_MAYBE_NULL,
 	},
-	.arg5		= { .type = ARG_CONST_SIZE_OR_ZERO },
+	.arg5		= {
+		.type = ARG_CONST_SIZE,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 };
 
 BPF_CALL_3(bpf_seq_write, struct seq_file *, m, const void *, data, u32, len)
@@ -516,7 +540,10 @@ static const struct bpf_func_proto bpf_seq_write_proto = {
 	.arg1		= { .type = ARG_PTR_TO_BTF_ID },
 	.arg1_btf_id	= &btf_seq_file_ids[0],
 	.arg2		= { .type = ARG_PTR_TO_MEM },
-	.arg3		= { .type = ARG_CONST_SIZE_OR_ZERO },
+	.arg3		= {
+		.type = ARG_CONST_SIZE,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 };
 
 BPF_CALL_4(bpf_seq_printf_btf, struct seq_file *, m, struct btf_ptr *, ptr,
@@ -540,7 +567,10 @@ static const struct bpf_func_proto bpf_seq_printf_btf_proto = {
 	.arg1		= { .type = ARG_PTR_TO_BTF_ID },
 	.arg1_btf_id	= &btf_seq_file_ids[0],
 	.arg2		= { .type = ARG_PTR_TO_MEM },
-	.arg3		= { .type = ARG_CONST_SIZE_OR_ZERO },
+	.arg3		= {
+		.type = ARG_CONST_SIZE,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 	.arg4		= { .type = ARG_ANYTHING },
 };
 
@@ -701,7 +731,10 @@ static const struct bpf_func_proto bpf_perf_event_output_proto = {
 	.arg2		= { .type = ARG_CONST_MAP_PTR },
 	.arg3		= { .type = ARG_ANYTHING },
 	.arg4		= { .type = ARG_PTR_TO_MEM },
-	.arg5		= { .type = ARG_CONST_SIZE_OR_ZERO },
+	.arg5		= {
+		.type = ARG_CONST_SIZE,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 };
 
 static DEFINE_PER_CPU(int, bpf_event_output_nest_level);
@@ -952,7 +985,10 @@ static const struct bpf_func_proto bpf_d_path_proto = {
 	.arg1		= { .type = ARG_PTR_TO_BTF_ID },
 	.arg1_btf_id	= &bpf_d_path_btf_ids[0],
 	.arg2		= { .type = ARG_PTR_TO_MEM },
-	.arg3		= { .type = ARG_CONST_SIZE_OR_ZERO },
+	.arg3		= {
+		.type = ARG_CONST_SIZE,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 	.allowed	= bpf_d_path_allowed,
 };
 
@@ -1094,7 +1130,10 @@ static const struct bpf_func_proto bpf_get_branch_snapshot_proto = {
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1		= { .type = ARG_PTR_TO_UNINIT_MEM },
-	.arg2		= { .type = ARG_CONST_SIZE_OR_ZERO },
+	.arg2		= {
+		.type = ARG_CONST_SIZE,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 };
 
 static const struct bpf_func_proto *
@@ -1296,7 +1335,10 @@ static const struct bpf_func_proto bpf_perf_event_output_proto_tp = {
 	.arg2		= { .type = ARG_CONST_MAP_PTR },
 	.arg3		= { .type = ARG_ANYTHING },
 	.arg4		= { .type = ARG_PTR_TO_MEM },
-	.arg5		= { .type = ARG_CONST_SIZE_OR_ZERO },
+	.arg5		= {
+		.type = ARG_CONST_SIZE,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 };
 
 BPF_CALL_3(bpf_get_stackid_tp, void *, tp_buff, struct bpf_map *, map,
@@ -1337,7 +1379,10 @@ static const struct bpf_func_proto bpf_get_stack_proto_tp = {
 	.ret_type	= RET_INTEGER,
 	.arg1		= { .type = ARG_PTR_TO_CTX },
 	.arg2		= { .type = ARG_PTR_TO_UNINIT_MEM },
-	.arg3		= { .type = ARG_CONST_SIZE_OR_ZERO },
+	.arg3		= {
+		.type = ARG_CONST_SIZE,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 	.arg4		= { .type = ARG_ANYTHING },
 };
 
@@ -1445,7 +1490,10 @@ static const struct bpf_func_proto bpf_read_branch_records_proto = {
 		.type = ARG_PTR_TO_MEM,
 		.flag = ARG_FLAG_MAYBE_NULL,
 	},
-	.arg3	      = { .type = ARG_CONST_SIZE_OR_ZERO },
+	.arg3	      = {
+		.type = ARG_CONST_SIZE,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 	.arg4	      = { .type = ARG_ANYTHING },
 };
 
@@ -1525,7 +1573,10 @@ static const struct bpf_func_proto bpf_perf_event_output_proto_raw_tp = {
 	.arg2		= { .type = ARG_CONST_MAP_PTR },
 	.arg3		= { .type = ARG_ANYTHING },
 	.arg4		= { .type = ARG_PTR_TO_MEM },
-	.arg5		= { .type = ARG_CONST_SIZE_OR_ZERO },
+	.arg5		= {
+		.type = ARG_CONST_SIZE,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 };
 
 extern const struct bpf_func_proto bpf_skb_output_proto;
@@ -1579,7 +1630,10 @@ static const struct bpf_func_proto bpf_get_stack_proto_raw_tp = {
 	.ret_type	= RET_INTEGER,
 	.arg1		= { .type = ARG_PTR_TO_CTX },
 	.arg2		= { .type = ARG_PTR_TO_MEM },
-	.arg3		= { .type = ARG_CONST_SIZE_OR_ZERO },
+	.arg3		= {
+		.type = ARG_CONST_SIZE,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 	.arg4		= { .type = ARG_ANYTHING },
 };
 
diff --git a/net/core/filter.c b/net/core/filter.c
index 81c6638ffc2a..5e0f726a9bcd 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2022,12 +2022,18 @@ static const struct bpf_func_proto bpf_csum_diff_proto = {
 		.type = ARG_PTR_TO_MEM,
 		.flag = ARG_FLAG_MAYBE_NULL,
 	},
-	.arg2		= { .type = ARG_CONST_SIZE_OR_ZERO },
+	.arg2		= {
+		.type = ARG_CONST_SIZE,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 	.arg3		= {
 		.type = ARG_PTR_TO_MEM,
 		.flag = ARG_FLAG_MAYBE_NULL,
 	},
-	.arg4		= { .type = ARG_CONST_SIZE_OR_ZERO },
+	.arg4		= {
+		.type = ARG_CONST_SIZE,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 	.arg5		= { .type = ARG_ANYTHING },
 };
 
@@ -2551,7 +2557,10 @@ static const struct bpf_func_proto bpf_redirect_neigh_proto = {
 		.type = ARG_PTR_TO_MEM,
 		.flag = ARG_FLAG_MAYBE_NULL,
 	},
-	.arg3		= { .type = ARG_CONST_SIZE_OR_ZERO },
+	.arg3		= {
+		.type = ARG_CONST_SIZE,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 	.arg4		= { .type = ARG_ANYTHING },
 };
 
@@ -4184,7 +4193,10 @@ static const struct bpf_func_proto bpf_skb_event_output_proto = {
 	.arg2		= { .type = ARG_CONST_MAP_PTR },
 	.arg3		= { .type = ARG_ANYTHING },
 	.arg4		= { .type = ARG_PTR_TO_MEM },
-	.arg5		= { .type = ARG_CONST_SIZE_OR_ZERO },
+	.arg5		= {
+		.type = ARG_CONST_SIZE,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 };
 
 BTF_ID_LIST_SINGLE(bpf_skb_output_btf_ids, struct, sk_buff)
@@ -4198,7 +4210,10 @@ const struct bpf_func_proto bpf_skb_output_proto = {
 	.arg2		= { .type = ARG_CONST_MAP_PTR },
 	.arg3		= { .type = ARG_ANYTHING },
 	.arg4		= { .type = ARG_PTR_TO_MEM },
-	.arg5		= { .type = ARG_CONST_SIZE_OR_ZERO },
+	.arg5		= {
+		.type = ARG_CONST_SIZE,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 };
 
 static unsigned short bpf_tunnel_key_af(u64 flags)
@@ -4577,7 +4592,10 @@ static const struct bpf_func_proto bpf_xdp_event_output_proto = {
 	.arg2		= { .type = ARG_CONST_MAP_PTR },
 	.arg3		= { .type = ARG_ANYTHING },
 	.arg4		= { .type = ARG_PTR_TO_MEM },
-	.arg5		= { .type = ARG_CONST_SIZE_OR_ZERO },
+	.arg5		= {
+		.type = ARG_CONST_SIZE,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 };
 
 BTF_ID_LIST_SINGLE(bpf_xdp_output_btf_ids, struct, xdp_buff)
@@ -4591,7 +4609,10 @@ const struct bpf_func_proto bpf_xdp_output_proto = {
 	.arg2		= { .type = ARG_CONST_MAP_PTR },
 	.arg3		= { .type = ARG_ANYTHING },
 	.arg4		= { .type = ARG_PTR_TO_MEM },
-	.arg5		= { .type = ARG_CONST_SIZE_OR_ZERO },
+	.arg5		= {
+		.type = ARG_CONST_SIZE,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 };
 
 BPF_CALL_1(bpf_get_socket_cookie, struct sk_buff *, skb)
-- 
2.34.0.rc0.344.g81b53c2807-goog


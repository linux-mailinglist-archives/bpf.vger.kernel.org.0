Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA0846AE5E
	for <lists+bpf@lfdr.de>; Tue,  7 Dec 2021 00:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350577AbhLFX0R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Dec 2021 18:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357504AbhLFX0R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Dec 2021 18:26:17 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE9BC061746
        for <bpf@vger.kernel.org>; Mon,  6 Dec 2021 15:22:47 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id hg9-20020a17090b300900b001a6aa0b7d8cso883622pjb.2
        for <bpf@vger.kernel.org>; Mon, 06 Dec 2021 15:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7d1h5UR7WibHpLEpizOjOk9LhsG8HgRSA29mc5VwW+U=;
        b=HIh0B0faPrVEu/hc8X9ja3CQjtSK2WZ01hnN44oy/sZ5v7hUevNDwVU7k4mtatRC+k
         OczXPrrogLwa4lvp9qVpt1fudEL3EuG1udJVk9HQ1VaMA5IgTZKAgM3f14i1wemeZt2g
         Krezt4x0CCMmPOcXE5pM/wzFuqRD5NQbKE+RbvhOCXdWRXJ6QiSNLrCyNlbFA6jTZlFE
         /AA65xYABGZn0/dDA5wKQ1D1uQWFvX2+TudwcBThH8KU0XbmPseVJBeXqKKFaOOpG1HB
         wDl6kCSW1/b79nWqGds8Bo3UPISawOIV+LFagxLO/r0Hp8LTSpZyYb70SpNTabP57sFQ
         HRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7d1h5UR7WibHpLEpizOjOk9LhsG8HgRSA29mc5VwW+U=;
        b=LakfpnsAxMpMkWVUmRAAqIKtQALhnhPI6SV7S2DNllUg5PXOOjqCWyMfyxB5elFpT0
         4bIWMSnT1Gh/fccPaANhhzX4GG3S6XyjV6dk03lonr7YOvJvJChLjO5jZ9Tj9svvCygw
         T2dYSTBCF2KWoq5omShgwsS/xsnSC/X6aDuq4x/rK3m1avfNDBa1D3/1WpJ3BNIwwgr1
         KbFHX5MB4Owbi8AcDE9ihbp7sKOIW/uBxJFSh0wkzHpxVswweT4wEnZNoHiiO5AZJzxJ
         OHL4bZ12HIYdvle/fdjxQJk+swYoq7IQtwfjD2vvo81Ir9LEfudwx3xFQ7baavzWifF0
         56/g==
X-Gm-Message-State: AOAM530nQjIgaLWVIBo1JnFvo9Ng5h/vSkSofqPnZhhcW5xqcdCnPKq5
        ZSBOUdnlUmxe8pleyHxs7Pm938GFYG4=
X-Google-Smtp-Source: ABdhPJwMddWzXbimzTYv1pc9UCHy/PIcuaYZakX8k7EKmvf5YNWmGrz4sk/RuOMvu5dJDXd76uCb9i2Neug=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:2977:d88c:3c3:c52a])
 (user=haoluo job=sendgmr) by 2002:a17:90a:7ac8:: with SMTP id
 b8mr2020288pjl.206.1638832967306; Mon, 06 Dec 2021 15:22:47 -0800 (PST)
Date:   Mon,  6 Dec 2021 15:22:26 -0800
In-Reply-To: <20211206232227.3286237-1-haoluo@google.com>
Message-Id: <20211206232227.3286237-9-haoluo@google.com>
Mime-Version: 1.0
References: <20211206232227.3286237-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH bpf-next v1 8/9] bpf: Add MEM_RDONLY for helper args that are
 pointers to rdonly mem.
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

Some helper functions may modify its arguments, for example,
bpf_d_path, bpf_get_stack etc. Previously, their argument types
were marked as ARG_PTR_TO_MEM, which is compatible with read-only
mem types, such as PTR_TO_RDONLY_BUF. Therefore it's legitimate
to modify a read-only memory by passing it into one of such helper
functions.

This patch tags the bpf_args compatible with immutable memory with
MEM_RDONLY flag. The arguments that don't have this flag will be
only compatible with mutable memory types, preventing the helper
from modifying a read-only memory. The bpf_args that have
MEM_RDONLY are compatible with both mutable memory and immutable
memory.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 include/linux/bpf.h      |  4 ++-
 kernel/bpf/btf.c         |  2 +-
 kernel/bpf/cgroup.c      |  2 +-
 kernel/bpf/helpers.c     |  8 ++---
 kernel/bpf/ringbuf.c     |  2 +-
 kernel/bpf/syscall.c     |  2 +-
 kernel/bpf/verifier.c    | 14 +++++++--
 kernel/trace/bpf_trace.c | 26 ++++++++--------
 net/core/filter.c        | 64 ++++++++++++++++++++--------------------
 9 files changed, 67 insertions(+), 57 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 03418ab3f416..5151d6b1f392 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -311,7 +311,9 @@ enum bpf_type_flag {
 	/* PTR may be NULL. */
 	PTR_MAYBE_NULL		= BIT(0 + BPF_BASE_TYPE_BITS),
 
-	/* MEM is read-only. */
+	/* MEM is read-only. When applied on bpf_arg, it indicates the arg is
+	 * compatible with both mutable and immutable memory.
+	 */
 	MEM_RDONLY		= BIT(1 + BPF_BASE_TYPE_BITS),
 
 	__BPF_TYPE_LAST_FLAG	= MEM_RDONLY,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 7adc099bb24b..e09b5a7bfdc3 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6350,7 +6350,7 @@ const struct bpf_func_proto bpf_btf_find_by_name_kind_proto = {
 	.func		= bpf_btf_find_by_name_kind,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_PTR_TO_MEM,
+	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg2_type	= ARG_CONST_SIZE,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_ANYTHING,
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 2ca643af9a54..b8fe671af13c 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1789,7 +1789,7 @@ static const struct bpf_func_proto bpf_sysctl_set_new_value_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE,
 };
 
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a5e349c9d3e3..66b466903a4e 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -530,7 +530,7 @@ const struct bpf_func_proto bpf_strtol_proto = {
 	.func		= bpf_strtol,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_PTR_TO_MEM,
+	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg2_type	= ARG_CONST_SIZE,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_PTR_TO_LONG,
@@ -558,7 +558,7 @@ const struct bpf_func_proto bpf_strtoul_proto = {
 	.func		= bpf_strtoul,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_PTR_TO_MEM,
+	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg2_type	= ARG_CONST_SIZE,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_PTR_TO_LONG,
@@ -630,7 +630,7 @@ const struct bpf_func_proto bpf_event_output_data_proto =  {
 	.arg1_type      = ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_CONST_MAP_PTR,
 	.arg3_type      = ARG_ANYTHING,
-	.arg4_type      = ARG_PTR_TO_MEM,
+	.arg4_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg5_type      = ARG_CONST_SIZE_OR_ZERO,
 };
 
@@ -1011,7 +1011,7 @@ const struct bpf_func_proto bpf_snprintf_proto = {
 	.arg1_type	= ARG_PTR_TO_MEM_OR_NULL,
 	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg3_type	= ARG_PTR_TO_CONST_STR,
-	.arg4_type	= ARG_PTR_TO_MEM_OR_NULL,
+	.arg4_type	= ARG_PTR_TO_MEM | PTR_MAYBE_NULL | MEM_RDONLY,
 	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 9e0c10c6892a..638d7fd7b375 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -444,7 +444,7 @@ const struct bpf_func_proto bpf_ringbuf_output_proto = {
 	.func		= bpf_ringbuf_output,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_CONST_MAP_PTR,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 };
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 50f96ea4452a..301afb44e47f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4757,7 +4757,7 @@ static const struct bpf_func_proto bpf_sys_bpf_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_ANYTHING,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE,
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 44af65f07a82..a7c015a7b52d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4966,6 +4966,7 @@ static int resolve_map_arg_type(struct bpf_verifier_env *env,
 	return 0;
 }
 
+
 struct bpf_reg_types {
 	const enum bpf_reg_type types[10];
 	u32 *btf_id;
@@ -5012,7 +5013,6 @@ static const struct bpf_reg_types mem_types = {
 		PTR_TO_MAP_VALUE,
 		PTR_TO_MEM,
 		PTR_TO_BUF,
-		PTR_TO_BUF | MEM_RDONLY,
 	},
 };
 
@@ -5074,6 +5074,7 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
 	enum bpf_reg_type expected, type = reg->type;
 	const struct bpf_reg_types *compatible;
+	u32 compatible_flags;
 	int i, j;
 
 	compatible = compatible_reg_types[base_type(arg_type)];
@@ -5082,6 +5083,13 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 		return -EFAULT;
 	}
 
+	/* If arg_type is tagged with MEM_RDONLY, it's compatible with both
+	 * RDONLY and non-RDONLY reg values. Therefore fold this flag before
+	 * comparison. PTR_MAYBE_NULL is similar.
+	 */
+	compatible_flags = arg_type & (MEM_RDONLY | PTR_MAYBE_NULL);
+	type &= ~compatible_flags;
+
 	for (i = 0; i < ARRAY_SIZE(compatible->types); i++) {
 		expected = compatible->types[i];
 		if (expected == NOT_INIT)
@@ -5091,14 +5099,14 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 			goto found;
 	}
 
-	verbose(env, "R%d type=%s expected=", regno, reg_type_str(type));
+	verbose(env, "R%d type=%s expected=", regno, reg_type_str(reg->type));
 	for (j = 0; j + 1 < i; j++)
 		verbose(env, "%s, ", reg_type_str(compatible->types[j]));
 	verbose(env, "%s\n", reg_type_str(compatible->types[j]));
 	return -EACCES;
 
 found:
-	if (type == PTR_TO_BTF_ID) {
+	if (reg->type == PTR_TO_BTF_ID) {
 		if (!arg_btf_id) {
 			if (!compatible->btf_id) {
 				verbose(env, "verifier internal error: missing arg compatible BTF ID\n");
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 25ea521fb8f1..79404049b70f 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -345,7 +345,7 @@ static const struct bpf_func_proto bpf_probe_write_user_proto = {
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_ANYTHING,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE,
 };
 
@@ -394,7 +394,7 @@ static const struct bpf_func_proto bpf_trace_printk_proto = {
 	.func		= bpf_trace_printk,
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_PTR_TO_MEM,
+	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg2_type	= ARG_CONST_SIZE,
 };
 
@@ -450,9 +450,9 @@ static const struct bpf_func_proto bpf_trace_vprintk_proto = {
 	.func		= bpf_trace_vprintk,
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_PTR_TO_MEM,
+	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg2_type	= ARG_CONST_SIZE,
-	.arg3_type	= ARG_PTR_TO_MEM_OR_NULL,
+	.arg3_type	= ARG_PTR_TO_MEM | PTR_MAYBE_NULL | MEM_RDONLY,
 	.arg4_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
@@ -492,9 +492,9 @@ static const struct bpf_func_proto bpf_seq_printf_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
 	.arg1_btf_id	= &btf_seq_file_ids[0],
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE,
-	.arg4_type      = ARG_PTR_TO_MEM_OR_NULL,
+	.arg4_type      = ARG_PTR_TO_MEM | PTR_MAYBE_NULL | MEM_RDONLY,
 	.arg5_type      = ARG_CONST_SIZE_OR_ZERO,
 };
 
@@ -509,7 +509,7 @@ static const struct bpf_func_proto bpf_seq_write_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
 	.arg1_btf_id	= &btf_seq_file_ids[0],
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
@@ -533,7 +533,7 @@ static const struct bpf_func_proto bpf_seq_printf_btf_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
 	.arg1_btf_id	= &btf_seq_file_ids[0],
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 };
@@ -694,7 +694,7 @@ static const struct bpf_func_proto bpf_perf_event_output_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_CONST_MAP_PTR,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_MEM,
+	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
@@ -1004,7 +1004,7 @@ const struct bpf_func_proto bpf_snprintf_btf_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_MEM,
 	.arg2_type	= ARG_CONST_SIZE,
-	.arg3_type	= ARG_PTR_TO_MEM,
+	.arg3_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg4_type	= ARG_CONST_SIZE,
 	.arg5_type	= ARG_ANYTHING,
 };
@@ -1289,7 +1289,7 @@ static const struct bpf_func_proto bpf_perf_event_output_proto_tp = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_CONST_MAP_PTR,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_MEM,
+	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
@@ -1515,7 +1515,7 @@ static const struct bpf_func_proto bpf_perf_event_output_proto_raw_tp = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_CONST_MAP_PTR,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_MEM,
+	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
@@ -1569,7 +1569,7 @@ static const struct bpf_func_proto bpf_get_stack_proto_raw_tp = {
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 };
diff --git a/net/core/filter.c b/net/core/filter.c
index 26e0276aa00d..eadca10b436d 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1713,7 +1713,7 @@ static const struct bpf_func_proto bpf_skb_store_bytes_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_PTR_TO_MEM,
+	.arg3_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg4_type	= ARG_CONST_SIZE,
 	.arg5_type	= ARG_ANYTHING,
 };
@@ -2018,9 +2018,9 @@ static const struct bpf_func_proto bpf_csum_diff_proto = {
 	.gpl_only	= false,
 	.pkt_access	= true,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_PTR_TO_MEM_OR_NULL,
+	.arg1_type	= ARG_PTR_TO_MEM | PTR_MAYBE_NULL | MEM_RDONLY,
 	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
-	.arg3_type	= ARG_PTR_TO_MEM_OR_NULL,
+	.arg3_type	= ARG_PTR_TO_MEM | PTR_MAYBE_NULL | MEM_RDONLY,
 	.arg4_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg5_type	= ARG_ANYTHING,
 };
@@ -2541,7 +2541,7 @@ static const struct bpf_func_proto bpf_redirect_neigh_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_ANYTHING,
-	.arg2_type      = ARG_PTR_TO_MEM_OR_NULL,
+	.arg2_type      = ARG_PTR_TO_MEM | PTR_MAYBE_NULL | MEM_RDONLY,
 	.arg3_type      = ARG_CONST_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 };
@@ -4174,7 +4174,7 @@ static const struct bpf_func_proto bpf_skb_event_output_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_CONST_MAP_PTR,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_MEM,
+	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
@@ -4188,7 +4188,7 @@ const struct bpf_func_proto bpf_skb_output_proto = {
 	.arg1_btf_id	= &bpf_skb_output_btf_ids[0],
 	.arg2_type	= ARG_CONST_MAP_PTR,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_MEM,
+	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
@@ -4371,7 +4371,7 @@ static const struct bpf_func_proto bpf_skb_set_tunnel_key_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 };
@@ -4397,7 +4397,7 @@ static const struct bpf_func_proto bpf_skb_set_tunnel_opt_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE,
 };
 
@@ -4567,7 +4567,7 @@ static const struct bpf_func_proto bpf_xdp_event_output_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_CONST_MAP_PTR,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_MEM,
+	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
@@ -4581,7 +4581,7 @@ const struct bpf_func_proto bpf_xdp_output_proto = {
 	.arg1_btf_id	= &bpf_xdp_output_btf_ids[0],
 	.arg2_type	= ARG_CONST_MAP_PTR,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_MEM,
+	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
@@ -5067,7 +5067,7 @@ const struct bpf_func_proto bpf_sk_setsockopt_proto = {
 	.arg1_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON,
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_MEM,
+	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg5_type	= ARG_CONST_SIZE,
 };
 
@@ -5101,7 +5101,7 @@ static const struct bpf_func_proto bpf_sock_addr_setsockopt_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_MEM,
+	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg5_type	= ARG_CONST_SIZE,
 };
 
@@ -5135,7 +5135,7 @@ static const struct bpf_func_proto bpf_sock_ops_setsockopt_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_MEM,
+	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg5_type	= ARG_CONST_SIZE,
 };
 
@@ -5310,7 +5310,7 @@ static const struct bpf_func_proto bpf_bind_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE,
 };
 
@@ -5898,7 +5898,7 @@ static const struct bpf_func_proto bpf_lwt_in_push_encap_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_PTR_TO_MEM,
+	.arg3_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg4_type	= ARG_CONST_SIZE
 };
 
@@ -5908,7 +5908,7 @@ static const struct bpf_func_proto bpf_lwt_xmit_push_encap_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_PTR_TO_MEM,
+	.arg3_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg4_type	= ARG_CONST_SIZE
 };
 
@@ -5951,7 +5951,7 @@ static const struct bpf_func_proto bpf_lwt_seg6_store_bytes_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_PTR_TO_MEM,
+	.arg3_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg4_type	= ARG_CONST_SIZE
 };
 
@@ -6039,7 +6039,7 @@ static const struct bpf_func_proto bpf_lwt_seg6_action_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_PTR_TO_MEM,
+	.arg3_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg4_type	= ARG_CONST_SIZE
 };
 
@@ -6264,7 +6264,7 @@ static const struct bpf_func_proto bpf_skc_lookup_tcp_proto = {
 	.pkt_access	= true,
 	.ret_type	= RET_PTR_TO_SOCK_COMMON_OR_NULL,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
@@ -6283,7 +6283,7 @@ static const struct bpf_func_proto bpf_sk_lookup_tcp_proto = {
 	.pkt_access	= true,
 	.ret_type	= RET_PTR_TO_SOCKET_OR_NULL,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
@@ -6302,7 +6302,7 @@ static const struct bpf_func_proto bpf_sk_lookup_udp_proto = {
 	.pkt_access	= true,
 	.ret_type	= RET_PTR_TO_SOCKET_OR_NULL,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
@@ -6339,7 +6339,7 @@ static const struct bpf_func_proto bpf_xdp_sk_lookup_udp_proto = {
 	.pkt_access     = true,
 	.ret_type       = RET_PTR_TO_SOCKET_OR_NULL,
 	.arg1_type      = ARG_PTR_TO_CTX,
-	.arg2_type      = ARG_PTR_TO_MEM,
+	.arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type      = ARG_CONST_SIZE,
 	.arg4_type      = ARG_ANYTHING,
 	.arg5_type      = ARG_ANYTHING,
@@ -6362,7 +6362,7 @@ static const struct bpf_func_proto bpf_xdp_skc_lookup_tcp_proto = {
 	.pkt_access     = true,
 	.ret_type       = RET_PTR_TO_SOCK_COMMON_OR_NULL,
 	.arg1_type      = ARG_PTR_TO_CTX,
-	.arg2_type      = ARG_PTR_TO_MEM,
+	.arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type      = ARG_CONST_SIZE,
 	.arg4_type      = ARG_ANYTHING,
 	.arg5_type      = ARG_ANYTHING,
@@ -6385,7 +6385,7 @@ static const struct bpf_func_proto bpf_xdp_sk_lookup_tcp_proto = {
 	.pkt_access     = true,
 	.ret_type       = RET_PTR_TO_SOCKET_OR_NULL,
 	.arg1_type      = ARG_PTR_TO_CTX,
-	.arg2_type      = ARG_PTR_TO_MEM,
+	.arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type      = ARG_CONST_SIZE,
 	.arg4_type      = ARG_ANYTHING,
 	.arg5_type      = ARG_ANYTHING,
@@ -6404,7 +6404,7 @@ static const struct bpf_func_proto bpf_sock_addr_skc_lookup_tcp_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_PTR_TO_SOCK_COMMON_OR_NULL,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
@@ -6423,7 +6423,7 @@ static const struct bpf_func_proto bpf_sock_addr_sk_lookup_tcp_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_PTR_TO_SOCKET_OR_NULL,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
@@ -6442,7 +6442,7 @@ static const struct bpf_func_proto bpf_sock_addr_sk_lookup_udp_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_PTR_TO_SOCKET_OR_NULL,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
@@ -6755,9 +6755,9 @@ static const struct bpf_func_proto bpf_tcp_check_syncookie_proto = {
 	.pkt_access	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE,
-	.arg4_type	= ARG_PTR_TO_MEM,
+	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg5_type	= ARG_CONST_SIZE,
 };
 
@@ -6824,9 +6824,9 @@ static const struct bpf_func_proto bpf_tcp_gen_syncookie_proto = {
 	.pkt_access	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE,
-	.arg4_type	= ARG_PTR_TO_MEM,
+	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg5_type	= ARG_CONST_SIZE,
 };
 
@@ -7055,7 +7055,7 @@ static const struct bpf_func_proto bpf_sock_ops_store_hdr_opt_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 };
-- 
2.34.1.400.ga245620fadb-goog


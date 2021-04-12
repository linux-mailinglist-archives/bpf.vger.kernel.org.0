Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F2035CA2D
	for <lists+bpf@lfdr.de>; Mon, 12 Apr 2021 17:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243155AbhDLPi1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Apr 2021 11:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243134AbhDLPiW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Apr 2021 11:38:22 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2535FC061344
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 08:38:04 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id w7-20020a1cdf070000b0290125f388fb34so6467428wmg.0
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 08:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3P/DPjrl0Mazyk3F7ibE7epMr8BVunMgYhF76uRot4Q=;
        b=IIBW4oQ4jWwZZ2VaMh2EskQP90/cZjYSas6KTlru//cZZO/64B+hRww2T9atMPGd9P
         btEZiwKS3NmCHitzsnqE1+OahWpdTUfCBFwAkbFFcbTP6H/wV6OofOYfZu1sjHMPYEOr
         v0j2IbJ5MPd6WAZESQMiA5xgun1rHdOdU6I7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3P/DPjrl0Mazyk3F7ibE7epMr8BVunMgYhF76uRot4Q=;
        b=JtB00wcTd8bP4f/zml7PKM+tZqrDX6MwZ/YXm+tSWmD7hcbVCMsnuRSTrsJU53hiQg
         t8wQwzDavYCqTpeqeNsYkXOcg7UqrV0VxNHEHbPyBsVdyq1bwn7tAJuK7TV9DVoJJW/H
         H6Q5ZaczG5Fsf2h8/cj4dqV6S+6cr9W2VFQMWpSsmCEIXB9gQ6dRZ3AIwbcVAOX4AL6l
         ohAco33P6ekbFQV4U04BtIGzRUClLi+Iklth5OJeBByuywkY3HtjWgz6O2iKyBcqjS6t
         RRc2gKcoDgDrHC0f3vWyzhP7lfSg5Y8YnScHduHIPxErOyV2pSOv+Bm5F8h6rDqHr3dG
         bywA==
X-Gm-Message-State: AOAM531+ckTAVc9m100nGwm6cuWqcZ9d1asJ9Fu88r6BBhAsYcvQHF12
        ucK//spFycHfC9++1p8GzWayiCDdwnTmhA==
X-Google-Smtp-Source: ABdhPJwskOAZ4ZFaKdPq8cYAz8qeJFwVJDe+zvDeKhWEAJD6hmPE9K6G6fz9s8tidGJcDWEl2GVqSw==
X-Received: by 2002:a05:600c:3796:: with SMTP id o22mr27129660wmr.139.1618241882517;
        Mon, 12 Apr 2021 08:38:02 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:a372:3c3b:eeb:ad14])
        by smtp.gmail.com with ESMTPSA id i4sm2501449wrx.56.2021.04.12.08.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 08:38:02 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v3 3/6] bpf: Add a bpf_snprintf helper
Date:   Mon, 12 Apr 2021 17:37:51 +0200
Message-Id: <20210412153754.235500-4-revest@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210412153754.235500-1-revest@chromium.org>
References: <20210412153754.235500-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The implementation takes inspiration from the existing bpf_trace_printk
helper but there are a few differences:

To allow for a large number of format-specifiers, parameters are
provided in an array, like in bpf_seq_printf.

Because the output string takes two arguments and the array of
parameters also takes two arguments, the format string needs to fit in
one argument. Thankfully, ARG_PTR_TO_CONST_STR is guaranteed to point to
a zero-terminated read-only map so we don't need a format string length
arg.

Because the format-string is known at verification time, we also do
a first pass of format string validation in the verifier logic. This
makes debugging easier.

Signed-off-by: Florent Revest <revest@chromium.org>
---
 include/linux/bpf.h            |  6 ++++
 include/uapi/linux/bpf.h       | 28 +++++++++++++++++++
 kernel/bpf/helpers.c           |  2 ++
 kernel/bpf/verifier.c          | 41 ++++++++++++++++++++++++++++
 kernel/trace/bpf_trace.c       | 50 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h | 28 +++++++++++++++++++
 6 files changed, 155 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7d389eeee0b3..a3650fc93068 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1953,6 +1953,7 @@ extern const struct bpf_func_proto bpf_skc_to_tcp_request_sock_proto;
 extern const struct bpf_func_proto bpf_skc_to_udp6_sock_proto;
 extern const struct bpf_func_proto bpf_copy_from_user_proto;
 extern const struct bpf_func_proto bpf_snprintf_btf_proto;
+extern const struct bpf_func_proto bpf_snprintf_proto;
 extern const struct bpf_func_proto bpf_per_cpu_ptr_proto;
 extern const struct bpf_func_proto bpf_this_cpu_ptr_proto;
 extern const struct bpf_func_proto bpf_ktime_get_coarse_ns_proto;
@@ -2078,4 +2079,9 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 struct btf_id_set;
 bool btf_id_set_contains(const struct btf_id_set *set, u32 id);
 
+enum bpf_printf_mod_type;
+int bpf_printf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
+		       u64 *final_args, enum bpf_printf_mod_type *mod,
+		       u32 num_args);
+
 #endif /* _LINUX_BPF_H */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 49371eba98ba..40546d4676f1 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4671,6 +4671,33 @@ union bpf_attr {
  *	Return
  *		The number of traversed map elements for success, **-EINVAL** for
  *		invalid **flags**.
+ *
+ * long bpf_snprintf(char *str, u32 str_size, const char *fmt, u64 *data, u32 data_len)
+ *	Description
+ *		Outputs a string into the **str** buffer of size **str_size**
+ *		based on a format string stored in a read-only map pointed by
+ *		**fmt**.
+ *
+ *		Each format specifier in **fmt** corresponds to one u64 element
+ *		in the **data** array. For strings and pointers where pointees
+ *		are accessed, only the pointer values are stored in the *data*
+ *		array. The *data_len* is the size of *data* in bytes.
+ *
+ *		Formats **%s** and **%p{i,I}{4,6}** require to read kernel
+ *		memory. Reading kernel memory may fail due to either invalid
+ *		address or valid address but requiring a major memory fault. If
+ *		reading kernel memory fails, the string for **%s** will be an
+ *		empty string, and the ip address for **%p{i,I}{4,6}** will be 0.
+ *		Not returning error to bpf program is consistent with what
+ *		**bpf_trace_printk**\ () does for now.
+ *
+ *	Return
+ *		The strictly positive length of the formatted string, including
+ *		the trailing zero character. If the return value is greater than
+ *		**str_size**, **str** contains a truncated string, guaranteed to
+ *		be zero-terminated except when **str_size** is 0.
+ *
+ *		Or **-EBUSY** if the per-CPU memory copy buffer is busy.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -4838,6 +4865,7 @@ union bpf_attr {
 	FN(sock_from_file),		\
 	FN(check_mtu),			\
 	FN(for_each_map_elem),		\
+	FN(snprintf),			\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index f306611c4ddf..ec45c7526924 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -757,6 +757,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_probe_read_kernel_str_proto;
 	case BPF_FUNC_snprintf_btf:
 		return &bpf_snprintf_btf_proto;
+	case BPF_FUNC_snprintf:
+		return &bpf_snprintf_proto;
 	default:
 		return NULL;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5f46dd6f3383..d4020e5f91ee 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5918,6 +5918,41 @@ static int check_reference_leak(struct bpf_verifier_env *env)
 	return state->acquired_refs ? -EINVAL : 0;
 }
 
+static int check_bpf_snprintf_call(struct bpf_verifier_env *env,
+				   struct bpf_reg_state *regs)
+{
+	struct bpf_reg_state *fmt_reg = &regs[BPF_REG_3];
+	struct bpf_reg_state *data_len_reg = &regs[BPF_REG_5];
+	struct bpf_map *fmt_map = fmt_reg->map_ptr;
+	int err, fmt_map_off, num_args;
+	u64 fmt_addr;
+	char *fmt;
+
+	/* data must be an array of u64 */
+	if (data_len_reg->var_off.value % 8)
+		return -EINVAL;
+	num_args = data_len_reg->var_off.value / 8;
+
+	/* fmt being ARG_PTR_TO_CONST_STR guarantees that var_off is const
+	 * and map_direct_value_addr is set.
+	 */
+	fmt_map_off = fmt_reg->off + fmt_reg->var_off.value;
+	err = fmt_map->ops->map_direct_value_addr(fmt_map, &fmt_addr,
+						  fmt_map_off);
+	if (err)
+		return err;
+	fmt = (char *)fmt_addr + fmt_map_off;
+
+	/* We are also guaranteed that fmt+fmt_map_off is NULL terminated, we
+	 * can focus on validating the format specifiers.
+	 */
+	err = bpf_printf_prepare(fmt, UINT_MAX, NULL, NULL, NULL, num_args);
+	if (err < 0)
+		verbose(env, "Invalid format string\n");
+
+	return err;
+}
+
 static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			     int *insn_idx_p)
 {
@@ -6032,6 +6067,12 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			return -EINVAL;
 	}
 
+	if (func_id == BPF_FUNC_snprintf) {
+		err = check_bpf_snprintf_call(env, regs);
+		if (err < 0)
+			return err;
+	}
+
 	/* reset caller saved regs */
 	for (i = 0; i < CALLER_SAVED_REGS; i++) {
 		mark_reg_not_init(env, regs, caller_saved[i]);
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 3ce9aeee6681..990ed98d2842 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1238,6 +1238,54 @@ const struct bpf_func_proto bpf_snprintf_btf_proto = {
 	.arg5_type	= ARG_ANYTHING,
 };
 
+#define MAX_SNPRINTF_VARARGS		12
+
+BPF_CALL_5(bpf_snprintf, char *, str, u32, str_size, char *, fmt,
+	   const void *, data, u32, data_len)
+{
+	enum bpf_printf_mod_type mod[MAX_SNPRINTF_VARARGS];
+	u64 args[MAX_SNPRINTF_VARARGS];
+	int err, num_args;
+
+	if (data_len % 8 || data_len > MAX_SNPRINTF_VARARGS * 8 ||
+	    (data_len && !data))
+		return -EINVAL;
+	num_args = data_len / 8;
+
+	/* ARG_PTR_TO_CONST_STR guarantees that fmt is zero-terminated so we
+	 * can safely give an unbounded size.
+	 */
+	err = bpf_printf_prepare(fmt, UINT_MAX, data, args, mod, num_args);
+	if (err < 0)
+		return err;
+
+	/* Maximumly we can have MAX_SNPRINTF_VARARGS parameters, just give
+	 * all of them to snprintf().
+	 */
+	err = snprintf(str, str_size, fmt, BPF_CAST_FMT_ARG(0, args, mod),
+		BPF_CAST_FMT_ARG(1, args, mod), BPF_CAST_FMT_ARG(2, args, mod),
+		BPF_CAST_FMT_ARG(3, args, mod), BPF_CAST_FMT_ARG(4, args, mod),
+		BPF_CAST_FMT_ARG(5, args, mod), BPF_CAST_FMT_ARG(6, args, mod),
+		BPF_CAST_FMT_ARG(7, args, mod), BPF_CAST_FMT_ARG(8, args, mod),
+		BPF_CAST_FMT_ARG(9, args, mod), BPF_CAST_FMT_ARG(10, args, mod),
+		BPF_CAST_FMT_ARG(11, args, mod));
+
+	put_fmt_tmp_buf();
+
+	return err + 1;
+}
+
+const struct bpf_func_proto bpf_snprintf_proto = {
+	.func		= bpf_snprintf,
+	.gpl_only	= true,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_MEM_OR_NULL,
+	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type	= ARG_PTR_TO_CONST_STR,
+	.arg4_type	= ARG_PTR_TO_MEM_OR_NULL,
+	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
+};
+
 const struct bpf_func_proto *
 bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -1340,6 +1388,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_task_storage_delete_proto;
 	case BPF_FUNC_for_each_map_elem:
 		return &bpf_for_each_map_elem_proto;
+	case BPF_FUNC_snprintf:
+		return &bpf_snprintf_proto;
 	default:
 		return NULL;
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 69902603012c..ffdd2ae18c69 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4665,6 +4665,33 @@ union bpf_attr {
  *	Return
  *		The number of traversed map elements for success, **-EINVAL** for
  *		invalid **flags**.
+ *
+ * long bpf_snprintf(char *str, u32 str_size, const char *fmt, u64 *data, u32 data_len)
+ *	Description
+ *		Outputs a string into the **str** buffer of size **str_size**
+ *		based on a format string stored in a read-only map pointed by
+ *		**fmt**.
+ *
+ *		Each format specifier in **fmt** corresponds to one u64 element
+ *		in the **data** array. For strings and pointers where pointees
+ *		are accessed, only the pointer values are stored in the *data*
+ *		array. The *data_len* is the size of *data* in bytes.
+ *
+ *		Formats **%s** and **%p{i,I}{4,6}** require to read kernel
+ *		memory. Reading kernel memory may fail due to either invalid
+ *		address or valid address but requiring a major memory fault. If
+ *		reading kernel memory fails, the string for **%s** will be an
+ *		empty string, and the ip address for **%p{i,I}{4,6}** will be 0.
+ *		Not returning error to bpf program is consistent with what
+ *		**bpf_trace_printk**\ () does for now.
+ *
+ *	Return
+ *		The strictly positive length of the formatted string, including
+ *		the trailing zero character. If the return value is greater than
+ *		**str_size**, **str** contains a truncated string, guaranteed to
+ *		be zero-terminated except when **str_size** is 0.
+ *
+ *		Or **-EBUSY** if the per-CPU memory copy buffer is busy.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -4832,6 +4859,7 @@ union bpf_attr {
 	FN(sock_from_file),		\
 	FN(check_mtu),			\
 	FN(for_each_map_elem),		\
+	FN(snprintf),			\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.31.1.295.g9ea45b61b8-goog


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF55346F6F
	for <lists+bpf@lfdr.de>; Wed, 24 Mar 2021 03:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbhCXCXX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Mar 2021 22:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbhCXCXJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Mar 2021 22:23:09 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC2AC061765
        for <bpf@vger.kernel.org>; Tue, 23 Mar 2021 19:23:09 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v4so22826332wrp.13
        for <bpf@vger.kernel.org>; Tue, 23 Mar 2021 19:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZkjCrgnEgvQfqsVnqhVVOdbWMBOed7xvaT8ATkQrRYY=;
        b=BTgNiZwOiPD/uOZfH7x1auNgMBYSYs1FXq+wbsQSXIQUj8dZL99os5UEMtRqXkR9AQ
         mYd9Ku3uWSQL6qfo6F4eB1N/xWVeaRZAWNT1VlmjLoqqYSGh5ah6oJSnWwM6nqEKoor8
         /1/gjSqWpuWk3tw7+GUobJKHSdP2iahet7Frw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZkjCrgnEgvQfqsVnqhVVOdbWMBOed7xvaT8ATkQrRYY=;
        b=oRmcNmkYhZugcpDqDrjt3cX4NKUskq88h86owfJDmshmaGeZhp362yR0MKLHIEUBRs
         777m/GoJjPbSDreCWvDJJgUb8QElUmgiZcKbJxw/5Fn8fLig1QiU+pCRWGIQFKmV8zUv
         UrzhdBeKB95AJ0udbG8Jn8/DILl/jl3XYK9hJsR+EcZ6rCbRaqt7WQvxOKxNhFe/gnmH
         GKVX5VVRmatL+Wby3bLGmeOqoNe5qo+Gr9V3cGbVCDVKq/9kjFJkpu+KTL3ofVOHSiQ2
         WnV3gHkudMixBvgnfdm2LhYbVv59HbwZZzjLy5g1AHoEzFvIONIUjkowymgWeJZt48YP
         4s5Q==
X-Gm-Message-State: AOAM531qdRnjxkjNbfzbwdvc6g7ZluaG5pdToVX3By3Yx8HPns/B0yxz
        w0CoQ1ymIe1K1JgAhK4VRRykebvCIZKWiA==
X-Google-Smtp-Source: ABdhPJwAselLrOHaNmHCWIjg7RPBCSDXnvwh1HUfbmKw2YjjdKU5EtChaDh93gMJDlioY2fGaDLwtA==
X-Received: by 2002:adf:f851:: with SMTP id d17mr816541wrq.267.1616552587629;
        Tue, 23 Mar 2021 19:23:07 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:ccba:9601:929c:dbcb])
        by smtp.gmail.com with ESMTPSA id n9sm74219wrx.46.2021.03.23.19.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 19:23:07 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v2 3/6] bpf: Add a bpf_snprintf helper
Date:   Wed, 24 Mar 2021 03:22:08 +0100
Message-Id: <20210324022211.1718762-4-revest@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210324022211.1718762-1-revest@chromium.org>
References: <20210324022211.1718762-1-revest@chromium.org>
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
one argument. But because ARG_PTR_TO_CONST_STR guarantees to point to a
NULL-terminated read-only map, we don't need a format string length arg.

Because the format-string is known at verification time, we also move
most of the format string validation, currently done in formatting
helper calls, into the verifier logic. This makes debugging easier and
also slightly improves the runtime performance.

Signed-off-by: Florent Revest <revest@chromium.org>
---
 include/linux/bpf.h            |  6 ++++
 include/uapi/linux/bpf.h       | 28 ++++++++++++++++++
 kernel/bpf/helpers.c           |  2 ++
 kernel/bpf/verifier.c          | 41 +++++++++++++++++++++++++++
 kernel/trace/bpf_trace.c       | 52 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h | 28 ++++++++++++++++++
 6 files changed, 157 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7b5319d75b3e..f3d9c8fa60b3 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1893,6 +1893,7 @@ extern const struct bpf_func_proto bpf_skc_to_tcp_request_sock_proto;
 extern const struct bpf_func_proto bpf_skc_to_udp6_sock_proto;
 extern const struct bpf_func_proto bpf_copy_from_user_proto;
 extern const struct bpf_func_proto bpf_snprintf_btf_proto;
+extern const struct bpf_func_proto bpf_snprintf_proto;
 extern const struct bpf_func_proto bpf_per_cpu_ptr_proto;
 extern const struct bpf_func_proto bpf_this_cpu_ptr_proto;
 extern const struct bpf_func_proto bpf_ktime_get_coarse_ns_proto;
@@ -2018,4 +2019,9 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 struct btf_id_set;
 bool btf_id_set_contains(const struct btf_id_set *set, u32 id);
 
+enum bpf_printf_mod_type;
+int bpf_printf_preamble(char *fmt, u32 fmt_size, const u64 *raw_args,
+			u64 *final_args, enum bpf_printf_mod_type *mod,
+			u32 num_args);
+
 #endif /* _LINUX_BPF_H */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 2d3036e292a9..86af61e912c6 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4660,6 +4660,33 @@ union bpf_attr {
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
+ *		be zero-terminated.
+ *
+ *		Or **-EBUSY** if the per-CPU memory copy buffer is busy.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -4827,6 +4854,7 @@ union bpf_attr {
 	FN(sock_from_file),		\
 	FN(check_mtu),			\
 	FN(for_each_map_elem),		\
+	FN(snprintf),			\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 074800226327..12f4cfb04fe7 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -750,6 +750,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_probe_read_kernel_str_proto;
 	case BPF_FUNC_snprintf_btf:
 		return &bpf_snprintf_btf_proto;
+	case BPF_FUNC_snprintf:
+		return &bpf_snprintf_proto;
 	default:
 		return NULL;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9e03608725b4..a89599dc51c9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5729,6 +5729,41 @@ static int check_reference_leak(struct bpf_verifier_env *env)
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
+	/* data must be an array of u64 so data_len must be a multiple of 8 */
+	if (data_len_reg->var_off.value & 7)
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
+	err = bpf_printf_preamble(fmt, UINT_MAX, NULL, NULL, NULL, num_args);
+	if (err < 0)
+		verbose(env, "Invalid format string\n");
+
+	return err;
+}
+
 static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			     int *insn_idx_p)
 {
@@ -5843,6 +5878,12 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
index 0fdca94a3c9c..15cbc8b63206 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1230,6 +1230,56 @@ const struct bpf_func_proto bpf_snprintf_btf_proto = {
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
+	if (data_len & 7 || data_len > MAX_SNPRINTF_VARARGS * 8 ||
+	    (data_len && !data))
+		return -EINVAL;
+	num_args = data_len / 8;
+
+	/* ARG_PTR_TO_CONST_STR guarantees that fmt is zero-terminated so we
+	 * can safely give an unbounded size.
+	 */
+	err = bpf_printf_preamble(fmt, UINT_MAX, data, args, mod, num_args);
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
+	if (str_size)
+		str[str_size - 1] = '\0';
+
+	bpf_printf_postamble();
+
+	return err + 1;
+}
+
+const struct bpf_func_proto bpf_snprintf_proto = {
+	.func		= bpf_snprintf,
+	.gpl_only	= true,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type	= ARG_PTR_TO_CONST_STR,
+	.arg4_type	= ARG_PTR_TO_MEM,
+	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
+};
+
 const struct bpf_func_proto *
 bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -1332,6 +1382,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_task_storage_delete_proto;
 	case BPF_FUNC_for_each_map_elem:
 		return &bpf_for_each_map_elem_proto;
+	case BPF_FUNC_snprintf:
+		return &bpf_snprintf_proto;
 	default:
 		return NULL;
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 2d3036e292a9..86af61e912c6 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4660,6 +4660,33 @@ union bpf_attr {
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
+ *		be zero-terminated.
+ *
+ *		Or **-EBUSY** if the per-CPU memory copy buffer is busy.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -4827,6 +4854,7 @@ union bpf_attr {
 	FN(sock_from_file),		\
 	FN(check_mtu),			\
 	FN(for_each_map_elem),		\
+	FN(snprintf),			\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.31.0.291.g576ba9dcdaf-goog


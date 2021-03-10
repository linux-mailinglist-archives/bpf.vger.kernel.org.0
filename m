Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52DC334ADF
	for <lists+bpf@lfdr.de>; Wed, 10 Mar 2021 23:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbhCJWDO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Mar 2021 17:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbhCJWCl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Mar 2021 17:02:41 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9787CC061765
        for <bpf@vger.kernel.org>; Wed, 10 Mar 2021 14:02:31 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id h98so24984068wrh.11
        for <bpf@vger.kernel.org>; Wed, 10 Mar 2021 14:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Es0AexKvs5+khKMtAaBpvDUkgE/LO3Ums9bZgZDut8=;
        b=nZr7K5aVtBYC5lYJXrp1mCaeM4f6aDVH5sjejYluMn2iKMdxVJ0ZrDV3FSHwZ9j5yp
         zVeJpPsfKGQHSNW15yHrDa22bWB43FBl71uC78X1dyEjoZ2vsyCrQ1dGYhkWSefj1Kpi
         T7teA09RrIAqsR4loABMgKrRz+sNW6ZmKsw1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Es0AexKvs5+khKMtAaBpvDUkgE/LO3Ums9bZgZDut8=;
        b=k64GeXxrCdCRKzNW+7D+z0RNqTlBu5LjFY2rCQBLuqmA77ofxSZC6Ye+yEAU1X3Swc
         h8PzqruSxWbTVmIFFzsj1O1/8JW1zQfMOOkPFS8i+Ozz87fe/pw6sC/wn1f+Bo+2MUtS
         RsSXnBmkUYV6hyIZVpqUk2hp4cDB/zSe0IfVg7dj9rgq5RgdYxtqGwRCe8I5ZOO4ej+h
         XNZd2Flg+ziFGyB/4SUfBG8jrkY+EUD8Tgywi91qBQCBEDuwk/S5UPF3uyMzJeO8o5PK
         6ymkM6Wh3DiI98rIj25bngKucpILmPTuaRV6V5N9hyS4doPqXmBazyugowIxEXE745cr
         Q0Vw==
X-Gm-Message-State: AOAM530JvtnRzKeuC2JjHyJ+x0ZpKTeFhFZEWRi/Dd1p0oknQEg3g4Cq
        sgrMVdkI4Z122ly++XOzhNnV/NagpLYAYQ==
X-Google-Smtp-Source: ABdhPJyITXTET0D7rYQI8CuuZCzNEGrJN21HJ/hMIAjqwpxqvoAt1MLC9ITeLE9NNHZQiEDc7mVQSQ==
X-Received: by 2002:adf:8562:: with SMTP id 89mr5576981wrh.101.1615413748820;
        Wed, 10 Mar 2021 14:02:28 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:e08c:1e90:4e6b:365a])
        by smtp.gmail.com with ESMTPSA id y16sm699234wrh.3.2021.03.10.14.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 14:02:28 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next 2/5] bpf: Add a bpf_snprintf helper
Date:   Wed, 10 Mar 2021 23:02:08 +0100
Message-Id: <20210310220211.1454516-3-revest@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210310220211.1454516-1-revest@chromium.org>
References: <20210310220211.1454516-1-revest@chromium.org>
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
 include/linux/bpf.h            |   4 +
 include/uapi/linux/bpf.h       |  28 +++++++
 kernel/bpf/verifier.c          | 137 +++++++++++++++++++++++++++++++++
 kernel/trace/bpf_trace.c       | 110 ++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  28 +++++++
 5 files changed, 307 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7b5319d75b3e..d78175c9a887 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1902,6 +1902,10 @@ extern const struct bpf_func_proto bpf_task_storage_get_proto;
 extern const struct bpf_func_proto bpf_task_storage_delete_proto;
 extern const struct bpf_func_proto bpf_for_each_map_elem_proto;
 
+#define MAX_SNPRINTF_VARARGS		12
+#define MAX_SNPRINTF_MEMCPY		6
+#define MAX_SNPRINTF_STR_LEN		128
+
 const struct bpf_func_proto *bpf_tracing_func_proto(
 	enum bpf_func_id func_id, const struct bpf_prog *prog);
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 2d3036e292a9..3cbdc8ae00e7 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4660,6 +4660,33 @@ union bpf_attr {
  *	Return
  *		The number of traversed map elements for success, **-EINVAL** for
  *		invalid **flags**.
+ *
+ * long bpf_snprintf(char *out, u32 out_size, const char *fmt, u64 *data, u32 data_len)
+ *	Description
+ *		Outputs a string into the **out** buffer of size **out_size**
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
+ *		The strictly positive length of the printed string, including
+ *		the trailing NUL character. If the return value is greater than
+ *		**out_size**, **out** contains a truncated string, without a
+ *		trailing NULL character.
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
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c99b2b67dc8d..3ab549df817b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5732,6 +5732,137 @@ static int check_reference_leak(struct bpf_verifier_env *env)
 	return state->acquired_refs ? -EINVAL : 0;
 }
 
+int check_bpf_snprintf_call(struct bpf_verifier_env *env,
+			    struct bpf_reg_state *regs)
+{
+	struct bpf_reg_state *fmt_reg = &regs[BPF_REG_3];
+	struct bpf_reg_state *data_len_reg = &regs[BPF_REG_5];
+	struct bpf_map *fmt_map = fmt_reg->map_ptr;
+	int err, fmt_map_off, i, fmt_cnt = 0, memcpy_cnt = 0, num_args;
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
+	fmt = (char *)fmt_addr;
+
+	/* We are also guaranteed that fmt+fmt_map_off is NULL terminated, we
+	 * can focus on validating the format specifiers.
+	 */
+	for (i = fmt_map_off; fmt[i] != '\0'; i++) {
+		if ((!isprint(fmt[i]) && !isspace(fmt[i])) ||
+		    !isascii(fmt[i])) {
+			verbose(env, "only printable ascii for now\n");
+			return -EINVAL;
+		}
+
+		if (fmt[i] != '%')
+			continue;
+
+		if (fmt[i + 1] == '%') {
+			i++;
+			continue;
+		}
+
+		if (fmt_cnt >= MAX_SNPRINTF_VARARGS) {
+			verbose(env, "too many format specifiers\n");
+			return -E2BIG;
+		}
+
+		if (fmt_cnt >= num_args) {
+			verbose(env, "not enough parameters to print\n");
+			return -EINVAL;
+		}
+
+		/* fmt[i] != 0 && fmt[last] == 0, so we can access fmt[i + 1] */
+		i++;
+
+		/* skip optional "[0 +-][num]" width formating field */
+		while (fmt[i] == '0' || fmt[i] == '+'  || fmt[i] == '-' ||
+		       fmt[i] == ' ')
+			i++;
+		if (fmt[i] >= '1' && fmt[i] <= '9') {
+			i++;
+			while (fmt[i] >= '0' && fmt[i] <= '9')
+				i++;
+		}
+
+		if (fmt[i] == 's') {
+			if (memcpy_cnt >= MAX_SNPRINTF_MEMCPY) {
+				verbose(env, "too many buffer copies\n");
+				return -E2BIG;
+			}
+
+			fmt_cnt++;
+			memcpy_cnt++;
+			continue;
+		}
+
+		if (fmt[i] == 'p') {
+			if (fmt[i + 1] == 0 ||  fmt[i + 1] == 'K' ||
+			    fmt[i + 1] == 'x' || fmt[i + 1] == 'B' ||
+			    fmt[i + 1] == 's' || fmt[i + 1] == 'S') {
+				fmt_cnt++;
+				continue;
+			}
+
+			/* only support "%pI4", "%pi4", "%pI6" and "%pi6". */
+			if (fmt[i + 1] != 'i' && fmt[i + 1] != 'I') {
+				verbose(env, "invalid specifier %%p%c\n",
+					fmt[i+1]);
+				return -EINVAL;
+			}
+			if (fmt[i + 2] != '4' && fmt[i + 2] != '6') {
+				verbose(env, "invalid specifier %%p%c%c\n",
+					fmt[i+1], fmt[i+2]);
+				return -EINVAL;
+			}
+
+			if (memcpy_cnt >= MAX_SNPRINTF_MEMCPY) {
+				verbose(env, "too many buffer copies\n");
+				return -E2BIG;
+			}
+
+			i += 2;
+			fmt_cnt++;
+			memcpy_cnt++;
+			continue;
+		}
+
+		if (fmt[i] == 'l') {
+			i++;
+			if (fmt[i] == 'l')
+				i++;
+		}
+
+		if (fmt[i] != 'i' && fmt[i] != 'd' && fmt[i] != 'u' &&
+		    fmt[i] != 'x' && fmt[i] != 'X') {
+			verbose(env, "invalid format specifier %%%c\n", fmt[i]);
+			return -EINVAL;
+		}
+
+		fmt_cnt++;
+	}
+
+	if (fmt_cnt != num_args) {
+		verbose(env, "too many parameters to print\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			     int *insn_idx_p)
 {
@@ -5846,6 +5977,12 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
index 0d23755c2747..7b80759c10a9 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1271,6 +1271,114 @@ const struct bpf_func_proto bpf_snprintf_btf_proto = {
 	.arg5_type	= ARG_ANYTHING,
 };
 
+struct bpf_snprintf_buf {
+	char buf[MAX_SNPRINTF_MEMCPY][MAX_SNPRINTF_STR_LEN];
+};
+static DEFINE_PER_CPU(struct bpf_snprintf_buf, bpf_snprintf_buf);
+static DEFINE_PER_CPU(int, bpf_snprintf_buf_used);
+
+BPF_CALL_5(bpf_snprintf, char *, out, u32, out_size, char *, fmt, u64 *, args,
+	   u32, args_len)
+{
+	int err, i, buf_used, copy_size, fmt_cnt = 0, memcpy_cnt = 0;
+	u64 params[MAX_SNPRINTF_VARARGS];
+	struct bpf_snprintf_buf *bufs;
+
+	buf_used = this_cpu_inc_return(bpf_snprintf_buf_used);
+	if (WARN_ON_ONCE(buf_used > 1)) {
+		err = -EBUSY;
+		goto out;
+	}
+
+	bufs = this_cpu_ptr(&bpf_snprintf_buf);
+
+	/*
+	 * The verifier has already done most of the heavy-work for us in
+	 * check_bpf_snprintf_call. We know that fmt is well formatted and that
+	 * args_len is valid. The only task left is to convert some of the
+	 * arguments. For the %s and %pi* specifiers, we need to read buffers
+	 * from a kernel address during the helper call.
+	 */
+	for (i = 0; fmt[i] != '\0'; i++) {
+		if (fmt[i] != '%')
+			continue;
+
+		if (fmt[i + 1] == '%') {
+			i++;
+			continue;
+		}
+
+		/* fmt[i] != 0 && fmt[last] == 0, so we can access fmt[i + 1] */
+		i++;
+
+		/* skip optional "[0 +-][num]" width formating field */
+		while (fmt[i] == '0' || fmt[i] == '+'  || fmt[i] == '-' ||
+		       fmt[i] == ' ')
+			i++;
+		if (fmt[i] >= '1' && fmt[i] <= '9') {
+			i++;
+			while (fmt[i] >= '0' && fmt[i] <= '9')
+				i++;
+		}
+
+		if (fmt[i] == 's') {
+			void *unsafe_ptr = (void *)(long)args[fmt_cnt];
+
+			err = strncpy_from_kernel_nofault(bufs->buf[memcpy_cnt],
+							  unsafe_ptr,
+							  MAX_SNPRINTF_STR_LEN);
+			if (err < 0)
+				bufs->buf[memcpy_cnt][0] = '\0';
+			params[fmt_cnt] = (u64)(long)bufs->buf[memcpy_cnt];
+
+			fmt_cnt++;
+			memcpy_cnt++;
+			continue;
+		}
+
+		if (fmt[i] == 'p' && (fmt[i + 1] == 'i' || fmt[i + 1] == 'I')) {
+			copy_size = (fmt[i + 2] == '4') ? 4 : 16;
+
+			err = copy_from_kernel_nofault(bufs->buf[memcpy_cnt],
+						(void *) (long) args[fmt_cnt],
+						copy_size);
+			if (err < 0)
+				memset(bufs->buf[memcpy_cnt], 0, copy_size);
+			params[fmt_cnt] = (u64)(long)bufs->buf[memcpy_cnt];
+
+			i += 2;
+			fmt_cnt++;
+			memcpy_cnt++;
+			continue;
+		}
+
+		params[fmt_cnt] = args[fmt_cnt];
+		fmt_cnt++;
+	}
+
+	/* Maximumly we can have MAX_SNPRINTF_VARARGS parameters, just give
+	 * all of them to snprintf().
+	 */
+	err = snprintf(out, out_size, fmt, params[0], params[1], params[2],
+		       params[3], params[4], params[5], params[6], params[7],
+		       params[8], params[9], params[10], params[11]) + 1;
+
+out:
+	this_cpu_dec(bpf_snprintf_buf_used);
+	return err;
+}
+
+static const struct bpf_func_proto bpf_snprintf_proto = {
+	.func		= bpf_snprintf,
+	.gpl_only	= true,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_CONST_SIZE,
+	.arg3_type	= ARG_PTR_TO_CONST_STR,
+	.arg4_type	= ARG_PTR_TO_MEM,
+	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
+};
+
 const struct bpf_func_proto *
 bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -1373,6 +1481,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_task_storage_delete_proto;
 	case BPF_FUNC_for_each_map_elem:
 		return &bpf_for_each_map_elem_proto;
+	case BPF_FUNC_snprintf:
+		return &bpf_snprintf_proto;
 	default:
 		return NULL;
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 2d3036e292a9..3cbdc8ae00e7 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4660,6 +4660,33 @@ union bpf_attr {
  *	Return
  *		The number of traversed map elements for success, **-EINVAL** for
  *		invalid **flags**.
+ *
+ * long bpf_snprintf(char *out, u32 out_size, const char *fmt, u64 *data, u32 data_len)
+ *	Description
+ *		Outputs a string into the **out** buffer of size **out_size**
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
+ *		The strictly positive length of the printed string, including
+ *		the trailing NUL character. If the return value is greater than
+ *		**out_size**, **out** contains a truncated string, without a
+ *		trailing NULL character.
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
2.30.1.766.gb4fecdf3b7-goog


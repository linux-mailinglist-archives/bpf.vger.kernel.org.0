Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8761E35CA2E
	for <lists+bpf@lfdr.de>; Mon, 12 Apr 2021 17:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243078AbhDLPi2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Apr 2021 11:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243133AbhDLPiW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Apr 2021 11:38:22 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D602DC06138D
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 08:38:02 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x7so13394080wrw.10
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 08:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CuzQ/6A2N5ZM/MLeCczyCzdZJ2gUp3DLKaA8Zo0z3tA=;
        b=hcBxdGm8hyc/c1oVz2NkKIF8nVsBm1kIQYzGpprm+NGk9W0Ir67ZpiNG8y/8RqHQrS
         ST7++vY/dndbq666+yIFBm8O/K84ZzrOmKA+3BY+RqDDoBpNsK0FP34nzFgohSUT40za
         SM/mdcygfICMxSNYrU/mVzZoqtvMFbdtjZ0Qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CuzQ/6A2N5ZM/MLeCczyCzdZJ2gUp3DLKaA8Zo0z3tA=;
        b=Fw0cZAqtDTG3DJGYQU+3CwajPf+eM8RRb9MRcY1G1Hqc+cGsUQyo/XbDulZf6QcjG9
         61Cb4h3RvhM6bhPR6hlpPRSmMg08RmGJcx3Yy+YqisnAWpt2o5ZcCnl4h9AuA5SwYGM3
         ai90PtOctgcheAqDso9kopxzhimUj4iNHF+jBPCUk1DIgQBdrMxRvM2eQPFoqtSDDM5x
         UxfDaX1MkIOdbJnScCLtGJRgMf3qcKsUGEF1UByAJTVHJFV37kki/hiBb8SJr1lztg1v
         WN+UeuslkOwkrWYXMPjuRPMGhnRaFLldeauy2Aswh4Z5ihsV3cg5mV3x0lbAdgSSoXYu
         cXZw==
X-Gm-Message-State: AOAM5328+gUFtDePTs5Q6bBwkmobvpNBTpU8Gb2GCEH0uKDP68Hyrk3r
        Jlqu5UD7BrgT2eUiBNaIXI/W8jCGHdQp5A==
X-Google-Smtp-Source: ABdhPJyTOUz9/7GEZxMSMI/Djq62oxjg3nFP32lEwvKPgiQSNam5oyaaOPxlKb5j5cdUW5V9XvW2Fg==
X-Received: by 2002:adf:e647:: with SMTP id b7mr22413216wrn.43.1618241881068;
        Mon, 12 Apr 2021 08:38:01 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:a372:3c3b:eeb:ad14])
        by smtp.gmail.com with ESMTPSA id i4sm2501449wrx.56.2021.04.12.08.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 08:38:00 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v3 1/6] bpf: Factorize bpf_trace_printk and bpf_seq_printf
Date:   Mon, 12 Apr 2021 17:37:49 +0200
Message-Id: <20210412153754.235500-2-revest@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210412153754.235500-1-revest@chromium.org>
References: <20210412153754.235500-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Two helpers (trace_printk and seq_printf) have very similar
implementations of format string parsing and a third one is coming
(snprintf). To avoid code duplication and make the code easier to
maintain, this moves the operations associated with format string
parsing (validation and argument sanitization) into one generic
function.

The implementation of the two existing helpers already drifted quite a
bit so unifying them entailed a lot of changes:

- bpf_trace_printk always expected fmt[fmt_size] to be the terminating
  NULL character, this is no longer true, the first 0 is terminating.
- bpf_trace_printk now supports %% (which produces the percentage char).
- bpf_trace_printk now skips width formating fields.
- bpf_trace_printk now supports the X modifier (capital hexadecimal).
- bpf_trace_printk now supports %pK, %px, %pB, %pi4, %pI4, %pi6 and %pI6
- argument casting on 32 bit has been simplified into one macro and
  using an enum instead of obscure int increments.

- bpf_seq_printf now uses bpf_trace_copy_string instead of
  strncpy_from_kernel_nofault and handles the %pks %pus specifiers.
- bpf_seq_printf now prints longs correctly on 32 bit architectures.

- both were changed to use a global per-cpu tmp buffer instead of one
  stack buffer for trace_printk and 6 small buffers for seq_printf.
- to avoid per-cpu buffer usage conflict, these helpers disable
  preemption while the per-cpu buffer is in use.
- both helpers now support the %ps and %pS specifiers to print symbols.

Signed-off-by: Florent Revest <revest@chromium.org>
---
 kernel/trace/bpf_trace.c | 529 ++++++++++++++++++---------------------
 1 file changed, 248 insertions(+), 281 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0d23755c2747..3ce9aeee6681 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -372,7 +372,7 @@ static const struct bpf_func_proto *bpf_get_probe_write_proto(void)
 	return &bpf_probe_write_user_proto;
 }
 
-static void bpf_trace_copy_string(char *buf, void *unsafe_ptr, char fmt_ptype,
+static int bpf_trace_copy_string(char *buf, void *unsafe_ptr, char fmt_ptype,
 		size_t bufsz)
 {
 	void __user *user_ptr = (__force void __user *)unsafe_ptr;
@@ -382,178 +382,292 @@ static void bpf_trace_copy_string(char *buf, void *unsafe_ptr, char fmt_ptype,
 	switch (fmt_ptype) {
 	case 's':
 #ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
-		if ((unsigned long)unsafe_ptr < TASK_SIZE) {
-			strncpy_from_user_nofault(buf, user_ptr, bufsz);
-			break;
-		}
+		if ((unsigned long)unsafe_ptr < TASK_SIZE)
+			return strncpy_from_user_nofault(buf, user_ptr, bufsz);
 		fallthrough;
 #endif
 	case 'k':
-		strncpy_from_kernel_nofault(buf, unsafe_ptr, bufsz);
-		break;
+		return strncpy_from_kernel_nofault(buf, unsafe_ptr, bufsz);
 	case 'u':
-		strncpy_from_user_nofault(buf, user_ptr, bufsz);
-		break;
+		return strncpy_from_user_nofault(buf, user_ptr, bufsz);
 	}
+
+	return -EINVAL;
 }
 
 static DEFINE_RAW_SPINLOCK(trace_printk_lock);
 
-#define BPF_TRACE_PRINTK_SIZE   1024
+enum bpf_printf_mod_type {
+	BPF_PRINTF_INT,
+	BPF_PRINTF_LONG,
+	BPF_PRINTF_LONG_LONG,
+};
+
+/* Workaround for getting va_list handling working with different argument type
+ * combinations generically for 32 and 64 bit archs.
+ */
+#define BPF_CAST_FMT_ARG(arg_nb, args, mod)				\
+	(mod[arg_nb] == BPF_PRINTF_LONG_LONG ||				\
+	 (mod[arg_nb] == BPF_PRINTF_LONG && __BITS_PER_LONG == 64)	\
+	  ? (u64)args[arg_nb]						\
+	  : (u32)args[arg_nb])
 
-static __printf(1, 0) int bpf_do_trace_printk(const char *fmt, ...)
+/* Per-cpu temp buffers which can be used by printf-like helpers for %s or %p
+ */
+#define MAX_PRINTF_BUF_LEN	512
+
+struct bpf_printf_buf {
+	char tmp_buf[MAX_PRINTF_BUF_LEN];
+};
+static DEFINE_PER_CPU(struct bpf_printf_buf, bpf_printf_buf);
+static DEFINE_PER_CPU(int, bpf_printf_buf_used);
+
+static int try_get_fmt_tmp_buf(char **tmp_buf)
 {
-	static char buf[BPF_TRACE_PRINTK_SIZE];
-	unsigned long flags;
-	va_list ap;
-	int ret;
+	struct bpf_printf_buf *bufs = this_cpu_ptr(&bpf_printf_buf);
+	int used;
 
-	raw_spin_lock_irqsave(&trace_printk_lock, flags);
-	va_start(ap, fmt);
-	ret = vsnprintf(buf, sizeof(buf), fmt, ap);
-	va_end(ap);
-	/* vsnprintf() will not append null for zero-length strings */
-	if (ret == 0)
-		buf[0] = '\0';
-	trace_bpf_trace_printk(buf);
-	raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
+	if (*tmp_buf)
+		return 0;
 
-	return ret;
+	preempt_disable();
+	used = this_cpu_inc_return(bpf_printf_buf_used);
+	if (WARN_ON_ONCE(used > 1)) {
+		this_cpu_dec(bpf_printf_buf_used);
+		return -EBUSY;
+	}
+	*tmp_buf = bufs->tmp_buf;
+
+	return 0;
+}
+
+static void put_fmt_tmp_buf(void)
+{
+	if (this_cpu_read(bpf_printf_buf_used)) {
+		this_cpu_dec(bpf_printf_buf_used);
+		preempt_enable();
+	}
 }
 
 /*
- * Only limited trace_printk() conversion specifiers allowed:
- * %d %i %u %x %ld %li %lu %lx %lld %lli %llu %llx %p %pB %pks %pus %s
+ * bpf_parse_fmt_str - Generic pass on format strings for printf-like helpers
+ *
+ * Returns a negative value if fmt is an invalid format string or 0 otherwise.
+ *
+ * This can be used in two ways:
+ * - Format string verification only: when final_args and mod are NULL
+ * - Arguments preparation: in addition to the above verification, it writes in
+ *   final_args a copy of raw_args where pointers from BPF have been sanitized
+ *   into pointers safe to use by snprintf. This also writes in the mod array
+ *   the size requirement of each argument, usable by BPF_CAST_FMT_ARG for ex.
+ *
+ * In argument preparation mode, if 0 is returned, safe temporary buffers are
+ * allocated and put_fmt_tmp_buf should be called to free them after use.
  */
-BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
-	   u64, arg2, u64, arg3)
-{
-	int i, mod[3] = {}, fmt_cnt = 0;
-	char buf[64], fmt_ptype;
-	void *unsafe_ptr = NULL;
-	bool str_seen = false;
+int bpf_printf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
+			u64 *final_args, enum bpf_printf_mod_type *mod,
+			u32 num_args)
+{
+	int err, i, curr_specifier = 0, copy_size;
+	char *unsafe_ptr = NULL, *tmp_buf = NULL;
+	size_t tmp_buf_len = MAX_PRINTF_BUF_LEN;
+	enum bpf_printf_mod_type current_mod;
+	u64 current_arg;
+	char fmt_ptype;
+
+	if ((final_args && !mod) || (mod && !final_args))
+		return -EINVAL;
 
-	/*
-	 * bpf_check()->check_func_arg()->check_stack_boundary()
-	 * guarantees that fmt points to bpf program stack,
-	 * fmt_size bytes of it were initialized and fmt_size > 0
-	 */
-	if (fmt[--fmt_size] != 0)
+	fmt_size = (strnchr(fmt, fmt_size, 0) - fmt);
+	if (!fmt_size)
 		return -EINVAL;
 
-	/* check format string for allowed specifiers */
 	for (i = 0; i < fmt_size; i++) {
-		if ((!isprint(fmt[i]) && !isspace(fmt[i])) || !isascii(fmt[i]))
-			return -EINVAL;
+		if ((!isprint(fmt[i]) && !isspace(fmt[i])) || !isascii(fmt[i])) {
+			err = -EINVAL;
+			goto out;
+		}
 
 		if (fmt[i] != '%')
 			continue;
 
-		if (fmt_cnt >= 3)
-			return -EINVAL;
+		if (fmt[i + 1] == '%') {
+			i++;
+			continue;
+		}
+
+		if (curr_specifier >= num_args) {
+			err = -EINVAL;
+			goto out;
+		}
 
 		/* fmt[i] != 0 && fmt[last] == 0, so we can access fmt[i + 1] */
 		i++;
-		if (fmt[i] == 'l') {
-			mod[fmt_cnt]++;
+
+		/* skip optional "[0 +-][num]" width formatting field */
+		while (fmt[i] == '0' || fmt[i] == '+'  || fmt[i] == '-' ||
+		       fmt[i] == ' ')
 			i++;
-		} else if (fmt[i] == 'p') {
-			mod[fmt_cnt]++;
-			if ((fmt[i + 1] == 'k' ||
-			     fmt[i + 1] == 'u') &&
+		if (fmt[i] >= '1' && fmt[i] <= '9') {
+			i++;
+			while (fmt[i] >= '0' && fmt[i] <= '9')
+				i++;
+		}
+
+		if (fmt[i] == 'p') {
+			current_mod = BPF_PRINTF_LONG;
+
+			if ((fmt[i + 1] == 'k' || fmt[i + 1] == 'u') &&
 			    fmt[i + 2] == 's') {
 				fmt_ptype = fmt[i + 1];
 				i += 2;
 				goto fmt_str;
 			}
 
-			if (fmt[i + 1] == 'B') {
-				i++;
+			if (fmt[i + 1] == 0 || isspace(fmt[i + 1]) ||
+			    ispunct(fmt[i + 1]) || fmt[i + 1] == 'K' ||
+			    fmt[i + 1] == 'x' || fmt[i + 1] == 'B' ||
+			    fmt[i + 1] == 's' || fmt[i + 1] == 'S') {
+				/* just kernel pointers */
+				if (final_args)
+					current_arg = raw_args[curr_specifier];
 				goto fmt_next;
 			}
 
-			/* disallow any further format extensions */
-			if (fmt[i + 1] != 0 &&
-			    !isspace(fmt[i + 1]) &&
-			    !ispunct(fmt[i + 1]))
-				return -EINVAL;
+			/* only support "%pI4", "%pi4", "%pI6" and "%pi6". */
+			if ((fmt[i + 1] != 'i' && fmt[i + 1] != 'I') ||
+			    (fmt[i + 2] != '4' && fmt[i + 2] != '6')) {
+				err = -EINVAL;
+				goto out;
+			}
+
+			i += 2;
+			if (!final_args)
+				goto fmt_next;
+
+			if (try_get_fmt_tmp_buf(&tmp_buf)) {
+				err = -EBUSY;
+				goto out;
+			}
+
+			copy_size = (fmt[i + 2] == '4') ? 4 : 16;
+			if (tmp_buf_len < copy_size) {
+				err = -ENOSPC;
+				goto out;
+			}
+
+			unsafe_ptr = (char *)(long)raw_args[curr_specifier];
+			err = copy_from_kernel_nofault(tmp_buf, unsafe_ptr,
+						       copy_size);
+			if (err < 0)
+				memset(tmp_buf, 0, copy_size);
+			current_arg = (u64)(long)tmp_buf;
+			tmp_buf += copy_size;
+			tmp_buf_len -= copy_size;
 
 			goto fmt_next;
 		} else if (fmt[i] == 's') {
-			mod[fmt_cnt]++;
+			current_mod = BPF_PRINTF_LONG;
 			fmt_ptype = fmt[i];
 fmt_str:
-			if (str_seen)
-				/* allow only one '%s' per fmt string */
-				return -EINVAL;
-			str_seen = true;
-
 			if (fmt[i + 1] != 0 &&
 			    !isspace(fmt[i + 1]) &&
-			    !ispunct(fmt[i + 1]))
-				return -EINVAL;
+			    !ispunct(fmt[i + 1])) {
+				err = -EINVAL;
+				goto out;
+			}
 
-			switch (fmt_cnt) {
-			case 0:
-				unsafe_ptr = (void *)(long)arg1;
-				arg1 = (long)buf;
-				break;
-			case 1:
-				unsafe_ptr = (void *)(long)arg2;
-				arg2 = (long)buf;
-				break;
-			case 2:
-				unsafe_ptr = (void *)(long)arg3;
-				arg3 = (long)buf;
-				break;
+			if (!final_args)
+				goto fmt_next;
+
+			if (try_get_fmt_tmp_buf(&tmp_buf)) {
+				err = -EBUSY;
+				goto out;
+			}
+
+			if (!tmp_buf_len) {
+				err = -ENOSPC;
+				goto out;
 			}
 
-			bpf_trace_copy_string(buf, unsafe_ptr, fmt_ptype,
-					sizeof(buf));
+			unsafe_ptr = (char *)(long)raw_args[curr_specifier];
+			err = bpf_trace_copy_string(tmp_buf, unsafe_ptr,
+						    fmt_ptype, tmp_buf_len);
+			if (err < 0) {
+				tmp_buf[0] = '\0';
+				err = 1;
+			}
+
+			current_arg = (u64)(long)tmp_buf;
+			tmp_buf += err;
+			tmp_buf_len -= err;
+
 			goto fmt_next;
 		}
 
+		current_mod = BPF_PRINTF_INT;
+
+		if (fmt[i] == 'l') {
+			current_mod = BPF_PRINTF_LONG;
+			i++;
+		}
 		if (fmt[i] == 'l') {
-			mod[fmt_cnt]++;
+			current_mod = BPF_PRINTF_LONG_LONG;
 			i++;
 		}
 
-		if (fmt[i] != 'i' && fmt[i] != 'd' &&
-		    fmt[i] != 'u' && fmt[i] != 'x')
-			return -EINVAL;
+		if (fmt[i] != 'i' && fmt[i] != 'd' && fmt[i] != 'u' &&
+		    fmt[i] != 'x' && fmt[i] != 'X') {
+			err = -EINVAL;
+			goto out;
+		}
+
+		if (final_args)
+			current_arg = raw_args[curr_specifier];
 fmt_next:
-		fmt_cnt++;
+		if (final_args) {
+			mod[curr_specifier] = current_mod;
+			final_args[curr_specifier] = current_arg;
+		}
+		curr_specifier++;
 	}
 
-/* Horrid workaround for getting va_list handling working with different
- * argument type combinations generically for 32 and 64 bit archs.
- */
-#define __BPF_TP_EMIT()	__BPF_ARG3_TP()
-#define __BPF_TP(...)							\
-	bpf_do_trace_printk(fmt, ##__VA_ARGS__)
-
-#define __BPF_ARG1_TP(...)						\
-	((mod[0] == 2 || (mod[0] == 1 && __BITS_PER_LONG == 64))	\
-	  ? __BPF_TP(arg1, ##__VA_ARGS__)				\
-	  : ((mod[0] == 1 || (mod[0] == 0 && __BITS_PER_LONG == 32))	\
-	      ? __BPF_TP((long)arg1, ##__VA_ARGS__)			\
-	      : __BPF_TP((u32)arg1, ##__VA_ARGS__)))
-
-#define __BPF_ARG2_TP(...)						\
-	((mod[1] == 2 || (mod[1] == 1 && __BITS_PER_LONG == 64))	\
-	  ? __BPF_ARG1_TP(arg2, ##__VA_ARGS__)				\
-	  : ((mod[1] == 1 || (mod[1] == 0 && __BITS_PER_LONG == 32))	\
-	      ? __BPF_ARG1_TP((long)arg2, ##__VA_ARGS__)		\
-	      : __BPF_ARG1_TP((u32)arg2, ##__VA_ARGS__)))
-
-#define __BPF_ARG3_TP(...)						\
-	((mod[2] == 2 || (mod[2] == 1 && __BITS_PER_LONG == 64))	\
-	  ? __BPF_ARG2_TP(arg3, ##__VA_ARGS__)				\
-	  : ((mod[2] == 1 || (mod[2] == 0 && __BITS_PER_LONG == 32))	\
-	      ? __BPF_ARG2_TP((long)arg3, ##__VA_ARGS__)		\
-	      : __BPF_ARG2_TP((u32)arg3, ##__VA_ARGS__)))
-
-	return __BPF_TP_EMIT();
+	err = 0;
+out:
+	put_fmt_tmp_buf();
+	return err;
+}
+
+#define MAX_TRACE_PRINTK_VARARGS	3
+#define BPF_TRACE_PRINTK_SIZE		1024
+
+BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
+	   u64, arg2, u64, arg3)
+{
+	u64 args[MAX_TRACE_PRINTK_VARARGS] = { arg1, arg2, arg3 };
+	enum bpf_printf_mod_type mod[MAX_TRACE_PRINTK_VARARGS];
+	static char buf[BPF_TRACE_PRINTK_SIZE];
+	unsigned long flags;
+	int ret;
+
+	ret = bpf_printf_prepare(fmt, fmt_size, args, args, mod,
+				 MAX_TRACE_PRINTK_VARARGS);
+	if (ret < 0)
+		return ret;
+
+	ret = snprintf(buf, sizeof(buf), fmt, BPF_CAST_FMT_ARG(0, args, mod),
+		BPF_CAST_FMT_ARG(1, args, mod), BPF_CAST_FMT_ARG(2, args, mod));
+	/* snprintf() will not append null for zero-length strings */
+	if (ret == 0)
+		buf[0] = '\0';
+
+	raw_spin_lock_irqsave(&trace_printk_lock, flags);
+	trace_bpf_trace_printk(buf);
+	raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
+
+	put_fmt_tmp_buf();
+
+	return ret;
 }
 
 static const struct bpf_func_proto bpf_trace_printk_proto = {
@@ -581,184 +695,37 @@ const struct bpf_func_proto *bpf_get_trace_printk_proto(void)
 }
 
 #define MAX_SEQ_PRINTF_VARARGS		12
-#define MAX_SEQ_PRINTF_MAX_MEMCPY	6
-#define MAX_SEQ_PRINTF_STR_LEN		128
-
-struct bpf_seq_printf_buf {
-	char buf[MAX_SEQ_PRINTF_MAX_MEMCPY][MAX_SEQ_PRINTF_STR_LEN];
-};
-static DEFINE_PER_CPU(struct bpf_seq_printf_buf, bpf_seq_printf_buf);
-static DEFINE_PER_CPU(int, bpf_seq_printf_buf_used);
 
 BPF_CALL_5(bpf_seq_printf, struct seq_file *, m, char *, fmt, u32, fmt_size,
 	   const void *, data, u32, data_len)
 {
-	int err = -EINVAL, fmt_cnt = 0, memcpy_cnt = 0;
-	int i, buf_used, copy_size, num_args;
-	u64 params[MAX_SEQ_PRINTF_VARARGS];
-	struct bpf_seq_printf_buf *bufs;
-	const u64 *args = data;
-
-	buf_used = this_cpu_inc_return(bpf_seq_printf_buf_used);
-	if (WARN_ON_ONCE(buf_used > 1)) {
-		err = -EBUSY;
-		goto out;
-	}
-
-	bufs = this_cpu_ptr(&bpf_seq_printf_buf);
-
-	/*
-	 * bpf_check()->check_func_arg()->check_stack_boundary()
-	 * guarantees that fmt points to bpf program stack,
-	 * fmt_size bytes of it were initialized and fmt_size > 0
-	 */
-	if (fmt[--fmt_size] != 0)
-		goto out;
-
-	if (data_len & 7)
-		goto out;
-
-	for (i = 0; i < fmt_size; i++) {
-		if (fmt[i] == '%') {
-			if (fmt[i + 1] == '%')
-				i++;
-			else if (!data || !data_len)
-				goto out;
-		}
-	}
+	enum bpf_printf_mod_type mod[MAX_SEQ_PRINTF_VARARGS];
+	u64 args[MAX_SEQ_PRINTF_VARARGS];
+	int err, num_args;
 
+	if (data_len & 7 || data_len > MAX_SEQ_PRINTF_VARARGS * 8 ||
+	    (data_len && !data))
+		return -EINVAL;
 	num_args = data_len / 8;
 
-	/* check format string for allowed specifiers */
-	for (i = 0; i < fmt_size; i++) {
-		/* only printable ascii for now. */
-		if ((!isprint(fmt[i]) && !isspace(fmt[i])) || !isascii(fmt[i])) {
-			err = -EINVAL;
-			goto out;
-		}
-
-		if (fmt[i] != '%')
-			continue;
-
-		if (fmt[i + 1] == '%') {
-			i++;
-			continue;
-		}
-
-		if (fmt_cnt >= MAX_SEQ_PRINTF_VARARGS) {
-			err = -E2BIG;
-			goto out;
-		}
-
-		if (fmt_cnt >= num_args) {
-			err = -EINVAL;
-			goto out;
-		}
-
-		/* fmt[i] != 0 && fmt[last] == 0, so we can access fmt[i + 1] */
-		i++;
-
-		/* skip optional "[0 +-][num]" width formating field */
-		while (fmt[i] == '0' || fmt[i] == '+'  || fmt[i] == '-' ||
-		       fmt[i] == ' ')
-			i++;
-		if (fmt[i] >= '1' && fmt[i] <= '9') {
-			i++;
-			while (fmt[i] >= '0' && fmt[i] <= '9')
-				i++;
-		}
-
-		if (fmt[i] == 's') {
-			void *unsafe_ptr;
-
-			/* try our best to copy */
-			if (memcpy_cnt >= MAX_SEQ_PRINTF_MAX_MEMCPY) {
-				err = -E2BIG;
-				goto out;
-			}
-
-			unsafe_ptr = (void *)(long)args[fmt_cnt];
-			err = strncpy_from_kernel_nofault(bufs->buf[memcpy_cnt],
-					unsafe_ptr, MAX_SEQ_PRINTF_STR_LEN);
-			if (err < 0)
-				bufs->buf[memcpy_cnt][0] = '\0';
-			params[fmt_cnt] = (u64)(long)bufs->buf[memcpy_cnt];
-
-			fmt_cnt++;
-			memcpy_cnt++;
-			continue;
-		}
-
-		if (fmt[i] == 'p') {
-			if (fmt[i + 1] == 0 ||
-			    fmt[i + 1] == 'K' ||
-			    fmt[i + 1] == 'x' ||
-			    fmt[i + 1] == 'B') {
-				/* just kernel pointers */
-				params[fmt_cnt] = args[fmt_cnt];
-				fmt_cnt++;
-				continue;
-			}
-
-			/* only support "%pI4", "%pi4", "%pI6" and "%pi6". */
-			if (fmt[i + 1] != 'i' && fmt[i + 1] != 'I') {
-				err = -EINVAL;
-				goto out;
-			}
-			if (fmt[i + 2] != '4' && fmt[i + 2] != '6') {
-				err = -EINVAL;
-				goto out;
-			}
-
-			if (memcpy_cnt >= MAX_SEQ_PRINTF_MAX_MEMCPY) {
-				err = -E2BIG;
-				goto out;
-			}
-
-
-			copy_size = (fmt[i + 2] == '4') ? 4 : 16;
-
-			err = copy_from_kernel_nofault(bufs->buf[memcpy_cnt],
-						(void *) (long) args[fmt_cnt],
-						copy_size);
-			if (err < 0)
-				memset(bufs->buf[memcpy_cnt], 0, copy_size);
-			params[fmt_cnt] = (u64)(long)bufs->buf[memcpy_cnt];
-
-			i += 2;
-			fmt_cnt++;
-			memcpy_cnt++;
-			continue;
-		}
-
-		if (fmt[i] == 'l') {
-			i++;
-			if (fmt[i] == 'l')
-				i++;
-		}
-
-		if (fmt[i] != 'i' && fmt[i] != 'd' &&
-		    fmt[i] != 'u' && fmt[i] != 'x' &&
-		    fmt[i] != 'X') {
-			err = -EINVAL;
-			goto out;
-		}
-
-		params[fmt_cnt] = args[fmt_cnt];
-		fmt_cnt++;
-	}
+	err = bpf_printf_prepare(fmt, fmt_size, data, args, mod, num_args);
+	if (err < 0)
+		return err;
 
 	/* Maximumly we can have MAX_SEQ_PRINTF_VARARGS parameter, just give
 	 * all of them to seq_printf().
 	 */
-	seq_printf(m, fmt, params[0], params[1], params[2], params[3],
-		   params[4], params[5], params[6], params[7], params[8],
-		   params[9], params[10], params[11]);
+	seq_printf(m, fmt, BPF_CAST_FMT_ARG(0, args, mod),
+		BPF_CAST_FMT_ARG(1, args, mod), BPF_CAST_FMT_ARG(2, args, mod),
+		BPF_CAST_FMT_ARG(3, args, mod), BPF_CAST_FMT_ARG(4, args, mod),
+		BPF_CAST_FMT_ARG(5, args, mod), BPF_CAST_FMT_ARG(6, args, mod),
+		BPF_CAST_FMT_ARG(7, args, mod), BPF_CAST_FMT_ARG(8, args, mod),
+		BPF_CAST_FMT_ARG(9, args, mod), BPF_CAST_FMT_ARG(10, args, mod),
+		BPF_CAST_FMT_ARG(11, args, mod));
 
-	err = seq_has_overflowed(m) ? -EOVERFLOW : 0;
-out:
-	this_cpu_dec(bpf_seq_printf_buf_used);
-	return err;
+	put_fmt_tmp_buf();
+
+	return seq_has_overflowed(m) ? -EOVERFLOW : 0;
 }
 
 BTF_ID_LIST_SINGLE(btf_seq_file_ids, struct, seq_file)
-- 
2.31.1.295.g9ea45b61b8-goog


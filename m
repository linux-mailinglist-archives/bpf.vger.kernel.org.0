Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6906D346F6A
	for <lists+bpf@lfdr.de>; Wed, 24 Mar 2021 03:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbhCXCXX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Mar 2021 22:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbhCXCXI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Mar 2021 22:23:08 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A978FC061765
        for <bpf@vger.kernel.org>; Tue, 23 Mar 2021 19:23:07 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j7so22853575wrd.1
        for <bpf@vger.kernel.org>; Tue, 23 Mar 2021 19:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CDKR4mn0D+0ToAPKoj8yxVzmpuQKKpkHpHo3GgwCUgs=;
        b=iYy0ghynetPOE7s7LU8CEgPGfVBSiBYm4jCH8ctV+MXYqakX2VldRtNrv6RL6v6x8n
         qG7Iqn01pkvaY9nmTA6/vh3gs/FBZ8QOGB/fLwwO8jvNIyPtWSWH+gUlnUhGtitAdehy
         Oq+6EwLEnFlJdWvrjypNGY5/oc+2OSDen5pko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CDKR4mn0D+0ToAPKoj8yxVzmpuQKKpkHpHo3GgwCUgs=;
        b=nxWr32gcxG5mzIKr3V1RbWzjhyaQKbPDyX3D1fxg4XnuBPORMWwcoZDzIZVvHlISz9
         tE7IIIgyCvy+f2L52/LLyRUoeS3svr6v0ZPGz48empIJfhhxNXWI112HY/i/0aMELMIe
         +CG/kTORNHh7zOLKCqHeyarNTkVFYcIU4WJvl4/pzuoBZx+AsmXL5ERTRvh4uSK6qtAO
         IMFJy6FEJd3clJ1zkNsd4ymb70kBdl+39zfVd6a8LcbiFKSXcZf0rSWlDA8CAJBM5D/V
         RXEvuveLz0jk8f7ZHEtn8wsLHQ5xuLo1lTXGG1SVuc2uP9/MtRNYhl/JJVA0zTMkzJ71
         jbQQ==
X-Gm-Message-State: AOAM5328+PLtw+HwiWdHcCoVKEyj/O3Lsa9eKV9AKApa9gcSDfJ0PsK6
        vwkREQOEqJ9j0s5UoTaaFRyk4BxYLsn8NQ==
X-Google-Smtp-Source: ABdhPJzgns9bPEyyrZ9NIWlt9uSbLIDbtyIZ/6fPq6woxDCL1Qr96Ovpa7BJX1innunvfyUa924PzA==
X-Received: by 2002:adf:8b4e:: with SMTP id v14mr822758wra.103.1616552585884;
        Tue, 23 Mar 2021 19:23:05 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:ccba:9601:929c:dbcb])
        by smtp.gmail.com with ESMTPSA id n9sm74219wrx.46.2021.03.23.19.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 19:23:05 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v2 1/6] bpf: Factorize bpf_trace_printk and bpf_seq_printf
Date:   Wed, 24 Mar 2021 03:22:06 +0100
Message-Id: <20210324022211.1718762-2-revest@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210324022211.1718762-1-revest@chromium.org>
References: <20210324022211.1718762-1-revest@chromium.org>
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

Unfortunately, the implementation of the two existing helpers already
drifted quite a bit and unifying them entailed a lot of changes:

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
 1 file changed, 244 insertions(+), 285 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0d23755c2747..0fdca94a3c9c 100644
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
@@ -382,178 +382,284 @@ static void bpf_trace_copy_string(char *buf, void *unsafe_ptr, char fmt_ptype,
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
 
-static __printf(1, 0) int bpf_do_trace_printk(const char *fmt, ...)
-{
-	static char buf[BPF_TRACE_PRINTK_SIZE];
-	unsigned long flags;
-	va_list ap;
-	int ret;
+/* Horrid workaround for getting va_list handling working with different
+ * argument type combinations generically for 32 and 64 bit archs.
+ */
+#define BPF_CAST_FMT_ARG(arg_nb, args, mod)				\
+	((mod[arg_nb] == BPF_PRINTF_LONG_LONG ||			\
+	 (mod[arg_nb] == BPF_PRINTF_LONG && __BITS_PER_LONG == 64))	\
+	  ? args[arg_nb]						\
+	  : ((mod[arg_nb] == BPF_PRINTF_LONG ||				\
+	     (mod[arg_nb] == BPF_PRINTF_INT && __BITS_PER_LONG == 32))	\
+	      ? (long)args[arg_nb]					\
+	      : (u32)args[arg_nb]))
+
+/* Per-cpu temp buffers which can be used by printf-like helpers for %s or %p
+ */
+#define MAX_PRINTF_BUF_LEN	512
 
-	raw_spin_lock_irqsave(&trace_printk_lock, flags);
-	va_start(ap, fmt);
-	ret = vsnprintf(buf, sizeof(buf), fmt, ap);
-	va_end(ap);
-	/* vsnprintf() will not append null for zero-length strings */
-	if (ret == 0)
-		buf[0] = '\0';
-	trace_bpf_trace_printk(buf);
-	raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
+struct bpf_printf_buf {
+	char tmp_buf[MAX_PRINTF_BUF_LEN];
+};
+static DEFINE_PER_CPU(struct bpf_printf_buf, bpf_printf_buf);
+static DEFINE_PER_CPU(int, bpf_printf_buf_used);
 
-	return ret;
+static void bpf_printf_postamble(void)
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
+ * allocated and bpf_printf_postamble should be called to free them after use.
  */
-BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
-	   u64, arg2, u64, arg3)
-{
-	int i, mod[3] = {}, fmt_cnt = 0;
-	char buf[64], fmt_ptype;
-	void *unsafe_ptr = NULL;
-	bool str_seen = false;
-
-	/*
-	 * bpf_check()->check_func_arg()->check_stack_boundary()
-	 * guarantees that fmt points to bpf program stack,
-	 * fmt_size bytes of it were initialized and fmt_size > 0
-	 */
-	if (fmt[--fmt_size] != 0)
-		return -EINVAL;
-
-	/* check format string for allowed specifiers */
-	for (i = 0; i < fmt_size; i++) {
-		if ((!isprint(fmt[i]) && !isspace(fmt[i])) || !isascii(fmt[i]))
-			return -EINVAL;
+int bpf_printf_preamble(char *fmt, u32 fmt_size, const u64 *raw_args,
+			u64 *final_args, enum bpf_printf_mod_type *mod,
+			u32 num_args)
+{
+	struct bpf_printf_buf *bufs = this_cpu_ptr(&bpf_printf_buf);
+	int err, i, fmt_cnt = 0, copy_size, used;
+	char *unsafe_ptr = NULL, *tmp_buf = NULL;
+	bool prepare_args = final_args && mod;
+	enum bpf_printf_mod_type current_mod;
+	size_t tmp_buf_len;
+	u64 current_arg;
+	char fmt_ptype;
+
+	for (i = 0; i < fmt_size && fmt[i] != '\0'; i++) {
+		if ((!isprint(fmt[i]) && !isspace(fmt[i])) ||
+		    !isascii(fmt[i])) {
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
+		if (fmt_cnt >= num_args) {
+			err = -EINVAL;
+			goto out;
+		}
 
 		/* fmt[i] != 0 && fmt[last] == 0, so we can access fmt[i + 1] */
 		i++;
-		if (fmt[i] == 'l') {
-			mod[fmt_cnt]++;
+
+		/* skip optional "[0 +-][num]" width formating field */
+		while (fmt[i] == '0' || fmt[i] == '+'  || fmt[i] == '-' ||
+		       fmt[i] == ' ')
+			i++;
+		if (fmt[i] >= '1' && fmt[i] <= '9') {
 			i++;
-		} else if (fmt[i] == 'p') {
-			mod[fmt_cnt]++;
-			if ((fmt[i + 1] == 'k' ||
-			     fmt[i + 1] == 'u') &&
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
+				if (prepare_args)
+					current_arg = raw_args[fmt_cnt];
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
+			if (!prepare_args)
+				goto fmt_next;
+
+			if (!tmp_buf) {
+				used = this_cpu_inc_return(bpf_printf_buf_used);
+				if (WARN_ON_ONCE(used > 1)) {
+					this_cpu_dec(bpf_printf_buf_used);
+					return -EBUSY;
+				}
+				preempt_disable();
+				tmp_buf = bufs->tmp_buf;
+				tmp_buf_len = MAX_PRINTF_BUF_LEN;
+			}
+
+			copy_size = (fmt[i + 2] == '4') ? 4 : 16;
+			if (tmp_buf_len < copy_size) {
+				err = -ENOSPC;
+				goto out;
+			}
+
+			unsafe_ptr = (char *)(long)raw_args[fmt_cnt];
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
+			if (!prepare_args)
+				goto fmt_next;
+
+			if (!tmp_buf) {
+				used = this_cpu_inc_return(bpf_printf_buf_used);
+				if (WARN_ON_ONCE(used > 1)) {
+					this_cpu_dec(bpf_printf_buf_used);
+					return -EBUSY;
+				}
+				preempt_disable();
+				tmp_buf = bufs->tmp_buf;
+				tmp_buf_len = MAX_PRINTF_BUF_LEN;
+			}
+
+			if (!tmp_buf_len) {
+				err = -ENOSPC;
+				goto out;
 			}
 
-			bpf_trace_copy_string(buf, unsafe_ptr, fmt_ptype,
-					sizeof(buf));
+			unsafe_ptr = (char *)(long)raw_args[fmt_cnt];
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
 		if (fmt[i] == 'l') {
-			mod[fmt_cnt]++;
+			current_mod = BPF_PRINTF_LONG;
+			i++;
+		}
+		if (fmt[i] == 'l') {
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
+		if (prepare_args)
+			current_arg = raw_args[fmt_cnt];
 fmt_next:
+		if (prepare_args) {
+			mod[fmt_cnt] = current_mod;
+			final_args[fmt_cnt] = current_arg;
+		}
 		fmt_cnt++;
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
+	bpf_printf_postamble();
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
+	ret = bpf_printf_preamble(fmt, fmt_size, args, args, mod,
+				  MAX_TRACE_PRINTK_VARARGS);
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
+	bpf_printf_postamble();
+
+	return ret;
 }
 
 static const struct bpf_func_proto bpf_trace_printk_proto = {
@@ -581,184 +687,37 @@ const struct bpf_func_proto *bpf_get_trace_printk_proto(void)
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
+	err = bpf_printf_preamble(fmt, fmt_size, data, args, mod, num_args);
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
+	bpf_printf_postamble();
+
+	return seq_has_overflowed(m) ? -EOVERFLOW : 0;
 }
 
 BTF_ID_LIST_SINGLE(btf_seq_file_ids, struct, seq_file)
-- 
2.31.0.291.g576ba9dcdaf-goog


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7D0368A4A
	for <lists+bpf@lfdr.de>; Fri, 23 Apr 2021 03:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240081AbhDWBQA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Apr 2021 21:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240052AbhDWBP7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Apr 2021 21:15:59 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02953C061574
        for <bpf@vger.kernel.org>; Thu, 22 Apr 2021 18:15:24 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id p6so39979427wrn.9
        for <bpf@vger.kernel.org>; Thu, 22 Apr 2021 18:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lzQz53Dyr4VaEnOtOvCzZGEEMawO8rrtvUi1dAgwgJs=;
        b=FduYITz0MEkWtLzfo3PQZc2UBIVwytuajvwOFchbTNbiOEMGQmDM7j6XKtNCWCID1o
         mICd/G9YKUF0GPNbZB3Pv13IRU874WC52FBQNjZLzidvmPB7z4AWUwuFoCmHk+cfzesR
         w5YKMPUBUP1pPHJdl5c7BtZeKRXHzGSxG0Psw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lzQz53Dyr4VaEnOtOvCzZGEEMawO8rrtvUi1dAgwgJs=;
        b=PTVKL6QsHWcePza1lF6PedbvN7KELsNgvr4NsYD7aTXwiWaqSQ1xaMPbg9256wBr81
         dSXh9SZilm0rDHAWIM8I4cwu/zwXGZLTx7SZ7eEXqJ72U3i2qPfbkQRr/5jqDoggFuT0
         5cKX36iHYK5kxNmI+0kp7Dz61sIKu51hSLXqOF/3s58RlZ0H7gEngBGOI4mT8LLye8S7
         iSDqMFnKs3/nuo95/Gnbt3yOdtsO4nVG+XGrEj5TFzRaJ9axEIvN4tAYB6ko/jWQLnUB
         0S70TwESy28mdnsqlYSbTNqq5ugB2pS7rngprIlJ1gxcbirEQyV0TzK3KaLf0KxxNLFF
         9Mzw==
X-Gm-Message-State: AOAM532CUu4+SqeTR3Z1JoOkzEBxYPhKOK4CXX20Nrbvgu2AdbBpicJT
        URYzBO5whduxU2AztYhI1SsWDGt1yVNcBA==
X-Google-Smtp-Source: ABdhPJxnZ25VwrgrCBZvNTc042f4aCegFjwT1hFeKlYICQ5QA4bM8U3hip/kNZLBqLoywUqaSe6ctw==
X-Received: by 2002:a5d:4251:: with SMTP id s17mr1278444wrr.174.1619140522308;
        Thu, 22 Apr 2021 18:15:22 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:61:302:e4b7:67ca:7609:a533])
        by smtp.gmail.com with ESMTPSA id a13sm6709340wrs.78.2021.04.22.18.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 18:15:21 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, jackmanb@google.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next 2/2] bpf: Implement formatted output helpers with bstr_printf
Date:   Fri, 23 Apr 2021 03:15:17 +0200
Message-Id: <20210423011517.4069221-3-revest@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210423011517.4069221-1-revest@chromium.org>
References: <20210423011517.4069221-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF has three formatted output helpers: bpf_trace_printk, bpf_seq_printf
and bpf_snprintf. Their signatures specifies that arguments are always
provided from the BPF world as u64s (in an array or as registers). All
of these helpers are currently implemented by calling functions such as
snprintf() whose signatures take arguments as a va_list.

To convert args from u64s to a va_list "d9c9e4db bpf: Factorize
bpf_trace_printk and bpf_seq_printf" introduced a bpf_printf_prepare
function that fills an array of arguments and an array of modifiers.
The BPF_CAST_FMT_ARG macro was supposed to consume these arrays and cast
each argument to the right size. However, the C promotion rules implies
that every argument is stored as a u64 in the va_list.

In "88a5c690b6 bpf: fix bpf_trace_printk on 32 bit archs", this problem
had been solved for bpf_trace_printk only with a "horrid workaround"
that emitted multiple calls to trace_printk where each call had
different types stored in its va_list, known at compilation time. This
was ok with 3 arguments but bpf_seq_printf and bpf_snprintf have a
maximum of 12 arguments and because this approach scales code
exponentially, this is not a viable option.

Because the promotion rules are part of the language and because the
construction of a va_list is an arch- and compiler-specific ABI, it's
easier to avoid va_lists altogether. Thankfully snprintf() has an
alternative in the form of bstr_printf() that accepts arguments in a
"binary buffer representation". These binary buffers are currently
created by vbin_printf and used in the tracing subsystem.

This patch refactors bpf_printf_prepare to construct binary buffers of
arguments consumable by bstr_printf() instead of arrays of arguments and
modifiers. This greatly simplifies the bpf_printf_prepare API usage but
there are a few gotchas that change how bpf_printf_prepare does things.

Currently, bpf_printf_prepare uses a per cpu temporary buffer as a
generic storage for strings and IP addresses. With this refactoring, the
temporary buffers now stores all the arguments in a structured binary
format.

To comply with the format expected by bstr_printf, certain format
specifiers also need to be pre-formatted: %pB and %pi6/%pi4/%pI4/%pI6.
Because vsnprintf subroutines for these specifiers are hard to expose,
we pre-format these arguments with calls to snprintf().

Signed-off-by: Florent Revest <revest@chromium.org>
Reported-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/bpf.h      |  22 +----
 init/Kconfig             |   1 +
 kernel/bpf/helpers.c     | 188 +++++++++++++++++++++------------------
 kernel/bpf/verifier.c    |   2 +-
 kernel/trace/bpf_trace.c |  34 +++----
 5 files changed, 115 insertions(+), 132 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f8a45f109e96..8f59df9fc9fc 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2079,24 +2079,8 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 struct btf_id_set;
 bool btf_id_set_contains(const struct btf_id_set *set, u32 id);
 
-enum bpf_printf_mod_type {
-	BPF_PRINTF_INT,
-	BPF_PRINTF_LONG,
-	BPF_PRINTF_LONG_LONG,
-};
-
-/* Workaround for getting va_list handling working with different argument type
- * combinations generically for 32 and 64 bit archs.
- */
-#define BPF_CAST_FMT_ARG(arg_nb, args, mod)				\
-	(mod[arg_nb] == BPF_PRINTF_LONG_LONG ||				\
-	 (mod[arg_nb] == BPF_PRINTF_LONG && __BITS_PER_LONG == 64)	\
-	  ? (u64)args[arg_nb]						\
-	  : (u32)args[arg_nb])
-
-int bpf_printf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
-		       u64 *final_args, enum bpf_printf_mod_type *mod,
-		       u32 num_args);
-void bpf_printf_cleanup(void);
+int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
+			u32 **bin_buf, u32 num_args);
+void bpf_bprintf_cleanup(void);
 
 #endif /* _LINUX_BPF_H */
diff --git a/init/Kconfig b/init/Kconfig
index 5deae45b8d81..0d82a1f838cc 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1708,6 +1708,7 @@ config BPF_SYSCALL
 	select BPF
 	select IRQ_WORK
 	select TASKS_TRACE_RCU
+	select BINARY_PRINTF
 	select NET_SOCK_MSG if INET
 	default n
 	help
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 85b26ca5aacd..24cc99a4ee38 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -707,9 +707,6 @@ static int try_get_fmt_tmp_buf(char **tmp_buf)
 	struct bpf_printf_buf *bufs;
 	int used;
 
-	if (*tmp_buf)
-		return 0;
-
 	preempt_disable();
 	used = this_cpu_inc_return(bpf_printf_buf_used);
 	if (WARN_ON_ONCE(used > 1)) {
@@ -723,7 +720,7 @@ static int try_get_fmt_tmp_buf(char **tmp_buf)
 	return 0;
 }
 
-void bpf_printf_cleanup(void)
+void bpf_bprintf_cleanup(void)
 {
 	if (this_cpu_read(bpf_printf_buf_used)) {
 		this_cpu_dec(bpf_printf_buf_used);
@@ -732,43 +729,45 @@ void bpf_printf_cleanup(void)
 }
 
 /*
- * bpf_parse_fmt_str - Generic pass on format strings for printf-like helpers
+ * bpf_bprintf_prepare - Generic pass on format strings for bprintf-like helpers
  *
  * Returns a negative value if fmt is an invalid format string or 0 otherwise.
  *
  * This can be used in two ways:
- * - Format string verification only: when final_args and mod are NULL
+ * - Format string verification only: when bin_args is NULL
  * - Arguments preparation: in addition to the above verification, it writes in
- *   final_args a copy of raw_args where pointers from BPF have been sanitized
- *   into pointers safe to use by snprintf. This also writes in the mod array
- *   the size requirement of each argument, usable by BPF_CAST_FMT_ARG for ex.
+ *   bin_args a binary representation of arguments usable by bstr_printf where
+ *   pointers from BPF have been sanitized.
  *
  * In argument preparation mode, if 0 is returned, safe temporary buffers are
- * allocated and bpf_printf_cleanup should be called to free them after use.
+ * allocated and bpf_bprintf_cleanup should be called to free them after use.
  */
-int bpf_printf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
-			u64 *final_args, enum bpf_printf_mod_type *mod,
-			u32 num_args)
+int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
+			u32 **bin_args, u32 num_args)
 {
-	char *unsafe_ptr = NULL, *tmp_buf = NULL, *fmt_end;
-	size_t tmp_buf_len = MAX_PRINTF_BUF_LEN;
-	int err, i, num_spec = 0, copy_size;
-	enum bpf_printf_mod_type cur_mod;
+	char *unsafe_ptr = NULL, *tmp_buf = NULL, *tmp_buf_end, *fmt_end;
+	size_t sizeof_cur_arg, sizeof_cur_ip;
+	int err, i, num_spec = 0;
 	u64 cur_arg;
-	char fmt_ptype;
-
-	if (!!final_args != !!mod)
-		return -EINVAL;
+	char fmt_ptype, cur_ip[16], ip_spec[] = "%pXX";
 
 	fmt_end = strnchr(fmt, fmt_size, 0);
 	if (!fmt_end)
 		return -EINVAL;
 	fmt_size = fmt_end - fmt;
 
+	if (bin_args) {
+		if (num_args && try_get_fmt_tmp_buf(&tmp_buf))
+			return -EBUSY;
+
+		tmp_buf_end = tmp_buf + MAX_PRINTF_BUF_LEN;
+		*bin_args = (u32 *)tmp_buf;
+	}
+
 	for (i = 0; i < fmt_size; i++) {
 		if ((!isprint(fmt[i]) && !isspace(fmt[i])) || !isascii(fmt[i])) {
 			err = -EINVAL;
-			goto cleanup;
+			goto out;
 		}
 
 		if (fmt[i] != '%')
@@ -781,7 +780,7 @@ int bpf_printf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 
 		if (num_spec >= num_args) {
 			err = -EINVAL;
-			goto cleanup;
+			goto out;
 		}
 
 		/* The string is zero-terminated so if fmt[i] != 0, we can
@@ -800,7 +799,7 @@ int bpf_printf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 		}
 
 		if (fmt[i] == 'p') {
-			cur_mod = BPF_PRINTF_LONG;
+			sizeof_cur_arg = sizeof(long);
 
 			if ((fmt[i + 1] == 'k' || fmt[i + 1] == 'u') &&
 			    fmt[i + 2] == 's') {
@@ -811,117 +810,140 @@ int bpf_printf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 
 			if (fmt[i + 1] == 0 || isspace(fmt[i + 1]) ||
 			    ispunct(fmt[i + 1]) || fmt[i + 1] == 'K' ||
-			    fmt[i + 1] == 'x' || fmt[i + 1] == 'B' ||
-			    fmt[i + 1] == 's' || fmt[i + 1] == 'S') {
+			    fmt[i + 1] == 'x' || fmt[i + 1] == 's' ||
+			    fmt[i + 1] == 'S') {
 				/* just kernel pointers */
-				if (final_args)
+				if (tmp_buf)
 					cur_arg = raw_args[num_spec];
-				goto fmt_next;
+				i++;
+				goto nocopy_fmt;
+			}
+
+			if (fmt[i + 1] == 'B') {
+				if (tmp_buf)  {
+					err = snprintf(tmp_buf,
+						       (tmp_buf_end - tmp_buf),
+						       "%pB",
+						       (void *)(long)raw_args[num_spec]);
+					tmp_buf += (err + 1);
+				}
+
+				i++;
+				num_spec++;
+				continue;
 			}
 
 			/* only support "%pI4", "%pi4", "%pI6" and "%pi6". */
 			if ((fmt[i + 1] != 'i' && fmt[i + 1] != 'I') ||
 			    (fmt[i + 2] != '4' && fmt[i + 2] != '6')) {
 				err = -EINVAL;
-				goto cleanup;
+				goto out;
 			}
 
 			i += 2;
-			if (!final_args)
-				goto fmt_next;
+			if (!tmp_buf)
+				goto nocopy_fmt;
 
-			if (try_get_fmt_tmp_buf(&tmp_buf)) {
-				err = -EBUSY;
-				goto out;
-			}
-
-			copy_size = (fmt[i + 2] == '4') ? 4 : 16;
-			if (tmp_buf_len < copy_size) {
+			sizeof_cur_ip = (fmt[i] == '4') ? 4 : 16;
+			if ((tmp_buf_end - tmp_buf) < sizeof_cur_ip) {
 				err = -ENOSPC;
-				goto cleanup;
+				goto out;
 			}
 
 			unsafe_ptr = (char *)(long)raw_args[num_spec];
-			err = copy_from_kernel_nofault(tmp_buf, unsafe_ptr,
-						       copy_size);
+			err = copy_from_kernel_nofault(cur_ip, unsafe_ptr,
+						       sizeof_cur_ip);
 			if (err < 0)
-				memset(tmp_buf, 0, copy_size);
-			cur_arg = (u64)(long)tmp_buf;
-			tmp_buf += copy_size;
-			tmp_buf_len -= copy_size;
+				memset(cur_ip, 0, sizeof_cur_ip);
+
+			/* hack: bstr_printf expects IP addresses to be
+			 * pre-formatted as strings, ironically, the easiest way
+			 * to do that is to call snprintf.
+			 */
+			ip_spec[2] = fmt[i - 1];
+			ip_spec[3] = fmt[i];
+			err = snprintf(tmp_buf, (tmp_buf_end - tmp_buf),
+				       ip_spec, &cur_ip);
 
-			goto fmt_next;
+			tmp_buf += (err + 1);
+			num_spec++;
+
+			continue;
 		} else if (fmt[i] == 's') {
-			cur_mod = BPF_PRINTF_LONG;
 			fmt_ptype = fmt[i];
 fmt_str:
 			if (fmt[i + 1] != 0 &&
 			    !isspace(fmt[i + 1]) &&
 			    !ispunct(fmt[i + 1])) {
 				err = -EINVAL;
-				goto cleanup;
-			}
-
-			if (!final_args)
-				goto fmt_next;
-
-			if (try_get_fmt_tmp_buf(&tmp_buf)) {
-				err = -EBUSY;
 				goto out;
 			}
 
-			if (!tmp_buf_len) {
+			if (!tmp_buf)
+				goto nocopy_fmt;
+
+			if (tmp_buf_end == tmp_buf) {
 				err = -ENOSPC;
-				goto cleanup;
+				goto out;
 			}
 
 			unsafe_ptr = (char *)(long)raw_args[num_spec];
 			err = bpf_trace_copy_string(tmp_buf, unsafe_ptr,
-						    fmt_ptype, tmp_buf_len);
+						    fmt_ptype,
+						    (tmp_buf_end - tmp_buf));
 			if (err < 0) {
 				tmp_buf[0] = '\0';
 				err = 1;
 			}
 
-			cur_arg = (u64)(long)tmp_buf;
 			tmp_buf += err;
-			tmp_buf_len -= err;
+			num_spec++;
 
-			goto fmt_next;
+			continue;
 		}
 
-		cur_mod = BPF_PRINTF_INT;
+		sizeof_cur_arg = sizeof(int);
 
 		if (fmt[i] == 'l') {
-			cur_mod = BPF_PRINTF_LONG;
+			sizeof_cur_arg = sizeof(long);
 			i++;
 		}
 		if (fmt[i] == 'l') {
-			cur_mod = BPF_PRINTF_LONG_LONG;
+			sizeof_cur_arg = sizeof(long long);
 			i++;
 		}
 
 		if (fmt[i] != 'i' && fmt[i] != 'd' && fmt[i] != 'u' &&
 		    fmt[i] != 'x' && fmt[i] != 'X') {
 			err = -EINVAL;
-			goto cleanup;
+			goto out;
 		}
 
-		if (final_args)
+		if (tmp_buf)
 			cur_arg = raw_args[num_spec];
-fmt_next:
-		if (final_args) {
-			mod[num_spec] = cur_mod;
-			final_args[num_spec] = cur_arg;
+nocopy_fmt:
+		if (tmp_buf) {
+			tmp_buf = PTR_ALIGN(tmp_buf, sizeof(u32));
+			if ((tmp_buf_end - tmp_buf) < sizeof_cur_arg) {
+				err = -ENOSPC;
+				goto out;
+			}
+
+			if (sizeof_cur_arg == 8) {
+				*(u32 *)tmp_buf = *(u32 *)&cur_arg;
+				*(u32 *)(tmp_buf + 4) = *((u32 *)&cur_arg + 1);
+			} else {
+				*(u32 *)tmp_buf = (u32)(long)cur_arg;
+			}
+			tmp_buf += sizeof_cur_arg;
 		}
 		num_spec++;
 	}
 
 	err = 0;
-cleanup:
-	if (err)
-		bpf_printf_cleanup();
 out:
+	if (err)
+		bpf_bprintf_cleanup();
 	return err;
 }
 
@@ -930,9 +952,8 @@ int bpf_printf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 BPF_CALL_5(bpf_snprintf, char *, str, u32, str_size, char *, fmt,
 	   const void *, data, u32, data_len)
 {
-	enum bpf_printf_mod_type mod[MAX_SNPRINTF_VARARGS];
-	u64 args[MAX_SNPRINTF_VARARGS];
 	int err, num_args;
+	u32 *bin_args;
 
 	if (data_len % 8 || data_len > MAX_SNPRINTF_VARARGS * 8 ||
 	    (data_len && !data))
@@ -942,22 +963,13 @@ BPF_CALL_5(bpf_snprintf, char *, str, u32, str_size, char *, fmt,
 	/* ARG_PTR_TO_CONST_STR guarantees that fmt is zero-terminated so we
 	 * can safely give an unbounded size.
 	 */
-	err = bpf_printf_prepare(fmt, UINT_MAX, data, args, mod, num_args);
+	err = bpf_bprintf_prepare(fmt, UINT_MAX, data, &bin_args, num_args);
 	if (err < 0)
 		return err;
 
-	/* Maximumly we can have MAX_SNPRINTF_VARARGS parameters, just give
-	 * all of them to snprintf().
-	 */
-	err = snprintf(str, str_size, fmt, BPF_CAST_FMT_ARG(0, args, mod),
-		BPF_CAST_FMT_ARG(1, args, mod), BPF_CAST_FMT_ARG(2, args, mod),
-		BPF_CAST_FMT_ARG(3, args, mod), BPF_CAST_FMT_ARG(4, args, mod),
-		BPF_CAST_FMT_ARG(5, args, mod), BPF_CAST_FMT_ARG(6, args, mod),
-		BPF_CAST_FMT_ARG(7, args, mod), BPF_CAST_FMT_ARG(8, args, mod),
-		BPF_CAST_FMT_ARG(9, args, mod), BPF_CAST_FMT_ARG(10, args, mod),
-		BPF_CAST_FMT_ARG(11, args, mod));
-
-	bpf_printf_cleanup();
+	err = bstr_printf(str, str_size, fmt, bin_args);
+
+	bpf_bprintf_cleanup();
 
 	return err + 1;
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 58730872f7e5..48539afb9e9a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5947,7 +5947,7 @@ static int check_bpf_snprintf_call(struct bpf_verifier_env *env,
 	/* We are also guaranteed that fmt+fmt_map_off is NULL terminated, we
 	 * can focus on validating the format specifiers.
 	 */
-	err = bpf_printf_prepare(fmt, UINT_MAX, NULL, NULL, NULL, num_args);
+	err = bpf_bprintf_prepare(fmt, UINT_MAX, NULL, NULL, num_args);
 	if (err < 0)
 		verbose(env, "Invalid format string\n");
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 2a8bcdc927c7..c8702d6ce7de 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -381,27 +381,23 @@ BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
 	   u64, arg2, u64, arg3)
 {
 	u64 args[MAX_TRACE_PRINTK_VARARGS] = { arg1, arg2, arg3 };
-	enum bpf_printf_mod_type mod[MAX_TRACE_PRINTK_VARARGS];
+	u32 *bin_args;
 	static char buf[BPF_TRACE_PRINTK_SIZE];
 	unsigned long flags;
 	int ret;
 
-	ret = bpf_printf_prepare(fmt, fmt_size, args, args, mod,
-				 MAX_TRACE_PRINTK_VARARGS);
+	ret = bpf_bprintf_prepare(fmt, fmt_size, args, &bin_args,
+				  MAX_TRACE_PRINTK_VARARGS);
 	if (ret < 0)
 		return ret;
 
-	ret = snprintf(buf, sizeof(buf), fmt, BPF_CAST_FMT_ARG(0, args, mod),
-		BPF_CAST_FMT_ARG(1, args, mod), BPF_CAST_FMT_ARG(2, args, mod));
-	/* snprintf() will not append null for zero-length strings */
-	if (ret == 0)
-		buf[0] = '\0';
+	ret = bstr_printf(buf, sizeof(buf), fmt, bin_args);
 
 	raw_spin_lock_irqsave(&trace_printk_lock, flags);
 	trace_bpf_trace_printk(buf);
 	raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
 
-	bpf_printf_cleanup();
+	bpf_bprintf_cleanup();
 
 	return ret;
 }
@@ -435,31 +431,21 @@ const struct bpf_func_proto *bpf_get_trace_printk_proto(void)
 BPF_CALL_5(bpf_seq_printf, struct seq_file *, m, char *, fmt, u32, fmt_size,
 	   const void *, data, u32, data_len)
 {
-	enum bpf_printf_mod_type mod[MAX_SEQ_PRINTF_VARARGS];
-	u64 args[MAX_SEQ_PRINTF_VARARGS];
 	int err, num_args;
+	u32 *bin_args;
 
 	if (data_len & 7 || data_len > MAX_SEQ_PRINTF_VARARGS * 8 ||
 	    (data_len && !data))
 		return -EINVAL;
 	num_args = data_len / 8;
 
-	err = bpf_printf_prepare(fmt, fmt_size, data, args, mod, num_args);
+	err = bpf_bprintf_prepare(fmt, fmt_size, data, &bin_args, num_args);
 	if (err < 0)
 		return err;
 
-	/* Maximumly we can have MAX_SEQ_PRINTF_VARARGS parameter, just give
-	 * all of them to seq_printf().
-	 */
-	seq_printf(m, fmt, BPF_CAST_FMT_ARG(0, args, mod),
-		BPF_CAST_FMT_ARG(1, args, mod), BPF_CAST_FMT_ARG(2, args, mod),
-		BPF_CAST_FMT_ARG(3, args, mod), BPF_CAST_FMT_ARG(4, args, mod),
-		BPF_CAST_FMT_ARG(5, args, mod), BPF_CAST_FMT_ARG(6, args, mod),
-		BPF_CAST_FMT_ARG(7, args, mod), BPF_CAST_FMT_ARG(8, args, mod),
-		BPF_CAST_FMT_ARG(9, args, mod), BPF_CAST_FMT_ARG(10, args, mod),
-		BPF_CAST_FMT_ARG(11, args, mod));
-
-	bpf_printf_cleanup();
+	seq_bprintf(m, fmt, bin_args);
+
+	bpf_bprintf_cleanup();
 
 	return seq_has_overflowed(m) ? -EOVERFLOW : 0;
 }
-- 
2.31.1.498.g6c1eba8ee3d-goog


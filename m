Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1247B2C59B9
	for <lists+bpf@lfdr.de>; Thu, 26 Nov 2020 18:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403939AbgKZQ7H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Nov 2020 11:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403891AbgKZQ7F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Nov 2020 11:59:05 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD79FC0617A7
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2020 08:59:04 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a186so2744404wme.1
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2020 08:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0L00r4rPHemcbzcKizDl5R/fNH5uAoaWPolJKjNNL9c=;
        b=EivVOmLNk176rC1BaDYKctnghwXfBJ8z7Vtqp3kgoYE9GywHRyCXiLuUXCFTUOrUxa
         /l5zZGyjrAbnUwyPs1Y9iN/ilkHw2xWvXklsmM8mKMvuW9Q+H9ispA2Wt6bxLoWZ8Ba/
         g/vBv3cyAQaJSj+Ve66wA52pJQBf8mNihZ/cQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0L00r4rPHemcbzcKizDl5R/fNH5uAoaWPolJKjNNL9c=;
        b=fTomrpXC/8lt1zxpMvsNUaCXb5eJ4Ongmfz2Ru675KHkwljNbCMdD9VwLJXQKSz+QV
         dwp1J6ibYc2xeu88hL14pSCtYdPXL5V8d5wbPfMKbc5uSAh0g8Ap4lK121T/x5N+E0Ap
         2T8b5NwO4ELONprhWX6SVFHb63EVLYSZSwpB/4iCsLKs8Qm8Y1xxmOKX1kFoCRtPqlIR
         11poNyCU2fEJODILr2b8sBq4F6j4ap5P7SZK3IJ113BtNJnLniPvnJFKxKWctqyU+flO
         XDuYAxwwpOhBrIgVXlDJANQjlqGP/lijiKeGRCCqEVZ30+vES6SDDDyC4hfV8R2dN/3O
         Ox4w==
X-Gm-Message-State: AOAM530bV5anQgvuwsobeiRwWONZR9H2K3tkNDATp+W1OIJ2ZP02XZWA
        mZtpVj7IdbS1dGjM4mT4m8YxVWLuSfOeKmqW
X-Google-Smtp-Source: ABdhPJyIgpPGSqDwYRnHLR+STfy/X3mG/aOhmRn390E4IPISSzL02fN4S0cJfWSOd/Lw11+HIV2Kkg==
X-Received: by 2002:a1c:1f16:: with SMTP id f22mr4243742wmf.108.1606409943063;
        Thu, 26 Nov 2020 08:59:03 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:f693:9fff:fef4:a569])
        by smtp.gmail.com with ESMTPSA id 17sm8768032wmf.48.2020.11.26.08.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 08:59:02 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
X-Google-Original-From: Florent Revest <revest@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@chromium.org, revest@google.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/2] bpf: Add a bpf_kallsyms_lookup helper
Date:   Thu, 26 Nov 2020 17:57:47 +0100
Message-Id: <20201126165748.1748417-1-revest@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This helper exposes the kallsyms_lookup function to eBPF tracing
programs. This can be used to retrieve the name of the symbol at an
address. For example, when hooking into nf_register_net_hook, one can
audit the name of the registered netfilter hook and potentially also
the name of the module in which the symbol is located.

Signed-off-by: Florent Revest <revest@google.com>
---
 include/uapi/linux/bpf.h       | 16 +++++++++++++
 kernel/trace/bpf_trace.c       | 41 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h | 16 +++++++++++++
 3 files changed, 73 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c3458ec1f30a..670998635eac 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3817,6 +3817,21 @@ union bpf_attr {
  *		The **hash_algo** is returned on success,
  *		**-EOPNOTSUP** if IMA is disabled or **-EINVAL** if
  *		invalid arguments are passed.
+ *
+ * long bpf_kallsyms_lookup(u64 address, char *symbol, u32 symbol_size, char *module, u32 module_size)
+ *	Description
+ *		Uses kallsyms to write the name of the symbol at *address*
+ *		into *symbol* of size *symbol_sz*. This is guaranteed to be
+ *		zero terminated.
+ *		If the symbol is in a module, up to *module_size* bytes of
+ *		the module name is written in *module*. This is also
+ *		guaranteed to be zero-terminated. Note: a module name
+ *		is always shorter than 64 bytes.
+ *	Return
+ *		On success, the strictly positive length of the full symbol
+ *		name, If this is greater than *symbol_size*, the written
+ *		symbol is truncated.
+ *		On error, a negative value.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3981,6 +3996,7 @@ union bpf_attr {
 	FN(bprm_opts_set),		\
 	FN(ktime_get_coarse_ns),	\
 	FN(ima_inode_hash),		\
+	FN(kallsyms_lookup),	\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index d255bc9b2bfa..9d86e20c2b13 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -17,6 +17,7 @@
 #include <linux/error-injection.h>
 #include <linux/btf_ids.h>
 #include <linux/bpf_lsm.h>
+#include <linux/kallsyms.h>
 
 #include <net/bpf_sk_storage.h>
 
@@ -1260,6 +1261,44 @@ const struct bpf_func_proto bpf_snprintf_btf_proto = {
 	.arg5_type	= ARG_ANYTHING,
 };
 
+BPF_CALL_5(bpf_kallsyms_lookup, u64, address, char *, symbol, u32, symbol_size,
+	   char *, module, u32, module_size)
+{
+	char buffer[KSYM_SYMBOL_LEN];
+	unsigned long offset, size;
+	const char *name;
+	char *modname;
+	long ret;
+
+	name = kallsyms_lookup(address, &size, &offset, &modname, buffer);
+	if (!name)
+		return -EINVAL;
+
+	ret = strlen(name) + 1;
+	if (symbol_size) {
+		strncpy(symbol, name, symbol_size);
+		symbol[symbol_size - 1] = '\0';
+	}
+
+	if (modname && module_size) {
+		strncpy(module, modname, module_size);
+		module[module_size - 1] = '\0';
+	}
+
+	return ret;
+}
+
+const struct bpf_func_proto bpf_kallsyms_lookup_proto = {
+	.func		= bpf_kallsyms_lookup,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg3_type	= ARG_CONST_SIZE,
+	.arg4_type	= ARG_PTR_TO_MEM,
+	.arg5_type	= ARG_CONST_SIZE,
+};
+
 const struct bpf_func_proto *
 bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -1356,6 +1395,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_per_cpu_ptr_proto;
 	case BPF_FUNC_bpf_this_cpu_ptr:
 		return &bpf_this_cpu_ptr_proto;
+	case BPF_FUNC_kallsyms_lookup:
+		return &bpf_kallsyms_lookup_proto;
 	default:
 		return NULL;
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index c3458ec1f30a..670998635eac 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3817,6 +3817,21 @@ union bpf_attr {
  *		The **hash_algo** is returned on success,
  *		**-EOPNOTSUP** if IMA is disabled or **-EINVAL** if
  *		invalid arguments are passed.
+ *
+ * long bpf_kallsyms_lookup(u64 address, char *symbol, u32 symbol_size, char *module, u32 module_size)
+ *	Description
+ *		Uses kallsyms to write the name of the symbol at *address*
+ *		into *symbol* of size *symbol_sz*. This is guaranteed to be
+ *		zero terminated.
+ *		If the symbol is in a module, up to *module_size* bytes of
+ *		the module name is written in *module*. This is also
+ *		guaranteed to be zero-terminated. Note: a module name
+ *		is always shorter than 64 bytes.
+ *	Return
+ *		On success, the strictly positive length of the full symbol
+ *		name, If this is greater than *symbol_size*, the written
+ *		symbol is truncated.
+ *		On error, a negative value.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3981,6 +3996,7 @@ union bpf_attr {
 	FN(bprm_opts_set),		\
 	FN(ktime_get_coarse_ns),	\
 	FN(ima_inode_hash),		\
+	FN(kallsyms_lookup),	\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.29.2.454.gaff20da3a2-goog


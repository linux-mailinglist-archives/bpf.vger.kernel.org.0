Return-Path: <bpf+bounces-76569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C7BCBC57C
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 04:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B217D3008BED
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 03:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE6F2BEC31;
	Mon, 15 Dec 2025 03:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhR+R9aq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91C129D29E
	for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 03:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765770169; cv=none; b=U3eHUghW/r+YrSV712XV/MqEj4e20V0BQlUWZ0lNzD9uWdANQR6ZfYje4SEvRHh+wq9zjcHVsG2kiATbptc78XgyHGWm5o4oeApWBE7124pJlHS4G7rtgl8yX5so9nKHw0VneuwZ3cPq8D3dglVNos0kv1XwEx4OsziOXdb0QS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765770169; c=relaxed/simple;
	bh=x1EZDXwpBtHEAJwiUMWKxwGt4FVIKlZiGWUwN6Sc5P8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JNlzsFXaQn+LFQt15UjZT/ygwLVDSk06B0yvQH+urvsS2MIHUaDkPlXoLNf8wm2u79XEmf8pJKfR828B/clZ9sJrWExRS/JiDQjvrf+SeqIhbNKRFq5goHOX+uGpP+q7z5A3gSt/wH9Sq6ckGTwjZh7dQy1JKUN9zB30ZRYmu44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhR+R9aq; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34c1d84781bso1985872a91.2
        for <bpf@vger.kernel.org>; Sun, 14 Dec 2025 19:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765770167; x=1766374967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xd9WY+m6+WX7Pur4QkVKIOZEntT/jaxLPiAk2vWokIQ=;
        b=YhR+R9aqtgUfLjGkxgRTG7DPOOLpHV40plmzAtZV3ana3IVYK39KV/JNS4y3mb+MBI
         uHdQ187XCA0HOhR3eBMlKbT7m2SC2bhO+uocHElkoN+YJCMvYUHfuz5nxFJgU9mYQAsK
         TwOYw9mX/JXvb0zswLw+e770OiXRKDkRQp3Pbbup0emOlVjx90UAB4mt8ylTyvKb9t2o
         Q2WPZtiTGVJf7hJS1RI3Vq6P1M6zUS65KDPnH/Lpg0B0GtjJaoEeD+25BAVXhMSHVCur
         UsJPHIj3Ce0LE3lKd1StaHxiqm3pnsmcxcCwWbp7oiHge42ADaOUEnUCpyhYGDwcWsu2
         jakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765770167; x=1766374967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xd9WY+m6+WX7Pur4QkVKIOZEntT/jaxLPiAk2vWokIQ=;
        b=L5K1/xubP+KBSEMK6DQhWwBFR4GdUL88U32S/IGJnpN7M8C6+IwbWxQcYCEFr8W6mE
         wVxSIuYmIIpsoBSF1Xv1Bk9e+WR1SoZ4dwyfwjMA3P3LqickGd118WpYbFzBWE6BPL1q
         zpd/+IT10VPVWAFgWY0B3Nar7+/l/fd1zLMnrf1Or88l/xsZLhDeVVEo0s8aQ+Cmjbmx
         6cVSWtDQLGCLkCQkD6F/3S1z7vKjkRLux7GRQ2EhmnE7XvfuTc8XJpVUho22N6igDU2N
         6BUXbj5hjnoWc7gxvP9xyFB5sX9pmFoghinjCfWEBXebD7dUKN22aMEbzzBuANLPrY6W
         orKA==
X-Forwarded-Encrypted: i=1; AJvYcCXk2ipr/HnZsHZ2Bd0Ru8TLzZ+JY4uFXWKT3vgbXQOlaCzltGljsfTvz0pBZcOnqkOWDXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu2A9Bdlyes4juERTA+OlMTh5hO8nsVo1xuXMaKSgP0il4mbDw
	3txvbaaY00h5VB1Ajurk3xFIG4BZeUxxOqjFICka//LENrL3e9tAtCiZCvWAD/HPEVA=
X-Gm-Gg: AY/fxX7uw8Mb7iWM07V7Yl0W4wLcfhxzmWQSBv2wNRqvwFY66S4iDxrEb4buLmqkM12
	cKpHe+I3n/rqU5/rOnfZycegD3K8cyY+mEj20/GPEY5pX8pKgWmJM65BDfoJ3KUdeMR9z6+1lDG
	LrPgq/a7uhX5yVaPIvnlewFwZ9Dw0g8/m07hD309+zgVrsC41qAjApPbQ68iiHf4YmafZCh6Nab
	fw8cwBojhtkNG5nqEnceBqaZM0/xi9rmV4VQBhdYadCK97QH1+RkXbuhn+Z9+vCVfXBwyIIJeJi
	JmvAgKiVXOIm3KdSFLXRUwCEEfXkZ8jHvGhuJNLXbnVFBNHH1U7auDONVExfeGk1J0/faV8naSP
	KLfP9Kjo6HqOpzt6y2KSjcATfew4HOENhB0lr/izxO6mGDe+7/Dv6NBOf+zz1uA1eoiwtqMQ2b7
	GwtR81JFqUl4yxcqZElSp58YWRmrU=
X-Google-Smtp-Source: AGHT+IFEKMAm2xwpvhAT31FkoiRa3afcZbkdDGilaT6v6Av0cg8Jp7vcjHFm1RUYNGN5u6kMK6k+cA==
X-Received: by 2002:a17:90b:2d4b:b0:349:2936:7f4 with SMTP id 98e67ed59e1d1-34abd786b6amr7848522a91.32.1765770166936;
        Sun, 14 Dec 2025 19:42:46 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe23a207sm3420562a91.1.2025.12.14.19.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 19:42:45 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>,
	Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Subject: [PATCH v4 2/3] fgraph: Enhance funcgraph-retval with BTF-based type-aware output
Date: Mon, 15 Dec 2025 11:41:52 +0800
Message-Id: <20251215034153.2367756-3-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251215034153.2367756-1-dolinux.peng@gmail.com>
References: <20251215034153.2367756-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

The current funcgraph-retval implementation suffers from two accuracy
issues:

1. Void-returning functions still print a return value, creating
   misleading noise in the trace output.

2. For functions returning narrower types (e.g., char, short), the
   displayed value can be incorrect because high bits of the register
   may contain undefined data.

This patch addresses both problems by leveraging BTF to obtain the exact
return type of each traced kernel function. The key changes are:

1. Void function filtering: Functions with void return type no longer
   display any return value in the trace output, eliminating unnecessary
   clutter.

2. Type-aware value formatting: The return value is now properly truncated
   to match the actual width of the return type before being displayed.
   Additionally, the value is formatted according to its type for better
   human readability.

Here is an output comparison:

Before:
 # perf ftrace -G vfs_read --graph-opts retval
 ...
 1)               |   touch_atime() {
 1)               |     atime_needs_update() {
 1)   0.069 us    |       make_vfsuid(); /* ret=0x0 */
 1)   0.067 us    |       make_vfsgid(); /* ret=0x0 */
 1)               |       current_time() {
 1)   0.197 us    |         ktime_get_coarse_real_ts64_mg(); /* ret=0x187f886aec3ed6f5 */
 1)   0.352 us    |       } /* current_time ret=0x69380753 */
 1)   0.792 us    |     } /* atime_needs_update ret=0x0 */
 1)   0.937 us    |   } /* touch_atime ret=0x0 */

After:
 # perf ftrace -G vfs_read --graph-opts retval
 ...
 2)               |   touch_atime() {
 2)               |     atime_needs_update() {
 2)   0.070 us    |       make_vfsuid(); /* ret=0x0 */
 2)   0.070 us    |       make_vfsgid(); /* ret=0x0 */
 2)               |       current_time() {
 2)   0.162 us    |         ktime_get_coarse_real_ts64_mg();
 2)   0.312 us    |       } /* current_time ret=0x69380649(trunc) */
 2)   0.753 us    |     } /* atime_needs_update ret=false */
 2)   0.899 us    |   } /* touch_atime */

Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
---
 kernel/trace/trace_functions_graph.c | 124 ++++++++++++++++++++++++---
 1 file changed, 111 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 17c75cf2348e..46b66b1cfc16 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -15,6 +15,7 @@
 
 #include "trace.h"
 #include "trace_output.h"
+#include "trace_btf.h"
 
 /* When set, irq functions might be ignored */
 static int ftrace_graph_skip_irqs;
@@ -120,6 +121,13 @@ enum {
 	FLAGS_FILL_END   = 3 << TRACE_GRAPH_PRINT_FILL_SHIFT,
 };
 
+enum {
+	RETVAL_FMT_HEX   = BIT(0),
+	RETVAL_FMT_DEC   = BIT(1),
+	RETVAL_FMT_BOOL  = BIT(2),
+	RETVAL_FMT_TRUNC = BIT(3),
+};
+
 static void
 print_graph_duration(struct trace_array *tr, unsigned long long duration,
 		     struct trace_seq *s, u32 flags);
@@ -865,6 +873,73 @@ static void print_graph_retaddr(struct trace_seq *s, struct fgraph_retaddr_ent_e
 
 #if defined(CONFIG_FUNCTION_GRAPH_RETVAL) || defined(CONFIG_FUNCTION_GRAPH_RETADDR)
 
+static void trim_retval(unsigned long func, unsigned long *retval, bool *print_retval,
+			int *fmt)
+{
+	const struct btf_type *t;
+	char name[KSYM_NAME_LEN];
+	struct btf *btf;
+	u32 v, msb;
+	int kind;
+
+	if (!IS_ENABLED(CONFIG_DEBUG_INFO_BTF))
+		return;
+
+	if (lookup_symbol_name(func, name))
+		return;
+
+	t = btf_find_func_proto(name, &btf);
+	if (IS_ERR_OR_NULL(t))
+		return;
+
+	t = btf_type_skip_modifiers(btf, t->type, NULL);
+	kind = t ? BTF_INFO_KIND(t->info) : BTF_KIND_UNKN;
+	switch (kind) {
+	case BTF_KIND_UNKN:
+		*print_retval = false;
+		break;
+	case BTF_KIND_STRUCT:
+	case BTF_KIND_UNION:
+	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
+		if (kind == BTF_KIND_STRUCT || kind == BTF_KIND_UNION)
+			*fmt = RETVAL_FMT_HEX;
+		else
+			*fmt = RETVAL_FMT_DEC;
+
+		if (t->size > sizeof(unsigned long)) {
+			*fmt |= RETVAL_FMT_TRUNC;
+		} else {
+			msb = BITS_PER_BYTE * t->size - 1;
+			*retval &= GENMASK(msb, 0);
+		}
+		break;
+	case BTF_KIND_INT:
+		v = *(u32 *)(t + 1);
+		if (BTF_INT_ENCODING(v) == BTF_INT_BOOL) {
+			*fmt = RETVAL_FMT_BOOL;
+			msb = 0;
+		} else {
+			if (BTF_INT_ENCODING(v) == BTF_INT_SIGNED)
+				*fmt = RETVAL_FMT_DEC;
+			else
+				*fmt = RETVAL_FMT_HEX;
+
+			if (t->size > sizeof(unsigned long)) {
+				*fmt |= RETVAL_FMT_TRUNC;
+				msb = BITS_PER_LONG - 1;
+			} else {
+				msb = BTF_INT_BITS(v) - 1;
+			}
+		}
+		*retval &= GENMASK(msb, 0);
+		break;
+	default:
+		*fmt = RETVAL_FMT_HEX;
+		break;
+	}
+}
+
 static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entry *entry,
 				struct ftrace_graph_ret *graph_ret, void *func,
 				u32 opt_flags, u32 trace_flags, int args_size)
@@ -873,7 +948,7 @@ static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entr
 	unsigned long retval = 0;
 	bool print_retaddr = false;
 	bool print_retval = false;
-	bool hex_format = !!(opt_flags & TRACE_GRAPH_PRINT_RETVAL_HEX);
+	int retval_fmt = 0;
 
 #ifdef CONFIG_FUNCTION_GRAPH_RETVAL
 	retval = graph_ret->retval;
@@ -884,17 +959,35 @@ static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entr
 	print_retaddr = !!(opt_flags & TRACE_GRAPH_PRINT_RETADDR);
 #endif
 
-	if (print_retval && retval && !hex_format) {
-		/* Check if the return value matches the negative format */
-		if (IS_ENABLED(CONFIG_64BIT) && (retval & BIT(31)) &&
-			(((u64)retval) >> 32) == 0) {
-			err_code = sign_extend64(retval, 31);
-		} else {
-			err_code = retval;
+	if (print_retval) {
+		int fmt = RETVAL_FMT_HEX;
+
+		trim_retval((unsigned long)func, &retval, &print_retval, &fmt);
+		if (print_retval) {
+			if (opt_flags & TRACE_GRAPH_PRINT_RETVAL_HEX)
+				retval_fmt = RETVAL_FMT_HEX;
+
+			if (retval && retval_fmt != RETVAL_FMT_HEX) {
+				/* Check if the return value matches the negative format */
+				if (IS_ENABLED(CONFIG_64BIT) && (retval & BIT(31)) &&
+					(((u64)retval) >> 32) == 0) {
+					err_code = sign_extend64(retval, 31);
+				} else {
+					err_code = retval;
+				}
+
+				if (!IS_ERR_VALUE(err_code))
+					err_code = 0;
+			}
+
+			if (retval_fmt == RETVAL_FMT_HEX) {
+				retval_fmt |= (fmt & RETVAL_FMT_TRUNC);
+			} else {
+				if (err_code && fmt & RETVAL_FMT_HEX)
+					fmt = (fmt & ~RETVAL_FMT_HEX) | RETVAL_FMT_DEC;
+				retval_fmt = fmt;
+			}
 		}
-
-		if (!IS_ERR_VALUE(err_code))
-			err_code = 0;
 	}
 
 	if (entry) {
@@ -921,10 +1014,15 @@ static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entr
 				    trace_flags, false);
 
 	if (print_retval) {
-		if (hex_format || (err_code == 0))
+		if (retval_fmt & RETVAL_FMT_HEX)
 			trace_seq_printf(s, " ret=0x%lx", retval);
+		else if (retval_fmt & RETVAL_FMT_BOOL)
+			trace_seq_printf(s, " ret=%s", retval ? "true" : "false");
 		else
-			trace_seq_printf(s, " ret=%ld", err_code);
+			trace_seq_printf(s, " ret=%ld", err_code ?: retval);
+
+		if (retval_fmt & RETVAL_FMT_TRUNC)
+			trace_seq_printf(s, "(trunc)");
 	}
 
 	if (!entry || print_retval || print_retaddr)
-- 
2.34.1



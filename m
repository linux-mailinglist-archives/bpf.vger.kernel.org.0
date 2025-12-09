Return-Path: <bpf+bounces-76364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2B3CAFE0D
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 13:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3310A3015594
	for <lists+bpf@lfdr.de>; Tue,  9 Dec 2025 12:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59BF1E2606;
	Tue,  9 Dec 2025 12:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OA069yn6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A283E321F5F
	for <bpf@vger.kernel.org>; Tue,  9 Dec 2025 12:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765282443; cv=none; b=skdvpPuluunDKbPwAe7fkm0QOQK/H+/P3GYjKEv+ASSAuNwxh17pKpa8Vdr8BmVNjzIq72AwSIWRleGZPQEMEpb0DMeW/b8Zs+sngfuahEEojxOq/PKWbBWkBGCFcT0TIZrxmzhg/uceWs23qgDW1I2R6ozQX7dZduLr7rcb6/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765282443; c=relaxed/simple;
	bh=x1EZDXwpBtHEAJwiUMWKxwGt4FVIKlZiGWUwN6Sc5P8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZC1vzc0nqhgmxUZY4W0Hef4UA581HC2h1TBzR0tHp5sZVbyuzAWWPiRAlWilqjOuE0taf/tz4GdOKGkHo1Tzgt9rfJUSeKicGsGpIaxQ0/imCGSXJ7q8AZyKCyyMY91qpnQIz3FktCsz/S27hYxVa+Ek624Z3Cwm3+eToExPCR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OA069yn6; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7b8eff36e3bso8570272b3a.2
        for <bpf@vger.kernel.org>; Tue, 09 Dec 2025 04:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765282441; x=1765887241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xd9WY+m6+WX7Pur4QkVKIOZEntT/jaxLPiAk2vWokIQ=;
        b=OA069yn6MSRr+Og7FXrjNdhBMlN8ehPlTfUcpYhHzdlNbW4TC6pMg8DQW3fBLqUB3v
         T5iMLWsrqex3PD2Yqhl492WL2c9I+yk/yum3gzieNd35DK0l/0gzaE+esg/UGE1uJPY7
         XpUp/YwdanA+tc11yV0m9/ZhKmy9HlaaXp1qMb6EvzZvK1Kne0lybESVlOltYntBvMWr
         GnMF3HyiG7eQj8xrmYvn+1u1wbT7yyeiH4uqLSy6HM9YbRE7y2e/le1rkvDaR7r8F42T
         +zAkG5A1VVmc3RyB46FD/StNaOsmjTWAkEuIl7Nu1oSg0rpBBCiZkgzEb0SYTpV5F+ls
         Goyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765282441; x=1765887241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xd9WY+m6+WX7Pur4QkVKIOZEntT/jaxLPiAk2vWokIQ=;
        b=ExVG7pJSGNVRW19mfDA8CLOASbZyPhgJT+GoJD29sA387t3eZOPnUz1VnITp74dgBN
         tq31rJV+L1PYfxwD+MUMh9HkSGvXlFD6YLuF8eyJ9/6dbiKXS7yEutVprSL0pstafmwS
         zRUWLEnsv1In5pwwZxnQKSGaZtyJTUYqH3DOs4wivy1XdlL+9m07uzAlq4q3ECZE8Ac8
         THP54bXRnmEVJXAoSz8l813ld4y4m9OU7Rp73Y6WQBt1dyjISrz/OKA88h4d+qdM10hw
         sebYot2l7PRXOXbZlCrH/SBfGPtOW024oofzjukSC6xxqmaeKu+XIcR3i8woV2vWdA2G
         n2xA==
X-Forwarded-Encrypted: i=1; AJvYcCWQsYzQ9zMla8bCT/8pa8aIaXuX0X3fHIS2w9cPPqLSEkZfidKoRni4dGQfN/stn8N/Llc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzUrIu7npWQWfeyIfNsx+cPhUVq63enttdwvwg6fua9QswkzzL
	JWHrneyDj3NEpLYFEyX3MRuuvmRsy3XJ+lWolar+cpV1eulaZ9an/OFQ4KVLfJQVwB4=
X-Gm-Gg: ASbGncsVReKAmmgGxArQOgnZQ/MVRSkYQ7BkDotYKu6ppCNdvJwO/PHT0Oq5e6GACDd
	HTJ08n6nOwAKZHbbGeA7Xsvi0oOF47YgJrLzpg9G/+d8kVQPJooODnW4q4FyTu+Jt0T6B+RuyzK
	yP5fyFcqaLibJEJsSKkeVp8grfrNf7v57vofZXgqZ4cX0viJN3538+mbF7Yh0ZHB1AgZ+FzJKhy
	o6ySyhzMO4bDyxOswRrYBXGqTTDxi1931zrJCWWBzLnk7cs0TIIpygO9pybLi6NF5eDWFGgfOoM
	n53EWF4xhtZVYU8W2snpSZj1xbxyRrDWO85qEzjbd4TaYrZhWRSlJA139CMiGHppBxUGmKte6Pl
	lqLGIAiOMVpPhHK3ZVlPCpZQfm+9M5avk3LahCS/sto9McW31pDDg5/WP7qjnjGdTYaAUjabVie
	0TIc6GyXzp6fncocKtXzvT8jplpC0DKUjc9kbujQ==
X-Google-Smtp-Source: AGHT+IHnL8h4iPh68HebIIjK5biqwtKYROqay2GVZXGuZd32fD9IKVY9z2xFvcNNo8rKYOxEx25URQ==
X-Received: by 2002:a05:6a21:7781:b0:366:2476:db4a with SMTP id adf61e73a8af0-36624775150mr8292105637.59.1765282440824;
        Tue, 09 Dec 2025 04:14:00 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0724e9888esm4776a12.14.2025.12.09.04.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 04:13:59 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>,
	Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Subject: [PATCH v3 1/2] fgraph: Enhance funcgraph-retval with BTF-based type-aware output
Date: Tue,  9 Dec 2025 20:13:48 +0800
Message-Id: <20251209121349.525641-2-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251209121349.525641-1-dolinux.peng@gmail.com>
References: <20251209121349.525641-1-dolinux.peng@gmail.com>
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



Return-Path: <bpf+bounces-74487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6279C5C439
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 10:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A42284233AC
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 09:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBEA303C9E;
	Fri, 14 Nov 2025 09:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEROZlaW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945353054F5
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 09:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112307; cv=none; b=pJ7eAjZFI5YURBK2e+wE9tNfAJm01BPonfA4pYdoNIHWBDk5OF1To3z502cJ6+TXmI1xS+4SNq3e76NEWZNZYXlxPfu4ArE6sOVcIvicHXRDLAg/2QC/tEu2Cq2vfs2BGzW4Muk6f/c6zLmd0QdoSYezsddOw/528uL+jiLPEOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112307; c=relaxed/simple;
	bh=S0ECY3J4eY0S5MNW8rLP5hJohbui7zvgamXvzag6zbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bccYwLM+HbxfHSvZNghg64hl8L5/utSCqLGyRePNYM2myUJzUlO2IaKBxcc/ZQW9Jua5VWkuqOSLawBzC7XHSZ9pzc4HByY/xPoLXjwSGKL58GV8BiJFWoS9TM4zpWdlq8zE0c1cOexLMvevFEPK5/wZalBkoiN3y2t/7In9Tfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEROZlaW; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-297e982506fso19955075ad.2
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 01:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763112304; x=1763717104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5AEyxkBUzWQX1qPT1Lf5tl2SWOdn4lIjFoqvWNFFWs=;
        b=aEROZlaWHJLaj7IaklCRtTDlcCI2NHdeeEeSwRlV20jKz0x88Vf/sALXcUw88b/7Py
         aA0gSKPXMWQ2sFFOb+KdE65/HQit0w/OV6AreHSXgmebytivLE/VcYlUnee831kZ8BR4
         89XjWAKeVCj092zA7Vi4HBebQtopfI46yeTVgXc6Oh+8Xx8tiHkLKBAu+HgavvRlTZ9q
         5Ud7RGX038yfwfkLvnOcH06ofFEhZmjRt9hvYSbaVRTLYCV1JkvUxegULl/npM/UdYRZ
         Mfo1JcXgYFhcUMZOyRej/9LxhQpJoMYkYkG30FjhmWIbPkDGr4sS/0wbA9YimTo2OrGi
         otlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763112304; x=1763717104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y5AEyxkBUzWQX1qPT1Lf5tl2SWOdn4lIjFoqvWNFFWs=;
        b=VRsNv6yAo8T6mkdsV289m1Gf37O5k8XTC2/tBXWsoe7PGA164FOEvq8g3stUUIeddl
         3eVDzP10wxYXhTd8yS5pue18b1g0U+VzD2i+7gZSECN2OI9/bZtFezsqpmHlJ5JGl2wn
         4T/NRMRSEuGmFfMHXFGgW7eN2i+nTBIvvzT6EvJv/a6+ftAThSqSwa8LWfsp2P4CREpT
         D2DVnQ3dfS8j4MTYtAsNJhy7iAOfRlk/yEBFtw2CBIyOBQtwp8elTLZ1fQmt1laFPimE
         7a7cR+28KWIl4NF9ce3CEI6cl0NgtIYhtI5rac3vXxoM9qHdeodNfqpVkCZmZxrpy4Ia
         WXuA==
X-Forwarded-Encrypted: i=1; AJvYcCW7dOgEjKtELwG3aTMS9XiKS3h2JSYfzKeJsUdmkoPIKcwWMJXQqsQWLc4Zhhjz/ZOmnOk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb8xFyU7yTde8FscZZJifA5OstZN843ttbES3FGixcg8phwUr4
	VZ7OIXdgbFr9O/T0NrPlfTAOtDR9wR/pcq97MH1ni0yT3Si2wG6eRC/o
X-Gm-Gg: ASbGnctOkBNKZ/8PxjF07PIHFZW1u0yeeeWKCkmAJhK+vfceqBIAvBV+b4vE4mkdjqG
	Bh9ylw9PqUjCNNxUdT4bwjQxOiACLJx9gW5D7bduTR1AtekUh1rCIIXijibPkJR8Hvf+Rc+rjQK
	lvSnTfgfXfDq7nZkxqSpKP9+OTQUSo3ORqooLaxPTgGYekDNLKV1N6+FcDWTO8as+tWp8CtqIrq
	ixWzJVUa5/hribETF7PwPb39WZ5olJV3OckCl/jay8yjqD47s7xnx+IMm1lzDuef1j8Sw9mZI7l
	+AW5UlU27O9xclyNzQCSGv7XoX3936yOXvYzcVp++uVd2eyDuirxhWfB/poIQ/keasF1Qe6Ku04
	gEg83UF9tlSVXWbMPVKECpgY4Q1qATrAsytYrBY5HYEZzoKzZN7I4ME5XyjZjcbSLgON6/mJB5U
	AZf3qcH2Sgwmc=
X-Google-Smtp-Source: AGHT+IFnh52crzYkS3TAz7VEtpDOKOIs0IFpocAnXLP18gr0pPhgLCo1zXXKhdHJbPjGce+rZZ8OBQ==
X-Received: by 2002:a17:902:da83:b0:298:90f:5b01 with SMTP id d9443c01a7336-2986a76f3e0mr26574065ad.52.1763112303652;
        Fri, 14 Nov 2025 01:25:03 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2346dasm50451525ad.7.2025.11.14.01.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 01:25:03 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	rostedt@goodmis.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH RFC bpf-next 1/7] ftrace: introduce FTRACE_OPS_FL_JMP
Date: Fri, 14 Nov 2025 17:24:44 +0800
Message-ID: <20251114092450.172024-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251114092450.172024-1-dongml2@chinatelecom.cn>
References: <20251114092450.172024-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, the "nop" will be replaced with a "call" instruction when a
function is hooked by the ftrace. However, sometimes the "call" can break
the RSB and introduce extra overhead. Therefore, introduce the flag
FTRACE_OPS_FL_JMP, which indicate that the ftrace_ops should be called
with a "jmp" instead of "call". For now, it is only used by the direct
call case.

When a direct ftrace_ops is marked with FTRACE_OPS_FL_JMP, the last bit of
the ops->direct_call will be set to 1. Therefore, we can tell if we should
use "jmp" for the callback in ftrace_call_replace().

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/ftrace.h | 33 +++++++++++++++++++++++++++++++++
 kernel/trace/Kconfig   | 12 ++++++++++++
 kernel/trace/ftrace.c  |  9 ++++++++-
 3 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 7ded7df6e9b5..14705dec1b08 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -351,6 +351,7 @@ enum {
 	FTRACE_OPS_FL_DIRECT			= BIT(17),
 	FTRACE_OPS_FL_SUBOP			= BIT(18),
 	FTRACE_OPS_FL_GRAPH			= BIT(19),
+	FTRACE_OPS_FL_JMP			= BIT(20),
 };
 
 #ifndef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
@@ -569,6 +570,38 @@ static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs,
 						 unsigned long addr) { }
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_JMP
+static inline bool ftrace_is_jmp(unsigned long addr)
+{
+	return addr & 1;
+}
+
+static inline unsigned long ftrace_jmp_set(unsigned long addr)
+{
+	return addr | 1UL;
+}
+
+static inline unsigned long ftrace_jmp_get(unsigned long addr)
+{
+	return addr & ~1UL;
+}
+#else
+static inline bool ftrace_is_jmp(unsigned long addr)
+{
+	return false;
+}
+
+static inline unsigned long ftrace_jmp_set(unsigned long addr)
+{
+	return addr;
+}
+
+static inline unsigned long ftrace_jmp_get(unsigned long addr)
+{
+	return addr;
+}
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_JMP */
+
 #ifdef CONFIG_STACK_TRACER
 
 int stack_trace_sysctl(const struct ctl_table *table, int write, void *buffer,
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index d2c79da81e4f..4661b9e606e0 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -80,6 +80,12 @@ config HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
 	  If the architecture generates __patchable_function_entries sections
 	  but does not want them included in the ftrace locations.
 
+config HAVE_DYNAMIC_FTRACE_WITH_JMP
+	bool
+	help
+	  If the architecture supports to replace the __fentry__ with a
+	  "jmp" instruction.
+
 config HAVE_SYSCALL_TRACEPOINTS
 	bool
 	help
@@ -330,6 +336,12 @@ config DYNAMIC_FTRACE_WITH_ARGS
 	depends on DYNAMIC_FTRACE
 	depends on HAVE_DYNAMIC_FTRACE_WITH_ARGS
 
+config DYNAMIC_FTRACE_WITH_JMP
+	def_bool y
+	depends on DYNAMIC_FTRACE
+	depends on DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	depends on HAVE_DYNAMIC_FTRACE_WITH_JMP
+
 config FPROBE
 	bool "Kernel Function Probe (fprobe)"
 	depends on HAVE_FUNCTION_GRAPH_FREGS && HAVE_FTRACE_GRAPH_FUNC
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index efb5ce32298f..8d7b2a7f4b15 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5938,7 +5938,8 @@ static void remove_direct_functions_hash(struct ftrace_hash *hash, unsigned long
 	for (i = 0; i < size; i++) {
 		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
 			del = __ftrace_lookup_ip(direct_functions, entry->ip);
-			if (del && del->direct == addr) {
+			if (del && ftrace_jmp_get(del->direct) ==
+				   ftrace_jmp_get(addr)) {
 				remove_hash_entry(direct_functions, del);
 				kfree(del);
 			}
@@ -5994,6 +5995,9 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 
 	mutex_lock(&direct_mutex);
 
+	if (ops->flags & FTRACE_OPS_FL_JMP)
+		addr = ftrace_jmp_set(addr);
+
 	/* Make sure requested entries are not already registered.. */
 	size = 1 << hash->size_bits;
 	for (i = 0; i < size; i++) {
@@ -6117,6 +6121,9 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 
 	lockdep_assert_held_once(&direct_mutex);
 
+	if (ops->flags & FTRACE_OPS_FL_JMP)
+		addr = ftrace_jmp_set(addr);
+
 	/* Enable the tmp_ops to have the same functions as the direct ops */
 	ftrace_ops_init(&tmp_ops);
 	tmp_ops.func_hash = ops->func_hash;
-- 
2.51.2



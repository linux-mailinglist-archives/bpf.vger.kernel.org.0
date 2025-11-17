Return-Path: <bpf+bounces-74687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C75ABC62462
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 04:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 514504E84CC
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 03:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1CC314D2E;
	Mon, 17 Nov 2025 03:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YB9odUOS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64AD226CFD
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 03:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763351364; cv=none; b=KoHqKZlxWjBGFKvdYjYZk+J+RdhLONi85ZPRMQs7YF4rhAliZHwPmgiQj1H6Quxj5xs3dxf1l1BrymPihqJZSJBw9R+K7DbqdfkS0bGdXP65TKzZOj3UZKVOfrHQVXnCNjPS0OdsXiHE2Pd1j4u/4jcsI48/L8CKzNwQRnXW/eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763351364; c=relaxed/simple;
	bh=eN8XLnT7oDDbVfBQj9WK/lxzOCXsGmTMCnuXBGXGsuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IrnHMHM4u74v1fyikkfc/b0AbFG/WYwHwOQx9ekRXiPURzE6PeaIjXcMdihiA4yUsKMHAEhtZG/MvTprSYqOVPeeXEhWm1PlnglAuPz81FsNEZxFqz/vBp2cZ0aFl7119C1Pr0XZoVlVZxNV/lGm9ZpO2DUQaSIL2Mljb9PfOX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YB9odUOS; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-343684a06b2so3374734a91.1
        for <bpf@vger.kernel.org>; Sun, 16 Nov 2025 19:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763351361; x=1763956161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tB6Rux0HrLKcgyll4hZbEBMFFfGOp9PtogHaw5ekHkk=;
        b=YB9odUOSt3QaSuY1CE6bSAlUnwP8jWfvN2KmY9jm/a2GAPgWKQc/NZvt5yRzxkcpF3
         33chlIBSEYM/hNRhZPRcoh2BHsO0AMeRwdZ7C+gzOjTCUtzbTXwcv3eLKkjb7ZeA7vmj
         MksRaAfr2RamGsipWi8fHeHY4CSbk8bZu//xIpMm7PiPtCKQeGZ8mkAr6Od+VqutpjZK
         uNH2QJpyqnxNQzl/FgEKLng+OPshMc3WXogmijXcIA3g/gObLe2YkPI43ywmUr1kFXPk
         FywprulMk+GeZuf9DRJy2SUcqf8xtarXKTn1auQiNan+Cq0twTJtlaBLd+ImR4S7GAVd
         zigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763351361; x=1763956161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tB6Rux0HrLKcgyll4hZbEBMFFfGOp9PtogHaw5ekHkk=;
        b=H7m622Zo62tri0PgyOtIhvxQ1XoGJ9dnEY9kA61DkdKeA4X5rpcC2+IXAaLbjZcrDf
         q7MreDyxnS/x5GFpdXMW5mtRZcCElcIYKs/TArgU4qPH2cpC1QTfopgnKjcYlGf1GCPP
         xycvEhy2TloSc9jyCo0WtPP44nQh/T9Lxo6ftURWmjMOBAzs/f2nMoQxUjHYgJbsuzJB
         t8zr7ZiKlL59R5HrRTFzqJtzI4NL+Jru8vcwNWDFnRyCwnlb/kFdoKKFbtBHoyri6+N4
         f1W+JWbtmyzlIvMCdc7xyJOdO5qslpj+a+Twii+Kp0yztWfG0BToE5tFVin2R/zFT4zi
         Q3qQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7b4C+L1VEDnZNg2ql7B3KlrOHxykjhT7wQJESCSXhU8qD0jKMIzYQdwhfuAf4JBYrchU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPuWluMnLYSOPywowl74Xo3SX/FY/mDLl/U02ZQ2CwIdwKZwft
	hpclYGi5DvHYLFe7YXLH6QaLRgYtUdMpH1IwAl5d9IqxEYuOXUnS3lYT
X-Gm-Gg: ASbGnct1lL7L8JzKNjIy9yRMxA07YWW0REoX2tzJYr+D46KlNAUY8WjhTQHNRQzz9DJ
	wzLjloFec1gwKD8jB4Uast38Ba4zeAqc6NnVLSoProDox7w6JRXCIB3UpB0pzo8YwaL50y3/lhT
	S07/Eiks+N0t/SSBovUmw44AnGRwmfItZhIgHIi+0HIpzDXTFRH+BnvWJhLZS+E7TJZ6cDMkxfo
	+bSmLIA83PWk3OLkGYk9MCMsD1PUQplocITYjIverlitoM/ynLae6ulqN7EfQalIjiNsfnb3f5f
	CezoYzSvbnAwEbNMKjs0x4idxDG4z9XAexE2Bg/6L7gS2S+jQ4PtREecJBHBXZxy1KIyeX6UqSp
	4GA6L+fUwvYV6yF4Wf14rFZyRZ21sdjmoE+rAfG/Rb76Rx5mGsloOJJ9WXIPsd7idFCEyoFkqKO
	lJ
X-Google-Smtp-Source: AGHT+IHd1el4WKJ8buLYRG3q/1pExUSAcCsDzHZs0s3Ph2PwZFUd1QCWFuHC2Xz4Nk7dDgEi1CtzGw==
X-Received: by 2002:a17:90a:da8d:b0:341:a9e7:e5f9 with SMTP id 98e67ed59e1d1-343f99c41admr11436935a91.0.1763351360865;
        Sun, 16 Nov 2025 19:49:20 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc37703a0d9sm10348179a12.31.2025.11.16.19.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 19:49:20 -0800 (PST)
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
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 1/6] ftrace: introduce FTRACE_OPS_FL_JMP
Date: Mon, 17 Nov 2025 11:49:01 +0800
Message-ID: <20251117034906.32036-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251117034906.32036-1-dongml2@chinatelecom.cn>
References: <20251117034906.32036-1-dongml2@chinatelecom.cn>
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
index 07f8c309e432..015dd1049bea 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -359,6 +359,7 @@ enum {
 	FTRACE_OPS_FL_DIRECT			= BIT(17),
 	FTRACE_OPS_FL_SUBOP			= BIT(18),
 	FTRACE_OPS_FL_GRAPH			= BIT(19),
+	FTRACE_OPS_FL_JMP			= BIT(20),
 };
 
 #ifndef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
@@ -577,6 +578,38 @@ static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs,
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
index 59cfacb8a5bb..a6c060a4f50b 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5951,7 +5951,8 @@ static void remove_direct_functions_hash(struct ftrace_hash *hash, unsigned long
 	for (i = 0; i < size; i++) {
 		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
 			del = __ftrace_lookup_ip(direct_functions, entry->ip);
-			if (del && del->direct == addr) {
+			if (del && ftrace_jmp_get(del->direct) ==
+				   ftrace_jmp_get(addr)) {
 				remove_hash_entry(direct_functions, del);
 				kfree(del);
 			}
@@ -6018,6 +6019,9 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 
 	mutex_lock(&direct_mutex);
 
+	if (ops->flags & FTRACE_OPS_FL_JMP)
+		addr = ftrace_jmp_set(addr);
+
 	/* Make sure requested entries are not already registered.. */
 	size = 1 << hash->size_bits;
 	for (i = 0; i < size; i++) {
@@ -6138,6 +6142,9 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 
 	lockdep_assert_held_once(&direct_mutex);
 
+	if (ops->flags & FTRACE_OPS_FL_JMP)
+		addr = ftrace_jmp_set(addr);
+
 	/* Enable the tmp_ops to have the same functions as the direct ops */
 	ftrace_ops_init(&tmp_ops);
 	tmp_ops.func_hash = ops->func_hash;
-- 
2.51.2



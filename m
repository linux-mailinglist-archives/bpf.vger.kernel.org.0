Return-Path: <bpf+bounces-74954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C449C696C9
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 13:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E32D4E52A0
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 12:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDB4355039;
	Tue, 18 Nov 2025 12:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBSSvhsI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159993546FC
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763469418; cv=none; b=JjjhbISbar0WAuP7NZ16sZJ55x92cqywhDS37gTaAKuwGFTio7y8Tmb3dcOOTi6ViSaHJaw5J+8dBoN+wRe+c00W3Y0HXhI0Ohu7+jEmKh2GttBRR5e6eDVtUYWfG+FDV5FqRQYj5jSGh3Rk1u8ycvpN7PVcKs92D5QAQOBVR6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763469418; c=relaxed/simple;
	bh=HfdqWCvCXsXMTJZ0UXs4yz02O0KD4yDebfnbUfc9UBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=duGZzwBIX77MMhtnYuNkO44EYF5RVzJxCPBHr4MTtrEFzw7nZZFlnUAhnsrCl/lsZsuw3Tw5VOygvh8natrWwEs9/peELF8mPTcQ48+Fg41KFPxxOr5EqsnsRwad2Jjz9LncGd/BO/PWyzYk9SepwyyHnEHwGEyQuSkPwqEKnOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBSSvhsI; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so4465396b3a.1
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 04:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763469415; x=1764074215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGjFhDeMxWrGazpljFY/Z83jYWiFR4RMAA/Pm2GV6ZI=;
        b=LBSSvhsI1sqOJPY7QAQUtWmbtl419gPdfOjJSFQDG6LzPdUeCnZqt0Mf4xYV//cBD+
         puymsRS1DcZlug9FKhG2mm+2fGhbW7Gb4Jh9k5lFzhjv5ROnlPyhcjOviVE3aPW/Cci7
         C3lMqFQ1tzBX0hy/1668QvsDO1Zq+D/WvtsFlO1Tpe9NUDgBEnAUEmaHCgGqzfTndGTq
         N3uAOPb4hsRbuHGFo2hNwj1ooD7aBMMK/kxhWGsURSO0NpyAecmstap2hNjRWpxhIlBF
         UBtd51TxmKFBDpMwsGD2D+QGb19nxsUFGv/9RcbaJKZPRilhTgRFoRE0zzQ8ZToW7EzM
         /9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763469415; x=1764074215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cGjFhDeMxWrGazpljFY/Z83jYWiFR4RMAA/Pm2GV6ZI=;
        b=qRLB1irC4hwK9GlS4uoxQFf3DpRxWaQ7kjgV/egAJEL+NdBxbiSgamSqPQdv2Fo4nK
         HicASPlTPDurqADc2xrKpJ3bz1EXb6ELaexxlabZNqkDSnhyRJGCgbUbpPVHQKA1I5+6
         oNE9MPPAfYgiWl/lLK4PRfhTO/tmh3fV1qBoloytRi7jNYJkKjBnUO/q8zcAUkNtqke4
         bNJZI2WNuVZehd6gyYWvX2jXgXXv4oi/9UHg0xIUUZVIInb99ToDpGXdxalJ2tAN+yZb
         Fs2ACtTdkvPviJ67gsa2AjcCcExC9WTbdYhRl+sYyfpAe0zRQ84E8KuXdfuY8QpVTnfc
         4vqA==
X-Forwarded-Encrypted: i=1; AJvYcCX5FAQYJyk+4aQELnKC8+viG7VuQhpx5c2wc7CTFScYBLXlqujfhpbz0M9ildsE8GDskoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRFTw/+y5PFXSkcgjpdveopf/835CQk5kvUKF/aa8b+8X4QK4q
	Hx61oFrtDnCxVaUCjtZxRXFPZ76CBjgXFrRun6N82roo4qiopVd4mI/f
X-Gm-Gg: ASbGncteY0JIROiQeL0qtxRA/nERst/Nb7iC2AlmKVD9ECj9+gj3Gl6tP0otyhJ7phV
	YKVQnQMHxaOnLwdIzGa/AbQVxQG0KEZ5vbNLcBU+Xho0iQuYEUVSvWRiC3WeH3PcrrWla812Syj
	KqQq+vwtVadeeqJflmoaXaCV9mXGvZadJIMZsGRUJnw1GJDsoHDdjK3PrvF1k3LCC4I/0BjSXzR
	U1uG/OeMibTsvcmOZ/Qfowg8NRm/yraPI05B3+0fUpXUagqRbAoMu9ZZmDuDah0YT9eBD9JE+u1
	QFy46323chbldf6DmX17bHVzoT9kdGUj8T5zXP1UXnGR9DqXxzzLBNZ1AjXx5I33ZTOnLKC+ux4
	6fGjJ1+ac6x3aLNm10pquQum9B/vnV9hyXEaWywKafywLWe5Qu1vbqhdII6xZIDkm2D14vYZ/zc
	G7TQE+2h0YuDA=
X-Google-Smtp-Source: AGHT+IHzC6fTh7q+8Nly65oI1W6f1opZTTs/1Rfi00Y9lq9IK/uPekC1SfgGQME1iV9wmsttAbLwug==
X-Received: by 2002:a05:6a00:21c5:b0:7ad:f6e8:d013 with SMTP id d2e1a72fcca58-7ba3cd668d4mr21966720b3a.32.1763469415307;
        Tue, 18 Nov 2025 04:36:55 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b92772e7f2sm16331496b3a.57.2025.11.18.04.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 04:36:55 -0800 (PST)
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
Subject: [PATCH bpf-next v3 1/6] ftrace: introduce FTRACE_OPS_FL_JMP
Date: Tue, 18 Nov 2025 20:36:29 +0800
Message-ID: <20251118123639.688444-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251118123639.688444-1-dongml2@chinatelecom.cn>
References: <20251118123639.688444-1-dongml2@chinatelecom.cn>
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
v3:
- reject if the addr is already "jmp" in register_ftrace_direct() and
  __modify_ftrace_direct()
---
 include/linux/ftrace.h | 33 +++++++++++++++++++++++++++++++++
 kernel/trace/Kconfig   | 12 ++++++++++++
 kernel/trace/ftrace.c  | 17 ++++++++++++++++-
 3 files changed, 61 insertions(+), 1 deletion(-)

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
index 59cfacb8a5bb..bbb37c0f8c6c 100644
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
@@ -6016,8 +6017,15 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 	if (ftrace_hash_empty(hash))
 		return -EINVAL;
 
+	/* This is a "raw" address, and this should never happen. */
+	if (WARN_ON_ONCE(ftrace_is_jmp(addr)))
+		return -EINVAL;
+
 	mutex_lock(&direct_mutex);
 
+	if (ops->flags & FTRACE_OPS_FL_JMP)
+		addr = ftrace_jmp_set(addr);
+
 	/* Make sure requested entries are not already registered.. */
 	size = 1 << hash->size_bits;
 	for (i = 0; i < size; i++) {
@@ -6138,6 +6146,13 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 
 	lockdep_assert_held_once(&direct_mutex);
 
+	/* This is a "raw" address, and this should never happen. */
+	if (WARN_ON_ONCE(ftrace_is_jmp(addr)))
+		return -EINVAL;
+
+	if (ops->flags & FTRACE_OPS_FL_JMP)
+		addr = ftrace_jmp_set(addr);
+
 	/* Enable the tmp_ops to have the same functions as the direct ops */
 	ftrace_ops_init(&tmp_ops);
 	tmp_ops.func_hash = ops->func_hash;
-- 
2.51.2



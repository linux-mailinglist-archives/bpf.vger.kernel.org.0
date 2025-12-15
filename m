Return-Path: <bpf+bounces-76634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A2296CBFE21
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 22:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3727C301AB3B
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 21:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D67329C5D;
	Mon, 15 Dec 2025 21:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCNG5YZ/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E20525F99B;
	Mon, 15 Dec 2025 21:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765833288; cv=none; b=YBf+EfjVaNf3MIuTnvzvarXIi/QZ7uVg9+cKZSSLDuqq74pRYEENHmqB2yqIN4CAXPTInzeS0eSf5+QW7lV7RPPBsDXqaLtN4L62yYidyIY+YjjwFobkBePFJdRrNSU9JWrjBcFESkZQwU3Rw23TKXBP8625tT/FKZDRR1ZzKn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765833288; c=relaxed/simple;
	bh=5BIA2Tyu/z9yvlHVqz+8RZrzeJHV2LsScF4IznePJN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJzP/ozz0VEjulo3StFsO+cC+SCN7FQ0FAXIl5HrP0JceuHu4uIoiQOrxWYMTIRv+4KuzFt3WP1nYcfcwfv6C1pBcwaaC8T1YTmSZ91osQTv/2vkUkhqchjSJzUv4xf2F0qcYAAoMknk5ZagAK8Z6OOWZZZjRZ4o0RoTE95qDI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCNG5YZ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4F9C16AAE;
	Mon, 15 Dec 2025 21:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765833286;
	bh=5BIA2Tyu/z9yvlHVqz+8RZrzeJHV2LsScF4IznePJN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GCNG5YZ/B9+6hVu+xSNbOtmFI7uZsIXZBken7R3nGGQWf34LGkwO6OGh164QCEP2P
	 4FlSwymFe6pae84FKnioTliiflZKgH047OxcQ4SK0Rg6anazjy5J2J/9nyGPQhPKHe
	 lFNs0xGT9Q8zOTWV7jeSA5pOyMkfvrf+tFTdZMGpyaeTzEtGssAPfHbLVpIylaHNIZ
	 dCXlw/+Ppgxt7boUH7CsZJxxrd29LuCmfCZ4M2l62QQeEaBr6jkxPWa6f9MCvDWQaY
	 6e5nnJQmhyrcZUyCQzDkz05LlNzlMnkEoNwZOQRob4xf6NX80fVQDc0NmWcsRJxtwA
	 lGJxmFO2d5Dvg==
From: Jiri Olsa <jolsa@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>,
	Florent Revest <revest@google.com>,
	Mark Rutland <mark.rutland@arm.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Song Liu <song@kernel.org>
Subject: [PATCHv5 bpf-next 3/9] ftrace: Export some of hash related functions
Date: Mon, 15 Dec 2025 22:13:56 +0100
Message-ID: <20251215211402.353056-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215211402.353056-1-jolsa@kernel.org>
References: <20251215211402.353056-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are going to use these functions in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/ftrace.h | 9 +++++++++
 kernel/trace/ftrace.c  | 7 +++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 505b7d3f5641..c0a72fcae1f6 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -82,6 +82,7 @@ static inline void early_trace_init(void) { }
 
 struct module;
 struct ftrace_hash;
+struct ftrace_func_entry;
 
 #if defined(CONFIG_FUNCTION_TRACER) && defined(CONFIG_MODULES) && \
 	defined(CONFIG_DYNAMIC_FTRACE)
@@ -405,6 +406,14 @@ enum ftrace_ops_cmd {
 typedef int (*ftrace_ops_func_t)(struct ftrace_ops *op, enum ftrace_ops_cmd cmd);
 
 #ifdef CONFIG_DYNAMIC_FTRACE
+
+#define FTRACE_HASH_DEFAULT_BITS 10
+
+struct ftrace_hash *alloc_ftrace_hash(int size_bits);
+void free_ftrace_hash(struct ftrace_hash *hash);
+struct ftrace_func_entry *add_hash_entry_direct(struct ftrace_hash *hash,
+						unsigned long ip, unsigned long direct);
+
 /* The hash used to know what functions callbacks trace */
 struct ftrace_ops_hash {
 	struct ftrace_hash __rcu	*notrace_hash;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 7e3a81bd6f1e..84aee9096a9e 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -68,7 +68,6 @@
 	})
 
 /* hash bits for specific function selection */
-#define FTRACE_HASH_DEFAULT_BITS 10
 #define FTRACE_HASH_MAX_BITS 12
 
 #ifdef CONFIG_DYNAMIC_FTRACE
@@ -1185,7 +1184,7 @@ static void __add_hash_entry(struct ftrace_hash *hash,
 	hash->count++;
 }
 
-static struct ftrace_func_entry *
+struct ftrace_func_entry *
 add_hash_entry_direct(struct ftrace_hash *hash, unsigned long ip, unsigned long direct)
 {
 	struct ftrace_func_entry *entry;
@@ -1265,7 +1264,7 @@ static void clear_ftrace_mod_list(struct list_head *head)
 	mutex_unlock(&ftrace_lock);
 }
 
-static void free_ftrace_hash(struct ftrace_hash *hash)
+void free_ftrace_hash(struct ftrace_hash *hash)
 {
 	if (!hash || hash == EMPTY_HASH)
 		return;
@@ -1305,7 +1304,7 @@ void ftrace_free_filter(struct ftrace_ops *ops)
 }
 EXPORT_SYMBOL_GPL(ftrace_free_filter);
 
-static struct ftrace_hash *alloc_ftrace_hash(int size_bits)
+struct ftrace_hash *alloc_ftrace_hash(int size_bits)
 {
 	struct ftrace_hash *hash;
 	int size;
-- 
2.52.0



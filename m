Return-Path: <bpf+bounces-77515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F25FCCE9FAD
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 15:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53B233025A6E
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 14:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51345318149;
	Tue, 30 Dec 2025 14:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsHpaNMQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5388D317715;
	Tue, 30 Dec 2025 14:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767106252; cv=none; b=ofiET8UgxKgy+RmeBQfMh6JyHKPToo1qXPpqovvqwGzv2SZX+Uyo3278pe9kDKfaA4ERnGng8LJsEQ3LE1WUYrKtdUIfY3L0t1votyiStuosLk94spslciEQfL8yVGcFVoI1gDgmEKxgL+LxKaXX/4DJ9XbiMPJYodJIOuKfmCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767106252; c=relaxed/simple;
	bh=xAdRIPxz2/hvjSXbuibVtNtw7JeJSHCTtXeA/1xe6eY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PnOyND4XjSkchx9JX89reTZKwdCWNnY2lRRaVcDs7IYTJM2XHeRvOke+nz/BnAkSOg1jhSluxi7q61DrUZDHEM1ST7dK0URhBnrUA6KSdr44Qjm9xce+zy5oBoHVmZMMFg7296CcvCQ+y1YS4JIBpl6nPA/CSET1AB4o3n/YyRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsHpaNMQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC971C4CEFB;
	Tue, 30 Dec 2025 14:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767106251;
	bh=xAdRIPxz2/hvjSXbuibVtNtw7JeJSHCTtXeA/1xe6eY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SsHpaNMQWKuuIMXh4V+Y9C2r9oS3M/R/Yq/heDyjybhBN2ZZXIyBXDrbkUT6AIToF
	 Wg1WA0Jbw5rP8B3ZoKYbDkdnZ6arZNZEMAZdZ41GDmcEmUUDNWi6dsFYC4Bgy55ocf
	 qv6dRvAELINeaE9hnXrOwyyKvlnNAng6DDUEHmhCMvJIXpw19/zVEcSB/IkEhUE8RV
	 goOxorFxmZjVj3bC8T1xjsB8a1azak73xL/vbLy2YwWgGQVubsip1l1GKzz4UZLOsE
	 fEBI99K5BWwSgep2cOOsD2BW8OFhiW70ezEzPJtjwp4Fn7kntiH5PydEQoG2UHHoEY
	 tIBmoNbTwOeog==
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
Subject: [PATCHv6 bpf-next 3/9] ftrace: Export some of hash related functions
Date: Tue, 30 Dec 2025 15:50:04 +0100
Message-ID: <20251230145010.103439-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230145010.103439-1-jolsa@kernel.org>
References: <20251230145010.103439-1-jolsa@kernel.org>
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
 include/linux/ftrace.h |  9 +++++++++
 kernel/trace/ftrace.c  | 13 ++++++-------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 41c9bb08d4e4..472f2d8a4c0f 100644
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
+struct ftrace_func_entry *add_ftrace_hash_entry_direct(struct ftrace_hash *hash,
+						       unsigned long ip, unsigned long direct);
+
 /* The hash used to know what functions callbacks trace */
 struct ftrace_ops_hash {
 	struct ftrace_hash __rcu	*notrace_hash;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 409271aa8dad..3ca3aee5f886 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -68,7 +68,6 @@
 	})
 
 /* hash bits for specific function selection */
-#define FTRACE_HASH_DEFAULT_BITS 10
 #define FTRACE_HASH_MAX_BITS 12
 
 #ifdef CONFIG_DYNAMIC_FTRACE
@@ -1211,8 +1210,8 @@ static void __add_hash_entry(struct ftrace_hash *hash,
 	hash->count++;
 }
 
-static struct ftrace_func_entry *
-add_hash_entry_direct(struct ftrace_hash *hash, unsigned long ip, unsigned long direct)
+struct ftrace_func_entry *
+add_ftrace_hash_entry_direct(struct ftrace_hash *hash, unsigned long ip, unsigned long direct)
 {
 	struct ftrace_func_entry *entry;
 
@@ -1230,7 +1229,7 @@ add_hash_entry_direct(struct ftrace_hash *hash, unsigned long ip, unsigned long
 static struct ftrace_func_entry *
 add_hash_entry(struct ftrace_hash *hash, unsigned long ip)
 {
-	return add_hash_entry_direct(hash, ip, 0);
+	return add_ftrace_hash_entry_direct(hash, ip, 0);
 }
 
 static void
@@ -1291,7 +1290,7 @@ static void clear_ftrace_mod_list(struct list_head *head)
 	mutex_unlock(&ftrace_lock);
 }
 
-static void free_ftrace_hash(struct ftrace_hash *hash)
+void free_ftrace_hash(struct ftrace_hash *hash)
 {
 	if (!hash || hash == EMPTY_HASH)
 		return;
@@ -1331,7 +1330,7 @@ void ftrace_free_filter(struct ftrace_ops *ops)
 }
 EXPORT_SYMBOL_GPL(ftrace_free_filter);
 
-static struct ftrace_hash *alloc_ftrace_hash(int size_bits)
+struct ftrace_hash *alloc_ftrace_hash(int size_bits)
 {
 	struct ftrace_hash *hash;
 	int size;
@@ -1405,7 +1404,7 @@ alloc_and_copy_ftrace_hash(int size_bits, struct ftrace_hash *hash)
 	size = 1 << hash->size_bits;
 	for (i = 0; i < size; i++) {
 		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
-			if (add_hash_entry_direct(new_hash, entry->ip, entry->direct) == NULL)
+			if (add_ftrace_hash_entry_direct(new_hash, entry->ip, entry->direct) == NULL)
 				goto free_hash;
 		}
 	}
-- 
2.52.0



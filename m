Return-Path: <bpf+bounces-69487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD123B97A6A
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 23:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9593F3220A5
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 21:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9321B30FF3C;
	Tue, 23 Sep 2025 21:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENSO36TM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AB130FC36;
	Tue, 23 Sep 2025 21:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758664373; cv=none; b=c1PIFsm0kz/9MYGzjBbBQOsmhXhewQabHfSm+hO039kEgdh/RzT3PLfXXylNatasBidQNVY5KOyCNd51hyeOEEUR1JlLzi+hhaEWbPE8OsHZVfUjSEsYIzS/PcoDr0H89EPBFRB179c4yNw8MqNEVVVrq4ZF2hiY2+u7skS8m6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758664373; c=relaxed/simple;
	bh=/3umJShdbnhAxPz6ow/VdTepJxIa2+Qo1lw/fdFc2zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uvhog3Cn92QT/w7m1TKMwm5nGt+7SMJu9L3LaC80kicTYHtBV2U0WB2G8kzOvTvO9V0AUrL/I6TS2L873179OnQ+zE94qmIiUqoP84ECasPQCWDw/jyC8o9w9CZ2U+Y7p7KXH8d1RH8DIYD05cafUPy4MspGl84lBQCGguGSHBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENSO36TM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3D2C4CEF5;
	Tue, 23 Sep 2025 21:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758664372;
	bh=/3umJShdbnhAxPz6ow/VdTepJxIa2+Qo1lw/fdFc2zQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ENSO36TMfNdTqWne6KZSr2xujAgaqO/1HFu/e7x2DWmnSVQVRcSiuLT6WDKaLGUv4
	 s295SRO1S6IxfDWxqOotwhjpm9AEMgMk+IthEpy/2iXCyDIFcM+9DjUZxEqEQZ/yX/
	 CSfFHxlUoOrHSnQpUNcJ5cTh5BGsoGAMJkNJ4konyK1EYFWnc0zkzpv43SmeQJA7e7
	 YcgKOCSIA3AKXLWMoeOrE5pq20hBeg7t6SzA73RsFaFaTywUsKWsATqsEOdwUg7Qou
	 2MM5SXH93urieyBXMcTAQ3aIII7Z5K1KdnYgHSXARDe5D6RIVKR5ROlrmcA/4Zzrix
	 LGoF+Nin2S8tg==
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
	Menglong Dong <menglong8.dong@gmail.com>
Subject: [PATCH 5/9] ftrace: Export some of hash related functions
Date: Tue, 23 Sep 2025 23:51:43 +0200
Message-ID: <20250923215147.1571952-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923215147.1571952-1-jolsa@kernel.org>
References: <20250923215147.1571952-1-jolsa@kernel.org>
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
 include/linux/ftrace.h | 16 ++++++++++++++++
 kernel/trace/ftrace.c  |  7 +++----
 kernel/trace/trace.h   |  8 --------
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 1cf6d0bb9a81..a8e351df3a52 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -397,6 +397,22 @@ enum ftrace_ops_cmd {
 typedef int (*ftrace_ops_func_t)(struct ftrace_ops *op, enum ftrace_ops_cmd cmd);
 
 #ifdef CONFIG_DYNAMIC_FTRACE
+
+#define FTRACE_HASH_DEFAULT_BITS 10
+
+struct ftrace_hash {
+	unsigned long		size_bits;
+	struct hlist_head	*buckets;
+	unsigned long		count;
+	unsigned long		flags;
+	struct rcu_head		rcu;
+};
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
index 4eb08817e4ee..75bea44e4f8e 100644
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
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 5f4bed5842f9..5070aafa590c 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -899,14 +899,6 @@ enum {
 	FTRACE_HASH_FL_MOD	= (1 << 0),
 };
 
-struct ftrace_hash {
-	unsigned long		size_bits;
-	struct hlist_head	*buckets;
-	unsigned long		count;
-	unsigned long		flags;
-	struct rcu_head		rcu;
-};
-
 struct ftrace_func_entry *
 ftrace_lookup_ip(struct ftrace_hash *hash, unsigned long ip);
 
-- 
2.51.0



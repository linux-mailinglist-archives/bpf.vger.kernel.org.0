Return-Path: <bpf+bounces-69483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F66AB97A31
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 23:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0BB774E320E
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 21:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8057230EF9E;
	Tue, 23 Sep 2025 21:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFQrqZvy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF29B30E0FB;
	Tue, 23 Sep 2025 21:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758664329; cv=none; b=jNt3V2eXZPOn3OKZNXIMg36nywFFgH8EJhQVM3edkI2RdZYbMLz3cwb7rwsUUe1WKoMldSVkcI5QZw1x9xttNZtGGKMXk7+/Za0Xs12Wz58RHo4/0FaU9U0/PoOWIJPSlLzTN5HPeOZB2RW/ufGw2VXHQc0QUnY9dkVkp5q0PZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758664329; c=relaxed/simple;
	bh=0OT+Cifnt0VO7z3Jrp77kFKvZcc+x/w351c++TwCC8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=foSp9j2usGzVS/aEsZfJ4uFWmLa66k/mDcDD20Zc9U8V/GokjzXO1fI2pI19albquRJITZan9jmqOyqnDRVjJh3S6jSLqt5HwJTX+3HMPE6k91j//HXj1LVHqL0RxE6lN/kjRRuxqWbehqiUJ+j3bBAd5GFm3VjAFqsE15t7wXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFQrqZvy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC33C4CEF5;
	Tue, 23 Sep 2025 21:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758664329;
	bh=0OT+Cifnt0VO7z3Jrp77kFKvZcc+x/w351c++TwCC8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lFQrqZvyVzpwGobW1Sq6klf1KfypkcKGBdHHJ8VMP9SnEbZViyQP4J7B5JuLsvUaC
	 yBATX7bUKRqJ5wRjrnH1jm5X8vV16rqXhk8kCHQ9BRGQVsNsqK+5CufVCl3dFjUYts
	 Fv/qTGYF7wy0FkOlJMSpnVXjchYpYWvyBQ189bvTa0go0zCsyZE+X+ax5RUjLOWRI7
	 zw+m+G1qf/QMP0Ge7KXiikMSO9ROZIYu71LzbJzZ+HRSUMuwqZ584aQoTV8pQoBfPI
	 BXVvjV608ylTuVn2HZm9R2k+i2bptD5vaeA8B2vsVY5cb2l7k7nPUASXMEE0rDBDHE
	 jQuYWJgg8TchA==
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
Subject: [PATCH 1/9] ftrace: Make alloc_and_copy_ftrace_hash direct friendly
Date: Tue, 23 Sep 2025 23:51:39 +0200
Message-ID: <20250923215147.1571952-2-jolsa@kernel.org>
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

Make alloc_and_copy_ftrace_hash to copy also direct address
for each hash entry.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/ftrace.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index a69067367c29..a45556257963 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1186,7 +1186,7 @@ static void __add_hash_entry(struct ftrace_hash *hash,
 }
 
 static struct ftrace_func_entry *
-add_hash_entry(struct ftrace_hash *hash, unsigned long ip)
+add_hash_entry_direct(struct ftrace_hash *hash, unsigned long ip, unsigned long direct)
 {
 	struct ftrace_func_entry *entry;
 
@@ -1195,11 +1195,18 @@ add_hash_entry(struct ftrace_hash *hash, unsigned long ip)
 		return NULL;
 
 	entry->ip = ip;
+	entry->direct = direct;
 	__add_hash_entry(hash, entry);
 
 	return entry;
 }
 
+static struct ftrace_func_entry *
+add_hash_entry(struct ftrace_hash *hash, unsigned long ip)
+{
+	return add_hash_entry_direct(hash, ip, 0);
+}
+
 static void
 free_hash_entry(struct ftrace_hash *hash,
 		  struct ftrace_func_entry *entry)
@@ -1372,7 +1379,7 @@ alloc_and_copy_ftrace_hash(int size_bits, struct ftrace_hash *hash)
 	size = 1 << hash->size_bits;
 	for (i = 0; i < size; i++) {
 		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
-			if (add_hash_entry(new_hash, entry->ip) == NULL)
+			if (add_hash_entry_direct(new_hash, entry->ip, entry->direct) == NULL)
 				goto free_hash;
 		}
 	}
-- 
2.51.0



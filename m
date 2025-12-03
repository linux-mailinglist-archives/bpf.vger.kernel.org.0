Return-Path: <bpf+bounces-75946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5DAC9E30E
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 09:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FF913A9B7A
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 08:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15A02C234B;
	Wed,  3 Dec 2025 08:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxUJfuJP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E76329B764;
	Wed,  3 Dec 2025 08:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764750274; cv=none; b=BbR/pDHxOcHvuUry26MeDDKXrjpKBlLHQM1LMg21W3F3GBisdgko6VmMh/oUDNMVy0UI2A7xHJGGFbUagMl2vEWMZ793M5hSTE2ErK63xrd4rDCJh1VeKBSnI7MKlAx87F3hId37kJQA79T36TR40C9Uo8XetBaQfDaUyyJrilY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764750274; c=relaxed/simple;
	bh=wjKeRmILuEv3XhFbvkHTofLX7c9w7rQEYLqUWe4Qoek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GnTPYhHsCE5VJ4xLpvl09gvHkf9UOpbcvvDGUFE0cB6skW4Fyj1w19xnwizoVSDK3R0NR+nASka7+R7coyBNjJXAZWQQfE4fdE6V3nopMERKCwbAKRWUCQuUED+hIdJY0pH7x0v8QF20ZS79hoAKZMmKzfLC4+ux/O9dyr9H5Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxUJfuJP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10F9C4CEFB;
	Wed,  3 Dec 2025 08:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764750273;
	bh=wjKeRmILuEv3XhFbvkHTofLX7c9w7rQEYLqUWe4Qoek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WxUJfuJPyPpworw3v/WLpFY416v3SYtgNevvykumUYKWYbHWCIKX73mSlUDOEDAb0
	 TVdVlaXQjrSS4mRrg8WDIXOFL1y/7XVw30DvGZnWefyFAHWnS8ELvSOZqGjRjV9t0+
	 tqGMmqoQogZGf9+tjbvIT8TTzkxWTAyc82Q5nEQngMrJDhIYn5XvIjaUUdIMDd0si+
	 lz9vFDiW99tuVzl94LayvsW+YZLTy7kM2nEPz2PuXjeULezuWgw0eBL/N6bn+V3M6i
	 rB7177AyPub7QnvbUc7IBKjXXyKpqtBIclScPrnP1jgXmU7PfQyhaRvu/VrYtyx1TQ
	 pkntOn4XjWBvw==
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
Subject: [PATCHv4 bpf-next 2/9] ftrace: Make alloc_and_copy_ftrace_hash direct friendly
Date: Wed,  3 Dec 2025 09:23:55 +0100
Message-ID: <20251203082402.78816-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203082402.78816-1-jolsa@kernel.org>
References: <20251203082402.78816-1-jolsa@kernel.org>
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
index b0dc911411f1..7e3a81bd6f1e 100644
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
2.52.0



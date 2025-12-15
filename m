Return-Path: <bpf+bounces-76633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E20C6CBFE15
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 22:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4851301CE51
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 21:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818CC3161A5;
	Mon, 15 Dec 2025 21:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzP+bVkc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAE02DA768;
	Mon, 15 Dec 2025 21:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765833277; cv=none; b=gCXl/IquHdS0bIDBxXQJLmTlNUThytSdZGgipg9+kHHOmOzzh333Yr8gAxsIcTllj2wd3k5C/c5OvkRcw/04Bt9SFjYbder5aE0PBd8Q5nLWBGpq0d5wpFTvbyCpKACnxjanm00v37z09RnFwzVhXaWmKG9HzUGl48CbYUIKx3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765833277; c=relaxed/simple;
	bh=wjKeRmILuEv3XhFbvkHTofLX7c9w7rQEYLqUWe4Qoek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Boen4ALvw9YONxhPqF91wFp9IcrVAMa+U7rWRH4xqrKljRgcwTP3zmSSiqtvE4vawL46+ebHdUorAaQwU712Iw5OGnRkT9HlCrFEBnlQQtJGbyqKx8s1HPGbxlZ3v/jyCmqYGt+eQqizpi2p+qCb+cO+gt9tZCi+9ZImvMdyYZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzP+bVkc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBFDC116B1;
	Mon, 15 Dec 2025 21:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765833276;
	bh=wjKeRmILuEv3XhFbvkHTofLX7c9w7rQEYLqUWe4Qoek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bzP+bVkc5hChjLfE0u0Bavhc2el37Kp8ZedRsgxpESdHwM5Sky+TjEpAyC4QuGl4G
	 jhNsj2Cx4FtIFPj4h7q9ClqNz5j1FgCxc76dT/XJC6IsuHIS22xLqzcSL2WKKHlK0Q
	 HI70cBeZDPqfsiD9fPEA9m/pm/bheSDg8AD/OBcbb9+an/EZunqzXt1CPDad5QFE6t
	 CHnQLpSAo+IhWFHClAo5tK9vqpq383MHqzHix+aVBIvDBUS3uQyNtCUnkjyNPbXTgV
	 bvGIqW43x75CwddIwZ2cKvg/6pch9yjFK/izB8lBqzlkN7gurj9M4QviS7M1XoLPIn
	 hpFZeYaMk2sSA==
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
Subject: [PATCHv5 bpf-next 2/9] ftrace: Make alloc_and_copy_ftrace_hash direct friendly
Date: Mon, 15 Dec 2025 22:13:55 +0100
Message-ID: <20251215211402.353056-3-jolsa@kernel.org>
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



Return-Path: <bpf+bounces-75185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B97C765CD
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 22:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 14D562C604
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 21:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E62C30AAB6;
	Thu, 20 Nov 2025 21:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJiID6Fz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74552F999F;
	Thu, 20 Nov 2025 21:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763673863; cv=none; b=F5PxrUjCHBBvkjnz9jERYSpmAY9pzRuDxJNcVSpwTVh8de25AQjNV/lHdIYjVnNaiwYFMWiUbd4RaGZB/Fy3rFGyZIdXBxwfaNTZ2UDrLkZ9NgB0NwZmHDTaL90R1FTDnEq79kDo46PLk0y0JCWCWrInFpJYUKZEKUkgGSh20KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763673863; c=relaxed/simple;
	bh=YnnW7zN+aKxuUBmWBuWqRRKoptp3OePRxKnEM6fAzmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7+LMOW504p5rZ1jlN7w8KU3xVdv+HXHd+I3WADUzOtNnO2Q/N7qBRcRJfljenmf0up/2z5aopAz/mo1Rw7u7LOxJWYAcl0NqyJzA0fqsmol7wJ/nS60dP7cfXnbnKxq371bzzyhvFVlfzSFpU4ar7Gfy1WrH8uRRKOE8ZFFrTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJiID6Fz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368F1C116B1;
	Thu, 20 Nov 2025 21:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763673863;
	bh=YnnW7zN+aKxuUBmWBuWqRRKoptp3OePRxKnEM6fAzmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mJiID6FzDqCsD96MzGN7HnAhWBymD9bFoqZ3uvJ03Iikha8ymsq+M3bqkPa8q11Jf
	 rE6bGC3VFHdgZT7GcIrhRmCK4XYjh7ADIdjRmoOVmINk0cSxtXJiigG5OT2bPXv1Z9
	 LeKJLqR7nE21vmZCtB/vpKEWZe0JxaPCUj+taClupYABypOSMUTWdOKUH2vWzAt52y
	 lMeeAnEzZIujCfouxYnmlZjGszEQTNnY61kfqdFKwbftrg57VRR8U2Ntmpzpycpql9
	 6c+mmxa8d+2HeREjY6284t7c58cH8gLEnK3Czs9IRsZBm5WFkxHD5eI0unHcR/HCjs
	 RVnQuREpk3S2w==
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
Subject: [PATCHv3 bpf-next 1/8] ftrace: Make alloc_and_copy_ftrace_hash direct friendly
Date: Thu, 20 Nov 2025 22:23:55 +0100
Message-ID: <20251120212402.466524-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251120212402.466524-1-jolsa@kernel.org>
References: <20251120212402.466524-1-jolsa@kernel.org>
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
index 59cfacb8a5bb..0e3714b796d9 100644
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
2.51.1



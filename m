Return-Path: <bpf+bounces-64931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8310B18877
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 23:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DBA73AC3F9
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 21:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E368E28DEE7;
	Fri,  1 Aug 2025 21:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3HaIabD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B7821A43D;
	Fri,  1 Aug 2025 21:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754082194; cv=none; b=MIaXveOdWGQ19+ctQDOahiKtWILeo1fZjhB6twYsXhj6rIUbi1qyGoWbX/rG+x/4hAyecdz4LxVgg80JElMHeuiYt1k2G88JeqPwTov/EjY3kVY/HZSsk26uBQYBbqIkyj/5w5HJDCtvzwfzMMXg0JNu/nuo36pO6PNI3TbE1S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754082194; c=relaxed/simple;
	bh=0RmjoFSsHQJXWphY2gRGBMuPj3H+tw0ROuPOh0jMxIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HmZKBQZ441S+bDoBzWOX9fCrsPsybL4prf9qXiMPhsS12t5auH9tWT2xYGXPmPdtEtKf/sQh3UFFffOGtDSSoNEirZMlCqg1cpsflh0tDsFTU2g5IWlKg6jQqNaQeKELLoEdySCSd8wxTmfTEoltDMs0UCsJzJXyyuVJTQRkwd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3HaIabD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD4CC4CEE7;
	Fri,  1 Aug 2025 21:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754082193;
	bh=0RmjoFSsHQJXWphY2gRGBMuPj3H+tw0ROuPOh0jMxIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m3HaIabD9dOEu/iXFt7ZO1+JAaMCp8S4jlY9k0GI66F5I//5gajvTJtw/x371t3e5
	 r4DgxrJvRZpI0+zB0TEl/UYkn5bOoUWXmKBUbWWTbX+ZoSM5AtjJSMVperGBgNUluw
	 j5h8PWKih7Z1lmH03Md8WZQjepeP73s8lp6eRgFFuhGgC+ePrXAdW+nIdSkWWoGYGF
	 mMn/ZCMz5TyCopw4uwcvCZqAIPoAZyCM/YlFAZ/9pf+iSjL7xFZvguqcOtPoIRw0zK
	 rkqBbhCWUR4l45SnbE4pCi83qHhKEqn+yMMxccTsxnZebkrf56SwuVveFtvtQPLp1+
	 aXEeQ7XbIc8qg==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [RFC 2/4] bpf: Allow uprobe program to change context registers
Date: Fri,  1 Aug 2025 23:02:36 +0200
Message-ID: <20250801210238.2207429-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250801210238.2207429-1-jolsa@kernel.org>
References: <20250801210238.2207429-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently uprobe (BPF_PROG_TYPE_KPROBE) program can't write to the
context registers data. While this makes sense for kprobe attachments,
for uprobe attachment it might make sense to be able to change user
space registers to alter application execution.

Since uprobe and kprobe programs share the same type (BPF_PROG_TYPE_KPROBE),
we can't deny write access to context during the program load. We need
to check on it during program attachment to see if it's going to be
kprobe or uprobe.

Storing the program's write attempt to context and checking on it
during the attachment.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h      | 1 +
 kernel/events/core.c     | 4 ++++
 kernel/trace/bpf_trace.c | 3 +--
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f9cd2164ed23..8c8bd00e0095 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1609,6 +1609,7 @@ struct bpf_prog_aux {
 	bool priv_stack_requested;
 	bool changes_pkt_data;
 	bool might_sleep;
+	bool kprobe_write_ctx;
 	u64 prog_array_member_cnt; /* counts how many times as member of prog_array */
 	struct mutex ext_mutex; /* mutex for is_extended and prog_array_member_cnt */
 	struct bpf_arena *arena;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 22fdf0c187cd..4eaeeb40aa08 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11205,6 +11205,10 @@ static int __perf_event_set_bpf_prog(struct perf_event *event,
 	if (prog->kprobe_override && !is_kprobe)
 		return -EINVAL;
 
+	/* Writing to context allowed only for uprobes. */
+	if (prog->aux->kprobe_write_ctx && !is_uprobe)
+		return -EINVAL;
+
 	if (is_tracepoint || is_syscall_tp) {
 		int off = trace_event_get_offsets(event->tp_event);
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 3ae52978cae6..467fd5ab4b79 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1521,8 +1521,6 @@ static bool kprobe_prog_is_valid_access(int off, int size, enum bpf_access_type
 {
 	if (off < 0 || off >= sizeof(struct pt_regs))
 		return false;
-	if (type != BPF_READ)
-		return false;
 	if (off % size != 0)
 		return false;
 	/*
@@ -1532,6 +1530,7 @@ static bool kprobe_prog_is_valid_access(int off, int size, enum bpf_access_type
 	if (off + size > sizeof(struct pt_regs))
 		return false;
 
+	prog->aux->kprobe_write_ctx |= type == BPF_WRITE;
 	return true;
 }
 
-- 
2.50.1



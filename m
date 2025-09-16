Return-Path: <bpf+bounces-68558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04820B5A449
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 23:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D26F23ACD15
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 21:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16A8313D79;
	Tue, 16 Sep 2025 21:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7jU4Uex"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207E2285C95;
	Tue, 16 Sep 2025 21:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758059601; cv=none; b=aosdW4HGI7vgU+vXZGDZ2/JysRi0dBrJGY0mMRiD53e5047Cay5a7TWsAORN+DmlaHf3iwq1vX2AkhNURM9jUvrD3VSb93YENheplr7+ofjoltNB90vtyBkzICPp3L56YNCBetzE2imuQjhUfIqcNaBDUKICVTMsBwMOgUWSyug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758059601; c=relaxed/simple;
	bh=vamR6nnchvOX6ID/s4Gnk1+hiU0FEri8mSpRjt7jFtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=agEKUykpEyGuOTAfvg1Vx5wCg9WK3Cz6WXiUiFsHCqaPw2t+pUbdpFg+Wn9u+80wdsAKtr+0dUMMVH4RspzivHeBxQxrCLLAR96oza7a7i+MUk3JeJrMzn6C/OnPg5Uswx9s91Df5u+juEB16prBBtzTs2Bq6lJkeF2TosASH6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7jU4Uex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCBEC4CEEB;
	Tue, 16 Sep 2025 21:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758059600;
	bh=vamR6nnchvOX6ID/s4Gnk1+hiU0FEri8mSpRjt7jFtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M7jU4UexoKNz9UCdo6Z+OPlNiiSZJ69JJL5tumqug7YZGxF8MR++abAn3htBLUDoR
	 4Gg/BjAUIrN0+sBcLhma3OMWgay6Xqkh5AECoIoyL75vELiFVSuG5PAOXouc6g6pW9
	 gYFzsjX7SXLJtVbBUeQvLzFVG/tVNU8KpB8FyM1qCQJZfKu+5X9vQocy50zcd7oycP
	 auwqfnJ83a8YB65XzUu8DsrFfQnO0rv/F0sXX1UFfS8DYet/CXsLWWIOze9yrC9ouQ
	 j7u/ql2wFQP4Yx/C61viPbiW2UOSBjdgbSmoU5LsECjRN81miowKgE126FqbiMOi8e
	 YWU4O8ObXk76A==
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
Subject: [PATCHv4 bpf-next 1/6] bpf: Allow uprobe program to change context registers
Date: Tue, 16 Sep 2025 23:52:56 +0200
Message-ID: <20250916215301.664963-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916215301.664963-1-jolsa@kernel.org>
References: <20250916215301.664963-1-jolsa@kernel.org>
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

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h      | 1 +
 kernel/events/core.c     | 4 ++++
 kernel/trace/bpf_trace.c | 9 +++++++--
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 41f776071ff5..8dfaf5e9f7fb 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1624,6 +1624,7 @@ struct bpf_prog_aux {
 	bool priv_stack_requested;
 	bool changes_pkt_data;
 	bool might_sleep;
+	bool kprobe_write_ctx;
 	u64 prog_array_member_cnt; /* counts how many times as member of prog_array */
 	struct mutex ext_mutex; /* mutex for is_extended and prog_array_member_cnt */
 	struct bpf_arena *arena;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 820127536e62..1d354778dcd4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11232,6 +11232,10 @@ static int __perf_event_set_bpf_prog(struct perf_event *event,
 	if (prog->kprobe_override && !is_kprobe)
 		return -EINVAL;
 
+	/* Writing to context allowed only for uprobes. */
+	if (prog->aux->kprobe_write_ctx && !is_uprobe)
+		return -EINVAL;
+
 	if (is_tracepoint || is_syscall_tp) {
 		int off = trace_event_get_offsets(event->tp_event);
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 606007c387c5..b0deaeebb34a 100644
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
@@ -1532,6 +1530,9 @@ static bool kprobe_prog_is_valid_access(int off, int size, enum bpf_access_type
 	if (off + size > sizeof(struct pt_regs))
 		return false;
 
+	if (type == BPF_WRITE)
+		prog->aux->kprobe_write_ctx = true;
+
 	return true;
 }
 
@@ -2918,6 +2919,10 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	if (!is_kprobe_multi(prog))
 		return -EINVAL;
 
+	/* Writing to context is not allowed for kprobes. */
+	if (prog->aux->kprobe_write_ctx)
+		return -EINVAL;
+
 	flags = attr->link_create.kprobe_multi.flags;
 	if (flags & ~BPF_F_KPROBE_MULTI_RETURN)
 		return -EINVAL;
-- 
2.51.0



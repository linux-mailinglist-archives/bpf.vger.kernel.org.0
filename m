Return-Path: <bpf+bounces-67705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D15B48D0A
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 14:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C156C1682BB
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 12:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EDE2FC869;
	Mon,  8 Sep 2025 12:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OILdliMd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74B42288E3;
	Mon,  8 Sep 2025 12:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333612; cv=none; b=eFmjVslKUoBw4ZCX66qpOVs44Y+17zk1yM0o86FlAFPPZwcDmNqon1ZObCuGUlMJ72o0sISJljcEKy3jGuyLTXfBDwhGwm1agQwE+Jlq2h4id9OJ+sjqaSki5hiZSpucYRTmOW+LrKWV2NHErbNL3RdkRfOPW66pOVZb8k9mtHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333612; c=relaxed/simple;
	bh=TwNZjXgz2JRkVlwNdJF9RElMCC/ODJjFB3Q+jBg+QAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iawfDIjTynsUEexvPCRIlYMHlwmXGCyiSxT8vXEWZxi7Fq44SIjyxd4+Hj+m+4FTpLCQPETnNJFq0Jy/SF3r6Wc9OjVCN0Jo0BjmOQ3oN+1GfGK3Mn0VyWXzA5FUpq6nFx4Al9mfdubWXIT4evpFI2+k+0OvykkFH7L0UpuYiE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OILdliMd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5993C4CEF1;
	Mon,  8 Sep 2025 12:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757333612;
	bh=TwNZjXgz2JRkVlwNdJF9RElMCC/ODJjFB3Q+jBg+QAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OILdliMdOuTpG6gquwrBCoJV+APpwLrnf99xbLG0jNCXy9797GBqfVaRR77ah1MV5
	 bSST2h3O+uegk68Jb9izrDDz1QTChSKkfnqNkJQjdVQkKoU5r3FBAqEPtdbfBpxIUm
	 zjW2wQV6kUVy5wmC5mlH06MYEIXJN8KRw5Sosmbys8hKCC1A0SXTxOs2deQc3K/e1i
	 CBP+ECNcaKTviMr5EV0fCxQ42tc+qV4hOIfoSakRJSn2nLP8n85Y2CKjcIJ28RoMDb
	 IEO9dbxnl6jnswwePM/43mEj2Y1kxqVBqPp71h+eyRJLGZF1G2sXYmwhdJIqtNrEBo
	 /pX/BqZgSIbjQ==
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
Subject: [PATCHv2 perf/core 1/4] bpf: Allow uprobe program to change context registers
Date: Mon,  8 Sep 2025 14:13:07 +0200
Message-ID: <20250908121310.46824-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908121310.46824-1-jolsa@kernel.org>
References: <20250908121310.46824-1-jolsa@kernel.org>
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
index cc700925b802..404a30cde84e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1619,6 +1619,7 @@ struct bpf_prog_aux {
 	bool priv_stack_requested;
 	bool changes_pkt_data;
 	bool might_sleep;
+	bool kprobe_write_ctx;
 	u64 prog_array_member_cnt; /* counts how many times as member of prog_array */
 	struct mutex ext_mutex; /* mutex for is_extended and prog_array_member_cnt */
 	struct bpf_arena *arena;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 28de3baff792..c3f37b266fc4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11238,6 +11238,10 @@ static int __perf_event_set_bpf_prog(struct perf_event *event,
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
2.51.0



Return-Path: <bpf+bounces-67187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 178E7B4071C
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 16:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60D4173360
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 14:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE142FB975;
	Tue,  2 Sep 2025 14:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1bxLkE+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55802EA49D;
	Tue,  2 Sep 2025 14:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823769; cv=none; b=ob0ZDWlRZEzdfnSFtB2AyX3Kzcehi8qOGDskT289D49lfTW68lEUGv7zJgLXUIlTLhvkav0vmNvqtmd0B72P/J0TOOjY5MJh4PYI4tHhG0RA8XGFWNXTgI1XQ1V6peiNfkvltuIISKuWbJjYzu45xYAXUx2tWvKciDFTKosJ408=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823769; c=relaxed/simple;
	bh=ixNZrhvRsdTd9sVuo3xMKCH4jWWm/B/SYs1iIFGaOwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lV3i153rb+vGMqUxl5bDZ9B8SqizWFoCcZaWj0JN32N/+NfqPfGzWyHzphnWlsD9BfDctfEPIQGS2xOZWy3bT7kLvLkHrBFZsXgSJmKpWrNBHMHpGClvGkqcgZhSVtGgOBQont03qjuT2s4FwlwRPZhuK7VLGyt2MLChHJwp20c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1bxLkE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001D4C4CEED;
	Tue,  2 Sep 2025 14:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756823769;
	bh=ixNZrhvRsdTd9sVuo3xMKCH4jWWm/B/SYs1iIFGaOwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d1bxLkE+vJ2Jcv16rcCmbgKvG5AXEsVwszB2+3qCX8136suKG2rtaK8KORVWprSdM
	 Mj9HnFLaU409NBr4b0DPVmYTyouAaWbByyos/DoxWLlKzaus61DjOPUmc7bsCXELyX
	 oS38Qv8bIOMCXg8x69kVzrD5gdAQIj7hnLeHOskJ9WPILr217R1rizWQwBXC5hNVB2
	 +cQLDalAKiSwp2Mk443NCJIeN3c10TP0kU56wHtwoHVnDKfxMjkY+Pfx8DKrNw+QLR
	 //GjF7lR72/lEXwjf9EH6uMomByNT+vkZqhBGKLw2she13IRzDdGruCITP64u1BR1n
	 ZsxikY+c712mA==
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
Subject: [PATCH perf/core 05/11] bpf: Allow uprobe program to change context registers
Date: Tue,  2 Sep 2025 16:34:58 +0200
Message-ID: <20250902143504.1224726-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902143504.1224726-1-jolsa@kernel.org>
References: <20250902143504.1224726-1-jolsa@kernel.org>
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
index 10a9341c638f..74bb5008a1c4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11242,6 +11242,10 @@ static int __perf_event_set_bpf_prog(struct perf_event *event,
 	if (prog->kprobe_override && !is_kprobe)
 		return -EINVAL;
 
+	/* Writing to context allowed only for uprobes. */
+	if (prog->aux->kprobe_write_ctx && !is_uprobe)
+		return -EINVAL;
+
 	if (is_tracepoint || is_syscall_tp) {
 		int off = trace_event_get_offsets(event->tp_event);
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0674d5ac7b55..6fdec68563bd 100644
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



Return-Path: <bpf+bounces-67858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4636BB4FB72
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 14:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 400A43B6A0E
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 12:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7A73375BB;
	Tue,  9 Sep 2025 12:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cf6cGQ2u"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF4E2DC34B;
	Tue,  9 Sep 2025 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757421561; cv=none; b=gdS1Tqr4wo9naVSqWbLGIa8CItbQIw5BZYdWBPwYWZ+f6Z9uLg5ywgGrWsA8fh4isyXhWMYx7VBEnnElf1Puifjm+VizcdSjgsr4g5Ga1cfU1nE4WfyR+yq7G4Wd30FtqF2dt5QfddYGEG/PNhN46C64cMfg7y1tZI6asyJXs+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757421561; c=relaxed/simple;
	bh=QoVbv3Gt4+8mnAmP5Qd017V/bTQvkbHe423VRjfq6Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=srvk0IvEAtCWcG74k7j3mh5lA93PIrVVuubrvROn8SX6wpQIYOIqfxOVBmzuxXkVUFW3QpsE1HPeQjY8nthVXjHdtgK0ZXS2Jda/1B9n/o7URJKP4uN0rF4pKJhGVrJubol3e82sXTcWsyYEAuzEn1jZHCtzM0J0QuJ589err1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cf6cGQ2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB777C4CEF4;
	Tue,  9 Sep 2025 12:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757421561;
	bh=QoVbv3Gt4+8mnAmP5Qd017V/bTQvkbHe423VRjfq6Z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cf6cGQ2uNa4dIlsaDafSOxvdSDJTd2RsLEU9IyvqwnqpOa9YEBT8F5hv4faVq0AAz
	 pcu/hCGdKfPRGUmaCjUsfwweD7be+IruIPxs+76u+KX3cF1qn3tSgcOGMEL+AdNfw3
	 CcbRSxv/JLlkIxvRSbJvYreEijfYLa4wffjytXF+NGIpw1JpLrnIeFMFGuHFUnU1zt
	 nV3RA+BhiRk5DQ8wTFy78ae4WUQ1xQ+P614mZ8YxUD68iNRlGCLWJ/dRqcPv0ltwGT
	 FZiQd9a2iK3seQAubRAjtyO48IbQvzK3a15qnP+9iSVGPTgGVy2OegpFLWtdcYCCcM
	 hYF1i2DRvDISg==
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
Subject: [PATCHv3 perf/core 1/6] bpf: Allow uprobe program to change context registers
Date: Tue,  9 Sep 2025 14:38:52 +0200
Message-ID: <20250909123857.315599-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909123857.315599-1-jolsa@kernel.org>
References: <20250909123857.315599-1-jolsa@kernel.org>
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
 kernel/trace/bpf_trace.c | 7 +++++--
 3 files changed, 10 insertions(+), 2 deletions(-)

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
index 3ae52978cae6..dfb19e773afa 100644
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
 
@@ -2913,6 +2912,10 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
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



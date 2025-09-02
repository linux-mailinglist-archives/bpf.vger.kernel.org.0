Return-Path: <bpf+bounces-67188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A89DFB40713
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 16:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21BDE4E2114
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 14:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB3A313E04;
	Tue,  2 Sep 2025 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3S1b54n"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0562EA49D;
	Tue,  2 Sep 2025 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823781; cv=none; b=h6JolQKmN6tgwDS+vrju0YGKaXjy8M0JKwM/d6iORUwxOUDBB080TyaQzxEuYZFsh/IDiUyh5fHHpM9F8zoOLQAG7cD3vx7+y3MMPC2ZIg+9gu3PqyRZW2nwr5n5uS5gX1kuk7/vB8xZkt+3s9megG6TO1m108fVLY14elH626M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823781; c=relaxed/simple;
	bh=4JOoZz3iZN1zacKGCHmVDgQlHUbUlhkai0CbLI11oAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iiRbrrDl7yICO/6u0efmcEj0IgiXqg6oSX5cIojivwIk/0bBh7/r2FrfrxlbkNQfAhFFsD9WfAnDgZTZyB0+xZLxv37qjfK3xUdQRk7BnrFfUvqgWr8vK6sHSK+ftIustKhnela1SmY6IatHqCZ5Sacep2DKmrVF1oq3UA/TvjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3S1b54n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A04C4CEED;
	Tue,  2 Sep 2025 14:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756823780;
	bh=4JOoZz3iZN1zacKGCHmVDgQlHUbUlhkai0CbLI11oAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W3S1b54naU/RQWH8K4HgD4xC3woY8aWCaUWMAuVxoE2wrsza65fyOr9RowvFGZeve
	 d7EyT+8WaxP9uK1d/0whZnWEfzf2fSY8XlBTkhWy1ix5GQIkFjp+SxP+nfDZR6YXuj
	 dEcagW56EIZqb0VsQ4SHqhYI1iUxdp3XcTGS9O4BtIwRLlug1j0Oltr7jRMD1E2CiZ
	 nDrOdeT+pFaE+Rg7MapBCAOHKELq56ZFKh7kLVvE7ZTUAPKxZ0hNmlKx64S0QglWzB
	 mEbqwBw44BuSx4zHtvDhLC6XgEnr6QU6aKpB2SVHyMGwOiq+7kbBz7eGcT37glRzNW
	 jMc4NCbVzI21w==
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
Subject: [PATCH perf/core 06/11] libbpf: Add support to attach unique uprobe_multi uprobe
Date: Tue,  2 Sep 2025 16:34:59 +0200
Message-ID: <20250902143504.1224726-7-jolsa@kernel.org>
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

Adding support to attach unique uprobe multi by adding the 'unique'
bool flag to struct bpf_uprobe_multi_opts.

Also adding "uprobe.unique[.s]" auto load sections to create
uprobe_multi unique uprobe.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c | 7 ++++++-
 tools/lib/bpf/libbpf.h | 4 +++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8f5a81b672e1..1f613a5f95b6 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9525,6 +9525,8 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("uprobe.multi+",	KPROBE,	BPF_TRACE_UPROBE_MULTI, SEC_NONE, attach_uprobe_multi),
 	SEC_DEF("uretprobe.multi+",	KPROBE,	BPF_TRACE_UPROBE_MULTI, SEC_NONE, attach_uprobe_multi),
 	SEC_DEF("uprobe.session+",	KPROBE,	BPF_TRACE_UPROBE_SESSION, SEC_NONE, attach_uprobe_multi),
+	SEC_DEF("uprobe.unique+",	KPROBE,	BPF_TRACE_UPROBE_MULTI, SEC_NONE, attach_uprobe_multi),
+	SEC_DEF("uprobe.unique.s+",	KPROBE,	BPF_TRACE_UPROBE_MULTI, SEC_SLEEPABLE, attach_uprobe_multi),
 	SEC_DEF("uprobe.multi.s+",	KPROBE,	BPF_TRACE_UPROBE_MULTI, SEC_SLEEPABLE, attach_uprobe_multi),
 	SEC_DEF("uretprobe.multi.s+",	KPROBE,	BPF_TRACE_UPROBE_MULTI, SEC_SLEEPABLE, attach_uprobe_multi),
 	SEC_DEF("uprobe.session.s+",	KPROBE,	BPF_TRACE_UPROBE_SESSION, SEC_SLEEPABLE, attach_uprobe_multi),
@@ -11880,6 +11882,7 @@ static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, stru
 	case 3:
 		opts.session = str_has_pfx(probe_type, "uprobe.session");
 		opts.retprobe = str_has_pfx(probe_type, "uretprobe.multi");
+		opts.unique = str_has_pfx(probe_type, "uprobe.unique");
 
 		*link = bpf_program__attach_uprobe_multi(prog, -1, binary_path, func_name, &opts);
 		ret = libbpf_get_error(*link);
@@ -12116,10 +12119,10 @@ bpf_program__attach_uprobe_multi(const struct bpf_program *prog,
 	LIBBPF_OPTS(bpf_link_create_opts, lopts);
 	unsigned long *resolved_offsets = NULL;
 	enum bpf_attach_type attach_type;
+	bool retprobe, session, unique;
 	int err = 0, link_fd, prog_fd;
 	struct bpf_link *link = NULL;
 	char full_path[PATH_MAX];
-	bool retprobe, session;
 	const __u64 *cookies;
 	const char **syms;
 	size_t cnt;
@@ -12141,6 +12144,7 @@ bpf_program__attach_uprobe_multi(const struct bpf_program *prog,
 	cnt = OPTS_GET(opts, cnt, 0);
 	retprobe = OPTS_GET(opts, retprobe, false);
 	session  = OPTS_GET(opts, session, false);
+	unique = OPTS_GET(opts, unique, false);
 
 	/*
 	 * User can specify 2 mutually exclusive set of inputs:
@@ -12203,6 +12207,7 @@ bpf_program__attach_uprobe_multi(const struct bpf_program *prog,
 	lopts.uprobe_multi.cookies = cookies;
 	lopts.uprobe_multi.cnt = cnt;
 	lopts.uprobe_multi.flags = retprobe ? BPF_F_UPROBE_MULTI_RETURN : 0;
+	lopts.uprobe_multi.flags |= unique ? BPF_F_UPROBE_MULTI_UNIQUE : 0;
 
 	if (pid == 0)
 		pid = getpid();
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 455a957cb702..13a10299331b 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -596,10 +596,12 @@ struct bpf_uprobe_multi_opts {
 	bool retprobe;
 	/* create session kprobes */
 	bool session;
+	/* create unique uprobe */
+	bool unique;
 	size_t :0;
 };
 
-#define bpf_uprobe_multi_opts__last_field session
+#define bpf_uprobe_multi_opts__last_field unique
 
 /**
  * @brief **bpf_program__attach_uprobe_multi()** attaches a BPF program
-- 
2.51.0



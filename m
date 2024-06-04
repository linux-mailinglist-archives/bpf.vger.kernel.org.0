Return-Path: <bpf+bounces-31378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B505E8FBCF0
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 22:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FE63B2642E
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 20:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6916A14B944;
	Tue,  4 Jun 2024 20:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILEvU0gT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC45A146D78;
	Tue,  4 Jun 2024 20:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717531407; cv=none; b=XQG8YT2IdSsPg6iow458VgNZIhp9PrDd4kqA+IJZ2Y8HJORGqOdM8gLK5s5kxlO4qG7adaSNJ0iEvyDeFuvgMZSVmwg+Ysf+ZF2XHFUGZYQRWplbPg+IIbKzhqQFCZmKGiTlHokIYVzEGrFDZuYV3/zCkGiASeIdApWMBCMpGW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717531407; c=relaxed/simple;
	bh=DggXebc+5AYH4oM8/iWPJWB6VFy1ERgOM6IPvJ6rIjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GdapsL4AjmEWo/TDMK5A4lliHBFjtvhG/d0tp0zMl0HlmQWrzuwHYB/xskIklrNQazwQIexhzvuIt89JU1xkZZ4ARFXK2TQf2C5N5j1nF9rRPbd5EElaf5r2pIH468ZWK0eugQoXaJaJojajPYN501kihdioqmdPPG/KU6hPvIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILEvU0gT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32F7C2BBFC;
	Tue,  4 Jun 2024 20:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717531406;
	bh=DggXebc+5AYH4oM8/iWPJWB6VFy1ERgOM6IPvJ6rIjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ILEvU0gTFvCYyzXJcUBLPA4oft6W+BmxISq3P/cmEVVan/6LPmsmuTLbkAhJbgWQn
	 gIAeCrHBeykLM1cNbVWZcK6qKgTNNnWyCpcRTkYuPTRED6Ne6vcG0Zv1ao/BqxcG/2
	 E1eT/T6CMjmllRxsluhBxZr/DlnGkIiWqYUGMe7WwGO0gRlbuzGduycAPxnhXvZmsG
	 Q6YyReZzxwZuMK+gGS9ZV26ycoQtJmQQp8m6VDqVRSVAbyUCGWcJOlv3WViGAymALC
	 ALMHNn+nkghG0wl/CozwcDe3HDiPtGjvwTHHmCvqVgbyfN8h4Il36CGDp8PumztyMJ
	 Jh5YUsNhjUKoA==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [RFC bpf-next 04/10] libbpf: Add support for uprobe multi session attach
Date: Tue,  4 Jun 2024 22:02:15 +0200
Message-ID: <20240604200221.377848-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604200221.377848-1-jolsa@kernel.org>
References: <20240604200221.377848-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support to attach program in uprobe session mode
with bpf_program__attach_uprobe_multi function.

Adding session bool to bpf_uprobe_multi_opts struct that allows
to load and attach the bpf program via uprobe session.
the attachment to create uprobe multi session.

Also adding new program loader section that allows:
SEC("uprobe.session/bpf_fentry_test*")

and loads/attaches uprobe program as uprobe session.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/bpf.c    |  1 +
 tools/lib/bpf/libbpf.c | 50 ++++++++++++++++++++++++++++++++++++++++--
 tools/lib/bpf/libbpf.h |  4 +++-
 3 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 2a4c71501a17..becdfa701c75 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -776,6 +776,7 @@ int bpf_link_create(int prog_fd, int target_fd,
 			return libbpf_err(-EINVAL);
 		break;
 	case BPF_TRACE_UPROBE_MULTI:
+	case BPF_TRACE_UPROBE_SESSION:
 		attr.link_create.uprobe_multi.flags = OPTS_GET(opts, uprobe_multi.flags, 0);
 		attr.link_create.uprobe_multi.cnt = OPTS_GET(opts, uprobe_multi.cnt, 0);
 		attr.link_create.uprobe_multi.path = ptr_to_u64(OPTS_GET(opts, uprobe_multi.path, 0));
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index d1627a2ca30b..a0044448a708 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9328,6 +9328,7 @@ static int attach_trace(const struct bpf_program *prog, long cookie, struct bpf_
 static int attach_kprobe_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_kprobe_session(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
+static int attach_uprobe_session(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_lsm(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_iter(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 
@@ -9346,6 +9347,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("kprobe.session+",	KPROBE,	BPF_TRACE_KPROBE_SESSION, SEC_NONE, attach_kprobe_session),
 	SEC_DEF("uprobe.multi+",	KPROBE,	BPF_TRACE_UPROBE_MULTI, SEC_NONE, attach_uprobe_multi),
 	SEC_DEF("uretprobe.multi+",	KPROBE,	BPF_TRACE_UPROBE_MULTI, SEC_NONE, attach_uprobe_multi),
+	SEC_DEF("uprobe.session+",	KPROBE,	BPF_TRACE_UPROBE_SESSION, SEC_NONE, attach_uprobe_session),
 	SEC_DEF("uprobe.multi.s+",	KPROBE,	BPF_TRACE_UPROBE_MULTI, SEC_SLEEPABLE, attach_uprobe_multi),
 	SEC_DEF("uretprobe.multi.s+",	KPROBE,	BPF_TRACE_UPROBE_MULTI, SEC_SLEEPABLE, attach_uprobe_multi),
 	SEC_DEF("ksyscall+",		KPROBE,	0, SEC_NONE, attach_ksyscall),
@@ -11682,6 +11684,40 @@ static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, stru
 	return ret;
 }
 
+static int attach_uprobe_session(const struct bpf_program *prog, long cookie, struct bpf_link **link)
+{
+	char *binary_path = NULL, *func_name = NULL;
+	LIBBPF_OPTS(bpf_uprobe_multi_opts, opts,
+		.session = true,
+	);
+	int n, ret = -EINVAL;
+	const char *spec;
+
+	*link = NULL;
+
+	spec = prog->sec_name + sizeof("uprobe.session/") - 1;
+	n = sscanf(spec, "%m[^:]:%m[^\n]",
+		   &binary_path, &func_name);
+
+	switch (n) {
+	case 1:
+		/* but auto-attach is impossible. */
+		ret = 0;
+		break;
+	case 2:
+		*link = bpf_program__attach_uprobe_multi(prog, -1, binary_path, func_name, &opts);
+		ret = *link ? 0 : -errno;
+		break;
+	default:
+		pr_warn("prog '%s': invalid format of section definition '%s'\n", prog->name,
+			prog->sec_name);
+		break;
+	}
+	free(binary_path);
+	free(func_name);
+	return ret;
+}
+
 static void gen_uprobe_legacy_event_name(char *buf, size_t buf_sz,
 					 const char *binary_path, uint64_t offset)
 {
@@ -11916,10 +11952,12 @@ bpf_program__attach_uprobe_multi(const struct bpf_program *prog,
 	const unsigned long *ref_ctr_offsets = NULL, *offsets = NULL;
 	LIBBPF_OPTS(bpf_link_create_opts, lopts);
 	unsigned long *resolved_offsets = NULL;
+	enum bpf_attach_type attach_type;
 	int err = 0, link_fd, prog_fd;
 	struct bpf_link *link = NULL;
 	char errmsg[STRERR_BUFSIZE];
 	char full_path[PATH_MAX];
+	bool retprobe, session;
 	const __u64 *cookies;
 	const char **syms;
 	size_t cnt;
@@ -11990,12 +12028,20 @@ bpf_program__attach_uprobe_multi(const struct bpf_program *prog,
 		offsets = resolved_offsets;
 	}
 
+	retprobe = OPTS_GET(opts, retprobe, false);
+	session  = OPTS_GET(opts, session, false);
+
+	if (retprobe && session)
+		return libbpf_err_ptr(-EINVAL);
+
+	attach_type = session ? BPF_TRACE_UPROBE_SESSION : BPF_TRACE_UPROBE_MULTI;
+
 	lopts.uprobe_multi.path = path;
 	lopts.uprobe_multi.offsets = offsets;
 	lopts.uprobe_multi.ref_ctr_offsets = ref_ctr_offsets;
 	lopts.uprobe_multi.cookies = cookies;
 	lopts.uprobe_multi.cnt = cnt;
-	lopts.uprobe_multi.flags = OPTS_GET(opts, retprobe, false) ? BPF_F_UPROBE_MULTI_RETURN : 0;
+	lopts.uprobe_multi.flags = retprobe ? BPF_F_UPROBE_MULTI_RETURN : 0;
 
 	if (pid == 0)
 		pid = getpid();
@@ -12009,7 +12055,7 @@ bpf_program__attach_uprobe_multi(const struct bpf_program *prog,
 	}
 	link->detach = &bpf_link__detach_fd;
 
-	link_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &lopts);
+	link_fd = bpf_link_create(prog_fd, 0, attach_type, &lopts);
 	if (link_fd < 0) {
 		err = -errno;
 		pr_warn("prog '%s': failed to attach multi-uprobe: %s\n",
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 26e4e35528c5..04cdb38f527f 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -569,10 +569,12 @@ struct bpf_uprobe_multi_opts {
 	size_t cnt;
 	/* create return uprobes */
 	bool retprobe;
+	/* create session kprobes */
+	bool session;
 	size_t :0;
 };
 
-#define bpf_uprobe_multi_opts__last_field retprobe
+#define bpf_uprobe_multi_opts__last_field session
 
 /**
  * @brief **bpf_program__attach_uprobe_multi()** attaches a BPF program
-- 
2.45.1



Return-Path: <bpf+bounces-22852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0881486AAD7
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 10:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22B301C25C3C
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 09:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F52339A1;
	Wed, 28 Feb 2024 09:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rP/9QD9b"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E4A31A94
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 09:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709111003; cv=none; b=XPyIDft147gRMTHzKNSft3r++o6P2vHvenRTxQA5t9ukxCnYY+VczM/CoBzjJVjJZ4Lsq04uSvSSf7usoC44x8m2sWY7o/lhUYDRm+yU7GebmSxhDg2VHXT2yM9TxjPuaSOGjmzfv1zqwzGF0mSnrlT2lEwmL/VRP2MLzlPrT0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709111003; c=relaxed/simple;
	bh=ETUdGq+ubKGgZlGTk6No23JdOZXS4gyPRBS//b/nowM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eq0wnUo3pQnRzvihE7xMSXCKfVZREwyR2D5zH1FHWV0Ex7w5Fq2TnPrkeo8r4z8MI81Q8oB4mwr/IU8B6l37OFQ9ZyC9xKtgKCTcPHJSbOv+kazJfqrolMs1NMYDkZ4yPbOZ4Lv9Petq591J6F3qS7+ZCKNJTwvMSht0T9nK7XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rP/9QD9b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B90C433C7;
	Wed, 28 Feb 2024 09:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709111003;
	bh=ETUdGq+ubKGgZlGTk6No23JdOZXS4gyPRBS//b/nowM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rP/9QD9bLw5uKP0YbH2iFnHYCQfxU5JiXH65FAJDvAAwM72OhQf37vvm9Cf1j3Q/Q
	 V4dsav7sfYorj9KZYDFkNKIw67MXuQPJwGs3On/s+E6F/Fz07eCvvmuiCsRawhJTu3
	 76UBlzBymftN2rjxwui2YI14ccizpaCllgYvjHV5R/X29AIj3ShJA+lh49bnQxEMZa
	 LQM/cKDWIztIRov0h8xLVDKOuQE7JZnaAz9LPN7P5F21q9XcWlJcatMJpiQXXmCToq
	 bJkDyBJ9HPMiwNh4KMLVi51nac2FSCZqRhm5GpBby2XdD1Dk3zAEdVjaStrjuMZBHN
	 gHupndNdHGwPA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
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
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH RFCv2 bpf-next 3/4] libbpf: Add support for kprobe multi wrapper attach
Date: Wed, 28 Feb 2024 10:02:41 +0100
Message-ID: <20240228090242.4040210-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228090242.4040210-1-jolsa@kernel.org>
References: <20240228090242.4040210-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support for specify wrapper mode in bpf_kprobe_multi_opts
struct object and new bpf program loader section:

 SEC("kprobe.wrapper/bpf_fentry_test*")

to load program as kprobe multi wrapper.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c | 38 +++++++++++++++++++++++++++++++++++---
 tools/lib/bpf/libbpf.h |  4 +++-
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 01f407591a92..5416d784c857 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8944,6 +8944,7 @@ static int attach_tp(const struct bpf_program *prog, long cookie, struct bpf_lin
 static int attach_raw_tp(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_trace(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_kprobe_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
+static int attach_kprobe_wrapper(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_lsm(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_iter(const struct bpf_program *prog, long cookie, struct bpf_link **link);
@@ -8960,6 +8961,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("uretprobe.s+",		KPROBE, 0, SEC_SLEEPABLE, attach_uprobe),
 	SEC_DEF("kprobe.multi+",	KPROBE,	BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
 	SEC_DEF("kretprobe.multi+",	KPROBE,	BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
+	SEC_DEF("kprobe.wrapper+",	KPROBE,	BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_wrapper),
 	SEC_DEF("uprobe.multi+",	KPROBE,	BPF_TRACE_UPROBE_MULTI, SEC_NONE, attach_uprobe_multi),
 	SEC_DEF("uretprobe.multi+",	KPROBE,	BPF_TRACE_UPROBE_MULTI, SEC_NONE, attach_uprobe_multi),
 	SEC_DEF("uprobe.multi.s+",	KPROBE,	BPF_TRACE_UPROBE_MULTI, SEC_SLEEPABLE, attach_uprobe_multi),
@@ -11034,7 +11036,7 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 	int err, link_fd, prog_fd;
 	const __u64 *cookies;
 	const char **syms;
-	bool retprobe;
+	__u32 flags = 0;
 	size_t cnt;
 
 	if (!OPTS_VALID(opts, bpf_kprobe_multi_opts))
@@ -11065,13 +11067,16 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 		cnt = res.cnt;
 	}
 
-	retprobe = OPTS_GET(opts, retprobe, false);
+	if (OPTS_GET(opts, retprobe, false))
+		flags |= BPF_F_KPROBE_MULTI_RETURN;
+	if (OPTS_GET(opts, wrapper, false))
+		flags |= BPF_F_KPROBE_MULTI_WRAPPER;
 
 	lopts.kprobe_multi.syms = syms;
 	lopts.kprobe_multi.addrs = addrs;
 	lopts.kprobe_multi.cookies = cookies;
 	lopts.kprobe_multi.cnt = cnt;
-	lopts.kprobe_multi.flags = retprobe ? BPF_F_KPROBE_MULTI_RETURN : 0;
+	lopts.kprobe_multi.flags = flags;
 
 	link = calloc(1, sizeof(*link));
 	if (!link) {
@@ -11187,6 +11192,33 @@ static int attach_kprobe_multi(const struct bpf_program *prog, long cookie, stru
 	return libbpf_get_error(*link);
 }
 
+static int attach_kprobe_wrapper(const struct bpf_program *prog, long cookie, struct bpf_link **link)
+{
+	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts,
+		.wrapper = true,
+	);
+	const char *spec;
+	char *pattern;
+	int n;
+
+	*link = NULL;
+
+	/* no auto-attach for SEC("kprobe.wrapper") */
+	if (strcmp(prog->sec_name, "kprobe.wrapper") == 0)
+		return 0;
+
+	spec = prog->sec_name + sizeof("kprobe.wrapper/") - 1;
+	n = sscanf(spec, "%m[a-zA-Z0-9_.*?]", &pattern);
+	if (n < 1) {
+		pr_warn("kprobe wrapper pattern is invalid: %s\n", pattern);
+		return -EINVAL;
+	}
+
+	*link = bpf_program__attach_kprobe_multi_opts(prog, pattern, &opts);
+	free(pattern);
+	return libbpf_get_error(*link);
+}
+
 static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link)
 {
 	char *probe_type = NULL, *binary_path = NULL, *func_name = NULL;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 5723cbbfcc41..72f4e3ad295f 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -539,10 +539,12 @@ struct bpf_kprobe_multi_opts {
 	size_t cnt;
 	/* create return kprobes */
 	bool retprobe;
+	/* create wrapper kprobes */
+	bool wrapper;
 	size_t :0;
 };
 
-#define bpf_kprobe_multi_opts__last_field retprobe
+#define bpf_kprobe_multi_opts__last_field wrapper
 
 LIBBPF_API struct bpf_link *
 bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
-- 
2.43.2



Return-Path: <bpf+bounces-40030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB70A97AD1F
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 10:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F047B2994A
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 08:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437421581F4;
	Tue, 17 Sep 2024 08:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4uS4nmN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58C01531DB;
	Tue, 17 Sep 2024 08:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563119; cv=none; b=ISjnLojvzUmtFzJU9XExfkBZyjoVjgn9r/fGhRuEyuGvED30F+fsUXppSaIWBZDpMJD5anICb8f9DApFoHOvjjXWprD/RFB5/o/o612VOnSK5V4UW8wI83UAmZEORVVuE+Ymnm8pRGsdDoNkOZ9XgrbPNsHRqAkt7EKQXnQXjBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563119; c=relaxed/simple;
	bh=3lpH1TcPLZZROLVAgrsQatm8wpUWuKts3MBt4vGURUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HfGil3WW0MDllRJLiXj21pj+s2PQzdrWrqszjzvLEkLRqKu2cfgt70pd92I1Zp49sJB55IIRLy/EWmxmj6H0EsKg3hQG0hYJuuahHYj38TuHRPwlkf5ZeyfM9oDBmN/Th6EmFXt9Rt6iStuXyP41lkJ4uiadRKjxxcA1FxoNNh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4uS4nmN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9862C4CEC5;
	Tue, 17 Sep 2024 08:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726563119;
	bh=3lpH1TcPLZZROLVAgrsQatm8wpUWuKts3MBt4vGURUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L4uS4nmNrX9yNY8rSKjBlncd45hMw2rnIl7ZfZcxP02kXJ12JTiOILIYGAnwZrZbz
	 s3FBpuuCakwJHKN3oopgMvJQ14wmn7MpYaPc5BpoyY8TEIATdzkExyc0n5yN13ZIuJ
	 rgLSu2oKwQi2duedPCh+1E7bKRT2l7TboCnynGUywWg87F6PiX95QmEimm5SaUnuAj
	 HWomALSlbhBzzbsoMhQd2zPVUq1wAcbk5Gaxw1r35lvYzIJV4kgk99QueyqcUx2kjO
	 3bFwhpZeQd8TWUyTGvKZf12yoJ5Na1Icc8X9GOqMZ4xJ1ruUcC1snjjw8AFrb0Dk8p
	 i4hb6zaCscz2g==
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
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv4 07/14] libbpf: Add support for uprobe multi session attach
Date: Tue, 17 Sep 2024 10:50:17 +0200
Message-ID: <20240917085024.765883-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240917085024.765883-1-jolsa@kernel.org>
References: <20240917085024.765883-1-jolsa@kernel.org>
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

Adding sleepable hook (uprobe.session.s) as well.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/bpf.c    |  1 +
 tools/lib/bpf/libbpf.c | 21 ++++++++++++++++++---
 tools/lib/bpf/libbpf.h |  4 +++-
 3 files changed, 22 insertions(+), 4 deletions(-)

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
index 6917d4a0bd4e..83e56856b2b4 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9363,8 +9363,10 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("kprobe.session+",	KPROBE,	BPF_TRACE_KPROBE_SESSION, SEC_NONE, attach_kprobe_session),
 	SEC_DEF("uprobe.multi+",	KPROBE,	BPF_TRACE_UPROBE_MULTI, SEC_NONE, attach_uprobe_multi),
 	SEC_DEF("uretprobe.multi+",	KPROBE,	BPF_TRACE_UPROBE_MULTI, SEC_NONE, attach_uprobe_multi),
+	SEC_DEF("uprobe.session+",	KPROBE,	BPF_TRACE_UPROBE_SESSION, SEC_NONE, attach_uprobe_multi),
 	SEC_DEF("uprobe.multi.s+",	KPROBE,	BPF_TRACE_UPROBE_MULTI, SEC_SLEEPABLE, attach_uprobe_multi),
 	SEC_DEF("uretprobe.multi.s+",	KPROBE,	BPF_TRACE_UPROBE_MULTI, SEC_SLEEPABLE, attach_uprobe_multi),
+	SEC_DEF("uprobe.session.s+",	KPROBE,	BPF_TRACE_UPROBE_SESSION, SEC_SLEEPABLE, attach_uprobe_multi),
 	SEC_DEF("ksyscall+",		KPROBE,	0, SEC_NONE, attach_ksyscall),
 	SEC_DEF("kretsyscall+",		KPROBE, 0, SEC_NONE, attach_ksyscall),
 	SEC_DEF("usdt+",		KPROBE,	0, SEC_USDT, attach_usdt),
@@ -11684,7 +11686,10 @@ static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, stru
 		ret = 0;
 		break;
 	case 3:
-		opts.retprobe = str_has_pfx(probe_type, "uretprobe.multi");
+		if (str_has_pfx(probe_type, "uprobe.session"))
+			opts.session = true;
+		else
+			opts.retprobe = str_has_pfx(probe_type, "uretprobe.multi");
 		*link = bpf_program__attach_uprobe_multi(prog, -1, binary_path, func_name, &opts);
 		ret = libbpf_get_error(*link);
 		break;
@@ -11933,10 +11938,12 @@ bpf_program__attach_uprobe_multi(const struct bpf_program *prog,
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
@@ -12007,12 +12014,20 @@ bpf_program__attach_uprobe_multi(const struct bpf_program *prog,
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
@@ -12026,7 +12041,7 @@ bpf_program__attach_uprobe_multi(const struct bpf_program *prog,
 	}
 	link->detach = &bpf_link__detach_fd;
 
-	link_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &lopts);
+	link_fd = bpf_link_create(prog_fd, 0, attach_type, &lopts);
 	if (link_fd < 0) {
 		err = -errno;
 		pr_warn("prog '%s': failed to attach multi-uprobe: %s\n",
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 64a6a3d323e3..f6a7835dc519 100644
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
2.46.0



Return-Path: <bpf+bounces-39273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D1997101A
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 09:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B859E282B90
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 07:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4C31B1427;
	Mon,  9 Sep 2024 07:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmDgSU0S"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD65A1AD5C1;
	Mon,  9 Sep 2024 07:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868007; cv=none; b=t31P4V++ix4GYeA565bnCPDEjt3Y8YkyYtIt3bZwNl+B1gtMRO1zivvXYYXc1VlX/iAODZELUoyZVDncTLRrYqT7RhujRK1sU6tq/3IEMviAjMoS2YNTfTwFqSeuIuPwfWVRE0RuFmxm6f/lpSs6yUTLrB0RuUJ31iITeZ/H5OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868007; c=relaxed/simple;
	bh=ObTqM6334eLsYB+Krs4fbcM5unxTfDttQTIQdBshKKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fd16NZy2ACoPpdLM4VDtGSRC4E50JOVwToGp8vUlOgSVoA3YXM1i1/SL/VlxK6kEfmQQv34K6oZzCAidq6q65LSVS2GdVYplggPYMXwtt/HQvFZXqiDFC7xuCXQVc2TpSksFk96bzp5I471rNOkvzFiNOxROLBHnGZOh40xi6SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmDgSU0S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DF9C4CEC5;
	Mon,  9 Sep 2024 07:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725868007;
	bh=ObTqM6334eLsYB+Krs4fbcM5unxTfDttQTIQdBshKKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HmDgSU0SGrENUi3/u+fMKiO/+krvucO7mSLZeBb9XZLadyMioCfsfGRaojqf8xdSX
	 3yQoGm8YQ6dbwI2ndHuzqAOyqLtotpyGTG/syOdp5P/0CCdu42VxoXuFofaNYnQi1F
	 Gz8qQJ53Gj7TlZIuWezDJNBj1aQXqHDrmxfRQhrtvgqM9PqcbGs7BTmc0+ZJcEgI7N
	 y+pmScz5mhC3FJbAF1E5W+YSJvn0pKo6d81lNGQPG++ceCnJpIdbNRGsYNhH+ubGu3
	 yCq915gth5/4dhqjw1KpbK4OtK0wsLBZmnCa4RHHwP92aomBumJBIDTZHpTVvhpt1k
	 qudUKqg02bgpg==
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
Subject: [PATCHv3 4/7] libbpf: Add support for uprobe multi session attach
Date: Mon,  9 Sep 2024 09:45:51 +0200
Message-ID: <20240909074554.2339984-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909074554.2339984-1-jolsa@kernel.org>
References: <20240909074554.2339984-1-jolsa@kernel.org>
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
index 274441674f92..7b72a29b09a7 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9345,6 +9345,7 @@ static int attach_trace(const struct bpf_program *prog, long cookie, struct bpf_
 static int attach_kprobe_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_kprobe_session(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
+static int attach_uprobe_session(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_lsm(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_iter(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 
@@ -9363,8 +9364,10 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("kprobe.session+",	KPROBE,	BPF_TRACE_KPROBE_SESSION, SEC_NONE, attach_kprobe_session),
 	SEC_DEF("uprobe.multi+",	KPROBE,	BPF_TRACE_UPROBE_MULTI, SEC_NONE, attach_uprobe_multi),
 	SEC_DEF("uretprobe.multi+",	KPROBE,	BPF_TRACE_UPROBE_MULTI, SEC_NONE, attach_uprobe_multi),
+	SEC_DEF("uprobe.session+",	KPROBE,	BPF_TRACE_UPROBE_SESSION, SEC_NONE, attach_uprobe_session),
 	SEC_DEF("uprobe.multi.s+",	KPROBE,	BPF_TRACE_UPROBE_MULTI, SEC_SLEEPABLE, attach_uprobe_multi),
 	SEC_DEF("uretprobe.multi.s+",	KPROBE,	BPF_TRACE_UPROBE_MULTI, SEC_SLEEPABLE, attach_uprobe_multi),
+	SEC_DEF("uprobe.session.s+",	KPROBE,	BPF_TRACE_UPROBE_SESSION, SEC_SLEEPABLE, attach_uprobe_session),
 	SEC_DEF("ksyscall+",		KPROBE,	0, SEC_NONE, attach_ksyscall),
 	SEC_DEF("kretsyscall+",		KPROBE, 0, SEC_NONE, attach_ksyscall),
 	SEC_DEF("usdt+",		KPROBE,	0, SEC_USDT, attach_usdt),
@@ -11699,6 +11702,39 @@ static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, stru
 	return ret;
 }
 
+static int attach_uprobe_session(const struct bpf_program *prog, long cookie, struct bpf_link **link)
+{
+	LIBBPF_OPTS(bpf_uprobe_multi_opts, opts, .session = true);
+	char *binary_path = NULL, *func_name = NULL;
+	int n, ret = -EINVAL;
+	const char *spec;
+
+	*link = NULL;
+
+	spec = prog->sec_name + sizeof("uprobe.session/") - 1;
+	if (cookie & SEC_SLEEPABLE)
+		spec += 2; /* extra '.s' */
+	n = sscanf(spec, "%m[^:]:%m[^\n]", &binary_path, &func_name);
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
@@ -11933,10 +11969,12 @@ bpf_program__attach_uprobe_multi(const struct bpf_program *prog,
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
@@ -12007,12 +12045,20 @@ bpf_program__attach_uprobe_multi(const struct bpf_program *prog,
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
@@ -12026,7 +12072,7 @@ bpf_program__attach_uprobe_multi(const struct bpf_program *prog,
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



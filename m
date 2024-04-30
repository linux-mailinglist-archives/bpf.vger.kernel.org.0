Return-Path: <bpf+bounces-28252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 511588B744D
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 13:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B9832868BB
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 11:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E33B12D75C;
	Tue, 30 Apr 2024 11:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5hr17Uz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF5A12BF32
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 11:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714476558; cv=none; b=OSSfqP4yG2t9cx99HOWzhmVjMo+PvySBxQDP6XLxGMQHdFXES2kcNKHydw0Ls9m7RqBt3EATo7/CazXaEByhculRPGjbeBDe9PozqCz5vOAvnrRkCugPOfVyllfRl8f4uJavavgyaE1wLUZ9V8ErUr7tbGscmECXjBLwoYO/b78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714476558; c=relaxed/simple;
	bh=O0O94FmCBPbfVzNUQicKN23EUJ+bVcytNTSL1YmGWX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i1tDcspRsR3Zr63ZVIU3UWhpBwI8Ck/icnkjRIL+/OY/31AlMWZHrMAFMmzXw2SKCa5AJqMCPwdgZK2GiipWQ2+kkLZimSbbSiEA8zN8MhoF7So0VVLw4KMtolWL5YhZb62Q5OpbUeI9MCNIDjqF7ezF3UUijvzGCstKcARjnM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5hr17Uz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8DCCC2BBFC;
	Tue, 30 Apr 2024 11:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714476558;
	bh=O0O94FmCBPbfVzNUQicKN23EUJ+bVcytNTSL1YmGWX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B5hr17UzakwVXR60o3Y9uOA7dAtUL2jHPA+MhR5o7kLmZsieO58U6J/YUdmD2+wqU
	 XZ2T28gkUQqkshr+B8tVsW0Ivs/Jkd/d6LXzMiAGY5btj+rSXxFmxLZscuDcz3Vf9d
	 X+gT9SxtexKTPpN5Bdt9QYiOSPHZ/JmgQGRWcg0t/tE28/sUB6rAr1lCLGfiGC2rP0
	 d8Zvo+MlbXO5dY+PIdfl9T2ZYtHohJZFFsRNwbPg1dlPfxpzYoEVLNbOnUOirWYnYB
	 RSgg2C6WW5rYb4wPKGN49wD6mbEa+pxZBrGd15nlqb+hAqYxIfqa/8blmWSnT/xBxV
	 gpRnoC0J766Wg==
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
	Viktor Malik <vmalik@redhat.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: [PATCHv2 bpf-next 4/7] libbpf: Add support for kprobe session attach
Date: Tue, 30 Apr 2024 13:28:27 +0200
Message-ID: <20240430112830.1184228-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430112830.1184228-1-jolsa@kernel.org>
References: <20240430112830.1184228-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support to attach program in kprobe session mode
with bpf_program__attach_kprobe_multi_opts function.

Adding session bool to bpf_kprobe_multi_opts struct that allows
to load and attach the bpf program via kprobe session.
the attachment to create kprobe multi session.

Also adding new program loader section that allows:
 SEC("kprobe.session/bpf_fentry_test*")

and loads/attaches kprobe program as kprobe session.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/bpf.c    |  1 +
 tools/lib/bpf/libbpf.c | 39 +++++++++++++++++++++++++++++++++++++--
 tools/lib/bpf/libbpf.h |  4 +++-
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index c9f4e04f38fe..466a29d80124 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -766,6 +766,7 @@ int bpf_link_create(int prog_fd, int target_fd,
 			return libbpf_err(-EINVAL);
 		break;
 	case BPF_TRACE_KPROBE_MULTI:
+	case BPF_TRACE_KPROBE_SESSION:
 		attr.link_create.kprobe_multi.flags = OPTS_GET(opts, kprobe_multi.flags, 0);
 		attr.link_create.kprobe_multi.cnt = OPTS_GET(opts, kprobe_multi.cnt, 0);
 		attr.link_create.kprobe_multi.syms = ptr_to_u64(OPTS_GET(opts, kprobe_multi.syms, 0));
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 898d5d34ecea..16dae279a900 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9273,6 +9273,7 @@ static int attach_tp(const struct bpf_program *prog, long cookie, struct bpf_lin
 static int attach_raw_tp(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_trace(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_kprobe_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
+static int attach_kprobe_session(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_lsm(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_iter(const struct bpf_program *prog, long cookie, struct bpf_link **link);
@@ -9289,6 +9290,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("uretprobe.s+",		KPROBE, 0, SEC_SLEEPABLE, attach_uprobe),
 	SEC_DEF("kprobe.multi+",	KPROBE,	BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
 	SEC_DEF("kretprobe.multi+",	KPROBE,	BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
+	SEC_DEF("kprobe.session+",	KPROBE,	BPF_TRACE_KPROBE_SESSION, SEC_NONE, attach_kprobe_session),
 	SEC_DEF("uprobe.multi+",	KPROBE,	BPF_TRACE_UPROBE_MULTI, SEC_NONE, attach_uprobe_multi),
 	SEC_DEF("uretprobe.multi+",	KPROBE,	BPF_TRACE_UPROBE_MULTI, SEC_NONE, attach_uprobe_multi),
 	SEC_DEF("uprobe.multi.s+",	KPROBE,	BPF_TRACE_UPROBE_MULTI, SEC_SLEEPABLE, attach_uprobe_multi),
@@ -11381,13 +11383,14 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 	struct kprobe_multi_resolve res = {
 		.pattern = pattern,
 	};
+	enum bpf_attach_type attach_type;
 	struct bpf_link *link = NULL;
 	char errmsg[STRERR_BUFSIZE];
 	const unsigned long *addrs;
 	int err, link_fd, prog_fd;
+	bool retprobe, session;
 	const __u64 *cookies;
 	const char **syms;
-	bool retprobe;
 	size_t cnt;
 
 	if (!OPTS_VALID(opts, bpf_kprobe_multi_opts))
@@ -11426,6 +11429,12 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 	}
 
 	retprobe = OPTS_GET(opts, retprobe, false);
+	session  = OPTS_GET(opts, session, false);
+
+	if (retprobe && session)
+		return libbpf_err_ptr(-EINVAL);
+
+	attach_type = session ? BPF_TRACE_KPROBE_SESSION : BPF_TRACE_KPROBE_MULTI;
 
 	lopts.kprobe_multi.syms = syms;
 	lopts.kprobe_multi.addrs = addrs;
@@ -11440,7 +11449,7 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 	}
 	link->detach = &bpf_link__detach_fd;
 
-	link_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_KPROBE_MULTI, &lopts);
+	link_fd = bpf_link_create(prog_fd, 0, attach_type, &lopts);
 	if (link_fd < 0) {
 		err = -errno;
 		pr_warn("prog '%s': failed to attach: %s\n",
@@ -11546,6 +11555,32 @@ static int attach_kprobe_multi(const struct bpf_program *prog, long cookie, stru
 	return libbpf_get_error(*link);
 }
 
+static int attach_kprobe_session(const struct bpf_program *prog, long cookie,
+				 struct bpf_link **link)
+{
+	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts, .session = true);
+	const char *spec;
+	char *pattern;
+	int n;
+
+	*link = NULL;
+
+	/* no auto-attach for SEC("kprobe.session") */
+	if (strcmp(prog->sec_name, "kprobe.session") == 0)
+		return 0;
+
+	spec = prog->sec_name + sizeof("kprobe.session/") - 1;
+	n = sscanf(spec, "%m[a-zA-Z0-9_.*?]", &pattern);
+	if (n < 1) {
+		pr_warn("kprobe session pattern is invalid: %s\n", pattern);
+		return -EINVAL;
+	}
+
+	*link = bpf_program__attach_kprobe_multi_opts(prog, pattern, &opts);
+	free(pattern);
+	return *link ? 0 : -errno;
+}
+
 static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link)
 {
 	char *probe_type = NULL, *binary_path = NULL, *func_name = NULL;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 1333ae20ebe6..c3f77d9260fe 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -539,10 +539,12 @@ struct bpf_kprobe_multi_opts {
 	size_t cnt;
 	/* create return kprobes */
 	bool retprobe;
+	/* create session kprobes */
+	bool session;
 	size_t :0;
 };
 
-#define bpf_kprobe_multi_opts__last_field retprobe
+#define bpf_kprobe_multi_opts__last_field session
 
 LIBBPF_API struct bpf_link *
 bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
-- 
2.44.0



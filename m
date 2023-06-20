Return-Path: <bpf+bounces-2891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F658736667
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 10:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B273B1C20BA3
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 08:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9084C125;
	Tue, 20 Jun 2023 08:37:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA5FA92D
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 08:37:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48665C433C8;
	Tue, 20 Jun 2023 08:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687250262;
	bh=FktqRvEKOQuxcgLuyn2EXyM9kfljvnXA9PSx8mLls3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U7j3MCDaFWl1044ISgiogCYF0mqMfbHa9I3hI5i7z5Ifjf/vHtl8XDyiBQfJ5sfgV
	 SYYx4UfkrGQdL3gOKU3iWXQSsoLIVtWYIDjyA56pODYmAtRiCXD0IeM3j/x/1/et7H
	 RG8iSRdEOai8vsh1H9hSi03lsXwV3xkUSSsPlXXigneTqKH5+V8DS6oZeCFtiAvjPq
	 l7D9GmbienLlgcOpvvhvfnmAo93UOa95oYkvFxvYDiaF1zIQqDUsQvCE67m7NW7cVS
	 I/ccybOvSr34/9Et7bf7ivVdLoCpYXi57W2QydAH9psp+WOuHoN0gwbwuEi2DUcf3b
	 VTeuVNzvSMe7g==
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
	Hao Luo <haoluo@google.com>
Subject: [PATCHv2 bpf-next 11/24] libbpf: Add bpf_program__attach_uprobe_multi_opts function
Date: Tue, 20 Jun 2023 10:35:37 +0200
Message-ID: <20230620083550.690426-12-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620083550.690426-1-jolsa@kernel.org>
References: <20230620083550.690426-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding bpf_program__attach_uprobe_multi_opts function that
allows to attach multiple uprobes with uprobe_multi link.

The user can specify uprobes with direct arguments:

  binary_path/func_pattern

or with struct bpf_uprobe_multi_opts opts argument fields:

  const char *path;
  const char **syms;
  const unsigned long *offsets;
  const unsigned long *ref_ctr_offsets;

User can specify 3 mutually exclusive set of incputs:

 1) use only binary_path/func_pattern aruments

 2) use only opts argument with allowed combinations of:
    path/offsets/ref_ctr_offsets/cookies/cnt

 3) use binary_path with allowed combinations of:
    syms/offsets/ref_ctr_offsets/cookies/cnt

Any other usage results in error.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c   | 131 +++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   |  31 +++++++++
 tools/lib/bpf/libbpf.map |   1 +
 3 files changed, 163 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 3e5c88caf5d5..d972cea4c658 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11402,6 +11402,137 @@ static int resolve_full_path(const char *file, char *result, size_t result_sz)
 	return -ENOENT;
 }
 
+struct bpf_link *
+bpf_program__attach_uprobe_multi_opts(const struct bpf_program *prog,
+				      pid_t pid,
+				      const char *binary_path,
+				      const char *func_pattern,
+				      const struct bpf_uprobe_multi_opts *opts)
+{
+	const unsigned long *ref_ctr_offsets = NULL, *offsets = NULL;
+	LIBBPF_OPTS(bpf_link_create_opts, lopts);
+	unsigned long *resolved_offsets = NULL;
+	const char **resolved_symbols = NULL;
+	int err = 0, link_fd, prog_fd;
+	struct bpf_link *link = NULL;
+	char errmsg[STRERR_BUFSIZE];
+	const char *path, **syms;
+	char full_path[PATH_MAX];
+	const __u64 *cookies;
+	bool has_pattern;
+	bool retprobe;
+	size_t cnt;
+
+	if (!OPTS_VALID(opts, bpf_uprobe_multi_opts))
+		return libbpf_err_ptr(-EINVAL);
+
+	path = OPTS_GET(opts, path, NULL);
+	syms = OPTS_GET(opts, syms, NULL);
+	offsets = OPTS_GET(opts, offsets, NULL);
+	ref_ctr_offsets = OPTS_GET(opts, ref_ctr_offsets, NULL);
+	cookies = OPTS_GET(opts, cookies, NULL);
+	cnt = OPTS_GET(opts, cnt, 0);
+
+	/*
+	 * User can specify 3 mutually exclusive set of incputs:
+	 *
+	 * 1) use only binary_path/func_pattern aruments
+	 *
+	 * 2) use only opts argument with allowed combinations of:
+	 *    path/offsets/ref_ctr_offsets/cookies/cnt
+	 *
+	 * 3) use binary_path with allowed combinations of:
+	 *    syms/offsets/ref_ctr_offsets/cookies/cnt
+	 *
+	 * Any other usage results in error.
+	 */
+
+	if (!binary_path && !func_pattern && !cnt)
+		return libbpf_err_ptr(-EINVAL);
+	if (func_pattern && !binary_path)
+		return libbpf_err_ptr(-EINVAL);
+
+	has_pattern = binary_path && func_pattern;
+
+	if (has_pattern) {
+		if (path || syms || offsets || ref_ctr_offsets || cookies || cnt)
+			return libbpf_err_ptr(-EINVAL);
+	} else {
+		if (!cnt)
+			return libbpf_err_ptr(-EINVAL);
+		if (!!path == !!binary_path)
+			return libbpf_err_ptr(-EINVAL);
+		if (!!syms == !!offsets)
+			return libbpf_err_ptr(-EINVAL);
+		if (path && syms)
+			return libbpf_err_ptr(-EINVAL);
+	}
+
+	if (has_pattern) {
+		if (!strchr(binary_path, '/')) {
+			err = resolve_full_path(binary_path, full_path, sizeof(full_path));
+			if (err) {
+				pr_warn("prog '%s': failed to resolve full path for '%s': %d\n",
+					prog->name, binary_path, err);
+				return libbpf_err_ptr(err);
+			}
+			binary_path = full_path;
+		}
+
+		err = elf_find_pattern_func_offset(binary_path, func_pattern,
+						   &resolved_symbols, &resolved_offsets,
+						   &cnt);
+		if (err < 0)
+			return libbpf_err_ptr(err);
+		offsets = resolved_offsets;
+	} else if (syms) {
+		err = elf_find_multi_func_offset(binary_path, cnt, syms, &resolved_offsets);
+		if (err < 0)
+			return libbpf_err_ptr(err);
+		offsets = resolved_offsets;
+	}
+
+	retprobe = OPTS_GET(opts, retprobe, false);
+
+	lopts.uprobe_multi.path = path ?: binary_path;
+	lopts.uprobe_multi.offsets = offsets;
+	lopts.uprobe_multi.ref_ctr_offsets = ref_ctr_offsets;
+	lopts.uprobe_multi.cookies = cookies;
+	lopts.uprobe_multi.cnt = cnt;
+	lopts.uprobe_multi.flags = retprobe ? BPF_F_UPROBE_MULTI_RETURN : 0;
+
+	if (pid == 0)
+		pid = getpid();
+	if (pid > 0)
+		lopts.uprobe_multi.pid = pid;
+
+	link = calloc(1, sizeof(*link));
+	if (!link) {
+		err = -ENOMEM;
+		goto error;
+	}
+	link->detach = &bpf_link__detach_fd;
+
+	prog_fd = bpf_program__fd(prog);
+	link_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &lopts);
+	if (link_fd < 0) {
+		err = -errno;
+		pr_warn("prog '%s': failed to attach: %s\n",
+			prog->name, libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+		goto error;
+	}
+	link->fd = link_fd;
+	free(resolved_offsets);
+	free(resolved_symbols);
+	return link;
+
+error:
+	free(resolved_offsets);
+	free(resolved_symbols);
+	free(link);
+	return libbpf_err_ptr(err);
+}
+
 LIBBPF_API struct bpf_link *
 bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 				const char *binary_path, size_t func_offset,
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 754da73c643b..b6ff7d69a1d7 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -529,6 +529,37 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 				      const char *pattern,
 				      const struct bpf_kprobe_multi_opts *opts);
 
+struct bpf_uprobe_multi_opts {
+	/* size of this struct, for forward/backward compatibility */
+	size_t sz;
+	/* path to attach */
+	const char *path;
+	/* array of function symbols to attach */
+	const char **syms;
+	/* array of function addresses to attach */
+	const unsigned long *offsets;
+	/* array of refctr offsets to attach */
+	const unsigned long *ref_ctr_offsets;
+	/* array of user-provided values fetchable through bpf_get_attach_cookie */
+	const __u64 *cookies;
+	/* number of elements in syms/addrs/cookies arrays */
+	size_t cnt;
+	/* create return uprobes */
+	bool retprobe;
+	/* pid filter */
+	int pid;
+	size_t :0;
+};
+
+#define bpf_uprobe_multi_opts__last_field pid
+
+LIBBPF_API struct bpf_link *
+bpf_program__attach_uprobe_multi_opts(const struct bpf_program *prog,
+				      pid_t pid,
+				      const char *binary_path,
+				      const char *func_pattern,
+				      const struct bpf_uprobe_multi_opts *opts);
+
 struct bpf_ksyscall_opts {
 	/* size of this struct, for forward/backward compatibility */
 	size_t sz;
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 7521a2fb7626..81558ef1bc38 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -390,6 +390,7 @@ LIBBPF_1.2.0 {
 		bpf_link_get_info_by_fd;
 		bpf_map_get_info_by_fd;
 		bpf_prog_get_info_by_fd;
+		bpf_program__attach_uprobe_multi_opts;
 } LIBBPF_1.1.0;
 
 LIBBPF_1.3.0 {
-- 
2.41.0



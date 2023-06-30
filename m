Return-Path: <bpf+bounces-3780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F0574376C
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 10:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02B6281082
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 08:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC7BA957;
	Fri, 30 Jun 2023 08:36:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9352DA932
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 08:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E57C433C0;
	Fri, 30 Jun 2023 08:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688114185;
	bh=2Yq5mpC+pEG+MrqXH74X96nZwjknPf5/vBk2V8r242g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kRg49m1Xwl+F7/6R3U0uXelkVD6v14VPyCNZjSyKGHg/iwR+vasBBn+zdHjfn+bV0
	 0mUcnCnjCF4LnO2jrYnd53yIMjnHVrwXSpvxgrMpYjKYra73/5zonjaCzCAnFnaX7B
	 QTAHhTqGHxXjb06NL/uUoOLrt14TNZt0smX7KwOUeVKUk5yzNA/CGnrtbNQBiqgyVI
	 7Qt7xOqK0haB9PTqNHZBr4peEgPzf7wZbrSq7nkh5RyfqlNu9UPz9JhbS2PAV/uhjI
	 2qKjFr8F9/K53yjDEYezxqQVd7C3b0q5mCk8U+F6FtPAu678JSAAQtjF217ZHypmlX
	 nAp00L6PpexJA==
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
Subject: [PATCHv3 bpf-next 13/26] libbpf: Add bpf_program__attach_uprobe_multi function
Date: Fri, 30 Jun 2023 10:33:31 +0200
Message-ID: <20230630083344.984305-14-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630083344.984305-1-jolsa@kernel.org>
References: <20230630083344.984305-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding bpf_program__attach_uprobe_multi function that
allows to attach multiple uprobes with uprobe_multi link.

The user can specify uprobes with direct arguments:

  binary_path/func_pattern/pid

or with struct bpf_uprobe_multi_opts opts argument fields:

  const char **syms;
  const unsigned long *offsets;
  const unsigned long *ref_ctr_offsets;
  const __u64 *cookies;

User can specify 2 mutually exclusive set of inputs:

 1) use only path/func_pattern/pid arguments

 2) use path/pid with allowed combinations of:
    syms/offsets/ref_ctr_offsets/cookies/cnt

    - syms and offsets are mutually exclusive
    - ref_ctr_offsets and cookies are optional

Any other usage results in error.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c   | 122 +++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   |  27 +++++++++
 tools/lib/bpf/libbpf.map |   1 +
 3 files changed, 150 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index f33ef7cb1adc..b942f248038e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10954,6 +10954,128 @@ static int resolve_full_path(const char *file, char *result, size_t result_sz)
 	return -ENOENT;
 }
 
+struct bpf_link *
+bpf_program__attach_uprobe_multi(const struct bpf_program *prog,
+				 pid_t pid,
+				 const char *path,
+				 const char *func_pattern,
+				 const struct bpf_uprobe_multi_opts *opts)
+{
+	const unsigned long *ref_ctr_offsets = NULL, *offsets = NULL;
+	LIBBPF_OPTS(bpf_link_create_opts, lopts);
+	unsigned long *resolved_offsets = NULL;
+	int err = 0, link_fd, prog_fd;
+	struct bpf_link *link = NULL;
+	char errmsg[STRERR_BUFSIZE];
+	char full_path[PATH_MAX];
+	const __u64 *cookies;
+	const char **syms;
+	bool has_pattern;
+	bool retprobe;
+	size_t cnt;
+
+	if (!OPTS_VALID(opts, bpf_uprobe_multi_opts))
+		return libbpf_err_ptr(-EINVAL);
+
+	syms = OPTS_GET(opts, syms, NULL);
+	offsets = OPTS_GET(opts, offsets, NULL);
+	ref_ctr_offsets = OPTS_GET(opts, ref_ctr_offsets, NULL);
+	cookies = OPTS_GET(opts, cookies, NULL);
+	cnt = OPTS_GET(opts, cnt, 0);
+
+	/*
+	 * User can specify 2 mutually exclusive set of inputs:
+	 *
+	 * 1) use only path/func_pattern/pid arguments
+	 *
+	 * 2) use path/pid with allowed combinations of:
+	 *    syms/offsets/ref_ctr_offsets/cookies/cnt
+	 *
+	 *    - syms and offsets are mutually exclusive
+	 *    - ref_ctr_offsets and cookies are optional
+	 *
+	 * Any other usage results in error.
+	 */
+
+	if (!path && !func_pattern && !cnt)
+		return libbpf_err_ptr(-EINVAL);
+	if (func_pattern && !path)
+		return libbpf_err_ptr(-EINVAL);
+
+	has_pattern = path && func_pattern;
+
+	if (has_pattern) {
+		if (syms || offsets || ref_ctr_offsets || cookies || cnt)
+			return libbpf_err_ptr(-EINVAL);
+	} else {
+		if (!cnt)
+			return libbpf_err_ptr(-EINVAL);
+		if (!!syms == !!offsets)
+			return libbpf_err_ptr(-EINVAL);
+	}
+
+	if (has_pattern) {
+		if (!strchr(path, '/')) {
+			err = resolve_full_path(path, full_path, sizeof(full_path));
+			if (err) {
+				pr_warn("prog '%s': failed to resolve full path for '%s': %d\n",
+					prog->name, path, err);
+				return libbpf_err_ptr(err);
+			}
+			path = full_path;
+		}
+
+		err = elf_resolve_pattern_offsets(path, func_pattern,
+						  &resolved_offsets, &cnt);
+		if (err < 0)
+			return libbpf_err_ptr(err);
+		offsets = resolved_offsets;
+	} else if (syms) {
+		err = elf_resolve_syms_offsets(path, cnt, syms, &resolved_offsets);
+		if (err < 0)
+			return libbpf_err_ptr(err);
+		offsets = resolved_offsets;
+	}
+
+	retprobe = OPTS_GET(opts, retprobe, false);
+
+	lopts.uprobe_multi.path = path;
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
+	return link;
+
+error:
+	free(resolved_offsets);
+	free(link);
+	return libbpf_err_ptr(err);
+}
+
 LIBBPF_API struct bpf_link *
 bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 				const char *binary_path, size_t func_offset,
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 754da73c643b..7c218f610210 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -529,6 +529,33 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 				      const char *pattern,
 				      const struct bpf_kprobe_multi_opts *opts);
 
+struct bpf_uprobe_multi_opts {
+	/* size of this struct, for forward/backward compatibility */
+	size_t sz;
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
+	size_t :0;
+};
+
+#define bpf_uprobe_multi_opts__last_field retprobe
+
+LIBBPF_API struct bpf_link *
+bpf_program__attach_uprobe_multi(const struct bpf_program *prog,
+				 pid_t pid,
+				 const char *binary_path,
+				 const char *func_pattern,
+				 const struct bpf_uprobe_multi_opts *opts);
+
 struct bpf_ksyscall_opts {
 	/* size of this struct, for forward/backward compatibility */
 	size_t sz;
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 7521a2fb7626..d8d11ea6c35e 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -395,4 +395,5 @@ LIBBPF_1.2.0 {
 LIBBPF_1.3.0 {
 	global:
 		bpf_obj_pin_opts;
+		bpf_program__attach_uprobe_multi;
 } LIBBPF_1.2.0;
-- 
2.41.0



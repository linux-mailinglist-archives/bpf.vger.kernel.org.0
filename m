Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6CA6ED204
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 18:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjDXQGg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 12:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbjDXQGf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 12:06:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E556C6EB2
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 09:06:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8138661B47
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 16:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BAC5C433EF;
        Mon, 24 Apr 2023 16:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682352392;
        bh=/9ywEhBkIC/m5wfYdpkWTwLs5LVLRAYXfjnzpncDMLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K04ZpHuB6QPPKKg356JBG0eVDcDfxeNaqSuN1DQWezVwXUpxa8MrTFEiIF6qrmTMH
         9JHU6LbEr7X3CCM60fJ0R9oEOXpWhySFRY9AZjkgodU8Spzs8y21Ipxza+yxRTjVmM
         tXgrjUPL6/IiVQCtyoy5u9/cdjplRlQ5q02y+huXtyAl2ind3ztDDxk9KAzvXJKliW
         P3zZ8Ett5KkGdB4HQkasWWP+PEyN6p4qLea9y2lxZu0bZ/HeDLPGA/+R7wGtuqbAsC
         MYAEdow5QZoOBZplWen3DVaAxsn0tq6UOJsRDhNpb9NEq+fxgFcojxAbvxX4N7zVfF
         w7Xge4olb9SEA==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [RFC/PATCH bpf-next 10/20] libbpf: Add bpf_program__attach_uprobe_multi_opts function
Date:   Mon, 24 Apr 2023 18:04:37 +0200
Message-Id: <20230424160447.2005755-11-jolsa@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230424160447.2005755-1-jolsa@kernel.org>
References: <20230424160447.2005755-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding bpf_program__attach_uprobe_multi_opts function that
allows to attach multiple uprobes with uprobe_multi link.

The user can specify uprobes with direct arguments:

  binary_path/func_pattern

or with struct bpf_uprobe_multi_opts opts argument fields:

  const char **paths;
  const char **syms;
  const unsigned long *offsets;
  const unsigned long *ref_ctr_offsets;

User can specify 3 mutually exclusive set of incputs:

 1) use only binary_path/func_pattern aruments

 2) use only opts argument with allowed combinations of:
    paths/offsets/ref_ctr_offsets/cookies/cnt

 3) use binary_path with allowed combinations of:
    syms/offsets/ref_ctr_offsets/cookies/cnt

Any other usage results in error.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c   | 137 +++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   |  28 ++++++++
 tools/lib/bpf/libbpf.map |   1 +
 3 files changed, 166 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 7eb7035f7b73..c786bc142791 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11345,6 +11345,143 @@ static int resolve_full_path(const char *file, char *result, size_t result_sz)
 	return -ENOENT;
 }
 
+struct bpf_link *
+bpf_program__attach_uprobe_multi_opts(const struct bpf_program *prog,
+				      const char *binary_path,
+				      const char *func_pattern,
+				      const struct bpf_uprobe_multi_opts *opts)
+{
+	const unsigned long *ref_ctr_offsets = NULL, *offsets = NULL;
+	LIBBPF_OPTS(bpf_link_create_opts, lopts);
+	unsigned long *resolved_offsets = NULL;
+	const char **resolved_symbols = NULL;
+	const char **resolved_paths = NULL;
+	int i, err = 0, link_fd, prog_fd;
+	struct bpf_link *link = NULL;
+	char errmsg[STRERR_BUFSIZE];
+	const char **paths, **syms;
+	char full_path[PATH_MAX];
+	const __u64 *cookies;
+	bool has_pattern;
+	bool retprobe;
+	size_t cnt;
+
+	if (!OPTS_VALID(opts, bpf_uprobe_multi_opts))
+		return libbpf_err_ptr(-EINVAL);
+
+	paths = OPTS_GET(opts, paths, NULL);
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
+	 *    paths/offsets/ref_ctr_offsets/cookies/cnt
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
+		if (paths || syms || offsets || ref_ctr_offsets || cookies || cnt)
+			return libbpf_err_ptr(-EINVAL);
+	} else {
+		if (!cnt)
+			return libbpf_err_ptr(-EINVAL);
+		if (!!paths == !!binary_path)
+			return libbpf_err_ptr(-EINVAL);
+		if (!!syms == !!offsets)
+			return libbpf_err_ptr(-EINVAL);
+		if (paths && syms)
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
+		err = elf_find_patern_func_offset(binary_path, func_pattern,
+						  &resolved_symbols, &resolved_offsets,
+						  &cnt);
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
+	if (binary_path) {
+		resolved_paths = calloc(cnt, sizeof(*paths));
+		if (!resolved_paths)
+			goto error;
+		for (i = 0; i < cnt; i++)
+			resolved_paths[i] = binary_path;
+		paths = resolved_paths;
+	}
+
+	retprobe = OPTS_GET(opts, retprobe, false);
+
+	lopts.uprobe_multi.paths = paths;
+	lopts.uprobe_multi.offsets = offsets;
+	lopts.uprobe_multi.ref_ctr_offsets = ref_ctr_offsets;
+	lopts.uprobe_multi.cookies = cookies;
+	lopts.uprobe_multi.cnt = cnt;
+	lopts.uprobe_multi.flags = retprobe ? BPF_F_UPROBE_MULTI_RETURN : 0;
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
+	free(resolved_paths);
+	return link;
+
+error:
+	free(resolved_offsets);
+	free(resolved_symbols);
+	free(resolved_paths);
+	free(link);
+	return libbpf_err_ptr(err);
+}
+
 LIBBPF_API struct bpf_link *
 bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 				const char *binary_path, size_t func_offset,
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 96ed109ae011..921ab2a94cec 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -529,6 +529,34 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 				      const char *pattern,
 				      const struct bpf_kprobe_multi_opts *opts);
 
+struct bpf_uprobe_multi_opts {
+	/* size of this struct, for forward/backward compatibility */
+	size_t sz;
+	/* array of paths to attach */
+	const char **paths;
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
+bpf_program__attach_uprobe_multi_opts(const struct bpf_program *prog,
+				      const char *binary_path,
+				      const char *func_pattern,
+				      const struct bpf_uprobe_multi_opts *opts);
+
 struct bpf_ksyscall_opts {
 	/* size of this struct, for forward/backward compatibility */
 	size_t sz;
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 2f091a0f093b..7aae41ff181d 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -392,4 +392,5 @@ LIBBPF_1.2.0 {
 		bpf_prog_get_info_by_fd;
 		elf_find_multi_func_offset;
 		elf_find_patern_func_offset;
+		bpf_program__attach_uprobe_multi_opts;
 } LIBBPF_1.1.0;
-- 
2.40.0


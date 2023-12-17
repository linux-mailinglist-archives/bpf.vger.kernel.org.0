Return-Path: <bpf+bounces-18139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 376678162AF
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 22:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3CE4282A32
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 21:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F2E495E0;
	Sun, 17 Dec 2023 21:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8JVIDwf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC66481DA
	for <bpf@vger.kernel.org>; Sun, 17 Dec 2023 21:56:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1078C433C7;
	Sun, 17 Dec 2023 21:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702850166;
	bh=eTOZKn6JUzOy8vh+dhgM54DI0KwIV9SWs9NkH3bJuQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E8JVIDwfJKyJpqicWCZGnmhg17LevkyG2Cb9SH2EmCPu6Jwisp71+81ClDy0xTLcZ
	 U55KhWX5JotvGTwa6XeTNfvYqkKelqUjY3bDVfJsDkbmmlYC6jkgbOEq7VVmhBXSA1
	 UCGNItrZ5SrxI+nQDOldpyGPQ690l7yEScHlY/+VDhKBdLFrU6QwQQRxVm1151X4o7
	 Y1MRQxDsV/ctLbPNgX3lXzx0UGT/O2VSeK3usgGPggER/3OwIKj3xKJC8s6qiT4fTT
	 EcdX7b7wrFSa6HpfC+Qm+vLQ3r4d1BLxzCr+Rt4qBDrI/RS6hyn2OqpveN4CjK4QdE
	 A9e8wAq5P7KKA==
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
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCHv2 bpf-next 2/2] selftests/bpf: Add more uprobe multi fail tests
Date: Sun, 17 Dec 2023 22:55:38 +0100
Message-ID: <20231217215538.3361991-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231217215538.3361991-1-jolsa@kernel.org>
References: <20231217215538.3361991-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We fail to create uprobe if we pass negative offset,
adding test for that plus some more.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 149 +++++++++++++++++-
 1 file changed, 146 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 07a009f95e85..8269cdee33ae 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -239,23 +239,166 @@ static void test_attach_api_fails(void)
 	LIBBPF_OPTS(bpf_link_create_opts, opts);
 	const char *path = "/proc/self/exe";
 	struct uprobe_multi *skel = NULL;
+	int prog_fd, link_fd = -1;
 	unsigned long offset = 0;
-	int link_fd = -1;
 
 	skel = uprobe_multi__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "uprobe_multi__open_and_load"))
 		goto cleanup;
 
+	prog_fd = bpf_program__fd(skel->progs.uprobe_extra);
+
 	/* abnormal cnt */
 	opts.uprobe_multi.path = path;
 	opts.uprobe_multi.offsets = &offset;
 	opts.uprobe_multi.cnt = INT_MAX;
-	link_fd = bpf_link_create(bpf_program__fd(skel->progs.uprobe), 0,
-				  BPF_TRACE_UPROBE_MULTI, &opts);
+	link_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &opts);
 	if (!ASSERT_ERR(link_fd, "link_fd"))
 		goto cleanup;
 	if (!ASSERT_EQ(link_fd, -E2BIG, "big cnt"))
 		goto cleanup;
+
+	/* cnt is 0 */
+	LIBBPF_OPTS_RESET(opts,
+		.uprobe_multi.path = path,
+		.uprobe_multi.offsets = (unsigned long *) &offset,
+	);
+
+	link_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &opts);
+	if (!ASSERT_ERR(link_fd, "link_fd"))
+		goto cleanup;
+	if (!ASSERT_EQ(link_fd, -EINVAL, "cnt_is_zero"))
+		goto cleanup;
+
+	/* negative offset */
+	offset = -1;
+	opts.uprobe_multi.path = path;
+	opts.uprobe_multi.offsets = (unsigned long *) &offset;
+	opts.uprobe_multi.cnt = 1;
+
+	link_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &opts);
+	if (!ASSERT_ERR(link_fd, "link_fd"))
+		goto cleanup;
+	if (!ASSERT_EQ(link_fd, -EINVAL, "offset_is_negative"))
+		goto cleanup;
+
+	/* offsets is NULL */
+	LIBBPF_OPTS_RESET(opts,
+		.uprobe_multi.path = path,
+		.uprobe_multi.cnt = 1,
+	);
+
+	link_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &opts);
+	if (!ASSERT_ERR(link_fd, "link_fd"))
+		goto cleanup;
+	if (!ASSERT_EQ(link_fd, -EINVAL, "offsets_is_null"))
+		goto cleanup;
+
+	/* wrong offsets pointer */
+	LIBBPF_OPTS_RESET(opts,
+		.uprobe_multi.path = path,
+		.uprobe_multi.offsets = (unsigned long *) 1,
+		.uprobe_multi.cnt = 1,
+	);
+
+	link_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &opts);
+	if (!ASSERT_ERR(link_fd, "link_fd"))
+		goto cleanup;
+	if (!ASSERT_EQ(link_fd, -EFAULT, "offsets_is_wrong"))
+		goto cleanup;
+
+	/* path is NULL */
+	offset = 1;
+	LIBBPF_OPTS_RESET(opts,
+		.uprobe_multi.offsets = (unsigned long *) &offset,
+		.uprobe_multi.cnt = 1,
+	);
+
+	link_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &opts);
+	if (!ASSERT_ERR(link_fd, "link_fd"))
+		goto cleanup;
+	if (!ASSERT_EQ(link_fd, -EINVAL, "path_is_null"))
+		goto cleanup;
+
+	/* wrong path pointer  */
+	LIBBPF_OPTS_RESET(opts,
+		.uprobe_multi.path = (const char *) 1,
+		.uprobe_multi.offsets = (unsigned long *) &offset,
+		.uprobe_multi.cnt = 1,
+	);
+
+	link_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &opts);
+	if (!ASSERT_ERR(link_fd, "link_fd"))
+		goto cleanup;
+	if (!ASSERT_EQ(link_fd, -EFAULT, "path_is_wrong"))
+		goto cleanup;
+
+	/* wrong path type */
+	LIBBPF_OPTS_RESET(opts,
+		.uprobe_multi.path = "/",
+		.uprobe_multi.offsets = (unsigned long *) &offset,
+		.uprobe_multi.cnt = 1,
+	);
+
+	link_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &opts);
+	if (!ASSERT_ERR(link_fd, "link_fd"))
+		goto cleanup;
+	if (!ASSERT_EQ(link_fd, -EBADF, "path_is_wrong_type"))
+		goto cleanup;
+
+	/* wrong cookies pointer */
+	LIBBPF_OPTS_RESET(opts,
+		.uprobe_multi.path = path,
+		.uprobe_multi.offsets = (unsigned long *) &offset,
+		.uprobe_multi.cookies = (__u64 *) 1ULL,
+		.uprobe_multi.cnt = 1,
+	);
+
+	link_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &opts);
+	if (!ASSERT_ERR(link_fd, "link_fd"))
+		goto cleanup;
+	if (!ASSERT_EQ(link_fd, -EFAULT, "cookies_is_wrong"))
+		goto cleanup;
+
+	/* wrong ref_ctr_offsets pointer */
+	LIBBPF_OPTS_RESET(opts,
+		.uprobe_multi.path = path,
+		.uprobe_multi.offsets = (unsigned long *) &offset,
+		.uprobe_multi.cookies = (__u64 *) &offset,
+		.uprobe_multi.ref_ctr_offsets = (unsigned long *) 1,
+		.uprobe_multi.cnt = 1,
+	);
+
+	link_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &opts);
+	if (!ASSERT_ERR(link_fd, "link_fd"))
+		goto cleanup;
+	if (!ASSERT_EQ(link_fd, -EFAULT, "ref_ctr_offsets_is_wrong"))
+		goto cleanup;
+
+	/* wrong flags */
+	LIBBPF_OPTS_RESET(opts,
+		.uprobe_multi.flags = 1 << 31,
+	);
+
+	link_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &opts);
+	if (!ASSERT_ERR(link_fd, "link_fd"))
+		goto cleanup;
+	if (!ASSERT_EQ(link_fd, -EINVAL, "wrong_flags"))
+		goto cleanup;
+
+	/* wrong pid */
+	LIBBPF_OPTS_RESET(opts,
+		.uprobe_multi.path = path,
+		.uprobe_multi.offsets = (unsigned long *) &offset,
+		.uprobe_multi.cnt = 1,
+		.uprobe_multi.pid = -2,
+	);
+
+	link_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &opts);
+	if (!ASSERT_ERR(link_fd, "link_fd"))
+		goto cleanup;
+	ASSERT_EQ(link_fd, -ESRCH, "pid_is_wrong");
+
 cleanup:
 	if (link_fd >= 0)
 		close(link_fd);
-- 
2.43.0



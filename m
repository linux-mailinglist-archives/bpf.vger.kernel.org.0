Return-Path: <bpf+bounces-17673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD400811460
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 15:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A0828278A
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 14:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A46D2E844;
	Wed, 13 Dec 2023 14:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTZ26ieH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017E02E835
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 14:12:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA876C433C7;
	Wed, 13 Dec 2023 14:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702476770;
	bh=HE1orOoNFSwlY2tEkIusKvIBVjsDwCmt6/cMQCPUYjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TTZ26ieHHfcri5TX3xIFk3hoSmUFL1pJjzOZ7iFfzi7blLeqrHN08UztNHC2jjt8A
	 fgLEHqpjYzwGZThKzxBVf+PV0ACgktkGPkU3DEPUZsKWXcT9Kwcecp1zNNOHGFdqEG
	 fsnDizMssVPRr3zrP6iowpCY/uJc3PGrII7VFlDmqj+D7+cP2GAO2ixKrZjlRBTxQf
	 9Hyqi4oJ6wESA0LLViXN8ifFCaAmrO0Ap9tsCnmQN8xMXa2m7mhDQYsvoJRALYgo0X
	 W1SU92XvcqfUhcPdpe8SDdNjAuAOVNi148rCe2Ou00824NMIJa2SYUggO+tk3qyHjh
	 vCE+ypOJpveFQ==
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
	Oleg Nesterov <oleg@redhat.com>
Subject: [RFC bpf-next 2/2] selftests/bpf: Add uprobe multi fail test
Date: Wed, 13 Dec 2023 15:12:34 +0100
Message-ID: <20231213141234.1210389-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213141234.1210389-1-jolsa@kernel.org>
References: <20231213141234.1210389-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We fail to create uprobe if we pass negative offset,
adding test for that.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index ece260cf2c0b..aebfa7e6bfd6 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -326,6 +326,31 @@ void test_link_api(void)
 	__test_link_api(child);
 }
 
+static void test_attach_api_fails(void)
+{
+	LIBBPF_OPTS(bpf_link_create_opts, opts);
+	const char *path = "/proc/self/exe";
+	struct uprobe_multi *skel = NULL;
+	int prog_fd, link_fd;
+	long offset = -1;
+
+	skel = uprobe_multi__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_multi__open_and_load"))
+		return;
+
+	/* fail_1 - attach on negative offset */
+	opts.uprobe_multi.path = path;
+	opts.uprobe_multi.offsets = (unsigned long *) &offset;
+	opts.uprobe_multi.cnt = 1;
+
+	prog_fd = bpf_program__fd(skel->progs.uprobe_extra);
+	link_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &opts);
+	if (!ASSERT_EQ(link_fd, -EINVAL, "link_fd"))
+		close(link_fd);
+
+	uprobe_multi__destroy(skel);
+}
+
 static void test_bench_attach_uprobe(void)
 {
 	long attach_start_ns = 0, attach_end_ns = 0;
@@ -412,4 +437,6 @@ void test_uprobe_multi_test(void)
 		test_bench_attach_uprobe();
 	if (test__start_subtest("bench_usdt"))
 		test_bench_attach_usdt();
+	if (test__start_subtest("attach_api_fails"))
+		test_attach_api_fails();
 }
-- 
2.43.0



Return-Path: <bpf+bounces-15846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B86E77F8DF7
	for <lists+bpf@lfdr.de>; Sat, 25 Nov 2023 20:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74AAF281568
	for <lists+bpf@lfdr.de>; Sat, 25 Nov 2023 19:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61082F864;
	Sat, 25 Nov 2023 19:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/qma3uO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B0528E03
	for <bpf@vger.kernel.org>; Sat, 25 Nov 2023 19:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F42C433C9;
	Sat, 25 Nov 2023 19:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700940740;
	bh=veNngNB6VbSJLUXnfLNX/RwUMAPvQPOoWUbsHXCdYn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n/qma3uOfTKu1tXzbIEXPSWt2hmOOqb8vM01TaoKVugumi+cnPWkLJnqFCjciw6mR
	 GMSgnKYRPbN1iz9G0J6Cb63iNqK5Js8WQ3sCUb2i46/A3igF6ZgOcUhWKksUucUVue
	 09FXB1dOeTor4BLWh38CqwwE5XjYKU14Eyhluvi1h3j2rF9wDM+O4oRWM9NEDPfyMK
	 s3Pr4sUUsqHQQblw1HtjidaP+wceFoatUCzi3sA5msq6hs9MkH3GQMB0B1yRGu4yPU
	 3CeRL8e1Ec9rNeksapOGAgWb/Bu62R43facRqMvjYvBHn55mqy6nkAo8YCHmwIj3ss
	 lLk2yywFd1fqQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Yafang Shao <laoar.shao@gmail.com>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>
Subject: [PATCHv4 bpf-next 4/6] selftests/bpf: Use bpf_link__destroy in fill_link_info tests
Date: Sat, 25 Nov 2023 20:31:28 +0100
Message-ID: <20231125193130.834322-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231125193130.834322-1-jolsa@kernel.org>
References: <20231125193130.834322-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fill_link_info test keeps skeleton open and just creates
various links. We are wrongly calling bpf_link__detach after
each test to close them, we need to call bpf_link__destroy.

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Acked-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/fill_link_info.c | 44 ++++++++++---------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
index 97142a4db374..9294cb8d7743 100644
--- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
+++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
@@ -140,14 +140,14 @@ static void test_kprobe_fill_link_info(struct test_fill_link_info *skel,
 		.retprobe = type == BPF_PERF_EVENT_KRETPROBE,
 	);
 	ssize_t entry_offset = 0;
+	struct bpf_link *link;
 	int link_fd, err;
 
-	skel->links.kprobe_run = bpf_program__attach_kprobe_opts(skel->progs.kprobe_run,
-								 KPROBE_FUNC, &opts);
-	if (!ASSERT_OK_PTR(skel->links.kprobe_run, "attach_kprobe"))
+	link = bpf_program__attach_kprobe_opts(skel->progs.kprobe_run, KPROBE_FUNC, &opts);
+	if (!ASSERT_OK_PTR(link, "attach_kprobe"))
 		return;
 
-	link_fd = bpf_link__fd(skel->links.kprobe_run);
+	link_fd = bpf_link__fd(link);
 	if (!invalid) {
 		/* See also arch_adjust_kprobe_addr(). */
 		if (skel->kconfig->CONFIG_X86_KERNEL_IBT)
@@ -157,39 +157,41 @@ static void test_kprobe_fill_link_info(struct test_fill_link_info *skel,
 	} else {
 		kprobe_fill_invalid_user_buffer(link_fd);
 	}
-	bpf_link__detach(skel->links.kprobe_run);
+	bpf_link__destroy(link);
 }
 
 static void test_tp_fill_link_info(struct test_fill_link_info *skel)
 {
+	struct bpf_link *link;
 	int link_fd, err;
 
-	skel->links.tp_run = bpf_program__attach_tracepoint(skel->progs.tp_run, TP_CAT, TP_NAME);
-	if (!ASSERT_OK_PTR(skel->links.tp_run, "attach_tp"))
+	link = bpf_program__attach_tracepoint(skel->progs.tp_run, TP_CAT, TP_NAME);
+	if (!ASSERT_OK_PTR(link, "attach_tp"))
 		return;
 
-	link_fd = bpf_link__fd(skel->links.tp_run);
+	link_fd = bpf_link__fd(link);
 	err = verify_perf_link_info(link_fd, BPF_PERF_EVENT_TRACEPOINT, 0, 0, 0);
 	ASSERT_OK(err, "verify_perf_link_info");
-	bpf_link__detach(skel->links.tp_run);
+	bpf_link__destroy(link);
 }
 
 static void test_uprobe_fill_link_info(struct test_fill_link_info *skel,
 				       enum bpf_perf_event_type type)
 {
+	struct bpf_link *link;
 	int link_fd, err;
 
-	skel->links.uprobe_run = bpf_program__attach_uprobe(skel->progs.uprobe_run,
-							    type == BPF_PERF_EVENT_URETPROBE,
-							    0, /* self pid */
-							    UPROBE_FILE, uprobe_offset);
-	if (!ASSERT_OK_PTR(skel->links.uprobe_run, "attach_uprobe"))
+	link = bpf_program__attach_uprobe(skel->progs.uprobe_run,
+					  type == BPF_PERF_EVENT_URETPROBE,
+					  0, /* self pid */
+					  UPROBE_FILE, uprobe_offset);
+	if (!ASSERT_OK_PTR(link, "attach_uprobe"))
 		return;
 
-	link_fd = bpf_link__fd(skel->links.uprobe_run);
+	link_fd = bpf_link__fd(link);
 	err = verify_perf_link_info(link_fd, type, 0, uprobe_offset, 0);
 	ASSERT_OK(err, "verify_perf_link_info");
-	bpf_link__detach(skel->links.uprobe_run);
+	bpf_link__destroy(link);
 }
 
 static int verify_kmulti_link_info(int fd, bool retprobe)
@@ -278,24 +280,24 @@ static void test_kprobe_multi_fill_link_info(struct test_fill_link_info *skel,
 					     bool retprobe, bool invalid)
 {
 	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
+	struct bpf_link *link;
 	int link_fd, err;
 
 	opts.syms = kmulti_syms;
 	opts.cnt = KMULTI_CNT;
 	opts.retprobe = retprobe;
-	skel->links.kmulti_run = bpf_program__attach_kprobe_multi_opts(skel->progs.kmulti_run,
-								       NULL, &opts);
-	if (!ASSERT_OK_PTR(skel->links.kmulti_run, "attach_kprobe_multi"))
+	link = bpf_program__attach_kprobe_multi_opts(skel->progs.kmulti_run, NULL, &opts);
+	if (!ASSERT_OK_PTR(link, "attach_kprobe_multi"))
 		return;
 
-	link_fd = bpf_link__fd(skel->links.kmulti_run);
+	link_fd = bpf_link__fd(link);
 	if (!invalid) {
 		err = verify_kmulti_link_info(link_fd, retprobe);
 		ASSERT_OK(err, "verify_kmulti_link_info");
 	} else {
 		verify_kmulti_invalid_user_buffer(link_fd);
 	}
-	bpf_link__detach(skel->links.kmulti_run);
+	bpf_link__destroy(link);
 }
 
 void test_fill_link_info(void)
-- 
2.42.0



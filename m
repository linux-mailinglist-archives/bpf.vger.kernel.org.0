Return-Path: <bpf+bounces-19803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E061B831641
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 10:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1E9F283E0B
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 09:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BC31F959;
	Thu, 18 Jan 2024 09:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFBKAu0j"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914BE1BDFD
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 09:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705571722; cv=none; b=ibJt1CPbKlZLawTVOcZR0Lwrl1uFheCpXgimWD/S7IoiUxMOFhh02Tmb1hiOIok3zhLKAMzj+iE7VqaBYullk1JOvzpCEYPyTr9FuDQh1MDAM9+Q+2AJ0+h/itUL3pdDl8sKiMqR3t2qWt9Ua/DVlkxOFCbfr2byfInH4/CX4kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705571722; c=relaxed/simple;
	bh=xbYJVYgxSEkBUK9vaWzRV3/NBpHPO2JeCofc2zcX8n8=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=mAjHGbHu+EvkZx+jQtPSSSozYOyPgxWjqXsfqEiiIU4PFcu1dcmGeryygoWWb7mEdPo9F1dHkUvSRZIvWtCChSnlFTKC60ir3d3eBYEy7uA7pMhQwPRneD+fa2E3UbdgSHEjndeOt7KxpxNQEUzNe5RswEsYHh9rdoexKalUPRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFBKAu0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63387C433F1;
	Thu, 18 Jan 2024 09:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705571722;
	bh=xbYJVYgxSEkBUK9vaWzRV3/NBpHPO2JeCofc2zcX8n8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jFBKAu0jwWgxWwOtZOYht8qZh9XgR8U0QUXsCGSSONanWFAUC1u1/cPFHvRQRWq3G
	 wrOp0LglROckcvbDQ63MEj20RPiDTouw0wmpvetk7FOMvuSuiajAvyhPTRj6GqCy0J
	 VcP8RK7Xmv5o3nWxegMGtgcLJcCdQ9JmVisImjPj3XvWEWU75w6lEyrG62s3TxNlha
	 bWdBG4IDbultv5GzbPHUtHANXWr8F3ablJluABBmIURsQ6lNlBsPeTFA7Iiec5Mc6k
	 00nvjTJPsLQkLGUyirP0rKvGUfVEQ42uesEJCrHytIalxlC9HdXw07qK+b8IckT/eV
	 pF4jQUjwNpHAg==
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
	Yafang Shao <laoar.shao@gmail.com>,
	Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 5/8] selftests/bpf: Add cookies check for perf_event fill_link_info test
Date: Thu, 18 Jan 2024 10:54:13 +0100
Message-ID: <20240118095416.989152-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118095416.989152-1-jolsa@kernel.org>
References: <20240118095416.989152-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we get cookies for perf_event probes, adding tests
for cookie for kprobe/uprobe/tracepoint.

The perf_event test needs to be added completely and is coming
in following change.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/fill_link_info.c | 26 +++++++++++++++----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
index 2c2a02010c0b..20e105001bc3 100644
--- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
+++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
@@ -32,6 +32,8 @@ static noinline void uprobe_func(void)
 	asm volatile ("");
 }
 
+#define PERF_EVENT_COOKIE 0xdeadbeef
+
 static int verify_perf_link_info(int fd, enum bpf_perf_event_type type, long addr,
 				 ssize_t offset, ssize_t entry_offset)
 {
@@ -63,6 +65,8 @@ static int verify_perf_link_info(int fd, enum bpf_perf_event_type type, long add
 			ASSERT_EQ(info.perf_event.kprobe.addr, addr + entry_offset,
 				  "kprobe_addr");
 
+		ASSERT_EQ(info.perf_event.kprobe.cookie, PERF_EVENT_COOKIE, "kprobe_cookie");
+
 		if (!info.perf_event.kprobe.func_name) {
 			ASSERT_EQ(info.perf_event.kprobe.name_len, 0, "name_len");
 			info.perf_event.kprobe.func_name = ptr_to_u64(&buf);
@@ -82,6 +86,8 @@ static int verify_perf_link_info(int fd, enum bpf_perf_event_type type, long add
 			goto again;
 		}
 
+		ASSERT_EQ(info.perf_event.tracepoint.cookie, PERF_EVENT_COOKIE, "tracepoint_cookie");
+
 		err = strncmp(u64_to_ptr(info.perf_event.tracepoint.tp_name), TP_NAME,
 			      strlen(TP_NAME));
 		ASSERT_EQ(err, 0, "cmp_tp_name");
@@ -97,6 +103,8 @@ static int verify_perf_link_info(int fd, enum bpf_perf_event_type type, long add
 			goto again;
 		}
 
+		ASSERT_EQ(info.perf_event.uprobe.cookie, PERF_EVENT_COOKIE, "uprobe_cookie");
+
 		err = strncmp(u64_to_ptr(info.perf_event.uprobe.file_name), UPROBE_FILE,
 			      strlen(UPROBE_FILE));
 			ASSERT_EQ(err, 0, "cmp_file_name");
@@ -140,6 +148,7 @@ static void test_kprobe_fill_link_info(struct test_fill_link_info *skel,
 	DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, opts,
 		.attach_mode = PROBE_ATTACH_MODE_LINK,
 		.retprobe = type == BPF_PERF_EVENT_KRETPROBE,
+		.bpf_cookie = PERF_EVENT_COOKIE,
 	);
 	ssize_t entry_offset = 0;
 	struct bpf_link *link;
@@ -164,10 +173,13 @@ static void test_kprobe_fill_link_info(struct test_fill_link_info *skel,
 
 static void test_tp_fill_link_info(struct test_fill_link_info *skel)
 {
+	DECLARE_LIBBPF_OPTS(bpf_tracepoint_opts, opts,
+		.bpf_cookie = PERF_EVENT_COOKIE,
+	);
 	struct bpf_link *link;
 	int link_fd, err;
 
-	link = bpf_program__attach_tracepoint(skel->progs.tp_run, TP_CAT, TP_NAME);
+	link = bpf_program__attach_tracepoint_opts(skel->progs.tp_run, TP_CAT, TP_NAME, &opts);
 	if (!ASSERT_OK_PTR(link, "attach_tp"))
 		return;
 
@@ -180,13 +192,17 @@ static void test_tp_fill_link_info(struct test_fill_link_info *skel)
 static void test_uprobe_fill_link_info(struct test_fill_link_info *skel,
 				       enum bpf_perf_event_type type)
 {
+	DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, opts,
+		.retprobe = type == BPF_PERF_EVENT_URETPROBE,
+		.bpf_cookie = PERF_EVENT_COOKIE,
+	);
 	struct bpf_link *link;
 	int link_fd, err;
 
-	link = bpf_program__attach_uprobe(skel->progs.uprobe_run,
-					  type == BPF_PERF_EVENT_URETPROBE,
-					  0, /* self pid */
-					  UPROBE_FILE, uprobe_offset);
+	link = bpf_program__attach_uprobe_opts(skel->progs.uprobe_run,
+					       0, /* self pid */
+					       UPROBE_FILE, uprobe_offset,
+					       &opts);
 	if (!ASSERT_OK_PTR(link, "attach_uprobe"))
 		return;
 
-- 
2.43.0



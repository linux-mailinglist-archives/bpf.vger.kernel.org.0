Return-Path: <bpf+bounces-19804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A97E831642
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 10:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3DFEB216FF
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 09:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C99A200AC;
	Thu, 18 Jan 2024 09:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHGUd/s2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB009200A0
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 09:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705571734; cv=none; b=GD6SQr1XA6ZX1N/J4J7dWC6Nlmx/Fa0KplAHz6H1J5aQ82N0Eadn7at6VpsrV0AC0CUAsSYgPErUQPCaWvDFWcLdBNDyX0qdpi2PxUFjEvhIX13LS+j85VEK52efNRyBiRffB1/BBGowqUy03Q3XSIjFPa816kL/lLqgSZXkpts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705571734; c=relaxed/simple;
	bh=NW5rzKFuCFZy1w810jndYtklE+L66BXOFRZlUSIkjhg=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=GIl52Ua67Qe1i1nDONS6kBveJVM3CsTXm3Hrcoshr2xXW/Nl5V7gk4D27XMErE6dRUYaYR+O7tzUb5j8u2VF4mzZRnNp6F++Ejxot9DEDsKxF/TAMNAY4WNLK+ZK6Baz+COUMjbyliVhqRwjpxGFWaRmcioIg1y4Vt9SmxOcdXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHGUd/s2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5789EC433C7;
	Thu, 18 Jan 2024 09:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705571734;
	bh=NW5rzKFuCFZy1w810jndYtklE+L66BXOFRZlUSIkjhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HHGUd/s217VjPe9bC7qdTk/AOXwBgE518oa2W0JnpeGtGZ2169X/VQEMOA6G2bhD/
	 XZeKTDNs6q4B3P0d3vBP09qoo8zOLKyQpUVUAgryQPnmMIUZjW1hU3Rq3ocChK/Kmu
	 lP3EQDrg+dYfP5Mvian7578Zx3TuKYVnNMXCqArQqabbc2DtbmjKgnyylNaQCk63y1
	 iliek7hjG3VAJ8hIHTs1Vps1fU2Ja7p7ZMbVCd4BLsXdbw/mO3V3fgp+7sqgea04TZ
	 d43b97017YaVV50QaCFN9HCilPBN/v43Ut88ZX3NcvVrUf/xC/CrgWfSSpBGESLjCS
	 t4eZibpZ22osw==
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
Subject: [PATCH bpf-next 6/8] selftests/bpf: Add fill_link_info test for perf event
Date: Thu, 18 Jan 2024 10:54:14 +0100
Message-ID: <20240118095416.989152-7-jolsa@kernel.org>
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

Adding fill_link_info test for perf event and testing we
get its values back through the bpf_link_info interface.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/fill_link_info.c | 40 +++++++++++++++++++
 .../selftests/bpf/progs/test_fill_link_info.c |  6 +++
 2 files changed, 46 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
index 20e105001bc3..f3932941bbaa 100644
--- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
+++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
@@ -109,6 +109,11 @@ static int verify_perf_link_info(int fd, enum bpf_perf_event_type type, long add
 			      strlen(UPROBE_FILE));
 			ASSERT_EQ(err, 0, "cmp_file_name");
 		break;
+	case BPF_PERF_EVENT_EVENT:
+		ASSERT_EQ(info.perf_event.event.type, PERF_TYPE_SOFTWARE, "event_type");
+		ASSERT_EQ(info.perf_event.event.config, PERF_COUNT_SW_PAGE_FAULTS, "event_config");
+		ASSERT_EQ(info.perf_event.event.cookie, PERF_EVENT_COOKIE, "event_cookie");
+		break;
 	default:
 		err = -1;
 		break;
@@ -189,6 +194,39 @@ static void test_tp_fill_link_info(struct test_fill_link_info *skel)
 	bpf_link__destroy(link);
 }
 
+static void test_event_fill_link_info(struct test_fill_link_info *skel)
+{
+	DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, opts,
+		.bpf_cookie = PERF_EVENT_COOKIE,
+	);
+	struct bpf_link *link;
+	int link_fd, err, pfd;
+	struct perf_event_attr attr = {
+		.type = PERF_TYPE_SOFTWARE,
+		.config = PERF_COUNT_SW_PAGE_FAULTS,
+		.freq = 1,
+		.sample_freq = 1,
+		.size = sizeof(struct perf_event_attr),
+	};
+
+	pfd = syscall(__NR_perf_event_open, &attr, -1 /* pid */, 0 /* cpu 0 */,
+		      -1 /* group id */, 0 /* flags */);
+	if (!ASSERT_GE(pfd, 0, "perf_event_open"))
+		return;
+
+	link = bpf_program__attach_perf_event_opts(skel->progs.event_run, pfd, &opts);
+	if (!ASSERT_OK_PTR(link, "attach_event"))
+		goto error;
+
+	link_fd = bpf_link__fd(link);
+	err = verify_perf_link_info(link_fd, BPF_PERF_EVENT_EVENT, 0, 0, 0);
+	ASSERT_OK(err, "verify_perf_link_info");
+	bpf_link__destroy(link);
+
+error:
+	close(pfd);
+}
+
 static void test_uprobe_fill_link_info(struct test_fill_link_info *skel,
 				       enum bpf_perf_event_type type)
 {
@@ -549,6 +587,8 @@ void test_fill_link_info(void)
 		test_kprobe_fill_link_info(skel, BPF_PERF_EVENT_KPROBE, true);
 	if (test__start_subtest("tracepoint_link_info"))
 		test_tp_fill_link_info(skel);
+	if (test__start_subtest("event_link_info"))
+		test_event_fill_link_info(skel);
 
 	uprobe_offset = get_uprobe_offset(&uprobe_func);
 	if (test__start_subtest("uprobe_link_info"))
diff --git a/tools/testing/selftests/bpf/progs/test_fill_link_info.c b/tools/testing/selftests/bpf/progs/test_fill_link_info.c
index 69509f8bb680..6afa834756e9 100644
--- a/tools/testing/selftests/bpf/progs/test_fill_link_info.c
+++ b/tools/testing/selftests/bpf/progs/test_fill_link_info.c
@@ -33,6 +33,12 @@ int BPF_PROG(tp_run)
 	return 0;
 }
 
+SEC("perf_event")
+int event_run(void *ctx)
+{
+	return 0;
+}
+
 SEC("kprobe.multi")
 int BPF_PROG(kmulti_run)
 {
-- 
2.43.0



Return-Path: <bpf+bounces-13269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E6B7D757A
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 22:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35C151C20E93
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 20:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D8C33996;
	Wed, 25 Oct 2023 20:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HW3W0MiA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571EE3398B
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 20:25:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A61C433C8;
	Wed, 25 Oct 2023 20:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698265508;
	bh=d1xVG+KpucDtyaWtSPlpmGw9SfRaMtX90wnctNfV+Is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HW3W0MiA0wepPrEiTPcfDHTHXSlUVBDOUsHswwWWGeMYHPdVD64LgCNZBC+Ndpkeo
	 hVoWXQDMSDYk3JvzmX9jAUsGgYlnz1h27cmmgPvRkm+EioInmWcOomWO5MJ3j4bD0t
	 4GrTIpDMIO0/pNfJMf1qPE+sHfG/r1+UHEU9AevdVEUXN6wGMyIGZb/z2j8Vrgm03/
	 LtoxflnDNkh7FT9DSntXIJtEtq/HZUSES8vJGdXpQJVlo0D2QlhBOWd7fBnP9K/Wi4
	 4a8b33o9u9hTeMq2GUT+QLOGcoIVqkuetO1nOo3MikA/EiAg6i97DASwkf4KMVI4dT
	 69sjX9ecWv2TA==
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
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 4/6] selftests/bpf: Use bpf_link__destroy in fill_link_info tests
Date: Wed, 25 Oct 2023 22:24:18 +0200
Message-ID: <20231025202420.390702-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025202420.390702-1-jolsa@kernel.org>
References: <20231025202420.390702-1-jolsa@kernel.org>
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

Also we need to set the link NULL so the skeleton destroy
won't try to destroy them again.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/fill_link_info.c       | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
index 97142a4db374..0379872c445a 100644
--- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
+++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
@@ -22,6 +22,11 @@ static __u64 kmulti_addrs[KMULTI_CNT];
 #define KPROBE_FUNC "bpf_fentry_test1"
 static __u64 kprobe_addr;
 
+#define LINK_DESTROY(__link) ({		\
+	bpf_link__destroy(__link);	\
+	__link = NULL;			\
+})
+
 #define UPROBE_FILE "/proc/self/exe"
 static ssize_t uprobe_offset;
 /* uprobe attach point */
@@ -157,7 +162,7 @@ static void test_kprobe_fill_link_info(struct test_fill_link_info *skel,
 	} else {
 		kprobe_fill_invalid_user_buffer(link_fd);
 	}
-	bpf_link__detach(skel->links.kprobe_run);
+	LINK_DESTROY(skel->links.kprobe_run);
 }
 
 static void test_tp_fill_link_info(struct test_fill_link_info *skel)
@@ -171,7 +176,7 @@ static void test_tp_fill_link_info(struct test_fill_link_info *skel)
 	link_fd = bpf_link__fd(skel->links.tp_run);
 	err = verify_perf_link_info(link_fd, BPF_PERF_EVENT_TRACEPOINT, 0, 0, 0);
 	ASSERT_OK(err, "verify_perf_link_info");
-	bpf_link__detach(skel->links.tp_run);
+	LINK_DESTROY(skel->links.tp_run);
 }
 
 static void test_uprobe_fill_link_info(struct test_fill_link_info *skel,
@@ -189,7 +194,7 @@ static void test_uprobe_fill_link_info(struct test_fill_link_info *skel,
 	link_fd = bpf_link__fd(skel->links.uprobe_run);
 	err = verify_perf_link_info(link_fd, type, 0, uprobe_offset, 0);
 	ASSERT_OK(err, "verify_perf_link_info");
-	bpf_link__detach(skel->links.uprobe_run);
+	LINK_DESTROY(skel->links.uprobe_run);
 }
 
 static int verify_kmulti_link_info(int fd, bool retprobe)
@@ -295,7 +300,7 @@ static void test_kprobe_multi_fill_link_info(struct test_fill_link_info *skel,
 	} else {
 		verify_kmulti_invalid_user_buffer(link_fd);
 	}
-	bpf_link__detach(skel->links.kmulti_run);
+	LINK_DESTROY(skel->links.kmulti_run);
 }
 
 void test_fill_link_info(void)
-- 
2.41.0



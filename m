Return-Path: <bpf+bounces-12113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 178FC7C7B37
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 03:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB4B7282C87
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 01:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82A2A2A;
	Fri, 13 Oct 2023 01:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49634A29
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 01:35:50 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C9FDC0;
	Thu, 12 Oct 2023 18:35:44 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee365289eec415-eec04;
	Fri, 13 Oct 2023 09:35:40 +0800 (CST)
X-RM-TRANSID:2ee365289eec415-eec04
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.54.5.252])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee965289eeb0e4-051a9;
	Fri, 13 Oct 2023 09:35:40 +0800 (CST)
X-RM-TRANSID:2ee965289eeb0e4-051a9
From: zhujun2 <zhujun2@cmss.chinamobile.com>
To: shuah@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	andrii@kernel.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH] selftests: bpf: remove unused variables
Date: Thu, 12 Oct 2023 18:35:36 -0700
Message-Id: <20231013013536.2047-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

These variables are never referenced in the code, just remove them.

Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>
---
 tools/testing/selftests/bpf/prog_tests/atomic_bounds.c      | 1 -
 tools/testing/selftests/bpf/prog_tests/kfree_skb.c          | 2 --
 tools/testing/selftests/bpf/prog_tests/perf_branches.c      | 6 +-----
 .../testing/selftests/bpf/prog_tests/probe_read_user_str.c  | 4 ++--
 tools/testing/selftests/bpf/prog_tests/test_overhead.c      | 4 ++--
 tools/testing/selftests/bpf/prog_tests/xdp_synproxy.c       | 1 -
 6 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/atomic_bounds.c b/tools/testing/selftests/bpf/prog_tests/atomic_bounds.c
index 69bd7853e..4715cde38 100644
--- a/tools/testing/selftests/bpf/prog_tests/atomic_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/atomic_bounds.c
@@ -7,7 +7,6 @@
 void test_atomic_bounds(void)
 {
 	struct atomic_bounds *skel;
-	__u32 duration = 0;
 
 	skel = atomic_bounds__open_and_load();
 	if (CHECK(!skel, "skel_load", "couldn't load program\n"))
diff --git a/tools/testing/selftests/bpf/prog_tests/kfree_skb.c b/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
index c07991544..b0992a9ed 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
@@ -20,7 +20,6 @@ static void on_sample(void *ctx, int cpu, void *data, __u32 size)
 {
 	struct meta *meta = (struct meta *)data;
 	struct ipv6_packet *pkt_v6 = data + sizeof(*meta);
-	int duration = 0;
 
 	if (CHECK(size != 72 + sizeof(*meta), "check_size", "size %u != %zu\n",
 		  size, 72 + sizeof(*meta)))
@@ -65,7 +64,6 @@ void serial_test_kfree_skb(void)
 	struct perf_buffer *pb = NULL;
 	int err, prog_fd;
 	bool passed = false;
-	__u32 duration = 0;
 	const int zero = 0;
 	bool test_ok[2];
 
diff --git a/tools/testing/selftests/bpf/prog_tests/perf_branches.c b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
index bc24f8333..0942b9891 100644
--- a/tools/testing/selftests/bpf/prog_tests/perf_branches.c
+++ b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
@@ -13,7 +13,6 @@ static void check_good_sample(struct test_perf_branches *skel)
 	int required_size = skel->bss->required_size_out;
 	int written_stack = skel->bss->written_stack_out;
 	int pbe_size = sizeof(struct perf_branch_entry);
-	int duration = 0;
 
 	if (CHECK(!skel->bss->valid, "output not valid",
 		 "no valid sample from prog"))
@@ -43,7 +42,6 @@ static void check_bad_sample(struct test_perf_branches *skel)
 	int written_global = skel->bss->written_global_out;
 	int required_size = skel->bss->required_size_out;
 	int written_stack = skel->bss->written_stack_out;
-	int duration = 0;
 
 	if (CHECK(!skel->bss->valid, "output not valid",
 		 "no valid sample from prog"))
@@ -61,7 +59,7 @@ static void test_perf_branches_common(int perf_fd,
 				      void (*cb)(struct test_perf_branches *))
 {
 	struct test_perf_branches *skel;
-	int err, i, duration = 0;
+	int err, i;
 	bool detached = false;
 	struct bpf_link *link;
 	volatile int j = 0;
@@ -102,7 +100,6 @@ static void test_perf_branches_common(int perf_fd,
 static void test_perf_branches_hw(void)
 {
 	struct perf_event_attr attr = {0};
-	int duration = 0;
 	int pfd;
 
 	/* create perf event */
@@ -143,7 +140,6 @@ static void test_perf_branches_hw(void)
 static void test_perf_branches_no_hw(void)
 {
 	struct perf_event_attr attr = {0};
-	int duration = 0;
 	int pfd;
 
 	/* create perf event */
diff --git a/tools/testing/selftests/bpf/prog_tests/probe_read_user_str.c b/tools/testing/selftests/bpf/prog_tests/probe_read_user_str.c
index e41929813..a7c6ad8d6 100644
--- a/tools/testing/selftests/bpf/prog_tests/probe_read_user_str.c
+++ b/tools/testing/selftests/bpf/prog_tests/probe_read_user_str.c
@@ -9,7 +9,7 @@ static const char str3[] = "mestringblubblubblubblubblub";
 static int test_one_str(struct test_probe_read_user_str *skel, const char *str,
 			size_t len)
 {
-	int err, duration = 0;
+	int err;
 	char buf[256];
 
 	/* Ensure bytes after string are ones */
@@ -44,7 +44,7 @@ static int test_one_str(struct test_probe_read_user_str *skel, const char *str,
 void test_probe_read_user_str(void)
 {
 	struct test_probe_read_user_str *skel;
-	int err, duration = 0;
+	int err;
 
 	skel = test_probe_read_user_str__open_and_load();
 	if (CHECK(!skel, "test_probe_read_user_str__open_and_load",
diff --git a/tools/testing/selftests/bpf/prog_tests/test_overhead.c b/tools/testing/selftests/bpf/prog_tests/test_overhead.c
index f27013e38..6161009df 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_overhead.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_overhead.c
@@ -17,7 +17,7 @@ static __u64 time_get_ns(void)
 
 static int test_task_rename(const char *prog)
 {
-	int i, fd, duration = 0, err;
+	int i, fd, err;
 	char buf[] = "test_overhead";
 	__u64 start_time;
 
@@ -66,7 +66,7 @@ void test_test_overhead(void)
 	struct bpf_program *fentry_prog, *fexit_prog;
 	struct bpf_object *obj;
 	struct bpf_link *link;
-	int err, duration = 0;
+	int err;
 	char comm[16] = {};
 
 	if (CHECK_FAIL(prctl(PR_GET_NAME, comm, 0L, 0L, 0L)))
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_synproxy.c b/tools/testing/selftests/bpf/prog_tests/xdp_synproxy.c
index 8b50a992d..5af434353 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_synproxy.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_synproxy.c
@@ -40,7 +40,6 @@ static bool expect_str(char *buf, size_t size, const char *str, const char *name
 {
 	static char escbuf_expected[CMD_OUT_BUF_SIZE * 4];
 	static char escbuf_actual[CMD_OUT_BUF_SIZE * 4];
-	static int duration = 0;
 	bool ok;
 
 	ok = size == strlen(str) && !memcmp(buf, str, size);
-- 
2.17.1





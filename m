Return-Path: <bpf+bounces-5459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E526D75AD2A
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 13:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 226911C203AC
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 11:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D937B17FE3;
	Thu, 20 Jul 2023 11:39:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89359174E9
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 11:39:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E86AC433C8;
	Thu, 20 Jul 2023 11:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689853142;
	bh=TYvbI4J+iiAairt216XCxpjfpCxYWmTZ2NCuQBTKWbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dEiB0gWkMlXH0tKLVBk8dh8iO3mXPyRq5JEcUnvT94nt5YzLpdVtrqrB2UO5TrovP
	 qMBS7KOuSVmo7eqGLfbYdwJGExkWtpccGQs1g8LUN1E5zyEqo89EtSYmGWYl8CJeKx
	 pBPDTbdJx4qqzoJR6R8+lJJMsc7naYLJxc+FPsqvRPqvC0l43vEzrZyn7b4StnAODH
	 4Gc3L7opYZLAYJns/cLeMcAIOAj/P4M8ffQMzlhhglGXmESMOJ3/wzqo42sJqgIH8h
	 Dxtr7O65EHbUdlzphG9pF7xXgwN4pK4oaZpFhUYee2iPy1CScV0iHtgLIhWuPTdHvc
	 2LhRsK3li8SSw==
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
Subject: [PATCHv4 bpf-next 18/28] selftests/bpf: Move get_time_ns to testing_helpers.h
Date: Thu, 20 Jul 2023 13:35:40 +0200
Message-ID: <20230720113550.369257-19-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230720113550.369257-1-jolsa@kernel.org>
References: <20230720113550.369257-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We'd like to have single copy of get_time_ns used b bench and test_progs,
but we can't just include bench.h, because of conflicting 'struct env'
objects.

Moving get_time_ns to testing_helpers.h which is being included by both
bench and test_progs objects.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/bench.h                    |  9 ---------
 .../selftests/bpf/prog_tests/kprobe_multi_test.c       |  8 --------
 tools/testing/selftests/bpf/testing_helpers.h          | 10 ++++++++++
 3 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/bench.h b/tools/testing/selftests/bpf/bench.h
index 7ff32be3d730..68180d8f8558 100644
--- a/tools/testing/selftests/bpf/bench.h
+++ b/tools/testing/selftests/bpf/bench.h
@@ -81,15 +81,6 @@ void grace_period_latency_basic_stats(struct bench_res res[], int res_cnt,
 void grace_period_ticks_basic_stats(struct bench_res res[], int res_cnt,
 				    struct basic_stats *gp_stat);
 
-static inline __u64 get_time_ns(void)
-{
-	struct timespec t;
-
-	clock_gettime(CLOCK_MONOTONIC, &t);
-
-	return (u64)t.tv_sec * 1000000000 + t.tv_nsec;
-}
-
 static inline void atomic_inc(long *value)
 {
 	(void)__atomic_add_fetch(value, 1, __ATOMIC_RELAXED);
diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 2173c4bb555e..179fe300534f 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -304,14 +304,6 @@ static void test_attach_api_fails(void)
 	kprobe_multi__destroy(skel);
 }
 
-static inline __u64 get_time_ns(void)
-{
-	struct timespec t;
-
-	clock_gettime(CLOCK_MONOTONIC, &t);
-	return (__u64) t.tv_sec * 1000000000 + t.tv_nsec;
-}
-
 static size_t symbol_hash(long key, void *ctx __maybe_unused)
 {
 	return str_hash((const char *) key);
diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
index 5312323881b6..5b7a55136741 100644
--- a/tools/testing/selftests/bpf/testing_helpers.h
+++ b/tools/testing/selftests/bpf/testing_helpers.h
@@ -7,6 +7,7 @@
 #include <stdbool.h>
 #include <bpf/bpf.h>
 #include <bpf/libbpf.h>
+#include <time.h>
 
 int parse_num_list(const char *s, bool **set, int *set_len);
 __u32 link_info_prog_id(const struct bpf_link *link, struct bpf_link_info *info);
@@ -33,4 +34,13 @@ int load_bpf_testmod(bool verbose);
 int unload_bpf_testmod(bool verbose);
 int kern_sync_rcu(void);
 
+static inline __u64 get_time_ns(void)
+{
+	struct timespec t;
+
+	clock_gettime(CLOCK_MONOTONIC, &t);
+
+	return (u64)t.tv_sec * 1000000000 + t.tv_nsec;
+}
+
 #endif /* __TESTING_HELPERS_H */
-- 
2.41.0



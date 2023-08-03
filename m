Return-Path: <bpf+bounces-6813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 662B676E1D5
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 09:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 887DD1C214CB
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 07:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EFD134DC;
	Thu,  3 Aug 2023 07:37:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F050D9454
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 07:37:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEEDEC433C8;
	Thu,  3 Aug 2023 07:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691048248;
	bh=TYvbI4J+iiAairt216XCxpjfpCxYWmTZ2NCuQBTKWbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cboj1Q4jL2qu/SasFJhb+PgMtDZqwhisLnWEp+CpAxqJ6DKNA6L4gTjsqnQQbq38k
	 kNO+x70KP9kjnEqexewsCM+6yGCOH8ajsjZofi8RDhvBGLo1pKDg/UwGMYoJYmhjPl
	 tmyJnUkMV8h8LPwWts+tjCTVuBZZzeUPIVqdYeRoN0n5CDzlG5jPloEsm1DXOe/wPR
	 fMxY7WkMG46QFz7MOM3O7s924wlQhWgj/eMOkI9sTMY4LMoWuFlnt5PdOtVNtv439z
	 QIsUu40bLOGOtyrHxTZ8ZxAbPcweBH40Y047e3ddWQi4y73DprWEynQyGHKRgdw9jJ
	 GAICjDcZHF/hg==
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
Subject: [PATCHv6 bpf-next 18/28] selftests/bpf: Move get_time_ns to testing_helpers.h
Date: Thu,  3 Aug 2023 09:34:10 +0200
Message-ID: <20230803073420.1558613-19-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803073420.1558613-1-jolsa@kernel.org>
References: <20230803073420.1558613-1-jolsa@kernel.org>
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



Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365E36E0071
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 23:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjDLVFa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 12 Apr 2023 17:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjDLVF3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 17:05:29 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61FD55A3
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 14:05:18 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CI97eT010083
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 14:04:40 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pwqspvujq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 14:04:40 -0700
Received: from twshared16996.15.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 12 Apr 2023 14:04:39 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 233641B0AF03F; Wed, 12 Apr 2023 14:04:30 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kernel-team@meta.com>, Song Liu <song@kernel.org>
Subject: [PATCH bpf-next 1/3] selftests/bpf: Use read_perf_max_sample_freq() in perf_event_stackmap
Date:   Wed, 12 Apr 2023 14:04:21 -0700
Message-ID: <20230412210423.900851-2-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230412210423.900851-1-song@kernel.org>
References: <20230412210423.900851-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: w3mPPnn1mHBVKo5UgTNuxqwlxLuZyyI7
X-Proofpoint-GUID: w3mPPnn1mHBVKo5UgTNuxqwlxLuZyyI7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_11,2023-04-12_01,2023-02-09_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, perf_event sample period in perf_event_stackmap is set too low
that the test fails randomly. Fix this by using the max sample frequency,
from read_perf_max_sample_freq().

Move read_perf_max_sample_freq() to testing_helpers.c. Replace the CHECK()
with if-printf, as CHECK is not available in testing_helpers.c.

Fixes: 1da4864c2b20 ("selftests/bpf: Add callchain_stackid")
Signed-off-by: Song Liu <song@kernel.org>
---
 .../bpf/prog_tests/perf_event_stackmap.c      |  3 ++-
 .../bpf/prog_tests/stacktrace_build_id_nmi.c  | 15 --------------
 tools/testing/selftests/bpf/testing_helpers.c | 20 +++++++++++++++++++
 tools/testing/selftests/bpf/testing_helpers.h |  2 ++
 4 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/perf_event_stackmap.c b/tools/testing/selftests/bpf/prog_tests/perf_event_stackmap.c
index 33144c9432ae..f4aad35afae1 100644
--- a/tools/testing/selftests/bpf/prog_tests/perf_event_stackmap.c
+++ b/tools/testing/selftests/bpf/prog_tests/perf_event_stackmap.c
@@ -63,7 +63,8 @@ void test_perf_event_stackmap(void)
 			PERF_SAMPLE_BRANCH_NO_FLAGS |
 			PERF_SAMPLE_BRANCH_NO_CYCLES |
 			PERF_SAMPLE_BRANCH_CALL_STACK,
-		.sample_period = 5000,
+		.freq = 1,
+		.sample_freq = read_perf_max_sample_freq(),
 		.size = sizeof(struct perf_event_attr),
 	};
 	struct perf_event_stackmap *skel;
diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
index 47558b0d7f66..5db9eec24b5b 100644
--- a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
@@ -2,21 +2,6 @@
 #include <test_progs.h>
 #include "test_stacktrace_build_id.skel.h"
 
-static __u64 read_perf_max_sample_freq(void)
-{
-	__u64 sample_freq = 5000; /* fallback to 5000 on error */
-	FILE *f;
-	__u32 duration = 0;
-
-	f = fopen("/proc/sys/kernel/perf_event_max_sample_rate", "r");
-	if (f == NULL)
-		return sample_freq;
-	CHECK(fscanf(f, "%llu", &sample_freq) != 1, "Get max sample rate",
-		  "return default value: 5000,err %d\n", -errno);
-	fclose(f);
-	return sample_freq;
-}
-
 void test_stacktrace_build_id_nmi(void)
 {
 	int control_map_fd, stackid_hmap_fd, stackmap_fd;
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index ecfea13f938b..0b5e0829e5be 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -229,3 +229,23 @@ int bpf_test_load_program(enum bpf_prog_type type, const struct bpf_insn *insns,
 
 	return bpf_prog_load(type, NULL, license, insns, insns_cnt, &opts);
 }
+
+__u64 read_perf_max_sample_freq(void)
+{
+	__u64 sample_freq = 5000; /* fallback to 5000 on error */
+	FILE *f;
+
+	f = fopen("/proc/sys/kernel/perf_event_max_sample_rate", "r");
+	if (f == NULL) {
+		printf("Failed to open /proc/sys/kernel/perf_event_max_sample_rate: err %d\n"
+		       "return default value: 5000\n", -errno);
+		return sample_freq;
+	}
+	if (fscanf(f, "%llu", &sample_freq) != 1) {
+		printf("Failed to parse /proc/sys/kernel/perf_event_max_sample_rate: err %d\n"
+		       "return default value: 5000\n", -errno);
+	}
+
+	fclose(f);
+	return sample_freq;
+}
diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
index 6ec00bf79cb5..eb8790f928e4 100644
--- a/tools/testing/selftests/bpf/testing_helpers.h
+++ b/tools/testing/selftests/bpf/testing_helpers.h
@@ -20,3 +20,5 @@ struct test_filter_set;
 int parse_test_list(const char *s,
 		    struct test_filter_set *test_set,
 		    bool is_glob_pattern);
+
+__u64 read_perf_max_sample_freq(void);
-- 
2.34.1


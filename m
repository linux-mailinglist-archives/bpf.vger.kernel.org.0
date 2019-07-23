Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 441757219D
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2019 23:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392146AbfGWVfC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Jul 2019 17:35:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41032 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389412AbfGWVfC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Jul 2019 17:35:02 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6NLQIiU003980
        for <bpf@vger.kernel.org>; Tue, 23 Jul 2019 14:35:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=1BuOTSdC8YtfHG3RLLooJReYLL0Zd45X9cY9c8gS9JI=;
 b=dVuY1ettdwkhwsQC0RKPNQEjuNFkey+YAIMKrmx3TFK63hg10oiAcWhr5BUDYCWJg6FI
 pdwylGXBgrlOHexG3XzqYUSi06SPzfth4WtU9ZByCzh3UixwBA9Kdtr+vjgpBp+3xsoM
 DS5OgY0EdwPvrkKmtqWVOPD7pLie+y/b9Gk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2tx61p13en-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 23 Jul 2019 14:35:01 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 23 Jul 2019 14:35:00 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 337D28615A2; Tue, 23 Jul 2019 14:34:58 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>, <songliubraving@fb.com>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 bpf-next 1/5] selftests/bpf: convert test_get_stack_raw_tp to perf_buffer API
Date:   Tue, 23 Jul 2019 14:34:41 -0700
Message-ID: <20190723213445.1732339-2-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190723213445.1732339-1-andriin@fb.com>
References: <20190723213445.1732339-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-23_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=25 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907230216
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Convert test_get_stack_raw_tp test to new perf_buffer API.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 .../bpf/prog_tests/get_stack_raw_tp.c         | 78 ++++++++++---------
 .../bpf/progs/test_get_stack_rawtp.c          |  2 +-
 2 files changed, 44 insertions(+), 36 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c b/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c
index c2a0a9d5591b..9d73a8f932ac 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c
@@ -1,8 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <pthread.h>
+#include <sched.h>
+#include <sys/socket.h>
 #include <test_progs.h>
 
 #define MAX_CNT_RAWTP	10ull
 #define MAX_STACK_RAWTP	100
+
+static int duration = 0;
+
 struct get_stack_trace_t {
 	int pid;
 	int kern_stack_size;
@@ -13,7 +20,7 @@ struct get_stack_trace_t {
 	struct bpf_stack_build_id user_stack_buildid[MAX_STACK_RAWTP];
 };
 
-static int get_stack_print_output(void *data, int size)
+static void get_stack_print_output(void *ctx, int cpu, void *data, __u32 size)
 {
 	bool good_kern_stack = false, good_user_stack = false;
 	const char *nonjit_func = "___bpf_prog_run";
@@ -65,75 +72,76 @@ static int get_stack_print_output(void *data, int size)
 		if (e->user_stack_size > 0 && e->user_stack_buildid_size > 0)
 			good_user_stack = true;
 	}
-	if (!good_kern_stack || !good_user_stack)
-		return LIBBPF_PERF_EVENT_ERROR;
 
-	if (cnt == MAX_CNT_RAWTP)
-		return LIBBPF_PERF_EVENT_DONE;
-
-	return LIBBPF_PERF_EVENT_CONT;
+	if (!good_kern_stack)
+	    CHECK(!good_kern_stack, "kern_stack", "corrupted kernel stack\n");
+	if (!good_user_stack)
+	    CHECK(!good_user_stack, "user_stack", "corrupted user stack\n");
 }
 
 void test_get_stack_raw_tp(void)
 {
 	const char *file = "./test_get_stack_rawtp.o";
-	int i, efd, err, prog_fd, pmu_fd, perfmap_fd;
-	struct perf_event_attr attr = {};
+	const char *prog_name = "raw_tracepoint/sys_enter";
+	int i, err, prog_fd, exp_cnt = MAX_CNT_RAWTP;
+	struct perf_buffer_opts pb_opts = {};
+	struct perf_buffer *pb = NULL;
+	struct bpf_link *link = NULL;
 	struct timespec tv = {0, 10};
-	__u32 key = 0, duration = 0;
+	struct bpf_program *prog;
 	struct bpf_object *obj;
+	struct bpf_map *map;
+	cpu_set_t cpu_set;
 
 	err = bpf_prog_load(file, BPF_PROG_TYPE_RAW_TRACEPOINT, &obj, &prog_fd);
 	if (CHECK(err, "prog_load raw tp", "err %d errno %d\n", err, errno))
 		return;
 
-	efd = bpf_raw_tracepoint_open("sys_enter", prog_fd);
-	if (CHECK(efd < 0, "raw_tp_open", "err %d errno %d\n", efd, errno))
+	prog = bpf_object__find_program_by_title(obj, prog_name);
+	if (CHECK(!prog, "find_probe", "prog '%s' not found\n", prog_name))
 		goto close_prog;
 
-	perfmap_fd = bpf_find_map(__func__, obj, "perfmap");
-	if (CHECK(perfmap_fd < 0, "bpf_find_map", "err %d errno %d\n",
-		  perfmap_fd, errno))
+	map = bpf_object__find_map_by_name(obj, "perfmap");
+	if (CHECK(!map, "bpf_find_map", "not found\n"))
 		goto close_prog;
 
 	err = load_kallsyms();
 	if (CHECK(err < 0, "load_kallsyms", "err %d errno %d\n", err, errno))
 		goto close_prog;
 
-	attr.sample_type = PERF_SAMPLE_RAW;
-	attr.type = PERF_TYPE_SOFTWARE;
-	attr.config = PERF_COUNT_SW_BPF_OUTPUT;
-	pmu_fd = syscall(__NR_perf_event_open, &attr, getpid()/*pid*/, -1/*cpu*/,
-			 -1/*group_fd*/, 0);
-	if (CHECK(pmu_fd < 0, "perf_event_open", "err %d errno %d\n", pmu_fd,
-		  errno))
+	CPU_ZERO(&cpu_set);
+	CPU_SET(0, &cpu_set);
+	err = pthread_setaffinity_np(pthread_self(), sizeof(cpu_set), &cpu_set);
+	if (CHECK(err, "set_affinity", "err %d, errno %d\n", err, errno))
 		goto close_prog;
 
-	err = bpf_map_update_elem(perfmap_fd, &key, &pmu_fd, BPF_ANY);
-	if (CHECK(err < 0, "bpf_map_update_elem", "err %d errno %d\n", err,
-		  errno))
+	link = bpf_program__attach_raw_tracepoint(prog, "sys_enter");
+	if (CHECK(IS_ERR(link), "attach_raw_tp", "err %ld\n", PTR_ERR(link)))
 		goto close_prog;
 
-	err = ioctl(pmu_fd, PERF_EVENT_IOC_ENABLE, 0);
-	if (CHECK(err < 0, "ioctl PERF_EVENT_IOC_ENABLE", "err %d errno %d\n",
-		  err, errno))
-		goto close_prog;
-
-	err = perf_event_mmap(pmu_fd);
-	if (CHECK(err < 0, "perf_event_mmap", "err %d errno %d\n", err, errno))
+	pb_opts.sample_cb = get_stack_print_output;
+	pb = perf_buffer__new(bpf_map__fd(map), 8, &pb_opts);
+	if (CHECK(IS_ERR(pb), "perf_buf__new", "err %ld\n", PTR_ERR(pb)))
 		goto close_prog;
 
 	/* trigger some syscall action */
 	for (i = 0; i < MAX_CNT_RAWTP; i++)
 		nanosleep(&tv, NULL);
 
-	err = perf_event_poller(pmu_fd, get_stack_print_output);
-	if (CHECK(err < 0, "perf_event_poller", "err %d errno %d\n", err, errno))
-		goto close_prog;
+	while (exp_cnt > 0) {
+		err = perf_buffer__poll(pb, 100);
+		if (err < 0 && CHECK(err < 0, "pb__poll", "err %d\n", err))
+			goto close_prog;
+		exp_cnt -= err;
+	}
 
 	goto close_prog_noerr;
 close_prog:
 	error_cnt++;
 close_prog_noerr:
+	if (!IS_ERR_OR_NULL(link))
+		bpf_link__destroy(link);
+	if (!IS_ERR_OR_NULL(pb))
+		perf_buffer__free(pb);
 	bpf_object__close(obj);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_get_stack_rawtp.c b/tools/testing/selftests/bpf/progs/test_get_stack_rawtp.c
index 33254b771384..f8ffa3f3d44b 100644
--- a/tools/testing/selftests/bpf/progs/test_get_stack_rawtp.c
+++ b/tools/testing/selftests/bpf/progs/test_get_stack_rawtp.c
@@ -55,7 +55,7 @@ struct {
 	__type(value, raw_stack_trace_t);
 } rawdata_map SEC(".maps");
 
-SEC("tracepoint/raw_syscalls/sys_enter")
+SEC("raw_tracepoint/sys_enter")
 int bpf_prog1(void *ctx)
 {
 	int max_len, max_buildid_len, usize, ksize, total_size;
-- 
2.17.1


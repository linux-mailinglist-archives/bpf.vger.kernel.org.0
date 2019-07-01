Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70A5C5C61E
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2019 01:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfGAX72 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Jul 2019 19:59:28 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:28838 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727035AbfGAX72 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 1 Jul 2019 19:59:28 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x61NxGTJ004753
        for <bpf@vger.kernel.org>; Mon, 1 Jul 2019 16:59:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=u/HuWife6f9JIEaDnkOMoVeauTs6Sjl4LW+ZfFuG6Rw=;
 b=nYwmTWbxGe48rV/p6/eugTIJgHKuXInDZ5LOHICaRx6q+KjLFkQGYJWXaRQ02mQzjBXg
 aV6Y0kovWttPDSKIIXTycabZHWUSK2+FjvHBiqGIDU65LorNwyHHtwDgw+ho2bblJfm4
 w7HyKxRm8jc7sXi+H4T0TjDpJ785SX1jgIk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2tfqa0s2d0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2019 16:59:26 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 1 Jul 2019 16:59:25 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 23C2B86149D; Mon,  1 Jul 2019 16:59:23 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>, <ast@fb.com>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>, <yhs@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v5 bpf-next 9/9] selftests/bpf: convert existing tracepoint tests to new APIs
Date:   Mon, 1 Jul 2019 16:59:03 -0700
Message-ID: <20190701235903.660141-10-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190701235903.660141-1-andriin@fb.com>
References: <20190701235903.660141-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-01_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907010280
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Convert some existing tests that attach to tracepoints to use
bpf_program__attach_tracepoint API instead.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Reviewed-by: Stanislav Fomichev <sdf@google.com>
Acked-by: Song Liu <songliubraving@fb.com>
---
 .../bpf/prog_tests/stacktrace_build_id.c      | 55 ++++---------------
 .../selftests/bpf/prog_tests/stacktrace_map.c | 43 +++------------
 .../bpf/prog_tests/stacktrace_map_raw_tp.c    | 15 ++++-
 3 files changed, 32 insertions(+), 81 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id.c
index 3aab2b083c71..ac44fda84833 100644
--- a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id.c
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id.c
@@ -4,11 +4,13 @@
 void test_stacktrace_build_id(void)
 {
 	int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd;
+	const char *prog_name = "tracepoint/random/urandom_read";
 	const char *file = "./test_stacktrace_build_id.o";
-	int bytes, efd, err, pmu_fd, prog_fd, stack_trace_len;
-	struct perf_event_attr attr = {};
+	int err, prog_fd, stack_trace_len;
 	__u32 key, previous_key, val, duration = 0;
+	struct bpf_program *prog;
 	struct bpf_object *obj;
+	struct bpf_link *link = NULL;
 	char buf[256];
 	int i, j;
 	struct bpf_stack_build_id id_offs[PERF_MAX_STACK_DEPTH];
@@ -18,44 +20,16 @@ void test_stacktrace_build_id(void)
 retry:
 	err = bpf_prog_load(file, BPF_PROG_TYPE_TRACEPOINT, &obj, &prog_fd);
 	if (CHECK(err, "prog_load", "err %d errno %d\n", err, errno))
-		goto out;
+		return;
 
-	/* Get the ID for the sched/sched_switch tracepoint */
-	snprintf(buf, sizeof(buf),
-		 "/sys/kernel/debug/tracing/events/random/urandom_read/id");
-	efd = open(buf, O_RDONLY, 0);
-	if (CHECK(efd < 0, "open", "err %d errno %d\n", efd, errno))
+	prog = bpf_object__find_program_by_title(obj, prog_name);
+	if (CHECK(!prog, "find_prog", "prog '%s' not found\n", prog_name))
 		goto close_prog;
 
-	bytes = read(efd, buf, sizeof(buf));
-	close(efd);
-	if (CHECK(bytes <= 0 || bytes >= sizeof(buf),
-		  "read", "bytes %d errno %d\n", bytes, errno))
+	link = bpf_program__attach_tracepoint(prog, "random", "urandom_read");
+	if (CHECK(IS_ERR(link), "attach_tp", "err %ld\n", PTR_ERR(link)))
 		goto close_prog;
 
-	/* Open the perf event and attach bpf progrram */
-	attr.config = strtol(buf, NULL, 0);
-	attr.type = PERF_TYPE_TRACEPOINT;
-	attr.sample_type = PERF_SAMPLE_RAW | PERF_SAMPLE_CALLCHAIN;
-	attr.sample_period = 1;
-	attr.wakeup_events = 1;
-	pmu_fd = syscall(__NR_perf_event_open, &attr, -1 /* pid */,
-			 0 /* cpu 0 */, -1 /* group id */,
-			 0 /* flags */);
-	if (CHECK(pmu_fd < 0, "perf_event_open", "err %d errno %d\n",
-		  pmu_fd, errno))
-		goto close_prog;
-
-	err = ioctl(pmu_fd, PERF_EVENT_IOC_ENABLE, 0);
-	if (CHECK(err, "perf_event_ioc_enable", "err %d errno %d\n",
-		  err, errno))
-		goto close_pmu;
-
-	err = ioctl(pmu_fd, PERF_EVENT_IOC_SET_BPF, prog_fd);
-	if (CHECK(err, "perf_event_ioc_set_bpf", "err %d errno %d\n",
-		  err, errno))
-		goto disable_pmu;
-
 	/* find map fds */
 	control_map_fd = bpf_find_map(__func__, obj, "control_map");
 	if (CHECK(control_map_fd < 0, "bpf_find_map control_map",
@@ -133,8 +107,7 @@ void test_stacktrace_build_id(void)
 	 * try it one more time.
 	 */
 	if (build_id_matches < 1 && retry--) {
-		ioctl(pmu_fd, PERF_EVENT_IOC_DISABLE);
-		close(pmu_fd);
+		bpf_link__destroy(link);
 		bpf_object__close(obj);
 		printf("%s:WARN:Didn't find expected build ID from the map, retrying\n",
 		       __func__);
@@ -152,14 +125,8 @@ void test_stacktrace_build_id(void)
 	      "err %d errno %d\n", err, errno);
 
 disable_pmu:
-	ioctl(pmu_fd, PERF_EVENT_IOC_DISABLE);
-
-close_pmu:
-	close(pmu_fd);
+	bpf_link__destroy(link);
 
 close_prog:
 	bpf_object__close(obj);
-
-out:
-	return;
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
index 2bfd50a0d6d1..fc539335c5b3 100644
--- a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
@@ -4,50 +4,26 @@
 void test_stacktrace_map(void)
 {
 	int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd;
+	const char *prog_name = "tracepoint/sched/sched_switch";
+	int err, prog_fd, stack_trace_len;
 	const char *file = "./test_stacktrace_map.o";
-	int bytes, efd, err, pmu_fd, prog_fd, stack_trace_len;
-	struct perf_event_attr attr = {};
 	__u32 key, val, duration = 0;
+	struct bpf_program *prog;
 	struct bpf_object *obj;
-	char buf[256];
+	struct bpf_link *link;
 
 	err = bpf_prog_load(file, BPF_PROG_TYPE_TRACEPOINT, &obj, &prog_fd);
 	if (CHECK(err, "prog_load", "err %d errno %d\n", err, errno))
 		return;
 
-	/* Get the ID for the sched/sched_switch tracepoint */
-	snprintf(buf, sizeof(buf),
-		 "/sys/kernel/debug/tracing/events/sched/sched_switch/id");
-	efd = open(buf, O_RDONLY, 0);
-	if (CHECK(efd < 0, "open", "err %d errno %d\n", efd, errno))
+	prog = bpf_object__find_program_by_title(obj, prog_name);
+	if (CHECK(!prog, "find_prog", "prog '%s' not found\n", prog_name))
 		goto close_prog;
 
-	bytes = read(efd, buf, sizeof(buf));
-	close(efd);
-	if (bytes <= 0 || bytes >= sizeof(buf))
+	link = bpf_program__attach_tracepoint(prog, "sched", "sched_switch");
+	if (CHECK(IS_ERR(link), "attach_tp", "err %ld\n", PTR_ERR(link)))
 		goto close_prog;
 
-	/* Open the perf event and attach bpf progrram */
-	attr.config = strtol(buf, NULL, 0);
-	attr.type = PERF_TYPE_TRACEPOINT;
-	attr.sample_type = PERF_SAMPLE_RAW | PERF_SAMPLE_CALLCHAIN;
-	attr.sample_period = 1;
-	attr.wakeup_events = 1;
-	pmu_fd = syscall(__NR_perf_event_open, &attr, -1 /* pid */,
-			 0 /* cpu 0 */, -1 /* group id */,
-			 0 /* flags */);
-	if (CHECK(pmu_fd < 0, "perf_event_open", "err %d errno %d\n",
-		  pmu_fd, errno))
-		goto close_prog;
-
-	err = ioctl(pmu_fd, PERF_EVENT_IOC_ENABLE, 0);
-	if (err)
-		goto disable_pmu;
-
-	err = ioctl(pmu_fd, PERF_EVENT_IOC_SET_BPF, prog_fd);
-	if (err)
-		goto disable_pmu;
-
 	/* find map fds */
 	control_map_fd = bpf_find_map(__func__, obj, "control_map");
 	if (control_map_fd < 0)
@@ -96,8 +72,7 @@ void test_stacktrace_map(void)
 disable_pmu:
 	error_cnt++;
 disable_pmu_noerr:
-	ioctl(pmu_fd, PERF_EVENT_IOC_DISABLE);
-	close(pmu_fd);
+	bpf_link__destroy(link);
 close_prog:
 	bpf_object__close(obj);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_map_raw_tp.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_map_raw_tp.c
index 1f8387d80fd7..fbfa8e76cf63 100644
--- a/tools/testing/selftests/bpf/prog_tests/stacktrace_map_raw_tp.c
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_map_raw_tp.c
@@ -3,18 +3,25 @@
 
 void test_stacktrace_map_raw_tp(void)
 {
+	const char *prog_name = "tracepoint/sched/sched_switch";
 	int control_map_fd, stackid_hmap_fd, stackmap_fd;
 	const char *file = "./test_stacktrace_map.o";
-	int efd, err, prog_fd;
 	__u32 key, val, duration = 0;
+	int err, prog_fd;
+	struct bpf_program *prog;
 	struct bpf_object *obj;
+	struct bpf_link *link = NULL;
 
 	err = bpf_prog_load(file, BPF_PROG_TYPE_RAW_TRACEPOINT, &obj, &prog_fd);
 	if (CHECK(err, "prog_load raw tp", "err %d errno %d\n", err, errno))
 		return;
 
-	efd = bpf_raw_tracepoint_open("sched_switch", prog_fd);
-	if (CHECK(efd < 0, "raw_tp_open", "err %d errno %d\n", efd, errno))
+	prog = bpf_object__find_program_by_title(obj, prog_name);
+	if (CHECK(!prog, "find_prog", "prog '%s' not found\n", prog_name))
+		goto close_prog;
+
+	link = bpf_program__attach_raw_tracepoint(prog, "sched_switch");
+	if (CHECK(IS_ERR(link), "attach_raw_tp", "err %ld\n", PTR_ERR(link)))
 		goto close_prog;
 
 	/* find map fds */
@@ -55,5 +62,7 @@ void test_stacktrace_map_raw_tp(void)
 close_prog:
 	error_cnt++;
 close_prog_noerr:
+	if (!IS_ERR_OR_NULL(link))
+		bpf_link__destroy(link);
 	bpf_object__close(obj);
 }
-- 
2.17.1


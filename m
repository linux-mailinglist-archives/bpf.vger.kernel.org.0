Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE2E13B412
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2020 22:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgANVLt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jan 2020 16:11:49 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:32112 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727285AbgANVLs (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Jan 2020 16:11:48 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00EL2E3n004358
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2020 13:11:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=+2KnbqcX17RhFIoVnB6HDEgWaRnSN/g51k126eSoYNw=;
 b=iRJQaTwLgJDU/txpCEuhKzwUzFPkbmIH9Dkiq+XtaGhPgEp3wSdESBr4KxcmNe2e4TRF
 coJAwohMAh3ZlEsSJcsLgT9j4J/soK9pTSOls5a4+2vv1zgSPqeDvIJtaQUCtjY4R4ue
 tyGYYH7i7CSP8oVnjBE5KyzX1FScHp2Rqk8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2xgw2epya9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2020 13:11:47 -0800
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 14 Jan 2020 13:11:46 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 6DA97370257F; Tue, 14 Jan 2020 13:11:45 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v2 2/2] tools/bpf: add self tests for bpf_send_signal_thread()
Date:   Tue, 14 Jan 2020 13:11:45 -0800
Message-ID: <20200114211145.3201733-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200114211143.3201505-1-yhs@fb.com>
References: <20200114211143.3201505-1-yhs@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-14_06:2020-01-14,2020-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 adultscore=0 suspectscore=13 mlxscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001140161
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The test_progs send_signal() is amended to test
bpf_send_signal_thread() as well.

   $ ./test_progs -n 40
   #40/1 send_signal_tracepoint:OK
   #40/2 send_signal_perf:OK
   #40/3 send_signal_nmi:OK
   #40/4 send_signal_tracepoint_thread:OK
   #40/5 send_signal_perf_thread:OK
   #40/6 send_signal_nmi_thread:OK
   #40 send_signal:OK
   Summary: 1/6 PASSED, 0 SKIPPED, 0 FAILED

Also took this opportunity to rewrite the send_signal test
using skeleton framework and array mmap to make code
simpler and more readable.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/send_signal.c    | 111 ++++++++++--------
 .../bpf/progs/test_send_signal_kern.c         |  51 ++++----
 2 files changed, 87 insertions(+), 75 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
index b607112c64e7..14ec9cf218ed 100644
--- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include <sys/mman.h>
+#include "test_send_signal_kern.skel.h"
 
 static volatile int sigusr1_received = 0;
 
@@ -8,18 +10,26 @@ static void sigusr1_handler(int signum)
 	sigusr1_received++;
 }
 
+static size_t roundup_page(size_t sz)
+{
+	long page_size = sysconf(_SC_PAGE_SIZE);
+	return (sz + page_size - 1) / page_size * page_size;
+}
+
 static void test_send_signal_common(struct perf_event_attr *attr,
-				    int prog_type,
+				    bool is_tp, bool signal_thread,
 				    const char *test_name)
 {
-	int err = -1, pmu_fd, prog_fd, info_map_fd, status_map_fd;
-	const char *file = "./test_send_signal_kern.o";
-	struct bpf_object *obj = NULL;
+	const size_t bss_sz = roundup_page(sizeof(struct test_send_signal_kern__bss));
+	struct test_send_signal_kern__bss *bss_data;
+	struct test_send_signal_kern *skel;
 	int pipe_c2p[2], pipe_p2c[2];
-	__u32 key = 0, duration = 0;
+	struct bpf_map *bss_map;
+	void *bss_mmaped = NULL;
+	int err = -1, pmu_fd;
+	__u32 duration = 0;
 	char buf[256];
 	pid_t pid;
-	__u64 val;
 
 	if (CHECK(pipe(pipe_c2p), test_name,
 		  "pipe pipe_c2p error: %s\n", strerror(errno)))
@@ -73,45 +83,50 @@ static void test_send_signal_common(struct perf_event_attr *attr,
 	close(pipe_c2p[1]); /* close write */
 	close(pipe_p2c[0]); /* close read */
 
-	err = bpf_prog_load(file, prog_type, &obj, &prog_fd);
-	if (CHECK(err < 0, test_name, "bpf_prog_load error: %s\n",
-		  strerror(errno)))
-		goto prog_load_failure;
+	skel = test_send_signal_kern__open_and_load();
+	if (CHECK(!skel, "skel_open_and_load", "skeleton open_and_load failed\n"))
+		goto skel_open_load_failure;
+
+	bss_map = skel->maps.bss;
+	bss_mmaped = mmap(NULL, bss_sz, PROT_READ | PROT_WRITE, MAP_SHARED,
+			  bpf_map__fd(bss_map), 0);
+	if (CHECK(bss_mmaped == MAP_FAILED, "bss_mmap",
+		  ".bss mmap failed: %d\n", errno)) {
+		bss_mmaped = NULL;
+		goto destroy_skel;
+	}
+
+	bss_data = bss_mmaped;
 
 	pmu_fd = syscall(__NR_perf_event_open, attr, pid, -1,
 			 -1 /* group id */, 0 /* flags */);
 	if (CHECK(pmu_fd < 0, test_name, "perf_event_open error: %s\n",
 		  strerror(errno))) {
 		err = -1;
-		goto close_prog;
+		goto destroy_skel;
 	}
 
-	err = ioctl(pmu_fd, PERF_EVENT_IOC_ENABLE, 0);
-	if (CHECK(err < 0, test_name, "ioctl perf_event_ioc_enable error: %s\n",
-		  strerror(errno)))
-		goto disable_pmu;
-
-	err = ioctl(pmu_fd, PERF_EVENT_IOC_SET_BPF, prog_fd);
-	if (CHECK(err < 0, test_name, "ioctl perf_event_ioc_set_bpf error: %s\n",
-		  strerror(errno)))
-		goto disable_pmu;
-
-	err = -1;
-	info_map_fd = bpf_object__find_map_fd_by_name(obj, "info_map");
-	if (CHECK(info_map_fd < 0, test_name, "find map %s error\n", "info_map"))
-		goto disable_pmu;
-
-	status_map_fd = bpf_object__find_map_fd_by_name(obj, "status_map");
-	if (CHECK(status_map_fd < 0, test_name, "find map %s error\n", "status_map"))
-		goto disable_pmu;
+	if (is_tp) {
+		skel->links.send_signal_tp =
+			bpf_program__attach_perf_event(skel->progs.send_signal_tp, pmu_fd);
+		if (CHECK(IS_ERR(skel->links.send_signal_tp), "attach_perf_event",
+			"err %ld\n", PTR_ERR(skel->links.send_signal_tp)))
+			goto disable_pmu;
+	} else {
+		skel->links.send_signal_perf =
+			bpf_program__attach_perf_event(skel->progs.send_signal_perf, pmu_fd);
+		if (CHECK(IS_ERR(skel->links.send_signal_perf), "attach_perf_event",
+			"err %ld\n", PTR_ERR(skel->links.send_signal_perf)))
+			goto disable_pmu;
+	}
 
 	/* wait until child signal handler installed */
 	read(pipe_c2p[0], buf, 1);
 
 	/* trigger the bpf send_signal */
-	key = 0;
-	val = (((__u64)(SIGUSR1)) << 32) | pid;
-	bpf_map_update_elem(info_map_fd, &key, &val, 0);
+	bss_data->pid = pid;
+	bss_data->sig = SIGUSR1;
+	bss_data->signal_thread = signal_thread;
 
 	/* notify child that bpf program can send_signal now */
 	write(pipe_p2c[1], buf, 1);
@@ -132,15 +147,15 @@ static void test_send_signal_common(struct perf_event_attr *attr,
 
 disable_pmu:
 	close(pmu_fd);
-close_prog:
-	bpf_object__close(obj);
-prog_load_failure:
+destroy_skel:
+	test_send_signal_kern__destroy(skel);
+skel_open_load_failure:
 	close(pipe_c2p[0]);
 	close(pipe_p2c[1]);
 	wait(NULL);
 }
 
-static void test_send_signal_tracepoint(void)
+static void test_send_signal_tracepoint(bool signal_thread)
 {
 	const char *id_path = "/sys/kernel/debug/tracing/events/syscalls/sys_enter_nanosleep/id";
 	struct perf_event_attr attr = {
@@ -168,10 +183,10 @@ static void test_send_signal_tracepoint(void)
 
 	attr.config = strtol(buf, NULL, 0);
 
-	test_send_signal_common(&attr, BPF_PROG_TYPE_TRACEPOINT, "tracepoint");
+	test_send_signal_common(&attr, true, signal_thread, "tracepoint");
 }
 
-static void test_send_signal_perf(void)
+static void test_send_signal_perf(bool signal_thread)
 {
 	struct perf_event_attr attr = {
 		.sample_period = 1,
@@ -179,11 +194,10 @@ static void test_send_signal_perf(void)
 		.config = PERF_COUNT_SW_CPU_CLOCK,
 	};
 
-	test_send_signal_common(&attr, BPF_PROG_TYPE_PERF_EVENT,
-				"perf_sw_event");
+	test_send_signal_common(&attr, false, signal_thread, "perf_sw_event");
 }
 
-static void test_send_signal_nmi(void)
+static void test_send_signal_nmi(bool signal_thread)
 {
 	struct perf_event_attr attr = {
 		.sample_freq = 50,
@@ -210,16 +224,21 @@ static void test_send_signal_nmi(void)
 		close(pmu_fd);
 	}
 
-	test_send_signal_common(&attr, BPF_PROG_TYPE_PERF_EVENT,
-				"perf_hw_event");
+	test_send_signal_common(&attr, false, signal_thread, "perf_hw_event");
 }
 
 void test_send_signal(void)
 {
 	if (test__start_subtest("send_signal_tracepoint"))
-		test_send_signal_tracepoint();
+		test_send_signal_tracepoint(false);
 	if (test__start_subtest("send_signal_perf"))
-		test_send_signal_perf();
+		test_send_signal_perf(false);
 	if (test__start_subtest("send_signal_nmi"))
-		test_send_signal_nmi();
+		test_send_signal_nmi(false);
+	if (test__start_subtest("send_signal_tracepoint_thread"))
+		test_send_signal_tracepoint(true);
+	if (test__start_subtest("send_signal_perf_thread"))
+		test_send_signal_perf(true);
+	if (test__start_subtest("send_signal_nmi_thread"))
+		test_send_signal_nmi(true);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c b/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
index 0e6be01157e6..726733f9f20b 100644
--- a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
@@ -4,44 +4,37 @@
 #include <linux/version.h>
 #include "bpf_helpers.h"
 
-struct {
-	__uint(type, BPF_MAP_TYPE_ARRAY);
-	__uint(max_entries, 1);
-	__type(key, __u32);
-	__type(value, __u64);
-} info_map SEC(".maps");
-
-struct {
-	__uint(type, BPF_MAP_TYPE_ARRAY);
-	__uint(max_entries, 1);
-	__type(key, __u32);
-	__type(value, __u64);
-} status_map SEC(".maps");
-
-SEC("send_signal_demo")
-int bpf_send_signal_test(void *ctx)
+__u32 sig = 0, pid = 0, status = 0, signal_thread = 0;
+
+static __always_inline int bpf_send_signal_test(void *ctx)
 {
-	__u64 *info_val, *status_val;
-	__u32 key = 0, pid, sig;
 	int ret;
 
-	status_val = bpf_map_lookup_elem(&status_map, &key);
-	if (!status_val || *status_val != 0)
-		return 0;
-
-	info_val = bpf_map_lookup_elem(&info_map, &key);
-	if (!info_val || *info_val == 0)
+	if (status != 0 || sig == 0 || pid == 0)
 		return 0;
 
-	sig = *info_val >> 32;
-	pid = *info_val & 0xffffFFFF;
-
 	if ((bpf_get_current_pid_tgid() >> 32) == pid) {
-		ret = bpf_send_signal(sig);
+		if (signal_thread)
+			ret = bpf_send_signal_thread(sig);
+		else
+			ret = bpf_send_signal(sig);
 		if (ret == 0)
-			*status_val = 1;
+			status = 1;
 	}
 
 	return 0;
 }
+
+SEC("tracepoint/syscalls/sys_enter_nanosleep")
+int send_signal_tp(void *ctx)
+{
+	return bpf_send_signal_test(ctx);
+}
+
+SEC("perf_event")
+int send_signal_perf(void *ctx)
+{
+	return bpf_send_signal_test(ctx);
+}
+
 char __license[] SEC("license") = "GPL";
-- 
2.17.1


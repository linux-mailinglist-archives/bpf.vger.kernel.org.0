Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8D413B85F
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2020 04:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgAODuM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jan 2020 22:50:12 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49516 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728904AbgAODuM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Jan 2020 22:50:12 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00F3npQu021939
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2020 19:50:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=YZEbXFmkALfdCtcxmF12s0q0wu5zhLvEEwvCSmYpJRU=;
 b=gRk6jszAcBz40GmjLsvMpQzH/3WMtxkec1j0xlBCAvAhMPkT4YSLyltSWdal7P8D3NOy
 L2hb4GYOoRFRpgLxWD2pBKvWOzCLcafhnwRqOAZ4piY5Y0zT2w8T0crzqOvtDse18Rik
 u01InJTHXq3QavfJLuSG3UDWQIngOTBwgq4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2xhp0fh6mm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2020 19:50:11 -0800
Received: from intmgw003.08.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 14 Jan 2020 19:50:10 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id A976D37047F1; Tue, 14 Jan 2020 19:50:03 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v3 2/2] tools/bpf: add self tests for bpf_send_signal_thread()
Date:   Tue, 14 Jan 2020 19:50:03 -0800
Message-ID: <20200115035003.602425-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200115035002.602280-1-yhs@fb.com>
References: <20200115035002.602280-1-yhs@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-14_06:2020-01-14,2020-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 clxscore=1015 mlxscore=0 priorityscore=1501 suspectscore=13
 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001150031
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
 .../selftests/bpf/prog_tests/send_signal.c    | 128 +++++++-----------
 .../bpf/progs/test_send_signal_kern.c         |  51 +++----
 2 files changed, 73 insertions(+), 106 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
index b607112c64e7..d4cedd86c424 100644
--- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include "test_send_signal_kern.skel.h"
 
 static volatile int sigusr1_received = 0;
 
@@ -9,17 +10,15 @@ static void sigusr1_handler(int signum)
 }
 
 static void test_send_signal_common(struct perf_event_attr *attr,
-				    int prog_type,
+				    bool signal_thread,
 				    const char *test_name)
 {
-	int err = -1, pmu_fd, prog_fd, info_map_fd, status_map_fd;
-	const char *file = "./test_send_signal_kern.o";
-	struct bpf_object *obj = NULL;
+	struct test_send_signal_kern *skel;
 	int pipe_c2p[2], pipe_p2c[2];
-	__u32 key = 0, duration = 0;
+	int err = -1, pmu_fd = -1;
+	__u32 duration = 0;
 	char buf[256];
 	pid_t pid;
-	__u64 val;
 
 	if (CHECK(pipe(pipe_c2p), test_name,
 		  "pipe pipe_c2p error: %s\n", strerror(errno)))
@@ -73,45 +72,42 @@ static void test_send_signal_common(struct perf_event_attr *attr,
 	close(pipe_c2p[1]); /* close write */
 	close(pipe_p2c[0]); /* close read */
 
-	err = bpf_prog_load(file, prog_type, &obj, &prog_fd);
-	if (CHECK(err < 0, test_name, "bpf_prog_load error: %s\n",
-		  strerror(errno)))
-		goto prog_load_failure;
-
-	pmu_fd = syscall(__NR_perf_event_open, attr, pid, -1,
-			 -1 /* group id */, 0 /* flags */);
-	if (CHECK(pmu_fd < 0, test_name, "perf_event_open error: %s\n",
-		  strerror(errno))) {
-		err = -1;
-		goto close_prog;
-	}
-
-	err = ioctl(pmu_fd, PERF_EVENT_IOC_ENABLE, 0);
-	if (CHECK(err < 0, test_name, "ioctl perf_event_ioc_enable error: %s\n",
-		  strerror(errno)))
-		goto disable_pmu;
+	skel = test_send_signal_kern__open_and_load();
+	if (CHECK(!skel, "skel_open_and_load", "skeleton open_and_load failed\n"))
+		goto skel_open_load_failure;
 
-	err = ioctl(pmu_fd, PERF_EVENT_IOC_SET_BPF, prog_fd);
-	if (CHECK(err < 0, test_name, "ioctl perf_event_ioc_set_bpf error: %s\n",
-		  strerror(errno)))
-		goto disable_pmu;
+	/* add a delay for child thread to ramp up */
+	usleep(100);
 
-	err = -1;
-	info_map_fd = bpf_object__find_map_fd_by_name(obj, "info_map");
-	if (CHECK(info_map_fd < 0, test_name, "find map %s error\n", "info_map"))
-		goto disable_pmu;
+	if (!attr) {
+		err = test_send_signal_kern__attach(skel);
+		if (CHECK(err, "skel_attach", "skeleton attach failed\n")) {
+			err = -1;
+			goto destroy_skel;
+		}
+	} else {
+		pmu_fd = syscall(__NR_perf_event_open, attr, pid, -1,
+				 -1 /* group id */, 0 /* flags */);
+		if (CHECK(pmu_fd < 0, test_name, "perf_event_open error: %s\n",
+			strerror(errno))) {
+			err = -1;
+			goto destroy_skel;
+		}
 
-	status_map_fd = bpf_object__find_map_fd_by_name(obj, "status_map");
-	if (CHECK(status_map_fd < 0, test_name, "find map %s error\n", "status_map"))
-		goto disable_pmu;
+		skel->links.send_signal_perf =
+			bpf_program__attach_perf_event(skel->progs.send_signal_perf, pmu_fd);
+		if (CHECK(IS_ERR(skel->links.send_signal_perf), "attach_perf_event",
+			  "err %ld\n", PTR_ERR(skel->links.send_signal_perf)))
+			goto disable_pmu;
+	}
 
 	/* wait until child signal handler installed */
 	read(pipe_c2p[0], buf, 1);
 
 	/* trigger the bpf send_signal */
-	key = 0;
-	val = (((__u64)(SIGUSR1)) << 32) | pid;
-	bpf_map_update_elem(info_map_fd, &key, &val, 0);
+	skel->bss->pid = pid;
+	skel->bss->sig = SIGUSR1;
+	skel->bss->signal_thread = signal_thread;
 
 	/* notify child that bpf program can send_signal now */
 	write(pipe_p2c[1], buf, 1);
@@ -132,46 +128,20 @@ static void test_send_signal_common(struct perf_event_attr *attr,
 
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
-	const char *id_path = "/sys/kernel/debug/tracing/events/syscalls/sys_enter_nanosleep/id";
-	struct perf_event_attr attr = {
-		.type = PERF_TYPE_TRACEPOINT,
-		.sample_type = PERF_SAMPLE_RAW | PERF_SAMPLE_CALLCHAIN,
-		.sample_period = 1,
-		.wakeup_events = 1,
-	};
-	__u32 duration = 0;
-	int bytes, efd;
-	char buf[256];
-
-	efd = open(id_path, O_RDONLY, 0);
-	if (CHECK(efd < 0, "tracepoint",
-		  "open syscalls/sys_enter_nanosleep/id failure: %s\n",
-		  strerror(errno)))
-		return;
-
-	bytes = read(efd, buf, sizeof(buf));
-	close(efd);
-	if (CHECK(bytes <= 0 || bytes >= sizeof(buf), "tracepoint",
-		  "read syscalls/sys_enter_nanosleep/id failure: %s\n",
-		  strerror(errno)))
-		return;
-
-	attr.config = strtol(buf, NULL, 0);
-
-	test_send_signal_common(&attr, BPF_PROG_TYPE_TRACEPOINT, "tracepoint");
+	test_send_signal_common(NULL, signal_thread, "tracepoint");
 }
 
-static void test_send_signal_perf(void)
+static void test_send_signal_perf(bool signal_thread)
 {
 	struct perf_event_attr attr = {
 		.sample_period = 1,
@@ -179,11 +149,10 @@ static void test_send_signal_perf(void)
 		.config = PERF_COUNT_SW_CPU_CLOCK,
 	};
 
-	test_send_signal_common(&attr, BPF_PROG_TYPE_PERF_EVENT,
-				"perf_sw_event");
+	test_send_signal_common(&attr, signal_thread, "perf_sw_event");
 }
 
-static void test_send_signal_nmi(void)
+static void test_send_signal_nmi(bool signal_thread)
 {
 	struct perf_event_attr attr = {
 		.sample_freq = 50,
@@ -210,16 +179,21 @@ static void test_send_signal_nmi(void)
 		close(pmu_fd);
 	}
 
-	test_send_signal_common(&attr, BPF_PROG_TYPE_PERF_EVENT,
-				"perf_hw_event");
+	test_send_signal_common(&attr, signal_thread, "perf_hw_event");
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


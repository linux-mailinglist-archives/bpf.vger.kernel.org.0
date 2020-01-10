Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 042B313649D
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2020 02:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730452AbgAJBQH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jan 2020 20:16:07 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:10280 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730446AbgAJBQH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 9 Jan 2020 20:16:07 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00A19C6l024021
        for <bpf@vger.kernel.org>; Thu, 9 Jan 2020 17:16:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=Wz86KvFukJg/0dm6Bi9IRhMk1KsBY2thJq0dQbv+oe4=;
 b=CwJbfNJq0HmpcRizmdR0j/Y29/w05zH4xw+Ix/t5mag9HleDtKNuMbDR1bLyIqL0+O6c
 RPVKSFwlOybsBUb4fKFf5l8UJBkN2MhnHx9tHjQ2cBLmsPLSr7Z8jqZ0qEDD8LTIQnA8
 o2gycyhteGkWlcrG2MzPAsc5VVI8eg69fus= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2xe7ubaq4j-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 09 Jan 2020 17:16:06 -0800
Received: from intmgw005.03.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 9 Jan 2020 17:16:05 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 69A8237047ED; Thu,  9 Jan 2020 17:15:59 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 2/2] tools/bpf: add a selftest for bpf_send_signal_thread()
Date:   Thu, 9 Jan 2020 17:15:59 -0800
Message-ID: <20200110011559.1949913-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110011557.1949757-1-yhs@fb.com>
References: <20200110011557.1949757-1-yhs@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_06:2020-01-09,2020-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 clxscore=1015
 impostorscore=0 suspectscore=13 adultscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001100009
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

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/include/uapi/linux/bpf.h                | 18 +++++++++--
 .../selftests/bpf/prog_tests/send_signal.c    | 30 ++++++++++++-------
 .../bpf/progs/test_send_signal_kern.c         |  9 ++++--
 3 files changed, 42 insertions(+), 15 deletions(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 52966e758fe5..3320f8bdfe7e 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2714,7 +2714,7 @@ union bpf_attr {
  *
  * int bpf_send_signal(u32 sig)
  *	Description
- *		Send signal *sig* to the current task.
+ *		Send signal *sig* to the process of the current task.
  *	Return
  *		0 on success or successfully queued.
  *
@@ -2850,6 +2850,19 @@ union bpf_attr {
  *	Return
  *		0 on success, or a negative error in case of failure.
  *
+ * int bpf_send_signal_thread(u32 sig)
+ *	Description
+ *		Send signal *sig* to the current task.
+ *	Return
+ *		0 on success or successfully queued.
+ *
+ *		**-EBUSY** if work queue under nmi is full.
+ *
+ *		**-EINVAL** if *sig* is invalid.
+ *
+ *		**-EPERM** if no permission to send the *sig*.
+ *
+ *		**-EAGAIN** if bpf program can try again.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -2968,7 +2981,8 @@ union bpf_attr {
 	FN(probe_read_kernel),		\
 	FN(probe_read_user_str),	\
 	FN(probe_read_kernel_str),	\
-	FN(tcp_send_ack),
+	FN(tcp_send_ack),		\
+	FN(send_signal_thread),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
index b607112c64e7..b12350832be3 100644
--- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
@@ -10,7 +10,8 @@ static void sigusr1_handler(int signum)
 
 static void test_send_signal_common(struct perf_event_attr *attr,
 				    int prog_type,
-				    const char *test_name)
+				    const char *test_name,
+				    bool send_thread)
 {
 	int err = -1, pmu_fd, prog_fd, info_map_fd, status_map_fd;
 	const char *file = "./test_send_signal_kern.o";
@@ -110,7 +111,7 @@ static void test_send_signal_common(struct perf_event_attr *attr,
 
 	/* trigger the bpf send_signal */
 	key = 0;
-	val = (((__u64)(SIGUSR1)) << 32) | pid;
+	val = (((__u64)send_thread) << 48) | (((__u64)(SIGUSR1)) << 32) | pid;
 	bpf_map_update_elem(info_map_fd, &key, &val, 0);
 
 	/* notify child that bpf program can send_signal now */
@@ -140,7 +141,7 @@ static void test_send_signal_common(struct perf_event_attr *attr,
 	wait(NULL);
 }
 
-static void test_send_signal_tracepoint(void)
+static void test_send_signal_tracepoint(bool send_thread)
 {
 	const char *id_path = "/sys/kernel/debug/tracing/events/syscalls/sys_enter_nanosleep/id";
 	struct perf_event_attr attr = {
@@ -168,10 +169,11 @@ static void test_send_signal_tracepoint(void)
 
 	attr.config = strtol(buf, NULL, 0);
 
-	test_send_signal_common(&attr, BPF_PROG_TYPE_TRACEPOINT, "tracepoint");
+	test_send_signal_common(&attr, BPF_PROG_TYPE_TRACEPOINT, "tracepoint",
+				send_thread);
 }
 
-static void test_send_signal_perf(void)
+static void test_send_signal_perf(bool send_thread)
 {
 	struct perf_event_attr attr = {
 		.sample_period = 1,
@@ -180,10 +182,10 @@ static void test_send_signal_perf(void)
 	};
 
 	test_send_signal_common(&attr, BPF_PROG_TYPE_PERF_EVENT,
-				"perf_sw_event");
+				"perf_sw_event", send_thread);
 }
 
-static void test_send_signal_nmi(void)
+static void test_send_signal_nmi(bool send_thread)
 {
 	struct perf_event_attr attr = {
 		.sample_freq = 50,
@@ -211,15 +213,21 @@ static void test_send_signal_nmi(void)
 	}
 
 	test_send_signal_common(&attr, BPF_PROG_TYPE_PERF_EVENT,
-				"perf_hw_event");
+				"perf_hw_event", send_thread);
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
index 0e6be01157e6..4a722024c32b 100644
--- a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
@@ -23,6 +23,7 @@ int bpf_send_signal_test(void *ctx)
 {
 	__u64 *info_val, *status_val;
 	__u32 key = 0, pid, sig;
+	int use_signal_thread;
 	int ret;
 
 	status_val = bpf_map_lookup_elem(&status_map, &key);
@@ -33,11 +34,15 @@ int bpf_send_signal_test(void *ctx)
 	if (!info_val || *info_val == 0)
 		return 0;
 
-	sig = *info_val >> 32;
+	use_signal_thread = *info_val >> 48;
+	sig = *info_val >> 32 & 0xFFFF;
 	pid = *info_val & 0xffffFFFF;
 
 	if ((bpf_get_current_pid_tgid() >> 32) == pid) {
-		ret = bpf_send_signal(sig);
+		if (use_signal_thread)
+			ret = bpf_send_signal_thread(sig);
+		else
+			ret = bpf_send_signal(sig);
 		if (ret == 0)
 			*status_val = 1;
 	}
-- 
2.17.1


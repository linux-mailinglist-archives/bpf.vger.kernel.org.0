Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18EAE1798B3
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 20:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbgCDTLL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Mar 2020 14:11:11 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:20196 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728539AbgCDTLK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 4 Mar 2020 14:11:10 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 024ItI5v018500
        for <bpf@vger.kernel.org>; Wed, 4 Mar 2020 11:11:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=EM1hjN0ZSzV+ewtjiKWRA7MnU09QiUEIka7s34hOQTs=;
 b=Q4EGbvLtWe2nhZ+7vHOfjHlULaE0EL4IX0YnQ3vNjwTpyeCunBLo6Y79S5iJ97FJKqHY
 4FCICzZZwQsJLIvP3QKIG+Pn67GNJOcAZg0sN2rN8nsorglRSQlaKZUmNGG5iI1jwKMx
 U4saVXti6w6w3A5bGtmjx8pZk0WwMAUku2o= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2yhpfwrq17-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2020 11:11:09 -0800
Received: from intmgw001.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 4 Mar 2020 11:11:07 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id E5F0A370103E; Wed,  4 Mar 2020 11:11:05 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf v3 2/2] selftests/bpf: add send_signal_sched_switch test
Date:   Wed, 4 Mar 2020 11:11:05 -0800
Message-ID: <20200304191105.2796601-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200304191104.2796444-1-yhs@fb.com>
References: <20200304191104.2796444-1-yhs@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_08:2020-03-04,2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=13 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040126
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Added one test, send_signal_sched_switch, to test bpf_send_signal()
helper triggered by sched/sched_switch tracepoint. This test can be used
to verify kernel deadlocks fixed by the previous commit. The test itself
is heavily borrowed from Commit eac9153f2b58 ("bpf/stackmap: Fix deadlock
with rq_lock in bpf_get_stack()").

Cc: Song Liu <songliubraving@fb.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../bpf/prog_tests/send_signal_sched_switch.c | 60 +++++++++++++++++++
 .../bpf/progs/test_send_signal_kern.c         |  6 ++
 2 files changed, 66 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/send_signal_sched_switch.c

diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal_sched_switch.c b/tools/testing/selftests/bpf/prog_tests/send_signal_sched_switch.c
new file mode 100644
index 000000000000..189a34a7addb
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal_sched_switch.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/mman.h>
+#include <pthread.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include "test_send_signal_kern.skel.h"
+
+static void sigusr1_handler(int signum)
+{
+}
+
+#define THREAD_COUNT 100
+
+static void *worker(void *p)
+{
+	int i;
+
+	for ( i = 0; i < 1000; i++)
+		usleep(1);
+
+	return NULL;
+}
+
+void test_send_signal_sched_switch(void)
+{
+	struct test_send_signal_kern *skel;
+	pthread_t threads[THREAD_COUNT];
+	u32 duration = 0;
+	int i, err;
+
+	signal(SIGUSR1, sigusr1_handler);
+
+	skel = test_send_signal_kern__open_and_load();
+	if (CHECK(!skel, "skel_open_and_load", "skeleton open_and_load failed\n"))
+		return;
+
+	skel->bss->pid = getpid();
+	skel->bss->sig = SIGUSR1;
+
+	err = test_send_signal_kern__attach(skel);
+	if (CHECK(err, "skel_attach", "skeleton attach failed\n"))
+		goto destroy_skel;
+
+	for (i = 0; i < THREAD_COUNT; i++) {
+		err = pthread_create(threads + i, NULL, worker, NULL);
+		if (CHECK(err, "pthread_create", "Error creating thread, %s\n",
+			  strerror(errno)))
+			goto destroy_skel;
+	}
+
+	for (i = 0; i < THREAD_COUNT; i++)
+		pthread_join(threads[i], NULL);
+
+destroy_skel:
+	test_send_signal_kern__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c b/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
index 1acc91e87bfc..b4233d3efac2 100644
--- a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
@@ -31,6 +31,12 @@ int send_signal_tp(void *ctx)
 	return bpf_send_signal_test(ctx);
 }
 
+SEC("tracepoint/sched/sched_switch")
+int send_signal_tp_sched(void *ctx)
+{
+	return bpf_send_signal_test(ctx);
+}
+
 SEC("perf_event")
 int send_signal_perf(void *ctx)
 {
-- 
2.17.1


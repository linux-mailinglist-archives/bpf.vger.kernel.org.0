Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706693EF0C1
	for <lists+bpf@lfdr.de>; Tue, 17 Aug 2021 19:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhHQRUq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Aug 2021 13:20:46 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57400 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229723AbhHQRUp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 17 Aug 2021 13:20:45 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HHFpdD016053
        for <bpf@vger.kernel.org>; Tue, 17 Aug 2021 10:20:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=XfJ/M/7C4X6dgMrXCDu6UKXGhPm3WNc2dLGETxt1qXc=;
 b=Fipy/cW44f2NLUTy4YmJiYCrX7X+znasU4FnBiUVGn4HBWw2fcVP/i166VSH6wUE3NlY
 c8uB8zRKnfoL7wl+SLy+tQ5n+W+hHq9DgwUvspWmK5hFmjH/wROIPfuQqpGGv9EjF30b
 uhPsu/Ll5kSw0FP7u7L2YPDwYh0kExbiGbk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3aftr4qv9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 17 Aug 2021 10:20:11 -0700
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 17 Aug 2021 10:20:11 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id D86996063B94; Tue, 17 Aug 2021 10:20:09 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: fix flaky send_signal test
Date:   Tue, 17 Aug 2021 10:20:09 -0700
Message-ID: <20210817172009.2770161-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210817171958.2769074-1-yhs@fb.com>
References: <20210817171958.2769074-1-yhs@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 38W2CabjwxPVhq2lNJecDAZ3GHgcqhrp
X-Proofpoint-GUID: 38W2CabjwxPVhq2lNJecDAZ3GHgcqhrp
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-17_06:2021-08-17,2021-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 adultscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108170108
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

libbpf CI has reported send_signal test is flaky although
I am not able to reproduce it in my local environment.
But I am able to reproduce with on-demand libbpf CI ([1]).

Through code analysis, the following is possible reason.
The failed subtest runs bpf program in softirq environment.
Since bpf_send_signal() only sends to a fork of "test_progs"
process. If the underlying current task is
not "test_progs", bpf_send_signal() will not be triggered
and the subtest will fail.

To reduce the chances where the underlying process is not
the intended one, this patch boosted scheduling priority to
-20 (highest allowed by setpriority() call). And I did
10 runs with on-demand libbpf CI with this patch and I
didn't observe any failures.

 [1] https://github.com/libbpf/libbpf/actions/workflows/ondemand.yml

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/send_signal.c    | 33 +++++++++++++++----
 .../bpf/progs/test_send_signal_kern.c         |  3 +-
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/t=
esting/selftests/bpf/prog_tests/send_signal.c
index 41e158ae888e..0701c97456da 100644
--- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include <sys/time.h>
+#include <sys/resource.h>
 #include "test_send_signal_kern.skel.h"
=20
 int sigusr1_received =3D 0;
@@ -10,7 +12,7 @@ static void sigusr1_handler(int signum)
 }
=20
 static void test_send_signal_common(struct perf_event_attr *attr,
-				    bool signal_thread)
+				    bool signal_thread, bool allow_skip)
 {
 	struct test_send_signal_kern *skel;
 	int pipe_c2p[2], pipe_p2c[2];
@@ -37,12 +39,23 @@ static void test_send_signal_common(struct perf_event_a=
ttr *attr,
 	}
=20
 	if (pid =3D=3D 0) {
+		int old_prio;
+
 		/* install signal handler and notify parent */
 		signal(SIGUSR1, sigusr1_handler);
=20
 		close(pipe_c2p[0]); /* close read */
 		close(pipe_p2c[1]); /* close write */
=20
+		/* boost with a high priority so we got a higher chance
+		 * that if an interrupt happens, the underlying task
+		 * is this process.
+		 */
+		errno =3D 0;
+		old_prio =3D getpriority(PRIO_PROCESS, 0);
+		ASSERT_OK(errno, "getpriority");
+		ASSERT_OK(setpriority(PRIO_PROCESS, 0, -20), "setpriority");
+
 		/* notify parent signal handler is installed */
 		ASSERT_EQ(write(pipe_c2p[1], buf, 1), 1, "pipe_write");
=20
@@ -58,6 +71,9 @@ static void test_send_signal_common(struct perf_event_att=
r *attr,
 		/* wait for parent notification and exit */
 		ASSERT_EQ(read(pipe_p2c[0], buf, 1), 1, "pipe_read");
=20
+		/* restore the old priority */
+		ASSERT_OK(setpriority(PRIO_PROCESS, 0, old_prio), "setpriority");
+
 		close(pipe_c2p[1]);
 		close(pipe_p2c[0]);
 		exit(0);
@@ -110,11 +126,16 @@ static void test_send_signal_common(struct perf_event=
_attr *attr,
 		goto disable_pmu;
 	}
=20
-	ASSERT_EQ(buf[0], '2', "incorrect result");
-
 	/* notify child safe to exit */
 	ASSERT_EQ(write(pipe_p2c[1], buf, 1), 1, "pipe_write");
=20
+	if (skel->bss->status =3D=3D 0 && allow_skip) {
+		printf("%s:SKIP\n", __func__);
+		test__skip();
+	} else if (skel->bss->status !=3D 1) {
+		ASSERT_EQ(buf[0], '2', "incorrect result");
+	}
+
 disable_pmu:
 	close(pmu_fd);
 destroy_skel:
@@ -127,7 +148,7 @@ static void test_send_signal_common(struct perf_event_a=
ttr *attr,
=20
 static void test_send_signal_tracepoint(bool signal_thread)
 {
-	test_send_signal_common(NULL, signal_thread);
+	test_send_signal_common(NULL, signal_thread, false);
 }
=20
 static void test_send_signal_perf(bool signal_thread)
@@ -138,7 +159,7 @@ static void test_send_signal_perf(bool signal_thread)
 		.config =3D PERF_COUNT_SW_CPU_CLOCK,
 	};
=20
-	test_send_signal_common(&attr, signal_thread);
+	test_send_signal_common(&attr, signal_thread, true);
 }
=20
 static void test_send_signal_nmi(bool signal_thread)
@@ -167,7 +188,7 @@ static void test_send_signal_nmi(bool signal_thread)
 		close(pmu_fd);
 	}
=20
-	test_send_signal_common(&attr, signal_thread);
+	test_send_signal_common(&attr, signal_thread, true);
 }
=20
 void test_send_signal(void)
diff --git a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c b/to=
ols/testing/selftests/bpf/progs/test_send_signal_kern.c
index b4233d3efac2..59c05c422bbd 100644
--- a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
@@ -18,8 +18,7 @@ static __always_inline int bpf_send_signal_test(void *ctx)
 			ret =3D bpf_send_signal_thread(sig);
 		else
 			ret =3D bpf_send_signal(sig);
-		if (ret =3D=3D 0)
-			status =3D 1;
+		status =3D (ret =3D=3D 0) ? 1 : 2;
 	}
=20
 	return 0;
--=20
2.30.2


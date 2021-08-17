Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 541A73EF27F
	for <lists+bpf@lfdr.de>; Tue, 17 Aug 2021 21:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbhHQTKG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Aug 2021 15:10:06 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:5040 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229821AbhHQTJ7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 17 Aug 2021 15:09:59 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HJ5pv1027707
        for <bpf@vger.kernel.org>; Tue, 17 Aug 2021 12:09:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=MQx4F/Hy2agtrxVtqs4xzsFNwoXhTkZ7F0K2sM3TnNE=;
 b=KBCaKFOsy3xXWLlL+0Hl1HV/8C98ChMqmFx2uqn7JK6SZg6jI/LWv/CPmIXELToVmTBy
 cdLyNyj2/+2ntpv450VsLcUutwyau8tMXbgTSw+yAScFeifUTbw1wqblv4oSXlPTpXyt
 6KVxHomF1Q3VXrcX04hVVl1TPc8P7vbjZRA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3aftr4rjsa-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 17 Aug 2021 12:09:26 -0700
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 17 Aug 2021 12:09:24 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 45258606B1E7; Tue, 17 Aug 2021 12:09:23 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: fix flaky send_signal test
Date:   Tue, 17 Aug 2021 12:09:23 -0700
Message-ID: <20210817190923.3186725-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210817190912.3185813-1-yhs@fb.com>
References: <20210817190912.3185813-1-yhs@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: W1Hv_HGAF5P-lhzNrBFaUtVvbr7PrcqL
X-Proofpoint-GUID: W1Hv_HGAF5P-lhzNrBFaUtVvbr7PrcqL
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-17_06:2021-08-17,2021-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 adultscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108170120
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
 .../selftests/bpf/prog_tests/send_signal.c       | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/t=
esting/selftests/bpf/prog_tests/send_signal.c
index 41e158ae888e..776916b61c40 100644
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
--=20
2.30.2


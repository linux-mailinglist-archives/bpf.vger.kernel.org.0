Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4101B22B570
	for <lists+bpf@lfdr.de>; Thu, 23 Jul 2020 20:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgGWSKE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jul 2020 14:10:04 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:11244 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726983AbgGWSKD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Jul 2020 14:10:03 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 06NHqXNx003573
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2020 11:10:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=d0xYJy4huNGUNES1TTj69vv7d4p2DHeoXRNFx3PPv5Y=;
 b=gfjR83YnIXIa1Krrxfd7y1p8w+E/mTZBO/EmxFC7gK95cjR6zVDkV3BXqDQeQQkEJUv2
 ykigmo7OO4+YiOp7Bvss+PY9Vzq4t17MKIliwQCcFyf96n8ZhflTKYzsKxM0FdmL5b2Z
 aYX3LYrAlI1S7imjh0VjUk7CVlV8LdvA8Fs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 32er2febns-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2020 11:10:02 -0700
Received: from intmgw002.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 23 Jul 2020 11:10:01 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 3E65862E50BB; Thu, 23 Jul 2020 11:07:06 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@chromium.org>,
        <brouer@redhat.com>, <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v5 bpf-next 5/5] selftests/bpf: add get_stackid_cannot_attach
Date:   Thu, 23 Jul 2020 11:06:48 -0700
Message-ID: <20200723180648.1429892-6-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200723180648.1429892-1-songliubraving@fb.com>
References: <20200723180648.1429892-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-23_09:2020-07-23,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 impostorscore=0 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007230132
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This test confirms that BPF program that calls bpf_get_stackid() cannot
attach to perf_event with precise_ip > 0 but not PERF_SAMPLE_CALLCHAIN;
and cannot attach if the perf_event has exclude_callchain_kernel.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 .../prog_tests/get_stackid_cannot_attach.c    | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/get_stackid_ca=
nnot_attach.c

diff --git a/tools/testing/selftests/bpf/prog_tests/get_stackid_cannot_at=
tach.c b/tools/testing/selftests/bpf/prog_tests/get_stackid_cannot_attach=
.c
new file mode 100644
index 0000000000000..f13149d279bc9
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/get_stackid_cannot_attach.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2020 Facebook
+#include <test_progs.h>
+#include "test_stacktrace_build_id.skel.h"
+
+void test_get_stackid_cannot_attach(void)
+{
+	struct perf_event_attr attr =3D {
+		/* .type =3D PERF_TYPE_SOFTWARE, */
+		.type =3D PERF_TYPE_HARDWARE,
+		.config =3D PERF_COUNT_HW_CPU_CYCLES,
+		.precise_ip =3D 1,
+		.sample_type =3D PERF_SAMPLE_IP | PERF_SAMPLE_BRANCH_STACK,
+		.branch_sample_type =3D PERF_SAMPLE_BRANCH_USER |
+			PERF_SAMPLE_BRANCH_NO_FLAGS |
+			PERF_SAMPLE_BRANCH_NO_CYCLES |
+			PERF_SAMPLE_BRANCH_CALL_STACK,
+		.sample_period =3D 5000,
+		.size =3D sizeof(struct perf_event_attr),
+	};
+	struct test_stacktrace_build_id *skel;
+	__u32 duration =3D 0;
+	int pmu_fd, err;
+
+	skel =3D test_stacktrace_build_id__open();
+	if (CHECK(!skel, "skel_open", "skeleton open failed\n"))
+		return;
+
+	/* override program type */
+	bpf_program__set_perf_event(skel->progs.oncpu);
+
+	err =3D test_stacktrace_build_id__load(skel);
+	if (CHECK(err, "skel_load", "skeleton load failed: %d\n", err))
+		goto cleanup;
+
+	pmu_fd =3D syscall(__NR_perf_event_open, &attr, -1 /* pid */,
+			 0 /* cpu 0 */, -1 /* group id */,
+			 0 /* flags */);
+	if (pmu_fd < 0 && errno =3D=3D ENOENT) {
+		printf("%s:SKIP:cannot open PERF_COUNT_HW_CPU_CYCLES with precise_ip >=
 0\n",
+		       __func__);
+		test__skip();
+		goto cleanup;
+	}
+	if (CHECK(pmu_fd < 0, "perf_event_open", "err %d errno %d\n",
+		  pmu_fd, errno))
+		goto cleanup;
+
+	skel->links.oncpu =3D bpf_program__attach_perf_event(skel->progs.oncpu,
+							   pmu_fd);
+	CHECK(!IS_ERR(skel->links.oncpu), "attach_perf_event_no_callchain",
+	      "should have failed\n");
+	close(pmu_fd);
+
+	/* add PERF_SAMPLE_CALLCHAIN, attach should succeed */
+	attr.sample_type |=3D PERF_SAMPLE_CALLCHAIN;
+
+	pmu_fd =3D syscall(__NR_perf_event_open, &attr, -1 /* pid */,
+			 0 /* cpu 0 */, -1 /* group id */,
+			 0 /* flags */);
+
+	if (CHECK(pmu_fd < 0, "perf_event_open", "err %d errno %d\n",
+		  pmu_fd, errno))
+		goto cleanup;
+
+	skel->links.oncpu =3D bpf_program__attach_perf_event(skel->progs.oncpu,
+							   pmu_fd);
+	CHECK(IS_ERR(skel->links.oncpu), "attach_perf_event_callchain",
+	      "err: %ld\n", PTR_ERR(skel->links.oncpu));
+	close(pmu_fd);
+
+	/* add exclude_callchain_kernel, attach should fail */
+	attr.exclude_callchain_kernel =3D 1;
+
+	pmu_fd =3D syscall(__NR_perf_event_open, &attr, -1 /* pid */,
+			 0 /* cpu 0 */, -1 /* group id */,
+			 0 /* flags */);
+
+	if (CHECK(pmu_fd < 0, "perf_event_open", "err %d errno %d\n",
+		  pmu_fd, errno))
+		goto cleanup;
+
+	skel->links.oncpu =3D bpf_program__attach_perf_event(skel->progs.oncpu,
+							   pmu_fd);
+	CHECK(!IS_ERR(skel->links.oncpu), "attach_perf_event_exclude_callchain_=
kernel",
+	      "should have failed\n");
+	close(pmu_fd);
+
+cleanup:
+	test_stacktrace_build_id__destroy(skel);
+}
--=20
2.24.1


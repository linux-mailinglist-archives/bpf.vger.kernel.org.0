Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928C521C18F
	for <lists+bpf@lfdr.de>; Sat, 11 Jul 2020 03:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgGKB3O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jul 2020 21:29:14 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38728 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726605AbgGKB3O (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Jul 2020 21:29:14 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06B1OTFb027668
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2020 18:29:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Zt9u2EpjWjLtKzNqOLuW2yd8dLixE48PVNDjLnQBOGM=;
 b=cwzPqJzFj3nKDLXek/ZNIQ/9oxUu1edCuWpV3UbI6SQ3J12UrHs9ZJAHSADpnl9oMBoh
 kgl/ynnFLB0FjLoGiA8OFYivfDc69+gPJtRY5CChtOM6JW6e6C9USV94A0WzaMeLolBf
 Q7Nwj9uq1bzrNcTsjx79Jhv6CULRu39q5zU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 325k2cd84t-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2020 18:29:13 -0700
Received: from intmgw004.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 10 Jul 2020 18:29:09 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 56F4662E5296; Fri, 10 Jul 2020 18:27:00 -0700 (PDT)
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
Subject: [PATCH bpf-next 5/5] selftests/bpf: add callchain_stackid
Date:   Fri, 10 Jul 2020 18:26:39 -0700
Message-ID: <20200711012639.3429622-6-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200711012639.3429622-1-songliubraving@fb.com>
References: <20200711012639.3429622-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-10_14:2020-07-10,2020-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007110006
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This tests new helper function bpf_get_callchain_stackid(), which is the
alternative to bpf_get_stackid() for perf_event with PEBS entry.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 .../bpf/prog_tests/callchain_stackid.c        | 61 +++++++++++++++++++
 .../selftests/bpf/progs/callchain_stackid.c   | 37 +++++++++++
 2 files changed, 98 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/callchain_stac=
kid.c
 create mode 100644 tools/testing/selftests/bpf/progs/callchain_stackid.c

diff --git a/tools/testing/selftests/bpf/prog_tests/callchain_stackid.c b=
/tools/testing/selftests/bpf/prog_tests/callchain_stackid.c
new file mode 100644
index 0000000000000..ebe6251324a1a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/callchain_stackid.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2020 Facebook
+#include <test_progs.h>
+#include "callchain_stackid.skel.h"
+
+void test_callchain_stackid(void)
+{
+	struct perf_event_attr attr =3D {
+		/* .type =3D PERF_TYPE_SOFTWARE, */
+		.type =3D PERF_TYPE_HARDWARE,
+		.config =3D PERF_COUNT_HW_CPU_CYCLES,
+		.precise_ip =3D 2,
+		.sample_type =3D PERF_SAMPLE_IP | PERF_SAMPLE_BRANCH_STACK |
+			PERF_SAMPLE_CALLCHAIN,
+		.branch_sample_type =3D PERF_SAMPLE_BRANCH_USER |
+			PERF_SAMPLE_BRANCH_NO_FLAGS |
+			PERF_SAMPLE_BRANCH_NO_CYCLES |
+			PERF_SAMPLE_BRANCH_CALL_STACK,
+		.sample_period =3D 5000,
+		.size =3D sizeof(struct perf_event_attr),
+	};
+	struct callchain_stackid *skel;
+	__u32 duration =3D 0;
+	int pmu_fd, err;
+
+	skel =3D callchain_stackid__open();
+
+	if (CHECK(!skel, "skel_open", "skeleton open failed\n"))
+		return;
+
+	/* override program type */
+	bpf_program__set_perf_event(skel->progs.oncpu);
+
+	err =3D callchain_stackid__load(skel);
+	if (CHECK(err, "skel_load", "skeleton load failed: %d\n", err))
+		goto cleanup;
+
+	pmu_fd =3D syscall(__NR_perf_event_open, &attr, -1 /* pid */,
+			 0 /* cpu 0 */, -1 /* group id */,
+			 0 /* flags */);
+	if (pmu_fd < 0) {
+		printf("%s:SKIP:cpu doesn't support the event\n", __func__);
+		test__skip();
+		goto cleanup;
+	}
+
+	skel->links.oncpu =3D bpf_program__attach_perf_event(skel->progs.oncpu,
+							   pmu_fd);
+	if (CHECK(IS_ERR(skel->links.oncpu), "attach_perf_event",
+		  "err %ld\n", PTR_ERR(skel->links.oncpu))) {
+		close(pmu_fd);
+		goto cleanup;
+	}
+	usleep(500000);
+
+	CHECK(skel->data->total_val =3D=3D 1, "get_callchain_stack", "failed\n"=
);
+	close(pmu_fd);
+
+cleanup:
+	callchain_stackid__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/callchain_stackid.c b/tool=
s/testing/selftests/bpf/progs/callchain_stackid.c
new file mode 100644
index 0000000000000..aab2c736a0a45
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/callchain_stackid.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2020 Facebook
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+#ifndef PERF_MAX_STACK_DEPTH
+#define PERF_MAX_STACK_DEPTH         127
+#endif
+
+#ifndef BPF_F_USER_STACK
+#define BPF_F_USER_STACK		(1ULL << 8)
+#endif
+
+typedef __u64 stack_trace_t[PERF_MAX_STACK_DEPTH];
+struct {
+	__uint(type, BPF_MAP_TYPE_STACK_TRACE);
+	__uint(max_entries, 16384);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(stack_trace_t));
+} stackmap SEC(".maps");
+
+long total_val =3D 1;
+
+SEC("perf_event")
+int oncpu(struct bpf_perf_event_data *ctx)
+{
+	long val;
+
+	val =3D bpf_get_callchain_stackid(ctx->callchain, &stackmap, 0);
+
+	if (val > 0)
+		total_val +=3D val;
+
+	return 0;
+}
+
+char LICENSE[] SEC("license") =3D "GPL";
--=20
2.24.1


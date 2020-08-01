Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56122235139
	for <lists+bpf@lfdr.de>; Sat,  1 Aug 2020 10:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgHAItt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 1 Aug 2020 04:49:49 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:3128 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726364AbgHAIts (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 1 Aug 2020 04:49:48 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0718mPNA022611
        for <bpf@vger.kernel.org>; Sat, 1 Aug 2020 01:49:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=vdX/GltbK6AC9lvrmsjSBcxCEJYHeciHw/4RADdW77s=;
 b=cuFAjrHR5I9sZl4Z1iJgTR5Y8zF5eZi75vwq4pilOBG2HVma+rJixB6kTFzMR1/lbYM7
 6jSAbaouC2mmECFQQrm2eXufBiQYTy1UDPA3iqrQEjDYPSeO27+WAfe0xeDvKbJTLAXI
 dEQ9v3Nzljl8pi+z3f7mDAlHCk2NPgHZOMM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 32n42m05vp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2020 01:49:47 -0700
Received: from intmgw005.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 1 Aug 2020 01:49:46 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 42C0362E53CC; Sat,  1 Aug 2020 01:47:29 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@chromium.org>,
        <brouer@redhat.com>, <dlxu@fb.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 3/5] selftests/bpf: add selftest for BPF_PROG_TYPE_USER
Date:   Sat, 1 Aug 2020 01:47:19 -0700
Message-ID: <20200801084721.1812607-4-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200801084721.1812607-1-songliubraving@fb.com>
References: <20200801084721.1812607-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-01_07:2020-07-31,2020-08-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008010068
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This test checks the correctness of BPF_PROG_TYPE_USER program, including=
:
running on the right cpu, passing in correct args, returning retval, and
being able to call bpf_get_stack|stackid.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 .../selftests/bpf/prog_tests/user_prog.c      | 52 +++++++++++++++++
 tools/testing/selftests/bpf/progs/user_prog.c | 56 +++++++++++++++++++
 2 files changed, 108 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/user_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/user_prog.c

diff --git a/tools/testing/selftests/bpf/prog_tests/user_prog.c b/tools/t=
esting/selftests/bpf/prog_tests/user_prog.c
new file mode 100644
index 0000000000000..416707b3bff01
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/user_prog.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020 Facebook */
+#include <test_progs.h>
+#include "user_prog.skel.h"
+
+static int duration;
+
+void test_user_prog(void)
+{
+	struct bpf_user_prog_args args =3D {{0, 1, 2, 3, 4}};
+	struct bpf_prog_test_run_attr attr =3D {};
+	struct user_prog *skel;
+	int i, numcpu, ret;
+
+	skel =3D user_prog__open_and_load();
+
+	if (CHECK(!skel, "user_prog__open_and_load",
+		  "skeleton open_and_laod failed\n"))
+		return;
+
+	numcpu =3D libbpf_num_possible_cpus();
+
+	attr.prog_fd =3D bpf_program__fd(skel->progs.user_func);
+	attr.data_size_in =3D sizeof(args);
+	attr.data_in =3D &args;
+
+	/* start from -1, so we test cpu_plus =3D=3D 0 */
+	for (i =3D -1; i < numcpu; i++) {
+		args.args[0] =3D i + 1;
+		attr.cpu_plus =3D i + 1;
+		ret =3D bpf_prog_test_run_xattr(&attr);
+		CHECK(ret, "bpf_prog_test_run_xattr", "returns error\n");
+
+		/* skip two tests for i =3D=3D -1 */
+		if (i =3D=3D -1)
+			continue;
+		CHECK(attr.retval !=3D i + 2, "bpf_prog_test_run_xattr",
+		      "doesn't get expected retval\n");
+		CHECK(skel->data->sum !=3D 11 + i, "user_prog_args_test",
+		      "sum of args doesn't match\n");
+	}
+
+	CHECK(skel->data->cpu_match =3D=3D 0, "cpu_match_test", "failed\n");
+	CHECK(skel->bss->get_stack_success !=3D numcpu + 1, "test_bpf_get_stack=
",
+	      "failed on %d cores\n", numcpu - skel->bss->get_stack_success);
+	CHECK(skel->bss->get_stackid_success !=3D numcpu + 1,
+	      "test_bpf_get_stackid",
+	      "failed on %d cores\n",
+	      numcpu + 1 - skel->bss->get_stackid_success);
+
+	user_prog__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/user_prog.c b/tools/testin=
g/selftests/bpf/progs/user_prog.c
new file mode 100644
index 0000000000000..cf320e97f107a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/user_prog.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020 Facebook */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") =3D "GPL";
+
+#ifndef PERF_MAX_STACK_DEPTH
+#define PERF_MAX_STACK_DEPTH         127
+#endif
+
+typedef __u64 stack_trace_t[PERF_MAX_STACK_DEPTH];
+
+struct {
+	__uint(type, BPF_MAP_TYPE_STACK_TRACE);
+	__uint(max_entries, 16384);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(stack_trace_t));
+} stackmap SEC(".maps");
+
+volatile int cpu_match =3D 1;
+volatile __u64 sum =3D 1;
+volatile int get_stack_success =3D 0;
+volatile int get_stackid_success =3D 0;
+volatile __u64 stacktrace[PERF_MAX_STACK_DEPTH];
+
+SEC("user")
+int user_func(struct bpf_user_prog_ctx *ctx)
+{
+	int cpu =3D bpf_get_smp_processor_id();
+	__u32 key =3D cpu;
+	long stackid, err;
+
+	/* check the program runs on the right cpu */
+	if (ctx->args[0] && ctx->args[0] !=3D cpu + 1)
+		cpu_match =3D 0;
+
+	/* check the sum of arguments are correct */
+	sum =3D ctx->args[0] + ctx->args[1] + ctx->args[2] +
+		ctx->args[3] + ctx->args[4];
+
+	/* check bpf_get_stackid works */
+	stackid =3D bpf_get_stackid(ctx, &stackmap, 0);
+	if (stackid >=3D 0)
+		get_stackid_success++;
+
+	/* check bpf_get_stack works */
+	err =3D bpf_get_stack(ctx, (void *)stacktrace,
+			    PERF_MAX_STACK_DEPTH * sizeof(__u64),
+			    BPF_F_USER_STACK);
+	if (err >=3D 0)
+		get_stack_success++;
+
+	return cpu + 2;
+}
--=20
2.24.1


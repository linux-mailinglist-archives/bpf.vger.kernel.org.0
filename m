Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C454D23513A
	for <lists+bpf@lfdr.de>; Sat,  1 Aug 2020 10:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgHAItv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 1 Aug 2020 04:49:51 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:30770 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726364AbgHAItv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 1 Aug 2020 04:49:51 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0718mPNC022611
        for <bpf@vger.kernel.org>; Sat, 1 Aug 2020 01:49:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=5RPWFtVuXAxEQqbG8nvPzo+ekxrYzxIosVhRDbbFtRc=;
 b=TQhOkKHSxPnkUVPxz91FcLwJvwey5tZM7TUz1+PwNo+ehPKmNc1xYDZrpq1OEI1T9hyh
 s0sLm7PKtMTS1ZMEMEolruK6FEosPR6W++9wMqWCnSrFFuhUzNvP00glO2531JocY36h
 7s/cqIPeWr9Fx4PWvXvpEVHi0JQrf6FZ0LA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 32n42m05vt-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2020 01:49:50 -0700
Received: from intmgw002.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 1 Aug 2020 01:49:49 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 52B3862E53D6; Sat,  1 Aug 2020 01:47:33 -0700 (PDT)
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
Subject: [PATCH bpf-next 5/5] selftests/bpf: add benchmark for uprobe vs. user_prog
Date:   Sat, 1 Aug 2020 01:47:21 -0700
Message-ID: <20200801084721.1812607-6-songliubraving@fb.com>
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

Add a benchmark to compare performance of
  1) uprobe;
  2) user program w/o args;
  3) user program w/ args;
  4) user program w/ args on random cpu.

Sample output:

./test_progs -t uprobe_vs_user_prog -v
test_uprobe_vs_user_prog:PASS:uprobe_vs_user_prog__open_and_load 0 nsec
test_uprobe_vs_user_prog:PASS:get_base_addr 0 nsec
test_uprobe_vs_user_prog:PASS:attach_uprobe 0 nsec
run_perf_test:PASS:uprobe 0 nsec
Each uprobe uses 1419 nanoseconds
run_perf_test:PASS:user_prog_no_args 0 nsec
Each user_prog_no_args uses 313 nanoseconds
run_perf_test:PASS:user_prog_with_args 0 nsec
Each user_prog_with_args uses 335 nanoseconds
run_perf_test:PASS:user_prog_with_args_on_cpu 0 nsec
Each user_prog_with_args_on_cpu uses 2821 nanoseconds
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 .../bpf/prog_tests/uprobe_vs_user_prog.c      | 101 ++++++++++++++++++
 .../selftests/bpf/progs/uprobe_vs_user_prog.c |  21 ++++
 2 files changed, 122 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_vs_user=
_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_vs_user_prog=
.c

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_vs_user_prog.c=
 b/tools/testing/selftests/bpf/prog_tests/uprobe_vs_user_prog.c
new file mode 100644
index 0000000000000..dadd7b56e69ec
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_vs_user_prog.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "uprobe_vs_user_prog.skel.h"
+
+#define REPEAT_CNT 10000ULL
+
+static int duration;
+
+static noinline void uprobe_target(void)
+{
+	asm ("");
+}
+
+struct bpf_prog_test_run_attr attr;
+
+static void call_user_prog(void)
+{
+	bpf_prog_test_run_xattr(&attr);
+}
+
+static int numcpu;
+
+static void call_user_prog_on_cpu(void)
+{
+	static int cpu =3D 0;
+
+	attr.cpu_plus =3D cpu + 1;
+	bpf_prog_test_run_xattr(&attr);
+	cpu =3D (cpu + 1) % numcpu;
+}
+
+typedef void (__run_func)(void);
+
+static void run_perf_test(struct uprobe_vs_user_prog *skel,
+			  __run_func func, const char *name)
+{
+	__u64 start_time, total_time;
+	int i;
+
+	skel->bss->sum =3D 0;
+
+	start_time =3D time_get_ns();
+	for (i =3D 0; i < REPEAT_CNT; i++)
+		func();
+	total_time =3D time_get_ns() - start_time;
+
+	CHECK(skel->bss->sum !=3D REPEAT_CNT, name,
+	      "missed %llu times\n", REPEAT_CNT - skel->bss->sum);
+	printf("Each %s uses %llu nanoseconds\n", name, total_time / REPEAT_CNT=
);
+}
+
+void test_uprobe_vs_user_prog(void)
+{
+	struct bpf_user_prog_args args =3D {};
+	struct uprobe_vs_user_prog *skel;
+	struct bpf_link *uprobe_link;
+	size_t uprobe_offset;
+	ssize_t base_addr;
+
+	skel =3D uprobe_vs_user_prog__open_and_load();
+
+	if (CHECK(!skel, "uprobe_vs_user_prog__open_and_load",
+		  "skeleton open_and_laod failed\n"))
+		return;
+
+	base_addr =3D get_base_addr();
+	if (CHECK(base_addr < 0, "get_base_addr",
+		  "failed to find base addr: %zd", base_addr))
+		return;
+	uprobe_offset =3D (size_t)&uprobe_target - base_addr;
+	uprobe_link =3D bpf_program__attach_uprobe(skel->progs.handle_uprobe,
+						 false /* retprobe */,
+						 0 /* self pid */,
+						 "/proc/self/exe",
+						 uprobe_offset);
+
+	if (CHECK(IS_ERR(uprobe_link), "attach_uprobe",
+		  "err %ld\n", PTR_ERR(uprobe_link)))
+		goto cleanup;
+	skel->links.handle_uprobe =3D uprobe_link;
+
+	run_perf_test(skel, uprobe_target, "uprobe");
+
+	attr.prog_fd =3D bpf_program__fd(skel->progs.user_prog);
+	run_perf_test(skel, call_user_prog, "user_prog_no_args");
+
+	attr.data_size_in =3D sizeof(args);
+	attr.data_in =3D &args;
+	run_perf_test(skel, call_user_prog, "user_prog_with_args");
+
+	numcpu =3D libbpf_num_possible_cpus();
+
+	if (numcpu <=3D 0)
+		goto cleanup;
+
+	run_perf_test(skel, call_user_prog_on_cpu,
+		      "user_prog_with_args_on_cpu");
+
+cleanup:
+	uprobe_vs_user_prog__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/uprobe_vs_user_prog.c b/to=
ols/testing/selftests/bpf/progs/uprobe_vs_user_prog.c
new file mode 100644
index 0000000000000..8b327b7cee30d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uprobe_vs_user_prog.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2017 Facebook
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+volatile __u64 sum =3D 0;
+
+SEC("uprobe/func")
+int handle_uprobe(struct pt_regs *ctx)
+{
+	sum++;
+	return 0;
+}
+
+SEC("user")
+int user_prog(struct pt_regs *ctx)
+{
+	sum++;
+	return 0;
+}
--=20
2.24.1


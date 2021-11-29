Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019684625C1
	for <lists+bpf@lfdr.de>; Mon, 29 Nov 2021 23:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbhK2WnO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Nov 2021 17:43:14 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:23704 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234440AbhK2Wmc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 29 Nov 2021 17:42:32 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATIl9Hg028187
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 14:39:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=dpXhiDBTwKVQTfgQ2Q52Vxe4Z5Ecxc3KRtOR39SbR4o=;
 b=U97aBJZDcEG/ZABgFVg0gs4CZD+aWa9wvLaRd0Gj3I4MsTkvEsNcXYlEC9/S+k2E+h1K
 wX/Q9PHWX5VPNCkiQ+y8ZEaxNRITAMsc9sj7rDpbW88KoxfkZje8NDLfT0MV0MdcU7Nv
 H2c96p6qkLXg9zu1nS3vJFcNfLu2YpIGerw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cn1as37dx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 14:39:14 -0800
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 14:39:12 -0800
Received: by devbig612.frc2.facebook.com (Postfix, from userid 115148)
        id 45A49570A527; Mon, 29 Nov 2021 14:39:00 -0800 (PST)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <Kernel-team@fb.com>, Joanne Koong <joannekoong@fb.com>
Subject: [PATCH v3 bpf-next 2/4] selftests/bpf: Add bpf_loop test
Date:   Mon, 29 Nov 2021 14:37:23 -0800
Message-ID: <20211129223725.2770730-3-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211129223725.2770730-1-joannekoong@fb.com>
References: <20211129223725.2770730-1-joannekoong@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: TXQtRA7PUAPuvdbYL7wK5tO5fJu-7M-g
X-Proofpoint-ORIG-GUID: TXQtRA7PUAPuvdbYL7wK5tO5fJu-7M-g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-29_11,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 spamscore=0 phishscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 mlxlogscore=898 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111290106
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add test for bpf_loop testing a variety of cases:
various nr_loops, null callback ctx, invalid flags, nested callbacks.

Signed-off-by: Joanne Koong <joannekoong@fb.com>
---
 .../selftests/bpf/prog_tests/bpf_loop.c       | 138 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_loop.c  |  99 +++++++++++++
 2 files changed, 237 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_loop.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_loop.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_loop.c b/tools/te=
sting/selftests/bpf/prog_tests/bpf_loop.c
new file mode 100644
index 000000000000..31b8e7715f07
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_loop.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+
+#include <test_progs.h>
+#include <network_helpers.h>
+#include "bpf_loop.skel.h"
+
+static void check_nr_loops(struct bpf_loop *skel)
+{
+	__u32 retval, duration;
+	int err;
+
+	/* test 0 loops */
+	skel->bss->nr_loops =3D 0;
+	err =3D bpf_prog_test_run(bpf_program__fd(skel->progs.test_prog),
+				1, &pkt_v4, sizeof(pkt_v4), NULL, NULL,
+				&retval, &duration);
+	if (!ASSERT_OK(err, "err") || !ASSERT_OK(retval, "retval"))
+		return;
+	ASSERT_EQ(skel->bss->nr_loops_returned, skel->bss->nr_loops,
+		  "0 loops");
+
+	/* test 500 loops */
+	skel->bss->nr_loops =3D 500;
+	err =3D bpf_prog_test_run(bpf_program__fd(skel->progs.test_prog),
+				1, &pkt_v4, sizeof(pkt_v4), NULL, NULL,
+				&retval, &duration);
+	if (!ASSERT_OK(err, "err") ||
+	    !ASSERT_OK(retval, "retval"))
+		return;
+	ASSERT_EQ(skel->bss->nr_loops_returned, skel->bss->nr_loops,
+		  "500 loops");
+	ASSERT_EQ(skel->bss->g_output, (500 * 499) / 2, "g_output");
+
+	/* test exceeding the max limit */
+	skel->bss->nr_loops =3D -1;
+	err =3D bpf_prog_test_run(bpf_program__fd(skel->progs.test_prog),
+				1, &pkt_v4, sizeof(pkt_v4), NULL, NULL,
+				&retval, &duration);
+	if (!ASSERT_OK(err, "err") || !ASSERT_OK(retval, "retval"))
+		return;
+	ASSERT_EQ(skel->bss->err, -E2BIG, "over max limit");
+}
+
+static void check_callback_fn_stop(struct bpf_loop *skel)
+{
+	__u32 retval, duration;
+	int err;
+
+	skel->bss->nr_loops =3D 400;
+	skel->data->stop_index =3D 50;
+
+	/* testing that loop is stopped when callback_fn returns 1 */
+	err =3D bpf_prog_test_run(bpf_program__fd(skel->progs.test_prog),
+				1, &pkt_v4, sizeof(pkt_v4), NULL, NULL,
+				&retval, &duration);
+
+	if (!ASSERT_OK(err, "err") || !ASSERT_OK(retval, "retval"))
+		return;
+
+	ASSERT_EQ(skel->bss->nr_loops_returned, skel->data->stop_index + 1,
+		  "nr_loops_returned");
+	ASSERT_EQ(skel->bss->g_output, (50 * 49) / 2,
+		  "g_output");
+}
+
+static void check_null_callback_ctx(struct bpf_loop *skel)
+{
+	__u32 retval, duration;
+	int err;
+
+	skel->bss->nr_loops =3D 10;
+
+	/* check that user is able to pass in a null callback_ctx */
+	err =3D bpf_prog_test_run(bpf_program__fd(skel->progs.prog_null_ctx),
+				1, &pkt_v4, sizeof(pkt_v4), NULL, NULL,
+				&retval, &duration);
+
+	if (!ASSERT_OK(err, "err") || !ASSERT_OK(retval, "retval"))
+		return;
+
+	ASSERT_EQ(skel->bss->nr_loops_returned, skel->bss->nr_loops,
+		  "nr_loops_returned");
+}
+
+static void check_invalid_flags(struct bpf_loop *skel)
+{
+	__u32 retval, duration;
+	int err;
+
+	/* check that passing in non-zero flags returns -EINVAL */
+	err =3D bpf_prog_test_run(bpf_program__fd(skel->progs.prog_invalid_flag=
s),
+				1, &pkt_v4, sizeof(pkt_v4), NULL, NULL,
+				&retval, &duration);
+
+	if (!ASSERT_OK(err, "err") || !ASSERT_OK(retval, "retval"))
+		return;
+
+	ASSERT_EQ(skel->bss->err, -EINVAL, "err");
+}
+
+static void check_nested_calls(struct bpf_loop *skel)
+{
+	__u32 nr_loops =3D 100, nested_callback_nr_loops =3D 4;
+	__u32 retval, duration;
+	int err;
+
+	skel->bss->nr_loops =3D nr_loops;
+	skel->bss->nested_callback_nr_loops =3D nested_callback_nr_loops;
+
+	/* check that nested calls are supported */
+	err =3D bpf_prog_test_run(bpf_program__fd(skel->progs.prog_nested_calls=
),
+				1, &pkt_v4, sizeof(pkt_v4), NULL, NULL,
+				&retval, &duration);
+	if (!ASSERT_OK(err, "err") || !ASSERT_OK(retval, "retval"))
+		return;
+	ASSERT_EQ(skel->bss->nr_loops_returned, nr_loops * nested_callback_nr_l=
oops
+		  * nested_callback_nr_loops, "nr_loops_returned");
+	ASSERT_EQ(skel->bss->g_output, (4 * 3) / 2 * nested_callback_nr_loops
+		* nr_loops, "g_output");
+}
+
+void test_bpf_loop(void)
+{
+	struct bpf_loop *skel;
+
+	skel =3D bpf_loop__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "bpf_loop__open_and_load"))
+		return;
+
+	check_nr_loops(skel);
+	check_callback_fn_stop(skel);
+	check_null_callback_ctx(skel);
+	check_invalid_flags(skel);
+	check_nested_calls(skel);
+
+	bpf_loop__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_loop.c b/tools/testing=
/selftests/bpf/progs/bpf_loop.c
new file mode 100644
index 000000000000..f5437792fe0f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_loop.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") =3D "GPL";
+
+struct callback_ctx {
+	int output;
+};
+
+/* These should be set by the user program */
+u32 nested_callback_nr_loops;
+u32 stop_index =3D -1;
+u32 nr_loops;
+
+/* Making these global variables so that the userspace program
+ * can verify the output through the skeleton
+ */
+int nr_loops_returned;
+int g_output;
+int err;
+
+static int callback(__u32 index, void *data)
+{
+	struct callback_ctx *ctx =3D data;
+
+	if (index >=3D stop_index)
+		return 1;
+
+	ctx->output +=3D index;
+
+	return 0;
+}
+
+static int empty_callback(__u32 index, void *data)
+{
+	return 0;
+}
+
+static int nested_callback2(__u32 index, void *data)
+{
+	nr_loops_returned +=3D bpf_loop(nested_callback_nr_loops, callback, dat=
a, 0);
+
+	return 0;
+}
+
+static int nested_callback1(__u32 index, void *data)
+{
+	bpf_loop(nested_callback_nr_loops, nested_callback2, data, 0);
+	return 0;
+}
+
+SEC("tc")
+int test_prog(struct __sk_buff *skb)
+{
+	struct callback_ctx data =3D {};
+
+	nr_loops_returned =3D bpf_loop(nr_loops, callback, &data, 0);
+
+	if (nr_loops_returned < 0)
+		err =3D nr_loops_returned;
+	else
+		g_output =3D data.output;
+
+	return 0;
+}
+
+SEC("tc")
+int prog_null_ctx(struct __sk_buff *skb)
+{
+	nr_loops_returned =3D bpf_loop(nr_loops, empty_callback, NULL, 0);
+
+	return 0;
+}
+
+SEC("tc")
+int prog_invalid_flags(struct __sk_buff *skb)
+{
+	struct callback_ctx data =3D {};
+
+	err =3D bpf_loop(nr_loops, callback, &data, 1);
+
+	return 0;
+}
+
+SEC("tc")
+int prog_nested_calls(struct __sk_buff *skb)
+{
+	struct callback_ctx data =3D {};
+
+	nr_loops_returned =3D 0;
+	bpf_loop(nr_loops, nested_callback1, &data, 0);
+
+	g_output =3D data.output;
+
+	return 0;
+}
--=20
2.30.2


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CB62047EA
	for <lists+bpf@lfdr.de>; Tue, 23 Jun 2020 05:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731840AbgFWDWk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Jun 2020 23:22:40 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:7402 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731706AbgFWDWi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Jun 2020 23:22:38 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05N3Fsee025247
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 20:22:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=ZpEDl2NIvGpkVQHt7+lFerx0/kyQgLn41ftY32EjoZ4=;
 b=XzbcaepVnSrMP6bK1eJNbrGHH9qfTAkcVVBF75W+apYoa62GVKbIoItn53aQ/OZBGbJJ
 4xmfway/MBlIy7Rv5+zeyZXPcQo+m3l2Woqx2/5WeeAE+P91dXmxvcp+L46tpw0aKK/q
 BAjhcEtleheTX7/CDDklgVOtrIicxWI0qQM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31t2a2gx9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 20:22:38 -0700
Received: from intmgw003.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 22 Jun 2020 20:22:36 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 768262EC33D1; Mon, 22 Jun 2020 20:22:27 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>, <john.fastabend@gmail.com>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v3 bpf-next 2/3] selftests/bpf: add variable-length data concatenation pattern test
Date:   Mon, 22 Jun 2020 20:22:22 -0700
Message-ID: <20200623032224.4020118-2-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200623032224.4020118-1-andriin@fb.com>
References: <20200623032224.4020118-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_16:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 cotscore=-2147483648 mlxscore=0
 impostorscore=0 suspectscore=8 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006230024
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add selftest that validates variable-length data reading and concatentati=
on
with one big shared data array. This is a common pattern in production us=
e for
monitoring and tracing applications, that potentially can read a lot of d=
ata,
but overall read much less. Such pattern allows to determine precisely wh=
at
amount of data needs to be sent over perfbuf/ringbuf and maximize efficie=
ncy.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 .../testing/selftests/bpf/prog_tests/varlen.c | 56 +++++++++++
 .../testing/selftests/bpf/progs/test_varlen.c | 96 +++++++++++++++++++
 2 files changed, 152 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/varlen.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_varlen.c

diff --git a/tools/testing/selftests/bpf/prog_tests/varlen.c b/tools/test=
ing/selftests/bpf/prog_tests/varlen.c
new file mode 100644
index 000000000000..7533565e096d
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/varlen.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020 Facebook */
+
+#include <test_progs.h>
+#include <time.h>
+#include "test_varlen.skel.h"
+
+#define CHECK_VAL(got, exp) \
+	CHECK((got) !=3D (exp), "check", "got %ld !=3D exp %ld\n", \
+	      (long)(got), (long)(exp))
+
+void test_varlen(void)
+{
+	int duration =3D 0, err;
+	struct test_varlen* skel;
+	struct test_varlen__bss *bss;
+	struct test_varlen__data *data;
+	const char str1[] =3D "Hello, ";
+	const char str2[] =3D "World!";
+	const char exp_str[] =3D "Hello, \0World!\0";
+	const int size1 =3D sizeof(str1);
+	const int size2 =3D sizeof(str2);
+
+	skel =3D test_varlen__open_and_load();
+	if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
+		return;
+	bss =3D skel->bss;
+	data =3D skel->data;
+
+	err =3D test_varlen__attach(skel);
+	if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
+		goto cleanup;
+
+	bss->test_pid =3D getpid();
+
+	/* trigger everything */
+	memcpy(bss->buf_in1, str1, size1);
+	memcpy(bss->buf_in2, str2, size2);
+	bss->capture =3D true;
+	usleep(1);
+	bss->capture =3D false;
+
+	CHECK_VAL(bss->payload1_len1, size1);
+	CHECK_VAL(bss->payload1_len2, size2);
+	CHECK_VAL(bss->total1, size1 + size2);
+	CHECK(memcmp(bss->payload1, exp_str, size1 + size2), "content_check",
+	      "doesn't match!");
+
+	CHECK_VAL(data->payload2_len1, size1);
+	CHECK_VAL(data->payload2_len2, size2);
+	CHECK_VAL(data->total2, size1 + size2);
+	CHECK(memcmp(data->payload2, exp_str, size1 + size2), "content_check",
+	      "doesn't match!");
+cleanup:
+	test_varlen__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_varlen.c b/tools/test=
ing/selftests/bpf/progs/test_varlen.c
new file mode 100644
index 000000000000..09691852debf
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_varlen.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020 Facebook */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+#define MAX_LEN 256
+
+char buf_in1[MAX_LEN] =3D {};
+char buf_in2[MAX_LEN] =3D {};
+
+int test_pid =3D 0;
+bool capture =3D false;
+
+/* .bss */
+long payload1_len1 =3D 0;
+long payload1_len2 =3D 0;
+long total1 =3D 0;
+char payload1[MAX_LEN + MAX_LEN] =3D {};
+
+/* .data */
+int payload2_len1 =3D -1;
+int payload2_len2 =3D -1;
+int total2 =3D -1;
+char payload2[MAX_LEN + MAX_LEN] =3D { 1 };
+
+SEC("raw_tp/sys_enter")
+int handler64(void *regs)
+{
+	int pid =3D bpf_get_current_pid_tgid() >> 32;
+	void *payload =3D payload1;
+	u64 len;
+
+	/* ignore irrelevant invocations */
+	if (test_pid !=3D pid || !capture)
+		return 0;
+
+	len =3D bpf_probe_read_kernel_str(payload, MAX_LEN, &buf_in1[0]);
+	if (len <=3D MAX_LEN) {
+		payload +=3D len;
+		payload1_len1 =3D len;
+	}
+
+	len =3D bpf_probe_read_kernel_str(payload, MAX_LEN, &buf_in2[0]);
+	if (len <=3D MAX_LEN) {
+		payload +=3D len;
+		payload1_len2 =3D len;
+	}
+
+	total1 =3D payload - (void *)payload1;
+
+	return 0;
+}
+
+SEC("tp_btf/sys_enter")
+int handler32(void *regs)
+{
+	int pid =3D bpf_get_current_pid_tgid() >> 32;
+	void *payload =3D payload2;
+	u32 len;
+
+	/* ignore irrelevant invocations */
+	if (test_pid !=3D pid || !capture)
+		return 0;
+
+	len =3D bpf_probe_read_kernel_str(payload, MAX_LEN, &buf_in1[0]);
+	if (len <=3D MAX_LEN) {
+		payload +=3D len;
+		payload2_len1 =3D len;
+	}
+
+	len =3D bpf_probe_read_kernel_str(payload, MAX_LEN, &buf_in2[0]);
+	if (len <=3D MAX_LEN) {
+		payload +=3D len;
+		payload2_len2 =3D len;
+	}
+
+	total2 =3D payload - (void *)payload2;
+
+	return 0;
+}
+
+SEC("tp_btf/sys_exit")
+int handler_exit(void *regs)
+{
+	long bla;
+
+	if (bpf_probe_read_kernel(&bla, sizeof(bla), 0))
+		return 1;
+	else
+		return 0;
+}
+
+char LICENSE[] SEC("license") =3D "GPL";
--=20
2.24.1


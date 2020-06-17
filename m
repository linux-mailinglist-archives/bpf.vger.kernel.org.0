Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316A61FD1DE
	for <lists+bpf@lfdr.de>; Wed, 17 Jun 2020 18:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgFQQVj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Jun 2020 12:21:39 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50344 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726835AbgFQQVi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Jun 2020 12:21:38 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05HGJ97b001167
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2020 09:21:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=6ENgc7mV1pjTqzJvZLO+o3HnsiY+Qwqtmd6iQKDqhS4=;
 b=L3vLhU8MY6otZSW93ScYGhYHBP7nty0e9tMIZt4HTUJ5P3hlsSTkLf3jaEGm+5ZIfgam
 Ck1pzp443hEjHv979CBkx2BH/smj1YI8hi3RoE0kikrCav2Gz945N2wxKexJrzGSkCVg
 GD5Qk1PkE2vcrNu5ZEOlIhF0+TcW4gkwAUQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31q8u6cqy2-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2020 09:21:38 -0700
Received: from intmgw003.03.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 17 Jun 2020 09:21:37 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 5A95D2EC35FD; Wed, 17 Jun 2020 09:19:01 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Quentin Monnet <quentin@isovalent.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 3/9] selftests/bpf: add __ksym extern selftest
Date:   Wed, 17 Jun 2020 09:18:26 -0700
Message-ID: <20200617161832.1438371-4-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200617161832.1438371-1-andriin@fb.com>
References: <20200617161832.1438371-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-17_06:2020-06-17,2020-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 cotscore=-2147483648 malwarescore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=881 mlxscore=0 suspectscore=8 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006170129
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Validate libbpf is able to handle weak and strong kernel symbol externs i=
n BPF
code correctly.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 .../testing/selftests/bpf/prog_tests/ksyms.c  | 71 +++++++++++++++++++
 .../testing/selftests/bpf/progs/test_ksyms.c  | 32 +++++++++
 2 files changed, 103 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ksyms.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_ksyms.c

diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms.c b/tools/testi=
ng/selftests/bpf/prog_tests/ksyms.c
new file mode 100644
index 000000000000..e3d6777226a8
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/ksyms.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2019 Facebook */
+
+#include <test_progs.h>
+#include "test_ksyms.skel.h"
+#include <sys/stat.h>
+
+static int duration;
+
+static __u64 kallsyms_find(const char *sym)
+{
+	char type, name[500];
+	__u64 addr, res =3D 0;
+	FILE *f;
+
+	f =3D fopen("/proc/kallsyms", "r");
+	if (CHECK(!f, "kallsyms_fopen", "failed to open: %d\n", errno))
+		return 0;
+
+	while (fscanf(f, "%llx %c %499s%*[^\n]\n", &addr, &type, name) > 0) {
+		if (strcmp(name, sym) =3D=3D 0) {
+			res =3D addr;
+			goto out;
+		}
+	}
+
+	CHECK(false, "not_found", "symbol %s not found\n", sym);
+out:
+	fclose(f);
+	return res;
+}
+
+void test_ksyms(void)
+{
+	__u64 link_fops_addr =3D kallsyms_find("bpf_link_fops");
+	const char *btf_path =3D "/sys/kernel/btf/vmlinux";
+	struct test_ksyms *skel;
+	struct test_ksyms__data *data;
+	struct stat st;
+	__u64 btf_size;
+	int err;
+
+	if (CHECK(stat(btf_path, &st), "stat_btf", "err %d\n", errno))
+		return;
+	btf_size =3D st.st_size;
+
+	skel =3D test_ksyms__open_and_load();
+	if (CHECK(!skel, "skel_open", "failed to open and load skeleton\n"))
+		return;
+
+	err =3D test_ksyms__attach(skel);
+	if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
+		goto cleanup;
+
+	/* trigger tracepoint */
+	usleep(1);
+
+	data =3D skel->data;
+	CHECK(data->out__bpf_link_fops !=3D link_fops_addr, "bpf_link_fops",
+	      "got 0x%llx, exp 0x%llx\n",
+	      data->out__bpf_link_fops, link_fops_addr);
+	CHECK(data->out__bpf_link_fops1 !=3D 0, "bpf_link_fops1",
+	      "got %llu, exp %llu\n", data->out__bpf_link_fops1, (__u64)0);
+	CHECK(data->out__btf_size !=3D btf_size, "btf_size",
+	      "got %llu, exp %llu\n", data->out__btf_size, btf_size);
+	CHECK(data->out__per_cpu_start !=3D 0, "__per_cpu_start",
+	      "got %llu, exp %llu\n", data->out__per_cpu_start, (__u64)0);
+
+cleanup:
+	test_ksyms__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_ksyms.c b/tools/testi=
ng/selftests/bpf/progs/test_ksyms.c
new file mode 100644
index 000000000000..6c9cbb5a3bdf
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_ksyms.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2019 Facebook */
+
+#include <stdbool.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+__u64 out__bpf_link_fops =3D -1;
+__u64 out__bpf_link_fops1 =3D -1;
+__u64 out__btf_size =3D -1;
+__u64 out__per_cpu_start =3D -1;
+
+extern const void bpf_link_fops __ksym;
+extern const void __start_BTF __ksym;
+extern const void __stop_BTF __ksym;
+extern const void __per_cpu_start __ksym;
+/* non-existing symbol, weak, default to zero */
+extern const void bpf_link_fops1 __ksym __weak;
+
+SEC("raw_tp/sys_enter")
+int handler(const void *ctx)
+{
+	out__bpf_link_fops =3D (__u64)&bpf_link_fops;
+	out__btf_size =3D (__u64)(&__stop_BTF - &__start_BTF);
+	out__per_cpu_start =3D (__u64)&__per_cpu_start;
+
+	out__bpf_link_fops1 =3D (__u64)&bpf_link_fops1;
+
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.24.1


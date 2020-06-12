Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3B61F7EEC
	for <lists+bpf@lfdr.de>; Sat, 13 Jun 2020 00:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgFLWep (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Jun 2020 18:34:45 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47214 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726302AbgFLWep (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 12 Jun 2020 18:34:45 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05CM6MgC025615
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2020 15:34:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=cNRfGcbMbBf94VQ5FUSapjaaDr7Mz+2SNVUjQz4+BWc=;
 b=nAIMYR6Zx6d+Td3Q4Po0oUY0ZTBc7FNs7KNk/+cNc3wdSOzI6o5blA2tnhKy1iQR3o7u
 ePxXByqElpmg0/3PWPc4N/hpSTriJoHfOYQzYrfpKTLdjD7SCF+j2CUAaKLWqrrnTAn6
 WbK0Qi74zvCzSeM1K/ZV+xQ20t31X/qx2Fw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31kqwwy6j5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2020 15:34:44 -0700
Received: from intmgw003.08.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 12 Jun 2020 15:34:41 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id B9D912EC1D14; Fri, 12 Jun 2020 15:32:04 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next 3/8] selftests/bpf: add __ksym extern selftest
Date:   Fri, 12 Jun 2020 15:31:45 -0700
Message-ID: <20200612223150.1177182-4-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200612223150.1177182-1-andriin@fb.com>
References: <20200612223150.1177182-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-12_17:2020-06-12,2020-06-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=859 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 suspectscore=8 cotscore=-2147483648
 adultscore=0 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006120164
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
index 000000000000..8f041c9059ed
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
+	char type, name[256];
+	unsigned long addr, res =3D 0;
+	FILE *f;
+
+	f =3D fopen("/proc/kallsyms", "r");
+	if (CHECK(!f, "kallsyms_fopen", "failed to open: %d\n", errno))
+		return 0;
+
+	while (fscanf(f, "%lx %c %s%*[^\n]\n", &addr, &type, name) > 0) {
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
+	CHECK(data->out__fixed_percpu_data !=3D 0, "fixed_percpu_data",
+	      "got %llu, exp %llu\n", data->out__fixed_percpu_data, (__u64)0);
+
+cleanup:
+	test_ksyms__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_ksyms.c b/tools/testi=
ng/selftests/bpf/progs/test_ksyms.c
new file mode 100644
index 000000000000..598d6749b691
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
+__u64 out__fixed_percpu_data =3D -1;
+
+extern const void bpf_link_fops __ksym;
+/* non-existing symbol, weak, default to zero */
+extern const void bpf_link_fops1 __ksym __weak;
+extern const void __start_BTF __ksym;
+extern const void __stop_BTF __ksym;
+/* fixed_percpu_data is always at zero offset */
+extern const void fixed_percpu_data __ksym;
+
+SEC("raw_tp/sys_enter")
+int handler(const void *ctx)
+{
+	out__bpf_link_fops =3D (__u64)&bpf_link_fops;
+	out__bpf_link_fops1 =3D (__u64)&bpf_link_fops1;
+	out__btf_size =3D (__u64)(&__stop_BTF - &__start_BTF);
+	out__fixed_percpu_data =3D (__u64)&fixed_percpu_data;
+
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.24.1


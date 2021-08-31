Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C0C3FCFB1
	for <lists+bpf@lfdr.de>; Wed,  1 Sep 2021 00:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240924AbhHaWv2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Aug 2021 18:51:28 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:63390 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240987AbhHaWv1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 31 Aug 2021 18:51:27 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17VMjxaO001854
        for <bpf@vger.kernel.org>; Tue, 31 Aug 2021 15:50:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=yHMj+I5aFnUugFv+L2waOjCHqcx7gWMFNCgaF09hql0=;
 b=grm1iXbFO1t0FoyLFXq4SzpNWEk83QR2wm4o64PwbD0o1UUAg9VENu/O19J/aWYwLh0j
 +js7Rm8NJxjeSSttpXbwCpXuVALYpDVGznoYr+I9G8+11Qa/VlgZ6YPM/NXp8vvYI5qA
 cE4Hu1IJZ7XHa6qeJXJo1/drmkYgtCZbZm4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3asrgut4ja-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 31 Aug 2021 15:50:32 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 31 Aug 2021 15:50:29 -0700
Received: by devbig612.frc2.facebook.com (Postfix, from userid 115148)
        id A65E21C88BD1; Tue, 31 Aug 2021 15:50:26 -0700 (PDT)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Joanne Koong <joannekoong@fb.com>
Subject: [PATCH bpf-next 3/5] selftests/bpf: Add bloom filter map test cases
Date:   Tue, 31 Aug 2021 15:50:03 -0700
Message-ID: <20210831225005.2762202-4-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210831225005.2762202-1-joannekoong@fb.com>
References: <20210831225005.2762202-1-joannekoong@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: SssWWrKMRB5rKn8IbyP0NTWuB7KEG0qw
X-Proofpoint-ORIG-GUID: SssWWrKMRB5rKn8IbyP0NTWuB7KEG0qw
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-31_09:2021-08-31,2021-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108310124
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds test cases for bpf bloom filter maps. They
include tests for invalid operations by the userspace, checks
against false-negatives, and a bpf program that queries the
bloom filter map for values added by the userspace.

Signed-off-by: Joanne Koong <joannekoong@fb.com>
---
 .../bpf/prog_tests/bloom_filter_map.c         | 123 ++++++++++++++++++
 .../selftests/bpf/progs/bloom_filter_map.c    |  49 +++++++
 2 files changed, 172 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bloom_filter_m=
ap.c
 create mode 100644 tools/testing/selftests/bpf/progs/bloom_filter_map.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c b/=
tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
new file mode 100644
index 000000000000..6b41a8cfec6c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+
+#include <sys/syscall.h>
+#include <test_progs.h>
+#include "bloom_filter_map.skel.h"
+
+static void test_bloom_filter_map_fail(void)
+{
+	struct bpf_create_map_attr xattr =3D {
+		.name =3D "bloom_filter_map",
+		.map_type =3D BPF_MAP_TYPE_BLOOM_FILTER,
+		.max_entries =3D 100,
+		.value_size =3D sizeof(__u32),
+		.nr_hashes =3D 3,
+	};
+	__u32 value;
+	int fd, err;
+
+	/* Invalid key size */
+	xattr.key_size =3D 4;
+	fd =3D bpf_create_map_xattr(&xattr);
+	if (!ASSERT_LT(fd, 0, "bpf_create_map bloom filter invalid key size"))
+		close(fd);
+	xattr.key_size =3D 0;
+
+	/* Invalid value size */
+	xattr.value_size =3D 0;
+	fd =3D bpf_create_map_xattr(&xattr);
+	if (!ASSERT_LT(fd, 0, "bpf_create_map bloom filter invalid value size")=
)
+		close(fd);
+	xattr.value_size =3D sizeof(__u32);
+
+	/* Invalid max entries size */
+	xattr.max_entries =3D 0;
+	fd =3D bpf_create_map_xattr(&xattr);
+	if (!ASSERT_LT(fd, 0, "bpf_create_map bloom filter invalid max entries =
size"))
+		close(fd);
+	xattr.max_entries =3D 100;
+
+	/* Invalid number of hashes */
+	xattr.nr_hashes =3D 0;
+	fd =3D bpf_create_map_xattr(&xattr);
+	if (!ASSERT_LT(fd, 0, "bpf_create_map bloom filter invalid number of ha=
shes"))
+		close(fd);
+	xattr.nr_hashes =3D 3;
+
+	/* Bloom filter maps do not support BPF_F_NO_PREALLOC */
+	xattr.map_flags =3D BPF_F_NO_PREALLOC;
+	fd =3D bpf_create_map_xattr(&xattr);
+	if (!ASSERT_LT(fd, 0, "bpf_create_map bloom filter invalid flags"))
+		close(fd);
+	xattr.map_flags =3D 0;
+
+	fd =3D bpf_create_map_xattr(&xattr);
+	if (!ASSERT_GE(fd, 0, "bpf_create_map bloom filter"))
+		return;
+
+	/* Test invalid flags */
+	err =3D bpf_map_update_elem(fd, NULL, &value, -1);
+	ASSERT_EQ(err, -EINVAL, "bpf_map_update_elem bloom filter invalid flags=
");
+
+	err =3D bpf_map_update_elem(fd, NULL, &value, BPF_EXIST);
+	ASSERT_EQ(err, -EINVAL, "bpf_map_update_elem bloom filter invalid flags=
");
+
+	err =3D bpf_map_update_elem(fd, NULL, &value, BPF_F_LOCK);
+	ASSERT_EQ(err, -EINVAL, "bpf_map_update_elem bloom filter invalid flags=
");
+
+	err =3D bpf_map_update_elem(fd, NULL, &value, BPF_NOEXIST);
+	ASSERT_EQ(err, -EINVAL, "bpf_map_update_elem bloom filter invalid flags=
");
+
+	err =3D bpf_map_update_elem(fd, NULL, &value, 10000);
+	ASSERT_EQ(err, -EINVAL, "bpf_map_update_elem bloom filter invalid flags=
");
+
+	close(fd);
+}
+
+static void bloom_filter_map(struct bloom_filter_map *skel)
+{
+	const int map_size =3D bpf_map__max_entries(skel->maps.map_random_data)=
;
+	int err, map_random_data_fd, map_bloom_filter_fd, i;
+	__u64 val;
+
+	map_random_data_fd =3D bpf_map__fd(skel->maps.map_random_data);
+	map_bloom_filter_fd =3D bpf_map__fd(skel->maps.map_bloom_filter);
+
+	/* Generate random values and add them to the maps */
+	for (i =3D 0; i < map_size; i++) {
+		val =3D rand();
+		err =3D bpf_map_update_elem(map_random_data_fd, &i, &val, BPF_ANY);
+		if (!ASSERT_OK(err, "Add random value to map_random_data"))
+			continue;
+
+		err =3D bpf_map_update_elem(map_bloom_filter_fd, NULL, &val, 0);
+		if (!ASSERT_OK(err, "Add random value to map_bloom_filter"))
+			return;
+	}
+
+	skel->links.prog_bloom_filter =3D
+		bpf_program__attach_trace(skel->progs.prog_bloom_filter);
+	if (!ASSERT_OK_PTR(skel->links.prog_bloom_filter, "link"))
+		return;
+
+	syscall(SYS_getpgid);
+
+	ASSERT_EQ(skel->bss->error, 0, "error");
+}
+
+void test_bloom_filter_map(void)
+{
+	struct bloom_filter_map *skel;
+
+	test_bloom_filter_map_fail();
+
+	skel =3D bloom_filter_map__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "bloom_filter_map__open_and_load"))
+		goto cleanup;
+
+	bloom_filter_map(skel);
+
+cleanup:
+	bloom_filter_map__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/bloom_filter_map.c b/tools=
/testing/selftests/bpf/progs/bloom_filter_map.c
new file mode 100644
index 000000000000..2d9c43a30246
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bloom_filter_map.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-3.0
+/* Copyright (c) 2021 Facebook */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") =3D "GPL";
+
+struct bpf_map;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1000);
+	__type(key, __u32);
+	__type(value, __u64);
+} map_random_data SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_BLOOM_FILTER);
+	__uint(key_size, 0);
+	__uint(value_size, sizeof(__u64));
+	__uint(max_entries, 1000);
+	__uint(nr_hashes, 2);
+} map_bloom_filter SEC(".maps");
+
+int error =3D 0;
+
+static __u64
+check_elem(struct bpf_map *map, __u32 *key, __u64 *val,
+	   void *data)
+{
+	int err;
+
+	err =3D bpf_map_peek_elem(&map_bloom_filter, val);
+	if (err) {
+		error |=3D 1;
+		return 1; /* stop the iteration */
+	}
+
+	return 0;
+}
+
+SEC("fentry/__x64_sys_getpgid")
+int prog_bloom_filter(void *ctx)
+{
+	bpf_for_each_map_elem(&map_random_data, check_elem, NULL, 0);
+
+	return 0;
+}
--=20
2.30.2


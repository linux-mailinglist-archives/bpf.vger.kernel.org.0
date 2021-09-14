Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9CE040A523
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 06:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhINEKi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 00:10:38 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53412 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229567AbhINEKg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Sep 2021 00:10:36 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18E33Fkg006334
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 21:09:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=pfl1NBJ3i0oELy/+pdOfpfXBHfMF7ImKLbhsZc81xbY=;
 b=AC8gUGHdWBCwUdRDvDBqGKWnNigACAPFbpd6QeO84YoYg6pY9CNxjRLTGfr/SaQDE1cZ
 RE1EyuAhmH4lQzJOlBr2W/wZo7Dag8G8CeBKt8/Ed7F6unfNjTfvORF1aBkb+dxEjUkn
 rMEW62v6jm/xIIBYZKehYWMk4cz3/p2bcv0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b2kga88yj-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 21:09:19 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 13 Sep 2021 21:09:17 -0700
Received: by devbig612.frc2.facebook.com (Postfix, from userid 115148)
        id 3D3F425C5B73; Mon, 13 Sep 2021 21:09:17 -0700 (PDT)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <Kernel-team@fb.com>, Joanne Koong <joannekoong@fb.com>
Subject: [PATCH v2 bpf-next 2/4] selftests/bpf: Add bloom filter map test cases
Date:   Mon, 13 Sep 2021 21:04:31 -0700
Message-ID: <20210914040433.3184308-3-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914040433.3184308-1-joannekoong@fb.com>
References: <20210914040433.3184308-1-joannekoong@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: Fou9NH9aA2wpY4Yg5eKxat31n3MLiAmg
X-Proofpoint-GUID: Fou9NH9aA2wpY4Yg5eKxat31n3MLiAmg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-13_09,2021-09-09_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 bulkscore=0
 mlxscore=0 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0
 mlxlogscore=962 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140024
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds test cases for bpf bloom filter maps. They include tests
checking against invalid operations by userspace, tests for using the blo=
om
filter map as an inner map, and a bpf program that queries the bloom filt=
er
map for values added by a userspace program.

Signed-off-by: Joanne Koong <joannekoong@fb.com>
---
 .../bpf/prog_tests/bloom_filter_map.c         | 177 ++++++++++++++++++
 .../selftests/bpf/progs/bloom_filter_map.c    |  82 ++++++++
 2 files changed, 259 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bloom_filter_m=
ap.c
 create mode 100644 tools/testing/selftests/bpf/progs/bloom_filter_map.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c b/=
tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
new file mode 100644
index 000000000000..eb81aab0d7be
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
@@ -0,0 +1,177 @@
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
+		.map_flags =3D BPF_F_BLOOM_FILTER_HASH_BIT_2,
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
+	struct bpf_link *link;
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
+	link =3D bpf_program__attach(skel->progs.prog_bloom_filter);
+	if (!ASSERT_OK_PTR(link, "link"))
+		return;
+
+	syscall(SYS_getpgid);
+
+	ASSERT_EQ(skel->bss->error, 0, "error");
+
+	bpf_link__destroy(link);
+}
+
+static void bloom_filter_inner_map(struct bloom_filter_map *skel)
+{
+	const int map_size =3D bpf_map__max_entries(skel->maps.map_random_data)=
;
+	int outer_map_fd, inner_map_fd, map_random_data_fd, err, i, key =3D 0;
+	struct bpf_create_map_attr xattr =3D {
+		.name =3D "bloom_filter_inner_map",
+		.map_type =3D BPF_MAP_TYPE_BLOOM_FILTER,
+		.max_entries =3D map_size,
+		.value_size =3D sizeof(__u64),
+	};
+	struct bpf_link *link;
+	__u64 val;
+
+	/* Create a bloom filter map that will be used as the inner map */
+	inner_map_fd =3D bpf_create_map_xattr(&xattr);
+	if (!ASSERT_GE(inner_map_fd, 0, "bpf_create_map bloom filter map as inn=
er map"))
+		return;
+
+	/* Generate random values and add them to the maps */
+	map_random_data_fd =3D bpf_map__fd(skel->maps.map_random_data);
+	for (i =3D 0; i < map_size; i++) {
+		val =3D rand();
+		err =3D bpf_map_update_elem(map_random_data_fd, &i, &val, BPF_ANY);
+		if (!ASSERT_OK(err, "Add random value to map_random_data"))
+			continue;
+
+		err =3D bpf_map_update_elem(inner_map_fd, NULL, &val, 0);
+		if (!ASSERT_OK(err, "Add random value to inner_map_fd"))
+			goto done;
+	}
+
+	outer_map_fd =3D bpf_map__fd(skel->maps.outer_map);
+	/* Add the bloom filter map to the outer map */
+	err =3D bpf_map_update_elem(outer_map_fd, &key, &inner_map_fd, 0);
+	if (!ASSERT_OK(err, "Add bloom filter map to outer map"))
+		goto done;
+
+	/* Attach the bloom_filter_inner_map prog */
+	link =3D bpf_program__attach(skel->progs.prog_bloom_filter_inner_map);
+	if (!ASSERT_OK_PTR(link, "link"))
+		goto delete_inner_map;
+
+	syscall(SYS_getpgid);
+
+	ASSERT_EQ(skel->bss->error, 0, "error");
+
+	bpf_link__destroy(link);
+
+delete_inner_map:
+	/* Ensure the inner bloom filter map can be deleted */
+	err =3D bpf_map_delete_elem(outer_map_fd, &key);
+	ASSERT_OK(err, "Delete inner bloom filter map");
+
+done:
+	close(inner_map_fd);
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
+	bloom_filter_inner_map(skel);
+
+cleanup:
+	bloom_filter_map__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/bloom_filter_map.c b/tools=
/testing/selftests/bpf/progs/bloom_filter_map.c
new file mode 100644
index 000000000000..8b5bf8d61a40
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bloom_filter_map.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
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
+struct map_bloom_filter_type {
+	__uint(type, BPF_MAP_TYPE_BLOOM_FILTER);
+	__uint(key_size, 0);
+	__uint(value_size, sizeof(__u64));
+	__uint(max_entries, 1000);
+} map_bloom_filter SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(int));
+	__uint(value_size, sizeof(int));
+	__array(values, struct map_bloom_filter_type);
+} outer_map SEC(".maps");
+
+struct callback_ctx {
+	struct map_bloom_filter_type *map;
+};
+
+int error =3D 0;
+
+static __u64
+check_elem(struct bpf_map *map, __u32 *key, __u64 *val,
+	   struct callback_ctx *data)
+{
+	int err;
+
+	err =3D bpf_map_peek_elem(data->map, val);
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
+	struct callback_ctx data;
+
+	data.map =3D &map_bloom_filter;
+	bpf_for_each_map_elem(&map_random_data, check_elem, &data, 0);
+
+	return 0;
+}
+
+SEC("fentry/__x64_sys_getpgid")
+int prog_bloom_filter_inner_map(void *ctx)
+{
+	struct map_bloom_filter_type *inner_map;
+	struct callback_ctx data;
+	int key =3D 0;
+
+	inner_map =3D bpf_map_lookup_elem(&outer_map, &key);
+	if (!inner_map) {
+		error |=3D 2;
+		return 0;
+	}
+
+	data.map =3D inner_map;
+	bpf_for_each_map_elem(&map_random_data, check_elem, &data, 0);
+
+	return 0;
+}
--=20
2.30.2


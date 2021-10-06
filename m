Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946F742498D
	for <lists+bpf@lfdr.de>; Thu,  7 Oct 2021 00:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239454AbhJFWXa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 18:23:30 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:62484 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239547AbhJFWX3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 Oct 2021 18:23:29 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 196Ksxit023994
        for <bpf@vger.kernel.org>; Wed, 6 Oct 2021 15:21:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=anDzD/iblmNmbfeM1SYA2DgeBKoMdZK8weQQt8f3O8U=;
 b=W8CAFySa9HLL96FR+u77D+2bn3YnJVu4FEW+PaKN/Qt27MXyHtuH2+TDFWMzz4RDxZ5v
 qgykhKn7bLnSs7zqByOP/DlGXsk+iUj5jDJw/8o94U9Fulh6hQz3+/18U4SzRoza9RKa
 mpHU6r0uIw3PqSyGPJjgUfb7IRB9GmIlFHI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bhk8eghgv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 15:21:36 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 6 Oct 2021 15:21:35 -0700
Received: by devbig612.frc2.facebook.com (Postfix, from userid 115148)
        id BD5143451891; Wed,  6 Oct 2021 15:21:29 -0700 (PDT)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <Kernel-team@fb.com>, Joanne Koong <joannekoong@fb.com>
Subject: [PATCH bpf-next v4 3/5] selftests/bpf: Add bitset map test cases
Date:   Wed, 6 Oct 2021 15:21:01 -0700
Message-ID: <20211006222103.3631981-4-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211006222103.3631981-1-joannekoong@fb.com>
References: <20211006222103.3631981-1-joannekoong@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: xS6XNt1b610lGTu-8sllD1OaiHyts9zZ
X-Proofpoint-ORIG-GUID: xS6XNt1b610lGTu-8sllD1OaiHyts9zZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_04,2021-10-06_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 bulkscore=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110060139
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds test cases for bpf bitset maps. They include tests
checking against invalid operations by userspace, tests for using the
bitset  map as an inner map, a bpf program that queries the bitset
map for values added by userspace, and well as tests for the bloom
filter capabilities of the bitset map.

Signed-off-by: Joanne Koong <joannekoong@fb.com>
---
 .../selftests/bpf/prog_tests/bitset_map.c     | 279 ++++++++++++++++++
 .../testing/selftests/bpf/progs/bitset_map.c  | 115 ++++++++
 2 files changed, 394 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bitset_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/bitset_map.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bitset_map.c b/tools/=
testing/selftests/bpf/prog_tests/bitset_map.c
new file mode 100644
index 000000000000..8929cc598b9d
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bitset_map.c
@@ -0,0 +1,279 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+
+#include <sys/syscall.h>
+#include <test_progs.h>
+#include "bitset_map.skel.h"
+
+static void test_bitset_map_fail(bool bloom_filter)
+{
+	struct bpf_create_map_attr xattr =3D {
+		.name =3D "bitset_map",
+		.map_type =3D BPF_MAP_TYPE_BITSET,
+		.max_entries =3D 100,
+		.value_size =3D bloom_filter ? 11 : sizeof(__u32),
+		.map_extra =3D bloom_filter ? 5 : 0,
+	};
+	__u32 value;
+	int fd, err;
+
+	/* Invalid key size */
+	xattr.key_size =3D 4;
+	fd =3D bpf_create_map_xattr(&xattr);
+	if (!ASSERT_LT(fd, 0, "bpf_create_map bitset invalid key size"))
+		close(fd);
+	xattr.key_size =3D 0;
+
+	/* Invalid value size */
+	xattr.value_size =3D 0;
+	fd =3D bpf_create_map_xattr(&xattr);
+	if (!ASSERT_LT(fd, 0, "bpf_create_map bitset invalid value size 0"))
+		close(fd);
+	if (!bloom_filter) {
+		/* For bitset maps that are not bloom filters, the value size must
+		 * be a __u32.
+		 */
+		xattr.value_size =3D sizeof(__u64);
+		fd =3D bpf_create_map_xattr(&xattr);
+		if (!ASSERT_LT(fd, 0, "bpf_create_map bitset invalid value size u64"))
+			close(fd);
+	}
+	xattr.value_size =3D bloom_filter ? 11 : sizeof(__u32);
+
+	/* Invalid max entries size */
+	xattr.max_entries =3D 0;
+	fd =3D bpf_create_map_xattr(&xattr);
+	if (!ASSERT_LT(fd, 0, "bpf_create_map bitset invalid max entries size")=
)
+		close(fd);
+	xattr.max_entries =3D 100;
+
+	/* bitset maps do not support BPF_F_NO_PREALLOC */
+	xattr.map_flags =3D BPF_F_NO_PREALLOC;
+	fd =3D bpf_create_map_xattr(&xattr);
+	if (!ASSERT_LT(fd, 0, "bpf_create_map bitset invalid flags"))
+		close(fd);
+	xattr.map_flags =3D 0;
+
+	fd =3D bpf_create_map_xattr(&xattr);
+	if (!ASSERT_GE(fd, 0, "bpf_create_map bitset"))
+		return;
+
+	/* Test invalid flags */
+	err =3D bpf_map_update_elem(fd, NULL, &value, -1);
+	ASSERT_EQ(err, -EINVAL, "bpf_map_update_elem bitset invalid flags");
+
+	err =3D bpf_map_update_elem(fd, NULL, &value, BPF_EXIST);
+	ASSERT_EQ(err, -EINVAL, "bpf_map_update_elem bitset invalid flags");
+
+	err =3D bpf_map_update_elem(fd, NULL, &value, BPF_F_LOCK);
+	ASSERT_EQ(err, -EINVAL, "bpf_map_update_elem bitset invalid flags");
+
+	err =3D bpf_map_update_elem(fd, NULL, &value, BPF_NOEXIST);
+	ASSERT_EQ(err, -EINVAL, "bpf_map_update_elem bitset invalid flags");
+
+	err =3D bpf_map_update_elem(fd, NULL, &value, 10000);
+	ASSERT_EQ(err, -EINVAL, "bpf_map_update_elem bitset invalid flags");
+
+	if (bloom_filter) {
+		err =3D bpf_map_update_elem(fd, NULL, &value, 0);
+		ASSERT_OK(err, "bpf_map_update_elem bitset invalid flags");
+
+		/* Clearing a bit is not allowed */
+		err =3D bpf_map_lookup_and_delete_elem(fd, NULL, &value);
+		ASSERT_EQ(err, -EOPNOTSUPP, "bpf_map_lookup_and_delete invalid");
+	} else {
+		/* Try clearing a bit that wasn't set */
+		err =3D bpf_map_lookup_and_delete_elem(fd, NULL, &value);
+		ASSERT_EQ(err, -EINVAL, "bpf_map_lookup_and_delete invalid bit");
+
+		/* Try setting a bit that is outside the bitset range */
+		value =3D xattr.max_entries;
+		err =3D bpf_map_update_elem(fd, NULL, &value, 0);
+		ASSERT_EQ(err, -EINVAL, "bpf_map_update_elem bitset out of range");
+	}
+
+	/* bpf_map_delete is not supported. Only use bpf_map_lookup_and_delete =
*/
+	err =3D bpf_map_delete_elem(fd, &value);
+	ASSERT_EQ(err, -EINVAL, "bpf_map_delete_elem");
+
+	close(fd);
+}
+
+static void test_bitset_map_clear(void)
+{
+	int fd, err;
+	__u32 val;
+
+	fd =3D bpf_create_map(BPF_MAP_TYPE_BITSET, 0, sizeof(__u32), 10, 0);
+	if (!ASSERT_GE(fd, 0, "bpf_create_map"))
+		return;
+
+	val =3D 3;
+	err =3D bpf_map_update_elem(fd, NULL, &val, 0);
+	if (!ASSERT_OK(err, "Set bit in bitmap"))
+		goto done;
+
+	err =3D bpf_map_lookup_elem(fd, NULL, &val);
+	if (!ASSERT_OK(err, "Check bit in bitmap"))
+		goto done;
+
+	err =3D bpf_map_lookup_and_delete_elem(fd, NULL, &val);
+	if (!ASSERT_OK(err, "Clear bit in bitmap"))
+		goto done;
+
+	err =3D bpf_map_lookup_elem(fd, NULL, &val);
+	if (!ASSERT_EQ(err, -ENOENT, "Check cleared bit in bitmap"))
+		goto done;
+
+done:
+	close(fd);
+}
+
+static void bitset_map(struct bitset_map *skel, struct bpf_program *prog=
)
+{
+	struct bpf_link *link;
+
+	link =3D bpf_program__attach(prog);
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
+static void bitset_inner_map(struct bitset_map *skel, const __u32 *rand_=
vals,
+			     __u32 nr_rand_vals)
+{
+	int outer_map_fd, inner_map_fd, err, i, key =3D 0;
+	struct bpf_create_map_attr xattr =3D {
+		.name =3D "bitset_inner_map",
+		.map_type =3D BPF_MAP_TYPE_BITSET,
+		.value_size =3D sizeof(__u32),
+		.max_entries =3D 1 << 16,
+	};
+	struct bpf_link *link;
+
+	/* Create a bitset map that will be used as the inner map */
+	inner_map_fd =3D bpf_create_map_xattr(&xattr);
+	if (!ASSERT_GE(inner_map_fd, 0, "bpf_create_map bitset map as inner map=
"))
+		return;
+
+	for (i =3D 0; i < nr_rand_vals; i++) {
+		err =3D bpf_map_update_elem(inner_map_fd, NULL, rand_vals + i, BPF_ANY=
);
+		if (!ASSERT_OK(err, "Add random value to inner_map_fd"))
+			goto done;
+	}
+
+	/* Add the bitset map to the outer map */
+	outer_map_fd =3D bpf_map__fd(skel->maps.outer_map);
+	err =3D bpf_map_update_elem(outer_map_fd, &key, &inner_map_fd, BPF_ANY)=
;
+	if (!ASSERT_OK(err, "Add bitset map to outer map"))
+		goto done;
+
+	/* Attach the bitset_inner_map prog */
+	link =3D bpf_program__attach(skel->progs.prog_bitset_inner_map);
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
+	/* Ensure the inner bitset map can be deleted */
+	err =3D bpf_map_delete_elem(outer_map_fd, &key);
+	ASSERT_OK(err, "Delete inner bitset map");
+
+done:
+	close(inner_map_fd);
+}
+
+static int setup_bitset_progs(struct bitset_map **out_skel, __u32 **out_=
rand_vals,
+			      __u32 *out_nr_rand_vals)
+{
+	int random_data_fd, bitset_fd, bloom_filter_fd;
+	struct bitset_map *skel;
+	__u32 *rand_vals =3D NULL;
+	__u32 map_size;
+	__u32 val;
+	int err, i;
+
+	/* Set up a bitset map skeleton */
+	skel =3D bitset_map__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "bitset_map__open_and_load"))
+		return -EINVAL;
+
+	/* Set up rand_vals */
+	map_size =3D bpf_map__max_entries(skel->maps.map_random_data);
+	rand_vals =3D malloc(sizeof(*rand_vals) * map_size);
+	if (!rand_vals) {
+		err =3D -ENOMEM;
+		goto error;
+	}
+
+	/* Generate random values and populate both skeletons */
+	random_data_fd =3D bpf_map__fd(skel->maps.map_random_data);
+	bitset_fd =3D bpf_map__fd(skel->maps.map_bitset);
+	bloom_filter_fd =3D bpf_map__fd(skel->maps.map_bloom_filter);
+	for (i =3D 0; i < map_size; i++) {
+		val =3D rand();
+
+		err =3D bpf_map_update_elem(random_data_fd, &i, &val, BPF_ANY);
+		if (!ASSERT_OK(err, "Add random value to map_random_data"))
+			goto error;
+
+		err =3D bpf_map_update_elem(bloom_filter_fd, NULL, &val, BPF_ANY);
+		if (!ASSERT_OK(err, "Add random value to map_bloom_filter"))
+			goto error;
+
+		/* Take the lower 16 bits */
+		val &=3D 0xFFFF;
+
+		rand_vals[i] =3D val;
+
+		err =3D bpf_map_update_elem(bitset_fd, NULL, &val, BPF_ANY);
+		if (!ASSERT_OK(err, "Add random value to map_bitset"))
+			goto error;
+	}
+
+	*out_skel =3D skel;
+	*out_rand_vals =3D rand_vals;
+	*out_nr_rand_vals =3D map_size;
+
+	return 0;
+
+error:
+	bitset_map__destroy(skel);
+	if (rand_vals)
+		free(rand_vals);
+	return err;
+}
+
+void test_bitset_map(void)
+{
+	__u32 *rand_vals, nr_rand_vals;
+	struct bitset_map *skel;
+	int err;
+
+	test_bitset_map_fail(false);
+	test_bitset_map_fail(true);
+
+	test_bitset_map_clear();
+
+	err =3D setup_bitset_progs(&skel, &rand_vals, &nr_rand_vals);
+	if (err)
+		return;
+
+	bitset_inner_map(skel, rand_vals, nr_rand_vals);
+	free(rand_vals);
+
+	bitset_map(skel, skel->progs.prog_bitset);
+	bitset_map(skel, skel->progs.prog_bloom_filter);
+
+	bitset_map__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/bitset_map.c b/tools/testi=
ng/selftests/bpf/progs/bitset_map.c
new file mode 100644
index 000000000000..c284ade37db1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bitset_map.c
@@ -0,0 +1,115 @@
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
+	__type(value, __u32);
+} map_random_data SEC(".maps");
+
+struct map_bitset_type {
+	__uint(type, BPF_MAP_TYPE_BITSET);
+	__uint(value_size, sizeof(__u32));
+	__uint(max_entries, 1 << 16);
+} map_bitset SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_BITSET);
+	__uint(value_size, sizeof(__u32));
+	__uint(max_entries, 10000);
+	__uint(map_extra, 5);
+} map_bloom_filter SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(int));
+	__uint(value_size, sizeof(int));
+	__array(values, struct map_bitset_type);
+} outer_map SEC(".maps");
+
+struct callback_ctx {
+	struct bpf_map *map;
+};
+
+int error =3D 0;
+
+static __u64
+check_bit(struct bpf_map *map, __u32 *key, __u32 *val,
+	  struct callback_ctx *data)
+{
+	__u32 index =3D *val & 0xFFFF;
+	int err;
+
+	err =3D bpf_map_peek_elem(data->map, &index);
+	if (err) {
+		error |=3D 1;
+		return 1; /* stop the iteration */
+	}
+
+	return 0;
+}
+
+SEC("fentry/__x64_sys_getpgid")
+int prog_bitset(void *ctx)
+{
+	struct callback_ctx data;
+
+	data.map =3D (struct bpf_map *)&map_bitset;
+	bpf_for_each_map_elem(&map_random_data, check_bit, &data, 0);
+
+	return 0;
+}
+
+SEC("fentry/__x64_sys_getpgid")
+int prog_bitset_inner_map(void *ctx)
+{
+	struct bpf_map *inner_map;
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
+	bpf_for_each_map_elem(&map_random_data, check_bit, &data, 0);
+
+	return 0;
+}
+
+static __u64
+check_elem(struct bpf_map *map, __u32 *key, __u32 *val,
+	   struct callback_ctx *data)
+{
+	int err;
+
+	err =3D bpf_map_peek_elem(data->map, val);
+	if (err) {
+		error |=3D 3;
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
+	data.map =3D (struct bpf_map *)&map_bloom_filter;
+	bpf_for_each_map_elem(&map_random_data, check_elem, &data, 0);
+
+	return 0;
+}
--=20
2.30.2


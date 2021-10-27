Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D2843D7BE
	for <lists+bpf@lfdr.de>; Thu, 28 Oct 2021 01:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhJ0Xum (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Oct 2021 19:50:42 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:7128 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229447AbhJ0Xum (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 27 Oct 2021 19:50:42 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 19RLfViJ016261
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 16:48:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=CIMPXFXBew33gqh4ZvshRxgSEGZ3I5lrZkjTGx+vQnM=;
 b=HM7hHG1z0vm+K5VlW2bfEfnFWBoWXJRPFt8eCI/DhtKpJLWvAyd5pe94Io9UhpU2p24D
 bkO/ZY9kf7iDPSJR8j+XPHDmb/5/kddS4cH0aILKpGbfv6mhBIJl39FENNJY5qvHbtPi
 AuJ+rqyHtT63axJIDtbfpY0jtvafFsfjtZg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3by64p6v6d-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 16:48:15 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 27 Oct 2021 16:48:14 -0700
Received: by devbig612.frc2.facebook.com (Postfix, from userid 115148)
        id A0A29421C73A; Wed, 27 Oct 2021 16:45:18 -0700 (PDT)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kafai@fb.com>, <Kernel-team@fb.com>,
        Joanne Koong <joannekoong@fb.com>
Subject: [PATCH v6 bpf-next 3/5] selftests/bpf: Add bloom filter map test cases
Date:   Wed, 27 Oct 2021 16:45:02 -0700
Message-ID: <20211027234504.30744-4-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211027234504.30744-1-joannekoong@fb.com>
References: <20211027234504.30744-1-joannekoong@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: fuoh7kf0I8l1C-B7g8alpq4tIa_Hcv9-
X-Proofpoint-GUID: fuoh7kf0I8l1C-B7g8alpq4tIa_Hcv9-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-27_07,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110270130
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds test cases for bpf bloom filter maps. They include tests
checking against invalid operations by userspace, tests for using the
bloom filter map as an inner map, and a bpf program that queries the
bloom filter map for values added by a userspace program.

Signed-off-by: Joanne Koong <joannekoong@fb.com>
---
 .../bpf/prog_tests/bloom_filter_map.c         | 204 ++++++++++++++++++
 .../selftests/bpf/progs/bloom_filter_map.c    |  82 +++++++
 2 files changed, 286 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bloom_filter_m=
ap.c
 create mode 100644 tools/testing/selftests/bpf/progs/bloom_filter_map.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c b/=
tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
new file mode 100644
index 000000000000..9aa3fbed918b
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+
+#include <sys/syscall.h>
+#include <test_progs.h>
+#include "bloom_filter_map.skel.h"
+
+static void test_fail_cases(void)
+{
+	struct bpf_create_map_attr xattr =3D {
+		.name =3D "bloom_filter_map",
+		.map_type =3D BPF_MAP_TYPE_BLOOM_FILTER,
+		.max_entries =3D 100,
+		.value_size =3D 11,
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
+	if (!ASSERT_LT(fd, 0, "bpf_create_map bloom filter invalid value size 0=
"))
+		close(fd);
+	xattr.value_size =3D 11;
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
+static void check_bloom(struct bloom_filter_map *skel)
+{
+	struct bpf_link *link;
+
+	link =3D bpf_program__attach(skel->progs.check_bloom);
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
+static void test_inner_map(struct bloom_filter_map *skel, const __u32 *r=
and_vals,
+			   __u32 nr_rand_vals)
+{
+	int outer_map_fd, inner_map_fd, err, i, key =3D 0;
+	struct bpf_create_map_attr xattr =3D {
+		.name =3D "bloom_filter_inner_map",
+		.map_type =3D BPF_MAP_TYPE_BLOOM_FILTER,
+		.value_size =3D sizeof(__u32),
+		.max_entries =3D nr_rand_vals,
+	};
+	struct bpf_link *link;
+
+	/* Create a bloom filter map that will be used as the inner map */
+	inner_map_fd =3D bpf_create_map_xattr(&xattr);
+	if (!ASSERT_GE(inner_map_fd, 0, "bpf_create_map bloom filter inner map"=
))
+		return;
+
+	for (i =3D 0; i < nr_rand_vals; i++) {
+		err =3D bpf_map_update_elem(inner_map_fd, NULL, rand_vals + i, BPF_ANY=
);
+		if (!ASSERT_OK(err, "Add random value to inner_map_fd"))
+			goto done;
+	}
+
+	/* Add the bloom filter map to the outer map */
+	outer_map_fd =3D bpf_map__fd(skel->maps.outer_map);
+	err =3D bpf_map_update_elem(outer_map_fd, &key, &inner_map_fd, BPF_ANY)=
;
+	if (!ASSERT_OK(err, "Add bloom filter map to outer map"))
+		goto done;
+
+	/* Attach the bloom_filter_inner_map prog */
+	link =3D bpf_program__attach(skel->progs.inner_map);
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
+static int setup_progs(struct bloom_filter_map **out_skel, __u32 **out_r=
and_vals,
+		       __u32 *out_nr_rand_vals)
+{
+	struct bloom_filter_map *skel;
+	int random_data_fd, bloom_fd;
+	__u32 *rand_vals =3D NULL;
+	__u32 map_size, val;
+	int err, i;
+
+	/* Set up a bloom filter map skeleton */
+	skel =3D bloom_filter_map__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "bloom_filter_map__open_and_load"))
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
+	bloom_fd =3D bpf_map__fd(skel->maps.map_bloom);
+	for (i =3D 0; i < map_size; i++) {
+		val =3D rand();
+
+		err =3D bpf_map_update_elem(random_data_fd, &i, &val, BPF_ANY);
+		if (!ASSERT_OK(err, "Add random value to map_random_data"))
+			goto error;
+
+		err =3D bpf_map_update_elem(bloom_fd, NULL, &val, BPF_ANY);
+		if (!ASSERT_OK(err, "Add random value to map_bloom"))
+			goto error;
+
+		rand_vals[i] =3D val;
+	}
+
+	*out_skel =3D skel;
+	*out_rand_vals =3D rand_vals;
+	*out_nr_rand_vals =3D map_size;
+
+	return 0;
+
+error:
+	bloom_filter_map__destroy(skel);
+	if (rand_vals)
+		free(rand_vals);
+	return err;
+}
+
+void test_bloom_filter_map(void)
+{
+	__u32 *rand_vals, nr_rand_vals;
+	struct bloom_filter_map *skel;
+	int err;
+
+	test_fail_cases();
+
+	err =3D setup_progs(&skel, &rand_vals, &nr_rand_vals);
+	if (err)
+		return;
+
+	test_inner_map(skel, rand_vals, nr_rand_vals);
+	free(rand_vals);
+
+	check_bloom(skel);
+
+	bloom_filter_map__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/bloom_filter_map.c b/tools=
/testing/selftests/bpf/progs/bloom_filter_map.c
new file mode 100644
index 000000000000..1316f3db79d9
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
+	__type(key, __u32);
+	__type(value, __u32);
+	__uint(max_entries, 1000);
+} map_random_data SEC(".maps");
+
+struct map_bloom_type {
+	__uint(type, BPF_MAP_TYPE_BLOOM_FILTER);
+	__type(value, __u32);
+	__uint(max_entries, 10000);
+	__uint(map_extra, 5);
+} map_bloom SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__type(key, int);
+	__type(value, int);
+	__uint(max_entries, 1);
+	__array(values, struct map_bloom_type);
+} outer_map SEC(".maps");
+
+struct callback_ctx {
+	struct bpf_map *map;
+};
+
+int error =3D 0;
+
+static __u64
+check_elem(struct bpf_map *map, __u32 *key, __u32 *val,
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
+int inner_map(void *ctx)
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
+	bpf_for_each_map_elem(&map_random_data, check_elem, &data, 0);
+
+	return 0;
+}
+
+SEC("fentry/__x64_sys_getpgid")
+int check_bloom(void *ctx)
+{
+	struct callback_ctx data;
+
+	data.map =3D (struct bpf_map *)&map_bloom;
+	bpf_for_each_map_elem(&map_random_data, check_elem, &data, 0);
+
+	return 0;
+}
--=20
2.30.2


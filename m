Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5668522FCC7
	for <lists+bpf@lfdr.de>; Tue, 28 Jul 2020 01:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgG0XPA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jul 2020 19:15:00 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34446 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726196AbgG0XPA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 27 Jul 2020 19:15:00 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06RNEv56016496
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2020 16:14:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=7CWKNixQDcVQNXNCMBvHCt7Ku8k6MhDCgz1xTihXokY=;
 b=cBzd1E82IRfgq9ggSPKp3P9qjMFEXNjpj1Qo2rRhKQ+Oi1hVSKZOF+aOH2F4/e7Ujlk3
 XBiXvd+uB1qownw3ncAKMTb9JV2w2vm4IGTuj0ldx30CUxiG/bF+p/8mmdjdQVDKX01t
 b5krWCkWHFgxNIZLjQtURzacYGS/0uuZiVE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32h4q9ey0p-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2020 16:14:59 -0700
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 27 Jul 2020 16:14:49 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 787382EC4BB0; Mon, 27 Jul 2020 16:14:48 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Song Liu <songliubraving@fb.com>, <stable@vger.kernel.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf 2/2] selftests/bpf: extend map-in-map selftest to detect memory leaks
Date:   Mon, 27 Jul 2020 16:14:45 -0700
Message-ID: <20200727231445.1227594-2-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200727231445.1227594-1-andriin@fb.com>
References: <20200727231445.1227594-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-27_15:2020-07-27,2020-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 bulkscore=0 suspectscore=9 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007270158
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add test validating that all inner maps are released properly after skele=
ton
is destroyed. To ensure determinism, trigger kernel-side synchronize_rcu(=
)
before checking map existence by their IDs.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 .../selftests/bpf/prog_tests/btf_map_in_map.c | 121 ++++++++++++++++--
 1 file changed, 108 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_map_in_map.c b/to=
ols/testing/selftests/bpf/prog_tests/btf_map_in_map.c
index f7ee8fa377ad..c06b61235212 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_map_in_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_map_in_map.c
@@ -5,10 +5,59 @@
=20
 #include "test_btf_map_in_map.skel.h"
=20
+static int duration;
+
+__u32 bpf_map_id(struct bpf_map *map)
+{
+	struct bpf_map_info info;
+	__u32 info_len =3D sizeof(info);
+	int err;
+
+	memset(&info, 0, info_len);
+	err =3D bpf_obj_get_info_by_fd(bpf_map__fd(map), &info, &info_len);
+	if (err)
+		return 0;
+	return info.id;
+}
+
+/*
+ * Trigger synchronize_cpu() in kernel.
+ *
+ * ARRAY_OF_MAPS/HASH_OF_MAPS lookup/update operations trigger
+ * synchronize_rcu(), if looking up/updating non-NULL element. Use this =
fact
+ * to trigger synchronize_cpu(): create map-in-map, create a trivial ARR=
AY
+ * map, update map-in-map with ARRAY inner map. Then cleanup. At the end=
, at
+ * least one synchronize_rcu() would be called.
+ */
+int kern_sync_rcu() {
+	int inner_map_fd, outer_map_fd, err, zero =3D 0;
+
+	inner_map_fd =3D bpf_create_map(BPF_MAP_TYPE_ARRAY, 4, 4, 1, 0);
+	if (CHECK(inner_map_fd < 0, "inner_map_create", "failed %d\n", -errno))
+		return -1;
+
+	outer_map_fd =3D bpf_create_map_in_map(BPF_MAP_TYPE_ARRAY_OF_MAPS, NULL=
,
+					     sizeof(int), inner_map_fd, 1, 0);
+	if (CHECK(outer_map_fd < 0, "outer_map_create", "failed %d\n", -errno))=
 {
+		close(inner_map_fd);
+		return -1;
+	}
+
+	err =3D bpf_map_update_elem(outer_map_fd, &zero, &inner_map_fd, 0);
+	if (err)
+		err =3D -errno;
+	CHECK(err, "outer_map_update", "failed %d\n", err);
+	close(inner_map_fd);
+	close(outer_map_fd);
+	return err;
+}
+
 void test_btf_map_in_map(void)
 {
-	int duration =3D 0, err, key =3D 0, val;
+	int err, key =3D 0, val, i;
 	struct test_btf_map_in_map* skel;
+	int outer_arr_fd, outer_hash_fd;
+	int fd, map1_fd, map2_fd, map1_id, map2_id;
=20
 	skel =3D test_btf_map_in_map__open_and_load();
 	if (CHECK(!skel, "skel_open", "failed to open&load skeleton\n"))
@@ -18,32 +67,78 @@ void test_btf_map_in_map(void)
 	if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
 		goto cleanup;
=20
+	map1_fd =3D bpf_map__fd(skel->maps.inner_map1);
+	map2_fd =3D bpf_map__fd(skel->maps.inner_map2);
+	outer_arr_fd =3D bpf_map__fd(skel->maps.outer_arr);
+	outer_hash_fd =3D bpf_map__fd(skel->maps.outer_hash);
+
 	/* inner1 =3D input, inner2 =3D input + 1 */
-	val =3D bpf_map__fd(skel->maps.inner_map1);
-	bpf_map_update_elem(bpf_map__fd(skel->maps.outer_arr), &key, &val, 0);
-	val =3D bpf_map__fd(skel->maps.inner_map2);
-	bpf_map_update_elem(bpf_map__fd(skel->maps.outer_hash), &key, &val, 0);
+	map1_fd =3D bpf_map__fd(skel->maps.inner_map1);
+	bpf_map_update_elem(outer_arr_fd, &key, &map1_fd, 0);
+	map2_fd =3D bpf_map__fd(skel->maps.inner_map2);
+	bpf_map_update_elem(outer_hash_fd, &key, &map2_fd, 0);
 	skel->bss->input =3D 1;
 	usleep(1);
=20
-	bpf_map_lookup_elem(bpf_map__fd(skel->maps.inner_map1), &key, &val);
+	bpf_map_lookup_elem(map1_fd, &key, &val);
 	CHECK(val !=3D 1, "inner1", "got %d !=3D exp %d\n", val, 1);
-	bpf_map_lookup_elem(bpf_map__fd(skel->maps.inner_map2), &key, &val);
+	bpf_map_lookup_elem(map2_fd, &key, &val);
 	CHECK(val !=3D 2, "inner2", "got %d !=3D exp %d\n", val, 2);
=20
 	/* inner1 =3D input + 1, inner2 =3D input */
-	val =3D bpf_map__fd(skel->maps.inner_map2);
-	bpf_map_update_elem(bpf_map__fd(skel->maps.outer_arr), &key, &val, 0);
-	val =3D bpf_map__fd(skel->maps.inner_map1);
-	bpf_map_update_elem(bpf_map__fd(skel->maps.outer_hash), &key, &val, 0);
+	bpf_map_update_elem(outer_arr_fd, &key, &map2_fd, 0);
+	bpf_map_update_elem(outer_hash_fd, &key, &map1_fd, 0);
 	skel->bss->input =3D 3;
 	usleep(1);
=20
-	bpf_map_lookup_elem(bpf_map__fd(skel->maps.inner_map1), &key, &val);
+	bpf_map_lookup_elem(map1_fd, &key, &val);
 	CHECK(val !=3D 4, "inner1", "got %d !=3D exp %d\n", val, 4);
-	bpf_map_lookup_elem(bpf_map__fd(skel->maps.inner_map2), &key, &val);
+	bpf_map_lookup_elem(map2_fd, &key, &val);
 	CHECK(val !=3D 3, "inner2", "got %d !=3D exp %d\n", val, 3);
=20
+	for (i =3D 0; i < 5; i++) {
+		val =3D i % 2 ? map1_fd : map2_fd;
+		err =3D bpf_map_update_elem(outer_hash_fd, &key, &val, 0);
+		if (CHECK_FAIL(err)) {
+			printf("failed to update hash_of_maps on iter #%d\n", i);
+			goto cleanup;
+		}
+		err =3D bpf_map_update_elem(outer_arr_fd, &key, &val, 0);
+		if (CHECK_FAIL(err)) {
+			printf("failed to update hash_of_maps on iter #%d\n", i);
+			goto cleanup;
+		}
+	}
+
+	map1_id =3D bpf_map_id(skel->maps.inner_map1);
+	map2_id =3D bpf_map_id(skel->maps.inner_map2);
+	CHECK(map1_id =3D=3D 0, "map1_id", "failed to get ID 1\n");
+	CHECK(map2_id =3D=3D 0, "map2_id", "failed to get ID 2\n");
+
+	test_btf_map_in_map__destroy(skel);
+	skel =3D NULL;
+=09
+	/* we need to either wait for or force synchronize_rcu(), before
+	 * checking for "still exists" condition, otherwise map could still be
+	 * resolvable by ID, causing false positives.
+	 *
+	 * Older kernels (5.8 and earlier) freed map only after two
+	 * synchronize_rcu()s, so trigger two, to be entirely sure.
+	 */
+	CHECK(kern_sync_rcu(), "sync_rcu", "failed\n");
+	CHECK(kern_sync_rcu(), "sync_rcu", "failed\n");
+
+	fd =3D bpf_map_get_fd_by_id(map1_id);
+	if (CHECK(fd >=3D 0, "map1_leak", "inner_map1 leaked!\n")) {
+		close(fd);
+		goto cleanup;
+	}
+	fd =3D bpf_map_get_fd_by_id(map2_id);
+	if (CHECK(fd >=3D 0, "map2_leak", "inner_map2 leaked!\n")) {
+		close(fd);
+		goto cleanup;
+	}
+
 cleanup:
 	test_btf_map_in_map__destroy(skel);
 }
--=20
2.24.1


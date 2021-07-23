Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287DD3D4202
	for <lists+bpf@lfdr.de>; Fri, 23 Jul 2021 23:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhGWUf0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Jul 2021 16:35:26 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:9118 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229461AbhGWUfZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 23 Jul 2021 16:35:25 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16NLDQ5H017416
        for <bpf@vger.kernel.org>; Fri, 23 Jul 2021 14:15:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=UaSWY5FKWamMhzACX4HcliR3fNvwOvAkEY6XjP4Qbo4=;
 b=hKPhf6fhqNBzlDJbikzn+1Dxh57L27C6lMDGXFTzFdCMQvxAHYEKxjzLZPzy92HW1puK
 7XGOFYqUGsQu3M35VfE7MBf3F5aQZctPg5UzTZeNh0d8P8zEbJBRPoUjgM11QEX7ZZ+s
 BgSrvvP0YRqNKpt9jYLJDAARV/+w5YdN19I= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 39yeddyy6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 23 Jul 2021 14:15:58 -0700
Received: from intmgw002.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Jul 2021 14:15:56 -0700
Received: by devvm2776.vll0.facebook.com (Postfix, from userid 364226)
        id D56F55DF16E; Fri, 23 Jul 2021 14:15:53 -0700 (PDT)
From:   Evgeniy Litvinenko <evgeniyl@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
Subject: [PATCH bpf-next] libbpf: Add bpf_map__pin_path function
Date:   Fri, 23 Jul 2021 14:15:16 -0700
Message-ID: <20210723211516.533088-1-evgeniyl@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: uAKY9A36VYXb_qN3EMHq55rZOury2dmK
X-Proofpoint-GUID: uAKY9A36VYXb_qN3EMHq55rZOury2dmK
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-23_10:2021-07-23,2021-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 malwarescore=0 phishscore=0 clxscore=1011 priorityscore=1501 mlxscore=0
 suspectscore=0 mlxlogscore=701 bulkscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107230129
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add bpf_map__pin_path, so that the inconsistently named
bpf_map__get_pin_path can be deprecated later. This is part of the
effort towards libbpf v1.0: https://github.com/libbpf/libbpf/issues/307

Also, add a selftest for the new function.

Signed-off-by: Evgeniy Litvinenko <evgeniyl@fb.com>
---
 tools/lib/bpf/libbpf.c                           | 5 +++++
 tools/lib/bpf/libbpf.h                           | 1 +
 tools/lib/bpf/libbpf.map                         | 1 +
 tools/testing/selftests/bpf/prog_tests/pinning.c | 9 +++++++++
 4 files changed, 16 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e595816b8b76..82df478dea12 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8511,6 +8511,11 @@ const char *bpf_map__get_pin_path(const struct bpf_m=
ap *map)
 	return map->pin_path;
 }
=20
+const char *bpf_map__pin_path(const struct bpf_map *map)
+{
+        return map->pin_path;
+}
+
 bool bpf_map__is_pinned(const struct bpf_map *map)
 {
 	return map->pinned;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 9ec6b7244889..1271d99bb7aa 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -499,6 +499,7 @@ LIBBPF_API bool bpf_map__is_offload_neutral(const struc=
t bpf_map *map);
 LIBBPF_API bool bpf_map__is_internal(const struct bpf_map *map);
 LIBBPF_API int bpf_map__set_pin_path(struct bpf_map *map, const char *path=
);
 LIBBPF_API const char *bpf_map__get_pin_path(const struct bpf_map *map);
+LIBBPF_API const char *bpf_map__pin_path(const struct bpf_map *map);
 LIBBPF_API bool bpf_map__is_pinned(const struct bpf_map *map);
 LIBBPF_API int bpf_map__pin(struct bpf_map *map, const char *path);
 LIBBPF_API int bpf_map__unpin(struct bpf_map *map, const char *path);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 887d372a3f27..c240d488eb5e 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -371,6 +371,7 @@ LIBBPF_0.4.0 {
 LIBBPF_0.5.0 {
 	global:
 		bpf_map__initial_value;
+		bpf_map__pin_path;
 		bpf_map_lookup_and_delete_elem_flags;
 		bpf_program__attach_kprobe_opts;
 		bpf_object__gen_loader;
diff --git a/tools/testing/selftests/bpf/prog_tests/pinning.c b/tools/testi=
ng/selftests/bpf/prog_tests/pinning.c
index fcf54b3a1dd0..d4b953ae3407 100644
--- a/tools/testing/selftests/bpf/prog_tests/pinning.c
+++ b/tools/testing/selftests/bpf/prog_tests/pinning.c
@@ -125,6 +125,10 @@ void test_pinning(void)
 	if (CHECK(err, "pin maps", "err %d errno %d\n", err, errno))
 		goto out;
=20
+	/* get pinning path */
+	if (!ASSERT_STREQ(bpf_map__pin_path(map), pinpath, "get pin path"))
+		goto out;
+
 	/* set pinning path of other map and re-pin all */
 	map =3D bpf_object__find_map_by_name(obj, "nopinmap");
 	if (CHECK(!map, "find map", "NULL map"))
@@ -134,6 +138,11 @@ void test_pinning(void)
 	if (CHECK(err, "set pin path", "err %d errno %d\n", err, errno))
 		goto out;
=20
+	/* get pinning path after set */
+	if (!ASSERT_STREQ(bpf_map__pin_path(map), custpinpath,
+			  "get pin path after set"))
+		goto out;
+
 	/* should only pin the one unpinned map */
 	err =3D bpf_object__pin_maps(obj, NULL);
 	if (CHECK(err, "pin maps", "err %d errno %d\n", err, errno))
--=20
2.30.2


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A330E487FFE
	for <lists+bpf@lfdr.de>; Sat,  8 Jan 2022 01:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbiAHAm4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Jan 2022 19:42:56 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:8384 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232043AbiAHAm4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 7 Jan 2022 19:42:56 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 207M40Re010723
        for <bpf@vger.kernel.org>; Fri, 7 Jan 2022 16:42:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=opEYKceThN6akS25MtNuQeV5cHSDVxipHuOKH+PBkn4=;
 b=jKXL2aswiyggLlhHmroISwgWw2b79+O6ZWn2qYcmh4v0e9LYZSvuopd9FxxTLtPaThg5
 H4sud90l88JP1WnSWfvnu+iYqSRX3eyacIzb/DfWv4vhoTz59RQFDZxFb9LktZKTxyHc
 bcA+fXhuP3WViCoqGWiDdf1du0gmqPeq4Og= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3de4w1hmqq-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 07 Jan 2022 16:42:55 -0800
Received: from twshared5363.25.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 7 Jan 2022 16:42:53 -0800
Received: by devbig921.prn2.facebook.com (Postfix, from userid 132113)
        id 907361694BCB; Fri,  7 Jan 2022 16:42:39 -0800 (PST)
From:   Christy Lee <christylee@fb.com>
To:     <andrii@kernel.org>, <acme@kernel.org>
CC:     <christyc.y.lee@gmail.com>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-perf-users@vger.kernel.org>,
        Christy Lee <christylee@fb.com>
Subject: [PATCH bpf-next v2 4/5] selftests/bpf: stop using bpf_map__def() API
Date:   Fri, 7 Jan 2022 16:42:17 -0800
Message-ID: <20220108004218.355761-5-christylee@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220108004218.355761-1-christylee@fb.com>
References: <20220108004218.355761-1-christylee@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: hxA2sh0MizpCXAAEGxbHpSVwZcIzdJF2
X-Proofpoint-ORIG-GUID: hxA2sh0MizpCXAAEGxbHpSVwZcIzdJF2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-07_10,2022-01-07_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201080001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

libbpf bpf_map__def() API is being deprecated, replace selftests/bpf's
usage with the appropriate getters and setters.

Signed-off-by: Christy Lee <christylee@fb.com>
---
 .../selftests/bpf/prog_tests/flow_dissector.c |  2 +-
 .../selftests/bpf/prog_tests/global_data.c    |  2 +-
 .../bpf/prog_tests/global_data_init.c         |  2 +-
 .../selftests/bpf/prog_tests/sockmap_listen.c | 12 +++----
 .../selftests/bpf/prog_tests/tailcalls.c      | 36 +++++++++----------
 5 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/to=
ols/testing/selftests/bpf/prog_tests/flow_dissector.c
index ac54e3f91d42..dfafd62df50b 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -457,7 +457,7 @@ static int init_prog_array(struct bpf_object *obj, st=
ruct bpf_map *prog_array)
 	if (map_fd < 0)
 		return -1;
=20
-	for (i =3D 0; i < bpf_map__def(prog_array)->max_entries; i++) {
+	for (i =3D 0; i < bpf_map__max_entries(prog_array); i++) {
 		snprintf(prog_name, sizeof(prog_name), "flow_dissector_%d", i);
=20
 		prog =3D bpf_object__find_program_by_name(obj, prog_name);
diff --git a/tools/testing/selftests/bpf/prog_tests/global_data.c b/tools=
/testing/selftests/bpf/prog_tests/global_data.c
index 9da131b32e13..917165e04427 100644
--- a/tools/testing/selftests/bpf/prog_tests/global_data.c
+++ b/tools/testing/selftests/bpf/prog_tests/global_data.c
@@ -121,7 +121,7 @@ static void test_global_data_rdonly(struct bpf_object=
 *obj, __u32 duration)
 	if (CHECK_FAIL(map_fd < 0))
 		return;
=20
-	buff =3D malloc(bpf_map__def(map)->value_size);
+	buff =3D malloc(bpf_map__value_size(map));
 	if (buff)
 		err =3D bpf_map_update_elem(map_fd, &zero, buff, 0);
 	free(buff);
diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/=
tools/testing/selftests/bpf/prog_tests/global_data_init.c
index 1db86eab101b..57331c606964 100644
--- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
+++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
@@ -20,7 +20,7 @@ void test_global_data_init(void)
 	if (CHECK_FAIL(!map || !bpf_map__is_internal(map)))
 		goto out;
=20
-	sz =3D bpf_map__def(map)->value_size;
+	sz =3D bpf_map__value_size(map);
 	newval =3D malloc(sz);
 	if (CHECK_FAIL(!newval))
 		goto out;
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/to=
ols/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 7e21bfab6358..2cf0c7a3fe23 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -1413,14 +1413,12 @@ static void test_reuseport_mixed_groups(int famil=
y, int sotype, int sock_map,
=20
 static void test_ops_cleanup(const struct bpf_map *map)
 {
-	const struct bpf_map_def *def;
 	int err, mapfd;
 	u32 key;
=20
-	def =3D bpf_map__def(map);
 	mapfd =3D bpf_map__fd(map);
=20
-	for (key =3D 0; key < def->max_entries; key++) {
+	for (key =3D 0; key < bpf_map__max_entries(map); key++) {
 		err =3D bpf_map_delete_elem(mapfd, &key);
 		if (err && errno !=3D EINVAL && errno !=3D ENOENT)
 			FAIL_ERRNO("map_delete: expected EINVAL/ENOENT");
@@ -1443,13 +1441,13 @@ static const char *family_str(sa_family_t family)
=20
 static const char *map_type_str(const struct bpf_map *map)
 {
-	const struct bpf_map_def *def;
+	int type;
=20
-	def =3D bpf_map__def(map);
-	if (IS_ERR(def))
+	if (!map)
 		return "invalid";
+	type =3D bpf_map__type(map);
=20
-	switch (def->type) {
+	switch (type) {
 	case BPF_MAP_TYPE_SOCKMAP:
 		return "sockmap";
 	case BPF_MAP_TYPE_SOCKHASH:
diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/t=
esting/selftests/bpf/prog_tests/tailcalls.c
index 5dc0f425bd11..796f231582f8 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -37,7 +37,7 @@ static void test_tailcall_1(void)
 	if (CHECK_FAIL(map_fd < 0))
 		goto out;
=20
-	for (i =3D 0; i < bpf_map__def(prog_array)->max_entries; i++) {
+	for (i =3D 0; i < bpf_map__max_entries(prog_array); i++) {
 		snprintf(prog_name, sizeof(prog_name), "classifier_%d", i);
=20
 		prog =3D bpf_object__find_program_by_name(obj, prog_name);
@@ -53,7 +53,7 @@ static void test_tailcall_1(void)
 			goto out;
 	}
=20
-	for (i =3D 0; i < bpf_map__def(prog_array)->max_entries; i++) {
+	for (i =3D 0; i < bpf_map__max_entries(prog_array); i++) {
 		err =3D bpf_prog_test_run(main_fd, 1, buff, sizeof(buff), 0,
 					&duration, &retval, NULL);
 		CHECK(err || retval !=3D i, "tailcall",
@@ -69,7 +69,7 @@ static void test_tailcall_1(void)
 	CHECK(err || retval !=3D 3, "tailcall", "err %d errno %d retval %d\n",
 	      err, errno, retval);
=20
-	for (i =3D 0; i < bpf_map__def(prog_array)->max_entries; i++) {
+	for (i =3D 0; i < bpf_map__max_entries(prog_array); i++) {
 		snprintf(prog_name, sizeof(prog_name), "classifier_%d", i);
=20
 		prog =3D bpf_object__find_program_by_name(obj, prog_name);
@@ -90,8 +90,8 @@ static void test_tailcall_1(void)
 	CHECK(err || retval !=3D 0, "tailcall", "err %d errno %d retval %d\n",
 	      err, errno, retval);
=20
-	for (i =3D 0; i < bpf_map__def(prog_array)->max_entries; i++) {
-		j =3D bpf_map__def(prog_array)->max_entries - 1 - i;
+	for (i =3D 0; i < bpf_map__max_entries(prog_array); i++) {
+		j =3D bpf_map__max_entries(prog_array) - 1 - i;
 		snprintf(prog_name, sizeof(prog_name), "classifier_%d", j);
=20
 		prog =3D bpf_object__find_program_by_name(obj, prog_name);
@@ -107,8 +107,8 @@ static void test_tailcall_1(void)
 			goto out;
 	}
=20
-	for (i =3D 0; i < bpf_map__def(prog_array)->max_entries; i++) {
-		j =3D bpf_map__def(prog_array)->max_entries - 1 - i;
+	for (i =3D 0; i < bpf_map__max_entries(prog_array); i++) {
+		j =3D bpf_map__max_entries(prog_array) - 1 - i;
=20
 		err =3D bpf_prog_test_run(main_fd, 1, buff, sizeof(buff), 0,
 					&duration, &retval, NULL);
@@ -125,7 +125,7 @@ static void test_tailcall_1(void)
 	CHECK(err || retval !=3D 3, "tailcall", "err %d errno %d retval %d\n",
 	      err, errno, retval);
=20
-	for (i =3D 0; i < bpf_map__def(prog_array)->max_entries; i++) {
+	for (i =3D 0; i < bpf_map__max_entries(prog_array); i++) {
 		err =3D bpf_map_delete_elem(map_fd, &i);
 		if (CHECK_FAIL(err >=3D 0 || errno !=3D ENOENT))
 			goto out;
@@ -175,7 +175,7 @@ static void test_tailcall_2(void)
 	if (CHECK_FAIL(map_fd < 0))
 		goto out;
=20
-	for (i =3D 0; i < bpf_map__def(prog_array)->max_entries; i++) {
+	for (i =3D 0; i < bpf_map__max_entries(prog_array); i++) {
 		snprintf(prog_name, sizeof(prog_name), "classifier_%d", i);
=20
 		prog =3D bpf_object__find_program_by_name(obj, prog_name);
@@ -353,7 +353,7 @@ static void test_tailcall_4(void)
 	if (CHECK_FAIL(map_fd < 0))
 		return;
=20
-	for (i =3D 0; i < bpf_map__def(prog_array)->max_entries; i++) {
+	for (i =3D 0; i < bpf_map__max_entries(prog_array); i++) {
 		snprintf(prog_name, sizeof(prog_name), "classifier_%d", i);
=20
 		prog =3D bpf_object__find_program_by_name(obj, prog_name);
@@ -369,7 +369,7 @@ static void test_tailcall_4(void)
 			goto out;
 	}
=20
-	for (i =3D 0; i < bpf_map__def(prog_array)->max_entries; i++) {
+	for (i =3D 0; i < bpf_map__max_entries(prog_array); i++) {
 		err =3D bpf_map_update_elem(data_fd, &zero, &i, BPF_ANY);
 		if (CHECK_FAIL(err))
 			goto out;
@@ -380,7 +380,7 @@ static void test_tailcall_4(void)
 		      "err %d errno %d retval %d\n", err, errno, retval);
 	}
=20
-	for (i =3D 0; i < bpf_map__def(prog_array)->max_entries; i++) {
+	for (i =3D 0; i < bpf_map__max_entries(prog_array); i++) {
 		err =3D bpf_map_update_elem(data_fd, &zero, &i, BPF_ANY);
 		if (CHECK_FAIL(err))
 			goto out;
@@ -441,7 +441,7 @@ static void test_tailcall_5(void)
 	if (CHECK_FAIL(map_fd < 0))
 		return;
=20
-	for (i =3D 0; i < bpf_map__def(prog_array)->max_entries; i++) {
+	for (i =3D 0; i < bpf_map__max_entries(prog_array); i++) {
 		snprintf(prog_name, sizeof(prog_name), "classifier_%d", i);
=20
 		prog =3D bpf_object__find_program_by_name(obj, prog_name);
@@ -457,7 +457,7 @@ static void test_tailcall_5(void)
 			goto out;
 	}
=20
-	for (i =3D 0; i < bpf_map__def(prog_array)->max_entries; i++) {
+	for (i =3D 0; i < bpf_map__max_entries(prog_array); i++) {
 		err =3D bpf_map_update_elem(data_fd, &zero, &key[i], BPF_ANY);
 		if (CHECK_FAIL(err))
 			goto out;
@@ -468,7 +468,7 @@ static void test_tailcall_5(void)
 		      "err %d errno %d retval %d\n", err, errno, retval);
 	}
=20
-	for (i =3D 0; i < bpf_map__def(prog_array)->max_entries; i++) {
+	for (i =3D 0; i < bpf_map__max_entries(prog_array); i++) {
 		err =3D bpf_map_update_elem(data_fd, &zero, &key[i], BPF_ANY);
 		if (CHECK_FAIL(err))
 			goto out;
@@ -520,7 +520,7 @@ static void test_tailcall_bpf2bpf_1(void)
 		goto out;
=20
 	/* nop -> jmp */
-	for (i =3D 0; i < bpf_map__def(prog_array)->max_entries; i++) {
+	for (i =3D 0; i < bpf_map__max_entries(prog_array); i++) {
 		snprintf(prog_name, sizeof(prog_name), "classifier_%d", i);
=20
 		prog =3D bpf_object__find_program_by_name(obj, prog_name);
@@ -681,7 +681,7 @@ static void test_tailcall_bpf2bpf_3(void)
 	if (CHECK_FAIL(map_fd < 0))
 		goto out;
=20
-	for (i =3D 0; i < bpf_map__def(prog_array)->max_entries; i++) {
+	for (i =3D 0; i < bpf_map__max_entries(prog_array); i++) {
 		snprintf(prog_name, sizeof(prog_name), "classifier_%d", i);
=20
 		prog =3D bpf_object__find_program_by_name(obj, prog_name);
@@ -778,7 +778,7 @@ static void test_tailcall_bpf2bpf_4(bool noise)
 	if (CHECK_FAIL(map_fd < 0))
 		goto out;
=20
-	for (i =3D 0; i < bpf_map__def(prog_array)->max_entries; i++) {
+	for (i =3D 0; i < bpf_map__max_entries(prog_array); i++) {
 		snprintf(prog_name, sizeof(prog_name), "classifier_%d", i);
=20
 		prog =3D bpf_object__find_program_by_name(obj, prog_name);
--=20
2.30.2


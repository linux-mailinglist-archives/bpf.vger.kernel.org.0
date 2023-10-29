Return-Path: <bpf+bounces-13563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D2E7DAA56
	for <lists+bpf@lfdr.de>; Sun, 29 Oct 2023 02:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 513541C209AB
	for <lists+bpf@lfdr.de>; Sun, 29 Oct 2023 01:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17BD39A;
	Sun, 29 Oct 2023 01:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DBD194
	for <bpf@vger.kernel.org>; Sun, 29 Oct 2023 01:15:27 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1C8D6
	for <bpf@vger.kernel.org>; Sat, 28 Oct 2023 18:15:26 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39T0YCrX027214
	for <bpf@vger.kernel.org>; Sat, 28 Oct 2023 18:15:26 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u0ydyu1t9-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sat, 28 Oct 2023 18:15:25 -0700
Received: from twshared15991.38.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 28 Oct 2023 18:15:24 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 355C03A8B9BA1; Sat, 28 Oct 2023 18:15:10 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next] selftests/bpf: fix test_maps' use of bpf_map_create_opts
Date: Sat, 28 Oct 2023 18:15:09 -0700
Message-ID: <20231029011509.2479232-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: dovXkb5AtFytLUnjZNfXVC1GlvfE-NSa
X-Proofpoint-GUID: dovXkb5AtFytLUnjZNfXVC1GlvfE-NSa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-28_24,2023-10-27_01,2023-05-22_02

Use LIBBPF_OPTS() macro to properly initialize bpf_map_create_opts in
test_maps' tests.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/map_tests/map_percpu_stats.c          | 20 +++++--------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/map_tests/map_percpu_stats.c b/t=
ools/testing/selftests/bpf/map_tests/map_percpu_stats.c
index 1a9eeefda9a8..8bf497a9843e 100644
--- a/tools/testing/selftests/bpf/map_tests/map_percpu_stats.c
+++ b/tools/testing/selftests/bpf/map_tests/map_percpu_stats.c
@@ -326,20 +326,14 @@ static int map_create(__u32 type, const char *name,=
 struct bpf_map_create_opts *
=20
 static int create_hash(void)
 {
-	struct bpf_map_create_opts map_opts =3D {
-		.sz =3D sizeof(map_opts),
-		.map_flags =3D BPF_F_NO_PREALLOC,
-	};
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts, .map_flags =3D BPF_F_NO_PREA=
LLOC);
=20
 	return map_create(BPF_MAP_TYPE_HASH, "hash", &map_opts);
 }
=20
 static int create_percpu_hash(void)
 {
-	struct bpf_map_create_opts map_opts =3D {
-		.sz =3D sizeof(map_opts),
-		.map_flags =3D BPF_F_NO_PREALLOC,
-	};
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts, .map_flags =3D BPF_F_NO_PREA=
LLOC);
=20
 	return map_create(BPF_MAP_TYPE_PERCPU_HASH, "percpu_hash", &map_opts);
 }
@@ -356,21 +350,17 @@ static int create_percpu_hash_prealloc(void)
=20
 static int create_lru_hash(__u32 type, __u32 map_flags)
 {
-	struct bpf_map_create_opts map_opts =3D {
-		.sz =3D sizeof(map_opts),
-		.map_flags =3D map_flags,
-	};
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts, .map_flags =3D map_flags);
=20
 	return map_create(type, "lru_hash", &map_opts);
 }
=20
 static int create_hash_of_maps(void)
 {
-	struct bpf_map_create_opts map_opts =3D {
-		.sz =3D sizeof(map_opts),
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts,
 		.map_flags =3D BPF_F_NO_PREALLOC,
 		.inner_map_fd =3D create_small_hash(),
-	};
+	);
 	int ret;
=20
 	ret =3D map_create_opts(BPF_MAP_TYPE_HASH_OF_MAPS, "hash_of_maps",
--=20
2.34.1



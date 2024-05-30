Return-Path: <bpf+bounces-30905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6A48D45BA
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 09:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C6FA1C21A02
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 07:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E3E3DABFA;
	Thu, 30 May 2024 07:05:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAF8143727
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 07:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717052734; cv=none; b=D7l6mUmetUimhhG37u6KU+31gydkfPNouFJ0sLPLW4r5EWl0r0UWTy4ga3tk7JRv6e/fJ1WHz+YAvOdhjafbBryoaXvXzek1W7Wrm3CvfExNnet4HMfq4G46SLX2nfHjJ9B4jzalLuBee54LFNX8Y9v1IMxVY34/oifsQP/d9tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717052734; c=relaxed/simple;
	bh=c4MvaUpjPHMpNuWx8zg6N0T/rGHgEXl1XQtb+cBPDDA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RToc0AhGd5jCzSuofwMJ674UjG9PuPWYmsQDyagkla90C41wNUaCP5ppuoiFt57eyU/6WIJdAFx7XhWEXou3WCkIcCdb5skkYIuhmJ4LtjsRUf+scUa9Y34s/YK7j2fMyjgmvCs2/LwyehR1SKOuq/hJgVnMmIG+j6sBcXI12hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=meta.com; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44U3oWAG029385
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 00:05:32 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3yehw5gnu9-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 00:05:32 -0700
Received: from twshared18280.38.frc1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 30 May 2024 07:05:05 +0000
Received: by devbig1475.frc2.facebook.com (Postfix, from userid 460691)
	id 22B9E5DFFBEB; Thu, 30 May 2024 00:04:50 -0700 (PDT)
From: <thinker.li@gmail.com>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <kernel-team@meta.com>, <andrii@kernel.org>, <sinquersw@gmail.com>,
        <kuifeng@meta.com>, <thinker.li@gmail.com>
Subject: [PATCH bpf-next v7 1/8] bpf: pass bpf_struct_ops_link to callbacks in bpf_struct_ops.
Date: Wed, 29 May 2024 23:59:39 -0700
Message-ID: <20240530065946.979330-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240530065946.979330-1-thinker.li@gmail.com>
References: <20240530065946.979330-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: WBJcOp0LDlIHIA41pdIKp53558k2zBu7
X-Proofpoint-GUID: WBJcOp0LDlIHIA41pdIKp53558k2zBu7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_04,2024-05-28_01,2024-05-17_01

From: Kui-Feng Lee <thinker.li@gmail.com>

Pass an additional pointer of bpf_struct_ops_link to callback function re=
g,
unreg, and update provided by subsystems defined in bpf_struct_ops. A
bpf_struct_ops_map can be registered for multiple links. Passing a pointe=
r
of bpf_struct_ops_link helps subsystems to distinguish them.

This pointer will be used in the later patches to let the subsystem
initiate a detachment on a link that was registered to it previously.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h                                    |  6 +++---
 kernel/bpf/bpf_struct_ops.c                            | 10 +++++-----
 net/bpf/bpf_dummy_struct_ops.c                         |  4 ++--
 net/ipv4/bpf_tcp_ca.c                                  |  6 +++---
 .../selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c    |  4 ++--
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c  |  6 +++---
 6 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5e694a308081..19f8836382fc 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1730,9 +1730,9 @@ struct bpf_struct_ops {
 	int (*init_member)(const struct btf_type *t,
 			   const struct btf_member *member,
 			   void *kdata, const void *udata);
-	int (*reg)(void *kdata);
-	void (*unreg)(void *kdata);
-	int (*update)(void *kdata, void *old_kdata);
+	int (*reg)(void *kdata, struct bpf_link *link);
+	void (*unreg)(void *kdata, struct bpf_link *link);
+	int (*update)(void *kdata, void *old_kdata, struct bpf_link *link);
 	int (*validate)(void *kdata);
 	void *cfi_stubs;
 	struct module *owner;
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 86c7884abaf8..1542dded7489 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -757,7 +757,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf=
_map *map, void *key,
 		goto unlock;
 	}
=20
-	err =3D st_ops->reg(kdata);
+	err =3D st_ops->reg(kdata, NULL);
 	if (likely(!err)) {
 		/* This refcnt increment on the map here after
 		 * 'st_ops->reg()' is secure since the state of the
@@ -805,7 +805,7 @@ static long bpf_struct_ops_map_delete_elem(struct bpf=
_map *map, void *key)
 			     BPF_STRUCT_OPS_STATE_TOBEFREE);
 	switch (prev_state) {
 	case BPF_STRUCT_OPS_STATE_INUSE:
-		st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data);
+		st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, NULL);
 		bpf_map_put(map);
 		return 0;
 	case BPF_STRUCT_OPS_STATE_TOBEFREE:
@@ -1060,7 +1060,7 @@ static void bpf_struct_ops_map_link_dealloc(struct =
bpf_link *link)
 		/* st_link->map can be NULL if
 		 * bpf_struct_ops_link_create() fails to register.
 		 */
-		st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data);
+		st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, link);
 		bpf_map_put(&st_map->map);
 	}
 	kfree(st_link);
@@ -1125,7 +1125,7 @@ static int bpf_struct_ops_map_link_update(struct bp=
f_link *link, struct bpf_map
 		goto err_out;
 	}
=20
-	err =3D st_map->st_ops_desc->st_ops->update(st_map->kvalue.data, old_st=
_map->kvalue.data);
+	err =3D st_map->st_ops_desc->st_ops->update(st_map->kvalue.data, old_st=
_map->kvalue.data, link);
 	if (err)
 		goto err_out;
=20
@@ -1176,7 +1176,7 @@ int bpf_struct_ops_link_create(union bpf_attr *attr=
)
 	if (err)
 		goto err_out;
=20
-	err =3D st_map->st_ops_desc->st_ops->reg(st_map->kvalue.data);
+	err =3D st_map->st_ops_desc->st_ops->reg(st_map->kvalue.data, &link->li=
nk);
 	if (err) {
 		bpf_link_cleanup(&link_primer);
 		link =3D NULL;
diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_op=
s.c
index 891cdf61c65a..3ea52b05adfb 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -272,12 +272,12 @@ static int bpf_dummy_init_member(const struct btf_t=
ype *t,
 	return -EOPNOTSUPP;
 }
=20
-static int bpf_dummy_reg(void *kdata)
+static int bpf_dummy_reg(void *kdata, struct bpf_link *link)
 {
 	return -EOPNOTSUPP;
 }
=20
-static void bpf_dummy_unreg(void *kdata)
+static void bpf_dummy_unreg(void *kdata, struct bpf_link *link)
 {
 }
=20
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 18227757ec0c..3f88d0961e5b 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -260,17 +260,17 @@ static int bpf_tcp_ca_check_member(const struct btf=
_type *t,
 	return 0;
 }
=20
-static int bpf_tcp_ca_reg(void *kdata)
+static int bpf_tcp_ca_reg(void *kdata, struct bpf_link *link)
 {
 	return tcp_register_congestion_control(kdata);
 }
=20
-static void bpf_tcp_ca_unreg(void *kdata)
+static void bpf_tcp_ca_unreg(void *kdata, struct bpf_link *link)
 {
 	tcp_unregister_congestion_control(kdata);
 }
=20
-static int bpf_tcp_ca_update(void *kdata, void *old_kdata)
+static int bpf_tcp_ca_update(void *kdata, void *old_kdata, struct bpf_li=
nk *link)
 {
 	return tcp_update_congestion_control(kdata, old_kdata);
 }
diff --git a/tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.=
c b/tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c
index b1dd889d5d7d..948eb3962732 100644
--- a/tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c
+++ b/tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c
@@ -22,12 +22,12 @@ static int dummy_init_member(const struct btf_type *t=
,
 	return 0;
 }
=20
-static int dummy_reg(void *kdata)
+static int dummy_reg(void *kdata, struct bpf_link *link)
 {
 	return 0;
 }
=20
-static void dummy_unreg(void *kdata)
+static void dummy_unreg(void *kdata, struct bpf_link *link)
 {
 }
=20
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tool=
s/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 2a18bd320e92..0a09732cde4b 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -820,7 +820,7 @@ static const struct bpf_verifier_ops bpf_testmod_veri=
fier_ops =3D {
 	.is_valid_access =3D bpf_testmod_ops_is_valid_access,
 };
=20
-static int bpf_dummy_reg(void *kdata)
+static int bpf_dummy_reg(void *kdata, struct bpf_link *link)
 {
 	struct bpf_testmod_ops *ops =3D kdata;
=20
@@ -835,7 +835,7 @@ static int bpf_dummy_reg(void *kdata)
 	return 0;
 }
=20
-static void bpf_dummy_unreg(void *kdata)
+static void bpf_dummy_unreg(void *kdata, struct bpf_link *link)
 {
 }
=20
@@ -871,7 +871,7 @@ struct bpf_struct_ops bpf_bpf_testmod_ops =3D {
 	.owner =3D THIS_MODULE,
 };
=20
-static int bpf_dummy_reg2(void *kdata)
+static int bpf_dummy_reg2(void *kdata, struct bpf_link *link)
 {
 	struct bpf_testmod_ops2 *ops =3D kdata;
=20
--=20
2.43.0



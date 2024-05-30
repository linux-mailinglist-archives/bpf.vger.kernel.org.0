Return-Path: <bpf+bounces-30898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9408D45B3
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 09:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860731F2247D
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 07:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B7F21C160;
	Thu, 30 May 2024 07:05:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B1747779
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 07:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717052710; cv=none; b=DnCI93I749CDphdb3g1lL4atmrB2joWGYXpt2TGpH4VtrpOTAv9S0ePEnocg7M5mSqku04L1REMZV/zpUJi7FOfFGUj08fxUNmGG47gJlvLhttpdhquN1J2zmKEX9YPoRsP5zp/yWx2Pb257KY+uKSyZGXN20/AvxQ7dsJwWVZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717052710; c=relaxed/simple;
	bh=J83ZZzPHhklB6H+3ztnap9bNqVf3n2jJy0YCE5MS/HA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hxCK5Hf+6FVV++awIb1uWz3JxTsiHCDkEsqvbvhE2ErEV6iO5aLOULzD81eXb7KblEKC03xxTB+z/sGT+/WCok5qDRcoz+v3H9tqPUy6wybgrF2c/o/nOe9SvDvt4TbuBOcfuZRxtXEoKVjT4FrrEPx634DWY/S9RsJP7ZLDCuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=meta.com; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44U69Kom025842
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 00:05:08 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3yekxf85v5-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 00:05:08 -0700
Received: from twshared20084.14.frc2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 30 May 2024 07:04:53 +0000
Received: by devbig1475.frc2.facebook.com (Postfix, from userid 460691)
	id 72BBF5DFFBEF; Thu, 30 May 2024 00:04:51 -0700 (PDT)
From: <thinker.li@gmail.com>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <kernel-team@meta.com>, <andrii@kernel.org>, <sinquersw@gmail.com>,
        <kuifeng@meta.com>, <thinker.li@gmail.com>
Subject: [PATCH bpf-next v7 2/8] bpf: enable detaching links of struct_ops objects.
Date: Wed, 29 May 2024 23:59:40 -0700
Message-ID: <20240530065946.979330-3-thinker.li@gmail.com>
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
X-Proofpoint-ORIG-GUID: A_1cIzyJ0pA0Bf8DqTdE-jlMGS3AI-qU
X-Proofpoint-GUID: A_1cIzyJ0pA0Bf8DqTdE-jlMGS3AI-qU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_04,2024-05-28_01,2024-05-17_01

From: Kui-Feng Lee <thinker.li@gmail.com>

Implement the detach callback in bpf_link_ops for struct_ops so that user
programs can detach a struct_ops link. The subsystems that struct_ops
objects are registered to can also use this callback to detach the links
being passed to them.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/bpf_struct_ops.c | 45 ++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 1542dded7489..5ea35608326f 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -1057,9 +1057,6 @@ static void bpf_struct_ops_map_link_dealloc(struct =
bpf_link *link)
 	st_map =3D (struct bpf_struct_ops_map *)
 		rcu_dereference_protected(st_link->map, true);
 	if (st_map) {
-		/* st_link->map can be NULL if
-		 * bpf_struct_ops_link_create() fails to register.
-		 */
 		st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, link);
 		bpf_map_put(&st_map->map);
 	}
@@ -1075,7 +1072,8 @@ static void bpf_struct_ops_map_link_show_fdinfo(con=
st struct bpf_link *link,
 	st_link =3D container_of(link, struct bpf_struct_ops_link, link);
 	rcu_read_lock();
 	map =3D rcu_dereference(st_link->map);
-	seq_printf(seq, "map_id:\t%d\n", map->id);
+	if (map)
+		seq_printf(seq, "map_id:\t%d\n", map->id);
 	rcu_read_unlock();
 }
=20
@@ -1088,7 +1086,8 @@ static int bpf_struct_ops_map_link_fill_link_info(c=
onst struct bpf_link *link,
 	st_link =3D container_of(link, struct bpf_struct_ops_link, link);
 	rcu_read_lock();
 	map =3D rcu_dereference(st_link->map);
-	info->struct_ops.map_id =3D map->id;
+	if (map)
+		info->struct_ops.map_id =3D map->id;
 	rcu_read_unlock();
 	return 0;
 }
@@ -1113,6 +1112,10 @@ static int bpf_struct_ops_map_link_update(struct b=
pf_link *link, struct bpf_map
 	mutex_lock(&update_mutex);
=20
 	old_map =3D rcu_dereference_protected(st_link->map, lockdep_is_held(&up=
date_mutex));
+	if (!old_map) {
+		err =3D -ENOLINK;
+		goto err_out;
+	}
 	if (expected_old_map && old_map !=3D expected_old_map) {
 		err =3D -EPERM;
 		goto err_out;
@@ -1139,8 +1142,37 @@ static int bpf_struct_ops_map_link_update(struct b=
pf_link *link, struct bpf_map
 	return err;
 }
=20
+static int bpf_struct_ops_map_link_detach(struct bpf_link *link)
+{
+	struct bpf_struct_ops_link *st_link =3D container_of(link, struct bpf_s=
truct_ops_link, link);
+	struct bpf_struct_ops_map *st_map;
+	struct bpf_map *map;
+
+	mutex_lock(&update_mutex);
+
+	map =3D rcu_dereference_protected(st_link->map, lockdep_is_held(&update=
_mutex));
+	if (!map) {
+		mutex_unlock(&update_mutex);
+		return 0;
+	}
+	st_map =3D container_of(map, struct bpf_struct_ops_map, map);
+
+	st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, link);
+
+	rcu_assign_pointer(st_link->map, NULL);
+	/* Pair with bpf_map_get() in bpf_struct_ops_link_create() or
+	 * bpf_map_inc() in bpf_struct_ops_map_link_update().
+	 */
+	bpf_map_put(&st_map->map);
+
+	mutex_unlock(&update_mutex);
+
+	return 0;
+}
+
 static const struct bpf_link_ops bpf_struct_ops_map_lops =3D {
 	.dealloc =3D bpf_struct_ops_map_link_dealloc,
+	.detach =3D bpf_struct_ops_map_link_detach,
 	.show_fdinfo =3D bpf_struct_ops_map_link_show_fdinfo,
 	.fill_link_info =3D bpf_struct_ops_map_link_fill_link_info,
 	.update_map =3D bpf_struct_ops_map_link_update,
@@ -1176,13 +1208,16 @@ int bpf_struct_ops_link_create(union bpf_attr *at=
tr)
 	if (err)
 		goto err_out;
=20
+	mutex_lock(&update_mutex);
 	err =3D st_map->st_ops_desc->st_ops->reg(st_map->kvalue.data, &link->li=
nk);
 	if (err) {
+		mutex_unlock(&update_mutex);
 		bpf_link_cleanup(&link_primer);
 		link =3D NULL;
 		goto err_out;
 	}
 	RCU_INIT_POINTER(link->map, map);
+	mutex_unlock(&update_mutex);
=20
 	return bpf_link_settle(&link_primer);
=20
--=20
2.43.0



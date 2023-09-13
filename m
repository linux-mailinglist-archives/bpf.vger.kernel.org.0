Return-Path: <bpf+bounces-9968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8D979F4E4
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 00:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEAF41F21745
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 22:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA6327710;
	Wed, 13 Sep 2023 22:27:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E6229CA
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 22:27:03 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B931BCB
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 15:27:02 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DIS8U2003231
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 15:27:02 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3t3363asf7-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 15:27:02 -0700
Received: from twshared52565.14.frc2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 13 Sep 2023 15:27:00 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
	id CC41D244DF337; Wed, 13 Sep 2023 15:26:51 -0700 (PDT)
From: Song Liu <song@kernel.org>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <kernel-team@meta.com>,
        Song Liu <song@kernel.org>
Subject: [PATCH bpf-next] bpf: Charge modmem for struct_ops trampoline
Date: Wed, 13 Sep 2023 15:26:32 -0700
Message-ID: <20230913222632.3312183-1-song@kernel.org>
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
X-Proofpoint-ORIG-GUID: BUjCDn4xe2Qqg9ANubnSviSiCd_djC6-
X-Proofpoint-GUID: BUjCDn4xe2Qqg9ANubnSviSiCd_djC6-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_17,2023-09-13_01,2023-05-22_02

Current code charges modmem for regular trampoline, but not for struct_op=
s
trampoline. Add bpf_jit_[charge|uncharge]_modmem() to struct_ops so the
trampoline is charged in both cases.

Signed-off-by: Song Liu <song@kernel.org>
---
 kernel/bpf/bpf_struct_ops.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index fdc3e8705a3c..ea6ca87a2ed9 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -615,7 +615,10 @@ static void __bpf_struct_ops_map_free(struct bpf_map=
 *map)
 	if (st_map->links)
 		bpf_struct_ops_map_put_progs(st_map);
 	bpf_map_area_free(st_map->links);
-	bpf_jit_free_exec(st_map->image);
+	if (st_map->image) {
+		bpf_jit_free_exec(st_map->image);
+		bpf_jit_uncharge_modmem(PAGE_SIZE);
+	}
 	bpf_map_area_free(st_map->uvalue);
 	bpf_map_area_free(st_map);
 }
@@ -657,6 +660,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union=
 bpf_attr *attr)
 	struct bpf_struct_ops_map *st_map;
 	const struct btf_type *t, *vt;
 	struct bpf_map *map;
+	int ret;
=20
 	st_ops =3D bpf_struct_ops_find_value(attr->btf_vmlinux_value_type_id);
 	if (!st_ops)
@@ -681,6 +685,12 @@ static struct bpf_map *bpf_struct_ops_map_alloc(unio=
n bpf_attr *attr)
 	st_map->st_ops =3D st_ops;
 	map =3D &st_map->map;
=20
+	ret =3D bpf_jit_charge_modmem(PAGE_SIZE);
+	if (ret) {
+		__bpf_struct_ops_map_free(map);
+		return ERR_PTR(ret);
+	}
+
 	st_map->uvalue =3D bpf_map_area_alloc(vt->size, NUMA_NO_NODE);
 	st_map->links =3D
 		bpf_map_area_alloc(btf_type_vlen(t) * sizeof(struct bpf_links *),
@@ -907,4 +917,3 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 	kfree(link);
 	return err;
 }
-
--=20
2.34.1



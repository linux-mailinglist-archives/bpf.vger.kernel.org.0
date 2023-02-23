Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21ED06A007B
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 02:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbjBWBND (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 20:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjBWBNC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 20:13:02 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A19769B
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 17:13:01 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 31MNC7ea020466
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 17:13:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=DsA0yP4DYVtrC7j2kQbeoPGw5gxnkaT42Cu/MPsMZBM=;
 b=d7AofC5qJjx2T4Ej5o7hZIGJXKtitSq5MwOLU6CdyOl+rfq6qo6XN3dIe6Y/J8Rqxz+C
 3JU5HSsMz6XrEZ07pzH4+1fcLIPIgNPcLLbHis+tzDQEa/qT36QcIjqMxq/fpjJlNE9D
 9OMlaVes5TYslrgvozAw9Ft2J6D6SirvsP0pU+Spe9gaRIONn2oCxvVMdfty9mScW7FD
 fNVhCwscA4sR296yvmK8Nli5gSZUk+M56SglSjl9Baaz4rEAau5InUW3cKQtjqLAno+B
 kWfa6q19mbWeomy1shHi2MGUTPJIpOcv+20NlHfJTx4Rtg6G4b0ALM8Ro9LJEOVKuz8Z Pg== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3nw5n4sd6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 17:13:00 -0800
Received: from twshared16996.15.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 22 Feb 2023 17:12:59 -0800
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 113C85BD8CFF; Wed, 22 Feb 2023 17:12:41 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <song@kernel.org>, <kernel-team@meta.com>, <andrii@kernel.org>,
        <sdf@google.com>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v2 4/6] bpf: Update the struct_ops of a bpf_link.
Date:   Wed, 22 Feb 2023 17:12:36 -0800
Message-ID: <20230223011238.12313-5-kuifeng@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230223011238.12313-1-kuifeng@meta.com>
References: <20230223011238.12313-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: e0gXe6xXgc5Wl8_oaP3bMN5WzwIN5tax
X-Proofpoint-GUID: e0gXe6xXgc5Wl8_oaP3bMN5WzwIN5tax
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_12,2023-02-22_02,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

By improving the BPF_LINK_UPDATE command of bpf(), it should allow you
to conveniently switch between different struct_ops on a single
bpf_link. This would enable smoother transitions from one struct_ops
to another.

The struct_ops maps passing along with BPF_LINK_UPDATE should have the
BPF_F_LINK flag.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 include/linux/bpf.h         |  1 +
 include/uapi/linux/bpf.h    |  8 +++--
 kernel/bpf/bpf_struct_ops.c | 69 +++++++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c        | 32 +++++++++++++++++
 4 files changed, 108 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7508ca89e814..9797d9d87a3e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1409,6 +1409,7 @@ struct bpf_link_ops {
 	void (*show_fdinfo)(const struct bpf_link *link, struct seq_file *seq);
 	int (*fill_link_info)(const struct bpf_link *link,
 			      struct bpf_link_info *info);
+	int (*update_struct_ops)(struct bpf_link *link, struct bpf_map *new_map=
);
 };
=20
 struct bpf_tramp_link {
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index cd0ff39981e8..0702e88f7c08 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1555,8 +1555,12 @@ union bpf_attr {
=20
 	struct { /* struct used by BPF_LINK_UPDATE command */
 		__u32		link_fd;	/* link fd */
-		/* new program fd to update link with */
-		__u32		new_prog_fd;
+		union {
+			/* new program fd to update link with */
+			__u32		new_prog_fd;
+			/* new struct_ops map fd to update link with */
+			__u32           new_map_fd;
+		};
 		__u32		flags;		/* extra flags */
 		/* expected link's program fd; is specified only if
 		 * BPF_F_REPLACE flag is set in flags */
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index cfc69033c1b8..700dc95a6daa 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -961,11 +961,80 @@ static int bpf_struct_ops_map_link_fill_link_info(c=
onst struct bpf_link *link,
 	return 0;
 }
=20
+static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct =
bpf_map *new_map)
+{
+	struct bpf_struct_ops_value *kvalue;
+	struct bpf_struct_ops_map *st_map, *old_st_map;
+	struct bpf_struct_ops_link *st_link;
+	struct bpf_map *old_map;
+	int err =3D 0;
+
+	if (new_map->map_type !=3D BPF_MAP_TYPE_STRUCT_OPS)
+		return -EINVAL;
+
+	/* Ensure that the registration of the struct_ops matches the
+	 * value of the pointer within the link.
+	 */
+	mutex_lock(&update_mutex);
+
+	st_link =3D container_of(link, struct bpf_struct_ops_link, link);
+
+	old_map =3D st_link->map;
+	if (!old_map) {
+		err =3D -EINVAL;
+		goto err_out;
+	}
+
+	/* The new and old struct_ops must be the same type. */
+	st_map =3D container_of(new_map, struct bpf_struct_ops_map, map);
+
+	if (!(new_map->map_flags & BPF_F_LINK)) {
+		err =3D -EINVAL;
+		goto err_out;
+	}
+
+	old_st_map =3D container_of(old_map, struct bpf_struct_ops_map, map);
+	if (st_map->st_ops !=3D old_st_map->st_ops) {
+		err =3D -EINVAL;
+		goto err_out;
+	}
+
+	err =3D bpf_struct_ops_transit_state_check(st_map, BPF_STRUCT_OPS_STATE=
_UNREG,
+						 BPF_STRUCT_OPS_STATE_INUSE);
+	if (err)
+		goto err_out;
+
+	kvalue =3D &st_map->kvalue;
+
+	set_memory_rox((long)st_map->image, 1);
+	err =3D st_map->st_ops->update(kvalue->data, old_st_map->kvalue.data);
+	if (err) {
+		bpf_struct_ops_restore_unreg(st_map);
+
+		set_memory_nx((long)st_map->image, 1);
+		set_memory_rw((long)st_map->image, 1);
+		goto err_out;
+	}
+
+	bpf_map_inc(new_map);
+	rcu_assign_pointer(st_link->map, new_map);
+
+	bpf_struct_ops_transit_state(old_st_map, BPF_STRUCT_OPS_STATE_INUSE,
+				     BPF_STRUCT_OPS_STATE_TOBEUNREG);
+	bpf_struct_ops_put(&old_st_map->kvalue.data);
+
+err_out:
+	mutex_unlock(&update_mutex);
+
+	return err;
+}
+
 static const struct bpf_link_ops bpf_struct_ops_map_lops =3D {
 	.dealloc =3D bpf_struct_ops_map_link_dealloc,
 	.detach =3D bpf_struct_ops_map_link_detach,
 	.show_fdinfo =3D bpf_struct_ops_map_link_show_fdinfo,
 	.fill_link_info =3D bpf_struct_ops_map_link_fill_link_info,
+	.update_struct_ops =3D bpf_struct_ops_map_link_update,
 };
=20
 int bpf_struct_ops_link_create(union bpf_attr *attr)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 2670de8dd0d4..423e6b7a6b41 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4647,6 +4647,30 @@ static int link_create(union bpf_attr *attr, bpfpt=
r_t uattr)
 	return ret;
 }
=20
+static int link_update_struct_ops(struct bpf_link *link, union bpf_attr =
*attr)
+{
+	struct bpf_map *new_map;
+	int ret =3D 0;
+
+	new_map =3D bpf_map_get(attr->link_update.new_map_fd);
+	if (IS_ERR(new_map))
+		return -EINVAL;
+
+	if (new_map->map_type !=3D BPF_MAP_TYPE_STRUCT_OPS) {
+		ret =3D -EINVAL;
+		goto out_put_map;
+	}
+
+	if (link->ops->update_struct_ops)
+		ret =3D link->ops->update_struct_ops(link, new_map);
+	else
+		ret =3D -EINVAL;
+
+out_put_map:
+	bpf_map_put(new_map);
+	return ret;
+}
+
 #define BPF_LINK_UPDATE_LAST_FIELD link_update.old_prog_fd
=20
 static int link_update(union bpf_attr *attr)
@@ -4667,6 +4691,14 @@ static int link_update(union bpf_attr *attr)
 	if (IS_ERR(link))
 		return PTR_ERR(link);
=20
+	if (link->ops->update_struct_ops) {
+		if (flags)	/* always replace the existing one */
+			ret =3D -EINVAL;
+		else
+			ret =3D link_update_struct_ops(link, attr);
+		goto out_put_link;
+	}
+
 	new_prog =3D bpf_prog_get(attr->link_update.new_prog_fd);
 	if (IS_ERR(new_prog)) {
 		ret =3D PTR_ERR(new_prog);
--=20
2.30.2


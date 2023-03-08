Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A2E6AFB95
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 01:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjCHAxq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 19:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjCHAxp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 19:53:45 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7D1984C5
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 16:53:43 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32800e0e023549
        for <bpf@vger.kernel.org>; Tue, 7 Mar 2023 16:53:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=y19padtCiXBhWeTHeZaIQKUnIyNQqGgu8ga+f3l70xY=;
 b=iB6kwo7eje9fkWXPcdcMIevyKpn/ZkBlTxkqpkKiGh4F9sMSPBvI5BxWAuz/+jGSrbrA
 khD/3uo7GZmXjJA4Qks9krmlZ4NONgQ4RgSWD+KJEUdt7daJcsivoo5hvOA8OZjdDUty
 rvxmZzCZzpn4SaZRAYRAWF4sbr+nD9jrgkguaqi1A2htZWAdVwOQMZlyX4QK3Vux0OsW
 OPted16Faem880ay6yU5WDsdsrWNKu4cuRmJKZzHVM4M06pqoCO99h39lgVLQtHPWyg7
 LelvZRGCjSX1FHkG0tlBp5rrFSj3PYYW3/gvdRCqhlp8oftrn5mk4Nu/pMusWRGdWHzt 0Q== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p6fekg8pq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 16:53:42 -0800
Received: from twshared33736.38.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 7 Mar 2023 16:53:41 -0800
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id A0A716C92E1C; Tue,  7 Mar 2023 16:50:54 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <song@kernel.org>, <kernel-team@meta.com>, <andrii@kernel.org>,
        <sdf@google.com>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v5 5/8] bpf: Update the struct_ops of a bpf_link.
Date:   Tue, 7 Mar 2023 16:50:47 -0800
Message-ID: <20230308005050.255859-6-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308005050.255859-1-kuifeng@meta.com>
References: <20230308005050.255859-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 5Le3zePsQguySn2_aY8JgE290AB9mWz3
X-Proofpoint-ORIG-GUID: 5Le3zePsQguySn2_aY8JgE290AB9mWz3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_18,2023-03-07_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       |  8 ++++--
 kernel/bpf/bpf_struct_ops.c    | 46 ++++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c           | 43 ++++++++++++++++++++++++++++---
 tools/include/uapi/linux/bpf.h |  7 +++++-
 5 files changed, 98 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index afca6c526fe4..29d555a82bad 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1470,6 +1470,7 @@ struct bpf_link_ops {
 	void (*show_fdinfo)(const struct bpf_link *link, struct seq_file *seq);
 	int (*fill_link_info)(const struct bpf_link *link,
 			      struct bpf_link_info *info);
+	int (*update_map)(struct bpf_link *link, struct bpf_map *new_map);
 };
=20
 struct bpf_tramp_link {
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index f9fc7b8af3c4..edef9cf7d596 100644
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
index 5a7e86cf67b5..79e663869e51 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -775,10 +775,56 @@ static int bpf_struct_ops_map_link_fill_link_info(c=
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
+	if (new_map->map_type !=3D BPF_MAP_TYPE_STRUCT_OPS ||
+	    !(new_map->map_flags & BPF_F_LINK))
+		return -EINVAL;
+
+	mutex_lock(&update_mutex);
+
+	st_link =3D container_of(link, struct bpf_struct_ops_link, link);
+
+	/* The new and old struct_ops must be the same type. */
+	st_map =3D container_of(new_map, struct bpf_struct_ops_map, map);
+
+	old_map =3D st_link->map;
+	old_st_map =3D container_of(old_map, struct bpf_struct_ops_map, map);
+	if (st_map->st_ops !=3D old_st_map->st_ops ||
+	    /* Pair with smp_store_release() during map_update */
+	    smp_load_acquire(&st_map->kvalue.state) !=3D BPF_STRUCT_OPS_STATE_R=
EADY) {
+		err =3D -EINVAL;
+		goto err_out;
+	}
+
+	kvalue =3D &st_map->kvalue;
+
+	err =3D st_map->st_ops->update(kvalue->data, old_st_map->kvalue.data);
+	if (err)
+		goto err_out;
+
+	bpf_map_inc(new_map);
+	rcu_assign_pointer(st_link->map, new_map);
+
+	bpf_map_put(old_map);
+
+err_out:
+	mutex_unlock(&update_mutex);
+
+	return err;
+}
+
 static const struct bpf_link_ops bpf_struct_ops_map_lops =3D {
 	.dealloc =3D bpf_struct_ops_map_link_dealloc,
 	.show_fdinfo =3D bpf_struct_ops_map_link_show_fdinfo,
 	.fill_link_info =3D bpf_struct_ops_map_link_fill_link_info,
+	.update_map =3D bpf_struct_ops_map_link_update,
 };
=20
 int bpf_struct_ops_link_create(union bpf_attr *attr)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 3a4503987a48..c087dd2e2c08 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4658,6 +4658,30 @@ static int link_create(union bpf_attr *attr, bpfpt=
r_t uattr)
 	return ret;
 }
=20
+static int link_update_map(struct bpf_link *link, union bpf_attr *attr)
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
+	if (link->ops->update_map)
+		ret =3D link->ops->update_map(link, new_map);
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
@@ -4670,14 +4694,25 @@ static int link_update(union bpf_attr *attr)
 	if (CHECK_ATTR(BPF_LINK_UPDATE))
 		return -EINVAL;
=20
-	flags =3D attr->link_update.flags;
-	if (flags & ~BPF_F_REPLACE)
-		return -EINVAL;
-
 	link =3D bpf_link_get_from_fd(attr->link_update.link_fd);
 	if (IS_ERR(link))
 		return PTR_ERR(link);
=20
+	flags =3D attr->link_update.flags;
+
+	if (link->ops->update_map) {
+		if (flags)	/* always replace the existing one */
+			ret =3D -EINVAL;
+		else
+			ret =3D link_update_map(link, attr);
+		goto out_put_link;
+	}
+
+	if (flags & ~BPF_F_REPLACE) {
+		ret =3D -EINVAL;
+		goto out_put_link;
+	}
+
 	new_prog =3D bpf_prog_get(attr->link_update.new_prog_fd);
 	if (IS_ERR(new_prog)) {
 		ret =3D PTR_ERR(new_prog);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 051b85525302..cfd1d2a9898d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1556,7 +1556,12 @@ union bpf_attr {
 	struct { /* struct used by BPF_LINK_UPDATE command */
 		__u32		link_fd;	/* link fd */
 		/* new program fd to update link with */
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
--=20
2.34.1


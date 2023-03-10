Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7026B35A6
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 05:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjCJEje (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 23:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjCJEjc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 23:39:32 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FF1101117
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 20:39:30 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 329MBKC8011784
        for <bpf@vger.kernel.org>; Thu, 9 Mar 2023 20:39:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=XCGNL9Qa+vhmNg3dPwXwX6TqsvdwMBZXTzII/n2ea6I=;
 b=XBaknEBYDHPUR7dIpOzEX8kzd6KIS8oP+YsaC5GQucAMyoEzbusPnsdaRT1vbK/j7lov
 iOFFXFQQK6IukHugFzyvWl4DkIcGy0TYLFc9tfVq4Kdn3dsterk2DzRZvKckqBSRg/AO
 4M5Wyt7Q+b9RmCZRpSsHdrjivuizHMNdsI+WGV6YPnLjiuw1i4p3id5bzeFwtHgFyTZO
 WYNFidUssllfT2W0oPsMsoqOOqDcgBK+SdurzK3imL0PlRBENAhuIImxPZ/oBy5DDuOy
 aUBfW209XMn/ZByC40y6XbAlLact2zVylg0m35TeILB3ahtcds12s89QATYR4Ht7tkG1 6w== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p7r1dhx90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 09 Mar 2023 20:39:30 -0800
Received: from twshared33736.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 9 Mar 2023 20:39:29 -0800
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id CDA306F6C2BC; Thu,  9 Mar 2023 20:39:24 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <song@kernel.org>, <kernel-team@meta.com>, <andrii@kernel.org>,
        <sdf@google.com>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v6 5/8] bpf: Update the struct_ops of a bpf_link.
Date:   Thu, 9 Mar 2023 20:38:10 -0800
Message-ID: <20230310043812.3087672-6-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310043812.3087672-1-kuifeng@meta.com>
References: <20230310043812.3087672-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: WTRDWd5yuFZh3bk4EexL2E5RY07w3Y4Q
X-Proofpoint-ORIG-GUID: WTRDWd5yuFZh3bk4EexL2E5RY07w3Y4Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_02,2023-03-09_01,2023-02-09_01
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
 include/uapi/linux/bpf.h       |  8 +++++--
 kernel/bpf/bpf_struct_ops.c    | 40 ++++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c           | 20 +++++++++++++++++
 tools/include/uapi/linux/bpf.h |  8 +++++--
 5 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 38f0c8ff726f..c3ef680cafd9 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1469,6 +1469,7 @@ struct bpf_link_ops {
 	void (*show_fdinfo)(const struct bpf_link *link, struct seq_file *seq);
 	int (*fill_link_info)(const struct bpf_link *link,
 			      struct bpf_link_info *info);
+	int (*update_map)(struct bpf_link *link, struct bpf_map *new_map);
 };
=20
 struct bpf_tramp_link {
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index dedd948de6a2..1539a7bdb83e 100644
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
index 888d6aefc31a..70202c85f8d9 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -64,6 +64,8 @@ struct bpf_struct_ops_link {
 	struct bpf_map __rcu *map;
 };
=20
+static DEFINE_MUTEX(update_mutex);
+
 #define VALUE_PREFIX "bpf_struct_ops_"
 #define VALUE_PREFIX_LEN (sizeof(VALUE_PREFIX) - 1)
=20
@@ -793,10 +795,48 @@ static int bpf_struct_ops_map_link_fill_link_info(c=
onst struct bpf_link *link,
 	return 0;
 }
=20
+static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct =
bpf_map *new_map)
+{
+	struct bpf_struct_ops_map *st_map, *old_st_map;
+	struct bpf_struct_ops_link *st_link;
+	struct bpf_map *old_map;
+	int err =3D 0;
+
+	st_link =3D container_of(link, struct bpf_struct_ops_link, link);
+	st_map =3D container_of(new_map, struct bpf_struct_ops_map, map);
+
+	if (!bpf_struct_ops_valid_to_reg(new_map))
+		return -EINVAL;
+
+	mutex_lock(&update_mutex);
+
+	old_map =3D rcu_dereference_protected(st_link->map, lockdep_is_held(&up=
date_mutex));
+	old_st_map =3D container_of(old_map, struct bpf_struct_ops_map, map);
+	/* The new and old struct_ops must be the same type. */
+	if (st_map->st_ops !=3D old_st_map->st_ops) {
+		err =3D -EINVAL;
+		goto err_out;
+	}
+
+	err =3D st_map->st_ops->update(st_map->kvalue.data, old_st_map->kvalue.=
data);
+	if (err)
+		goto err_out;
+
+	bpf_map_inc(new_map);
+	rcu_assign_pointer(st_link->map, new_map);
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
index 8d473af5ff42..f2602787dc43 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4660,6 +4660,21 @@ static int link_create(union bpf_attr *attr, bpfpt=
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
+	ret =3D link->ops->update_map(link, new_map);
+
+	bpf_map_put(new_map);
+	return ret;
+}
+
 #define BPF_LINK_UPDATE_LAST_FIELD link_update.old_prog_fd
=20
 static int link_update(union bpf_attr *attr)
@@ -4680,6 +4695,11 @@ static int link_update(union bpf_attr *attr)
 	if (IS_ERR(link))
 		return PTR_ERR(link);
=20
+	if (link->ops->update_map) {
+		ret =3D link_update_map(link, attr);
+		goto out_put_link;
+	}
+
 	new_prog =3D bpf_prog_get(attr->link_update.new_prog_fd);
 	if (IS_ERR(new_prog)) {
 		ret =3D PTR_ERR(new_prog);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index e75a3f66e9db..c53c685231a9 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
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
--=20
2.34.1


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713336C2180
	for <lists+bpf@lfdr.de>; Mon, 20 Mar 2023 20:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjCTTcK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Mar 2023 15:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjCTTbm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Mar 2023 15:31:42 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5681E9CA
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 12:24:31 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 32KH7YWQ016266
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 12:24:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=vn1LhLnQkaXKJ64wLJQbonIsDfiAR8u6DFNr2H90z1M=;
 b=JSIk95OgYc//sI4CccNWel5oa/Zbi26zd3jypR8wB+XoYKPcLVa60W6Ql2XQMY06gcS+
 aGJ8aVKV/jIFvxnNazszK5MWRVUbFEq72VndJhE9s/dTjxLq/qPEB7pfYpcJNMDYCFC4
 iDqzTzUj7sYzTZFNnSQmHXmXqXzyqcT3EzPYgGQxBBg7X0OBgPsciiCzZQjNxPwp1s4F
 vZ3Fz8IdAGznoh6Pfu+3nLmolY3XYBSX6fZB/9kgT/rWtwXoDmUwWNStl4nfygy/gyvb
 YMqSVsG1eLF204E+bRCUSSnEXPhVXL9TBeSGVtmHJL15/r25YKwKhwKAlXQ6TOPMMRx7 CA== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3pd8yyuq63-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 12:24:30 -0700
Received: from twshared21760.39.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 20 Mar 2023 12:24:28 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id C7C517D43603; Mon, 20 Mar 2023 12:24:12 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <song@kernel.org>, <kernel-team@meta.com>, <andrii@kernel.org>,
        <sdf@google.com>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v9 5/8] bpf: Update the struct_ops of a bpf_link.
Date:   Mon, 20 Mar 2023 12:24:07 -0700
Message-ID: <20230320192410.1624645-6-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230320192410.1624645-1-kuifeng@meta.com>
References: <20230320192410.1624645-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: BpeWnvxbhuay9gKsW7B81-TGMOVsJHdK
X-Proofpoint-ORIG-GUID: BpeWnvxbhuay9gKsW7B81-TGMOVsJHdK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_16,2023-03-20_02,2023-02-09_01
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
 include/linux/bpf.h            |  3 +++
 include/uapi/linux/bpf.h       | 21 +++++++++++----
 kernel/bpf/bpf_struct_ops.c    | 48 +++++++++++++++++++++++++++++++++-
 kernel/bpf/syscall.c           | 34 ++++++++++++++++++++++++
 net/ipv4/bpf_tcp_ca.c          |  6 +++++
 tools/include/uapi/linux/bpf.h | 21 +++++++++++----
 6 files changed, 122 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2faf01fa3f04..29287a2d8b1b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1476,6 +1476,8 @@ struct bpf_link_ops {
 	void (*show_fdinfo)(const struct bpf_link *link, struct seq_file *seq);
 	int (*fill_link_info)(const struct bpf_link *link,
 			      struct bpf_link_info *info);
+	int (*update_map)(struct bpf_link *link, struct bpf_map *new_map,
+			  struct bpf_map *old_map);
 };
=20
 struct bpf_tramp_link {
@@ -1518,6 +1520,7 @@ struct bpf_struct_ops {
 			   void *kdata, const void *udata);
 	int (*reg)(void *kdata);
 	void (*unreg)(void *kdata);
+	int (*update)(void *kdata, void *old_kdata);
 	int (*validate)(void *kdata);
 	const struct btf_type *type;
 	const struct btf_type *value_type;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 42f40ee083bf..e3d3b5160d26 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1555,12 +1555,23 @@ union bpf_attr {
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
-		/* expected link's program fd; is specified only if
-		 * BPF_F_REPLACE flag is set in flags */
-		__u32		old_prog_fd;
+		union {
+			/* expected link's program fd; is specified only if
+			 * BPF_F_REPLACE flag is set in flags.
+			 */
+			__u32		old_prog_fd;
+			/* expected link's map fd; is specified only
+			 * if BPF_F_REPLACE flag is set.
+			 */
+			__u32           old_map_fd;
+		};
 	} link_update;
=20
 	struct {
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index b50863b3ab77..b2aa9a0839b7 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -65,6 +65,8 @@ struct bpf_struct_ops_link {
 	struct bpf_map __rcu *map;
 };
=20
+static DEFINE_MUTEX(update_mutex);
+
 #define VALUE_PREFIX "bpf_struct_ops_"
 #define VALUE_PREFIX_LEN (sizeof(VALUE_PREFIX) - 1)
=20
@@ -660,7 +662,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union=
 bpf_attr *attr)
 	if (attr->value_size !=3D vt->size)
 		return ERR_PTR(-EINVAL);
=20
-	if (attr->map_flags & BPF_F_LINK && !st_ops->validate)
+	if (attr->map_flags & BPF_F_LINK && (!st_ops->validate || !st_ops->upda=
te))
 		return ERR_PTR(-ENOTSUPP);
=20
 	t =3D st_ops->type;
@@ -806,10 +808,54 @@ static int bpf_struct_ops_map_link_fill_link_info(c=
onst struct bpf_link *link,
 	return 0;
 }
=20
+static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct =
bpf_map *new_map,
+					  struct bpf_map *expected_old_map)
+{
+	struct bpf_struct_ops_map *st_map, *old_st_map;
+	struct bpf_map *old_map;
+	struct bpf_struct_ops_link *st_link;
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
+	if (expected_old_map && old_map !=3D expected_old_map) {
+		err =3D -EINVAL;
+		goto err_out;
+	}
+
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
index 21f76698875c..b4d758fa5981 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4682,6 +4682,35 @@ static int link_create(union bpf_attr *attr, bpfpt=
r_t uattr)
 	return ret;
 }
=20
+static int link_update_map(struct bpf_link *link, union bpf_attr *attr)
+{
+	struct bpf_map *new_map, *old_map =3D NULL;
+	int ret;
+
+	new_map =3D bpf_map_get(attr->link_update.new_map_fd);
+	if (IS_ERR(new_map))
+		return -EINVAL;
+
+	if (attr->link_update.flags & BPF_F_REPLACE) {
+		old_map =3D bpf_map_get(attr->link_update.old_map_fd);
+		if (IS_ERR(old_map)) {
+			ret =3D -EINVAL;
+			goto out_put;
+		}
+	} else if (attr->link_update.old_map_fd) {
+		ret =3D -EINVAL;
+		goto out_put;
+	}
+
+	ret =3D link->ops->update_map(link, new_map, old_map);
+
+	if (old_map)
+		bpf_map_put(old_map);
+out_put:
+	bpf_map_put(new_map);
+	return ret;
+}
+
 #define BPF_LINK_UPDATE_LAST_FIELD link_update.old_prog_fd
=20
 static int link_update(union bpf_attr *attr)
@@ -4702,6 +4731,11 @@ static int link_update(union bpf_attr *attr)
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
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index bbbd5eb94db2..e8b27826283e 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -264,6 +264,11 @@ static void bpf_tcp_ca_unreg(void *kdata)
 	tcp_unregister_congestion_control(kdata);
 }
=20
+static int bpf_tcp_ca_update(void *kdata, void *old_kdata)
+{
+	return tcp_update_congestion_control(kdata, old_kdata);
+}
+
 static int bpf_tcp_ca_validate(void *kdata)
 {
 	return tcp_validate_congestion_control(kdata);
@@ -273,6 +278,7 @@ struct bpf_struct_ops bpf_tcp_congestion_ops =3D {
 	.verifier_ops =3D &bpf_tcp_ca_verifier_ops,
 	.reg =3D bpf_tcp_ca_reg,
 	.unreg =3D bpf_tcp_ca_unreg,
+	.update =3D bpf_tcp_ca_update,
 	.check_member =3D bpf_tcp_ca_check_member,
 	.init_member =3D bpf_tcp_ca_init_member,
 	.init =3D bpf_tcp_ca_init,
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 9cf1deaf21f2..d6c5a022ae28 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1555,12 +1555,23 @@ union bpf_attr {
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
-		/* expected link's program fd; is specified only if
-		 * BPF_F_REPLACE flag is set in flags */
-		__u32		old_prog_fd;
+		union {
+			/* expected link's program fd; is specified only if
+			 * BPF_F_REPLACE flag is set in flags.
+			 */
+			__u32		old_prog_fd;
+			/* expected link's map fd; is specified only
+			 * if BPF_F_REPLACE flag is set.
+			 */
+			__u32           old_map_fd;
+		};
 	} link_update;
=20
 	struct {
--=20
2.34.1


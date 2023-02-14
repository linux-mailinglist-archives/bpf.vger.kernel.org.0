Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CAB697095
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 23:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjBNWRs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 17:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233444AbjBNWRq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 17:17:46 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC02305EC
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 14:17:45 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 31EGth4X004699
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 14:17:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=OiQz4if9V76Op78AfsvTi3ifo/m4eCUhlkjHETCa4+M=;
 b=IvsoXZ4glu48Mclx9AQlJTeho3Fm5HxguqT1h49ge3vi4Yj8gSfThSPIv6orOfVWHaG5
 oTzy3M2t0Ztb1qAZ2tSoC05opa8GbqIBTi52Uffw9Fb3QJByYA2z9r2WcvtbpPumUwTY
 MMTLOf1uKOk8r7b6BI96xsaGnVmqn1JADn69nbZ82N1VzMeK1426hRxjV5DfUl+TnVKr
 HkPxwde0DDKKBFLcwxQ59+BfJ5VTlsEZiZII0tveqL48GFczSevSRXUJeJhqr4G8qzI7
 yXInS+17CnTxGAjOOr2RD+Q3MTulrGdgaaHvk1/Um21V2bQDv9WEwIRZWmWdvpNjyghm mQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3nr5ahnsrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 14:17:44 -0800
Received: from twshared25601.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 14 Feb 2023 14:17:42 -0800
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id DA1F551430AA; Tue, 14 Feb 2023 14:17:23 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <song@kernel.org>, <kernel-team@meta.com>, <andrii@kernel.org>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next 5/7] bpf: Update the struct_ops of a bpf_link.
Date:   Tue, 14 Feb 2023 14:17:16 -0800
Message-ID: <20230214221718.503964-6-kuifeng@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230214221718.503964-1-kuifeng@meta.com>
References: <20230214221718.503964-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: XQVxijrs10ULmskBuYGBdbCSgTl8-2hZ
X-Proofpoint-GUID: XQVxijrs10ULmskBuYGBdbCSgTl8-2hZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_15,2023-02-14_01,2023-02-09_01
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
 include/uapi/linux/bpf.h    |  8 ++++--
 kernel/bpf/bpf_struct_ops.c | 55 +++++++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c        | 31 +++++++++++++++++++++
 net/ipv4/bpf_tcp_ca.c       |  2 --
 5 files changed, 93 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5fe39f56a760..03a15dc26d7a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1408,6 +1408,7 @@ struct bpf_link_ops {
 	void (*show_fdinfo)(const struct bpf_link *link, struct seq_file *seq);
 	int (*fill_link_info)(const struct bpf_link *link,
 			      struct bpf_link_info *info);
+	int (*update_struct_ops)(struct bpf_link *link, struct bpf_map *new_map=
);
 };
=20
 struct bpf_tramp_link {
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 48d8b3058aa1..7c009ac859c8 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1552,8 +1552,12 @@ union bpf_attr {
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
index d16ca06cf09a..d329621fc721 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -752,11 +752,66 @@ static int bpf_struct_ops_map_link_fill_link_info(c=
onst struct bpf_link *link,
 	return 0;
 }
=20
+static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct =
bpf_map *new_map)
+{
+	struct bpf_struct_ops_value *kvalue;
+	struct bpf_struct_ops_map *st_map, *old_st_map;
+	struct bpf_map *old_map;
+	int err;
+
+	if (new_map->map_type !=3D BPF_MAP_TYPE_STRUCT_OPS || !(new_map->map_fl=
ags & BPF_F_LINK))
+		return -EINVAL;
+
+	old_map =3D link->map;
+
+	/* It does nothing if the new map is the same as the old one.
+	 * A struct_ops that backs a bpf_link can not be updated or
+	 * its kvalue would be updated and causes inconsistencies.
+	 */
+	if (old_map =3D=3D new_map)
+		return 0;
+
+	/* The new and old struct_ops must be the same type. */
+	st_map =3D (struct bpf_struct_ops_map *)new_map;
+	old_st_map =3D (struct bpf_struct_ops_map *)old_map;
+	if (st_map->st_ops !=3D old_st_map->st_ops)
+		return -EINVAL;
+
+	/* Assure the struct_ops is updated (has value) and not
+	 * backing any other link.
+	 */
+	kvalue =3D &st_map->kvalue;
+	if (kvalue->state !=3D BPF_STRUCT_OPS_STATE_INUSE ||
+	    refcount_read(&kvalue->refcnt) !=3D 0)
+		return -EINVAL;
+
+	bpf_map_inc(new_map);
+	refcount_set(&kvalue->refcnt, 1);
+
+	set_memory_rox((long)st_map->image, 1);
+	err =3D st_map->st_ops->update(kvalue->data, old_st_map->kvalue.data);
+	if (err) {
+		refcount_set(&kvalue->refcnt, 0);
+
+		set_memory_nx((long)st_map->image, 1);
+		set_memory_rw((long)st_map->image, 1);
+		bpf_map_put(new_map);
+		return err;
+	}
+
+	link->map =3D new_map;
+
+	bpf_struct_ops_kvalue_put(&old_st_map->kvalue);
+
+	return 0;
+}
+
 static const struct bpf_link_ops bpf_struct_ops_map_lops =3D {
 	.release =3D bpf_struct_ops_map_link_release,
 	.dealloc =3D bpf_struct_ops_map_link_dealloc,
 	.show_fdinfo =3D bpf_struct_ops_map_link_show_fdinfo,
 	.fill_link_info =3D bpf_struct_ops_map_link_fill_link_info,
+	.update_struct_ops =3D bpf_struct_ops_map_link_update,
 };
=20
 int link_create_struct_ops_map(union bpf_attr *attr, bpfptr_t uattr)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 54e172d8f5d1..1341634863b5 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4650,6 +4650,32 @@ static int link_create(union bpf_attr *attr, bpfpt=
r_t uattr)
 	return ret;
 }
=20
+#define BPF_LINK_UPDATE_STRUCT_OPS_LAST_FIELD link_update_struct_ops.new=
_map_fd
+
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
@@ -4670,6 +4696,11 @@ static int link_update(union bpf_attr *attr)
 	if (IS_ERR(link))
 		return PTR_ERR(link);
=20
+	if (link->type =3D=3D BPF_LINK_TYPE_STRUCT_OPS) {
+		ret =3D link_update_struct_ops(link, attr);
+		goto out_put_link;
+	}
+
 	new_prog =3D bpf_prog_get(attr->link_update.new_prog_fd);
 	if (IS_ERR(new_prog)) {
 		ret =3D PTR_ERR(new_prog);
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 66ce5fadfe42..558b01d5250f 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -239,8 +239,6 @@ static int bpf_tcp_ca_init_member(const struct btf_ty=
pe *t,
 		if (bpf_obj_name_cpy(tcp_ca->name, utcp_ca->name,
 				     sizeof(tcp_ca->name)) <=3D 0)
 			return -EINVAL;
-		if (tcp_ca_find(utcp_ca->name))
-			return -EEXIST;
 		return 1;
 	}
=20
--=20
2.30.2


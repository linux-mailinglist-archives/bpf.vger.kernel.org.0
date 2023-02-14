Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2983C69708F
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 23:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjBNWRj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 17:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjBNWRi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 17:17:38 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D682940F
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 14:17:37 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EGsEuZ002349
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 14:17:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=dz+c22Tv56wEqAmEKounccQcsu7fBOrYX2sIQZ6ACxQ=;
 b=eS1WMmeWmUJoR7QZKTomopnKNg9xmNVgTYdGhKA1tvMJXTBxT0yNke5cef9Pds5VZlMT
 gL1Fbc8JxCbXoAK9evuW8c8k9uUZVvTb5KxtjByii6OITwp4mWmcpVRQAbyHwr4vxpiF
 e+kiz+0Afh9IYygBPycJ4Bw6L4qdTkvP1G4gP2t747KU9MnB0dA4Y0j9mUKpqxfAlcZN
 narv7gaEtVo1LAwXIJyia2CYpcr5manWkTQJNiZPGay3FH4peFx5MEJv7IteEkhur697
 FoPjTpnqVpSWylqUjTGlBs3hTSPk2BhROn4IVapBllP3K61MH/xqTgmQ1iBbcHzOy9R9 hA== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nrc3b39t0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 14:17:36 -0800
Received: from twshared15216.17.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 14 Feb 2023 14:17:35 -0800
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 47A89514309A; Tue, 14 Feb 2023 14:17:22 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <song@kernel.org>, <kernel-team@meta.com>, <andrii@kernel.org>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next 4/7] libbpf: Create a bpf_link in bpf_map__attach_struct_ops().
Date:   Tue, 14 Feb 2023 14:17:15 -0800
Message-ID: <20230214221718.503964-5-kuifeng@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230214221718.503964-1-kuifeng@meta.com>
References: <20230214221718.503964-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 3d5XZajFzj8CA3Wmq5ey3HMgvFuxds3d
X-Proofpoint-GUID: 3d5XZajFzj8CA3Wmq5ey3HMgvFuxds3d
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

bpf_map__attach_struct_ops() was creating a dummy bpf_link as a
placeholder, but now it is constructing an authentic one by calling
bpf_link_create() if the map has the BPF_F_LINK flag.

You can flag a struct_ops map with BPF_F_LINK by calling
bpf_map__set_map_flags().

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 tools/lib/bpf/libbpf.c | 73 +++++++++++++++++++++++++++++++++---------
 1 file changed, 58 insertions(+), 15 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 75ed95b7e455..1eff6a03ddd9 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11430,29 +11430,41 @@ struct bpf_link *bpf_program__attach(const stru=
ct bpf_program *prog)
 	return link;
 }
=20
+struct bpf_link_struct_ops_map {
+	struct bpf_link link;
+	int map_fd;
+};
+
 static int bpf_link__detach_struct_ops(struct bpf_link *link)
 {
+	struct bpf_link_struct_ops_map *st_link;
 	__u32 zero =3D 0;
=20
-	if (bpf_map_delete_elem(link->fd, &zero))
+	st_link =3D container_of(link, struct bpf_link_struct_ops_map, link);
+
+	if (st_link->map_fd < 0) {
+		/* Fake bpf_link */
+		if (bpf_map_delete_elem(link->fd, &zero))
+			return -errno;
+		return 0;
+	}
+
+	if (bpf_map_delete_elem(st_link->map_fd, &zero))
+		return -errno;
+
+	if (close(link->fd))
 		return -errno;
=20
 	return 0;
 }
=20
-struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
+/*
+ * Update the map with the prepared vdata.
+ */
+static int bpf_map__update_vdata(const struct bpf_map *map)
 {
 	struct bpf_struct_ops *st_ops;
-	struct bpf_link *link;
 	__u32 i, zero =3D 0;
-	int err;
-
-	if (!bpf_map__is_struct_ops(map) || map->fd =3D=3D -1)
-		return libbpf_err_ptr(-EINVAL);
-
-	link =3D calloc(1, sizeof(*link));
-	if (!link)
-		return libbpf_err_ptr(-EINVAL);
=20
 	st_ops =3D map->st_ops;
 	for (i =3D 0; i < btf_vlen(st_ops->type); i++) {
@@ -11468,17 +11480,48 @@ struct bpf_link *bpf_map__attach_struct_ops(con=
st struct bpf_map *map)
 		*(unsigned long *)kern_data =3D prog_fd;
 	}
=20
-	err =3D bpf_map_update_elem(map->fd, &zero, st_ops->kern_vdata, 0);
+	return bpf_map_update_elem(map->fd, &zero, st_ops->kern_vdata, 0);
+}
+
+struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
+{
+	struct bpf_link_struct_ops_map *link;
+	int err, fd;
+
+	if (!bpf_map__is_struct_ops(map) || map->fd =3D=3D -1)
+		return libbpf_err_ptr(-EINVAL);
+
+	link =3D calloc(1, sizeof(*link));
+	if (!link)
+		return libbpf_err_ptr(-EINVAL);
+
+	err =3D bpf_map__update_vdata(map);
 	if (err) {
 		err =3D -errno;
 		free(link);
 		return libbpf_err_ptr(err);
 	}
=20
-	link->detach =3D bpf_link__detach_struct_ops;
-	link->fd =3D map->fd;
+	link->link.detach =3D bpf_link__detach_struct_ops;
=20
-	return link;
+	if (!(map->def.map_flags & BPF_F_LINK)) {
+		/* Fake bpf_link */
+		link->link.fd =3D map->fd;
+		link->map_fd =3D -1;
+		return &link->link;
+	}
+
+	fd =3D bpf_link_create(map->fd, -1, BPF_STRUCT_OPS_MAP, NULL);
+	if (fd < 0) {
+		err =3D -errno;
+		free(link);
+		return libbpf_err_ptr(err);
+	}
+
+	link->link.fd =3D fd;
+	link->map_fd =3D map->fd;
+
+	return &link->link;
 }
=20
 typedef enum bpf_perf_event_ret (*bpf_perf_event_print_t)(struct perf_ev=
ent_header *hdr,
--=20
2.30.2


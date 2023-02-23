Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625646A007D
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 02:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbjBWBNI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 20:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbjBWBNE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 20:13:04 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D7118B19
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 17:13:03 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31MMQq66029906
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 17:13:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=FYS6F2jPmfg490T40yKUwjY2CM1x1BH1IHsHRF5A9ko=;
 b=kbTMT5UG8HZ3ZFjZ6ebkz9pJoJd+rcJH/c5ZyHMSHpOQy/WLBr3tTy1aQ/EJjL87V+27
 J0p65xTNJ/mD0OhCeFrmylOCrEqu6zAnC+LAISrxzmu8lXcwxatPDfhVX5WUiliIyT3C
 2Gdm8yUBvlzJTSVtcX+n0FzRKepOHz/e06vCQ9i1IgBeKoHJlxdDlRPFPDz/VoVpuTj7
 PvL02Dn9uyvCS6E8QBO6NCf4V7b4TCHoJuIkVneY/4pi6euzlouUtrTOObgJxkdq/fEn
 JC3fbHcYZ0jDffbz8Fh7k630itl2UvqHgFuMGGwsiiPIGcZLbh5rCKc7QHbQy7a20BHv eQ== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nw4rn0tke-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 17:13:03 -0800
Received: from twshared16996.15.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 22 Feb 2023 17:12:59 -0800
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 30FD15BD8D0B; Wed, 22 Feb 2023 17:12:42 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <song@kernel.org>, <kernel-team@meta.com>, <andrii@kernel.org>,
        <sdf@google.com>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v2 5/6] libbpf: Update a bpf_link with another struct_ops.
Date:   Wed, 22 Feb 2023 17:12:37 -0800
Message-ID: <20230223011238.12313-6-kuifeng@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230223011238.12313-1-kuifeng@meta.com>
References: <20230223011238.12313-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: hsCxhCQZn84QPRoomJ8GQziMbEOLPkdW
X-Proofpoint-ORIG-GUID: hsCxhCQZn84QPRoomJ8GQziMbEOLPkdW
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

Introduce bpf_link__update_struct_ops(), which will allow you to
effortlessly transition the struct_ops map of any given bpf_link into
an alternative.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 tools/lib/bpf/libbpf.c   | 36 ++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   |  1 +
 tools/lib/bpf/libbpf.map |  2 ++
 3 files changed, 39 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 40f239cd1150..0cb3e5ed4d18 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11524,6 +11524,42 @@ struct bpf_link *bpf_map__attach_struct_ops(cons=
t struct bpf_map *map)
 	return &link->link;
 }
=20
+/*
+ * Swap the back struct_ops of a link with a new struct_ops map.
+ */
+int bpf_link__update_map(struct bpf_link *link, const struct bpf_map *ma=
p)
+{
+	struct bpf_link_struct_ops *st_ops_link;
+	__u32 zero =3D 0;
+	int err, fd;
+
+	if (!bpf_map__is_struct_ops(map) || map->fd =3D=3D -1)
+		return -EINVAL;
+
+	/* Ensure the type of a link is correct */
+	if (link->detach !=3D bpf_link__detach_struct_ops)
+		return -EINVAL;
+
+	err =3D bpf_map_update_elem(map->fd, &zero, map->st_ops->kern_vdata, 0)=
;
+	if (err) {
+		err =3D -errno;
+		free(link);
+		return err;
+	}
+
+	fd =3D bpf_link_update(link->fd, map->fd, NULL);
+	if (fd < 0) {
+		err =3D -errno;
+		free(link);
+		return err;
+	}
+
+	st_ops_link =3D container_of(link, struct bpf_link_struct_ops, link);
+	st_ops_link->map_fd =3D map->fd;
+
+	return 0;
+}
+
 typedef enum bpf_perf_event_ret (*bpf_perf_event_print_t)(struct perf_ev=
ent_header *hdr,
 							  void *private_data);
=20
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 2efd80f6f7b9..5e62878d184c 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -695,6 +695,7 @@ bpf_program__attach_freplace(const struct bpf_program=
 *prog,
 struct bpf_map;
=20
 LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_=
map *map);
+LIBBPF_API int bpf_link__update_map(struct bpf_link *link, const struct =
bpf_map *map);
=20
 struct bpf_iter_attach_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 11c36a3c1a9f..e83571b04c19 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -384,4 +384,6 @@ LIBBPF_1.1.0 {
 } LIBBPF_1.0.0;
=20
 LIBBPF_1.2.0 {
+	global:
+		bpf_link__update_map;
 } LIBBPF_1.1.0;
--=20
2.30.2


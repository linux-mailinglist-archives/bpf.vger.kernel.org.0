Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0179697096
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 23:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbjBNWRz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 17:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbjBNWRy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 17:17:54 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725C459CA
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 14:17:51 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31ELLGI0025849
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 14:17:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=z++okg8JoArGPUzPBJfCEpx4xcZ1y/UpeXPFBnid/zc=;
 b=aT5f6ASPJuYqEIoxXeLJ536G+ye2hlecPVwMmbNp/L4E7YC01KZeKuCn9JHIt2keH5lz
 z/EfhKY+fQgTfNjXAl5RvdcZml7dfaBMP+yTK+iwv/sEK4gr19+1fcB1H5K5Nv4cI/w1
 FOg0CuU5FurCsc4r52z7KCi1lzyOqtUL0B7/DUjrhcNUBi0jYCPzbJmt6ZSNn2cGKPPU
 0HCFRRm4WmA7Jib3us+3UqqSuz+Zmcb/6+YVhZLo3a1u2nNZ4iGaW3qzmUxrZv9wyAGz
 9hM5+ahhtUPK4ltmNDdWDxadaEFEl/YtICv88PPhRCMWhrynLJFwqFiG8GKyhdja12fX qw== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nqyqmy381-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 14:17:50 -0800
Received: from twshared25383.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 14 Feb 2023 14:17:44 -0800
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id E84B551430AC; Tue, 14 Feb 2023 14:17:23 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <song@kernel.org>, <kernel-team@meta.com>, <andrii@kernel.org>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next 6/7] libbpf: Update a bpf_link with another struct_ops.
Date:   Tue, 14 Feb 2023 14:17:17 -0800
Message-ID: <20230214221718.503964-7-kuifeng@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230214221718.503964-1-kuifeng@meta.com>
References: <20230214221718.503964-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: EtPEfETvgWnk4dVpKW9nv90eqTE1cxXj
X-Proofpoint-ORIG-GUID: EtPEfETvgWnk4dVpKW9nv90eqTE1cxXj
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

Introduce bpf_link__update_struct_ops(), which will allow you to
effortlessly transition the struct_ops map of any given bpf_link into
an alternative.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 tools/lib/bpf/libbpf.c   | 35 +++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   |  1 +
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 37 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1eff6a03ddd9..6f7c72e312d4 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11524,6 +11524,41 @@ struct bpf_link *bpf_map__attach_struct_ops(cons=
t struct bpf_map *map)
 	return &link->link;
 }
=20
+/*
+ * Swap the back struct_ops of a link with a new struct_ops map.
+ */
+int bpf_link__update_struct_ops(struct bpf_link *link, const struct bpf_=
map *map)
+{
+	struct bpf_link_struct_ops_map *st_ops_link;
+	int err, fd;
+
+	if (!bpf_map__is_struct_ops(map) || map->fd =3D=3D -1)
+		return -EINVAL;
+
+	/* Ensure the type of a link is correct */
+	if (link->detach !=3D bpf_link__detach_struct_ops)
+		return -EINVAL;
+
+	err =3D bpf_map__update_vdata(map);
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
+	st_ops_link =3D container_of(link, struct bpf_link_struct_ops_map, link=
);
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
index 2efd80f6f7b9..dd25cd6759d4 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -695,6 +695,7 @@ bpf_program__attach_freplace(const struct bpf_program=
 *prog,
 struct bpf_map;
=20
 LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_=
map *map);
+LIBBPF_API int bpf_link__update_struct_ops(struct bpf_link *link, const =
struct bpf_map *map);
=20
 struct bpf_iter_attach_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 11c36a3c1a9f..ca6993c744b6 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -373,6 +373,7 @@ LIBBPF_1.1.0 {
 	global:
 		bpf_btf_get_fd_by_id_opts;
 		bpf_link_get_fd_by_id_opts;
+		bpf_link__update_struct_ops;
 		bpf_map_get_fd_by_id_opts;
 		bpf_prog_get_fd_by_id_opts;
 		user_ring_buffer__discard;
--=20
2.30.2


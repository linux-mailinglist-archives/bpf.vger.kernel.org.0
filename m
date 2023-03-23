Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230656C5BAC
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 02:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCWBEa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 21:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjCWBE3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 21:04:29 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0A0279A4
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 18:04:28 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N0geeV021023
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 18:04:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=VmMFwMdWvoPj3u7o6eFRxsDk1b44VhGgX5FY6GmFT8s=;
 b=YXpx81vBQGDsUM0+hFyZ3K5S4LQfWYp4vHX6pEZuCl9ZsNQ3CJogTI0CG6gKus7fHto/
 8CMpPXU1rSXyDg9UaBO8tcsBuG/tFQmDJPpndV1B+LAMAzYjgWbjsJNZTR7OuvlO9esq
 s3jbps8D9SN6F4/pkr/qNR1mXujgcerpLcED5ubhDoUdmSAHKtfpr5HWbqEdGlWKb49W
 zFubYGq/8TEchBcj0A1Qy5Cajh8zWVMZR4+IQQj7uHqmxrV6p3UN+v+nUnSRqEiWgupe
 FvaajVcI/qbBtWEID2EzsjMWp3/HRBz53beLsWP+lMtdvCcI3by7gW0aKKEtzpKJQXt5 tg== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pg1mm4s1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 18:04:27 -0700
Received: from twshared15216.17.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 22 Mar 2023 18:04:26 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id CA70B80624AD; Wed, 22 Mar 2023 18:04:10 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <song@kernel.org>, <kernel-team@meta.com>, <andrii@kernel.org>,
        <sdf@google.com>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v11 6/8] libbpf: Update a bpf_link with another struct_ops.
Date:   Wed, 22 Mar 2023 18:04:07 -0700
Message-ID: <20230323010409.2265383-7-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230323010409.2265383-1-kuifeng@meta.com>
References: <20230323010409.2265383-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: MYcRQrz6JTUp2ErrDpQnBzsWpzcN4hyL
X-Proofpoint-GUID: MYcRQrz6JTUp2ErrDpQnBzsWpzcN4hyL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce bpf_link__update_map(), which allows to atomically update
underlying struct_ops implementation for given struct_ops BPF link.

Also add old_map_fd to struct bpf_link_update_opts to handle
BPF_F_REPLACE feature.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 tools/lib/bpf/bpf.c      |  4 ++++
 tools/lib/bpf/bpf.h      |  3 ++-
 tools/lib/bpf/libbpf.c   | 35 +++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   |  1 +
 tools/lib/bpf/libbpf.map |  1 +
 5 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index e750b6f5fcc3..5e88f924bb6d 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -794,11 +794,15 @@ int bpf_link_update(int link_fd, int new_prog_fd,
 	if (!OPTS_VALID(opts, bpf_link_update_opts))
 		return libbpf_err(-EINVAL);
=20
+	if (OPTS_GET(opts, old_prog_fd, 0) && OPTS_GET(opts, old_map_fd, 0))
+		return libbpf_err(-EINVAL);
+
 	memset(&attr, 0, attr_sz);
 	attr.link_update.link_fd =3D link_fd;
 	attr.link_update.new_prog_fd =3D new_prog_fd;
 	attr.link_update.flags =3D OPTS_GET(opts, flags, 0);
 	attr.link_update.old_prog_fd =3D OPTS_GET(opts, old_prog_fd, 0);
+	attr.link_update.old_map_fd =3D OPTS_GET(opts, old_map_fd, 0);
=20
 	ret =3D sys_bpf(BPF_LINK_UPDATE, &attr, attr_sz);
 	return libbpf_err_errno(ret);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index f0f786373238..b073e73439ef 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -336,8 +336,9 @@ struct bpf_link_update_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
 	__u32 flags;	   /* extra flags */
 	__u32 old_prog_fd; /* expected old program FD */
+	__u32 old_map_fd;  /* expected old map FD */
 };
-#define bpf_link_update_opts__last_field old_prog_fd
+#define bpf_link_update_opts__last_field old_map_fd
=20
 LIBBPF_API int bpf_link_update(int link_fd, int new_prog_fd,
 			       const struct bpf_link_update_opts *opts);
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4ff82baba0ea..2b5ea2500b80 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11677,6 +11677,41 @@ struct bpf_link *bpf_map__attach_struct_ops(cons=
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
+	int err;
+
+	if (!bpf_map__is_struct_ops(map) || map->fd < 0)
+		return -EINVAL;
+
+	st_ops_link =3D container_of(link, struct bpf_link_struct_ops, link);
+	/* Ensure the type of a link is correct */
+	if (st_ops_link->map_fd < 0)
+		return -EINVAL;
+
+	err =3D bpf_map_update_elem(map->fd, &zero, map->st_ops->kern_vdata, 0)=
;
+	/* It can be EBUSY if the map has been used to create or
+	 * update a link before.  We don't allow updating the value of
+	 * a struct_ops once it is set.  That ensures that the value
+	 * never changed.  So, it is safe to skip EBUSY.
+	 */
+	if (err && err !=3D -EBUSY)
+		return err;
+
+	err =3D bpf_link_update(link->fd, map->fd, NULL);
+	if (err < 0)
+		return err;
+
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
index db4992a036f8..1615e55e2e79 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -719,6 +719,7 @@ bpf_program__attach_freplace(const struct bpf_program=
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
index 50dde1f6521e..a5aa3a383d69 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -386,6 +386,7 @@ LIBBPF_1.1.0 {
 LIBBPF_1.2.0 {
 	global:
 		bpf_btf_get_info_by_fd;
+		bpf_link__update_map;
 		bpf_link_get_info_by_fd;
 		bpf_map_get_info_by_fd;
 		bpf_prog_get_info_by_fd;
--=20
2.34.1


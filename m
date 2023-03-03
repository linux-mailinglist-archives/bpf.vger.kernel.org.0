Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851ED6A8E97
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 02:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjCCBVo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 20:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCCBVn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 20:21:43 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E0A515E5
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 17:21:41 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322KTZ76030242
        for <bpf@vger.kernel.org>; Thu, 2 Mar 2023 17:21:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=TXcdZq3SnlcQtElGGECZN35GOT7c1vWCllC+RhcoVWc=;
 b=UB3CG4l66KcJ4biBxKIhXUtV3KJDW98xifcjcA1WnlipwRF7VynnvXZpVSr7wJI5FzKA
 F+fH5OkRWEFJPTeiJA6oYGfr/NLptNKxFMmtOnOah/Eb0hIAq/1QOU0vwl8f9m3vxwlJ
 A7L6L+p/Qx7JCDuYn+qDTDtO/P44CPJykaceMn463KqPICoI1+m1TqwsTknYcmV7YOm/
 1l/EHc9VF2a1m+VGWK0022kNpdrkAHE9PtyeBG7J1eyedFYsfqStu703HV6+p9rvHhII
 xeClLJczKTzajp+MbbxK6mPYSCAw2a2oH/HgFDwbgP8zj7VhKsZRYibjZPLNjMcosIFE 2A== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p30k9jpd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 02 Mar 2023 17:21:40 -0800
Received: from twshared52565.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 2 Mar 2023 17:21:39 -0800
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id C4F716644D88; Thu,  2 Mar 2023 17:21:30 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <song@kernel.org>, <kernel-team@meta.com>, <andrii@kernel.org>,
        <sdf@google.com>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v3 4/8] libbpf: Create a bpf_link in bpf_map__attach_struct_ops().
Date:   Thu, 2 Mar 2023 17:21:18 -0800
Message-ID: <20230303012122.852654-5-kuifeng@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230303012122.852654-1-kuifeng@meta.com>
References: <20230303012122.852654-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Zl73M5uuobczmQyYo40OuO15o0LN5n5b
X-Proofpoint-ORIG-GUID: Zl73M5uuobczmQyYo40OuO15o0LN5n5b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_01,2023-03-02_02,2023-02-09_01
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
 tools/lib/bpf/libbpf.c | 84 +++++++++++++++++++++++++++++++-----------
 1 file changed, 62 insertions(+), 22 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 35a698eb825d..a67efc3b3763 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -115,6 +115,7 @@ static const char * const attach_type_name[] =3D {
 	[BPF_SK_REUSEPORT_SELECT_OR_MIGRATE]	=3D "sk_reuseport_select_or_migrat=
e",
 	[BPF_PERF_EVENT]		=3D "perf_event",
 	[BPF_TRACE_KPROBE_MULTI]	=3D "trace_kprobe_multi",
+	[BPF_STRUCT_OPS]		=3D "struct_ops",
 };
=20
 static const char * const link_type_name[] =3D {
@@ -7677,6 +7678,26 @@ static int bpf_object__resolve_externs(struct bpf_=
object *obj,
 	return 0;
 }
=20
+static void bpf_map_prepare_vdata(const struct bpf_map *map)
+{
+	struct bpf_struct_ops *st_ops;
+	__u32 i;
+
+	st_ops =3D map->st_ops;
+	for (i =3D 0; i < btf_vlen(st_ops->type); i++) {
+		struct bpf_program *prog =3D st_ops->progs[i];
+		void *kern_data;
+		int prog_fd;
+
+		if (!prog)
+			continue;
+
+		prog_fd =3D bpf_program__fd(prog);
+		kern_data =3D st_ops->kern_vdata + st_ops->kern_func_off[i];
+		*(unsigned long *)kern_data =3D prog_fd;
+	}
+}
+
 static int bpf_object_load(struct bpf_object *obj, int extra_log_level, =
const char *target_btf_path)
 {
 	int err, i;
@@ -7728,6 +7749,10 @@ static int bpf_object_load(struct bpf_object *obj,=
 int extra_log_level, const ch
 	btf__free(obj->btf_vmlinux);
 	obj->btf_vmlinux =3D NULL;
=20
+	for (i =3D 0; i < obj->nr_maps; i++)
+		if (bpf_map__is_struct_ops(&obj->maps[i]))
+			bpf_map_prepare_vdata(&obj->maps[i]);
+
 	obj->loaded =3D true; /* doesn't matter if successfully or not */
=20
 	if (err)
@@ -11429,22 +11454,34 @@ struct bpf_link *bpf_program__attach(const stru=
ct bpf_program *prog)
 	return link;
 }
=20
+struct bpf_link_struct_ops {
+	struct bpf_link link;
+	int map_fd;
+};
+
 static int bpf_link__detach_struct_ops(struct bpf_link *link)
 {
+	struct bpf_link_struct_ops *st_link;
 	__u32 zero =3D 0;
=20
-	if (bpf_map_delete_elem(link->fd, &zero))
-		return -errno;
+	st_link =3D container_of(link, struct bpf_link_struct_ops, link);
=20
-	return 0;
+	if (st_link->map_fd < 0) {
+		/* Fake bpf_link */
+		if (bpf_map_delete_elem(link->fd, &zero))
+			return -errno;
+		return 0;
+	}
+
+	/* Doesn't support detaching. */
+	return -EOPNOTSUPP;
 }
=20
 struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
 {
-	struct bpf_struct_ops *st_ops;
-	struct bpf_link *link;
-	__u32 i, zero =3D 0;
-	int err;
+	struct bpf_link_struct_ops *link;
+	__u32 zero =3D 0;
+	int err, fd;
=20
 	if (!bpf_map__is_struct_ops(map) || map->fd =3D=3D -1)
 		return libbpf_err_ptr(-EINVAL);
@@ -11453,31 +11490,34 @@ struct bpf_link *bpf_map__attach_struct_ops(con=
st struct bpf_map *map)
 	if (!link)
 		return libbpf_err_ptr(-EINVAL);
=20
-	st_ops =3D map->st_ops;
-	for (i =3D 0; i < btf_vlen(st_ops->type); i++) {
-		struct bpf_program *prog =3D st_ops->progs[i];
-		void *kern_data;
-		int prog_fd;
+	/* kern_vdata should be prepared during the loading phase. */
+	err =3D bpf_map_update_elem(map->fd, &zero, map->st_ops->kern_vdata, 0)=
;
+	if (err) {
+		err =3D -errno;
+		free(link);
+		return libbpf_err_ptr(err);
+	}
=20
-		if (!prog)
-			continue;
=20
-		prog_fd =3D bpf_program__fd(prog);
-		kern_data =3D st_ops->kern_vdata + st_ops->kern_func_off[i];
-		*(unsigned long *)kern_data =3D prog_fd;
+	if (!(map->def.map_flags & BPF_F_LINK)) {
+		/* Fake bpf_link */
+		link->link.fd =3D map->fd;
+		link->map_fd =3D -1;
+		link->link.detach =3D bpf_link__detach_struct_ops;
+		return &link->link;
 	}
=20
-	err =3D bpf_map_update_elem(map->fd, &zero, st_ops->kern_vdata, 0);
-	if (err) {
+	fd =3D bpf_link_create(map->fd, -1, BPF_STRUCT_OPS, NULL);
+	if (fd < 0) {
 		err =3D -errno;
 		free(link);
 		return libbpf_err_ptr(err);
 	}
=20
-	link->detach =3D bpf_link__detach_struct_ops;
-	link->fd =3D map->fd;
+	link->link.fd =3D fd;
+	link->map_fd =3D map->fd;
=20
-	return link;
+	return &link->link;
 }
=20
 typedef enum bpf_perf_event_ret (*bpf_perf_event_print_t)(struct perf_ev=
ent_header *hdr,
--=20
2.30.2


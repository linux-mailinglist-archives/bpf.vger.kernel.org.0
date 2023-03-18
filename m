Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F4E6BF805
	for <lists+bpf@lfdr.de>; Sat, 18 Mar 2023 06:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjCRFfP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 18 Mar 2023 01:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjCRFfO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 18 Mar 2023 01:35:14 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608571E1EE
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 22:35:13 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32I4nkqJ026666
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 22:35:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=+vvs/l+gkw85c6C8w//C3e34B5mEhSjVJPXVhKGKCeI=;
 b=gn9UHvJR36Fpepl+fS09plsKtsy0XAMOmwYz7QUjcyH2eOndbqf8cQQ6b4/BQOYCK/O4
 XMGAq0Gp8nDIKpsTrkztoHGt4FoDBGSfyyo/XnFWLEHWG9m8rw5hI8XBu2Dvx+vsS57P
 L5phtJRYdvGuh+g3/wQpse7BpeBv4jykIXsU9y7i1lrF5LKmGAGCMYPwBZfIJNuRzVgn
 /eeydpOyPZt8oPmH2637rsc2GvmGKeylWfSpVFKpRUAC75CwFsNqQqSv6oGD13rIELxC
 IrFCavQVozHwRrcxUwWo6Crvdtzh6nloztQnowenSpmHGz6XKu17TEAzDw1Nn3/NpVxM Gw== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pcp01nmaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 22:35:13 -0700
Received: from twshared15216.17.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 17 Mar 2023 22:35:12 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 9856A79EB019; Fri, 17 Mar 2023 22:31:51 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <song@kernel.org>, <kernel-team@meta.com>, <andrii@kernel.org>,
        <sdf@google.com>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v8 4/8] libbpf: Create a bpf_link in bpf_map__attach_struct_ops().
Date:   Fri, 17 Mar 2023 22:31:40 -0700
Message-ID: <20230318053144.1180301-5-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230318053144.1180301-1-kuifeng@meta.com>
References: <20230318053144.1180301-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: E8TtDJPSM7dIm5y6ujOJmEY4azVOFTLp
X-Proofpoint-GUID: E8TtDJPSM7dIm5y6ujOJmEY4azVOFTLp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-18_02,2023-03-16_02,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 tools/lib/bpf/libbpf.c | 90 +++++++++++++++++++++++++++++++-----------
 1 file changed, 66 insertions(+), 24 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4c34fbd7b5be..56a60ab2ca8f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -116,6 +116,7 @@ static const char * const attach_type_name[] =3D {
 	[BPF_SK_REUSEPORT_SELECT_OR_MIGRATE]	=3D "sk_reuseport_select_or_migrat=
e",
 	[BPF_PERF_EVENT]		=3D "perf_event",
 	[BPF_TRACE_KPROBE_MULTI]	=3D "trace_kprobe_multi",
+	[BPF_STRUCT_OPS]		=3D "struct_ops",
 };
=20
 static const char * const link_type_name[] =3D {
@@ -7683,6 +7684,37 @@ static int bpf_object__resolve_externs(struct bpf_=
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
+static int bpf_object_prepare_struct_ops(struct bpf_object *obj)
+{
+	int i;
+
+	for (i =3D 0; i < obj->nr_maps; i++)
+		if (bpf_map__is_struct_ops(&obj->maps[i]))
+			bpf_map_prepare_vdata(&obj->maps[i]);
+
+	return 0;
+}
+
 static int bpf_object_load(struct bpf_object *obj, int extra_log_level, =
const char *target_btf_path)
 {
 	int err, i;
@@ -7708,6 +7740,7 @@ static int bpf_object_load(struct bpf_object *obj, =
int extra_log_level, const ch
 	err =3D err ? : bpf_object__relocate(obj, obj->btf_custom_path ? : targ=
et_btf_path);
 	err =3D err ? : bpf_object__load_progs(obj, extra_log_level);
 	err =3D err ? : bpf_object_init_prog_arrays(obj);
+	err =3D err ? : bpf_object_prepare_struct_ops(obj);
=20
 	if (obj->gen_loader) {
 		/* reset FDs */
@@ -11572,22 +11605,30 @@ struct bpf_link *bpf_program__attach(const stru=
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
+	if (st_link->map_fd < 0)
+		/* w/o a real link */
+		return bpf_map_delete_elem(link->fd, &zero);
+
+	return close(link->fd);
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
@@ -11596,31 +11637,32 @@ struct bpf_link *bpf_map__attach_struct_ops(con=
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
+	if (err && err !=3D -EBUSY) {
+		free(link);
+		return libbpf_err_ptr(err);
+	}
=20
-		if (!prog)
-			continue;
+	link->link.detach =3D bpf_link__detach_struct_ops;
=20
-		prog_fd =3D bpf_program__fd(prog);
-		kern_data =3D st_ops->kern_vdata + st_ops->kern_func_off[i];
-		*(unsigned long *)kern_data =3D prog_fd;
+	if (!(map->def.map_flags & BPF_F_LINK)) {
+		/* w/o a real link */
+		link->link.fd =3D map->fd;
+		link->map_fd =3D -1;
+		return &link->link;
 	}
=20
-	err =3D bpf_map_update_elem(map->fd, &zero, st_ops->kern_vdata, 0);
-	if (err) {
-		err =3D -errno;
+	fd =3D bpf_link_create(map->fd, 0, BPF_STRUCT_OPS, NULL);
+	if (fd < 0) {
 		free(link);
-		return libbpf_err_ptr(err);
+		return libbpf_err_ptr(fd);
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
2.34.1


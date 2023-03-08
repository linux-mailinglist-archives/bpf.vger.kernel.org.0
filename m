Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA416AFB8E
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 01:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjCHAvR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 19:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjCHAvQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 19:51:16 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E94EA9094
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 16:51:14 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32803Tds005982
        for <bpf@vger.kernel.org>; Tue, 7 Mar 2023 16:51:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=xBtLHRi/fE39rmtAIXz9SbXkIFMqtXCh5jvOhDGCg74=;
 b=fBvMUziRSQUJJ6Oht6OXijt72SKkOaWnqYnGLLaKGBzP+Thg1bJgvykMEd86bhLZsQx5
 x6V/dRNK3cey9qbBxIMDY9x2ess1kY/znlX7kh3PVGPg+EhihCY/mLKf0Jn9x7YtVgtp
 B+mZfkiJpmgQcAvzcnvfeeziE6pmRNGgUMCQk20CnXH/fT+dIwtCiZuEd+2b4GtXfUFX
 1f/qlFEPWZ/ysP1348OcuElRCg0MZgePAMklKZNRHul6hJuDFZA75TOlyztSwjNUWH2R
 o7OcP8rNOXHV6LxnaLivAsKsIcen93HoEiQQRrR4nniWfAgqS9uRsZYflI86I3lm593H Ew== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p6fft87a2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 16:51:14 -0800
Received: from twshared19568.39.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 7 Mar 2023 16:51:13 -0800
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id B50716C92E20; Tue,  7 Mar 2023 16:50:54 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <song@kernel.org>, <kernel-team@meta.com>, <andrii@kernel.org>,
        <sdf@google.com>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v5 7/8] libbpf: Use .struct_ops.link section to indicate a struct_ops with a link.
Date:   Tue, 7 Mar 2023 16:50:49 -0800
Message-ID: <20230308005050.255859-8-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308005050.255859-1-kuifeng@meta.com>
References: <20230308005050.255859-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: wBBWptg1MlvesFQ9TbAecinu8z78T9D_
X-Proofpoint-ORIG-GUID: wBBWptg1MlvesFQ9TbAecinu8z78T9D_
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

Flags a struct_ops is to back a bpf_link by putting it to the
".struct_ops.link" section.  Once it is flagged, the created
struct_ops can be used to create a bpf_link or update a bpf_link that
has been backed by another struct_ops.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 tools/lib/bpf/libbpf.c | 64 +++++++++++++++++++++++++++++++++---------
 1 file changed, 50 insertions(+), 14 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0406d0e00e1f..589eea158d95 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -468,6 +468,7 @@ struct bpf_struct_ops {
 #define KCONFIG_SEC ".kconfig"
 #define KSYMS_SEC ".ksyms"
 #define STRUCT_OPS_SEC ".struct_ops"
+#define STRUCT_OPS_LINK_SEC ".struct_ops.link"
=20
 enum libbpf_map_type {
 	LIBBPF_MAP_UNSPEC,
@@ -597,6 +598,7 @@ struct elf_state {
 	Elf64_Ehdr *ehdr;
 	Elf_Data *symbols;
 	Elf_Data *st_ops_data;
+	Elf_Data *st_ops_link_data;
 	size_t shstrndx; /* section index for section name strings */
 	size_t strtabidx;
 	struct elf_sec_desc *secs;
@@ -606,6 +608,7 @@ struct elf_state {
 	int text_shndx;
 	int symbols_shndx;
 	int st_ops_shndx;
+	int st_ops_link_shndx;
 };
=20
 struct usdt_manager;
@@ -1119,7 +1122,7 @@ static int bpf_object__init_kern_struct_ops_maps(st=
ruct bpf_object *obj)
 	return 0;
 }
=20
-static int bpf_object__init_struct_ops_maps(struct bpf_object *obj)
+static int bpf_object__init_struct_ops_maps_link(struct bpf_object *obj,=
 bool link)
 {
 	const struct btf_type *type, *datasec;
 	const struct btf_var_secinfo *vsi;
@@ -1127,18 +1130,33 @@ static int bpf_object__init_struct_ops_maps(struc=
t bpf_object *obj)
 	const char *tname, *var_name;
 	__s32 type_id, datasec_id;
 	const struct btf *btf;
+	const char *sec_name;
 	struct bpf_map *map;
-	__u32 i;
+	__u32 i, map_flags;
+	Elf_Data *data;
+	int shndx;
=20
-	if (obj->efile.st_ops_shndx =3D=3D -1)
+	if (link) {
+		sec_name =3D STRUCT_OPS_LINK_SEC;
+		shndx =3D obj->efile.st_ops_link_shndx;
+		data =3D obj->efile.st_ops_link_data;
+		map_flags =3D BPF_F_LINK;
+	} else {
+		sec_name =3D STRUCT_OPS_SEC;
+		shndx =3D obj->efile.st_ops_shndx;
+		data =3D obj->efile.st_ops_data;
+		map_flags =3D 0;
+	}
+
+	if (shndx =3D=3D -1)
 		return 0;
=20
 	btf =3D obj->btf;
-	datasec_id =3D btf__find_by_name_kind(btf, STRUCT_OPS_SEC,
+	datasec_id =3D btf__find_by_name_kind(btf, sec_name,
 					    BTF_KIND_DATASEC);
 	if (datasec_id < 0) {
 		pr_warn("struct_ops init: DATASEC %s not found\n",
-			STRUCT_OPS_SEC);
+			sec_name);
 		return -EINVAL;
 	}
=20
@@ -1151,7 +1169,7 @@ static int bpf_object__init_struct_ops_maps(struct =
bpf_object *obj)
 		type_id =3D btf__resolve_type(obj->btf, vsi->type);
 		if (type_id < 0) {
 			pr_warn("struct_ops init: Cannot resolve var type_id %u in DATASEC %s=
\n",
-				vsi->type, STRUCT_OPS_SEC);
+				vsi->type, sec_name);
 			return -EINVAL;
 		}
=20
@@ -1170,7 +1188,7 @@ static int bpf_object__init_struct_ops_maps(struct =
bpf_object *obj)
 		if (IS_ERR(map))
 			return PTR_ERR(map);
=20
-		map->sec_idx =3D obj->efile.st_ops_shndx;
+		map->sec_idx =3D shndx;
 		map->sec_offset =3D vsi->offset;
 		map->name =3D strdup(var_name);
 		if (!map->name)
@@ -1180,6 +1198,7 @@ static int bpf_object__init_struct_ops_maps(struct =
bpf_object *obj)
 		map->def.key_size =3D sizeof(int);
 		map->def.value_size =3D type->size;
 		map->def.max_entries =3D 1;
+		map->def.map_flags =3D map_flags;
=20
 		map->st_ops =3D calloc(1, sizeof(*map->st_ops));
 		if (!map->st_ops)
@@ -1192,14 +1211,14 @@ static int bpf_object__init_struct_ops_maps(struc=
t bpf_object *obj)
 		if (!st_ops->data || !st_ops->progs || !st_ops->kern_func_off)
 			return -ENOMEM;
=20
-		if (vsi->offset + type->size > obj->efile.st_ops_data->d_size) {
+		if (vsi->offset + type->size > data->d_size) {
 			pr_warn("struct_ops init: var %s is beyond the end of DATASEC %s\n",
-				var_name, STRUCT_OPS_SEC);
+				var_name, sec_name);
 			return -EINVAL;
 		}
=20
 		memcpy(st_ops->data,
-		       obj->efile.st_ops_data->d_buf + vsi->offset,
+		       data->d_buf + vsi->offset,
 		       type->size);
 		st_ops->tname =3D tname;
 		st_ops->type =3D type;
@@ -1212,6 +1231,15 @@ static int bpf_object__init_struct_ops_maps(struct=
 bpf_object *obj)
 	return 0;
 }
=20
+static int bpf_object__init_struct_ops_maps(struct bpf_object *obj)
+{
+	int err;
+
+	err =3D bpf_object__init_struct_ops_maps_link(obj, false);
+	err =3D err ?: bpf_object__init_struct_ops_maps_link(obj, true);
+	return err;
+}
+
 static struct bpf_object *bpf_object__new(const char *path,
 					  const void *obj_buf,
 					  size_t obj_buf_sz,
@@ -1248,6 +1276,7 @@ static struct bpf_object *bpf_object__new(const cha=
r *path,
 	obj->efile.obj_buf_sz =3D obj_buf_sz;
 	obj->efile.btf_maps_shndx =3D -1;
 	obj->efile.st_ops_shndx =3D -1;
+	obj->efile.st_ops_link_shndx =3D -1;
 	obj->kconfig_map_idx =3D -1;
=20
 	obj->kern_version =3D get_kernel_version();
@@ -1265,6 +1294,7 @@ static void bpf_object__elf_finish(struct bpf_objec=
t *obj)
 	obj->efile.elf =3D NULL;
 	obj->efile.symbols =3D NULL;
 	obj->efile.st_ops_data =3D NULL;
+	obj->efile.st_ops_link_data =3D NULL;
=20
 	zfree(&obj->efile.secs);
 	obj->efile.sec_cnt =3D 0;
@@ -2753,12 +2783,13 @@ static bool libbpf_needs_btf(const struct bpf_obj=
ect *obj)
 {
 	return obj->efile.btf_maps_shndx >=3D 0 ||
 	       obj->efile.st_ops_shndx >=3D 0 ||
+	       obj->efile.st_ops_link_shndx >=3D 0 ||
 	       obj->nr_extern > 0;
 }
=20
 static bool kernel_needs_btf(const struct bpf_object *obj)
 {
-	return obj->efile.st_ops_shndx >=3D 0;
+	return obj->efile.st_ops_shndx >=3D 0 || obj->efile.st_ops_link_shndx >=
=3D 0;
 }
=20
 static int bpf_object__init_btf(struct bpf_object *obj,
@@ -3451,6 +3482,9 @@ static int bpf_object__elf_collect(struct bpf_objec=
t *obj)
 			} else if (strcmp(name, STRUCT_OPS_SEC) =3D=3D 0) {
 				obj->efile.st_ops_data =3D data;
 				obj->efile.st_ops_shndx =3D idx;
+			} else if (strcmp(name, STRUCT_OPS_LINK_SEC) =3D=3D 0) {
+				obj->efile.st_ops_link_data =3D data;
+				obj->efile.st_ops_link_shndx =3D idx;
 			} else {
 				pr_info("elf: skipping unrecognized data section(%d) %s\n",
 					idx, name);
@@ -3465,6 +3499,7 @@ static int bpf_object__elf_collect(struct bpf_objec=
t *obj)
 			/* Only do relo for section with exec instructions */
 			if (!section_have_execinstr(obj, targ_sec_idx) &&
 			    strcmp(name, ".rel" STRUCT_OPS_SEC) &&
+			    strcmp(name, ".rel" STRUCT_OPS_LINK_SEC) &&
 			    strcmp(name, ".rel" MAPS_ELF_SEC)) {
 				pr_info("elf: skipping relo section(%d) %s for section(%d) %s\n",
 					idx, name, targ_sec_idx,
@@ -6611,7 +6646,7 @@ static int bpf_object__collect_relos(struct bpf_obj=
ect *obj)
 			return -LIBBPF_ERRNO__INTERNAL;
 		}
=20
-		if (idx =3D=3D obj->efile.st_ops_shndx)
+		if (idx =3D=3D obj->efile.st_ops_shndx || idx =3D=3D obj->efile.st_ops=
_link_shndx)
 			err =3D bpf_object__collect_st_ops_relos(obj, shdr, data);
 		else if (idx =3D=3D obj->efile.btf_maps_shndx)
 			err =3D bpf_object__collect_map_relos(obj, shdr, data);
@@ -8954,8 +8989,9 @@ static int bpf_object__collect_st_ops_relos(struct =
bpf_object *obj,
 		}
=20
 		/* struct_ops BPF prog can be re-used between multiple
-		 * .struct_ops as long as it's the same struct_ops struct
-		 * definition and the same function pointer field
+		 * .struct_ops & .struct_ops.link as long as it's the
+		 * same struct_ops struct definition and the same
+		 * function pointer field
 		 */
 		if (prog->attach_btf_id !=3D st_ops->type_id ||
 		    prog->expected_attach_type !=3D member_idx) {
--=20
2.34.1


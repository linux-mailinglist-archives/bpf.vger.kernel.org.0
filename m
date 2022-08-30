Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8100E5A6ADD
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 19:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbiH3Re0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 13:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbiH3Rdl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 13:33:41 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8492558DD
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:29:51 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UGLbJG003220
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:28:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Zu3eUoS3YFs3fC9lOiVyLm6LTawbtUPSRWdjUY2mbAE=;
 b=pPdxXzd9ZsNXtmKVNM+jnJkJ4u4sTQgU9tWJsJ7D21bueBPGS1dbEvh1sR9ObU6+NZeu
 q+cwZHfVq/IJD/Eev2p2EepuAWJlbD+7WV8ximMyLpl+eyYAFZRJJ6gpy/we5eVUtf0R
 AtYjd1tdWDrtqvv/ELzCCnFgUonjJMS/au8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j9h5djqgr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:28:17 -0700
Received: from twshared6324.05.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 10:28:16 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id DB31BCAD0772; Tue, 30 Aug 2022 10:28:09 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [RFCv2 PATCH bpf-next 05/18] libbpf: Add support for private BSS map section
Date:   Tue, 30 Aug 2022 10:27:46 -0700
Message-ID: <20220830172759.4069786-6-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220830172759.4069786-1-davemarchevsky@fb.com>
References: <20220830172759.4069786-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: l-76MBjYaZfJ_YOK9YAFc_0aHakB766G
X-Proofpoint-ORIG-GUID: l-76MBjYaZfJ_YOK9YAFc_0aHakB766G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_10,2022-08-30_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently libbpf does not allow declaration of a struct bpf_spin_lock in
global scope. Attempting to do so results in "failed to re-mmap" error,
as .bss arraymap containing spinlock is not allowed to be mmap'd.

This patch adds support for a .bss.private section. The maps contained
in this section will not be mmaped into userspace by libbpf, nor will
they be exposed via bpftool-generated skeleton.

Intent here is to allow more natural programming pattern for
global-scope spinlocks which will be used by rbtree locking mechanism in
further patches in this series.

[
  RFC Notes:

  * Initially I called the section .bss.no_mmap, but the broader
    'private' term better indicates that skeleton shouldn't expose these
    maps at all, IMO.

  * bpftool/gen.c's is_internal_mmapable_map function checks whether the
    map flags have BPF_F_MMAPABLE, so no bpftool changes were necessary
    to remove .bss.private maps from skeleton
]

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 tools/lib/bpf/libbpf.c | 65 ++++++++++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 21 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 3f01f5cd8a4c..a6dd53e0c4b4 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -463,6 +463,7 @@ struct bpf_struct_ops {
 #define KCONFIG_SEC ".kconfig"
 #define KSYMS_SEC ".ksyms"
 #define STRUCT_OPS_SEC ".struct_ops"
+#define BSS_SEC_PRIVATE ".bss.private"
=20
 enum libbpf_map_type {
 	LIBBPF_MAP_UNSPEC,
@@ -576,6 +577,7 @@ enum sec_type {
 	SEC_BSS,
 	SEC_DATA,
 	SEC_RODATA,
+	SEC_BSS_PRIVATE,
 };
=20
 struct elf_sec_desc {
@@ -1578,7 +1580,8 @@ bpf_map_find_btf_info(struct bpf_object *obj, struc=
t bpf_map *map);
=20
 static int
 bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_ty=
pe type,
-			      const char *real_name, int sec_idx, void *data, size_t data_sz)
+			      const char *real_name, int sec_idx, void *data,
+			      size_t data_sz, bool do_mmap)
 {
 	struct bpf_map_def *def;
 	struct bpf_map *map;
@@ -1606,27 +1609,31 @@ bpf_object__init_internal_map(struct bpf_object *=
obj, enum libbpf_map_type type,
 	def->max_entries =3D 1;
 	def->map_flags =3D type =3D=3D LIBBPF_MAP_RODATA || type =3D=3D LIBBPF_=
MAP_KCONFIG
 			 ? BPF_F_RDONLY_PROG : 0;
-	def->map_flags |=3D BPF_F_MMAPABLE;
+	if (do_mmap)
+		def->map_flags |=3D BPF_F_MMAPABLE;
=20
 	pr_debug("map '%s' (global data): at sec_idx %d, offset %zu, flags %x.\=
n",
 		 map->name, map->sec_idx, map->sec_offset, def->map_flags);
=20
-	map->mmaped =3D mmap(NULL, bpf_map_mmap_sz(map), PROT_READ | PROT_WRITE=
,
-			   MAP_SHARED | MAP_ANONYMOUS, -1, 0);
-	if (map->mmaped =3D=3D MAP_FAILED) {
-		err =3D -errno;
-		map->mmaped =3D NULL;
-		pr_warn("failed to alloc map '%s' content buffer: %d\n",
-			map->name, err);
-		zfree(&map->real_name);
-		zfree(&map->name);
-		return err;
+	map->mmaped =3D NULL;
+	if (do_mmap) {
+		map->mmaped =3D mmap(NULL, bpf_map_mmap_sz(map), PROT_READ | PROT_WRIT=
E,
+				   MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+		if (map->mmaped =3D=3D MAP_FAILED) {
+			err =3D -errno;
+			map->mmaped =3D NULL;
+			pr_warn("failed to alloc map '%s' content buffer: %d\n",
+				map->name, err);
+			zfree(&map->real_name);
+			zfree(&map->name);
+			return err;
+		}
 	}
=20
 	/* failures are fine because of maps like .rodata.str1.1 */
 	(void) bpf_map_find_btf_info(obj, map);
=20
-	if (data)
+	if (do_mmap && data)
 		memcpy(map->mmaped, data, data_sz);
=20
 	pr_debug("map %td is \"%s\"\n", map - obj->maps, map->name);
@@ -1638,12 +1645,14 @@ static int bpf_object__init_global_data_maps(stru=
ct bpf_object *obj)
 	struct elf_sec_desc *sec_desc;
 	const char *sec_name;
 	int err =3D 0, sec_idx;
+	bool do_mmap;
=20
 	/*
 	 * Populate obj->maps with libbpf internal maps.
 	 */
 	for (sec_idx =3D 1; sec_idx < obj->efile.sec_cnt; sec_idx++) {
 		sec_desc =3D &obj->efile.secs[sec_idx];
+		do_mmap =3D true;
=20
 		/* Skip recognized sections with size 0. */
 		if (sec_desc->data && sec_desc->data->d_size =3D=3D 0)
@@ -1655,7 +1664,8 @@ static int bpf_object__init_global_data_maps(struct=
 bpf_object *obj)
 			err =3D bpf_object__init_internal_map(obj, LIBBPF_MAP_DATA,
 							    sec_name, sec_idx,
 							    sec_desc->data->d_buf,
-							    sec_desc->data->d_size);
+							    sec_desc->data->d_size,
+							    do_mmap);
 			break;
 		case SEC_RODATA:
 			obj->has_rodata =3D true;
@@ -1663,14 +1673,18 @@ static int bpf_object__init_global_data_maps(stru=
ct bpf_object *obj)
 			err =3D bpf_object__init_internal_map(obj, LIBBPF_MAP_RODATA,
 							    sec_name, sec_idx,
 							    sec_desc->data->d_buf,
-							    sec_desc->data->d_size);
+							    sec_desc->data->d_size,
+							    do_mmap);
 			break;
+		case SEC_BSS_PRIVATE:
+			do_mmap =3D false;
 		case SEC_BSS:
 			sec_name =3D elf_sec_name(obj, elf_sec_by_idx(obj, sec_idx));
 			err =3D bpf_object__init_internal_map(obj, LIBBPF_MAP_BSS,
 							    sec_name, sec_idx,
 							    NULL,
-							    sec_desc->data->d_size);
+							    sec_desc->data->d_size,
+							    do_mmap);
 			break;
 		default:
 			/* skip */
@@ -1984,7 +1998,7 @@ static int bpf_object__init_kconfig_map(struct bpf_=
object *obj)
 	map_sz =3D last_ext->kcfg.data_off + last_ext->kcfg.sz;
 	err =3D bpf_object__init_internal_map(obj, LIBBPF_MAP_KCONFIG,
 					    ".kconfig", obj->efile.symbols_shndx,
-					    NULL, map_sz);
+					    NULL, map_sz, true);
 	if (err)
 		return err;
=20
@@ -3428,6 +3442,10 @@ static int bpf_object__elf_collect(struct bpf_obje=
ct *obj)
 			sec_desc->sec_type =3D SEC_BSS;
 			sec_desc->shdr =3D sh;
 			sec_desc->data =3D data;
+		} else if (sh->sh_type =3D=3D SHT_NOBITS && strcmp(name, BSS_SEC_PRIVA=
TE) =3D=3D 0) {
+			sec_desc->sec_type =3D SEC_BSS_PRIVATE;
+			sec_desc->shdr =3D sh;
+			sec_desc->data =3D data;
 		} else {
 			pr_info("elf: skipping section(%d) %s (size %zu)\n", idx, name,
 				(size_t)sh->sh_size);
@@ -3890,6 +3908,7 @@ static bool bpf_object__shndx_is_data(const struct =
bpf_object *obj,
 	case SEC_BSS:
 	case SEC_DATA:
 	case SEC_RODATA:
+	case SEC_BSS_PRIVATE:
 		return true;
 	default:
 		return false;
@@ -3909,6 +3928,7 @@ bpf_object__section_to_libbpf_map_type(const struct=
 bpf_object *obj, int shndx)
 		return LIBBPF_MAP_KCONFIG;
=20
 	switch (obj->efile.secs[shndx].sec_type) {
+	case SEC_BSS_PRIVATE:
 	case SEC_BSS:
 		return LIBBPF_MAP_BSS;
 	case SEC_DATA:
@@ -4889,16 +4909,19 @@ bpf_object__populate_internal_map(struct bpf_obje=
ct *obj, struct bpf_map *map)
 {
 	enum libbpf_map_type map_type =3D map->libbpf_type;
 	char *cp, errmsg[STRERR_BUFSIZE];
-	int err, zero =3D 0;
+	int err =3D 0, zero =3D 0;
=20
 	if (obj->gen_loader) {
-		bpf_gen__map_update_elem(obj->gen_loader, map - obj->maps,
-					 map->mmaped, map->def.value_size);
+		if (map->mmaped)
+			bpf_gen__map_update_elem(obj->gen_loader, map - obj->maps,
+						 map->mmaped, map->def.value_size);
 		if (map_type =3D=3D LIBBPF_MAP_RODATA || map_type =3D=3D LIBBPF_MAP_KC=
ONFIG)
 			bpf_gen__map_freeze(obj->gen_loader, map - obj->maps);
 		return 0;
 	}
-	err =3D bpf_map_update_elem(map->fd, &zero, map->mmaped, 0);
+
+	if (map->mmaped)
+		err =3D bpf_map_update_elem(map->fd, &zero, map->mmaped, 0);
 	if (err) {
 		err =3D -errno;
 		cp =3D libbpf_strerror_r(err, errmsg, sizeof(errmsg));
--=20
2.30.2


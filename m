Return-Path: <bpf+bounces-18787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E88D98221A4
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 20:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C37CB2274E
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 19:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBABF15E97;
	Tue,  2 Jan 2024 19:01:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9025415EAB
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 19:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 402IZRWR030510
	for <bpf@vger.kernel.org>; Tue, 2 Jan 2024 11:01:10 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3vc9sn4hpm-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 11:01:10 -0800
Received: from twshared20528.39.frc1.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 2 Jan 2024 11:01:06 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 1ABAE3DF01600; Tue,  2 Jan 2024 11:01:00 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 1/9] libbpf: name internal functions consistently
Date: Tue, 2 Jan 2024 11:00:47 -0800
Message-ID: <20240102190055.1602698-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102190055.1602698-1-andrii@kernel.org>
References: <20240102190055.1602698-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: JXApZYAvF3XPZjMy4D34KUFPMWsY5mZd
X-Proofpoint-ORIG-GUID: JXApZYAvF3XPZjMy4D34KUFPMWsY5mZd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-02_06,2024-01-02_01,2023-05-22_02

For a while now all new internal libbpf functions stopped using
<obj>__<method>() naming, which was historically used both for public
APIs and all the helper functions that can be thought of as "methods" of
libbpf "objects" (bpf_object, bpf_map, bpf_program, etc). This
convention turned out to be confusing because of "could be public API"
concerns, requiring double-checking whether a given function needs
special treatment or not (special error return handling, for example).

We've been doing conversion of pre-existing code naming lazily as we
touched relevant functions, but there are still a bunch of functions
remaining that use old double-underscore naming.

To remove all the confusion and inconsistent naming, complete the rename
to keep double-underscore naming only for public APIs.

There are some notable exceptions, though. Libbpf has a bunch of
APIs that are internal to libbpf, but still are used as API boundaries.
For example, bpf_gen__xxx() is designed to be decoupled from libbpf.c's
logic. Similarly, we have hashmap and strset datastructures with their
own internal APIs (some of which are actually used by bpftool as well,
so they are kind-of-internal). For those internal APIs we still keep
API-like naming with double underscores.

No functional changes.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 504 +++++++++++++++++++----------------------
 1 file changed, 238 insertions(+), 266 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ebcfb2147fbd..8e7a50c1ce89 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -68,7 +68,7 @@
=20
 #define __printf(a, b)	__attribute__((format(printf, a, b)))
=20
-static struct bpf_map *bpf_object__add_map(struct bpf_object *obj);
+static struct bpf_map *bpf_object_add_map(struct bpf_object *obj);
 static bool prog_is_subprog(const struct bpf_object *obj, const struct b=
pf_program *prog);
=20
 static const char * const attach_type_name[] =3D {
@@ -479,7 +479,7 @@ struct bpf_struct_ops {
 	 *	struct tcp_congestion_ops data;
 	 * }
 	 * kern_vdata-size =3D=3D sizeof(struct bpf_struct_ops_tcp_congestion_o=
ps)
-	 * bpf_map__init_kern_struct_ops() will populate the "kern_vdata"
+	 * bpf_map_init_kern_struct_ops() will populate the "kern_vdata"
 	 * from "data".
 	 */
 	void *kern_vdata;
@@ -717,7 +717,7 @@ void bpf_program__unload(struct bpf_program *prog)
 	zfree(&prog->line_info);
 }
=20
-static void bpf_program__exit(struct bpf_program *prog)
+static void bpf_program_exit(struct bpf_program *prog)
 {
 	if (!prog)
 		return;
@@ -753,10 +753,9 @@ static bool insn_is_pseudo_func(struct bpf_insn *ins=
n)
 	return is_ldimm64_insn(insn) && insn->src_reg =3D=3D BPF_PSEUDO_FUNC;
 }
=20
-static int
-bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
-		      const char *name, size_t sec_idx, const char *sec_name,
-		      size_t sec_off, void *insn_data, size_t insn_data_sz)
+static int bpf_object_init_prog(struct bpf_object *obj, struct bpf_progr=
am *prog,
+				const char *name, size_t sec_idx, const char *sec_name,
+				size_t sec_off, void *insn_data, size_t insn_data_sz)
 {
 	if (insn_data_sz =3D=3D 0 || insn_data_sz % BPF_INSN_SZ || sec_off % BP=
F_INSN_SZ) {
 		pr_warn("sec '%s': corrupted program '%s', offset %zu, size %zu\n",
@@ -810,13 +809,12 @@ bpf_object__init_prog(struct bpf_object *obj, struc=
t bpf_program *prog,
 	return 0;
 errout:
 	pr_warn("sec '%s': failed to allocate memory for prog '%s'\n", sec_name=
, name);
-	bpf_program__exit(prog);
+	bpf_program_exit(prog);
 	return -ENOMEM;
 }
=20
-static int
-bpf_object__add_programs(struct bpf_object *obj, Elf_Data *sec_data,
-			 const char *sec_name, int sec_idx)
+static int bpf_object_add_programs(struct bpf_object *obj, Elf_Data *sec=
_data,
+				   const char *sec_name, int sec_idx)
 {
 	Elf_Data *symbols =3D obj->efile.symbols;
 	struct bpf_program *prog, *progs;
@@ -877,8 +875,8 @@ bpf_object__add_programs(struct bpf_object *obj, Elf_=
Data *sec_data,
=20
 		prog =3D &progs[nr_progs];
=20
-		err =3D bpf_object__init_prog(obj, prog, name, sec_idx, sec_name,
-					    sec_off, data + sec_off, prog_sz);
+		err =3D bpf_object_init_prog(obj, prog, name, sec_idx, sec_name,
+					   sec_off, data + sec_off, prog_sz);
 		if (err)
 			return err;
=20
@@ -993,15 +991,15 @@ find_struct_ops_kern_types(const struct btf *btf, c=
onst char *tname,
 	return 0;
 }
=20
-static bool bpf_map__is_struct_ops(const struct bpf_map *map)
+static bool bpf_map_is_struct_ops(const struct bpf_map *map)
 {
 	return map->def.type =3D=3D BPF_MAP_TYPE_STRUCT_OPS;
 }
=20
 /* Init the map's fields that depend on kern_btf */
-static int bpf_map__init_kern_struct_ops(struct bpf_map *map,
-					 const struct btf *btf,
-					 const struct btf *kern_btf)
+static int bpf_map_init_kern_struct_ops(struct bpf_map *map,
+					const struct btf *btf,
+					const struct btf *kern_btf)
 {
 	const struct btf_member *member, *kern_member, *kern_data_member;
 	const struct btf_type *type, *kern_type, *kern_vtype;
@@ -1090,7 +1088,7 @@ static int bpf_map__init_kern_struct_ops(struct bpf=
_map *map,
 							    &kern_mtype_id);
=20
 			/* mtype->type must be a func_proto which was
-			 * guaranteed in bpf_object__collect_st_ops_relos(),
+			 * guaranteed in bpf_object_collect_st_ops_relos(),
 			 * so only check kern_mtype for func_proto here.
 			 */
 			if (!btf_is_func_proto(kern_mtype)) {
@@ -1129,7 +1127,7 @@ static int bpf_map__init_kern_struct_ops(struct bpf=
_map *map,
 	return 0;
 }
=20
-static int bpf_object__init_kern_struct_ops_maps(struct bpf_object *obj)
+static int bpf_object_init_kern_struct_ops_maps(struct bpf_object *obj)
 {
 	struct bpf_map *map;
 	size_t i;
@@ -1138,11 +1136,10 @@ static int bpf_object__init_kern_struct_ops_maps(=
struct bpf_object *obj)
 	for (i =3D 0; i < obj->nr_maps; i++) {
 		map =3D &obj->maps[i];
=20
-		if (!bpf_map__is_struct_ops(map))
+		if (!bpf_map_is_struct_ops(map))
 			continue;
=20
-		err =3D bpf_map__init_kern_struct_ops(map, obj->btf,
-						    obj->btf_vmlinux);
+		err =3D bpf_map_init_kern_struct_ops(map, obj->btf, obj->btf_vmlinux);
 		if (err)
 			return err;
 	}
@@ -1198,7 +1195,7 @@ static int init_struct_ops_maps(struct bpf_object *=
obj, const char *sec_name,
 			return -EINVAL;
 		}
=20
-		map =3D bpf_object__add_map(obj);
+		map =3D bpf_object_add_map(obj);
 		if (IS_ERR(map))
 			return PTR_ERR(map);
=20
@@ -1258,10 +1255,10 @@ static int bpf_object_init_struct_ops(struct bpf_=
object *obj)
 	return err;
 }
=20
-static struct bpf_object *bpf_object__new(const char *path,
-					  const void *obj_buf,
-					  size_t obj_buf_sz,
-					  const char *obj_name)
+static struct bpf_object *bpf_object_new(const char *path,
+					 const void *obj_buf,
+					 size_t obj_buf_sz,
+					 const char *obj_name)
 {
 	struct bpf_object *obj;
 	char *end;
@@ -1286,7 +1283,7 @@ static struct bpf_object *bpf_object__new(const cha=
r *path,
 	obj->efile.fd =3D -1;
 	/*
 	 * Caller of this function should also call
-	 * bpf_object__elf_finish() after data collection to return
+	 * bpf_object_elf_finish() after data collection to return
 	 * obj_buf to user. If not, we should duplicate the buffer to
 	 * avoid user freeing them before elf finish.
 	 */
@@ -1303,7 +1300,7 @@ static struct bpf_object *bpf_object__new(const cha=
r *path,
 	return obj;
 }
=20
-static void bpf_object__elf_finish(struct bpf_object *obj)
+static void bpf_object_elf_finish(struct bpf_object *obj)
 {
 	if (!obj->efile.elf)
 		return;
@@ -1321,7 +1318,7 @@ static void bpf_object__elf_finish(struct bpf_objec=
t *obj)
 	obj->efile.obj_buf_sz =3D 0;
 }
=20
-static int bpf_object__elf_init(struct bpf_object *obj)
+static int bpf_object_elf_init(struct bpf_object *obj)
 {
 	Elf64_Ehdr *ehdr;
 	int err =3D 0;
@@ -1400,11 +1397,11 @@ static int bpf_object__elf_init(struct bpf_object=
 *obj)
=20
 	return 0;
 errout:
-	bpf_object__elf_finish(obj);
+	bpf_object_elf_finish(obj);
 	return err;
 }
=20
-static int bpf_object__check_endianness(struct bpf_object *obj)
+static int bpf_object_check_endianness(struct bpf_object *obj)
 {
 #if __BYTE_ORDER__ =3D=3D __ORDER_LITTLE_ENDIAN__
 	if (obj->efile.ehdr->e_ident[EI_DATA] =3D=3D ELFDATA2LSB)
@@ -1419,8 +1416,7 @@ static int bpf_object__check_endianness(struct bpf_=
object *obj)
 	return -LIBBPF_ERRNO__ENDIAN;
 }
=20
-static int
-bpf_object__init_license(struct bpf_object *obj, void *data, size_t size=
)
+static int bpf_object_init_license(struct bpf_object *obj, void *data, s=
ize_t size)
 {
 	if (!data) {
 		pr_warn("invalid license section in %s\n", obj->path);
@@ -1434,8 +1430,7 @@ bpf_object__init_license(struct bpf_object *obj, vo=
id *data, size_t size)
 	return 0;
 }
=20
-static int
-bpf_object__init_kversion(struct bpf_object *obj, void *data, size_t siz=
e)
+static int bpf_object_init_kversion(struct bpf_object *obj, void *data, =
size_t size)
 {
 	__u32 kver;
=20
@@ -1449,7 +1444,7 @@ bpf_object__init_kversion(struct bpf_object *obj, v=
oid *data, size_t size)
 	return 0;
 }
=20
-static bool bpf_map_type__is_map_in_map(enum bpf_map_type type)
+static bool bpf_map_type_is_map_in_map(enum bpf_map_type type)
 {
 	if (type =3D=3D BPF_MAP_TYPE_ARRAY_OF_MAPS ||
 	    type =3D=3D BPF_MAP_TYPE_HASH_OF_MAPS)
@@ -1503,7 +1498,7 @@ static Elf64_Sym *find_elf_var_sym(const struct bpf=
_object *obj, const char *nam
 	return ERR_PTR(-ENOENT);
 }
=20
-static struct bpf_map *bpf_object__add_map(struct bpf_object *obj)
+static struct bpf_map *bpf_object_add_map(struct bpf_object *obj)
 {
 	struct bpf_map *map;
 	int err;
@@ -1645,15 +1640,15 @@ static bool map_is_mmapable(struct bpf_object *ob=
j, struct bpf_map *map)
 }
=20
 static int
-bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_ty=
pe type,
-			      const char *real_name, int sec_idx, void *data, size_t data_sz)
+bpf_object_init_internal_map(struct bpf_object *obj, enum libbpf_map_typ=
e type,
+			     const char *real_name, int sec_idx, void *data, size_t data_sz)
 {
 	struct bpf_map_def *def;
 	struct bpf_map *map;
 	size_t mmap_sz;
 	int err;
=20
-	map =3D bpf_object__add_map(obj);
+	map =3D bpf_object_add_map(obj);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
=20
@@ -1705,7 +1700,7 @@ bpf_object__init_internal_map(struct bpf_object *ob=
j, enum libbpf_map_type type,
 	return 0;
 }
=20
-static int bpf_object__init_global_data_maps(struct bpf_object *obj)
+static int bpf_object_init_global_data_maps(struct bpf_object *obj)
 {
 	struct elf_sec_desc *sec_desc;
 	const char *sec_name;
@@ -1724,25 +1719,25 @@ static int bpf_object__init_global_data_maps(stru=
ct bpf_object *obj)
 		switch (sec_desc->sec_type) {
 		case SEC_DATA:
 			sec_name =3D elf_sec_name(obj, elf_sec_by_idx(obj, sec_idx));
-			err =3D bpf_object__init_internal_map(obj, LIBBPF_MAP_DATA,
-							    sec_name, sec_idx,
-							    sec_desc->data->d_buf,
-							    sec_desc->data->d_size);
+			err =3D bpf_object_init_internal_map(obj, LIBBPF_MAP_DATA,
+							   sec_name, sec_idx,
+							   sec_desc->data->d_buf,
+							   sec_desc->data->d_size);
 			break;
 		case SEC_RODATA:
 			obj->has_rodata =3D true;
 			sec_name =3D elf_sec_name(obj, elf_sec_by_idx(obj, sec_idx));
-			err =3D bpf_object__init_internal_map(obj, LIBBPF_MAP_RODATA,
-							    sec_name, sec_idx,
-							    sec_desc->data->d_buf,
-							    sec_desc->data->d_size);
+			err =3D bpf_object_init_internal_map(obj, LIBBPF_MAP_RODATA,
+							   sec_name, sec_idx,
+							   sec_desc->data->d_buf,
+							   sec_desc->data->d_size);
 			break;
 		case SEC_BSS:
 			sec_name =3D elf_sec_name(obj, elf_sec_by_idx(obj, sec_idx));
-			err =3D bpf_object__init_internal_map(obj, LIBBPF_MAP_BSS,
-							    sec_name, sec_idx,
-							    NULL,
-							    sec_desc->data->d_size);
+			err =3D bpf_object_init_internal_map(obj, LIBBPF_MAP_BSS,
+							   sec_name, sec_idx,
+							   NULL,
+							   sec_desc->data->d_size);
 			break;
 		default:
 			/* skip */
@@ -1917,8 +1912,7 @@ static int set_kcfg_value_num(struct extern_desc *e=
xt, void *ext_val,
 	return 0;
 }
=20
-static int bpf_object__process_kconfig_line(struct bpf_object *obj,
-					    char *buf, void *data)
+static int bpf_object_process_kconfig_line(struct bpf_object *obj, char =
*buf, void *data)
 {
 	struct extern_desc *ext;
 	char *sep, *value;
@@ -1981,7 +1975,7 @@ static int bpf_object__process_kconfig_line(struct =
bpf_object *obj,
 	return 0;
 }
=20
-static int bpf_object__read_kconfig_file(struct bpf_object *obj, void *d=
ata)
+static int bpf_object_read_kconfig_file(struct bpf_object *obj, void *da=
ta)
 {
 	char buf[PATH_MAX];
 	struct utsname uts;
@@ -2006,7 +2000,7 @@ static int bpf_object__read_kconfig_file(struct bpf=
_object *obj, void *data)
 	}
=20
 	while (gzgets(file, buf, sizeof(buf))) {
-		err =3D bpf_object__process_kconfig_line(obj, buf, data);
+		err =3D bpf_object_process_kconfig_line(obj, buf, data);
 		if (err) {
 			pr_warn("error parsing system Kconfig line '%s': %d\n",
 				buf, err);
@@ -2019,8 +2013,7 @@ static int bpf_object__read_kconfig_file(struct bpf=
_object *obj, void *data)
 	return err;
 }
=20
-static int bpf_object__read_kconfig_mem(struct bpf_object *obj,
-					const char *config, void *data)
+static int bpf_object_read_kconfig_mem(struct bpf_object *obj, const cha=
r *config, void *data)
 {
 	char buf[PATH_MAX];
 	int err =3D 0;
@@ -2034,7 +2027,7 @@ static int bpf_object__read_kconfig_mem(struct bpf_=
object *obj,
 	}
=20
 	while (fgets(buf, sizeof(buf), file)) {
-		err =3D bpf_object__process_kconfig_line(obj, buf, data);
+		err =3D bpf_object_process_kconfig_line(obj, buf, data);
 		if (err) {
 			pr_warn("error parsing in-memory Kconfig line '%s': %d\n",
 				buf, err);
@@ -2046,7 +2039,7 @@ static int bpf_object__read_kconfig_mem(struct bpf_=
object *obj,
 	return err;
 }
=20
-static int bpf_object__init_kconfig_map(struct bpf_object *obj)
+static int bpf_object_init_kconfig_map(struct bpf_object *obj)
 {
 	struct extern_desc *last_ext =3D NULL, *ext;
 	size_t map_sz;
@@ -2062,9 +2055,9 @@ static int bpf_object__init_kconfig_map(struct bpf_=
object *obj)
 		return 0;
=20
 	map_sz =3D last_ext->kcfg.data_off + last_ext->kcfg.sz;
-	err =3D bpf_object__init_internal_map(obj, LIBBPF_MAP_KCONFIG,
-					    ".kconfig", obj->efile.symbols_shndx,
-					    NULL, map_sz);
+	err =3D bpf_object_init_internal_map(obj, LIBBPF_MAP_KCONFIG,
+					   ".kconfig", obj->efile.symbols_shndx,
+					   NULL, map_sz);
 	if (err)
 		return err;
=20
@@ -2324,7 +2317,7 @@ int parse_btf_map_def(const char *map_name, struct =
btf *btf,
 			map_def->parts |=3D MAP_DEF_VALUE_SIZE | MAP_DEF_VALUE_TYPE;
 		}
 		else if (strcmp(name, "values") =3D=3D 0) {
-			bool is_map_in_map =3D bpf_map_type__is_map_in_map(map_def->map_type)=
;
+			bool is_map_in_map =3D bpf_map_type_is_map_in_map(map_def->map_type);
 			bool is_prog_array =3D map_def->map_type =3D=3D BPF_MAP_TYPE_PROG_ARR=
AY;
 			const char *desc =3D is_map_in_map ? "map-in-map inner" : "prog-array=
 value";
 			char inner_map_name[128];
@@ -2524,11 +2517,11 @@ static const char *btf_var_linkage_str(__u32 link=
age)
 	}
 }
=20
-static int bpf_object__init_user_btf_map(struct bpf_object *obj,
-					 const struct btf_type *sec,
-					 int var_idx, int sec_idx,
-					 const Elf_Data *data, bool strict,
-					 const char *pin_root_path)
+static int bpf_object_init_user_btf_map(struct bpf_object *obj,
+					const struct btf_type *sec,
+					int var_idx, int sec_idx,
+					const Elf_Data *data, bool strict,
+					const char *pin_root_path)
 {
 	struct btf_map_def map_def =3D {}, inner_def =3D {};
 	const struct btf_type *var, *def;
@@ -2573,7 +2566,7 @@ static int bpf_object__init_user_btf_map(struct bpf=
_object *obj,
 		return -EINVAL;
 	}
=20
-	map =3D bpf_object__add_map(obj);
+	map =3D bpf_object_add_map(obj);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
 	map->name =3D strdup(map_name);
@@ -2624,8 +2617,8 @@ static int bpf_object__init_user_btf_map(struct bpf=
_object *obj,
 	return 0;
 }
=20
-static int bpf_object__init_user_btf_maps(struct bpf_object *obj, bool s=
trict,
-					  const char *pin_root_path)
+static int bpf_object_init_user_btf_maps(struct bpf_object *obj, bool st=
rict,
+					 const char *pin_root_path)
 {
 	const struct btf_type *sec =3D NULL;
 	int nr_types, i, vlen, err;
@@ -2665,10 +2658,10 @@ static int bpf_object__init_user_btf_maps(struct =
bpf_object *obj, bool strict,
=20
 	vlen =3D btf_vlen(sec);
 	for (i =3D 0; i < vlen; i++) {
-		err =3D bpf_object__init_user_btf_map(obj, sec, i,
-						    obj->efile.btf_maps_shndx,
-						    data, strict,
-						    pin_root_path);
+		err =3D bpf_object_init_user_btf_map(obj, sec, i,
+						   obj->efile.btf_maps_shndx,
+						   data, strict,
+						   pin_root_path);
 		if (err)
 			return err;
 	}
@@ -2676,8 +2669,7 @@ static int bpf_object__init_user_btf_maps(struct bp=
f_object *obj, bool strict,
 	return 0;
 }
=20
-static int bpf_object__init_maps(struct bpf_object *obj,
-				 const struct bpf_object_open_opts *opts)
+static int bpf_object_init_maps(struct bpf_object *obj, const struct bpf=
_object_open_opts *opts)
 {
 	const char *pin_root_path;
 	bool strict;
@@ -2686,9 +2678,9 @@ static int bpf_object__init_maps(struct bpf_object =
*obj,
 	strict =3D !OPTS_GET(opts, relaxed_maps, false);
 	pin_root_path =3D OPTS_GET(opts, pin_root_path, NULL);
=20
-	err =3D bpf_object__init_user_btf_maps(obj, strict, pin_root_path);
-	err =3D err ?: bpf_object__init_global_data_maps(obj);
-	err =3D err ?: bpf_object__init_kconfig_map(obj);
+	err =3D bpf_object_init_user_btf_maps(obj, strict, pin_root_path);
+	err =3D err ?: bpf_object_init_global_data_maps(obj);
+	err =3D err ?: bpf_object_init_kconfig_map(obj);
 	err =3D err ?: bpf_object_init_struct_ops(obj);
=20
 	return err;
@@ -2719,7 +2711,7 @@ static bool btf_needs_sanitization(struct bpf_objec=
t *obj)
 	       !has_decl_tag || !has_type_tag || !has_enum64;
 }
=20
-static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *=
btf)
+static int bpf_object_sanitize_btf(struct bpf_object *obj, struct btf *b=
tf)
 {
 	bool has_func_global =3D kernel_supports(obj, FEAT_BTF_GLOBAL_FUNC);
 	bool has_datasec =3D kernel_supports(obj, FEAT_BTF_DATASEC);
@@ -2832,9 +2824,7 @@ static bool kernel_needs_btf(const struct bpf_objec=
t *obj)
 	return obj->efile.st_ops_shndx >=3D 0 || obj->efile.st_ops_link_shndx >=
=3D 0;
 }
=20
-static int bpf_object__init_btf(struct bpf_object *obj,
-				Elf_Data *btf_data,
-				Elf_Data *btf_ext_data)
+static int bpf_object_init_btf(struct bpf_object *obj, Elf_Data *btf_dat=
a, Elf_Data *btf_ext_data)
 {
 	int err =3D -ENOENT;
=20
@@ -3056,7 +3046,7 @@ static bool prog_needs_vmlinux_btf(struct bpf_progr=
am *prog)
=20
 static bool map_needs_vmlinux_btf(struct bpf_map *map)
 {
-	return bpf_map__is_struct_ops(map);
+	return bpf_map_is_struct_ops(map);
 }
=20
 static bool obj_needs_vmlinux_btf(const struct bpf_object *obj)
@@ -3095,7 +3085,7 @@ static bool obj_needs_vmlinux_btf(const struct bpf_=
object *obj)
 	return false;
 }
=20
-static int bpf_object__load_vmlinux_btf(struct bpf_object *obj, bool for=
ce)
+static int bpf_object_load_vmlinux_btf(struct bpf_object *obj, bool forc=
e)
 {
 	int err;
=20
@@ -3116,7 +3106,7 @@ static int bpf_object__load_vmlinux_btf(struct bpf_=
object *obj, bool force)
 	return 0;
 }
=20
-static int bpf_object__sanitize_and_load_btf(struct bpf_object *obj)
+static int bpf_object_sanitize_and_load_btf(struct bpf_object *obj)
 {
 	struct btf *kern_btf =3D obj->btf;
 	bool btf_mandatory, sanitize;
@@ -3260,7 +3250,7 @@ static int bpf_object__sanitize_and_load_btf(struct=
 bpf_object *obj)
=20
 		/* enforce 8-byte pointers for BPF-targeted BTFs */
 		btf__set_pointer_size(obj->btf, 8);
-		err =3D bpf_object__sanitize_btf(obj, kern_btf);
+		err =3D bpf_object_sanitize_btf(obj, kern_btf);
 		if (err)
 			return err;
 	}
@@ -3486,7 +3476,7 @@ static int cmp_progs(const void *_a, const void *_b=
)
 	return a->sec_insn_off < b->sec_insn_off ? -1 : 1;
 }
=20
-static int bpf_object__elf_collect(struct bpf_object *obj)
+static int bpf_object_elf_collect(struct bpf_object *obj)
 {
 	struct elf_sec_desc *sec_desc;
 	Elf *elf =3D obj->efile.elf;
@@ -3571,11 +3561,11 @@ static int bpf_object__elf_collect(struct bpf_obj=
ect *obj)
 			 (int)sh->sh_type);
=20
 		if (strcmp(name, "license") =3D=3D 0) {
-			err =3D bpf_object__init_license(obj, data->d_buf, data->d_size);
+			err =3D bpf_object_init_license(obj, data->d_buf, data->d_size);
 			if (err)
 				return err;
 		} else if (strcmp(name, "version") =3D=3D 0) {
-			err =3D bpf_object__init_kversion(obj, data->d_buf, data->d_size);
+			err =3D bpf_object_init_kversion(obj, data->d_buf, data->d_size);
 			if (err)
 				return err;
 		} else if (strcmp(name, "maps") =3D=3D 0) {
@@ -3597,7 +3587,7 @@ static int bpf_object__elf_collect(struct bpf_objec=
t *obj)
 			if (sh->sh_flags & SHF_EXECINSTR) {
 				if (strcmp(name, ".text") =3D=3D 0)
 					obj->efile.text_shndx =3D idx;
-				err =3D bpf_object__add_programs(obj, data, name, idx);
+				err =3D bpf_object_add_programs(obj, data, name, idx);
 				if (err)
 					return err;
 			} else if (strcmp(name, DATA_SEC) =3D=3D 0 ||
@@ -3663,7 +3653,7 @@ static int bpf_object__elf_collect(struct bpf_objec=
t *obj)
 	if (obj->nr_programs)
 		qsort(obj->programs, obj->nr_programs, sizeof(*obj->programs), cmp_pro=
gs);
=20
-	return bpf_object__init_btf(obj, btf_data, btf_ext_data);
+	return bpf_object_init_btf(obj, btf_data, btf_ext_data);
 }
=20
 static bool sym_is_extern(const Elf64_Sym *sym)
@@ -3872,7 +3862,7 @@ static int add_dummy_ksym_var(struct btf *btf)
 	return dummy_var_btf_id;
 }
=20
-static int bpf_object__collect_externs(struct bpf_object *obj)
+static int bpf_object_collect_externs(struct bpf_object *obj)
 {
 	struct btf_type *sec, *kcfg_sec =3D NULL, *ksym_sec =3D NULL;
 	const struct btf_type *t;
@@ -4111,8 +4101,7 @@ bpf_object__find_program_by_name(const struct bpf_o=
bject *obj,
 	return errno =3D ENOENT, NULL;
 }
=20
-static bool bpf_object__shndx_is_data(const struct bpf_object *obj,
-				      int shndx)
+static bool bpf_object_shndx_is_data(const struct bpf_object *obj, int s=
hndx)
 {
 	switch (obj->efile.secs[shndx].sec_type) {
 	case SEC_BSS:
@@ -4124,14 +4113,13 @@ static bool bpf_object__shndx_is_data(const struc=
t bpf_object *obj,
 	}
 }
=20
-static bool bpf_object__shndx_is_maps(const struct bpf_object *obj,
+static bool bpf_object_shndx_is_maps(const struct bpf_object *obj,
 				      int shndx)
 {
 	return shndx =3D=3D obj->efile.btf_maps_shndx;
 }
=20
-static enum libbpf_map_type
-bpf_object__section_to_libbpf_map_type(const struct bpf_object *obj, int=
 shndx)
+static enum libbpf_map_type map_section_to_libbpf_map_type(const struct =
bpf_object *obj, int shndx)
 {
 	if (shndx =3D=3D obj->efile.symbols_shndx)
 		return LIBBPF_MAP_KCONFIG;
@@ -4148,10 +4136,10 @@ bpf_object__section_to_libbpf_map_type(const stru=
ct bpf_object *obj, int shndx)
 	}
 }
=20
-static int bpf_program__record_reloc(struct bpf_program *prog,
-				     struct reloc_desc *reloc_desc,
-				     __u32 insn_idx, const char *sym_name,
-				     const Elf64_Sym *sym, const Elf64_Rel *rel)
+static int bpf_program_record_reloc(struct bpf_program *prog,
+				    struct reloc_desc *reloc_desc,
+				    __u32 insn_idx, const char *sym_name,
+				    const Elf64_Sym *sym, const Elf64_Rel *rel)
 {
 	struct bpf_insn *insn =3D &prog->insns[insn_idx];
 	size_t map_idx, nr_maps =3D prog->obj->nr_maps;
@@ -4240,12 +4228,12 @@ static int bpf_program__record_reloc(struct bpf_p=
rogram *prog,
 		return 0;
 	}
=20
-	type =3D bpf_object__section_to_libbpf_map_type(obj, shdr_idx);
+	type =3D map_section_to_libbpf_map_type(obj, shdr_idx);
 	sym_sec_name =3D elf_sec_name(obj, elf_sec_by_idx(obj, shdr_idx));
=20
 	/* generic map reference relocation */
 	if (type =3D=3D LIBBPF_MAP_UNSPEC) {
-		if (!bpf_object__shndx_is_maps(obj, shdr_idx)) {
+		if (!bpf_object_shndx_is_maps(obj, shdr_idx)) {
 			pr_warn("prog '%s': bad map relo against '%s' in section '%s'\n",
 				prog->name, sym_name, sym_sec_name);
 			return -LIBBPF_ERRNO__RELOC;
@@ -4274,7 +4262,7 @@ static int bpf_program__record_reloc(struct bpf_pro=
gram *prog,
 	}
=20
 	/* global data map relocation */
-	if (!bpf_object__shndx_is_data(obj, shdr_idx)) {
+	if (!bpf_object_shndx_is_data(obj, shdr_idx)) {
 		pr_warn("prog '%s': bad data relo against section '%s'\n",
 			prog->name, sym_sec_name);
 		return -LIBBPF_ERRNO__RELOC;
@@ -4335,8 +4323,7 @@ static struct bpf_program *find_prog_by_sec_insn(co=
nst struct bpf_object *obj,
 	return NULL;
 }
=20
-static int
-bpf_object__collect_prog_relos(struct bpf_object *obj, Elf64_Shdr *shdr,=
 Elf_Data *data)
+static int bpf_object_collect_prog_relos(struct bpf_object *obj, Elf64_S=
hdr *shdr, Elf_Data *data)
 {
 	const char *relo_sec_name, *sec_name;
 	size_t sec_idx =3D shdr->sh_info, sym_idx;
@@ -4425,8 +4412,8 @@ bpf_object__collect_prog_relos(struct bpf_object *o=
bj, Elf64_Shdr *shdr, Elf_Dat
=20
 		/* adjust insn_idx to local BPF program frame of reference */
 		insn_idx -=3D prog->sec_insn_off;
-		err =3D bpf_program__record_reloc(prog, &relos[prog->nr_reloc],
-						insn_idx, sym_name, sym, rel);
+		err =3D bpf_program_record_reloc(prog, &relos[prog->nr_reloc],
+					       insn_idx, sym_name, sym, rel);
 		if (err)
 			return err;
=20
@@ -4446,7 +4433,7 @@ static int map_fill_btf_type_info(struct bpf_object=
 *obj, struct bpf_map *map)
 	 * For struct_ops map, it does not need btf_key_type_id and
 	 * btf_value_type_id.
 	 */
-	if (map->sec_idx =3D=3D obj->efile.btf_maps_shndx || bpf_map__is_struct=
_ops(map))
+	if (map->sec_idx =3D=3D obj->efile.btf_maps_shndx || bpf_map_is_struct_=
ops(map))
 		return 0;
=20
 	/*
@@ -4584,7 +4571,7 @@ __u32 bpf_map__max_entries(const struct bpf_map *ma=
p)
=20
 struct bpf_map *bpf_map__inner_map(struct bpf_map *map)
 {
-	if (!bpf_map_type__is_map_in_map(map->def.type))
+	if (!bpf_map_type_is_map_in_map(map->def.type))
 		return errno =3D EINVAL, NULL;
=20
 	return map->inner_map;
@@ -4604,8 +4591,7 @@ int bpf_map__set_max_entries(struct bpf_map *map, _=
_u32 max_entries)
 	return 0;
 }
=20
-static int
-bpf_object__probe_loading(struct bpf_object *obj)
+static int bpf_object_probe_loading(struct bpf_object *obj)
 {
 	char *cp, errmsg[STRERR_BUFSIZE];
 	struct bpf_insn insns[] =3D {
@@ -5122,8 +5108,7 @@ static bool map_is_reuse_compat(const struct bpf_ma=
p *map, int map_fd)
 		map_info.map_extra =3D=3D map->map_extra);
 }
=20
-static int
-bpf_object__reuse_map(struct bpf_map *map)
+static int bpf_object_reuse_map(struct bpf_map *map)
 {
 	char *cp, errmsg[STRERR_BUFSIZE];
 	int err, pin_fd;
@@ -5161,8 +5146,7 @@ bpf_object__reuse_map(struct bpf_map *map)
 	return 0;
 }
=20
-static int
-bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map=
 *map)
+static int bpf_object_populate_internal_map(struct bpf_object *obj, stru=
ct bpf_map *map)
 {
 	enum libbpf_map_type map_type =3D map->libbpf_type;
 	char *cp, errmsg[STRERR_BUFSIZE];
@@ -5198,9 +5182,9 @@ bpf_object__populate_internal_map(struct bpf_object=
 *obj, struct bpf_map *map)
 	return 0;
 }
=20
-static void bpf_map__destroy(struct bpf_map *map);
+static void bpf_map_destroy(struct bpf_map *map);
=20
-static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map=
 *map, bool is_inner)
+static int bpf_object_create_map(struct bpf_object *obj, struct bpf_map =
*map, bool is_inner)
 {
 	LIBBPF_OPTS(bpf_map_create_opts, create_attr);
 	struct bpf_map_def *def =3D &map->def;
@@ -5214,7 +5198,7 @@ static int bpf_object__create_map(struct bpf_object=
 *obj, struct bpf_map *map, b
 	create_attr.numa_node =3D map->numa_node;
 	create_attr.map_extra =3D map->map_extra;
=20
-	if (bpf_map__is_struct_ops(map))
+	if (bpf_map_is_struct_ops(map))
 		create_attr.btf_vmlinux_value_type_id =3D map->btf_vmlinux_value_type_=
id;
=20
 	if (obj->btf && btf__fd(obj->btf) >=3D 0) {
@@ -5223,9 +5207,9 @@ static int bpf_object__create_map(struct bpf_object=
 *obj, struct bpf_map *map, b
 		create_attr.btf_value_type_id =3D map->btf_value_type_id;
 	}
=20
-	if (bpf_map_type__is_map_in_map(def->type)) {
+	if (bpf_map_type_is_map_in_map(def->type)) {
 		if (map->inner_map) {
-			err =3D bpf_object__create_map(obj, map->inner_map, true);
+			err =3D bpf_object_create_map(obj, map->inner_map, true);
 			if (err) {
 				pr_warn("map '%s': failed to create inner map: %d\n",
 					map->name, err);
@@ -5293,10 +5277,10 @@ static int bpf_object__create_map(struct bpf_obje=
ct *obj, struct bpf_map *map, b
=20
 	err =3D map->fd < 0 ? -errno : 0;
=20
-	if (bpf_map_type__is_map_in_map(def->type) && map->inner_map) {
+	if (bpf_map_type_is_map_in_map(def->type) && map->inner_map) {
 		if (obj->gen_loader)
 			map->inner_map->fd =3D -1;
-		bpf_map__destroy(map->inner_map);
+		bpf_map_destroy(map->inner_map);
 		zfree(&map->inner_map);
 	}
=20
@@ -5410,8 +5394,7 @@ static int map_set_def_max_entries(struct bpf_map *=
map)
 	return 0;
 }
=20
-static int
-bpf_object__create_maps(struct bpf_object *obj)
+static int bpf_object_create_maps(struct bpf_object *obj)
 {
 	struct bpf_map *map;
 	char *cp, errmsg[STRERR_BUFSIZE];
@@ -5451,7 +5434,7 @@ bpf_object__create_maps(struct bpf_object *obj)
 		retried =3D false;
 retry:
 		if (map->pin_path) {
-			err =3D bpf_object__reuse_map(map);
+			err =3D bpf_object_reuse_map(map);
 			if (err) {
 				pr_warn("map '%s': error reusing pinned map\n",
 					map->name);
@@ -5469,7 +5452,7 @@ bpf_object__create_maps(struct bpf_object *obj)
 			pr_debug("map '%s': skipping creation (preset fd=3D%d)\n",
 				 map->name, map->fd);
 		} else {
-			err =3D bpf_object__create_map(obj, map, false);
+			err =3D bpf_object_create_map(obj, map, false);
 			if (err)
 				goto err_out;
=20
@@ -5477,7 +5460,7 @@ bpf_object__create_maps(struct bpf_object *obj)
 				 map->name, map->fd);
=20
 			if (bpf_map__is_internal(map)) {
-				err =3D bpf_object__populate_internal_map(obj, map);
+				err =3D bpf_object_populate_internal_map(obj, map);
 				if (err < 0) {
 					zclose(map->fd);
 					goto err_out;
@@ -5879,8 +5862,7 @@ static int bpf_core_resolve_relo(struct bpf_program=
 *prog,
 				       targ_res);
 }
=20
-static int
-bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_p=
ath)
+static int bpf_object_relocate_core(struct bpf_object *obj, const char *=
targ_btf_path)
 {
 	const struct btf_ext_info_sec *sec;
 	struct bpf_core_relo_res targ_res;
@@ -6057,8 +6039,7 @@ static void poison_kfunc_call(struct bpf_program *p=
rog, int relo_idx,
  *  - global variable references;
  *  - extern references.
  */
-static int
-bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *pr=
og)
+static int bpf_object_relocate_data(struct bpf_object *obj, struct bpf_p=
rogram *prog)
 {
 	int i;
=20
@@ -6340,9 +6321,8 @@ static int append_subprog_relos(struct bpf_program =
*main_prog, struct bpf_progra
 	return 0;
 }
=20
-static int
-bpf_object__append_subprog_code(struct bpf_object *obj, struct bpf_progr=
am *main_prog,
-				struct bpf_program *subprog)
+static int bpf_object_append_subprog_code(struct bpf_object *obj, struct=
 bpf_program *main_prog,
+					  struct bpf_program *subprog)
 {
        struct bpf_insn *insns;
        size_t new_cnt;
@@ -6372,9 +6352,8 @@ bpf_object__append_subprog_code(struct bpf_object *=
obj, struct bpf_program *main
        return 0;
 }
=20
-static int
-bpf_object__reloc_code(struct bpf_object *obj, struct bpf_program *main_=
prog,
-		       struct bpf_program *prog)
+static int bpf_object_reloc_code(struct bpf_object *obj, struct bpf_prog=
ram *main_prog,
+				 struct bpf_program *prog)
 {
 	size_t sub_insn_idx, insn_idx;
 	struct bpf_program *subprog;
@@ -6394,7 +6373,7 @@ bpf_object__reloc_code(struct bpf_object *obj, stru=
ct bpf_program *main_prog,
 		relo =3D find_prog_insn_relo(prog, insn_idx);
 		if (relo && relo->type =3D=3D RELO_EXTERN_CALL)
 			/* kfunc relocations will be handled later
-			 * in bpf_object__relocate_data()
+			 * in bpf_object_relocate_data()
 			 */
 			continue;
 		if (relo && relo->type !=3D RELO_CALL && relo->type !=3D RELO_SUBPROG_=
ADDR) {
@@ -6454,10 +6433,10 @@ bpf_object__reloc_code(struct bpf_object *obj, st=
ruct bpf_program *main_prog,
 		 *   and relocate.
 		 */
 		if (subprog->sub_insn_off =3D=3D 0) {
-			err =3D bpf_object__append_subprog_code(obj, main_prog, subprog);
+			err =3D bpf_object_append_subprog_code(obj, main_prog, subprog);
 			if (err)
 				return err;
-			err =3D bpf_object__reloc_code(obj, main_prog, subprog);
+			err =3D bpf_object_reloc_code(obj, main_prog, subprog);
 			if (err)
 				return err;
 		}
@@ -6562,8 +6541,7 @@ bpf_object__reloc_code(struct bpf_object *obj, stru=
ct bpf_program *main_prog,
  *
  * At this point we unwind recursion, relocate calls in subC, then in ma=
inB.
  */
-static int
-bpf_object__relocate_calls(struct bpf_object *obj, struct bpf_program *p=
rog)
+static int bpf_object_relocate_calls(struct bpf_object *obj, struct bpf_=
program *prog)
 {
 	struct bpf_program *subprog;
 	int i, err;
@@ -6579,15 +6557,14 @@ bpf_object__relocate_calls(struct bpf_object *obj=
, struct bpf_program *prog)
 		subprog->sub_insn_off =3D 0;
 	}
=20
-	err =3D bpf_object__reloc_code(obj, prog, prog);
+	err =3D bpf_object_reloc_code(obj, prog, prog);
 	if (err)
 		return err;
=20
 	return 0;
 }
=20
-static void
-bpf_object__free_relocs(struct bpf_object *obj)
+static void bpf_object_free_relocs(struct bpf_object *obj)
 {
 	struct bpf_program *prog;
 	int i;
@@ -6615,7 +6592,7 @@ static int cmp_relocs(const void *_a, const void *_=
b)
 	return 0;
 }
=20
-static void bpf_object__sort_relos(struct bpf_object *obj)
+static void bpf_object_sort_relos(struct bpf_object *obj)
 {
 	int i;
=20
@@ -6630,25 +6607,25 @@ static void bpf_object__sort_relos(struct bpf_obj=
ect *obj)
 }
=20
 static int
-bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_path)
+bpf_object_relocate(struct bpf_object *obj, const char *targ_btf_path)
 {
 	struct bpf_program *prog;
 	size_t i, j;
 	int err;
=20
 	if (obj->btf_ext) {
-		err =3D bpf_object__relocate_core(obj, targ_btf_path);
+		err =3D bpf_object_relocate_core(obj, targ_btf_path);
 		if (err) {
 			pr_warn("failed to perform CO-RE relocations: %d\n",
 				err);
 			return err;
 		}
-		bpf_object__sort_relos(obj);
+		bpf_object_sort_relos(obj);
 	}
=20
 	/* Before relocating calls pre-process relocations and mark
 	 * few ld_imm64 instructions that points to subprogs.
-	 * Otherwise bpf_object__reloc_code() later would have to consider
+	 * Otherwise bpf_object_reloc_code() later would have to consider
 	 * all ld_imm64 insns as relocation candidates. That would
 	 * reduce relocation speed, since amount of find_prog_insn_relo()
 	 * would increase and most of them will fail to find a relo.
@@ -6682,7 +6659,7 @@ bpf_object__relocate(struct bpf_object *obj, const =
char *targ_btf_path)
 		if (!prog->autoload)
 			continue;
=20
-		err =3D bpf_object__relocate_calls(obj, prog);
+		err =3D bpf_object_relocate_calls(obj, prog);
 		if (err) {
 			pr_warn("prog '%s': failed to relocate calls: %d\n",
 				prog->name, err);
@@ -6699,10 +6676,10 @@ bpf_object__relocate(struct bpf_object *obj, cons=
t char *targ_btf_path)
 			 * have to append exception callback now.
 			 */
 			if (subprog->sub_insn_off =3D=3D 0) {
-				err =3D bpf_object__append_subprog_code(obj, prog, subprog);
+				err =3D bpf_object_append_subprog_code(obj, prog, subprog);
 				if (err)
 					return err;
-				err =3D bpf_object__reloc_code(obj, prog, subprog);
+				err =3D bpf_object_reloc_code(obj, prog, subprog);
 				if (err)
 					return err;
 			}
@@ -6715,7 +6692,7 @@ bpf_object__relocate(struct bpf_object *obj, const =
char *targ_btf_path)
 			continue;
 		if (!prog->autoload)
 			continue;
-		err =3D bpf_object__relocate_data(obj, prog);
+		err =3D bpf_object_relocate_data(obj, prog);
 		if (err) {
 			pr_warn("prog '%s': failed to relocate data references: %d\n",
 				prog->name, err);
@@ -6726,11 +6703,11 @@ bpf_object__relocate(struct bpf_object *obj, cons=
t char *targ_btf_path)
 	return 0;
 }
=20
-static int bpf_object__collect_st_ops_relos(struct bpf_object *obj,
-					    Elf64_Shdr *shdr, Elf_Data *data);
+static int bpf_object_collect_st_ops_relos(struct bpf_object *obj,
+					   Elf64_Shdr *shdr, Elf_Data *data);
=20
-static int bpf_object__collect_map_relos(struct bpf_object *obj,
-					 Elf64_Shdr *shdr, Elf_Data *data)
+static int bpf_object_collect_map_relos(struct bpf_object *obj,
+					Elf64_Shdr *shdr, Elf_Data *data)
 {
 	const int bpf_ptr_sz =3D 8, host_ptr_sz =3D sizeof(void *);
 	int i, j, nrels, new_sz;
@@ -6788,7 +6765,7 @@ static int bpf_object__collect_map_relos(struct bpf=
_object *obj,
 			return -EINVAL;
 		}
=20
-		is_map_in_map =3D bpf_map_type__is_map_in_map(map->def.type);
+		is_map_in_map =3D bpf_map_type_is_map_in_map(map->def.type);
 		is_prog_array =3D map->def.type =3D=3D BPF_MAP_TYPE_PROG_ARRAY;
 		type =3D is_map_in_map ? "map" : "prog";
 		if (is_map_in_map) {
@@ -6866,7 +6843,7 @@ static int bpf_object__collect_map_relos(struct bpf=
_object *obj,
 	return 0;
 }
=20
-static int bpf_object__collect_relos(struct bpf_object *obj)
+static int bpf_object_collect_relos(struct bpf_object *obj)
 {
 	int i, err;
=20
@@ -6889,16 +6866,16 @@ static int bpf_object__collect_relos(struct bpf_o=
bject *obj)
 		}
=20
 		if (idx =3D=3D obj->efile.st_ops_shndx || idx =3D=3D obj->efile.st_ops=
_link_shndx)
-			err =3D bpf_object__collect_st_ops_relos(obj, shdr, data);
+			err =3D bpf_object_collect_st_ops_relos(obj, shdr, data);
 		else if (idx =3D=3D obj->efile.btf_maps_shndx)
-			err =3D bpf_object__collect_map_relos(obj, shdr, data);
+			err =3D bpf_object_collect_map_relos(obj, shdr, data);
 		else
-			err =3D bpf_object__collect_prog_relos(obj, shdr, data);
+			err =3D bpf_object_collect_prog_relos(obj, shdr, data);
 		if (err)
 			return err;
 	}
=20
-	bpf_object__sort_relos(obj);
+	bpf_object_sort_relos(obj);
 	return 0;
 }
=20
@@ -6915,7 +6892,7 @@ static bool insn_is_helper_call(struct bpf_insn *in=
sn, enum bpf_func_id *func_id
 	return false;
 }
=20
-static int bpf_object__sanitize_prog(struct bpf_object *obj, struct bpf_=
program *prog)
+static int bpf_object_sanitize_prog(struct bpf_object *obj, struct bpf_p=
rogram *prog)
 {
 	struct bpf_insn *insn =3D prog->insns;
 	enum bpf_func_id func_id;
@@ -7433,7 +7410,7 @@ static int bpf_program_record_relos(struct bpf_prog=
ram *prog)
 }
=20
 static int
-bpf_object__load_progs(struct bpf_object *obj, int log_level)
+bpf_object_load_progs(struct bpf_object *obj, int log_level)
 {
 	struct bpf_program *prog;
 	size_t i;
@@ -7441,7 +7418,7 @@ bpf_object__load_progs(struct bpf_object *obj, int =
log_level)
=20
 	for (i =3D 0; i < obj->nr_programs; i++) {
 		prog =3D &obj->programs[i];
-		err =3D bpf_object__sanitize_prog(obj, prog);
+		err =3D bpf_object_sanitize_prog(obj, prog);
 		if (err)
 			return err;
 	}
@@ -7467,7 +7444,7 @@ bpf_object__load_progs(struct bpf_object *obj, int =
log_level)
 		}
 	}
=20
-	bpf_object__free_relocs(obj);
+	bpf_object_free_relocs(obj);
 	return 0;
 }
=20
@@ -7546,7 +7523,7 @@ static struct bpf_object *bpf_object_open(const cha=
r *path, const void *obj_buf,
 	if (log_size && !log_buf)
 		return ERR_PTR(-EINVAL);
=20
-	obj =3D bpf_object__new(path, obj_buf, obj_buf_sz, obj_name);
+	obj =3D bpf_object_new(path, obj_buf, obj_buf_sz, obj_name);
 	if (IS_ERR(obj))
 		return obj;
=20
@@ -7576,18 +7553,18 @@ static struct bpf_object *bpf_object_open(const c=
har *path, const void *obj_buf,
 		}
 	}
=20
-	err =3D bpf_object__elf_init(obj);
-	err =3D err ? : bpf_object__check_endianness(obj);
-	err =3D err ? : bpf_object__elf_collect(obj);
-	err =3D err ? : bpf_object__collect_externs(obj);
+	err =3D bpf_object_elf_init(obj);
+	err =3D err ? : bpf_object_check_endianness(obj);
+	err =3D err ? : bpf_object_elf_collect(obj);
+	err =3D err ? : bpf_object_collect_externs(obj);
 	err =3D err ? : bpf_object_fixup_btf(obj);
-	err =3D err ? : bpf_object__init_maps(obj, opts);
+	err =3D err ? : bpf_object_init_maps(obj, opts);
 	err =3D err ? : bpf_object_init_progs(obj, opts);
-	err =3D err ? : bpf_object__collect_relos(obj);
+	err =3D err ? : bpf_object_collect_relos(obj);
 	if (err)
 		goto out;
=20
-	bpf_object__elf_finish(obj);
+	bpf_object_elf_finish(obj);
=20
 	return obj;
 out:
@@ -7640,7 +7617,7 @@ static int bpf_object_unload(struct bpf_object *obj=
)
 	return 0;
 }
=20
-static int bpf_object__sanitize_maps(struct bpf_object *obj)
+static int bpf_object_sanitize_maps(struct bpf_object *obj)
 {
 	struct bpf_map *m;
=20
@@ -7716,7 +7693,7 @@ static int kallsyms_cb(unsigned long long sym_addr,=
 char sym_type,
 	return 0;
 }
=20
-static int bpf_object__read_kallsyms_file(struct bpf_object *obj)
+static int bpf_object_read_kallsyms_file(struct bpf_object *obj)
 {
 	return libbpf_kallsyms_parse(kallsyms_cb, obj);
 }
@@ -7755,8 +7732,7 @@ static int find_ksym_btf_id(struct bpf_object *obj,=
 const char *ksym_name,
 	return id;
 }
=20
-static int bpf_object__resolve_ksym_var_btf_id(struct bpf_object *obj,
-					       struct extern_desc *ext)
+static int bpf_object_resolve_ksym_var_btf_id(struct bpf_object *obj, st=
ruct extern_desc *ext)
 {
 	const struct btf_type *targ_var, *targ_type;
 	__u32 targ_type_id, local_type_id;
@@ -7808,8 +7784,7 @@ static int bpf_object__resolve_ksym_var_btf_id(stru=
ct bpf_object *obj,
 	return 0;
 }
=20
-static int bpf_object__resolve_ksym_func_btf_id(struct bpf_object *obj,
-						struct extern_desc *ext)
+static int bpf_object_resolve_ksym_func_btf_id(struct bpf_object *obj, s=
truct extern_desc *ext)
 {
 	int local_func_proto_id, kfunc_proto_id, kfunc_id;
 	struct module_btf *mod_btf =3D NULL;
@@ -7868,7 +7843,7 @@ static int bpf_object__resolve_ksym_func_btf_id(str=
uct bpf_object *obj,
 	ext->is_set =3D true;
 	ext->ksym.kernel_btf_id =3D kfunc_id;
 	ext->ksym.btf_fd_idx =3D mod_btf ? mod_btf->fd_array_idx : 0;
-	/* Also set kernel_btf_obj_fd to make sure that bpf_object__relocate_da=
ta()
+	/* Also set kernel_btf_obj_fd to make sure that bpf_object_relocate_dat=
a()
 	 * populates FD into ld_imm64 insn when it's used to point to kfunc.
 	 * {kernel_btf_id, btf_fd_idx} -> fixup bpf_call.
 	 * {kernel_btf_id, kernel_btf_obj_fd} -> fixup ld_imm64.
@@ -7880,7 +7855,7 @@ static int bpf_object__resolve_ksym_func_btf_id(str=
uct bpf_object *obj,
 	return 0;
 }
=20
-static int bpf_object__resolve_ksyms_btf_id(struct bpf_object *obj)
+static int bpf_object_resolve_ksyms_btf_id(struct bpf_object *obj)
 {
 	const struct btf_type *t;
 	struct extern_desc *ext;
@@ -7899,17 +7874,16 @@ static int bpf_object__resolve_ksyms_btf_id(struc=
t bpf_object *obj)
 		}
 		t =3D btf__type_by_id(obj->btf, ext->btf_id);
 		if (btf_is_var(t))
-			err =3D bpf_object__resolve_ksym_var_btf_id(obj, ext);
+			err =3D bpf_object_resolve_ksym_var_btf_id(obj, ext);
 		else
-			err =3D bpf_object__resolve_ksym_func_btf_id(obj, ext);
+			err =3D bpf_object_resolve_ksym_func_btf_id(obj, ext);
 		if (err)
 			return err;
 	}
 	return 0;
 }
=20
-static int bpf_object__resolve_externs(struct bpf_object *obj,
-				       const char *extra_kconfig)
+static int bpf_object_resolve_externs(struct bpf_object *obj, const char=
 *extra_kconfig)
 {
 	bool need_config =3D false, need_kallsyms =3D false;
 	bool need_vmlinux_btf =3D false;
@@ -7976,7 +7950,7 @@ static int bpf_object__resolve_externs(struct bpf_o=
bject *obj,
 		}
 	}
 	if (need_config && extra_kconfig) {
-		err =3D bpf_object__read_kconfig_mem(obj, extra_kconfig, kcfg_data);
+		err =3D bpf_object_read_kconfig_mem(obj, extra_kconfig, kcfg_data);
 		if (err)
 			return -EINVAL;
 		need_config =3D false;
@@ -7989,17 +7963,17 @@ static int bpf_object__resolve_externs(struct bpf=
_object *obj,
 		}
 	}
 	if (need_config) {
-		err =3D bpf_object__read_kconfig_file(obj, kcfg_data);
+		err =3D bpf_object_read_kconfig_file(obj, kcfg_data);
 		if (err)
 			return -EINVAL;
 	}
 	if (need_kallsyms) {
-		err =3D bpf_object__read_kallsyms_file(obj);
+		err =3D bpf_object_read_kallsyms_file(obj);
 		if (err)
 			return -EINVAL;
 	}
 	if (need_vmlinux_btf) {
-		err =3D bpf_object__resolve_ksyms_btf_id(obj);
+		err =3D bpf_object_resolve_ksyms_btf_id(obj);
 		if (err)
 			return -EINVAL;
 	}
@@ -8043,7 +8017,7 @@ static int bpf_object_prepare_struct_ops(struct bpf=
_object *obj)
 	int i;
=20
 	for (i =3D 0; i < obj->nr_maps; i++)
-		if (bpf_map__is_struct_ops(&obj->maps[i]))
+		if (bpf_map_is_struct_ops(&obj->maps[i]))
 			bpf_map_prepare_vdata(&obj->maps[i]);
=20
 	return 0;
@@ -8064,15 +8038,15 @@ static int bpf_object_load(struct bpf_object *obj=
, int extra_log_level, const ch
 	if (obj->gen_loader)
 		bpf_gen__init(obj->gen_loader, extra_log_level, obj->nr_programs, obj-=
>nr_maps);
=20
-	err =3D bpf_object__probe_loading(obj);
-	err =3D err ? : bpf_object__load_vmlinux_btf(obj, false);
-	err =3D err ? : bpf_object__resolve_externs(obj, obj->kconfig);
-	err =3D err ? : bpf_object__sanitize_and_load_btf(obj);
-	err =3D err ? : bpf_object__sanitize_maps(obj);
-	err =3D err ? : bpf_object__init_kern_struct_ops_maps(obj);
-	err =3D err ? : bpf_object__create_maps(obj);
-	err =3D err ? : bpf_object__relocate(obj, obj->btf_custom_path ? : targ=
et_btf_path);
-	err =3D err ? : bpf_object__load_progs(obj, extra_log_level);
+	err =3D bpf_object_probe_loading(obj);
+	err =3D err ? : bpf_object_load_vmlinux_btf(obj, false);
+	err =3D err ? : bpf_object_resolve_externs(obj, obj->kconfig);
+	err =3D err ? : bpf_object_sanitize_and_load_btf(obj);
+	err =3D err ? : bpf_object_sanitize_maps(obj);
+	err =3D err ? : bpf_object_init_kern_struct_ops_maps(obj);
+	err =3D err ? : bpf_object_create_maps(obj);
+	err =3D err ? : bpf_object_relocate(obj, obj->btf_custom_path ? : targe=
t_btf_path);
+	err =3D err ? : bpf_object_load_progs(obj, extra_log_level);
 	err =3D err ? : bpf_object_init_prog_arrays(obj);
 	err =3D err ? : bpf_object_prepare_struct_ops(obj);
=20
@@ -8530,10 +8504,10 @@ int bpf_object__unpin(struct bpf_object *obj, con=
st char *path)
 	return 0;
 }
=20
-static void bpf_map__destroy(struct bpf_map *map)
+static void bpf_map_destroy(struct bpf_map *map)
 {
 	if (map->inner_map) {
-		bpf_map__destroy(map->inner_map);
+		bpf_map_destroy(map->inner_map);
 		zfree(&map->inner_map);
 	}
=20
@@ -8574,14 +8548,14 @@ void bpf_object__close(struct bpf_object *obj)
 	obj->usdt_man =3D NULL;
=20
 	bpf_gen__free(obj->gen_loader);
-	bpf_object__elf_finish(obj);
+	bpf_object_elf_finish(obj);
 	bpf_object_unload(obj);
 	btf__free(obj->btf);
 	btf__free(obj->btf_vmlinux);
 	btf_ext__free(obj->btf_ext);
=20
 	for (i =3D 0; i < obj->nr_maps; i++)
-		bpf_map__destroy(&obj->maps[i]);
+		bpf_map_destroy(&obj->maps[i]);
=20
 	zfree(&obj->btf_custom_path);
 	zfree(&obj->kconfig);
@@ -8597,7 +8571,7 @@ void bpf_object__close(struct bpf_object *obj)
=20
 	if (obj->programs && obj->nr_programs) {
 		for (i =3D 0; i < obj->nr_programs; i++)
-			bpf_program__exit(&obj->programs[i]);
+			bpf_program_exit(&obj->programs[i]);
 	}
 	zfree(&obj->programs);
=20
@@ -8651,8 +8625,8 @@ int bpf_object__gen_loader(struct bpf_object *obj, =
struct gen_loader_opts *opts)
 }
=20
 static struct bpf_program *
-__bpf_program__iter(const struct bpf_program *p, const struct bpf_object=
 *obj,
-		    bool forward)
+bpf_object_prog_iter(const struct bpf_program *p, const struct bpf_objec=
t *obj,
+		     bool forward)
 {
 	size_t nr_programs =3D obj->nr_programs;
 	ssize_t idx;
@@ -8682,7 +8656,7 @@ bpf_object__next_program(const struct bpf_object *o=
bj, struct bpf_program *prev)
 	struct bpf_program *prog =3D prev;
=20
 	do {
-		prog =3D __bpf_program__iter(prog, obj, true);
+		prog =3D bpf_object_prog_iter(prog, obj, true);
 	} while (prog && prog_is_subprog(obj, prog));
=20
 	return prog;
@@ -8694,7 +8668,7 @@ bpf_object__prev_program(const struct bpf_object *o=
bj, struct bpf_program *next)
 	struct bpf_program *prog =3D next;
=20
 	do {
-		prog =3D __bpf_program__iter(prog, obj, false);
+		prog =3D bpf_object_prog_iter(prog, obj, false);
 	} while (prog && prog_is_subprog(obj, prog));
=20
 	return prog;
@@ -9250,7 +9224,7 @@ static struct bpf_map *find_struct_ops_map_by_offse=
t(struct bpf_object *obj,
=20
 	for (i =3D 0; i < obj->nr_maps; i++) {
 		map =3D &obj->maps[i];
-		if (!bpf_map__is_struct_ops(map))
+		if (!bpf_map_is_struct_ops(map))
 			continue;
 		if (map->sec_idx =3D=3D sec_idx &&
 		    map->sec_offset <=3D offset &&
@@ -9262,8 +9236,8 @@ static struct bpf_map *find_struct_ops_map_by_offse=
t(struct bpf_object *obj,
 }
=20
 /* Collect the reloc from ELF and populate the st_ops->progs[] */
-static int bpf_object__collect_st_ops_relos(struct bpf_object *obj,
-					    Elf64_Shdr *shdr, Elf_Data *data)
+static int bpf_object_collect_st_ops_relos(struct bpf_object *obj,
+					   Elf64_Shdr *shdr, Elf_Data *data)
 {
 	const struct btf_member *member;
 	struct bpf_struct_ops *st_ops;
@@ -9850,7 +9824,7 @@ int bpf_map__set_ifindex(struct bpf_map *map, __u32=
 ifindex)
=20
 int bpf_map__set_inner_map_fd(struct bpf_map *map, int fd)
 {
-	if (!bpf_map_type__is_map_in_map(map->def.type)) {
+	if (!bpf_map_type_is_map_in_map(map->def.type)) {
 		pr_warn("error: unsupported map type\n");
 		return libbpf_err(-EINVAL);
 	}
@@ -9859,7 +9833,7 @@ int bpf_map__set_inner_map_fd(struct bpf_map *map, =
int fd)
 		return libbpf_err(-EINVAL);
 	}
 	if (map->inner_map) {
-		bpf_map__destroy(map->inner_map);
+		bpf_map_destroy(map->inner_map);
 		zfree(&map->inner_map);
 	}
 	map->inner_map_fd =3D fd;
@@ -9867,7 +9841,7 @@ int bpf_map__set_inner_map_fd(struct bpf_map *map, =
int fd)
 }
=20
 static struct bpf_map *
-__bpf_map__iter(const struct bpf_map *m, const struct bpf_object *obj, i=
nt i)
+bpf_object_iter_map(const struct bpf_map *m, const struct bpf_object *ob=
j, int i)
 {
 	ssize_t idx;
 	struct bpf_map *s, *e;
@@ -9896,7 +9870,7 @@ bpf_object__next_map(const struct bpf_object *obj, =
const struct bpf_map *prev)
 	if (prev =3D=3D NULL)
 		return obj->maps;
=20
-	return __bpf_map__iter(prev, obj, 1);
+	return bpf_object_iter_map(prev, obj, 1);
 }
=20
 struct bpf_map *
@@ -9908,7 +9882,7 @@ bpf_object__prev_map(const struct bpf_object *obj, =
const struct bpf_map *next)
 		return obj->maps + obj->nr_maps - 1;
 	}
=20
-	return __bpf_map__iter(next, obj, -1);
+	return bpf_object_iter_map(next, obj, -1);
 }
=20
 struct bpf_map *
@@ -10117,7 +10091,7 @@ const char *bpf_link__pin_path(const struct bpf_l=
ink *link)
 	return link->pin_path;
 }
=20
-static int bpf_link__detach_fd(struct bpf_link *link)
+static int bpf_link_detach_fd(struct bpf_link *link)
 {
 	return libbpf_err_errno(close(link->fd));
 }
@@ -10139,7 +10113,7 @@ struct bpf_link *bpf_link__open(const char *path)
 		close(fd);
 		return libbpf_err_ptr(-ENOMEM);
 	}
-	link->detach =3D &bpf_link__detach_fd;
+	link->detach =3D &bpf_link_detach_fd;
 	link->fd =3D fd;
=20
 	link->pin_path =3D strdup(path);
@@ -11025,7 +10999,7 @@ bpf_program__attach_kprobe_multi_opts(const struc=
t bpf_program *prog,
 		err =3D -ENOMEM;
 		goto error;
 	}
-	link->detach =3D &bpf_link__detach_fd;
+	link->detach =3D &bpf_link_detach_fd;
=20
 	prog_fd =3D bpf_program__fd(prog);
 	link_fd =3D bpf_link_create(prog_fd, 0, BPF_TRACE_KPROBE_MULTI, &lopts)=
;
@@ -11483,7 +11457,7 @@ bpf_program__attach_uprobe_multi(const struct bpf=
_program *prog,
 		err =3D -ENOMEM;
 		goto error;
 	}
-	link->detach =3D &bpf_link__detach_fd;
+	link->detach =3D &bpf_link_detach_fd;
=20
 	prog_fd =3D bpf_program__fd(prog);
 	link_fd =3D bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &lopts)=
;
@@ -11936,7 +11910,7 @@ struct bpf_link *bpf_program__attach_raw_tracepoi=
nt(const struct bpf_program *pr
 	link =3D calloc(1, sizeof(*link));
 	if (!link)
 		return libbpf_err_ptr(-ENOMEM);
-	link->detach =3D &bpf_link__detach_fd;
+	link->detach =3D &bpf_link_detach_fd;
=20
 	pfd =3D bpf_raw_tracepoint_open(tp_name, prog_fd);
 	if (pfd < 0) {
@@ -11992,8 +11966,8 @@ static int attach_raw_tp(const struct bpf_program=
 *prog, long cookie, struct bpf
 }
=20
 /* Common logic for all BPF program types that attach to a btf_id */
-static struct bpf_link *bpf_program__attach_btf_id(const struct bpf_prog=
ram *prog,
-						   const struct bpf_trace_opts *opts)
+static struct bpf_link *bpf_program_attach_btf_id(const struct bpf_progr=
am *prog,
+						  const struct bpf_trace_opts *opts)
 {
 	LIBBPF_OPTS(bpf_link_create_opts, link_opts);
 	char errmsg[STRERR_BUFSIZE];
@@ -12012,7 +11986,7 @@ static struct bpf_link *bpf_program__attach_btf_i=
d(const struct bpf_program *pro
 	link =3D calloc(1, sizeof(*link));
 	if (!link)
 		return libbpf_err_ptr(-ENOMEM);
-	link->detach =3D &bpf_link__detach_fd;
+	link->detach =3D &bpf_link_detach_fd;
=20
 	/* libbpf is smart enough to redirect to BPF_RAW_TRACEPOINT_OPEN on old=
 kernels */
 	link_opts.tracing.cookie =3D OPTS_GET(opts, cookie, 0);
@@ -12030,18 +12004,18 @@ static struct bpf_link *bpf_program__attach_btf=
_id(const struct bpf_program *pro
=20
 struct bpf_link *bpf_program__attach_trace(const struct bpf_program *pro=
g)
 {
-	return bpf_program__attach_btf_id(prog, NULL);
+	return bpf_program_attach_btf_id(prog, NULL);
 }
=20
 struct bpf_link *bpf_program__attach_trace_opts(const struct bpf_program=
 *prog,
 						const struct bpf_trace_opts *opts)
 {
-	return bpf_program__attach_btf_id(prog, opts);
+	return bpf_program_attach_btf_id(prog, opts);
 }
=20
 struct bpf_link *bpf_program__attach_lsm(const struct bpf_program *prog)
 {
-	return bpf_program__attach_btf_id(prog, NULL);
+	return bpf_program_attach_btf_id(prog, NULL);
 }
=20
 static int attach_trace(const struct bpf_program *prog, long cookie, str=
uct bpf_link **link)
@@ -12075,7 +12049,7 @@ bpf_program_attach_fd(const struct bpf_program *p=
rog,
 	link =3D calloc(1, sizeof(*link));
 	if (!link)
 		return libbpf_err_ptr(-ENOMEM);
-	link->detach =3D &bpf_link__detach_fd;
+	link->detach =3D &bpf_link_detach_fd;
=20
 	attach_type =3D bpf_program__expected_attach_type(prog);
 	link_fd =3D bpf_link_create(prog_fd, target_fd, attach_type, opts);
@@ -12240,7 +12214,7 @@ bpf_program__attach_iter(const struct bpf_program=
 *prog,
 	link =3D calloc(1, sizeof(*link));
 	if (!link)
 		return libbpf_err_ptr(-ENOMEM);
-	link->detach =3D &bpf_link__detach_fd;
+	link->detach =3D &bpf_link_detach_fd;
=20
 	link_fd =3D bpf_link_create(prog_fd, target_fd, BPF_TRACE_ITER,
 				  &link_create_opts);
@@ -12281,7 +12255,7 @@ struct bpf_link *bpf_program__attach_netfilter(co=
nst struct bpf_program *prog,
 	if (!link)
 		return libbpf_err_ptr(-ENOMEM);
=20
-	link->detach =3D &bpf_link__detach_fd;
+	link->detach =3D &bpf_link_detach_fd;
=20
 	lopts.netfilter.pf =3D OPTS_GET(opts, pf, 0);
 	lopts.netfilter.hooknum =3D OPTS_GET(opts, hooknum, 0);
@@ -12331,7 +12305,7 @@ struct bpf_link_struct_ops {
 	int map_fd;
 };
=20
-static int bpf_link__detach_struct_ops(struct bpf_link *link)
+static int bpf_link_detach_struct_ops(struct bpf_link *link)
 {
 	struct bpf_link_struct_ops *st_link;
 	__u32 zero =3D 0;
@@ -12351,7 +12325,7 @@ struct bpf_link *bpf_map__attach_struct_ops(const=
 struct bpf_map *map)
 	__u32 zero =3D 0;
 	int err, fd;
=20
-	if (!bpf_map__is_struct_ops(map) || map->fd =3D=3D -1)
+	if (!bpf_map_is_struct_ops(map) || map->fd =3D=3D -1)
 		return libbpf_err_ptr(-EINVAL);
=20
 	link =3D calloc(1, sizeof(*link));
@@ -12370,7 +12344,7 @@ struct bpf_link *bpf_map__attach_struct_ops(const=
 struct bpf_map *map)
 		return libbpf_err_ptr(err);
 	}
=20
-	link->link.detach =3D bpf_link__detach_struct_ops;
+	link->link.detach =3D bpf_link_detach_struct_ops;
=20
 	if (!(map->def.map_flags & BPF_F_LINK)) {
 		/* w/o a real link */
@@ -12400,7 +12374,7 @@ int bpf_link__update_map(struct bpf_link *link, c=
onst struct bpf_map *map)
 	__u32 zero =3D 0;
 	int err;
=20
-	if (!bpf_map__is_struct_ops(map) || map->fd < 0)
+	if (!bpf_map_is_struct_ops(map) || map->fd < 0)
 		return -EINVAL;
=20
 	st_ops_link =3D container_of(link, struct bpf_link_struct_ops, link);
@@ -12517,8 +12491,7 @@ struct perf_buffer {
 	int map_fd; /* BPF_MAP_TYPE_PERF_EVENT_ARRAY BPF map FD */
 };
=20
-static void perf_buffer__free_cpu_buf(struct perf_buffer *pb,
-				      struct perf_cpu_buf *cpu_buf)
+static void perf_buffer_free_cpu_buf(struct perf_buffer *pb, struct perf=
_cpu_buf *cpu_buf)
 {
 	if (!cpu_buf)
 		return;
@@ -12547,7 +12520,7 @@ void perf_buffer__free(struct perf_buffer *pb)
 				continue;
=20
 			bpf_map_delete_elem(pb->map_fd, &cpu_buf->map_key);
-			perf_buffer__free_cpu_buf(pb, cpu_buf);
+			perf_buffer_free_cpu_buf(pb, cpu_buf);
 		}
 		free(pb->cpu_bufs);
 	}
@@ -12558,8 +12531,8 @@ void perf_buffer__free(struct perf_buffer *pb)
 }
=20
 static struct perf_cpu_buf *
-perf_buffer__open_cpu_buf(struct perf_buffer *pb, struct perf_event_attr=
 *attr,
-			  int cpu, int map_key)
+perf_buffer_open_cpu_buf(struct perf_buffer *pb, struct perf_event_attr =
*attr,
+			 int cpu, int map_key)
 {
 	struct perf_cpu_buf *cpu_buf;
 	char msg[STRERR_BUFSIZE];
@@ -12603,12 +12576,12 @@ perf_buffer__open_cpu_buf(struct perf_buffer *p=
b, struct perf_event_attr *attr,
 	return cpu_buf;
=20
 error:
-	perf_buffer__free_cpu_buf(pb, cpu_buf);
+	perf_buffer_free_cpu_buf(pb, cpu_buf);
 	return (struct perf_cpu_buf *)ERR_PTR(err);
 }
=20
-static struct perf_buffer *__perf_buffer__new(int map_fd, size_t page_cn=
t,
-					      struct perf_buffer_params *p);
+static struct perf_buffer *perf_buffer_new(int map_fd, size_t page_cnt,
+					   struct perf_buffer_params *p);
=20
 struct perf_buffer *perf_buffer__new(int map_fd, size_t page_cnt,
 				     perf_buffer_sample_fn sample_cb,
@@ -12641,7 +12614,7 @@ struct perf_buffer *perf_buffer__new(int map_fd, =
size_t page_cnt,
 	p.lost_cb =3D lost_cb;
 	p.ctx =3D ctx;
=20
-	return libbpf_ptr(__perf_buffer__new(map_fd, page_cnt, &p));
+	return libbpf_ptr(perf_buffer_new(map_fd, page_cnt, &p));
 }
=20
 struct perf_buffer *perf_buffer__new_raw(int map_fd, size_t page_cnt,
@@ -12664,11 +12637,11 @@ struct perf_buffer *perf_buffer__new_raw(int ma=
p_fd, size_t page_cnt,
 	p.cpus =3D OPTS_GET(opts, cpus, NULL);
 	p.map_keys =3D OPTS_GET(opts, map_keys, NULL);
=20
-	return libbpf_ptr(__perf_buffer__new(map_fd, page_cnt, &p));
+	return libbpf_ptr(perf_buffer_new(map_fd, page_cnt, &p));
 }
=20
-static struct perf_buffer *__perf_buffer__new(int map_fd, size_t page_cn=
t,
-					      struct perf_buffer_params *p)
+static struct perf_buffer *perf_buffer_new(int map_fd, size_t page_cnt,
+					   struct perf_buffer_params *p)
 {
 	const char *online_cpus_file =3D "/sys/devices/system/cpu/online";
 	struct bpf_map_info map;
@@ -12773,7 +12746,7 @@ static struct perf_buffer *__perf_buffer__new(int=
 map_fd, size_t page_cnt,
 		if (p->cpu_cnt <=3D 0 && (cpu >=3D n || !online[cpu]))
 			continue;
=20
-		cpu_buf =3D perf_buffer__open_cpu_buf(pb, p->attr, cpu, map_key);
+		cpu_buf =3D perf_buffer_open_cpu_buf(pb, p->attr, cpu, map_key);
 		if (IS_ERR(cpu_buf)) {
 			err =3D PTR_ERR(cpu_buf);
 			goto error;
@@ -12828,8 +12801,7 @@ struct perf_sample_lost {
 	uint64_t sample_id;
 };
=20
-static enum bpf_perf_event_ret
-perf_buffer__process_record(struct perf_event_header *e, void *ctx)
+static enum bpf_perf_event_ret perf_buffer_process_record(struct perf_ev=
ent_header *e, void *ctx)
 {
 	struct perf_cpu_buf *cpu_buf =3D ctx;
 	struct perf_buffer *pb =3D cpu_buf->pb;
@@ -12861,15 +12833,15 @@ perf_buffer__process_record(struct perf_event_h=
eader *e, void *ctx)
 	return LIBBPF_PERF_EVENT_CONT;
 }
=20
-static int perf_buffer__process_records(struct perf_buffer *pb,
-					struct perf_cpu_buf *cpu_buf)
+static int perf_buffer_process_records(struct perf_buffer *pb,
+				       struct perf_cpu_buf *cpu_buf)
 {
 	enum bpf_perf_event_ret ret;
=20
 	ret =3D perf_event_read_simple(cpu_buf->base, pb->mmap_size,
 				     pb->page_size, &cpu_buf->buf,
 				     &cpu_buf->buf_size,
-				     perf_buffer__process_record, cpu_buf);
+				     perf_buffer_process_record, cpu_buf);
 	if (ret !=3D LIBBPF_PERF_EVENT_CONT)
 		return ret;
 	return 0;
@@ -12891,7 +12863,7 @@ int perf_buffer__poll(struct perf_buffer *pb, int=
 timeout_ms)
 	for (i =3D 0; i < cnt; i++) {
 		struct perf_cpu_buf *cpu_buf =3D pb->events[i].data.ptr;
=20
-		err =3D perf_buffer__process_records(pb, cpu_buf);
+		err =3D perf_buffer_process_records(pb, cpu_buf);
 		if (err) {
 			pr_warn("error while processing records: %d\n", err);
 			return libbpf_err(err);
@@ -12962,7 +12934,7 @@ int perf_buffer__consume_buffer(struct perf_buffe=
r *pb, size_t buf_idx)
 	if (!cpu_buf)
 		return libbpf_err(-ENOENT);
=20
-	return perf_buffer__process_records(pb, cpu_buf);
+	return perf_buffer_process_records(pb, cpu_buf);
 }
=20
 int perf_buffer__consume(struct perf_buffer *pb)
@@ -12975,7 +12947,7 @@ int perf_buffer__consume(struct perf_buffer *pb)
 		if (!cpu_buf)
 			continue;
=20
-		err =3D perf_buffer__process_records(pb, cpu_buf);
+		err =3D perf_buffer_process_records(pb, cpu_buf);
 		if (err) {
 			pr_warn("perf_buffer: failed to process records in buffer #%d: %d\n",=
 i, err);
 			return libbpf_err(err);
@@ -12997,7 +12969,7 @@ int bpf_program__set_attach_target(struct bpf_pro=
gram *prog,
 		return libbpf_err(-EINVAL);
=20
 	if (attach_prog_fd && !attach_func_name) {
-		/* remember attach_prog_fd and let bpf_program__load() find
+		/* remember attach_prog_fd and let bpf_object_load_prog() find
 		 * BTF ID during the program load
 		 */
 		prog->attach_prog_fd =3D attach_prog_fd;
@@ -13014,7 +12986,7 @@ int bpf_program__set_attach_target(struct bpf_pro=
gram *prog,
 			return libbpf_err(-EINVAL);
=20
 		/* load btf_vmlinux, if not yet */
-		err =3D bpf_object__load_vmlinux_btf(prog->obj, true);
+		err =3D bpf_object_load_vmlinux_btf(prog->obj, true);
 		if (err)
 			return libbpf_err(err);
 		err =3D find_kernel_btf_id(prog->obj, attach_func_name,
--=20
2.34.1



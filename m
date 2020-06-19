Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA219201E88
	for <lists+bpf@lfdr.de>; Sat, 20 Jun 2020 01:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730374AbgFSXT3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Jun 2020 19:19:29 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:26308 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730253AbgFSXT2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Jun 2020 19:19:28 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05JNFSfm021253
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2020 16:19:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=8gxTbSuIeQ2cJG6hg196UjGkHI4b9vG8AbeK5P4TfyI=;
 b=hPJrSmiu/+8j+iIexYuwiCb7Ac6tww+s13PjS7uoZAo79MyUfLt9xnscW7xe6NDSKnDy
 Lrl49yi4azgRAX9zVqCJvwDv9GLpv0RIx0LDsi2k+GRU3Gfypbd+qvU5nzfPn4IL9Ywx
 MvzkofVH5N8DzbjpoPrsl+SWJI//vlkDj3Q= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31r092n726-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2020 16:19:26 -0700
Received: from intmgw002.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 19 Jun 2020 16:19:25 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 1D8C42EC3744; Fri, 19 Jun 2020 16:17:09 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Quentin Monnet <quentin@isovalent.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v3 bpf-next 1/9] libbpf: generalize libbpf externs support
Date:   Fri, 19 Jun 2020 16:16:55 -0700
Message-ID: <20200619231703.738941-2-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200619231703.738941-1-andriin@fb.com>
References: <20200619231703.738941-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-19_22:2020-06-19,2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 mlxlogscore=999
 spamscore=0 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 mlxscore=0 suspectscore=9 cotscore=-2147483648 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190163
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Switch existing Kconfig externs to be just one of few possible kinds of m=
ore
generic externs. This refactoring is in preparation for ksymbol extern
support, added in the follow up patch. There are no functional changes
intended.

Reviewed-by: Hao Luo <haoluo@google.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/libbpf.c | 346 ++++++++++++++++++++++++-----------------
 1 file changed, 206 insertions(+), 140 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 477c679ed945..4b021cb94e48 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -329,24 +329,35 @@ struct bpf_map {
=20
 enum extern_type {
 	EXT_UNKNOWN,
-	EXT_CHAR,
-	EXT_BOOL,
-	EXT_INT,
-	EXT_TRISTATE,
-	EXT_CHAR_ARR,
+	EXT_KCFG,
+};
+
+enum kcfg_type {
+	KCFG_UNKNOWN,
+	KCFG_CHAR,
+	KCFG_BOOL,
+	KCFG_INT,
+	KCFG_TRISTATE,
+	KCFG_CHAR_ARR,
 };
=20
 struct extern_desc {
-	const char *name;
+	enum extern_type type;
 	int sym_idx;
 	int btf_id;
-	enum extern_type type;
-	int sz;
-	int align;
-	int data_off;
-	bool is_signed;
-	bool is_weak;
+	int sec_btf_id;
+	const char *name;
 	bool is_set;
+	bool is_weak;
+	union {
+		struct {
+			enum kcfg_type type;
+			int sz;
+			int align;
+			int data_off;
+			bool is_signed;
+		} kcfg;
+	};
 };
=20
 static LIST_HEAD(bpf_objects_list);
@@ -1423,19 +1434,19 @@ static struct extern_desc *find_extern_by_name(co=
nst struct bpf_object *obj,
 	return NULL;
 }
=20
-static int set_ext_value_tri(struct extern_desc *ext, void *ext_val,
-			     char value)
+static int set_kcfg_value_tri(struct extern_desc *ext, void *ext_val,
+			      char value)
 {
-	switch (ext->type) {
-	case EXT_BOOL:
+	switch (ext->kcfg.type) {
+	case KCFG_BOOL:
 		if (value =3D=3D 'm') {
-			pr_warn("extern %s=3D%c should be tristate or char\n",
+			pr_warn("extern (kcfg) %s=3D%c should be tristate or char\n",
 				ext->name, value);
 			return -EINVAL;
 		}
 		*(bool *)ext_val =3D value =3D=3D 'y' ? true : false;
 		break;
-	case EXT_TRISTATE:
+	case KCFG_TRISTATE:
 		if (value =3D=3D 'y')
 			*(enum libbpf_tristate *)ext_val =3D TRI_YES;
 		else if (value =3D=3D 'm')
@@ -1443,14 +1454,14 @@ static int set_ext_value_tri(struct extern_desc *=
ext, void *ext_val,
 		else /* value =3D=3D 'n' */
 			*(enum libbpf_tristate *)ext_val =3D TRI_NO;
 		break;
-	case EXT_CHAR:
+	case KCFG_CHAR:
 		*(char *)ext_val =3D value;
 		break;
-	case EXT_UNKNOWN:
-	case EXT_INT:
-	case EXT_CHAR_ARR:
+	case KCFG_UNKNOWN:
+	case KCFG_INT:
+	case KCFG_CHAR_ARR:
 	default:
-		pr_warn("extern %s=3D%c should be bool, tristate, or char\n",
+		pr_warn("extern (kcfg) %s=3D%c should be bool, tristate, or char\n",
 			ext->name, value);
 		return -EINVAL;
 	}
@@ -1458,29 +1469,29 @@ static int set_ext_value_tri(struct extern_desc *=
ext, void *ext_val,
 	return 0;
 }
=20
-static int set_ext_value_str(struct extern_desc *ext, char *ext_val,
-			     const char *value)
+static int set_kcfg_value_str(struct extern_desc *ext, char *ext_val,
+			      const char *value)
 {
 	size_t len;
=20
-	if (ext->type !=3D EXT_CHAR_ARR) {
-		pr_warn("extern %s=3D%s should char array\n", ext->name, value);
+	if (ext->kcfg.type !=3D KCFG_CHAR_ARR) {
+		pr_warn("extern (kcfg) %s=3D%s should be char array\n", ext->name, val=
ue);
 		return -EINVAL;
 	}
=20
 	len =3D strlen(value);
 	if (value[len - 1] !=3D '"') {
-		pr_warn("extern '%s': invalid string config '%s'\n",
+		pr_warn("extern (kcfg) '%s': invalid string config '%s'\n",
 			ext->name, value);
 		return -EINVAL;
 	}
=20
 	/* strip quotes */
 	len -=3D 2;
-	if (len >=3D ext->sz) {
-		pr_warn("extern '%s': long string config %s of (%zu bytes) truncated t=
o %d bytes\n",
-			ext->name, value, len, ext->sz - 1);
-		len =3D ext->sz - 1;
+	if (len >=3D ext->kcfg.sz) {
+		pr_warn("extern (kcfg) '%s': long string config %s of (%zu bytes) trun=
cated to %d bytes\n",
+			ext->name, value, len, ext->kcfg.sz - 1);
+		len =3D ext->kcfg.sz - 1;
 	}
 	memcpy(ext_val, value + 1, len);
 	ext_val[len] =3D '\0';
@@ -1507,11 +1518,11 @@ static int parse_u64(const char *value, __u64 *re=
s)
 	return 0;
 }
=20
-static bool is_ext_value_in_range(const struct extern_desc *ext, __u64 v=
)
+static bool is_kcfg_value_in_range(const struct extern_desc *ext, __u64 =
v)
 {
-	int bit_sz =3D ext->sz * 8;
+	int bit_sz =3D ext->kcfg.sz * 8;
=20
-	if (ext->sz =3D=3D 8)
+	if (ext->kcfg.sz =3D=3D 8)
 		return true;
=20
 	/* Validate that value stored in u64 fits in integer of `ext->sz`
@@ -1526,26 +1537,26 @@ static bool is_ext_value_in_range(const struct ex=
tern_desc *ext, __u64 v)
 	 *  For unsigned target integer, check that all the (64 - Y) bits are
 	 *  zero.
 	 */
-	if (ext->is_signed)
+	if (ext->kcfg.is_signed)
 		return v + (1ULL << (bit_sz - 1)) < (1ULL << bit_sz);
 	else
 		return (v >> bit_sz) =3D=3D 0;
 }
=20
-static int set_ext_value_num(struct extern_desc *ext, void *ext_val,
-			     __u64 value)
+static int set_kcfg_value_num(struct extern_desc *ext, void *ext_val,
+			      __u64 value)
 {
-	if (ext->type !=3D EXT_INT && ext->type !=3D EXT_CHAR) {
-		pr_warn("extern %s=3D%llu should be integer\n",
+	if (ext->kcfg.type !=3D KCFG_INT && ext->kcfg.type !=3D KCFG_CHAR) {
+		pr_warn("extern (kcfg) %s=3D%llu should be integer\n",
 			ext->name, (unsigned long long)value);
 		return -EINVAL;
 	}
-	if (!is_ext_value_in_range(ext, value)) {
-		pr_warn("extern %s=3D%llu value doesn't fit in %d bytes\n",
-			ext->name, (unsigned long long)value, ext->sz);
+	if (!is_kcfg_value_in_range(ext, value)) {
+		pr_warn("extern (kcfg) %s=3D%llu value doesn't fit in %d bytes\n",
+			ext->name, (unsigned long long)value, ext->kcfg.sz);
 		return -ERANGE;
 	}
-	switch (ext->sz) {
+	switch (ext->kcfg.sz) {
 		case 1: *(__u8 *)ext_val =3D value; break;
 		case 2: *(__u16 *)ext_val =3D value; break;
 		case 4: *(__u32 *)ext_val =3D value; break;
@@ -1591,30 +1602,30 @@ static int bpf_object__process_kconfig_line(struc=
t bpf_object *obj,
 	if (!ext || ext->is_set)
 		return 0;
=20
-	ext_val =3D data + ext->data_off;
+	ext_val =3D data + ext->kcfg.data_off;
 	value =3D sep + 1;
=20
 	switch (*value) {
 	case 'y': case 'n': case 'm':
-		err =3D set_ext_value_tri(ext, ext_val, *value);
+		err =3D set_kcfg_value_tri(ext, ext_val, *value);
 		break;
 	case '"':
-		err =3D set_ext_value_str(ext, ext_val, value);
+		err =3D set_kcfg_value_str(ext, ext_val, value);
 		break;
 	default:
 		/* assume integer */
 		err =3D parse_u64(value, &num);
 		if (err) {
-			pr_warn("extern %s=3D%s should be integer\n",
+			pr_warn("extern (kcfg) %s=3D%s should be integer\n",
 				ext->name, value);
 			return err;
 		}
-		err =3D set_ext_value_num(ext, ext_val, num);
+		err =3D set_kcfg_value_num(ext, ext_val, num);
 		break;
 	}
 	if (err)
 		return err;
-	pr_debug("extern %s=3D%s\n", ext->name, value);
+	pr_debug("extern (kcfg) %s=3D%s\n", ext->name, value);
 	return 0;
 }
=20
@@ -1685,16 +1696,20 @@ static int bpf_object__read_kconfig_mem(struct bp=
f_object *obj,
=20
 static int bpf_object__init_kconfig_map(struct bpf_object *obj)
 {
-	struct extern_desc *last_ext;
+	struct extern_desc *last_ext =3D NULL, *ext;
 	size_t map_sz;
-	int err;
+	int i, err;
=20
-	if (obj->nr_extern =3D=3D 0)
-		return 0;
+	for (i =3D 0; i < obj->nr_extern; i++) {
+		ext =3D &obj->externs[i];
+		if (ext->type =3D=3D EXT_KCFG)
+			last_ext =3D ext;
+	}
=20
-	last_ext =3D &obj->externs[obj->nr_extern - 1];
-	map_sz =3D last_ext->data_off + last_ext->sz;
+	if (!last_ext)
+		return 0;
=20
+	map_sz =3D last_ext->kcfg.data_off + last_ext->kcfg.sz;
 	err =3D bpf_object__init_internal_map(obj, LIBBPF_MAP_KCONFIG,
 					    obj->efile.symbols_shndx,
 					    NULL, map_sz);
@@ -2709,8 +2724,33 @@ static int find_extern_btf_id(const struct btf *bt=
f, const char *ext_name)
 	return -ENOENT;
 }
=20
-static enum extern_type find_extern_type(const struct btf *btf, int id,
-					 bool *is_signed)
+static int find_extern_sec_btf_id(struct btf *btf, int ext_btf_id) {
+	const struct btf_var_secinfo *vs;
+	const struct btf_type *t;
+	int i, j, n;
+
+	if (!btf)
+		return -ESRCH;
+
+	n =3D btf__get_nr_types(btf);
+	for (i =3D 1; i <=3D n; i++) {
+		t =3D btf__type_by_id(btf, i);
+
+		if (!btf_is_datasec(t))
+			continue;
+
+		vs =3D btf_var_secinfos(t);
+		for (j =3D 0; j < btf_vlen(t); j++, vs++) {
+			if (vs->type =3D=3D ext_btf_id)
+				return i;
+		}
+	}
+
+	return -ENOENT;
+}
+
+static enum kcfg_type find_kcfg_type(const struct btf *btf, int id,
+				     bool *is_signed)
 {
 	const struct btf_type *t;
 	const char *name;
@@ -2725,29 +2765,29 @@ static enum extern_type find_extern_type(const st=
ruct btf *btf, int id,
 		int enc =3D btf_int_encoding(t);
=20
 		if (enc & BTF_INT_BOOL)
-			return t->size =3D=3D 1 ? EXT_BOOL : EXT_UNKNOWN;
+			return t->size =3D=3D 1 ? KCFG_BOOL : KCFG_UNKNOWN;
 		if (is_signed)
 			*is_signed =3D enc & BTF_INT_SIGNED;
 		if (t->size =3D=3D 1)
-			return EXT_CHAR;
+			return KCFG_CHAR;
 		if (t->size < 1 || t->size > 8 || (t->size & (t->size - 1)))
-			return EXT_UNKNOWN;
-		return EXT_INT;
+			return KCFG_UNKNOWN;
+		return KCFG_INT;
 	}
 	case BTF_KIND_ENUM:
 		if (t->size !=3D 4)
-			return EXT_UNKNOWN;
+			return KCFG_UNKNOWN;
 		if (strcmp(name, "libbpf_tristate"))
-			return EXT_UNKNOWN;
-		return EXT_TRISTATE;
+			return KCFG_UNKNOWN;
+		return KCFG_TRISTATE;
 	case BTF_KIND_ARRAY:
 		if (btf_array(t)->nelems =3D=3D 0)
-			return EXT_UNKNOWN;
-		if (find_extern_type(btf, btf_array(t)->type, NULL) !=3D EXT_CHAR)
-			return EXT_UNKNOWN;
-		return EXT_CHAR_ARR;
+			return KCFG_UNKNOWN;
+		if (find_kcfg_type(btf, btf_array(t)->type, NULL) !=3D KCFG_CHAR)
+			return KCFG_UNKNOWN;
+		return KCFG_CHAR_ARR;
 	default:
-		return EXT_UNKNOWN;
+		return KCFG_UNKNOWN;
 	}
 }
=20
@@ -2756,23 +2796,29 @@ static int cmp_externs(const void *_a, const void=
 *_b)
 	const struct extern_desc *a =3D _a;
 	const struct extern_desc *b =3D _b;
=20
-	/* descending order by alignment requirements */
-	if (a->align !=3D b->align)
-		return a->align > b->align ? -1 : 1;
-	/* ascending order by size, within same alignment class */
-	if (a->sz !=3D b->sz)
-		return a->sz < b->sz ? -1 : 1;
+	if (a->type !=3D b->type)
+		return a->type < b->type ? -1 : 1;
+
+	if (a->type =3D=3D EXT_KCFG) {
+		/* descending order by alignment requirements */
+		if (a->kcfg.align !=3D b->kcfg.align)
+			return a->kcfg.align > b->kcfg.align ? -1 : 1;
+		/* ascending order by size, within same alignment class */
+		if (a->kcfg.sz !=3D b->kcfg.sz)
+			return a->kcfg.sz < b->kcfg.sz ? -1 : 1;
+	}
+
 	/* resolve ties by name */
 	return strcmp(a->name, b->name);
 }
=20
 static int bpf_object__collect_externs(struct bpf_object *obj)
 {
+	struct btf_type *sec, *kcfg_sec =3D NULL;
 	const struct btf_type *t;
 	struct extern_desc *ext;
-	int i, n, off, btf_id;
-	struct btf_type *sec;
-	const char *ext_name;
+	int i, n, off;
+	const char *ext_name, *sec_name;
 	Elf_Scn *scn;
 	GElf_Shdr sh;
=20
@@ -2818,22 +2864,39 @@ static int bpf_object__collect_externs(struct bpf=
_object *obj)
 		ext->name =3D btf__name_by_offset(obj->btf, t->name_off);
 		ext->sym_idx =3D i;
 		ext->is_weak =3D GELF_ST_BIND(sym.st_info) =3D=3D STB_WEAK;
-		ext->sz =3D btf__resolve_size(obj->btf, t->type);
-		if (ext->sz <=3D 0) {
-			pr_warn("failed to resolve size of extern '%s': %d\n",
-				ext_name, ext->sz);
-			return ext->sz;
-		}
-		ext->align =3D btf__align_of(obj->btf, t->type);
-		if (ext->align <=3D 0) {
-			pr_warn("failed to determine alignment of extern '%s': %d\n",
-				ext_name, ext->align);
-			return -EINVAL;
-		}
-		ext->type =3D find_extern_type(obj->btf, t->type,
-					     &ext->is_signed);
-		if (ext->type =3D=3D EXT_UNKNOWN) {
-			pr_warn("extern '%s' type is unsupported\n", ext_name);
+
+		ext->sec_btf_id =3D find_extern_sec_btf_id(obj->btf, ext->btf_id);
+		if (ext->sec_btf_id <=3D 0) {
+			pr_warn("failed to find BTF for extern '%s' [%d] section: %d\n",
+				ext_name, ext->btf_id, ext->sec_btf_id);
+			return ext->sec_btf_id;
+		}
+		sec =3D (void *)btf__type_by_id(obj->btf, ext->sec_btf_id);
+		sec_name =3D btf__name_by_offset(obj->btf, sec->name_off);
+
+		if (strcmp(sec_name, KCONFIG_SEC) =3D=3D 0) {
+			kcfg_sec =3D sec;
+			ext->type =3D EXT_KCFG;
+			ext->kcfg.sz =3D btf__resolve_size(obj->btf, t->type);
+			if (ext->kcfg.sz <=3D 0) {
+				pr_warn("failed to resolve size of extern (kcfg) '%s': %d\n",
+					ext_name, ext->kcfg.sz);
+				return ext->kcfg.sz;
+			}
+			ext->kcfg.align =3D btf__align_of(obj->btf, t->type);
+			if (ext->kcfg.align <=3D 0) {
+				pr_warn("failed to determine alignment of extern (kcfg) '%s': %d\n",
+					ext_name, ext->kcfg.align);
+				return -EINVAL;
+			}
+			ext->kcfg.type =3D find_kcfg_type(obj->btf, t->type,
+						        &ext->kcfg.is_signed);
+			if (ext->kcfg.type =3D=3D KCFG_UNKNOWN) {
+				pr_warn("extern (kcfg) '%s' type is unsupported\n", ext_name);
+				return -ENOTSUP;
+			}
+		} else {
+			pr_warn("unrecognized extern section '%s'\n", sec_name);
 			return -ENOTSUP;
 		}
 	}
@@ -2842,42 +2905,40 @@ static int bpf_object__collect_externs(struct bpf=
_object *obj)
 	if (!obj->nr_extern)
 		return 0;
=20
-	/* sort externs by (alignment, size, name) and calculate their offsets
-	 * within a map */
+	/* sort externs by type, for kcfg ones also by (align, size, name) */
 	qsort(obj->externs, obj->nr_extern, sizeof(*ext), cmp_externs);
-	off =3D 0;
-	for (i =3D 0; i < obj->nr_extern; i++) {
-		ext =3D &obj->externs[i];
-		ext->data_off =3D roundup(off, ext->align);
-		off =3D ext->data_off + ext->sz;
-		pr_debug("extern #%d: symbol %d, off %u, name %s\n",
-			 i, ext->sym_idx, ext->data_off, ext->name);
-	}
=20
-	btf_id =3D btf__find_by_name(obj->btf, KCONFIG_SEC);
-	if (btf_id <=3D 0) {
-		pr_warn("no BTF info found for '%s' datasec\n", KCONFIG_SEC);
-		return -ESRCH;
-	}
+	if (kcfg_sec) {
+		sec =3D kcfg_sec;
+		/* for kcfg externs calculate their offsets within a .kconfig map */
+		off =3D 0;
+		for (i =3D 0; i < obj->nr_extern; i++) {
+			ext =3D &obj->externs[i];
+			if (ext->type !=3D EXT_KCFG)
+				continue;
=20
-	sec =3D (struct btf_type *)btf__type_by_id(obj->btf, btf_id);
-	sec->size =3D off;
-	n =3D btf_vlen(sec);
-	for (i =3D 0; i < n; i++) {
-		struct btf_var_secinfo *vs =3D btf_var_secinfos(sec) + i;
-
-		t =3D btf__type_by_id(obj->btf, vs->type);
-		ext_name =3D btf__name_by_offset(obj->btf, t->name_off);
-		ext =3D find_extern_by_name(obj, ext_name);
-		if (!ext) {
-			pr_warn("failed to find extern definition for BTF var '%s'\n",
-				ext_name);
-			return -ESRCH;
+			ext->kcfg.data_off =3D roundup(off, ext->kcfg.align);
+			off =3D ext->kcfg.data_off + ext->kcfg.sz;
+			pr_debug("extern #%d (kcfg): symbol %d, off %u, name %s\n",
+				 i, ext->sym_idx, ext->kcfg.data_off, ext->name);
+		}
+		sec->size =3D off;
+		n =3D btf_vlen(sec);
+		for (i =3D 0; i < n; i++) {
+			struct btf_var_secinfo *vs =3D btf_var_secinfos(sec) + i;
+
+			t =3D btf__type_by_id(obj->btf, vs->type);
+			ext_name =3D btf__name_by_offset(obj->btf, t->name_off);
+			ext =3D find_extern_by_name(obj, ext_name);
+			if (!ext) {
+				pr_warn("failed to find extern definition for BTF var '%s'\n",
+					ext_name);
+				return -ESRCH;
+			}
+			btf_var(t)->linkage =3D BTF_VAR_GLOBAL_ALLOCATED;
+			vs->offset =3D ext->kcfg.data_off;
 		}
-		vs->offset =3D ext->data_off;
-		btf_var(t)->linkage =3D BTF_VAR_GLOBAL_ALLOCATED;
 	}
-
 	return 0;
 }
=20
@@ -3007,11 +3068,11 @@ static int bpf_program__record_reloc(struct bpf_p=
rogram *prog,
 				sym_idx);
 			return -LIBBPF_ERRNO__RELOC;
 		}
-		pr_debug("found extern #%d '%s' (sym %d, off %u) for insn %u\n",
-			 i, ext->name, ext->sym_idx, ext->data_off, insn_idx);
+		pr_debug("found extern #%d '%s' (sym %d) for insn %u\n",
+			 i, ext->name, ext->sym_idx, insn_idx);
 		reloc_desc->type =3D RELO_EXTERN;
 		reloc_desc->insn_idx =3D insn_idx;
-		reloc_desc->sym_off =3D ext->data_off;
+		reloc_desc->sym_off =3D i; /* sym_off stores extern index */
 		return 0;
 	}
=20
@@ -4928,6 +4989,7 @@ bpf_program__relocate(struct bpf_program *prog, str=
uct bpf_object *obj)
 	for (i =3D 0; i < prog->nr_reloc; i++) {
 		struct reloc_desc *relo =3D &prog->reloc_desc[i];
 		struct bpf_insn *insn =3D &prog->insns[relo->insn_idx];
+		struct extern_desc *ext;
=20
 		if (relo->insn_idx + 1 >=3D (int)prog->insns_cnt) {
 			pr_warn("relocation out of range: '%s'\n",
@@ -4946,9 +5008,10 @@ bpf_program__relocate(struct bpf_program *prog, st=
ruct bpf_object *obj)
 			insn[0].imm =3D obj->maps[relo->map_idx].fd;
 			break;
 		case RELO_EXTERN:
+			ext =3D &obj->externs[relo->sym_off];
 			insn[0].src_reg =3D BPF_PSEUDO_MAP_VALUE;
 			insn[0].imm =3D obj->maps[obj->kconfig_map_idx].fd;
-			insn[1].imm =3D relo->sym_off;
+			insn[1].imm =3D ext->kcfg.data_off;
 			break;
 		case RELO_CALL:
 			err =3D bpf_program__reloc_text(prog, obj, relo);
@@ -5572,30 +5635,33 @@ static int bpf_object__resolve_externs(struct bpf=
_object *obj,
 {
 	bool need_config =3D false;
 	struct extern_desc *ext;
+	void *kcfg_data =3D NULL;
 	int err, i;
-	void *data;
=20
 	if (obj->nr_extern =3D=3D 0)
 		return 0;
=20
-	data =3D obj->maps[obj->kconfig_map_idx].mmaped;
+	if (obj->kconfig_map_idx >=3D 0)
+		kcfg_data =3D obj->maps[obj->kconfig_map_idx].mmaped;
=20
 	for (i =3D 0; i < obj->nr_extern; i++) {
 		ext =3D &obj->externs[i];
=20
-		if (strcmp(ext->name, "LINUX_KERNEL_VERSION") =3D=3D 0) {
-			void *ext_val =3D data + ext->data_off;
+		if (ext->type =3D=3D EXT_KCFG &&
+		    strcmp(ext->name, "LINUX_KERNEL_VERSION") =3D=3D 0) {
+			void *ext_val =3D kcfg_data + ext->kcfg.data_off;
 			__u32 kver =3D get_kernel_version();
=20
 			if (!kver) {
 				pr_warn("failed to get kernel version\n");
 				return -EINVAL;
 			}
-			err =3D set_ext_value_num(ext, ext_val, kver);
+			err =3D set_kcfg_value_num(ext, ext_val, kver);
 			if (err)
 				return err;
-			pr_debug("extern %s=3D0x%x\n", ext->name, kver);
-		} else if (strncmp(ext->name, "CONFIG_", 7) =3D=3D 0) {
+			pr_debug("extern (kcfg) %s=3D0x%x\n", ext->name, kver);
+		} else if (ext->type =3D=3D EXT_KCFG &&
+			   strncmp(ext->name, "CONFIG_", 7) =3D=3D 0) {
 			need_config =3D true;
 		} else {
 			pr_warn("unrecognized extern '%s'\n", ext->name);
@@ -5603,20 +5669,20 @@ static int bpf_object__resolve_externs(struct bpf=
_object *obj,
 		}
 	}
 	if (need_config && extra_kconfig) {
-		err =3D bpf_object__read_kconfig_mem(obj, extra_kconfig, data);
+		err =3D bpf_object__read_kconfig_mem(obj, extra_kconfig, kcfg_data);
 		if (err)
 			return -EINVAL;
 		need_config =3D false;
 		for (i =3D 0; i < obj->nr_extern; i++) {
 			ext =3D &obj->externs[i];
-			if (!ext->is_set) {
+			if (ext->type =3D=3D EXT_KCFG && !ext->is_set) {
 				need_config =3D true;
 				break;
 			}
 		}
 	}
 	if (need_config) {
-		err =3D bpf_object__read_kconfig_file(obj, data);
+		err =3D bpf_object__read_kconfig_file(obj, kcfg_data);
 		if (err)
 			return -EINVAL;
 	}
--=20
2.24.1


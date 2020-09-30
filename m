Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF8F27DF7B
	for <lists+bpf@lfdr.de>; Wed, 30 Sep 2020 06:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbgI3E2Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Sep 2020 00:28:16 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43704 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725372AbgI3E2P (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 30 Sep 2020 00:28:15 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08U4Prqu026094
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 21:28:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=kzAslwn3dQjTwUeYAuDHn3tR812u16ofdy/dzelP7oY=;
 b=D0+nIhfrwQzwdLKMjwmjtL29TXz9Ck5vOMNnAt6QIcQBgdQtWD4W0KiyJKff7sa9d0PL
 txYipcpQf62DGV6FGMITawy8RTN2Q9arXmX+GSM8/0xePA3FmKFV/0ZZ/LVC0JztQTKF
 6qPhpQDrMYfVlAQXxR9egoyPjtFWsoxzkOw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33t35n91ww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 21:28:08 -0700
Received: from intmgw003.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Sep 2020 21:28:07 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id C584E2EC77F1; Tue, 29 Sep 2020 21:28:02 -0700 (PDT)
From:   Andrii Nakryiko <andriin@fb.com>
To:     <dwarves@vger.kernel.org>
CC:     <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH dwarves 05/11] btf_encoder: use libbpf APIs to encode BTF type info
Date:   Tue, 29 Sep 2020 21:27:36 -0700
Message-ID: <20200930042742.2525310-6-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200930042742.2525310-1-andriin@fb.com>
References: <20200930042742.2525310-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_01:2020-09-29,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 mlxscore=0 lowpriorityscore=0 suspectscore=85 impostorscore=0
 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300032
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Switch to use libbpf's BTF writing APIs to encode BTF. This reconciles
btf_elf's use of internal struct btf from libbpf for both loading and enc=
oding
BTF type info. This change also saves a considerable amount of memory use=
d for
DWARF to BTF conversion due to avoiding extra memory copy between gobuffe=
rs
and libbpf's struct btf. Now that pahole uses libbpf's struct btf, it's
possible to further utilize libbpf's features and APIs, e.g., for handlin=
g
endianness conversion, for dumping raw BTF type info during encoding. The=
se
features might be implemented in the follow up patches.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 btf_encoder.c |  96 +++++-----
 libbtf.c      | 521 +++++++++++++++++++++++---------------------------
 libbtf.h      |  29 +--
 3 files changed, 295 insertions(+), 351 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index d26c0b65f5c3..0a9db2938422 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -67,6 +67,8 @@ static void dump_invalid_symbol(const char *msg, const =
char *sym, const char *cu
 	fprintf(stderr, "PAHOLE: Error: Use '-j' or '--force' to ignore such sy=
mbols and force emit the btf.\n");
 }
=20
+extern struct debug_fmt_ops *active_loader;
+
 static int tag__check_id_drift(const struct tag *tag,
 			       uint32_t core_id, uint32_t btf_type_id,
 			       uint32_t type_id_off)
@@ -82,36 +84,19 @@ static int tag__check_id_drift(const struct tag *tag,
 	return 0;
 }
=20
-static int32_t structure_type__encode(struct btf_elf *btfe, struct tag *=
tag, uint32_t type_id_off)
+static int32_t structure_type__encode(struct btf_elf *btfe, struct cu *c=
u, struct tag *tag, uint32_t type_id_off)
 {
 	struct type *type =3D tag__type(tag);
 	struct class_member *pos;
-	bool kind_flag =3D false;
+	const char *name;
 	int32_t type_id;
 	uint8_t kind;
=20
 	kind =3D (tag->tag =3D=3D DW_TAG_union_type) ?
 		BTF_KIND_UNION : BTF_KIND_STRUCT;
=20
-	/* Although no_bitfield_type_recode has been set true
-	 * in pahole.c if BTF encoding is requested, we still check
-	 * the value here. So if no_bitfield_type_recode is set
-	 * to false for whatever reason, we do not accidentally
-	 * set kind_flag incorrectly.
-	 */
-	if (no_bitfield_type_recode) {
-		/* kind_flag only set where there is a bitfield
-		 * in the struct.
-		 */
-		type__for_each_data_member(type, pos) {
-			if (pos->bitfield_size) {
-				kind_flag =3D true;
-				break;
-			}
-		}
-	}
-
-	type_id =3D btf_elf__add_struct(btfe, kind, type->namespace.name, kind_=
flag, type->size, type->nr_members);
+	name =3D active_loader->strings__ptr(cu, type->namespace.name);
+	type_id =3D btf_elf__add_struct(btfe, kind, name, type->size);
 	if (type_id < 0)
 		return type_id;
=20
@@ -121,7 +106,8 @@ static int32_t structure_type__encode(struct btf_elf =
*btfe, struct tag *tag, uin
 		 * scheme, which conforms to BTF requirement, so no conversion
 		 * is required.
 		 */
-		if (btf_elf__add_member(btfe, pos->name, type_id_off + pos->tag.type, =
kind_flag, pos->bitfield_size, pos->bit_offset))
+		name =3D active_loader->strings__ptr(cu, pos->name);
+		if (btf_elf__add_member(btfe, name, type_id_off + pos->tag.type, pos->=
bitfield_size, pos->bit_offset))
 			return -1;
 	}
=20
@@ -140,56 +126,64 @@ static uint32_t array_type__nelems(struct tag *tag)
 	return nelem;
 }
=20
-static int32_t enumeration_type__encode(struct btf_elf *btfe, struct tag=
 *tag)
+static int32_t enumeration_type__encode(struct btf_elf *btfe, struct cu =
*cu, struct tag *tag)
 {
 	struct type *etype =3D tag__type(tag);
 	struct enumerator *pos;
+	const char *name;
 	int32_t type_id;
=20
-	type_id =3D btf_elf__add_enum(btfe, etype->namespace.name, etype->size,=
 etype->nr_members);
+	name =3D active_loader->strings__ptr(cu, etype->namespace.name);
+	type_id =3D btf_elf__add_enum(btfe, name, etype->size);
 	if (type_id < 0)
 		return type_id;
=20
-	type__for_each_enumerator(etype, pos)
-		if (btf_elf__add_enum_val(btfe, pos->name, pos->value))
+	type__for_each_enumerator(etype, pos) {
+		name =3D active_loader->strings__ptr(cu, pos->name);
+		if (btf_elf__add_enum_val(btfe, name, pos->value))
 			return -1;
+	}
=20
 	return type_id;
 }
=20
-static int tag__encode_btf(struct tag *tag, uint32_t core_id, struct btf=
_elf *btfe,
+static int tag__encode_btf(struct cu *cu, struct tag *tag, uint32_t core=
_id, struct btf_elf *btfe,
 			   uint32_t array_index_id, uint32_t type_id_off)
 {
 	/* single out type 0 as it represents special type "void" */
 	uint32_t ref_type_id =3D tag->type =3D=3D 0 ? 0 : type_id_off + tag->ty=
pe;
+	const char *name;
=20
 	switch (tag->tag) {
 	case DW_TAG_base_type:
-		return btf_elf__add_base_type(btfe, tag__base_type(tag));
+		name =3D active_loader->strings__ptr(cu, tag__base_type(tag)->name);
+		return btf_elf__add_base_type(btfe, tag__base_type(tag), name);
 	case DW_TAG_const_type:
-		return btf_elf__add_ref_type(btfe, BTF_KIND_CONST, ref_type_id, 0, fal=
se);
+		return btf_elf__add_ref_type(btfe, BTF_KIND_CONST, ref_type_id, NULL, =
false);
 	case DW_TAG_pointer_type:
-		return btf_elf__add_ref_type(btfe, BTF_KIND_PTR, ref_type_id, 0, false=
);
+		return btf_elf__add_ref_type(btfe, BTF_KIND_PTR, ref_type_id, NULL, fa=
lse);
 	case DW_TAG_restrict_type:
-		return btf_elf__add_ref_type(btfe, BTF_KIND_RESTRICT, ref_type_id, 0, =
false);
+		return btf_elf__add_ref_type(btfe, BTF_KIND_RESTRICT, ref_type_id, NUL=
L, false);
 	case DW_TAG_volatile_type:
-		return btf_elf__add_ref_type(btfe, BTF_KIND_VOLATILE, ref_type_id, 0, =
false);
+		return btf_elf__add_ref_type(btfe, BTF_KIND_VOLATILE, ref_type_id, NUL=
L, false);
 	case DW_TAG_typedef:
-		return btf_elf__add_ref_type(btfe, BTF_KIND_TYPEDEF, ref_type_id, tag_=
_namespace(tag)->name, false);
+		name =3D active_loader->strings__ptr(cu, tag__namespace(tag)->name);
+		return btf_elf__add_ref_type(btfe, BTF_KIND_TYPEDEF, ref_type_id, name=
, false);
 	case DW_TAG_structure_type:
 	case DW_TAG_union_type:
 	case DW_TAG_class_type:
+		name =3D active_loader->strings__ptr(cu, tag__namespace(tag)->name);
 		if (tag__type(tag)->declaration)
-			return btf_elf__add_ref_type(btfe, BTF_KIND_FWD, 0, tag__namespace(ta=
g)->name, tag->tag =3D=3D DW_TAG_union_type);
+			return btf_elf__add_ref_type(btfe, BTF_KIND_FWD, 0, name, tag->tag =3D=
=3D DW_TAG_union_type);
 		else
-			return structure_type__encode(btfe, tag, type_id_off);
+			return structure_type__encode(btfe, cu, tag, type_id_off);
 	case DW_TAG_array_type:
 		/* TODO: Encode one dimension at a time. */
 		return btf_elf__add_array(btfe, ref_type_id, array_index_id, array_typ=
e__nelems(tag));
 	case DW_TAG_enumeration_type:
-		return enumeration_type__encode(btfe, tag);
+		return enumeration_type__encode(btfe, cu, tag);
 	case DW_TAG_subroutine_type:
-		return btf_elf__add_func_proto(btfe, tag__ftype(tag), type_id_off);
+		return btf_elf__add_func_proto(btfe, cu, tag__ftype(tag), type_id_off)=
;
 	default:
 		fprintf(stderr, "Unsupported DW_TAG_%s(0x%x)\n",
 			dwarf_tag_name(tag->tag), tag->tag);
@@ -197,12 +191,6 @@ static int tag__encode_btf(struct tag *tag, uint32_t=
 core_id, struct btf_elf *bt
 	}
 }
=20
-/*
- * FIXME: Its in the DWARF loader, we have to find a better handoff
- * mechanizm...
- */
-extern struct strings *strings;
-
 static struct btf_elf *btfe;
 static uint32_t array_index_id;
=20
@@ -265,7 +253,6 @@ int cu__encode_btf(struct cu *cu, int verbose, bool f=
orce,
 		btfe =3D btf_elf__new(cu->filename, cu->elf);
 		if (!btfe)
 			return -1;
-		btf_elf__set_strings(btfe, &strings->gb);
=20
 		/* cu__find_base_type_by_name() takes "type_id_t *id" */
 		type_id_t id;
@@ -280,10 +267,10 @@ int cu__encode_btf(struct cu *cu, int verbose, bool=
 force,
 	}
=20
 	btf_elf__verbose =3D verbose;
-	type_id_off =3D btfe->type_index;
+	type_id_off =3D btf__get_nr_types(btfe->btf);
=20
 	cu__for_each_type(cu, core_id, pos) {
-		int32_t btf_type_id =3D tag__encode_btf(pos, core_id, btfe, array_inde=
x_id, type_id_off);
+		int32_t btf_type_id =3D tag__encode_btf(cu, pos, core_id, btfe, array_=
index_id, type_id_off);
=20
 		if (btf_type_id < 0 ||
 		    tag__check_id_drift(pos, core_id, btf_type_id, type_id_off)) {
@@ -297,17 +284,19 @@ int cu__encode_btf(struct cu *cu, int verbose, bool=
 force,
=20
 		bt.name =3D 0;
 		bt.bit_size =3D 32;
-		btf_elf__add_base_type(btfe, &bt);
+		btf_elf__add_base_type(btfe, &bt, "__ARRAY_SIZE_TYPE__");
 	}
=20
 	cu__for_each_function(cu, core_id, fn) {
 		int btf_fnproto_id, btf_fn_id;
+		const char *name;
=20
 		if (fn->declaration || !fn->external)
 			continue;
=20
-		btf_fnproto_id =3D btf_elf__add_func_proto(btfe, &fn->proto, type_id_o=
ff);
-		btf_fn_id =3D btf_elf__add_ref_type(btfe, BTF_KIND_FUNC, btf_fnproto_i=
d, fn->name, false);
+		btf_fnproto_id =3D btf_elf__add_func_proto(btfe, cu, &fn->proto, type_=
id_off);
+		name =3D active_loader->strings__ptr(cu, fn->name);
+		btf_fn_id =3D btf_elf__add_ref_type(btfe, BTF_KIND_FUNC, btf_fnproto_i=
d, name, false);
 		if (btf_fnproto_id < 0 || btf_fn_id < 0) {
 			err =3D -1;
 			printf("error: failed to encode function '%s'\n", function__name(fn, =
cu));
@@ -349,7 +338,7 @@ int cu__encode_btf(struct cu *cu, int verbose, bool f=
orce,
=20
 	/* search within symtab for percpu variables */
 	elf_symtab__for_each_symbol(btfe->symtab, core_id, sym) {
-		uint32_t linkage, type, size, offset, name;
+		uint32_t linkage, type, size, offset;
 		int32_t btf_var_id, btf_var_secinfo_id;
 		uint64_t addr;
 		const char *sym_name;
@@ -389,7 +378,6 @@ int cu__encode_btf(struct cu *cu, int verbose, bool f=
orce,
 			err =3D -1;
 			break;
 		}
-		name =3D strings__add(strings, sym_name);
 		type =3D var->ip.tag.type + type_id_off;
 		size =3D elf_sym__size(&sym);
 		if (!size) {
@@ -407,7 +395,7 @@ int cu__encode_btf(struct cu *cu, int verbose, bool f=
orce,
=20
 		/* add a BTF_KIND_VAR in btfe->types */
 		linkage =3D var->external ? BTF_VAR_GLOBAL_ALLOCATED : BTF_VAR_STATIC;
-		btf_var_id =3D btf_elf__add_var_type(btfe, type, name, linkage);
+		btf_var_id =3D btf_elf__add_var_type(btfe, type, sym_name, linkage);
 		if (btf_var_id < 0) {
 			err =3D -1;
 			printf("error: failed to encode variable '%s'\n", sym_name);
@@ -430,7 +418,9 @@ int cu__encode_btf(struct cu *cu, int verbose, bool f=
orce,
 	}
=20
 out:
-	if (err)
+	if (err) {
 		btf_elf__delete(btfe);
+		btfe =3D NULL;
+	}
 	return err;
 }
diff --git a/libbtf.c b/libbtf.c
index 02a55dbd7e13..d74e4eb03393 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -27,31 +27,6 @@
 #include "dwarves.h"
 #include "elf_symtab.h"
=20
-#define BTF_INFO_ENCODE(kind, kind_flag, vlen)				\
-	((!!(kind_flag) << 31) | ((kind) << 24) | ((vlen) & BTF_MAX_VLEN))
-#define BTF_INT_ENCODE(encoding, bits_offset, nr_bits)		\
-	((encoding) << 24 | (bits_offset) << 16 | (nr_bits))
-
-struct btf_int_type {
-	struct btf_type type;
-	uint32_t 	data;
-};
-
-struct btf_enum_type {
-	struct btf_type type;
-	struct btf_enum btf_enum;
-};
-
-struct btf_array_type {
-	struct btf_type type;
-	struct btf_array array;
-};
-
-struct btf_var_type {
-	struct btf_type type;
-	struct btf_var var;
-};
-
 uint8_t btf_elf__verbose;
=20
 static int btf_var_secinfo_cmp(const void *a, const void *b)
@@ -102,6 +77,12 @@ struct btf_elf *btf_elf__new(const char *filename, El=
f *elf)
 	if (btfe->filename =3D=3D NULL)
 		goto errout;
=20
+	btfe->btf =3D btf__new_empty();
+	if (libbpf_get_error(btfe->btf)) {
+		fprintf(stderr, "%s: failed to create empty BTF.\n", __func__);
+		goto errout;
+	}
+
 	if (strcmp(filename, "/sys/kernel/btf/vmlinux") =3D=3D 0) {
 		btfe->raw_btf  =3D true;
 		btfe->wordsize =3D sizeof(long);
@@ -188,12 +169,9 @@ void btf_elf__delete(struct btf_elf *btfe)
 	}
=20
 	elf_symtab__delete(btfe->symtab);
-
-	__gobuffer__delete(&btfe->types);
 	__gobuffer__delete(&btfe->percpu_secinfo);
 	btf__free(btfe->btf);
 	free(btfe->filename);
-	free(btfe->data);
 	free(btfe);
 }
=20
@@ -204,16 +182,6 @@ const char *btf_elf__string(struct btf_elf *btfe, ui=
nt32_t ref)
 	return s && s[0] =3D=3D '\0' ? NULL : s;
 }
=20
-static void *btf_elf__nohdr_data(struct btf_elf *btfe)
-{
-	return btfe->hdr + 1;
-}
-
-void btf_elf__set_strings(struct btf_elf *btfe, struct gobuffer *strings=
)
-{
-	btfe->strings =3D strings;
-}
-
 #define BITS_PER_BYTE 8
 #define BITS_PER_BYTE_MASK (BITS_PER_BYTE - 1)
 #define BITS_PER_BYTE_MASKED(bits) ((bits) & BITS_PER_BYTE_MASK)
@@ -237,12 +205,10 @@ static const char * const btf_kind_str[NR_BTF_KINDS=
] =3D {
 	[BTF_KIND_FUNC_PROTO]	=3D "FUNC_PROTO",
 };
=20
-static const char *btf_elf__name_in_gobuf(const struct btf_elf *btfe, ui=
nt32_t offset)
+static const char *btf_elf__printable_name(const struct btf_elf *btfe, u=
int32_t offset)
 {
 	if (!offset)
 		return "(anon)";
-	else if (btfe->strings)
-		return &btfe->strings->entries[offset];
 	else
 		return btf__str_by_offset(btfe->btf, offset);
 }
@@ -261,6 +227,27 @@ static const char * btf_elf__int_encoding_str(uint8_=
t encoding)
 		return "UNKN";
 }
=20
+
+__attribute ((format (printf, 5, 6)))
+static void btf_elf__log_err(const struct btf_elf *btfe, int kind, const=
 char *name,
+			     bool output_cr, const char *fmt, ...)
+{
+	fprintf(stderr, "[%u] %s %s", btf__get_nr_types(btfe->btf) + 1,
+		btf_kind_str[kind], name ?: "(anon)");
+
+	if (fmt && *fmt) {
+		va_list ap;
+
+		fprintf(stderr, " ");
+		va_start(ap, fmt);
+		vfprintf(stderr, fmt, ap);
+		va_end(ap);
+	}
+
+	if (output_cr)
+		fprintf(stderr, "\n");
+}
+
 __attribute ((format (printf, 5, 6)))
 static void btf_elf__log_type(const struct btf_elf *btfe, const struct b=
tf_type *t,
 			      bool err, bool output_cr, const char *fmt, ...)
@@ -275,8 +262,8 @@ static void btf_elf__log_type(const struct btf_elf *b=
tfe, const struct btf_type
 	out =3D err ? stderr : stdout;
=20
 	fprintf(out, "[%u] %s %s",
-		btfe->type_index, btf_kind_str[kind],
-		btf_elf__name_in_gobuf(btfe, t->name_off));
+		btf__get_nr_types(btfe->btf), btf_kind_str[kind],
+		btf_elf__printable_name(btfe, t->name_off));
=20
 	if (fmt && *fmt) {
 		va_list ap;
@@ -293,8 +280,9 @@ static void btf_elf__log_type(const struct btf_elf *b=
tfe, const struct btf_type
=20
 __attribute ((format (printf, 5, 6)))
 static void btf_log_member(const struct btf_elf *btfe,
+			   const struct btf_type *t,
 			   const struct btf_member *member,
-			   bool kind_flag, bool err, const char *fmt, ...)
+			   bool err, const char *fmt, ...)
 {
 	FILE *out;
=20
@@ -303,15 +291,15 @@ static void btf_log_member(const struct btf_elf *bt=
fe,
=20
 	out =3D err ? stderr : stdout;
=20
-	if (kind_flag)
+	if (btf_kflag(t))
 		fprintf(out, "\t%s type_id=3D%u bitfield_size=3D%u bits_offset=3D%u",
-			btf_elf__name_in_gobuf(btfe, member->name_off),
+			btf_elf__printable_name(btfe, member->name_off),
 			member->type,
 			BTF_MEMBER_BITFIELD_SIZE(member->offset),
 			BTF_MEMBER_BIT_OFFSET(member->offset));
 	else
 		fprintf(out, "\t%s type_id=3D%u bits_offset=3D%u",
-			btf_elf__name_in_gobuf(btfe, member->name_off),
+			btf_elf__printable_name(btfe, member->name_off),
 			member->type,
 			member->offset);
=20
@@ -329,7 +317,7 @@ static void btf_log_member(const struct btf_elf *btfe=
,
=20
 __attribute ((format (printf, 6, 7)))
 static void btf_log_func_param(const struct btf_elf *btfe,
-			       uint32_t name_off, uint32_t type,
+			       const char *name, uint32_t type,
 			       bool err, bool is_last_param,
 			       const char *fmt, ...)
 {
@@ -343,9 +331,7 @@ static void btf_log_func_param(const struct btf_elf *=
btfe,
 	if (is_last_param && !type)
 		fprintf(out, "vararg)\n");
 	else
-		fprintf(out, "%u %s%s", type,
-			btf_elf__name_in_gobuf(btfe, name_off),
-			is_last_param ? ")\n" : ", ");
+		fprintf(out, "%u %s%s", type, name, is_last_param ? ")\n" : ", ");
=20
 	if (fmt && *fmt) {
 		va_list ap;
@@ -357,15 +343,14 @@ static void btf_log_func_param(const struct btf_elf=
 *btfe,
 	}
 }
=20
-int32_t btf_elf__add_base_type(struct btf_elf *btfe, const struct base_t=
ype *bt)
+int32_t btf_elf__add_base_type(struct btf_elf *btfe, const struct base_t=
ype *bt,
+			       const char *name)
 {
-	struct btf_int_type int_type;
-	struct btf_type *t =3D &int_type.type;
+	struct btf *btf =3D btfe->btf;
+	const struct btf_type *t;
 	uint8_t encoding =3D 0;
+	int32_t id;
=20
-	t->name_off =3D bt->name;
-	t->info =3D BTF_INFO_ENCODE(BTF_KIND_INT, 0, 0);
-	t->size =3D BITS_ROUNDUP_BYTES(bt->bit_size);
 	if (bt->is_signed) {
 		encoding =3D BTF_INT_SIGNED;
 	} else if (bt->is_bool) {
@@ -374,240 +359,253 @@ int32_t btf_elf__add_base_type(struct btf_elf *bt=
fe, const struct base_type *bt)
 		fprintf(stderr, "float_type is not supported\n");
 		return -1;
 	}
-	int_type.data =3D BTF_INT_ENCODE(encoding, 0, bt->bit_size);
=20
-	++btfe->type_index;
-	if (gobuffer__add(&btfe->types, &int_type, sizeof(int_type)) >=3D 0) {
-		btf_elf__log_type(btfe, t, false, true,
-			      "size=3D%u bit_offset=3D%u nr_bits=3D%u encoding=3D%s",
-			      t->size, BTF_INT_OFFSET(int_type.data),
-			      BTF_INT_BITS(int_type.data),
-			      btf_elf__int_encoding_str(BTF_INT_ENCODING(int_type.data)));
-		return btfe->type_index;
+	id =3D btf__add_int(btf, name, BITS_ROUNDUP_BYTES(bt->bit_size), encodi=
ng);
+	if (id < 0) {
+		btf_elf__log_err(btfe, BTF_KIND_INT, name, true, "Error emitting BTF t=
ype");
 	} else {
-		btf_elf__log_type(btfe, t, true, true,
-			      "size=3D%u bit_offset=3D%u nr_bits=3D%u encoding=3D%s Error in =
adding gobuffer",
-			      t->size, BTF_INT_OFFSET(int_type.data),
-			      BTF_INT_BITS(int_type.data),
-			      btf_elf__int_encoding_str(BTF_INT_ENCODING(int_type.data)));
-		return -1;
+		t =3D btf__type_by_id(btf, id);
+		btf_elf__log_type(btfe, t, false, true,
+				"size=3D%u nr_bits=3D%u encoding=3D%s%s",
+				t->size, bt->bit_size,
+				btf_elf__int_encoding_str(encoding),
+				id < 0 ? " Error in emitting BTF" : "" );
 	}
+
+	return id;
 }
=20
 int32_t btf_elf__add_ref_type(struct btf_elf *btfe, uint16_t kind, uint3=
2_t type,
-			      uint32_t name, bool kind_flag)
+			      const char *name, bool kind_flag)
 {
-	struct btf_type t;
-
-	t.name_off =3D name;
-	t.info =3D BTF_INFO_ENCODE(kind, kind_flag, 0);
-	t.type =3D type;
+	struct btf *btf =3D btfe->btf;
+	const struct btf_type *t;
+	int32_t id;
+
+	switch (kind) {
+	case BTF_KIND_PTR:
+		id =3D btf__add_ptr(btf, type);
+		break;
+	case BTF_KIND_VOLATILE:
+		id =3D btf__add_volatile(btf, type);
+		break;
+	case BTF_KIND_CONST:
+		id =3D btf__add_const(btf, type);
+		break;
+	case BTF_KIND_RESTRICT:
+		id =3D btf__add_const(btf, type);
+		break;
+	case BTF_KIND_TYPEDEF:
+		id =3D btf__add_typedef(btf, name, type);
+		break;
+	case BTF_KIND_FWD:
+		id =3D btf__add_fwd(btf, name, kind_flag);
+		break;
+	case BTF_KIND_FUNC:
+		id =3D btf__add_func(btf, name, BTF_FUNC_STATIC, type);
+		break;
+	default:
+		btf_elf__log_err(btfe, kind, name, true, "Unexpected kind for referenc=
e");
+		return -1;
+	}
=20
-	++btfe->type_index;
-	if (gobuffer__add(&btfe->types, &t, sizeof(t)) >=3D 0) {
+	if (id > 0) {
+		t =3D btf__type_by_id(btf, id);
 		if (kind =3D=3D BTF_KIND_FWD)
-			btf_elf__log_type(btfe, &t, false, true, "%s", kind_flag ? "union" : =
"struct");
+			btf_elf__log_type(btfe, t, false, true, "%s", kind_flag ? "union" : "=
struct");
 		else
-			btf_elf__log_type(btfe, &t, false, true, "type_id=3D%u", t.type);
-		return btfe->type_index;
+			btf_elf__log_type(btfe, t, false, true, "type_id=3D%u", t->type);
 	} else {
-		btf_elf__log_type(btfe, &t, true, true,
-			      "kind_flag=3D%d type_id=3D%u Error in adding gobuffer",
-			      kind_flag, t.type);
-		return -1;
+		btf_elf__log_err(btfe, kind, name, true, "Error emitting BTF type");
 	}
+	return id;
 }
=20
 int32_t btf_elf__add_array(struct btf_elf *btfe, uint32_t type, uint32_t=
 index_type, uint32_t nelems)
 {
-	struct btf_array_type array_type;
-	struct btf_type *t =3D &array_type.type;
-	struct btf_array *array =3D &array_type.array;
-
-	t->name_off =3D 0;
-	t->info =3D BTF_INFO_ENCODE(BTF_KIND_ARRAY, 0, 0);
-	t->size =3D 0;
-
-	array->type =3D type;
-	array->index_type =3D index_type;
-	array->nelems =3D nelems;
-
-	++btfe->type_index;
-	if (gobuffer__add(&btfe->types, &array_type, sizeof(array_type)) >=3D 0=
) {
+	struct btf *btf =3D btfe->btf;
+	const struct btf_type *t;
+	const struct btf_array *array;
+	int32_t id;
+
+	id =3D btf__add_array(btf, index_type, type, nelems);
+	if (id > 0) {
+		t =3D btf__type_by_id(btf, id);
+		array =3D btf_array(t);
 		btf_elf__log_type(btfe, t, false, true,
 			      "type_id=3D%u index_type_id=3D%u nr_elems=3D%u",
 			      array->type, array->index_type, array->nelems);
-		return btfe->type_index;
 	} else {
-		btf_elf__log_type(btfe, t, true, true,
-			      "type_id=3D%u index_type_id=3D%u nr_elems=3D%u Error in adding =
gobuffer",
-			      array->type, array->index_type, array->nelems);
-		return -1;
+		btf_elf__log_err(btfe, BTF_KIND_ARRAY, NULL, true,
+			      "type_id=3D%u index_type_id=3D%u nr_elems=3D%u Error emitting B=
TF type",
+			      type, index_type, nelems);
 	}
+	return id;
 }
=20
-int btf_elf__add_member(struct btf_elf *btfe, uint32_t name, uint32_t ty=
pe, bool kind_flag,
+int btf_elf__add_member(struct btf_elf *btfe, const char *name, uint32_t=
 type,
 			uint32_t bitfield_size, uint32_t offset)
 {
-	struct btf_member member =3D {
-		.name_off   =3D name,
-		.type   =3D type,
-		.offset =3D kind_flag ? (bitfield_size << 24 | offset) : offset,
-	};
+	struct btf *btf =3D btfe->btf;
+	const struct btf_type *t;
+	const struct btf_member *m;
+	int err;
=20
-	if (gobuffer__add(&btfe->types, &member, sizeof(member)) >=3D 0) {
-		btf_log_member(btfe, &member, kind_flag, false, NULL);
-		return 0;
+	err =3D btf__add_field(btf, name, type, offset, bitfield_size);
+	t =3D btf__type_by_id(btf, btf__get_nr_types(btf));
+	if (err) {
+		fprintf(stderr, "[%u] %s %s's field '%s' offset=3D%u bit_size=3D%u typ=
e=3D%u Error emitting field\n",
+			btf__get_nr_types(btf), btf_kind_str[btf_kind(t)],
+			btf_elf__printable_name(btfe, t->name_off),
+			name, offset, bitfield_size, type);
 	} else {
-		btf_log_member(btfe, &member, kind_flag, true, "Error in adding gobuff=
er");
-		return -1;
+		m =3D &btf_members(t)[btf_vlen(t) - 1];
+		btf_log_member(btfe, t, m, false, NULL);
 	}
+	return err;
 }
=20
-int32_t btf_elf__add_struct(struct btf_elf *btfe, uint8_t kind, uint32_t=
 name,
-			    bool kind_flag, uint32_t size, uint16_t nr_members)
+int32_t btf_elf__add_struct(struct btf_elf *btfe, uint8_t kind, const ch=
ar *name, uint32_t size)
 {
-	struct btf_type t;
-
-	t.name_off =3D name;
-	t.info =3D BTF_INFO_ENCODE(kind, kind_flag, nr_members);
-	t.size =3D size;
+	struct btf *btf =3D btfe->btf;
+	const struct btf_type *t;
+	int32_t id;
+
+	switch (kind) {
+	case BTF_KIND_STRUCT:
+		id =3D btf__add_struct(btf, name, size);
+		break;
+	case BTF_KIND_UNION:
+		id =3D btf__add_union(btf, name, size);
+		break;
+	default:
+		btf_elf__log_err(btfe, kind, name, true, "Unexpected kind of struct");
+		return -1;
+	}
=20
-	++btfe->type_index;
-	if (gobuffer__add(&btfe->types, &t, sizeof(t)) >=3D 0) {
-		btf_elf__log_type(btfe, &t, false, true, "kind_flag=3D%d size=3D%u vle=
n=3D%u",
-			      kind_flag, t.size, BTF_INFO_VLEN(t.info));
-		return btfe->type_index;
+	if (id < 0) {
+		btf_elf__log_err(btfe, kind, name, true, "Error emitting BTF type");
 	} else {
-		btf_elf__log_type(btfe, &t, true, true,
-			      "kind_flag=3D%d size=3D%u vlen=3D%u Error in adding gobuffer",
-			      kind_flag, t.size, BTF_INFO_VLEN(t.info));
-		return -1;
+		t =3D btf__type_by_id(btf, id);
+		btf_elf__log_type(btfe, t, false, true, "size=3D%u", t->size);
 	}
+
+	return id;
 }
=20
-int32_t btf_elf__add_enum(struct btf_elf *btfe, uint32_t name, uint32_t =
bit_size, uint16_t nr_entries)
+int32_t btf_elf__add_enum(struct btf_elf *btfe, const char *name, uint32=
_t bit_size)
 {
-	struct btf_type t;
-
-	t.name_off =3D name;
-	t.info =3D BTF_INFO_ENCODE(BTF_KIND_ENUM, 0, nr_entries);
-	t.size =3D BITS_ROUNDUP_BYTES(bit_size);
-
-	++btfe->type_index;
-	if (gobuffer__add(&btfe->types, &t, sizeof(t)) >=3D 0) {
-		btf_elf__log_type(btfe, &t, false, true, "size=3D%u vlen=3D%u", t.size=
, BTF_INFO_VLEN(t.info));
-		return btfe->type_index;
+	struct btf *btf =3D btfe->btf;
+	const struct btf_type *t;
+	int32_t id, size;
+
+	size =3D BITS_ROUNDUP_BYTES(bit_size);
+	id =3D btf__add_enum(btf, name, size);
+	if (id > 0) {
+		t =3D btf__type_by_id(btf, id);
+		btf_elf__log_type(btfe, t, false, true, "size=3D%u", t->size);
 	} else {
-		btf_elf__log_type(btfe, &t, true, true,
-			      "size=3D%u vlen=3D%u Error in adding gobuffer",
-			      t.size, BTF_INFO_VLEN(t.info));
-		return -1;
+		btf_elf__log_err(btfe, BTF_KIND_ENUM, name, true,
+			      "size=3D%u Error emitting BTF type", size);
 	}
+	return id;
 }
=20
-int btf_elf__add_enum_val(struct btf_elf *btfe, uint32_t name, int32_t v=
alue)
+int btf_elf__add_enum_val(struct btf_elf *btfe, const char *name, int32_=
t value)
 {
-	struct btf_enum e =3D {
-		.name_off =3D name,
-		.val  =3D value,
-	};
-
-	if (gobuffer__add(&btfe->types, &e, sizeof(e)) < 0) {
-		fprintf(stderr, "\t%s val=3D%d Error in adding gobuffer\n",
-			btf_elf__name_in_gobuf(btfe, e.name_off), e.val);
-		return -1;
-	} else if (btf_elf__verbose)
-		printf("\t%s val=3D%d\n", btf_elf__name_in_gobuf(btfe, e.name_off),
-		       e.val);
+	struct btf *btf =3D btfe->btf;
+	int err;
=20
-	return 0;
+	err =3D btf__add_enum_value(btf, name, value);
+	if (!err) {
+		if (btf_elf__verbose)
+			printf("\t%s val=3D%d\n", name, value);
+	} else {
+		fprintf(stderr, "\t%s val=3D%d Error emitting BTF enum value\n",
+			name, value);
+	}
+	return err;
 }
=20
-static int32_t btf_elf__add_func_proto_param(struct btf_elf *btfe, uint3=
2_t name,
+static int32_t btf_elf__add_func_proto_param(struct btf_elf *btfe, const=
 char *name,
 					     uint32_t type, bool is_last_param)
 {
-	struct btf_param param;
-
-	param.name_off =3D name;
-	param.type =3D type;
+	int err;
=20
-	if (gobuffer__add(&btfe->types, &param, sizeof(param)) >=3D 0) {
+	err =3D btf__add_func_param(btfe->btf, name, type);
+	if (!err) {
 		btf_log_func_param(btfe, name, type, false, is_last_param, NULL);
 		return 0;
 	} else {
 		btf_log_func_param(btfe, name, type, true, is_last_param,
-				   "Error in adding gobuffer");
+				   "Error adding func param");
 		return -1;
 	}
 }
=20
-int32_t btf_elf__add_func_proto(struct btf_elf *btfe, struct ftype *ftyp=
e, uint32_t type_id_off)
+extern struct debug_fmt_ops *active_loader;
+
+int32_t btf_elf__add_func_proto(struct btf_elf *btfe, struct cu *cu, str=
uct ftype *ftype, uint32_t type_id_off)
 {
-	uint16_t nr_params, param_idx;
+	struct btf *btf =3D btfe->btf;
+	const struct btf_type *t;
 	struct parameter *param;
-	struct btf_type t;
-	int32_t type_id;
+	uint16_t nr_params, param_idx;
+	int32_t id, type_id;
=20
 	/* add btf_type for func_proto */
 	nr_params =3D ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
+	type_id =3D ftype->tag.type =3D=3D 0 ? 0 : type_id_off + ftype->tag.typ=
e;
=20
-	t.name_off =3D 0;
-	t.info =3D BTF_INFO_ENCODE(BTF_KIND_FUNC_PROTO, 0, nr_params);
-	t.type =3D ftype->tag.type =3D=3D 0 ? 0 : type_id_off + ftype->tag.type=
;
-
-	++btfe->type_index;
-	if (gobuffer__add(&btfe->types, &t, sizeof(t)) >=3D 0) {
-		btf_elf__log_type(btfe, &t, false, false, "return=3D%u args=3D(%s",
-			      t.type, !nr_params ? "void)\n" : "");
-		type_id =3D btfe->type_index;
+	id =3D btf__add_func_proto(btf, type_id);
+	if (id > 0) {
+		t =3D btf__type_by_id(btf, id);
+		btf_elf__log_type(btfe, t, false, false, "return=3D%u args=3D(%s",
+			      t->type, !nr_params ? "void)\n" : "");
 	} else {
-		btf_elf__log_type(btfe, &t, true, true,
-			      "return=3D%u vlen=3D%u Error in adding gobuffer",
-			      t.type, BTF_INFO_VLEN(t.info));
-		return -1;
+		btf_elf__log_err(btfe, BTF_KIND_FUNC_PROTO, NULL, true,
+			      "return=3D%u vlen=3D%u Error emitting BTF type",
+			      type_id, nr_params);
+		return id;
 	}
=20
 	/* add parameters */
 	param_idx =3D 0;
 	ftype__for_each_parameter(ftype, param) {
-		uint32_t param_type_id =3D param->tag.type =3D=3D 0 ? 0 : type_id_off =
+ param->tag.type;
+		const char *name =3D active_loader->strings__ptr(cu, param->name);
+
+		type_id =3D param->tag.type =3D=3D 0 ? 0 : type_id_off + param->tag.ty=
pe;
 		++param_idx;
-		if (btf_elf__add_func_proto_param(btfe, param->name, param_type_id, pa=
ram_idx =3D=3D nr_params))
+		if (btf_elf__add_func_proto_param(btfe, name, type_id, param_idx =3D=3D=
 nr_params))
 			return -1;
 	}
=20
 	++param_idx;
 	if (ftype->unspec_parms)
-		if (btf_elf__add_func_proto_param(btfe, 0, 0, param_idx =3D=3D nr_para=
ms))
+		if (btf_elf__add_func_proto_param(btfe, NULL, 0, param_idx =3D=3D nr_p=
arams))
 			return -1;
=20
-	return type_id;
+	return id;
 }
=20
-int32_t btf_elf__add_var_type(struct btf_elf *btfe, uint32_t type, uint3=
2_t name_off,
+int32_t btf_elf__add_var_type(struct btf_elf *btfe, uint32_t type, const=
 char *name,
 			      uint32_t linkage)
 {
-	struct btf_var_type t;
-
-	t.type.name_off =3D name_off;
-	t.type.info =3D BTF_INFO_ENCODE(BTF_KIND_VAR, 0, 0);
-	t.type.type =3D type;
-
-	t.var.linkage =3D linkage;
-
-	++btfe->type_index;
-	if (gobuffer__add(&btfe->types, &t.type, sizeof(t)) < 0) {
-		btf_elf__log_type(btfe, &t.type, true, true,
-				  "type=3D%u name=3D%s Error in adding gobuffer",
-				  t.type.type, btf_elf__name_in_gobuf(btfe, t.type.name_off));
-		return -1;
+	struct btf *btf =3D btfe->btf;
+	const struct btf_type *t;
+	int32_t id;
+
+	id =3D btf__add_var(btf, name, linkage, type);
+	if (id > 0) {
+		t =3D btf__type_by_id(btf, id);
+		btf_elf__log_type(btfe, t, false, true, "type=3D%u linkage=3D%u",
+				  t->type, btf_var(t)->linkage);
+	} else {
+		btf_elf__log_err(btfe, BTF_KIND_VAR, name, true,
+			      "type=3D%u linkage=3D%u Error emitting BTF type",
+			      type, linkage);
 	}
-
-	btf_elf__log_type(btfe, &t.type, false, false, "type=3D%u name=3D%s",
-			  t.type.type, btf_elf__name_in_gobuf(btfe, t.type.name_off));
-
-	return btfe->type_index;
+	return id;
 }
=20
 int32_t btf_elf__add_var_secinfo(struct gobuffer *buf, uint32_t type,
@@ -621,52 +619,49 @@ int32_t btf_elf__add_var_secinfo(struct gobuffer *b=
uf, uint32_t type,
 	return gobuffer__add(buf, &si, sizeof(si));
 }
=20
-extern struct strings *strings;
-
 int32_t btf_elf__add_datasec_type(struct btf_elf *btfe, const char *sect=
ion_name,
 				  struct gobuffer *var_secinfo_buf)
 {
-	struct btf_type type;
+	struct btf *btf =3D btfe->btf;
 	size_t sz =3D gobuffer__size(var_secinfo_buf);
 	uint16_t nr_var_secinfo =3D sz / sizeof(struct btf_var_secinfo);
-	uint32_t name_off;
-	struct btf_var_secinfo *last_vsi;
+	struct btf_var_secinfo *last_vsi, *vsi;
+	const struct btf_type *t;
+	uint32_t datasec_sz;
+	int32_t err, id, i;
=20
 	qsort(var_secinfo_buf->entries, nr_var_secinfo,
 	      sizeof(struct btf_var_secinfo), btf_var_secinfo_cmp);
=20
 	last_vsi =3D (struct btf_var_secinfo *)var_secinfo_buf->entries + nr_va=
r_secinfo - 1;
+	datasec_sz =3D last_vsi->offset + last_vsi->size;
=20
-	/*
-	 * dwarves doesn't store section names in its string table,
-	 * so we have to add it by ourselves.
-	 */
-	name_off =3D strings__add(strings, section_name);
-
-	type.name_off =3D name_off;
-	type.info =3D BTF_INFO_ENCODE(BTF_KIND_DATASEC, 0, nr_var_secinfo);
-	type.size =3D last_vsi->offset + last_vsi->size;
-
-	++btfe->type_index;
-	if (gobuffer__add(&btfe->types, &type, sizeof(type)) < 0) {
-		btf_elf__log_type(btfe, &type, true, true,
-				  "name=3D%s vlen=3D%u Error in adding datasec",
-				  btf_elf__name_in_gobuf(btfe, type.name_off),
-				  nr_var_secinfo);
-		return -1;
-	}
-	if (gobuffer__add(&btfe->types, var_secinfo_buf->entries, sz) < 0) {
-		btf_elf__log_type(btfe, &type, true, true,
-				  "name=3D%s vlen=3D%u Error in adding var_secinfo",
-				  btf_elf__name_in_gobuf(btfe, type.name_off),
-				  nr_var_secinfo);
-		return -1;
+	id =3D btf__add_datasec(btf, section_name, datasec_sz);
+	if (id < 0) {
+		btf_elf__log_err(btfe, BTF_KIND_DATASEC, section_name, true,
+				 "size=3D%u vlen=3D%u Error emitting BTF type",
+				 datasec_sz, nr_var_secinfo);
+	} else {
+		t =3D btf__type_by_id(btf, id);
+		btf_elf__log_type(btfe, t, false, true, "size=3D%u vlen=3D%u",
+				  t->size, nr_var_secinfo);
+	}
+
+	for (i =3D 0; i < nr_var_secinfo; i++) {
+		vsi =3D (struct btf_var_secinfo *)var_secinfo_buf->entries + i;
+		err =3D btf__add_datasec_var_info(btf, vsi->type, vsi->offset, vsi->si=
ze);
+		if (!err) {
+			if (btf_elf__verbose)
+				printf("\ttype=3D%u offset=3D%u size=3D%u\n",
+				       vsi->type, vsi->offset, vsi->size);
+		} else {
+			fprintf(stderr, "\ttype=3D%u offset=3D%u size=3D%u Error emitting BTF=
 datasec var info\n",
+				       vsi->type, vsi->offset, vsi->size);
+			return -1;
+		}
 	}
=20
-	btf_elf__log_type(btfe, &type, false, false, "type=3Ddatasec name=3D%s"=
,
-			  btf_elf__name_in_gobuf(btfe, type.name_off));
-
-	return btfe->type_index;
+	return id;
 }
=20
 static int btf_elf__write(const char *filename, struct btf *btf)
@@ -771,48 +766,16 @@ out:
=20
 int btf_elf__encode(struct btf_elf *btfe, uint8_t flags)
 {
-	struct btf_header *hdr;
-	struct btf *btf;
-
-	/* Empty file, nothing to do, so... done! */
-	if (gobuffer__size(&btfe->types) =3D=3D 0)
-		return 0;
+	struct btf *btf =3D btfe->btf;
=20
 	if (gobuffer__size(&btfe->percpu_secinfo) !=3D 0)
 		btf_elf__add_datasec_type(btfe, PERCPU_SECTION,
 					  &btfe->percpu_secinfo);
=20
-	btfe->size =3D sizeof(*hdr) + (gobuffer__size(&btfe->types) + gobuffer_=
_size(btfe->strings));
-	btfe->data =3D zalloc(btfe->size);
-
-	if (btfe->data =3D=3D NULL) {
-		fprintf(stderr, "%s: malloc failed!\n", __func__);
-		return -1;
-	}
-
-	hdr =3D btfe->hdr;
-	hdr->magic =3D BTF_MAGIC;
-	hdr->version =3D 1;
-	hdr->flags =3D flags;
-	hdr->hdr_len =3D sizeof(*hdr);
-
-	hdr->type_off =3D 0;
-	hdr->type_len =3D gobuffer__size(&btfe->types);
-	hdr->str_off  =3D hdr->type_len;
-	hdr->str_len  =3D gobuffer__size(btfe->strings);
-
-	gobuffer__copy(&btfe->types, btf_elf__nohdr_data(btfe) + hdr->type_off)=
;
-	gobuffer__copy(btfe->strings, btf_elf__nohdr_data(btfe) + hdr->str_off)=
;
-
-	*(char *)(btf_elf__nohdr_data(btfe) + hdr->str_off) =3D '\0';
-
-	libbpf_set_print(libbpf_log);
+	/* Empty file, nothing to do, so... done! */
+	if (btf__get_nr_types(btf) =3D=3D 0)
+		return 0;
=20
-	btf =3D btf__new(btfe->data, btfe->size);
-	if (IS_ERR(btf)) {
-		fprintf(stderr, "%s: btf__new failed!\n", __func__);
-		return -1;
-	}
 	if (btf__dedup(btf, NULL, NULL)) {
 		fprintf(stderr, "%s: btf__dedup failed!\n", __func__);
 		return -1;
diff --git a/libbtf.h b/libbtf.h
index 5f29b427c4fd..9b3d396da31f 100644
--- a/libbtf.h
+++ b/libbtf.h
@@ -14,24 +14,16 @@
 #include "lib/bpf/src/btf.h"
=20
 struct btf_elf {
-	union {
-		struct btf_header *hdr;
-		void		  *data;
-	};
 	void		  *priv;
 	Elf		  *elf;
 	GElf_Ehdr	  ehdr;
 	struct elf_symtab *symtab;
-	struct gobuffer	  types;
-	struct gobuffer   *strings;
 	struct gobuffer   percpu_secinfo;
 	char		  *filename;
-	size_t		  size;
 	int		  in_fd;
 	uint8_t		  wordsize;
 	bool		  is_big_endian;
 	bool		  raw_btf; // "/sys/kernel/btf/vmlinux"
-	uint32_t	  type_index;
 	uint32_t	  percpu_shndx;
 	uint64_t	  percpu_base_addr;
 	struct btf	  *btf;
@@ -42,33 +34,32 @@ extern uint8_t btf_elf__verbose;
=20
 #define PERCPU_SECTION ".data..percpu"
=20
+struct cu;
 struct base_type;
 struct ftype;
=20
 struct btf_elf *btf_elf__new(const char *filename, Elf *elf);
 void btf_elf__delete(struct btf_elf *btf);
=20
-int32_t btf_elf__add_base_type(struct btf_elf *btf, const struct base_ty=
pe *bt);
+int32_t btf_elf__add_base_type(struct btf_elf *btf, const struct base_ty=
pe *bt,
+			       const char *name);
 int32_t btf_elf__add_ref_type(struct btf_elf *btf, uint16_t kind, uint32=
_t type,
-			      uint32_t name, bool kind_flag);
-int btf_elf__add_member(struct btf_elf *btf, uint32_t name, uint32_t typ=
e, bool kind_flag,
+			      const char *name, bool kind_flag);
+int btf_elf__add_member(struct btf_elf *btf, const char *name, uint32_t =
type,
 			uint32_t bitfield_size, uint32_t bit_offset);
-int32_t btf_elf__add_struct(struct btf_elf *btf, uint8_t kind, uint32_t =
name,
-			    bool kind_flag, uint32_t size, uint16_t nr_members);
+int32_t btf_elf__add_struct(struct btf_elf *btf, uint8_t kind, const cha=
r *name, uint32_t size);
 int32_t btf_elf__add_array(struct btf_elf *btf, uint32_t type, uint32_t =
index_type,
 			   uint32_t nelems);
-int32_t btf_elf__add_enum(struct btf_elf *btf, uint32_t name, uint32_t s=
ize,
-			  uint16_t nr_entries);
-int btf_elf__add_enum_val(struct btf_elf *btf, uint32_t name, int32_t va=
lue);
-int32_t btf_elf__add_func_proto(struct btf_elf *btf, struct ftype *ftype=
,
+int32_t btf_elf__add_enum(struct btf_elf *btf, const char *name, uint32_=
t size);
+int btf_elf__add_enum_val(struct btf_elf *btf, const char *name, int32_t=
 value);
+int32_t btf_elf__add_func_proto(struct btf_elf *btf, struct cu *cu, stru=
ct ftype *ftype,
 				uint32_t type_id_off);
-int32_t btf_elf__add_var_type(struct btf_elf *btfe, uint32_t type, uint3=
2_t name_off,
+int32_t btf_elf__add_var_type(struct btf_elf *btfe, uint32_t type, const=
 char *name,
 			      uint32_t linkage);
 int32_t btf_elf__add_var_secinfo(struct gobuffer *buf, uint32_t type,
 				 uint32_t offset, uint32_t size);
 int32_t btf_elf__add_datasec_type(struct btf_elf *btfe, const char *sect=
ion_name,
 				  struct gobuffer *var_secinfo_buf);
-void btf_elf__set_strings(struct btf_elf *btf, struct gobuffer *strings)=
;
 int  btf_elf__encode(struct btf_elf *btf, uint8_t flags);
=20
 const char *btf_elf__string(struct btf_elf *btf, uint32_t ref);
--=20
2.24.1


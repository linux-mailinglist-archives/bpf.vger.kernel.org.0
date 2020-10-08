Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E89D287F37
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 01:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731074AbgJHXkq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 8 Oct 2020 19:40:46 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59890 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731077AbgJHXkq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 8 Oct 2020 19:40:46 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 098NeDhx007710
        for <bpf@vger.kernel.org>; Thu, 8 Oct 2020 16:40:43 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3429h8gvu2-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2020 16:40:42 -0700
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 8 Oct 2020 16:40:14 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 07A882EC7C76; Thu,  8 Oct 2020 16:40:07 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <dwarves@vger.kernel.org>
CC:     <bpf@vger.kernel.org>, <kernel-team@fb.com>, <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH v2 dwarves 2/8] btf_encoder: use libbpf APIs to encode BTF type info
Date:   Thu, 8 Oct 2020 16:39:54 -0700
Message-ID: <20201008234000.740660-3-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201008234000.740660-1-andrii@kernel.org>
References: <20201008234000.740660-1-andrii@kernel.org>
MIME-Version: 1.0
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: 8BIT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-08_15:2020-10-08,2020-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 clxscore=1034 impostorscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 suspectscore=85
 bulkscore=0 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010080167
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrii Nakryiko <andriin@fb.com>

Switch to use libbpf's BTF writing APIs to encode BTF. This reconciles
btf_elf's use of internal struct btf from libbpf for both loading and encoding
BTF type info. This change also saves a considerable amount of memory used for
DWARF to BTF conversion due to avoiding extra memory copy between gobuffers
and libbpf's struct btf. Now that pahole uses libbpf's struct btf, it's
possible to further utilize libbpf's features and APIs, e.g., for handling
endianness conversion, for dumping raw BTF type info during encoding. These
features might be implemented in the follow up patches.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 btf_encoder.c |  96 +++++-----
 libbtf.c      | 521 +++++++++++++++++++++++---------------------------
 libbtf.h      |  29 +--
 3 files changed, 295 insertions(+), 351 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index e90150784282..6e6bce202438 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -67,6 +67,8 @@ static void dump_invalid_symbol(const char *msg, const char *sym, const char *cu
 	fprintf(stderr, "PAHOLE: Error: Use '-j' or '--force' to ignore such symbols and force emit the btf.\n");
 }
 
+extern struct debug_fmt_ops *dwarves__active_loader;
+
 static int tag__check_id_drift(const struct tag *tag,
 			       uint32_t core_id, uint32_t btf_type_id,
 			       uint32_t type_id_off)
@@ -82,36 +84,19 @@ static int tag__check_id_drift(const struct tag *tag,
 	return 0;
 }
 
-static int32_t structure_type__encode(struct btf_elf *btfe, struct tag *tag, uint32_t type_id_off)
+static int32_t structure_type__encode(struct btf_elf *btfe, struct cu *cu, struct tag *tag, uint32_t type_id_off)
 {
 	struct type *type = tag__type(tag);
 	struct class_member *pos;
-	bool kind_flag = false;
+	const char *name;
 	int32_t type_id;
 	uint8_t kind;
 
 	kind = (tag->tag == DW_TAG_union_type) ?
 		BTF_KIND_UNION : BTF_KIND_STRUCT;
 
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
-				kind_flag = true;
-				break;
-			}
-		}
-	}
-
-	type_id = btf_elf__add_struct(btfe, kind, type->namespace.name, kind_flag, type->size, type->nr_members);
+	name = dwarves__active_loader->strings__ptr(cu, type->namespace.name);
+	type_id = btf_elf__add_struct(btfe, kind, name, type->size);
 	if (type_id < 0)
 		return type_id;
 
@@ -121,7 +106,8 @@ static int32_t structure_type__encode(struct btf_elf *btfe, struct tag *tag, uin
 		 * scheme, which conforms to BTF requirement, so no conversion
 		 * is required.
 		 */
-		if (btf_elf__add_member(btfe, pos->name, type_id_off + pos->tag.type, kind_flag, pos->bitfield_size, pos->bit_offset))
+		name = dwarves__active_loader->strings__ptr(cu, pos->name);
+		if (btf_elf__add_member(btfe, name, type_id_off + pos->tag.type, pos->bitfield_size, pos->bit_offset))
 			return -1;
 	}
 
@@ -140,56 +126,64 @@ static uint32_t array_type__nelems(struct tag *tag)
 	return nelem;
 }
 
-static int32_t enumeration_type__encode(struct btf_elf *btfe, struct tag *tag)
+static int32_t enumeration_type__encode(struct btf_elf *btfe, struct cu *cu, struct tag *tag)
 {
 	struct type *etype = tag__type(tag);
 	struct enumerator *pos;
+	const char *name;
 	int32_t type_id;
 
-	type_id = btf_elf__add_enum(btfe, etype->namespace.name, etype->size, etype->nr_members);
+	name = dwarves__active_loader->strings__ptr(cu, etype->namespace.name);
+	type_id = btf_elf__add_enum(btfe, name, etype->size);
 	if (type_id < 0)
 		return type_id;
 
-	type__for_each_enumerator(etype, pos)
-		if (btf_elf__add_enum_val(btfe, pos->name, pos->value))
+	type__for_each_enumerator(etype, pos) {
+		name = dwarves__active_loader->strings__ptr(cu, pos->name);
+		if (btf_elf__add_enum_val(btfe, name, pos->value))
 			return -1;
+	}
 
 	return type_id;
 }
 
-static int tag__encode_btf(struct tag *tag, uint32_t core_id, struct btf_elf *btfe,
+static int tag__encode_btf(struct cu *cu, struct tag *tag, uint32_t core_id, struct btf_elf *btfe,
 			   uint32_t array_index_id, uint32_t type_id_off)
 {
 	/* single out type 0 as it represents special type "void" */
 	uint32_t ref_type_id = tag->type == 0 ? 0 : type_id_off + tag->type;
+	const char *name;
 
 	switch (tag->tag) {
 	case DW_TAG_base_type:
-		return btf_elf__add_base_type(btfe, tag__base_type(tag));
+		name = dwarves__active_loader->strings__ptr(cu, tag__base_type(tag)->name);
+		return btf_elf__add_base_type(btfe, tag__base_type(tag), name);
 	case DW_TAG_const_type:
-		return btf_elf__add_ref_type(btfe, BTF_KIND_CONST, ref_type_id, 0, false);
+		return btf_elf__add_ref_type(btfe, BTF_KIND_CONST, ref_type_id, NULL, false);
 	case DW_TAG_pointer_type:
-		return btf_elf__add_ref_type(btfe, BTF_KIND_PTR, ref_type_id, 0, false);
+		return btf_elf__add_ref_type(btfe, BTF_KIND_PTR, ref_type_id, NULL, false);
 	case DW_TAG_restrict_type:
-		return btf_elf__add_ref_type(btfe, BTF_KIND_RESTRICT, ref_type_id, 0, false);
+		return btf_elf__add_ref_type(btfe, BTF_KIND_RESTRICT, ref_type_id, NULL, false);
 	case DW_TAG_volatile_type:
-		return btf_elf__add_ref_type(btfe, BTF_KIND_VOLATILE, ref_type_id, 0, false);
+		return btf_elf__add_ref_type(btfe, BTF_KIND_VOLATILE, ref_type_id, NULL, false);
 	case DW_TAG_typedef:
-		return btf_elf__add_ref_type(btfe, BTF_KIND_TYPEDEF, ref_type_id, tag__namespace(tag)->name, false);
+		name = dwarves__active_loader->strings__ptr(cu, tag__namespace(tag)->name);
+		return btf_elf__add_ref_type(btfe, BTF_KIND_TYPEDEF, ref_type_id, name, false);
 	case DW_TAG_structure_type:
 	case DW_TAG_union_type:
 	case DW_TAG_class_type:
+		name = dwarves__active_loader->strings__ptr(cu, tag__namespace(tag)->name);
 		if (tag__type(tag)->declaration)
-			return btf_elf__add_ref_type(btfe, BTF_KIND_FWD, 0, tag__namespace(tag)->name, tag->tag == DW_TAG_union_type);
+			return btf_elf__add_ref_type(btfe, BTF_KIND_FWD, 0, name, tag->tag == DW_TAG_union_type);
 		else
-			return structure_type__encode(btfe, tag, type_id_off);
+			return structure_type__encode(btfe, cu, tag, type_id_off);
 	case DW_TAG_array_type:
 		/* TODO: Encode one dimension at a time. */
 		return btf_elf__add_array(btfe, ref_type_id, array_index_id, array_type__nelems(tag));
 	case DW_TAG_enumeration_type:
-		return enumeration_type__encode(btfe, tag);
+		return enumeration_type__encode(btfe, cu, tag);
 	case DW_TAG_subroutine_type:
-		return btf_elf__add_func_proto(btfe, tag__ftype(tag), type_id_off);
+		return btf_elf__add_func_proto(btfe, cu, tag__ftype(tag), type_id_off);
 	default:
 		fprintf(stderr, "Unsupported DW_TAG_%s(0x%x)\n",
 			dwarf_tag_name(tag->tag), tag->tag);
@@ -197,12 +191,6 @@ static int tag__encode_btf(struct tag *tag, uint32_t core_id, struct btf_elf *bt
 	}
 }
 
-/*
- * FIXME: Its in the DWARF loader, we have to find a better handoff
- * mechanizm...
- */
-extern struct strings *strings;
-
 static struct btf_elf *btfe;
 static uint32_t array_index_id;
 
@@ -265,7 +253,6 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 		btfe = btf_elf__new(cu->filename, cu->elf);
 		if (!btfe)
 			return -1;
-		btf_elf__set_strings(btfe, &strings->gb);
 
 		/* cu__find_base_type_by_name() takes "type_id_t *id" */
 		type_id_t id;
@@ -280,10 +267,10 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 	}
 
 	btf_elf__verbose = verbose;
-	type_id_off = btfe->type_index;
+	type_id_off = btf__get_nr_types(btfe->btf);
 
 	cu__for_each_type(cu, core_id, pos) {
-		int32_t btf_type_id = tag__encode_btf(pos, core_id, btfe, array_index_id, type_id_off);
+		int32_t btf_type_id = tag__encode_btf(cu, pos, core_id, btfe, array_index_id, type_id_off);
 
 		if (btf_type_id < 0 ||
 		    tag__check_id_drift(pos, core_id, btf_type_id, type_id_off)) {
@@ -297,17 +284,19 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 
 		bt.name = 0;
 		bt.bit_size = 32;
-		btf_elf__add_base_type(btfe, &bt);
+		btf_elf__add_base_type(btfe, &bt, "__ARRAY_SIZE_TYPE__");
 	}
 
 	cu__for_each_function(cu, core_id, fn) {
 		int btf_fnproto_id, btf_fn_id;
+		const char *name;
 
 		if (fn->declaration || !fn->external)
 			continue;
 
-		btf_fnproto_id = btf_elf__add_func_proto(btfe, &fn->proto, type_id_off);
-		btf_fn_id = btf_elf__add_ref_type(btfe, BTF_KIND_FUNC, btf_fnproto_id, fn->name, false);
+		btf_fnproto_id = btf_elf__add_func_proto(btfe, cu, &fn->proto, type_id_off);
+		name = dwarves__active_loader->strings__ptr(cu, fn->name);
+		btf_fn_id = btf_elf__add_ref_type(btfe, BTF_KIND_FUNC, btf_fnproto_id, name, false);
 		if (btf_fnproto_id < 0 || btf_fn_id < 0) {
 			err = -1;
 			printf("error: failed to encode function '%s'\n", function__name(fn, cu));
@@ -349,7 +338,7 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 
 	/* search within symtab for percpu variables */
 	elf_symtab__for_each_symbol(btfe->symtab, core_id, sym) {
-		uint32_t linkage, type, size, offset, name;
+		uint32_t linkage, type, size, offset;
 		int32_t btf_var_id, btf_var_secinfo_id;
 		uint64_t addr;
 		const char *sym_name;
@@ -391,7 +380,6 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 			err = -1;
 			break;
 		}
-		name = strings__add(strings, sym_name);
 		if (var->ip.tag.type == 0) {
 			dump_invalid_symbol("Found symbol of void type when encoding btf",
 					    sym_name, cu->name, verbose, force);
@@ -417,7 +405,7 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 
 		/* add a BTF_KIND_VAR in btfe->types */
 		linkage = var->external ? BTF_VAR_GLOBAL_ALLOCATED : BTF_VAR_STATIC;
-		btf_var_id = btf_elf__add_var_type(btfe, type, name, linkage);
+		btf_var_id = btf_elf__add_var_type(btfe, type, sym_name, linkage);
 		if (btf_var_id < 0) {
 			err = -1;
 			printf("error: failed to encode variable '%s'\n", sym_name);
@@ -440,7 +428,9 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 	}
 
 out:
-	if (err)
+	if (err) {
 		btf_elf__delete(btfe);
+		btfe = NULL;
+	}
 	return err;
 }
diff --git a/libbtf.c b/libbtf.c
index 20f9074ad68b..0467f1f2a596 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -27,31 +27,6 @@
 #include "dwarves.h"
 #include "elf_symtab.h"
 
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
 
 static int btf_var_secinfo_cmp(const void *a, const void *b)
@@ -102,6 +77,12 @@ struct btf_elf *btf_elf__new(const char *filename, Elf *elf)
 	if (btfe->filename == NULL)
 		goto errout;
 
+	btfe->btf = btf__new_empty();
+	if (libbpf_get_error(btfe->btf)) {
+		fprintf(stderr, "%s: failed to create empty BTF.\n", __func__);
+		goto errout;
+	}
+
 	if (strcmp(filename, "/sys/kernel/btf/vmlinux") == 0) {
 		btfe->raw_btf  = true;
 		btfe->wordsize = sizeof(long);
@@ -189,12 +170,9 @@ void btf_elf__delete(struct btf_elf *btfe)
 	}
 
 	elf_symtab__delete(btfe->symtab);
-
-	__gobuffer__delete(&btfe->types);
 	__gobuffer__delete(&btfe->percpu_secinfo);
 	btf__free(btfe->btf);
 	free(btfe->filename);
-	free(btfe->data);
 	free(btfe);
 }
 
@@ -205,16 +183,6 @@ const char *btf_elf__string(struct btf_elf *btfe, uint32_t ref)
 	return s && s[0] == '\0' ? NULL : s;
 }
 
-static void *btf_elf__nohdr_data(struct btf_elf *btfe)
-{
-	return btfe->hdr + 1;
-}
-
-void btf_elf__set_strings(struct btf_elf *btfe, struct gobuffer *strings)
-{
-	btfe->strings = strings;
-}
-
 #define BITS_PER_BYTE 8
 #define BITS_PER_BYTE_MASK (BITS_PER_BYTE - 1)
 #define BITS_PER_BYTE_MASKED(bits) ((bits) & BITS_PER_BYTE_MASK)
@@ -240,12 +208,10 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
 	[BTF_KIND_DATASEC]      = "DATASEC",
 };
 
-static const char *btf_elf__name_in_gobuf(const struct btf_elf *btfe, uint32_t offset)
+static const char *btf_elf__printable_name(const struct btf_elf *btfe, uint32_t offset)
 {
 	if (!offset)
 		return "(anon)";
-	else if (btfe->strings)
-		return &btfe->strings->entries[offset];
 	else
 		return btf__str_by_offset(btfe->btf, offset);
 }
@@ -264,6 +230,27 @@ static const char * btf_elf__int_encoding_str(uint8_t encoding)
 		return "UNKN";
 }
 
+
+__attribute ((format (printf, 5, 6)))
+static void btf_elf__log_err(const struct btf_elf *btfe, int kind, const char *name,
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
 static void btf_elf__log_type(const struct btf_elf *btfe, const struct btf_type *t,
 			      bool err, bool output_cr, const char *fmt, ...)
@@ -278,8 +265,8 @@ static void btf_elf__log_type(const struct btf_elf *btfe, const struct btf_type
 	out = err ? stderr : stdout;
 
 	fprintf(out, "[%u] %s %s",
-		btfe->type_index, btf_kind_str[kind],
-		btf_elf__name_in_gobuf(btfe, t->name_off));
+		btf__get_nr_types(btfe->btf), btf_kind_str[kind],
+		btf_elf__printable_name(btfe, t->name_off));
 
 	if (fmt && *fmt) {
 		va_list ap;
@@ -296,8 +283,9 @@ static void btf_elf__log_type(const struct btf_elf *btfe, const struct btf_type
 
 __attribute ((format (printf, 5, 6)))
 static void btf_log_member(const struct btf_elf *btfe,
+			   const struct btf_type *t,
 			   const struct btf_member *member,
-			   bool kind_flag, bool err, const char *fmt, ...)
+			   bool err, const char *fmt, ...)
 {
 	FILE *out;
 
@@ -306,15 +294,15 @@ static void btf_log_member(const struct btf_elf *btfe,
 
 	out = err ? stderr : stdout;
 
-	if (kind_flag)
+	if (btf_kflag(t))
 		fprintf(out, "\t%s type_id=%u bitfield_size=%u bits_offset=%u",
-			btf_elf__name_in_gobuf(btfe, member->name_off),
+			btf_elf__printable_name(btfe, member->name_off),
 			member->type,
 			BTF_MEMBER_BITFIELD_SIZE(member->offset),
 			BTF_MEMBER_BIT_OFFSET(member->offset));
 	else
 		fprintf(out, "\t%s type_id=%u bits_offset=%u",
-			btf_elf__name_in_gobuf(btfe, member->name_off),
+			btf_elf__printable_name(btfe, member->name_off),
 			member->type,
 			member->offset);
 
@@ -332,7 +320,7 @@ static void btf_log_member(const struct btf_elf *btfe,
 
 __attribute ((format (printf, 6, 7)))
 static void btf_log_func_param(const struct btf_elf *btfe,
-			       uint32_t name_off, uint32_t type,
+			       const char *name, uint32_t type,
 			       bool err, bool is_last_param,
 			       const char *fmt, ...)
 {
@@ -346,9 +334,7 @@ static void btf_log_func_param(const struct btf_elf *btfe,
 	if (is_last_param && !type)
 		fprintf(out, "vararg)\n");
 	else
-		fprintf(out, "%u %s%s", type,
-			btf_elf__name_in_gobuf(btfe, name_off),
-			is_last_param ? ")\n" : ", ");
+		fprintf(out, "%u %s%s", type, name, is_last_param ? ")\n" : ", ");
 
 	if (fmt && *fmt) {
 		va_list ap;
@@ -360,15 +346,14 @@ static void btf_log_func_param(const struct btf_elf *btfe,
 	}
 }
 
-int32_t btf_elf__add_base_type(struct btf_elf *btfe, const struct base_type *bt)
+int32_t btf_elf__add_base_type(struct btf_elf *btfe, const struct base_type *bt,
+			       const char *name)
 {
-	struct btf_int_type int_type;
-	struct btf_type *t = &int_type.type;
+	struct btf *btf = btfe->btf;
+	const struct btf_type *t;
 	uint8_t encoding = 0;
+	int32_t id;
 
-	t->name_off = bt->name;
-	t->info = BTF_INFO_ENCODE(BTF_KIND_INT, 0, 0);
-	t->size = BITS_ROUNDUP_BYTES(bt->bit_size);
 	if (bt->is_signed) {
 		encoding = BTF_INT_SIGNED;
 	} else if (bt->is_bool) {
@@ -377,240 +362,253 @@ int32_t btf_elf__add_base_type(struct btf_elf *btfe, const struct base_type *bt)
 		fprintf(stderr, "float_type is not supported\n");
 		return -1;
 	}
-	int_type.data = BTF_INT_ENCODE(encoding, 0, bt->bit_size);
 
-	++btfe->type_index;
-	if (gobuffer__add(&btfe->types, &int_type, sizeof(int_type)) >= 0) {
-		btf_elf__log_type(btfe, t, false, true,
-			      "size=%u bit_offset=%u nr_bits=%u encoding=%s",
-			      t->size, BTF_INT_OFFSET(int_type.data),
-			      BTF_INT_BITS(int_type.data),
-			      btf_elf__int_encoding_str(BTF_INT_ENCODING(int_type.data)));
-		return btfe->type_index;
+	id = btf__add_int(btf, name, BITS_ROUNDUP_BYTES(bt->bit_size), encoding);
+	if (id < 0) {
+		btf_elf__log_err(btfe, BTF_KIND_INT, name, true, "Error emitting BTF type");
 	} else {
-		btf_elf__log_type(btfe, t, true, true,
-			      "size=%u bit_offset=%u nr_bits=%u encoding=%s Error in adding gobuffer",
-			      t->size, BTF_INT_OFFSET(int_type.data),
-			      BTF_INT_BITS(int_type.data),
-			      btf_elf__int_encoding_str(BTF_INT_ENCODING(int_type.data)));
-		return -1;
+		t = btf__type_by_id(btf, id);
+		btf_elf__log_type(btfe, t, false, true,
+				"size=%u nr_bits=%u encoding=%s%s",
+				t->size, bt->bit_size,
+				btf_elf__int_encoding_str(encoding),
+				id < 0 ? " Error in emitting BTF" : "" );
 	}
+
+	return id;
 }
 
 int32_t btf_elf__add_ref_type(struct btf_elf *btfe, uint16_t kind, uint32_t type,
-			      uint32_t name, bool kind_flag)
+			      const char *name, bool kind_flag)
 {
-	struct btf_type t;
-
-	t.name_off = name;
-	t.info = BTF_INFO_ENCODE(kind, kind_flag, 0);
-	t.type = type;
+	struct btf *btf = btfe->btf;
+	const struct btf_type *t;
+	int32_t id;
+
+	switch (kind) {
+	case BTF_KIND_PTR:
+		id = btf__add_ptr(btf, type);
+		break;
+	case BTF_KIND_VOLATILE:
+		id = btf__add_volatile(btf, type);
+		break;
+	case BTF_KIND_CONST:
+		id = btf__add_const(btf, type);
+		break;
+	case BTF_KIND_RESTRICT:
+		id = btf__add_const(btf, type);
+		break;
+	case BTF_KIND_TYPEDEF:
+		id = btf__add_typedef(btf, name, type);
+		break;
+	case BTF_KIND_FWD:
+		id = btf__add_fwd(btf, name, kind_flag);
+		break;
+	case BTF_KIND_FUNC:
+		id = btf__add_func(btf, name, BTF_FUNC_STATIC, type);
+		break;
+	default:
+		btf_elf__log_err(btfe, kind, name, true, "Unexpected kind for reference");
+		return -1;
+	}
 
-	++btfe->type_index;
-	if (gobuffer__add(&btfe->types, &t, sizeof(t)) >= 0) {
+	if (id > 0) {
+		t = btf__type_by_id(btf, id);
 		if (kind == BTF_KIND_FWD)
-			btf_elf__log_type(btfe, &t, false, true, "%s", kind_flag ? "union" : "struct");
+			btf_elf__log_type(btfe, t, false, true, "%s", kind_flag ? "union" : "struct");
 		else
-			btf_elf__log_type(btfe, &t, false, true, "type_id=%u", t.type);
-		return btfe->type_index;
+			btf_elf__log_type(btfe, t, false, true, "type_id=%u", t->type);
 	} else {
-		btf_elf__log_type(btfe, &t, true, true,
-			      "kind_flag=%d type_id=%u Error in adding gobuffer",
-			      kind_flag, t.type);
-		return -1;
+		btf_elf__log_err(btfe, kind, name, true, "Error emitting BTF type");
 	}
+	return id;
 }
 
 int32_t btf_elf__add_array(struct btf_elf *btfe, uint32_t type, uint32_t index_type, uint32_t nelems)
 {
-	struct btf_array_type array_type;
-	struct btf_type *t = &array_type.type;
-	struct btf_array *array = &array_type.array;
-
-	t->name_off = 0;
-	t->info = BTF_INFO_ENCODE(BTF_KIND_ARRAY, 0, 0);
-	t->size = 0;
-
-	array->type = type;
-	array->index_type = index_type;
-	array->nelems = nelems;
-
-	++btfe->type_index;
-	if (gobuffer__add(&btfe->types, &array_type, sizeof(array_type)) >= 0) {
+	struct btf *btf = btfe->btf;
+	const struct btf_type *t;
+	const struct btf_array *array;
+	int32_t id;
+
+	id = btf__add_array(btf, index_type, type, nelems);
+	if (id > 0) {
+		t = btf__type_by_id(btf, id);
+		array = btf_array(t);
 		btf_elf__log_type(btfe, t, false, true,
 			      "type_id=%u index_type_id=%u nr_elems=%u",
 			      array->type, array->index_type, array->nelems);
-		return btfe->type_index;
 	} else {
-		btf_elf__log_type(btfe, t, true, true,
-			      "type_id=%u index_type_id=%u nr_elems=%u Error in adding gobuffer",
-			      array->type, array->index_type, array->nelems);
-		return -1;
+		btf_elf__log_err(btfe, BTF_KIND_ARRAY, NULL, true,
+			      "type_id=%u index_type_id=%u nr_elems=%u Error emitting BTF type",
+			      type, index_type, nelems);
 	}
+	return id;
 }
 
-int btf_elf__add_member(struct btf_elf *btfe, uint32_t name, uint32_t type, bool kind_flag,
+int btf_elf__add_member(struct btf_elf *btfe, const char *name, uint32_t type,
 			uint32_t bitfield_size, uint32_t offset)
 {
-	struct btf_member member = {
-		.name_off   = name,
-		.type   = type,
-		.offset = kind_flag ? (bitfield_size << 24 | offset) : offset,
-	};
+	struct btf *btf = btfe->btf;
+	const struct btf_type *t;
+	const struct btf_member *m;
+	int err;
 
-	if (gobuffer__add(&btfe->types, &member, sizeof(member)) >= 0) {
-		btf_log_member(btfe, &member, kind_flag, false, NULL);
-		return 0;
+	err = btf__add_field(btf, name, type, offset, bitfield_size);
+	t = btf__type_by_id(btf, btf__get_nr_types(btf));
+	if (err) {
+		fprintf(stderr, "[%u] %s %s's field '%s' offset=%u bit_size=%u type=%u Error emitting field\n",
+			btf__get_nr_types(btf), btf_kind_str[btf_kind(t)],
+			btf_elf__printable_name(btfe, t->name_off),
+			name, offset, bitfield_size, type);
 	} else {
-		btf_log_member(btfe, &member, kind_flag, true, "Error in adding gobuffer");
-		return -1;
+		m = &btf_members(t)[btf_vlen(t) - 1];
+		btf_log_member(btfe, t, m, false, NULL);
 	}
+	return err;
 }
 
-int32_t btf_elf__add_struct(struct btf_elf *btfe, uint8_t kind, uint32_t name,
-			    bool kind_flag, uint32_t size, uint16_t nr_members)
+int32_t btf_elf__add_struct(struct btf_elf *btfe, uint8_t kind, const char *name, uint32_t size)
 {
-	struct btf_type t;
-
-	t.name_off = name;
-	t.info = BTF_INFO_ENCODE(kind, kind_flag, nr_members);
-	t.size = size;
+	struct btf *btf = btfe->btf;
+	const struct btf_type *t;
+	int32_t id;
+
+	switch (kind) {
+	case BTF_KIND_STRUCT:
+		id = btf__add_struct(btf, name, size);
+		break;
+	case BTF_KIND_UNION:
+		id = btf__add_union(btf, name, size);
+		break;
+	default:
+		btf_elf__log_err(btfe, kind, name, true, "Unexpected kind of struct");
+		return -1;
+	}
 
-	++btfe->type_index;
-	if (gobuffer__add(&btfe->types, &t, sizeof(t)) >= 0) {
-		btf_elf__log_type(btfe, &t, false, true, "kind_flag=%d size=%u vlen=%u",
-			      kind_flag, t.size, BTF_INFO_VLEN(t.info));
-		return btfe->type_index;
+	if (id < 0) {
+		btf_elf__log_err(btfe, kind, name, true, "Error emitting BTF type");
 	} else {
-		btf_elf__log_type(btfe, &t, true, true,
-			      "kind_flag=%d size=%u vlen=%u Error in adding gobuffer",
-			      kind_flag, t.size, BTF_INFO_VLEN(t.info));
-		return -1;
+		t = btf__type_by_id(btf, id);
+		btf_elf__log_type(btfe, t, false, true, "size=%u", t->size);
 	}
+
+	return id;
 }
 
-int32_t btf_elf__add_enum(struct btf_elf *btfe, uint32_t name, uint32_t bit_size, uint16_t nr_entries)
+int32_t btf_elf__add_enum(struct btf_elf *btfe, const char *name, uint32_t bit_size)
 {
-	struct btf_type t;
-
-	t.name_off = name;
-	t.info = BTF_INFO_ENCODE(BTF_KIND_ENUM, 0, nr_entries);
-	t.size = BITS_ROUNDUP_BYTES(bit_size);
-
-	++btfe->type_index;
-	if (gobuffer__add(&btfe->types, &t, sizeof(t)) >= 0) {
-		btf_elf__log_type(btfe, &t, false, true, "size=%u vlen=%u", t.size, BTF_INFO_VLEN(t.info));
-		return btfe->type_index;
+	struct btf *btf = btfe->btf;
+	const struct btf_type *t;
+	int32_t id, size;
+
+	size = BITS_ROUNDUP_BYTES(bit_size);
+	id = btf__add_enum(btf, name, size);
+	if (id > 0) {
+		t = btf__type_by_id(btf, id);
+		btf_elf__log_type(btfe, t, false, true, "size=%u", t->size);
 	} else {
-		btf_elf__log_type(btfe, &t, true, true,
-			      "size=%u vlen=%u Error in adding gobuffer",
-			      t.size, BTF_INFO_VLEN(t.info));
-		return -1;
+		btf_elf__log_err(btfe, BTF_KIND_ENUM, name, true,
+			      "size=%u Error emitting BTF type", size);
 	}
+	return id;
 }
 
-int btf_elf__add_enum_val(struct btf_elf *btfe, uint32_t name, int32_t value)
+int btf_elf__add_enum_val(struct btf_elf *btfe, const char *name, int32_t value)
 {
-	struct btf_enum e = {
-		.name_off = name,
-		.val  = value,
-	};
-
-	if (gobuffer__add(&btfe->types, &e, sizeof(e)) < 0) {
-		fprintf(stderr, "\t%s val=%d Error in adding gobuffer\n",
-			btf_elf__name_in_gobuf(btfe, e.name_off), e.val);
-		return -1;
-	} else if (btf_elf__verbose)
-		printf("\t%s val=%d\n", btf_elf__name_in_gobuf(btfe, e.name_off),
-		       e.val);
+	struct btf *btf = btfe->btf;
+	int err;
 
-	return 0;
+	err = btf__add_enum_value(btf, name, value);
+	if (!err) {
+		if (btf_elf__verbose)
+			printf("\t%s val=%d\n", name, value);
+	} else {
+		fprintf(stderr, "\t%s val=%d Error emitting BTF enum value\n",
+			name, value);
+	}
+	return err;
 }
 
-static int32_t btf_elf__add_func_proto_param(struct btf_elf *btfe, uint32_t name,
+static int32_t btf_elf__add_func_proto_param(struct btf_elf *btfe, const char *name,
 					     uint32_t type, bool is_last_param)
 {
-	struct btf_param param;
-
-	param.name_off = name;
-	param.type = type;
+	int err;
 
-	if (gobuffer__add(&btfe->types, &param, sizeof(param)) >= 0) {
+	err = btf__add_func_param(btfe->btf, name, type);
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
 
-int32_t btf_elf__add_func_proto(struct btf_elf *btfe, struct ftype *ftype, uint32_t type_id_off)
+extern struct debug_fmt_ops *dwarves__active_loader;
+
+int32_t btf_elf__add_func_proto(struct btf_elf *btfe, struct cu *cu, struct ftype *ftype, uint32_t type_id_off)
 {
-	uint16_t nr_params, param_idx;
+	struct btf *btf = btfe->btf;
+	const struct btf_type *t;
 	struct parameter *param;
-	struct btf_type t;
-	int32_t type_id;
+	uint16_t nr_params, param_idx;
+	int32_t id, type_id;
 
 	/* add btf_type for func_proto */
 	nr_params = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
+	type_id = ftype->tag.type == 0 ? 0 : type_id_off + ftype->tag.type;
 
-	t.name_off = 0;
-	t.info = BTF_INFO_ENCODE(BTF_KIND_FUNC_PROTO, 0, nr_params);
-	t.type = ftype->tag.type == 0 ? 0 : type_id_off + ftype->tag.type;
-
-	++btfe->type_index;
-	if (gobuffer__add(&btfe->types, &t, sizeof(t)) >= 0) {
-		btf_elf__log_type(btfe, &t, false, false, "return=%u args=(%s",
-			      t.type, !nr_params ? "void)\n" : "");
-		type_id = btfe->type_index;
+	id = btf__add_func_proto(btf, type_id);
+	if (id > 0) {
+		t = btf__type_by_id(btf, id);
+		btf_elf__log_type(btfe, t, false, false, "return=%u args=(%s",
+			      t->type, !nr_params ? "void)\n" : "");
 	} else {
-		btf_elf__log_type(btfe, &t, true, true,
-			      "return=%u vlen=%u Error in adding gobuffer",
-			      t.type, BTF_INFO_VLEN(t.info));
-		return -1;
+		btf_elf__log_err(btfe, BTF_KIND_FUNC_PROTO, NULL, true,
+			      "return=%u vlen=%u Error emitting BTF type",
+			      type_id, nr_params);
+		return id;
 	}
 
 	/* add parameters */
 	param_idx = 0;
 	ftype__for_each_parameter(ftype, param) {
-		uint32_t param_type_id = param->tag.type == 0 ? 0 : type_id_off + param->tag.type;
+		const char *name = dwarves__active_loader->strings__ptr(cu, param->name);
+
+		type_id = param->tag.type == 0 ? 0 : type_id_off + param->tag.type;
 		++param_idx;
-		if (btf_elf__add_func_proto_param(btfe, param->name, param_type_id, param_idx == nr_params))
+		if (btf_elf__add_func_proto_param(btfe, name, type_id, param_idx == nr_params))
 			return -1;
 	}
 
 	++param_idx;
 	if (ftype->unspec_parms)
-		if (btf_elf__add_func_proto_param(btfe, 0, 0, param_idx == nr_params))
+		if (btf_elf__add_func_proto_param(btfe, NULL, 0, param_idx == nr_params))
 			return -1;
 
-	return type_id;
+	return id;
 }
 
-int32_t btf_elf__add_var_type(struct btf_elf *btfe, uint32_t type, uint32_t name_off,
+int32_t btf_elf__add_var_type(struct btf_elf *btfe, uint32_t type, const char *name,
 			      uint32_t linkage)
 {
-	struct btf_var_type t;
-
-	t.type.name_off = name_off;
-	t.type.info = BTF_INFO_ENCODE(BTF_KIND_VAR, 0, 0);
-	t.type.type = type;
-
-	t.var.linkage = linkage;
-
-	++btfe->type_index;
-	if (gobuffer__add(&btfe->types, &t.type, sizeof(t)) < 0) {
-		btf_elf__log_type(btfe, &t.type, true, true,
-				  "type=%u name=%s Error in adding gobuffer",
-				  t.type.type, btf_elf__name_in_gobuf(btfe, t.type.name_off));
-		return -1;
+	struct btf *btf = btfe->btf;
+	const struct btf_type *t;
+	int32_t id;
+
+	id = btf__add_var(btf, name, linkage, type);
+	if (id > 0) {
+		t = btf__type_by_id(btf, id);
+		btf_elf__log_type(btfe, t, false, true, "type=%u linkage=%u",
+				  t->type, btf_var(t)->linkage);
+	} else {
+		btf_elf__log_err(btfe, BTF_KIND_VAR, name, true,
+			      "type=%u linkage=%u Error emitting BTF type",
+			      type, linkage);
 	}
-
-	btf_elf__log_type(btfe, &t.type, false, false, "type=%u name=%s\n",
-			  t.type.type, btf_elf__name_in_gobuf(btfe, t.type.name_off));
-
-	return btfe->type_index;
+	return id;
 }
 
 int32_t btf_elf__add_var_secinfo(struct gobuffer *buf, uint32_t type,
@@ -624,52 +622,49 @@ int32_t btf_elf__add_var_secinfo(struct gobuffer *buf, uint32_t type,
 	return gobuffer__add(buf, &si, sizeof(si));
 }
 
-extern struct strings *strings;
-
 int32_t btf_elf__add_datasec_type(struct btf_elf *btfe, const char *section_name,
 				  struct gobuffer *var_secinfo_buf)
 {
-	struct btf_type type;
+	struct btf *btf = btfe->btf;
 	size_t sz = gobuffer__size(var_secinfo_buf);
 	uint16_t nr_var_secinfo = sz / sizeof(struct btf_var_secinfo);
-	uint32_t name_off;
-	struct btf_var_secinfo *last_vsi;
+	struct btf_var_secinfo *last_vsi, *vsi;
+	const struct btf_type *t;
+	uint32_t datasec_sz;
+	int32_t err, id, i;
 
 	qsort(var_secinfo_buf->entries, nr_var_secinfo,
 	      sizeof(struct btf_var_secinfo), btf_var_secinfo_cmp);
 
 	last_vsi = (struct btf_var_secinfo *)var_secinfo_buf->entries + nr_var_secinfo - 1;
+	datasec_sz = last_vsi->offset + last_vsi->size;
 
-	/*
-	 * dwarves doesn't store section names in its string table,
-	 * so we have to add it by ourselves.
-	 */
-	name_off = strings__add(strings, section_name);
-
-	type.name_off = name_off;
-	type.info = BTF_INFO_ENCODE(BTF_KIND_DATASEC, 0, nr_var_secinfo);
-	type.size = last_vsi->offset + last_vsi->size;
-
-	++btfe->type_index;
-	if (gobuffer__add(&btfe->types, &type, sizeof(type)) < 0) {
-		btf_elf__log_type(btfe, &type, true, true,
-				  "name=%s vlen=%u Error in adding datasec",
-				  btf_elf__name_in_gobuf(btfe, type.name_off),
-				  nr_var_secinfo);
-		return -1;
-	}
-	if (gobuffer__add(&btfe->types, var_secinfo_buf->entries, sz) < 0) {
-		btf_elf__log_type(btfe, &type, true, true,
-				  "name=%s vlen=%u Error in adding var_secinfo",
-				  btf_elf__name_in_gobuf(btfe, type.name_off),
-				  nr_var_secinfo);
-		return -1;
+	id = btf__add_datasec(btf, section_name, datasec_sz);
+	if (id < 0) {
+		btf_elf__log_err(btfe, BTF_KIND_DATASEC, section_name, true,
+				 "size=%u vlen=%u Error emitting BTF type",
+				 datasec_sz, nr_var_secinfo);
+	} else {
+		t = btf__type_by_id(btf, id);
+		btf_elf__log_type(btfe, t, false, true, "size=%u vlen=%u",
+				  t->size, nr_var_secinfo);
+	}
+
+	for (i = 0; i < nr_var_secinfo; i++) {
+		vsi = (struct btf_var_secinfo *)var_secinfo_buf->entries + i;
+		err = btf__add_datasec_var_info(btf, vsi->type, vsi->offset, vsi->size);
+		if (!err) {
+			if (btf_elf__verbose)
+				printf("\ttype=%u offset=%u size=%u\n",
+				       vsi->type, vsi->offset, vsi->size);
+		} else {
+			fprintf(stderr, "\ttype=%u offset=%u size=%u Error emitting BTF datasec var info\n",
+				       vsi->type, vsi->offset, vsi->size);
+			return -1;
+		}
 	}
 
-	btf_elf__log_type(btfe, &type, false, false, "type=datasec name=%s",
-			  btf_elf__name_in_gobuf(btfe, type.name_off));
-
-	return btfe->type_index;
+	return id;
 }
 
 static int btf_elf__write(const char *filename, struct btf *btf)
@@ -774,48 +769,16 @@ out:
 
 int btf_elf__encode(struct btf_elf *btfe, uint8_t flags)
 {
-	struct btf_header *hdr;
-	struct btf *btf;
-
-	/* Empty file, nothing to do, so... done! */
-	if (gobuffer__size(&btfe->types) == 0)
-		return 0;
+	struct btf *btf = btfe->btf;
 
 	if (gobuffer__size(&btfe->percpu_secinfo) != 0)
 		btf_elf__add_datasec_type(btfe, PERCPU_SECTION,
 					  &btfe->percpu_secinfo);
 
-	btfe->size = sizeof(*hdr) + (gobuffer__size(&btfe->types) + gobuffer__size(btfe->strings));
-	btfe->data = zalloc(btfe->size);
-
-	if (btfe->data == NULL) {
-		fprintf(stderr, "%s: malloc failed!\n", __func__);
-		return -1;
-	}
-
-	hdr = btfe->hdr;
-	hdr->magic = BTF_MAGIC;
-	hdr->version = 1;
-	hdr->flags = flags;
-	hdr->hdr_len = sizeof(*hdr);
-
-	hdr->type_off = 0;
-	hdr->type_len = gobuffer__size(&btfe->types);
-	hdr->str_off  = hdr->type_len;
-	hdr->str_len  = gobuffer__size(btfe->strings);
-
-	gobuffer__copy(&btfe->types, btf_elf__nohdr_data(btfe) + hdr->type_off);
-	gobuffer__copy(btfe->strings, btf_elf__nohdr_data(btfe) + hdr->str_off);
-
-	*(char *)(btf_elf__nohdr_data(btfe) + hdr->str_off) = '\0';
-
-	libbpf_set_print(libbpf_log);
+	/* Empty file, nothing to do, so... done! */
+	if (btf__get_nr_types(btf) == 0)
+		return 0;
 
-	btf = btf__new(btfe->data, btfe->size);
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
 
 #define PERCPU_SECTION ".data..percpu"
 
+struct cu;
 struct base_type;
 struct ftype;
 
 struct btf_elf *btf_elf__new(const char *filename, Elf *elf);
 void btf_elf__delete(struct btf_elf *btf);
 
-int32_t btf_elf__add_base_type(struct btf_elf *btf, const struct base_type *bt);
+int32_t btf_elf__add_base_type(struct btf_elf *btf, const struct base_type *bt,
+			       const char *name);
 int32_t btf_elf__add_ref_type(struct btf_elf *btf, uint16_t kind, uint32_t type,
-			      uint32_t name, bool kind_flag);
-int btf_elf__add_member(struct btf_elf *btf, uint32_t name, uint32_t type, bool kind_flag,
+			      const char *name, bool kind_flag);
+int btf_elf__add_member(struct btf_elf *btf, const char *name, uint32_t type,
 			uint32_t bitfield_size, uint32_t bit_offset);
-int32_t btf_elf__add_struct(struct btf_elf *btf, uint8_t kind, uint32_t name,
-			    bool kind_flag, uint32_t size, uint16_t nr_members);
+int32_t btf_elf__add_struct(struct btf_elf *btf, uint8_t kind, const char *name, uint32_t size);
 int32_t btf_elf__add_array(struct btf_elf *btf, uint32_t type, uint32_t index_type,
 			   uint32_t nelems);
-int32_t btf_elf__add_enum(struct btf_elf *btf, uint32_t name, uint32_t size,
-			  uint16_t nr_entries);
-int btf_elf__add_enum_val(struct btf_elf *btf, uint32_t name, int32_t value);
-int32_t btf_elf__add_func_proto(struct btf_elf *btf, struct ftype *ftype,
+int32_t btf_elf__add_enum(struct btf_elf *btf, const char *name, uint32_t size);
+int btf_elf__add_enum_val(struct btf_elf *btf, const char *name, int32_t value);
+int32_t btf_elf__add_func_proto(struct btf_elf *btf, struct cu *cu, struct ftype *ftype,
 				uint32_t type_id_off);
-int32_t btf_elf__add_var_type(struct btf_elf *btfe, uint32_t type, uint32_t name_off,
+int32_t btf_elf__add_var_type(struct btf_elf *btfe, uint32_t type, const char *name,
 			      uint32_t linkage);
 int32_t btf_elf__add_var_secinfo(struct gobuffer *buf, uint32_t type,
 				 uint32_t offset, uint32_t size);
 int32_t btf_elf__add_datasec_type(struct btf_elf *btfe, const char *section_name,
 				  struct gobuffer *var_secinfo_buf);
-void btf_elf__set_strings(struct btf_elf *btf, struct gobuffer *strings);
 int  btf_elf__encode(struct btf_elf *btf, uint8_t flags);
 
 const char *btf_elf__string(struct btf_elf *btf, uint32_t ref);
-- 
2.24.1


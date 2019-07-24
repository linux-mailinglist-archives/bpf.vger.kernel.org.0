Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8524673F79
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2019 22:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388182AbfGXT2K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Jul 2019 15:28:10 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:63496 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387564AbfGXT2K (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Jul 2019 15:28:10 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6OJQl8L002976
        for <bpf@vger.kernel.org>; Wed, 24 Jul 2019 12:28:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=pLzD5Hl5HIlYlxXq0QdpMEGXQbtJGcMKDH+xRTbvxkM=;
 b=doM0yRt7XO5GzL9QuG0N/uIzn1Kfx8nBxQ1xeQ8ioUHlLIVd7e584mWUMfiTm0Fd5xdU
 3PtdOmt942sUufi2W+h0a5Qyw+J1SxsSsCoRldV4EOwfw9StXPquDcUe1VIoSud26/+V
 PfrlYoPhSsSclCyJnV2xABzHvSTHMdgL2WY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0b-00082601.pphosted.com with ESMTP id 2txu1ugp62-18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 24 Jul 2019 12:28:08 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 24 Jul 2019 12:28:06 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 91DB98615F8; Wed, 24 Jul 2019 12:28:03 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>, <yhs@fb.com>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 02/10] libbpf: implement BPF CO-RE offset relocation algorithm
Date:   Wed, 24 Jul 2019 12:27:34 -0700
Message-ID: <20190724192742.1419254-3-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190724192742.1419254-1-andriin@fb.com>
References: <20190724192742.1419254-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-24_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=25 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907240208
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch implements the core logic for BPF CO-RE offsets relocations.
All the details are described in code comments.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/libbpf.c | 866 ++++++++++++++++++++++++++++++++++++++++-
 tools/lib/bpf/libbpf.h |   1 +
 2 files changed, 861 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8741c39adb1c..86d87bf10d46 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -38,6 +38,7 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/vfs.h>
+#include <sys/utsname.h>
 #include <tools/libc_compat.h>
 #include <libelf.h>
 #include <gelf.h>
@@ -47,6 +48,7 @@
 #include "btf.h"
 #include "str_error.h"
 #include "libbpf_internal.h"
+#include "hashmap.h"
 
 #ifndef EM_BPF
 #define EM_BPF 247
@@ -1013,16 +1015,22 @@ static int bpf_object__init_user_maps(struct bpf_object *obj, bool strict)
 }
 
 static const struct btf_type *skip_mods_and_typedefs(const struct btf *btf,
-						     __u32 id)
+						     __u32 id,
+						     __u32 *res_id)
 {
 	const struct btf_type *t = btf__type_by_id(btf, id);
 
+	if (res_id)
+		*res_id = id;
+
 	while (true) {
 		switch (BTF_INFO_KIND(t->info)) {
 		case BTF_KIND_VOLATILE:
 		case BTF_KIND_CONST:
 		case BTF_KIND_RESTRICT:
 		case BTF_KIND_TYPEDEF:
+			if (res_id)
+				*res_id = t->type;
 			t = btf__type_by_id(btf, t->type);
 			break;
 		default:
@@ -1041,7 +1049,7 @@ static const struct btf_type *skip_mods_and_typedefs(const struct btf *btf,
 static bool get_map_field_int(const char *map_name, const struct btf *btf,
 			      const struct btf_type *def,
 			      const struct btf_member *m, __u32 *res) {
-	const struct btf_type *t = skip_mods_and_typedefs(btf, m->type);
+	const struct btf_type *t = skip_mods_and_typedefs(btf, m->type, NULL);
 	const char *name = btf__name_by_offset(btf, m->name_off);
 	const struct btf_array *arr_info;
 	const struct btf_type *arr_t;
@@ -1107,7 +1115,7 @@ static int bpf_object__init_user_btf_map(struct bpf_object *obj,
 		return -EOPNOTSUPP;
 	}
 
-	def = skip_mods_and_typedefs(obj->btf, var->type);
+	def = skip_mods_and_typedefs(obj->btf, var->type, NULL);
 	if (BTF_INFO_KIND(def->info) != BTF_KIND_STRUCT) {
 		pr_warning("map '%s': unexpected def kind %u.\n",
 			   map_name, BTF_INFO_KIND(var->info));
@@ -2289,6 +2297,845 @@ bpf_program_reloc_btf_ext(struct bpf_program *prog, struct bpf_object *obj,
 	return 0;
 }
 
+#define BPF_CORE_SPEC_MAX_LEN 64
+
+/* represents BPF CO-RE field or array element accessor */
+struct bpf_core_accessor {
+	__u32 type_id;		/* struct/union type or array element type */
+	__u32 idx;		/* field index or array index */
+	const char *name;	/* field name or NULL for array accessor */
+};
+
+struct bpf_core_spec {
+	const struct btf *btf;
+	/* high-level spec: named fields and array indicies only */
+	struct bpf_core_accessor spec[BPF_CORE_SPEC_MAX_LEN];
+	/* high-level spec length */
+	int len;
+	/* raw, low-level spec: 1-to-1 with accessor spec string */
+	int raw_spec[BPF_CORE_SPEC_MAX_LEN];
+	/* raw spec length */
+	int raw_len;
+	/* field byte offset represented by spec */
+	__u32 offset;
+};
+
+static bool str_is_empty(const char *s)
+{
+	return !s || !s[0];
+}
+
+static int btf_kind(const struct btf_type *t)
+{
+	return BTF_INFO_KIND(t->info);
+}
+
+static bool btf_is_composite(const struct btf_type *t)
+{
+	int kind = btf_kind(t);
+
+	return kind == BTF_KIND_STRUCT || kind == BTF_KIND_UNION;
+}
+
+static bool btf_is_array(const struct btf_type *t)
+{
+	return btf_kind(t) == BTF_KIND_ARRAY;
+}
+
+/* 
+ * Turn bpf_offset_reloc into a low- and high-level spec representation,
+ * validating correctness along the way, as well as calculating resulting
+ * field offset (in bytes), specified by accessor string. Low-level spec
+ * captures every single level of nestedness, including traversing anonymous
+ * struct/union members. High-level one only captures semantically meaningful
+ * "turning points": named fields and array indicies.
+ * E.g., for this case:
+ *
+ *   struct sample {
+ *       int __unimportant;
+ *       struct {
+ *           int __1;
+ *           int __2;
+ *           int a[7];
+ *       };
+ *   };
+ *
+ *   struct sample *s = ...;
+ *
+ *   int x = &s->a[3]; // access string = '0:1:2:3'
+ *
+ * Low-level spec has 1:1 mapping with each element of access string (it's
+ * just a parsed access string representation): [0, 1, 2, 3].
+ *
+ * High-level spec will capture only 3 points:
+ *   - intial zero-index access by pointer (&s->... is the same as &s[0]...);
+ *   - field 'a' access (corresponds to '2' in low-level spec);
+ *   - array element #3 access (corresponds to '3' in low-level spec).
+ *
+ */
+static int bpf_core_spec_parse(const struct btf *btf,
+			       __u32 type_id,
+			       const char *spec_str,
+			       struct bpf_core_spec *spec)
+{
+	int access_idx, parsed_len, i;
+	const struct btf_type *t;
+	__u32 id = type_id;
+	const char *name;
+	__s64 sz;
+
+	if (str_is_empty(spec_str) || *spec_str == ':')
+		return -EINVAL;
+
+	memset(spec, 0, sizeof(*spec));
+	spec->btf = btf;
+
+	/* parse spec_str="0:1:2:3:4" into array raw_spec=[0, 1, 2, 3, 4] */
+	while (*spec_str) {
+		if (*spec_str == ':')
+			++spec_str;
+		if (sscanf(spec_str, "%d%n", &access_idx, &parsed_len) != 1)
+			return -EINVAL;
+		if (spec->raw_len == BPF_CORE_SPEC_MAX_LEN)
+			return -E2BIG;
+		spec_str += parsed_len;
+		spec->raw_spec[spec->raw_len++] = access_idx;
+	}
+
+	if (spec->raw_len == 0)
+		return -EINVAL;
+
+	for (i = 0; i < spec->raw_len; i++) {
+		t = skip_mods_and_typedefs(btf, id, &id);
+		if (!t)
+			return -EINVAL;
+
+		access_idx = spec->raw_spec[i];
+
+		if (i == 0) {
+			/* first spec value is always reloc type array index */
+			spec->spec[spec->len].type_id = id;
+			spec->spec[spec->len].idx = access_idx;
+			spec->len++;
+
+			sz = btf__resolve_size(btf, id);
+			if (sz < 0)
+				return sz;
+			spec->offset += access_idx * sz;
+			continue;
+		}
+
+		if (btf_is_composite(t)) {
+			const struct btf_member *m = (void *)(t + 1);
+			__u32 offset;
+
+			if (access_idx >= BTF_INFO_VLEN(t->info))
+				return -EINVAL;
+
+			m = &m[access_idx];
+
+			if (BTF_INFO_KFLAG(t->info)) {
+				if (BTF_MEMBER_BITFIELD_SIZE(m->offset))
+					return -EINVAL;
+				offset = BTF_MEMBER_BIT_OFFSET(m->offset);
+			} else {
+				offset = m->offset;
+			}
+			if (m->offset % 8)
+				return -EINVAL;
+			spec->offset += offset / 8;
+
+			if (m->name_off) {
+				name = btf__name_by_offset(btf, m->name_off);
+				if (str_is_empty(name))
+					return -EINVAL;
+
+				spec->spec[spec->len].type_id = id;
+				spec->spec[spec->len].idx = access_idx;
+				spec->spec[spec->len].name = name;
+				spec->len++;
+			}
+
+			id = m->type;
+		} else if (btf_is_array(t)) {
+			const struct btf_array *a = (void *)(t + 1);
+
+			t = skip_mods_and_typedefs(btf, a->type, &id);
+			if (!t || access_idx >= a->nelems)
+				return -EINVAL;
+
+			spec->spec[spec->len].type_id = id;
+			spec->spec[spec->len].idx = access_idx;
+			spec->len++;
+
+			sz = btf__resolve_size(btf, id);
+			if (sz < 0)
+				return sz;
+			spec->offset += access_idx * sz;
+		} else {
+			pr_warning("relo for [%u] %s (at idx %d) captures type [%d] of unexpected kind %d\n",
+				   type_id, spec_str, i, id, btf_kind(t));
+			return -EINVAL;
+		}
+	}
+
+	if (spec->len == 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+/* Given 'some_struct_name___with_flavor' return the length of a name prefix
+ * before last triple underscore. Struct name part after last triple
+ * underscore is ignored by BPF CO-RE relocation during relocation matching.
+ */
+static size_t bpf_core_essential_name_len(const char *name)
+{
+	size_t n = strlen(name);
+	int i = n - 3;
+
+	while (i > 0) {
+		if (name[i] == '_' && name[i + 1] == '_' && name[i + 2] == '_')
+			return i;
+		i--;
+	}
+	return n;
+}
+
+/* dynamically sized list of type IDs */
+struct ids_vec {
+	__u32 *data;
+	int len;
+};
+
+static void bpf_core_free_cands(struct ids_vec *cand_ids)
+{
+	free(cand_ids->data);
+	free(cand_ids);
+}
+
+static struct ids_vec *bpf_core_find_cands(const struct btf *local_btf,
+					   __u32 local_type_id,
+					   const struct btf *targ_btf)
+{
+	size_t local_essent_len, targ_essent_len;
+	const char *local_name, *targ_name;
+	const struct btf_type *t;
+	struct ids_vec *cand_ids;
+	__u32 *new_ids;
+	int i, err, n;
+
+	t = btf__type_by_id(local_btf, local_type_id);
+	if (!t)
+		return ERR_PTR(-EINVAL);
+
+	local_name = btf__name_by_offset(local_btf, t->name_off);
+	if (str_is_empty(local_name))
+		return ERR_PTR(-EINVAL);
+	local_essent_len = bpf_core_essential_name_len(local_name);
+
+	cand_ids = calloc(1, sizeof(*cand_ids));
+	if (!cand_ids)
+		return ERR_PTR(-ENOMEM);
+
+	n = btf__get_nr_types(targ_btf);
+	for (i = 1; i <= n; i++) {
+		t = btf__type_by_id(targ_btf, i);
+		targ_name = btf__name_by_offset(targ_btf, t->name_off);
+		if (str_is_empty(targ_name))
+			continue;
+
+		targ_essent_len = bpf_core_essential_name_len(targ_name);
+		if (targ_essent_len != local_essent_len)
+			continue;
+
+		if (strncmp(local_name, targ_name, local_essent_len) == 0) {
+			pr_debug("[%d] (%s): found candidate [%d] (%s)\n",
+				 local_type_id, local_name, i, targ_name);
+			new_ids = realloc(cand_ids->data, cand_ids->len + 1);
+			if (!new_ids) {
+				err = -ENOMEM;
+				goto err_out;
+			}
+			cand_ids->data = new_ids;
+			cand_ids->data[cand_ids->len++] = i;
+		}
+	}
+	return cand_ids;
+err_out:
+	bpf_core_free_cands(cand_ids);
+	return ERR_PTR(err);
+}
+
+/* Check two types for compatibility, skipping const/volatile/restrict and
+ * typedefs, to ensure we are relocating offset to the compatible entities:
+ *   - any two STRUCTs/UNIONs are compatible and can be mixed;
+ *   - any two FWDs are compatible;
+ *   - any two PTRs are always compatible;
+ *   - for ENUMs, check sizes, names are ignored;
+ *   - for INT, size and bitness should match, signedness is ignored;
+ *   - for ARRAY, dimensionality is ignored, element types are checked for
+ *     compatibility recursively;
+ *   - everything else shouldn't be ever a target of relocation.
+ * These rules are not set in stone and probably will be adjusted as we get
+ * more experience with using BPF CO-RE relocations.
+ */
+static int bpf_core_fields_are_compat(const struct btf *local_btf,
+				      __u32 local_id,
+				      const struct btf *targ_btf,
+				      __u32 targ_id)
+{
+	const struct btf_type *local_type, *targ_type;
+	__u16 kind;
+
+recur:
+	local_type = skip_mods_and_typedefs(local_btf, local_id, &local_id);
+	targ_type = skip_mods_and_typedefs(targ_btf, targ_id, &targ_id);
+	if (!local_type || !targ_type)
+		return -EINVAL;
+
+	if (btf_is_composite(local_type) && btf_is_composite(targ_type))
+		return 1;
+	if (BTF_INFO_KIND(local_type->info) != BTF_INFO_KIND(targ_type->info))
+		return 0;
+
+	kind = BTF_INFO_KIND(local_type->info);
+	switch (kind) {
+	case BTF_KIND_FWD:
+	case BTF_KIND_PTR:
+		return 1;
+	case BTF_KIND_ENUM:
+		return local_type->size == targ_type->size;
+	case BTF_KIND_INT: {
+		__u32 loc_int = *(__u32 *)(local_type + 1);
+		__u32 targ_int = *(__u32 *)(targ_type + 1);
+
+		return BTF_INT_OFFSET(loc_int) == 0 &&
+		       BTF_INT_OFFSET(targ_int) == 0 &&
+		       local_type->size == targ_type->size &&
+		       BTF_INT_BITS(loc_int) == BTF_INT_BITS(targ_int);
+	}
+	case BTF_KIND_ARRAY: {
+		const struct btf_array *loc_a, *targ_a;
+
+		loc_a = (void *)(local_type + 1);
+		targ_a = (void *)(targ_type + 1);
+		local_id = loc_a->type;
+		targ_id = targ_a->type;
+		goto recur;
+	}
+	default:
+		pr_warning("unexpected kind %d relocated, local [%d], target [%d]\n",
+			   kind, local_id, targ_id);
+		return 0;
+	}
+}
+
+/* 
+ * Given single high-level accessor (either named field or array index) in
+ * local type, find corresponding high-level accessor for a target type. Along
+ * the way, maintain low-level spec for target as well. Also keep updating
+ * target offset.
+ */
+static int bpf_core_match_member(const struct btf *local_btf,
+				 const struct bpf_core_accessor *local_acc,
+				 const struct btf *targ_btf,
+				 __u32 targ_id,
+				 struct bpf_core_spec *spec,
+				 __u32 *next_targ_id)
+{
+	const struct btf_type *local_type, *targ_type;
+	const struct btf_member *local_member, *m;
+	const char *local_name, *targ_name;
+	__u32 local_id;
+	int i, n, found;
+
+	targ_type = skip_mods_and_typedefs(targ_btf, targ_id, &targ_id);
+	if (!targ_type)
+		return -EINVAL;
+	if (!btf_is_composite(targ_type))
+		return 0;
+
+	local_id = local_acc->type_id;
+	local_type = btf__type_by_id(local_btf, local_id);
+	local_member = (void *)(local_type + 1);
+	local_member += local_acc->idx;
+	local_name = btf__name_by_offset(local_btf, local_member->name_off);
+
+	n = BTF_INFO_VLEN(targ_type->info);
+	m = (void *)(targ_type + 1);
+	for (i = 0; i < n; i++, m++) {
+		__u32 offset;
+
+		/* bitfield relocations not supported */
+		if (BTF_INFO_KFLAG(targ_type->info)) {
+			if (BTF_MEMBER_BITFIELD_SIZE(m->offset))
+				continue;
+			offset = BTF_MEMBER_BIT_OFFSET(m->offset);
+		} else {
+			offset = m->offset;
+		}
+		if (offset % 8)
+			continue;
+
+		/* too deep struct/union/array nesting */
+		if (spec->raw_len == BPF_CORE_SPEC_MAX_LEN)
+			return -E2BIG;
+
+		/* speculate this member will be the good one */
+		spec->offset += offset / 8;
+		spec->raw_spec[spec->raw_len++] = i;
+
+		targ_name = btf__name_by_offset(targ_btf, m->name_off);
+		if (str_is_empty(targ_name)) {
+			/* embedded struct/union, we need to go deeper */
+			found = bpf_core_match_member(local_btf, local_acc,
+						      targ_btf, m->type,
+						      spec, next_targ_id);
+			if (found) /* either found or error */
+				return found;
+		} else if (strcmp(local_name, targ_name) == 0) {
+			/* matching named field */
+			struct bpf_core_accessor *targ_acc;
+
+			targ_acc = &spec->spec[spec->len++];
+			targ_acc->type_id = targ_id;
+			targ_acc->idx = i;
+			targ_acc->name = targ_name;
+
+			*next_targ_id = m->type;
+			found = bpf_core_fields_are_compat(local_btf,
+							   local_member->type,
+							   targ_btf, m->type);
+			if (!found)
+				spec->len--; /* pop accessor */
+			return found;
+		}
+		/* member turned out to be not we looked for */
+		spec->offset -= offset / 8;
+		spec->raw_len--;
+	}
+
+	return 0;
+}
+
+/*
+ * Try to match local spec to a target type and, if successful, produce full
+ * target spec (high-level, low-level + offset).
+ */
+static int bpf_core_spec_match(struct bpf_core_spec *local_spec,
+			       const struct btf *targ_btf, __u32 targ_id,
+			       struct bpf_core_spec *targ_spec)
+{
+	const struct btf_type *targ_type;
+	const struct bpf_core_accessor *local_acc;
+	struct bpf_core_accessor *targ_acc;
+	int i, sz, matched;
+
+	memset(targ_spec, 0, sizeof(*targ_spec));
+	targ_spec->btf = targ_btf;
+
+	local_acc = &local_spec->spec[0];
+	targ_acc = &targ_spec->spec[0];
+
+	for (i = 0; i < local_spec->len; i++, local_acc++, targ_acc++) {
+		targ_type = skip_mods_and_typedefs(targ_spec->btf, targ_id,
+						   &targ_id);
+		if (!targ_type)
+			return -EINVAL;
+
+		if (local_acc->name) {
+			if (!btf_is_composite(targ_type))
+				return 0;
+
+			matched = bpf_core_match_member(local_spec->btf,
+							local_acc,
+							targ_btf, targ_id,
+							targ_spec, &targ_id);
+			if (matched <= 0)
+				return matched;
+		} else {
+			/* for i=0, targ_id is already treated as array element
+			 * type (because it's the original struct), for others
+			 * we should find array element type first
+			 */
+			if (i > 0) {
+				const struct btf_array *a;
+
+				if (!btf_is_array(targ_type))
+					return 0;
+
+				a = (void *)(targ_type + 1);
+				if (local_acc->idx >= a->nelems)
+					return 0;
+				if (!skip_mods_and_typedefs(targ_btf, a->type,
+							    &targ_id))
+					return -EINVAL;
+			}
+
+			/* too deep struct/union/array nesting */
+			if (targ_spec->raw_len == BPF_CORE_SPEC_MAX_LEN)
+				return -E2BIG;
+
+			targ_acc->type_id = targ_id;
+			targ_acc->idx = local_acc->idx;
+			targ_acc->name = NULL;
+			targ_spec->len++;
+			targ_spec->raw_spec[targ_spec->raw_len] = targ_acc->idx;
+			targ_spec->raw_len++;
+
+			sz = btf__resolve_size(targ_btf, targ_id);
+			if (sz < 0)
+				return sz;
+			targ_spec->offset += local_acc->idx * sz;
+		}
+	}
+
+	return 1;
+}
+
+/*
+ * Patch relocatable BPF instruction.
+ * Expected insn->imm value is provided for validation, as well as the new
+ * relocated value.
+ *
+ * Currently three kinds of BPF instructions are supported:
+ * 1. rX = <imm> (assignment with immediate operand);
+ * 2. rX += <imm> (arithmetic operations with immediate operand);
+ * 3. *(rX) = <imm> (indirect memory assignment with immediate operand).
+ *
+ * If actual insn->imm value is wrong, bail out.
+ */
+static int bpf_core_reloc_insn(struct bpf_program *prog, int insn_off,
+			       __u32 orig_off, __u32 new_off)
+{
+	struct bpf_insn *insn;
+	int insn_idx;
+	__u8 class;
+
+	if (insn_off % sizeof(struct bpf_insn))
+		return -EINVAL;
+	insn_idx = insn_off / sizeof(struct bpf_insn);
+
+	insn = &prog->insns[insn_idx];
+	class = BPF_CLASS(insn->code);
+
+	if (class == BPF_ALU || class == BPF_ALU64) {
+		if (BPF_SRC(insn->code) != BPF_K)
+			return -EINVAL;
+		if (insn->imm != orig_off)
+			return -EINVAL;
+		insn->imm = new_off;
+		pr_debug("prog '%s': patched insn #%d (ALU/ALU64) imm %d -> %d\n",
+			 bpf_program__title(prog, false),
+			 insn_idx, orig_off, new_off);
+	} else if (class == BPF_ST && BPF_MODE(insn->code) == BPF_MEM) {
+		if (insn->imm != orig_off)
+			return -EINVAL;
+		insn->imm = new_off;
+		pr_debug("prog '%s': patched insn #%d (ST | MEM) imm %d -> %d\n",
+			 bpf_program__title(prog, false),
+			 insn_idx, orig_off, new_off);
+	} else {
+		pr_warning("prog '%s': trying to relocate unrecognized insn #%d, code:%x, src:%x, dst:%x, off:%x, imm:%x\n",
+			   bpf_program__title(prog, false),
+			   insn_idx, insn->code, insn->src_reg, insn->dst_reg,
+			   insn->off, insn->imm);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/*
+ * Probe few well-known locations for vmlinux kernel image and try to load BTF
+ * data out of it to use for target BTF.
+ */
+static struct btf *bpf_core_find_kernel_btf(void)
+{
+	const char *locations[] = {
+		"/lib/modules/%1$s/vmlinux-%1$s",
+		"/usr/lib/modules/%1$s/kernel/vmlinux",
+	};
+	char path[PATH_MAX + 1];
+	struct utsname buf;
+	struct btf *btf;
+	int i, err;
+
+	err = uname(&buf);
+	if (err) {
+		pr_warning("failed to uname(): %d\n", err);
+		return ERR_PTR(err);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(locations); i++) {
+		snprintf(path, PATH_MAX, locations[i], buf.release);
+		pr_debug("attempting to load kernel BTF from '%s'\n", path);
+
+		if (access(path, R_OK))
+			continue;
+
+		btf = btf__parse_elf(path, NULL);
+		if (IS_ERR(btf))
+			continue;
+
+		pr_debug("successfully loaded kernel BTF from '%s'\n", path);
+		return btf;
+	}
+
+	pr_warning("failed to find valid kernel BTF\n");
+	return ERR_PTR(-ESRCH);
+}
+
+static size_t bpf_core_hash_fn(const void *key, void *ctx)
+{
+	return (size_t)key;
+}
+
+static bool bpf_core_equal_fn(const void *k1, const void *k2, void *ctx)
+{
+	return k1 == k2;
+}
+
+static void *u32_to_ptr(__u32 x)
+{
+	return (void *)(uintptr_t)x;
+}
+
+/* 
+ * CO-RE relocate single instruction.
+ *
+ * The outline and important points of the algorithm:
+ * 1. For given local type, find corresponding candidate target types.
+ *    Candidate type is a type with the same "essential" name, ignoring
+ *    everything after last triple underscore (___). E.g., `sample`,
+ *    `sample___flavor_one`, `sample___flavor_another_one`, are all candidates
+ *    for each other. Names with triple underscore are referred to as
+ *    "flavors" and are useful, among other things, to allow to
+ *    specify/support incompatible variations of the same kernel struct, which
+ *    might differ between different kernel versions and/or build
+ *    configurations.
+ * 2. For each candidate type, try to match local specification to this
+ *    candidate target type. Matching involves finding corresponding
+ *    high-level spec accessors, meaning that all named fields should match,
+ *    as well as all array accesses should be within the actual bounds. Also,
+ *    types should be compatible (see bpf_core_fields_are_compat for details).
+ * 3. It is supported and expected that there might be multiple flavors
+ *    matching the spec. As long as all the specs resolve to the same set of
+ *    offsets across all candidates, there is not error. If there is any
+ *    ambiguity, CO-RE relocation will fail. This is necessary to accomodate
+ *    imprefection of BTF deduplication, which can cause slight duplication of
+ *    the same BTF type, if some directly or indirectly referenced (by
+ *    pointer) type gets resolved to different actual types in different
+ *    object files. If such situation occurs, deduplicated BTF will end up
+ *    with two (or more) structurally identical types, which differ only in
+ *    types they refer to through pointer. This should be OK in most cases and
+ *    is not an error.
+ * 4. Candidate types search is performed by linearly scanning through all
+ *    types in target BTF. It is anticipated that this is overall more
+ *    efficient memory-wise and not significantly worse (if not better)
+ *    CPU-wise compared to prebuilding a map from all local type names to
+ *    a list of candidate type names. It's also sped up by caching resolved
+ *    list of matching candidates per each local "root" type ID, that has at
+ *    least one bpf_offset_reloc associated with it. This list is shared
+ *    between multiple relocations for the same type ID and is updated as some
+ *    of the candidates are pruned due to structural incompatibility.
+ */
+static int bpf_core_reloc_offset(struct bpf_program *prog,
+				 const struct bpf_offset_reloc *relo,
+				 int relo_idx,
+				 const struct btf *local_btf,
+				 const struct btf *targ_btf,
+				 struct hashmap *cand_cache)
+{
+	const char *prog_name = bpf_program__title(prog, false);
+	struct bpf_core_spec local_spec, cand_spec, targ_spec;
+	const void *type_key = u32_to_ptr(relo->type_id);
+	const struct btf_type *local_type, *cand_type;
+	const char *local_name, *cand_name;
+	struct ids_vec *cand_ids;
+	__u32 local_id, cand_id;
+	const char *spec_str;
+	int i, j, err;
+
+	local_id = relo->type_id;
+	local_type = btf__type_by_id(local_btf, local_id);
+	if (!local_type)
+		return -EINVAL;
+
+	local_name = btf__name_by_offset(local_btf, local_type->name_off);
+	if (str_is_empty(local_name))
+		return -EINVAL;
+
+	spec_str = btf__name_by_offset(local_btf, relo->access_str_off);
+	if (str_is_empty(spec_str))
+		return -EINVAL;
+
+	pr_debug("prog '%s': relo #%d: insn_off=%d, [%d] (%s) + %s\n",
+		 prog_name, relo_idx, relo->insn_off,
+		 local_id, local_name, spec_str);
+
+	err = bpf_core_spec_parse(local_btf, local_id, spec_str, &local_spec);
+	if (err) {
+		pr_warning("prog '%s': relo #%d: parsing [%d] (%s) + %s failed: %d\n",
+			   prog_name, relo_idx, local_id, local_name, spec_str,
+			   err);
+		return -EINVAL;
+	}
+	pr_debug("prog '%s': relo #%d: [%d] (%s) + %s is off %u, len %d, raw_len %d\n",
+		 prog_name, relo_idx, local_id, local_name, spec_str,
+		 local_spec.offset, local_spec.len, local_spec.raw_len);
+
+	if (!hashmap__find(cand_cache, type_key, (void **)&cand_ids)) {
+		cand_ids = bpf_core_find_cands(local_btf, local_id, targ_btf);
+		if (IS_ERR(cand_ids)) {
+			pr_warning("prog '%s': relo #%d: target candidate search failed for [%d] (%s) + %s: %ld\n",
+				   prog_name, relo_idx, local_id, local_name,
+				   spec_str, PTR_ERR(cand_ids));
+			return PTR_ERR(cand_ids);
+		}
+		err = hashmap__set(cand_cache, type_key, cand_ids, NULL, NULL);
+		if (err) {
+			bpf_core_free_cands(cand_ids);
+			return err;
+		}
+	}
+
+	for (i = 0, j = 0; i < cand_ids->len; i++) {
+		cand_id = cand_ids->data[j];
+		cand_type = btf__type_by_id(targ_btf, cand_id);
+		cand_name = btf__name_by_offset(targ_btf, cand_type->name_off);
+
+		err = bpf_core_spec_match(&local_spec, targ_btf,
+					  cand_id, &cand_spec);
+		if (err < 0) {
+			pr_warning("prog '%s': relo #%d: failed to match spec [%d] (%s) + %s to candidate #%d [%d] (%s): %d\n",
+				   prog_name, relo_idx, local_id, local_name,
+				   spec_str, i, cand_id, cand_name, err);
+			return err;
+		}
+		if (err == 0) {
+			pr_debug("prog '%s': relo #%d: candidate #%d [%d] (%s) doesn't match spec\n",
+				 prog_name, relo_idx, i, cand_id, cand_name);
+			continue;
+		}
+
+		pr_debug("prog '%s': relo #%d: candidate #%d ([%d] %s) is off %u, len %d, raw_len %d\n",
+			 prog_name, relo_idx, i, cand_id, cand_name,
+			 cand_spec.offset, cand_spec.len, cand_spec.raw_len);
+
+		if (j == 0) {
+			targ_spec = cand_spec;
+		} else if (cand_spec.offset != targ_spec.offset) {
+			/* if there are many candidates, they should all
+			 * resolve to the same offset
+			 */
+			pr_warning("prog '%s': relo #%d: candidate #%d ([%d] %s): conflicting offset found (%u != %u)\n",
+				   prog_name, relo_idx, i, cand_id, cand_name,
+				   cand_spec.offset, targ_spec.offset);
+			return -EINVAL;
+		}
+
+		cand_ids->data[j++] = cand_spec.spec[0].type_id;
+	}
+
+	cand_ids->len = j;
+	if (cand_ids->len == 0) {
+		pr_warning("prog '%s': relo #%d: no matching targets found for [%d] (%s) + %s\n",
+			   prog_name, relo_idx, local_id, local_name, spec_str);
+		return -ESRCH;
+	}
+
+	err = bpf_core_reloc_insn(prog, relo->insn_off,
+				  local_spec.offset, targ_spec.offset);
+	if (err) {
+		pr_warning("prog '%s': relo #%d: failed to patch insn at offset %d: %d\n",
+			   prog_name, relo_idx, relo->insn_off, err);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int
+bpf_core_reloc_offsets(struct bpf_object *obj, const char *targ_btf_path)
+{
+	const struct btf_ext_info_sec *sec;
+	const struct bpf_offset_reloc *rec;
+	const struct btf_ext_info *seg;
+	struct hashmap_entry *entry;
+	struct hashmap *cand_cache = NULL;
+	struct bpf_program *prog;
+	struct btf *targ_btf;
+	const char *sec_name;
+	int i, err = 0;
+
+	if (targ_btf_path)
+		targ_btf = btf__parse_elf(targ_btf_path, NULL);
+	else
+		targ_btf = bpf_core_find_kernel_btf();
+	if (IS_ERR(targ_btf)) {
+		pr_warning("failed to get target BTF: %ld\n",
+			   PTR_ERR(targ_btf));
+		return PTR_ERR(targ_btf);
+	}
+
+	cand_cache = hashmap__new(bpf_core_hash_fn, bpf_core_equal_fn, NULL);
+	if (IS_ERR(cand_cache)) {
+		err = PTR_ERR(cand_cache);
+		goto out;
+	}
+
+	seg = &obj->btf_ext->offset_reloc_info;
+	for_each_btf_ext_sec(seg, sec) {
+		sec_name = btf__name_by_offset(obj->btf, sec->sec_name_off);
+		if (str_is_empty(sec_name)) {
+			err = -EINVAL;
+			goto out;
+		}
+		prog = bpf_object__find_program_by_title(obj, sec_name);
+		if (!prog) {
+			pr_warning("failed to find program '%s' for CO-RE offset relocation\n",
+				   sec_name);
+			err = -EINVAL;
+			goto out;
+		}
+
+		pr_debug("prog '%s': performing %d CO-RE offset relocs\n",
+			 sec_name, sec->num_info);
+
+		for_each_btf_ext_rec(seg, sec, i, rec) {
+			err = bpf_core_reloc_offset(prog, rec, i, obj->btf,
+						    targ_btf, cand_cache);
+			if (err) {
+				pr_warning("prog '%s': relo #%d: failed to relocate: %d\n",
+					   sec_name, i, err);
+				goto out;
+			}
+		}
+	}
+
+out:
+	btf__free(targ_btf);
+	if (!IS_ERR_OR_NULL(cand_cache)) {
+		hashmap__for_each_entry(cand_cache, entry, i) {
+			bpf_core_free_cands(entry->value);
+		}
+		hashmap__free(cand_cache);
+	}
+	return err;
+}
+
+static int
+bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
+{
+	int err = 0;
+
+	if (obj->btf_ext->offset_reloc_info.len)
+		err = bpf_core_reloc_offsets(obj, targ_btf_path);
+
+	return err;
+}
+
 static int
 bpf_program__reloc_text(struct bpf_program *prog, struct bpf_object *obj,
 			struct reloc_desc *relo)
@@ -2396,14 +3243,21 @@ bpf_program__relocate(struct bpf_program *prog, struct bpf_object *obj)
 	return 0;
 }
 
-
 static int
-bpf_object__relocate(struct bpf_object *obj)
+bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_path)
 {
 	struct bpf_program *prog;
 	size_t i;
 	int err;
 
+	if (obj->btf_ext) {
+		err = bpf_object__relocate_core(obj, targ_btf_path);
+		if (err) {
+			pr_warning("failed to perform CO-RE relocations: %d\n",
+				   err);
+			return err;
+		}
+	}
 	for (i = 0; i < obj->nr_programs; i++) {
 		prog = &obj->programs[i];
 
@@ -2804,7 +3658,7 @@ int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
 	obj->loaded = true;
 
 	CHECK_ERR(bpf_object__create_maps(obj), err, out);
-	CHECK_ERR(bpf_object__relocate(obj), err, out);
+	CHECK_ERR(bpf_object__relocate(obj, attr->target_btf_path), err, out);
 	CHECK_ERR(bpf_object__load_progs(obj, attr->log_level), err, out);
 
 	return 0;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 5cbf459ece0b..6004bfe1ebf0 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -92,6 +92,7 @@ LIBBPF_API void bpf_object__close(struct bpf_object *object);
 struct bpf_object_load_attr {
 	struct bpf_object *obj;
 	int log_level;
+	const char *target_btf_path;
 };
 
 /* Load/unload object into/from kernel */
-- 
2.17.1


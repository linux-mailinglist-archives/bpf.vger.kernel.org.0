Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8A040578D
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 15:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353333AbhIINhO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 09:37:14 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:43741 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347511AbhIINda (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 09:33:30 -0400
Received: by mail-ed1-f42.google.com with SMTP id n10so151611eda.10
        for <bpf@vger.kernel.org>; Thu, 09 Sep 2021 06:32:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Aq1xY0REUOEfnLCSBdWgf4NBuDgX1GcDdaCSCv/9Ojc=;
        b=2tGZm+9g8Q6GyHtfAG2h28uz37z3aNJyD2/W61CixTv719diLTWX2xefqYo+WGMNJt
         mBMrEL2fOHUbkYiFXLxEcmkNl7vkX7qO8VDxHnjlI6sGDCp18ulrJO1xMSYjOT4F8CYU
         wNpnx3oWpDIKzclbK2NMt2Z0ICNV4wjViQ8YKbWKPI7OMJacMkLQl+99tP1z/6xT2ZMC
         lIm1Y7+ed9vd0h8sPLFUZDW4s292BdfsL+YX7/51GJO9Vm9Gg9MwMENnoADl1MDFU/2w
         Q76obbD4SEuPkzkGvxdWr9fWqB5mlofa+9Lyne3S9FsRs3sH+IO/pw59iN/010YPfOvn
         Cltg==
X-Gm-Message-State: AOAM5300FNdTdPmxWA+61sdQlSl9gPsS/pVU3NmlsCH03hiajp2iojmd
        xXo2TdBVqyX5OwApgQzVEX223hugCmc=
X-Google-Smtp-Source: ABdhPJw2MXhwBlRk61kxU19tGBzqi3LFVwdGHSmNpjxdtse1OphbHFX0HSjtuxUSLKNCsqXTZevvLA==
X-Received: by 2002:a05:6402:27c6:: with SMTP id c6mr3221927ede.111.1631194339808;
        Thu, 09 Sep 2021 06:32:19 -0700 (PDT)
Received: from msft-t490s.. (mob-83-225-149-177.net.vodafone.it. [83.225.149.177])
        by smtp.gmail.com with ESMTPSA id am3sm959030ejc.74.2021.09.09.06.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 06:32:19 -0700 (PDT)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [RFC bpf 2/2] btf: adapt relo_core for kernel compilation
Date:   Thu,  9 Sep 2021 15:31:53 +0200
Message-Id: <20210909133153.48994-3-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210909133153.48994-1-mcroce@linux.microsoft.com>
References: <20210909133153.48994-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

Refactor kernel/bpf/relo_core.c so it builds in kernel contexxt.

- Replace lot of helpers used by the userspace code with the in-kernel
  equivalent (e.g. s/btf_is_composite/btf_type_is_struct/
  and s/btf_vlen/btf_type_vlen)
- Move some static helpers from btf.c to btf.h (e.g. btf_type_is_array)
- Port utility functions (e.g. str_is_empty)

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 include/linux/btf.h    |  65 ++++++++++
 kernel/bpf/btf.c       |  45 ++-----
 kernel/bpf/relo_core.c | 272 ++++++++++++++++++++++++++++++++---------
 3 files changed, 289 insertions(+), 93 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 214fde93214b..6c5bfbab9f23 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -123,6 +123,11 @@ const char *btf_type_str(const struct btf_type *t);
 	     i < btf_type_vlen(datasec_type);			\
 	     i++, member++)
 
+static inline __u16 btf_kind(const struct btf_type *t)
+{
+	return BTF_INFO_KIND(t->info);
+}
+
 static inline bool btf_type_is_ptr(const struct btf_type *t)
 {
 	return BTF_INFO_KIND(t->info) == BTF_KIND_PTR;
@@ -168,6 +173,34 @@ static inline bool btf_type_is_var(const struct btf_type *t)
 	return BTF_INFO_KIND(t->info) == BTF_KIND_VAR;
 }
 
+static inline bool btf_type_is_array(const struct btf_type *t)
+{
+	return BTF_INFO_KIND(t->info) == BTF_KIND_ARRAY;
+}
+
+static inline bool btf_type_is_modifier(const struct btf_type *t)
+{
+	/* Some of them is not strictly a C modifier
+	 * but they are grouped into the same bucket
+	 * for BTF concern:
+	 *   A type (t) that refers to another
+	 *   type through t->type AND its size cannot
+	 *   be determined without following the t->type.
+	 *
+	 * ptr does not fall into this bucket
+	 * because its size is always sizeof(void *).
+	 */
+	switch (BTF_INFO_KIND(t->info)) {
+	case BTF_KIND_TYPEDEF:
+	case BTF_KIND_VOLATILE:
+	case BTF_KIND_CONST:
+	case BTF_KIND_RESTRICT:
+		return true;
+	}
+
+	return false;
+}
+
 /* union is only a special case of struct:
  * all its offsetof(member) == 0
  */
@@ -207,6 +240,21 @@ static inline u32 btf_member_bitfield_size(const struct btf_type *struct_type,
 					   : 0;
 }
 
+static inline __u8 btf_member_int_offset(const struct btf_type *t)
+{
+	return BTF_INT_OFFSET(*(__u32 *)(t + 1));
+}
+
+static inline __u8 btf_int_encoding(const struct btf_type *t)
+{
+	return BTF_INT_ENCODING(*(__u32 *)(t + 1));
+}
+
+static inline struct btf_param *btf_type_params(const struct btf_type *t)
+{
+	return (struct btf_param *)(t + 1);
+}
+
 static inline const struct btf_member *btf_type_member(const struct btf_type *t)
 {
 	return (const struct btf_member *)(t + 1);
@@ -218,6 +266,23 @@ static inline const struct btf_var_secinfo *btf_type_var_secinfo(
 	return (const struct btf_var_secinfo *)(t + 1);
 }
 
+static inline const struct btf_enum *btf_type_enum(const struct btf_type *t)
+{
+	return (const struct btf_enum *)(t + 1);
+}
+
+static inline const struct btf_array *btf_type_array(const struct btf_type *t)
+{
+	return (const struct btf_array *)(t + 1);
+}
+
+static inline bool is_ldimm64_insn(struct bpf_insn *insn)
+{
+	return insn->code == (BPF_LD | BPF_IMM | BPF_DW);
+}
+
+const struct btf_type *btf__type_by_id(const struct btf *btf, __u32 type_id);
+
 #ifdef CONFIG_BPF_SYSCALL
 struct bpf_prog;
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index dfe61df4f974..d0c3a6c7fb2a 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -400,29 +400,6 @@ static struct btf_type btf_void;
 static int btf_resolve(struct btf_verifier_env *env,
 		       const struct btf_type *t, u32 type_id);
 
-static bool btf_type_is_modifier(const struct btf_type *t)
-{
-	/* Some of them is not strictly a C modifier
-	 * but they are grouped into the same bucket
-	 * for BTF concern:
-	 *   A type (t) that refers to another
-	 *   type through t->type AND its size cannot
-	 *   be determined without following the t->type.
-	 *
-	 * ptr does not fall into this bucket
-	 * because its size is always sizeof(void *).
-	 */
-	switch (BTF_INFO_KIND(t->info)) {
-	case BTF_KIND_TYPEDEF:
-	case BTF_KIND_VOLATILE:
-	case BTF_KIND_CONST:
-	case BTF_KIND_RESTRICT:
-		return true;
-	}
-
-	return false;
-}
-
 bool btf_type_is_void(const struct btf_type *t)
 {
 	return t == &btf_void;
@@ -449,11 +426,6 @@ static bool __btf_type_is_struct(const struct btf_type *t)
 	return BTF_INFO_KIND(t->info) == BTF_KIND_STRUCT;
 }
 
-static bool btf_type_is_array(const struct btf_type *t)
-{
-	return BTF_INFO_KIND(t->info) == BTF_KIND_ARRAY;
-}
-
 static bool btf_type_is_datasec(const struct btf_type *t)
 {
 	return BTF_INFO_KIND(t->info) == BTF_KIND_DATASEC;
@@ -601,16 +573,6 @@ static u32 btf_type_int(const struct btf_type *t)
 	return *(u32 *)(t + 1);
 }
 
-static const struct btf_array *btf_type_array(const struct btf_type *t)
-{
-	return (const struct btf_array *)(t + 1);
-}
-
-static const struct btf_enum *btf_type_enum(const struct btf_type *t)
-{
-	return (const struct btf_enum *)(t + 1);
-}
-
 static const struct btf_var *btf_type_var(const struct btf_type *t)
 {
 	return (const struct btf_var *)(t + 1);
@@ -6007,6 +5969,13 @@ bool btf_id_set_contains(const struct btf_id_set *set, u32 id)
 	return bsearch(&id, set->ids, set->cnt, sizeof(u32), btf_id_cmp_func) != NULL;
 }
 
+const struct btf_type *btf__type_by_id(const struct btf *btf, __u32 type_id)
+{
+	if (type_id >= btf->start_id + btf->nr_types)
+		return NULL;
+	return btf_type_by_id((struct btf *)btf, type_id);
+}
+
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 struct btf_module {
 	struct list_head list;
diff --git a/kernel/bpf/relo_core.c b/kernel/bpf/relo_core.c
index 4016ed492d0c..c15a627d9131 100644
--- a/kernel/bpf/relo_core.c
+++ b/kernel/bpf/relo_core.c
@@ -1,17 +1,11 @@
 // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 /* Copyright (c) 2019 Facebook */
 
-#include <stdio.h>
-#include <string.h>
-#include <errno.h>
-#include <ctype.h>
-#include <linux/err.h>
-
-#include "libbpf.h"
-#include "bpf.h"
-#include "btf.h"
-#include "str_error.h"
-#include "libbpf_internal.h"
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <uapi/linux/btf.h>
+
+#include "relo_core.h"
 
 #define BPF_CORE_SPEC_MAX_LEN 64
 
@@ -40,6 +34,50 @@ struct bpf_core_spec {
 	__u32 bit_offset;
 };
 
+enum libbpf_print_level {
+	LIBBPF_WARN,
+	LIBBPF_INFO,
+	LIBBPF_DEBUG,
+};
+
+#define libbpf_print(lvl, fmt...)	do {		\
+		if (lvl == LIBBPF_WARN) {		\
+			pr_warn(fmt);			\
+		} else if (lvl == LIBBPF_INFO) {	\
+			pr_info(fmt);			\
+		} else if (lvl == LIBBPF_DEBUG) { 	\
+			pr_debug(fmt);			\
+		} 					\
+		} while (0)
+
+static bool str_is_empty(const char *s)
+{
+	return !s || !s[0];
+}
+
+static bool bpf_core_is_flavor_sep(const char *s)
+{
+	/* check X___Y name pattern, where X and Y are not underscores */
+	return s[0] != '_' &&				      /* X */
+	       s[1] == '_' && s[2] == '_' && s[3] == '_' &&   /* ___ */
+	       s[4] != '_';				      /* Y */
+}
+
+/* Given 'some_struct_name___with_flavor' return the length of a name prefix
+ * before last triple underscore. Struct name part after last triple
+ * underscore is ignored by BPF CO-RE relocation during relocation matching.
+ */
+size_t bpf_core_essential_name_len(const char *name)
+{
+	size_t n = strlen(name);
+	int i;
+
+	for (i = n - 5; i >= 0; i--) {
+		if (bpf_core_is_flavor_sep(name + i))
+			return i + 1;
+	}
+	return n;
+}
 static bool is_flex_arr(const struct btf *btf,
 			const struct bpf_core_accessor *acc,
 			const struct btf_array *arr)
@@ -52,7 +90,20 @@ static bool is_flex_arr(const struct btf *btf,
 
 	/* has to be the last member of enclosing struct */
 	t = btf__type_by_id(btf, acc->type_id);
-	return acc->idx == btf_vlen(t) - 1;
+	return acc->idx == btf_type_vlen(t) - 1;
+}
+
+static __s64 btf__resolve_size(const struct btf *btf, __u32 type_id)
+{
+	const struct btf_type *t = btf__type_by_id(btf, type_id);
+	const struct btf_type *ret;
+	__u32 type_size;
+
+	ret = btf_resolve_size(btf, t, &type_size);
+	if (IS_ERR(ret))
+		return PTR_ERR(ret);
+
+	return type_size;
 }
 
 static const char *core_relo_kind_str(enum bpf_core_relo_kind kind)
@@ -113,6 +164,117 @@ static bool core_relo_is_enumval_based(enum bpf_core_relo_kind kind)
 	}
 }
 
+const struct btf_type *
+skip_mods_and_typedefs(const struct btf *btf, __u32 id, __u32 *res_id)
+{
+	const struct btf_type *t = btf__type_by_id(btf, id);
+
+	if (res_id)
+		*res_id = id;
+
+	while (btf_type_is_modifier(t) || btf_type_is_typedef(t)) {
+		if (res_id)
+			*res_id = t->type;
+		t = btf__type_by_id(btf, t->type);
+	}
+
+	return t;
+}
+
+/* Check local and target types for compatibility. This check is used for
+ * type-based CO-RE relocations and follow slightly different rules than
+ * field-based relocations. This function assumes that root types were already
+ * checked for name match. Beyond that initial root-level name check, names
+ * are completely ignored. Compatibility rules are as follows:
+ *   - any two STRUCTs/UNIONs/FWDs/ENUMs/INTs are considered compatible, but
+ *     kind should match for local and target types (i.e., STRUCT is not
+ *     compatible with UNION);
+ *   - for ENUMs, the size is ignored;
+ *   - for INT, size and signedness are ignored;
+ *   - for ARRAY, dimensionality is ignored, element types are checked for
+ *     compatibility recursively;
+ *   - CONST/VOLATILE/RESTRICT modifiers are ignored;
+ *   - TYPEDEFs/PTRs are compatible if types they pointing to are compatible;
+ *   - FUNC_PROTOs are compatible if they have compatible signature: same
+ *     number of input args and compatible return and argument types.
+ * These rules are not set in stone and probably will be adjusted as we get
+ * more experience with using BPF CO-RE relocations.
+ */
+int bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
+			      const struct btf *targ_btf, __u32 targ_id)
+{
+	const struct btf_type *local_type, *targ_type;
+	int depth = 32; /* max recursion depth */
+
+	/* caller made sure that names match (ignoring flavor suffix) */
+	local_type = btf__type_by_id(local_btf, local_id);
+	targ_type = btf__type_by_id(targ_btf, targ_id);
+	if (btf_kind(local_type) != btf_kind(targ_type))
+		return 0;
+
+recur:
+	depth--;
+	if (depth < 0)
+		return -EINVAL;
+
+	local_type = skip_mods_and_typedefs(local_btf, local_id, &local_id);
+	targ_type = skip_mods_and_typedefs(targ_btf, targ_id, &targ_id);
+	if (!local_type || !targ_type)
+		return -EINVAL;
+
+	if (btf_kind(local_type) != btf_kind(targ_type))
+		return 0;
+
+	switch (btf_kind(local_type)) {
+	case BTF_KIND_UNKN:
+	case BTF_KIND_STRUCT:
+	case BTF_KIND_UNION:
+	case BTF_KIND_ENUM:
+	case BTF_KIND_FWD:
+		return 1;
+	case BTF_KIND_INT:
+		/* just reject deprecated bitfield-like integers; all other
+		 * integers are by default compatible between each other
+		 */
+		return btf_member_int_offset(local_type) == 0 && btf_member_int_offset(targ_type) == 0;
+	case BTF_KIND_PTR:
+		local_id = local_type->type;
+		targ_id = targ_type->type;
+		goto recur;
+	case BTF_KIND_ARRAY:
+		local_id = btf_type_array(local_type)->type;
+		targ_id = btf_type_array(targ_type)->type;
+		goto recur;
+	case BTF_KIND_FUNC_PROTO: {
+		struct btf_param *local_p = btf_type_params(local_type);
+		struct btf_param *targ_p = btf_type_params(targ_type);
+		__u16 local_vlen = btf_type_vlen(local_type);
+		__u16 targ_vlen = btf_type_vlen(targ_type);
+		int i, err;
+
+		if (local_vlen != targ_vlen)
+			return 0;
+
+		for (i = 0; i < local_vlen; i++, local_p++, targ_p++) {
+			skip_mods_and_typedefs(local_btf, local_p->type, &local_id);
+			skip_mods_and_typedefs(targ_btf, targ_p->type, &targ_id);
+			err = bpf_core_types_are_compat(local_btf, local_id, targ_btf, targ_id);
+			if (err <= 0)
+				return err;
+		}
+
+		/* tail recurse for return type check */
+		skip_mods_and_typedefs(local_btf, local_type->type, &local_id);
+		skip_mods_and_typedefs(targ_btf, targ_type->type, &targ_id);
+		goto recur;
+	}
+	default:
+		pr_warn("unexpected kind %s relocated, local [%d], target [%d]\n",
+			btf_type_str(local_type), local_id, targ_id);
+		return 0;
+	}
+}
+
 /*
  * Turn bpf_core_relo into a low- and high-level spec representation,
  * validating correctness along the way, as well as calculating resulting
@@ -204,11 +366,11 @@ static int bpf_core_parse_spec(const struct btf *btf,
 	spec->len++;
 
 	if (core_relo_is_enumval_based(relo_kind)) {
-		if (!btf_is_enum(t) || spec->raw_len > 1 || access_idx >= btf_vlen(t))
+		if (!btf_type_is_enum(t) || spec->raw_len > 1 || access_idx >= btf_type_vlen(t))
 			return -EINVAL;
 
 		/* record enumerator name in a first accessor */
-		acc->name = btf__name_by_offset(btf, btf_enum(t)[access_idx].name_off);
+		acc->name = btf_name_by_offset(btf, btf_type_enum(t)[access_idx].name_off);
 		return 0;
 	}
 
@@ -228,19 +390,19 @@ static int bpf_core_parse_spec(const struct btf *btf,
 		access_idx = spec->raw_spec[i];
 		acc = &spec->spec[spec->len];
 
-		if (btf_is_composite(t)) {
+		if (btf_type_is_struct(t)) {
 			const struct btf_member *m;
 			__u32 bit_offset;
 
-			if (access_idx >= btf_vlen(t))
+			if (access_idx >= btf_type_vlen(t))
 				return -EINVAL;
 
-			bit_offset = btf_member_bit_offset(t, access_idx);
+			bit_offset = btf_member_bit_offset(t, btf_type_member(t) + access_idx);
 			spec->bit_offset += bit_offset;
 
-			m = btf_members(t) + access_idx;
+			m = btf_type_member(t) + access_idx;
 			if (m->name_off) {
-				name = btf__name_by_offset(btf, m->name_off);
+				name = btf_name_by_offset(btf, m->name_off);
 				if (str_is_empty(name))
 					return -EINVAL;
 
@@ -251,8 +413,8 @@ static int bpf_core_parse_spec(const struct btf *btf,
 			}
 
 			id = m->type;
-		} else if (btf_is_array(t)) {
-			const struct btf_array *a = btf_array(t);
+		} else if (btf_type_is_array(t)) {
+			const struct btf_array *a = btf_type_array(t);
 			bool flex;
 
 			t = skip_mods_and_typedefs(btf, a->type, &id);
@@ -273,7 +435,7 @@ static int bpf_core_parse_spec(const struct btf *btf,
 			spec->bit_offset += access_idx * sz * 8;
 		} else {
 			pr_warn("relo for [%u] %s (at idx %d) captures type [%d] of unexpected kind %s\n",
-				type_id, spec_str, i, id, btf_kind_str(t));
+				type_id, spec_str, i, id, btf_type_str(t));
 			return -EINVAL;
 		}
 	}
@@ -311,7 +473,7 @@ static int bpf_core_fields_are_compat(const struct btf *local_btf,
 	if (!local_type || !targ_type)
 		return -EINVAL;
 
-	if (btf_is_composite(local_type) && btf_is_composite(targ_type))
+	if (btf_type_is_struct(local_type) && btf_type_is_struct(targ_type))
 		return 1;
 	if (btf_kind(local_type) != btf_kind(targ_type))
 		return 0;
@@ -325,9 +487,9 @@ static int bpf_core_fields_are_compat(const struct btf *local_btf,
 		const char *local_name, *targ_name;
 		size_t local_len, targ_len;
 
-		local_name = btf__name_by_offset(local_btf,
+		local_name = btf_name_by_offset(local_btf,
 						 local_type->name_off);
-		targ_name = btf__name_by_offset(targ_btf, targ_type->name_off);
+		targ_name = btf_name_by_offset(targ_btf, targ_type->name_off);
 		local_len = bpf_core_essential_name_len(local_name);
 		targ_len = bpf_core_essential_name_len(targ_name);
 		/* one of them is anonymous or both w/ same flavor-less names */
@@ -339,11 +501,11 @@ static int bpf_core_fields_are_compat(const struct btf *local_btf,
 		/* just reject deprecated bitfield-like integers; all other
 		 * integers are by default compatible between each other
 		 */
-		return btf_int_offset(local_type) == 0 &&
-		       btf_int_offset(targ_type) == 0;
+		return btf_member_int_offset(local_type) == 0 &&
+		       btf_member_int_offset(targ_type) == 0;
 	case BTF_KIND_ARRAY:
-		local_id = btf_array(local_type)->type;
-		targ_id = btf_array(targ_type)->type;
+		local_id = btf_type_array(local_type)->type;
+		targ_id = btf_type_array(targ_type)->type;
 		goto recur;
 	default:
 		pr_warn("unexpected kind %d relocated, local [%d], target [%d]\n",
@@ -384,20 +546,20 @@ static int bpf_core_match_member(const struct btf *local_btf,
 	targ_type = skip_mods_and_typedefs(targ_btf, targ_id, &targ_id);
 	if (!targ_type)
 		return -EINVAL;
-	if (!btf_is_composite(targ_type))
+	if (!btf_type_is_struct(targ_type))
 		return 0;
 
 	local_id = local_acc->type_id;
 	local_type = btf__type_by_id(local_btf, local_id);
-	local_member = btf_members(local_type) + local_acc->idx;
-	local_name = btf__name_by_offset(local_btf, local_member->name_off);
+	local_member = btf_type_member(local_type) + local_acc->idx;
+	local_name = btf_name_by_offset(local_btf, local_member->name_off);
 
-	n = btf_vlen(targ_type);
-	m = btf_members(targ_type);
+	n = btf_type_vlen(targ_type);
+	m = btf_type_member(targ_type);
 	for (i = 0; i < n; i++, m++) {
 		__u32 bit_offset;
 
-		bit_offset = btf_member_bit_offset(targ_type, i);
+		bit_offset = btf_member_bit_offset(targ_type, btf_type_member(targ_type) + i);
 
 		/* too deep struct/union/array nesting */
 		if (spec->raw_len == BPF_CORE_SPEC_MAX_LEN)
@@ -407,7 +569,7 @@ static int bpf_core_match_member(const struct btf *local_btf,
 		spec->bit_offset += bit_offset;
 		spec->raw_spec[spec->raw_len++] = i;
 
-		targ_name = btf__name_by_offset(targ_btf, m->name_off);
+		targ_name = btf_name_by_offset(targ_btf, m->name_off);
 		if (str_is_empty(targ_name)) {
 			/* embedded struct/union, we need to go deeper */
 			found = bpf_core_match_member(local_btf, local_acc,
@@ -474,13 +636,13 @@ static int bpf_core_spec_match(struct bpf_core_spec *local_spec,
 
 		/* has to resolve to an enum */
 		targ_type = skip_mods_and_typedefs(targ_spec->btf, targ_id, &targ_id);
-		if (!btf_is_enum(targ_type))
+		if (!btf_type_is_enum(targ_type))
 			return 0;
 
 		local_essent_len = bpf_core_essential_name_len(local_acc->name);
 
-		for (i = 0, e = btf_enum(targ_type); i < btf_vlen(targ_type); i++, e++) {
-			targ_name = btf__name_by_offset(targ_spec->btf, e->name_off);
+		for (i = 0, e = btf_type_enum(targ_type); i < btf_type_vlen(targ_type); i++, e++) {
+			targ_name = btf_name_by_offset(targ_spec->btf, e->name_off);
 			targ_essent_len = bpf_core_essential_name_len(targ_name);
 			if (targ_essent_len != local_essent_len)
 				continue;
@@ -522,10 +684,10 @@ static int bpf_core_spec_match(struct bpf_core_spec *local_spec,
 				const struct btf_array *a;
 				bool flex;
 
-				if (!btf_is_array(targ_type))
+				if (!btf_type_is_array(targ_type))
 					return 0;
 
-				a = btf_array(targ_type);
+				a = btf_type_array(targ_type);
 				flex = is_flex_arr(targ_btf, targ_acc - 1, a);
 				if (!flex && local_acc->idx >= a->nelems)
 					return 0;
@@ -607,10 +769,10 @@ static int bpf_core_calc_field_relo(const char *prog_name,
 		return 0;
 	}
 
-	m = btf_members(t) + acc->idx;
+	m = btf_type_member(t) + acc->idx;
 	mt = skip_mods_and_typedefs(spec->btf, m->type, &field_type_id);
 	bit_off = spec->bit_offset;
-	bit_sz = btf_member_bitfield_size(t, acc->idx);
+	bit_sz = btf_member_bitfield_size(t, btf_type_member(t) + acc->idx);
 
 	bitfield = bit_sz > 0;
 	if (bitfield) {
@@ -656,13 +818,13 @@ static int bpf_core_calc_field_relo(const char *prog_name,
 		break;
 	case BPF_FIELD_SIGNED:
 		/* enums will be assumed unsigned */
-		*val = btf_is_enum(mt) ||
+		*val = btf_type_is_enum(mt) ||
 		       (btf_int_encoding(mt) & BTF_INT_SIGNED);
 		if (validate)
 			*validate = true; /* signedness is never ambiguous */
 		break;
 	case BPF_FIELD_LSHIFT_U64:
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#ifdef __LITTLE_ENDIAN
 		*val = 64 - (bit_off + bit_sz - byte_off  * 8);
 #else
 		*val = (8 - byte_sz) * 8 + (bit_off - byte_off * 8);
@@ -730,7 +892,7 @@ static int bpf_core_calc_enumval_relo(const struct bpf_core_relo *relo,
 		if (!spec)
 			return -EUCLEAN; /* request instruction poisoning */
 		t = btf__type_by_id(spec->btf, spec->spec[0].type_id);
-		e = btf_enum(t) + spec->spec[0].idx;
+		e = btf_type_enum(t) + spec->spec[0].idx;
 		*val = e->val;
 		break;
 	default:
@@ -822,9 +984,9 @@ static int bpf_core_calc_relo(const char *prog_name,
 			 * load/store field because read value will be
 			 * incorrect, so we poison relocated instruction.
 			 */
-			if (btf_is_ptr(orig_t) && btf_is_ptr(new_t))
+			if (btf_type_is_ptr(orig_t) && btf_type_is_ptr(new_t))
 				goto done;
-			if (btf_is_int(orig_t) && btf_is_int(new_t) &&
+			if (btf_type_is_int(orig_t) && btf_type_is_int(new_t) &&
 			    btf_int_encoding(orig_t) != BTF_INT_SIGNED &&
 			    btf_int_encoding(new_t) != BTF_INT_SIGNED)
 				goto done;
@@ -1055,17 +1217,17 @@ static void bpf_core_dump_spec(int level, const struct bpf_core_spec *spec)
 
 	type_id = spec->root_type_id;
 	t = btf__type_by_id(spec->btf, type_id);
-	s = btf__name_by_offset(spec->btf, t->name_off);
+	s = btf_name_by_offset(spec->btf, t->name_off);
 
-	libbpf_print(level, "[%u] %s %s", type_id, btf_kind_str(t), str_is_empty(s) ? "<anon>" : s);
+	libbpf_print(level, "[%u] %s %s", type_id, btf_type_str(t), str_is_empty(s) ? "<anon>" : s);
 
 	if (core_relo_is_type_based(spec->relo_kind))
 		return;
 
 	if (core_relo_is_enumval_based(spec->relo_kind)) {
 		t = skip_mods_and_typedefs(spec->btf, type_id, NULL);
-		e = btf_enum(t) + spec->raw_spec[0];
-		s = btf__name_by_offset(spec->btf, e->name_off);
+		e = btf_type_enum(t) + spec->raw_spec[0];
+		s = btf_name_by_offset(spec->btf, e->name_off);
 
 		libbpf_print(level, "::%s = %u", s, e->val);
 		return;
@@ -1162,18 +1324,18 @@ int bpf_core_apply_relo_insn(const char *prog_name, struct bpf_insn *insn,
 	if (!local_type)
 		return -EINVAL;
 
-	local_name = btf__name_by_offset(local_btf, local_type->name_off);
+	local_name = btf_name_by_offset(local_btf, local_type->name_off);
 	if (!local_name)
 		return -EINVAL;
 
-	spec_str = btf__name_by_offset(local_btf, relo->access_str_off);
+	spec_str = btf_name_by_offset(local_btf, relo->access_str_off);
 	if (str_is_empty(spec_str))
 		return -EINVAL;
 
 	err = bpf_core_parse_spec(local_btf, local_id, spec_str, relo->kind, &local_spec);
 	if (err) {
 		pr_warn("prog '%s': relo #%d: parsing [%d] %s %s + %s failed: %d\n",
-			prog_name, relo_idx, local_id, btf_kind_str(local_type),
+			prog_name, relo_idx, local_id, btf_type_str(local_type),
 			str_is_empty(local_name) ? "<anon>" : local_name,
 			spec_str, err);
 		return -EINVAL;
-- 
2.31.1


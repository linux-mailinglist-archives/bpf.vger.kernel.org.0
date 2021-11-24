Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E262A45B41B
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 07:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbhKXGFa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Nov 2021 01:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbhKXGFa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Nov 2021 01:05:30 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B43C061574
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 22:02:21 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so1640683pjb.1
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 22:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=47UpfwK0PMVJN253RoPR3lXOYWYN7tiiwPem+P8ZxD8=;
        b=aupJWV6DQxUh8tg/ESpGvR4iY4owYDu6brRvtU8Ai4gkLNQi9BPxoIJ9vSptx9scrf
         ha3F6toHejQDtEEOAf10HfQX0cjur5QxppoVooIyLUiBy6uts7NBoJ7rbCWcoJoNbbKO
         JP0Ak+rgG5CEG42ypwKb9GWcJLD/aWKGcYIpZNbB656OrPxUMS08t4zLQ6+ZuVU+z9KI
         YV2Ht5n0VpmmPXlDQ46rRGWrVI2aNTtSqGthOnQUT8Ryir4qllyWu0O0P23/KiQ6VHgP
         vgOlnljG3v8kXUSyU9946/sAdU46q9UksRDVWA93QdWPXDpkntx17kCgSJU0/djhs4JR
         VQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=47UpfwK0PMVJN253RoPR3lXOYWYN7tiiwPem+P8ZxD8=;
        b=tZeosC1FfgUjrXgsU1usK01FJugvOmkwcAMtGfS3VrNTts7D3RE1ULiv5Bp9Yz4Yd5
         j8uqARXGhb6HaxfE4FZyFTer5iEONYa6RyEgp5MclAH6Cjs9CshASDIgGfj0m3sOUbkX
         SjtEXDbonnLBVduPRNl8rwSZnMmfA6ev6lrZkudPC2xsRmSkQ0cUKNuEQnlzbMGKv/vu
         T6uJo992VfFVGhvDS+/1Jle7FlmyVsWDOd2i6AmtaKwE6LapYtPFYRyiWTKu6gBqTb5f
         mub8VSd/y8eqXl5bNBHwMvRheREfbMMbgOL88KHmI4FAeI9SuMZdOhALSsVxHoHPMaBf
         GYXw==
X-Gm-Message-State: AOAM533Z7R8h6tggKqXFLduT4eZwdOTMO5PA3+ILHacpV498fR8kiLlo
        M7A1JtTvTeDrZ2dC8A8sqCc=
X-Google-Smtp-Source: ABdhPJwQeth8dHxhVz2gKQLsq4bHiUKe4yXjsyNxBPUtOUEkxsdlomnswUuY0Z5MuguwzgQ5hUdWYA==
X-Received: by 2002:a17:902:d2c1:b0:141:f710:922 with SMTP id n1-20020a170902d2c100b00141f7100922mr15483317plc.7.1637733740781;
        Tue, 23 Nov 2021 22:02:20 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:8fd1])
        by smtp.gmail.com with ESMTPSA id y190sm14898153pfg.153.2021.11.23.22.02.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Nov 2021 22:02:20 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v4 bpf-next 03/16] bpf: Prepare relo_core.c for kernel duty.
Date:   Tue, 23 Nov 2021 22:01:56 -0800
Message-Id: <20211124060209.493-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211124060209.493-1-alexei.starovoitov@gmail.com>
References: <20211124060209.493-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Make relo_core.c to be compiled for the kernel and for user space libbpf.

Note the patch is reducing BPF_CORE_SPEC_MAX_LEN from 64 to 32.
This is the maximum number of nested structs and arrays.
For example:
 struct sample {
     int a;
     struct {
         int b[10];
     };
 };

 struct sample *s = ...;
 int *y = &s->b[5];
This field access is encoded as "0:1:0:5" and spec len is 4.

The follow up patch might bump it back to 64.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/btf.h       | 81 +++++++++++++++++++++++++++++++++++++++
 kernel/bpf/Makefile       |  4 ++
 kernel/bpf/btf.c          | 26 +++++++++++++
 tools/lib/bpf/relo_core.c | 76 ++++++++++++++++++++++++++++++------
 4 files changed, 176 insertions(+), 11 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 956f70388f69..acef6ef28768 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -144,6 +144,53 @@ static inline bool btf_type_is_enum(const struct btf_type *t)
 	return BTF_INFO_KIND(t->info) == BTF_KIND_ENUM;
 }
 
+static inline bool str_is_empty(const char *s)
+{
+	return !s || !s[0];
+}
+
+static inline u16 btf_kind(const struct btf_type *t)
+{
+	return BTF_INFO_KIND(t->info);
+}
+
+static inline bool btf_is_enum(const struct btf_type *t)
+{
+	return btf_kind(t) == BTF_KIND_ENUM;
+}
+
+static inline bool btf_is_composite(const struct btf_type *t)
+{
+	u16 kind = btf_kind(t);
+
+	return kind == BTF_KIND_STRUCT || kind == BTF_KIND_UNION;
+}
+
+static inline bool btf_is_array(const struct btf_type *t)
+{
+	return btf_kind(t) == BTF_KIND_ARRAY;
+}
+
+static inline bool btf_is_int(const struct btf_type *t)
+{
+	return btf_kind(t) == BTF_KIND_INT;
+}
+
+static inline bool btf_is_ptr(const struct btf_type *t)
+{
+	return btf_kind(t) == BTF_KIND_PTR;
+}
+
+static inline u8 btf_int_offset(const struct btf_type *t)
+{
+	return BTF_INT_OFFSET(*(u32 *)(t + 1));
+}
+
+static inline u8 btf_int_encoding(const struct btf_type *t)
+{
+	return BTF_INT_ENCODING(*(u32 *)(t + 1));
+}
+
 static inline bool btf_type_is_scalar(const struct btf_type *t)
 {
 	return btf_type_is_int(t) || btf_type_is_enum(t);
@@ -184,6 +231,11 @@ static inline u16 btf_type_vlen(const struct btf_type *t)
 	return BTF_INFO_VLEN(t->info);
 }
 
+static inline u16 btf_vlen(const struct btf_type *t)
+{
+	return btf_type_vlen(t);
+}
+
 static inline u16 btf_func_linkage(const struct btf_type *t)
 {
 	return BTF_INFO_VLEN(t->info);
@@ -208,11 +260,40 @@ static inline u32 __btf_member_bitfield_size(const struct btf_type *struct_type,
 					   : 0;
 }
 
+static inline struct btf_member *btf_members(const struct btf_type *t)
+{
+	return (struct btf_member *)(t + 1);
+}
+
+static inline u32 btf_member_bit_offset(const struct btf_type *t, u32 member_idx)
+{
+	const struct btf_member *m = btf_members(t) + member_idx;
+
+	return __btf_member_bit_offset(t, m);
+}
+
+static inline u32 btf_member_bitfield_size(const struct btf_type *t, u32 member_idx)
+{
+	const struct btf_member *m = btf_members(t) + member_idx;
+
+	return __btf_member_bitfield_size(t, m);
+}
+
 static inline const struct btf_member *btf_type_member(const struct btf_type *t)
 {
 	return (const struct btf_member *)(t + 1);
 }
 
+static inline struct btf_array *btf_array(const struct btf_type *t)
+{
+	return (struct btf_array *)(t + 1);
+}
+
+static inline struct btf_enum *btf_enum(const struct btf_type *t)
+{
+	return (struct btf_enum *)(t + 1);
+}
+
 static inline const struct btf_var_secinfo *btf_type_var_secinfo(
 		const struct btf_type *t)
 {
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index cf6ca339f3cd..c1a9be6a4b9f 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -36,3 +36,7 @@ obj-$(CONFIG_BPF_SYSCALL) += bpf_struct_ops.o
 obj-${CONFIG_BPF_LSM} += bpf_lsm.o
 endif
 obj-$(CONFIG_BPF_PRELOAD) += preload/
+
+obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
+$(obj)/relo_core.o: $(srctree)/tools/lib/bpf/relo_core.c FORCE
+	$(call if_changed_rule,cc_o_c)
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index f4119a99da7b..c79595aad55b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6413,3 +6413,29 @@ bool bpf_check_mod_kfunc_call(struct kfunc_btf_id_list *klist, u32 kfunc_id,
 
 DEFINE_KFUNC_BTF_ID_LIST(bpf_tcp_ca_kfunc_list);
 DEFINE_KFUNC_BTF_ID_LIST(prog_test_kfunc_list);
+
+int bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
+			      const struct btf *targ_btf, __u32 targ_id)
+{
+	return -EOPNOTSUPP;
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
diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index c0904f4cb514..56dbe6d16664 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -1,6 +1,60 @@
 // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 /* Copyright (c) 2019 Facebook */
 
+#ifdef __KERNEL__
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/string.h>
+#include <linux/bpf_verifier.h>
+#include "relo_core.h"
+
+static const char *btf_kind_str(const struct btf_type *t)
+{
+	return btf_type_str(t);
+}
+
+static bool is_ldimm64_insn(struct bpf_insn *insn)
+{
+	return insn->code == (BPF_LD | BPF_IMM | BPF_DW);
+}
+
+static const struct btf_type *
+skip_mods_and_typedefs(const struct btf *btf, u32 id, u32 *res_id)
+{
+	return btf_type_skip_modifiers(btf, id, res_id);
+}
+
+static const char *btf__name_by_offset(const struct btf *btf, u32 offset)
+{
+	return btf_name_by_offset(btf, offset);
+}
+
+static s64 btf__resolve_size(const struct btf *btf, u32 type_id)
+{
+	const struct btf_type *t;
+	int size;
+
+	t = btf_type_by_id(btf, type_id);
+	t = btf_resolve_size(btf, t, &size);
+	if (IS_ERR(t))
+		return PTR_ERR(t);
+	return size;
+}
+
+enum libbpf_print_level {
+	LIBBPF_WARN,
+	LIBBPF_INFO,
+	LIBBPF_DEBUG,
+};
+
+#undef pr_warn
+#undef pr_info
+#undef pr_debug
+#define pr_warn(fmt, log, ...)	bpf_log((void *)log, fmt, "", ##__VA_ARGS__)
+#define pr_info(fmt, log, ...)	bpf_log((void *)log, fmt, "", ##__VA_ARGS__)
+#define pr_debug(fmt, log, ...)	bpf_log((void *)log, fmt, "", ##__VA_ARGS__)
+#define libbpf_print(level, fmt, ...)	bpf_log((void *)prog_name, fmt, ##__VA_ARGS__)
+#else
 #include <stdio.h>
 #include <string.h>
 #include <errno.h>
@@ -12,8 +66,9 @@
 #include "btf.h"
 #include "str_error.h"
 #include "libbpf_internal.h"
+#endif
 
-#define BPF_CORE_SPEC_MAX_LEN 64
+#define BPF_CORE_SPEC_MAX_LEN 32
 
 /* represents BPF CO-RE field or array element accessor */
 struct bpf_core_accessor {
@@ -150,7 +205,7 @@ static bool core_relo_is_enumval_based(enum bpf_core_relo_kind kind)
  * Enum value-based relocations (ENUMVAL_EXISTS/ENUMVAL_VALUE) use access
  * string to specify enumerator's value index that need to be relocated.
  */
-static int bpf_core_parse_spec(const struct btf *btf,
+static int bpf_core_parse_spec(const char *prog_name, const struct btf *btf,
 			       __u32 type_id,
 			       const char *spec_str,
 			       enum bpf_core_relo_kind relo_kind,
@@ -272,8 +327,8 @@ static int bpf_core_parse_spec(const struct btf *btf,
 				return sz;
 			spec->bit_offset += access_idx * sz * 8;
 		} else {
-			pr_warn("relo for [%u] %s (at idx %d) captures type [%d] of unexpected kind %s\n",
-				type_id, spec_str, i, id, btf_kind_str(t));
+			pr_warn("prog '%s': relo for [%u] %s (at idx %d) captures type [%d] of unexpected kind %s\n",
+				prog_name, type_id, spec_str, i, id, btf_kind_str(t));
 			return -EINVAL;
 		}
 	}
@@ -346,8 +401,6 @@ static int bpf_core_fields_are_compat(const struct btf *local_btf,
 		targ_id = btf_array(targ_type)->type;
 		goto recur;
 	default:
-		pr_warn("unexpected kind %d relocated, local [%d], target [%d]\n",
-			btf_kind(local_type), local_id, targ_id);
 		return 0;
 	}
 }
@@ -1045,7 +1098,7 @@ static int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
  * [<type-id>] (<type-name>) + <raw-spec> => <offset>@<spec>,
  * where <spec> is a C-syntax view of recorded field access, e.g.: x.a[3].b
  */
-static void bpf_core_dump_spec(int level, const struct bpf_core_spec *spec)
+static void bpf_core_dump_spec(const char *prog_name, int level, const struct bpf_core_spec *spec)
 {
 	const struct btf_type *t;
 	const struct btf_enum *e;
@@ -1167,7 +1220,8 @@ int bpf_core_apply_relo_insn(const char *prog_name, struct bpf_insn *insn,
 	if (str_is_empty(spec_str))
 		return -EINVAL;
 
-	err = bpf_core_parse_spec(local_btf, local_id, spec_str, relo->kind, &local_spec);
+	err = bpf_core_parse_spec(prog_name, local_btf, local_id, spec_str,
+				  relo->kind, &local_spec);
 	if (err) {
 		pr_warn("prog '%s': relo #%d: parsing [%d] %s %s + %s failed: %d\n",
 			prog_name, relo_idx, local_id, btf_kind_str(local_type),
@@ -1178,7 +1232,7 @@ int bpf_core_apply_relo_insn(const char *prog_name, struct bpf_insn *insn,
 
 	pr_debug("prog '%s': relo #%d: kind <%s> (%d), spec is ", prog_name,
 		 relo_idx, core_relo_kind_str(relo->kind), relo->kind);
-	bpf_core_dump_spec(LIBBPF_DEBUG, &local_spec);
+	bpf_core_dump_spec(prog_name, LIBBPF_DEBUG, &local_spec);
 	libbpf_print(LIBBPF_DEBUG, "\n");
 
 	/* TYPE_ID_LOCAL relo is special and doesn't need candidate search */
@@ -1204,14 +1258,14 @@ int bpf_core_apply_relo_insn(const char *prog_name, struct bpf_insn *insn,
 		if (err < 0) {
 			pr_warn("prog '%s': relo #%d: error matching candidate #%d ",
 				prog_name, relo_idx, i);
-			bpf_core_dump_spec(LIBBPF_WARN, &cand_spec);
+			bpf_core_dump_spec(prog_name, LIBBPF_WARN, &cand_spec);
 			libbpf_print(LIBBPF_WARN, ": %d\n", err);
 			return err;
 		}
 
 		pr_debug("prog '%s': relo #%d: %s candidate #%d ", prog_name,
 			 relo_idx, err == 0 ? "non-matching" : "matching", i);
-		bpf_core_dump_spec(LIBBPF_DEBUG, &cand_spec);
+		bpf_core_dump_spec(prog_name, LIBBPF_DEBUG, &cand_spec);
 		libbpf_print(LIBBPF_DEBUG, "\n");
 
 		if (err == 0)
-- 
2.30.2


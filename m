Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8DF405CD7
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 20:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241213AbhIISYP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 14:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237172AbhIISYO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 14:24:14 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DCCC061574
        for <bpf@vger.kernel.org>; Thu,  9 Sep 2021 11:23:05 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id g184so2663474pgc.6
        for <bpf@vger.kernel.org>; Thu, 09 Sep 2021 11:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qNn4G8cvzJvLHz8cH6kihKqYYetWlzBm/2GQUQSOwPI=;
        b=XSRXcD4m995NaHEzO06hoU+GG9P7N2CihBogpT2d6h0DPJwkd4+GXWEwAeGGlXqKw+
         0X3BFbqAlU5vyjT90QXEPQP3yi/dybznG0N2UffQo59LL249Nu09N/aH5Ehw2tVNgLF/
         GqB3dmtUEKJ0TFGxdqf1kKZfPW2t89mKH0ADoAHCkilK/oXibQgZyeuMFOJa247/Tg+n
         r6YwGlOm3s1kB3YCm2935w9XJpkVNqaUJuyWq/qB+x39+AmMR/Tu+49yCFiivVfst69f
         dAKDFctvvGwljDjUyNaV3DcWixQO3KkuspELcvmZ9yGciIgDmc0NFDrQO4r1HbysCWTu
         PdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qNn4G8cvzJvLHz8cH6kihKqYYetWlzBm/2GQUQSOwPI=;
        b=cdw+JRrVfpDRuXFEyeluqh5O0SNHosYvrQeEtsXzy9MUdXvfOovhNJr95rrbZN/F2c
         27jHCrdgY8SM+o4IdrN+5VMt4uhlQFOdTuOGZAgy/E0MkZHHHGc6vHxMg7ph53ZXWX+e
         ZdXc0FWnehQdu/lpRCM46EHu1UK5IisCiTS5CWD6QyrMXgItZuNDgQBmPjjvonfHcRt4
         r2SXOInM12nh4SEQoCHQvW3BDPEhK/m3/JWyThbnEwBHodlMzrDqKrSh1Qfjasq9ETPj
         HzbASRn2AYK+g+je3S4CNdCdf8zxu9OscsyYxV6l3AFvR3YIdyt+pEV7zF9IOputAIpo
         9CZA==
X-Gm-Message-State: AOAM531J4iO/9sq2CJjNjvlq0UpDMwPuVclJZshCw0GcVvjhYsaDTz9k
        dUq305HLBjkdovPF/eTPXbc=
X-Google-Smtp-Source: ABdhPJwb7SJiTOgtSGDWIYS31HbgDout6SP1Ah937VBYnz2IgD1plvsuGSWyVz5CnhU/RDXkSPubGg==
X-Received: by 2002:a63:1f5b:: with SMTP id q27mr3869424pgm.324.1631211784407;
        Thu, 09 Sep 2021 11:23:04 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:500::6:ec8c])
        by smtp.gmail.com with ESMTPSA id y14sm2985389pfp.84.2021.09.09.11.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 11:23:04 -0700 (PDT)
Date:   Thu, 9 Sep 2021 11:23:01 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [RFC bpf 2/2] btf: adapt relo_core for kernel compilation
Message-ID: <20210909182301.javodesbocpianzd@ast-mbp.dhcp.thefacebook.com>
References: <20210909133153.48994-1-mcroce@linux.microsoft.com>
 <20210909133153.48994-3-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909133153.48994-3-mcroce@linux.microsoft.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 09, 2021 at 03:31:53PM +0200, Matteo Croce wrote:
> From: Matteo Croce <mcroce@microsoft.com>
> 
> Refactor kernel/bpf/relo_core.c so it builds in kernel contexxt.
> 
> - Replace lot of helpers used by the userspace code with the in-kernel
>   equivalent (e.g. s/btf_is_composite/btf_type_is_struct/
>   and s/btf_vlen/btf_type_vlen)
> - Move some static helpers from btf.c to btf.h (e.g. btf_type_is_array)
> - Port utility functions (e.g. str_is_empty)

Cool. It's great to see that you're working on it.

> +int bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
> +			      const struct btf *targ_btf, __u32 targ_id)
> +{
> +	const struct btf_type *local_type, *targ_type;
> +	int depth = 32; /* max recursion depth */
> +
> +	/* caller made sure that names match (ignoring flavor suffix) */
> +	local_type = btf__type_by_id(local_btf, local_id);
> +	targ_type = btf__type_by_id(targ_btf, targ_id);
> +	if (btf_kind(local_type) != btf_kind(targ_type))
> +		return 0;
> +
> +recur:
> +	depth--;
> +	if (depth < 0)
> +		return -EINVAL;
> +
> +	local_type = skip_mods_and_typedefs(local_btf, local_id, &local_id);
> +	targ_type = skip_mods_and_typedefs(targ_btf, targ_id, &targ_id);
> +	if (!local_type || !targ_type)
> +		return -EINVAL;
> +
> +	if (btf_kind(local_type) != btf_kind(targ_type))
> +		return 0;
> +
> +	switch (btf_kind(local_type)) {
> +	case BTF_KIND_UNKN:
> +	case BTF_KIND_STRUCT:
> +	case BTF_KIND_UNION:
> +	case BTF_KIND_ENUM:
> +	case BTF_KIND_FWD:
> +		return 1;
> +	case BTF_KIND_INT:
> +		/* just reject deprecated bitfield-like integers; all other
> +		 * integers are by default compatible between each other
> +		 */
> +		return btf_member_int_offset(local_type) == 0 && btf_member_int_offset(targ_type) == 0;
> +	case BTF_KIND_PTR:
> +		local_id = local_type->type;
> +		targ_id = targ_type->type;
> +		goto recur;
> +	case BTF_KIND_ARRAY:
> +		local_id = btf_type_array(local_type)->type;
> +		targ_id = btf_type_array(targ_type)->type;
> +		goto recur;
> +	case BTF_KIND_FUNC_PROTO: {
> +		struct btf_param *local_p = btf_type_params(local_type);
> +		struct btf_param *targ_p = btf_type_params(targ_type);
> +		__u16 local_vlen = btf_type_vlen(local_type);
> +		__u16 targ_vlen = btf_type_vlen(targ_type);
> +		int i, err;
> +
> +		if (local_vlen != targ_vlen)
> +			return 0;
> +
> +		for (i = 0; i < local_vlen; i++, local_p++, targ_p++) {
> +			skip_mods_and_typedefs(local_btf, local_p->type, &local_id);
> +			skip_mods_and_typedefs(targ_btf, targ_p->type, &targ_id);
> +			err = bpf_core_types_are_compat(local_btf, local_id, targ_btf, targ_id);

The main todo for this function is to convert to non-recursive
or limit the recursion to some small number (like 16).

>  		/* record enumerator name in a first accessor */
> -		acc->name = btf__name_by_offset(btf, btf_enum(t)[access_idx].name_off);
> +		acc->name = btf_name_by_offset(btf, btf_type_enum(t)[access_idx].name_off);

Instead of doing this kind of change and diverge further between kernel and
libbpf it would be better to agree on the same names for the helpers.
They're really the same. There is no good reason for them to have
different names in kernel's btf.h and libbpf's btf.h.

See attached patch how relo_core.c can be converted for kernel duty without copy-paste.
We're doing double compile for disasm.c. We can do the same here.
The copy-paste will lead to code divergence.
The same bug/feature would have to be implemented twice in the future.
The CO-RE algorithm can work in both kernel and user space unmodified.
imo code sharing is almost always a win.


From 1e9b236914d3e7672eba2e3b99aa198ac2bdb7bd Mon Sep 17 00:00:00 2001
From: Alexei Starovoitov <ast@kernel.org>
Date: Tue, 7 Sep 2021 15:45:44 -0700
Subject: [PATCH] bpf: Prepare relo_core.c for kernel duty.

Make relo_core.c to be compiled with kernel and with libbpf.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/btf.h       | 84 +++++++++++++++++++++++++++++++++
 kernel/bpf/Makefile       |  4 ++
 tools/lib/bpf/relo_core.c | 97 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 183 insertions(+), 2 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 214fde93214b..152aff09ee2d 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -143,6 +143,48 @@ static inline bool btf_type_is_enum(const struct btf_type *t)
 	return BTF_INFO_KIND(t->info) == BTF_KIND_ENUM;
 }
 
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
@@ -183,6 +225,11 @@ static inline u16 btf_type_vlen(const struct btf_type *t)
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
@@ -193,6 +240,27 @@ static inline bool btf_type_kflag(const struct btf_type *t)
 	return BTF_INFO_KFLAG(t->info);
 }
 
+static inline struct btf_member *btf_members(const struct btf_type *t)
+{
+	return (struct btf_member *)(t + 1);
+}
+#ifdef RELO_CORE
+static inline u32 btf_member_bit_offset(const struct btf_type *t, u32 member_idx)
+{
+	const struct btf_member *m = btf_members(t) + member_idx;
+	bool kflag = btf_type_kflag(t);
+
+	return kflag ? BTF_MEMBER_BIT_OFFSET(m->offset) : m->offset;
+}
+
+static inline u32 btf_member_bitfield_size(const struct btf_type *t, u32 member_idx)
+{
+	const struct btf_member *m = btf_members(t) + member_idx;
+	bool kflag = btf_type_kflag(t);
+
+	return kflag ? BTF_MEMBER_BITFIELD_SIZE(m->offset) : 0;
+}
+#else
 static inline u32 btf_member_bit_offset(const struct btf_type *struct_type,
 					const struct btf_member *member)
 {
@@ -206,12 +274,24 @@ static inline u32 btf_member_bitfield_size(const struct btf_type *struct_type,
 	return btf_type_kflag(struct_type) ? BTF_MEMBER_BITFIELD_SIZE(member->offset)
 					   : 0;
 }
+#endif
 
 static inline const struct btf_member *btf_type_member(const struct btf_type *t)
 {
 	return (const struct btf_member *)(t + 1);
 }
 
+
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
@@ -222,6 +302,10 @@ static inline const struct btf_var_secinfo *btf_type_var_secinfo(
 struct bpf_prog;
 
 const struct btf_type *btf_type_by_id(const struct btf *btf, u32 type_id);
+static inline const struct btf_type *btf__type_by_id(const struct btf *btf, u32 type_id)
+{
+	return btf_type_by_id(btf, type_id);
+}
 const char *btf_name_by_offset(const struct btf *btf, u32 offset);
 struct btf *btf_parse_vmlinux(void);
 struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog);
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 7f33098ca63f..3d5370c876b5 100644
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
diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index 4016ed492d0c..9d1f309f05fe 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -1,6 +1,98 @@
 // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 /* Copyright (c) 2019 Facebook */
 
+#ifdef __KERNEL__
+#define RELO_CORE
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/string.h>
+#include "relo_core.h"
+
+static const char *btf_kind_str(const struct btf_type *t)
+{
+	return btf_type_str(t);
+}
+
+static bool str_is_empty(const char *s)
+{
+	return !s || !s[0];
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
+
+enum libbpf_print_level {
+        LIBBPF_WARN,
+        LIBBPF_INFO,
+        LIBBPF_DEBUG,
+};
+__attribute__((format(printf, 2, 3)))
+void libbpf_print(enum libbpf_print_level level,
+		  const char *format, ...)
+{
+}
+#define __pr(level, fmt, ...)	\
+do {				\
+	libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__);	\
+} while (0)
+
+#undef pr_warn
+#undef pr_info
+#undef pr_debug
+#define pr_warn(fmt, ...)	__pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
+#define pr_info(fmt, ...)	__pr(LIBBPF_INFO, fmt, ##__VA_ARGS__)
+#define pr_debug(fmt, ...)	__pr(LIBBPF_DEBUG, fmt, ##__VA_ARGS__)
+int bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
+			      const struct btf *targ_btf, __u32 targ_id)
+{
+	return 0;
+}
+#else
 #include <stdio.h>
 #include <string.h>
 #include <errno.h>
@@ -12,8 +104,9 @@
 #include "btf.h"
 #include "str_error.h"
 #include "libbpf_internal.h"
+#endif
 
-#define BPF_CORE_SPEC_MAX_LEN 64
+#define BPF_CORE_SPEC_MAX_LEN 32
 
 /* represents BPF CO-RE field or array element accessor */
 struct bpf_core_accessor {
@@ -662,7 +755,7 @@ static int bpf_core_calc_field_relo(const char *prog_name,
 			*validate = true; /* signedness is never ambiguous */
 		break;
 	case BPF_FIELD_LSHIFT_U64:
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 		*val = 64 - (bit_off + bit_sz - byte_off  * 8);
 #else
 		*val = (8 - byte_sz) * 8 + (bit_off - byte_off * 8);
-- 
2.30.2


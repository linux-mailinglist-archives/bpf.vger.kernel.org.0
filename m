Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87BFC4100F9
	for <lists+bpf@lfdr.de>; Fri, 17 Sep 2021 23:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhIQV6x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Sep 2021 17:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242308AbhIQV6u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Sep 2021 17:58:50 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44336C061574
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 14:57:27 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id m21-20020a17090a859500b00197688449c4so8415652pjn.0
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 14:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xnPXEBmKeTLZQewoctmdTv1cfeyLbPqUm5I4xoSgPos=;
        b=FQznexSatKcYOhqivURZius3nP1kkNLfJtHpa33tDuk+YAPQpTWMSeBpzs4b/w1Vhp
         kt8bQMV4nKklmguEks7pKymJAvbTgLMRe1E2mfQEqq9k8KwuGjIrCu41uiHoVb7nTEbi
         p3aqh+tUgGMVjIqMK5HbHYrFe13xWaiO2tOb7ZEFtowte0Mqc3A3FsR/feRBNmbY+f3v
         QSR2zixnqg39oSgbXpXt+icNqDCm+saLwzd4AQj8mRKzjpMqgc6uSfjRhl9e9sb4O+hk
         1wH7+0212U82YtThN6G2yOb3VOnbMbogEskWj7MloHDcoRQUCLUbHmz5xH21hX9kwl8b
         ZbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xnPXEBmKeTLZQewoctmdTv1cfeyLbPqUm5I4xoSgPos=;
        b=OCELY7A0SoWLKYEUz7UYc7P2C8o0U4ZVmB0/pCbvDtMSvxjlh3ywmFodrGmGhUK2ta
         35RzpdSZeIiTNgzme7LNgZfnmtXclkFOPs7fyhZslE2y9AqY8L60/O3tWlTl7OHWfVIo
         Z8dQ4GxkMiASHI6LniRLQhUXYrTKQpRxqLg0UOxN1ujFYfwslhGkiD9S04zU+yD8doS7
         B+DwNE7Zhvba96c4CA37fVfq4uNGY6pWKYc4hpIb82uedKHTBKSo5a9Ye4mjKW4kP6LG
         1pL8BVSuAz7k/gQOQ2fFEQldpdyMQqWHJN81/3MBJohoHdbRQ5sSggwCggd+K87Nr27s
         a9UQ==
X-Gm-Message-State: AOAM533Lge1UnkXwgrwdCQfyP+MC7Cm6n8qWkPsi6+InomTnTGWkKE7c
        JQ/ogHRCWKrvYTSjAZ9u5e8=
X-Google-Smtp-Source: ABdhPJypSuvWJb8QEuJyAznKRLNjQXXIDsbwcqg8zkOIf+PKISBU3KFLBqTBSA0qCduzx0EdfE7IZA==
X-Received: by 2002:a17:90b:4a4c:: with SMTP id lb12mr23337842pjb.55.1631915846779;
        Fri, 17 Sep 2021 14:57:26 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:500::6:db29])
        by smtp.gmail.com with ESMTPSA id y80sm2536559pfb.196.2021.09.17.14.57.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Sep 2021 14:57:26 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        lmb@cloudflare.com, mcroce@microsoft.com, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH RFC bpf-next 01/10] bpf: Prepare relo_core.c for kernel duty.
Date:   Fri, 17 Sep 2021 14:57:12 -0700
Message-Id: <20210917215721.43491-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210917215721.43491-1-alexei.starovoitov@gmail.com>
References: <20210917215721.43491-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Make relo_core.c to be compiled with kernel and with libbpf.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/btf.h       | 89 +++++++++++++++++++++++++++++++++++++++
 kernel/bpf/Makefile       |  4 ++
 kernel/bpf/btf.c          | 26 ++++++++++++
 tools/lib/bpf/relo_core.c | 72 ++++++++++++++++++++++++++++++-
 4 files changed, 189 insertions(+), 2 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 214fde93214b..bc42ab20d549 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -143,6 +143,53 @@ static inline bool btf_type_is_enum(const struct btf_type *t)
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
@@ -183,6 +230,11 @@ static inline u16 btf_type_vlen(const struct btf_type *t)
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
@@ -193,6 +245,27 @@ static inline bool btf_type_kflag(const struct btf_type *t)
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
@@ -206,12 +279,24 @@ static inline u32 btf_member_bitfield_size(const struct btf_type *struct_type,
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
@@ -222,6 +307,10 @@ static inline const struct btf_var_secinfo *btf_type_var_secinfo(
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
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index c3d605b22473..fa2c88f6ac4a 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6343,3 +6343,29 @@ const struct bpf_func_proto bpf_btf_find_by_name_kind_proto = {
 };
 
 BTF_ID_LIST_GLOBAL_SINGLE(btf_task_struct_ids, struct, task_struct)
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
index 4016ed492d0c..d30c315f8fd4 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -1,6 +1,73 @@
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
+        LIBBPF_WARN,
+        LIBBPF_INFO,
+        LIBBPF_DEBUG,
+};
+__attribute__((format(printf, 2, 3)))
+void libbpf_print(enum libbpf_print_level level,
+		  const char *format, ...)
+{
+	va_list args;
+
+	va_start(args, format);
+	vprintk(format, args);
+	va_end(args);
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
+#else
 #include <stdio.h>
 #include <string.h>
 #include <errno.h>
@@ -12,8 +79,9 @@
 #include "btf.h"
 #include "str_error.h"
 #include "libbpf_internal.h"
+#endif
 
-#define BPF_CORE_SPEC_MAX_LEN 64
+#define BPF_CORE_SPEC_MAX_LEN 32
 
 /* represents BPF CO-RE field or array element accessor */
 struct bpf_core_accessor {
@@ -662,7 +730,7 @@ static int bpf_core_calc_field_relo(const char *prog_name,
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


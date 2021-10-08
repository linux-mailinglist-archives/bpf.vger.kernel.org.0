Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3958F4260DA
	for <lists+bpf@lfdr.de>; Fri,  8 Oct 2021 02:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhJHAFO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Oct 2021 20:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbhJHAFN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Oct 2021 20:05:13 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68318C061570
        for <bpf@vger.kernel.org>; Thu,  7 Oct 2021 17:03:19 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id o133so426919pfg.7
        for <bpf@vger.kernel.org>; Thu, 07 Oct 2021 17:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f89V8UR53B8PBEWbuIYHTgDN0cQYvdiHh1xbBCwRiV8=;
        b=Y34qeSkZ9Oc+TY5QOCe0+BRHadnPTedE5XP1OP1w0P1ig26TDWMqX78WFiKTCZ0hFX
         4l1yxOYSVFgSMM1Zx418dpNWQrKyHlzhoR13FJy+c0QRkmjRdKWCEQg9AiU9UQBAbIEQ
         Wfgr5jJM6dkPGi4345JcFV5izeX262FgGjTs57Ctzpn5GUel1qda30MoeGG1O2Tzvibx
         WHmE2S25GihAmPsdeMKjd9yh12LhD0GCTgaYhwKsUqc3rWfop6XK3qk30dSurvf3OK37
         JGQFYVyl2pFtg3oZUosWlAAK2rS6yPEc+9YPb3RxTksmWvoJkUHfFlf5eDzoYUuz0vWU
         WjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f89V8UR53B8PBEWbuIYHTgDN0cQYvdiHh1xbBCwRiV8=;
        b=WhtVWm5nNI7hN6jfVcoRKxrvR5ofZFzz4awkUps1XX6e2uly7UN+pEr/AEnZDkvqJG
         X9ZXWMHna/dkteyYc+x+SyblndMQx3iYL4B9qu+K1NiWVPmn4JatXp6AEJ36QATOcn/9
         qa0mTPWPAwyAhmTeJU4sF/COUYiYvVCoAVfW35nsnNVH2FV9xVDwkqlVu2jTZMdUmnZY
         67Vi99tQzHO1PL6mie6xIv6AfIzrWWmtPIF0ycZGGVU5k1hvWI/SsoAzrr6eIk94kPS+
         gnX0wqbemKmeYeZUDfkvHOWCw7L/gJt09jAR4g+4y3t32t61SZBaxiVnidCvYRFa6pnY
         EMNA==
X-Gm-Message-State: AOAM532qlt48de6FHmTIqmRiokqDDD3jhF2IttWu/ROTdBdDf/IeFAR2
        ljOALA/x2d2JIFf/2FyO72G0vbTsCCOS2g==
X-Google-Smtp-Source: ABdhPJyFkftJ+wxnIcsKJ51hmmWV6hxCI3AtStnZo7X+Ovrf1Ug8yAMAk0UH38oKMYm4jVPn5I8vcw==
X-Received: by 2002:a63:1352:: with SMTP id 18mr2031152pgt.348.1633651398591;
        Thu, 07 Oct 2021 17:03:18 -0700 (PDT)
Received: from andriin-mbp.thefacebook.com ([2620:10d:c090:500::e050])
        by smtp.gmail.com with ESMTPSA id j7sm476718pfh.168.2021.10.07.17.03.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Oct 2021 17:03:18 -0700 (PDT)
From:   andrii.nakryiko@gmail.com
X-Google-Original-From: andrii@kernel.org
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     andrii@kernel.org, kernel-team@fb.com
Subject: [PATCH bpf-next 01/10] libbpf: deprecate btf__finalize_data() and move it into libbpf.c
Date:   Thu,  7 Oct 2021 17:03:00 -0700
Message-Id: <20211008000309.43274-2-andrii@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211008000309.43274-1-andrii@kernel.org>
References: <20211008000309.43274-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrii Nakryiko <andrii@kernel.org>

There isn't a good use case where anyone but libbpf itself needs to call
btf__finalize_data(). It was implemented for internal use and it's not
clear why it was made into public API in the first place. To function, it
requires active ELF data, which is stored inside bpf_object for the
duration of opening phase only. But the only BTF that needs bpf_object's
ELF is that bpf_object's BTF itself, which libbpf fixes up automatically
during bpf_object__open() operation anyways. There is no need for any
additional fix up and no reasonable scenario where it's useful and
appropriate.

Thus, btf__finalize_data() is just an API atavism and is better removed.
So this patch marks it as deprecated immediately (v0.6+) and moves the
code from btf.c into libbpf.c where it's used in the context of
bpf_object opening phase. Such code co-location allows to make code
structure more straightforward and remove bpf_object__section_size() and
bpf_object__variable_offset() internal helpers from libbpf_internal.h,
making them static. Their naming is also adjusted to not create
a wrong illusion that they are some sort of method of bpf_object. They
are internal helpers and are called appropriately.

This is part of libbpf 1.0 effort ([0]).

  [0] Closes: https://github.com/libbpf/libbpf/issues/276

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/btf.c             |  93 ----------------------------
 tools/lib/bpf/btf.h             |   1 +
 tools/lib/bpf/libbpf.c          | 106 ++++++++++++++++++++++++++++++--
 tools/lib/bpf/libbpf_internal.h |   4 --
 4 files changed, 102 insertions(+), 102 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 60fbd1c6d466..b85ca8313247 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1107,99 +1107,6 @@ struct btf *btf__parse_split(const char *path, struct btf *base_btf)
 	return libbpf_ptr(btf_parse(path, base_btf, NULL));
 }
 
-static int compare_vsi_off(const void *_a, const void *_b)
-{
-	const struct btf_var_secinfo *a = _a;
-	const struct btf_var_secinfo *b = _b;
-
-	return a->offset - b->offset;
-}
-
-static int btf_fixup_datasec(struct bpf_object *obj, struct btf *btf,
-			     struct btf_type *t)
-{
-	__u32 size = 0, off = 0, i, vars = btf_vlen(t);
-	const char *name = btf__name_by_offset(btf, t->name_off);
-	const struct btf_type *t_var;
-	struct btf_var_secinfo *vsi;
-	const struct btf_var *var;
-	int ret;
-
-	if (!name) {
-		pr_debug("No name found in string section for DATASEC kind.\n");
-		return -ENOENT;
-	}
-
-	/* .extern datasec size and var offsets were set correctly during
-	 * extern collection step, so just skip straight to sorting variables
-	 */
-	if (t->size)
-		goto sort_vars;
-
-	ret = bpf_object__section_size(obj, name, &size);
-	if (ret || !size || (t->size && t->size != size)) {
-		pr_debug("Invalid size for section %s: %u bytes\n", name, size);
-		return -ENOENT;
-	}
-
-	t->size = size;
-
-	for (i = 0, vsi = btf_var_secinfos(t); i < vars; i++, vsi++) {
-		t_var = btf__type_by_id(btf, vsi->type);
-		var = btf_var(t_var);
-
-		if (!btf_is_var(t_var)) {
-			pr_debug("Non-VAR type seen in section %s\n", name);
-			return -EINVAL;
-		}
-
-		if (var->linkage == BTF_VAR_STATIC)
-			continue;
-
-		name = btf__name_by_offset(btf, t_var->name_off);
-		if (!name) {
-			pr_debug("No name found in string section for VAR kind\n");
-			return -ENOENT;
-		}
-
-		ret = bpf_object__variable_offset(obj, name, &off);
-		if (ret) {
-			pr_debug("No offset found in symbol table for VAR %s\n",
-				 name);
-			return -ENOENT;
-		}
-
-		vsi->offset = off;
-	}
-
-sort_vars:
-	qsort(btf_var_secinfos(t), vars, sizeof(*vsi), compare_vsi_off);
-	return 0;
-}
-
-int btf__finalize_data(struct bpf_object *obj, struct btf *btf)
-{
-	int err = 0;
-	__u32 i;
-
-	for (i = 1; i <= btf->nr_types; i++) {
-		struct btf_type *t = btf_type_by_id(btf, i);
-
-		/* Loader needs to fix up some of the things compiler
-		 * couldn't get its hands on while emitting BTF. This
-		 * is section size and global variable offset. We use
-		 * the info from the ELF itself for this purpose.
-		 */
-		if (btf_is_datasec(t)) {
-			err = btf_fixup_datasec(obj, btf, t);
-			if (err)
-				break;
-		}
-	}
-
-	return libbpf_err(err);
-}
-
 static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool swap_endian);
 
 int btf__load_into_kernel(struct btf *btf)
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 864eb51753a1..68fb340f2a6e 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -123,6 +123,7 @@ LIBBPF_API struct btf *btf__load_from_kernel_by_id_split(__u32 id, struct btf *b
 LIBBPF_DEPRECATED_SINCE(0, 6, "use btf__load_from_kernel_by_id instead")
 LIBBPF_API int btf__get_from_id(__u32 id, struct btf **btf);
 
+LIBBPF_DEPRECATED_SINCE(0, 6, "intended for internal libbpf use only")
 LIBBPF_API int btf__finalize_data(struct bpf_object *obj, struct btf *btf);
 LIBBPF_DEPRECATED_SINCE(0, 6, "use btf__load_into_kernel instead")
 LIBBPF_API int btf__load(struct btf *btf);
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ed313fd491bd..994dd25e36cd 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1324,8 +1324,7 @@ static bool bpf_map_type__is_map_in_map(enum bpf_map_type type)
 	return false;
 }
 
-int bpf_object__section_size(const struct bpf_object *obj, const char *name,
-			     __u32 *size)
+static int find_elf_sec_sz(const struct bpf_object *obj, const char *name, __u32 *size)
 {
 	int ret = -ENOENT;
 
@@ -1357,8 +1356,7 @@ int bpf_object__section_size(const struct bpf_object *obj, const char *name,
 	return *size ? 0 : ret;
 }
 
-int bpf_object__variable_offset(const struct bpf_object *obj, const char *name,
-				__u32 *off)
+static int find_elf_var_offset(const struct bpf_object *obj, const char *name, __u32 *off)
 {
 	Elf_Data *symbols = obj->efile.symbols;
 	const char *sname;
@@ -2650,6 +2648,104 @@ static int bpf_object__init_btf(struct bpf_object *obj,
 	return 0;
 }
 
+static int compare_vsi_off(const void *_a, const void *_b)
+{
+	const struct btf_var_secinfo *a = _a;
+	const struct btf_var_secinfo *b = _b;
+
+	return a->offset - b->offset;
+}
+
+static int btf_fixup_datasec(struct bpf_object *obj, struct btf *btf,
+			     struct btf_type *t)
+{
+	__u32 size = 0, off = 0, i, vars = btf_vlen(t);
+	const char *name = btf__name_by_offset(btf, t->name_off);
+	const struct btf_type *t_var;
+	struct btf_var_secinfo *vsi;
+	const struct btf_var *var;
+	int ret;
+
+	if (!name) {
+		pr_debug("No name found in string section for DATASEC kind.\n");
+		return -ENOENT;
+	}
+
+	/* .extern datasec size and var offsets were set correctly during
+	 * extern collection step, so just skip straight to sorting variables
+	 */
+	if (t->size)
+		goto sort_vars;
+
+	ret = find_elf_sec_sz(obj, name, &size);
+	if (ret || !size || (t->size && t->size != size)) {
+		pr_debug("Invalid size for section %s: %u bytes\n", name, size);
+		return -ENOENT;
+	}
+
+	t->size = size;
+
+	for (i = 0, vsi = btf_var_secinfos(t); i < vars; i++, vsi++) {
+		t_var = btf__type_by_id(btf, vsi->type);
+		var = btf_var(t_var);
+
+		if (!btf_is_var(t_var)) {
+			pr_debug("Non-VAR type seen in section %s\n", name);
+			return -EINVAL;
+		}
+
+		if (var->linkage == BTF_VAR_STATIC)
+			continue;
+
+		name = btf__name_by_offset(btf, t_var->name_off);
+		if (!name) {
+			pr_debug("No name found in string section for VAR kind\n");
+			return -ENOENT;
+		}
+
+		ret = find_elf_var_offset(obj, name, &off);
+		if (ret) {
+			pr_debug("No offset found in symbol table for VAR %s\n",
+				 name);
+			return -ENOENT;
+		}
+
+		vsi->offset = off;
+	}
+
+sort_vars:
+	qsort(btf_var_secinfos(t), vars, sizeof(*vsi), compare_vsi_off);
+	return 0;
+}
+
+static int btf_finalize_data(struct bpf_object *obj, struct btf *btf)
+{
+	int err = 0;
+	__u32 i, n = btf__get_nr_types(btf);
+
+	for (i = 1; i <= n; i++) {
+		struct btf_type *t = btf_type_by_id(btf, i);
+
+		/* Loader needs to fix up some of the things compiler
+		 * couldn't get its hands on while emitting BTF. This
+		 * is section size and global variable offset. We use
+		 * the info from the ELF itself for this purpose.
+		 */
+		if (btf_is_datasec(t)) {
+			err = btf_fixup_datasec(obj, btf, t);
+			if (err)
+				break;
+		}
+	}
+
+	return libbpf_err(err);
+}
+
+int btf__finalize_data(struct bpf_object *obj, struct btf *btf)
+{
+	return btf_finalize_data(obj, btf);
+}
+
 static int bpf_object__finalize_btf(struct bpf_object *obj)
 {
 	int err;
@@ -2657,7 +2753,7 @@ static int bpf_object__finalize_btf(struct bpf_object *obj)
 	if (!obj->btf)
 		return 0;
 
-	err = btf__finalize_data(obj, obj->btf);
+	err = btf_finalize_data(obj, obj->btf);
 	if (err) {
 		pr_warn("Error finalizing %s: %d.\n", BTF_ELF_SEC, err);
 		return err;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index f7fd3944d46d..983da066092d 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -303,10 +303,6 @@ struct bpf_prog_load_params {
 
 int libbpf__bpf_prog_load(const struct bpf_prog_load_params *load_attr);
 
-int bpf_object__section_size(const struct bpf_object *obj, const char *name,
-			     __u32 *size);
-int bpf_object__variable_offset(const struct bpf_object *obj, const char *name,
-				__u32 *off);
 struct btf *btf_get_from_fd(int btf_fd, struct btf *base_btf);
 void btf_get_kernel_prefix_kind(enum bpf_attach_type attach_type,
 				const char **prefix, int *kind);
-- 
2.30.2


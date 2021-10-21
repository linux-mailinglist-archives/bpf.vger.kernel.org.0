Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7732C435864
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 03:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhJUBqb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 20 Oct 2021 21:46:31 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:30346 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230103AbhJUBqa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 20 Oct 2021 21:46:30 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 19L03rJN024442
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 18:44:14 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3btwba0enk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 18:44:14 -0700
Received: from intmgw003.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 20 Oct 2021 18:44:13 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 1C82A6E3E13B; Wed, 20 Oct 2021 18:44:11 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v2 bpf-next 01/10] libbpf: deprecate btf__finalize_data() and move it into libbpf.c
Date:   Wed, 20 Oct 2021 18:43:55 -0700
Message-ID: <20211021014404.2635234-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021014404.2635234-1-andrii@kernel.org>
References: <20211021014404.2635234-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: XS0F9YNqgMgmfS3WFBPJdrk6jecfyeJQ
X-Proofpoint-ORIG-GUID: XS0F9YNqgMgmfS3WFBPJdrk6jecfyeJQ
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-20_06,2021-10-20_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110210008
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

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

Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/btf.c             |  93 ----------------------------
 tools/lib/bpf/btf.h             |   1 +
 tools/lib/bpf/libbpf.c          | 106 ++++++++++++++++++++++++++++++--
 tools/lib/bpf/libbpf_internal.h |   4 --
 4 files changed, 102 insertions(+), 102 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 1f6dea11f600..3a01c4b7f36a 100644
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
index 4011e206e6f7..c9364be42035 100644
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
index 760c7e346603..fdc25a112150 100644
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
index f6a5748dd318..4bbd327a4ce9 100644
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


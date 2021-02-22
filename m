Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B63B3221CB
	for <lists+bpf@lfdr.de>; Mon, 22 Feb 2021 22:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhBVVvj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Feb 2021 16:51:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57102 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230036AbhBVVvg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Feb 2021 16:51:36 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11MLWinv169696;
        Mon, 22 Feb 2021 16:50:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6rmpCKDZimLq3usXEGvqqQrv0uxcw8o6FDY0JXm6qYs=;
 b=E+V3gJ9bkkJSAaYS3lLQFcvnAq0AYPJdza9j5rMGeDdslI6HZQkuWvTS9lhQW7QU2EVc
 kvfl0DlOPkmTcilv3yimo2iIdLszVvB4K+nyEjVuODdMPli7FZzo+oeo2ECaZVXUsZ/u
 omBGQgo2fteWoSispxAK2KJhZsX46wZRFJ8R7TU4Nv9gFLO55IgPlatmQEvcWGsAw+Ru
 4Z10p4Q53PxbbP4XDmKsc03bHNnOFObZuYRY2q+ch1eexmOu4It93C0SRlnRCtHGVYA5
 719bXsXjJ0rUY7ptgrPpLv1mDp/kwZL/7kzKbeFznskowv5/0MoEWYVtKJR6dMw7Lzwu Bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36vkm9jm28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 16:50:41 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11MLXgDw172937;
        Mon, 22 Feb 2021 16:50:41 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36vkm9jm1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 16:50:40 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11MLm1gB018396;
        Mon, 22 Feb 2021 21:50:39 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 36tsph21h6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 21:50:39 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11MLoa6i42795418
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 21:50:36 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CFE5A4051;
        Mon, 22 Feb 2021 21:50:36 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9886BA4053;
        Mon, 22 Feb 2021 21:50:35 +0000 (GMT)
Received: from vm.lan (unknown [9.145.151.190])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 22 Feb 2021 21:50:35 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v4 bpf-next 2/7] libbpf: Add BTF_KIND_FLOAT support
Date:   Mon, 22 Feb 2021 22:49:12 +0100
Message-Id: <20210222214917.83629-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210222214917.83629-1-iii@linux.ibm.com>
References: <20210222214917.83629-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-22_07:2021-02-22,2021-02-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220187
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The logic follows that of BTF_KIND_INT most of the time. Sanitization
replaces BTF_KIND_FLOATs with BTF_KIND_CONSTs pointing to
equally-sized BTF_KIND_ARRAYs on older kernels, for example, the
following:

    [4] FLOAT 'float' size=4

becomes the following:

    [4] CONST '(anon)' type_id=10
    ...
    [8] INT 'unsigned int' size=4 bits_offset=0 nr_bits=32 encoding=(none)
    [9] INT 'unsigned char' size=1 bits_offset=0 nr_bits=8 encoding=(none)
    [10] ARRAY '(anon)' type_id=9 index_type_id=8 nr_elems=4

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/btf.c             | 44 +++++++++++++++++
 tools/lib/bpf/btf.h             |  8 ++++
 tools/lib/bpf/btf_dump.c        |  4 ++
 tools/lib/bpf/libbpf.c          | 84 +++++++++++++++++++++++++++++++--
 tools/lib/bpf/libbpf.map        |  5 ++
 tools/lib/bpf/libbpf_internal.h |  2 +
 6 files changed, 142 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index fdfff544f59a..1ebfcc687dab 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -292,6 +292,7 @@ static int btf_type_size(const struct btf_type *t)
 	case BTF_KIND_PTR:
 	case BTF_KIND_TYPEDEF:
 	case BTF_KIND_FUNC:
+	case BTF_KIND_FLOAT:
 		return base_size;
 	case BTF_KIND_INT:
 		return base_size + sizeof(__u32);
@@ -339,6 +340,7 @@ static int btf_bswap_type_rest(struct btf_type *t)
 	case BTF_KIND_PTR:
 	case BTF_KIND_TYPEDEF:
 	case BTF_KIND_FUNC:
+	case BTF_KIND_FLOAT:
 		return 0;
 	case BTF_KIND_INT:
 		*(__u32 *)(t + 1) = bswap_32(*(__u32 *)(t + 1));
@@ -579,6 +581,7 @@ __s64 btf__resolve_size(const struct btf *btf, __u32 type_id)
 		case BTF_KIND_UNION:
 		case BTF_KIND_ENUM:
 		case BTF_KIND_DATASEC:
+		case BTF_KIND_FLOAT:
 			size = t->size;
 			goto done;
 		case BTF_KIND_PTR:
@@ -622,6 +625,7 @@ int btf__align_of(const struct btf *btf, __u32 id)
 	switch (kind) {
 	case BTF_KIND_INT:
 	case BTF_KIND_ENUM:
+	case BTF_KIND_FLOAT:
 		return min(btf_ptr_sz(btf), (size_t)t->size);
 	case BTF_KIND_PTR:
 		return btf_ptr_sz(btf);
@@ -2400,6 +2404,42 @@ int btf__add_datasec(struct btf *btf, const char *name, __u32 byte_sz)
 	return btf_commit_type(btf, sz);
 }
 
+/*
+ * Append new BTF_KIND_FLOAT type with:
+ *   - *name* - non-empty, non-NULL type name;
+ *   - *sz* - size of the type, in bytes;
+ * Returns:
+ *   - >0, type ID of newly added BTF type;
+ *   - <0, on error.
+ */
+int btf__add_float(struct btf *btf, const char *name, size_t byte_sz)
+{
+	struct btf_type *t;
+	int sz, name_off;
+
+	/* non-empty name */
+	if (!name || !name[0])
+		return -EINVAL;
+
+	if (btf_ensure_modifiable(btf))
+		return -ENOMEM;
+
+	sz = sizeof(struct btf_type);
+	t = btf_add_type_mem(btf, sz);
+	if (!t)
+		return -ENOMEM;
+
+	name_off = btf__add_str(btf, name);
+	if (name_off < 0)
+		return name_off;
+
+	t->name_off = name_off;
+	t->info = btf_type_info(BTF_KIND_FLOAT, 0, 0);
+	t->size = byte_sz;
+
+	return btf_commit_type(btf, sz);
+}
+
 /*
  * Append new data section variable information entry for current DATASEC type:
  *   - *var_type_id* - type ID, describing type of the variable;
@@ -3653,6 +3693,7 @@ static int btf_dedup_prep(struct btf_dedup *d)
 		case BTF_KIND_FWD:
 		case BTF_KIND_TYPEDEF:
 		case BTF_KIND_FUNC:
+		case BTF_KIND_FLOAT:
 			h = btf_hash_common(t);
 			break;
 		case BTF_KIND_INT:
@@ -3749,6 +3790,7 @@ static int btf_dedup_prim_type(struct btf_dedup *d, __u32 type_id)
 		break;
 
 	case BTF_KIND_FWD:
+	case BTF_KIND_FLOAT:
 		h = btf_hash_common(t);
 		for_each_dedup_cand(d, hash_entry, h) {
 			cand_id = (__u32)(long)hash_entry->value;
@@ -4010,6 +4052,7 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
 			return btf_compat_enum(cand_type, canon_type);
 
 	case BTF_KIND_FWD:
+	case BTF_KIND_FLOAT:
 		return btf_equal_common(cand_type, canon_type);
 
 	case BTF_KIND_CONST:
@@ -4506,6 +4549,7 @@ static int btf_dedup_remap_type(struct btf_dedup *d, __u32 type_id)
 	switch (btf_kind(t)) {
 	case BTF_KIND_INT:
 	case BTF_KIND_ENUM:
+	case BTF_KIND_FLOAT:
 		break;
 
 	case BTF_KIND_FWD:
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 1237bcd1dd17..c3b11bcebeda 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -132,6 +132,9 @@ LIBBPF_API int btf__add_datasec(struct btf *btf, const char *name, __u32 byte_sz
 LIBBPF_API int btf__add_datasec_var_info(struct btf *btf, int var_type_id,
 					 __u32 offset, __u32 byte_sz);
 
+/* float construction APIs */
+LIBBPF_API int btf__add_float(struct btf *btf, const char *name, size_t byte_sz);
+
 struct btf_dedup_opts {
 	unsigned int dedup_table_size;
 	bool dont_resolve_fwds;
@@ -294,6 +297,11 @@ static inline bool btf_is_datasec(const struct btf_type *t)
 	return btf_kind(t) == BTF_KIND_DATASEC;
 }
 
+static inline bool btf_is_float(const struct btf_type *t)
+{
+	return btf_kind(t) == BTF_KIND_FLOAT;
+}
+
 static inline __u8 btf_int_encoding(const struct btf_type *t)
 {
 	return BTF_INT_ENCODING(*(__u32 *)(t + 1));
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 2f9d685bd522..5e957fcceee6 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -279,6 +279,7 @@ static int btf_dump_mark_referenced(struct btf_dump *d)
 		case BTF_KIND_INT:
 		case BTF_KIND_ENUM:
 		case BTF_KIND_FWD:
+		case BTF_KIND_FLOAT:
 			break;
 
 		case BTF_KIND_VOLATILE:
@@ -453,6 +454,7 @@ static int btf_dump_order_type(struct btf_dump *d, __u32 id, bool through_ptr)
 
 	switch (btf_kind(t)) {
 	case BTF_KIND_INT:
+	case BTF_KIND_FLOAT:
 		tstate->order_state = ORDERED;
 		return 0;
 
@@ -1133,6 +1135,7 @@ static void btf_dump_emit_type_decl(struct btf_dump *d, __u32 id,
 		case BTF_KIND_STRUCT:
 		case BTF_KIND_UNION:
 		case BTF_KIND_TYPEDEF:
+		case BTF_KIND_FLOAT:
 			goto done;
 		default:
 			pr_warn("unexpected type in decl chain, kind:%u, id:[%u]\n",
@@ -1247,6 +1250,7 @@ static void btf_dump_emit_type_chain(struct btf_dump *d,
 
 		switch (kind) {
 		case BTF_KIND_INT:
+		case BTF_KIND_FLOAT:
 			btf_dump_emit_mods(d, decls);
 			name = btf_name_of(d, t->name_off);
 			btf_dump_printf(d, "%s", name);
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index d43cc3f29dae..45682820a6e8 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -178,6 +178,8 @@ enum kern_feature_id {
 	FEAT_PROG_BIND_MAP,
 	/* Kernel support for module BTFs */
 	FEAT_MODULE_BTF,
+	/* BTF_KIND_FLOAT support */
+	FEAT_BTF_FLOAT,
 	__FEAT_CNT,
 };
 
@@ -1935,6 +1937,7 @@ static const char *btf_kind_str(const struct btf_type *t)
 	case BTF_KIND_FUNC_PROTO: return "func_proto";
 	case BTF_KIND_VAR: return "var";
 	case BTF_KIND_DATASEC: return "datasec";
+	case BTF_KIND_FLOAT: return "float";
 	default: return "unknown";
 	}
 }
@@ -2384,18 +2387,37 @@ static bool btf_needs_sanitization(struct bpf_object *obj)
 {
 	bool has_func_global = kernel_supports(FEAT_BTF_GLOBAL_FUNC);
 	bool has_datasec = kernel_supports(FEAT_BTF_DATASEC);
+	bool has_float = kernel_supports(FEAT_BTF_FLOAT);
 	bool has_func = kernel_supports(FEAT_BTF_FUNC);
 
-	return !has_func || !has_datasec || !has_func_global;
+	return !has_func || !has_datasec || !has_func_global || !has_float;
 }
 
-static void bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
+static int btf_ensure_int(struct btf *btf, int *id, const char *name,
+			  size_t byte_sz, int encoding)
+{
+	if (*id)
+		return 0;
+
+	*id = btf__add_int(btf, name, byte_sz, encoding);
+	if (*id < 0) {
+		pr_warn("Error adding %s BTF type: %d.\n", name, *id);
+		return *id;
+	}
+
+	return 0;
+}
+
+static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
 {
 	bool has_func_global = kernel_supports(FEAT_BTF_GLOBAL_FUNC);
 	bool has_datasec = kernel_supports(FEAT_BTF_DATASEC);
+	bool has_float = kernel_supports(FEAT_BTF_FLOAT);
 	bool has_func = kernel_supports(FEAT_BTF_FUNC);
+	int err, i, j, vlen;
 	struct btf_type *t;
-	int i, j, vlen;
+	int uchar_id = 0;
+	int uint_id = 0;
 
 	for (i = 1; i <= btf__get_nr_types(btf); i++) {
 		t = (struct btf_type *)btf__type_by_id(btf, i);
@@ -2445,8 +2467,35 @@ static void bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
 		} else if (!has_func_global && btf_is_func(t)) {
 			/* replace BTF_FUNC_GLOBAL with BTF_FUNC_STATIC */
 			t->info = BTF_INFO_ENC(BTF_KIND_FUNC, 0, 0);
+		} else if (!has_float && btf_is_float(t)) {
+			/* replace FLOAT with CONST(u8[]) */
+			int array_id;
+			__u32 size;
+
+			size = t->size;
+			err = btf_ensure_int(btf, &uint_id, "unsigned int", 4, 0);
+			if (err)
+				return err;
+			err = btf_ensure_int(btf, &uchar_id, "unsigned char", 1, 0);
+			if (err)
+				return err;
+			array_id = btf__add_array(btf, uint_id, uchar_id, size);
+			if (array_id < 0) {
+				pr_warn("Error adding unsigned char[%" PRIu32 "] BTF type: %d.\n",
+					t->size, array_id);
+				return array_id;
+			}
+
+			/* adding new types may have invalidated t */
+			t = (struct btf_type *)btf__type_by_id(btf, i);
+
+			t->name_off = 0;
+			t->info = BTF_INFO_ENC(BTF_KIND_CONST, 0, 0);
+			t->type = array_id;
 		}
 	}
+
+	return 0;
 }
 
 static bool libbpf_needs_btf(const struct bpf_object *obj)
@@ -2585,6 +2634,7 @@ static int bpf_object__load_vmlinux_btf(struct bpf_object *obj, bool force)
 
 static int bpf_object__sanitize_and_load_btf(struct bpf_object *obj)
 {
+	const char *action = "loading .BTF into kernel";
 	struct btf *kern_btf = obj->btf;
 	bool btf_mandatory, sanitize;
 	int err = 0;
@@ -2614,7 +2664,12 @@ static int bpf_object__sanitize_and_load_btf(struct bpf_object *obj)
 
 		/* enforce 8-byte pointers for BPF-targeted BTFs */
 		btf__set_pointer_size(obj->btf, 8);
-		bpf_object__sanitize_btf(obj, kern_btf);
+		err = bpf_object__sanitize_btf(obj, kern_btf);
+		if (err) {
+			btf__free(kern_btf);
+			action = "sanitizing .BTF";
+			goto report;
+		}
 	}
 
 	err = btf__load(kern_btf);
@@ -2629,7 +2684,7 @@ static int bpf_object__sanitize_and_load_btf(struct bpf_object *obj)
 report:
 	if (err) {
 		btf_mandatory = kernel_needs_btf(obj);
-		pr_warn("Error loading .BTF into kernel: %d. %s\n", err,
+		pr_warn("Error %s: %d. %s\n", action, err,
 			btf_mandatory ? "BTF is mandatory, can't proceed."
 				      : "BTF is optional, ignoring.");
 		if (!btf_mandatory)
@@ -3882,6 +3937,18 @@ static int probe_kern_btf_datasec(void)
 					     strs, sizeof(strs)));
 }
 
+static int probe_kern_btf_float(void)
+{
+	static const char strs[] = "\0float";
+	__u32 types[] = {
+		/* float */
+		BTF_TYPE_FLOAT_ENC(1, 4),
+	};
+
+	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
+					     strs, sizeof(strs)));
+}
+
 static int probe_kern_array_mmap(void)
 {
 	struct bpf_create_map_attr attr = {
@@ -4061,6 +4128,9 @@ static struct kern_feature_desc {
 	[FEAT_MODULE_BTF] = {
 		"module BTF support", probe_module_btf,
 	},
+	[FEAT_BTF_FLOAT] = {
+		"BTF_KIND_FLOAT support", probe_kern_btf_float,
+	},
 };
 
 static bool kernel_supports(enum kern_feature_id feat_id)
@@ -4940,6 +5010,8 @@ static int bpf_core_fields_are_compat(const struct btf *local_btf,
 		local_id = btf_array(local_type)->type;
 		targ_id = btf_array(targ_type)->type;
 		goto recur;
+	case BTF_KIND_FLOAT:
+		return local_type->size == targ_type->size;
 	default:
 		pr_warn("unexpected kind %d relocated, local [%d], target [%d]\n",
 			btf_kind(local_type), local_id, targ_id);
@@ -5122,6 +5194,8 @@ static int bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id
 		skip_mods_and_typedefs(targ_btf, targ_type->type, &targ_id);
 		goto recur;
 	}
+	case BTF_KIND_FLOAT:
+		return local_type->size == targ_type->size;
 	default:
 		pr_warn("unexpected kind %s relocated, local [%d], target [%d]\n",
 			btf_kind_str(local_type), local_id, targ_id);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 1c0fd2dd233a..ec898f464ab9 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -350,3 +350,8 @@ LIBBPF_0.3.0 {
 		xsk_setup_xdp_prog;
 		xsk_socket__update_xskmap;
 } LIBBPF_0.2.0;
+
+LIBBPF_0.4.0 {
+	global:
+		btf__add_float;
+} LIBBPF_0.3.0;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 969d0ac592ba..343f6eb05637 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -31,6 +31,8 @@
 #define BTF_MEMBER_ENC(name, type, bits_offset) (name), (type), (bits_offset)
 #define BTF_PARAM_ENC(name, type) (name), (type)
 #define BTF_VAR_SECINFO_ENC(type, offset, size) (type), (offset), (size)
+#define BTF_TYPE_FLOAT_ENC(name, sz) \
+	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_FLOAT, 0, 0), sz)
 
 #ifndef likely
 #define likely(x) __builtin_expect(!!(x), 1)
-- 
2.29.2


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC4231F404
	for <lists+bpf@lfdr.de>; Fri, 19 Feb 2021 03:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhBSC1O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Feb 2021 21:27:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29484 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229468AbhBSC1N (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Feb 2021 21:27:13 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11J2JoaZ008255;
        Thu, 18 Feb 2021 21:26:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=xaAVpRCtMyf/+SLa61sCfadyGz0D2bcGOg6zQeYKSqc=;
 b=RoViIUxOwwq8hFQF2zsj/kBXDYGnHo1DmN1s7RDDmWPxXx/FrpqIqmAlNFLUW5UFL5rX
 YBZGvIhfBmwxRQ7FnqxQCSnFrV1xwEmClmXkbz+s/xVP26oVYBfa4FVDMQGDjm+WPuB7
 235FIUriK6hqFaf7zdLLIkvg9v1rtepml/tWgyrSvzoaqWy14c8mJaywthLAk9G3byAX
 GB4sj8YzN9dXCjikvd7oiqEDss7LsDbU8SC9TVweBhqQCcs7XWQ/BpzDmjyB6OHWAGlD
 xCWHunqQbFo+CQg0yV5/o6u+D1BnaerSwEyxTTcZz+APpHbAokAasQYHCUaTqpOO0Tnf ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36t4ep02hf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 21:26:18 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11J2LUGo010908;
        Thu, 18 Feb 2021 21:26:17 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36t4ep02h2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 21:26:17 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11J2LoY8019402;
        Fri, 19 Feb 2021 02:26:15 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 36p6d8aq4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 02:26:15 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11J2QCKa33227056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 02:26:12 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8EA85A4053;
        Fri, 19 Feb 2021 02:26:12 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08873A4040;
        Fri, 19 Feb 2021 02:26:12 +0000 (GMT)
Received: from vm.lan (unknown [9.145.178.56])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 19 Feb 2021 02:26:11 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 bpf-next 2/6] libbpf: Add BTF_KIND_FLOAT support
Date:   Fri, 19 Feb 2021 03:25:39 +0100
Message-Id: <20210219022543.20893-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210219022543.20893-1-iii@linux.ibm.com>
References: <20210219022543.20893-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_14:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 phishscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190007
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The logic follows that of BTF_KIND_INT most of the time. Sanitization
replaces BTF_KIND_FLOATs with BTF_KIND_TYPEDEFs pointing to
equally-sized BTF_KIND_ARRAYs on older kernels.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/btf.c             | 44 ++++++++++++++++++++++++++++++++
 tools/lib/bpf/btf.h             |  8 ++++++
 tools/lib/bpf/btf_dump.c        |  4 +++
 tools/lib/bpf/libbpf.c          | 45 ++++++++++++++++++++++++++++++++-
 tools/lib/bpf/libbpf.map        |  5 ++++
 tools/lib/bpf/libbpf_internal.h |  2 ++
 6 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index d9c10830d749..07a30e98c3de 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -291,6 +291,7 @@ static int btf_type_size(const struct btf_type *t)
 	case BTF_KIND_PTR:
 	case BTF_KIND_TYPEDEF:
 	case BTF_KIND_FUNC:
+	case BTF_KIND_FLOAT:
 		return base_size;
 	case BTF_KIND_INT:
 		return base_size + sizeof(__u32);
@@ -338,6 +339,7 @@ static int btf_bswap_type_rest(struct btf_type *t)
 	case BTF_KIND_PTR:
 	case BTF_KIND_TYPEDEF:
 	case BTF_KIND_FUNC:
+	case BTF_KIND_FLOAT:
 		return 0;
 	case BTF_KIND_INT:
 		*(__u32 *)(t + 1) = bswap_32(*(__u32 *)(t + 1));
@@ -578,6 +580,7 @@ __s64 btf__resolve_size(const struct btf *btf, __u32 type_id)
 		case BTF_KIND_UNION:
 		case BTF_KIND_ENUM:
 		case BTF_KIND_DATASEC:
+		case BTF_KIND_FLOAT:
 			size = t->size;
 			goto done;
 		case BTF_KIND_PTR:
@@ -621,6 +624,7 @@ int btf__align_of(const struct btf *btf, __u32 id)
 	switch (kind) {
 	case BTF_KIND_INT:
 	case BTF_KIND_ENUM:
+	case BTF_KIND_FLOAT:
 		return min(btf_ptr_sz(btf), (size_t)t->size);
 	case BTF_KIND_PTR:
 		return btf_ptr_sz(btf);
@@ -2373,6 +2377,42 @@ int btf__add_datasec(struct btf *btf, const char *name, __u32 byte_sz)
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
@@ -3626,6 +3666,7 @@ static int btf_dedup_prep(struct btf_dedup *d)
 		case BTF_KIND_FWD:
 		case BTF_KIND_TYPEDEF:
 		case BTF_KIND_FUNC:
+		case BTF_KIND_FLOAT:
 			h = btf_hash_common(t);
 			break;
 		case BTF_KIND_INT:
@@ -3722,6 +3763,7 @@ static int btf_dedup_prim_type(struct btf_dedup *d, __u32 type_id)
 		break;
 
 	case BTF_KIND_FWD:
+	case BTF_KIND_FLOAT:
 		h = btf_hash_common(t);
 		for_each_dedup_cand(d, hash_entry, h) {
 			cand_id = (__u32)(long)hash_entry->value;
@@ -3983,6 +4025,7 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
 			return btf_compat_enum(cand_type, canon_type);
 
 	case BTF_KIND_FWD:
+	case BTF_KIND_FLOAT:
 		return btf_equal_common(cand_type, canon_type);
 
 	case BTF_KIND_CONST:
@@ -4479,6 +4522,7 @@ static int btf_dedup_remap_type(struct btf_dedup *d, __u32 type_id)
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
index d43cc3f29dae..3b170066d613 100644
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
@@ -2384,18 +2387,22 @@ static bool btf_needs_sanitization(struct bpf_object *obj)
 {
 	bool has_func_global = kernel_supports(FEAT_BTF_GLOBAL_FUNC);
 	bool has_datasec = kernel_supports(FEAT_BTF_DATASEC);
+	bool has_float = kernel_supports(FEAT_BTF_FLOAT);
 	bool has_func = kernel_supports(FEAT_BTF_FUNC);
 
-	return !has_func || !has_datasec || !has_func_global;
+	return !has_func || !has_datasec || !has_func_global || !has_float;
 }
 
 static void bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
 {
 	bool has_func_global = kernel_supports(FEAT_BTF_GLOBAL_FUNC);
 	bool has_datasec = kernel_supports(FEAT_BTF_DATASEC);
+	bool has_float = kernel_supports(FEAT_BTF_FLOAT);
 	bool has_func = kernel_supports(FEAT_BTF_FUNC);
 	struct btf_type *t;
 	int i, j, vlen;
+	int t_u32 = 0;
+	int t_u8 = 0;
 
 	for (i = 1; i <= btf__get_nr_types(btf); i++) {
 		t = (struct btf_type *)btf__type_by_id(btf, i);
@@ -2445,6 +2452,23 @@ static void bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
 		} else if (!has_func_global && btf_is_func(t)) {
 			/* replace BTF_FUNC_GLOBAL with BTF_FUNC_STATIC */
 			t->info = BTF_INFO_ENC(BTF_KIND_FUNC, 0, 0);
+		} else if (!has_float && btf_is_float(t)) {
+			/* replace FLOAT with TYPEDEF(u8[]) */
+			int t_array;
+			__u32 size;
+
+			size = t->size;
+			if (!t_u8)
+				t_u8 = btf__add_int(btf, "u8", 1, 0);
+			if (!t_u32)
+				t_u32 = btf__add_int(btf, "u32", 4, 0);
+			t_array = btf__add_array(btf, t_u32, t_u8, size);
+
+			/* adding new types may have invalidated t */
+			t = (struct btf_type *)btf__type_by_id(btf, i);
+
+			t->info = BTF_INFO_ENC(BTF_KIND_TYPEDEF, 0, 0);
+			t->type = t_array;
 		}
 	}
 }
@@ -3882,6 +3906,18 @@ static int probe_kern_btf_datasec(void)
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
@@ -4061,6 +4097,9 @@ static struct kern_feature_desc {
 	[FEAT_MODULE_BTF] = {
 		"module BTF support", probe_module_btf,
 	},
+	[FEAT_BTF_FLOAT] = {
+		"BTF_KIND_FLOAT support", probe_kern_btf_float,
+	},
 };
 
 static bool kernel_supports(enum kern_feature_id feat_id)
@@ -4940,6 +4979,8 @@ static int bpf_core_fields_are_compat(const struct btf *local_btf,
 		local_id = btf_array(local_type)->type;
 		targ_id = btf_array(targ_type)->type;
 		goto recur;
+	case BTF_KIND_FLOAT:
+		return local_type->size == targ_type->size;
 	default:
 		pr_warn("unexpected kind %d relocated, local [%d], target [%d]\n",
 			btf_kind(local_type), local_id, targ_id);
@@ -5122,6 +5163,8 @@ static int bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id
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


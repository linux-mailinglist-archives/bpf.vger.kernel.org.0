Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E5331C4E2
	for <lists+bpf@lfdr.de>; Tue, 16 Feb 2021 02:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbhBPBNt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Feb 2021 20:13:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19378 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229708AbhBPBNs (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 15 Feb 2021 20:13:48 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11G11lEo003444;
        Mon, 15 Feb 2021 20:12:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=/6Qd35lk5aEpS7qUbvqhmr9wyfLKAPzwR1I9Q1iiqn8=;
 b=YG3I2EEbQ0mvgi+GU2n/r8FxsT8YjKE7Y4deCRqpWvoTiuc4xOfQQZu/3E71A/CTZmwc
 qsk0TmN1sCE58QI2emt0NrXOuM/Jh8t7s2XCm+tzdlDhfg4q5FkQQOohPHXPlPrFd+HZ
 EmnnGtiOsj9OteBkTTNmqpz37WzB5CsRnwp/pv8OiSwScuIVtipUB6WI0F/jSOjDQgdP
 GIZUKpLXMAKITaTjC7kaaomT4YmU3glKfw+/VtdODxv0gwUdyB3LOfr9ir3XiIM0K3WN
 6P67sp4ITQgkZZmal4Rh9TydMFJaBL7qXg9H0ZEKARe2L7/6oTImrthHIFDpN82yYTIU Og== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36r27fjqjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 20:12:46 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11G12uN8007071;
        Mon, 15 Feb 2021 20:12:46 -0500
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36r27fjqjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 20:12:46 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11G1CaPU031341;
        Tue, 16 Feb 2021 01:12:44 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 36p6d896m1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Feb 2021 01:12:44 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11G1CfbK42467750
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Feb 2021 01:12:41 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 729C611C04A;
        Tue, 16 Feb 2021 01:12:41 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7840611C050;
        Tue, 16 Feb 2021 01:12:40 +0000 (GMT)
Received: from vm.lan (unknown [9.171.16.112])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 16 Feb 2021 01:12:40 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 2/6] libbpf: Add BTF_KIND_FLOAT support
Date:   Tue, 16 Feb 2021 02:12:12 +0100
Message-Id: <20210216011216.3168-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210216011216.3168-1-iii@linux.ibm.com>
References: <20210216011216.3168-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-15_16:2021-02-12,2021-02-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 impostorscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102160003
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The logic follows that of BTF_KIND_INT most of the time. Sanitization
replaces BTF_KIND_FLOATs with equally-sized BTF_KIND_INTs on older
kernels.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/btf.c             | 44 +++++++++++++++++++++++++++++++++
 tools/lib/bpf/btf.h             |  8 ++++++
 tools/lib/bpf/btf_dump.c        |  4 +++
 tools/lib/bpf/libbpf.c          | 29 +++++++++++++++++++++-
 tools/lib/bpf/libbpf.map        |  5 ++++
 tools/lib/bpf/libbpf_internal.h |  2 ++
 6 files changed, 91 insertions(+), 1 deletion(-)

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
index d43cc3f29dae..703988d68e73 100644
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
@@ -2384,15 +2387,17 @@ static bool btf_needs_sanitization(struct bpf_object *obj)
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
@@ -2445,6 +2450,9 @@ static void bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
 		} else if (!has_func_global && btf_is_func(t)) {
 			/* replace BTF_FUNC_GLOBAL with BTF_FUNC_STATIC */
 			t->info = BTF_INFO_ENC(BTF_KIND_FUNC, 0, 0);
+		} else if (!has_float && btf_is_float(t)) {
+			/* replace FLOAT with INT */
+			t->info = BTF_INFO_ENC(BTF_KIND_FLOAT, 0, 0);
 		}
 	}
 }
@@ -3882,6 +3890,18 @@ static int probe_kern_btf_datasec(void)
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
@@ -4061,6 +4081,9 @@ static struct kern_feature_desc {
 	[FEAT_MODULE_BTF] = {
 		"module BTF support", probe_module_btf,
 	},
+	[FEAT_BTF_FLOAT] = {
+		"BTF_KIND_FLOAT support", probe_kern_btf_float,
+	},
 };
 
 static bool kernel_supports(enum kern_feature_id feat_id)
@@ -4940,6 +4963,8 @@ static int bpf_core_fields_are_compat(const struct btf *local_btf,
 		local_id = btf_array(local_type)->type;
 		targ_id = btf_array(targ_type)->type;
 		goto recur;
+	case BTF_KIND_FLOAT:
+		return local_type->size == targ_type->size;
 	default:
 		pr_warn("unexpected kind %d relocated, local [%d], target [%d]\n",
 			btf_kind(local_type), local_id, targ_id);
@@ -5122,6 +5147,8 @@ static int bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id
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


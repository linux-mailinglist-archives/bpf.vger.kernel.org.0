Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB2232479E
	for <lists+bpf@lfdr.de>; Thu, 25 Feb 2021 00:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbhBXXqw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Feb 2021 18:46:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52498 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233791AbhBXXqv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Feb 2021 18:46:51 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11ONXZvO008151;
        Wed, 24 Feb 2021 18:45:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=bRelzKSfsN5o4t4N0AtCS6sNxAeIDmRBPc3wIgUkgTk=;
 b=sbaYZWYy1lknAtC+uHHuilZbeYBGULYqXYdyouBdZlwk7buSwr9v5l5nn/kSTjRmYGow
 CFrZphNI+Nopj9CUqdwAnMnBW1AoFya5PY/HWC/FzkyOncTyHp0jGHj86rohOus4Ip+6
 O1sgvMWiNuqMySzCYmxuTOOy3MQmZBMjM3uVHWiWmn0c/H1q5CkkLvZ83OT2eVtNwNJ3
 Y/a4X3VL3Zm7ncfJb1HgMRsoSxBHhljZfQC3ZdQKBeAsbh+FxnX/IUACW2ZRus1E5wAu
 sn0X0pF0L3/YF22L9tVgcsB7YbSUpBSv4fYFCya9Yuiep86M1EqSv3YW96WpGsqB2BQ9 KA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36wvsey8b1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 18:45:53 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11ONaL1e018127;
        Wed, 24 Feb 2021 18:45:53 -0500
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36wvsey8a4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 18:45:53 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11ONiIfU005533;
        Wed, 24 Feb 2021 23:45:51 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 36tspha3b1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 23:45:51 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11ONjZG033358290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 23:45:35 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69FE442041;
        Wed, 24 Feb 2021 23:45:48 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D54C94203F;
        Wed, 24 Feb 2021 23:45:47 +0000 (GMT)
Received: from vm.lan (unknown [9.145.151.190])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 24 Feb 2021 23:45:47 +0000 (GMT)
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
Subject: [PATCH v6 bpf-next 3/9] libbpf: Add BTF_KIND_FLOAT support
Date:   Thu, 25 Feb 2021 00:45:29 +0100
Message-Id: <20210224234535.106970-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224234535.106970-1-iii@linux.ibm.com>
References: <20210224234535.106970-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-24_13:2021-02-24,2021-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 phishscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240184
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The logic follows that of BTF_KIND_INT most of the time. Sanitization
replaces BTF_KIND_FLOATs with equally-sized empty BTF_KIND_STRUCTs on
older kernels, for example, the following:

    [4] FLOAT 'float' size=4

becomes the following:

    [4] STRUCT '(anon)' size=4 vlen=0

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/btf.c             | 49 +++++++++++++++++++++++++++++++++
 tools/lib/bpf/btf.h             |  6 ++++
 tools/lib/bpf/btf_dump.c        |  4 +++
 tools/lib/bpf/libbpf.c          | 26 ++++++++++++++++-
 tools/lib/bpf/libbpf.map        |  5 ++++
 tools/lib/bpf/libbpf_internal.h |  2 ++
 6 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 313f62a78626..488464307c0f 100644
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
@@ -1783,6 +1787,47 @@ int btf__add_int(struct btf *btf, const char *name, size_t byte_sz, int encoding
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
+	/* byte_sz must be one of the explicitly allowed values */
+	if (byte_sz != 2 && byte_sz != 4 && byte_sz != 8 && byte_sz != 12 &&
+	    byte_sz != 16)
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
 /* it's completely legal to append BTF types with type IDs pointing forward to
  * types that haven't been appended yet, so we only make sure that id looks
  * sane, we can't guarantee that ID will always be valid
@@ -3653,6 +3698,7 @@ static int btf_dedup_prep(struct btf_dedup *d)
 		case BTF_KIND_FWD:
 		case BTF_KIND_TYPEDEF:
 		case BTF_KIND_FUNC:
+		case BTF_KIND_FLOAT:
 			h = btf_hash_common(t);
 			break;
 		case BTF_KIND_INT:
@@ -3749,6 +3795,7 @@ static int btf_dedup_prim_type(struct btf_dedup *d, __u32 type_id)
 		break;
 
 	case BTF_KIND_FWD:
+	case BTF_KIND_FLOAT:
 		h = btf_hash_common(t);
 		for_each_dedup_cand(d, hash_entry, h) {
 			cand_id = (__u32)(long)hash_entry->value;
@@ -4010,6 +4057,7 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
 			return btf_compat_enum(cand_type, canon_type);
 
 	case BTF_KIND_FWD:
+	case BTF_KIND_FLOAT:
 		return btf_equal_common(cand_type, canon_type);
 
 	case BTF_KIND_CONST:
@@ -4506,6 +4554,7 @@ static int btf_dedup_remap_type(struct btf_dedup *d, __u32 type_id)
 	switch (btf_kind(t)) {
 	case BTF_KIND_INT:
 	case BTF_KIND_ENUM:
+	case BTF_KIND_FLOAT:
 		break;
 
 	case BTF_KIND_FWD:
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 1237bcd1dd17..029a9cfc8c2d 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -95,6 +95,7 @@ LIBBPF_API int btf__find_str(struct btf *btf, const char *s);
 LIBBPF_API int btf__add_str(struct btf *btf, const char *s);
 
 LIBBPF_API int btf__add_int(struct btf *btf, const char *name, size_t byte_sz, int encoding);
+LIBBPF_API int btf__add_float(struct btf *btf, const char *name, size_t byte_sz);
 LIBBPF_API int btf__add_ptr(struct btf *btf, int ref_type_id);
 LIBBPF_API int btf__add_array(struct btf *btf,
 			      int index_type_id, int elem_type_id, __u32 nr_elems);
@@ -294,6 +295,11 @@ static inline bool btf_is_datasec(const struct btf_type *t)
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
index d43cc3f29dae..d3ccd2aec6d2 100644
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
@@ -2445,6 +2450,10 @@ static void bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
 		} else if (!has_func_global && btf_is_func(t)) {
 			/* replace BTF_FUNC_GLOBAL with BTF_FUNC_STATIC */
 			t->info = BTF_INFO_ENC(BTF_KIND_FUNC, 0, 0);
+		} else if (!has_float && btf_is_float(t)) {
+			/* replace FLOAT with an equally-sized empty STRUCT */
+			t->name_off = 0;
+			t->info = BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 0);
 		}
 	}
 }
@@ -3882,6 +3891,18 @@ static int probe_kern_btf_datasec(void)
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
@@ -4061,6 +4082,9 @@ static struct kern_feature_desc {
 	[FEAT_MODULE_BTF] = {
 		"module BTF support", probe_module_btf,
 	},
+	[FEAT_BTF_FLOAT] = {
+		"BTF_KIND_FLOAT support", probe_kern_btf_float,
+	},
 };
 
 static bool kernel_supports(enum kern_feature_id feat_id)
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


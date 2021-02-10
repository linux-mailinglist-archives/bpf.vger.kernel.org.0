Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232CE315DB3
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 04:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbhBJDFF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 22:05:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30838 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233598AbhBJDE7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Feb 2021 22:04:59 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11A31E4K003110;
        Tue, 9 Feb 2021 22:03:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=mWoLhbE5+q/xsL0uTCNcnak+2c5X+CFrlU1CfQwv3fU=;
 b=erYmde3Rugg3XdpFFEaP13/yVOpBhQLxjNj3uZNix4KOBVj7JHKQfDQqrPdnSN2H67qY
 +8dlc3gI72MIlRp+TgNdaZA06uZU+rH6k3wGoY5Sf+TB7afsCFSm6Yw9i4zAu1nTQktf
 ULvTCB/HGu3f7qugbC/tQb7rDJ5dRS/1Oyq/VsxcKWiTDm4l+e1hrAt0+PSjqYLsNyTG
 5gcAGkMom8HpFsAylChchTVJUceZIFYo7vSWR8jspbhX00no7/a5spVZG9+5xGF2fxO+
 T3HO6IBiYjDWLTO8h9rcjwVJv+dtwZUvWcFKhwwB1Y4Klm3JFrR5IoGr6qIRr/PNW7Yp OA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36m6ax9b38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 22:03:47 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11A31UIB005462;
        Tue, 9 Feb 2021 22:03:46 -0500
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36m6ax9b29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 22:03:46 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11A33iI0016235;
        Wed, 10 Feb 2021 03:03:44 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 36hjch267q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 03:03:44 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11A33fgv61407582
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 03:03:41 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA27AA4040;
        Wed, 10 Feb 2021 03:03:41 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46974A4053;
        Wed, 10 Feb 2021 03:03:41 +0000 (GMT)
Received: from vm.lan (unknown [9.171.67.27])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 10 Feb 2021 03:03:41 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH RFC 2/6] libbpf: Add BTF_KIND_FLOAT support
Date:   Wed, 10 Feb 2021 04:03:13 +0100
Message-Id: <20210210030317.78820-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210210030317.78820-1-iii@linux.ibm.com>
References: <20210210030317.78820-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_08:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100025
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The logic follows that of BTF_KIND_INT most of the time, some functions
are even unified to work on both. Sanitization replaces BTF_KIND_FLOATs
with equally-sized BTF_KIND_INTs on older kernels.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/btf.c             | 85 +++++++++++++++++++++++----------
 tools/lib/bpf/btf.h             | 13 +++++
 tools/lib/bpf/btf_dump.c        |  4 ++
 tools/lib/bpf/libbpf.c          | 32 ++++++++++++-
 tools/lib/bpf/libbpf.map        |  5 ++
 tools/lib/bpf/libbpf_internal.h |  4 ++
 6 files changed, 118 insertions(+), 25 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index d9c10830d749..0cc91e94f7c3 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -293,6 +293,7 @@ static int btf_type_size(const struct btf_type *t)
 	case BTF_KIND_FUNC:
 		return base_size;
 	case BTF_KIND_INT:
+	case BTF_KIND_FLOAT:
 		return base_size + sizeof(__u32);
 	case BTF_KIND_ENUM:
 		return base_size + vlen * sizeof(struct btf_enum);
@@ -340,6 +341,7 @@ static int btf_bswap_type_rest(struct btf_type *t)
 	case BTF_KIND_FUNC:
 		return 0;
 	case BTF_KIND_INT:
+	case BTF_KIND_FLOAT:
 		*(__u32 *)(t + 1) = bswap_32(*(__u32 *)(t + 1));
 		return 0;
 	case BTF_KIND_ENUM:
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
@@ -1707,16 +1711,8 @@ static int btf_commit_type(struct btf *btf, int data_sz)
 	return btf->start_id + btf->nr_types - 1;
 }
 
-/*
- * Append new BTF_KIND_INT type with:
- *   - *name* - non-empty, non-NULL type name;
- *   - *sz* - power-of-2 (1, 2, 4, ..) size of the type, in bytes;
- *   - encoding is a combination of BTF_INT_SIGNED, BTF_INT_CHAR, BTF_INT_BOOL.
- * Returns:
- *   - >0, type ID of newly added BTF type;
- *   - <0, on error.
- */
-int btf__add_int(struct btf *btf, const char *name, size_t byte_sz, int encoding)
+static int btf_add_int_float(struct btf *btf, int kind, const char *name,
+			     size_t byte_sz, int encoding)
 {
 	struct btf_type *t;
 	int sz, name_off;
@@ -1724,10 +1720,13 @@ int btf__add_int(struct btf *btf, const char *name, size_t byte_sz, int encoding
 	/* non-empty name */
 	if (!name || !name[0])
 		return -EINVAL;
-	/* byte_sz must be power of 2 */
-	if (!byte_sz || (byte_sz & (byte_sz - 1)) || byte_sz > 16)
+	/* BTF_KIND_INT's byte_sz must be power of 2 */
+	if (!byte_sz ||
+	    (kind == BTF_KIND_INT && (byte_sz & (byte_sz - 1))) ||
+	    byte_sz > 16)
 		return -EINVAL;
-	if (encoding & ~(BTF_INT_SIGNED | BTF_INT_CHAR | BTF_INT_BOOL))
+	if (kind == BTF_KIND_INT &&
+	    (encoding & ~(BTF_INT_SIGNED | BTF_INT_CHAR | BTF_INT_BOOL)))
 		return -EINVAL;
 
 	/* deconstruct BTF, if necessary, and invalidate raw_data */
@@ -1748,14 +1747,35 @@ int btf__add_int(struct btf *btf, const char *name, size_t byte_sz, int encoding
 		return name_off;
 
 	t->name_off = name_off;
-	t->info = btf_type_info(BTF_KIND_INT, 0, 0);
+	t->info = btf_type_info(kind, 0, 0);
 	t->size = byte_sz;
-	/* set INT info, we don't allow setting legacy bit offset/size */
-	*(__u32 *)(t + 1) = (encoding << 24) | (byte_sz * 8);
+	if (kind == BTF_KIND_INT)
+		/* set INT info, we don't allow setting legacy bit offset/size
+		 */
+		*(__u32 *)(t + 1) = (encoding << 24) | (byte_sz * 8);
+	else if (kind == BTF_KIND_FLOAT)
+		/* set FLOAT info */
+		*(__u32 *)(t + 1) = byte_sz * 8;
+	else
+		return -EINVAL;
 
 	return btf_commit_type(btf, sz);
 }
 
+/*
+ * Append new BTF_KIND_INT type with:
+ *   - *name* - non-empty, non-NULL type name;
+ *   - *sz* - power-of-2 (1, 2, 4, ..) size of the type, in bytes;
+ *   - encoding is a combination of BTF_INT_SIGNED, BTF_INT_CHAR, BTF_INT_BOOL.
+ * Returns:
+ *   - >0, type ID of newly added BTF type;
+ *   - <0, on error.
+ */
+int btf__add_int(struct btf *btf, const char *name, size_t byte_sz, int encoding)
+{
+	return btf_add_int_float(btf, BTF_KIND_INT, name, byte_sz, encoding);
+}
+
 /* it's completely legal to append BTF types with type IDs pointing forward to
  * types that haven't been appended yet, so we only make sure that id looks
  * sane, we can't guarantee that ID will always be valid
@@ -2373,6 +2393,19 @@ int btf__add_datasec(struct btf *btf, const char *name, __u32 byte_sz)
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
+	return btf_add_int_float(btf, BTF_KIND_FLOAT, name, byte_sz, 0);
+}
+
 /*
  * Append new data section variable information entry for current DATASEC type:
  *   - *var_type_id* - type ID, describing type of the variable;
@@ -3351,8 +3384,8 @@ static bool btf_equal_common(struct btf_type *t1, struct btf_type *t2)
 	       t1->size == t2->size;
 }
 
-/* Calculate type signature hash of INT. */
-static long btf_hash_int(struct btf_type *t)
+/* Calculate type signature hash of an INT or a FLOAT. */
+static long btf_hash_int_float(struct btf_type *t)
 {
 	__u32 info = *(__u32 *)(t + 1);
 	long h;
@@ -3362,8 +3395,8 @@ static long btf_hash_int(struct btf_type *t)
 	return h;
 }
 
-/* Check structural equality of two INTs. */
-static bool btf_equal_int(struct btf_type *t1, struct btf_type *t2)
+/* Check structural equality of two INTs or two FLOATs. */
+static bool btf_equal_int_float(struct btf_type *t1, struct btf_type *t2)
 {
 	__u32 info1, info2;
 
@@ -3629,7 +3662,8 @@ static int btf_dedup_prep(struct btf_dedup *d)
 			h = btf_hash_common(t);
 			break;
 		case BTF_KIND_INT:
-			h = btf_hash_int(t);
+		case BTF_KIND_FLOAT:
+			h = btf_hash_int_float(t);
 			break;
 		case BTF_KIND_ENUM:
 			h = btf_hash_enum(t);
@@ -3687,11 +3721,12 @@ static int btf_dedup_prim_type(struct btf_dedup *d, __u32 type_id)
 		return 0;
 
 	case BTF_KIND_INT:
-		h = btf_hash_int(t);
+	case BTF_KIND_FLOAT:
+		h = btf_hash_int_float(t);
 		for_each_dedup_cand(d, hash_entry, h) {
 			cand_id = (__u32)(long)hash_entry->value;
 			cand = btf_type_by_id(d->btf, cand_id);
-			if (btf_equal_int(t, cand)) {
+			if (btf_equal_int_float(t, cand)) {
 				new_id = cand_id;
 				break;
 			}
@@ -3974,7 +4009,8 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
 
 	switch (cand_kind) {
 	case BTF_KIND_INT:
-		return btf_equal_int(cand_type, canon_type);
+	case BTF_KIND_FLOAT:
+		return btf_equal_int_float(cand_type, canon_type);
 
 	case BTF_KIND_ENUM:
 		if (d->opts.dont_resolve_fwds)
@@ -4479,6 +4515,7 @@ static int btf_dedup_remap_type(struct btf_dedup *d, __u32 type_id)
 	switch (btf_kind(t)) {
 	case BTF_KIND_INT:
 	case BTF_KIND_ENUM:
+	case BTF_KIND_FLOAT:
 		break;
 
 	case BTF_KIND_FWD:
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 1237bcd1dd17..0f38bdc375bc 100644
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
@@ -362,6 +370,11 @@ btf_var_secinfos(const struct btf_type *t)
 	return (struct btf_var_secinfo *)(t + 1);
 }
 
+static inline __u8 btf_float_bits(const struct btf_type *t)
+{
+	return BTF_FLOAT_BITS(*(__u32 *)(t + 1));
+}
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
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
index 2abbc3800568..ae1cdab156d6 100644
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
@@ -2445,6 +2450,12 @@ static void bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
 		} else if (!has_func_global && btf_is_func(t)) {
 			/* replace BTF_FUNC_GLOBAL with BTF_FUNC_STATIC */
 			t->info = BTF_INFO_ENC(BTF_KIND_FUNC, 0, 0);
+		} else if (!has_float && btf_is_float(t)) {
+			/* replace FLOAT with INT */
+			__u8 nr_bits = btf_float_bits(t);
+
+			t->info = BTF_INFO_ENC(BTF_KIND_INT, 0, 0);
+			*(int *)(t + 1) = BTF_INT_ENC(0, 0, nr_bits);
 		}
 	}
 }
@@ -3882,6 +3893,18 @@ static int probe_kern_btf_datasec(void)
 					     strs, sizeof(strs)));
 }
 
+static int probe_kern_btf_float(void)
+{
+	static const char strs[] = "\0float";
+	__u32 types[] = {
+		/* float */
+		BTF_TYPE_FLOAT_ENC(1, 32, 4),
+	};
+
+	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
+					     strs, sizeof(strs)));
+}
+
 static int probe_kern_array_mmap(void)
 {
 	struct bpf_create_map_attr attr = {
@@ -4061,6 +4084,9 @@ static struct kern_feature_desc {
 	[FEAT_MODULE_BTF] = {
 		"module BTF support", probe_module_btf,
 	},
+	[FEAT_BTF_FLOAT] = {
+		"BTF_KIND_FLOAT support", probe_kern_btf_float,
+	},
 };
 
 static bool kernel_supports(enum kern_feature_id feat_id)
@@ -4940,6 +4966,8 @@ static int bpf_core_fields_are_compat(const struct btf *local_btf,
 		local_id = btf_array(local_type)->type;
 		targ_id = btf_array(targ_type)->type;
 		goto recur;
+	case BTF_KIND_FLOAT:
+		return btf_float_bits(local_type) == btf_float_bits(targ_type);
 	default:
 		pr_warn("unexpected kind %d relocated, local [%d], target [%d]\n",
 			btf_kind(local_type), local_id, targ_id);
@@ -5122,6 +5150,8 @@ static int bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id
 		skip_mods_and_typedefs(targ_btf, targ_type->type, &targ_id);
 		goto recur;
 	}
+	case BTF_KIND_FLOAT:
+		return btf_float_bits(local_type) == btf_float_bits(targ_type);
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
index 969d0ac592ba..6e440b88c010 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -31,6 +31,10 @@
 #define BTF_MEMBER_ENC(name, type, bits_offset) (name), (type), (bits_offset)
 #define BTF_PARAM_ENC(name, type) (name), (type)
 #define BTF_VAR_SECINFO_ENC(type, offset, size) (type), (offset), (size)
+#define BTF_FLOAT_ENC(nr_bits) nr_bits
+#define BTF_TYPE_FLOAT_ENC(name, bits, sz)				\
+	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_FLOAT, 0, 0), sz),	\
+	BTF_FLOAT_ENC(bits)
 
 #ifndef likely
 #define likely(x) __builtin_expect(!!(x), 1)
-- 
2.29.2


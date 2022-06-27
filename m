Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC76E55CCC3
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 15:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238090AbiF0VSJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 27 Jun 2022 17:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237982AbiF0VSG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jun 2022 17:18:06 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9423BBC8
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 14:18:04 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25RJ1Qpr004938
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 14:18:03 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gx03ywdd8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 14:18:03 -0700
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub102.TheFacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 27 Jun 2022 14:18:02 -0700
Received: from twshared13315.14.prn3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 27 Jun 2022 14:18:02 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 1BB981BAC27C2; Mon, 27 Jun 2022 14:15:40 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 05/15] libbpf: remove deprecated BTF APIs
Date:   Mon, 27 Jun 2022 14:15:17 -0700
Message-ID: <20220627211527.2245459-6-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220627211527.2245459-1-andrii@kernel.org>
References: <20220627211527.2245459-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: CFJhVFso1B72tlX9ISSpJuanK_E-eByj
X-Proofpoint-ORIG-GUID: CFJhVFso1B72tlX9ISSpJuanK_E-eByj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-27_06,2022-06-24_01,2022-06-22_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Get rid of deprecated BTF-related APIs.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/btf.c      | 183 +--------------------------------------
 tools/lib/bpf/btf.h      |  86 +-----------------
 tools/lib/bpf/btf_dump.c |  23 ++---
 tools/lib/bpf/libbpf.c   |  44 +++-------
 tools/lib/bpf/libbpf.map |  13 ---
 5 files changed, 24 insertions(+), 325 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index ae1520f7e1b0..2d14f1a52d7a 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -448,11 +448,6 @@ static int btf_parse_type_sec(struct btf *btf)
 	return 0;
 }
 
-__u32 btf__get_nr_types(const struct btf *btf)
-{
-	return btf->start_id + btf->nr_types - 1;
-}
-
 __u32 btf__type_cnt(const struct btf *btf)
 {
 	return btf->start_id + btf->nr_types;
@@ -1408,92 +1403,6 @@ struct btf *btf__load_from_kernel_by_id(__u32 id)
 	return btf__load_from_kernel_by_id_split(id, NULL);
 }
 
-int btf__get_from_id(__u32 id, struct btf **btf)
-{
-	struct btf *res;
-	int err;
-
-	*btf = NULL;
-	res = btf__load_from_kernel_by_id(id);
-	err = libbpf_get_error(res);
-
-	if (err)
-		return libbpf_err(err);
-
-	*btf = res;
-	return 0;
-}
-
-int btf__get_map_kv_tids(const struct btf *btf, const char *map_name,
-			 __u32 expected_key_size, __u32 expected_value_size,
-			 __u32 *key_type_id, __u32 *value_type_id)
-{
-	const struct btf_type *container_type;
-	const struct btf_member *key, *value;
-	const size_t max_name = 256;
-	char container_name[max_name];
-	__s64 key_size, value_size;
-	__s32 container_id;
-
-	if (snprintf(container_name, max_name, "____btf_map_%s", map_name) == max_name) {
-		pr_warn("map:%s length of '____btf_map_%s' is too long\n",
-			map_name, map_name);
-		return libbpf_err(-EINVAL);
-	}
-
-	container_id = btf__find_by_name(btf, container_name);
-	if (container_id < 0) {
-		pr_debug("map:%s container_name:%s cannot be found in BTF. Missing BPF_ANNOTATE_KV_PAIR?\n",
-			 map_name, container_name);
-		return libbpf_err(container_id);
-	}
-
-	container_type = btf__type_by_id(btf, container_id);
-	if (!container_type) {
-		pr_warn("map:%s cannot find BTF type for container_id:%u\n",
-			map_name, container_id);
-		return libbpf_err(-EINVAL);
-	}
-
-	if (!btf_is_struct(container_type) || btf_vlen(container_type) < 2) {
-		pr_warn("map:%s container_name:%s is an invalid container struct\n",
-			map_name, container_name);
-		return libbpf_err(-EINVAL);
-	}
-
-	key = btf_members(container_type);
-	value = key + 1;
-
-	key_size = btf__resolve_size(btf, key->type);
-	if (key_size < 0) {
-		pr_warn("map:%s invalid BTF key_type_size\n", map_name);
-		return libbpf_err(key_size);
-	}
-
-	if (expected_key_size != key_size) {
-		pr_warn("map:%s btf_key_type_size:%u != map_def_key_size:%u\n",
-			map_name, (__u32)key_size, expected_key_size);
-		return libbpf_err(-EINVAL);
-	}
-
-	value_size = btf__resolve_size(btf, value->type);
-	if (value_size < 0) {
-		pr_warn("map:%s invalid BTF value_type_size\n", map_name);
-		return libbpf_err(value_size);
-	}
-
-	if (expected_value_size != value_size) {
-		pr_warn("map:%s btf_value_type_size:%u != map_def_value_size:%u\n",
-			map_name, (__u32)value_size, expected_value_size);
-		return libbpf_err(-EINVAL);
-	}
-
-	*key_type_id = key->type;
-	*value_type_id = value->type;
-
-	return 0;
-}
-
 static void btf_invalidate_raw_data(struct btf *btf)
 {
 	if (btf->raw_data) {
@@ -2965,81 +2874,6 @@ const void *btf_ext__get_raw_data(const struct btf_ext *btf_ext, __u32 *size)
 	return btf_ext->data;
 }
 
-static int btf_ext_reloc_info(const struct btf *btf,
-			      const struct btf_ext_info *ext_info,
-			      const char *sec_name, __u32 insns_cnt,
-			      void **info, __u32 *cnt)
-{
-	__u32 sec_hdrlen = sizeof(struct btf_ext_info_sec);
-	__u32 i, record_size, existing_len, records_len;
-	struct btf_ext_info_sec *sinfo;
-	const char *info_sec_name;
-	__u64 remain_len;
-	void *data;
-
-	record_size = ext_info->rec_size;
-	sinfo = ext_info->info;
-	remain_len = ext_info->len;
-	while (remain_len > 0) {
-		records_len = sinfo->num_info * record_size;
-		info_sec_name = btf__name_by_offset(btf, sinfo->sec_name_off);
-		if (strcmp(info_sec_name, sec_name)) {
-			remain_len -= sec_hdrlen + records_len;
-			sinfo = (void *)sinfo + sec_hdrlen + records_len;
-			continue;
-		}
-
-		existing_len = (*cnt) * record_size;
-		data = realloc(*info, existing_len + records_len);
-		if (!data)
-			return libbpf_err(-ENOMEM);
-
-		memcpy(data + existing_len, sinfo->data, records_len);
-		/* adjust insn_off only, the rest data will be passed
-		 * to the kernel.
-		 */
-		for (i = 0; i < sinfo->num_info; i++) {
-			__u32 *insn_off;
-
-			insn_off = data + existing_len + (i * record_size);
-			*insn_off = *insn_off / sizeof(struct bpf_insn) + insns_cnt;
-		}
-		*info = data;
-		*cnt += sinfo->num_info;
-		return 0;
-	}
-
-	return libbpf_err(-ENOENT);
-}
-
-int btf_ext__reloc_func_info(const struct btf *btf,
-			     const struct btf_ext *btf_ext,
-			     const char *sec_name, __u32 insns_cnt,
-			     void **func_info, __u32 *cnt)
-{
-	return btf_ext_reloc_info(btf, &btf_ext->func_info, sec_name,
-				  insns_cnt, func_info, cnt);
-}
-
-int btf_ext__reloc_line_info(const struct btf *btf,
-			     const struct btf_ext *btf_ext,
-			     const char *sec_name, __u32 insns_cnt,
-			     void **line_info, __u32 *cnt)
-{
-	return btf_ext_reloc_info(btf, &btf_ext->line_info, sec_name,
-				  insns_cnt, line_info, cnt);
-}
-
-__u32 btf_ext__func_info_rec_size(const struct btf_ext *btf_ext)
-{
-	return btf_ext->func_info.rec_size;
-}
-
-__u32 btf_ext__line_info_rec_size(const struct btf_ext *btf_ext)
-{
-	return btf_ext->line_info.rec_size;
-}
-
 struct btf_dedup;
 
 static struct btf_dedup *btf_dedup_new(struct btf *btf, const struct btf_dedup_opts *opts);
@@ -3189,9 +3023,7 @@ static int btf_dedup_remap_types(struct btf_dedup *d);
  * deduplicating structs/unions is described in greater details in comments for
  * `btf_dedup_is_equiv` function.
  */
-
-DEFAULT_VERSION(btf__dedup_v0_6_0, btf__dedup, LIBBPF_0.6.0)
-int btf__dedup_v0_6_0(struct btf *btf, const struct btf_dedup_opts *opts)
+int btf__dedup(struct btf *btf, const struct btf_dedup_opts *opts)
 {
 	struct btf_dedup *d;
 	int err;
@@ -3251,19 +3083,6 @@ int btf__dedup_v0_6_0(struct btf *btf, const struct btf_dedup_opts *opts)
 	return libbpf_err(err);
 }
 
-COMPAT_VERSION(btf__dedup_deprecated, btf__dedup, LIBBPF_0.0.2)
-int btf__dedup_deprecated(struct btf *btf, struct btf_ext *btf_ext, const void *unused_opts)
-{
-	LIBBPF_OPTS(btf_dedup_opts, opts, .btf_ext = btf_ext);
-
-	if (unused_opts) {
-		pr_warn("please use new version of btf__dedup() that supports options\n");
-		return libbpf_err(-ENOTSUP);
-	}
-
-	return btf__dedup(btf, &opts);
-}
-
 #define BTF_UNPROCESSED_ID ((__u32)-1)
 #define BTF_IN_PROGRESS_ID ((__u32)-2)
 
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 9fb416eb5644..583760df83b4 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -120,20 +120,12 @@ LIBBPF_API struct btf *libbpf_find_kernel_btf(void);
 
 LIBBPF_API struct btf *btf__load_from_kernel_by_id(__u32 id);
 LIBBPF_API struct btf *btf__load_from_kernel_by_id_split(__u32 id, struct btf *base_btf);
-LIBBPF_DEPRECATED_SINCE(0, 6, "use btf__load_from_kernel_by_id instead")
-LIBBPF_API int btf__get_from_id(__u32 id, struct btf **btf);
 
-LIBBPF_DEPRECATED_SINCE(0, 6, "intended for internal libbpf use only")
-LIBBPF_API int btf__finalize_data(struct bpf_object *obj, struct btf *btf);
-LIBBPF_DEPRECATED_SINCE(0, 6, "use btf__load_into_kernel instead")
-LIBBPF_API int btf__load(struct btf *btf);
 LIBBPF_API int btf__load_into_kernel(struct btf *btf);
 LIBBPF_API __s32 btf__find_by_name(const struct btf *btf,
 				   const char *type_name);
 LIBBPF_API __s32 btf__find_by_name_kind(const struct btf *btf,
 					const char *type_name, __u32 kind);
-LIBBPF_DEPRECATED_SINCE(0, 7, "use btf__type_cnt() instead; note that btf__get_nr_types() == btf__type_cnt() - 1")
-LIBBPF_API __u32 btf__get_nr_types(const struct btf *btf);
 LIBBPF_API __u32 btf__type_cnt(const struct btf *btf);
 LIBBPF_API const struct btf *btf__base_btf(const struct btf *btf);
 LIBBPF_API const struct btf_type *btf__type_by_id(const struct btf *btf,
@@ -150,29 +142,10 @@ LIBBPF_API void btf__set_fd(struct btf *btf, int fd);
 LIBBPF_API const void *btf__raw_data(const struct btf *btf, __u32 *size);
 LIBBPF_API const char *btf__name_by_offset(const struct btf *btf, __u32 offset);
 LIBBPF_API const char *btf__str_by_offset(const struct btf *btf, __u32 offset);
-LIBBPF_DEPRECATED_SINCE(0, 7, "this API is not necessary when BTF-defined maps are used")
-LIBBPF_API int btf__get_map_kv_tids(const struct btf *btf, const char *map_name,
-				    __u32 expected_key_size,
-				    __u32 expected_value_size,
-				    __u32 *key_type_id, __u32 *value_type_id);
 
 LIBBPF_API struct btf_ext *btf_ext__new(const __u8 *data, __u32 size);
 LIBBPF_API void btf_ext__free(struct btf_ext *btf_ext);
 LIBBPF_API const void *btf_ext__raw_data(const struct btf_ext *btf_ext, __u32 *size);
-LIBBPF_API LIBBPF_DEPRECATED("btf_ext__reloc_func_info was never meant as a public API and has wrong assumptions embedded in it; it will be removed in the future libbpf versions")
-int btf_ext__reloc_func_info(const struct btf *btf,
-			     const struct btf_ext *btf_ext,
-			     const char *sec_name, __u32 insns_cnt,
-			     void **func_info, __u32 *cnt);
-LIBBPF_API LIBBPF_DEPRECATED("btf_ext__reloc_line_info was never meant as a public API and has wrong assumptions embedded in it; it will be removed in the future libbpf versions")
-int btf_ext__reloc_line_info(const struct btf *btf,
-			     const struct btf_ext *btf_ext,
-			     const char *sec_name, __u32 insns_cnt,
-			     void **line_info, __u32 *cnt);
-LIBBPF_API LIBBPF_DEPRECATED("btf_ext__reloc_func_info is deprecated; write custom func_info parsing to fetch rec_size")
-__u32 btf_ext__func_info_rec_size(const struct btf_ext *btf_ext);
-LIBBPF_API LIBBPF_DEPRECATED("btf_ext__reloc_line_info is deprecated; write custom line_info parsing to fetch rec_size")
-__u32 btf_ext__line_info_rec_size(const struct btf_ext *btf_ext);
 
 LIBBPF_API int btf__find_str(struct btf *btf, const char *s);
 LIBBPF_API int btf__add_str(struct btf *btf, const char *s);
@@ -259,22 +232,12 @@ struct btf_dedup_opts {
 
 LIBBPF_API int btf__dedup(struct btf *btf, const struct btf_dedup_opts *opts);
 
-LIBBPF_API int btf__dedup_v0_6_0(struct btf *btf, const struct btf_dedup_opts *opts);
-
-LIBBPF_DEPRECATED_SINCE(0, 7, "use btf__dedup() instead")
-LIBBPF_API int btf__dedup_deprecated(struct btf *btf, struct btf_ext *btf_ext, const void *opts);
-#define btf__dedup(...) ___libbpf_overload(___btf_dedup, __VA_ARGS__)
-#define ___btf_dedup3(btf, btf_ext, opts) btf__dedup_deprecated(btf, btf_ext, opts)
-#define ___btf_dedup2(btf, opts) btf__dedup(btf, opts)
-
 struct btf_dump;
 
 struct btf_dump_opts {
-	union {
-		size_t sz;
-		void *ctx; /* DEPRECATED: will be gone in v1.0 */
-	};
+	size_t sz;
 };
+#define btf_dump_opts__last_field sz
 
 typedef void (*btf_dump_printf_fn_t)(void *ctx, const char *fmt, va_list args);
 
@@ -283,51 +246,6 @@ LIBBPF_API struct btf_dump *btf_dump__new(const struct btf *btf,
 					  void *ctx,
 					  const struct btf_dump_opts *opts);
 
-LIBBPF_API struct btf_dump *btf_dump__new_v0_6_0(const struct btf *btf,
-						 btf_dump_printf_fn_t printf_fn,
-						 void *ctx,
-						 const struct btf_dump_opts *opts);
-
-LIBBPF_API struct btf_dump *btf_dump__new_deprecated(const struct btf *btf,
-						     const struct btf_ext *btf_ext,
-						     const struct btf_dump_opts *opts,
-						     btf_dump_printf_fn_t printf_fn);
-
-/* Choose either btf_dump__new() or btf_dump__new_deprecated() based on the
- * type of 4th argument. If it's btf_dump's print callback, use deprecated
- * API; otherwise, choose the new btf_dump__new(). ___libbpf_override()
- * doesn't work here because both variants have 4 input arguments.
- *
- * (void *) casts are necessary to avoid compilation warnings about type
- * mismatches, because even though __builtin_choose_expr() only ever evaluates
- * one side the other side still has to satisfy type constraints (this is
- * compiler implementation limitation which might be lifted eventually,
- * according to the documentation). So passing struct btf_ext in place of
- * btf_dump_printf_fn_t would be generating compilation warning.  Casting to
- * void * avoids this issue.
- *
- * Also, two type compatibility checks for a function and function pointer are
- * required because passing function reference into btf_dump__new() as
- * btf_dump__new(..., my_callback, ...) and as btf_dump__new(...,
- * &my_callback, ...) (not explicit ampersand in the latter case) actually
- * differs as far as __builtin_types_compatible_p() is concerned. Thus two
- * checks are combined to detect callback argument.
- *
- * The rest works just like in case of ___libbpf_override() usage with symbol
- * versioning.
- *
- * C++ compilers don't support __builtin_types_compatible_p(), so at least
- * don't screw up compilation for them and let C++ users pick btf_dump__new
- * vs btf_dump__new_deprecated explicitly.
- */
-#ifndef __cplusplus
-#define btf_dump__new(a1, a2, a3, a4) __builtin_choose_expr(				\
-	__builtin_types_compatible_p(typeof(a4), btf_dump_printf_fn_t) ||		\
-	__builtin_types_compatible_p(typeof(a4), void(void *, const char *, va_list)),	\
-	btf_dump__new_deprecated((void *)a1, (void *)a2, (void *)a3, (void *)a4),	\
-	btf_dump__new((void *)a1, (void *)a2, (void *)a3, (void *)a4))
-#endif
-
 LIBBPF_API void btf_dump__free(struct btf_dump *d);
 
 LIBBPF_API int btf_dump__dump_type(struct btf_dump *d, __u32 id);
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index f5275f819027..400e84fd0578 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -144,15 +144,17 @@ static void btf_dump_printf(const struct btf_dump *d, const char *fmt, ...)
 static int btf_dump_mark_referenced(struct btf_dump *d);
 static int btf_dump_resize(struct btf_dump *d);
 
-DEFAULT_VERSION(btf_dump__new_v0_6_0, btf_dump__new, LIBBPF_0.6.0)
-struct btf_dump *btf_dump__new_v0_6_0(const struct btf *btf,
-				      btf_dump_printf_fn_t printf_fn,
-				      void *ctx,
-				      const struct btf_dump_opts *opts)
+struct btf_dump *btf_dump__new(const struct btf *btf,
+			       btf_dump_printf_fn_t printf_fn,
+			       void *ctx,
+			       const struct btf_dump_opts *opts)
 {
 	struct btf_dump *d;
 	int err;
 
+	if (!OPTS_VALID(opts, btf_dump_opts))
+		return libbpf_err_ptr(-EINVAL);
+
 	if (!printf_fn)
 		return libbpf_err_ptr(-EINVAL);
 
@@ -188,17 +190,6 @@ struct btf_dump *btf_dump__new_v0_6_0(const struct btf *btf,
 	return libbpf_err_ptr(err);
 }
 
-COMPAT_VERSION(btf_dump__new_deprecated, btf_dump__new, LIBBPF_0.0.4)
-struct btf_dump *btf_dump__new_deprecated(const struct btf *btf,
-					  const struct btf_ext *btf_ext,
-					  const struct btf_dump_opts *opts,
-					  btf_dump_printf_fn_t printf_fn)
-{
-	if (!printf_fn)
-		return libbpf_err_ptr(-EINVAL);
-	return btf_dump__new_v0_6_0(btf, printf_fn, opts ? opts->ctx : NULL, opts);
-}
-
 static int btf_dump_resize(struct btf_dump *d)
 {
 	int err, last_id = btf__type_cnt(d->btf) - 1;
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b11d3e689126..c0150a7dbd81 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3061,11 +3061,6 @@ static int btf_finalize_data(struct bpf_object *obj, struct btf *btf)
 	return libbpf_err(err);
 }
 
-int btf__finalize_data(struct bpf_object *obj, struct btf *btf)
-{
-	return btf_finalize_data(obj, btf);
-}
-
 static int bpf_object__finalize_btf(struct bpf_object *obj)
 {
 	int err;
@@ -4397,9 +4392,7 @@ bpf_object__collect_prog_relos(struct bpf_object *obj, Elf64_Shdr *shdr, Elf_Dat
 
 static int bpf_map_find_btf_info(struct bpf_object *obj, struct bpf_map *map)
 {
-	struct bpf_map_def *def = &map->def;
-	__u32 key_type_id = 0, value_type_id = 0;
-	int ret;
+	int id;
 
 	if (!obj->btf)
 		return -ENOENT;
@@ -4408,31 +4401,22 @@ static int bpf_map_find_btf_info(struct bpf_object *obj, struct bpf_map *map)
 	 * For struct_ops map, it does not need btf_key_type_id and
 	 * btf_value_type_id.
 	 */
-	if (map->sec_idx == obj->efile.btf_maps_shndx ||
-	    bpf_map__is_struct_ops(map))
+	if (map->sec_idx == obj->efile.btf_maps_shndx || bpf_map__is_struct_ops(map))
 		return 0;
 
-	if (!bpf_map__is_internal(map)) {
-		pr_warn("Use of BPF_ANNOTATE_KV_PAIR is deprecated, use BTF-defined maps in .maps section instead\n");
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
-		ret = btf__get_map_kv_tids(obj->btf, map->name, def->key_size,
-					   def->value_size, &key_type_id,
-					   &value_type_id);
-#pragma GCC diagnostic pop
-	} else {
-		/*
-		 * LLVM annotates global data differently in BTF, that is,
-		 * only as '.data', '.bss' or '.rodata'.
-		 */
-		ret = btf__find_by_name(obj->btf, map->real_name);
-	}
-	if (ret < 0)
-		return ret;
+	/*
+	 * LLVM annotates global data differently in BTF, that is,
+	 * only as '.data', '.bss' or '.rodata'.
+	 */
+	if (!bpf_map__is_internal(map))
+		return -ENOENT;
+
+	id = btf__find_by_name(obj->btf, map->real_name);
+	if (id < 0)
+		return id;
 
-	map->btf_key_type_id = key_type_id;
-	map->btf_value_type_id = bpf_map__is_internal(map) ?
-				 ret : value_type_id;
+	map->btf_key_type_id = 0;
+	map->btf_value_type_id = id;
 	return 0;
 }
 
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 3cea0bab95ea..ff5fba17764b 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -95,7 +95,6 @@ LIBBPF_0.0.1 {
 		btf__fd;
 		btf__find_by_name;
 		btf__free;
-		btf__get_from_id;
 		btf__name_by_offset;
 		btf__new;
 		btf__resolve_size;
@@ -116,18 +115,10 @@ LIBBPF_0.0.2 {
 		bpf_map_lookup_elem_flags;
 		bpf_object__btf;
 		bpf_object__find_map_fd_by_name;
-		btf__dedup;
-		btf__get_map_kv_tids;
-		btf__get_nr_types;
 		btf__get_raw_data;
-		btf__load;
 		btf_ext__free;
-		btf_ext__func_info_rec_size;
 		btf_ext__get_raw_data;
-		btf_ext__line_info_rec_size;
 		btf_ext__new;
-		btf_ext__reloc_func_info;
-		btf_ext__reloc_line_info;
 		bpf_program__get_prog_info_linear;
 		bpf_program__bpil_addr_to_offs;
 		bpf_program__bpil_offs_to_addr;
@@ -137,7 +128,6 @@ LIBBPF_0.0.3 {
 	global:
 		bpf_map__is_internal;
 		bpf_map_freeze;
-		btf__finalize_data;
 } LIBBPF_0.0.2;
 
 LIBBPF_0.0.4 {
@@ -151,7 +141,6 @@ LIBBPF_0.0.4 {
 		bpf_program__attach_uprobe;
 		btf_dump__dump_type;
 		btf_dump__free;
-		btf_dump__new;
 		btf__parse_elf;
 		libbpf_num_possible_cpus;
 		perf_buffer__free;
@@ -373,11 +362,9 @@ LIBBPF_0.6.0 {
 		btf__add_decl_tag;
 		btf__add_type_tag;
 		btf__dedup;
-		btf__dedup_deprecated;
 		btf__raw_data;
 		btf__type_cnt;
 		btf_dump__new;
-		btf_dump__new_deprecated;
 		libbpf_major_version;
 		libbpf_minor_version;
 		libbpf_version_string;
-- 
2.30.2


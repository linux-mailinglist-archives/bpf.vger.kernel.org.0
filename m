Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66925498F3B
	for <lists+bpf@lfdr.de>; Mon, 24 Jan 2022 20:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356016AbiAXTv3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 24 Jan 2022 14:51:29 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60596 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1355692AbiAXTnK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 24 Jan 2022 14:43:10 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 20OHVjbp017128
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 11:43:09 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3dssutbkqv-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 11:43:09 -0800
Received: from twshared10426.24.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 11:43:07 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 1AFDDFF02AF7; Mon, 24 Jan 2022 11:42:57 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 1/7] libbpf: hide and discourage inconsistently named getters
Date:   Mon, 24 Jan 2022 11:42:48 -0800
Message-ID: <20220124194254.2051434-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124194254.2051434-1-andrii@kernel.org>
References: <20220124194254.2051434-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: BGXbIxl0KyplEhgQu6bPPhkGbAIEUWse
X-Proofpoint-GUID: BGXbIxl0KyplEhgQu6bPPhkGbAIEUWse
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-24_09,2022-01-24_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 impostorscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=786
 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201240129
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Move a bunch of "getters" into libbpf_legacy.h to keep them there in
libbpf 1.0. See [0] for discussion of "Discouraged APIs". These getters
don't add any maintenance burden and are simple alias, but they are
inconsistent in naming. So keep them in libbpf_legacy.h instead of
libbpf.h to "hide" them in favor of preferred getters ([1]). Also add two
missing getters: bpf_program__type() and bpf_program__expected_attach_type().

  [0] https://github.com/libbpf/libbpf/wiki/Libbpf:-the-road-to-v1.0#handling-deprecation-of-apis-and-functionality
  [1] Closes: https://github.com/libbpf/libbpf/issues/307

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/btf.h             |  5 +----
 tools/lib/bpf/libbpf.c          | 21 ++++++++++++---------
 tools/lib/bpf/libbpf.h          |  5 ++---
 tools/lib/bpf/libbpf.map        |  2 ++
 tools/lib/bpf/libbpf_internal.h |  3 +++
 tools/lib/bpf/libbpf_legacy.h   | 17 +++++++++++++++++
 6 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 51862fdee850..96b44d55db6e 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -147,8 +147,6 @@ LIBBPF_API int btf__resolve_type(const struct btf *btf, __u32 type_id);
 LIBBPF_API int btf__align_of(const struct btf *btf, __u32 id);
 LIBBPF_API int btf__fd(const struct btf *btf);
 LIBBPF_API void btf__set_fd(struct btf *btf, int fd);
-LIBBPF_DEPRECATED_SINCE(0, 7, "use btf__raw_data() instead")
-LIBBPF_API const void *btf__get_raw_data(const struct btf *btf, __u32 *size);
 LIBBPF_API const void *btf__raw_data(const struct btf *btf, __u32 *size);
 LIBBPF_API const char *btf__name_by_offset(const struct btf *btf, __u32 offset);
 LIBBPF_API const char *btf__str_by_offset(const struct btf *btf, __u32 offset);
@@ -159,8 +157,7 @@ LIBBPF_API int btf__get_map_kv_tids(const struct btf *btf, const char *map_name,
 
 LIBBPF_API struct btf_ext *btf_ext__new(const __u8 *data, __u32 size);
 LIBBPF_API void btf_ext__free(struct btf_ext *btf_ext);
-LIBBPF_API const void *btf_ext__get_raw_data(const struct btf_ext *btf_ext,
-					     __u32 *size);
+LIBBPF_API const void *btf_ext__raw_data(const struct btf_ext *btf_ext, __u32 *size);
 LIBBPF_API LIBBPF_DEPRECATED("btf_ext__reloc_func_info was never meant as a public API and has wrong assumptions embedded in it; it will be removed in the future libbpf versions")
 int btf_ext__reloc_func_info(const struct btf *btf,
 			     const struct btf_ext *btf_ext,
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a8c750373ad5..ed0d7efa1713 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7896,10 +7896,8 @@ int bpf_map__set_pin_path(struct bpf_map *map, const char *path)
 	return 0;
 }
 
-const char *bpf_map__get_pin_path(const struct bpf_map *map)
-{
-	return map->pin_path;
-}
+__alias(bpf_map__pin_path)
+const char *bpf_map__get_pin_path(const struct bpf_map *map);
 
 const char *bpf_map__pin_path(const struct bpf_map *map)
 {
@@ -8464,7 +8462,10 @@ static int bpf_program_nth_fd(const struct bpf_program *prog, int n)
 	return fd;
 }
 
-enum bpf_prog_type bpf_program__get_type(const struct bpf_program *prog)
+__alias(bpf_program__type)
+enum bpf_prog_type bpf_program__get_type(const struct bpf_program *prog);
+
+enum bpf_prog_type bpf_program__type(const struct bpf_program *prog)
 {
 	return prog->type;
 }
@@ -8508,8 +8509,10 @@ BPF_PROG_TYPE_FNS(struct_ops, BPF_PROG_TYPE_STRUCT_OPS);
 BPF_PROG_TYPE_FNS(extension, BPF_PROG_TYPE_EXT);
 BPF_PROG_TYPE_FNS(sk_lookup, BPF_PROG_TYPE_SK_LOOKUP);
 
-enum bpf_attach_type
-bpf_program__get_expected_attach_type(const struct bpf_program *prog)
+__alias(bpf_program__expected_attach_type)
+enum bpf_attach_type bpf_program__get_expected_attach_type(const struct bpf_program *prog);
+
+enum bpf_attach_type bpf_program__expected_attach_type(const struct bpf_program *prog)
 {
 	return prog->expected_attach_type;
 }
@@ -9476,7 +9479,7 @@ static int bpf_prog_load_xattr2(const struct bpf_prog_load_attr *attr,
 			bpf_program__set_expected_attach_type(prog,
 							      attach_type);
 		}
-		if (bpf_program__get_type(prog) == BPF_PROG_TYPE_UNSPEC) {
+		if (bpf_program__type(prog) == BPF_PROG_TYPE_UNSPEC) {
 			/*
 			 * we haven't guessed from section name and user
 			 * didn't provide a fallback type, too bad...
@@ -10527,7 +10530,7 @@ bpf_program__attach_fd(const struct bpf_program *prog, int target_fd, int btf_id
 		return libbpf_err_ptr(-ENOMEM);
 	link->detach = &bpf_link__detach_fd;
 
-	attach_type = bpf_program__get_expected_attach_type(prog);
+	attach_type = bpf_program__expected_attach_type(prog);
 	link_fd = bpf_link_create(prog_fd, target_fd, attach_type, &opts);
 	if (link_fd < 0) {
 		link_fd = -errno;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 94670066de62..c89d9b4456fd 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -605,12 +605,12 @@ LIBBPF_API int bpf_program__set_struct_ops(struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_extension(struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_sk_lookup(struct bpf_program *prog);
 
-LIBBPF_API enum bpf_prog_type bpf_program__get_type(const struct bpf_program *prog);
+LIBBPF_API enum bpf_prog_type bpf_program__type(const struct bpf_program *prog);
 LIBBPF_API void bpf_program__set_type(struct bpf_program *prog,
 				      enum bpf_prog_type type);
 
 LIBBPF_API enum bpf_attach_type
-bpf_program__get_expected_attach_type(const struct bpf_program *prog);
+bpf_program__expected_attach_type(const struct bpf_program *prog);
 LIBBPF_API void
 bpf_program__set_expected_attach_type(struct bpf_program *prog,
 				      enum bpf_attach_type type);
@@ -758,7 +758,6 @@ LIBBPF_API bool bpf_map__is_offload_neutral(const struct bpf_map *map);
  */
 LIBBPF_API bool bpf_map__is_internal(const struct bpf_map *map);
 LIBBPF_API int bpf_map__set_pin_path(struct bpf_map *map, const char *path);
-LIBBPF_API const char *bpf_map__get_pin_path(const struct bpf_map *map);
 LIBBPF_API const char *bpf_map__pin_path(const struct bpf_map *map);
 LIBBPF_API bool bpf_map__is_pinned(const struct bpf_map *map);
 LIBBPF_API int bpf_map__pin(struct bpf_map *map, const char *path);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index e10f0822845a..aef6253a90c8 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -424,10 +424,12 @@ LIBBPF_0.6.0 {
 LIBBPF_0.7.0 {
 	global:
 		bpf_btf_load;
+		bpf_program__expected_attach_type;
 		bpf_program__log_buf;
 		bpf_program__log_level;
 		bpf_program__set_log_buf;
 		bpf_program__set_log_level;
+		bpf_program__type;
 		bpf_xdp_attach;
 		bpf_xdp_detach;
 		bpf_xdp_query;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 1565679eb432..bc86b82e90d1 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -92,6 +92,9 @@
 # define offsetofend(TYPE, FIELD) \
 	(offsetof(TYPE, FIELD) + sizeof(((TYPE *)0)->FIELD))
 #endif
+#ifndef __alias
+#define __alias(symbol) __attribute__((alias(#symbol)))
+#endif
 
 /* Check whether a string `str` has prefix `pfx`, regardless if `pfx` is
  * a string literal known at compilation time or char * pointer known only at
diff --git a/tools/lib/bpf/libbpf_legacy.h b/tools/lib/bpf/libbpf_legacy.h
index 3c2b281c2bc3..a283cf031665 100644
--- a/tools/lib/bpf/libbpf_legacy.h
+++ b/tools/lib/bpf/libbpf_legacy.h
@@ -86,6 +86,23 @@ LIBBPF_API int libbpf_set_strict_mode(enum libbpf_strict_mode mode);
 
 #define DECLARE_LIBBPF_OPTS LIBBPF_OPTS
 
+/* "Discouraged" APIs which don't follow consistent libbpf naming patterns.
+ * They are normally a trivial aliases or wrappers for proper APIs and are
+ * left to minimize unnecessary disruption for users of libbpf. But they
+ * shouldn't be used going forward.
+ */
+
+struct bpf_program;
+struct bpf_map;
+struct btf;
+struct btf_ext;
+
+LIBBPF_API enum bpf_prog_type bpf_program__get_type(const struct bpf_program *prog);
+LIBBPF_API enum bpf_attach_type bpf_program__get_expected_attach_type(const struct bpf_program *prog);
+LIBBPF_API const char *bpf_map__get_pin_path(const struct bpf_map *map);
+LIBBPF_API const void *btf__get_raw_data(const struct btf *btf, __u32 *size);
+LIBBPF_API const void *btf_ext__get_raw_data(const struct btf_ext *btf_ext, __u32 *size);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
-- 
2.30.2


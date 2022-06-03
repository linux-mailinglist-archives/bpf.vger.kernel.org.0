Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0FA53D21F
	for <lists+bpf@lfdr.de>; Fri,  3 Jun 2022 21:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348725AbiFCTD7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 3 Jun 2022 15:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348724AbiFCTD6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jun 2022 15:03:58 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C6A31201
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 12:03:56 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 253Gn8TP014044
        for <bpf@vger.kernel.org>; Fri, 3 Jun 2022 12:03:56 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3geu05hxkj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 03 Jun 2022 12:03:56 -0700
Received: from twshared16308.14.prn3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 3 Jun 2022 12:03:55 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 34B391AC9C41E; Fri,  3 Jun 2022 12:03:49 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 09/15] libbpf: remove multi-instance and custom private data APIs
Date:   Fri, 3 Jun 2022 12:01:49 -0700
Message-ID: <20220603190155.3924899-10-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220603190155.3924899-1-andrii@kernel.org>
References: <20220603190155.3924899-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: JVdmloqhxzWxBOcxdVw_7JIFLt_5HGme
X-Proofpoint-ORIG-GUID: JVdmloqhxzWxBOcxdVw_7JIFLt_5HGme
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-03_06,2022-06-03_01,2022-02-23_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Remove all the public APIs that are related to creating multi-instance
bpf_programs through custom preprocessing callback and generally working
with them.

Also remove all the bpf_{object,map,program}__[set_]priv() APIs.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c   | 121 ++++-----------------------------------
 tools/lib/bpf/libbpf.h   |  91 -----------------------------
 tools/lib/bpf/libbpf.map |  10 ----
 3 files changed, 10 insertions(+), 212 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0930028bb11d..d46a965ced9e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -366,6 +366,16 @@ struct bpf_sec_def {
 	libbpf_prog_attach_fn_t prog_attach_fn;
 };
 
+struct bpf_prog_prep_result {
+	struct bpf_insn *new_insn_ptr;
+	int new_insn_cnt;
+	int *pfd;
+};
+
+typedef int (*bpf_program_prep_t)(struct bpf_program *prog, int n,
+				  struct bpf_insn *insns, int insns_cnt,
+				  struct bpf_prog_prep_result *res);
+
 /*
  * bpf_prog should be a better name but it has been used in
  * linux/filter.h.
@@ -426,8 +436,6 @@ struct bpf_program {
 	bpf_program_prep_t preprocessor;
 
 	struct bpf_object *obj;
-	void *priv;
-	bpf_program_clear_priv_t clear_priv;
 
 	bool autoload;
 	bool mark_btf_static;
@@ -511,8 +519,6 @@ struct bpf_map {
 	__u32 btf_key_type_id;
 	__u32 btf_value_type_id;
 	__u32 btf_vmlinux_value_type_id;
-	void *priv;
-	bpf_map_clear_priv_t clear_priv;
 	enum libbpf_map_type libbpf_type;
 	void *mmaped;
 	struct bpf_struct_ops *st_ops;
@@ -668,9 +674,6 @@ struct bpf_object {
 	size_t log_size;
 	__u32 log_level;
 
-	void *priv;
-	bpf_object_clear_priv_t clear_priv;
-
 	int *fd_array;
 	size_t fd_array_cap;
 	size_t fd_array_cnt;
@@ -721,12 +724,6 @@ static void bpf_program__exit(struct bpf_program *prog)
 	if (!prog)
 		return;
 
-	if (prog->clear_priv)
-		prog->clear_priv(prog, prog->priv);
-
-	prog->priv = NULL;
-	prog->clear_priv = NULL;
-
 	bpf_program__unload(prog);
 	zfree(&prog->name);
 	zfree(&prog->sec_name);
@@ -8072,12 +8069,6 @@ static int bpf_program_unpin_instance(struct bpf_program *prog, const char *path
 	return 0;
 }
 
-__attribute__((alias("bpf_program_pin_instance")))
-int bpf_object__pin_instance(struct bpf_program *prog, const char *path, int instance);
-
-__attribute__((alias("bpf_program_unpin_instance")))
-int bpf_program__unpin_instance(struct bpf_program *prog, const char *path, int instance);
-
 int bpf_program__pin(struct bpf_program *prog, const char *path)
 {
 	int i, err;
@@ -8513,11 +8504,6 @@ int bpf_object__pin(struct bpf_object *obj, const char *path)
 
 static void bpf_map__destroy(struct bpf_map *map)
 {
-	if (map->clear_priv)
-		map->clear_priv(map, map->priv);
-	map->priv = NULL;
-	map->clear_priv = NULL;
-
 	if (map->inner_map) {
 		bpf_map__destroy(map->inner_map);
 		zfree(&map->inner_map);
@@ -8553,9 +8539,6 @@ void bpf_object__close(struct bpf_object *obj)
 	if (IS_ERR_OR_NULL(obj))
 		return;
 
-	if (obj->clear_priv)
-		obj->clear_priv(obj, obj->priv);
-
 	usdt_manager_free(obj->usdt_man);
 	obj->usdt_man = NULL;
 
@@ -8615,22 +8598,6 @@ int bpf_object__set_kversion(struct bpf_object *obj, __u32 kern_version)
 	return 0;
 }
 
-int bpf_object__set_priv(struct bpf_object *obj, void *priv,
-			 bpf_object_clear_priv_t clear_priv)
-{
-	if (obj->priv && obj->clear_priv)
-		obj->clear_priv(obj, obj->priv);
-
-	obj->priv = priv;
-	obj->clear_priv = clear_priv;
-	return 0;
-}
-
-void *bpf_object__priv(const struct bpf_object *obj)
-{
-	return obj ? obj->priv : libbpf_err_ptr(-EINVAL);
-}
-
 int bpf_object__gen_loader(struct bpf_object *obj, struct gen_loader_opts *opts)
 {
 	struct bpf_gen *gen;
@@ -8697,22 +8664,6 @@ bpf_object__prev_program(const struct bpf_object *obj, struct bpf_program *next)
 	return prog;
 }
 
-int bpf_program__set_priv(struct bpf_program *prog, void *priv,
-			  bpf_program_clear_priv_t clear_priv)
-{
-	if (prog->priv && prog->clear_priv)
-		prog->clear_priv(prog, prog->priv);
-
-	prog->priv = priv;
-	prog->clear_priv = clear_priv;
-	return 0;
-}
-
-void *bpf_program__priv(const struct bpf_program *prog)
-{
-	return prog ? prog->priv : libbpf_err_ptr(-EINVAL);
-}
-
 void bpf_program__set_ifindex(struct bpf_program *prog, __u32 ifindex)
 {
 	prog->prog_ifindex = ifindex;
@@ -8779,37 +8730,6 @@ int bpf_program__set_insns(struct bpf_program *prog,
 	return 0;
 }
 
-int bpf_program__set_prep(struct bpf_program *prog, int nr_instances,
-			  bpf_program_prep_t prep)
-{
-	int *instances_fds;
-
-	if (nr_instances <= 0 || !prep)
-		return libbpf_err(-EINVAL);
-
-	if (prog->instances.nr > 0 || prog->instances.fds) {
-		pr_warn("Can't set pre-processor after loading\n");
-		return libbpf_err(-EINVAL);
-	}
-
-	instances_fds = malloc(sizeof(int) * nr_instances);
-	if (!instances_fds) {
-		pr_warn("alloc memory failed for fds\n");
-		return libbpf_err(-ENOMEM);
-	}
-
-	/* fill all fd with -1 */
-	memset(instances_fds, -1, sizeof(int) * nr_instances);
-
-	prog->instances.nr = nr_instances;
-	prog->instances.fds = instances_fds;
-	prog->preprocessor = prep;
-	return 0;
-}
-
-__attribute__((alias("bpf_program_nth_fd")))
-int bpf_program__nth_fd(const struct bpf_program *prog, int n);
-
 static int bpf_program_nth_fd(const struct bpf_program *prog, int n)
 {
 	int fd;
@@ -9735,27 +9655,6 @@ __u32 bpf_map__btf_value_type_id(const struct bpf_map *map)
 	return map ? map->btf_value_type_id : 0;
 }
 
-int bpf_map__set_priv(struct bpf_map *map, void *priv,
-		     bpf_map_clear_priv_t clear_priv)
-{
-	if (!map)
-		return libbpf_err(-EINVAL);
-
-	if (map->priv) {
-		if (map->clear_priv)
-			map->clear_priv(map, map->priv);
-	}
-
-	map->priv = priv;
-	map->clear_priv = clear_priv;
-	return 0;
-}
-
-void *bpf_map__priv(const struct bpf_map *map)
-{
-	return map ? map->priv : libbpf_err_ptr(-EINVAL);
-}
-
 int bpf_map__set_initial_value(struct bpf_map *map,
 			       const void *data, size_t size)
 {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 9c2279b7b6ed..5eb3145b8945 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -231,13 +231,6 @@ LIBBPF_API struct bpf_program *
 bpf_object__find_program_by_name(const struct bpf_object *obj,
 				 const char *name);
 
-typedef void (*bpf_object_clear_priv_t)(struct bpf_object *, void *);
-LIBBPF_DEPRECATED_SINCE(0, 7, "storage via set_priv/priv is deprecated")
-LIBBPF_API int bpf_object__set_priv(struct bpf_object *obj, void *priv,
-				    bpf_object_clear_priv_t clear_priv);
-LIBBPF_DEPRECATED_SINCE(0, 7, "storage via set_priv/priv is deprecated")
-LIBBPF_API void *bpf_object__priv(const struct bpf_object *prog);
-
 LIBBPF_API int
 libbpf_prog_type_by_name(const char *name, enum bpf_prog_type *prog_type,
 			 enum bpf_attach_type *expected_attach_type);
@@ -260,13 +253,6 @@ bpf_object__next_program(const struct bpf_object *obj, struct bpf_program *prog)
 LIBBPF_API struct bpf_program *
 bpf_object__prev_program(const struct bpf_object *obj, struct bpf_program *prog);
 
-typedef void (*bpf_program_clear_priv_t)(struct bpf_program *, void *);
-
-LIBBPF_DEPRECATED_SINCE(0, 7, "storage via set_priv/priv is deprecated")
-LIBBPF_API int bpf_program__set_priv(struct bpf_program *prog, void *priv,
-				     bpf_program_clear_priv_t clear_priv);
-LIBBPF_DEPRECATED_SINCE(0, 7, "storage via set_priv/priv is deprecated")
-LIBBPF_API void *bpf_program__priv(const struct bpf_program *prog);
 LIBBPF_API void bpf_program__set_ifindex(struct bpf_program *prog,
 					 __u32 ifindex);
 
@@ -328,14 +314,6 @@ LIBBPF_API int bpf_program__set_insns(struct bpf_program *prog,
 LIBBPF_API size_t bpf_program__insn_cnt(const struct bpf_program *prog);
 
 LIBBPF_API int bpf_program__fd(const struct bpf_program *prog);
-LIBBPF_DEPRECATED_SINCE(0, 7, "multi-instance bpf_program support is deprecated")
-LIBBPF_API int bpf_program__pin_instance(struct bpf_program *prog,
-					 const char *path,
-					 int instance);
-LIBBPF_DEPRECATED_SINCE(0, 7, "multi-instance bpf_program support is deprecated")
-LIBBPF_API int bpf_program__unpin_instance(struct bpf_program *prog,
-					   const char *path,
-					   int instance);
 
 /**
  * @brief **bpf_program__pin()** pins the BPF program to a file
@@ -635,69 +613,6 @@ LIBBPF_API struct bpf_link *
 bpf_program__attach_iter(const struct bpf_program *prog,
 			 const struct bpf_iter_attach_opts *opts);
 
-/*
- * Libbpf allows callers to adjust BPF programs before being loaded
- * into kernel. One program in an object file can be transformed into
- * multiple variants to be attached to different hooks.
- *
- * bpf_program_prep_t, bpf_program__set_prep and bpf_program__nth_fd
- * form an API for this purpose.
- *
- * - bpf_program_prep_t:
- *   Defines a 'preprocessor', which is a caller defined function
- *   passed to libbpf through bpf_program__set_prep(), and will be
- *   called before program is loaded. The processor should adjust
- *   the program one time for each instance according to the instance id
- *   passed to it.
- *
- * - bpf_program__set_prep:
- *   Attaches a preprocessor to a BPF program. The number of instances
- *   that should be created is also passed through this function.
- *
- * - bpf_program__nth_fd:
- *   After the program is loaded, get resulting FD of a given instance
- *   of the BPF program.
- *
- * If bpf_program__set_prep() is not used, the program would be loaded
- * without adjustment during bpf_object__load(). The program has only
- * one instance. In this case bpf_program__fd(prog) is equal to
- * bpf_program__nth_fd(prog, 0).
- */
-struct bpf_prog_prep_result {
-	/*
-	 * If not NULL, load new instruction array.
-	 * If set to NULL, don't load this instance.
-	 */
-	struct bpf_insn *new_insn_ptr;
-	int new_insn_cnt;
-
-	/* If not NULL, result FD is written to it. */
-	int *pfd;
-};
-
-/*
- * Parameters of bpf_program_prep_t:
- *  - prog:	The bpf_program being loaded.
- *  - n:	Index of instance being generated.
- *  - insns:	BPF instructions array.
- *  - insns_cnt:Number of instructions in insns.
- *  - res:	Output parameter, result of transformation.
- *
- * Return value:
- *  - Zero:	pre-processing success.
- *  - Non-zero:	pre-processing error, stop loading.
- */
-typedef int (*bpf_program_prep_t)(struct bpf_program *prog, int n,
-				  struct bpf_insn *insns, int insns_cnt,
-				  struct bpf_prog_prep_result *res);
-
-LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_program__insns() for getting bpf_program instructions")
-LIBBPF_API int bpf_program__set_prep(struct bpf_program *prog, int nr_instance,
-				     bpf_program_prep_t prep);
-
-LIBBPF_DEPRECATED_SINCE(0, 7, "multi-instance bpf_program support is deprecated")
-LIBBPF_API int bpf_program__nth_fd(const struct bpf_program *prog, int n);
-
 LIBBPF_API enum bpf_prog_type bpf_program__type(const struct bpf_program *prog);
 
 /**
@@ -846,12 +761,6 @@ LIBBPF_API int bpf_map__set_ifindex(struct bpf_map *map, __u32 ifindex);
 LIBBPF_API __u64 bpf_map__map_extra(const struct bpf_map *map);
 LIBBPF_API int bpf_map__set_map_extra(struct bpf_map *map, __u64 map_extra);
 
-typedef void (*bpf_map_clear_priv_t)(struct bpf_map *, void *);
-LIBBPF_DEPRECATED_SINCE(0, 7, "storage via set_priv/priv is deprecated")
-LIBBPF_API int bpf_map__set_priv(struct bpf_map *map, void *priv,
-				 bpf_map_clear_priv_t clear_priv);
-LIBBPF_DEPRECATED_SINCE(0, 7, "storage via set_priv/priv is deprecated")
-LIBBPF_API void *bpf_map__priv(const struct bpf_map *map);
 LIBBPF_API int bpf_map__set_initial_value(struct bpf_map *map,
 					  const void *data, size_t size);
 LIBBPF_API const void *bpf_map__initial_value(struct bpf_map *map, size_t *psize);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index f5ea2685b014..38054248c942 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -6,11 +6,9 @@ LIBBPF_0.0.1 {
 		bpf_map__fd;
 		bpf_map__name;
 		bpf_map__pin;
-		bpf_map__priv;
 		bpf_map__reuse_fd;
 		bpf_map__set_ifindex;
 		bpf_map__set_inner_map_fd;
-		bpf_map__set_priv;
 		bpf_map__unpin;
 		bpf_map_delete_elem;
 		bpf_map_get_fd_by_id;
@@ -32,8 +30,6 @@ LIBBPF_0.0.1 {
 		bpf_object__pin;
 		bpf_object__pin_maps;
 		bpf_object__pin_programs;
-		bpf_object__priv;
-		bpf_object__set_priv;
 		bpf_object__unpin_maps;
 		bpf_object__unpin_programs;
 		bpf_prog_attach;
@@ -43,18 +39,12 @@ LIBBPF_0.0.1 {
 		bpf_prog_get_next_id;
 		bpf_prog_query;
 		bpf_program__fd;
-		bpf_program__nth_fd;
 		bpf_program__pin;
-		bpf_program__pin_instance;
-		bpf_program__priv;
 		bpf_program__set_expected_attach_type;
 		bpf_program__set_ifindex;
-		bpf_program__set_prep;
-		bpf_program__set_priv;
 		bpf_program__set_type;
 		bpf_program__unload;
 		bpf_program__unpin;
-		bpf_program__unpin_instance;
 		bpf_prog_linfo__free;
 		bpf_prog_linfo__new;
 		bpf_prog_linfo__lfind_addr_func;
-- 
2.30.2


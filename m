Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D270255CD49
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 15:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241083AbiF0VQF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 27 Jun 2022 17:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241074AbiF0VQF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jun 2022 17:16:05 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DAB18381
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 14:16:03 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25RJ1QpK004938
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 14:16:02 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gx03ywd10-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 14:16:02 -0700
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub102.TheFacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 27 Jun 2022 14:15:59 -0700
Received: from twshared10560.18.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 27 Jun 2022 14:15:48 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 531F11BAC27D7; Mon, 27 Jun 2022 14:15:46 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 08/15] libbpf: remove most other deprecated high-level APIs
Date:   Mon, 27 Jun 2022 14:15:20 -0700
Message-ID: <20220627211527.2245459-9-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220627211527.2245459-1-andrii@kernel.org>
References: <20220627211527.2245459-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: KiNugW9Bx0UWPzCjT9sQTwmIXtqTmarK
X-Proofpoint-ORIG-GUID: KiNugW9Bx0UWPzCjT9sQTwmIXtqTmarK
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

Remove a bunch of high-level bpf_object/bpf_map/bpf_program related
APIs. All the APIs related to private per-object/map/prog state,
program preprocessing callback, and generally everything multi-instance
related is removed in a separate patch.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c   | 241 ++++-----------------------------------
 tools/lib/bpf/libbpf.h   | 163 +-------------------------
 tools/lib/bpf/libbpf.map |  43 -------
 3 files changed, 26 insertions(+), 421 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index cd06989812c9..149392604aa4 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -31,7 +31,6 @@
 #include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/filter.h>
-#include <linux/list.h>
 #include <linux/limits.h>
 #include <linux/perf_event.h>
 #include <linux/ring_buffer.h>
@@ -484,6 +483,14 @@ enum libbpf_map_type {
 	LIBBPF_MAP_KCONFIG,
 };
 
+struct bpf_map_def {
+	unsigned int type;
+	unsigned int key_size;
+	unsigned int value_size;
+	unsigned int max_entries;
+	unsigned int map_flags;
+};
+
 struct bpf_map {
 	struct bpf_object *obj;
 	char *name;
@@ -568,8 +575,6 @@ struct extern_desc {
 	};
 };
 
-static LIST_HEAD(bpf_objects_list);
-
 struct module_btf {
 	struct btf *btf;
 	char *name;
@@ -638,12 +643,6 @@ struct bpf_object {
 
 	/* Information when doing ELF related work. Only valid if efile.elf is not NULL */
 	struct elf_state efile;
-	/*
-	 * All loaded bpf_object are linked in a list, which is
-	 * hidden to caller. bpf_objects__<func> handlers deal with
-	 * all objects.
-	 */
-	struct list_head list;
 
 	struct btf *btf;
 	struct btf_ext *btf_ext;
@@ -1313,7 +1312,6 @@ static struct bpf_object *bpf_object__new(const char *path,
 					  size_t obj_buf_sz,
 					  const char *obj_name)
 {
-	bool strict = (libbpf_mode & LIBBPF_STRICT_NO_OBJECT_LIST);
 	struct bpf_object *obj;
 	char *end;
 
@@ -1351,9 +1349,6 @@ static struct bpf_object *bpf_object__new(const char *path,
 	obj->kern_version = get_kernel_version();
 	obj->loaded = false;
 
-	INIT_LIST_HEAD(&obj->list);
-	if (!strict)
-		list_add(&obj->list, &bpf_objects_list);
 	return obj;
 }
 
@@ -1386,10 +1381,7 @@ static int bpf_object__elf_init(struct bpf_object *obj)
 	}
 
 	if (obj->efile.obj_buf_sz > 0) {
-		/*
-		 * obj_buf should have been validated by
-		 * bpf_object__open_buffer().
-		 */
+		/* obj_buf should have been validated by bpf_object__open_mem(). */
 		elf = elf_memory((char *)obj->efile.obj_buf, obj->efile.obj_buf_sz);
 	} else {
 		obj->efile.fd = open(obj->path, O_RDONLY | O_CLOEXEC);
@@ -2306,6 +2298,13 @@ static int build_map_pin_path(struct bpf_map *map, const char *path)
 	return bpf_map__set_pin_path(map, buf);
 }
 
+/* should match definition in bpf_helpers.h */
+enum libbpf_pin_type {
+	LIBBPF_PIN_NONE,
+	/* PIN_BY_NAME: pin maps by name (in /sys/fs/bpf by default) */
+	LIBBPF_PIN_BY_NAME,
+};
+
 int parse_btf_map_def(const char *map_name, struct btf *btf,
 		      const struct btf_type *def_t, bool strict,
 		      struct btf_map_def *map_def, struct btf_map_def *inner_def)
@@ -4017,19 +4016,6 @@ static int bpf_object__collect_externs(struct bpf_object *obj)
 	return 0;
 }
 
-struct bpf_program *
-bpf_object__find_program_by_title(const struct bpf_object *obj,
-				  const char *title)
-{
-	struct bpf_program *pos;
-
-	bpf_object__for_each_program(pos, obj) {
-		if (pos->sec_name && !strcmp(pos->sec_name, title))
-			return pos;
-	}
-	return errno = ENOENT, NULL;
-}
-
 static bool prog_is_subprog(const struct bpf_object *obj,
 			    const struct bpf_program *prog)
 {
@@ -4548,14 +4534,6 @@ int bpf_map__set_max_entries(struct bpf_map *map, __u32 max_entries)
 	return 0;
 }
 
-int bpf_map__resize(struct bpf_map *map, __u32 max_entries)
-{
-	if (!map || !max_entries)
-		return libbpf_err(-EINVAL);
-
-	return bpf_map__set_max_entries(map, max_entries);
-}
-
 static int
 bpf_object__probe_loading(struct bpf_object *obj)
 {
@@ -7339,11 +7317,6 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 	return libbpf_err(err);
 }
 
-int bpf_program__load(struct bpf_program *prog, const char *license, __u32 kern_ver)
-{
-	return bpf_object_load_prog(prog->obj, prog, license, kern_ver);
-}
-
 static int
 bpf_object__load_progs(struct bpf_object *obj, int log_level)
 {
@@ -7395,13 +7368,6 @@ static int bpf_object_init_progs(struct bpf_object *obj, const struct bpf_object
 		prog->type = prog->sec_def->prog_type;
 		prog->expected_attach_type = prog->sec_def->expected_attach_type;
 
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
-		if (prog->sec_def->prog_type == BPF_PROG_TYPE_TRACING ||
-		    prog->sec_def->prog_type == BPF_PROG_TYPE_EXT)
-			prog->attach_prog_fd = OPTS_GET(opts, attach_prog_fd, 0);
-#pragma GCC diagnostic pop
-
 		/* sec_def can have custom callback which should be called
 		 * after bpf_program is initialized to adjust its properties
 		 */
@@ -7507,36 +7473,6 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
 	return ERR_PTR(err);
 }
 
-static struct bpf_object *
-__bpf_object__open_xattr(struct bpf_object_open_attr *attr, int flags)
-{
-	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts,
-		.relaxed_maps = flags & MAPS_RELAX_COMPAT,
-	);
-
-	/* param validation */
-	if (!attr->file)
-		return NULL;
-
-	pr_debug("loading %s\n", attr->file);
-	return bpf_object_open(attr->file, NULL, 0, &opts);
-}
-
-struct bpf_object *bpf_object__open_xattr(struct bpf_object_open_attr *attr)
-{
-	return libbpf_ptr(__bpf_object__open_xattr(attr, 0));
-}
-
-struct bpf_object *bpf_object__open(const char *path)
-{
-	struct bpf_object_open_attr attr = {
-		.file		= path,
-		.prog_type	= BPF_PROG_TYPE_UNSPEC,
-	};
-
-	return libbpf_ptr(__bpf_object__open_xattr(&attr, 0));
-}
-
 struct bpf_object *
 bpf_object__open_file(const char *path, const struct bpf_object_open_opts *opts)
 {
@@ -7548,6 +7484,11 @@ bpf_object__open_file(const char *path, const struct bpf_object_open_opts *opts)
 	return libbpf_ptr(bpf_object_open(path, NULL, 0, opts));
 }
 
+struct bpf_object *bpf_object__open(const char *path)
+{
+	return bpf_object__open_file(path, NULL);
+}
+
 struct bpf_object *
 bpf_object__open_mem(const void *obj_buf, size_t obj_buf_sz,
 		     const struct bpf_object_open_opts *opts)
@@ -7558,23 +7499,6 @@ bpf_object__open_mem(const void *obj_buf, size_t obj_buf_sz,
 	return libbpf_ptr(bpf_object_open(NULL, obj_buf, obj_buf_sz, opts));
 }
 
-struct bpf_object *
-bpf_object__open_buffer(const void *obj_buf, size_t obj_buf_sz,
-			const char *name)
-{
-	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts,
-		.object_name = name,
-		/* wrong default, but backwards-compatible */
-		.relaxed_maps = true,
-	);
-
-	/* returning NULL is wrong, but backwards-compatible */
-	if (!obj_buf || obj_buf_sz == 0)
-		return errno = EINVAL, NULL;
-
-	return libbpf_ptr(bpf_object_open(NULL, obj_buf, obj_buf_sz, &opts));
-}
-
 static int bpf_object_unload(struct bpf_object *obj)
 {
 	size_t i;
@@ -8007,11 +7931,6 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
 	return libbpf_err(err);
 }
 
-int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
-{
-	return bpf_object_load(attr->obj, attr->log_level, attr->target_btf_path);
-}
-
 int bpf_object__load(struct bpf_object *obj)
 {
 	return bpf_object_load(obj, 0, NULL);
@@ -8642,33 +8561,9 @@ void bpf_object__close(struct bpf_object *obj)
 	}
 	zfree(&obj->programs);
 
-	list_del(&obj->list);
 	free(obj);
 }
 
-struct bpf_object *
-bpf_object__next(struct bpf_object *prev)
-{
-	struct bpf_object *next;
-	bool strict = (libbpf_mode & LIBBPF_STRICT_NO_OBJECT_LIST);
-
-	if (strict)
-		return NULL;
-
-	if (!prev)
-		next = list_first_entry(&bpf_objects_list,
-					struct bpf_object,
-					list);
-	else
-		next = list_next_entry(prev, list);
-
-	/* Empty list is noticed here so don't need checking on entry. */
-	if (&next->list == &bpf_objects_list)
-		return NULL;
-
-	return next;
-}
-
 const char *bpf_object__name(const struct bpf_object *obj)
 {
 	return obj ? obj->name : libbpf_err_ptr(-EINVAL);
@@ -8757,12 +8652,6 @@ __bpf_program__iter(const struct bpf_program *p, const struct bpf_object *obj,
 	return &obj->programs[idx];
 }
 
-struct bpf_program *
-bpf_program__next(struct bpf_program *prev, const struct bpf_object *obj)
-{
-	return bpf_object__next_program(obj, prev);
-}
-
 struct bpf_program *
 bpf_object__next_program(const struct bpf_object *obj, struct bpf_program *prev)
 {
@@ -8775,12 +8664,6 @@ bpf_object__next_program(const struct bpf_object *obj, struct bpf_program *prev)
 	return prog;
 }
 
-struct bpf_program *
-bpf_program__prev(struct bpf_program *next, const struct bpf_object *obj)
-{
-	return bpf_object__prev_program(obj, next);
-}
-
 struct bpf_program *
 bpf_object__prev_program(const struct bpf_object *obj, struct bpf_program *next)
 {
@@ -8824,22 +8707,6 @@ const char *bpf_program__section_name(const struct bpf_program *prog)
 	return prog->sec_name;
 }
 
-const char *bpf_program__title(const struct bpf_program *prog, bool needs_copy)
-{
-	const char *title;
-
-	title = prog->sec_name;
-	if (needs_copy) {
-		title = strdup(title);
-		if (!title) {
-			pr_warn("failed to strdup program title\n");
-			return libbpf_err_ptr(-ENOMEM);
-		}
-	}
-
-	return title;
-}
-
 bool bpf_program__autoload(const struct bpf_program *prog)
 {
 	return prog->autoload;
@@ -8861,11 +8728,6 @@ int bpf_program__fd(const struct bpf_program *prog)
 	return bpf_program_nth_fd(prog, 0);
 }
 
-size_t bpf_program__size(const struct bpf_program *prog)
-{
-	return prog->insns_cnt * BPF_INSN_SZ;
-}
-
 const struct bpf_insn *bpf_program__insns(const struct bpf_program *prog)
 {
 	return prog->insns;
@@ -8967,39 +8829,6 @@ int bpf_program__set_type(struct bpf_program *prog, enum bpf_prog_type type)
 	return 0;
 }
 
-static bool bpf_program__is_type(const struct bpf_program *prog,
-				 enum bpf_prog_type type)
-{
-	return prog ? (prog->type == type) : false;
-}
-
-#define BPF_PROG_TYPE_FNS(NAME, TYPE)				\
-int bpf_program__set_##NAME(struct bpf_program *prog)		\
-{								\
-	if (!prog)						\
-		return libbpf_err(-EINVAL);			\
-	return bpf_program__set_type(prog, TYPE);			\
-}								\
-								\
-bool bpf_program__is_##NAME(const struct bpf_program *prog)	\
-{								\
-	return bpf_program__is_type(prog, TYPE);		\
-}								\
-
-BPF_PROG_TYPE_FNS(socket_filter, BPF_PROG_TYPE_SOCKET_FILTER);
-BPF_PROG_TYPE_FNS(lsm, BPF_PROG_TYPE_LSM);
-BPF_PROG_TYPE_FNS(kprobe, BPF_PROG_TYPE_KPROBE);
-BPF_PROG_TYPE_FNS(sched_cls, BPF_PROG_TYPE_SCHED_CLS);
-BPF_PROG_TYPE_FNS(sched_act, BPF_PROG_TYPE_SCHED_ACT);
-BPF_PROG_TYPE_FNS(tracepoint, BPF_PROG_TYPE_TRACEPOINT);
-BPF_PROG_TYPE_FNS(raw_tracepoint, BPF_PROG_TYPE_RAW_TRACEPOINT);
-BPF_PROG_TYPE_FNS(xdp, BPF_PROG_TYPE_XDP);
-BPF_PROG_TYPE_FNS(perf_event, BPF_PROG_TYPE_PERF_EVENT);
-BPF_PROG_TYPE_FNS(tracing, BPF_PROG_TYPE_TRACING);
-BPF_PROG_TYPE_FNS(struct_ops, BPF_PROG_TYPE_STRUCT_OPS);
-BPF_PROG_TYPE_FNS(extension, BPF_PROG_TYPE_EXT);
-BPF_PROG_TYPE_FNS(sk_lookup, BPF_PROG_TYPE_SK_LOOKUP);
-
 __alias(bpf_program__expected_attach_type)
 enum bpf_attach_type bpf_program__get_expected_attach_type(const struct bpf_program *prog);
 
@@ -9773,11 +9602,6 @@ int bpf_map__fd(const struct bpf_map *map)
 	return map ? map->fd : libbpf_err(-EINVAL);
 }
 
-const struct bpf_map_def *bpf_map__def(const struct bpf_map *map)
-{
-	return map ? &map->def : libbpf_err_ptr(-EINVAL);
-}
-
 static bool map_uses_real_name(const struct bpf_map *map)
 {
 	/* Since libbpf started to support custom .data.* and .rodata.* maps,
@@ -9932,11 +9756,6 @@ const void *bpf_map__initial_value(struct bpf_map *map, size_t *psize)
 	return map->mmaped;
 }
 
-bool bpf_map__is_offload_neutral(const struct bpf_map *map)
-{
-	return map->def.type == BPF_MAP_TYPE_PERF_EVENT_ARRAY;
-}
-
 bool bpf_map__is_internal(const struct bpf_map *map)
 {
 	return map->libbpf_type != LIBBPF_MAP_UNSPEC;
@@ -9997,12 +9816,6 @@ __bpf_map__iter(const struct bpf_map *m, const struct bpf_object *obj, int i)
 	return &obj->maps[idx];
 }
 
-struct bpf_map *
-bpf_map__next(const struct bpf_map *prev, const struct bpf_object *obj)
-{
-	return bpf_object__next_map(obj, prev);
-}
-
 struct bpf_map *
 bpf_object__next_map(const struct bpf_object *obj, const struct bpf_map *prev)
 {
@@ -10012,12 +9825,6 @@ bpf_object__next_map(const struct bpf_object *obj, const struct bpf_map *prev)
 	return __bpf_map__iter(prev, obj, 1);
 }
 
-struct bpf_map *
-bpf_map__prev(const struct bpf_map *next, const struct bpf_object *obj)
-{
-	return bpf_object__prev_map(obj, next);
-}
-
 struct bpf_map *
 bpf_object__prev_map(const struct bpf_object *obj, const struct bpf_map *next)
 {
@@ -10063,12 +9870,6 @@ bpf_object__find_map_fd_by_name(const struct bpf_object *obj, const char *name)
 	return bpf_map__fd(bpf_object__find_map_by_name(obj, name));
 }
 
-struct bpf_map *
-bpf_object__find_map_by_offset(struct bpf_object *obj, size_t offset)
-{
-	return libbpf_err_ptr(-ENOTSUP);
-}
-
 static int validate_map_op(const struct bpf_map *map, size_t key_sz,
 			   size_t value_sz, bool check_value_sz)
 {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index e6357ea7bf41..9c2279b7b6ed 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -101,11 +101,6 @@ LIBBPF_API libbpf_print_fn_t libbpf_set_print(libbpf_print_fn_t fn);
 /* Hide internal to user */
 struct bpf_object;
 
-struct bpf_object_open_attr {
-	const char *file;
-	enum bpf_prog_type prog_type;
-};
-
 struct bpf_object_open_opts {
 	/* size of this struct, for forward/backward compatibility */
 	size_t sz;
@@ -118,21 +113,12 @@ struct bpf_object_open_opts {
 	const char *object_name;
 	/* parse map definitions non-strictly, allowing extra attributes/data */
 	bool relaxed_maps;
-	/* DEPRECATED: handle CO-RE relocations non-strictly, allowing failures.
-	 * Value is ignored. Relocations always are processed non-strictly.
-	 * Non-relocatable instructions are replaced with invalid ones to
-	 * prevent accidental errors.
-	 * */
-	LIBBPF_DEPRECATED_SINCE(0, 6, "field has no effect")
-	bool relaxed_core_relocs;
 	/* maps that set the 'pinning' attribute in their definition will have
 	 * their pin_path attribute set to a file in this directory, and be
 	 * auto-pinned to that path on load; defaults to "/sys/fs/bpf".
 	 */
 	const char *pin_root_path;
-
-	LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_program__set_attach_target() on each individual bpf_program")
-	__u32 attach_prog_fd;
+	long :0;
 	/* Additional kernel config content that augments and overrides
 	 * system Kconfig for CONFIG_xxx externs.
 	 */
@@ -215,20 +201,10 @@ LIBBPF_API struct bpf_object *
 bpf_object__open_mem(const void *obj_buf, size_t obj_buf_sz,
 		     const struct bpf_object_open_opts *opts);
 
-/* deprecated bpf_object__open variants */
-LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_object__open_mem() instead")
-LIBBPF_API struct bpf_object *
-bpf_object__open_buffer(const void *obj_buf, size_t obj_buf_sz,
-			const char *name);
-LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_object__open_file() instead")
-LIBBPF_API struct bpf_object *
-bpf_object__open_xattr(struct bpf_object_open_attr *attr);
+/* Load/unload object into/from kernel */
+LIBBPF_API int bpf_object__load(struct bpf_object *obj);
 
-enum libbpf_pin_type {
-	LIBBPF_PIN_NONE,
-	/* PIN_BY_NAME: pin maps by name (in /sys/fs/bpf by default) */
-	LIBBPF_PIN_BY_NAME,
-};
+LIBBPF_API void bpf_object__close(struct bpf_object *object);
 
 /* pin_maps and unpin_maps can both be called with a NULL path, in which case
  * they will use the pin_path attribute of each map (and ignore all maps that
@@ -242,20 +218,6 @@ LIBBPF_API int bpf_object__pin_programs(struct bpf_object *obj,
 LIBBPF_API int bpf_object__unpin_programs(struct bpf_object *obj,
 					  const char *path);
 LIBBPF_API int bpf_object__pin(struct bpf_object *object, const char *path);
-LIBBPF_API void bpf_object__close(struct bpf_object *object);
-
-struct bpf_object_load_attr {
-	struct bpf_object *obj;
-	int log_level;
-	const char *target_btf_path;
-};
-
-/* Load/unload object into/from kernel */
-LIBBPF_API int bpf_object__load(struct bpf_object *obj);
-LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_object__load() instead")
-LIBBPF_API int bpf_object__load_xattr(struct bpf_object_load_attr *attr);
-LIBBPF_DEPRECATED_SINCE(0, 6, "bpf_object__unload() is deprecated, use bpf_object__close() instead")
-LIBBPF_API int bpf_object__unload(struct bpf_object *obj);
 
 LIBBPF_API const char *bpf_object__name(const struct bpf_object *obj);
 LIBBPF_API unsigned int bpf_object__kversion(const struct bpf_object *obj);
@@ -265,22 +227,10 @@ struct btf;
 LIBBPF_API struct btf *bpf_object__btf(const struct bpf_object *obj);
 LIBBPF_API int bpf_object__btf_fd(const struct bpf_object *obj);
 
-LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_object__find_program_by_name() instead")
-LIBBPF_API struct bpf_program *
-bpf_object__find_program_by_title(const struct bpf_object *obj,
-				  const char *title);
 LIBBPF_API struct bpf_program *
 bpf_object__find_program_by_name(const struct bpf_object *obj,
 				 const char *name);
 
-LIBBPF_API LIBBPF_DEPRECATED_SINCE(0, 7, "track bpf_objects in application code instead")
-struct bpf_object *bpf_object__next(struct bpf_object *prev);
-#define bpf_object__for_each_safe(pos, tmp)			\
-	for ((pos) = bpf_object__next(NULL),		\
-		(tmp) = bpf_object__next(pos);		\
-	     (pos) != NULL;				\
-	     (pos) = (tmp), (tmp) = bpf_object__next(tmp))
-
 typedef void (*bpf_object_clear_priv_t)(struct bpf_object *, void *);
 LIBBPF_DEPRECATED_SINCE(0, 7, "storage via set_priv/priv is deprecated")
 LIBBPF_API int bpf_object__set_priv(struct bpf_object *obj, void *priv,
@@ -298,9 +248,7 @@ LIBBPF_API int libbpf_find_vmlinux_btf_id(const char *name,
 
 /* Accessors of bpf_program */
 struct bpf_program;
-LIBBPF_API LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_object__next_program() instead")
-struct bpf_program *bpf_program__next(struct bpf_program *prog,
-				      const struct bpf_object *obj);
+
 LIBBPF_API struct bpf_program *
 bpf_object__next_program(const struct bpf_object *obj, struct bpf_program *prog);
 
@@ -309,9 +257,6 @@ bpf_object__next_program(const struct bpf_object *obj, struct bpf_program *prog)
 	     (pos) != NULL;					\
 	     (pos) = bpf_object__next_program((obj), (pos)))
 
-LIBBPF_API LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_object__prev_program() instead")
-struct bpf_program *bpf_program__prev(struct bpf_program *prog,
-				      const struct bpf_object *obj);
 LIBBPF_API struct bpf_program *
 bpf_object__prev_program(const struct bpf_object *obj, struct bpf_program *prog);
 
@@ -327,15 +272,9 @@ LIBBPF_API void bpf_program__set_ifindex(struct bpf_program *prog,
 
 LIBBPF_API const char *bpf_program__name(const struct bpf_program *prog);
 LIBBPF_API const char *bpf_program__section_name(const struct bpf_program *prog);
-LIBBPF_API LIBBPF_DEPRECATED("BPF program title is confusing term; please use bpf_program__section_name() instead")
-const char *bpf_program__title(const struct bpf_program *prog, bool needs_copy);
 LIBBPF_API bool bpf_program__autoload(const struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_autoload(struct bpf_program *prog, bool autoload);
 
-/* returns program size in bytes */
-LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_program__insn_cnt() instead")
-LIBBPF_API size_t bpf_program__size(const struct bpf_program *prog);
-
 struct bpf_insn;
 
 /**
@@ -388,8 +327,6 @@ LIBBPF_API int bpf_program__set_insns(struct bpf_program *prog,
  */
 LIBBPF_API size_t bpf_program__insn_cnt(const struct bpf_program *prog);
 
-LIBBPF_DEPRECATED_SINCE(0, 6, "use bpf_object__load() instead")
-LIBBPF_API int bpf_program__load(struct bpf_program *prog, const char *license, __u32 kern_version);
 LIBBPF_API int bpf_program__fd(const struct bpf_program *prog);
 LIBBPF_DEPRECATED_SINCE(0, 7, "multi-instance bpf_program support is deprecated")
 LIBBPF_API int bpf_program__pin_instance(struct bpf_program *prog,
@@ -761,36 +698,6 @@ LIBBPF_API int bpf_program__set_prep(struct bpf_program *prog, int nr_instance,
 LIBBPF_DEPRECATED_SINCE(0, 7, "multi-instance bpf_program support is deprecated")
 LIBBPF_API int bpf_program__nth_fd(const struct bpf_program *prog, int n);
 
-/*
- * Adjust type of BPF program. Default is kprobe.
- */
-LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__set_type() instead")
-LIBBPF_API int bpf_program__set_socket_filter(struct bpf_program *prog);
-LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__set_type() instead")
-LIBBPF_API int bpf_program__set_tracepoint(struct bpf_program *prog);
-LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__set_type() instead")
-LIBBPF_API int bpf_program__set_raw_tracepoint(struct bpf_program *prog);
-LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__set_type() instead")
-LIBBPF_API int bpf_program__set_kprobe(struct bpf_program *prog);
-LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__set_type() instead")
-LIBBPF_API int bpf_program__set_lsm(struct bpf_program *prog);
-LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__set_type() instead")
-LIBBPF_API int bpf_program__set_sched_cls(struct bpf_program *prog);
-LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__set_type() instead")
-LIBBPF_API int bpf_program__set_sched_act(struct bpf_program *prog);
-LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__set_type() instead")
-LIBBPF_API int bpf_program__set_xdp(struct bpf_program *prog);
-LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__set_type() instead")
-LIBBPF_API int bpf_program__set_perf_event(struct bpf_program *prog);
-LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__set_type() instead")
-LIBBPF_API int bpf_program__set_tracing(struct bpf_program *prog);
-LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__set_type() instead")
-LIBBPF_API int bpf_program__set_struct_ops(struct bpf_program *prog);
-LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__set_type() instead")
-LIBBPF_API int bpf_program__set_extension(struct bpf_program *prog);
-LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__set_type() instead")
-LIBBPF_API int bpf_program__set_sk_lookup(struct bpf_program *prog);
-
 LIBBPF_API enum bpf_prog_type bpf_program__type(const struct bpf_program *prog);
 
 /**
@@ -853,47 +760,6 @@ LIBBPF_API int
 bpf_program__set_attach_target(struct bpf_program *prog, int attach_prog_fd,
 			       const char *attach_func_name);
 
-LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__type() instead")
-LIBBPF_API bool bpf_program__is_socket_filter(const struct bpf_program *prog);
-LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__type() instead")
-LIBBPF_API bool bpf_program__is_tracepoint(const struct bpf_program *prog);
-LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__type() instead")
-LIBBPF_API bool bpf_program__is_raw_tracepoint(const struct bpf_program *prog);
-LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__type() instead")
-LIBBPF_API bool bpf_program__is_kprobe(const struct bpf_program *prog);
-LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__type() instead")
-LIBBPF_API bool bpf_program__is_lsm(const struct bpf_program *prog);
-LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__type() instead")
-LIBBPF_API bool bpf_program__is_sched_cls(const struct bpf_program *prog);
-LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__type() instead")
-LIBBPF_API bool bpf_program__is_sched_act(const struct bpf_program *prog);
-LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__type() instead")
-LIBBPF_API bool bpf_program__is_xdp(const struct bpf_program *prog);
-LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__type() instead")
-LIBBPF_API bool bpf_program__is_perf_event(const struct bpf_program *prog);
-LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__type() instead")
-LIBBPF_API bool bpf_program__is_tracing(const struct bpf_program *prog);
-LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__type() instead")
-LIBBPF_API bool bpf_program__is_struct_ops(const struct bpf_program *prog);
-LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__type() instead")
-LIBBPF_API bool bpf_program__is_extension(const struct bpf_program *prog);
-LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__type() instead")
-LIBBPF_API bool bpf_program__is_sk_lookup(const struct bpf_program *prog);
-
-/*
- * No need for __attribute__((packed)), all members of 'bpf_map_def'
- * are all aligned.  In addition, using __attribute__((packed))
- * would trigger a -Wpacked warning message, and lead to an error
- * if -Werror is set.
- */
-struct bpf_map_def {
-	unsigned int type;
-	unsigned int key_size;
-	unsigned int value_size;
-	unsigned int max_entries;
-	unsigned int map_flags;
-};
-
 /**
  * @brief **bpf_object__find_map_by_name()** returns BPF map of
  * the given name, if it exists within the passed BPF object
@@ -908,16 +774,6 @@ bpf_object__find_map_by_name(const struct bpf_object *obj, const char *name);
 LIBBPF_API int
 bpf_object__find_map_fd_by_name(const struct bpf_object *obj, const char *name);
 
-/*
- * Get bpf_map through the offset of corresponding struct bpf_map_def
- * in the BPF object file.
- */
-LIBBPF_API LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_object__find_map_by_name() instead")
-struct bpf_map *
-bpf_object__find_map_by_offset(struct bpf_object *obj, size_t offset);
-
-LIBBPF_API LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_object__next_map() instead")
-struct bpf_map *bpf_map__next(const struct bpf_map *map, const struct bpf_object *obj);
 LIBBPF_API struct bpf_map *
 bpf_object__next_map(const struct bpf_object *obj, const struct bpf_map *map);
 
@@ -927,8 +783,6 @@ bpf_object__next_map(const struct bpf_object *obj, const struct bpf_map *map);
 	     (pos) = bpf_object__next_map((obj), (pos)))
 #define bpf_map__for_each bpf_object__for_each_map
 
-LIBBPF_API LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_object__prev_map() instead")
-struct bpf_map *bpf_map__prev(const struct bpf_map *map, const struct bpf_object *obj);
 LIBBPF_API struct bpf_map *
 bpf_object__prev_map(const struct bpf_object *obj, const struct bpf_map *map);
 
@@ -962,9 +816,6 @@ LIBBPF_API bool bpf_map__autocreate(const struct bpf_map *map);
  */
 LIBBPF_API int bpf_map__fd(const struct bpf_map *map);
 LIBBPF_API int bpf_map__reuse_fd(struct bpf_map *map, int fd);
-/* get map definition */
-LIBBPF_API LIBBPF_DEPRECATED_SINCE(0, 8, "use appropriate getters or setters instead")
-const struct bpf_map_def *bpf_map__def(const struct bpf_map *map);
 /* get map name */
 LIBBPF_API const char *bpf_map__name(const struct bpf_map *map);
 /* get/set map type */
@@ -973,8 +824,6 @@ LIBBPF_API int bpf_map__set_type(struct bpf_map *map, enum bpf_map_type type);
 /* get/set map size (max_entries) */
 LIBBPF_API __u32 bpf_map__max_entries(const struct bpf_map *map);
 LIBBPF_API int bpf_map__set_max_entries(struct bpf_map *map, __u32 max_entries);
-LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_map__set_max_entries() instead")
-LIBBPF_API int bpf_map__resize(struct bpf_map *map, __u32 max_entries);
 /* get/set map flags */
 LIBBPF_API __u32 bpf_map__map_flags(const struct bpf_map *map);
 LIBBPF_API int bpf_map__set_map_flags(struct bpf_map *map, __u32 flags);
@@ -1006,8 +855,6 @@ LIBBPF_API void *bpf_map__priv(const struct bpf_map *map);
 LIBBPF_API int bpf_map__set_initial_value(struct bpf_map *map,
 					  const void *data, size_t size);
 LIBBPF_API const void *bpf_map__initial_value(struct bpf_map *map, size_t *psize);
-LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_map__type() instead")
-LIBBPF_API bool bpf_map__is_offload_neutral(const struct bpf_map *map);
 
 /**
  * @brief **bpf_map__is_internal()** tells the caller whether or not the
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 93c7bcc058c6..7f19c43028f1 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -3,13 +3,9 @@ LIBBPF_0.0.1 {
 		bpf_btf_get_fd_by_id;
 		bpf_map__btf_key_type_id;
 		bpf_map__btf_value_type_id;
-		bpf_map__def;
 		bpf_map__fd;
-		bpf_map__is_offload_neutral;
 		bpf_map__name;
-		bpf_map__next;
 		bpf_map__pin;
-		bpf_map__prev;
 		bpf_map__priv;
 		bpf_map__reuse_fd;
 		bpf_map__set_ifindex;
@@ -29,21 +25,15 @@ LIBBPF_0.0.1 {
 		bpf_object__btf_fd;
 		bpf_object__close;
 		bpf_object__find_map_by_name;
-		bpf_object__find_map_by_offset;
-		bpf_object__find_program_by_title;
 		bpf_object__kversion;
 		bpf_object__load;
 		bpf_object__name;
-		bpf_object__next;
 		bpf_object__open;
-		bpf_object__open_buffer;
-		bpf_object__open_xattr;
 		bpf_object__pin;
 		bpf_object__pin_maps;
 		bpf_object__pin_programs;
 		bpf_object__priv;
 		bpf_object__set_priv;
-		bpf_object__unload;
 		bpf_object__unpin_maps;
 		bpf_object__unpin_programs;
 		bpf_prog_attach;
@@ -53,35 +43,15 @@ LIBBPF_0.0.1 {
 		bpf_prog_get_next_id;
 		bpf_prog_query;
 		bpf_program__fd;
-		bpf_program__is_kprobe;
-		bpf_program__is_perf_event;
-		bpf_program__is_raw_tracepoint;
-		bpf_program__is_sched_act;
-		bpf_program__is_sched_cls;
-		bpf_program__is_socket_filter;
-		bpf_program__is_tracepoint;
-		bpf_program__is_xdp;
-		bpf_program__load;
-		bpf_program__next;
 		bpf_program__nth_fd;
 		bpf_program__pin;
 		bpf_program__pin_instance;
-		bpf_program__prev;
 		bpf_program__priv;
 		bpf_program__set_expected_attach_type;
 		bpf_program__set_ifindex;
-		bpf_program__set_kprobe;
-		bpf_program__set_perf_event;
 		bpf_program__set_prep;
 		bpf_program__set_priv;
-		bpf_program__set_raw_tracepoint;
-		bpf_program__set_sched_act;
-		bpf_program__set_sched_cls;
-		bpf_program__set_socket_filter;
-		bpf_program__set_tracepoint;
 		bpf_program__set_type;
-		bpf_program__set_xdp;
-		bpf_program__title;
 		bpf_program__unload;
 		bpf_program__unpin;
 		bpf_program__unpin_instance;
@@ -110,7 +80,6 @@ LIBBPF_0.0.1 {
 
 LIBBPF_0.0.2 {
 	global:
-		bpf_map__resize;
 		bpf_map_lookup_elem_flags;
 		bpf_object__btf;
 		bpf_object__find_map_fd_by_name;
@@ -129,7 +98,6 @@ LIBBPF_0.0.3 {
 LIBBPF_0.0.4 {
 	global:
 		bpf_link__destroy;
-		bpf_object__load_xattr;
 		bpf_program__attach_kprobe;
 		bpf_program__attach_perf_event;
 		bpf_program__attach_raw_tracepoint;
@@ -158,9 +126,6 @@ LIBBPF_0.0.6 {
 		bpf_program__attach_trace;
 		bpf_program__get_expected_attach_type;
 		bpf_program__get_type;
-		bpf_program__is_tracing;
-		bpf_program__set_tracing;
-		bpf_program__size;
 		btf__find_by_name_kind;
 		libbpf_find_vmlinux_btf_id;
 } LIBBPF_0.0.5;
@@ -182,10 +147,6 @@ LIBBPF_0.0.7 {
 		bpf_object__open_skeleton;
 		bpf_program__attach;
 		bpf_program__name;
-		bpf_program__is_extension;
-		bpf_program__is_struct_ops;
-		bpf_program__set_extension;
-		bpf_program__set_struct_ops;
 		btf__align_of;
 		libbpf_find_kernel_btf;
 } LIBBPF_0.0.6;
@@ -204,9 +165,7 @@ LIBBPF_0.0.8 {
 		bpf_prog_attach_opts;
 		bpf_program__attach_cgroup;
 		bpf_program__attach_lsm;
-		bpf_program__is_lsm;
 		bpf_program__set_attach_target;
-		bpf_program__set_lsm;
 } LIBBPF_0.0.7;
 
 LIBBPF_0.0.9 {
@@ -244,9 +203,7 @@ LIBBPF_0.1.0 {
 		bpf_map__value_size;
 		bpf_program__attach_xdp;
 		bpf_program__autoload;
-		bpf_program__is_sk_lookup;
 		bpf_program__set_autoload;
-		bpf_program__set_sk_lookup;
 		btf__parse;
 		btf__parse_raw;
 		btf__pointer_size;
-- 
2.30.2


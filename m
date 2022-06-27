Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6A655DBAF
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 15:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241077AbiF0VQO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 27 Jun 2022 17:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238386AbiF0VQN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jun 2022 17:16:13 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49027186DB
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 14:16:12 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25RJ1Qd4024725
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 14:16:12 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gwyfsdu74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 14:16:11 -0700
Received: from twshared18213.14.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 27 Jun 2022 14:16:10 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id A978E1BAC27F8; Mon, 27 Jun 2022 14:15:58 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 14/15] libbpf: enforce strict libbpf 1.0 behaviors
Date:   Mon, 27 Jun 2022 14:15:26 -0700
Message-ID: <20220627211527.2245459-15-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220627211527.2245459-1-andrii@kernel.org>
References: <20220627211527.2245459-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: t7QfuFu6mo5G_CZZPZTUkywaokWrfsDL
X-Proofpoint-ORIG-GUID: t7QfuFu6mo5G_CZZPZTUkywaokWrfsDL
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

Remove support for legacy features and behaviors that previously had to
be disabled by calling libbpf_set_strict_mode():
  - legacy BPF map definitions are not supported now;
  - RLIMIT_MEMLOCK auto-setting, if necessary, is always on (but see
    libbpf_set_memlock_rlim());
  - program name is used for program pinning (instead of section name);
  - cleaned up error returning logic;
  - entry BPF programs should have SEC() always.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c             |   4 -
 tools/lib/bpf/libbpf.c          | 212 ++------------------------------
 tools/lib/bpf/libbpf.h          |  34 -----
 tools/lib/bpf/libbpf_internal.h |  24 +---
 tools/lib/bpf/libbpf_legacy.h   |  24 ++++
 5 files changed, 37 insertions(+), 261 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 2f3495d80d69..6d848b02c1e0 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -147,10 +147,6 @@ int bump_rlimit_memlock(void)
 {
 	struct rlimit rlim;
 
-	/* this the default in libbpf 1.0, but for now user has to opt-in explicitly */
-	if (!(libbpf_mode & LIBBPF_STRICT_AUTO_RLIMIT_MEMLOCK))
-		return 0;
-
 	/* if kernel supports memcg-based accounting, skip bumping RLIMIT_MEMLOCK */
 	if (memlock_bumped || kernel_supports(NULL, FEAT_MEMCG_ACCOUNT))
 		return 0;
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ae58cf2898ad..e994797bcd48 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -278,12 +278,9 @@ static inline __u64 ptr_to_u64(const void *ptr)
 	return (__u64) (unsigned long) ptr;
 }
 
-/* this goes away in libbpf 1.0 */
-enum libbpf_strict_mode libbpf_mode = LIBBPF_STRICT_NONE;
-
 int libbpf_set_strict_mode(enum libbpf_strict_mode mode)
 {
-	libbpf_mode = mode;
+	/* as of v1.0 libbpf_set_strict_mode() is a no-op */
 	return 0;
 }
 
@@ -367,9 +364,10 @@ struct bpf_sec_def {
  * linux/filter.h.
  */
 struct bpf_program {
-	const struct bpf_sec_def *sec_def;
+	char *name;
 	char *sec_name;
 	size_t sec_idx;
+	const struct bpf_sec_def *sec_def;
 	/* this program's instruction offset (in number of instructions)
 	 * within its containing ELF section
 	 */
@@ -389,12 +387,6 @@ struct bpf_program {
 	 */
 	size_t sub_insn_off;
 
-	char *name;
-	/* name with / replaced by _; makes recursive pinning
-	 * in bpf_object__pin_programs easier
-	 */
-	char *pin_name;
-
 	/* instructions that belong to BPF program; insns[0] is located at
 	 * sec_insn_off instruction within its ELF section in ELF file, so
 	 * when mapping ELF file instruction index to the local instruction,
@@ -695,7 +687,6 @@ static void bpf_program__exit(struct bpf_program *prog)
 	bpf_program__unload(prog);
 	zfree(&prog->name);
 	zfree(&prog->sec_name);
-	zfree(&prog->pin_name);
 	zfree(&prog->insns);
 	zfree(&prog->reloc_desc);
 
@@ -704,26 +695,6 @@ static void bpf_program__exit(struct bpf_program *prog)
 	prog->sec_idx = -1;
 }
 
-static char *__bpf_program__pin_name(struct bpf_program *prog)
-{
-	char *name, *p;
-
-	if (libbpf_mode & LIBBPF_STRICT_SEC_NAME)
-		name = strdup(prog->name);
-	else
-		name = strdup(prog->sec_name);
-
-	if (!name)
-		return NULL;
-
-	p = name;
-
-	while ((p = strchr(p, '/')))
-		*p = '_';
-
-	return name;
-}
-
 static bool insn_is_subprog_call(const struct bpf_insn *insn)
 {
 	return BPF_CLASS(insn->code) == BPF_JMP &&
@@ -790,10 +761,6 @@ bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
 	if (!prog->name)
 		goto errout;
 
-	prog->pin_name = __bpf_program__pin_name(prog);
-	if (!prog->pin_name)
-		goto errout;
-
 	prog->insns = malloc(insn_data_sz);
 	if (!prog->insns)
 		goto errout;
@@ -2007,143 +1974,6 @@ static int bpf_object__init_kconfig_map(struct bpf_object *obj)
 	return 0;
 }
 
-static int bpf_object__init_user_maps(struct bpf_object *obj, bool strict)
-{
-	Elf_Data *symbols = obj->efile.symbols;
-	int i, map_def_sz = 0, nr_maps = 0, nr_syms;
-	Elf_Data *data = NULL;
-	Elf_Scn *scn;
-
-	if (obj->efile.maps_shndx < 0)
-		return 0;
-
-	if (libbpf_mode & LIBBPF_STRICT_MAP_DEFINITIONS) {
-		pr_warn("legacy map definitions in SEC(\"maps\") are not supported\n");
-		return -EOPNOTSUPP;
-	}
-
-	if (!symbols)
-		return -EINVAL;
-
-	scn = elf_sec_by_idx(obj, obj->efile.maps_shndx);
-	data = elf_sec_data(obj, scn);
-	if (!scn || !data) {
-		pr_warn("elf: failed to get legacy map definitions for %s\n",
-			obj->path);
-		return -EINVAL;
-	}
-
-	/*
-	 * Count number of maps. Each map has a name.
-	 * Array of maps is not supported: only the first element is
-	 * considered.
-	 *
-	 * TODO: Detect array of map and report error.
-	 */
-	nr_syms = symbols->d_size / sizeof(Elf64_Sym);
-	for (i = 0; i < nr_syms; i++) {
-		Elf64_Sym *sym = elf_sym_by_idx(obj, i);
-
-		if (sym->st_shndx != obj->efile.maps_shndx)
-			continue;
-		if (ELF64_ST_TYPE(sym->st_info) == STT_SECTION)
-			continue;
-		nr_maps++;
-	}
-	/* Assume equally sized map definitions */
-	pr_debug("elf: found %d legacy map definitions (%zd bytes) in %s\n",
-		 nr_maps, data->d_size, obj->path);
-
-	if (!data->d_size || nr_maps == 0 || (data->d_size % nr_maps) != 0) {
-		pr_warn("elf: unable to determine legacy map definition size in %s\n",
-			obj->path);
-		return -EINVAL;
-	}
-	map_def_sz = data->d_size / nr_maps;
-
-	/* Fill obj->maps using data in "maps" section.  */
-	for (i = 0; i < nr_syms; i++) {
-		Elf64_Sym *sym = elf_sym_by_idx(obj, i);
-		const char *map_name;
-		struct bpf_map_def *def;
-		struct bpf_map *map;
-
-		if (sym->st_shndx != obj->efile.maps_shndx)
-			continue;
-		if (ELF64_ST_TYPE(sym->st_info) == STT_SECTION)
-			continue;
-
-		map = bpf_object__add_map(obj);
-		if (IS_ERR(map))
-			return PTR_ERR(map);
-
-		map_name = elf_sym_str(obj, sym->st_name);
-		if (!map_name) {
-			pr_warn("failed to get map #%d name sym string for obj %s\n",
-				i, obj->path);
-			return -LIBBPF_ERRNO__FORMAT;
-		}
-
-		pr_warn("map '%s' (legacy): legacy map definitions are deprecated, use BTF-defined maps instead\n", map_name);
-
-		if (ELF64_ST_BIND(sym->st_info) == STB_LOCAL) {
-			pr_warn("map '%s' (legacy): static maps are not supported\n", map_name);
-			return -ENOTSUP;
-		}
-
-		map->libbpf_type = LIBBPF_MAP_UNSPEC;
-		map->sec_idx = sym->st_shndx;
-		map->sec_offset = sym->st_value;
-		pr_debug("map '%s' (legacy): at sec_idx %d, offset %zu.\n",
-			 map_name, map->sec_idx, map->sec_offset);
-		if (sym->st_value + map_def_sz > data->d_size) {
-			pr_warn("corrupted maps section in %s: last map \"%s\" too small\n",
-				obj->path, map_name);
-			return -EINVAL;
-		}
-
-		map->name = strdup(map_name);
-		if (!map->name) {
-			pr_warn("map '%s': failed to alloc map name\n", map_name);
-			return -ENOMEM;
-		}
-		pr_debug("map %d is \"%s\"\n", i, map->name);
-		def = (struct bpf_map_def *)(data->d_buf + sym->st_value);
-		/*
-		 * If the definition of the map in the object file fits in
-		 * bpf_map_def, copy it.  Any extra fields in our version
-		 * of bpf_map_def will default to zero as a result of the
-		 * calloc above.
-		 */
-		if (map_def_sz <= sizeof(struct bpf_map_def)) {
-			memcpy(&map->def, def, map_def_sz);
-		} else {
-			/*
-			 * Here the map structure being read is bigger than what
-			 * we expect, truncate if the excess bits are all zero.
-			 * If they are not zero, reject this map as
-			 * incompatible.
-			 */
-			char *b;
-
-			for (b = ((char *)def) + sizeof(struct bpf_map_def);
-			     b < ((char *)def) + map_def_sz; b++) {
-				if (*b != 0) {
-					pr_warn("maps section in %s: \"%s\" has unrecognized, non-zero options\n",
-						obj->path, map_name);
-					if (strict)
-						return -EINVAL;
-				}
-			}
-			memcpy(&map->def, def, sizeof(struct bpf_map_def));
-		}
-
-		/* btf info may not exist but fill it in if it does exist */
-		(void) bpf_map_find_btf_info(obj, map);
-	}
-	return 0;
-}
-
 const struct btf_type *
 skip_mods_and_typedefs(const struct btf *btf, __u32 id, __u32 *res_id)
 {
@@ -2700,12 +2530,11 @@ static int bpf_object__init_maps(struct bpf_object *obj,
 {
 	const char *pin_root_path;
 	bool strict;
-	int err;
+	int err = 0;
 
 	strict = !OPTS_GET(opts, relaxed_maps, false);
 	pin_root_path = OPTS_GET(opts, pin_root_path, NULL);
 
-	err = bpf_object__init_user_maps(obj, strict);
 	err = err ?: bpf_object__init_user_btf_maps(obj, strict, pin_root_path);
 	err = err ?: bpf_object__init_global_data_maps(obj);
 	err = err ?: bpf_object__init_kconfig_map(obj);
@@ -3979,28 +3808,8 @@ static int bpf_object__collect_externs(struct bpf_object *obj)
 	return 0;
 }
 
-static bool prog_is_subprog(const struct bpf_object *obj,
-			    const struct bpf_program *prog)
-{
-	/* For legacy reasons, libbpf supports an entry-point BPF programs
-	 * without SEC() attribute, i.e., those in the .text section. But if
-	 * there are 2 or more such programs in the .text section, they all
-	 * must be subprograms called from entry-point BPF programs in
-	 * designated SEC()'tions, otherwise there is no way to distinguish
-	 * which of those programs should be loaded vs which are a subprogram.
-	 * Similarly, if there is a function/program in .text and at least one
-	 * other BPF program with custom SEC() attribute, then we just assume
-	 * .text programs are subprograms (even if they are not called from
-	 * other programs), because libbpf never explicitly supported mixing
-	 * SEC()-designated BPF programs and .text entry-point BPF programs.
-	 *
-	 * In libbpf 1.0 strict mode, we always consider .text
-	 * programs to be subprograms.
-	 */
-
-	if (libbpf_mode & LIBBPF_STRICT_SEC_NAME)
-		return prog->sec_idx == obj->efile.text_shndx;
-
+static bool prog_is_subprog(const struct bpf_object *obj, const struct bpf_program *prog)
+{
 	return prog->sec_idx == obj->efile.text_shndx && obj->nr_programs > 1;
 }
 
@@ -8163,8 +7972,7 @@ int bpf_object__pin_programs(struct bpf_object *obj, const char *path)
 		char buf[PATH_MAX];
 		int len;
 
-		len = snprintf(buf, PATH_MAX, "%s/%s", path,
-			       prog->pin_name);
+		len = snprintf(buf, PATH_MAX, "%s/%s", path, prog->name);
 		if (len < 0) {
 			err = -EINVAL;
 			goto err_unpin_programs;
@@ -8185,8 +7993,7 @@ int bpf_object__pin_programs(struct bpf_object *obj, const char *path)
 		char buf[PATH_MAX];
 		int len;
 
-		len = snprintf(buf, PATH_MAX, "%s/%s", path,
-			       prog->pin_name);
+		len = snprintf(buf, PATH_MAX, "%s/%s", path, prog->name);
 		if (len < 0)
 			continue;
 		else if (len >= PATH_MAX)
@@ -8210,8 +8017,7 @@ int bpf_object__unpin_programs(struct bpf_object *obj, const char *path)
 		char buf[PATH_MAX];
 		int len;
 
-		len = snprintf(buf, PATH_MAX, "%s/%s", path,
-			       prog->pin_name);
+		len = snprintf(buf, PATH_MAX, "%s/%s", path, prog->name);
 		if (len < 0)
 			return libbpf_err(-EINVAL);
 		else if (len >= PATH_MAX)
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 5eb3145b8945..e4d5353f757b 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -886,40 +886,6 @@ LIBBPF_API int bpf_map__lookup_and_delete_elem(const struct bpf_map *map,
 LIBBPF_API int bpf_map__get_next_key(const struct bpf_map *map,
 				     const void *cur_key, void *next_key, size_t key_sz);
 
-/**
- * @brief **libbpf_get_error()** extracts the error code from the passed
- * pointer
- * @param ptr pointer returned from libbpf API function
- * @return error code; or 0 if no error occured
- *
- * Many libbpf API functions which return pointers have logic to encode error
- * codes as pointers, and do not return NULL. Meaning **libbpf_get_error()**
- * should be used on the return value from these functions immediately after
- * calling the API function, with no intervening calls that could clobber the
- * `errno` variable. Consult the individual functions documentation to verify
- * if this logic applies should be used.
- *
- * For these API functions, if `libbpf_set_strict_mode(LIBBPF_STRICT_CLEAN_PTRS)`
- * is enabled, NULL is returned on error instead.
- *
- * If ptr is NULL, then errno should be already set by the failing
- * API, because libbpf never returns NULL on success and it now always
- * sets errno on error.
- *
- * Example usage:
- *
- *   struct perf_buffer *pb;
- *
- *   pb = perf_buffer__new(bpf_map__fd(obj->maps.events), PERF_BUFFER_PAGES, &opts);
- *   err = libbpf_get_error(pb);
- *   if (err) {
- *	  pb = NULL;
- *	  fprintf(stderr, "failed to open perf buffer: %d\n", err);
- *	  goto cleanup;
- *   }
- */
-LIBBPF_API long libbpf_get_error(const void *ptr);
-
 struct bpf_xdp_set_link_opts {
 	size_t sz;
 	int old_fd;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index a1ad145ffa74..9cd7829cbe41 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -15,7 +15,6 @@
 #include <linux/err.h>
 #include <fcntl.h>
 #include <unistd.h>
-#include "libbpf_legacy.h"
 #include "relo_core.h"
 
 /* make sure libbpf doesn't use kernel-only integer typedefs */
@@ -478,8 +477,6 @@ int btf_ext_visit_str_offs(struct btf_ext *btf_ext, str_off_visit_fn visit, void
 __s32 btf__find_by_name_kind_own(const struct btf *btf, const char *type_name,
 				 __u32 kind);
 
-extern enum libbpf_strict_mode libbpf_mode;
-
 typedef int (*kallsyms_cb_t)(unsigned long long sym_addr, char sym_type,
 			     const char *sym_name, void *ctx);
 
@@ -498,12 +495,8 @@ static inline int libbpf_err(int ret)
  */
 static inline int libbpf_err_errno(int ret)
 {
-	if (libbpf_mode & LIBBPF_STRICT_DIRECT_ERRS)
-		/* errno is already assumed to be set on error */
-		return ret < 0 ? -errno : ret;
-
-	/* legacy: on error return -1 directly and don't touch errno */
-	return ret;
+	/* errno is already assumed to be set on error */
+	return ret < 0 ? -errno : ret;
 }
 
 /* handle error for pointer-returning APIs, err is assumed to be < 0 always */
@@ -511,12 +504,7 @@ static inline void *libbpf_err_ptr(int err)
 {
 	/* set errno on error, this doesn't break anything */
 	errno = -err;
-
-	if (libbpf_mode & LIBBPF_STRICT_CLEAN_PTRS)
-		return NULL;
-
-	/* legacy: encode err as ptr */
-	return ERR_PTR(err);
+	return NULL;
 }
 
 /* handle pointer-returning APIs' error handling */
@@ -526,11 +514,7 @@ static inline void *libbpf_ptr(void *ret)
 	if (IS_ERR(ret))
 		errno = -PTR_ERR(ret);
 
-	if (libbpf_mode & LIBBPF_STRICT_CLEAN_PTRS)
-		return IS_ERR(ret) ? NULL : ret;
-
-	/* legacy: pass-through original pointer */
-	return ret;
+	return IS_ERR(ret) ? NULL : ret;
 }
 
 static inline bool str_is_empty(const char *s)
diff --git a/tools/lib/bpf/libbpf_legacy.h b/tools/lib/bpf/libbpf_legacy.h
index d7bcbd01f66f..863f49df8bf4 100644
--- a/tools/lib/bpf/libbpf_legacy.h
+++ b/tools/lib/bpf/libbpf_legacy.h
@@ -20,6 +20,11 @@
 extern "C" {
 #endif
 
+/* As of libbpf 1.0 libbpf_set_strict_mode() and enum libbpf_struct_mode have
+ * no effect. But they are left in libbpf_legacy.h so that applications that
+ * prepared for libbpf 1.0 before final release by using
+ * libbpf_set_strict_mode() still work with libbpf 1.0+ without any changes.
+ */
 enum libbpf_strict_mode {
 	/* Turn on all supported strict features of libbpf to simulate libbpf
 	 * v1.0 behavior.
@@ -88,6 +93,25 @@ enum libbpf_strict_mode {
 
 LIBBPF_API int libbpf_set_strict_mode(enum libbpf_strict_mode mode);
 
+/**
+ * @brief **libbpf_get_error()** extracts the error code from the passed
+ * pointer
+ * @param ptr pointer returned from libbpf API function
+ * @return error code; or 0 if no error occured
+ *
+ * Note, as of libbpf 1.0 this function is not necessary and not recommended
+ * to be used. Libbpf doesn't return error code embedded into the pointer
+ * itself. Instead, NULL is returned on error and error code is passed through
+ * thread-local errno variable. **libbpf_get_error()** is just returning -errno
+ * value if it receives NULL, which is correct only if errno hasn't been
+ * modified between libbpf API call and corresponding **libbpf_get_error()**
+ * call. Prefer to check return for NULL and use errno directly.
+ *
+ * This API is left in libbpf 1.0 to allow applications that were 1.0-ready
+ * before final libbpf 1.0 without needing to change them.
+ */
+LIBBPF_API long libbpf_get_error(const void *ptr);
+
 #define DECLARE_LIBBPF_OPTS LIBBPF_OPTS
 
 /* "Discouraged" APIs which don't follow consistent libbpf naming patterns.
-- 
2.30.2


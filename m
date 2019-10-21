Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 610D1DE436
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2019 07:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfJUF6i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Oct 2019 01:58:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55438 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725794AbfJUF6h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Oct 2019 01:58:37 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BF9F1F7898AA45536609;
        Mon, 21 Oct 2019 13:58:32 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Mon, 21 Oct 2019 13:58:26 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <daniel@iogearbox.net>
CC:     <pmladek@suse.com>, <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "Martin KaFai Lau" <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>,
        "Sergey Senozhatsky" <sergey.senozhatsky@gmail.com>
Subject: [bpf-next] tools lib bpf: Renaming pr_warning to pr_warn
Date:   Mon, 21 Oct 2019 13:55:32 +0800
Message-ID: <20191021055532.185245-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018185220.GE26267@pc-63.home>
References: <20191018185220.GE26267@pc-63.home>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For kernel logging macro, pr_warning is completely removed and
replaced by pr_warn, using pr_warn in tools lib bpf for symmetry
to kernel logging macro, then we could drop pr_warning in the
whole linux code.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Song Liu <songliubraving@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Cc: bpf@vger.kernel.org
Acked-by: Andrii Nakryiko <andriin@fb.com>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---

Based on git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

 tools/lib/bpf/btf.c             |  56 +--
 tools/lib/bpf/btf_dump.c        |  18 +-
 tools/lib/bpf/libbpf.c          | 693 ++++++++++++++++----------------
 tools/lib/bpf/libbpf_internal.h |   8 +-
 tools/lib/bpf/xsk.c             |   4 +-
 5 files changed, 386 insertions(+), 393 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 3eae8d1addfa..d72e9a79dce1 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -390,14 +390,14 @@ struct btf *btf__parse_elf(const char *path, struct btf_ext **btf_ext)
 	GElf_Ehdr ehdr;
 
 	if (elf_version(EV_CURRENT) == EV_NONE) {
-		pr_warning("failed to init libelf for %s\n", path);
+		pr_warn("failed to init libelf for %s\n", path);
 		return ERR_PTR(-LIBBPF_ERRNO__LIBELF);
 	}
 
 	fd = open(path, O_RDONLY);
 	if (fd < 0) {
 		err = -errno;
-		pr_warning("failed to open %s: %s\n", path, strerror(errno));
+		pr_warn("failed to open %s: %s\n", path, strerror(errno));
 		return ERR_PTR(err);
 	}
 
@@ -405,19 +405,19 @@ struct btf *btf__parse_elf(const char *path, struct btf_ext **btf_ext)
 
 	elf = elf_begin(fd, ELF_C_READ, NULL);
 	if (!elf) {
-		pr_warning("failed to open %s as ELF file\n", path);
+		pr_warn("failed to open %s as ELF file\n", path);
 		goto done;
 	}
 	if (!gelf_getehdr(elf, &ehdr)) {
-		pr_warning("failed to get EHDR from %s\n", path);
+		pr_warn("failed to get EHDR from %s\n", path);
 		goto done;
 	}
 	if (!btf_check_endianness(&ehdr)) {
-		pr_warning("non-native ELF endianness is not supported\n");
+		pr_warn("non-native ELF endianness is not supported\n");
 		goto done;
 	}
 	if (!elf_rawdata(elf_getscn(elf, ehdr.e_shstrndx), NULL)) {
-		pr_warning("failed to get e_shstrndx from %s\n", path);
+		pr_warn("failed to get e_shstrndx from %s\n", path);
 		goto done;
 	}
 
@@ -427,29 +427,29 @@ struct btf *btf__parse_elf(const char *path, struct btf_ext **btf_ext)
 
 		idx++;
 		if (gelf_getshdr(scn, &sh) != &sh) {
-			pr_warning("failed to get section(%d) header from %s\n",
-				   idx, path);
+			pr_warn("failed to get section(%d) header from %s\n",
+				idx, path);
 			goto done;
 		}
 		name = elf_strptr(elf, ehdr.e_shstrndx, sh.sh_name);
 		if (!name) {
-			pr_warning("failed to get section(%d) name from %s\n",
-				   idx, path);
+			pr_warn("failed to get section(%d) name from %s\n",
+				idx, path);
 			goto done;
 		}
 		if (strcmp(name, BTF_ELF_SEC) == 0) {
 			btf_data = elf_getdata(scn, 0);
 			if (!btf_data) {
-				pr_warning("failed to get section(%d, %s) data from %s\n",
-					   idx, name, path);
+				pr_warn("failed to get section(%d, %s) data from %s\n",
+					idx, name, path);
 				goto done;
 			}
 			continue;
 		} else if (btf_ext && strcmp(name, BTF_EXT_ELF_SEC) == 0) {
 			btf_ext_data = elf_getdata(scn, 0);
 			if (!btf_ext_data) {
-				pr_warning("failed to get section(%d, %s) data from %s\n",
-					   idx, name, path);
+				pr_warn("failed to get section(%d, %s) data from %s\n",
+					idx, name, path);
 				goto done;
 			}
 			continue;
@@ -600,9 +600,9 @@ int btf__load(struct btf *btf)
 			       log_buf, log_buf_size, false);
 	if (btf->fd < 0) {
 		err = -errno;
-		pr_warning("Error loading BTF: %s(%d)\n", strerror(errno), errno);
+		pr_warn("Error loading BTF: %s(%d)\n", strerror(errno), errno);
 		if (*log_buf)
-			pr_warning("%s\n", log_buf);
+			pr_warn("%s\n", log_buf);
 		goto done;
 	}
 
@@ -707,8 +707,8 @@ int btf__get_map_kv_tids(const struct btf *btf, const char *map_name,
 
 	if (snprintf(container_name, max_name, "____btf_map_%s", map_name) ==
 	    max_name) {
-		pr_warning("map:%s length of '____btf_map_%s' is too long\n",
-			   map_name, map_name);
+		pr_warn("map:%s length of '____btf_map_%s' is too long\n",
+			map_name, map_name);
 		return -EINVAL;
 	}
 
@@ -721,14 +721,14 @@ int btf__get_map_kv_tids(const struct btf *btf, const char *map_name,
 
 	container_type = btf__type_by_id(btf, container_id);
 	if (!container_type) {
-		pr_warning("map:%s cannot find BTF type for container_id:%u\n",
-			   map_name, container_id);
+		pr_warn("map:%s cannot find BTF type for container_id:%u\n",
+			map_name, container_id);
 		return -EINVAL;
 	}
 
 	if (!btf_is_struct(container_type) || btf_vlen(container_type) < 2) {
-		pr_warning("map:%s container_name:%s is an invalid container struct\n",
-			   map_name, container_name);
+		pr_warn("map:%s container_name:%s is an invalid container struct\n",
+			map_name, container_name);
 		return -EINVAL;
 	}
 
@@ -737,25 +737,25 @@ int btf__get_map_kv_tids(const struct btf *btf, const char *map_name,
 
 	key_size = btf__resolve_size(btf, key->type);
 	if (key_size < 0) {
-		pr_warning("map:%s invalid BTF key_type_size\n", map_name);
+		pr_warn("map:%s invalid BTF key_type_size\n", map_name);
 		return key_size;
 	}
 
 	if (expected_key_size != key_size) {
-		pr_warning("map:%s btf_key_type_size:%u != map_def_key_size:%u\n",
-			   map_name, (__u32)key_size, expected_key_size);
+		pr_warn("map:%s btf_key_type_size:%u != map_def_key_size:%u\n",
+			map_name, (__u32)key_size, expected_key_size);
 		return -EINVAL;
 	}
 
 	value_size = btf__resolve_size(btf, value->type);
 	if (value_size < 0) {
-		pr_warning("map:%s invalid BTF value_type_size\n", map_name);
+		pr_warn("map:%s invalid BTF value_type_size\n", map_name);
 		return value_size;
 	}
 
 	if (expected_value_size != value_size) {
-		pr_warning("map:%s btf_value_type_size:%u != map_def_value_size:%u\n",
-			   map_name, (__u32)value_size, expected_value_size);
+		pr_warn("map:%s btf_value_type_size:%u != map_def_value_size:%u\n",
+			map_name, (__u32)value_size, expected_value_size);
 		return -EINVAL;
 	}
 
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 139812b46c7b..cb126d8fcf75 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -428,7 +428,7 @@ static int btf_dump_order_type(struct btf_dump *d, __u32 id, bool through_ptr)
 		/* type loop, but resolvable through fwd declaration */
 		if (btf_is_composite(t) && through_ptr && t->name_off != 0)
 			return 0;
-		pr_warning("unsatisfiable type cycle, id:[%u]\n", id);
+		pr_warn("unsatisfiable type cycle, id:[%u]\n", id);
 		return -ELOOP;
 	}
 
@@ -636,8 +636,8 @@ static void btf_dump_emit_type(struct btf_dump *d, __u32 id, __u32 cont_id)
 			if (id == cont_id)
 				return;
 			if (t->name_off == 0) {
-				pr_warning("anonymous struct/union loop, id:[%u]\n",
-					   id);
+				pr_warn("anonymous struct/union loop, id:[%u]\n",
+					id);
 				return;
 			}
 			btf_dump_emit_struct_fwd(d, id, t);
@@ -782,7 +782,7 @@ static int btf_align_of(const struct btf *btf, __u32 id)
 		return align;
 	}
 	default:
-		pr_warning("unsupported BTF_KIND:%u\n", btf_kind(t));
+		pr_warn("unsupported BTF_KIND:%u\n", btf_kind(t));
 		return 1;
 	}
 }
@@ -1067,7 +1067,7 @@ static void btf_dump_emit_type_decl(struct btf_dump *d, __u32 id,
 			 * chain, restore stack, emit warning, and try to
 			 * proceed nevertheless
 			 */
-			pr_warning("not enough memory for decl stack:%d", err);
+			pr_warn("not enough memory for decl stack:%d", err);
 			d->decl_stack_cnt = stack_start;
 			return;
 		}
@@ -1096,8 +1096,8 @@ static void btf_dump_emit_type_decl(struct btf_dump *d, __u32 id,
 		case BTF_KIND_TYPEDEF:
 			goto done;
 		default:
-			pr_warning("unexpected type in decl chain, kind:%u, id:[%u]\n",
-				   btf_kind(t), id);
+			pr_warn("unexpected type in decl chain, kind:%u, id:[%u]\n",
+				btf_kind(t), id);
 			goto done;
 		}
 	}
@@ -1323,8 +1323,8 @@ static void btf_dump_emit_type_chain(struct btf_dump *d,
 			return;
 		}
 		default:
-			pr_warning("unexpected type in decl chain, kind:%u, id:[%u]\n",
-				   kind, id);
+			pr_warn("unexpected type in decl chain, kind:%u, id:[%u]\n",
+				kind, id);
 			return;
 		}
 
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index cccfd9355134..31c8acddc17b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -312,8 +312,8 @@ void bpf_program__unload(struct bpf_program *prog)
 		for (i = 0; i < prog->instances.nr; i++)
 			zclose(prog->instances.fds[i]);
 	} else if (prog->instances.nr != -1) {
-		pr_warning("Internal error: instances.nr is %d\n",
-			   prog->instances.nr);
+		pr_warn("Internal error: instances.nr is %d\n",
+			prog->instances.nr);
 	}
 
 	prog->instances.nr = -1;
@@ -364,8 +364,8 @@ bpf_program__init(void *data, size_t size, char *section_name, int idx,
 	const size_t bpf_insn_sz = sizeof(struct bpf_insn);
 
 	if (size == 0 || size % bpf_insn_sz) {
-		pr_warning("corrupted section '%s', size: %zu\n",
-			   section_name, size);
+		pr_warn("corrupted section '%s', size: %zu\n",
+			section_name, size);
 		return -EINVAL;
 	}
 
@@ -373,22 +373,22 @@ bpf_program__init(void *data, size_t size, char *section_name, int idx,
 
 	prog->section_name = strdup(section_name);
 	if (!prog->section_name) {
-		pr_warning("failed to alloc name for prog under section(%d) %s\n",
-			   idx, section_name);
+		pr_warn("failed to alloc name for prog under section(%d) %s\n",
+			idx, section_name);
 		goto errout;
 	}
 
 	prog->pin_name = __bpf_program__pin_name(prog);
 	if (!prog->pin_name) {
-		pr_warning("failed to alloc pin name for prog under section(%d) %s\n",
-			   idx, section_name);
+		pr_warn("failed to alloc pin name for prog under section(%d) %s\n",
+			idx, section_name);
 		goto errout;
 	}
 
 	prog->insns = malloc(size);
 	if (!prog->insns) {
-		pr_warning("failed to alloc insns for prog under section %s\n",
-			   section_name);
+		pr_warn("failed to alloc insns for prog under section %s\n",
+			section_name);
 		goto errout;
 	}
 	prog->insns_cnt = size / bpf_insn_sz;
@@ -426,8 +426,8 @@ bpf_object__add_program(struct bpf_object *obj, void *data, size_t size,
 		 * is still valid, so don't need special treat for
 		 * bpf_close_object().
 		 */
-		pr_warning("failed to alloc a new program under section '%s'\n",
-			   section_name);
+		pr_warn("failed to alloc a new program under section '%s'\n",
+			section_name);
 		bpf_program__exit(&prog);
 		return -ENOMEM;
 	}
@@ -467,8 +467,8 @@ bpf_object__init_prog_names(struct bpf_object *obj)
 					  obj->efile.strtabidx,
 					  sym.st_name);
 			if (!name) {
-				pr_warning("failed to get sym name string for prog %s\n",
-					   prog->section_name);
+				pr_warn("failed to get sym name string for prog %s\n",
+					prog->section_name);
 				return -LIBBPF_ERRNO__LIBELF;
 			}
 		}
@@ -477,15 +477,15 @@ bpf_object__init_prog_names(struct bpf_object *obj)
 			name = ".text";
 
 		if (!name) {
-			pr_warning("failed to find sym for prog %s\n",
-				   prog->section_name);
+			pr_warn("failed to find sym for prog %s\n",
+				prog->section_name);
 			return -EINVAL;
 		}
 
 		prog->name = strdup(name);
 		if (!prog->name) {
-			pr_warning("failed to allocate memory for prog sym %s\n",
-				   name);
+			pr_warn("failed to allocate memory for prog sym %s\n",
+				name);
 			return -ENOMEM;
 		}
 	}
@@ -514,7 +514,7 @@ static struct bpf_object *bpf_object__new(const char *path,
 
 	obj = calloc(1, sizeof(struct bpf_object) + strlen(path) + 1);
 	if (!obj) {
-		pr_warning("alloc memory failed for %s\n", path);
+		pr_warn("alloc memory failed for %s\n", path);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -581,7 +581,7 @@ static int bpf_object__elf_init(struct bpf_object *obj)
 	GElf_Ehdr *ep;
 
 	if (obj_elf_valid(obj)) {
-		pr_warning("elf init: internal error\n");
+		pr_warn("elf init: internal error\n");
 		return -LIBBPF_ERRNO__LIBELF;
 	}
 
@@ -599,7 +599,7 @@ static int bpf_object__elf_init(struct bpf_object *obj)
 
 			err = -errno;
 			cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
-			pr_warning("failed to open %s: %s\n", obj->path, cp);
+			pr_warn("failed to open %s: %s\n", obj->path, cp);
 			return err;
 		}
 
@@ -608,13 +608,13 @@ static int bpf_object__elf_init(struct bpf_object *obj)
 	}
 
 	if (!obj->efile.elf) {
-		pr_warning("failed to open %s as ELF file\n", obj->path);
+		pr_warn("failed to open %s as ELF file\n", obj->path);
 		err = -LIBBPF_ERRNO__LIBELF;
 		goto errout;
 	}
 
 	if (!gelf_getehdr(obj->efile.elf, &obj->efile.ehdr)) {
-		pr_warning("failed to get EHDR from %s\n", obj->path);
+		pr_warn("failed to get EHDR from %s\n", obj->path);
 		err = -LIBBPF_ERRNO__FORMAT;
 		goto errout;
 	}
@@ -623,7 +623,7 @@ static int bpf_object__elf_init(struct bpf_object *obj)
 	/* Old LLVM set e_machine to EM_NONE */
 	if (ep->e_type != ET_REL ||
 	    (ep->e_machine && ep->e_machine != EM_BPF)) {
-		pr_warning("%s is not an eBPF object file\n", obj->path);
+		pr_warn("%s is not an eBPF object file\n", obj->path);
 		err = -LIBBPF_ERRNO__FORMAT;
 		goto errout;
 	}
@@ -645,7 +645,7 @@ static int bpf_object__check_endianness(struct bpf_object *obj)
 #else
 # error "Unrecognized __BYTE_ORDER__"
 #endif
-	pr_warning("endianness mismatch.\n");
+	pr_warn("endianness mismatch.\n");
 	return -LIBBPF_ERRNO__ENDIAN;
 }
 
@@ -663,7 +663,7 @@ bpf_object__init_kversion(struct bpf_object *obj, void *data, size_t size)
 	__u32 kver;
 
 	if (size != sizeof(kver)) {
-		pr_warning("invalid kver section in %s\n", obj->path);
+		pr_warn("invalid kver section in %s\n", obj->path);
 		return -LIBBPF_ERRNO__FORMAT;
 	}
 	memcpy(&kver, data, sizeof(kver));
@@ -705,15 +705,15 @@ static int bpf_object_search_section_size(const struct bpf_object *obj,
 
 		idx++;
 		if (gelf_getshdr(scn, &sh) != &sh) {
-			pr_warning("failed to get section(%d) header from %s\n",
-				   idx, obj->path);
+			pr_warn("failed to get section(%d) header from %s\n",
+				idx, obj->path);
 			return -EIO;
 		}
 
 		sec_name = elf_strptr(elf, ep->e_shstrndx, sh.sh_name);
 		if (!sec_name) {
-			pr_warning("failed to get section(%d) name from %s\n",
-				   idx, obj->path);
+			pr_warn("failed to get section(%d) name from %s\n",
+				idx, obj->path);
 			return -EIO;
 		}
 
@@ -722,8 +722,8 @@ static int bpf_object_search_section_size(const struct bpf_object *obj,
 
 		data = elf_getdata(scn, 0);
 		if (!data) {
-			pr_warning("failed to get section(%d) data from %s(%s)\n",
-				   idx, name, obj->path);
+			pr_warn("failed to get section(%d) data from %s(%s)\n",
+				idx, name, obj->path);
 			return -EIO;
 		}
 
@@ -783,8 +783,8 @@ int bpf_object__variable_offset(const struct bpf_object *obj, const char *name,
 		sname = elf_strptr(obj->efile.elf, obj->efile.strtabidx,
 				   sym.st_name);
 		if (!sname) {
-			pr_warning("failed to get sym name string for var %s\n",
-				   name);
+			pr_warn("failed to get sym name string for var %s\n",
+				name);
 			return -EIO;
 		}
 		if (strcmp(name, sname) == 0) {
@@ -808,7 +808,7 @@ static struct bpf_map *bpf_object__add_map(struct bpf_object *obj)
 	new_cap = max((size_t)4, obj->maps_cap * 3 / 2);
 	new_maps = realloc(obj->maps, new_cap * sizeof(*obj->maps));
 	if (!new_maps) {
-		pr_warning("alloc maps for object failed\n");
+		pr_warn("alloc maps for object failed\n");
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -849,7 +849,7 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
 		 libbpf_type_to_btf_name[type]);
 	map->name = strdup(map_name);
 	if (!map->name) {
-		pr_warning("failed to alloc map name\n");
+		pr_warn("failed to alloc map name\n");
 		return -ENOMEM;
 	}
 	pr_debug("map '%s' (global data): at sec_idx %d, offset %zu.\n",
@@ -865,7 +865,7 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
 		*data_buff = malloc(data->d_size);
 		if (!*data_buff) {
 			zfree(&map->name);
-			pr_warning("failed to alloc map content buffer\n");
+			pr_warn("failed to alloc map content buffer\n");
 			return -ENOMEM;
 		}
 		memcpy(*data_buff, data->d_buf, data->d_size);
@@ -927,8 +927,8 @@ static int bpf_object__init_user_maps(struct bpf_object *obj, bool strict)
 	if (scn)
 		data = elf_getdata(scn, NULL);
 	if (!scn || !data) {
-		pr_warning("failed to get Elf_Data from map section %d\n",
-			   obj->efile.maps_shndx);
+		pr_warn("failed to get Elf_Data from map section %d\n",
+			obj->efile.maps_shndx);
 		return -EINVAL;
 	}
 
@@ -955,9 +955,9 @@ static int bpf_object__init_user_maps(struct bpf_object *obj, bool strict)
 
 	map_def_sz = data->d_size / nr_maps;
 	if (!data->d_size || (data->d_size % nr_maps) != 0) {
-		pr_warning("unable to determine map definition size "
-			   "section %s, %d maps in %zd bytes\n",
-			   obj->path, nr_maps, data->d_size);
+		pr_warn("unable to determine map definition size "
+			"section %s, %d maps in %zd bytes\n",
+			obj->path, nr_maps, data->d_size);
 		return -EINVAL;
 	}
 
@@ -980,8 +980,8 @@ static int bpf_object__init_user_maps(struct bpf_object *obj, bool strict)
 		map_name = elf_strptr(obj->efile.elf, obj->efile.strtabidx,
 				      sym.st_name);
 		if (!map_name) {
-			pr_warning("failed to get map #%d name sym string for obj %s\n",
-				   i, obj->path);
+			pr_warn("failed to get map #%d name sym string for obj %s\n",
+				i, obj->path);
 			return -LIBBPF_ERRNO__FORMAT;
 		}
 
@@ -991,14 +991,14 @@ static int bpf_object__init_user_maps(struct bpf_object *obj, bool strict)
 		pr_debug("map '%s' (legacy): at sec_idx %d, offset %zu.\n",
 			 map_name, map->sec_idx, map->sec_offset);
 		if (sym.st_value + map_def_sz > data->d_size) {
-			pr_warning("corrupted maps section in %s: last map \"%s\" too small\n",
-				   obj->path, map_name);
+			pr_warn("corrupted maps section in %s: last map \"%s\" too small\n",
+				obj->path, map_name);
 			return -EINVAL;
 		}
 
 		map->name = strdup(map_name);
 		if (!map->name) {
-			pr_warning("failed to alloc map name\n");
+			pr_warn("failed to alloc map name\n");
 			return -ENOMEM;
 		}
 		pr_debug("map %d is \"%s\"\n", i, map->name);
@@ -1022,10 +1022,10 @@ static int bpf_object__init_user_maps(struct bpf_object *obj, bool strict)
 			for (b = ((char *)def) + sizeof(struct bpf_map_def);
 			     b < ((char *)def) + map_def_sz; b++) {
 				if (*b != 0) {
-					pr_warning("maps section in %s: \"%s\" "
-						   "has unrecognized, non-zero "
-						   "options\n",
-						   obj->path, map_name);
+					pr_warn("maps section in %s: \"%s\" "
+						"has unrecognized, non-zero "
+						"options\n",
+						obj->path, map_name);
 					if (strict)
 						return -EINVAL;
 				}
@@ -1069,20 +1069,20 @@ static bool get_map_field_int(const char *map_name, const struct btf *btf,
 	const struct btf_type *arr_t;
 
 	if (!btf_is_ptr(t)) {
-		pr_warning("map '%s': attr '%s': expected PTR, got %u.\n",
-			   map_name, name, btf_kind(t));
+		pr_warn("map '%s': attr '%s': expected PTR, got %u.\n",
+			map_name, name, btf_kind(t));
 		return false;
 	}
 
 	arr_t = btf__type_by_id(btf, t->type);
 	if (!arr_t) {
-		pr_warning("map '%s': attr '%s': type [%u] not found.\n",
-			   map_name, name, t->type);
+		pr_warn("map '%s': attr '%s': type [%u] not found.\n",
+			map_name, name, t->type);
 		return false;
 	}
 	if (!btf_is_array(arr_t)) {
-		pr_warning("map '%s': attr '%s': expected ARRAY, got %u.\n",
-			   map_name, name, btf_kind(arr_t));
+		pr_warn("map '%s': attr '%s': expected ARRAY, got %u.\n",
+			map_name, name, btf_kind(arr_t));
 		return false;
 	}
 	arr_info = btf_array(arr_t);
@@ -1110,33 +1110,33 @@ static int bpf_object__init_user_btf_map(struct bpf_object *obj,
 	vlen = btf_vlen(var);
 
 	if (map_name == NULL || map_name[0] == '\0') {
-		pr_warning("map #%d: empty name.\n", var_idx);
+		pr_warn("map #%d: empty name.\n", var_idx);
 		return -EINVAL;
 	}
 	if ((__u64)vi->offset + vi->size > data->d_size) {
-		pr_warning("map '%s' BTF data is corrupted.\n", map_name);
+		pr_warn("map '%s' BTF data is corrupted.\n", map_name);
 		return -EINVAL;
 	}
 	if (!btf_is_var(var)) {
-		pr_warning("map '%s': unexpected var kind %u.\n",
-			   map_name, btf_kind(var));
+		pr_warn("map '%s': unexpected var kind %u.\n",
+			map_name, btf_kind(var));
 		return -EINVAL;
 	}
 	if (var_extra->linkage != BTF_VAR_GLOBAL_ALLOCATED &&
 	    var_extra->linkage != BTF_VAR_STATIC) {
-		pr_warning("map '%s': unsupported var linkage %u.\n",
-			   map_name, var_extra->linkage);
+		pr_warn("map '%s': unsupported var linkage %u.\n",
+			map_name, var_extra->linkage);
 		return -EOPNOTSUPP;
 	}
 
 	def = skip_mods_and_typedefs(obj->btf, var->type, NULL);
 	if (!btf_is_struct(def)) {
-		pr_warning("map '%s': unexpected def kind %u.\n",
-			   map_name, btf_kind(var));
+		pr_warn("map '%s': unexpected def kind %u.\n",
+			map_name, btf_kind(var));
 		return -EINVAL;
 	}
 	if (def->size > vi->size) {
-		pr_warning("map '%s': invalid def size.\n", map_name);
+		pr_warn("map '%s': invalid def size.\n", map_name);
 		return -EINVAL;
 	}
 
@@ -1145,7 +1145,7 @@ static int bpf_object__init_user_btf_map(struct bpf_object *obj,
 		return PTR_ERR(map);
 	map->name = strdup(map_name);
 	if (!map->name) {
-		pr_warning("map '%s': failed to alloc map name.\n", map_name);
+		pr_warn("map '%s': failed to alloc map name.\n", map_name);
 		return -ENOMEM;
 	}
 	map->libbpf_type = LIBBPF_MAP_UNSPEC;
@@ -1161,8 +1161,7 @@ static int bpf_object__init_user_btf_map(struct bpf_object *obj,
 		const char *name = btf__name_by_offset(obj->btf, m->name_off);
 
 		if (!name) {
-			pr_warning("map '%s': invalid field #%d.\n",
-				   map_name, i);
+			pr_warn("map '%s': invalid field #%d.\n", map_name, i);
 			return -EINVAL;
 		}
 		if (strcmp(name, "type") == 0) {
@@ -1192,8 +1191,8 @@ static int bpf_object__init_user_btf_map(struct bpf_object *obj,
 			pr_debug("map '%s': found key_size = %u.\n",
 				 map_name, sz);
 			if (map->def.key_size && map->def.key_size != sz) {
-				pr_warning("map '%s': conflicting key size %u != %u.\n",
-					   map_name, map->def.key_size, sz);
+				pr_warn("map '%s': conflicting key size %u != %u.\n",
+					map_name, map->def.key_size, sz);
 				return -EINVAL;
 			}
 			map->def.key_size = sz;
@@ -1202,26 +1201,26 @@ static int bpf_object__init_user_btf_map(struct bpf_object *obj,
 
 			t = btf__type_by_id(obj->btf, m->type);
 			if (!t) {
-				pr_warning("map '%s': key type [%d] not found.\n",
-					   map_name, m->type);
+				pr_warn("map '%s': key type [%d] not found.\n",
+					map_name, m->type);
 				return -EINVAL;
 			}
 			if (!btf_is_ptr(t)) {
-				pr_warning("map '%s': key spec is not PTR: %u.\n",
-					   map_name, btf_kind(t));
+				pr_warn("map '%s': key spec is not PTR: %u.\n",
+					map_name, btf_kind(t));
 				return -EINVAL;
 			}
 			sz = btf__resolve_size(obj->btf, t->type);
 			if (sz < 0) {
-				pr_warning("map '%s': can't determine key size for type [%u]: %lld.\n",
-					   map_name, t->type, sz);
+				pr_warn("map '%s': can't determine key size for type [%u]: %lld.\n",
+					map_name, t->type, sz);
 				return sz;
 			}
 			pr_debug("map '%s': found key [%u], sz = %lld.\n",
 				 map_name, t->type, sz);
 			if (map->def.key_size && map->def.key_size != sz) {
-				pr_warning("map '%s': conflicting key size %u != %lld.\n",
-					   map_name, map->def.key_size, sz);
+				pr_warn("map '%s': conflicting key size %u != %lld.\n",
+					map_name, map->def.key_size, sz);
 				return -EINVAL;
 			}
 			map->def.key_size = sz;
@@ -1235,8 +1234,8 @@ static int bpf_object__init_user_btf_map(struct bpf_object *obj,
 			pr_debug("map '%s': found value_size = %u.\n",
 				 map_name, sz);
 			if (map->def.value_size && map->def.value_size != sz) {
-				pr_warning("map '%s': conflicting value size %u != %u.\n",
-					   map_name, map->def.value_size, sz);
+				pr_warn("map '%s': conflicting value size %u != %u.\n",
+					map_name, map->def.value_size, sz);
 				return -EINVAL;
 			}
 			map->def.value_size = sz;
@@ -1245,34 +1244,34 @@ static int bpf_object__init_user_btf_map(struct bpf_object *obj,
 
 			t = btf__type_by_id(obj->btf, m->type);
 			if (!t) {
-				pr_warning("map '%s': value type [%d] not found.\n",
-					   map_name, m->type);
+				pr_warn("map '%s': value type [%d] not found.\n",
+					map_name, m->type);
 				return -EINVAL;
 			}
 			if (!btf_is_ptr(t)) {
-				pr_warning("map '%s': value spec is not PTR: %u.\n",
-					   map_name, btf_kind(t));
+				pr_warn("map '%s': value spec is not PTR: %u.\n",
+					map_name, btf_kind(t));
 				return -EINVAL;
 			}
 			sz = btf__resolve_size(obj->btf, t->type);
 			if (sz < 0) {
-				pr_warning("map '%s': can't determine value size for type [%u]: %lld.\n",
-					   map_name, t->type, sz);
+				pr_warn("map '%s': can't determine value size for type [%u]: %lld.\n",
+					map_name, t->type, sz);
 				return sz;
 			}
 			pr_debug("map '%s': found value [%u], sz = %lld.\n",
 				 map_name, t->type, sz);
 			if (map->def.value_size && map->def.value_size != sz) {
-				pr_warning("map '%s': conflicting value size %u != %lld.\n",
-					   map_name, map->def.value_size, sz);
+				pr_warn("map '%s': conflicting value size %u != %lld.\n",
+					map_name, map->def.value_size, sz);
 				return -EINVAL;
 			}
 			map->def.value_size = sz;
 			map->btf_value_type_id = t->type;
 		} else {
 			if (strict) {
-				pr_warning("map '%s': unknown field '%s'.\n",
-					   map_name, name);
+				pr_warn("map '%s': unknown field '%s'.\n",
+					map_name, name);
 				return -ENOTSUP;
 			}
 			pr_debug("map '%s': ignoring unknown field '%s'.\n",
@@ -1281,7 +1280,7 @@ static int bpf_object__init_user_btf_map(struct bpf_object *obj,
 	}
 
 	if (map->def.type == BPF_MAP_TYPE_UNSPEC) {
-		pr_warning("map '%s': map type isn't specified.\n", map_name);
+		pr_warn("map '%s': map type isn't specified.\n", map_name);
 		return -EINVAL;
 	}
 
@@ -1304,8 +1303,8 @@ static int bpf_object__init_user_btf_maps(struct bpf_object *obj, bool strict)
 	if (scn)
 		data = elf_getdata(scn, NULL);
 	if (!scn || !data) {
-		pr_warning("failed to get Elf_Data from map section %d (%s)\n",
-			   obj->efile.maps_shndx, MAPS_ELF_SEC);
+		pr_warn("failed to get Elf_Data from map section %d (%s)\n",
+			obj->efile.maps_shndx, MAPS_ELF_SEC);
 		return -EINVAL;
 	}
 
@@ -1322,7 +1321,7 @@ static int bpf_object__init_user_btf_maps(struct bpf_object *obj, bool strict)
 	}
 
 	if (!sec) {
-		pr_warning("DATASEC '%s' not found.\n", MAPS_ELF_SEC);
+		pr_warn("DATASEC '%s' not found.\n", MAPS_ELF_SEC);
 		return -ENOENT;
 	}
 
@@ -1466,14 +1465,13 @@ static int bpf_object__init_btf(struct bpf_object *obj,
 	if (btf_data) {
 		obj->btf = btf__new(btf_data->d_buf, btf_data->d_size);
 		if (IS_ERR(obj->btf)) {
-			pr_warning("Error loading ELF section %s: %d.\n",
-				   BTF_ELF_SEC, err);
+			pr_warn("Error loading ELF section %s: %d.\n",
+				BTF_ELF_SEC, err);
 			goto out;
 		}
 		err = btf__finalize_data(obj, obj->btf);
 		if (err) {
-			pr_warning("Error finalizing %s: %d.\n",
-				   BTF_ELF_SEC, err);
+			pr_warn("Error finalizing %s: %d.\n", BTF_ELF_SEC, err);
 			goto out;
 		}
 	}
@@ -1486,8 +1484,8 @@ static int bpf_object__init_btf(struct bpf_object *obj,
 		obj->btf_ext = btf_ext__new(btf_ext_data->d_buf,
 					    btf_ext_data->d_size);
 		if (IS_ERR(obj->btf_ext)) {
-			pr_warning("Error loading ELF section %s: %ld. Ignored and continue.\n",
-				   BTF_EXT_ELF_SEC, PTR_ERR(obj->btf_ext));
+			pr_warn("Error loading ELF section %s: %ld. Ignored and continue.\n",
+				BTF_EXT_ELF_SEC, PTR_ERR(obj->btf_ext));
 			obj->btf_ext = NULL;
 			goto out;
 		}
@@ -1503,7 +1501,7 @@ static int bpf_object__init_btf(struct bpf_object *obj,
 		obj->btf = NULL;
 	}
 	if (btf_required && !obj->btf) {
-		pr_warning("BTF is required, but is missing or corrupted.\n");
+		pr_warn("BTF is required, but is missing or corrupted.\n");
 		return err == 0 ? -ENOENT : err;
 	}
 	return 0;
@@ -1521,8 +1519,8 @@ static int bpf_object__sanitize_and_load_btf(struct bpf_object *obj)
 
 	err = btf__load(obj->btf);
 	if (err) {
-		pr_warning("Error loading %s into kernel: %d.\n",
-			   BTF_ELF_SEC, err);
+		pr_warn("Error loading %s into kernel: %d.\n",
+			BTF_ELF_SEC, err);
 		btf__free(obj->btf);
 		obj->btf = NULL;
 		/* btf_ext can't exist without btf, so free it as well */
@@ -1548,7 +1546,7 @@ static int bpf_object__elf_collect(struct bpf_object *obj, bool relaxed_maps)
 
 	/* Elf is corrupted/truncated, avoid calling elf_strptr. */
 	if (!elf_rawdata(elf_getscn(elf, ep->e_shstrndx), NULL)) {
-		pr_warning("failed to get e_shstrndx from %s\n", obj->path);
+		pr_warn("failed to get e_shstrndx from %s\n", obj->path);
 		return -LIBBPF_ERRNO__FORMAT;
 	}
 
@@ -1559,22 +1557,22 @@ static int bpf_object__elf_collect(struct bpf_object *obj, bool relaxed_maps)
 
 		idx++;
 		if (gelf_getshdr(scn, &sh) != &sh) {
-			pr_warning("failed to get section(%d) header from %s\n",
-				   idx, obj->path);
+			pr_warn("failed to get section(%d) header from %s\n",
+				idx, obj->path);
 			return -LIBBPF_ERRNO__FORMAT;
 		}
 
 		name = elf_strptr(elf, ep->e_shstrndx, sh.sh_name);
 		if (!name) {
-			pr_warning("failed to get section(%d) name from %s\n",
-				   idx, obj->path);
+			pr_warn("failed to get section(%d) name from %s\n",
+				idx, obj->path);
 			return -LIBBPF_ERRNO__FORMAT;
 		}
 
 		data = elf_getdata(scn, 0);
 		if (!data) {
-			pr_warning("failed to get section(%d) data from %s(%s)\n",
-				   idx, name, obj->path);
+			pr_warn("failed to get section(%d) data from %s(%s)\n",
+				idx, name, obj->path);
 			return -LIBBPF_ERRNO__FORMAT;
 		}
 		pr_debug("section(%d) %s, size %ld, link %d, flags %lx, type=%d\n",
@@ -1604,8 +1602,8 @@ static int bpf_object__elf_collect(struct bpf_object *obj, bool relaxed_maps)
 			btf_ext_data = data;
 		} else if (sh.sh_type == SHT_SYMTAB) {
 			if (obj->efile.symbols) {
-				pr_warning("bpf: multiple SYMTAB in %s\n",
-					   obj->path);
+				pr_warn("bpf: multiple SYMTAB in %s\n",
+					obj->path);
 				return -LIBBPF_ERRNO__FORMAT;
 			}
 			obj->efile.symbols = data;
@@ -1621,8 +1619,8 @@ static int bpf_object__elf_collect(struct bpf_object *obj, bool relaxed_maps)
 					char *cp = libbpf_strerror_r(-err, errmsg,
 								     sizeof(errmsg));
 
-					pr_warning("failed to alloc program %s (%s): %s",
-						   name, obj->path, cp);
+					pr_warn("failed to alloc program %s (%s): %s",
+						name, obj->path, cp);
 					return err;
 				}
 			} else if (strcmp(name, ".data") == 0) {
@@ -1649,7 +1647,7 @@ static int bpf_object__elf_collect(struct bpf_object *obj, bool relaxed_maps)
 			reloc = reallocarray(reloc, nr_reloc + 1,
 					     sizeof(*obj->efile.reloc));
 			if (!reloc) {
-				pr_warning("realloc failed\n");
+				pr_warn("realloc failed\n");
 				return -ENOMEM;
 			}
 
@@ -1667,7 +1665,7 @@ static int bpf_object__elf_collect(struct bpf_object *obj, bool relaxed_maps)
 	}
 
 	if (!obj->efile.strtabidx || obj->efile.strtabidx >= idx) {
-		pr_warning("Corrupted ELF file: index of strtab invalid\n");
+		pr_warn("Corrupted ELF file: index of strtab invalid\n");
 		return -LIBBPF_ERRNO__FORMAT;
 	}
 	err = bpf_object__init_btf(obj, btf_data, btf_ext_data);
@@ -1757,7 +1755,7 @@ bpf_program__collect_reloc(struct bpf_program *prog, GElf_Shdr *shdr,
 
 	prog->reloc_desc = malloc(sizeof(*prog->reloc_desc) * nrels);
 	if (!prog->reloc_desc) {
-		pr_warning("failed to alloc memory in relocation\n");
+		pr_warn("failed to alloc memory in relocation\n");
 		return -ENOMEM;
 	}
 	prog->nr_reloc = nrels;
@@ -1773,13 +1771,13 @@ bpf_program__collect_reloc(struct bpf_program *prog, GElf_Shdr *shdr,
 		GElf_Rel rel;
 
 		if (!gelf_getrel(data, i, &rel)) {
-			pr_warning("relocation: failed to get %d reloc\n", i);
+			pr_warn("relocation: failed to get %d reloc\n", i);
 			return -LIBBPF_ERRNO__FORMAT;
 		}
 
 		if (!gelf_getsym(symbols, GELF_R_SYM(rel.r_info), &sym)) {
-			pr_warning("relocation: symbol %"PRIx64" not found\n",
-				   GELF_R_SYM(rel.r_info));
+			pr_warn("relocation: symbol %"PRIx64" not found\n",
+				GELF_R_SYM(rel.r_info));
 			return -LIBBPF_ERRNO__FORMAT;
 		}
 
@@ -1796,20 +1794,20 @@ bpf_program__collect_reloc(struct bpf_program *prog, GElf_Shdr *shdr,
 			 insn_idx, shdr_idx);
 
 		if (shdr_idx >= SHN_LORESERVE) {
-			pr_warning("relocation: not yet supported relo for non-static global \'%s\' variable in special section (0x%x) found in insns[%d].code 0x%x\n",
-				   name, shdr_idx, insn_idx,
-				   insns[insn_idx].code);
+			pr_warn("relocation: not yet supported relo for non-static global \'%s\' variable in special section (0x%x) found in insns[%d].code 0x%x\n",
+				name, shdr_idx, insn_idx,
+				insns[insn_idx].code);
 			return -LIBBPF_ERRNO__RELOC;
 		}
 		if (!bpf_object__relo_in_known_section(obj, shdr_idx)) {
-			pr_warning("Program '%s' contains unrecognized relo data pointing to section %u\n",
-				   prog->section_name, shdr_idx);
+			pr_warn("Program '%s' contains unrecognized relo data pointing to section %u\n",
+				prog->section_name, shdr_idx);
 			return -LIBBPF_ERRNO__RELOC;
 		}
 
 		if (insns[insn_idx].code == (BPF_JMP | BPF_CALL)) {
 			if (insns[insn_idx].src_reg != BPF_PSEUDO_CALL) {
-				pr_warning("incorrect bpf_call opcode\n");
+				pr_warn("incorrect bpf_call opcode\n");
 				return -LIBBPF_ERRNO__RELOC;
 			}
 			prog->reloc_desc[i].type = RELO_CALL;
@@ -1820,8 +1818,8 @@ bpf_program__collect_reloc(struct bpf_program *prog, GElf_Shdr *shdr,
 		}
 
 		if (insns[insn_idx].code != (BPF_LD | BPF_IMM | BPF_DW)) {
-			pr_warning("bpf: relocation: invalid relo for insns[%d].code 0x%x\n",
-				   insn_idx, insns[insn_idx].code);
+			pr_warn("bpf: relocation: invalid relo for insns[%d].code 0x%x\n",
+				insn_idx, insns[insn_idx].code);
 			return -LIBBPF_ERRNO__RELOC;
 		}
 
@@ -1830,13 +1828,13 @@ bpf_program__collect_reloc(struct bpf_program *prog, GElf_Shdr *shdr,
 			type = bpf_object__section_to_libbpf_map_type(obj, shdr_idx);
 			if (type != LIBBPF_MAP_UNSPEC) {
 				if (GELF_ST_BIND(sym.st_info) == STB_GLOBAL) {
-					pr_warning("bpf: relocation: not yet supported relo for non-static global \'%s\' variable found in insns[%d].code 0x%x\n",
-						   name, insn_idx, insns[insn_idx].code);
+					pr_warn("bpf: relocation: not yet supported relo for non-static global \'%s\' variable found in insns[%d].code 0x%x\n",
+						name, insn_idx, insns[insn_idx].code);
 					return -LIBBPF_ERRNO__RELOC;
 				}
 				if (!obj->caps.global_data) {
-					pr_warning("bpf: relocation: kernel does not support global \'%s\' variable access in insns[%d]\n",
-						   name, insn_idx);
+					pr_warn("bpf: relocation: kernel does not support global \'%s\' variable access in insns[%d]\n",
+						name, insn_idx);
 					return -LIBBPF_ERRNO__RELOC;
 				}
 			}
@@ -1857,8 +1855,8 @@ bpf_program__collect_reloc(struct bpf_program *prog, GElf_Shdr *shdr,
 			}
 
 			if (map_idx >= nr_maps) {
-				pr_warning("bpf relocation: map_idx %d larger than %d\n",
-					   (int)map_idx, (int)nr_maps - 1);
+				pr_warn("bpf relocation: map_idx %d larger than %d\n",
+					(int)map_idx, (int)nr_maps - 1);
 				return -LIBBPF_ERRNO__RELOC;
 			}
 
@@ -1985,8 +1983,8 @@ bpf_object__probe_name(struct bpf_object *obj)
 	ret = bpf_load_program_xattr(&attr, NULL, 0);
 	if (ret < 0) {
 		cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
-		pr_warning("Error in %s():%s(%d). Couldn't load basic 'r0 = 0' BPF program.\n",
-			   __func__, cp, errno);
+		pr_warn("Error in %s():%s(%d). Couldn't load basic 'r0 = 0' BPF program.\n",
+			__func__, cp, errno);
 		return -errno;
 	}
 	close(ret);
@@ -2026,8 +2024,8 @@ bpf_object__probe_global_data(struct bpf_object *obj)
 	map = bpf_create_map_xattr(&map_attr);
 	if (map < 0) {
 		cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
-		pr_warning("Error in %s():%s(%d). Couldn't create simple array map.\n",
-			   __func__, cp, errno);
+		pr_warn("Error in %s():%s(%d). Couldn't create simple array map.\n",
+			__func__, cp, errno);
 		return -errno;
 	}
 
@@ -2142,8 +2140,8 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
 		err = bpf_map_freeze(map->fd);
 		if (err) {
 			cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
-			pr_warning("Error freezing map(%s) as read-only: %s\n",
-				   map->name, cp);
+			pr_warn("Error freezing map(%s) as read-only: %s\n",
+				map->name, cp);
 			err = 0;
 		}
 	}
@@ -2182,8 +2180,8 @@ bpf_object__create_maps(struct bpf_object *obj)
 			if (!nr_cpus)
 				nr_cpus = libbpf_num_possible_cpus();
 			if (nr_cpus < 0) {
-				pr_warning("failed to determine number of system CPUs: %d\n",
-					   nr_cpus);
+				pr_warn("failed to determine number of system CPUs: %d\n",
+					nr_cpus);
 				err = nr_cpus;
 				goto err_out;
 			}
@@ -2211,8 +2209,8 @@ bpf_object__create_maps(struct bpf_object *obj)
 				 create_attr.btf_value_type_id)) {
 			err = -errno;
 			cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
-			pr_warning("Error in bpf_create_map_xattr(%s):%s(%d). Retrying without BTF.\n",
-				   map->name, cp, err);
+			pr_warn("Error in bpf_create_map_xattr(%s):%s(%d). Retrying without BTF.\n",
+				map->name, cp, err);
 			create_attr.btf_fd = 0;
 			create_attr.btf_key_type_id = 0;
 			create_attr.btf_value_type_id = 0;
@@ -2227,8 +2225,8 @@ bpf_object__create_maps(struct bpf_object *obj)
 			err = -errno;
 err_out:
 			cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
-			pr_warning("failed to create map (name: '%s'): %s(%d)\n",
-				   map->name, cp, err);
+			pr_warn("failed to create map (name: '%s'): %s(%d)\n",
+				map->name, cp, err);
 			for (j = 0; j < i; j++)
 				zclose(obj->maps[j].fd);
 			return err;
@@ -2253,8 +2251,8 @@ check_btf_ext_reloc_err(struct bpf_program *prog, int err,
 			void *btf_prog_info, const char *info_name)
 {
 	if (err != -ENOENT) {
-		pr_warning("Error in loading %s for sec %s.\n",
-			   info_name, prog->section_name);
+		pr_warn("Error in loading %s for sec %s.\n",
+			info_name, prog->section_name);
 		return err;
 	}
 
@@ -2265,14 +2263,14 @@ check_btf_ext_reloc_err(struct bpf_program *prog, int err,
 		 * Some info has already been found but has problem
 		 * in the last btf_ext reloc. Must have to error out.
 		 */
-		pr_warning("Error in relocating %s for sec %s.\n",
-			   info_name, prog->section_name);
+		pr_warn("Error in relocating %s for sec %s.\n",
+			info_name, prog->section_name);
 		return err;
 	}
 
 	/* Have problem loading the very first info. Ignore the rest. */
-	pr_warning("Cannot find %s for main program sec %s. Ignore all %s.\n",
-		   info_name, prog->section_name, info_name);
+	pr_warn("Cannot find %s for main program sec %s. Ignore all %s.\n",
+		info_name, prog->section_name, info_name);
 	return 0;
 }
 
@@ -2473,8 +2471,8 @@ static int bpf_core_spec_parse(const struct btf *btf,
 				return sz;
 			spec->offset += access_idx * sz;
 		} else {
-			pr_warning("relo for [%u] %s (at idx %d) captures type [%d] of unexpected kind %d\n",
-				   type_id, spec_str, i, id, btf_kind(t));
+			pr_warn("relo for [%u] %s (at idx %d) captures type [%d] of unexpected kind %d\n",
+				type_id, spec_str, i, id, btf_kind(t));
 			return -EINVAL;
 		}
 	}
@@ -2618,8 +2616,8 @@ static int bpf_core_fields_are_compat(const struct btf *local_btf,
 		targ_id = btf_array(targ_type)->type;
 		goto recur;
 	default:
-		pr_warning("unexpected kind %d relocated, local [%d], target [%d]\n",
-			   btf_kind(local_type), local_id, targ_id);
+		pr_warn("unexpected kind %d relocated, local [%d], target [%d]\n",
+			btf_kind(local_type), local_id, targ_id);
 		return 0;
 	}
 }
@@ -2823,9 +2821,9 @@ static int bpf_core_reloc_insn(struct bpf_program *prog,
 		if (targ_spec) {
 			new_val = targ_spec->offset;
 		} else {
-			pr_warning("prog '%s': patching insn #%d w/ failed reloc, imm %d -> %d\n",
-				   bpf_program__title(prog, false), insn_idx,
-				   orig_val, -1);
+			pr_warn("prog '%s': patching insn #%d w/ failed reloc, imm %d -> %d\n",
+				bpf_program__title(prog, false), insn_idx,
+				orig_val, -1);
 			new_val = (__u32)-1;
 		}
 		break;
@@ -2834,9 +2832,9 @@ static int bpf_core_reloc_insn(struct bpf_program *prog,
 		new_val = targ_spec ? 1 : 0;
 		break;
 	default:
-		pr_warning("prog '%s': unknown relo %d at insn #%d'\n",
-			   bpf_program__title(prog, false),
-			   relo->kind, insn_idx);
+		pr_warn("prog '%s': unknown relo %d at insn #%d'\n",
+			bpf_program__title(prog, false),
+			relo->kind, insn_idx);
 		return -EINVAL;
 	}
 
@@ -2853,10 +2851,10 @@ static int bpf_core_reloc_insn(struct bpf_program *prog,
 			 bpf_program__title(prog, false),
 			 insn_idx, orig_val, new_val);
 	} else {
-		pr_warning("prog '%s': trying to relocate unrecognized insn #%d, code:%x, src:%x, dst:%x, off:%x, imm:%x\n",
-			   bpf_program__title(prog, false),
-			   insn_idx, insn->code, insn->src_reg, insn->dst_reg,
-			   insn->off, insn->imm);
+		pr_warn("prog '%s': trying to relocate unrecognized insn #%d, code:%x, src:%x, dst:%x, off:%x, imm:%x\n",
+			bpf_program__title(prog, false),
+			insn_idx, insn->code, insn->src_reg, insn->dst_reg,
+			insn->off, insn->imm);
 		return -EINVAL;
 	}
 
@@ -2945,7 +2943,7 @@ static struct btf *bpf_core_find_kernel_btf(void)
 		return btf;
 	}
 
-	pr_warning("failed to find valid kernel BTF\n");
+	pr_warn("failed to find valid kernel BTF\n");
 	return ERR_PTR(-ESRCH);
 }
 
@@ -3077,9 +3075,9 @@ static int bpf_core_reloc_field(struct bpf_program *prog,
 
 	err = bpf_core_spec_parse(local_btf, local_id, spec_str, &local_spec);
 	if (err) {
-		pr_warning("prog '%s': relo #%d: parsing [%d] %s + %s failed: %d\n",
-			   prog_name, relo_idx, local_id, local_name, spec_str,
-			   err);
+		pr_warn("prog '%s': relo #%d: parsing [%d] %s + %s failed: %d\n",
+			prog_name, relo_idx, local_id, local_name, spec_str,
+			err);
 		return -EINVAL;
 	}
 
@@ -3090,9 +3088,9 @@ static int bpf_core_reloc_field(struct bpf_program *prog,
 	if (!hashmap__find(cand_cache, type_key, (void **)&cand_ids)) {
 		cand_ids = bpf_core_find_cands(local_btf, local_id, targ_btf);
 		if (IS_ERR(cand_ids)) {
-			pr_warning("prog '%s': relo #%d: target candidate search failed for [%d] %s: %ld",
-				   prog_name, relo_idx, local_id, local_name,
-				   PTR_ERR(cand_ids));
+			pr_warn("prog '%s': relo #%d: target candidate search failed for [%d] %s: %ld",
+				prog_name, relo_idx, local_id, local_name,
+				PTR_ERR(cand_ids));
 			return PTR_ERR(cand_ids);
 		}
 		err = hashmap__set(cand_cache, type_key, cand_ids, NULL, NULL);
@@ -3114,8 +3112,8 @@ static int bpf_core_reloc_field(struct bpf_program *prog,
 		bpf_core_dump_spec(LIBBPF_DEBUG, &cand_spec);
 		libbpf_print(LIBBPF_DEBUG, ": %d\n", err);
 		if (err < 0) {
-			pr_warning("prog '%s': relo #%d: matching error: %d\n",
-				   prog_name, relo_idx, err);
+			pr_warn("prog '%s': relo #%d: matching error: %d\n",
+				prog_name, relo_idx, err);
 			return err;
 		}
 		if (err == 0)
@@ -3127,9 +3125,9 @@ static int bpf_core_reloc_field(struct bpf_program *prog,
 			/* if there are many candidates, they should all
 			 * resolve to the same offset
 			 */
-			pr_warning("prog '%s': relo #%d: offset ambiguity: %u != %u\n",
-				   prog_name, relo_idx, cand_spec.offset,
-				   targ_spec.offset);
+			pr_warn("prog '%s': relo #%d: offset ambiguity: %u != %u\n",
+				prog_name, relo_idx, cand_spec.offset,
+				targ_spec.offset);
 			return -EINVAL;
 		}
 
@@ -3148,8 +3146,8 @@ static int bpf_core_reloc_field(struct bpf_program *prog,
 
 	if (j == 0 && !prog->obj->relaxed_core_relocs &&
 	    relo->kind != BPF_FIELD_EXISTS) {
-		pr_warning("prog '%s': relo #%d: no matching targets found for [%d] %s + %s\n",
-			   prog_name, relo_idx, local_id, local_name, spec_str);
+		pr_warn("prog '%s': relo #%d: no matching targets found for [%d] %s + %s\n",
+			prog_name, relo_idx, local_id, local_name, spec_str);
 		return -ESRCH;
 	}
 
@@ -3157,8 +3155,8 @@ static int bpf_core_reloc_field(struct bpf_program *prog,
 	err = bpf_core_reloc_insn(prog, relo, &local_spec,
 				  j ? &targ_spec : NULL);
 	if (err) {
-		pr_warning("prog '%s': relo #%d: failed to patch insn at offset %d: %d\n",
-			   prog_name, relo_idx, relo->insn_off, err);
+		pr_warn("prog '%s': relo #%d: failed to patch insn at offset %d: %d\n",
+			prog_name, relo_idx, relo->insn_off, err);
 		return -EINVAL;
 	}
 
@@ -3183,8 +3181,7 @@ bpf_core_reloc_fields(struct bpf_object *obj, const char *targ_btf_path)
 	else
 		targ_btf = bpf_core_find_kernel_btf();
 	if (IS_ERR(targ_btf)) {
-		pr_warning("failed to get target BTF: %ld\n",
-			   PTR_ERR(targ_btf));
+		pr_warn("failed to get target BTF: %ld\n", PTR_ERR(targ_btf));
 		return PTR_ERR(targ_btf);
 	}
 
@@ -3203,8 +3200,8 @@ bpf_core_reloc_fields(struct bpf_object *obj, const char *targ_btf_path)
 		}
 		prog = bpf_object__find_program_by_title(obj, sec_name);
 		if (!prog) {
-			pr_warning("failed to find program '%s' for CO-RE offset relocation\n",
-				   sec_name);
+			pr_warn("failed to find program '%s' for CO-RE offset relocation\n",
+				sec_name);
 			err = -EINVAL;
 			goto out;
 		}
@@ -3216,8 +3213,8 @@ bpf_core_reloc_fields(struct bpf_object *obj, const char *targ_btf_path)
 			err = bpf_core_reloc_field(prog, rec, i, obj->btf,
 						   targ_btf, cand_cache);
 			if (err) {
-				pr_warning("prog '%s': relo #%d: failed to relocate: %d\n",
-					   sec_name, i, err);
+				pr_warn("prog '%s': relo #%d: failed to relocate: %d\n",
+					sec_name, i, err);
 				goto out;
 			}
 		}
@@ -3258,21 +3255,21 @@ bpf_program__reloc_text(struct bpf_program *prog, struct bpf_object *obj,
 		return -LIBBPF_ERRNO__RELOC;
 
 	if (prog->idx == obj->efile.text_shndx) {
-		pr_warning("relo in .text insn %d into off %d\n",
-			   relo->insn_idx, relo->text_off);
+		pr_warn("relo in .text insn %d into off %d\n",
+			relo->insn_idx, relo->text_off);
 		return -LIBBPF_ERRNO__RELOC;
 	}
 
 	if (prog->main_prog_cnt == 0) {
 		text = bpf_object__find_prog_by_idx(obj, obj->efile.text_shndx);
 		if (!text) {
-			pr_warning("no .text section found yet relo into text exist\n");
+			pr_warn("no .text section found yet relo into text exist\n");
 			return -LIBBPF_ERRNO__RELOC;
 		}
 		new_cnt = prog->insns_cnt + text->insns_cnt;
 		new_insn = reallocarray(prog->insns, new_cnt, sizeof(*insn));
 		if (!new_insn) {
-			pr_warning("oom in prog realloc\n");
+			pr_warn("oom in prog realloc\n");
 			return -ENOMEM;
 		}
 
@@ -3327,8 +3324,8 @@ bpf_program__relocate(struct bpf_program *prog, struct bpf_object *obj)
 			map_idx = prog->reloc_desc[i].map_idx;
 
 			if (insn_idx + 1 >= (int)prog->insns_cnt) {
-				pr_warning("relocation out of range: '%s'\n",
-					   prog->section_name);
+				pr_warn("relocation out of range: '%s'\n",
+					prog->section_name);
 				return -LIBBPF_ERRNO__RELOC;
 			}
 
@@ -3362,8 +3359,8 @@ bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_path)
 	if (obj->btf_ext) {
 		err = bpf_object__relocate_core(obj, targ_btf_path);
 		if (err) {
-			pr_warning("failed to perform CO-RE relocations: %d\n",
-				   err);
+			pr_warn("failed to perform CO-RE relocations: %d\n",
+				err);
 			return err;
 		}
 	}
@@ -3372,8 +3369,7 @@ bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_path)
 
 		err = bpf_program__relocate(prog, obj);
 		if (err) {
-			pr_warning("failed to relocate '%s'\n",
-				   prog->section_name);
+			pr_warn("failed to relocate '%s'\n", prog->section_name);
 			return err;
 		}
 	}
@@ -3385,7 +3381,7 @@ static int bpf_object__collect_reloc(struct bpf_object *obj)
 	int i, err;
 
 	if (!obj_elf_valid(obj)) {
-		pr_warning("Internal error: elf object is closed\n");
+		pr_warn("Internal error: elf object is closed\n");
 		return -LIBBPF_ERRNO__INTERNAL;
 	}
 
@@ -3396,13 +3392,13 @@ static int bpf_object__collect_reloc(struct bpf_object *obj)
 		struct bpf_program *prog;
 
 		if (shdr->sh_type != SHT_REL) {
-			pr_warning("internal error at %d\n", __LINE__);
+			pr_warn("internal error at %d\n", __LINE__);
 			return -LIBBPF_ERRNO__INTERNAL;
 		}
 
 		prog = bpf_object__find_prog_by_idx(obj, idx);
 		if (!prog) {
-			pr_warning("relocation failed: no section(%d)\n", idx);
+			pr_warn("relocation failed: no section(%d)\n", idx);
 			return -LIBBPF_ERRNO__RELOC;
 		}
 
@@ -3454,7 +3450,7 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 retry_load:
 	log_buf = malloc(log_buf_size);
 	if (!log_buf)
-		pr_warning("Alloc log buffer for bpf loader error, continue without log\n");
+		pr_warn("Alloc log buffer for bpf loader error, continue without log\n");
 
 	ret = bpf_load_program_xattr(&load_attr, log_buf, log_buf_size);
 
@@ -3473,16 +3469,16 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 	}
 	ret = -LIBBPF_ERRNO__LOAD;
 	cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
-	pr_warning("load bpf program failed: %s\n", cp);
+	pr_warn("load bpf program failed: %s\n", cp);
 
 	if (log_buf && log_buf[0] != '\0') {
 		ret = -LIBBPF_ERRNO__VERIFY;
-		pr_warning("-- BEGIN DUMP LOG ---\n");
-		pr_warning("\n%s\n", log_buf);
-		pr_warning("-- END LOG --\n");
+		pr_warn("-- BEGIN DUMP LOG ---\n");
+		pr_warn("\n%s\n", log_buf);
+		pr_warn("-- END LOG --\n");
 	} else if (load_attr.insns_cnt >= BPF_MAXINSNS) {
-		pr_warning("Program too large (%zu insns), at most %d insns\n",
-			   load_attr.insns_cnt, BPF_MAXINSNS);
+		pr_warn("Program too large (%zu insns), at most %d insns\n",
+			load_attr.insns_cnt, BPF_MAXINSNS);
 		ret = -LIBBPF_ERRNO__PROG2BIG;
 	} else {
 		/* Wrong program type? */
@@ -3516,14 +3512,14 @@ bpf_program__load(struct bpf_program *prog,
 
 	if (prog->instances.nr < 0 || !prog->instances.fds) {
 		if (prog->preprocessor) {
-			pr_warning("Internal error: can't load program '%s'\n",
-				   prog->section_name);
+			pr_warn("Internal error: can't load program '%s'\n",
+				prog->section_name);
 			return -LIBBPF_ERRNO__INTERNAL;
 		}
 
 		prog->instances.fds = malloc(sizeof(int));
 		if (!prog->instances.fds) {
-			pr_warning("Not enough memory for BPF fds\n");
+			pr_warn("Not enough memory for BPF fds\n");
 			return -ENOMEM;
 		}
 		prog->instances.nr = 1;
@@ -3532,8 +3528,8 @@ bpf_program__load(struct bpf_program *prog,
 
 	if (!prog->preprocessor) {
 		if (prog->instances.nr != 1) {
-			pr_warning("Program '%s' is inconsistent: nr(%d) != 1\n",
-				   prog->section_name, prog->instances.nr);
+			pr_warn("Program '%s' is inconsistent: nr(%d) != 1\n",
+				prog->section_name, prog->instances.nr);
 		}
 		err = load_program(prog, prog->insns, prog->insns_cnt,
 				   license, kern_version, &fd);
@@ -3550,8 +3546,8 @@ bpf_program__load(struct bpf_program *prog,
 		err = preprocessor(prog, i, prog->insns,
 				   prog->insns_cnt, &result);
 		if (err) {
-			pr_warning("Preprocessing the %dth instance of program '%s' failed\n",
-				   i, prog->section_name);
+			pr_warn("Preprocessing the %dth instance of program '%s' failed\n",
+				i, prog->section_name);
 			goto out;
 		}
 
@@ -3569,8 +3565,8 @@ bpf_program__load(struct bpf_program *prog,
 				   license, kern_version, &fd);
 
 		if (err) {
-			pr_warning("Loading the %dth instance of program '%s' failed\n",
-					i, prog->section_name);
+			pr_warn("Loading the %dth instance of program '%s' failed\n",
+				i, prog->section_name);
 			goto out;
 		}
 
@@ -3580,8 +3576,7 @@ bpf_program__load(struct bpf_program *prog,
 	}
 out:
 	if (err)
-		pr_warning("failed to load program '%s'\n",
-			   prog->section_name);
+		pr_warn("failed to load program '%s'\n", prog->section_name);
 	zfree(&prog->insns);
 	prog->insns_cnt = 0;
 	return err;
@@ -3623,8 +3618,8 @@ __bpf_object__open(const char *path, const void *obj_buf, size_t obj_buf_sz,
 	int err;
 
 	if (elf_version(EV_CURRENT) == EV_NONE) {
-		pr_warning("failed to init libelf for %s\n",
-			   path ? : "(mem buf)");
+		pr_warn("failed to init libelf for %s\n",
+			path ? : "(mem buf)");
 		return ERR_PTR(-LIBBPF_ERRNO__LIBELF);
 	}
 
@@ -3759,7 +3754,7 @@ int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
 		return -EINVAL;
 
 	if (obj->loaded) {
-		pr_warning("object should not be loaded twice\n");
+		pr_warn("object should not be loaded twice\n");
 		return -EINVAL;
 	}
 
@@ -3772,7 +3767,7 @@ int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
 	return 0;
 out:
 	bpf_object__unload(obj);
-	pr_warning("failed to load object '%s'\n", obj->path);
+	pr_warn("failed to load object '%s'\n", obj->path);
 	return err;
 }
 
@@ -3802,13 +3797,13 @@ static int check_path(const char *path)
 	dir = dirname(dname);
 	if (statfs(dir, &st_fs)) {
 		cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
-		pr_warning("failed to statfs %s: %s\n", dir, cp);
+		pr_warn("failed to statfs %s: %s\n", dir, cp);
 		err = -errno;
 	}
 	free(dname);
 
 	if (!err && st_fs.f_type != BPF_FS_MAGIC) {
-		pr_warning("specified path %s is not on BPF FS\n", path);
+		pr_warn("specified path %s is not on BPF FS\n", path);
 		err = -EINVAL;
 	}
 
@@ -3826,19 +3821,19 @@ int bpf_program__pin_instance(struct bpf_program *prog, const char *path,
 		return err;
 
 	if (prog == NULL) {
-		pr_warning("invalid program pointer\n");
+		pr_warn("invalid program pointer\n");
 		return -EINVAL;
 	}
 
 	if (instance < 0 || instance >= prog->instances.nr) {
-		pr_warning("invalid prog instance %d of prog %s (max %d)\n",
-			   instance, prog->section_name, prog->instances.nr);
+		pr_warn("invalid prog instance %d of prog %s (max %d)\n",
+			instance, prog->section_name, prog->instances.nr);
 		return -EINVAL;
 	}
 
 	if (bpf_obj_pin(prog->instances.fds[instance], path)) {
 		cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
-		pr_warning("failed to pin program: %s\n", cp);
+		pr_warn("failed to pin program: %s\n", cp);
 		return -errno;
 	}
 	pr_debug("pinned program '%s'\n", path);
@@ -3856,13 +3851,13 @@ int bpf_program__unpin_instance(struct bpf_program *prog, const char *path,
 		return err;
 
 	if (prog == NULL) {
-		pr_warning("invalid program pointer\n");
+		pr_warn("invalid program pointer\n");
 		return -EINVAL;
 	}
 
 	if (instance < 0 || instance >= prog->instances.nr) {
-		pr_warning("invalid prog instance %d of prog %s (max %d)\n",
-			   instance, prog->section_name, prog->instances.nr);
+		pr_warn("invalid prog instance %d of prog %s (max %d)\n",
+			instance, prog->section_name, prog->instances.nr);
 		return -EINVAL;
 	}
 
@@ -3884,7 +3879,7 @@ static int make_dir(const char *path)
 
 	if (err) {
 		cp = libbpf_strerror_r(-err, errmsg, sizeof(errmsg));
-		pr_warning("failed to mkdir %s: %s\n", path, cp);
+		pr_warn("failed to mkdir %s: %s\n", path, cp);
 	}
 	return err;
 }
@@ -3898,12 +3893,12 @@ int bpf_program__pin(struct bpf_program *prog, const char *path)
 		return err;
 
 	if (prog == NULL) {
-		pr_warning("invalid program pointer\n");
+		pr_warn("invalid program pointer\n");
 		return -EINVAL;
 	}
 
 	if (prog->instances.nr <= 0) {
-		pr_warning("no instances of prog %s to pin\n",
+		pr_warn("no instances of prog %s to pin\n",
 			   prog->section_name);
 		return -EINVAL;
 	}
@@ -3965,12 +3960,12 @@ int bpf_program__unpin(struct bpf_program *prog, const char *path)
 		return err;
 
 	if (prog == NULL) {
-		pr_warning("invalid program pointer\n");
+		pr_warn("invalid program pointer\n");
 		return -EINVAL;
 	}
 
 	if (prog->instances.nr <= 0) {
-		pr_warning("no instances of prog %s to pin\n",
+		pr_warn("no instances of prog %s to pin\n",
 			   prog->section_name);
 		return -EINVAL;
 	}
@@ -4012,13 +4007,13 @@ int bpf_map__pin(struct bpf_map *map, const char *path)
 		return err;
 
 	if (map == NULL) {
-		pr_warning("invalid map pointer\n");
+		pr_warn("invalid map pointer\n");
 		return -EINVAL;
 	}
 
 	if (bpf_obj_pin(map->fd, path)) {
 		cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
-		pr_warning("failed to pin map: %s\n", cp);
+		pr_warn("failed to pin map: %s\n", cp);
 		return -errno;
 	}
 
@@ -4036,7 +4031,7 @@ int bpf_map__unpin(struct bpf_map *map, const char *path)
 		return err;
 
 	if (map == NULL) {
-		pr_warning("invalid map pointer\n");
+		pr_warn("invalid map pointer\n");
 		return -EINVAL;
 	}
 
@@ -4057,7 +4052,7 @@ int bpf_object__pin_maps(struct bpf_object *obj, const char *path)
 		return -ENOENT;
 
 	if (!obj->loaded) {
-		pr_warning("object not yet loaded; load it first\n");
+		pr_warn("object not yet loaded; load it first\n");
 		return -ENOENT;
 	}
 
@@ -4140,7 +4135,7 @@ int bpf_object__pin_programs(struct bpf_object *obj, const char *path)
 		return -ENOENT;
 
 	if (!obj->loaded) {
-		pr_warning("object not yet loaded; load it first\n");
+		pr_warn("object not yet loaded; load it first\n");
 		return -ENOENT;
 	}
 
@@ -4341,7 +4336,7 @@ __bpf_program__iter(const struct bpf_program *p, const struct bpf_object *obj,
 			&obj->programs[nr_programs - 1];
 
 	if (p->obj != obj) {
-		pr_warning("error: program handler doesn't match object\n");
+		pr_warn("error: program handler doesn't match object\n");
 		return NULL;
 	}
 
@@ -4404,7 +4399,7 @@ const char *bpf_program__title(const struct bpf_program *prog, bool needs_copy)
 	if (needs_copy) {
 		title = strdup(title);
 		if (!title) {
-			pr_warning("failed to strdup program title\n");
+			pr_warn("failed to strdup program title\n");
 			return ERR_PTR(-ENOMEM);
 		}
 	}
@@ -4426,13 +4421,13 @@ int bpf_program__set_prep(struct bpf_program *prog, int nr_instances,
 		return -EINVAL;
 
 	if (prog->instances.nr > 0 || prog->instances.fds) {
-		pr_warning("Can't set pre-processor after loading\n");
+		pr_warn("Can't set pre-processor after loading\n");
 		return -EINVAL;
 	}
 
 	instances_fds = malloc(sizeof(int) * nr_instances);
 	if (!instances_fds) {
-		pr_warning("alloc memory failed for fds\n");
+		pr_warn("alloc memory failed for fds\n");
 		return -ENOMEM;
 	}
 
@@ -4453,15 +4448,15 @@ int bpf_program__nth_fd(const struct bpf_program *prog, int n)
 		return -EINVAL;
 
 	if (n >= prog->instances.nr || n < 0) {
-		pr_warning("Can't get the %dth fd from program %s: only %d instances\n",
-			   n, prog->section_name, prog->instances.nr);
+		pr_warn("Can't get the %dth fd from program %s: only %d instances\n",
+			n, prog->section_name, prog->instances.nr);
 		return -EINVAL;
 	}
 
 	fd = prog->instances.fds[n];
 	if (fd < 0) {
-		pr_warning("%dth instance of program '%s' is invalid\n",
-			   n, prog->section_name);
+		pr_warn("%dth instance of program '%s' is invalid\n",
+			n, prog->section_name);
 		return -ENOENT;
 	}
 
@@ -4658,7 +4653,7 @@ int libbpf_prog_type_by_name(const char *name, enum bpf_prog_type *prog_type,
 			int ret;
 
 			if (IS_ERR(btf)) {
-				pr_warning("vmlinux BTF is not found\n");
+				pr_warn("vmlinux BTF is not found\n");
 				return -EINVAL;
 			}
 			/* prepend "btf_trace_" prefix per kernel convention */
@@ -4667,14 +4662,14 @@ int libbpf_prog_type_by_name(const char *name, enum bpf_prog_type *prog_type,
 			ret = btf__find_by_name(btf, raw_tp_btf_name);
 			btf__free(btf);
 			if (ret <= 0) {
-				pr_warning("%s is not found in vmlinux BTF\n", dst);
+				pr_warn("%s is not found in vmlinux BTF\n", dst);
 				return -EINVAL;
 			}
 			*expected_attach_type = ret;
 		}
 		return 0;
 	}
-	pr_warning("failed to guess program type based on ELF section name '%s'\n", name);
+	pr_warn("failed to guess program type based on ELF section name '%s'\n", name);
 	type_names = libbpf_get_type_names(false);
 	if (type_names != NULL) {
 		pr_info("supported section(type) names are:%s\n", type_names);
@@ -4701,7 +4696,7 @@ int libbpf_attach_type_by_name(const char *name,
 		*attach_type = section_names[i].attach_type;
 		return 0;
 	}
-	pr_warning("failed to guess attach type based on ELF section name '%s'\n", name);
+	pr_warn("failed to guess attach type based on ELF section name '%s'\n", name);
 	type_names = libbpf_get_type_names(true);
 	if (type_names != NULL) {
 		pr_info("attachable section(type) names are:%s\n", type_names);
@@ -4784,11 +4779,11 @@ void bpf_map__set_ifindex(struct bpf_map *map, __u32 ifindex)
 int bpf_map__set_inner_map_fd(struct bpf_map *map, int fd)
 {
 	if (!bpf_map_type__is_map_in_map(map->def.type)) {
-		pr_warning("error: unsupported map type\n");
+		pr_warn("error: unsupported map type\n");
 		return -EINVAL;
 	}
 	if (map->inner_map_fd != -1) {
-		pr_warning("error: inner_map_fd already specified\n");
+		pr_warn("error: inner_map_fd already specified\n");
 		return -EINVAL;
 	}
 	map->inner_map_fd = fd;
@@ -4808,8 +4803,8 @@ __bpf_map__iter(const struct bpf_map *m, const struct bpf_object *obj, int i)
 	e = obj->maps + obj->nr_maps;
 
 	if ((m < s) || (m >= e)) {
-		pr_warning("error in %s: map handler doesn't belong to object\n",
-			   __func__);
+		pr_warn("error in %s: map handler doesn't belong to object\n",
+			 __func__);
 		return NULL;
 	}
 
@@ -4938,7 +4933,7 @@ int bpf_prog_load_xattr(const struct bpf_prog_load_attr *attr,
 	}
 
 	if (!first_prog) {
-		pr_warning("object file doesn't contain bpf program\n");
+		pr_warn("object file doesn't contain bpf program\n");
 		bpf_object__close(obj);
 		return -ENOENT;
 	}
@@ -4997,14 +4992,14 @@ struct bpf_link *bpf_program__attach_perf_event(struct bpf_program *prog,
 	int prog_fd, err;
 
 	if (pfd < 0) {
-		pr_warning("program '%s': invalid perf event FD %d\n",
-			   bpf_program__title(prog, false), pfd);
+		pr_warn("program '%s': invalid perf event FD %d\n",
+			bpf_program__title(prog, false), pfd);
 		return ERR_PTR(-EINVAL);
 	}
 	prog_fd = bpf_program__fd(prog);
 	if (prog_fd < 0) {
-		pr_warning("program '%s': can't attach BPF program w/o FD (did you load it?)\n",
-			   bpf_program__title(prog, false));
+		pr_warn("program '%s': can't attach BPF program w/o FD (did you load it?)\n",
+			bpf_program__title(prog, false));
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -5017,16 +5012,16 @@ struct bpf_link *bpf_program__attach_perf_event(struct bpf_program *prog,
 	if (ioctl(pfd, PERF_EVENT_IOC_SET_BPF, prog_fd) < 0) {
 		err = -errno;
 		free(link);
-		pr_warning("program '%s': failed to attach to pfd %d: %s\n",
-			   bpf_program__title(prog, false), pfd,
+		pr_warn("program '%s': failed to attach to pfd %d: %s\n",
+			bpf_program__title(prog, false), pfd,
 			   libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
 		return ERR_PTR(err);
 	}
 	if (ioctl(pfd, PERF_EVENT_IOC_ENABLE, 0) < 0) {
 		err = -errno;
 		free(link);
-		pr_warning("program '%s': failed to enable pfd %d: %s\n",
-			   bpf_program__title(prog, false), pfd,
+		pr_warn("program '%s': failed to enable pfd %d: %s\n",
+			bpf_program__title(prog, false), pfd,
 			   libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
 		return ERR_PTR(err);
 	}
@@ -5101,9 +5096,9 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
 	type = uprobe ? determine_uprobe_perf_type()
 		      : determine_kprobe_perf_type();
 	if (type < 0) {
-		pr_warning("failed to determine %s perf type: %s\n",
-			   uprobe ? "uprobe" : "kprobe",
-			   libbpf_strerror_r(type, errmsg, sizeof(errmsg)));
+		pr_warn("failed to determine %s perf type: %s\n",
+			uprobe ? "uprobe" : "kprobe",
+			libbpf_strerror_r(type, errmsg, sizeof(errmsg)));
 		return type;
 	}
 	if (retprobe) {
@@ -5111,10 +5106,9 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
 				 : determine_kprobe_retprobe_bit();
 
 		if (bit < 0) {
-			pr_warning("failed to determine %s retprobe bit: %s\n",
-				   uprobe ? "uprobe" : "kprobe",
-				   libbpf_strerror_r(bit, errmsg,
-						     sizeof(errmsg)));
+			pr_warn("failed to determine %s retprobe bit: %s\n",
+				uprobe ? "uprobe" : "kprobe",
+				libbpf_strerror_r(bit, errmsg, sizeof(errmsg)));
 			return bit;
 		}
 		attr.config |= 1 << bit;
@@ -5131,9 +5125,9 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
 		      -1 /* group_fd */, PERF_FLAG_FD_CLOEXEC);
 	if (pfd < 0) {
 		err = -errno;
-		pr_warning("%s perf_event_open() failed: %s\n",
-			   uprobe ? "uprobe" : "kprobe",
-			   libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+		pr_warn("%s perf_event_open() failed: %s\n",
+			uprobe ? "uprobe" : "kprobe",
+			libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
 		return err;
 	}
 	return pfd;
@@ -5150,20 +5144,20 @@ struct bpf_link *bpf_program__attach_kprobe(struct bpf_program *prog,
 	pfd = perf_event_open_probe(false /* uprobe */, retprobe, func_name,
 				    0 /* offset */, -1 /* pid */);
 	if (pfd < 0) {
-		pr_warning("program '%s': failed to create %s '%s' perf event: %s\n",
-			   bpf_program__title(prog, false),
-			   retprobe ? "kretprobe" : "kprobe", func_name,
-			   libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
+		pr_warn("program '%s': failed to create %s '%s' perf event: %s\n",
+			bpf_program__title(prog, false),
+			retprobe ? "kretprobe" : "kprobe", func_name,
+			libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
 		return ERR_PTR(pfd);
 	}
 	link = bpf_program__attach_perf_event(prog, pfd);
 	if (IS_ERR(link)) {
 		close(pfd);
 		err = PTR_ERR(link);
-		pr_warning("program '%s': failed to attach to %s '%s': %s\n",
-			   bpf_program__title(prog, false),
-			   retprobe ? "kretprobe" : "kprobe", func_name,
-			   libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+		pr_warn("program '%s': failed to attach to %s '%s': %s\n",
+			bpf_program__title(prog, false),
+			retprobe ? "kretprobe" : "kprobe", func_name,
+			libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
 		return link;
 	}
 	return link;
@@ -5181,22 +5175,22 @@ struct bpf_link *bpf_program__attach_uprobe(struct bpf_program *prog,
 	pfd = perf_event_open_probe(true /* uprobe */, retprobe,
 				    binary_path, func_offset, pid);
 	if (pfd < 0) {
-		pr_warning("program '%s': failed to create %s '%s:0x%zx' perf event: %s\n",
-			   bpf_program__title(prog, false),
-			   retprobe ? "uretprobe" : "uprobe",
-			   binary_path, func_offset,
-			   libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
+		pr_warn("program '%s': failed to create %s '%s:0x%zx' perf event: %s\n",
+			bpf_program__title(prog, false),
+			retprobe ? "uretprobe" : "uprobe",
+			binary_path, func_offset,
+			libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
 		return ERR_PTR(pfd);
 	}
 	link = bpf_program__attach_perf_event(prog, pfd);
 	if (IS_ERR(link)) {
 		close(pfd);
 		err = PTR_ERR(link);
-		pr_warning("program '%s': failed to attach to %s '%s:0x%zx': %s\n",
-			   bpf_program__title(prog, false),
-			   retprobe ? "uretprobe" : "uprobe",
-			   binary_path, func_offset,
-			   libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+		pr_warn("program '%s': failed to attach to %s '%s:0x%zx': %s\n",
+			bpf_program__title(prog, false),
+			retprobe ? "uretprobe" : "uprobe",
+			binary_path, func_offset,
+			libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
 		return link;
 	}
 	return link;
@@ -5230,9 +5224,9 @@ static int perf_event_open_tracepoint(const char *tp_category,
 
 	tp_id = determine_tracepoint_id(tp_category, tp_name);
 	if (tp_id < 0) {
-		pr_warning("failed to determine tracepoint '%s/%s' perf event ID: %s\n",
-			   tp_category, tp_name,
-			   libbpf_strerror_r(tp_id, errmsg, sizeof(errmsg)));
+		pr_warn("failed to determine tracepoint '%s/%s' perf event ID: %s\n",
+			tp_category, tp_name,
+			libbpf_strerror_r(tp_id, errmsg, sizeof(errmsg)));
 		return tp_id;
 	}
 
@@ -5244,9 +5238,9 @@ static int perf_event_open_tracepoint(const char *tp_category,
 		      -1 /* group_fd */, PERF_FLAG_FD_CLOEXEC);
 	if (pfd < 0) {
 		err = -errno;
-		pr_warning("tracepoint '%s/%s' perf_event_open() failed: %s\n",
-			   tp_category, tp_name,
-			   libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+		pr_warn("tracepoint '%s/%s' perf_event_open() failed: %s\n",
+			tp_category, tp_name,
+			libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
 		return err;
 	}
 	return pfd;
@@ -5262,20 +5256,20 @@ struct bpf_link *bpf_program__attach_tracepoint(struct bpf_program *prog,
 
 	pfd = perf_event_open_tracepoint(tp_category, tp_name);
 	if (pfd < 0) {
-		pr_warning("program '%s': failed to create tracepoint '%s/%s' perf event: %s\n",
-			   bpf_program__title(prog, false),
-			   tp_category, tp_name,
-			   libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
+		pr_warn("program '%s': failed to create tracepoint '%s/%s' perf event: %s\n",
+			bpf_program__title(prog, false),
+			tp_category, tp_name,
+			libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
 		return ERR_PTR(pfd);
 	}
 	link = bpf_program__attach_perf_event(prog, pfd);
 	if (IS_ERR(link)) {
 		close(pfd);
 		err = PTR_ERR(link);
-		pr_warning("program '%s': failed to attach to tracepoint '%s/%s': %s\n",
-			   bpf_program__title(prog, false),
-			   tp_category, tp_name,
-			   libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+		pr_warn("program '%s': failed to attach to tracepoint '%s/%s': %s\n",
+			bpf_program__title(prog, false),
+			tp_category, tp_name,
+			libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
 		return link;
 	}
 	return link;
@@ -5297,8 +5291,8 @@ struct bpf_link *bpf_program__attach_raw_tracepoint(struct bpf_program *prog,
 
 	prog_fd = bpf_program__fd(prog);
 	if (prog_fd < 0) {
-		pr_warning("program '%s': can't attach before loaded\n",
-			   bpf_program__title(prog, false));
+		pr_warn("program '%s': can't attach before loaded\n",
+			bpf_program__title(prog, false));
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -5311,9 +5305,9 @@ struct bpf_link *bpf_program__attach_raw_tracepoint(struct bpf_program *prog,
 	if (pfd < 0) {
 		pfd = -errno;
 		free(link);
-		pr_warning("program '%s': failed to attach to raw tracepoint '%s': %s\n",
-			   bpf_program__title(prog, false), tp_name,
-			   libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
+		pr_warn("program '%s': failed to attach to raw tracepoint '%s': %s\n",
+			bpf_program__title(prog, false), tp_name,
+			libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
 		return ERR_PTR(pfd);
 	}
 	link->fd = pfd;
@@ -5415,7 +5409,7 @@ static void perf_buffer__free_cpu_buf(struct perf_buffer *pb,
 		return;
 	if (cpu_buf->base &&
 	    munmap(cpu_buf->base, pb->mmap_size + pb->page_size))
-		pr_warning("failed to munmap cpu_buf #%d\n", cpu_buf->cpu);
+		pr_warn("failed to munmap cpu_buf #%d\n", cpu_buf->cpu);
 	if (cpu_buf->fd >= 0) {
 		ioctl(cpu_buf->fd, PERF_EVENT_IOC_DISABLE, 0);
 		close(cpu_buf->fd);
@@ -5465,8 +5459,8 @@ perf_buffer__open_cpu_buf(struct perf_buffer *pb, struct perf_event_attr *attr,
 			      -1, PERF_FLAG_FD_CLOEXEC);
 	if (cpu_buf->fd < 0) {
 		err = -errno;
-		pr_warning("failed to open perf buffer event on cpu #%d: %s\n",
-			   cpu, libbpf_strerror_r(err, msg, sizeof(msg)));
+		pr_warn("failed to open perf buffer event on cpu #%d: %s\n",
+			cpu, libbpf_strerror_r(err, msg, sizeof(msg)));
 		goto error;
 	}
 
@@ -5476,15 +5470,15 @@ perf_buffer__open_cpu_buf(struct perf_buffer *pb, struct perf_event_attr *attr,
 	if (cpu_buf->base == MAP_FAILED) {
 		cpu_buf->base = NULL;
 		err = -errno;
-		pr_warning("failed to mmap perf buffer on cpu #%d: %s\n",
-			   cpu, libbpf_strerror_r(err, msg, sizeof(msg)));
+		pr_warn("failed to mmap perf buffer on cpu #%d: %s\n",
+			cpu, libbpf_strerror_r(err, msg, sizeof(msg)));
 		goto error;
 	}
 
 	if (ioctl(cpu_buf->fd, PERF_EVENT_IOC_ENABLE, 0) < 0) {
 		err = -errno;
-		pr_warning("failed to enable perf buffer event on cpu #%d: %s\n",
-			   cpu, libbpf_strerror_r(err, msg, sizeof(msg)));
+		pr_warn("failed to enable perf buffer event on cpu #%d: %s\n",
+			cpu, libbpf_strerror_r(err, msg, sizeof(msg)));
 		goto error;
 	}
 
@@ -5544,8 +5538,8 @@ static struct perf_buffer *__perf_buffer__new(int map_fd, size_t page_cnt,
 	int err, i;
 
 	if (page_cnt & (page_cnt - 1)) {
-		pr_warning("page count should be power of two, but is %zu\n",
-			   page_cnt);
+		pr_warn("page count should be power of two, but is %zu\n",
+			page_cnt);
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -5553,14 +5547,14 @@ static struct perf_buffer *__perf_buffer__new(int map_fd, size_t page_cnt,
 	err = bpf_obj_get_info_by_fd(map_fd, &map, &map_info_len);
 	if (err) {
 		err = -errno;
-		pr_warning("failed to get map info for map FD %d: %s\n",
-			   map_fd, libbpf_strerror_r(err, msg, sizeof(msg)));
+		pr_warn("failed to get map info for map FD %d: %s\n",
+			map_fd, libbpf_strerror_r(err, msg, sizeof(msg)));
 		return ERR_PTR(err);
 	}
 
 	if (map.type != BPF_MAP_TYPE_PERF_EVENT_ARRAY) {
-		pr_warning("map '%s' should be BPF_MAP_TYPE_PERF_EVENT_ARRAY\n",
-			   map.name);
+		pr_warn("map '%s' should be BPF_MAP_TYPE_PERF_EVENT_ARRAY\n",
+			map.name);
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -5580,8 +5574,8 @@ static struct perf_buffer *__perf_buffer__new(int map_fd, size_t page_cnt,
 	pb->epoll_fd = epoll_create1(EPOLL_CLOEXEC);
 	if (pb->epoll_fd < 0) {
 		err = -errno;
-		pr_warning("failed to create epoll instance: %s\n",
-			   libbpf_strerror_r(err, msg, sizeof(msg)));
+		pr_warn("failed to create epoll instance: %s\n",
+			libbpf_strerror_r(err, msg, sizeof(msg)));
 		goto error;
 	}
 
@@ -5600,13 +5594,13 @@ static struct perf_buffer *__perf_buffer__new(int map_fd, size_t page_cnt,
 	pb->events = calloc(pb->cpu_cnt, sizeof(*pb->events));
 	if (!pb->events) {
 		err = -ENOMEM;
-		pr_warning("failed to allocate events: out of memory\n");
+		pr_warn("failed to allocate events: out of memory\n");
 		goto error;
 	}
 	pb->cpu_bufs = calloc(pb->cpu_cnt, sizeof(*pb->cpu_bufs));
 	if (!pb->cpu_bufs) {
 		err = -ENOMEM;
-		pr_warning("failed to allocate buffers: out of memory\n");
+		pr_warn("failed to allocate buffers: out of memory\n");
 		goto error;
 	}
 
@@ -5629,9 +5623,9 @@ static struct perf_buffer *__perf_buffer__new(int map_fd, size_t page_cnt,
 					  &cpu_buf->fd, 0);
 		if (err) {
 			err = -errno;
-			pr_warning("failed to set cpu #%d, key %d -> perf FD %d: %s\n",
-				   cpu, map_key, cpu_buf->fd,
-				   libbpf_strerror_r(err, msg, sizeof(msg)));
+			pr_warn("failed to set cpu #%d, key %d -> perf FD %d: %s\n",
+				cpu, map_key, cpu_buf->fd,
+				libbpf_strerror_r(err, msg, sizeof(msg)));
 			goto error;
 		}
 
@@ -5640,9 +5634,9 @@ static struct perf_buffer *__perf_buffer__new(int map_fd, size_t page_cnt,
 		if (epoll_ctl(pb->epoll_fd, EPOLL_CTL_ADD, cpu_buf->fd,
 			      &pb->events[i]) < 0) {
 			err = -errno;
-			pr_warning("failed to epoll_ctl cpu #%d perf FD %d: %s\n",
-				   cpu, cpu_buf->fd,
-				   libbpf_strerror_r(err, msg, sizeof(msg)));
+			pr_warn("failed to epoll_ctl cpu #%d perf FD %d: %s\n",
+				cpu, cpu_buf->fd,
+				libbpf_strerror_r(err, msg, sizeof(msg)));
 			goto error;
 		}
 	}
@@ -5695,7 +5689,7 @@ perf_buffer__process_record(struct perf_event_header *e, void *ctx)
 		break;
 	}
 	default:
-		pr_warning("unknown perf sample type %d\n", e->type);
+		pr_warn("unknown perf sample type %d\n", e->type);
 		return LIBBPF_PERF_EVENT_ERROR;
 	}
 	return LIBBPF_PERF_EVENT_CONT;
@@ -5725,7 +5719,7 @@ int perf_buffer__poll(struct perf_buffer *pb, int timeout_ms)
 
 		err = perf_buffer__process_records(pb, cpu_buf);
 		if (err) {
-			pr_warning("error while processing records: %d\n", err);
+			pr_warn("error while processing records: %d\n", err);
 			return err;
 		}
 	}
@@ -5922,13 +5916,13 @@ bpf_program__get_prog_info_linear(int fd, __u64 arrays)
 		v2 = bpf_prog_info_read_offset_u32(&info_linear->info,
 						   desc->count_offset);
 		if (v1 != v2)
-			pr_warning("%s: mismatch in element count\n", __func__);
+			pr_warn("%s: mismatch in element count\n", __func__);
 
 		v1 = bpf_prog_info_read_offset_u32(&info, desc->size_offset);
 		v2 = bpf_prog_info_read_offset_u32(&info_linear->info,
 						   desc->size_offset);
 		if (v1 != v2)
-			pr_warning("%s: mismatch in rec size\n", __func__);
+			pr_warn("%s: mismatch in rec size\n", __func__);
 	}
 
 	/* step 7: update info_len and data_len */
@@ -5996,20 +5990,19 @@ int libbpf_num_possible_cpus(void)
 	fd = open(fcpu, O_RDONLY);
 	if (fd < 0) {
 		error = errno;
-		pr_warning("Failed to open file %s: %s\n",
-			   fcpu, strerror(error));
+		pr_warn("Failed to open file %s: %s\n", fcpu, strerror(error));
 		return -error;
 	}
 	len = read(fd, buf, sizeof(buf));
 	close(fd);
 	if (len <= 0) {
 		error = len ? errno : EINVAL;
-		pr_warning("Failed to read # of possible cpus from %s: %s\n",
-			   fcpu, strerror(error));
+		pr_warn("Failed to read # of possible cpus from %s: %s\n",
+			fcpu, strerror(error));
 		return -error;
 	}
 	if (len == sizeof(buf)) {
-		pr_warning("File %s size overflow\n", fcpu);
+		pr_warn("File %s size overflow\n", fcpu);
 		return -EOVERFLOW;
 	}
 	buf[len] = '\0';
@@ -6020,8 +6013,8 @@ int libbpf_num_possible_cpus(void)
 			buf[ir] = '\0';
 			n = sscanf(&buf[il], "%u-%u", &start, &end);
 			if (n <= 0) {
-				pr_warning("Failed to get # CPUs from %s\n",
-					   &buf[il]);
+				pr_warn("Failed to get # CPUs from %s\n",
+					&buf[il]);
 				return -EINVAL;
 			} else if (n == 1) {
 				end = start;
@@ -6031,7 +6024,7 @@ int libbpf_num_possible_cpus(void)
 		}
 	}
 	if (tmp_cpus <= 0) {
-		pr_warning("Invalid #CPUs %d from %s\n", tmp_cpus, fcpu);
+		pr_warn("Invalid #CPUs %d from %s\n", tmp_cpus, fcpu);
 		return -EINVAL;
 	}
 
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 5bfe85d4f8aa..b2880766e6b9 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -43,7 +43,7 @@ do {				\
 	libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__);	\
 } while (0)
 
-#define pr_warning(fmt, ...)	__pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
+#define pr_warn(fmt, ...)	__pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
 #define pr_info(fmt, ...)	__pr(LIBBPF_INFO, fmt, ##__VA_ARGS__)
 #define pr_debug(fmt, ...)	__pr(LIBBPF_DEBUG, fmt, ##__VA_ARGS__)
 
@@ -52,7 +52,7 @@ static inline bool libbpf_validate_opts(const char *opts,
 					const char *type_name)
 {
 	if (user_sz < sizeof(size_t)) {
-		pr_warning("%s size (%zu) is too small\n", type_name, user_sz);
+		pr_warn("%s size (%zu) is too small\n", type_name, user_sz);
 		return false;
 	}
 	if (user_sz > opts_sz) {
@@ -60,8 +60,8 @@ static inline bool libbpf_validate_opts(const char *opts,
 
 		for (i = opts_sz; i < user_sz; i++) {
 			if (opts[i]) {
-				pr_warning("%s has non-zero extra bytes",
-					   type_name);
+				pr_warn("%s has non-zero extra bytes",
+					type_name);
 				return false;
 			}
 		}
diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
index b0f532544c91..78665005b6f7 100644
--- a/tools/lib/bpf/xsk.c
+++ b/tools/lib/bpf/xsk.c
@@ -311,7 +311,7 @@ static int xsk_load_xdp_prog(struct xsk_socket *xsk)
 				   "LGPL-2.1 or BSD-2-Clause", 0, log_buf,
 				   log_buf_size);
 	if (prog_fd < 0) {
-		pr_warning("BPF log buffer:\n%s", log_buf);
+		pr_warn("BPF log buffer:\n%s", log_buf);
 		return prog_fd;
 	}
 
@@ -499,7 +499,7 @@ int xsk_socket__create(struct xsk_socket **xsk_ptr, const char *ifname,
 		return -EFAULT;
 
 	if (umem->refcount) {
-		pr_warning("Error: shared umems not supported by libbpf.\n");
+		pr_warn("Error: shared umems not supported by libbpf.\n");
 		return -EBUSY;
 	}
 
-- 
2.20.1


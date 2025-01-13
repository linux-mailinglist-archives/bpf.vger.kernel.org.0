Return-Path: <bpf+bounces-48702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89850A0BBBB
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 16:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A062A162314
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 15:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4AE24024F;
	Mon, 13 Jan 2025 15:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CuT6Mzgy"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717F024023F
	for <bpf@vger.kernel.org>; Mon, 13 Jan 2025 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736781910; cv=none; b=AWOzQR1eUUYzuJWSR7VR6uycmfYMGTpmbaxzhPwPfMT+Cs1RgqhARsilJEHRrD2QOVgwbQKVONYrUDu91ur4vmJa2YSZHAZn00lL+l1ZuR9UpHWvxieS/+qDcP6b88cOX/VYiaEBEMiCL8UIbOGaQABrdmveR1eUlFtQQiBS3oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736781910; c=relaxed/simple;
	bh=tig0w0UfcTNWzRaGJuWCFD6KvnTR9iuNAFSJds9vaNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tQI/ikubp3TKWmKuDvoVHE3MQYFNCI5dvlh/Tefbcuckv3Sa3wbMreZVY6o+WVSOg+9Pd9dEHdAOITAJFyrvaBcDDOL8WIFJLno3PTnIEOxQILoezMUb+i7s6bpRn8ly7tmoWWTj8hGys9j4Z9C5zbnK8qnBgtelcqmY1hmyKkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CuT6Mzgy; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736781906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T9gvuSGsgt8dMr0ph+0u+xe2RXVlcr9fiKN2o0ANsH8=;
	b=CuT6MzgyvcoNyulgB4RgYHUm1Zx78oguFoj/7Up7I9OmllvRs8nz/YMozilWGgDpe1wOz4
	nn8lKyq91QUPisSFrvLZaIWNgvhct6kuOgyPmotUeipwOWOYozS6Z1xz84tdiv5yuStNn+
	McHfEDSCagotSAkwMACeeQfmfPEVe5Y=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [RFC PATCH bpf-next 1/2] bpf: Introduce global percpu data
Date: Mon, 13 Jan 2025 23:24:36 +0800
Message-ID: <20250113152437.67196-2-leon.hwang@linux.dev>
In-Reply-To: <20250113152437.67196-1-leon.hwang@linux.dev>
References: <20250113152437.67196-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch introduces global per-CPU data, inspired by commit
6316f78306c1 ("Merge branch 'support-global-data'"). It enables the
definition of global per-CPU variables in BPF, similar to the
DEFINE_PER_CPU() macro in the kernel[0].

For example, in BPF, it is able to define a global per-CPU variable like
this:

int percpu_data SEC(".data..percpu");

With this patch, tools like retsnoop[1] and bpflbr[2] can simplify their
BPF code for handling LBRs. The code can be updated from

static struct perf_branch_entry lbrs[1][MAX_LBR_ENTRIES] SEC(".data.lbrs");

to

static struct perf_branch_entry lbrs[MAX_LBR_ENTRIES] SEC(".data..percpu.lbrs");

This eliminates the need to retrieve the CPU ID using the
bpf_get_smp_processor_id() helper.

Additionally, by reusing global per-CPU variables, sharing information
between tail callers and callees or freplace callers and callees becomes
simpler compared to using percpu_array maps.

Links:
[0] https://github.com/torvalds/linux/blob/fbfd64d25c7af3b8695201ebc85efe90be28c5a3/include/linux/percpu-defs.h#L114
[1] https://github.com/anakryiko/retsnoop
[2] https://github.com/Asphaltt/bpflbr

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/arraymap.c  |  39 +++++++++++++-
 kernel/bpf/verifier.c  |  45 +++++++++++++++++
 tools/lib/bpf/libbpf.c | 112 ++++++++++++++++++++++++++++++++---------
 3 files changed, 171 insertions(+), 25 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index eb28c0f219ee4..f8c60d8331975 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -249,6 +249,40 @@ static void *percpu_array_map_lookup_elem(struct bpf_map *map, void *key)
 	return this_cpu_ptr(array->pptrs[index & array->index_mask]);
 }
 
+static int percpu_array_map_direct_value_addr(const struct bpf_map *map,
+					      u64 *imm, u32 off)
+{
+	struct bpf_array *array = container_of(map, struct bpf_array, map);
+
+	if (map->max_entries != 1)
+		return -EOPNOTSUPP;
+	if (off >= map->value_size)
+		return -EINVAL;
+	if (!bpf_jit_supports_percpu_insn())
+		return -EOPNOTSUPP;
+
+	*imm = (u64) array->pptrs[0];
+	return 0;
+}
+
+static int percpu_array_map_direct_value_meta(const struct bpf_map *map,
+					      u64 imm, u32 *off)
+{
+	struct bpf_array *array = container_of(map, struct bpf_array, map);
+	u64 base = (u64) array->pptrs[0];
+	u64 range = array->elem_size;
+
+	if (map->max_entries != 1)
+		return -EOPNOTSUPP;
+	if (imm < base || imm >= base + range)
+		return -ENOENT;
+	if (!bpf_jit_supports_percpu_insn())
+		return -EOPNOTSUPP;
+
+	*off = imm - base;
+	return 0;
+}
+
 /* emit BPF instructions equivalent to C code of percpu_array_map_lookup_elem() */
 static int percpu_array_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
 {
@@ -534,7 +568,8 @@ static int array_map_check_btf(const struct bpf_map *map,
 
 	/* One exception for keyless BTF: .bss/.data/.rodata map */
 	if (btf_type_is_void(key_type)) {
-		if (map->map_type != BPF_MAP_TYPE_ARRAY ||
+		if ((map->map_type != BPF_MAP_TYPE_ARRAY &&
+		     map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY) ||
 		    map->max_entries != 1)
 			return -EINVAL;
 
@@ -815,6 +850,8 @@ const struct bpf_map_ops percpu_array_map_ops = {
 	.map_get_next_key = array_map_get_next_key,
 	.map_lookup_elem = percpu_array_map_lookup_elem,
 	.map_gen_lookup = percpu_array_map_gen_lookup,
+	.map_direct_value_addr = percpu_array_map_direct_value_addr,
+	.map_direct_value_meta = percpu_array_map_direct_value_meta,
 	.map_update_elem = array_map_update_elem,
 	.map_delete_elem = array_map_delete_elem,
 	.map_lookup_percpu_elem = percpu_array_map_lookup_percpu_elem,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b8ca227c78af1..94ce02a48ddc1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6809,6 +6809,8 @@ static int bpf_map_direct_read(struct bpf_map *map, int off, int size, u64 *val,
 	u64 addr;
 	int err;
 
+	if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
+		return -EINVAL;
 	err = map->ops->map_direct_value_addr(map, &addr, off);
 	if (err)
 		return err;
@@ -7324,6 +7326,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			/* if map is read-only, track its contents as scalars */
 			if (tnum_is_const(reg->var_off) &&
 			    bpf_map_is_rdonly(map) &&
+			    map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY &&
 			    map->ops->map_direct_value_addr) {
 				int map_off = off + reg->var_off.value;
 				u64 val = 0;
@@ -9140,6 +9143,11 @@ static int check_reg_const_str(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
+	if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
+		verbose(env, "percpu_array map does not support direct string value access\n");
+		return -EINVAL;
+	}
+
 	err = check_map_access(env, regno, reg->off,
 			       map->value_size - reg->off, false,
 			       ACCESS_HELPER);
@@ -10751,6 +10759,11 @@ static int check_bpf_snprintf_call(struct bpf_verifier_env *env,
 		return -EINVAL;
 	num_args = data_len_reg->var_off.value / 8;
 
+	if (fmt_map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
+		verbose(env, "percpu_array map does not support snprintf\n");
+		return -EINVAL;
+	}
+
 	/* fmt being ARG_PTR_TO_CONST_STR guarantees that var_off is const
 	 * and map_direct_value_addr is set.
 	 */
@@ -21304,6 +21317,38 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			goto next_insn;
 		}
 
+#ifdef CONFIG_SMP
+		if (insn->code == (BPF_LD | BPF_IMM | BPF_DW) &&
+		    (insn->src_reg == BPF_PSEUDO_MAP_VALUE ||
+		     insn->src_reg == BPF_PSEUDO_MAP_IDX_VALUE)) {
+			struct bpf_map *map;
+
+			aux = &env->insn_aux_data[i + delta];
+			map = env->used_maps[aux->map_index];
+			if (map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY)
+				goto next_insn;
+
+			/* Reuse the original ld_imm64 insn. And add one
+			 * mov64_percpu_reg insn.
+			 */
+
+			insn_buf[0] = insn[1];
+			insn_buf[1] = BPF_MOV64_PERCPU_REG(insn->dst_reg, insn->dst_reg);
+			cnt = 2;
+
+			i++;
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += cnt - 1;
+			env->prog = prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+
+			goto next_insn;
+		}
+#endif
+
 		if (insn->code != (BPF_JMP | BPF_CALL))
 			goto next_insn;
 		if (insn->src_reg == BPF_PSEUDO_CALL)
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6c262d0152f81..881174f4f90a4 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -516,6 +516,7 @@ struct bpf_struct_ops {
 };
 
 #define DATA_SEC ".data"
+#define PERCPU_DATA_SEC ".data..percpu"
 #define BSS_SEC ".bss"
 #define RODATA_SEC ".rodata"
 #define KCONFIG_SEC ".kconfig"
@@ -562,6 +563,8 @@ struct bpf_map {
 	__u32 btf_value_type_id;
 	__u32 btf_vmlinux_value_type_id;
 	enum libbpf_map_type libbpf_type;
+	int num_cpus;
+	void *data;
 	void *mmaped;
 	struct bpf_struct_ops *st_ops;
 	struct bpf_map *inner_map;
@@ -1923,11 +1926,35 @@ static bool map_is_mmapable(struct bpf_object *obj, struct bpf_map *map)
 	return false;
 }
 
+static bool map_is_percpu_data(struct bpf_map *map)
+{
+	return str_has_pfx(map->real_name, PERCPU_DATA_SEC);
+}
+
+static void map_copy_data(struct bpf_map *map, const void *data)
+{
+	bool is_percpu_data = map_is_percpu_data(map);
+	size_t data_sz = map->def.value_size;
+	size_t elem_sz = roundup(data_sz, 8);
+	int i;
+
+	if (!data)
+		return;
+
+	if (!is_percpu_data)
+		memcpy(map->mmaped, data, data_sz);
+	else
+		for (i = 0; i < map->num_cpus; i++)
+			memcpy(map->data + i*elem_sz, data, data_sz);
+}
+
 static int
 bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
 			      const char *real_name, int sec_idx, void *data, size_t data_sz)
 {
+	bool is_percpu_data = str_has_pfx(real_name, PERCPU_DATA_SEC);
 	struct bpf_map_def *def;
+	const char *data_desc;
 	struct bpf_map *map;
 	size_t mmap_sz;
 	int err;
@@ -1948,7 +1975,8 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
 	}
 
 	def = &map->def;
-	def->type = BPF_MAP_TYPE_ARRAY;
+	def->type = is_percpu_data ? BPF_MAP_TYPE_PERCPU_ARRAY
+				   : BPF_MAP_TYPE_ARRAY;
 	def->key_size = sizeof(int);
 	def->value_size = data_sz;
 	def->max_entries = 1;
@@ -1958,29 +1986,57 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
 	/* failures are fine because of maps like .rodata.str1.1 */
 	(void) map_fill_btf_type_info(obj, map);
 
-	if (map_is_mmapable(obj, map))
-		def->map_flags |= BPF_F_MMAPABLE;
+	data_desc = is_percpu_data ? "percpu " : "";
+	pr_debug("map '%s' (global %sdata): at sec_idx %d, offset %zu, flags %x.\n",
+		 map->name, data_desc, map->sec_idx, map->sec_offset,
+		 def->map_flags);
 
-	pr_debug("map '%s' (global data): at sec_idx %d, offset %zu, flags %x.\n",
-		 map->name, map->sec_idx, map->sec_offset, def->map_flags);
+	if (is_percpu_data) {
+		map->num_cpus = libbpf_num_possible_cpus();
+		if (map->num_cpus < 0) {
+			err = errno;
+			pr_warn("failed to get possible cpus\n");
+			goto free_name;
+		}
 
-	mmap_sz = bpf_map_mmap_sz(map);
-	map->mmaped = mmap(NULL, mmap_sz, PROT_READ | PROT_WRITE,
-			   MAP_SHARED | MAP_ANONYMOUS, -1, 0);
-	if (map->mmaped == MAP_FAILED) {
-		err = -errno;
-		map->mmaped = NULL;
-		pr_warn("failed to alloc map '%s' content buffer: %s\n", map->name, errstr(err));
-		zfree(&map->real_name);
-		zfree(&map->name);
-		return err;
-	}
+		map->data = calloc(map->num_cpus, roundup(data_sz, 8));
+		if (!map->data) {
+			err = -ENOMEM;
+			pr_warn("failed to alloc percpu map '%s' content buffer: %s\n",
+				map->name, errstr(err));
+			goto free_name;
+		}
 
-	if (data)
-		memcpy(map->mmaped, data, data_sz);
+		if (data)
+			map_copy_data(map, data);
+		else
+			memset(map->data, 0, map->num_cpus*roundup(data_sz, 8));
+	} else {
+		if (map_is_mmapable(obj, map))
+			def->map_flags |= BPF_F_MMAPABLE;
+
+		mmap_sz = bpf_map_mmap_sz(map);
+		map->mmaped = mmap(NULL, mmap_sz, PROT_READ | PROT_WRITE,
+				   MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+		if (map->mmaped == MAP_FAILED) {
+			err = -errno;
+			map->mmaped = NULL;
+			pr_warn("failed to alloc map '%s' content buffer: %s\n",
+				map->name, errstr(err));
+			goto free_name;
+		}
+
+		if (data)
+			memcpy(map->mmaped, data, data_sz);
+	}
 
 	pr_debug("map %td is \"%s\"\n", map - obj->maps, map->name);
 	return 0;
+
+free_name:
+	zfree(&map->real_name);
+	zfree(&map->name);
+	return err;
 }
 
 static int bpf_object__init_global_data_maps(struct bpf_object *obj)
@@ -5127,16 +5183,21 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
 	enum libbpf_map_type map_type = map->libbpf_type;
 	int err, zero = 0;
 	size_t mmap_sz;
+	size_t data_sz;
+	void *data;
 
+	data_sz = map_is_percpu_data(map) ? roundup(map->def.value_size, 8)*map->num_cpus
+					  : map->def.value_size;
+	data = map_is_percpu_data(map) ? map->data : map->mmaped;
 	if (obj->gen_loader) {
 		bpf_gen__map_update_elem(obj->gen_loader, map - obj->maps,
-					 map->mmaped, map->def.value_size);
+					 data, data_sz);
 		if (map_type == LIBBPF_MAP_RODATA || map_type == LIBBPF_MAP_KCONFIG)
 			bpf_gen__map_freeze(obj->gen_loader, map - obj->maps);
 		return 0;
 	}
 
-	err = bpf_map_update_elem(map->fd, &zero, map->mmaped, 0);
+	err = bpf_map_update_elem(map->fd, &zero, data, 0);
 	if (err) {
 		err = -errno;
 		pr_warn("map '%s': failed to set initial contents: %s\n",
@@ -9041,6 +9102,8 @@ static void bpf_map__destroy(struct bpf_map *map)
 	if (map->mmaped && map->mmaped != map->obj->arena_data)
 		munmap(map->mmaped, bpf_map_mmap_sz(map));
 	map->mmaped = NULL;
+	if (map->data)
+		zfree(&map->data);
 
 	if (map->st_ops) {
 		zfree(&map->st_ops->data);
@@ -10348,7 +10411,8 @@ int bpf_map__set_initial_value(struct bpf_map *map,
 	if (map->obj->loaded || map->reused)
 		return libbpf_err(-EBUSY);
 
-	if (!map->mmaped || map->libbpf_type == LIBBPF_MAP_KCONFIG)
+	if ((!map->mmaped && !map->data) ||
+	    map->libbpf_type == LIBBPF_MAP_KCONFIG)
 		return libbpf_err(-EINVAL);
 
 	if (map->def.type == BPF_MAP_TYPE_ARENA)
@@ -10358,7 +10422,7 @@ int bpf_map__set_initial_value(struct bpf_map *map,
 	if (size != actual_sz)
 		return libbpf_err(-EINVAL);
 
-	memcpy(map->mmaped, data, size);
+	map_copy_data(map, data);
 	return 0;
 }
 
@@ -10370,7 +10434,7 @@ void *bpf_map__initial_value(const struct bpf_map *map, size_t *psize)
 		return map->st_ops->data;
 	}
 
-	if (!map->mmaped)
+	if ((!map->mmaped && !map->data))
 		return NULL;
 
 	if (map->def.type == BPF_MAP_TYPE_ARENA)
@@ -10378,7 +10442,7 @@ void *bpf_map__initial_value(const struct bpf_map *map, size_t *psize)
 	else
 		*psize = map->def.value_size;
 
-	return map->mmaped;
+	return map->def.type == BPF_MAP_TYPE_PERCPU_ARRAY ? map->data : map->mmaped;
 }
 
 bool bpf_map__is_internal(const struct bpf_map *map)
-- 
2.47.1



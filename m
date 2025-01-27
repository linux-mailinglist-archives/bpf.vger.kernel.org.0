Return-Path: <bpf+bounces-49868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49786A1DA6D
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 17:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91D3B3A543B
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 16:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D813155C87;
	Mon, 27 Jan 2025 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CvoM9Yhb"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E9F14E2E8
	for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 16:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737994953; cv=none; b=Toxi4PAbNHUQKTMEHQubKifqIhJs6e3cMUdecpRCYmfKSJxToR/c9j3A+mzXje2lACwY5hoHJqH5aexa4iQBU9f7CJXE4sU2lkvB7EHUF9u+lqltk91QIoVMrAZcAf9yOW4fEoLofOp2FaClfVbeZGMmULyS3SFkOVCbykD4lbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737994953; c=relaxed/simple;
	bh=7DbjlrbGZB02APpDJdzLCYA2uOUpF1xjr7UTQyNEbaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ho88Lz+cGM+2GdX2CZlSfTbN6d4e9br1EOjKn5BUNM467ThrbpiOOb+CNL8SQim8i5RrCNjVEorQBtIBbH9TQeqU3Rv7njgArr4GhL9cRGx2KI0hDeG9fRJ9drzset1PdNVT6Di4aoKQIjzDygH+ni0XbGbZ5ebXRiIo+i39z3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CvoM9Yhb; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737994948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2sEzi/ol8biiXzqNX4u2Cupxa8A39NoWvtgT6jwYkrM=;
	b=CvoM9YhbslOakSp45eu2gnTKqccXJZGsRNmfLnr8VA0UkTnzVLWCG13AxAkajL81rjyPp1
	LYhboXaixM0/WYrRVF+ZUTH39KZg7k+0cUxnGLIgsoa0kDmPjuHJvYSbF6BwFBUGEjhDlX
	t12dA6ov3xsxhT+s4pAtn2rnNcl7sjM=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	qmo@kernel.org,
	dxu@dxuuu.xyz,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 1/4] bpf: Introduce global percpu data
Date: Tue, 28 Jan 2025 00:21:55 +0800
Message-ID: <20250127162158.84906-2-leon.hwang@linux.dev>
In-Reply-To: <20250127162158.84906-1-leon.hwang@linux.dev>
References: <20250127162158.84906-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch introduces global percpu data, inspired by commit
6316f78306c1 ("Merge branch 'support-global-data'"). It enables the
definition of global percpu variables in BPF, similar to the
DEFINE_PER_CPU() macro in the kernel[0].

For example, in BPF, it is able to define a global percpu variable like
this:

int percpu_data SEC(".percpu");

With this patch, tools like retsnoop[1] and bpflbr[2] can simplify their
BPF code for handling LBRs. The code can be updated from

static struct perf_branch_entry lbrs[1][MAX_LBR_ENTRIES] SEC(".data.lbrs");

to

static struct perf_branch_entry lbrs[MAX_LBR_ENTRIES] SEC(".percpu.lbrs");

This eliminates the need to retrieve the CPU ID using the
bpf_get_smp_processor_id() helper.

Additionally, by reusing global percpu data map, sharing information
between tail callers and callees or freplace callers and callees becomes
simpler compared to reusing percpu_array maps.

Links:
[0] https://github.com/torvalds/linux/blob/fbfd64d25c7af3b8695201ebc85efe90be28c5a3/include/linux/percpu-defs.h#L114
[1] https://github.com/anakryiko/retsnoop
[2] https://github.com/Asphaltt/bpflbr

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/arraymap.c | 39 ++++++++++++++++++++++++++++++++++++-
 kernel/bpf/verifier.c | 45 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+), 1 deletion(-)

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
index 9971c03adfd5d..9d99497c2b94c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6810,6 +6810,8 @@ static int bpf_map_direct_read(struct bpf_map *map, int off, int size, u64 *val,
 	u64 addr;
 	int err;
 
+	if (map->map_type != BPF_MAP_TYPE_ARRAY)
+		return -EINVAL;
 	err = map->ops->map_direct_value_addr(map, &addr, off);
 	if (err)
 		return err;
@@ -7322,6 +7324,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			/* if map is read-only, track its contents as scalars */
 			if (tnum_is_const(reg->var_off) &&
 			    bpf_map_is_rdonly(map) &&
+			    map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY &&
 			    map->ops->map_direct_value_addr) {
 				int map_off = off + reg->var_off.value;
 				u64 val = 0;
@@ -9128,6 +9131,11 @@ static int check_reg_const_str(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
+	if (map->map_type != BPF_MAP_TYPE_ARRAY) {
+		verbose(env, "only array map supports direct string value access\n");
+		return -EINVAL;
+	}
+
 	err = check_map_access(env, regno, reg->off,
 			       map->value_size - reg->off, false,
 			       ACCESS_HELPER);
@@ -10802,6 +10810,11 @@ static int check_bpf_snprintf_call(struct bpf_verifier_env *env,
 		return -EINVAL;
 	num_args = data_len_reg->var_off.value / 8;
 
+	if (fmt_map->map_type != BPF_MAP_TYPE_ARRAY) {
+		verbose(env, "only array map supports snprintf\n");
+		return -EINVAL;
+	}
+
 	/* fmt being ARG_PTR_TO_CONST_STR guarantees that var_off is const
 	 * and map_direct_value_addr is set.
 	 */
@@ -21381,6 +21394,38 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
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
-- 
2.47.1



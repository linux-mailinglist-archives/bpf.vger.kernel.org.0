Return-Path: <bpf+bounces-78854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 479D1D1D76A
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 10:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9E910300922A
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 09:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9585C3876C8;
	Wed, 14 Jan 2026 09:19:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6FD387376;
	Wed, 14 Jan 2026 09:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768382381; cv=none; b=cfWr8G/sZqjiQxYTr51e8u+76AjAd7KfTWmZfuFSYB05Y4tr1kdtVJLGorJLTmhzP7VuMdJHnl1AO6vhajzSc1vYTxuO/YoZlTgHSiBYP4zT1HMs7pMuPVDBsuLE5ykSw3PXCjFFYRvIWql28X1C3dPACHh+NEXnnEKq9efedeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768382381; c=relaxed/simple;
	bh=FfnYyZqbIuPhFnXISvjq7/1+uz7K6mlBSL0DqoCpePY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JkEwCKmMhe1eGs7qwUSvE+zi/Daxjf0k/GR1m+eyKzkpqA80/DcGdXZ6UcwYjwW/3I5BT33IamM0jDKtC1tD6SDqnwDTUPKLttTBCEtcCMP+FPC4NzsjqyustK9OM4N925ezPt9yIIg4fSKvVOGQIpALg86uCNvL4UDolWBWjsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4drgXG2JbGzKHMSk;
	Wed, 14 Jan 2026 17:18:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 229B240539;
	Wed, 14 Jan 2026 17:19:30 +0800 (CST)
Received: from k01.k01 (unknown [10.67.174.197])
	by APP2 (Coremail) with SMTP id Syh0CgCXsYCfX2dpDhLdDg--.16789S4;
	Wed, 14 Jan 2026 17:19:29 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next v4 2/4] bpf: Add helper to detect indirect jump targets
Date: Wed, 14 Jan 2026 17:39:12 +0800
Message-ID: <20260114093914.2403982-3-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260114093914.2403982-1-xukuohai@huaweicloud.com>
References: <20260114093914.2403982-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCXsYCfX2dpDhLdDg--.16789S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Cw47JF4rCF47XFWDKF1UGFg_yoWDWw43pF
	4DW3s7Ar4UXrsFgwnrAa18Ary3ta1rWa4DKFW7W3y8Aw1YqrnYgF4F9FWavF98trWUCw1x
	ZF4j9rW7Wry7ZFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFylc7CjxVAKzI0EY4vE52x082I5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsG
	vfC2KfnxnUUI43ZEXa7IU8go7tUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Introduce helper bpf_insn_is_indirect_target to determine whether a BPF
instruction is an indirect jump target. This helper will be used by
follow-up patches to decide where to emit indirect landing pad instructions.

Add a new flag to struct bpf_insn_aux_data to mark instructions that are
indirect jump targets. The BPF verifier sets this flag, and the helper
checks it to determine whether an instruction is an indirect jump target.

Since bpf_insn_aux_data is only available before JIT stage, add a new
field to struct bpf_prog_aux to store a pointer to the bpf_insn_aux_data
array, making it accessible to the JIT.

For programs with multiple subprogs, each subprog uses its own private
copy of insn_aux_data, since subprogs may insert additional instructions
during JIT and need to update the array. For non-subprog, the verifier's
insn_aux_data array is used directly to avoid unnecessary copying.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 include/linux/bpf.h          |  2 ++
 include/linux/bpf_verifier.h | 10 ++++---
 kernel/bpf/core.c            | 51 +++++++++++++++++++++++++++++++++---
 kernel/bpf/verifier.c        | 51 +++++++++++++++++++++++++++++++++++-
 4 files changed, 105 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5936f8e2996f..e7d7e705327e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1533,6 +1533,7 @@ bool bpf_has_frame_pointer(unsigned long ip);
 int bpf_jit_charge_modmem(u32 size);
 void bpf_jit_uncharge_modmem(u32 size);
 bool bpf_prog_has_trampoline(const struct bpf_prog *prog);
+bool bpf_insn_is_indirect_target(const struct bpf_prog *prog, int idx);
 #else
 static inline int bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 					   struct bpf_trampoline *tr,
@@ -1760,6 +1761,7 @@ struct bpf_prog_aux {
 	struct bpf_stream stream[2];
 	struct mutex st_ops_assoc_mutex;
 	struct bpf_map __rcu *st_ops_assoc;
+	struct bpf_insn_aux_data *insn_aux;
 };
 
 #define BPF_NR_CONTEXTS        4       /* normal, softirq, hardirq, NMI */
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 130bcbd66f60..758086b384df 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -574,16 +574,18 @@ struct bpf_insn_aux_data {
 
 	/* below fields are initialized once */
 	unsigned int orig_idx; /* original instruction index */
-	bool jmp_point;
-	bool prune_point;
+	u32 jmp_point:1;
+	u32 prune_point:1;
 	/* ensure we check state equivalence and save state checkpoint and
 	 * this instruction, regardless of any heuristics
 	 */
-	bool force_checkpoint;
+	u32 force_checkpoint:1;
 	/* true if instruction is a call to a helper function that
 	 * accepts callback function as a parameter.
 	 */
-	bool calls_callback;
+	u32 calls_callback:1;
+	/* true if the instruction is an indirect jump target */
+	u32 indirect_target:1;
 	/*
 	 * CFG strongly connected component this instruction belongs to,
 	 * zero if it is a singleton SCC.
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index e0b8a8a5aaa9..bb870936e74b 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1486,6 +1486,35 @@ static void adjust_insn_arrays(struct bpf_prog *prog, u32 off, u32 len)
 #endif
 }
 
+static int adjust_insn_aux(struct bpf_prog *prog, int off, int cnt)
+{
+	size_t size;
+	struct bpf_insn_aux_data *new_aux;
+
+	if (cnt == 1)
+		return 0;
+
+	/* prog->len already accounts for the cnt - 1 newly inserted instructions */
+	size = array_size(prog->len, sizeof(struct bpf_insn_aux_data));
+	new_aux = vrealloc(prog->aux->insn_aux, size, GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+	if (!new_aux)
+		return -ENOMEM;
+
+	/* follow the same behavior as adjust_insn_array(): leave [0, off] unchanged and shift
+	 * [off + 1, end) to [off + cnt, end). Otherwise, the JIT would emit landing pads at
+	 * wrong locations, as the actual indirect jump target remains at off.
+	 */
+	size = array_size(prog->len - off - cnt, sizeof(struct bpf_insn_aux_data));
+	memmove(new_aux + off + cnt, new_aux + off + 1, size);
+
+	size = array_size(cnt - 1, sizeof(struct bpf_insn_aux_data));
+	memset(new_aux + off + 1, 0, size);
+
+	prog->aux->insn_aux = new_aux;
+
+	return 0;
+}
+
 struct bpf_prog *bpf_jit_blind_constants(struct bpf_prog *prog)
 {
 	struct bpf_insn insn_buff[16], aux[2];
@@ -1541,6 +1570,11 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf_prog *prog)
 		clone = tmp;
 		insn_delta = rewritten - 1;
 
+		if (adjust_insn_aux(clone, i, rewritten)) {
+			bpf_jit_prog_release_other(prog, clone);
+			return ERR_PTR(-ENOMEM);
+		}
+
 		/* Instructions arrays must be updated using absolute xlated offsets */
 		adjust_insn_arrays(clone, prog->aux->subprog_start + i, rewritten);
 
@@ -1553,6 +1587,11 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf_prog *prog)
 	clone->blinded = 1;
 	return clone;
 }
+
+bool bpf_insn_is_indirect_target(const struct bpf_prog *prog, int idx)
+{
+	return prog->aux->insn_aux && prog->aux->insn_aux[idx].indirect_target;
+}
 #endif /* CONFIG_BPF_JIT */
 
 /* Base function for offset calculation. Needs to go into .text section,
@@ -2540,24 +2579,24 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
 	if (!bpf_prog_is_offloaded(fp->aux)) {
 		*err = bpf_prog_alloc_jited_linfo(fp);
 		if (*err)
-			return fp;
+			goto free_insn_aux;
 
 		fp = bpf_int_jit_compile(fp);
 		bpf_prog_jit_attempt_done(fp);
 		if (!fp->jited && jit_needed) {
 			*err = -ENOTSUPP;
-			return fp;
+			goto free_insn_aux;
 		}
 	} else {
 		*err = bpf_prog_offload_compile(fp);
 		if (*err)
-			return fp;
+			goto free_insn_aux;
 	}
 
 finalize:
 	*err = bpf_prog_lock_ro(fp);
 	if (*err)
-		return fp;
+		goto free_insn_aux;
 
 	/* The tail call compatibility check can only be done at
 	 * this late stage as we need to determine, if we deal
@@ -2566,6 +2605,10 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
 	 */
 	*err = bpf_check_tail_call(fp);
 
+free_insn_aux:
+	vfree(fp->aux->insn_aux);
+	fp->aux->insn_aux = NULL;
+
 	return fp;
 }
 EXPORT_SYMBOL_GPL(bpf_prog_select_runtime);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 22605d9e0ffa..f2fe6baeceb9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3852,6 +3852,11 @@ static bool is_jmp_point(struct bpf_verifier_env *env, int insn_idx)
 	return env->insn_aux_data[insn_idx].jmp_point;
 }
 
+static void mark_indirect_target(struct bpf_verifier_env *env, int idx)
+{
+	env->insn_aux_data[idx].indirect_target = true;
+}
+
 #define LR_FRAMENO_BITS	3
 #define LR_SPI_BITS	6
 #define LR_ENTRY_BITS	(LR_SPI_BITS + LR_FRAMENO_BITS + 1)
@@ -20337,6 +20342,7 @@ static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *in
 	}
 
 	for (i = 0; i < n; i++) {
+		mark_indirect_target(env, env->gotox_tmp_buf->items[i]);
 		other_branch = push_stack(env, env->gotox_tmp_buf->items[i],
 					  env->insn_idx, env->cur_state->speculative);
 		if (IS_ERR(other_branch))
@@ -21243,6 +21249,37 @@ static void convert_pseudo_ld_imm64(struct bpf_verifier_env *env)
 	}
 }
 
+static int clone_insn_aux_data(struct bpf_prog *prog, struct bpf_verifier_env *env, u32 off)
+{
+	u32 i;
+	size_t size;
+	bool has_indirect_target = false;
+	struct bpf_insn_aux_data *insn_aux;
+
+	for (i = 0; i < prog->len; i++) {
+		if (env->insn_aux_data[off + i].indirect_target) {
+			has_indirect_target = true;
+			break;
+		}
+	}
+
+	/* insn_aux is copied into bpf_prog so the JIT can check whether an instruction is an
+	 * indirect jump target. If no indirect jump targets exist, copying is unnecessary.
+	 */
+	if (!has_indirect_target)
+		return 0;
+
+	size = array_size(sizeof(struct bpf_insn_aux_data), prog->len);
+	insn_aux = vzalloc(size);
+	if (!insn_aux)
+		return -ENOMEM;
+
+	memcpy(insn_aux, env->insn_aux_data + off, size);
+	prog->aux->insn_aux = insn_aux;
+
+	return 0;
+}
+
 /* single env->prog->insni[off] instruction was replaced with the range
  * insni[off, off + cnt).  Adjust corresponding insn_aux_data by copying
  * [0, off) and [off, end) to new locations, so the patched range stays zero
@@ -22239,6 +22276,10 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		if (!i)
 			func[i]->aux->exception_boundary = env->seen_exception;
 
+		err = clone_insn_aux_data(func[i], env, subprog_start);
+		if (err < 0)
+			goto out_free;
+
 		/*
 		 * To properly pass the absolute subprog start to jit
 		 * all instruction adjustments should be accumulated
@@ -22306,6 +22347,8 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	for (i = 0; i < env->subprog_cnt; i++) {
 		func[i]->aux->used_maps = NULL;
 		func[i]->aux->used_map_cnt = 0;
+		vfree(func[i]->aux->insn_aux);
+		func[i]->aux->insn_aux = NULL;
 	}
 
 	/* finally lock prog and jit images for all functions and
@@ -22367,6 +22410,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	for (i = 0; i < env->subprog_cnt; i++) {
 		if (!func[i])
 			continue;
+		vfree(func[i]->aux->insn_aux);
 		func[i]->aux->poke_tab = NULL;
 		bpf_jit_free(func[i]);
 	}
@@ -25350,6 +25394,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	env->verification_time = ktime_get_ns() - start_time;
 	print_verification_stats(env);
 	env->prog->aux->verified_insns = env->insn_processed;
+	env->prog->aux->insn_aux = env->insn_aux_data;
 
 	/* preserve original error even if log finalization is successful */
 	err = bpf_vlog_finalize(&env->log, &log_true_size);
@@ -25428,7 +25473,11 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (!is_priv)
 		mutex_unlock(&bpf_verifier_lock);
 	clear_insn_aux_data(env, 0, env->prog->len);
-	vfree(env->insn_aux_data);
+	/* on success, insn_aux_data will be freed by bpf_prog_select_runtime */
+	if (ret) {
+		vfree(env->insn_aux_data);
+		env->prog->aux->insn_aux = NULL;
+	}
 err_free_env:
 	bpf_stack_liveness_free(env);
 	kvfree(env->cfg.insn_postorder);
-- 
2.47.3



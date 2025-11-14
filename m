Return-Path: <bpf+bounces-74523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 788DBC5E438
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 17:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AD17C3C257D
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 15:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AE13314C4;
	Fri, 14 Nov 2025 15:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pe4FX2I3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7102532ABE1
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 15:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763134828; cv=none; b=C7pom607ZP3XTknAv1D28hPZSoGd1Z4QHPza9dvDzfZNiWaZ7HzBgfpeLlPWdwgMM/dWWnT7lLftcSyszm2vtzLyGvU5NzbbQXLxBab8g9h7LUB2clzT7+ylCzrudecI1HBUf6joocTJmnXgv94MEqHgD+KmgUOe/K9D+EnB6Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763134828; c=relaxed/simple;
	bh=7zTdBRL+TAG9C9kbbJh4CCP5438NRQas1pOYsskJX7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UoQ9OzqWX/qQ5mvZ4F1WPO09HBTYN8LAEP7oPpeb+WeGm1HTHpBgffyiy+g+AplK+rxhx6yMautl5900q8KfB8t3BDrLF3q2x6GEEuH1Tq11WPLs6Px13i6gs8CI72GpGcgqeJm2GuwUhLdHO0pjr/0Jc1PJ+Yt5roJrPXGxBUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pe4FX2I3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5092C113D0;
	Fri, 14 Nov 2025 15:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763134828;
	bh=7zTdBRL+TAG9C9kbbJh4CCP5438NRQas1pOYsskJX7s=;
	h=From:To:Cc:Subject:Date:From;
	b=Pe4FX2I3Dakce/oC+VdT5SuCduJmK4VcjNuLiR+seJcN3v5kA+ecuFcmPdLwAohrN
	 fBGzbTUMQMsXdzBnZeqGzLm0Y1DPW0J5wHMF+J0mw1d5125KqmlZdkgapDGtnlKGSj
	 tKC3czJnudcm38j+u/GaWfInOEOBFwYYEjZtg6M4XlMbb5ZKYtKjxBq95V+dKUmAJQ
	 GyT8mr604NWGIjcsJF2qWXoUVI5cI8aAXQDrnXknQVz/l/G2jhYc0E2dkXG1AQVdQO
	 oSaOnE/j8n1AFZPHWRO49ZRRpmP7v0opfazG5ulgI65jamnyLV8pF5J3wwmGwAGFlm
	 lOwj8tihYNPrg==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3] bpf: verifier: Move desc->imm setup to sort_kfunc_descs_by_imm_off()
Date: Fri, 14 Nov 2025 15:40:22 +0000
Message-ID: <20251114154023.12801-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Metadata about a kfunc call is added to the kfunc_tab in
add_kfunc_call() but the call instruction itself could get removed by
opt_remove_dead_code() later if it is not reachable.

If the call instruction is removed, specialize_kfunc() is never called
for it and the desc->imm in the kfunc_tab is never initialized for this
kfunc call. In this case, sort_kfunc_descs_by_imm_off(env->prog); in
do_misc_fixups() doesn't sort the table correctly.
This is a problem for s390 as its JIT uses this table to find the
addresses for kfuncs, and if this table is not sorted properly, JIT may
fail to find addresses for valid kfunc calls.

This was exposed by:

commit d869d56ca848 ("bpf: verifier: refactor kfunc specialization")

as before this commit, desc->imm was initialised in add_kfunc_call()
which happens before dead code elimination.

Move desc->imm setup down to sort_kfunc_descs_by_imm_off(), this fixes
the problem and also saves us from having the same logic in
add_kfunc_call() and specialize_kfunc().

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---

Changes in v2->v3:
v2: https://lore.kernel.org/all/20251113104053.18107-1-puranjay@kernel.org/
- Move desc->imm setup down to sort_kfunc_descs_by_imm_off() (Eduard)

Changes in v1->v2:
v1: https://lore.kernel.org/all/20251111160949.45623-1-puranjay@kernel.org/
- Removed fixes tag as the broken commit is not upstream yet.
- Initialize desc->imm with the correct value for both with and without
  bpf_jit_supports_far_kfunc_call() for completeness.
- Don't re-initialize desc->imm to func_id in specialize_kfunc() as it
  it already have that value, it only needs to be updated in the
  !bpf_jit_supports_far_kfunc_call() case where the imm can change.

This bug is not triggered by the CI currently, I am working on another
set for non-sleepbale arena allocations and as part of that I am adding
a new selftest that triggers this bug.

Selftest: https://github.com/kernel-patches/bpf/pull/10242/commits/1f681f022c6d685fd76695e5eafbe9d9ab4c0002
CI run: https://github.com/kernel-patches/bpf/actions/runs/19238699806/job/54996376908

---
 kernel/bpf/verifier.c | 54 ++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1268fa075d4c..5f6f50f7116b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3391,16 +3391,43 @@ static int kfunc_desc_cmp_by_imm_off(const void *a, const void *b)
 	return 0;
 }
 
-static void sort_kfunc_descs_by_imm_off(struct bpf_prog *prog)
+static int set_kfunc_desc_imm(struct bpf_verifier_env *env, struct bpf_kfunc_desc *desc)
+{
+	unsigned long call_imm;
+
+	if (bpf_jit_supports_far_kfunc_call()) {
+		call_imm = desc->func_id;
+	} else {
+		call_imm = BPF_CALL_IMM(desc->addr);
+		/* Check whether the relative offset overflows desc->imm */
+		if ((unsigned long)(s32)call_imm != call_imm) {
+			verbose(env, "address of kernel func_id %u is out of range\n",
+				desc->func_id);
+			return -EINVAL;
+		}
+	}
+	desc->imm = call_imm;
+	return 0;
+}
+
+static int sort_kfunc_descs_by_imm_off(struct bpf_verifier_env *env)
 {
 	struct bpf_kfunc_desc_tab *tab;
+	int i, err;
 
-	tab = prog->aux->kfunc_tab;
+	tab = env->prog->aux->kfunc_tab;
 	if (!tab)
-		return;
+		return 0;
+
+	for (i = 0; i < tab->nr_descs; i++) {
+		err = set_kfunc_desc_imm(env, &tab->descs[i]);
+		if (err)
+			return err;
+	}
 
 	sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
 	     kfunc_desc_cmp_by_imm_off, NULL);
+	return 0;
 }
 
 bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog)
@@ -22320,10 +22347,10 @@ static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc
 	bool is_rdonly;
 	u32 func_id = desc->func_id;
 	u16 offset = desc->offset;
-	unsigned long addr = desc->addr, call_imm;
+	unsigned long addr = desc->addr;
 
 	if (offset) /* return if module BTF is used */
-		goto set_imm;
+		return 0;
 
 	if (bpf_dev_bound_kfunc_id(func_id)) {
 		xdp_kfunc = bpf_dev_bound_resolve_kfunc(prog, func_id);
@@ -22351,19 +22378,6 @@ static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc
 		if (!env->insn_aux_data[insn_idx].non_sleepable)
 			addr = (unsigned long)bpf_dynptr_from_file_sleepable;
 	}
-
-set_imm:
-	if (bpf_jit_supports_far_kfunc_call()) {
-		call_imm = func_id;
-	} else {
-		call_imm = BPF_CALL_IMM(addr);
-		/* Check whether the relative offset overflows desc->imm */
-		if ((unsigned long)(s32)call_imm != call_imm) {
-			verbose(env, "address of kernel func_id %u is out of range\n", func_id);
-			return -EINVAL;
-		}
-	}
-	desc->imm = call_imm;
 	desc->addr = addr;
 	return 0;
 }
@@ -23441,7 +23455,9 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		}
 	}
 
-	sort_kfunc_descs_by_imm_off(env->prog);
+	ret = sort_kfunc_descs_by_imm_off(env);
+	if (ret)
+		return ret;
 
 	return 0;
 }
-- 
2.47.3



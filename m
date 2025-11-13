Return-Path: <bpf+bounces-74364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CCDC56FB5
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 11:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DFE5423260
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 10:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E411335543;
	Thu, 13 Nov 2025 10:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTcrSVGY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1748D335061
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 10:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030458; cv=none; b=T6juO4J+OwWRjBF31Bec7l404dNntUMvbJ2mDjYjCTxlrjMmFPviHq+GQDENk9GhjTrAiWo/qqVunaodhpgIp+bXunBX66ad14MI05RAGA+zi0yNEXogmiO4QzSU3jZF6tNcIau3G5pWUNYUsfhcQuAi0vH13Hdkgkg4wAdl7c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030458; c=relaxed/simple;
	bh=JLkHmxfIT3puo82LYcfmo8QGiKSWD4IlMi83hConYbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HcLuGxWEiYj///aUohXQD3wgFoZidNnQqmX1UyVFgA+Pg0S7+R4gvbG/5q+goXckRHK/uxf5XHuW+XkdEpOHjz3s7iBgrvwFPvuA3njNQ9P1UQ1l+ef+AJwQnqEV0yU0cORy8c5BF43DHsAPc3vC2EWj/Ql41tnDhip1QaP9dvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTcrSVGY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71448C4CEF5;
	Thu, 13 Nov 2025 10:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763030457;
	bh=JLkHmxfIT3puo82LYcfmo8QGiKSWD4IlMi83hConYbw=;
	h=From:To:Cc:Subject:Date:From;
	b=KTcrSVGYqdL+ZLB5RvdkY9XKHbcQjfWVS6BcBrylGfYE7Y/Y6WcvRPJi9j4dSZH4F
	 WrW2wQ2l6FWdTu/JWGuR4yWNCut9+KDYk/z1kjZSsuek7Fd3Bf944/7Ui1QVhJratt
	 cJTBtceKK+FRAkWfQLcOjDQs6reyIURnnLOnYsj/RrehIYHJaSBNUBTxQyLVbAr009
	 h7UL9scSTzJTIbojnnx9ahR62hpDVoxjhroVEMishw85zLM/PZ1g18NxCGaJv0XtoL
	 9Vl80Y5JfBU2S1F5HPogkbOTmfg1GJOjx2Fv6arfJCTtdi7Qq/HJsqTttcPOFeUQmi
	 uN+K3SjFAgQIw==
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
Subject: [PATCH bpf-next v2] bpf: verifier: initialize imm in kfunc_tab in add_kfunc_call()
Date: Thu, 13 Nov 2025 10:40:52 +0000
Message-ID: <20251113104053.18107-1-puranjay@kernel.org>
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
This is a problem from s390 as its JIT uses this table to find the
addresses for kfuncs, and if this table is not sorted properly, JIT can
fail to find addresses for valid kfunc calls.

This was exposed by:

commit d869d56ca848 ("bpf: verifier: refactor kfunc specialization")

as before this commit, desc->imm was initialised in add_kfunc_call().

Initialize desc->imm in add_kfunc_call(), it will be overwritten with new
imm in specialize_kfunc() if the instruction is not removed.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---

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

 kernel/bpf/verifier.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1268fa075d4c..31136f9c418b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3273,7 +3273,7 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
 	struct bpf_kfunc_desc *desc;
 	const char *func_name;
 	struct btf *desc_btf;
-	unsigned long addr;
+	unsigned long addr, call_imm;
 	int err;
 
 	prog_aux = env->prog->aux;
@@ -3369,8 +3369,20 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
 	if (err)
 		return err;
 
+	if (bpf_jit_supports_far_kfunc_call()) {
+		call_imm = func_id;
+	} else {
+		call_imm = BPF_CALL_IMM(addr);
+		/* Check whether the relative offset overflows desc->imm */
+		if ((unsigned long)(s32)call_imm != call_imm) {
+			verbose(env, "address of kernel func_id %u is out of range\n", func_id);
+			return -EINVAL;
+		}
+	}
+
 	desc = &tab->descs[tab->nr_descs++];
 	desc->func_id = func_id;
+	desc->imm = call_imm;
 	desc->offset = offset;
 	desc->addr = addr;
 	desc->func_model = func_model;
@@ -22353,17 +22365,15 @@ static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc
 	}
 
 set_imm:
-	if (bpf_jit_supports_far_kfunc_call()) {
-		call_imm = func_id;
-	} else {
+	if (!bpf_jit_supports_far_kfunc_call()) {
 		call_imm = BPF_CALL_IMM(addr);
 		/* Check whether the relative offset overflows desc->imm */
 		if ((unsigned long)(s32)call_imm != call_imm) {
 			verbose(env, "address of kernel func_id %u is out of range\n", func_id);
 			return -EINVAL;
 		}
+		desc->imm = call_imm;
 	}
-	desc->imm = call_imm;
 	desc->addr = addr;
 	return 0;
 }
-- 
2.47.3



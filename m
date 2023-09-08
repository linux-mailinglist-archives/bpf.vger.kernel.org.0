Return-Path: <bpf+bounces-9542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A82798D16
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 20:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37F04281CA3
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 18:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921F114F68;
	Fri,  8 Sep 2023 18:15:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20BF14F64
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 18:15:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E382C116D3;
	Fri,  8 Sep 2023 18:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694196952;
	bh=+7IsQtQ5i+ArhkWuyUtskzCuxw9rV5PTuFOTyEJEqGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KUZ92OVeHqFjFkWDhuQKZedUWPtSIIOUo8fYpHOeuh9x5edHqaEVsKANMcNfbCGtN
	 fEJrXBR7aNro64S6feXez+bepOZ2tIZNqNYGsLYS6YRnYCYTeaUe6iNhDo1n0DZMVI
	 sV6/r7/+ekiXxbX6VtzFT3wwEfDdLhVdsfH48WHcEC4vmTpbULCkvbsO95hPr6d7sh
	 F7pNe4dkwhPTcXv+jZgqMLRRfZOxxdObYug57BtP3c07dmRxnfzz2xS204kg23cx/Q
	 KfIjZy9ahiEhEjceqk03boQ/7W/wYa9lRwpXQOyDkKsIBAuoYrS43C/oI1YXIODbRJ
	 IvKCR+zGhuKDQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dave Marchevsky <davemarchevsky@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 45/45] bpf: Consider non-owning refs to refcounted nodes RCU protected
Date: Fri,  8 Sep 2023 14:13:26 -0400
Message-Id: <20230908181327.3459042-45-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181327.3459042-1-sashal@kernel.org>
References: <20230908181327.3459042-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
Content-Transfer-Encoding: 8bit

From: Dave Marchevsky <davemarchevsky@fb.com>

[ Upstream commit 0816b8c6bf7fc87cec4273dc199e8f0764b9e7b1 ]

An earlier patch in the series ensures that the underlying memory of
nodes with bpf_refcount - which can have multiple owners - is not reused
until RCU grace period has elapsed. This prevents
use-after-free with non-owning references that may point to
recently-freed memory. While RCU read lock is held, it's safe to
dereference such a non-owning ref, as by definition RCU GP couldn't have
elapsed and therefore underlying memory couldn't have been reused.

From the perspective of verifier "trustedness" non-owning refs to
refcounted nodes are now trusted only in RCU CS and therefore should no
longer pass is_trusted_reg, but rather is_rcu_reg. Let's mark them
MEM_RCU in order to reflect this new state.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Link: https://lore.kernel.org/r/20230821193311.3290257-6-davemarchevsky@fb.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf.h   |  3 ++-
 kernel/bpf/verifier.c | 13 ++++++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f58895830adae..58e5fee4c03a4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -640,7 +640,8 @@ enum bpf_type_flag {
 	MEM_RCU			= BIT(13 + BPF_BASE_TYPE_BITS),
 
 	/* Used to tag PTR_TO_BTF_ID | MEM_ALLOC references which are non-owning.
-	 * Currently only valid for linked-list and rbtree nodes.
+	 * Currently only valid for linked-list and rbtree nodes. If the nodes
+	 * have a bpf_refcount_field, they must be tagged MEM_RCU as well.
 	 */
 	NON_OWN_REF		= BIT(14 + BPF_BASE_TYPE_BITS),
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 02a021c524ab8..c5fbdb977f011 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7842,6 +7842,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
 	case PTR_TO_BTF_ID | PTR_TRUSTED:
 	case PTR_TO_BTF_ID | MEM_RCU:
 	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF:
+	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU:
 		/* When referenced PTR_TO_BTF_ID is passed to release function,
 		 * its fixed offset must be 0. In the other cases, fixed offset
 		 * can be non-zero. This was already checked above. So pass
@@ -10303,6 +10304,7 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
 static int ref_set_non_owning(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
 	struct bpf_verifier_state *state = env->cur_state;
+	struct btf_record *rec = reg_btf_record(reg);
 
 	if (!state->active_lock.ptr) {
 		verbose(env, "verifier internal error: ref_set_non_owning w/o active lock\n");
@@ -10315,6 +10317,9 @@ static int ref_set_non_owning(struct bpf_verifier_env *env, struct bpf_reg_state
 	}
 
 	reg->type |= NON_OWN_REF;
+	if (rec->refcount_off >= 0)
+		reg->type |= MEM_RCU;
+
 	return 0;
 }
 
@@ -11155,6 +11160,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		struct bpf_func_state *state;
 		struct bpf_reg_state *reg;
 
+		if (in_rbtree_lock_required_cb(env) && (rcu_lock || rcu_unlock)) {
+			verbose(env, "Calling bpf_rcu_read_{lock,unlock} in unnecessary rbtree callback\n");
+			return -EACCES;
+		}
+
 		if (rcu_lock) {
 			verbose(env, "nested rcu read lock (kernel function %s)\n", func_name);
 			return -EINVAL;
@@ -16453,7 +16463,8 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
 
-				if (env->cur_state->active_rcu_lock) {
+				if (env->cur_state->active_rcu_lock &&
+				    !in_rbtree_lock_required_cb(env)) {
 					verbose(env, "bpf_rcu_read_unlock is missing\n");
 					return -EINVAL;
 				}
-- 
2.40.1



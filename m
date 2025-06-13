Return-Path: <bpf+bounces-60601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A55AD8637
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 11:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 714B5189BF9D
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 09:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1912727EC;
	Fri, 13 Jun 2025 09:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="HA4ilFFs"
X-Original-To: bpf@vger.kernel.org
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [131.188.11.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86212DA772;
	Fri, 13 Jun 2025 09:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749805446; cv=none; b=W2ISYzJZaOIZLxOOKPVosr0Xh5N2e4kt7teMhwCt6kUhoqbW9HGEpurmwqp4cXIRJOAxOIWevqd/fsriyHZV0mPI68zbvMmkzqSUilXJtoUgUNzLyUDJfJVXVfAtUbYMKzUzRDMzRsoT9WtoOEX9+TKZQyNIkhDHMuShnSN4RJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749805446; c=relaxed/simple;
	bh=zJwTtQSAa5HRrIuQh+CUXWejQR70jOTRCIqBI7Qzsts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Btio7jwhuZPv4OI/MI2eX+92N9oJojrKP7nXLdBcwZN+3PjfjOUOZ5ZZJgaYBN+UTWmANQaxHSeJnKC7FKx3JwWgtn2U2OUAfBEZdQ6BX592SlSQouQ4rPwjKP2cnKKB4lVAWbiKF2+Q4Zy7UtHCfvigN6r2Tt/RFTyuIItxq+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=HA4ilFFs; arc=none smtp.client-ip=131.188.11.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1749805435; bh=pk/YSiR8kM1WyBitG6y7PF5HVEEOKlm6+fhKP2kx/MI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=HA4ilFFsazSE0lY3YWiIRtVqOpFirpENabSxQo9qgtS1eclQw2fghvxUl0tvQd5Ee
	 i8TJ/XFKC2F9qDhSlI3jJ7lkpnANVO+N4bYSitZVLIS7DTVs+qof25dC10MdADjqzP
	 hB33CLu8APK7zhyAOuY1nEDNNxSw1wopnygNR5ubNt5BkmdVvicb5bAPDm3Yd111Gk
	 f6BADQBTtPOmyhmWzVP8sQ6qZzhZHbHZMmGTlYhRSN3IGg8e7g9ZhdKEtGI58ZpVB2
	 kwlTCg6XfzlO0KmfzYATBuLapLIcczz9syNoTNN6ROQ5lDteUgRfuoP4yo+H5thUkz
	 szUnhyq9pLzHg==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4bJYNW4mJPzPk28;
	Fri, 13 Jun 2025 11:03:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 37.201.192.232
Received: from luis-tp.. (ip-037-201-192-232.um10.pools.vodafone-ip.de [37.201.192.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1/h3Rf647JUjgakCq1chLzWuoo8oIF5ed8=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4bJYNS2JjLzPkBF;
	Fri, 13 Jun 2025 11:03:52 +0200 (CEST)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Luis Gerhorst <luis.gerhorst@fau.de>
Subject: [PATCH bpf-next v2] bpf: Remove redundant free_verifier_state()/pop_stack()
Date: Fri, 13 Jun 2025 11:01:58 +0200
Message-ID: <20250613090157.568349-2-luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <19f50af28e3a90cbd24b2325da8025e47f221739.camel@gmail.com>
References: <19f50af28e3a90cbd24b2325da8025e47f221739.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch removes duplicated code.

Eduard points out [1]:

    Same cleanup cycles are done in push_stack() and push_async_cb(),
    both functions are only reachable from do_check_common() via
    do_check() -> do_check_insn().

    Hence, I think that cur state should not be freed in push_*()
    functions and pop_stack() loop there is not needed.

This would also fix the 'symptom' for [2], but the issue also has a
simpler fix which was sent separately. This fix also makes sure the
push_*() callers always return an error for which
error_recoverable_with_nospec(err) is false. This is required because
otherwise we try to recover and access the stale `state`.

Moving free_verifier_state() and pop_stack(..., pop_log=false) to happen
after the bpf_vlog_reset() call in do_check_common() is fine because the
pop_stack() call that is moved does not call bpf_vlog_reset() with the
pop_log=false parameter.

[1] https://lore.kernel.org/all/b6931bd0dd72327c55287862f821ca6c4c3eb69a.camel@gmail.com/
[2] https://lore.kernel.org/all/68497853.050a0220.33aa0e.036a.GAE@google.com/

Reported-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/all/b6931bd0dd72327c55287862f821ca6c4c3eb69a.camel@gmail.com/
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
---

Changes since v1:
- Move free_verifier_state() and pop_stack() into free_state() and
  remove err label in push_*() altogether (incl. comment), both
  suggested by Eduard
- Link to v1: https://lore.kernel.org/bpf/20250611211431.275731-1-luis.gerhorst@fau.de/

 kernel/bpf/verifier.c | 37 +++++++++++--------------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c378074516cf..5f4e0a8b20f8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2097,7 +2097,7 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
 
 	elem = kzalloc(sizeof(struct bpf_verifier_stack_elem), GFP_KERNEL);
 	if (!elem)
-		goto err;
+		return NULL;
 
 	elem->insn_idx = insn_idx;
 	elem->prev_insn_idx = prev_insn_idx;
@@ -2107,12 +2107,12 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
 	env->stack_size++;
 	err = copy_verifier_state(&elem->st, cur);
 	if (err)
-		goto err;
+		return NULL;
 	elem->st.speculative |= speculative;
 	if (env->stack_size > BPF_COMPLEXITY_LIMIT_JMP_SEQ) {
 		verbose(env, "The sequence of %d jumps is too complex.\n",
 			env->stack_size);
-		goto err;
+		return NULL;
 	}
 	if (elem->st.parent) {
 		++elem->st.parent->branches;
@@ -2127,12 +2127,6 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
 		 */
 	}
 	return &elem->st;
-err:
-	free_verifier_state(env->cur_state, true);
-	env->cur_state = NULL;
-	/* pop all elements and return */
-	while (!pop_stack(env, NULL, NULL, false));
-	return NULL;
 }
 
 #define CALLER_SAVED_REGS 6
@@ -2864,7 +2858,7 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 
 	elem = kzalloc(sizeof(struct bpf_verifier_stack_elem), GFP_KERNEL);
 	if (!elem)
-		goto err;
+		return NULL;
 
 	elem->insn_idx = insn_idx;
 	elem->prev_insn_idx = prev_insn_idx;
@@ -2876,7 +2870,7 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 		verbose(env,
 			"The sequence of %d jumps is too complex for async cb.\n",
 			env->stack_size);
-		goto err;
+		return NULL;
 	}
 	/* Unlike push_stack() do not copy_verifier_state().
 	 * The caller state doesn't matter.
@@ -2887,19 +2881,13 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 	elem->st.in_sleepable = is_sleepable;
 	frame = kzalloc(sizeof(*frame), GFP_KERNEL);
 	if (!frame)
-		goto err;
+		return NULL;
 	init_func_state(env, frame,
 			BPF_MAIN_FUNC /* callsite */,
 			0 /* frameno within this callchain */,
 			subprog /* subprog number within this prog */);
 	elem->st.frame[0] = frame;
 	return &elem->st;
-err:
-	free_verifier_state(env->cur_state, true);
-	env->cur_state = NULL;
-	/* pop all elements and return */
-	while (!pop_stack(env, NULL, NULL, false));
-	return NULL;
 }
 
 
@@ -22934,6 +22922,11 @@ static void free_states(struct bpf_verifier_env *env)
 	struct bpf_scc_info *info;
 	int i, j;
 
+	WARN_ON_ONCE(!env->cur_state);
+	free_verifier_state(env->cur_state, true);
+	env->cur_state = NULL;
+	while (!pop_stack(env, NULL, NULL, false));
+
 	list_for_each_safe(pos, tmp, &env->free_list) {
 		sl = container_of(pos, struct bpf_verifier_state_list, node);
 		free_verifier_state(&sl->state, false);
@@ -23085,14 +23078,6 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 
 	ret = do_check(env);
 out:
-	/* check for NULL is necessary, since cur_state can be freed inside
-	 * do_check() under memory pressure.
-	 */
-	if (env->cur_state) {
-		free_verifier_state(env->cur_state, true);
-		env->cur_state = NULL;
-	}
-	while (!pop_stack(env, NULL, NULL, false));
 	if (!ret && pop_log)
 		bpf_vlog_reset(&env->log, 0);
 	free_states(env);

base-commit: af91af33c16853c569ca814124781b849886f007
-- 
2.49.0



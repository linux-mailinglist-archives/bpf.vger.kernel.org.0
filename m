Return-Path: <bpf+bounces-67727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 549EFB495B3
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 18:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFF88340A8A
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 16:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C61C3126DD;
	Mon,  8 Sep 2025 16:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUuAZFHZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D7F3126BB
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349419; cv=none; b=nJD46tzbR+nWyzSQdMcXbI8yGM7Sve4DB2g3H9vQzVdQeg/2Cjdle3jhyervsz8dHvKtdYZ3yKtkyl1y46Ga4EDa8T4mb++gDZna0QsMUr1c6+OljPV5/8R6X/oIZjVSWictUoQHfeDXYZd/Am65j/N8Mq/RooYIddPqBPafm5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349419; c=relaxed/simple;
	bh=tPFaiGQ9ipeWwto9ATZu8Uzn2irEud1LM+TyKGxlZr8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SnBryT4XqxYIeJCsyhUBxpZG5xx3JNAx+rMyaMrBYH3kI5Fj1BA/xhfcdj5bTXIxMLFutgWlEw7tjDzA0jIsxUEhi2olQ87tiEv6phklLvKLpFdT8bTGyQg8Uphek8Kk4Pn4KvP82O+am6v6CGaqsM3ve4tk6xiEaNuOMz36zdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUuAZFHZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6973FC4CEF1;
	Mon,  8 Sep 2025 16:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757349419;
	bh=tPFaiGQ9ipeWwto9ATZu8Uzn2irEud1LM+TyKGxlZr8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CUuAZFHZL5LizZpeffzVC/STCP6ymphXoxlyNRBbCFVcnQdy1x1r33TZ+Ehymp4f3
	 BonlgvQLa+mgSe+Js4SMSgLD7fH6EGECr5wM5v6S5OXjpHygIRefxHMWu3hlwFWHcb
	 iNoZQ/Zx+UJZdM6hDKC2cJqo/e40Z+HEMyNo7st4AZv28Spwo0kWtb0PPJY/bO7rgD
	 2flOfqjoLGpnQWvveZVPUeTWyS7feGdTmwv5mcoIxU/sF3FeAIohZTGCiGm2wRfSfo
	 mjCNr2nGeMg9mjI3C/vzt8wVGd0Vdm0gQfoWQxHabWFEWSM5vTD6o5JMldVG0LKss6
	 NxbcnlaAsFoJg==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v6 2/5] bpf: core: introduce main_prog_aux for stream access
Date: Mon,  8 Sep 2025 16:36:31 +0000
Message-ID: <20250908163638.23150-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250908163638.23150-1-puranjay@kernel.org>
References: <20250908163638.23150-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF streams are only valid for the main programs, to make it easier to
access streams from subprogs, introduce main_prog_aux in struct
bpf_prog_aux.

prog->aux->main_prog_aux = prog->aux, for main programs and
prog->aux->main_prog_aux = main_prog->aux, for subprograms.

Make bpf_prog_find_from_stack() use the added main_prog_aux to return
the mainprog when a subprog is found on the stack.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 include/linux/bpf.h   | 1 +
 kernel/bpf/core.c     | 6 +++---
 kernel/bpf/verifier.c | 1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8f6e87f0f3a89..d133171c4d2a9 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1633,6 +1633,7 @@ struct bpf_prog_aux {
 	/* function name for valid attach_btf_id */
 	const char *attach_func_name;
 	struct bpf_prog **func;
+	struct bpf_prog_aux *main_prog_aux;
 	void *jit_data; /* JIT specific data. arch dependent */
 	struct bpf_jit_poke_descriptor *poke_tab;
 	struct bpf_kfunc_desc_tab *kfunc_tab;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ef01cc644a965..c732737e6b735 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -120,6 +120,7 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
 
 	fp->pages = size / PAGE_SIZE;
 	fp->aux = aux;
+	fp->aux->main_prog_aux = aux;
 	fp->aux->prog = fp;
 	fp->jit_requested = ebpf_jit_enabled();
 	fp->blinding_requested = bpf_jit_blinding_enabled(fp);
@@ -3292,9 +3293,8 @@ static bool find_from_stack_cb(void *cookie, u64 ip, u64 sp, u64 bp)
 	rcu_read_unlock();
 	if (!prog)
 		return true;
-	if (bpf_is_subprog(prog))
-		return true;
-	ctxp->prog = prog;
+	/* Make sure we return the main prog if we found a subprog */
+	ctxp->prog = prog->aux->main_prog_aux->prog;
 	return false;
 }
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b9394f8fac0ed..0162c5ad682ed 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21597,6 +21597,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->func_info_cnt = prog->aux->func_info_cnt;
 		func[i]->aux->poke_tab = prog->aux->poke_tab;
 		func[i]->aux->size_poke_tab = prog->aux->size_poke_tab;
+		func[i]->aux->main_prog_aux = prog->aux;
 
 		for (j = 0; j < prog->aux->size_poke_tab; j++) {
 			struct bpf_jit_poke_descriptor *poke;
-- 
2.47.3



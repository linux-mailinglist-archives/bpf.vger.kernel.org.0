Return-Path: <bpf+bounces-68145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CE2B536C2
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 17:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7BEF17F99F
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 14:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938F6212555;
	Thu, 11 Sep 2025 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zo6Jpj/o"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0DB34AB17
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 14:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757602704; cv=none; b=Ha5qo9vHirwH7bEpXp0oOwOvpp4hZD51WtgNPGQpbsl2dO+n4v9tVCTV6QOONNBxdIixLVDsGNiYzB9GTpbo/Ke8bweDR+HZsC3HyV932fijy/JoFMuGjJaedQOdEfoOj55O7ymxIzTBDylbnrEVIZj4gWi4mpHWwVx8MwEJZ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757602704; c=relaxed/simple;
	bh=Ba33aso6QC//d2zAo5Yt1tmrqM64zeYP+H7lRa6RhOs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gX9bD9QW/m0ltWWoO4cuwVhiDFhY6oB1nOVrQrnjUU7NEKSiqA4RBNmz7lT6e725vA/kC3jltAol3+NG0hjPHF02vQtYpsu2VRBJivhelu6n9LYZ9omEkDTXaEM8mPDEhPI+4kZmaOFV7aYQAB9crX6X6F2AWaH6AS1xn9uebrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zo6Jpj/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDC9C4CEF0;
	Thu, 11 Sep 2025 14:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757602703;
	bh=Ba33aso6QC//d2zAo5Yt1tmrqM64zeYP+H7lRa6RhOs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Zo6Jpj/o7Ns+XiFVrdgTaN80f8V1YzgGxRRALyS/JY686+WFA6RKu5vkxp1Ksb61k
	 9uyum6zwbo47Uq1OB0ybsYdVkJKZd6oLW+3Blw3J+xTsbe7DKREMIK/oDltki3Tvqq
	 VGm60dqWjJLwY/RZUuTUZWPuiBQuT52frFV9h2j21kuUX+D/j6oTYLZ7I08XG12mby
	 hSdbNMwuv3PKgwt4a64dLA0/1L3UlAhNC6uc+l9GkT4Mf4DrbIJVua60g9jNa4/ltT
	 UlLBwKh9gJQhgLftykQ2Z7s1TWvQNC9S/PeAJ3YPkWI8rwxcavk+p6bRzb171efyLV
	 P2DKlpME3Evmg==
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
Subject: [PATCH bpf-next v7 2/6] bpf: core: introduce main_prog_aux for stream access
Date: Thu, 11 Sep 2025 14:58:01 +0000
Message-ID: <20250911145808.58042-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250911145808.58042-1-puranjay@kernel.org>
References: <20250911145808.58042-1-puranjay@kernel.org>
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
index 8f6e87f0f3a8..d133171c4d2a 100644
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
index ef01cc644a96..c732737e6b73 100644
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
index b9394f8fac0e..0162c5ad682e 100644
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



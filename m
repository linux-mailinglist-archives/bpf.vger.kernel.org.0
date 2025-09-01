Return-Path: <bpf+bounces-67126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF01B3EE79
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 21:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 580F1483D5A
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 19:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D24A324B1D;
	Mon,  1 Sep 2025 19:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZB3BuZ1a"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0557117A2E6
	for <bpf@vger.kernel.org>; Mon,  1 Sep 2025 19:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756755469; cv=none; b=F7OgCGHx1bfGbv3Vz9euREgJKBiyfpvrynoxuTlDfhHA5g+O7sXEwYOW6Zt54eJKqAwroTCy7kelNH1qvXE4o5bXdYBVj+/rn5veIx7/P4HqH3IGbUivzZNeWGUVpTLs5HMm+sMLlVyIV2OUiWZIc5JCqdZ9hKdN1RZYV1XJ+S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756755469; c=relaxed/simple;
	bh=vyydX+AAhmGYlhE+T8Ygrq2j7ZLDQrMTp0yaukORRfM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ez8mG5bk4Hlo5MDTfbkVT6uTNrlieUrQhTrWWA6DjxsxqSAHIJbnrfSlwC7jPQa6Rrb0JYcTbf/ck1mIIV+RtGpE8t700EinIpCMflrzqdP2dvdrH+JYOGA6yXgfKk4pb5vGvlmQJQ+HJ68sO8+iWuAHoiL4FQKcjaHwe0YJbow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZB3BuZ1a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3365EC4CEF0;
	Mon,  1 Sep 2025 19:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756755468;
	bh=vyydX+AAhmGYlhE+T8Ygrq2j7ZLDQrMTp0yaukORRfM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZB3BuZ1aBTf6WdqVhkCF6thI9oQiVc8RmVNaDlcJWqshEu8yTQjJ5gJzP1xUYhSYF
	 LmpBYU+GarVTgQqWQKyB/iVuscd1YW8EonJxe53guQn82vACJ/DdS3FlcXap1t+R9P
	 Vu8iA/GNzIfR4Z1biXeE80xiFPw4wIHDBufjMW7Xaj8iVfyIWbMLA8mwOMfmTxbeYH
	 EYUkt1930RBPPU/BQuli5diUVNa2zZNzabgBGiEvjBWxc+AOhkU9lRpMkVJBkTXbtp
	 hrEsMFo47QAh7NTuTFI6kDed0SEaHcun/z2cCBg839WZfMJLCJ8p9scwHpZFzg5Tzi
	 SU+IfrBiG6blA==
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
Subject: [PATCH bpf-next v5 2/4] bpf: core: introduce main_prog_aux for stream access
Date: Mon,  1 Sep 2025 19:37:24 +0000
Message-ID: <20250901193730.43543-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250901193730.43543-1-puranjay@kernel.org>
References: <20250901193730.43543-1-puranjay@kernel.org>
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

This makes it easy to access streams like:
stream = bpf_stream_get(stream_id, prog->main_prog_aux);

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 include/linux/bpf.h   | 1 +
 kernel/bpf/core.c     | 3 +--
 kernel/bpf/stream.c   | 6 +++---
 kernel/bpf/verifier.c | 1 +
 4 files changed, 6 insertions(+), 5 deletions(-)

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
index ef01cc644a965..dbbf8e4b6e4c2 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -120,6 +120,7 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
 
 	fp->pages = size / PAGE_SIZE;
 	fp->aux = aux;
+	fp->aux->main_prog_aux = aux;
 	fp->aux->prog = fp;
 	fp->jit_requested = ebpf_jit_enabled();
 	fp->blinding_requested = bpf_jit_blinding_enabled(fp);
@@ -3292,8 +3293,6 @@ static bool find_from_stack_cb(void *cookie, u64 ip, u64 sp, u64 bp)
 	rcu_read_unlock();
 	if (!prog)
 		return true;
-	if (bpf_is_subprog(prog))
-		return true;
 	ctxp->prog = prog;
 	return false;
 }
diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index ab592db4a4bf6..a36dee4a95d59 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -343,7 +343,7 @@ int bpf_prog_stream_read(struct bpf_prog *prog, enum bpf_stream_id stream_id, vo
 {
 	struct bpf_stream *stream;
 
-	stream = bpf_stream_get(stream_id, prog->aux);
+	stream = bpf_stream_get(stream_id, prog->aux->main_prog_aux);
 	if (!stream)
 		return -ENOENT;
 	return bpf_stream_read(stream, buf, len);
@@ -367,7 +367,7 @@ __bpf_kfunc int bpf_stream_vprintk(int stream_id, const char *fmt__str, const vo
 	u32 data_len = len__sz;
 	int ret, num_args;
 
-	stream = bpf_stream_get(stream_id, aux);
+	stream = bpf_stream_get(stream_id, aux->main_prog_aux);
 	if (!stream)
 		return -ENOENT;
 
@@ -457,7 +457,7 @@ int bpf_stream_stage_commit(struct bpf_stream_stage *ss, struct bpf_prog *prog,
 	struct bpf_stream *stream;
 	int ret;
 
-	stream = bpf_stream_get(stream_id, prog->aux);
+	stream = bpf_stream_get(stream_id, prog->aux->main_prog_aux);
 	if (!stream)
 		return -EINVAL;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5c9dd16b2c56b..fa110656099c4 100644
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



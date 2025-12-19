Return-Path: <bpf+bounces-77197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE71CD175E
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 19:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16525301DE2E
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 18:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD622BEFE3;
	Fri, 19 Dec 2025 18:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVE9d3vQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F2C34AAE2
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 18:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766169919; cv=none; b=dwCzo8RNvK/QWi+b71nPmGRmPgojo9huOQDNIyDHf02CfUy7WrX3RB1t6MckLZfnLkh6WK9BeUkwSJood1rWqZ3dshtIFC95zCGHoBDMYlfVeg1uoyHwNzQg2VRIepsMsAbknOcxfvO2rz74MvyU/J7ZowhfSz0km9TK9zq5Soo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766169919; c=relaxed/simple;
	bh=0JaE8pvqqdiKhvz4LZK6ONzKwPuiNY6tUt4e8f/EZrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=izxnCAUzdj6nQKSw2LZ10+v9KP2qLCeb3eLGv4HMbbD7A9opKlmn6YQTrW9+Cr5u287kI3ZV31+nRq3U7hbkjxEBKRdkaJjNAckomM/Y61mB675iMZkZSH7eafSxGJy/CWs1sE+HRVhvdFdIoAam+D6p7q/a5Ldr2rzf+cqh/8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVE9d3vQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB2CC16AAE;
	Fri, 19 Dec 2025 18:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766169918;
	bh=0JaE8pvqqdiKhvz4LZK6ONzKwPuiNY6tUt4e8f/EZrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DVE9d3vQj4W4nzVp1Q6Xy3tYBaTcAwctf7q6Nxnw2KfjxwCglcoFBSjMW3L5Qut5Z
	 +Y+mOwCrXfiiO9H9soGIMP+Ms+mBzmP5sVSCOU3Z3hNHuRytuP0CIO4wCsq7L9LrYs
	 47Am1CfIRTsmtBf3MoImISrb1tDlUsI/lQBhzkMcvlv7mGC80wVNwYgKM8ujE5aPzY
	 426pTd1ebyl6jhQkx20na76mbMIzdCKG6RiZwqBEqGDCYmBhYH/Nkm66ohfvHPR/JO
	 oqyJSbx0BbJ8lNHDh/CjIYLXAXS2IJw2o/GRI5YLLo8s/XDYl94aJO9ZR18Zg7xn4B
	 1DnFkWelhywvw==
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
	kernel-team@meta.com,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v3 1/2] bpf: move recursion detection logic to helpers
Date: Fri, 19 Dec 2025 10:44:17 -0800
Message-ID: <20251219184422.2899902-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251219184422.2899902-1-puranjay@kernel.org>
References: <20251219184422.2899902-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF programs detect recursion by doing atomic inc/dec on a per-cpu
active counter from the trampoline. Create two helpers for operations on
this active counter, this makes it easy to changes the recursion
detection logic in future.

This commit makes no functional changes.

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 include/linux/bpf.h      | 10 ++++++++++
 kernel/bpf/trampoline.c  |  8 ++++----
 kernel/trace/bpf_trace.c |  4 ++--
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index bb3847caeae1..2da986136d26 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2004,6 +2004,16 @@ struct bpf_struct_ops_common_value {
 	enum bpf_struct_ops_state state;
 };
 
+static inline bool bpf_prog_get_recursion_context(struct bpf_prog *prog)
+{
+	return this_cpu_inc_return(*(prog->active)) == 1;
+}
+
+static inline void bpf_prog_put_recursion_context(struct bpf_prog *prog)
+{
+	this_cpu_dec(*(prog->active));
+}
+
 #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
 /* This macro helps developer to register a struct_ops type and generate
  * type information correctly. Developers should use this macro to register
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 976d89011b15..2a125d063e62 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -949,7 +949,7 @@ static u64 notrace __bpf_prog_enter_recur(struct bpf_prog *prog, struct bpf_tram
 
 	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
 
-	if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
+	if (unlikely(!bpf_prog_get_recursion_context(prog))) {
 		bpf_prog_inc_misses_counter(prog);
 		if (prog->aux->recursion_detected)
 			prog->aux->recursion_detected(prog);
@@ -993,7 +993,7 @@ static void notrace __bpf_prog_exit_recur(struct bpf_prog *prog, u64 start,
 	bpf_reset_run_ctx(run_ctx->saved_run_ctx);
 
 	update_prog_stats(prog, start);
-	this_cpu_dec(*(prog->active));
+	bpf_prog_put_recursion_context(prog);
 	rcu_read_unlock_migrate();
 }
 
@@ -1029,7 +1029,7 @@ u64 notrace __bpf_prog_enter_sleepable_recur(struct bpf_prog *prog,
 
 	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
 
-	if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
+	if (unlikely(!bpf_prog_get_recursion_context(prog))) {
 		bpf_prog_inc_misses_counter(prog);
 		if (prog->aux->recursion_detected)
 			prog->aux->recursion_detected(prog);
@@ -1044,7 +1044,7 @@ void notrace __bpf_prog_exit_sleepable_recur(struct bpf_prog *prog, u64 start,
 	bpf_reset_run_ctx(run_ctx->saved_run_ctx);
 
 	update_prog_stats(prog, start);
-	this_cpu_dec(*(prog->active));
+	bpf_prog_put_recursion_context(prog);
 	migrate_enable();
 	rcu_read_unlock_trace();
 }
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index fe28d86f7c35..6e076485bf70 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2063,7 +2063,7 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
 	struct bpf_trace_run_ctx run_ctx;
 
 	cant_sleep();
-	if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
+	if (unlikely(!bpf_prog_get_recursion_context(prog))) {
 		bpf_prog_inc_misses_counter(prog);
 		goto out;
 	}
@@ -2077,7 +2077,7 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
 
 	bpf_reset_run_ctx(old_run_ctx);
 out:
-	this_cpu_dec(*(prog->active));
+	bpf_prog_put_recursion_context(prog);
 }
 
 #define UNPACK(...)			__VA_ARGS__
-- 
2.47.3



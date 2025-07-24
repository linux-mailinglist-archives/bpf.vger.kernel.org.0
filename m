Return-Path: <bpf+bounces-64250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AD4B109E0
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 14:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBD4E1CE3ED8
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 12:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395DA26A1B8;
	Thu, 24 Jul 2025 12:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3TqeyNw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35012BEC23
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 12:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753358585; cv=none; b=om3lbJ8Fk5g6NbQ2GU5vNcV/NNydqhDbY8yzjE7LmWi+P2sPM4FOg33Is0pD5d222WX/hga3S0Kg604fZ2NXwMMYie8YyZTDvt8SHExwAUtuYSY0Pn+ZnFh+FtQddmIZclMH8O1zYNOzZSCwHoWWDDYvrFiUAc6ITiAvAigYL/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753358585; c=relaxed/simple;
	bh=aHfC93qy7+R/kbmVF9yv9BFePJp8OHBw/MCIT6p+9sI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHrBaxmD+FKApgMCNURT2Ny4go8OIR6xGYyvDO5KOnLESdi/MGLEDQwtHKG8m9bf1ijd5EYg6e+camB/rJVinc73K6nifjuu+iDBv6qkr1kozR+7BwEb4yUGXnsMKozgMtZaE6PC9yAVE15j+pqvkXVbTi78oK/GdQYi69KeqxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3TqeyNw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E59C4CEED;
	Thu, 24 Jul 2025 12:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753358585;
	bh=aHfC93qy7+R/kbmVF9yv9BFePJp8OHBw/MCIT6p+9sI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=H3TqeyNweKBLCIIzyJ87lWNwYzk4vbofUIAOCGfLC5F0Ovx+CQw2zjUetk03CN7bX
	 jyUK3IgHhpCAEtq8n8Gno5mrv9RNKqdXIh0udeqsOUd4Uy3q1HNba6q9Krh/8gXeIH
	 X5wVCphQhAd2+QWOSjef4TWtxJAGo5SAkZccU+3DTsBdjn4nc5KnCBcntYqMT5NRf1
	 /Hulzr9ditsPtUvjPqAOkXTuXBDB2ZNrYGTkNTCa7g8I7RC6MYEybu8/lnMZs7yIND
	 FOBq3jWItryGq3zJ1/syj5rHL3rxO3JXo7n0S8o3vuoVHTIl8miIDOF6C+IS+YFmC3
	 xUhzM+csnHMHw==
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
	Mykola Lysenko <mykolal@fb.com>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 1/3] bpf: move bpf_jit_get_prog_name() to core.c
Date: Thu, 24 Jul 2025 12:02:53 +0000
Message-ID: <20250724120257.7299-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250724120257.7299-1-puranjay@kernel.org>
References: <20250724120257.7299-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_jit_get_prog_name() will be used by all JITs when enabling support
for private stack. This function is currently implemented in the x86
JIT.

Move the function to core.c so that other JITs can easily use it in
their implementation of private stack.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 9 +--------
 include/linux/filter.h      | 2 ++
 kernel/bpf/core.c           | 7 +++++++
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 40e1b3b9634fe..7e3fca1646203 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3501,13 +3501,6 @@ int arch_prepare_bpf_dispatcher(void *image, void *buf, s64 *funcs, int num_func
 	return emit_bpf_dispatcher(&prog, 0, num_funcs - 1, funcs, image, buf);
 }
 
-static const char *bpf_get_prog_name(struct bpf_prog *prog)
-{
-	if (prog->aux->ksym.prog)
-		return prog->aux->ksym.name;
-	return prog->aux->name;
-}
-
 static void priv_stack_init_guard(void __percpu *priv_stack_ptr, int alloc_size)
 {
 	int cpu, underflow_idx = (alloc_size - PRIV_STACK_GUARD_SZ) >> 3;
@@ -3531,7 +3524,7 @@ static void priv_stack_check_guard(void __percpu *priv_stack_ptr, int alloc_size
 		if (stack_ptr[0] != PRIV_STACK_GUARD_VAL ||
 		    stack_ptr[underflow_idx] != PRIV_STACK_GUARD_VAL) {
 			pr_err("BPF private stack overflow/underflow detected for prog %sx\n",
-			       bpf_get_prog_name(prog));
+			       bpf_jit_get_prog_name(prog));
 			break;
 		}
 	}
diff --git a/include/linux/filter.h b/include/linux/filter.h
index eca229752cbef..5cc7a82ec8322 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1278,6 +1278,8 @@ int bpf_jit_get_func_addr(const struct bpf_prog *prog,
 			  const struct bpf_insn *insn, bool extra_pass,
 			  u64 *func_addr, bool *func_addr_fixed);
 
+const char *bpf_jit_get_prog_name(struct bpf_prog *prog);
+
 struct bpf_prog *bpf_jit_blind_constants(struct bpf_prog *fp);
 void bpf_jit_prog_release_other(struct bpf_prog *fp, struct bpf_prog *fp_other);
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 61613785bdd0f..29c0225c14aa9 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1297,6 +1297,13 @@ int bpf_jit_get_func_addr(const struct bpf_prog *prog,
 	return 0;
 }
 
+const char *bpf_jit_get_prog_name(struct bpf_prog *prog)
+{
+	if (prog->aux->ksym.prog)
+		return prog->aux->ksym.name;
+	return prog->aux->name;
+}
+
 static int bpf_jit_blind_insn(const struct bpf_insn *from,
 			      const struct bpf_insn *aux,
 			      struct bpf_insn *to_buff,
-- 
2.47.3



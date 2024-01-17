Return-Path: <bpf+bounces-19763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D6B830F3B
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 23:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81C08B24575
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 22:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0661E87E;
	Wed, 17 Jan 2024 22:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxvHcP88"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383CE1E515
	for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 22:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705530836; cv=none; b=M1sd1VaTY3wubXnumGcqmdrqy5Wgin32B/kwnx57u6lmyzChwuIu9dMuMpz6PxXl5iKS4W5LI/+yUNjiemjzcpQUGTVUkCCZBdjUEBY1syLTdL2ThfURb1w839YA0TGtsVwFu2O3w5dULd9PaSityXaatK3jKwuVMF9ZIRpm+fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705530836; c=relaxed/simple;
	bh=XnDNqdOpo01Es/FXqfLWlfzXWRQYAckC3ojy2/oQiCs=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=J06Hnpqomdbrm1ze65t1HhElwF+I9dEXRNr3d08o8uRexUyOm3YauPZCOjBACuIAvJii3K7JDANG72O/rmSnxGHMSjwoKkk0eNd00zkmB6+M8eUY+Q98RwW8h7DhHoM+/dw4p4BSTz1zHb+nVnt66cQxAhNp4bPtMDvBNb4cOzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxvHcP88; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F073C433C7;
	Wed, 17 Jan 2024 22:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705530835;
	bh=XnDNqdOpo01Es/FXqfLWlfzXWRQYAckC3ojy2/oQiCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dxvHcP88fNJRmAieLS+EcC+y5FdPusgr3Pfne9ci54j6DVLIppUYkM+x7icTlr4Py
	 pSsJxcQ7IeCqD5FEMQy1uv78sKWuIOhOGFQiNb7OS6SCwwdS8lQL7sK460uLJ6ErN7
	 21jIfff6d9ZHvNsX+GqzhXAbglZY+oeU1b6w+RC31jRfhpPkzWmQwuMADpARuAzIyg
	 81KTnAVDUwDan+tAx04rH+ktqBWoccPSxcG9Vb/bGxRbQL2zC2Crwas+TA5oK1p4AA
	 HFRAGOKOKZ12FGOqdqbdb0Q97IzmO+ADjkfoP/INUUy7MAhL68dQqmyZW+QFjhc+gW
	 1PRsAHhS7b2QA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf 4/5] selftests/bpf: add tests confirming type logic in kernel for __arg_ctx
Date: Wed, 17 Jan 2024 14:33:39 -0800
Message-Id: <20240117223340.1733595-5-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117223340.1733595-1-andrii@kernel.org>
References: <20240117223340.1733595-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a bunch of global subprogs across variety of program types to
validate expected kernel type enforcement logic for __arg_ctx arguments.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/progs/verifier_global_subprogs.c      | 164 +++++++++++++++++-
 1 file changed, 161 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
index 9eeb2d89cda8..67dddd941891 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
@@ -3,6 +3,7 @@
 
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
 #include "bpf_misc.h"
 #include "xdp_metadata.h"
 #include "bpf_kfuncs.h"
@@ -138,25 +139,182 @@ __weak int subprog_ctx_tag(void *ctx __arg_ctx)
 	return bpf_get_stack(ctx, stack, sizeof(stack), 0);
 }
 
+__weak int raw_tp_canonical(struct bpf_raw_tracepoint_args *ctx __arg_ctx)
+{
+	return 0;
+}
+
+__weak int raw_tp_u64_array(u64 *ctx __arg_ctx)
+{
+	return 0;
+}
+
 SEC("?raw_tp")
 __success __log_level(2)
 int arg_tag_ctx_raw_tp(void *ctx)
 {
-	return subprog_ctx_tag(ctx);
+	return subprog_ctx_tag(ctx) + raw_tp_canonical(ctx) + raw_tp_u64_array(ctx);
+}
+
+SEC("?raw_tp.w")
+__success __log_level(2)
+int arg_tag_ctx_raw_tp_writable(void *ctx)
+{
+	return subprog_ctx_tag(ctx) + raw_tp_canonical(ctx) + raw_tp_u64_array(ctx);
+}
+
+SEC("?tp_btf/sys_enter")
+__success __log_level(2)
+int arg_tag_ctx_raw_tp_btf(void *ctx)
+{
+	return subprog_ctx_tag(ctx) + raw_tp_canonical(ctx) + raw_tp_u64_array(ctx);
+}
+
+struct whatever { };
+
+__weak int tp_whatever(struct whatever *ctx __arg_ctx)
+{
+	return 0;
 }
 
 SEC("?tp")
 __success __log_level(2)
 int arg_tag_ctx_tp(void *ctx)
 {
-	return subprog_ctx_tag(ctx);
+	return subprog_ctx_tag(ctx) + tp_whatever(ctx);
+}
+
+__weak int kprobe_subprog_pt_regs(struct pt_regs *ctx __arg_ctx)
+{
+	return 0;
+}
+
+__weak int kprobe_subprog_typedef(bpf_user_pt_regs_t *ctx __arg_ctx)
+{
+	return 0;
 }
 
 SEC("?kprobe")
 __success __log_level(2)
 int arg_tag_ctx_kprobe(void *ctx)
 {
-	return subprog_ctx_tag(ctx);
+	return subprog_ctx_tag(ctx) +
+	       kprobe_subprog_pt_regs(ctx) +
+	       kprobe_subprog_typedef(ctx);
+}
+
+__weak int perf_subprog_regs(
+#if defined(bpf_target_riscv)
+	struct user_regs_struct *ctx __arg_ctx
+#elif defined(bpf_target_s390)
+	/* user_pt_regs typedef is anonymous struct, so only `void *` works */
+	void *ctx __arg_ctx
+#elif defined(bpf_target_loongarch) || defined(bpf_target_arm64) || defined(bpf_target_powerpc)
+	struct user_pt_regs *ctx __arg_ctx
+#else
+	struct pt_regs *ctx __arg_ctx
+#endif
+)
+{
+	return 0;
+}
+
+__weak int perf_subprog_typedef(bpf_user_pt_regs_t *ctx __arg_ctx)
+{
+	return 0;
+}
+
+__weak int perf_subprog_canonical(struct bpf_perf_event_data *ctx __arg_ctx)
+{
+	return 0;
+}
+
+SEC("?perf_event")
+__success __log_level(2)
+int arg_tag_ctx_perf(void *ctx)
+{
+	return subprog_ctx_tag(ctx) +
+	       perf_subprog_regs(ctx) +
+	       perf_subprog_typedef(ctx) +
+	       perf_subprog_canonical(ctx);
+}
+
+__weak int iter_subprog_void(void *ctx __arg_ctx)
+{
+	return 0;
+}
+
+__weak int iter_subprog_typed(struct bpf_iter__task *ctx __arg_ctx)
+{
+	return 0;
+}
+
+SEC("?iter/task")
+__success __log_level(2)
+int arg_tag_ctx_iter_task(struct bpf_iter__task *ctx)
+{
+	return (iter_subprog_void(ctx) + iter_subprog_typed(ctx)) & 1;
+}
+
+__weak int tracing_subprog_void(void *ctx __arg_ctx)
+{
+	return 0;
+}
+
+__weak int tracing_subprog_u64(u64 *ctx __arg_ctx)
+{
+	return 0;
+}
+
+int acc;
+
+SEC("?fentry/" SYS_PREFIX "sys_nanosleep")
+__success __log_level(2)
+int BPF_PROG(arg_tag_ctx_fentry)
+{
+	acc += tracing_subprog_void(ctx) + tracing_subprog_u64(ctx);
+	return 0;
+}
+
+SEC("?fexit/" SYS_PREFIX "sys_nanosleep")
+__success __log_level(2)
+int BPF_PROG(arg_tag_ctx_fexit)
+{
+	acc += tracing_subprog_void(ctx) + tracing_subprog_u64(ctx);
+	return 0;
+}
+
+SEC("?fmod_ret/" SYS_PREFIX "sys_nanosleep")
+__success __log_level(2)
+int BPF_PROG(arg_tag_ctx_fmod_ret)
+{
+	return tracing_subprog_void(ctx) + tracing_subprog_u64(ctx);
+}
+
+SEC("?lsm/bpf")
+__success __log_level(2)
+int BPF_PROG(arg_tag_ctx_lsm)
+{
+	return tracing_subprog_void(ctx) + tracing_subprog_u64(ctx);
+}
+
+SEC("?struct_ops/test_1")
+__success __log_level(2)
+int BPF_PROG(arg_tag_ctx_struct_ops)
+{
+	return tracing_subprog_void(ctx) + tracing_subprog_u64(ctx);
+}
+
+SEC(".struct_ops")
+struct bpf_dummy_ops dummy_1 = {
+	.test_1 = (void *)arg_tag_ctx_struct_ops,
+};
+
+SEC("?syscall")
+__success __log_level(2)
+int arg_tag_ctx_syscall(void *ctx)
+{
+	return tracing_subprog_void(ctx) + tracing_subprog_u64(ctx) + tp_whatever(ctx);
 }
 
 __weak int subprog_dynptr(struct bpf_dynptr *dptr)
-- 
2.34.1



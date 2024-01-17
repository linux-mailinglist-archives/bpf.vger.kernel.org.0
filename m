Return-Path: <bpf+bounces-19747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9706830D7C
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 20:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52DF92881F3
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 19:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBBC24A0E;
	Wed, 17 Jan 2024 19:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Am+asXQA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0591C24A00
	for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 19:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705521147; cv=none; b=NInN2yjXAX0ztC4/h9H0/FNaLtTMpwOiteJOLT8uuL5wFSiagFBMxrxvkH2RpQ4jvtD5PXdVN4QSmM2jtWAJzY7sXK969EcIg4GiQgnBbfPenymNS5VeiEIuMGPbbgnaANmmZrbMeFZCpvhd4b1IJ+Hx3qb4XaPRNUSejzX8oTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705521147; c=relaxed/simple;
	bh=XnDNqdOpo01Es/FXqfLWlfzXWRQYAckC3ojy2/oQiCs=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=FerKpGKsYdHeMS5AM1yW2JXsFIVUAVLFi2iPAWzCToj/6oqbsecY9MdRJson0wRKegTBnt9nk0Wz/h+7cOuZDasZMcI+MQybyDHkHrkRghPGlwOrm9tvWfjQGN6bUQicj91TEqyEZenUrR36dwB7zhtnZllwgdLvHIuB8Ng17Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Am+asXQA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F533C433F1;
	Wed, 17 Jan 2024 19:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705521146;
	bh=XnDNqdOpo01Es/FXqfLWlfzXWRQYAckC3ojy2/oQiCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Am+asXQAofl2OwkBUPdDTdPVfYLbJ4626ZweBb8PAZc0q/nMIK+2rQ8Tn3r8beo/5
	 DCLU7AHk0tu5ugo5feDdboMvdy6K4sKRWuI7h58BU6D0Hp/Zchn21l22uVosqYDQ41
	 x/+626YDz3/CEBN/9S3bPBcV4bGvbHPk+dKxR0NKVxQcO4Tg2Se+Hs96CAxqPuhhfk
	 8GnFWQNWnlcv0tXIJvZMWAjL/2VyQpHpN54DSAHRIHbbFbKyBBDfVUJsrqb2OOpAJq
	 sCSaA5Wus1EFIJhbTcxv2yugBE/X6iJkZhIPCT4n0+QRpmgYh3nKuiluCGnb8Wobj0
	 ZOnFVd0+JUA5g==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf 4/5] selftests/bpf: add tests confirming type logic in kernel for __arg_ctx
Date: Wed, 17 Jan 2024 11:52:09 -0800
Message-Id: <20240117195210.739597-5-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117195210.739597-1-andrii@kernel.org>
References: <20240117195210.739597-1-andrii@kernel.org>
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



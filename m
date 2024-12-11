Return-Path: <bpf+bounces-46632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC399ECD56
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 14:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C556D188BB96
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 13:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D2B236905;
	Wed, 11 Dec 2024 13:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oN9LtIBB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D540F230274;
	Wed, 11 Dec 2024 13:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733924126; cv=none; b=D5JgKih1/Ctly7ihUYoAhDcZFa81Yx40OPeyqoPUNWtsZ/pT6yHiA1TCxMZWJ7TV9DqxpUNeayssBTfh7SKq7Q4FBebvll61ZKqKgbdrpWFh3w/F+hSPNidYAlA2HlRNYS4IF3P5ZCqGmimRrZFVfJ9YH9S3eyT3IxZpkzmY50Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733924126; c=relaxed/simple;
	bh=WwECUbWo0u9vUSB6TwXrs4yLoqM7oB5o5WuTwDjNBCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ejm07EjOchjhtxELFsiWL4mLRdrWXIbFk2TFSFkZuaMqGvmC4vORA4YtPiXHvadvBvwXEvTyQNA85r59GlZnx1JCoME6aaHRhdjMfyAmCxe+u3OM2UK2QL6E1LVKxXxC2GOTujg3FS1fFl2II9oBVpF1+my6yVrUiS8ZGl2WJ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oN9LtIBB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16232C4CED2;
	Wed, 11 Dec 2024 13:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733924125;
	bh=WwECUbWo0u9vUSB6TwXrs4yLoqM7oB5o5WuTwDjNBCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oN9LtIBB7sI/Ztd1K3UWLmFr54pgxIjnHUTVhCuyStuHxcB2q8BkukGzzAh4PgD+Q
	 ta9xVoyWxYaFly9qszDgn1pIEWRtXczcTohOYJ3rI/eZVDwLpXHyl7rjjWnmXgNVWI
	 DE1+0cWyeGtGuZoY/ocEHPZ/mifLhja8bv3oahCjYDpdvooMd8UVLxD+od44gM3fsf
	 RDfAelrothI0JQwMCsotYON3+8aDzPYJQ0Vor5o2cugtCX0fxoZHZTKK8hf4gue0ho
	 s/WAFNj5xlVykkriiqLhVCu19hQwPEa8+T9v370YrMDHMa2Xa8Qm061QNunaPxqD90
	 PO7Fp5UBLuwzQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next 07/13] uprobes/x86: Add support to emulate nop5 instruction
Date: Wed, 11 Dec 2024 14:33:56 +0100
Message-ID: <20241211133403.208920-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241211133403.208920-1-jolsa@kernel.org>
References: <20241211133403.208920-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adding support to emulate nop5 as the original uprobe instruction.

This speeds up uprobes on top of nop5 instructions:
(results from benchs/run_bench_uprobes.sh)

current:

     uprobe-nop     :    3.252 ± 0.019M/s
     uprobe-push    :    3.097 ± 0.002M/s
     uprobe-ret     :    1.116 ± 0.001M/s
 --> uprobe-nop5    :    1.115 ± 0.001M/s
     uretprobe-nop  :    1.731 ± 0.016M/s
     uretprobe-push :    1.673 ± 0.023M/s
     uretprobe-ret  :    0.843 ± 0.009M/s
 --> uretprobe-nop5 :    1.124 ± 0.001M/s

after the change:

     uprobe-nop     :    3.281 ± 0.003M/s
     uprobe-push    :    3.085 ± 0.003M/s
     uprobe-ret     :    1.130 ± 0.000M/s
 --> uprobe-nop5    :    3.276 ± 0.007M/s
     uretprobe-nop  :    1.716 ± 0.016M/s
     uretprobe-push :    1.651 ± 0.017M/s
     uretprobe-ret  :    0.846 ± 0.006M/s
 --> uretprobe-nop5 :    3.279 ± 0.002M/s

Strangely I can see uretprobe-nop5 is now much faster compared to
uretprobe-nop, while perf profiles for both are almost identical.
I'm still checking on that.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/kernel/uprobes.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 23e4f2821cff..cdea97f8cd39 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -909,6 +909,11 @@ static const struct uprobe_xol_ops push_xol_ops = {
 	.emulate  = push_emulate_op,
 };
 
+static int is_nop5_insn(uprobe_opcode_t *insn)
+{
+	return !memcmp(insn, x86_nops[5], 5);
+}
+
 /* Returns -ENOSYS if branch_xol_ops doesn't handle this insn */
 static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
 {
@@ -928,6 +933,8 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
 		break;
 
 	case 0x0f:
+		if (is_nop5_insn((uprobe_opcode_t *) &auprobe->insn))
+			goto setup;
 		if (insn->opcode.nbytes != 2)
 			return -ENOSYS;
 		/*
-- 
2.47.0



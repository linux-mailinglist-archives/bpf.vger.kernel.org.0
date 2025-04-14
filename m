Return-Path: <bpf+bounces-55842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448B2A87A87
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 10:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B3307A5A12
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 08:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5DD259CA8;
	Mon, 14 Apr 2025 08:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skmOBIv4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E8A1CD2C;
	Mon, 14 Apr 2025 08:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744619816; cv=none; b=W0+qTh4+NBQoXxFE7Whta1QTy+H/a8buOdxDcTyna/xbjFRz+We28lMnTsrE1xq33latyOTVWtdu60JOhOZ/wf4PGJ7WdO6F7dYOiHnPXPprZTLEB+fsxin6FIyoovKkIWxHX3JPH5u8d+7zT84pGEvucXgF1gSGD6xHmwr/MWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744619816; c=relaxed/simple;
	bh=A7FGAmdKF46W5Or2Z8OOuOUQ7edsr7AAwxaxc53q8OY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EYghW9/cP3kKSN9xv2XRfPigcMNCRMPktuO0DzsOYnOj1w2JQdJrcURqUpadD3KSrncqw4LllvHv55XClBjBvuPmGO1DSRO26Q8HmLEUojksiJF73HbyH4QeNQz54VJMcfAmQCehaH/D1+Z9eAKUg5utjs1r1eS/Eue+SmDzIgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skmOBIv4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B22C4CEE2;
	Mon, 14 Apr 2025 08:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744619816;
	bh=A7FGAmdKF46W5Or2Z8OOuOUQ7edsr7AAwxaxc53q8OY=;
	h=From:To:Cc:Subject:Date:From;
	b=skmOBIv4CMfxp0onQVhhNZRDG42vD2GpKXPVKqWr6beF/ovP8inP9mbfMm3AEQsf1
	 hPsjaxu6AWNOjRdCh2Ree3baR6kUfiMtXpW6FZuw+1xkk9/EUHzniWTGtv7M1OYiHr
	 jV5ZSmCeoWsPT+AW8p56YaLRv1rXDAi1zKfcuAghvlMJ09vqVp2jyO9s51zLw0UX7o
	 Pmhi2V7fD0KNmIjVjeyFEeZqZgMarTV/CPxO1WE9ysyvw7atwueYcVo0nrt/yzyD8C
	 VQk+YoVKuRt7cGrmeC9zcgeG4FVmjkt6xWprjRulTCOYVEgezLkMLDua9szH2s4xqd
	 jNj6DRr1wkTfw==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCHv3 perf/core 1/2] uprobes/x86: Add support to emulate nop instructions
Date: Mon, 14 Apr 2025 10:36:46 +0200
Message-ID: <20250414083647.1234007-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support to emulate all nop instructions as the original uprobe
instruction.

This change speeds up uprobe on top of all nop instructions and is a
preparation for usdt probe optimization, that will be done on top of
nop5 instruction.

With this change the usdt probe on top of nop5 won't take the performance
hit compared to usdt probe on top of standard nop instruction.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
v3 changes:
 - use insn->length as index to x86_nops [Andrii]

 arch/x86/kernel/uprobes.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 9194695662b2..6d383839e839 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -840,6 +840,11 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
 	insn_byte_t p;
 	int i;
 
+	/* x86_nops[insn->length]; same as jmp with .offs = 0 */
+	if (insn->length <= ASM_NOP_MAX &&
+	    !memcmp(insn->kaddr, x86_nops[insn->length], insn->length))
+		goto setup;
+
 	switch (opc1) {
 	case 0xeb:	/* jmp 8 */
 	case 0xe9:	/* jmp 32 */
-- 
2.49.0



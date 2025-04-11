Return-Path: <bpf+bounces-55726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FA8A85CE1
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 14:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8EFA4A5639
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 12:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF14F29AB14;
	Fri, 11 Apr 2025 12:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPZJSolU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B61215171;
	Fri, 11 Apr 2025 12:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744373886; cv=none; b=SghSIglPpXVlBkh9jp73gosWFuMH6o+bcLLrdfPZieS7tlPDX7apgAzPrVWdhx21n+/uOSQ8i0zysDQVEuMKgn50f425bqBepyVufL/95zsSZWF82pxdx6LeHfIqmX4VO0wBPCgOzu68axS17WREXB6Cy6ir3Gwj8x7pp8UNNnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744373886; c=relaxed/simple;
	bh=dH7AAWDa+xz7kvgKmNUKXkT5xXxX2wU24nwi1bWLMqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oJWj6G9Wm3UTulXC1CVtjUUmlbnmK5VwFQX4bImJhTRrLiafkAkOk0OrY/u4A2zQN9qLQckiSqjAUXXWuxvyVLshQALsq2s75EWWUV0m8KYCNAzGudyDRvYpdZ1ZYT/Y7HrsyYg6pZeoaa7t8JjHlWeExk4yUW224nXmJonMewU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPZJSolU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F07C4CEE2;
	Fri, 11 Apr 2025 12:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744373885;
	bh=dH7AAWDa+xz7kvgKmNUKXkT5xXxX2wU24nwi1bWLMqE=;
	h=From:To:Cc:Subject:Date:From;
	b=mPZJSolUIVJWGAGYbzrq6l4MUM9L7k22UzQ8utQhDRRuPKo4eQC+FfoXVNqHs+M53
	 /5xSkzIewqKJDlJgh577tWRxXJZmPYpZKs387C+qOiBhD4VCFNScU2kQIkeoHorAn+
	 JU/MStqK198rUEQBZKU+YJ8+In2Cvz0ieXymS0LhBY0mXGXCHBLljqpPD9H6HfDBly
	 eWMcF7UOxJhp9aocmg6zeXL4cMnUarOTZG3dW8b8jJkhkw6cxnO5yoF4JItaYpVBhT
	 x2JKiHivfg4yRC+tz9430jyHNu9YCZOy0rqX7x8RLrDv8EVxajpC7oI/5jSrHsc+HH
	 1vDZJfuJTSkag==
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
Subject: [PATCHv2 perf/core 1/2] uprobes/x86: Add support to emulate nop instructions
Date: Fri, 11 Apr 2025 14:17:55 +0200
Message-ID: <20250411121756.567274-1-jolsa@kernel.org>
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
v2 changes:
- follow Adndrii/Oleg's suggestion and emulate all the nops

 arch/x86/kernel/uprobes.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 9194695662b2..262960189a1c 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -840,6 +840,12 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
 	insn_byte_t p;
 	int i;
 
+	/* x86_nops[i]; same as jmp with .offs = 0 */
+	for (i = 1; i <= ASM_NOP_MAX; ++i) {
+		if (!memcmp(insn->kaddr, x86_nops[i], i))
+			goto setup;
+	}
+
 	switch (opc1) {
 	case 0xeb:	/* jmp 8 */
 	case 0xe9:	/* jmp 32 */
-- 
2.49.0



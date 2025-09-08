Return-Path: <bpf+bounces-67706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6CEB48D0E
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 14:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 584B416CC49
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 12:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC6B2FD1B6;
	Mon,  8 Sep 2025 12:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1GOkfrj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D83AE552;
	Mon,  8 Sep 2025 12:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333623; cv=none; b=GqvO58TT/rodrLnt29O4HpdsraxtdoG8aADFZe4YvxAKTAVWKT2dTObiMbcfATd9LQ0Hdcsv29GhK15uoi0BaK6/Fkodbr0aqmUvEtkDqJZymW8bcFqiAF1+poMyqElaDqwgtfZvxRoJUIQg6oxQ2MCmR1LMf21c/mrEat6rhBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333623; c=relaxed/simple;
	bh=6o24WB91e3G+pc7ZE6bwHLiyBlIwSK5wzIAI8siJQn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMbHH3noXk5YmaqoWE4PwGLyPNFQPhx/bDyTWsasjsOrad+mWm0Wo8PGJkeq3/UZd+g7ZvwUnEkLcowZDY3Vskf1PS8iLdSQPLKZX0ycba7+tAw2rGl5V9CyHkyu5gTExOYF/w1nZi8BR6ot6eadxTZ7jackG6yG1amBclyKebk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1GOkfrj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA623C4CEF1;
	Mon,  8 Sep 2025 12:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757333623;
	bh=6o24WB91e3G+pc7ZE6bwHLiyBlIwSK5wzIAI8siJQn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I1GOkfrj/eb9ZfTIP652r8BhsUumox2CSBjpkL/Tyvj6Q/4WAZieEWfublTBNEGbc
	 oyMMkyYJNDquIM3CF2lwhqU2T3J5OKMFmmdFrf6RMDK5cBtGThPBlIE/mEtLHJ3Ray
	 fmGzcTpCiAwpPozG5BoA704YD0GKw7N+Pr41IJENMuG96Er8dXcSNaephQRN1Vwh8z
	 iqOrlcKY6MSbeP9hLeYJbRD4Hu42JoUYSxp2TCBn0rX+uYKXOrVl6JZ7COqDtMXJXQ
	 rFuQsGn6sCcEatNCnBFac3fSTR+4Rn2oCdNLjl06vprr9OzYtnTuwNj9IOE0DYA0PO
	 QVD8gwJiQxDxw==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
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
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCHv2 perf/core 2/4] uprobe: Do not emulate/sstep original instruction when ip is changed
Date: Mon,  8 Sep 2025 14:13:08 +0200
Message-ID: <20250908121310.46824-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908121310.46824-1-jolsa@kernel.org>
References: <20250908121310.46824-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If uprobe handler changes instruction pointer we still execute single
step) or emulate the original instruction and increment the (new) ip
with its length.

This makes the new instruction pointer bogus and application will
likely crash on illegal instruction execution.

If user decided to take execution elsewhere, it makes little sense
to execute the original instruction, so let's skip it.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/events/uprobes.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 996a81080d56..4f46018e507e 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2768,6 +2768,13 @@ static void handle_swbp(struct pt_regs *regs)
 	/* Try to optimize after first hit. */
 	arch_uprobe_optimize(&uprobe->arch, bp_vaddr);
 
+	/*
+	 * If user decided to take execution elsewhere, it makes little sense
+	 * to execute the original instruction, so let's skip it.
+	 */
+	if (instruction_pointer(regs) != bp_vaddr)
+		goto out;
+
 	if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
 		goto out;
 
-- 
2.51.0



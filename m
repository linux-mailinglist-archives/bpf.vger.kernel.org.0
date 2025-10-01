Return-Path: <bpf+bounces-70082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08798BB0801
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 15:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7A4F1C088A
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 13:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9242F0692;
	Wed,  1 Oct 2025 13:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGgJx34f"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DE32EDD58;
	Wed,  1 Oct 2025 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759325104; cv=none; b=LU3y02ba2y7OUPKqXUoBjeZVXkUFSw2aHBnQSKmET99CvSW++NobVbe0QsDuNXkHSGimc99bpZ/xcNNM5fGeqQGubXg4qVtWcw06wx/GtdSJLqvMkphXIngfoloJulf70c5yr03j33IXqF93f0qpoHZ1spr78pNvsgMZNrfjgTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759325104; c=relaxed/simple;
	bh=rYRmOvRAy3y6trXdNjOAD8/jcxxPvin79sxszfYgSHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SUHe1da9xROfNlChv2cur/KRWfpLd2Gzu+5O4sOw/1VKdkui+X0kmdsHQxED41lHvPibN/nFuJKiCxRv6XUwsiRnL9HZIQY0dT8T4nO4PkOKSTKLgKfPWdoRyU/2fmJma0Lkqpa5UcK/w7v4VrznEATm7NRRe2kNaBhK7erfyl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGgJx34f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F121C4CEF4;
	Wed,  1 Oct 2025 13:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759325103;
	bh=rYRmOvRAy3y6trXdNjOAD8/jcxxPvin79sxszfYgSHw=;
	h=From:To:Cc:Subject:Date:From;
	b=kGgJx34fBTBXASzijvpxyYx1/WPJYi5J1P/i77kiz0DWCgVgvPC3LnnXiOG0lKhaF
	 5I2g/cv7LsrLIlo9P+p4eQkA1+/Yq/fh3Gm4ODQ4lrXLmLaA/sC3lfR0YV858I6eTw
	 CA7QnbLV8C7/UhLBgq4uaEBie8bBEeZDolrA5KcYrcTsI7lyd9zsY8BdtEpA/q6wZc
	 myLF12gigeHJa99zvfGziMvkg7mVZmcnGArZZjBeVATZmZ5eEW9PHeL2LAGfAzHRQb
	 dnej4iBl1/ngejhmcjwunNdEEP52c42s7MknGPpDSVHq4oi/wNXEebiq1vd7af/pwu
	 MkoP1gnb/fz0g==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@ACULAB.COM>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>,
	Jann Horn <jannh@google.com>,
	Alejandro Colomar <alx@kernel.org>
Subject: [PATCH] uprobe: Move arch_uprobe_optimize right after handlers execution
Date: Wed,  1 Oct 2025 15:24:49 +0200
Message-ID: <20251001132449.178759-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's less confusing to optimize uprobe right after handlers execution
and before we do the check for changed ip register to avoid situations
where changed ip register would skip uprobe optimization.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/events/uprobes.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 5dcf927310fd..c14ec27b976d 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2765,6 +2765,9 @@ static void handle_swbp(struct pt_regs *regs)
 
 	handler_chain(uprobe, regs);
 
+	/* Try to optimize after first hit. */
+	arch_uprobe_optimize(&uprobe->arch, bp_vaddr);
+
 	/*
 	 * If user decided to take execution elsewhere, it makes little sense
 	 * to execute the original instruction, so let's skip it.
@@ -2772,9 +2775,6 @@ static void handle_swbp(struct pt_regs *regs)
 	if (instruction_pointer(regs) != bp_vaddr)
 		goto out;
 
-	/* Try to optimize after first hit. */
-	arch_uprobe_optimize(&uprobe->arch, bp_vaddr);
-
 	if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
 		goto out;
 
-- 
2.51.0



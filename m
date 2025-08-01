Return-Path: <bpf+bounces-64930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC25AB18875
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 23:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D9351C84E98
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 21:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79CA28C852;
	Fri,  1 Aug 2025 21:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m12/gnQl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3290A21A43D;
	Fri,  1 Aug 2025 21:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754082183; cv=none; b=fsbRtzOFZ0zW8+TvuRwvSWOFVAyw9B1UVe5DO8ZpBsiypV4qhCsQoY/79TjV08JVlXUdOGPiVLuqE6/NBUiDCjxeOokg0Tn/1bZZioonl3wTXDlekT92Kc17sOPAPZ9mCTXm/PHF7LiO7EhNugrux4MW83svZ++tkmj1w0tVqAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754082183; c=relaxed/simple;
	bh=6gU1IZuL/kDyaT7QNAaYwy8htPH0k5Z8X4DvAqLt6gE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c7H/UJF9gMUmOBIiLkCdHowOJdtBBpcHlpQXJNkvtkgWkcsrK/xbIdGUth5CuSKfSd3e278tQsWigbz6E67LjsW6+61Vp26qS+OK+tiKDX2HpUH9w0jewlcngKmqS+Om6Pq4TzFVnDL1tRbvXzKuKiTRWwcbUPOmoaQzR0HYElA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m12/gnQl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CDBC4CEE7;
	Fri,  1 Aug 2025 21:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754082182;
	bh=6gU1IZuL/kDyaT7QNAaYwy8htPH0k5Z8X4DvAqLt6gE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m12/gnQlNLhRByx83c2Pf+AV+GFWLPPrx7+PKFHTkKLtBnzFuF40nhWuD/+Qn51lY
	 fEbMuAe1XRridVdBCc5LaQBStXrKQjTCmNIiRjV8RfBw83yjdv9pmjpBp4BfFyzrhH
	 MNgiU4bNocWu+PUuo/KEzQCX1emr8yILG931IX11YgGMlVYEFjKzwHYGmx4scdw/No
	 1vPde+J+0CwdtcgUKbmdtgNP8/kCh+K2gtwq2ORy/JSGn9FTsRQ+wqI7emNHaF1KmO
	 EztEW/VDsch8lBGpg7vqykv5zTTDTAXf1SrdTUAA3Odgs4O8mTekiisSstR2WOnAA6
	 FkGYGfamYd7+Q==
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
Subject: [RFC 1/4] uprobe: Do not emulate/sstep original instruction when ip is changed
Date: Fri,  1 Aug 2025 23:02:35 +0200
Message-ID: <20250801210238.2207429-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250801210238.2207429-1-jolsa@kernel.org>
References: <20250801210238.2207429-1-jolsa@kernel.org>
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
 kernel/events/uprobes.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 4c965ba77f9f..dff5509cde67 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2742,6 +2742,9 @@ static void handle_swbp(struct pt_regs *regs)
 
 	handler_chain(uprobe, regs);
 
+	if (instruction_pointer(regs) != bp_vaddr)
+		goto out;
+
 	if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
 		goto out;
 
-- 
2.50.1



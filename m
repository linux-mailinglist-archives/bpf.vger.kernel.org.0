Return-Path: <bpf+bounces-41623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B5399936B
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 22:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7E05282CE7
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 20:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE081E0098;
	Thu, 10 Oct 2024 20:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcbR/dW3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186A61CF28E;
	Thu, 10 Oct 2024 20:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728591054; cv=none; b=Ll2km591HfT7F4raBQBLwjX1a/7ADCOEebvT7BXR9+TsxpKNyT+NaI3hbZ8udmKQg2ZszLLAO+AsEBS43tdsDHQnuKkXOpNGdrQXPPjeDAfS/rSGjdNK+c0OE8/Zjaqp9r2gSZDxJ7rJLcjaOEiIByCYuWGPLQq+ZbxdrlICG9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728591054; c=relaxed/simple;
	bh=Nsb9smOufrjGnfYSOh3dlU2s4wT9SoXkoVS55B1Cq+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMn6a2FTqdpLPhPJeZ/yNVBquSapN7QOxLWPicrYckeSMK6k7Mgk09JS+OQSXO7mjF5tXwWs9LHtDVbXAAMDhoGcRS+5BROhbqS4lobmi6g+xfugKUxgEIqRDrGEiLplszr6OYW3U8BksH5V5GsL+oMIPFWumPjLINO1BlijN8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcbR/dW3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A910DC4CEC5;
	Thu, 10 Oct 2024 20:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728591053;
	bh=Nsb9smOufrjGnfYSOh3dlU2s4wT9SoXkoVS55B1Cq+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DcbR/dW39hN4vnaaBggNvTwwcIL3h73Na9N9bqkIWUWUfnTRiiBrIyyEnEW3GtbTB
	 lszlWPHN2QrVCwTG6qXZGVE/TIgPmF05TFbSyzpB6sq4O5H8WMuHEwWQi4P7Ke/W5j
	 Q/qeXBUJH0LvnmjQ5tYBTNiUxoXIHEtPsJ4KPTh7oAm0h4DCFQEYsdplQpRSWgo6Us
	 laK14pS+aR7K1GaUvsZtCCmc0bbpuECccSO1b4oTiIIkX6VljF2/dP0YvoNcPyKRTn
	 YwSjloj9KPB+4yX75yUsTYyV2J4qbaAzIs9y7+V5HLYEcKuwycejzpnHTCZe3OjKG2
	 Lm+UNVRoLojkg==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv6 bpf-next 04/16] bpf: Force uprobe bpf program to always return 0
Date: Thu, 10 Oct 2024 22:09:45 +0200
Message-ID: <20241010200957.2750179-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241010200957.2750179-1-jolsa@kernel.org>
References: <20241010200957.2750179-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As suggested by Andrii make uprobe multi bpf programs to always return 0,
so they can't force uprobe removal.

Keeping the int return type for uprobe_prog_run, because it will be used
in following session changes.

Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index fdab7ecd8dfa..3c1e5a561df4 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3209,7 +3209,6 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
 	struct bpf_prog *prog = link->link.prog;
 	bool sleepable = prog->sleepable;
 	struct bpf_run_ctx *old_run_ctx;
-	int err = 0;
 
 	if (link->task && !same_thread_group(current, link->task))
 		return 0;
@@ -3222,7 +3221,7 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
 	migrate_disable();
 
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
-	err = bpf_prog_run(link->link.prog, regs);
+	bpf_prog_run(link->link.prog, regs);
 	bpf_reset_run_ctx(old_run_ctx);
 
 	migrate_enable();
@@ -3231,7 +3230,7 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
 		rcu_read_unlock_trace();
 	else
 		rcu_read_unlock();
-	return err;
+	return 0;
 }
 
 static bool
-- 
2.46.2



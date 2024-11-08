Return-Path: <bpf+bounces-44342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EBC9C1E4D
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 14:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 179F31C21721
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 13:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C061EF953;
	Fri,  8 Nov 2024 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCi8DshW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4891EF0B9;
	Fri,  8 Nov 2024 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073581; cv=none; b=iELuHL/LIBBz4TmgmZlprGHcBDFvzjmPy438IeQ5blYo+8xQxdf0XdskCc2A8Q1bL8oaBZm+wHvBenqPEAlJi+f9EpBZCxbR06jmevFzN1pP90tXECmXmexNY/ufh/H7z1zxM9R2JDNQo8tG2dCISfZ448Y2aZQ1enEmrGg7FGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073581; c=relaxed/simple;
	bh=knGN9mYSt4oaC3PgJtQg4jNvS9bcAM6Ll/592/RM5X0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pd4syURX+sxOCxYzFdO6ha9Z7NjIazc/MAqZo4IOBkDLpElianmH1KKuuf9LkBZYKrIJaFyb5swX9kUkFMC8IoPrGAZGq6VuVhFbAgV+5utBIJ3DEVNs1fL4mumYgsOwul49by/BnApvt3fXDepPny9kzr9MtoQF2GZY246JCCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCi8DshW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7212C4CECD;
	Fri,  8 Nov 2024 13:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731073580;
	bh=knGN9mYSt4oaC3PgJtQg4jNvS9bcAM6Ll/592/RM5X0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XCi8DshW+kC5GEljOSF0i4pO79sxCvvMmhhM1IeqJn2p2CJDrWfoy63v8dHnyCuo6
	 A8drVbXzep16gHR2er0jVawOV71U6XIXRobpmR653fb4LPgjFpLj2KT0f0FmPmw00a
	 wMKxznPW6UFUv3DXCRvCqwnel5ypgMLGv1GhOt9HjC1uIxotCh8HKAHrEeIfkvL1UV
	 Jb2dRhd+WipW9J2oTk/ILAdi6Znn845QzaXzzWG3waaueDOOxiVmEGOqsuDedY5NKh
	 LeSMS6l+bzGivlkUUaKTtRL1Tr0yERIVuax2BmcyQ1i8NEV/UCHt7wPSrMnBzoXuPC
	 3BXmRfOfHkqCQ==
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
Subject: [PATCHv9 bpf-next 02/13] bpf: Force uprobe bpf program to always return 0
Date: Fri,  8 Nov 2024 14:45:33 +0100
Message-ID: <20241108134544.480660-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108134544.480660-1-jolsa@kernel.org>
References: <20241108134544.480660-1-jolsa@kernel.org>
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
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 88fd628850ca..db9e2792b42b 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3229,7 +3229,6 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
 	struct bpf_prog *prog = link->link.prog;
 	bool sleepable = prog->sleepable;
 	struct bpf_run_ctx *old_run_ctx;
-	int err = 0;
 
 	if (link->task && !same_thread_group(current, link->task))
 		return 0;
@@ -3242,7 +3241,7 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
 	migrate_disable();
 
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
-	err = bpf_prog_run(link->link.prog, regs);
+	bpf_prog_run(link->link.prog, regs);
 	bpf_reset_run_ctx(old_run_ctx);
 
 	migrate_enable();
@@ -3251,7 +3250,7 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
 		rcu_read_unlock_trace();
 	else
 		rcu_read_unlock();
-	return err;
+	return 0;
 }
 
 static bool
-- 
2.47.0



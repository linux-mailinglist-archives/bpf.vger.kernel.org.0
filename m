Return-Path: <bpf+bounces-43670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B10FD9B84F8
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 22:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 648911F2276E
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 21:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F901CDA25;
	Thu, 31 Oct 2024 21:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMmSnzG4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0301CCB5E;
	Thu, 31 Oct 2024 21:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730408990; cv=none; b=DFasd46F95FmL2k/TiCDQRX/JR7SyaHi16RgRUWKOI3ftuwK9Rddy32i++/MUEKwdz2QZ5nimHCDCzjRxjRWcA0/52nEAhJCh/skXuyp3qhkY2GjC6hGmwR0jsRk9CXZr9YEfkYLz7/r3MS1Rt/nYQ60iCoW2wLpmmvPfBK38EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730408990; c=relaxed/simple;
	bh=xJTzBD6BpyYMRten0/IhV3TKzrQ+ciwoPgRAuiCLgWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BYXLUXqh2Rc2QBNyikmyNDxtuem5swGImND2md7E8XaWxID9w5I22h52rdten6HrzIy058yXJgY2ZCM79kyxIMAg8xO0vbuLmizs2Ca3t8elEfI5H+nsUnr7GW0DQgsSHJuxxIV0CN6D4bDgEobAUNQz52mrt7RFKAHBdipi8X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMmSnzG4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81545C4CEC3;
	Thu, 31 Oct 2024 21:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730408989;
	bh=xJTzBD6BpyYMRten0/IhV3TKzrQ+ciwoPgRAuiCLgWQ=;
	h=From:To:Cc:Subject:Date:From;
	b=DMmSnzG4loA5DacydVvt+7G3FA4+p8BSEYnMRcKB+WLGHWGE9BEXHso4bTYx7U+0k
	 xBBAWNfE/MljIp60YTwR6joAoniDiI2Oksa1jDa0iv0/tiWhOuUcGAcDCxMNbIiddj
	 hK05uvLv7B1lbsNRebel2cP3B65bED2smZRy9DSnFk1W5bOf4ZCv9HwyQu31uumgy3
	 8TSVAvbScK+Dvfw//5tZuIi7yO2i6bJXWxD9F6Op0VdM5ZW1GV/wKd0dmETzyFNaxm
	 6SSu5OU/Ta5etKDSNIyiqUDDOIcNE5jE9FXB/ly1sPWprpvAZ5c4bAag+XPu6scKWj
	 zw9cQqjlooXzQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	rostedt@goodmis.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	peterz@infradead.org,
	paulmck@kernel.org,
	jrife@google.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH trace/for-next 1/3] bpf: put bpf_link's program when link is safe to be deallocated
Date: Thu, 31 Oct 2024 14:09:36 -0700
Message-ID: <20241031210938.1696639-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In general, BPF link's underlying BPF program should be considered to be
reachable through attach hook -> link -> prog chain, and, pessimistically,
we have to assume that as long as link's memory is not safe to free,
attach hook's code might hold a pointer to BPF program and use it.

As such, it's not (generally) correct to put link's program early before
waiting for RCU GPs to go through. More eager bpf_prog_put() that we
currently do is mostly correct due to BPF program's release code doing
similar RCU GP waiting, but as will be shown in the following patches,
BPF program can be non-sleepable (and, thus, reliant on only "classic"
RCU GP), while BPF link's attach hook can have sleepable semantics and
needs to be protected by RCU Tasks Trace, and for such cases BPF link
has to go through RCU Tasks Trace + "classic" RCU GPs before being
deallocated. And so, if we put BPF program early, we might free BPF
program before we free BPF link, leading to use-after-free situation.

So, this patch defers bpf_prog_put() until we are ready to perform
bpf_link's deallocation. At worst, this delays BPF program freeing by
one extra RCU GP, but that seems completely acceptable. Alternatively,
we'd need more elaborate ways to determine BPF hook, BPF link, and BPF
program lifetimes, and how they relate to each other, which seems like
an unnecessary complication.

Note, for most BPF links we still will perform eager bpf_prog_put() and
link dealloc, so for those BPF links there are no observable changes
whatsoever. Only BPF links that use deferred dealloc might notice
slightly delayed freeing of BPF programs.

Also, to reduce code and logic duplication, extract program put + link
dealloc logic into bpf_link_dealloc() helper.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/syscall.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a8f1808a1ca5..aa7246a399f3 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2976,12 +2976,24 @@ void bpf_link_inc(struct bpf_link *link)
 	atomic64_inc(&link->refcnt);
 }
 
+static void bpf_link_dealloc(struct bpf_link *link)
+{
+	/* now that we know that bpf_link itself can't be reached, put underlying BPF program */
+	if (link->prog)
+		bpf_prog_put(link->prog);
+
+	/* free bpf_link and its containing memory */
+	if (link->ops->dealloc_deferred)
+		link->ops->dealloc_deferred(link);
+	else
+		link->ops->dealloc(link);
+}
+
 static void bpf_link_defer_dealloc_rcu_gp(struct rcu_head *rcu)
 {
 	struct bpf_link *link = container_of(rcu, struct bpf_link, rcu);
 
-	/* free bpf_link and its containing memory */
-	link->ops->dealloc_deferred(link);
+	bpf_link_dealloc(link);
 }
 
 static void bpf_link_defer_dealloc_mult_rcu_gp(struct rcu_head *rcu)
@@ -3003,7 +3015,6 @@ static void bpf_link_free(struct bpf_link *link)
 		sleepable = link->prog->sleepable;
 		/* detach BPF program, clean up used resources */
 		ops->release(link);
-		bpf_prog_put(link->prog);
 	}
 	if (ops->dealloc_deferred) {
 		/* schedule BPF link deallocation; if underlying BPF program
@@ -3014,8 +3025,9 @@ static void bpf_link_free(struct bpf_link *link)
 			call_rcu_tasks_trace(&link->rcu, bpf_link_defer_dealloc_mult_rcu_gp);
 		else
 			call_rcu(&link->rcu, bpf_link_defer_dealloc_rcu_gp);
-	} else if (ops->dealloc)
-		ops->dealloc(link);
+	} else if (ops->dealloc) {
+		bpf_link_dealloc(link);
+	}
 }
 
 static void bpf_link_put_deferred(struct work_struct *work)
-- 
2.43.5



Return-Path: <bpf+bounces-46091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F479E442D
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 20:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D79B2B319E1
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 17:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BC321A421;
	Wed,  4 Dec 2024 17:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIc/32ZC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851A8219BDF;
	Wed,  4 Dec 2024 17:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331711; cv=none; b=ecSGBaEpE1t8Fl90CEPq42XslujDQUlqG4T2sp/7x+nb7O2f7G7WAYAiWt1Tqmrc8A06gqqDdeC+znkqSJ0ApjNpleUm17iRcdf/LIqkpcH7ZTY0BU0rfDXSWos8bm54/gf3mNWyPz4RQMYDKZQgEnxM+gEIjFBYNaAW1CQm4s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331711; c=relaxed/simple;
	bh=svuHgSx7ObMcRy+apYULq+FwO/qyXiJtvDg2To9+jcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aaE6g4r3LrGVEse+yCz9WlDjXwFtza8TAh5Now7/gBWRSJ5QPBS7UTxjUaZzPefUlkBYELt5hcv7/qaN6QOuVIm9UmPl+9IUvGgBrpTJYmHavRWqW7q2PY2O4Qyw+OqBqnqWL0NKF0hfNzg9VzIlxYpeHg6R4H7WxceBuE0lGl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIc/32ZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F84C4CECD;
	Wed,  4 Dec 2024 17:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331711;
	bh=svuHgSx7ObMcRy+apYULq+FwO/qyXiJtvDg2To9+jcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SIc/32ZCr1nyJqS74fr/L7HSalCEvqBquHax5fEHfU7g06qnzHUIiWF+hHyH9tcIQ
	 d281Qb6NG3/+MnwYDrtGA1rdLmTsdUeGQCHGvCx1gOFTYV81jTzQtId7UjKeQ8k7j8
	 LymEg0lImmWmhWK5xqEUmGZ0swsVNmJjPbyO1zncs/0R67GBiELEYn5JAlhZJ99PSf
	 w9Fh884D+cDleXVRFSN64q15/G4hG+MWMEtP0xtv9N0YEkYpbc9LbThn07MYBQZhh/
	 KYoZyCVIW5opuMZSTABYPiPkiED1Pw/YGf5RCMFtDMK/UbXmlNn89FGexF+ltPlVRa
	 7Jq9k15eKBwKQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Jordan Rife <jrife@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 11/24] bpf: put bpf_link's program when link is safe to be deallocated
Date: Wed,  4 Dec 2024 10:49:31 -0500
Message-ID: <20241204155003.2213733-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204155003.2213733-1-sashal@kernel.org>
References: <20241204155003.2213733-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
Content-Transfer-Encoding: 8bit

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit f44ec8733a8469143fde1984b5e6931b2e2f6f3f ]

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

Link: https://lore.kernel.org/20241101181754.782341-1-andrii@kernel.org
Tested-by: Jordan Rife <jrife@google.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/syscall.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 252aed82d45ea..ba38c08a9a059 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2870,12 +2870,24 @@ void bpf_link_inc(struct bpf_link *link)
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
@@ -2897,7 +2909,6 @@ static void bpf_link_free(struct bpf_link *link)
 		sleepable = link->prog->aux->sleepable;
 		/* detach BPF program, clean up used resources */
 		ops->release(link);
-		bpf_prog_put(link->prog);
 	}
 	if (ops->dealloc_deferred) {
 		/* schedule BPF link deallocation; if underlying BPF program
@@ -2908,8 +2919,9 @@ static void bpf_link_free(struct bpf_link *link)
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
2.43.0



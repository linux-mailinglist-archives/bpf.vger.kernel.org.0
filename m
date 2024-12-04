Return-Path: <bpf+bounces-46086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBDA9E4062
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 18:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E13116799D
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 17:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F1421764D;
	Wed,  4 Dec 2024 16:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oa8zLjEm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDEE20DD67;
	Wed,  4 Dec 2024 16:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331508; cv=none; b=g1soB/3+357hep8WGLyxkdGGlvmgRhLY4e6P/Py1vgmjQM9rzT86L8MS/OI6k2yQFd7cl+2cFre+/7syoOmunHlNHVn5kZKkiNBMqGkLDMXkwiwBJzneVYKHmVmVa+7OTmW8aDgXCMZLPCAeIJHZ1XITVHPU9a+seaUzHsLoalU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331508; c=relaxed/simple;
	bh=udSRhDBulGplchZ3ggP60P1EzgTxgPhSkL0dcvpLWgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=edcWeqM5Dijsgt7xTm/66Untz2M3aWG6hqAupJjICgRgAka5+DX++Ej0+LuUJjD1zq3gquitjGwXpt1JFuAMqCXTAw94Uf8u9JQ/6bLlGMf+sP5e6jNTZ9I1sJocBcnzYx1QZ1YbHzKMK70n1t5MyShz467hgMghBD5utaYqzr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oa8zLjEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395EDC4CED1;
	Wed,  4 Dec 2024 16:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331506;
	bh=udSRhDBulGplchZ3ggP60P1EzgTxgPhSkL0dcvpLWgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oa8zLjEmOEjTiscjmQL2W5oL24DNBDUsq1gYUYysF0+yu5BppsZxZpA/SYImVN8B5
	 xoSBmtL7iRM840ntnvKoCTTXvOKQedHiu/5n6ypO78AsmITM5XzfGPirKXHiAhv3Q7
	 90WKij2KKTfeQKM1pcOf1cvW/E9WzxaFJGf/27C4r5paOfRT8KuvhitBYQWvzony4Z
	 HFI+oYTtIBcdLOAPBIvtpwnh6qcJ8K2PFUjhdrZxzMJpX9wT38duIMCgoQbzCVs3LM
	 hjzM5ZZte+SpM2APrK/bddpFlb54VS47IyI8buXE7OFziVgKAY1XafXUWTYwGzts3E
	 xJVzCv2BVnDFQ==
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
Subject: [PATCH AUTOSEL 6.12 16/36] bpf: put bpf_link's program when link is safe to be deallocated
Date: Wed,  4 Dec 2024 10:45:32 -0500
Message-ID: <20241204154626.2211476-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204154626.2211476-1-sashal@kernel.org>
References: <20241204154626.2211476-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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
index c5aa127ed4cc0..2e99fedb9e4ab 100644
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
2.43.0



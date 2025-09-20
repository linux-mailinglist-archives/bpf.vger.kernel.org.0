Return-Path: <bpf+bounces-69071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26592B8BC5C
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0A7016D230
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2ECD2E3716;
	Sat, 20 Sep 2025 01:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kptV9WJu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8912E2EF3;
	Sat, 20 Sep 2025 01:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758330015; cv=none; b=LgauLlpk8wIlCUf8vC3Iu/VXQbCow5Rvh9AapymV1UJV533IcKnUrbLx4w48XS52ZiaoPtBeEqzDTzqNZPJEhELE5SrpgEQTo2reYTf88b2CWG+8aezf/gSlUFW3odBRA+zKGhUqaZbw9cUBLh7vUCNUqlNTnN8fRq0SY0CaQf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758330015; c=relaxed/simple;
	bh=DGypOrq6SgMS5tci1mp5f1brFYetegLf2MZV9KNNQoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tomVUk+EI7Ix46QkBDM4pm3F1HaExbKM3WQCPbDjWLn0GsEpuGn7e/K362zFg09YRxZPH95Wjeo6vEZgiPsIqisiRwpkgK79F/mQ90I3D/v/rIcogOgdbcarJff7gBNhtQGtycr5MInw7kkfsQ+wEyMwCRKGICICUIV9x/+9mY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kptV9WJu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77A4C4CEF0;
	Sat, 20 Sep 2025 01:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758330015;
	bh=DGypOrq6SgMS5tci1mp5f1brFYetegLf2MZV9KNNQoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kptV9WJuFmHdptVHV8UaYL7QoRKxw6xpkvTufWVBBu170zwLBfuTF4WfGlttUT2Is
	 JgtMaZIIDUvL05jNbxjk2a5yz8BlRlnv1KMLmCMe8NfkIlrXa0SaI/M0mVYLy0jZ/x
	 NUrI0jvIRbwpr/Gl5h93EhlDmt4Ur7aws+8B7SRWvVOFCOnh2Dh/BofxOPiqYmIImK
	 QmNX9vzSWthWS90tWxdxJ2tpMlYs0rJBKovSal25Cud2ywYlDaMTjxnTEQup4lgilv
	 TSH40taBhMFCMv742sXsno5ryUjbPfqh2rIsdoW/+BqJDA4I2s8Qguqhg/WN5sOqqD
	 jU28iYnKC8QgA==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 38/46] sched_ext: Convert scx_dump_state() spinlock to raw spinlock
Date: Fri, 19 Sep 2025 14:59:01 -1000
Message-ID: <20250920005931.2753828-39-tj@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920005931.2753828-1-tj@kernel.org>
References: <20250920005931.2753828-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The scx_dump_state() function uses a regular spinlock to serialize
access. In a subsequent patch, this function will be called while
holding scx_sched_lock, which is a raw spinlock, creating a lock
nesting violation.

Convert the dump_lock to a raw spinlock and use the guard macro for
cleaner lock management.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 4dc82afb7016..fafffe3ee812 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4565,7 +4565,7 @@ static void scx_dump_task(struct seq_buf *s, struct scx_dump_ctx *dctx,
 
 static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 {
-	static DEFINE_SPINLOCK(dump_lock);
+	static DEFINE_RAW_SPINLOCK(dump_lock);
 	static const char trunc_marker[] = "\n\n~~~~ TRUNCATED ~~~~\n";
 	struct scx_sched *sch = scx_root;
 	struct scx_dump_ctx dctx = {
@@ -4577,11 +4577,10 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 	};
 	struct seq_buf s;
 	struct scx_event_stats events;
-	unsigned long flags;
 	char *buf;
 	int cpu;
 
-	spin_lock_irqsave(&dump_lock, flags);
+	guard(raw_spinlock_irqsave)(&dump_lock);
 
 	seq_buf_init(&s, ei->dump, dump_len);
 
@@ -4705,8 +4704,6 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 	if (seq_buf_has_overflowed(&s) && dump_len >= sizeof(trunc_marker))
 		memcpy(ei->dump + dump_len - sizeof(trunc_marker),
 		       trunc_marker, sizeof(trunc_marker));
-
-	spin_unlock_irqrestore(&dump_lock, flags);
 }
 
 static void scx_error_irq_workfn(struct irq_work *irq_work)
-- 
2.51.0



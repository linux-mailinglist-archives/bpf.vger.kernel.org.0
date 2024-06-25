Return-Path: <bpf+bounces-32963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB43915AEF
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 02:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 364D0B2141F
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 00:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD028BE0;
	Tue, 25 Jun 2024 00:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOQRaJgw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4767748D;
	Tue, 25 Jun 2024 00:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719274915; cv=none; b=GTH3UpDBDcL67j1+55i8q2sVmUdrRXvxDb2ysVbxjo86UApRiNYfyVVLABhkomEDFwIszUGXxI1nBuu2FO/GAJy3Q1xi7YaWWb1pfIpnVeSZuTxEgtucWSlUvH+2JCmH3KDbZok4Qt5VgKS4+qi4q91IbWUfMqy6Ln2XVm+peaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719274915; c=relaxed/simple;
	bh=tkfMZEIfCD2t2X9zAlRKVT3aTkroscbKpUlij2Wh0pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fAX9/F3aBwzgUnQwscH+dn816xugn7c/x5op85Mu42XeQS8nE6Zlw5AmRCQMR1/1jkEvq/qgvNU0ushGX5vv3O0bA4qx9feGDLqGO+QdMGuSKuzprqPtj9LaStm04yr/6FiCEH32ytf2bvGdjbk9/5zukBzOk1RzjCPJumJ9Lks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOQRaJgw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383FAC2BBFC;
	Tue, 25 Jun 2024 00:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719274915;
	bh=tkfMZEIfCD2t2X9zAlRKVT3aTkroscbKpUlij2Wh0pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rOQRaJgwV/HmcGme2hL19+ik7Tr8OgaQfKkxNOObGOwKzUk/kQ56dSIj/5pPINVrC
	 Oroj2Juqj2UX8Pc6rEXO4iKXWBqB5ORWIR/cKzDiLy+TPeWilBcCXJZIrbHVWaRtsp
	 8WmCFZsWNcAt8KqDCj3klC3SaVLxAspv0ySuseSvtgsJ3m1d1fjVboTRQd9b8sxpE5
	 3PKvma7D2L+xqjDfPsHBoFx4malveX3q4dGgVEfQwek1IiEiJ+ouNPfmqZUS2ZDFON
	 J2aS3xhP5CakpaplYPsU9qjcCxWKTlrdCME1is6XXUUxVDb58jKWi5i7dVVLyZfxKF
	 2MR7F4zVtWehQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	oleg@redhat.com
Cc: peterz@infradead.org,
	mingo@redhat.com,
	bpf@vger.kernel.org,
	jolsa@kernel.org,
	paulmck@kernel.org,
	clm@meta.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH 01/12] uprobes: update outdated comment
Date: Mon, 24 Jun 2024 17:21:33 -0700
Message-ID: <20240625002144.3485799-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240625002144.3485799-1-andrii@kernel.org>
References: <20240625002144.3485799-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no task_struct passed into get_user_pages_remote() anymore,
drop the parts of comment mentioning NULL tsk, it's just confusing at
this point.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/events/uprobes.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2816e65729ac..197fbe4663b5 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2030,10 +2030,8 @@ static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
 		goto out;
 
 	/*
-	 * The NULL 'tsk' here ensures that any faults that occur here
-	 * will not be accounted to the task.  'mm' *is* current->mm,
-	 * but we treat this as a 'remote' access since it is
-	 * essentially a kernel access to the memory.
+	 * 'mm' *is* current->mm, but we treat this as a 'remote' access since
+	 * it is essentially a kernel access to the memory.
 	 */
 	result = get_user_pages_remote(mm, vaddr, 1, FOLL_FORCE, &page, NULL);
 	if (result < 0)
-- 
2.43.0



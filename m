Return-Path: <bpf+bounces-32965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFB8915AF0
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 02:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBC50B2145D
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 00:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883368BE0;
	Tue, 25 Jun 2024 00:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afH7HcO3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1BA8F54;
	Tue, 25 Jun 2024 00:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719274922; cv=none; b=pEWJyoR+A/rAnNb0D5tn+RTFfv2NSS70fzcH04I4fPnAE6QYP4MEQ5BUBkpTP1L3IJ6fwGxEW6LWXhBVzogCpwMGjwZqbhnlsIP/rqrrmLBxsf8sTtKGzCefL4aaVc2LU13qU0ZXZfkyTgEjN85U+8PfgW7yJZdIufDxWEmXTyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719274922; c=relaxed/simple;
	bh=u1aASBzMPXmgymcg/zj6/yzHwovabfoGhv7lvwXZipY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+6UlTa02F3/YHO73Sw1itnYpyhAbS3bSh3na6YWYwQZRLGjotXKrtxpx+PQXP++xNulk8lM6OzWV+rJ9ociuf9bzZyZtsSlTGPfiO21u8MrgMOpfCPLEu6M+4BCr55YyurC9lPibChkgo3RJCHUtVapEEclB9q7tdUfyvdfCZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afH7HcO3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6AE6C2BBFC;
	Tue, 25 Jun 2024 00:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719274921;
	bh=u1aASBzMPXmgymcg/zj6/yzHwovabfoGhv7lvwXZipY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=afH7HcO3puyoN35R1K4ugLM2CPbN6j8fP7EsXNZVPI2mevcF9Jt4jx/bQJpeh6R1n
	 fI3UtcrjJo5GPklaOIQw+g27G6EBgcSnOlK1DCnsSgy+0QHLHbbKYioe3y7r0iGSXC
	 HWwnfiZYuEcggR8NxH+Ii8RzMJp5eDhXurdP9ntzc7VsdWkp8RiwLFj/Nvs7DMScnI
	 4oipylz3x+7l/Br46kX5S9c6OIGQmf0CFOA0TDVUzIacGYdn0OkPD072LacJxHDFeu
	 WIUq9EG1e+OEiQ5gIPdl7oTG3QjtXzyqiMKqLTXF36npTxi8T49ApgqVgrFxzyw56K
	 zXxkRfFdGWHqw==
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
Subject: [PATCH 03/12] uprobes: simplify error handling for alloc_uprobe()
Date: Mon, 24 Jun 2024 17:21:35 -0700
Message-ID: <20240625002144.3485799-4-andrii@kernel.org>
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

Return -ENOMEM instead of NULL, which makes caller's error handling just
a touch simpler.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/events/uprobes.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index e896eeecb091..aa59fa53ae67 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -725,7 +725,7 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
 
 	uprobe = kzalloc(sizeof(struct uprobe), GFP_KERNEL);
 	if (!uprobe)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	uprobe->inode = inode;
 	uprobe->offset = offset;
@@ -1161,8 +1161,6 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
 
  retry:
 	uprobe = alloc_uprobe(inode, offset, ref_ctr_offset);
-	if (!uprobe)
-		return -ENOMEM;
 	if (IS_ERR(uprobe))
 		return PTR_ERR(uprobe);
 
-- 
2.43.0



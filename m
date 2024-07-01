Return-Path: <bpf+bounces-33543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C208591EAE1
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 00:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E1E41F22650
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 22:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4C617164D;
	Mon,  1 Jul 2024 22:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXMscKr9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC31171651;
	Mon,  1 Jul 2024 22:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719873589; cv=none; b=u0dwG+i00gYt0+JSoJxWxWE0/7REG+5G3VLG3xmCvNElj6nqktrRF8hZZxYK9muLXCAwJkfbLHIZTxOBJ9maiC8Ex9FSV7seuDeDEsoeTBukEhGgU8DPpQujC7sS8ly8KiMcI0FKaDaYHYUMgZC/lJwnRIdzAyyJ5C/MHIpyo2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719873589; c=relaxed/simple;
	bh=MFARpduduHb4nilHvQhZgOpCAhfnha4oEsghJo+BlOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBZcjAf3YaRdv72agUjUrvyQ55zVACoa44q1oFectXRJ2kA2lvuLs9CPfCwfpZulofX3006H14EAIlCLT0C5lvcqBycD9Rw4AKXM3S0bdgw3NaCtHAKP1cLY5ct6+C+NF+3a0S1JqyhpnwREg+Ekj8LcDX/dMw2agl6OhpcJL4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXMscKr9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE19C116B1;
	Mon,  1 Jul 2024 22:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719873588;
	bh=MFARpduduHb4nilHvQhZgOpCAhfnha4oEsghJo+BlOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tXMscKr9GnYZF6+hoLiWwXi1d1j63cEF7bJUMwtPkuFtrPc1u11GIkvjGhaWFFmDY
	 BE7sv7Io0/yIGrFkT6iY6nUpHEgEtnoPpijCd5nNEQn9WWGBmE9ySVI5Kdyw2blxW+
	 ukhSVWxQRAXs+c66lqtRTz15x+KcpNiRCTOZafw8QXAGqep/wFC7YkUct0jdCTC2cv
	 bS6Oe8bEV30wNLg4z7yCvkGVFAo4M3n/gsCqs9jakX43VPtdNdxYmhzMtFp9apiE8d
	 jeacyzcdnMsRTtGUQn3/N6MKQiYBy2ypbt2bTNpelzag+CBrgrXPRKaRQt1qyq4wgH
	 vsGoMfQzQ4ppg==
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
Subject: [PATCH v2 03/12] uprobes: simplify error handling for alloc_uprobe()
Date: Mon,  1 Jul 2024 15:39:26 -0700
Message-ID: <20240701223935.3783951-4-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701223935.3783951-1-andrii@kernel.org>
References: <20240701223935.3783951-1-andrii@kernel.org>
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
index f87049c08ee9..23449a8c5e7e 100644
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



Return-Path: <bpf+bounces-33542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA8591EAE0
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 00:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42E271F22907
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 22:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EBA171E52;
	Mon,  1 Jul 2024 22:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLtXfHjz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F381171079;
	Mon,  1 Jul 2024 22:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719873586; cv=none; b=dUvJqYf9YxQisEBSJTyYz/9tDEpVPuHE082SSzc1Po50FHj9+kYD1JubjgfSQzIJHLe0xi4MHDF63ps75+Xoi4R8NENE2OL4kTfw2K1y4J4LGM09vltXTg0Yyne0lBS6WUYGcwmRUW2QexflLwHJjKT7LPaJEadSPeQVVEflaoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719873586; c=relaxed/simple;
	bh=zuWlQDRIA9Y3TvaGDg+DFpB2kxzINwcItGB/mZydiw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bT5Hk9Yi4HY/80XU+pfjnbISGdcaQ6ViS18K6c3M8BMc2R4zsV2ujWS72UzBspIL5dNNFqajW/Il21ZXtixgyH0p76KvRlLJeSY12a4XOLQeoO0UQ4z4QprB15zBLxIEwpljdNSDUngp7sJzYUN1wtPrCaZopaxqgmvjBa53k20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLtXfHjz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EB9C116B1;
	Mon,  1 Jul 2024 22:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719873585;
	bh=zuWlQDRIA9Y3TvaGDg+DFpB2kxzINwcItGB/mZydiw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eLtXfHjz/odlDT45j//QKRBfSZNrLhArgaG3JBpHfwbkJp8atnSQqneeMmwtMxl2x
	 PFT+6P4z9S0IOPFbCjK9wNp1tDdv9bZ1CQAdcj1qQF1AAsmIa8Db7RukqCqCMhQAIV
	 yz85GmxmIU8vlZxL4nTcyDTMqqUg/ecOdoDnbVX/p1+gp6SGqRWRXIG/27mL+BCAbW
	 54nnkj8CC4zVMlJoeBtcY1hYZmzGwxFGTZ6LPj7V58shVr8LarZ7JrpbtsZmeykMAZ
	 ZSiRsYVHI4hSyyqTxw2tRlp1sgkrByQ4g6JXexMDwPno3a/p90tspYrYQ6EwWWdYLF
	 TTkpqALa0wEzw==
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
Subject: [PATCH v2 02/12] uprobes: correct mmap_sem locking assumptions in uprobe_write_opcode()
Date: Mon,  1 Jul 2024 15:39:25 -0700
Message-ID: <20240701223935.3783951-3-andrii@kernel.org>
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

It seems like uprobe_write_opcode() doesn't require writer locked
mmap_sem, any lock (reader or writer) should be sufficient. This was
established in a discussion in [0] and looking through existing code
seems to confirm that there is no need for write-locked mmap_sem.

Fix the comment to state this clearly.

  [0] https://lore.kernel.org/linux-trace-kernel/20240625190748.GC14254@redhat.com/

Fixes: 29dedee0e693 ("uprobes: Add mem_cgroup_charge_anon() into uprobe_write_opcode()")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 081821fd529a..f87049c08ee9 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -453,7 +453,7 @@ static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
  * @vaddr: the virtual address to store the opcode.
  * @opcode: opcode to be written at @vaddr.
  *
- * Called with mm->mmap_lock held for write.
+ * Called with mm->mmap_lock held for read or write.
  * Return 0 (success) or a negative errno.
  */
 int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
-- 
2.43.0



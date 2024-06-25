Return-Path: <bpf+bounces-32964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D661915AEE
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 02:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E9361C21160
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 00:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD50748D;
	Tue, 25 Jun 2024 00:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTLdIV9K"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91028F54;
	Tue, 25 Jun 2024 00:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719274919; cv=none; b=D2MXMKL946XnuBZj46ePHtR8qOfzZvcvaDDsHiBw0RuThsEY5slipr8Q8xIs4ajL8KoY8R1+EIKff9iT2c0FSeEwFKphl7nJCt9lHbv67ssGSWXYlxYOkBnUcoXRBScKCGz6AADzJf/rK1VRXJ8o+vYZrhlWoX+wVzCESgxJG1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719274919; c=relaxed/simple;
	bh=YNyvbgNFOWIesFZQZKPldGFE+T/lYtL4YunmLoVLoC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fckCVp1dno9t5gWcgYUku0k7P8wZ2Hp+HyHdoXlxjgcWuZlOp1yITsTAkqlE2HKBIXy/StxOML4tPFU6etzWYJp41fM1qeV2+zSfSr2HoL2xlnubMyujaoh25G0S2TDNSFJbc4nu4DMpfz+BuJyJf4GNAyRcNfwdlEMAgGjiG5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTLdIV9K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A589C2BBFC;
	Tue, 25 Jun 2024 00:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719274918;
	bh=YNyvbgNFOWIesFZQZKPldGFE+T/lYtL4YunmLoVLoC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HTLdIV9KeyGPtBnGNRcLnvCJ/1e2+cnmc+7JdIVey4eKy6Ny8yEsjAzoP0vBMHlgh
	 o4quxtDEUWt/boEz/NBVkjdRjdXf41GfWux+yOCHzRAZHVRcCIFXB2xHF8UKqkSCSJ
	 R9QKmvlvQnXPNNY3n7mZ9CKWwwIGzSbEyVoGwThooI88vxSMeUyw2MypevpEXq8nz1
	 eC/DmFL5Cfv2GPVJ7LXZOx73ZEmIWEu1n5NNW4cxuyYJ0OIglvyipSqrNWEM7lo5+L
	 kxKntBnEkvf+kxShFQ72JLO6B0Bp9V1dn4S+JROr21iMHfNBgs4XihI92uXKNX1lVC
	 AyeByFfH5F3wg==
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
Subject: [PATCH 02/12] uprobes: grab write mmap lock in unapply_uprobe()
Date: Mon, 24 Jun 2024 17:21:34 -0700
Message-ID: <20240625002144.3485799-3-andrii@kernel.org>
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

Given unapply_uprobe() can call remove_breakpoint() which eventually
calls uprobe_write_opcode(), which can modify a set of memory pages and
expects mm->mmap_lock held for write, it needs to have writer lock.

Fix this by switching to mmap_write_lock()/mmap_write_unlock().

Fixes: da1816b1caec ("uprobes: Teach handler_chain() to filter out the probed task")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/events/uprobes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 197fbe4663b5..e896eeecb091 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1235,7 +1235,7 @@ static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
 	struct vm_area_struct *vma;
 	int err = 0;
 
-	mmap_read_lock(mm);
+	mmap_write_lock(mm);
 	for_each_vma(vmi, vma) {
 		unsigned long vaddr;
 		loff_t offset;
@@ -1252,7 +1252,7 @@ static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
 		vaddr = offset_to_vaddr(vma, uprobe->offset);
 		err |= remove_breakpoint(uprobe, mm, vaddr);
 	}
-	mmap_read_unlock(mm);
+	mmap_write_unlock(mm);
 
 	return err;
 }
-- 
2.43.0



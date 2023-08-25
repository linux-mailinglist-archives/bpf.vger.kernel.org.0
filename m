Return-Path: <bpf+bounces-8603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F18D788AC7
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 16:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9004E1C21073
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 14:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAE810956;
	Fri, 25 Aug 2023 14:04:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2AD10947
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 14:04:30 +0000 (UTC)
Received: from out-249.mta1.migadu.com (out-249.mta1.migadu.com [95.215.58.249])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77D92680
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 07:04:12 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692972214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T6ViUZBPx7ad0ZahN3iXc6h6e/WwSaru8OskP5bAugQ=;
	b=ES2TiCn948OXPBoEBgWTcBO0RS4z23ivDrdXlTdAtaw6PThdxWDWOdUDMqwN5Zn7WD+dyR
	mB9Bpqj2y+SXbSPXBOj6qNtlf9PRruM/6AA9li5Lcnl6yPomOz6TlD4q7SN/nyqOvAgxMU
	ufKXd8FiPwyCFvbnzPL8RetLQf6iEEM=
From: Hao Xu <hao.xu@linux.dev>
To: io-uring@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Dominique Martinet <asmadeus@codewreck.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Stefan Roesch <shr@fb.com>,
	Clay Harris <bugs@claycon.org>,
	Dave Chinner <david@fromorbit.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-cachefs@redhat.com,
	ecryptfs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	codalist@coda.cs.cmu.edu,
	linux-f2fs-devel@lists.sourceforge.net,
	cluster-devel@redhat.com,
	linux-mm@kvack.org,
	linux-nilfs@vger.kernel.org,
	devel@lists.orangefs.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-mtd@lists.infradead.org,
	Wanpeng Li <wanpengli@tencent.com>
Subject: [PATCH 20/29] xfs: distinguish error type of memory allocation failure for nowait case
Date: Fri, 25 Aug 2023 21:54:22 +0800
Message-Id: <20230825135431.1317785-21-hao.xu@linux.dev>
In-Reply-To: <20230825135431.1317785-1-hao.xu@linux.dev>
References: <20230825135431.1317785-1-hao.xu@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Hao Xu <howeyxu@tencent.com>

Previously, if we fail to get the memory we need, -ENOMEM is returned.
It can be -EAGAIN now since we support nowait now. Return the latter
when it is the case. Involved functions are:  _xfs_buf_map_pages(),
xfs_buf_get_maps(), xfs_buf_alloc_kmem() and xfs_buf_alloc_pages().

Signed-off-by: Hao Xu <howeyxu@tencent.com>
---
 fs/xfs/xfs_buf.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 8b800ce28996..a6e6e64ff940 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -192,7 +192,7 @@ xfs_buf_get_maps(
 	bp->b_maps = kmem_zalloc(map_count * sizeof(struct xfs_buf_map),
 				KM_NOFS);
 	if (!bp->b_maps)
-		return -ENOMEM;
+		return bp->b_flags & XBF_NOWAIT ? -EAGAIN : -ENOMEM;
 	return 0;
 }
 
@@ -339,7 +339,7 @@ xfs_buf_alloc_kmem(
 
 	bp->b_addr = kmem_alloc(size, kmflag_mask);
 	if (!bp->b_addr)
-		return -ENOMEM;
+		return flags & XBF_NOWAIT ? -EAGAIN : -ENOMEM;
 
 	if (((unsigned long)(bp->b_addr + size - 1) & PAGE_MASK) !=
 	    ((unsigned long)bp->b_addr & PAGE_MASK)) {
@@ -363,6 +363,7 @@ xfs_buf_alloc_pages(
 {
 	gfp_t		gfp_mask = __GFP_NOWARN;
 	long		filled = 0;
+	bool		nowait = flags & XBF_NOWAIT;
 
 	if (flags & XBF_READ_AHEAD)
 		gfp_mask |= __GFP_NORETRY;
@@ -377,7 +378,7 @@ xfs_buf_alloc_pages(
 		bp->b_pages = kzalloc(sizeof(struct page *) * bp->b_page_count,
 					gfp_mask);
 		if (!bp->b_pages)
-			return -ENOMEM;
+			return nowait ? -EAGAIN : -ENOMEM;
 	}
 	bp->b_flags |= _XBF_PAGES;
 
@@ -451,7 +452,7 @@ _xfs_buf_map_pages(
 		memalloc_nofs_restore(nofs_flag);
 
 		if (!bp->b_addr)
-			return -ENOMEM;
+			return flags & XBF_NOWAIT ? -EAGAIN : -ENOMEM;
 	}
 
 	return 0;
-- 
2.25.1



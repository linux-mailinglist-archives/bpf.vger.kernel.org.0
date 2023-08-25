Return-Path: <bpf+bounces-8596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AF5788A2D
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 16:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 012961C210A6
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 14:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F0B10788;
	Fri, 25 Aug 2023 14:02:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47964101F2
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 14:02:45 +0000 (UTC)
Received: from out-247.mta1.migadu.com (out-247.mta1.migadu.com [IPv6:2001:41d0:203:375::f7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27842720;
	Fri, 25 Aug 2023 07:02:18 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692972134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KWqxpxLv+BWdZ1zPLCWWiPjW3gW3QR8GdaNCgbqB+rA=;
	b=W3mJ9hHH5VKigloC5U9bTjeZXL1WzXE+if57PbkgslJR/vwxXv7urAz03rnLzn8z8erL5h
	VCpx6iOsBDC23kpw8k8XGE0qr0cLxvBRgKj1NfrV6YtEtntJMub0qfyQ1aHr3mZsH0O0dL
	P836PFFsTuNux9i0jwQOVu5ehTDOpZM=
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
Subject: [PATCH 16/29] xfs: add nowait parameter for xfs_inode_item_init()
Date: Fri, 25 Aug 2023 21:54:18 +0800
Message-Id: <20230825135431.1317785-17-hao.xu@linux.dev>
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

Add nowait parameter for xfs_inode_item_init() to support nowait
semantics.

Signed-off-by: Hao Xu <howeyxu@tencent.com>
---
 fs/xfs/libxfs/xfs_trans_inode.c |  3 ++-
 fs/xfs/xfs_inode_item.c         | 12 ++++++++----
 fs/xfs/xfs_inode_item.h         |  3 ++-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_trans_inode.c
index cb4796b6e693..e7a8f63c8975 100644
--- a/fs/xfs/libxfs/xfs_trans_inode.c
+++ b/fs/xfs/libxfs/xfs_trans_inode.c
@@ -33,7 +33,8 @@ xfs_trans_ijoin(
 
 	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
 	if (ip->i_itemp == NULL)
-		xfs_inode_item_init(ip, ip->i_mount);
+		xfs_inode_item_init(ip, ip->i_mount,
+				    tp->t_flags & XFS_TRANS_NOWAIT);
 	iip = ip->i_itemp;
 
 	ASSERT(iip->ili_lock_flags == 0);
diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
index 91c847a84e10..1742920bb4ce 100644
--- a/fs/xfs/xfs_inode_item.c
+++ b/fs/xfs/xfs_inode_item.c
@@ -825,21 +825,25 @@ static const struct xfs_item_ops xfs_inode_item_ops = {
 /*
  * Initialize the inode log item for a newly allocated (in-core) inode.
  */
-void
+int
 xfs_inode_item_init(
 	struct xfs_inode	*ip,
-	struct xfs_mount	*mp)
+	struct xfs_mount	*mp,
+	bool			nowait)
 {
 	struct xfs_inode_log_item *iip;
+	gfp_t gfp_flags = GFP_KERNEL | (nowait ? 0 : __GFP_NOFAIL);
 
 	ASSERT(ip->i_itemp == NULL);
-	iip = ip->i_itemp = kmem_cache_zalloc(xfs_ili_cache,
-					      GFP_KERNEL | __GFP_NOFAIL);
+	iip = ip->i_itemp = kmem_cache_zalloc(xfs_ili_cache, gfp_flags);
+	if (!iip)
+		return -EAGAIN;
 
 	iip->ili_inode = ip;
 	spin_lock_init(&iip->ili_lock);
 	xfs_log_item_init(mp, &iip->ili_item, XFS_LI_INODE,
 						&xfs_inode_item_ops);
+	return 0;
 }
 
 /*
diff --git a/fs/xfs/xfs_inode_item.h b/fs/xfs/xfs_inode_item.h
index 377e06007804..7ba6f8a6b243 100644
--- a/fs/xfs/xfs_inode_item.h
+++ b/fs/xfs/xfs_inode_item.h
@@ -42,7 +42,8 @@ static inline int xfs_inode_clean(struct xfs_inode *ip)
 	return !ip->i_itemp || !(ip->i_itemp->ili_fields & XFS_ILOG_ALL);
 }
 
-extern void xfs_inode_item_init(struct xfs_inode *, struct xfs_mount *);
+extern int xfs_inode_item_init(struct xfs_inode *ip, struct xfs_mount *mp,
+			       bool nowait);
 extern void xfs_inode_item_destroy(struct xfs_inode *);
 extern void xfs_iflush_abort(struct xfs_inode *);
 extern void xfs_iflush_shutdown_abort(struct xfs_inode *);
-- 
2.25.1



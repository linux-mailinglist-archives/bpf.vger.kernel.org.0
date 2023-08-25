Return-Path: <bpf+bounces-8610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A18BA788B24
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 16:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D236A1C20F22
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 14:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6462107BD;
	Fri, 25 Aug 2023 14:07:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED30101D9
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 14:07:26 +0000 (UTC)
Received: from out-247.mta1.migadu.com (out-247.mta1.migadu.com [IPv6:2001:41d0:203:375::f7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C755BE7B
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 07:07:00 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692972368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o5eD4gq5Ypmv7xNjaJcQB3ZOSw79lNA3YgufxQ7kbUU=;
	b=IDkI/8FcKGXMrBLpAzKCujyKyUIvnRClPZG+PDDA+Kg6Ww/HgNrG0d8/UaYBPttRvdNV2G
	ImRsaH6EObyEWgQtf31bAS82oxf65cz7kpZXIj7D5nH1V4igKHLmt2T1OZkYhVy9UsI8OJ
	u9rq7LaZ7EE10dyazZwRdVBs5aqDaMI=
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
Subject: [PATCH 28/29] xfs: support nowait semantics for xc_ctx_lock in xlog_cil_commit()
Date: Fri, 25 Aug 2023 21:54:30 +0800
Message-Id: <20230825135431.1317785-29-hao.xu@linux.dev>
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

Apply trylock logic for xc_ctx_lock in xlog_cil_commit() in nowait
case and error out -EAGAIN for xlog_cil_commit().

Signed-off-by: Hao Xu <howeyxu@tencent.com>
---
 fs/xfs/xfs_log_cil.c  | 12 ++++++++++--
 fs/xfs/xfs_log_priv.h |  2 +-
 fs/xfs/xfs_trans.c    |  4 +++-
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_log_cil.c b/fs/xfs/xfs_log_cil.c
index b31830ee36dd..6d054359bbb5 100644
--- a/fs/xfs/xfs_log_cil.c
+++ b/fs/xfs/xfs_log_cil.c
@@ -1613,7 +1613,7 @@ xlog_cil_process_intents(
  * background commit, returns without it held once background commits are
  * allowed again.
  */
-void
+int
 xlog_cil_commit(
 	struct xlog		*log,
 	struct xfs_trans	*tp,
@@ -1623,6 +1623,7 @@ xlog_cil_commit(
 	struct xfs_cil		*cil = log->l_cilp;
 	struct xfs_log_item	*lip, *next;
 	uint32_t		released_space = 0;
+	bool			nowait = tp->t_flags & XFS_TRANS_NOWAIT;
 
 	/*
 	 * Do all necessary memory allocation before we lock the CIL.
@@ -1632,7 +1633,12 @@ xlog_cil_commit(
 	xlog_cil_alloc_shadow_bufs(log, tp);
 
 	/* lock out background commit */
-	down_read(&cil->xc_ctx_lock);
+	if (nowait) {
+		if (!down_read_trylock(&cil->xc_ctx_lock))
+			return -EAGAIN;
+	} else {
+		down_read(&cil->xc_ctx_lock);
+	}
 
 	if (tp->t_flags & XFS_TRANS_HAS_INTENT_DONE)
 		released_space = xlog_cil_process_intents(cil, tp);
@@ -1668,6 +1674,8 @@ xlog_cil_commit(
 
 	/* xlog_cil_push_background() releases cil->xc_ctx_lock */
 	xlog_cil_push_background(log);
+
+	return 0;
 }
 
 /*
diff --git a/fs/xfs/xfs_log_priv.h b/fs/xfs/xfs_log_priv.h
index 41edaa0ae869..eb7a1241deab 100644
--- a/fs/xfs/xfs_log_priv.h
+++ b/fs/xfs/xfs_log_priv.h
@@ -580,7 +580,7 @@ int	xlog_cil_init(struct xlog *log);
 void	xlog_cil_init_post_recovery(struct xlog *log);
 void	xlog_cil_destroy(struct xlog *log);
 bool	xlog_cil_empty(struct xlog *log);
-void	xlog_cil_commit(struct xlog *log, struct xfs_trans *tp,
+int	xlog_cil_commit(struct xlog *log, struct xfs_trans *tp,
 			xfs_csn_t *commit_seq, bool regrant);
 void	xlog_cil_set_ctx_write_state(struct xfs_cil_ctx *ctx,
 			struct xlog_in_core *iclog);
diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index f1f84a3dd456..e5beda636a37 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -1037,7 +1037,9 @@ __xfs_trans_commit(
 		xfs_trans_apply_sb_deltas(tp);
 	xfs_trans_apply_dquot_deltas(tp);
 
-	xlog_cil_commit(log, tp, &commit_seq, regrant);
+	error = xlog_cil_commit(log, tp, &commit_seq, regrant);
+	if (error)
+		goto out_unreserve;
 
 	xfs_trans_free(tp);
 
-- 
2.25.1



Return-Path: <bpf+bounces-8788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0234789F5F
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 15:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C93F280F9B
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 13:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C494D1095F;
	Sun, 27 Aug 2023 13:35:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B384D517
	for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 13:35:46 +0000 (UTC)
Received: from out-251.mta1.migadu.com (out-251.mta1.migadu.com [IPv6:2001:41d0:203:375::fb])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7671F1B6;
	Sun, 27 Aug 2023 06:35:35 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1693143333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CL8wzJoAbQ75iZcN0EHSqoGXIWt+IFMvEgcKIhs6zqE=;
	b=BRJIOv0sJCNWH9arCNNuOEeHNgvBAsJDXsD/9ROslY/E3EvWdOi7NTa+04JucH099rNnul
	4aa7v7DjXCaaQfzVNr38jK1tfhfTVUIcRN9rZkXC1mcdwty8x7yMXlzmlXd+zl6Ur2HPps
	a6OaK6jfFgLdJwLH2JKSlhPncqJxHqY=
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
Subject: [PATCH 10/11] vfs: trylock inode->i_rwsem in iterate_dir() to support nowait
Date: Sun, 27 Aug 2023 21:28:34 +0800
Message-Id: <20230827132835.1373581-11-hao.xu@linux.dev>
In-Reply-To: <20230827132835.1373581-1-hao.xu@linux.dev>
References: <20230827132835.1373581-1-hao.xu@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Hao Xu <howeyxu@tencent.com>

Trylock inode->i_rwsem in iterate_dir() to support nowait semantics and
error out -EAGAIN when there is contention.

Signed-off-by: Hao Xu <howeyxu@tencent.com>
---
 fs/readdir.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/readdir.c b/fs/readdir.c
index 6469f076ba6e..664ecd9665a1 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -43,6 +43,8 @@ int iterate_dir(struct file *file, struct dir_context *ctx)
 	struct inode *inode = file_inode(file);
 	bool shared = false;
 	int res = -ENOTDIR;
+	bool nowait;
+
 	if (file->f_op->iterate_shared)
 		shared = true;
 	else if (!file->f_op->iterate)
@@ -52,16 +54,22 @@ int iterate_dir(struct file *file, struct dir_context *ctx)
 	if (res)
 		goto out;
 
-	if (shared)
-		res = down_read_killable(&inode->i_rwsem);
-	else
-		res = down_write_killable(&inode->i_rwsem);
-	if (res)
+	nowait = ctx->flags & DIR_CONTEXT_F_NOWAIT;
+	if (nowait) {
+		res = shared ? down_read_trylock(&inode->i_rwsem) :
+			       down_write_trylock(&inode->i_rwsem);
+		if (!res)
+			res = -EAGAIN;
+	} else {
+		res = shared ? down_read_killable(&inode->i_rwsem) :
+			       down_write_killable(&inode->i_rwsem);
+	}
+	if (res < 0)
 		goto out;
 
 	res = -ENOENT;
 	if (!IS_DEADDIR(inode)) {
-		res = file_accessed(file, ctx->flags & DIR_CONTEXT_F_NOWAIT);
+		res = file_accessed(file, nowait);
 		if (res == -EAGAIN)
 			goto out_unlock;
 
-- 
2.25.1



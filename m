Return-Path: <bpf+bounces-11397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A190F7B8B7F
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 20:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 4198DB20987
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 18:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB11D21113;
	Wed,  4 Oct 2023 18:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlJs8eUM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B90918E29
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 18:55:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8569C433C9;
	Wed,  4 Oct 2023 18:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696445724;
	bh=EO4970jbAZuKMZTl4/2rNPllueWoXzioRkZ7MMwMF6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HlJs8eUM6lfk7ktqhE291v3xrDfffAHYaeF8iPm+c9muga1RkV44BSTk1vLuGArCu
	 RgO/Yq993tPgfM7L9w0wDuYLn1zlgWsnf7pxyTXmWK4MEZNCrmoPfQrBRFgwgXoaF9
	 4FAzJpSj4CWJEorRD13r+KQ4klo7Q4XSdtqb977uwDZ+CJAIV/hAm1W9teJQSvrbVI
	 X/2QivHontTzKXxisF4a8CvbP6lpfmYHQDLLspzm9iULj5I98QNuHXz4dNqX8Wjb92
	 DV4H9tLDg1FAC7T6Crb1CFOLS+8i3lso+jm/1i18XMKPEiklIvaOZhs4/XzLSy6/bE
	 oXX4TPhA+fbVQ==
From: Jeff Layton <jlayton@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org
Subject: [PATCH v2 81/89] bpf: convert to new timestamp accessors
Date: Wed,  4 Oct 2023 14:53:06 -0400
Message-ID: <20231004185347.80880-79-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004185347.80880-1-jlayton@kernel.org>
References: <20231004185221.80802-1-jlayton@kernel.org>
 <20231004185347.80880-1-jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert to using the new inode timestamp accessor functions.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 kernel/bpf/inode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 99d0625b6c82..1aafb2ff2e95 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -118,8 +118,7 @@ static struct inode *bpf_get_inode(struct super_block *sb,
 		return ERR_PTR(-ENOSPC);
 
 	inode->i_ino = get_next_ino();
-	inode->i_atime = inode_set_ctime_current(inode);
-	inode->i_mtime = inode->i_atime;
+	simple_inode_init_ts(inode);
 
 	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
 
@@ -147,7 +146,7 @@ static void bpf_dentry_finalize(struct dentry *dentry, struct inode *inode,
 	d_instantiate(dentry, inode);
 	dget(dentry);
 
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 }
 
 static int bpf_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-- 
2.41.0



Return-Path: <bpf+bounces-11037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E24A7B19B6
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 13:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 6CF561C20ABF
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 11:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60423716C;
	Thu, 28 Sep 2023 11:05:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702C535896
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 11:05:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EAB7C433C9;
	Thu, 28 Sep 2023 11:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695899148;
	bh=/OzpYTerhvIxS1I7NYNGCj7AfHI9vs2n0+hMzd5zjnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DuP/wv+atLxYolVz3TsVy7tiJ9223Z4WvylhKVREmBxsCU+CN1xVxwsq/2PSJlKEj
	 0SeFCWDbJDEV2ld8iYUItZxaNPQKwnCASz+Napuig4CEsneZ1BjStWwJ4HAb+OA7cy
	 SC9iG6X9UH80RRDJ1thj83wDn1k8f+8TcsKMLv9fjOR20LSA6H5T9oflMf7xc2GvJF
	 O+eaXZLTN+H3mhRL9ttNl/zo0SzNSOVAPN7PO6IE8z90ITg/kKteuIEqbh6j7HpWoT
	 JbjgE6gSfyISnBqy3vYQBrzvpMobxvgl/MqrGENhf1ZBiEdRbysBwAoi7vgbpwg+Lw
	 0YxsoKatJ28nA==
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
Subject: [PATCH 79/87] kernel/bpf: convert to new inode {a,m}time accessors
Date: Thu, 28 Sep 2023 07:03:28 -0400
Message-ID: <20230928110413.33032-78-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928110413.33032-1-jlayton@kernel.org>
References: <20230928110300.32891-1-jlayton@kernel.org>
 <20230928110413.33032-1-jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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



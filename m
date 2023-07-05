Return-Path: <bpf+bounces-4114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEC8748CFF
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 21:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BE562810B1
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 19:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4841014ABD;
	Wed,  5 Jul 2023 19:05:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F28620
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 19:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132EAC433C7;
	Wed,  5 Jul 2023 19:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688583939;
	bh=fuAcROkTvzWt2oLhwWrBRUVTBdgYfzuMksRnIzfqmIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C6fBOQcWDc/pi/H95I+kf1JujNXMjelHZVfb8qt4mTiNkNM6c6jDvFKaihRMDr5AG
	 ZbTxTPNng7DHr+2qgsCcMoh1vXTuuBrUh60Kz20uVdmvRFACmim8lw7S/nX74+8Phi
	 JVojm6xelMYsFECol+OmTAfJiVC6IOtTOqRg8StKBa2mUapqgcgeyk0OsG0DiJHMxq
	 F5iUXroxJyxAh6dglCanl133Fy67F9KKjMrbY9vxv4eHozCZojPMr5mF8u78WGKdru
	 zc/SidxREFDoR8sGbx2kwknTcaksqY+qzmc7U7+0UXqNqwFI21TmSKnMuG75Iw5F0i
	 uiuomrNVRF2Hw==
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2 86/92] bpf: convert to ctime accessor functions
Date: Wed,  5 Jul 2023 15:01:51 -0400
Message-ID: <20230705190309.579783-84-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705190309.579783-1-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In later patches, we're going to change how the inode's ctime field is
used. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 kernel/bpf/inode.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 4174f76133df..99d0625b6c82 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -118,9 +118,8 @@ static struct inode *bpf_get_inode(struct super_block *sb,
 		return ERR_PTR(-ENOSPC);
 
 	inode->i_ino = get_next_ino();
-	inode->i_atime = current_time(inode);
+	inode->i_atime = inode_set_ctime_current(inode);
 	inode->i_mtime = inode->i_atime;
-	inode->i_ctime = inode->i_atime;
 
 	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
 
@@ -148,8 +147,7 @@ static void bpf_dentry_finalize(struct dentry *dentry, struct inode *inode,
 	d_instantiate(dentry, inode);
 	dget(dentry);
 
-	dir->i_mtime = current_time(dir);
-	dir->i_ctime = dir->i_mtime;
+	dir->i_mtime = inode_set_ctime_current(dir);
 }
 
 static int bpf_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-- 
2.41.0



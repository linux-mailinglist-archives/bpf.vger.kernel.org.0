Return-Path: <bpf+bounces-3033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD97A7387B8
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 16:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3A651C20EE9
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 14:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977D918C1E;
	Wed, 21 Jun 2023 14:49:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47858F9DE
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 14:49:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72641C433C0;
	Wed, 21 Jun 2023 14:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687358982;
	bh=lRNOsnrBPUjv4L/g1gjVfCiRbZ+F6XeUXgjCMmQXIRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m+y2qDE/qDDLMWOZuIBh7Nvb9leyinmxQqHYG2BeojfL+wM+4CnM1cf0enDuIZlOM
	 /Fi7rgJ2bO5MIABG0w2mXexG7aF80adZorF/IVP1jM1T3evqwveCtmEmQi4tin1Ec7
	 0z29faQTyUrBE9U/i5qcfE+xzp+o+JQbgu0vAnDbJ4tYGVJoJyqaSZeo/IT++hlbC+
	 kY9WWoiptHDbz4jG3pwHQt6fM/0AvWjBExdyIsOZD4Ay3VWwhVc9KeKHY6QGnvp+kM
	 9wcB9h/KEpgJymelKoVRiEirPZsLMweswuaSADmoWBH60OhjSgoQlSfIL+2xVfdeHV
	 33c+N8iUIT+vg==
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
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 73/79] bpf: switch to new ctime accessors
Date: Wed, 21 Jun 2023 10:46:26 -0400
Message-ID: <20230621144735.55953-72-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621144735.55953-1-jlayton@kernel.org>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In later patches, we're going to change how the ctime.tv_nsec field is
utilized. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 kernel/bpf/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 4174f76133df..d4489bb761df 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -120,7 +120,7 @@ static struct inode *bpf_get_inode(struct super_block *sb,
 	inode->i_ino = get_next_ino();
 	inode->i_atime = current_time(inode);
 	inode->i_mtime = inode->i_atime;
-	inode->i_ctime = inode->i_atime;
+	inode_ctime_set(inode, inode->i_atime);
 
 	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
 
@@ -149,7 +149,7 @@ static void bpf_dentry_finalize(struct dentry *dentry, struct inode *inode,
 	dget(dentry);
 
 	dir->i_mtime = current_time(dir);
-	dir->i_ctime = dir->i_mtime;
+	inode_ctime_set(dir, dir->i_mtime);
 }
 
 static int bpf_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-- 
2.41.0



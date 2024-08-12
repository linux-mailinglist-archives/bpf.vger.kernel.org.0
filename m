Return-Path: <bpf+bounces-36903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 948AA94F481
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 18:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF843B2567E
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 16:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2A7187345;
	Mon, 12 Aug 2024 16:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+XXkMkq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88DB16D9B8;
	Mon, 12 Aug 2024 16:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723480270; cv=none; b=k2UgC6Z1qEgJmdDcuJfs6gQKPt82w4dWm5gvia9g0U5OztMf7DLZPoaTQFV9kCMlM2SKCi0m5XaRJZiZLQrpF8mlQXIjMZHDaZI5RiP9XK2DypHMHHrq0+2y+lVEqbZ4GMIB1law7VQLUyv776D4Zw+WTa0nRxkg+suDKk4RI8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723480270; c=relaxed/simple;
	bh=jd249FtY84TEbFzZDdzEu85GmiebbP7U4lN6e95Q+AM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=c0i7jLOw/YbswmjHcN0p8ATOtqw900fG96h/gSXgVC4hVtXuEmpp5odcaKueDlRpPHm5dQPpL25MleAzdNwho8sHxGSg6cEBWqjwjNlWkME74k/XKOWPD98VnJxotAcwYSeWxWInjX83IbproWulbndC3U+OG6u/l7gE1WmPJtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+XXkMkq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD712C32782;
	Mon, 12 Aug 2024 16:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723480270;
	bh=jd249FtY84TEbFzZDdzEu85GmiebbP7U4lN6e95Q+AM=;
	h=From:Date:Subject:To:Cc:From;
	b=C+XXkMkq1AFvCD3NfH+EyndSowOyQ+TBpi/XxH8TdsGWFzgXDaMEL3S+JkJgDznP4
	 M7TmZbvcWqydmcot9eZf2oRjljCU4qS2j4MGm3Zl+B9GUStbbBJUVdcOlwX/AObAuN
	 jQr6JalCvsSBLOyMvwRKoO36aEyFl0pbNh4mOmIJ+Tajj3y/Y3+16Dyiqn/0fKPrmp
	 IJJI/CoS4gvlSAopf/IiJ1Ce5U/Dw7h6LYvaKGVXo+uHV4A6sOg+s2/yhFv2Fdy4nt
	 ek+dzoB3qTzofbYXUi29ceYvTm2khwhUavgpiryhJTFQ4uHl+n55jQ8tjMT+I3v13d
	 0WxPnDQXkHKvg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 12 Aug 2024 12:30:52 -0400
Subject: [PATCH] btrfs: update target inode's ctime on unlink
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240812-btrfs-unlink-v1-1-ee5c2ef538eb@kernel.org>
X-B4-Tracking: v=1; b=H4sIALs4umYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDC0Mj3aSSorRi3dK8nMy8bF1zcyNLYxMjw1QTQzMloJaCotS0zAqwcdG
 xtbUAM9LYcF4AAAA=
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1027; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=jd249FtY84TEbFzZDdzEu85GmiebbP7U4lN6e95Q+AM=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmujjHP8bPV2lqmyH26xa2J8JKkdXoyALVoy3zJ
 RdRM6NcgPmJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZro4xwAKCRAADmhBGVaC
 Ff4UD/9xcba1wQRlkeRem8ijywl/o1o4cTTKCFRScXD8ivlTG1trZ/u6+vJTUt3LxdpkS5Reh7u
 hxrE9ifGm/J3k9YsyH4QPaVtTPwcIcT4SFxITxXRCe+jwJQtRzRAVJD53m6QvztraMoR457qcjA
 lBIYeiNRc47OTG9Ji2idmFlzsGsvdToa+H3rJdZ16SeaI9jkfafccAuvTUE6QmKwa3SGtUbdxdd
 iTTLuCr7zZSDpMxc54Xl1qP/53ze8eIO0qVufQuSxGh2opahSjB18ke7whbZNcXj/P3a9TGak2I
 H0s23YQIq4oihp90w53Zv2vE4CRCABan6Dtwv99FjPVnNVR4KZ1JSJi9lKcK4amkkzF8nMKNN5W
 fv9Ow8OFDS4kcfX3xWj5CAZUALyfEEZG6qHsmE8m+u0G9jUYqrTLqAMs/YwTlkeHiFjjLVISbAJ
 FHC4sk6YZLfX1fR+IWIYoWyVxSi5cIAEBYMyRxAKLf+3kWh7gJiNDxbj7wPL4RIQEN4Ypc5Y7Cr
 g+WHYJKC+jrFfFYmI2/oeRIgkXRJzUh9qGBDCUEqdWMhhq85+n5NuIT4pV8jGvMUTi0oo/MsyQm
 yhYZavrHU0gJVkr35IOr4VNsP1FrxYUqreTYPZH+zP+r3Z5lOGG1n1VbfTQj7lscasymGcGhhLw
 fIFY7cfizgXwP5A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Unlink changes the link count on the target inode. POSIX mandates that
the ctime must also change when this occurs.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Found using the nfstest_posix testsuite with knfsd exporting btrfs.
---
 fs/btrfs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 333b0e8587a2..b1b6564ab68f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4195,6 +4195,7 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 
 	btrfs_i_size_write(dir, dir->vfs_inode.i_size - name->len * 2);
 	inode_inc_iversion(&inode->vfs_inode);
+	inode_set_ctime_current(&inode->vfs_inode);
 	inode_inc_iversion(&dir->vfs_inode);
  	inode_set_mtime_to_ts(&dir->vfs_inode, inode_set_ctime_current(&dir->vfs_inode));
 	ret = btrfs_update_inode(trans, dir);

---
base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
change-id: 20240812-btrfs-unlink-77293421e416

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>



Return-Path: <bpf+bounces-9176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AEE791511
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 11:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23487280FD2
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 09:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335261C2D;
	Mon,  4 Sep 2023 09:51:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4E37E;
	Mon,  4 Sep 2023 09:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B855FC433C8;
	Mon,  4 Sep 2023 09:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693821110;
	bh=u+xgETcg23UcZvAsSNoTKQTpoQDzWhh5CjfKLhaLfCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GrBGNC0GUAEP92SVXDSYgvIeyQhEWu5ohv1UZxcq2j4jmPnZMVKVXd7PcLbrec+YC
	 YwtxwrDnv2HUbxAauD5LP+iZpv1hgd3J7v5N5AFier00fzuLYjkXSyalNCln662qcL
	 MOkKZFmfbFH61oxgNm/1PDUalOPIF/dG8en4lktLAOJKNet2WlaOi4SDB1WMRo8c1E
	 Fx1ryvNUFvNi9qlIPKbaeTXq/1cJbp6vtXGsOglG9wRy2wFIevByTxjIps/B3VRZZs
	 ZTGcqJO6bRRRPVV2zC3wt54/lylE+o7sVECKL3QKI1/oWONjJaYkFRkcM0vOKzehKT
	 ynVVLBmYA4BCQ==
Date: Mon, 4 Sep 2023 11:51:40 +0200
From: Christian Brauner <brauner@kernel.org>
To: Hao Xu <hao.xu@linux.dev>
Cc: io-uring@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Stefan Roesch <shr@fb.com>, Clay Harris <bugs@claycon.org>,
	Dave Chinner <david@fromorbit.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-cachefs@redhat.com,
	ecryptfs@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org, codalist@coda.cs.cmu.edu,
	linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
	linux-mm@kvack.org, linux-nilfs@vger.kernel.org,
	devel@lists.orangefs.org, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, linux-mtd@lists.infradead.org,
	Wanpeng Li <wanpengli@tencent.com>
Subject: Re: [PATCH 07/11] vfs: add nowait parameter for file_accessed()
Message-ID: <20230904-trennen-gewettert-0b2dc5ba60bc@brauner>
References: <20230827132835.1373581-1-hao.xu@linux.dev>
 <20230827132835.1373581-8-hao.xu@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230827132835.1373581-8-hao.xu@linux.dev>

On Sun, Aug 27, 2023 at 09:28:31PM +0800, Hao Xu wrote:
> From: Hao Xu <howeyxu@tencent.com>
> 
> Add a boolean parameter for file_accessed() to support nowait semantics.
> Currently it is true only with io_uring as its initial caller.
> 
> Signed-off-by: Hao Xu <howeyxu@tencent.com>
> ---
>  arch/s390/hypfs/inode.c | 2 +-
>  block/fops.c            | 2 +-
>  fs/btrfs/file.c         | 2 +-
>  fs/btrfs/inode.c        | 2 +-
>  fs/coda/dir.c           | 4 ++--
>  fs/ext2/file.c          | 4 ++--
>  fs/ext4/file.c          | 6 +++---
>  fs/f2fs/file.c          | 4 ++--
>  fs/fuse/dax.c           | 2 +-
>  fs/fuse/file.c          | 4 ++--
>  fs/gfs2/file.c          | 2 +-
>  fs/hugetlbfs/inode.c    | 2 +-
>  fs/nilfs2/file.c        | 2 +-
>  fs/orangefs/file.c      | 2 +-
>  fs/orangefs/inode.c     | 2 +-
>  fs/pipe.c               | 2 +-
>  fs/ramfs/file-nommu.c   | 2 +-
>  fs/readdir.c            | 2 +-
>  fs/smb/client/cifsfs.c  | 2 +-
>  fs/splice.c             | 2 +-
>  fs/ubifs/file.c         | 2 +-
>  fs/udf/file.c           | 2 +-
>  fs/xfs/xfs_file.c       | 6 +++---
>  fs/zonefs/file.c        | 4 ++--
>  include/linux/fs.h      | 5 +++--
>  mm/filemap.c            | 8 ++++----
>  mm/shmem.c              | 6 +++---
>  27 files changed, 43 insertions(+), 42 deletions(-)
> 
> diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
> index ee919bfc8186..55f562027c4f 100644
> --- a/arch/s390/hypfs/inode.c
> +++ b/arch/s390/hypfs/inode.c
> @@ -157,7 +157,7 @@ static ssize_t hypfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  	if (!count)
>  		return -EFAULT;
>  	iocb->ki_pos = pos + count;
> -	file_accessed(file);
> +	file_accessed(file, false);

Why? If all you do is skip atime update anyway then just add something
like:

bool file_needs_atime(struct file *file)
{
       return !(file->f_flags & O_NOATIME) &&
              atime_needs_update(&file->f_path, d_inode(path->dentry));
}

and then

if (file_needs_atime(file) && IOURING_WANTS_ASYNC)
	return -EAGAIN;

instead of touching all this code.


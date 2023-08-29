Return-Path: <bpf+bounces-8916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7019578C4C7
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 15:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1B4D1C20A5D
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 13:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE2B156FA;
	Tue, 29 Aug 2023 13:05:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E2214AB3;
	Tue, 29 Aug 2023 13:05:29 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFCA184;
	Tue, 29 Aug 2023 06:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RchKoATVAdQvPJfSjQ7igQ4w+5FVPwMefhSLf5vYpSI=; b=Q3QmRgXTehCOZCVueX+FS2Az5N
	PVqmWnEC5SOyltZJNMDkbuPj3BuxIKobdTkUGJdkwt9An23qab7RWIeUTJvkRcM5ZQw7A9VajHpfv
	K7r2l3ZZ2pGC+tetoYQU12TmTvlZI3sm3ayVKtCD8x7/yd2j9SuUz7gnHbMb8LXGAJC6qfT96aNHD
	/+KAN9szQKpq1/b+zh8evtWeBszURne3cpQtIIZ5DUWss+rP/RkNTx5Y/tCCASZPZaSLUEyAkYJWx
	0SrCGJoWwn5s3UmnWTZbObVE6DrneAPDreiurlPZ6M22SpYEkwQtVmJFqXgm29PIZAfXouLOFvP7I
	44OUuuBQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qayP8-006i8Z-JC; Tue, 29 Aug 2023 13:05:10 +0000
Date: Tue, 29 Aug 2023 14:05:10 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Hao Xu <hao.xu@linux.dev>
Cc: io-uring@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
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
Subject: Re: [PATCH 02/11] xfs: add NOWAIT semantics for readdir
Message-ID: <ZO3tBqJLtRwSYrEr@casper.infradead.org>
References: <20230827132835.1373581-1-hao.xu@linux.dev>
 <20230827132835.1373581-3-hao.xu@linux.dev>
 <ZOu1xYS6LRmPgEiV@casper.infradead.org>
 <ca10040f-b7fa-7c43-1c89-6706d13b2747@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca10040f-b7fa-7c43-1c89-6706d13b2747@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 29, 2023 at 03:41:43PM +0800, Hao Xu wrote:
> On 8/28/23 04:44, Matthew Wilcox wrote:
> > > @@ -391,10 +401,17 @@ xfs_dir2_leaf_getdents(
> > >   				bp = NULL;
> > >   			}
> > > -			if (*lock_mode == 0)
> > > -				*lock_mode = xfs_ilock_data_map_shared(dp);
> > > +			if (*lock_mode == 0) {
> > > +				*lock_mode =
> > > +					xfs_ilock_data_map_shared_generic(dp,
> > > +					ctx->flags & DIR_CONTEXT_F_NOWAIT);
> > > +				if (!*lock_mode) {
> > > +					error = -EAGAIN;
> > > +					break;
> > > +				}
> > > +			}
> > 
> > 'generic' doesn't seem like a great suffix to mean 'takes nowait flag'.
> > And this is far too far indented.
> > 
> > 			xfs_dir2_lock(dp, ctx, lock_mode);
> > 
> > with:
> > 
> > STATIC void xfs_dir2_lock(struct xfs_inode *dp, struct dir_context *ctx,
> > 		unsigned int lock_mode)
> > {
> > 	if (*lock_mode)
> > 		return;
> > 	if (ctx->flags & DIR_CONTEXT_F_NOWAIT)
> > 		return xfs_ilock_data_map_shared_nowait(dp);
> > 	return xfs_ilock_data_map_shared(dp);
> > }
> > 
> > ... which I think you can use elsewhere in this patch (reformat it to
> > XFS coding style, of course).  And then you don't need
> > xfs_ilock_data_map_shared_generic().
> 
> How about rename xfs_ilock_data_map_shared() to xfs_ilock_data_map_block()
> and rename xfs_ilock_data_map_shared_generic() to
> xfs_ilock_data_map_shared()?
> 
> STATIC void xfs_ilock_data_map_shared(struct xfs_inode *dp, struct
> dir_context *ctx, unsigned int lock_mode)
> {
>  	if (*lock_mode)
>  		return;
>  	if (ctx->flags & DIR_CONTEXT_F_NOWAIT)
>  		return xfs_ilock_data_map_shared_nowait(dp);
>  	return xfs_ilock_data_map_shared_block(dp);
> }

xfs_ilock_data_map_shared() is used for a lot of things which are not
directories.  I think a new function name is appropriate, and that
function name should include the word 'dir' in it somewhere.


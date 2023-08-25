Return-Path: <bpf+bounces-8616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D787788B86
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 16:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F9F91C20BB1
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 14:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3990C10790;
	Fri, 25 Aug 2023 14:20:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DA6C8CE;
	Fri, 25 Aug 2023 14:20:53 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30AF2718;
	Fri, 25 Aug 2023 07:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rIMc/jDCj9ILMqoJd0dO659w/9cB73A1MIGl7MCNQc0=; b=oBoPRF9uQlcnzO+kvA9HXiHIxh
	1BCZOYk+GNL3b9Hbl9e0kK321R7GUMuXBq5CnzZVygX8jax4dLYLnGd1XSzW1m9qVXov6cTXOpVyv
	sv5l1EBw3uu95Jxon5Sw3wlu1qTTRFkBQCTr+N8L/Prb1jdIi5jstgZjfRsnuOwWr9LDfkxjeCY5c
	UoI4nSwH2jPxj2QMMHZp0Wkb5xy7QvRuP3ObBs4CYLKVGqr6YBri4brVlX/zJEjbKcNGc0kRvuWzw
	6Da7DA+BObM8TzfQI+r1SxtKCOrEiJNsg27vpqxgEagx4gi10g2HUFqfKuMQw4f6GgzpXJkYlNle8
	RUhWro7w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qZXfd-00HYsg-Qa; Fri, 25 Aug 2023 14:20:17 +0000
Date: Fri, 25 Aug 2023 15:20:17 +0100
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
Subject: Re: [PATCH 12/29] xfs: enforce GFP_NOIO implicitly during nowait
 time update
Message-ID: <ZOi4oV7Ho3y0106O@casper.infradead.org>
References: <20230825135431.1317785-1-hao.xu@linux.dev>
 <20230825135431.1317785-13-hao.xu@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825135431.1317785-13-hao.xu@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 25, 2023 at 09:54:14PM +0800, Hao Xu wrote:
> +++ b/fs/xfs/xfs_iops.c
> @@ -1037,6 +1037,8 @@ xfs_vn_update_time(
>  	int			log_flags = XFS_ILOG_TIMESTAMP;
>  	struct xfs_trans	*tp;
>  	int			error;
> +	int			old_pflags;
> +	bool			nowait = flags & S_NOWAIT;
>  
>  	trace_xfs_update_time(ip);
>  
> @@ -1049,13 +1051,18 @@ xfs_vn_update_time(
>  		log_flags |= XFS_ILOG_CORE;
>  	}
>  
> +	if (nowait)
> +		old_pflags = memalloc_noio_save();
> +
>  	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_fsyncts, 0, 0, 0, &tp);

This is an abuse of the memalloc_noio_save() interface.  You shouldn't
be setting it around individual allocations; it's the part of the kernel
which decides "I can't afford to do I/O" that should be setting it.
In this case, it should probably be set by io_uring, way way way up at
the top.

But Jens didn't actually answer my question about that:

https://lore.kernel.org/all/ZMhZh2EYPMH1wIXX@casper.infradead.org/



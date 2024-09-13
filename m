Return-Path: <bpf+bounces-39799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DC49777AE
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 06:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A75B81F25905
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 04:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254D01D27A7;
	Fri, 13 Sep 2024 04:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="urLiEuAX"
X-Original-To: bpf@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD5E3EA64;
	Fri, 13 Sep 2024 04:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726200045; cv=none; b=uLhibFLboIVpnunwWDl7xphTiN5oHpfXn5vG7l/PslbvDDpYf2eNMkieK7IifBOuafqMd6h17b2rDsSG1BJOEpZH8Yus6gJQ5vYttlo1afQSF9FyTnO1bLIzDJUMw/Cpckcr0r0f0qmyMkO7oFn9ddPY3CIV2Q9EAAMgpesbcb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726200045; c=relaxed/simple;
	bh=NDdDwRKXFJ3ocb6cN2CztDmPZDA7oAIZ3KD1av78vT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdJRJvbZ4mSXu1SHo9gx+NIwO+WHU9TGM4VS/pxS28uOziSJycMzHzsGL5rySdtNtaXuPbeYol3NcacilcLo+FHoTHgRPyBTY6yj+X/CVL2VwHGNlNUpwHlER1Qp3a0tZ1tdWuoQeYNe/qIzzm7xleCnqkBnl3z4cnkKXo7ZQc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=urLiEuAX; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=J3qNUqZNVfiEFOTw9vbZilF7Sw8A1fnMeukG9fY96Hc=; b=urLiEuAX8Z5EV2SFvXDVz0TGeZ
	FXG02diij3n5guLGpivutfmnI+QUlbneHLpgfJ1wgmR/voRts4QyOL+iuDgzuyEcwLTKBrvxMMwPT
	CIPxmtej9k7rIkrS7VK6vybr5lkKwHch7dKSdZAmP50aDYebwrD7zvfAObXnlRLCmEerZzezRUPKc
	YcHn7VLr76YO2TcgyZ5vXSYvGDRICj8nA2xGlXHsRzfbuGTUVPARey6d8I2LxcwlJiysIkALhTESJ
	PgSOHobz6E1oc7ycbYJM1hv5zD50juaf9HiOjJMVjOe0CCoELa7hHh7v6GDitk569bLWCjT/CYN/3
	+hVaU4MQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1soxU6-0000000BsPr-3aRW;
	Fri, 13 Sep 2024 04:00:38 +0000
Date: Fri, 13 Sep 2024 05:00:38 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	David Chinner <david@fromorbit.com>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
Message-ID: <20240913040038.GA2825852@ZenIV>
References: <20240913135551.4156251c@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913135551.4156251c@canb.auug.org.au>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Sep 13, 2024 at 01:55:51PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the bpf-next tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> fs/xfs/xfs_exchrange.c: In function 'xfs_ioc_commit_range':
> fs/xfs/xfs_exchrange.c:938:19: error: 'struct fd' has no member named 'file'
>   938 |         if (!file1.file)
>       |                   ^
> fs/xfs/xfs_exchrange.c:940:26: error: 'struct fd' has no member named 'file'
>   940 |         fxr.file1 = file1.file;
>       |                          ^
> 
> Caused by commit
> 
>   1da91ea87aef ("introduce fd_file(), convert all accessors to it.")
> 
> interacting with commit
> 
>   398597c3ef7f ("xfs: introduce new file range commit ioctls")
> 
> I have applied the following patch for today.
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 13 Sep 2024 13:53:35 +1000
> Subject: [PATCH] fix up 3 for "introduce fd_file(), convert all accessors to
>  it."
> 
> interacting with commit "xfs: introduce new file range commit ioctls"
> from the xfs tree.

... and the same for io_uring/rsrc.c, conflict with "io_uring: add IORING_REGISTER_COPY_BUFFERS method".

FWIW, that (sub)series is in viro/vfs.git#for-next - I forgot to put it
there, so when bpf tree reorgs had lost their branch on top of that thing,
the conflict fixes got dropped from -next.  Sorry... ;-/


Return-Path: <bpf+bounces-37180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28393951DB6
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 16:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD9531F222A9
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 14:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FD71B3F1E;
	Wed, 14 Aug 2024 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzIPpQJF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF87E1B374E;
	Wed, 14 Aug 2024 14:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723647060; cv=none; b=lSVf+LNEuFwBSRzhUaVvmPik7bBUUITqke77QVsYjJF98ZUMtjfP0OnyCGudfpIkisuLx49uqXwGsDk1wSTqmIk26xBRog1IL8Gk9HTep9J49W/OoM8y2H7hfDHuIaUx4U5J7kXBhprrJDD5/pjzy7eCOWYDAjzKYpT5LyrYn3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723647060; c=relaxed/simple;
	bh=N0f1HZX04ynIZfeTBMvBaRDvfUH0YrPtxLoIFyTZvJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6GylVwaRDX8XXoDerKDzSKKej00mdm+tXQGiXO7CEEAN5UuMjPnfy4ee+DMCIwmFIRAsl54a6UyG1q0XSODVBxeQn47I0F+V7BI0iqnuy2eN8xYZVVMgL7XgWXgpucx8nmyitjxOat7nY/3qKpmDp4m2iQt4jotjIHbLAmcuxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzIPpQJF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C903C116B1;
	Wed, 14 Aug 2024 14:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723647059;
	bh=N0f1HZX04ynIZfeTBMvBaRDvfUH0YrPtxLoIFyTZvJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GzIPpQJFTzet4Fe5aXSfHcysIoe5/CP+VBNQ/ooVANO0D03QEHEyptfVY1lVCB5t5
	 ua53mdez7GYyHhRMQSIWk58EnAuE5HuZFCaig+K8EmHRRofulDjgHiaDDXkWOcAP94
	 /N9UwmiHqPfPuItco2C1w0zt16kpLJ6ZRHZ2s3aWmtTkcmUkFyo7x6sXICHiTJR3OA
	 1rb8ILGzP7oxm3W3Q4ZpxydMFfnIr+v+2UzFGx2eC/m3SF5pMj1WRQICRcX19LX3x4
	 eUMR8Jv1IIEREOiNmA3CjxrCDir4M3FlwUXSK1MPVNqOzEVInJuWN20MZF0XZCZNe5
	 MvmVQF3PZBR1A==
Date: Wed, 14 Aug 2024 16:50:54 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
Message-ID: <20240814-virtuell-diktieren-a08337b312fb@brauner>
References: <20240814112504.42f77e3c@canb.auug.org.au>
 <20240814014157.GM13701@ZenIV>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240814014157.GM13701@ZenIV>

On Wed, Aug 14, 2024 at 02:41:57AM GMT, Al Viro wrote:
> On Wed, Aug 14, 2024 at 11:25:04AM +1000, Stephen Rothwell wrote:
> >  	if (at_flags & AT_EMPTY_PATH && vfs_empty_path(dfd, pathname)) {
> >  		CLASS(fd, f)(dfd);
> > -		if (!f.file)
> > +		if (!fd_file(f))
> 
> 		if (fd_empty(f))
> 
> actually, and similar for the rest of it.  Anyway, that'll need to be
> sorted out in vfs/vfs.git; sorry about the delay.

You should already have a never rebase branch for the basic
infrastructure. I can just merge that. But I'll just make my usual note
and just provide the required fixups when I send Linus a pr. That'll
work too. /me trying not to have his brain melted by the heat.


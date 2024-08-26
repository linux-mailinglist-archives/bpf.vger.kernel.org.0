Return-Path: <bpf+bounces-38099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA7E95FA59
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 22:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE4A9B21981
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 20:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE54199EA2;
	Mon, 26 Aug 2024 20:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7rny3nI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43A0811E2;
	Mon, 26 Aug 2024 20:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724702679; cv=none; b=qb4AhDJnvo+4sP0Bf8MweamYvIZZ9i91T8XYgDv8+2rsME/rBtDLuDauXdLr8ey9s9nPydhcHPngQjRVWtXWFsZmZWV9Pz1IUm0vqt7lkv807Uu/EUm1U3T9fo58RbqIluQj3tPUdV5tV00g89uP/y9Y0XmYln1Z/0c48kxlavs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724702679; c=relaxed/simple;
	bh=AkihPQS8bQoOGzU1lf5ytFhEOS/7IsKOwAe50NQNpj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayuUPZS0ujzhq5QZDo5g43OUaNBeX1cPAzvLG5f48zabT47+8krkn6AI66zEmcXiS28J009PFjD44hq1AQ/iOqIV7ZwcSB0OsImvQohUwByW3kTgRD0wr/MSP9hWfl6EOkriMdDMGC9yEIvfVBv622KcG6SnKjOPZdIKfpnQlAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7rny3nI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19A7C4FF0E;
	Mon, 26 Aug 2024 20:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724702678;
	bh=AkihPQS8bQoOGzU1lf5ytFhEOS/7IsKOwAe50NQNpj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B7rny3nIJQ9zu5civdgfC7uSj83r3D2A6ZU5dsdSkoHtSyQ2WIm1B1tOKOP5OXK63
	 QKddcND3JDfmYIxjGfoz5dNx3kHim9VQ5J0NXEJ8/BMW3PNg3WdfgUZQtgdnlFM875
	 r3p9xyKeDGuvkHt6iCusYk1Db8VV6X7CFdWsae4t6hFjSrVNcroFCWoDYrfHPfCxnr
	 kzbKKujvkvGXrgWgye1Bb3+9fXnEzLTamvFjwatBmAgTYvQoAxMrA1Xt9qaXdcRuTj
	 H6g+KNuMKQRlo6utDjOIgGCgoKjfLTG654GBsxvHbxEXQ7q6mA858969MUP+HzW8sI
	 g4X1tUbV0EzTQ==
Date: Mon, 26 Aug 2024 17:04:35 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Phil Auld <pauld@redhat.com>
Cc: Sedat Dilek <sedat.dilek@gmail.com>, Jiri Slaby <jirislaby@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, dwarves@vger.kernel.org,
	Jiri Olsa <olsajiri@gmail.com>, masahiroy@kernel.org,
	linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, linux-kbuild@vger.kernel.org,
	bpf@vger.kernel.org, msuchanek@suse.com
Subject: Re: [RFC] kbuild: bpf: Do not run pahole with -j on 32bit userspace
Message-ID: <Zszf0_5DKuscmDWi@x1>
References: <ZsSpU5DqT3sRDzZy@krava>
 <523c1afa-ed9d-4c76-baea-1c43b1b0c682@kernel.org>
 <c2086083-4378-4503-b3e2-08fb14f8ff37@kernel.org>
 <7ebee21d-058f-4f83-8959-bd7aaa4e7719@kernel.org>
 <a45nq7wustxrztjxmkqzevv3mkki5oizfik7b24gqiyldhlkhv@4rpy4tzwi52l>
 <ZsdYGOS7Yg9pS2BJ@x1>
 <f170d7c2-2056-4f47-8847-af15b9a78b81@kernel.org>
 <Zsy1blxRL9VV9DRg@x1>
 <CA+icZUWMxzAFtr8vsUUQ9OCR68K=F6d6MANx8HMTQntq494roA@mail.gmail.com>
 <20240826184818.GC117125@pauld.westford.csb>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240826184818.GC117125@pauld.westford.csb>

On Mon, Aug 26, 2024 at 02:48:18PM -0400, Phil Auld wrote:
> On Mon, Aug 26, 2024 at 08:42:10PM +0200 Sedat Dilek wrote:
> > On Mon, Aug 26, 2024 at 7:03 PM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Mon, Aug 26, 2024 at 10:57:22AM +0200, Jiri Slaby wrote:
> > > > On 22. 08. 24, 17:24, Arnaldo Carvalho de Melo wrote:
> > > > > On Thu, Aug 22, 2024 at 11:55:05AM +0800, Shung-Hsi Yu wrote:
> > > > > I stumbled on this limitation as well when trying to build the kernel on
> > > > > a Libre Computer rk3399-pc board with only 4GiB of RAM, there I just
> > > > > created a swapfile and it managed to proceed, a bit slowly, but worked
> > > > > as well.
> > > >
> > > > Here, it hits the VM space limit (3 G).
> > >
> > > right, in my case it was on a 64-bit system, so just not enough memory,
> > > not address space.
> > >
> > > > > Please let me know if what is in the 'next' branch of:
> > >
> > > > > https://git.kernel.org/pub/scm/devel/pahole/pahole.git
> > >
> > > > > Works for you, that will be extra motivation to move it to the master
> > > > > branch and cut 1.28.
> > >
> > > > on 64bit (-j1):
> > > > * master: 3.706 GB
> > > > (* master + my changes: 3.559 GB)
> > > > * next: 3.157 GB
> > >
> > > > on 32bit:
> > > >  * master-j1: 2.445 GB
> > > >  * master-j16: 2.608 GB
> > > >  * master-j32: 2.811 GB
> > > >  * next-j1: 2.256 GB
> > > >  * next-j16: 2.401 GB
> > > >  * next-j32: 2.613 GB
> > > >
> > > > It's definitely better. So I think it could work now, if the thread count
> > > > was limited to 1 on 32bit. As building with -j10, -j20 randomly fails on
> > > > random machines (32bit processes only of course). Unlike -j1.
> > >
> > > Cool, I just merged a patch from Alan Maguire that should help with the
> > > parallel case, would be able to test it? It is in the 'next' branch:
> > >
> > > ⬢[acme@toolbox pahole]$ git log --oneline -5
> > > f37212d1611673a2 (HEAD -> master) pahole: Teduce memory usage by smarter deleting of CUs
> > >
> > 
> > *R*edzce? memory usage ...
> >
> 
> If you meant that further typo it's golden, and if not the irony is rich :)
> 
> Either way this is my favorite email of the day!

Hahaha, I went to uppercase what comes after the colon and introduced
that typo ;-)

Faxing it....

- Arnaldo


Return-Path: <bpf+bounces-33227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC7C91A024
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 09:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7098F1F2448D
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 07:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2454D8CF;
	Thu, 27 Jun 2024 07:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEeZNoq8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A264D8B9;
	Thu, 27 Jun 2024 07:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719472456; cv=none; b=FChjuQO6YUqAd07ZeeiqdzoytMsgaEbrOW5LyfMh+yoZs4K1gdqNmRwoguB+w41kiA2IIIL4QVBmtZYKaul4FWakzYf61KTYf5SPpGMJawPuCqoJbwQ7HrgJC+wQ2npbXQHR7UQwpk5UQqV6WhILbBGsTLPA+gYI+4Z3gUGw3f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719472456; c=relaxed/simple;
	bh=heO+CZ9nver405szEFaA0YnWPRyUevAoU0f9yFseYgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tw1pJv2YaBzJXpum/TO8aV8N90XzcAKkYnoNZZyBB0poxTT09jmI8BgLb9nd6Oorz0suLBHz88AUkJ0PzJW+6d2SXunH4J8ZzMnsfepqanWN9tFeKy2DKcGJoJz8h7JH1Rwa8PCTjLXziX6+VLH93Kka7mR3wdiUFkbFyRdg6ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEeZNoq8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB8FC2BBFC;
	Thu, 27 Jun 2024 07:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719472455;
	bh=heO+CZ9nver405szEFaA0YnWPRyUevAoU0f9yFseYgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LEeZNoq8B5DHK64YBtURZYLowmWNjZI8Vziu2frq0t+7j0v3Nh9CHz2o0CM3B8/yD
	 uNJWUqVBuryBm7Y+8TqQTPP7MJHkVXFsRV8f9aZmddUcWViRIgMyssJFWe+nCQpxsN
	 LJygEWRUmQxN4WX6w5WjYfzKALxZQirliNfttoM3aZMDvJnpp7tJ+ovR2YStIkqbvi
	 nunRziwlMIQ8Vx/jeLF+MkqCTpWY+JEKrA20TA8PeejqJwCXssjeGe/dgrATFw+3GT
	 OGMncN2TmasNDz5cbXvvLC0rU2ypaY/2pQyDbaCYrRcnEvEBcopKqalBw1QoypjRns
	 iElluEN5NVaVA==
Date: Thu, 27 Jun 2024 09:14:09 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Thinker Li <thinker.li@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
Message-ID: <pe5rcpwxdb7rrnpdifpenjavfnhmtjekd5wdtq27nn4lqz377g@pox5yp25ukli>
References: <ZnB9X1Jj6c04ufC0@sirena.org.uk>
 <CAFVMQ6R8ZZE+9jWM1vhEuz2PsLyCgKhpaVD377TKEu4AfGO_iA@mail.gmail.com>
 <ud5j6hbozgg6em43volidpffykdtd2lpf32etmdiyksorl2cb4@whtseaibw2xw>
 <CAADnVQ+cJ5bga7tX9BSTC150CgXM8KQT+Z21zYE-VY-8fts6kg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+cJ5bga7tX9BSTC150CgXM8KQT+Z21zYE-VY-8fts6kg@mail.gmail.com>

On Jun 25 2024, Alexei Starovoitov wrote:
> On Tue, Jun 25, 2024 at 8:54 AM Benjamin Tissoires <bentiss@kernel.org> wrote:
> >
> > On Jun 24 2024, Thinker Li wrote:
> > > Hi Mark,
> > >
> > > I'm sorry for not getting back to you sooner. I have been traveling
> > > since my last message.
> > > I guess this patch is for the HID tree. The changes in this patch are great.
> >
> > Ok, thanks for the review. However, the need appears because there is a
> > conflicting update in the bpf tree.
> >
> > May I ask the bpf maintainers (Daniel/Alexei/Andrii) for an immutable
> > tag I could merge to so I can take this patch from Mark?
> 
> I'm not sure how that would look like.
> imo conflict is minor enough.
> When net-next/bpf-next lands in the upcoming merge window
> just provide Mark's patch as a conflict resolution suggestion
> in the cover letter of hid PR ?

I guess I can also wait for the bpf PR to come in, merge with it and add
Mark's patch at that time. It's not so much of a conflict but 2
independant changes in 2 different trees.

Anyway, we'll figure it out when we need :)

Cheers,
Benjamin


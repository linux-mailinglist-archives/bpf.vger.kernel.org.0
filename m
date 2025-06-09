Return-Path: <bpf+bounces-60039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B88BAD1965
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 09:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F3FE3AC5B8
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 07:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0D62820BD;
	Mon,  9 Jun 2025 07:53:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A3328137D;
	Mon,  9 Jun 2025 07:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749455614; cv=none; b=EdHydjxHVoTbWYWxuamN/Q5CKYlXH5YGSa1Nz7ypP3H2j1DlIX15axlPcLQIZ6Zv+kuU22uEGYeutcg90K2bsiOmzW6aok26r2mlhkOOQKvlmOXiRRIoBMQW9crbsRVXoxMyEKp8Icfw21uSd/ui/jLkCYMnQPvsBWSe201byIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749455614; c=relaxed/simple;
	bh=FGBwJPh8pEHfaqPxdlLTmzyyX6UN9HsTGGpe/TwGMbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyjrvyO1zYKmovHRQnZJVthz9hg49pzv8onaxOzUzyocGPzIggvnZUhfT4lM/jThfwGzDx079b2zcNvF6sEU7uARcSYQLE26n+VWoelMuKMWE2LrRpZVjAGA4OtxrqUigD7Y58gevcGX3GbdelX8PhiAcZR4SrjZbjmIXuN6a6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-da-684692f6e63c
Date: Mon, 9 Jun 2025 16:53:21 +0900
From: Byungchul Park <byungchul@sk.com>
To: Mina Almasry <almasrymina@google.com>
Cc: willy@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, kuba@kernel.org,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch,
	asml.silence@gmail.com, toke@redhat.com, tariqt@nvidia.com,
	edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	vishal.moola@gmail.com, netdev@vger.kernel.org
Subject: Re: [RFC v4 00/18] Split netmem from struct page
Message-ID: <20250609075321.GA59170@system.software.com>
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604032319.GA69870@system.software.com>
 <CAHS8izPNKe+3A9HAk13idouEzvePnp5Tih0GmSQNzEcsxuvoPA@mail.gmail.com>
 <20250609042255.GA43325@system.software.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250609042255.GA43325@system.software.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUzMcRzHfe/3cL9u3fw6xTeZONGY52U+DMuMfY2Zp5mh6Ue/uZuu2vWg
	GJI2RIdqHu4OJ6qr5HRUx6xSN0RIJqfU9aBsSBQ3PZBOM/332ufp9f7jw1GKTGY8p46IEbUR
	QriSldGyTs/MWa60Vaq5dbYJYLTcYCH/ZzzkNNsYMOYVI/je2yCFHvsjFq5ddVFgfJFMww9L
	HwXtD1ul4MzuoOH+sRIKWk8/ZiE1uZ+CJJtZAjXFOgYy+rIoKElslsKre0YWmm4MMtBRkUpD
	lT6XBqcuGB6axoLr6WcEdkuJBFynLrGQXmtioS3ZiaC2spUGwxEdAkupg4H+n0Y2eDK5k/tW
	Qu7qG6XEZI0lt80zSIqjliLWvBMssXanScm7uvsseXyhnyZ3bT0Sknr0C0u+tdfTpKv0NUss
	d17TpNpkl5Ie68T1/DbZkjAxXB0naucsC5WpnEmVVFSDT7zF8pFNROV8CvLgMB+EP/w4yf7j
	NPtTJgVxHM0H4PQm5C6zfCB2OHopN3vz0/H10rOMmym+kcF9WRvdPIZfhJ/lF0jdLOcB13ce
	p1OQjFPw9QjffGKihhteuOrie3p4ORAPXK6l3C6K98M5v7nhsj8+WmT4O+4xdNORVvY3mg8/
	BZcXP5K4b2LexuFCXR0znNkXPzA76DPISz9CoR+h0P9X6EcoTIjOQwp1RJxGUIcHzVYlRKjj
	Z++O1FjR0OdkHxzYbkPdNZsqEM8hpac89PxKlYIR4qITNBUIc5TSW847V6gU8jAhYb+ojdyp
	jQ0XoyuQH0crx8nnu/aFKfg9Qoy4VxSjRO2/roTzGJ+IyLOpRdkLt+zICAz+8qvNO6o65PBc
	xtzp46ddfP5QbthEg6Z39Tyhxc8/ZPHhkzBQWVn06VxS061TrnUtoTL784E1W/NnHnhwxWwo
	1E0u2NyVdWbXgYBpq1Df6AUuTfaowUlvXrR0a8a+tPWKXWWC76iG5b5xa9tzp26oKkj+ujTB
	P1ZJR6uEeTMobbTwB0SKrhM1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeXcuO46tjkvzoB/EKVRSWVHwRCGBVK9FESFZfShHntpQZ2wq
	KgTmhVLSzO6nWZNy6rQGVnNWWG3i3S6aNjWdaUpkXjIznVK5JPLbj///eX7Pl4ch5FmUL6PW
	JPBajTJWQUtIyf5tGeumC3apNnTYpaA3V9BQPpMMJf1WCvQmC4Kp2R4xfK+tp+Fu0TQB+teZ
	JPwwuwgYqhsQg9M4TMKzc1UEDFxsoCE3c46AdGupCOyFjRS8seRRcMVVTEBVWr8Y2p/oaeir
	+E3BsC2XhEahjARn3g6oM6yE6eavCGrNVSKYvlBIw+U2Aw2DmU4EbfYBEm6dzUNgrnFQMDej
	p3co8KOyLhGuFnrF2FCZiB+WBuMcRxuBK03ZNK6cLBDjD53PaNxwY47E1dbvIpybMUbjb0Pd
	JB6v6aDx3c8TImx+1EHiFkOt+IDnUcn2aD5WncRrQ0KjJCpnup043eOdbDZ/odPQCzYHeTAc
	u5krqG2mchDDkGwQd7kPuWOaXcU5HLOEm73YNdy9mkuUmwm2l+JcxQfdvILdyrWW3xe7WcYC
	1z16nsxBEkbOdiPuQZOBWCw8ucabn8jF5VXc/O02wn2LYP24kl/MYuzPZTy+9XfcY8HpKHhO
	u9mbDeReWOpF+WiZsMQkLDEJ/03CEpMBkSbkpdYkxSnVsVvW62JUKRp18voT8XGVaOE5jGfm
	L1nRVPtuG2IZpJDKoq7vVMkpZZIuJc6GOIZQeMlYZ5hKLotWpqTy2vjj2sRYXmdDfgyp8JHt
	ieSj5OwpZQIfw/Onee2/VsR4+KahcK3nE0n0PW5sdl/45CY6ddRV1C+zvBpFg2O6zDhZ6bv8
	kyOdRx5ryIDUMOncxGqftc9b8P4gufHl9b3HuupaQyvehr9Xh5lafCM/isZTRgIM2UN26YDu
	sHDHFBwi2NqtV20/r7kOjW0uzxJbRq9V+8sDhWajqenpuuUREdIiBalTKTcGE1qd8g+uJydF
	GAMAAA==
X-CFilter-Loop: Reflected

On Mon, Jun 09, 2025 at 01:22:55PM +0900, Byungchul Park wrote:
> On Thu, Jun 05, 2025 at 12:55:30PM -0700, Mina Almasry wrote:
> > On Tue, Jun 3, 2025 at 8:23 PM Byungchul Park <byungchul@sk.com> wrote:
> > >
> > > On Wed, Jun 04, 2025 at 11:52:28AM +0900, Byungchul Park wrote:
> > > > The MM subsystem is trying to reduce struct page to a single pointer.
> > > > The first step towards that is splitting struct page by its individual
> > > > users, as has already been done with folio and slab.  This patchset does
> > > > that for netmem which is used for page pools.
> > > >
> > > > Matthew Wilcox tried and stopped the same work, you can see in:
> > > >
> > > >    https://lore.kernel.org/linux-mm/20230111042214.907030-1-willy@infradead.org/
> > > >
> > > > Mina Almasry already has done a lot fo prerequisite works by luck.  I
> > > > stacked my patches on the top of his work e.i. netmem.
> > > >
> > > > I focused on removing the page pool members in struct page this time,
> > > > not moving the allocation code of page pool from net to mm.  It can be
> > > > done later if needed.
> > > >
> > > > The final patch removing the page pool fields will be submitted once
> > > > all the converting work of page to netmem are done:
> > > >
> > > >    1. converting of libeth_fqe by Tony Nguyen.
> > > >    2. converting of mlx5 by Tariq Toukan.
> > > >    3. converting of prueth_swdata (on me).
> > > >    4. converting of freescale driver (on me).
> > > >
> > > > For our discussion, I'm sharing what the final patch looks like the
> > > > following.
> > >
> > > To Willy and Mina,
> > >
> > > I believe this version might be the final version.  Please check the
> > > direction if it's going as you meant so as to go ahead convinced.
> > >
> > > As I mentioned above, the final patch should be submitted later once all
> > > the required works on drivers are done, but you can check what it looks
> > > like, in the following embedded patch in this cover letter.
> > >
> > 
> > We need this tested with at least 1 of devmem TCP and io_uring zc to
> > make sure the net_iov stuff isn't broken (I'll get to that when I have
> > time).
> > 
> > And we need page_pool benchmark numbers before/after this series,
> > please run those yourself, if at all possible:
> 
> I'm trying but it keeps conflicting on several steps..  Please share a
> better manual.
> 
> 	Byungchul
> 
> > https://lore.kernel.org/netdev/20250525034354.258247-1-almasrymina@google.com/

I will try this guide again with some adjusted.. Thanks anyway.

	Byungchul

> > 
> > This series adds a bunch of netmem/page casts. I expect them not to
> > affect fast-path perf, but making sure would be nice.
> > 
> > -- 
> > Thanks,
> > Mina


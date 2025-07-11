Return-Path: <bpf+bounces-62991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87455B010A9
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 03:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6B9D5A8343
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 01:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8328E78F5E;
	Fri, 11 Jul 2025 01:17:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384714409;
	Fri, 11 Jul 2025 01:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752196630; cv=none; b=XEx4FQm1JO/D27uylY+7/wIZbvlc/atUDOyK5cQ/UtGudmzJQxCi/JwnpYIcE3Ikb4g2p1G2bvWknhkoV19iSuGrnqd4eRdR39g5EBXUQ/pvvspYE/WA/tC1CbYsDPhO6fxRuzdVn1vQZ7+TeFVKooUOy0higusOZbVzVHXdWH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752196630; c=relaxed/simple;
	bh=Jtk6z9y7hDRl+bGMqNMZgJfNfwoyTOtoQNDtHCHi0/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLVX5F+3ColI3VOCDd0mknW8ek/dsmjUCE0kt8PTQupec0AdPdhva3HuIIHPq9N/4nftZWXkGUBHmG1QyzlFucaJRwYz0miFlE+6qch6ZKQfstj0tXjAbVgxFgjaI6W7DGnvn8kDLs39y+mva9ddBdM9H49FcBuIvJSqeeusmjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-8a-687066114969
Date: Fri, 11 Jul 2025 10:17:00 +0900
From: Byungchul Park <byungchul@sk.com>
To: Mina Almasry <almasrymina@google.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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
	vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com,
	jackmanb@google.com
Subject: Re: [PATCH net-next v9 4/8] netmem: use netmem_desc instead of page
 to access ->pp in __netmem_get_pp()
Message-ID: <20250711011700.GD40145@system.software.com>
References: <20250710082807.27402-1-byungchul@sk.com>
 <20250710082807.27402-5-byungchul@sk.com>
 <CAHS8izM8a-1k=q6bJAXuien1w6Zr+HAJ=XFo-3mbgM3=YBBtog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izM8a-1k=q6bJAXuien1w6Zr+HAJ=XFo-3mbgM3=YBBtog@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRzGeXfO3nMcrc7WxVcTpJVlglpp8Sei/PhSBEnQh/pQI09uOadM
	M5UKq1UkaRe1y9FiUnmZ1WqZN0xsmi6KFMNYeStvKVrRSvMS1TaJ/PbjeZ73ef4fXp5RP5YH
	8npjqmgyag0arGAVnxcUh6sPJevWlf7EUGS7h6FiKh1KP9TIochaheDHdBcH35tbMdwunmSg
	qM3MwoRthoGhln4OKuw7oa9kmIX6c9UM9F90YsgxzzLwdPoLB6dqymTQXpUrh/yZuwxUZ33g
	4E1dEYbee3/kMOzIYeGFVM5CX24MtFiWweTLcQTNtmoZTF64iSGvw4JhwNyHoKOpn4XCk7kI
	bA0uOcxOeToKn/dyMato0/hXhlaWv5PRWqmHoxb7Efq4LIxmuzoYareex9TuvsLR7rf1mDqv
	z7K0tua7jOac/oLpt6H3LP3a0ImprbKTpa8szdwu1V7FljjRoE8TTZFbDyh03W8muOTfivSz
	j64xWegtn438eCJEk4IJJ/OPH17p8TErhJDiqzewl7Gwhrhc0z59ibCW3Gm4LM9GCp4RJEw6
	6/pZr7FYMJHKfKvMy0oByND7fOwNqYUyRPIKbcycoSIvbgz6HjCe1l+3Ojw67+HlpPQ3PycH
	k9NPCn1xPyGWfBpo9sWXCitJY1WrzNtJBCdPRpxn2LmrA8izMhd7CamkeRPSvAnp/4Q0b8KC
	WCtS641piVq9ITpCl2HUp0ccTEq0I89XKjn+a18NcrfvdiCBR5oFypiKJJ1ark1LyUh0IMIz
	miXKBzuTdWplnDYjUzQl7TcdMYgpDrScZzX+yg2TR+PUQrw2VUwQxWTR9M+V8X6BWSi9O2/z
	4KkAa6NqRfBu07r2sYITh/03RDcu2hF0vsC8MLM+7GHX/bU/Y9tW84mlx1ocUbRt+1QsvAtd
	uc2wcdNlxcxIAn4dYB4ZDRyIHGVwyRiJ5/Nam24Fh4e4H31OLcgOC7k0E5ohBZEVe/Jj1oAU
	7f4WGBV10Ghf/DHIFmTQsCk67fowxpSi/QsDSs0fRgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+Z9zdnZcTU7L6mBltZBIyTSKXuiCfSj/FWp+iCKoXHlqy9vY
	VFQoVpMiSctLF48WE69Na7WWN2yWmhciitnMzBszrUTSvKUZ1aZEfvvxPM/7+/QypOymyJNR
	xcTxmhhFlJyWUJKQHfpNS86olf4tFn/IM5XTUDadCCV9VSLIM1YgmJj5KIbxxmYaCvKnSMh7
	k0LBpOknCQNNDjGUmYOht3iQgtorlSQ4rrfQkJYyS8KzmW9iuFRVSkDD3VYRvK1IF0H2zyIS
	KnV9YmiryaOhp/yPCAbr0yhoFe5T0JseCE2G5TD1ahhBo6mSgKlrd2nIshlo6E/pRWBrcFCQ
	ezEdgcnaIYLZaacj92WPONAbNwyPkNhy/wOBq4VuMTaY4/GTUh+c2mEjsdl4lcbmsUwx7mqv
	pXHLnVkKV1eNEzhN/43G3wc6KTxitdO44MsogU0WO3VIdkyyM4KPUiXwms27wyXKrrZJsfq3
	JPHy49ukDrUzqciN4dit3KPMbtLFFOvN5d/KoV1Msxu4jo6ZudyD3cgVWjNEqUjCkKxAc/Ya
	B+UqlrIazpJtJFwsZYEb6MymXSMZW4q4rFwTOV8s4VpzPs0dkE7rr3s2Z844eSVX8puZj9dw
	+qe5c3M3Noz73N84N1/GrueeVzQTN5C7sMAkLDAJ/03CApMBUUbkoYpJiFaoorb5aSOVSTGq
	RL/TsdFm5HyW4vO/MqrQRFtQPWIZJF8sDSyLVcpEigRtUnQ94hhS7iF9GKxWyqQRiqRkXhN7
	UhMfxWvr0UqGkq+QHjjCh8vYs4o4PpLn1bzmX0swbp46ZN1vs0wVFTd7FYY31rw/eEm/6oEy
	vmJtzUgAlRmObTo+qO9owI5FJ7zXRV74wYQm+7Ja4lzmO0fdxYzV1hSq3LfnauiWH2Mh6qHt
	ye4t/FCQYCyUK5sZXcIpbldTdVGBYN/DPyg5nhrmtW9m3d6TXYflpXpv++iLEI/a19N1X+WU
	VqkI8CE1WsVfxfbcpigDAAA=
X-CFilter-Loop: Reflected

On Thu, Jul 10, 2025 at 11:25:12AM -0700, Mina Almasry wrote:
> On Thu, Jul 10, 2025 at 1:28 AM Byungchul Park <byungchul@sk.com> wrote:
> >
> > To eliminate the use of the page pool fields in struct page, the page
> > pool code should use netmem descriptor and APIs instead.
> >
> > However, __netmem_get_pp() still accesses ->pp via struct page.  So
> > change it to use struct netmem_desc instead, since ->pp no longer will
> > be available in struct page.
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > ---
> >  include/net/netmem.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > index 11e9de45efcb..283b4a997fbc 100644
> > --- a/include/net/netmem.h
> > +++ b/include/net/netmem.h
> > @@ -306,7 +306,7 @@ static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
> >   */
> >  static inline struct page_pool *__netmem_get_pp(netmem_ref netmem)
> >  {
> > -       return __netmem_to_page(netmem)->pp;
> > +       return __netmem_to_nmdesc(netmem)->pp;
> >  }
> >
> 
> __netmem_to_nmdesc should introduced with this patch.

Okay.

> But also, I wonder why not modify all the callsites of
> __netmem_to_page to the new __netmem_to_nmdesc and delete the
> __nemem_to_page helper?

It'd be better.  I will.  Thanks.

	Byungchul
> 
> 
> --
> Thanks,
> Mina


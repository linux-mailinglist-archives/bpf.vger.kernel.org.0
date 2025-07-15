Return-Path: <bpf+bounces-63282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A97B04D83
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 03:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25BF37AF383
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 01:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0530F288C8C;
	Tue, 15 Jul 2025 01:36:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542FB2882B7;
	Tue, 15 Jul 2025 01:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752543411; cv=none; b=kBuG3tSFoKE03oxS29NKZOEI82kcjaRBU/yNtr409Ts3PnNEjXG6GeF7X6X1cD4EkAqbIL0FSxudLt9AyQe1v2ODHjqiOcDEBQD1OQBdNrob940jf+LAEJrEwJd3QwnagWja1IZ5KukVFff7M7tBgdQ6vCWtzh9am1SdIlQzbcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752543411; c=relaxed/simple;
	bh=rjv9ebF1tIJq2t2V5hyW1X90P8nhO4gHfYr1e/VsC3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmCN6zcnCPOTcexus7AkKsFsemrSadF2OysugGz1lbT7DjnNlnDX6Q8PPrh/AAUmInCKwP9eIum6rlQEPqYgTzb8tIXfYIJRliadcIKcrbNUFt6gXYrTQkMhIE+Fkl14XIBsnUZJwxYjsiKy2DHxiTvOT5PcCNVTkKUy1luugRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-cc-6875b0a2a86a
Date: Tue, 15 Jul 2025 10:36:26 +0900
From: Byungchul Park <byungchul@sk.com>
To: Mina Almasry <almasrymina@google.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, ilias.apalodimas@linaro.org,
	harry.yoo@oracle.com, akpm@linux-foundation.org,
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com,
	david@redhat.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com,
	jackmanb@google.com, wei.fang@nxp.com, shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, sgoutham@marvell.com,
	gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
	bbhushan2@marvell.com, tariqt@nvidia.com, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	sdf@fomichev.me, saeedm@nvidia.com, leon@kernel.org,
	mbloch@nvidia.com, danishanwar@ti.com, rogerq@kernel.org,
	nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com,
	shayne.chen@mediatek.com, sean.wang@mediatek.com,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	aleksander.lobakin@intel.com, horms@kernel.org, m-malladi@ti.com,
	krzysztof.kozlowski@linaro.org, matthias.schiffer@ew.tq-group.com,
	robh@kernel.org, imx@lists.linux.dev,
	intel-wired-lan@lists.osuosl.org,
	linux-arm-kernel@lists.infradead.org,
	linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v10 02/12] netmem: use netmem_desc instead of
 page to access ->pp in __netmem_get_pp()
Message-ID: <20250715013626.GA49874@system.software.com>
References: <20250714120047.35901-1-byungchul@sk.com>
 <20250714120047.35901-3-byungchul@sk.com>
 <CAHS8izO393X_BDJxnX2d-auhTwrUZK5wYdoAh_tJc0GBf0AqcQ@mail.gmail.com>
 <CAHS8izNh7aCJOb1WKTx7CXNDPv_UBqFyq2XEHHhqHH=5JPmJCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izNh7aCJOb1WKTx7CXNDPv_UBqFyq2XEHHhqHH=5JPmJCQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf1DTdRjH7/P98dmXxbwvC/OjZN1NzaJLKb3ruYuM669v3XXleVdXeuYu
	vrbRQBuMH51dE8YVmEiBnpuzRgwEZo6GwKKBNEhROoGBOAUGghkgaKEsBou1wXnx3+t5nvc9
	r89z9+Fo+W94HadOyxC1aUqNAksZ6XR02QvltTpVwvGRBDDbz2LoeVDGgm0uG86MOFnwVBP4
	pXuOAnNNA4KHgQEJOAoGaXjQfglDeZmfhkDtUQbMXQYGZu3zNPxxcVQCHe5/GbA53oLhyjsM
	uL5spKFtdhOMHuvAcNSwQIPRl48hdHOBhebAPQnkOqsoaL5bL4HuhiIWSucraGjUj4RdY/0s
	9DaZMfTm9SDwnQ2xcMcdFk5VDUqgyGZC4L5QjSHXsA2m6h9K4K/j7TQMFyXB4slMuGh5Avyd
	UwgGKq5REHI5JXDVd46FdnsjBX23AjT4vz6NoXD6GIJrxiYKfj9dy4K1s48Kv2MX9IeCFJR4
	LBjGDMMIPG2jDJw6XITA3uJl4W9X+OSFOTNOel1om7pPC84hKxLOV9+ghPHiRUrwtlyhhJ9N
	QxLB4tAJdVXxQrlrghIKvR5acNQUYMEx861EGOx3YaHj5AIj1Fm/EMbrjOid9R9IE5NFjTpT
	1G7dsU+q+jN4FR/0bcz+yvCqHtU+WYiiOMJvJ7crmthHrD9xno4ww28i4+2zVIQxv5l4vYGl
	fiz/HLG2fBPOSzmat3JkotmJIsUqfoYmnbOdTCT1OK8jP9zyLrGMBzKWX8BEQnL+PiJHnAF2
	eRBDLhtvL4XosCL4nSes4MIcR84scsvtp0le/aklcxS/k/zovYcjvJrfQFobLlGRnYTPlRJb
	3jRePmEt+bXKyxQjuWmFwrRCYfpfYVqhsCCmBsnVaZmpSrVm+xZVTpo6e8tHB1IdKPy5Kz8P
	7naime5dbsRzSBEtg8kMlZxVZqbnpLoR4WhFrGxySKuSy5KVOZ+J2gMfanUaMd2N4jhGsUb2
	kj8rWc5/rMwQPxHFg6L20ZTiotbp0aHLJRbfnqD/+hrjZl3vu3e3lea8kaKwlV/vmohPeWW+
	RlOyz/5p6tZF2d7px64EVYkbSrNi9O+/9tNEUtL8qt3Jlmcqb9IlfW0XYvb2eJ468WZr/mG8
	Py5rrW3jy9Gt+vdCRwaKd6y+MXLuH/uhgcnnE7pSfNr9alz8dvf36xPde2L7nlUw6Srli/G0
	Nl35H/YfORbYAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTZxiH853v3GhWd9ahfsFdkk5cRjJ02UzeZNO56LKTZTNzI/G2RJtx
	sjZcZC0lYHZBKYHWiTLcBrUwwMrVja4IdK6iaQmXdXNShBy5CohDAd2EEitI12KW8d/zvu8v
	v+f74+OxqpKN4XWp6ZI+VZOsZhW0YufrOS9XOozaTVVyPNgazrHQPVvBQP2DTKi+4WLAX0vg
	16sPKLDVNSOYCw5w4DQPYpht62DhTMU8hqDjOA22P000BBoeYphoH+Og0/OIhnrn+zBSdYsG
	d14LBm8gFsZOdLJw3LSAoWQ4l4VQ/wIDF4N3OTjqqqHAW9oVHqeaOLjaXMDAqYdnMbRk3wgL
	x/sY6LlgY6EnpxvB8LkQA7c8Yet0zSAHBfVWBJ5LtSwcNb0K001zHPz9bRuGkYJtsFScAe3l
	a2DeN41g4GwvBSG3i4Mrwz8x0NbQQsG10SCG+a9LWbDMnEDQW3KBgt9LHQzYfdeo8Ds+gr7Q
	IgVF/nIWxk0jCPzeMRpOHylA0NAqM/CP20Rv2y56p+9h0TVkR+L52uuUOHlyiRLl1t8o8Rfr
	ECeWO41iY02ceMZ9mxItsh+LzjozKzrvf8OJg31uVuwsXqDFRvtX4mRjCfrguX2KNxKlZF2G
	pN+49aBC+9fiFTZteH1mvmlLNnI8Y0FRPBFeI9nfnccRpoVYMtkWoCLMCi8SWQ4u76OFl4i9
	tZCxIAWPBTtPbl90ociwSriPiS/goyOppwUjqRyVl1kpABnPNdORkEq4h8gxV5B5fHiKdJXc
	XA7hsGKxzB9W8GFeR6qX+Mfr50lO0+llc5Swi/wo32UjvFp4gVxu7qBOoietK5qsK5qs/zdZ
	VzSVI7oORetSM1I0uuTN8YYkbVaqLjP+k0MpThT+uVVfLBa60FzPOx4k8Ej9hBLupGtVjCbD
	kJXiQYTH6mjlnSG9VqVM1GQdlvSHDuiNyZLBg9bxtHqt8t3d0kGV8KkmXUqSpDRJ/9+V4qNi
	spH3SP6X0TuqO8z1e+17PlP3LiRtLWqxzuYdqFjz+UTCsQ3EkLg2dkdQnrB9vOqH/W+mp+Q9
	2/4IJWw0HvZ9GI97ft5smyrcUJRws2N0on8+7o/tpe1dA6auJEug+K2ZtPd2vu3tL5sJmddf
	cg/szbr8/VT3/i1ljnzn7pxN9OqY3LHrp9S0Qat5JQ7rDZp/AaLKAyC1AwAA
X-CFilter-Loop: Reflected

On Mon, Jul 14, 2025 at 12:58:15PM -0700, Mina Almasry wrote:
> On Mon, Jul 14, 2025 at 12:37 PM Mina Almasry <almasrymina@google.com> wrote:
> >
> > On Mon, Jul 14, 2025 at 5:01 AM Byungchul Park <byungchul@sk.com> wrote:
> > >
> > > To eliminate the use of the page pool fields in struct page, the page
> > > pool code should use netmem descriptor and APIs instead.
> > >
> > > However, __netmem_get_pp() still accesses ->pp via struct page.  So
> > > change it to use struct netmem_desc instead, since ->pp no longer will
> > > be available in struct page.
> > >
> > > While at it, add a helper, pp_page_to_nmdesc(), that can be used to
> > > extract netmem_desc from page only if it's pp page.  For now that
> > > netmem_desc overlays on page, it can be achieved by just casting.
> > >
> > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > > ---
> > >  include/net/netmem.h | 13 ++++++++++++-
> > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > > index 535cf17b9134..2b8a7b51ac99 100644
> > > --- a/include/net/netmem.h
> > > +++ b/include/net/netmem.h
> > > @@ -267,6 +267,17 @@ static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
> > >         return (struct net_iov *)((__force unsigned long)netmem & ~NET_IOV);
> > >  }
> > >
> > > +static inline struct netmem_desc *pp_page_to_nmdesc(struct page *page)
> > > +{
> > > +       DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(page));
> > > +
> > > +       /* XXX: How to extract netmem_desc from page must be changed,
> > > +        * once netmem_desc no longer overlays on page and will be
> > > +        * allocated through slab.
> > > +        */
> > > +       return (struct netmem_desc *)page;
> > > +}
> > > +
> >
> > Same thing. Do not create a generic looking pp_page_to_nmdesc helper
> > which does not check that the page is the correct type. The
> > DEBUG_NET... is not good enough.
> >
> > You don't need to add a generic helper here. There is only one call
> > site. Open code this in the callsite. The one callsite is marked as
> > unsafe, only called by code that knows that the netmem is specifically
> > a pp page. Open code this in the unsafe callsite, instead of creating
> > a generic looking unsafe helper and not even documenting it's unsafe.
> >
> 
> On second read through the series, I actually now think this is a
> great idea :-) Adding this helper has simplified the series greatly. I
> did not realize you were converting entire drivers to netmem just to
> get rid of page->pp accesses. Adding a pp_page_to_nmdesc helper makes
> the entire series simpler.
> 
> You're also calling it only from code paths like drivers that already
> assumed that the page is a pp page and did page->pp deference without
> a check, so this should be safe.
> 
> Only thing I would change is add a comment explaining that the calling
> code needs to check the page is pp page or know it's a pp page (like a
> driver that supports pp).
> 
> 
> > >  /**
> > >   * __netmem_get_pp - unsafely get pointer to the &page_pool backing @netmem
> > >   * @netmem: netmem reference to get the pointer from
> > > @@ -280,7 +291,7 @@ static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
> > >   */
> > >  static inline struct page_pool *__netmem_get_pp(netmem_ref netmem)
> > >  {
> > > -       return __netmem_to_page(netmem)->pp;
> > > +       return pp_page_to_nmdesc(__netmem_to_page(netmem))->pp;
> > >  }
> >
> > This makes me very sad. Casting from netmem -> page -> nmdesc...
> >
> > Instead, we should be able to go from netmem directly to nmdesc. I
> > would suggest rename __netmem_clear_lsb to netmem_to_nmdesc and have
> > it return netmem_desc instead of net_iov. Then use it here.
> >
> > We could have an unsafe version of netmem_to_nmdesc which converts the
> > netmem to netmem_desc without clearing the lsb and mark it unsafe.
> >
> 
> This, I think, we should address to keep some sanity in the code and
> reduce the casts and make it a bit more maintainable.

I will reflect your suggestions.  To summarize:

   1) The current implementation of pp_page_to_nmdesc() is good enough
      to keep, but add a comment on it like "Check if the page is a pp
      page before calling this function or know it's a pp page.".

   2) Introduce the unsafe version, __netmem_to_nmdesc(), and use it in
      __netmem_get_pp().

   3) Rename __netmem_clear_lsb() to netmem_to_nmdesc(), and return
      netmem_desc, and use it in all users of __netmem_clear_lsb().

Anything else?

	Byungchul
> 
> --
> Thanks,
> Mina


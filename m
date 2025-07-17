Return-Path: <bpf+bounces-63562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EB3B084F4
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 08:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6E927ABE69
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 06:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E275216605;
	Thu, 17 Jul 2025 06:32:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473881A841F;
	Thu, 17 Jul 2025 06:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752733958; cv=none; b=L9mAYTWt3+KDxucCIpXNTWzRjUh2WL+4E1XWzOqtA2pafmNcW9QBzKSqLjXmu9igheRjIH4XbdJmH0bmIlSrtLrMBcfZfMYDkmQ1kdKQOeEkrG5cmVZyNSltS00RafOATEbUSt+2BgvJ/j9Gp8NginLJ5MUvUZq00MCWXawpQtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752733958; c=relaxed/simple;
	bh=4TMBl1ezB8kszm0sZIN26Bt/jSN0MsvU0gKuNks4fqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzRIzzcbpw7vzs1W90DAR5jnKprmzn+G44rxQwD7euFSbiinP+zoYCg6PUYUkLRvyW0KOv2DwRbl4pSA7A6FwlPNVX9rsY9Qkja6AlDmvL0IOhojmJDxMa95vKg8ykJamGJ58WxiMH5kxA2kXoncOkb7JHwCLnvQWOtms3OzUMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-f3-687898feb6e6
Date: Thu, 17 Jul 2025 15:32:25 +0900
From: Byungchul Park <byungchul@sk.com>
To: Mina Almasry <almasrymina@google.com>
Cc: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
	willy@infradead.org, netdev@vger.kernel.org,
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
	horms@kernel.org, m-malladi@ti.com, krzysztof.kozlowski@linaro.org,
	matthias.schiffer@ew.tq-group.com, robh@kernel.org,
	imx@lists.linux.dev, intel-wired-lan@lists.osuosl.org,
	linux-arm-kernel@lists.infradead.org,
	linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v10 02/12] netmem: use netmem_desc instead of
 page to access ->pp in __netmem_get_pp()
Message-ID: <20250717063225.GA28772@system.software.com>
References: <20250714120047.35901-1-byungchul@sk.com>
 <20250714120047.35901-3-byungchul@sk.com>
 <CAHS8izO393X_BDJxnX2d-auhTwrUZK5wYdoAh_tJc0GBf0AqcQ@mail.gmail.com>
 <CAHS8izNh7aCJOb1WKTx7CXNDPv_UBqFyq2XEHHhqHH=5JPmJCQ@mail.gmail.com>
 <20250715013626.GA49874@system.software.com>
 <CAHS8izNgfrN-MimH1uv349AqNudvQJoeOsyHpoBT_QokF3Zv=w@mail.gmail.com>
 <20250716045124.GB12760@system.software.com>
 <CAHS8izMK2JA4rGNMRMqQbZtJVEP8b_QPLXzoKNeVgQFzAmdv3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izMK2JA4rGNMRMqQbZtJVEP8b_QPLXzoKNeVgQFzAmdv3g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0yTdxTG83/vNNS8VLf9p1tcuonRRNyULSfZJUa/vF9cNC5ZolFo5J1t
	BkhaqUCyjWmXzWZUho7QUhSlaLmMYhGoWjptkbK5bLRSrHIrOI2biMxLR7mUvS0x49uT5zl5
	fuckhyMVLmYlp8k/JGrzVblKRkbJHqWe3RCvKlK/fbXxfbA6mhkIPD1DQ9N0EZyPuGgINmC4
	0jdNgLWxA8Gz2CALzmNDJDzt9jNQdyZKQqy1jALrHwYKnjtmSLjXM85Cr3eegibndhg9d58C
	97edJPier4Hx470MlBlmSTCPfMPAwp1ZGrpikywccdkJ6HrYzkJfh4mGkzP1JHSWRiTW3QEa
	bl62MnDzaADBSPMCDfe9EnDCPsSCqcmCwPtzAwNHDJthov0ZC1M/dpMwatoC8So99NS+DNEb
	EwgG60MELLhdLPw+0kJDt6OTgP6xGAnR72sYMD46jiBkvkzAbzWtNNhu9BPSHrtgYGGOgBPB
	WgbuGkYRBH3jFFR/bULg8IRp+MctnTw7bWW2bBV8E49JwTVsQ8LFhtuE8KA8Tghhz6+EcMky
	zAq1zkKhzb5eqHP/RQjGcJAUnI3HGMH5pIIVhgbcjNBbNUsJbbavhAdtZrTj9d2yD3LEXI1e
	1G78KFum7g+U0QXhbUUXfOmlKL7JiFI4zGdiv7WKeqHtxttkQlP8Gnyh20MnNMOvxeFwLOmv
	4Ndhm+cHyZdxJN+Sisce3kGJYDlfiM+OhZNFch7wTw1xlBhS8IMkrpwzMotBGv7F/GdyiJRa
	504FpVZO0qvw+Ti3aK/GR9urk7AUfice6W9P6pf4N/HVDj+R6MR8NAVfujaGFrd+FV+zh6ly
	lGZZgrAsQVj+R1iWIGoR1YgUmnx9nkqTm5mhLs7XFGXsP5jnRNI/n/tibo8LPenb5UU8h5Sp
	8uzWw2oFrdLrivO8CHOkcoX8RFCvVshzVMUlovZglrYwV9R50SqOUr4i3xQ9nKPgD6gOiZ+L
	YoGofZESXMrKUiQ3zWTU1L+2J572HrE9csWnK0/v+24Hf2pS8FdsSO9xTm+OOPZmRajTusrh
	f7NQKNtQ0fKpedI29aW/efBeRhOxr+Bk17vBkg/fmnrj+q2ZbeLfmfV7W8wHQuO3qudV2ouV
	8/C4zvFZ4PTHZKXnk5rJoZK1y1zxUF0osGzf6p3rtiopnVr1znpSq1P9B9AI6bPLAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTdxTG87//+0ZHl7uObTeaOVPiyDBzsjlzli0LiVl2x+Je4hYzPkwK
	3KydUKS1HSwaO6hZbGytAgtU0DJQS0HAdkDVjm0tEZx7kYKk8lIEHXMBpw5EK6XsFrOMb895
	npPfcz4cFiuq6FWsRrtb1GlVBUpaRsree738xXh1iXqj3aSE2rYWGvpn6yloflACp675KAg1
	8XD+8gMCat2dCOaiIwx4DoximO3ppaGhfh5DtN1KQu3vZhLutT3E8MeFSQb6AoskNHu2wvjJ
	KRL8X3dhCN5bB5OH+miwmhcw1ET207A0vEDB99G/GSjzuQgI1l2UxukOBi532iiofHgCQ5fp
	mlR4fYiCgXO1NAyU9yOItCxRMBWQWmdcowzYmh0IAj800VBmfgVmOuYYuFPVg2HclgnxaiNc
	cD4N85dmEIycuELAkt/HwG+RVgp62roIGJyIYpg/WEeD5dYhBFdqzhHwS107BY2XBgnpjm0w
	tBQjoCLkpOG6eRxBKDhJwtGvbAjausMU3PWbycwtQnDmNhZ8Y41I+K7pKiHctMcJIdz9MyGc
	dYwxgtNjELyudKHB/xchWMIhLHjcB2jB888RRhgd8tNCX/UCKXgb9wk3vTXogzXZsjfyxQKN
	UdS99GaOTD3Yb6V2hbeUnAk+b0Lxly0oieW5TbzLchUnNMmt48/0dFMJTXNpfDgcXfZTuBf4
	xu7Dki9jMdeazE9MD6NE8CRn4L+dCJMJLeeAP90UR4klBTeC+W9iFvpR8AR/sebG8hKWqLFj
	IYnKSno1fyrOPrKf48s7ji6XJXEf8pHBjmX9FJfK/9jZS9jR444VJMcKkuN/kmMFyYlIN0rR
	aI2FKk3Bqxv0O9WlWk3JhryiQg+SnvXk3thhH5obeDuAOBYpk+U57V+oFZTKqC8tDCCexcoU
	eUXIqFbI81WlX4q6oh06Q4GoD6DVLKl8Rp61XcxRcJ+pdos7RXGXqPsvJdikVSaUGtnYWlyf
	nzwQW6/NWHz2RmY8Y7OtYr3BuiYNu/233M25VWPFn6Qzn37cmfvO5m2f75jatG/y/vkG5s5Q
	XtnZd+++76z80zCWFrFPn05d6+4q/mjeNew9+Gt21tbsrP25ssrje3RrZ4/DT9Yj44/d33N7
	wWR5y753e16L7bVe72JdUVRJ6tWqjHSs06v+BSardbOoAwAA
X-CFilter-Loop: Reflected

On Wed, Jul 16, 2025 at 12:41:04PM -0700, Mina Almasry wrote:
> On Tue, Jul 15, 2025 at 9:51 PM Byungchul Park <byungchul@sk.com> wrote:
> >
> > On Tue, Jul 15, 2025 at 12:09:34PM -0700, Mina Almasry wrote:
> > > On Mon, Jul 14, 2025 at 6:36 PM Byungchul Park <byungchul@sk.com> wrote:
> > > >
> > > > On Mon, Jul 14, 2025 at 12:58:15PM -0700, Mina Almasry wrote:
> > > > > On Mon, Jul 14, 2025 at 12:37 PM Mina Almasry <almasrymina@google.com> wrote:
> > > > > >
> > > > > > On Mon, Jul 14, 2025 at 5:01 AM Byungchul Park <byungchul@sk.com> wrote:
> > > > > > >
> > > > > > > To eliminate the use of the page pool fields in struct page, the page
> > > > > > > pool code should use netmem descriptor and APIs instead.
> > > > > > >
> > > > > > > However, __netmem_get_pp() still accesses ->pp via struct page.  So
> > > > > > > change it to use struct netmem_desc instead, since ->pp no longer will
> > > > > > > be available in struct page.
> > > > > > >
> > > > > > > While at it, add a helper, pp_page_to_nmdesc(), that can be used to
> > > > > > > extract netmem_desc from page only if it's pp page.  For now that
> > > > > > > netmem_desc overlays on page, it can be achieved by just casting.
> > > > > > >
> > > > > > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > > > > > > ---
> > > > > > >  include/net/netmem.h | 13 ++++++++++++-
> > > > > > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > > > > > > index 535cf17b9134..2b8a7b51ac99 100644
> > > > > > > --- a/include/net/netmem.h
> > > > > > > +++ b/include/net/netmem.h
> > > > > > > @@ -267,6 +267,17 @@ static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
> > > > > > >         return (struct net_iov *)((__force unsigned long)netmem & ~NET_IOV);
> > > > > > >  }
> > > > > > >
> > > > > > > +static inline struct netmem_desc *pp_page_to_nmdesc(struct page *page)
> > > > > > > +{
> > > > > > > +       DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(page));
> > > > > > > +
> > > > > > > +       /* XXX: How to extract netmem_desc from page must be changed,
> > > > > > > +        * once netmem_desc no longer overlays on page and will be
> > > > > > > +        * allocated through slab.
> > > > > > > +        */
> > > > > > > +       return (struct netmem_desc *)page;
> > > > > > > +}
> > > > > > > +
> > > > > >
> > > > > > Same thing. Do not create a generic looking pp_page_to_nmdesc helper
> > > > > > which does not check that the page is the correct type. The
> > > > > > DEBUG_NET... is not good enough.
> > > > > >
> > > > > > You don't need to add a generic helper here. There is only one call
> > > > > > site. Open code this in the callsite. The one callsite is marked as
> > > > > > unsafe, only called by code that knows that the netmem is specifically
> > > > > > a pp page. Open code this in the unsafe callsite, instead of creating
> > > > > > a generic looking unsafe helper and not even documenting it's unsafe.
> > > > > >
> > > > >
> > > > > On second read through the series, I actually now think this is a
> > > > > great idea :-) Adding this helper has simplified the series greatly. I
> > > > > did not realize you were converting entire drivers to netmem just to
> > > > > get rid of page->pp accesses. Adding a pp_page_to_nmdesc helper makes
> > > > > the entire series simpler.
> > > > >
> > > > > You're also calling it only from code paths like drivers that already
> > > > > assumed that the page is a pp page and did page->pp deference without
> > > > > a check, so this should be safe.
> > > > >
> > > > > Only thing I would change is add a comment explaining that the calling
> > > > > code needs to check the page is pp page or know it's a pp page (like a
> > > > > driver that supports pp).
> > > > >
> > > > >
> > > > > > >  /**
> > > > > > >   * __netmem_get_pp - unsafely get pointer to the &page_pool backing @netmem
> > > > > > >   * @netmem: netmem reference to get the pointer from
> > > > > > > @@ -280,7 +291,7 @@ static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
> > > > > > >   */
> > > > > > >  static inline struct page_pool *__netmem_get_pp(netmem_ref netmem)
> > > > > > >  {
> > > > > > > -       return __netmem_to_page(netmem)->pp;
> > > > > > > +       return pp_page_to_nmdesc(__netmem_to_page(netmem))->pp;
> > > > > > >  }
> > > > > >
> > > > > > This makes me very sad. Casting from netmem -> page -> nmdesc...
> > > > > >
> > > > > > Instead, we should be able to go from netmem directly to nmdesc. I
> > > > > > would suggest rename __netmem_clear_lsb to netmem_to_nmdesc and have
> > > > > > it return netmem_desc instead of net_iov. Then use it here.
> > > > > >
> > > > > > We could have an unsafe version of netmem_to_nmdesc which converts the
> > > > > > netmem to netmem_desc without clearing the lsb and mark it unsafe.
> > > > > >
> > > > >
> > > > > This, I think, we should address to keep some sanity in the code and
> > > > > reduce the casts and make it a bit more maintainable.
> > > >
> > > > I will reflect your suggestions.  To summarize:
> > > >
> > > >    1) The current implementation of pp_page_to_nmdesc() is good enough
> > > >       to keep, but add a comment on it like "Check if the page is a pp
> > > >       page before calling this function or know it's a pp page.".
> > > >
> > >
> > > Yes please.
> > >
> > > >    2) Introduce the unsafe version, __netmem_to_nmdesc(), and use it in
> > > >       __netmem_get_pp().
> > > >
> > >
> > > No need following Pavel's feedback. We can just delete
> > > __netmem_get_pp. If we do find a need in the future to extract the
> > > netmem_desc from a netmem_ref, I would rather we do a straight cast
> > > from netmem_ref to netmem_desc rather than netmem_ref -> pages/net_iov
> > > -> netmem_desc.
> > >
> > > But that seems unnecessary for this series.
> >
> > No.  The series should remove accessing ->pp through page.
> >
> > I will kill __netmem_get_pp() as you and I prefer.  However,
> > __netmem_get_pp() users e.i. libeth_xdp_return_va() and
> > libeth_xdp_tx_fill_buf() should be altered.  I will modify the code like:
> >
> > as is: __netmem_get_pp(netmem)
> > to be: __netmem_nmdesc(netmem)->pp
> >
> > Is it okay with you?
> >
> 
> When Pavel and I were saying 'remove __netmem_get_pp', I think we
> meant to remove the entire concept of unsafe netmem -> page
> conversions. I think we both don't like them. From this perspective,
> __netmem_nmdesc(netmem)->pp is just as bad as __netmem_get_pp(netmem).
> 
> I think since the unsafe netmem-to-page casts are already in mainline,
> lets assume they should stay there until someone feels strongly enough
> to remove them. The logic in Olek's patch is sound:
> 
> https://lore.kernel.org/all/20241203173733.3181246-8-aleksander.lobakin@intel.com/
> 
> Header buffer page pools do always use pages and will likely remain so
> for a long time, so I guess lets continue to support them rather than
> try to remove them in this series. A followup series could try to
> remove them.
> 
> > > >    3) Rename __netmem_clear_lsb() to netmem_to_nmdesc(), and return
> > > >       netmem_desc, and use it in all users of __netmem_clear_lsb().
> > > >
> > >
> > > Following Pavel's comment, this I think also is not necessary for this
> > > series. Cleaning up the return value of __netmem_clear_lsb is good
> > > work I think, but we're already on v10 of this and I think it would
> > > unnecessary to ask for added cleanups. We can do the cleanup on top.
> >
> > However, I still need to include 'introduce __netmem_nmdesc() helper'
> 
> Yes.
> 
> > in this series since it should be used to remove __netmem_get_pp() as I
> 
> lets keep __netmem_get_pp, which does a `return
> __netmem_nmdesc(netmem)->pp;` In general we avoid allowing the driver
> to do any netmem casts in the driver code, and we do any casting in
> core.
> 
> > described above.  I think I'd better add netmem_nmdesc() too while at it.
> >
> 
> Yes. netmem_nmdesc should replace __netmem_clear_lsb.

Even though the unsafe version is required in this series, on second
though, the safe version, netmem_nmdesc() doesn't have to be a part of
this series.  Let's do adding the safe version on top after.

	Byungchul

> > I assume __netmem_nmdesc() is an unsafe version not clearing lsb.  The
> 
> Yes.
> 
> > safe version, netmem_nmdesc() needs an additional operation clearing lsb.
> 
> Yes.
> 
> 
> --
> Thanks,
> Mina


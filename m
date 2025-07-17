Return-Path: <bpf+bounces-63559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7329DB083B6
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 06:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B191567D82
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 04:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5A420125F;
	Thu, 17 Jul 2025 04:19:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C692F1F9EC0;
	Thu, 17 Jul 2025 04:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752725943; cv=none; b=ehIgIxLA1ooydtsqChU3+DlOI0NQ/bKBUBwvUZSA3X2AqmeVgDZSILXSa4WWNOqc9LgOyuy4zhuvwrKdMQqGrgwvYPMQU5B68baEQ8PYV6SUYLJvfpcfH6/FXs1zQj7k5fMcH0C/J1jnIPU3h3FFRYbnWDt7KeoBQ0aN25yIbgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752725943; c=relaxed/simple;
	bh=SxsC0AtvePv5O9c8hnEMPH618+dNqauOpb3UqFCqOU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXM11VmI9qYbT8ZrQCAFOc1CGavi9SKCpmLr74xAFTOJuFQU4AS8fxFTHgh6NzWXRgjNw7Tyw7Do7MQL2AyCIYUfzm3Mx9BHsz85SNit2pkxN+RWcO7frvGL83j5CaMt1Tvuh/utbv3eZuQcBUjRcgGDcxTNbbQO+8KSw5otTtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-f3-687879af9283
Date: Thu, 17 Jul 2025 13:18:50 +0900
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
Message-ID: <20250717041850.GA70234@system.software.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUybVRiGd97vVmreVdSzzWVJceqWgKhonsRlIVOT18QZzf7o9sNV+8ZW
	+VgK7crU2DEU1zg2xjS0KwY2thU6KSkCpXa4FRzVfUEHWAe0g7lljLIPBg2lldqWLPLvyrmf
	c1/PSQ5Hyl3Mak5TVCpqi5QFCkZKSaczjmW3lhnUueXhx8HqOM3AwMMGGuzzBjh13UWDvwnD
	r/3zBFibOxDMRkdYcO4fJeFhbx8DxxsiJERbD1BgvVJBwZxjgYSb5ydY8Hn/pcDu3Aqhk7co
	8FR2ktAztx4mDvoYOFARI8Ec/IaBxLUYDWeid1kod9kIODPVzkJ/RxUNRxZOkNBpvJ503Rim
	4arbysDVfQMIgqcTNNzyJoVh2ygLVXYLAu9vTQyUV7wC4fZZFu7/0EtCqCofFmv1cL7+KYhc
	CCMYOTFEQMLjYuFysIWGXkcnAYPjURIi39cxYJo+iGDI7CbgYl0rDY0XBonkHttgOBEnoMZf
	z8CNihACf88EBUf3ViFwdAdoeOBJPjk2b2Xytwg94Xuk4BprRMIvTX8Twu1Di4QQ6P6TELos
	Y6xQ79QJbbaNwnHPJCGYAn5ScDbvZwTnzGFWGB32MIKvNkYJbY1fC7fbzOi9tdulm1RigUYv
	al/cvFOqDk6qd02/ZZirOYuM6GaeCUk4zOfhvTEz+4i/vXefSjHFr8d3r1jJFDP88zgQiKY5
	k9+AG7uraROSciTfkoHHp66hVPAEr8PHxgPpyzIesD14CaWG5PwIiX+Mm5ilYCX+w/xPeohM
	tsZ/8idbuSSvwacWuaXjdXhf+9G0TMK/j4OD7Wl+ks/CZzv6iFQn5iMSHLfMEUtbr8LnbAHq
	EFppWaawLFNY/ldYlinqEdWM5JoifaFSU5CXoy4r0hhyPikudKLkfz75VXyHC830b/MinkOK
	DNnO1t1qOa3Ul5QVehHmSEWmrMavV8tlKmXZHlFb/JFWVyCWeNEajlI8LXs5slsl5z9Vloqf
	i+IuUfsoJTjJaiNS1m7fkm3dY7yTsUmX+Kwroh89/OxY1+89b1+MziRKFereygdf+mo+9PVl
	tby6Oftj3+tbK2fXybOKE5eOTH7wwip3abX7NdWAPpb/XMvPqFr5zLvyFQZdZk5oqCFoXGux
	77AFc1Wmuu8WFCty/trwzpuOcwsTmW88dsf9heRybt/4VEhBlaiVL20ktSXK/wCz2PrZywMA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxbVRiHPffcLxpq7iq661hYUjONNeIWMb7qtiyZH0eSGc1mFheNVLna
	BijYjg5MjDjqlIYBG2JGVwy4jq+OlbQDuq1jpEVWRAcrDOuAMsAtI+sGbkDWgdTSxch/zzm/
	9zy/94/DY0UVu47X6vZJep06W8nKaNk7rxU/7ygs0Gyyj24Gq+MkC5fv1TFgv18ADdfcDASa
	RDg3cJ8Ca3M7grnICAfOklEM97ovsnC8bgFDpPUQDdZ+Ew3zjgcYrvdMcuD3/kOD3bkTxutv
	0OD5rgODb34jTJb7WThkWsRQHfqWhejVRQbOR+5wcMDdSIGvpjd2vNXGwUB7GQM/PDiBoaPo
	WqxwapiBwbNWFgaLLyMInYwycMMbaw03jnJQZrcg8F5oYuGA6UUIt81xMFvVjWG8bDssHzVC
	T+0TsNAXRjBy4goFUY+bg0uhUwx0OzooGJqIYFgorWHBfLscwZXqsxT8VtPKgK1viIrtsQuG
	o0sUVAZqWZgyjSMI+CZpOPZNGQJHZ5CBvz0mevsO4gvPYOIesyFyuulPitysWKZIsPNXipyx
	jHGk1plPXI0qctwzTRFzMICJs7mEJc67RzgyOuxhif/oIk1ctq/JTVc1ejdlr2xLppStNUr6
	F7ZlyDShaU3e7TcK5iu7UBG6nmZGCbwopIkHZ2bpFaaFjeKdfiteYVZ4RgwGI3FOEp4VbZ2H
	GTOS8Vg4lShO3LqKVoLHhHzx54lg/LFcANEe+h2tDCmEESz+uGRmHwZrxN7qv+JDOGZd+ikQ
	s/IxThYblvmH1xvE4rZj8bIE4T0xNNQW58eFp8Su9otUBXrUsspkWWWy/G+yrDLVIroZJWl1
	xhy1NvulVEOWplCnLUj9NDfHiWKftf6rpcNuNDf4lhcJPFImyjNa92sUjNpoKMzxIpHHyiR5
	ZcCoUcgz1YVfSvrcj/X52ZLBi5J5WrlWnr5HylAIn6v3SVmSlCfp/0spPmFdETpPzTds2TOr
	Gh5gNyX58/DIm96+c/YzL7soopp5xfT0jqro9GKdN1L63KCtIqWnqqV9/yNpH6b3n349+f26
	4vXOveNHvtj2SYe7NPHSqx/t2vDBk7tbVL/84W+pv7AzTbe193tqq843fbB8ytiVyn6Wtdb1
	dtHdzJJ0bef6XHPKGJbCStqgUW9WYb1B/S+S5G2AqAMAAA==
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

Trivial concern.  I don't think the contraint that the nmdesc must be
the first field in struct net_iov is __unnecessary__.  Thus, I think
netmem_nmdesc() should be something like:

	if (netmem_is_net_iov(netmem))
		return &(struct net_iov *)((__force unsigned long)netmem &
			~NET_IOV)->desc;
	return __netmem_to_nmdesc(netmem);

Do you want to keep the current contraint so that the just casting to
struct netmem_desc after the clearing, can work in netmem_nmdesc()?

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


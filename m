Return-Path: <bpf+bounces-63408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D551DB06CCF
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 06:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5A9E3A85E7
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 04:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968AA2749D6;
	Wed, 16 Jul 2025 04:51:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A67221544;
	Wed, 16 Jul 2025 04:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752641496; cv=none; b=RO7hXNzwt5LGY3wHX2IR5xAIVfoLgE1GGG8u57HvQ/Ap2nnEa6YpmOvdJwiTGZBt+/eVqfWVri4i/+A0G/PLS0PbmezyGd9bKHlVxJu8bZeYgM/XQFT0nwzDv4II2W7i7cX90GEZhSPtTt0rwD/UWZR9pEUC6DPxZhz8WFwXbA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752641496; c=relaxed/simple;
	bh=cnWvurfSEIowWEmeKeCClSAuxFNBnx6JPkdMlHA8QMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKFTrARvQrlHWJPiLZp/8c0NSmR8QowKYUyJOZAyyKFmU8zY/j/JfNPKEgH+J3n0q9NWLPQUl1kTM/UUKzNNHeaBRl/d6RV+XRNhucK4lsV5m4rSKeKEt9+GEz8e26pFL/I5B/M1akr6RA2Ubb885Sji+k3qRpMNrSdoNvmTPB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-e0-68772fd17b46
Date: Wed, 16 Jul 2025 13:51:24 +0900
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
Message-ID: <20250716045124.GB12760@system.software.com>
References: <20250714120047.35901-1-byungchul@sk.com>
 <20250714120047.35901-3-byungchul@sk.com>
 <CAHS8izO393X_BDJxnX2d-auhTwrUZK5wYdoAh_tJc0GBf0AqcQ@mail.gmail.com>
 <CAHS8izNh7aCJOb1WKTx7CXNDPv_UBqFyq2XEHHhqHH=5JPmJCQ@mail.gmail.com>
 <20250715013626.GA49874@system.software.com>
 <CAHS8izNgfrN-MimH1uv349AqNudvQJoeOsyHpoBT_QokF3Zv=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izNgfrN-MimH1uv349AqNudvQJoeOsyHpoBT_QokF3Zv=w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUyTZxDA87zfdHZ517HtGWwhlpExkonbMLkpMWTJklcTFhf/MJsxrpNu
	7VYQi5SPaAZY58BR3KpGSjFVqxRqVlIEOlfY1hJAMXxUYB3yIaBEszInSqFS2rV1Zvz3u7vc
	/e6S40hJN5PAKfMOytV5MpWUEVGi+XXn3x5KL1JsPHksFYy2ywwMPTpHg3W5GBpuO2jwNGL4
	ZXCZAGNTG4LHgVss2CvHSXjU1cPAhXN+EgLN1RQYB7QULNqekHC3e4aFXtcqBVZ7NkxdmqPA
	eaydBPdiCszU9DJQrV0hoXbyKAPhsRUaOgJ/s1DhsBDQ8VcrC4NtOhpOPrlIQnvZ7YhrdpSG
	m1eNDNw8MoRg8nKYhjlXROizjLOgsxoQuH5tZKBC+x74Wh+z8M+pLhKmdFkQOqOBbtPL4O/z
	Ibh1cYSAsNPBQv/kTzR02doJGJ4OkOD/vp6BqvkaBCO1Vwm4Ud9Mg7lvmIjssRNGw0EC9B4T
	A7PaKQQe9wwFdeU6BLZOLw0PnZGTV5aNTNYHgtv3gBQcE2YkXGn8kxDunQgRgrfzOiH8bJhg
	BZO9UGixpAkXnPcJocrrIQV7UyUj2Bd+ZIXxUScj9J5ZoYQW8zfCvZZatOP1T0WZOXKVUiNX
	p2/9TKQo7x9A+S2biiuDVqYMzaVWoTgO8xn4j7kbxDMeHdFTUab4FDygHWOizPBvYq83QEY5
	nn8Lmzt/oKuQiCN5M4fvdzhQNHieXyBx32JfrPtFvhCfn/bGWMwD9k0/jHVI+LsEXr1z9r/C
	C/ha7Z0YkxFF8KwnouAinIgbQtzTdBI+0loXM8fxH+Ol/lNslF/ik/FvbT1EdCbmQ3H4evMS
	+/SEV/HvFi91AkkMaxSGNQrD/wrDGoUJUU1IoszT5MqUqowNipI8ZfGGfftz7Sjy3ZcOB3c7
	0MLgThfiOSRdJ3Zs0SgktExTUJLrQpgjpfFivSeSEufISkrl6v171YUqeYELJXKU9BXxu/6i
	HAn/peyg/Gu5PF+uflYluLiEMpT1RWnH0idU8nO7eqqlZMMW+Ha3R5O2bdOBCu3n6Qd0w6e3
	+muGutZb9hzatv0jiXX1tc2hTvfxfNv0vpTTh79LPZqgXf9VWSYrbZ13q97YfMUW70qse7Ax
	vD1zh774WryEmCmqNNXPFmYH2ePlHybR3WNJ+uSM98erxYccronsklIpVaCQvZNGqgtk/wLy
	0C982QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTZxSH8973ftHQedd1eqPJtnQxm2bCzCA7kcW4LNlulmjYR+Z0W7CB
	q+0sYFopZQsZSreFZgKOudgKBKXKRw01ZUDViq4UxGFAirAqCEKVaNbBlA8tlLLbbsv47znn
	5Pye88dhsaKWXstqcw6K+hy1TkXLSNmOtOJN/cn5mteLLyZApfMsDf0zJylwPDVB3V03Bf4G
	Hi7eeEpAZWMrgtnwMAOukhEMM76rNNSenMcQPneEhMo+MwlzzgUM97smGOj2LpHgcG2HsTOT
	JHi+b8PQMbceJsq6aThiXsRgHf2WhuXbixRcCk8xcNhdT0BH1TWp/KOFgRutpRT8tHAaQ1vR
	XUkYHKJg4EIlDQPF/QhGzy5TMOmVrKH6EQZKHTYE3ssNNBw2vwGhllkG/jrmwzBWug2ix43Q
	VbMa5ntCCIZPDxKw7HEz0DvaRIHP2UbAzfEwhvkfqmiw/FmGYNB6gYDrVecosPfcJKQ7PoKh
	5QgBFf4aGoLmMQT+jgkSThwqReBsD1DwyGMmt70jdISmseC+Y0fCLw23COFBeZQQAu2/EcJ5
	2x1GqHHlCc31G4Vaz0NCsAT8WHA1ltCC6/GPjDAy5KGF7uOLpNBs/0Z40GxF6S/slr2VJeq0
	RlGfvHWPTHOotw8daE41lUQcdBGafNWCElieS+GHBivIGJPcer7PfJuOMc29wgcCYRxjJbeB
	t7cfpSxIxmLOzvIPL7lRrHiGe4z5nrme+PZzXB5/ajwQZzkHfGj8UXxDwd0n+KV71f8OnuWv
	We/FGUuKSLVfUrASr+Prouw/7Rf54pYTcXMC9wH/pPcYE+PnuZf5K61XiXK0yrYiybYiyfZ/
	km1FUg0iG5FSm2PMVmt1qUmG/ZqCHK0pKTM324Wk1z1TGDnqRrMD73kRxyJVotydZtQoKLXR
	UJDtRTyLVUp5hV9qybPUBV+J+twMfZ5ONHjROpZUrZG/v1Pco+D2qQ+K+0XxgKj/b0qwCWuL
	0Lity5SfWOKJDFdkfPlpelNGSzRzc9umr2dm1rx0vZrbu6Wq/JPXzFm5vsxdhWllCx8v/dye
	8hkd7Ew2WhLzrBqf81d7cMdW/GHS9pTv0nftnFr9JNkiV+iappXvTm3xd1pvKUbT3nTsK/uC
	fbtOmTppMnxe+Pv0qnQfaepsCEbzT6lIg0a9eSPWG9R/Ay6goT22AwAA
X-CFilter-Loop: Reflected

On Tue, Jul 15, 2025 at 12:09:34PM -0700, Mina Almasry wrote:
> On Mon, Jul 14, 2025 at 6:36 PM Byungchul Park <byungchul@sk.com> wrote:
> >
> > On Mon, Jul 14, 2025 at 12:58:15PM -0700, Mina Almasry wrote:
> > > On Mon, Jul 14, 2025 at 12:37 PM Mina Almasry <almasrymina@google.com> wrote:
> > > >
> > > > On Mon, Jul 14, 2025 at 5:01 AM Byungchul Park <byungchul@sk.com> wrote:
> > > > >
> > > > > To eliminate the use of the page pool fields in struct page, the page
> > > > > pool code should use netmem descriptor and APIs instead.
> > > > >
> > > > > However, __netmem_get_pp() still accesses ->pp via struct page.  So
> > > > > change it to use struct netmem_desc instead, since ->pp no longer will
> > > > > be available in struct page.
> > > > >
> > > > > While at it, add a helper, pp_page_to_nmdesc(), that can be used to
> > > > > extract netmem_desc from page only if it's pp page.  For now that
> > > > > netmem_desc overlays on page, it can be achieved by just casting.
> > > > >
> > > > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > > > > ---
> > > > >  include/net/netmem.h | 13 ++++++++++++-
> > > > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > > > > index 535cf17b9134..2b8a7b51ac99 100644
> > > > > --- a/include/net/netmem.h
> > > > > +++ b/include/net/netmem.h
> > > > > @@ -267,6 +267,17 @@ static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
> > > > >         return (struct net_iov *)((__force unsigned long)netmem & ~NET_IOV);
> > > > >  }
> > > > >
> > > > > +static inline struct netmem_desc *pp_page_to_nmdesc(struct page *page)
> > > > > +{
> > > > > +       DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(page));
> > > > > +
> > > > > +       /* XXX: How to extract netmem_desc from page must be changed,
> > > > > +        * once netmem_desc no longer overlays on page and will be
> > > > > +        * allocated through slab.
> > > > > +        */
> > > > > +       return (struct netmem_desc *)page;
> > > > > +}
> > > > > +
> > > >
> > > > Same thing. Do not create a generic looking pp_page_to_nmdesc helper
> > > > which does not check that the page is the correct type. The
> > > > DEBUG_NET... is not good enough.
> > > >
> > > > You don't need to add a generic helper here. There is only one call
> > > > site. Open code this in the callsite. The one callsite is marked as
> > > > unsafe, only called by code that knows that the netmem is specifically
> > > > a pp page. Open code this in the unsafe callsite, instead of creating
> > > > a generic looking unsafe helper and not even documenting it's unsafe.
> > > >
> > >
> > > On second read through the series, I actually now think this is a
> > > great idea :-) Adding this helper has simplified the series greatly. I
> > > did not realize you were converting entire drivers to netmem just to
> > > get rid of page->pp accesses. Adding a pp_page_to_nmdesc helper makes
> > > the entire series simpler.
> > >
> > > You're also calling it only from code paths like drivers that already
> > > assumed that the page is a pp page and did page->pp deference without
> > > a check, so this should be safe.
> > >
> > > Only thing I would change is add a comment explaining that the calling
> > > code needs to check the page is pp page or know it's a pp page (like a
> > > driver that supports pp).
> > >
> > >
> > > > >  /**
> > > > >   * __netmem_get_pp - unsafely get pointer to the &page_pool backing @netmem
> > > > >   * @netmem: netmem reference to get the pointer from
> > > > > @@ -280,7 +291,7 @@ static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
> > > > >   */
> > > > >  static inline struct page_pool *__netmem_get_pp(netmem_ref netmem)
> > > > >  {
> > > > > -       return __netmem_to_page(netmem)->pp;
> > > > > +       return pp_page_to_nmdesc(__netmem_to_page(netmem))->pp;
> > > > >  }
> > > >
> > > > This makes me very sad. Casting from netmem -> page -> nmdesc...
> > > >
> > > > Instead, we should be able to go from netmem directly to nmdesc. I
> > > > would suggest rename __netmem_clear_lsb to netmem_to_nmdesc and have
> > > > it return netmem_desc instead of net_iov. Then use it here.
> > > >
> > > > We could have an unsafe version of netmem_to_nmdesc which converts the
> > > > netmem to netmem_desc without clearing the lsb and mark it unsafe.
> > > >
> > >
> > > This, I think, we should address to keep some sanity in the code and
> > > reduce the casts and make it a bit more maintainable.
> >
> > I will reflect your suggestions.  To summarize:
> >
> >    1) The current implementation of pp_page_to_nmdesc() is good enough
> >       to keep, but add a comment on it like "Check if the page is a pp
> >       page before calling this function or know it's a pp page.".
> >
> 
> Yes please.
> 
> >    2) Introduce the unsafe version, __netmem_to_nmdesc(), and use it in
> >       __netmem_get_pp().
> >
> 
> No need following Pavel's feedback. We can just delete
> __netmem_get_pp. If we do find a need in the future to extract the
> netmem_desc from a netmem_ref, I would rather we do a straight cast
> from netmem_ref to netmem_desc rather than netmem_ref -> pages/net_iov
> -> netmem_desc.
> 
> But that seems unnecessary for this series.

No.  The series should remove accessing ->pp through page.

I will kill __netmem_get_pp() as you and I prefer.  However,
__netmem_get_pp() users e.i. libeth_xdp_return_va() and
libeth_xdp_tx_fill_buf() should be altered.  I will modify the code like:

as is: __netmem_get_pp(netmem)
to be: __netmem_nmdesc(netmem)->pp

Is it okay with you?

> >    3) Rename __netmem_clear_lsb() to netmem_to_nmdesc(), and return
> >       netmem_desc, and use it in all users of __netmem_clear_lsb().
> >
> 
> Following Pavel's comment, this I think also is not necessary for this
> series. Cleaning up the return value of __netmem_clear_lsb is good
> work I think, but we're already on v10 of this and I think it would
> unnecessary to ask for added cleanups. We can do the cleanup on top.

However, I still need to include 'introduce __netmem_nmdesc() helper'
in this series since it should be used to remove __netmem_get_pp() as I
described above.  I think I'd better add netmem_nmdesc() too while at it.

I assume __netmem_nmdesc() is an unsafe version not clearing lsb.  The
safe version, netmem_nmdesc() needs an additional operation clearing lsb.
If you are fine with it, I will add these two helpers in the next spin.
Or I could add __netmem_nmdesc() only.  Thoughts?  

> > Anything else?
> 
> Thank you very much :-)

I rather apprecisate your feedbacks.

	Byungchul

> --
> Thanks,
> Mina


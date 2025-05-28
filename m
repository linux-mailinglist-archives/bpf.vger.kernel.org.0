Return-Path: <bpf+bounces-59048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 179D3AC5EC8
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 03:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF2B9E4DAE
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 01:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165B51991CD;
	Wed, 28 May 2025 01:22:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7162135961;
	Wed, 28 May 2025 01:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748395333; cv=none; b=UUG7QFtx3wkTJ473xqqINw+49REfzh1GsitdFmkSDNjoBjoUoZa5cFDHjKHLeWIOv9ACm9qKl2Jv3MCDJHq2Ng/sYJMBpF1ibq0pFZjMoxSxNNCNrpt9JOYdw/9MBbxo6NpaxwZpb7tRXsllJmHSmLG8utO0a8i4+dQd4XfBCX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748395333; c=relaxed/simple;
	bh=BMAeACuO9VrROjRVYrDGn5PVXm/tc/VniB3LCfrMzGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uttJ3JjgYQTc6nyJEDz/ZHlqIj4si2T2PtkC9LqmPpBYwi3AeeOrTK0qIG8MHMG8gFOUD3/NzZwAFCSMuGIYfKG12qtYhea3wn14x0JuO2vrueCde2NLsHHmB+rW5Pd3O28/tKvi39qpM/3tzxBKGe4y9sjwPH3DpwUdA9vAs5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-65-6836653645ce
Date: Wed, 28 May 2025 10:21:52 +0900
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
	vishal.moola@gmail.com
Subject: Re: [PATCH 01/18] netmem: introduce struct netmem_desc
 struct_group_tagged()'ed on struct net_iov
Message-ID: <20250528012152.GA2986@system.software.com>
References: <20250523032609.16334-1-byungchul@sk.com>
 <20250523032609.16334-2-byungchul@sk.com>
 <20250527025047.GA71538@system.software.com>
 <CAHS8izOJ6BEhiY6ApKuUkKw8+_R_pZ7kKwE9NqzCyC=g_2JGcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izOJ6BEhiY6ApKuUkKw8+_R_pZ7kKwE9NqzCyC=g_2JGcA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa1BMYRjHvXvec/a0LMdKXkJjXcvohjwfTDJuL+MD41sMdnTYZbvMlpTB
	hGaMHSXE1NrMCrVy2VrpptmprUkuQ7OUza1swojQsi41Ybcx+vab5z//5/d8eHhGUchO4jUJ
	KaIuQaVVcjIs+ziqcF6UGKUOP18YBEbLVQ6u/EiD4s4qFowlFQi+/nwmBXfjbQ4unPcwYHyY
	ieGb5RcD3U0uKXQUvcFQe6SSAdfxZg6yMvsZOFRllkBLRTYLub8uMVCZ0SmFRzVGDl5e/c3C
	G3sWhjuGyxg6smOgyRQAnnsfEDRaKiXgOVbAwSmHiYOuzA4EjgYXhrMHsxFYbE4W+n8YuZhp
	tPxyu4RWG15Iqcm6m94wh1C908FQa8lRjlr7Tkrp87Zajjbn9WNaXeWW0KzDvRz90v0U00+2
	Vo5aylsxvW9qlFK3deo6IVa2OE7UalJFXVj0Vpm66GsvTioNSbv4+YskA5mn6hHPE2EBab40
	Ro/8fPi+uJ7xMhZmEk9DmY85YTZxOn/62F8IJhdtJ1gvM0IHSx4Yd3p5nKAlhacGsJflwiLy
	3ebm9EjGK4QniLR2n0ZDwVhyJ/81HirPJgPnHIz3BkYIJMWD/NA4iBy+edbn8hPWE3tvu686
	XphO6ipuS7w7iVDOkzxzATN09ERSb3biHDTWMExhGKYw/FcYhilMCJcghSYhNV6l0S4IVacn
	aNJCtyXGW9HfzynaP7CxCvW1bLAjgUfKUXJaulCtYFWpyenxdkR4RukvP7QkSq2Qx6nS94q6
	xC263Vox2Y4CeaycII/07IlTCDtUKeIuUUwSdf9SCe83KQMtrd2e1z2zTL29dcrjyYNt19OU
	kaEDm2e8ZaePKBk3uCN6+caApa+az1zLGf9daOwsSKkbM9fVkx9kmccza/tGTnsUbOvdtLK+
	LDf6Voui527w69GfHtR8PrDM4UblsbNse1dnva3uWhVxLsy/5sacffr5XaRtzcf54a7oFf05
	dfvfhW1R4mS1KiKE0SWr/gAysjaNNQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUzMcRzH9/093e9ujp8rfFcr22FNI2w9fKhV//VlZh5mxmZ10487XVfu
	qlVmqy5SU0lsnMsO6YntktQhN65QmLgWl6JWakZ60AMq0sNM/732fu/9+vzz4WnFKdaD1+gS
	RL1OpVVyMka2I9i4PlAMVG88a5eC2XqLg5s/k6G0y8aCuaIGweivdgmMNDzj4PrVcRrMzZkM
	jFknaOh92i2BzpI+Buqyamnozm/kIDdzkoYMWxkF9UVNLLyuyWPh/MQNGmrTuiTQct/Mwcdb
	0yz0OXIZaDKVM9CZFw5PLcth/EU/ggZrLQXjZ4o4KHRaOOjJ7ETgrO9m4HJ6HgKr3cXC5E8z
	F64k1eVtFLln+iAhlqpEcqfMl+S4nDSpqsjmSNX3cxLS8baOI40XJxlyzzZCkVzjAEeGe98z
	ZNDeypHrn4coYq1uZchLS4Nk59IDspBoUatJEvUbQqNk6pLRASa+0je5eGiYSkNl3jlIymPB
	H38pfUzPMiOsweP1t+eYE3ywy/Vrjt2FtbjYXsDOMi10sviV+egsuwlafK1wiplluRCEf9hH
	uBwk4xXCO4Rbey+g+WIpbrr0iZkf++CpK84ZKT/Dnrj0Dz8fr8TGu5fnbkmFXdgx0DY3XSas
	wo9qnlFn0WLTApNpgcn032RaYLIgpgK5a3RJsSqNNsDPEKNO0WmS/Q7FxVahme8oOTFVYEOj
	LREOJPBIuUhOKgPUClaVZEiJdSDM00p3eUZYoFohj1alpIr6uEh9olY0OJAnzyhXyLftE6MU
	whFVghgjivGi/l9L8VKPNHT1g3G5NL1azx1f7+Ec2xtff6ej8LA1yHV+S4f5OavbE5Sy4xih
	p9dmDyZF+70tKiiI99q7onk0IqRt+6qmrfnBmT1RB7e2+z/YHfHN7/fXks2R91dT3v0B5dnc
	6T0hxfvCToZJo4KfhOJdQW/CWS/butD9bh1S4xJLhOxhVuIFn1QlY1CrNvnSeoPqL8gRMpwZ
	AwAA
X-CFilter-Loop: Reflected

On Tue, May 27, 2025 at 01:03:32PM -0700, Mina Almasry wrote:
> On Mon, May 26, 2025 at 7:50 PM Byungchul Park <byungchul@sk.com> wrote:
> >
> > On Fri, May 23, 2025 at 12:25:52PM +0900, Byungchul Park wrote:
> > > To simplify struct page, the page pool members of struct page should be
> > > moved to other, allowing these members to be removed from struct page.
> > >
> > > Introduce a network memory descriptor to store the members, struct
> > > netmem_desc, reusing struct net_iov that already mirrored struct page.
> > >
> > > While at it, relocate _pp_mapping_pad to group struct net_iov's fields.
> > >
> > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > > ---
> > >  include/linux/mm_types.h |  2 +-
> > >  include/net/netmem.h     | 43 +++++++++++++++++++++++++++++++++-------
> > >  2 files changed, 37 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > > index 56d07edd01f9..873e820e1521 100644
> > > --- a/include/linux/mm_types.h
> > > +++ b/include/linux/mm_types.h
> > > @@ -120,13 +120,13 @@ struct page {
> > >                       unsigned long private;
> > >               };
> > >               struct {        /* page_pool used by netstack */
> > > +                     unsigned long _pp_mapping_pad;
> > >                       /**
> > >                        * @pp_magic: magic value to avoid recycling non
> > >                        * page_pool allocated pages.
> > >                        */
> > >                       unsigned long pp_magic;
> > >                       struct page_pool *pp;
> > > -                     unsigned long _pp_mapping_pad;
> > >                       unsigned long dma_addr;
> > >                       atomic_long_t pp_ref_count;
> > >               };
> > > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > > index 386164fb9c18..08e9d76cdf14 100644
> > > --- a/include/net/netmem.h
> > > +++ b/include/net/netmem.h
> > > @@ -31,12 +31,41 @@ enum net_iov_type {
> > >  };
> > >
> > >  struct net_iov {
> > > -     enum net_iov_type type;
> > > -     unsigned long pp_magic;
> > > -     struct page_pool *pp;
> > > -     struct net_iov_area *owner;
> > > -     unsigned long dma_addr;
> > > -     atomic_long_t pp_ref_count;
> > > +     /*
> > > +      * XXX: Now that struct netmem_desc overlays on struct page,
> > > +      * struct_group_tagged() should cover all of them.  However,
> > > +      * a separate struct netmem_desc should be declared and embedded,
> > > +      * once struct netmem_desc is no longer overlayed but it has its
> > > +      * own instance from slab.  The final form should be:
> > > +      *
> > > +      *    struct netmem_desc {
> > > +      *         unsigned long pp_magic;
> > > +      *         struct page_pool *pp;
> > > +      *         unsigned long dma_addr;
> > > +      *         atomic_long_t pp_ref_count;
> > > +      *    };
> > > +      *
> > > +      *    struct net_iov {
> > > +      *         enum net_iov_type type;
> > > +      *         struct net_iov_area *owner;
> > > +      *         struct netmem_desc;
> > > +      *    };
> > > +      */
> > > +     struct_group_tagged(netmem_desc, desc,
> >
> > So..  For now, this is the best option we can pick.  We can do all that
> > you told me once struct netmem_desc has it own instance from slab.
> >
> > Again, it's because the page pool fields (or netmem things) from struct
> > page will be gone by this series.
> >
> > Mina, thoughts?
> >
> 
> Can you please post an updated series with the approach you have in
> mind? I think this series as-is seems broken vis-a-vie the
> _pp_padding_map param move that looks incorrect. Pavel and I have also
> commented on patch 18 that removing the ASSERTS seems incorrect as
> it's breaking the symmetry between struct page and struct net_iov.

I told you I will fix it.  I will send the updated series shortly for
*review*.  However, it will be for review since we know this work can be
completed once the next works have been done:

   https://lore.kernel.org/all/20250520205920.2134829-2-anthony.l.nguyen@intel.com/
   https://lore.kernel.org/all/1747950086-1246773-9-git-send-email-tariqt@nvidia.com/

> It's not clear to me if the fields are being removed from struct page,
> where are they going... the approach ptdesc for example has taken is

They are going to struct net_iov.  Or I should introduce another struct
mirroring struct page as ptdesc did, that would be the exact same as
struct net_iov.  Do you think I should do that?

> to create a mirror of struct page, then show via asserts that the
> mirror is equivalent to struct page, AFAIU:
> 
> https://elixir.bootlin.com/linux/v6.14.3/source/include/linux/mm_types.h#L437
> 
> Also the same approach for zpdesc:
> 
> https://elixir.bootlin.com/linux/v6.14.3/source/mm/zpdesc.h#L29

Okay, again.  Thanks.

	Byungchul

> In this series you're removing the entries from struct page, I'm not
> really sure where they went, and you're removing the asserts that we
> have between net_iov and struct page so we're not even sure that those
> are in sync anymore. I would suggest for me at least reposting with
> the new types you have in mind and with clear asserts showing what is
> meant to be in sync (and overlay) what.
> 
> -- 
> Thanks,
> Mina


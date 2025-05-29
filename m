Return-Path: <bpf+bounces-59271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0557EAC774F
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 06:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB429501300
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 04:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE16025229D;
	Thu, 29 May 2025 04:47:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C321A3167;
	Thu, 29 May 2025 04:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748494022; cv=none; b=H1mc+7dUTPw4z5i5OKJ6COCYFmSJWjXv7JxmZnyCEIeiz4IB8jEiELfOFVKh0exhL+A9LfIPw5Ya7WdCkb6gjE2kEI+0xWLoz7jRj6/rnXXqI0n8fLfR0ZidEB+erVEXar40DfwkkGUmP8RyXsTJE/XU+CJsLFX+wP2j4pasEwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748494022; c=relaxed/simple;
	bh=ym87ZNfOP6kxoo6tAShh36EKFJb1j246Tla6OQTAB5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUfJRrA8ELM8kLwUXM4Iy+Yxrp9LGjFkEqL2V8PR8wuXwURw3ez+SAUCuYFd/dmJN69HZvHdXk5E3J3AU7Wvp43jpNxUCvc4RfRJPPlsTZcdWMefzxyNBik4CV7Rdhait7BjHi57AD6mwtfgneAGkOHkv58w8HVeAJxUTx76++8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-ff-6837e6be8606
Date: Thu, 29 May 2025 13:46:48 +0900
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
Subject: Re: [PATCH v2 01/16] netmem: introduce struct netmem_desc
 struct_group_tagged()'ed on struct net_iov
Message-ID: <20250529044648.GA1148@system.software.com>
References: <20250528022911.73453-1-byungchul@sk.com>
 <20250528022911.73453-2-byungchul@sk.com>
 <CAHS8izPTBnSL_zrW-u0mKBXC=iP9=WZcS9etCRpufCkpCwYoAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izPTBnSL_zrW-u0mKBXC=iP9=WZcS9etCRpufCkpCwYoAg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRTHe/ZeHY7eltpTQdlCRCm7YHk+hAYRvgSBIhGkYCtf3PK2NjWN
	ClNLkrQrmOst1s3mrcEqnTUk19i0y7SFMTOdmkrRxdQyU9FaEvntxzn/c37nw2EJ+U1qBavO
	zBa0mcp0BS0lpV/8b65vHo5SbXz5ajGIpjoaaifz4G6fhQKxpgHB91/dDIzbnTTcujFBgNhe
	TMIP0xQBQ44BBrxVwyRYSxoJGDjXSkNZ8TQBhRajBDoayim4PHWHgMaCPgZePxJp6K2bo2DY
	VkZCm76aBG/5dnAYgmDi+WcEdlOjBCbOXqPhkttAw/tiLwL30wESrp4sR2Bq9lAwPSnS29fw
	D6q7JHyTvofhDeYc/r4xnC/1uAneXHOG5s1jFxn+3RsrzbdemSb5Jsu4hC8r+krzo0NvSX6k
	uZPmTQ86Sf6Fwc7w4+ZVcdw+6bYUIV2dK2g3RO+XqnpHHZTGG5ZnsrroAvRxVSnyYzEXid/W
	i8Q/trSUU6WIZUkuBLc/D/aVaS4Uezy//kYCuDB8u/kC5WOC81LYJR7y8VIuCw/+nKJ9LOOi
	cPe5wT95KSvnjAjPzRZK5htLcFvlIDk/HIpnrrsJn4vgVuK7s+x8eTUuenj1r8uPi8eVtysY
	Hwdya/GTBqfEtxNzVhZ7az9T8zcvxy1GD3keLdEvUOgXKPT/FfoFCgMia5BcnZmboVSnR0ao
	8jPVeREHszLM6M/nVB2fSbSgsY4EG+JYpPCXtaIolZxS5uryM2wIs4QiQFYYs1Ull6Uo848K
	2qxkbU66oLOhlSypWCbbPHEkRc6lKrOFNEHQCNp/XQnrt6IAlaS66hepu57N1sasPfBtyJk0
	ImNdk2Rv3GHFiRnTljpN9OYWqzFw59HkgU/fQmJeOroflxTtZbSHqpyivUyMnN67Izjr62ys
	cLrLfqFiZ9xw8R7Nves6VVDlOqUuKWV3f//IB4FjiF3E+UnDUMKptO7YxMHoxfE9ck9I7JNj
	JxSkTqXcFE5odcrf0V1RuTUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRiH+5/bjqvFcWmeki6swhtaQeUbhhYEHvzQRSrBL3XKQ1vqlE1F
	o9DUsCxXllSuGaupmQknvM5Ykhe8oGhONEtzMi8USWWWlluWSyK/Pfx+7/u8X14al18m19Mq
	dZKgUfNxCkpKSA+FZAW+mAxW7ih7vhcMYgUFT3+kwuNRMwmG8loE334OSWCmpY0C08NZHAw9
	2QR8F+dxmGi1S8BWOkmAJacOB/uNdgrysh04ZJrLMGgu6iDhVa2OhIL5EhzqMkYl0PfcQMFI
	xW8SJpvyCOjQPyHAptsPrca1MNs5haBFrMNg9noRBbetRgrGsm0IrM12Au5f0iEQGwZJcPww
	UPsVXPWTNxhXr38n4YyVyVxVmT+XO2jFucryqxRX+fWWhBsesFBc+z0HwdWbZzAuL+sTxU1P
	vCW4zw39FGd6/wXjxOp+gusytkiOuEdL98UIcaoUQbM99JRUOTLdSiba/FJFSzeVgT5szEVu
	NMvsYs2NOjIX0TTBbGN7Oje7YorxYQcHf+Iu9mD82OKGfNLFOGMj2W7DORevYRLY8bl5ysUy
	JpgdujG+OC+l5UwZYn8vZGJLhTvbUThOLC37sM4HVtx1C2e82ccL9FK8ic2quf/3lhtzlC0s
	vitxsSezhX1Z24bdRKv1y0z6ZSb9f5N+mcmIiHLkoVKnxPOquN1B2lhlmlqVGnQmIb4SLT5H
	6UVnvhl96wtvQgyNFKtk7ShYKSf5FG1afBNiaVzhIcsM26OUy2L4tPOCJuGkJjlO0DYhb5pQ
	eMkiooRTcuYsnyTECkKioPnXYrTb+gwUE+L0nQvzXffwUVCB6JTVn7bzEb7DCxMrMfHTnjYh
	ei7KUhQg20K+FtOPaq8NZPkfXOE8fueK2uvX1YBGY6TDP9KvKun22ArrR5M69PCGktDiGpPm
	WtcJTx4pTAdUKU8dObqpksBnqq3TLXJ722Gv+mNh+VWW3uIL0tnw3qh0BaFV8jv9cY2W/wNU
	cGkJGAMAAA==
X-CFilter-Loop: Reflected

On Tue, May 27, 2025 at 08:39:43PM -0700, Mina Almasry wrote:
> On Tue, May 27, 2025 at 7:29 PM Byungchul Park <byungchul@sk.com> wrote:
> >
> > To simplify struct page, the page pool members of struct page should be
> > moved to other, allowing these members to be removed from struct page.
> >
> > Introduce a network memory descriptor to store the members, struct
> > netmem_desc, reusing struct net_iov that already mirrored struct page.
> >
> > While at it, add a static assert to prevent the size of struct
> > netmem_desc from getting bigger that might conflict with other members
> > within struct page.
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> 
> This patch looks fine to me, but as of this series this change seems
> unnecessary, no? You're not using netmem_desc for anything in this
> series AFAICT. It may make sense to keep this series as
> straightforward renames, and have the series that introduces
> netmem_desc be the same one that is removing the page_pool fields from
> struct page or does something useful with it?

I didn't document well nor even work quite well for my purpose.  I have
to admit I was also confused because the network code already had a
struct mirroring struct page, net_iov, so I thought it could be the
descriptor along with struct netmeme_desc until the day for page pool.

However, thanks to you, Pavel, and all, I understand better what net_iov
is for.  I posted v3 with all the feedbacks applied, I guess the changes
in v3 are going to meet what you guys asked me.

On the top of v3, I think we can work on organizing struct net_iov to
make it look like:

	struct net_iov {
		struct netmem_desc desc;

		net_iov_field1;
		net_iov_field2;
		net_iov_field3;
		...
	};

In order to make it, we should convert all the references to the
existing fields in struct net_iov, to access them indirectly using desc
field like e.g. 'net_iov->pp' to 'net_iov->desc.pp'.  Once the
conversion is completed, we can make net_iov look better, which is not
urgent and I will not include the work in this series.

Please check v3:

   https://lore.kernel.org/all/20250529031047.7587-1-byungchul@sk.com/
   https://lore.kernel.org/all/20250529031047.7587-2-byungchul@sk.com/

Thanks to all.

	Byungchul

> > ---
> >  include/net/netmem.h | 41 +++++++++++++++++++++++++++++++++++------
> >  1 file changed, 35 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > index 386164fb9c18..a721f9e060a2 100644
> > --- a/include/net/netmem.h
> > +++ b/include/net/netmem.h
> > @@ -31,12 +31,34 @@ enum net_iov_type {
> >  };
> >
> >  struct net_iov {
> > -       enum net_iov_type type;
> > -       unsigned long pp_magic;
> > -       struct page_pool *pp;
> > -       struct net_iov_area *owner;
> > -       unsigned long dma_addr;
> > -       atomic_long_t pp_ref_count;
> > +       /*
> > +        * XXX: Now that struct netmem_desc overlays on struct page,
> 
> This starting statement doesn't make sense to me TBH. netmem_desc
> doesn't seem to overlay struct page? For example, enum net_iov_type
> overlays unsigned long page->flags. Both have very different semantics
> and usage, no?
> 
> > +        * struct_group_tagged() should cover all of them.  However,
> > +        * a separate struct netmem_desc should be declared and embedded,
> > +        * once struct netmem_desc is no longer overlayed but it has its
> > +        * own instance from slab.  The final form should be:
> > +        *
> 
> Honestly I'm not sure about putting future plans that aren't
> completely agreed upon in code comments. May be better to keep these
> future plans to the series that actually introduces them?
> 
> > +        *    struct netmem_desc {
> > +        *         unsigned long pp_magic;
> > +        *         struct page_pool *pp;
> > +        *         unsigned long dma_addr;
> > +        *         atomic_long_t pp_ref_count;
> > +        *    };
> > +        *
> > +        *    struct net_iov {
> > +        *         enum net_iov_type type;
> > +        *         struct net_iov_area *owner;
> > +        *         struct netmem_desc;
> > +        *    };
> > +        */
> > +       struct_group_tagged(netmem_desc, desc,
> > +               enum net_iov_type type;
> > +               unsigned long pp_magic;
> > +               struct page_pool *pp;
> > +               struct net_iov_area *owner;
> > +               unsigned long dma_addr;
> > +               atomic_long_t pp_ref_count;
> > +       );
> >  };
> >
> >  struct net_iov_area {
> > @@ -73,6 +95,13 @@ NET_IOV_ASSERT_OFFSET(dma_addr, dma_addr);
> >  NET_IOV_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
> >  #undef NET_IOV_ASSERT_OFFSET
> >
> > +/*
> > + * Since struct netmem_desc uses the space in struct page, the size
> > + * should be checked, until struct netmem_desc has its own instance from
> > + * slab, to avoid conflicting with other members within struct page.
> > + */
> > +static_assert(sizeof(struct netmem_desc) <= offsetof(struct page, _refcount));
> > +
> >  static inline struct net_iov_area *net_iov_owner(const struct net_iov *niov)
> >  {
> >         return niov->owner;
> > --
> > 2.17.1
> >
> 
> 
> -- 
> Thanks,
> Mina


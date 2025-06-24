Return-Path: <bpf+bounces-61331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60574AE590B
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 03:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631C11BC1D51
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 01:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5257E194A45;
	Tue, 24 Jun 2025 01:18:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94495219ED;
	Tue, 24 Jun 2025 01:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750727886; cv=none; b=YzskCG4RtJ81DhTjIcE9m6z5WlIjxMl//vn7QuD8Af43dvlw7jC39lubmY9C8bVZJunx4OFlyDbYCUiN2hUXxiyCTew3iBes6hc0tM5FwDtZPpqpIl4YYJlvXqeOGBaaZ9E7wd5kHmGVus1uP+4eVJfLUg97LSbjtBKXM6plEqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750727886; c=relaxed/simple;
	bh=me71ucRDq5kbDYscPFKpYks6kdIMdxFX9R2d1sKvSw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t15FTP/cBktfbwLQxQEPRRdA4969zkCYVA768XeT/JIjI4p1I4eLo+hqa0wwomBH9pYBV+Gbiw0p2ifjbOl2zbW7J8QbJF7pRBvuhC3owPV/TwwVJjZJdWY+eoLCqRCE90x3Ait6H7EBU+LMzQRCJEXSqGWz5XKVwRLD1vENmxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-66-6859fcbd1974
Date: Tue, 24 Jun 2025 10:17:44 +0900
From: Byungchul Park <byungchul@sk.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Harry Yoo <harry.yoo@oracle.com>, David Hildenbrand <david@redhat.com>,
	willy@infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, kuba@kernel.org,
	ilias.apalodimas@linaro.org, hawk@kernel.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch,
	asml.silence@gmail.com, toke@redhat.com, tariqt@nvidia.com,
	edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	horms@kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com,
	jackmanb@google.com
Subject: Re: [PATCH net-next v6 1/9] netmem: introduce struct netmem_desc
 mirroring struct page
Message-ID: <20250624011744.GA5820@system.software.com>
References: <20250620041224.46646-1-byungchul@sk.com>
 <20250620041224.46646-2-byungchul@sk.com>
 <8eaf52bf-4c3c-4007-afe5-a22da9f228f9@redhat.com>
 <20250623102821.GC3199@system.software.com>
 <aFlGCam4_FnkGQYT@hyeyoo>
 <CAHS8izMbtp0dN3+PZsivFD4Zg1DqaL5BJ4cw4jGjs=wCXAns3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izMbtp0dN3+PZsivFD4Zg1DqaL5BJ4cw4jGjs=wCXAns3A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+917d+91Obguq18JJjOJDHtKnkpKivASFEUQlfa45a0t54NN
	TYNgpihZWz6CarOYWWpqjZbpCrWaZkZR5ov10PnIIiolLXEqlZtE/vfhnO85n/PHYUn5XclC
	VhWfJGriBbWCllLS797XQ+om9ylXWtr8odBSSUPFWCqU9tgkUFhejeCn6z0DI43PaCguGiWh
	8HUmBb8s4yQMNPUxUGHdDs6STxTUZteQ0HehmQZ95gQJda5BBs7YyghoqTZI4OL4TRJqdD0M
	tD0spKG78o8EPtn1FDw33qLAaYiAJvM8GH3xDUGjpYaA0fNXaShoNdPQn+lE0NrQR4Ep3YDA
	Uu+QwMTY1A7T024mYjHf8G2I5KtuvSX4B8Yuhjdbk/l7ZcF8jqOV5K3lZ2neOpzP8B86a2m+
	+fIExT+wjRC8PmOQ5n8MvKP4ofoOmrdUdVD8S3Mjs9NnvzQ8RlSrUkTNio2Hpcr2YReR+EqR
	qhvOI3Uo1y8HebGYC8WGtl6Ug1gPv/86112muCD8uVNPuJnmlmCHw0W62Zdbim/U50ncTHIP
	aZzR5OE5nIAv5fd78jIuDBcXfZ/KS1k5V0LgrKoGZrrhg59f+UhNDy/Bk9daSbeX5Pxw6W92
	urwIZ9w3eVxe3C7c/i7bMzqXC8SPq58R7p2Ye8nivvR8cvr+BfhJmYPKRT7GGQrjDIXxv8I4
	Q2FGVDmSq+JT4gSVOnS5Mi1elbr8aEKcFU09UsnpySgbGm7ZbUccixTeMtv6fUq5REjRpsXZ
	EWZJha/MvnmPUi6LEdJOiZqEQ5pktai1Iz+WUsyXrR49GSPnjgtJYqwoJoqaf12C9VqoQ4HN
	oVtdQY/qf7Qkznqz7cSWkoPjW5NPLAvxVtSdrd7QH/slfO3Xvbo5AQF2bdgL3/RjkRZZnm3z
	tov0uuiw6Eg946c2Zfuu6WJL75zbkX7gp9apVR+RDgX2P/U3ZdSOaHf1DobcVhcPCCPOrhW9
	VFBWgeFy1LmKcE3oJstAwuzuBQpKqxRWBZMarfAXkil51kQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+59zdnZcTU7L6p9Cl1WUlqbQ5cUuWB/yX2CUQrcvterQRjpl
	U9Eg0iZG0kzNqOYSxdK8jpbptJSaZUlpNi8s72iakGlZinN28ULkt4f3eZ7f8+XlaNlNkTun
	UkcKGrUiVM5KGMmhnTrvqqkTSt+6765gNBWxUDgRA3k9FhEYC8oQ/HS0i+HHy9cs5GSP02B8
	n8DAmGmShv7aXjEUmoOgO3eAgWdXy2novfGGBX2Ck4Yqx7AYrlgeUlBzr04EjWXJIkiffEBD
	eVyPGJoqjSx0Ff0RwYBVz0CdIZ+B7uQAqM1aBuNvhxC8NJVTMH79Hgs3bVks9CV0I7DV9DKQ
	EZ+MwFRtF4FzYpqR8apLHLCe1AyN0KQ0/yNFKgydYpJljiKPH3qRJLuNJuaCaywxj6aJSUfr
	M5a8ueNkSIXlB0X0umGWfO9vY8hIdQtLcga/UcRU2sIclp2U7DonhKqiBc2WPaclyuZRBxXR
	II+JG02l41CKRxLiOMxvxe1fliYhF47h1+PPrXpqRrP8Bmy3O+gZ7cZ74vvVqaIZTfOVLNbV
	zuolvALfTuubzUv5HTgn++t0XsLJ+FwKJ5bWiOeMxbju7idmrrwBT2Xa6JldmvfAeb+5ufMq
	rHuSMbvlwh/BzW1XZ6tL+bX4edlrKgW5GuaRDPNIhv8kwzxSFmIKkJtKHR2mUIVu89FeUMaq
	VTE+Z8PDzGj6VXIvTaVa0M+mQCviOSRfJLX4n1DKRIpobWyYFWGOlrtJrfuOKmXSc4rYi4Im
	/JQmKlTQWpEHx8iXSw8eE07L+POKSOGCIEQImn8uxbm4xyFXxzdbyPvMA9KxdeqMt0Rfy6Sd
	kRU7KzJ9elcvvOsZsWL3i41O7+Jr9TnBfn6msBImsXKwxxI/PFT0a7//yBrb8aeFHTdCqi6V
	+uoKA4P8Qx6t7PyQ3tj/LmBBZ1PmJvs4fbx+ODIxv6RRMoYb7Ns9Y9bd8greW3xGdrmloXFz
	ilHOaJUKPy9ao1X8BSc5QhUmAwAA
X-CFilter-Loop: Reflected

On Mon, Jun 23, 2025 at 12:09:09PM -0700, Mina Almasry wrote:
> On Mon, Jun 23, 2025 at 5:18 AM Harry Yoo <harry.yoo@oracle.com> wrote:
> > On Mon, Jun 23, 2025 at 07:28:21PM +0900, Byungchul Park wrote:
> > > On Mon, Jun 23, 2025 at 11:32:16AM +0200, David Hildenbrand wrote:
> > > > On 20.06.25 06:12, Byungchul Park wrote:
> > > > > To simplify struct page, the page pool members of struct page should be
> > > > > moved to other, allowing these members to be removed from struct page.
> > > > >
> > > > > Introduce a network memory descriptor to store the members, struct
> > > > > netmem_desc, and make it union'ed with the existing fields in struct
> > > > > net_iov, allowing to organize the fields of struct net_iov.
> > > >
> > > > It would be great adding some result from the previous discussions in
> > > > here, such as that the layout of "struct net_iov" can be changed because
> > > > it is not a "struct page" overlay, what the next steps based on this
> > >
> > > I think the network folks already know how to use and interpret their
> > > data struct, struct net_iov for sure.. but I will add the comment if it
> > > you think is needed.  Thanks for the comment.
> >
> > I agree with David - it's not immediately obvious at first glance.
> > That was my feedback on the previous version as well :)
> >
> > I think it'd be great to add that explanation, since this is where MM and
> > networking intersect.
> >
> 
> I think a lot of people are now saying the same thing: (1) lets keep
> net_iov and page/netmem_desc separate, and (2) lets add comments
> explaining their relation so this intersection between MM and
> networking is not confused in the long term .
> 
> For #1, concretely I would recommend removing the union inside struct
> net_iov? And also revert all the changes to net_iov for that matter.

It seems like many got it wrong.  I didn't change the layout of net_iov
much.  I did nothing but replaced the existing pp fields in net_iov with
a wrapper, netmem_desc that still has the same fields.  Even with
net_iov reverted, net_iov still has the fields of netmemdesc.

Just to clarify, netmem_desc is the intersection but net_iov is not.
net_iov is a network's thing.

> They are all to bring netmem_desc and net_iov closer together, but the

It was already closer together even before this series, since netmem_ref
is used to unify the related usages.

> feedback is that we should keep them separate, and I kinda agree with
> that. The fact that net_iov includes a netmem_desc in your patch makes
> readers think they're very closely related.

Again, they were already very closely related before this series.  Of
course I agree with that it should be kept separated but it's another
issue.  It can be done on top of this series by e.g. Pavel as he said.

> For #2, add this comment (roughly) on top of struct net_iov? Untested
> with kdoc and spell checker:
> 
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 7a1dafa3f080..8fb2b294e5f2 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -30,6 +30,25 @@ enum net_iov_type {
>         NET_IOV_MAX = ULONG_MAX
>  };
> 
> +/* A memory descriptor representing abstract networking I/O vectors.
> + *
> + * net_iovs are allocated by networking code, and generally represent some
> + * abstract form of non-paged memory used by the networking stack. The size
> + * of the chunk is PAGE_SIZE.
> + *
> + * This memory can be any form of non-struct paged memory. Examples include
> + * imported dmabuf memory and imported io_uring memory. See
> net_iov_type for all
> + * the supported types.

The description should be changed depending on the result of discussion.
However, I will basically add this doc with some adjustment.

Thanks Mina.

	Byungchul

> + *
> + * @type: the type of the memory. Different types of net_iovs are supported.
> + * @pp_magic: pp field, similar to the one in struct page/struct netmem_desc.
> + * @pp: the pp this net_iov belongs to, if any.
> + * @owner: the net_iov_area this net_iov belongs to, if any.
> + * @dma_addr: the dma addrs of the net_iov. Needed for the network card to
> + * send/receive this net_iov.
> + * @pp_ref_count:  the pp ref count of this net_iov, exactly the same usage as
> + * struct page/struct netmem_desc.
> + */
> 
> 
> 
> 
> 
> --
> Thanks,
> Mina


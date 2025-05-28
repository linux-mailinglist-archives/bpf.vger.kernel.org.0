Return-Path: <bpf+bounces-59049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F162CAC5ED4
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 03:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2A7C4A17FF
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 01:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE9D19EEC2;
	Wed, 28 May 2025 01:31:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDF83EA63;
	Wed, 28 May 2025 01:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748395918; cv=none; b=hgRib9UjowOwE4tbGOYD3jotjDQ1HXKbDHCbFwHQnFkJ0jvRyt86poqL/2pYPTNqYS6+bhbEPvJTXf/tFndJaousq4JWvjObSsHGfUQ8XVS+hRp4pb52/utCauhpHulYtww0SFwZLcFv3j0ORK1VWI+3sy1ctac3aA+H4O1xxkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748395918; c=relaxed/simple;
	bh=DnBoCKZIfZh8wjVZyghSCR6eXUupTg0NHFjxZ0bAA/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4BESKFMUDJzJ4INMwy/z96vs7LowJ2YBqvsLFWM0LytgRpTUbAj4RdKxhPNREg7BXd1oV/iJJ4b8rfCm9nvu40SB3FkQkSwAe1rsRWa5Hvz66ZIjVFV2xoo+EBygW1w+em818VlCa4j4foTwUKzVOsp4s880F5qj0SHXeReLio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-55-6836678697d7
Date: Wed, 28 May 2025 10:31:45 +0900
From: Byungchul Park <byungchul@sk.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, willy@infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch, toke@redhat.com,
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
	saeedm@nvidia.com, leon@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	vishal.moola@gmail.com
Subject: Re: [PATCH 18/18] mm, netmem: remove the page pool members in struct
 page
Message-ID: <20250528013145.GB2986@system.software.com>
References: <20250523032609.16334-1-byungchul@sk.com>
 <20250523032609.16334-19-byungchul@sk.com>
 <CAHS8izM-ee5C8W2D2x9ChQz667PQEaYFOtgKZcFCMT4HRHL0fQ@mail.gmail.com>
 <20250526013744.GD74632@system.software.com>
 <cae26eaa-66cf-4d1f-ae13-047fb421824a@gmail.com>
 <20250527010226.GA19906@system.software.com>
 <651351db-e3ec-4944-8db5-e63290a578e8@gmail.com>
 <CAHS8izNYmWTgb+QDA72RYAQaFC15Tfc59tK3Q2d670gHyyKJNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izNYmWTgb+QDA72RYAQaFC15Tfc59tK3Q2d670gHyyKJNQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se2xLYRjG851zenpWmnyr4dsmLhVZtrjH5RWCEPH9IUwwyRAaO9FGV9La
	NcTMYlG7uC3oijK7daPUbB3SMMtcky51K8boWIhdMt2qu8SlXcT+++V93vd5nj9egVWUSKIE
	jW6fqNeptEpexsk6R1+acWTXAvXsXNd0MNuqeagKpEP5R4cEzNZaBL3976Tga3zIQ8klPwtm
	Vw4HfbYBFr40eaXQWtbOwd3cOha8hY94yM8ZZCHbUcFAc22BBE4PlLJQl/VRCs9vm3n4UP1b
	Au0N+Rw8NlVy0FqwHJos48D/tANBo62OAX/eeR5OuS08tOW0InA/8HJQfKgAgc3pkcBgwMwv
	n0JrKt8wtN70Xkot9hR6syKOGj1ultqtR3lq/3FSSlte3eXpo7ODHK13+Biaf7iLpz1f3nK0
	2/mSp7aalxx9ZmmUUp99YjxOlC1JErWaVFE/a+kOmbroQQDtfTc+faC0n89CfmxEgkDwPPK1
	aY0RhYUwcP69NMgcnkaenL6KgszjGOLx9LNBjsCx5IrzhMSIZAKLuyTkWv/tkDAGbyQvPp0L
	HcvxQpJ3xykNLilwDUsKP7fxw0I4eXzuMxdk9q/r0AU3GyzB4mhS/ksYHk8ih28VhzzD8Hpi
	vXwxxGPxVHKv9iET9CTYIZBmq58bbh1J7ld4uOMo3DQiwjQiwvQ/wjQiwoI4K1JodKnJKo12
	3kx1hk6TPnPnnmQ7+vs6ZQeGtjjQj+YNDQgLSDlaTq/PVyskqlRDRnIDIgKrjJBnL1ugVsiT
	VBmZon7Pdn2KVjQ0oGiBU46Xz/WnJSnwLtU+cbco7hX1/1RGCIvKQuWbihLjXdY0b5Xh+DrX
	ClBGtUWQn0X2mPXRnYxJ51EO3Qjzuhd9i/T1TbyH0zJu1LdsdVa/TR44W6yL6lkV8z3Q0bhZ
	i65MimQY/c8UV++ZUS0r9bJj2xKiX3fXOi2rPQkH32R3rQ1kGZetjMktyYudzM4v3J+52Dmh
	pc0XeUzJGdSqOXGs3qD6Ax+7MRg2AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRiGe/cdHS4+p+aXFcEsokFWkPV0oKQDvkREYdHhT678cMM5Y1PR
	aqDTkszZSSvnrHWwdB0WnisbouK0gsTSVmaWmkRF2TzNmZVbRP67eO77vn49LCHNpkJZlSZJ
	0GoUahktJsXb12YuORG3UrnM6JoHZtsdGm67U+HW+1oKzNZqBMPjXQwMNTlouH51lADz8ywS
	RmweAj429zLQc3OAhLrsGgJ6T7fQYMyaIMBQWyqCxuJWCtqq8yjI95QQUJP+noEXD800vLvz
	m4KBBiMJraYyEnryIqHZMgtGn35F0GSrEcFobjEN59stNPRl9SBob+wloSgjD4HN7qRgwm2m
	I2W4suy1CD8wdTPYUp6MK0rlOMfZTuBy60kal7vOMfhtZx2NWy5NkPhB7ZAIGzO/0fjHxzck
	/m7voPH1T4MibKvsIPEzSxOzI2C/eF2soFalCNql62PEyoJGNzrcFZLqKRmn09Eol4P8WJ5b
	wbuLuxkvk9xC/kn+XeRlmlvEO53jhJeDuMX8DftZKgeJWYL7RvH3xh/6gkBuF//yQ6FvLOFW
	8bmP7Iy3JOUqCf50fx/9NwjgWwv7SS8TU9afl9unxuwUz+Fv/WL/nufzmVVFPqcft5O3Xrvi
	42AujK+vdojOoJmmaSbTNJPpv8k0zWRBpBUFqTQpCQqVOiJcF69M06hSww8lJpSjqfe4qf95
	thYNv4hqQByLZP4SfD9CKaUUKbq0hAbEs4QsSGLYsFIplcQq0o4I2sQD2mS1oGtAc1hSFiLZ
	ukeIkXJxiiQhXhAOC9p/qYj1C01HDsmFGlbYre9b97kwo7mbYjyP48a27Y0OrtN8WdUV5jG0
	tTFzL+e7DkTbDRf85Zn6Ptp60bG6IGzLYHLuZH9H4kLHmkj4dexo48b6zh9VxzP2llRtih9b
	ENB9cDI6/FXKUP2Mza6i2fJ9R/UuWeCp15aogQr9kbGK/bub2lQjUqeM1CkVy+WEVqf4A5sI
	EioaAwAA
X-CFilter-Loop: Reflected

On Tue, May 27, 2025 at 10:38:43AM -0700, Mina Almasry wrote:
> On Mon, May 26, 2025 at 10:29 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
> >
> > On 5/27/25 02:02, Byungchul Park wrote:
> > ...>> Patch 1:
> > >>
> > >> struct page {
> > >>      unsigned long flags;
> > >>      union {
> > >>              struct_group_tagged(netmem_desc, netmem_desc) {
> > >>                      // same layout as before
> > >>                      ...
> > >>                      struct page_pool *pp;
> > >>                      ...
> > >>              };
> > >
> > > This part will be gone shortly.  The matters come from absence of this
> > > part.
> >
> > Right, the problem is not having an explicit netmem_desc in struct
> > page and not using struct netmem_desc in all relevant helpers.
> >
> > >> struct net_iov {
> > >>      unsigned long flags_padding;
> > >>      union {
> > >>              struct {
> > >>                      // same layout as in page + build asserts;
> > >>                      ...
> > >>                      struct page_pool *pp;
> > >>                      ...
> > >>              };
> > >>              struct netmem_desc desc;
> > >>      };
> > >> };
> > >>
> > >> struct netmem_desc *page_to_netmem_desc(struct page *page)
> > >> {
> > >>      return &page->netmem_desc;
> > >
> > > page will not have any netmem things in it after this, that matters.
> >
> > Ok, the question is where are you going to stash the fields?
> > We still need space to store them. Are you going to do the
> > indirection mm folks want?
> >
> 
> I think I see some confusion here. I'm not sure indirection is what mm
> folks want. The memdesc effort has already been implemented for zpdesc
> and ptdesc[1], and the approach they did is very different from this
> series. zpdesc and ptdesc have created a struct that mirrors the

It's struct netmem_desc.  Just introducing struct netmem_desc that looks
exact same as struct net_iov, is ugly.

> entirety of struct page, not a subfield of struct page with
> indirection:

I think you got confused.

At the beginning, I tried to place a place-holder:

   https://lore.kernel.org/all/20250512125103.GC45370@system.software.com/

But changed the direction as Matthew requested:

   https://lore.kernel.org/all/aCK6J2YtA7vi1Kjz@casper.infradead.org/

So now, I will go with the same direction as the others.  I will share
the updates version with the assert issues fixed.

	Byungchul
> 
> https://elixir.bootlin.com/linux/v6.14.3/source/mm/zpdesc.h#L29
> 
> I'm now a bit confused, because the code changes in this series do not
> match the general approach that zpdesc and ptdesc have done.
> Byungchul, is the deviation in approach from zpdesc and ptdecs
> intentional? And if so why? Should we follow the zpdesc and ptdesc
> lead and implement a new struct that mirrors the entirety of struct
> page?
> 
> [1] https://kernelnewbies.org/MatthewWilcox/Memdescs/Path
> 
> --
> Thanks,
> Mina


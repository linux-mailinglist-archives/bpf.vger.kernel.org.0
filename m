Return-Path: <bpf+bounces-64970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B21B199C0
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 03:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43B56175CE7
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 01:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011F81DD877;
	Mon,  4 Aug 2025 01:03:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56128F4A;
	Mon,  4 Aug 2025 01:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754269402; cv=none; b=Fw1dCWLMZFNKqVxeBZ+NaqlkydUPO3/ybIlaGjXa+sgp6pXZg7YXfDtuvkKYH86KAQuszyt2vLOgwZE1fR8p3/UDU9SD1c1u+CzmcNgGnV8bjevDYAXi3EV07VObX34fa30FocYeFuEq9YNK+geLYPeMJ3rsN1iQFzHSduzcG18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754269402; c=relaxed/simple;
	bh=vrI1/6RmQv7/42SBmMzZtQwpbyWwiF8VImN39u0Cfec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXDESikuC0wSrblfVOfQHGtUsy6GsGWVVWC6YCVDwz01OeUbLAW+YxF3T50XZdO15d3xkd9SLH6GVRnv2HK3FQVuhS4waPd83duSmZu/o3ai7qOi9Uie9fJF+SV9Y28v36V+MtWybvWTnO7vcakzBLQ12G+/zjodlYaFi2aiv8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-5b-689006d004ea
Date: Mon, 4 Aug 2025 10:03:07 +0900
From: Byungchul Park <byungchul@sk.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com,
	sdf@fomichev.me, saeedm@nvidia.com, leon@kernel.org,
	tariqt@nvidia.com, mbloch@nvidia.com, andrew+netdev@lunn.ch,
	edumazet@google.com, pabeni@redhat.com, akpm@linux-foundation.org,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	ilias.apalodimas@linaro.org, willy@infradead.org,
	brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
	usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
	almasrymina@google.com, toke@redhat.com, asml.silence@gmail.com,
	bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
	sfr@canb.auug.org.au
Subject: Re: [PATCH linux-next v3] mm, page_pool: introduce a new page type
 for page pool in page type
Message-ID: <20250804010307.GA39461@system.software.com>
References: <20250729110210.48313-1-byungchul@sk.com>
 <20250801160805.28fa1e05@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801160805.28fa1e05@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHe+5zd+91tLgty6dFX1YQGVmG0Qns5VM9QVFUUJhRo93aUKdt
	ZtoLzTLMkUt6gVyrJpHZMlYzXyZq6cyZQdlKWS9qaa9kVqbiWmXOiPr243/O+Z3z4QhYWS1T
	CXpDumQ0aJLVnJyVfxpfNPcRV6Cb35KrBLurlINrw5lw5WWVDOzOCgQDwec8jNQ2IfjW6OPg
	o7cfwaWiIQz2hzksDLq+Y3jT1M3DNfca6Cp+y0JNbiWG7hPNHOTnhDDUBvt4OFxVwoC9zMxD
	a4VVBqe/X8ZQaX7Jw+NqOwedpSMyeNuQz8I921UWvpxpxNBlXQ5NjikwdL8XQaOrkoGh4+c5
	aCusZqC8to2HU34HBz05XQj83m4Wzvw4xsG5bCuC0PCosq9gQAbn7nbyy+fQ7ECAo97ez5je
	uvqUoYG6FoZ6bB08dbj30LKSaGoJ+DF1O/M46u4/ydMX7TUcbT4bYqnn1WLqqfrG0PwjfRz9
	+uYZuy4yQR6vlZL1GZJx3tLtcp2vtEOW9iAqM6/+IjYj/0QLEgQixpHG+rUWFDGGvoInXJhZ
	cSapaz+Kw8yJs0ggEBzjyNE8p6yQtSC5gMVynoR8jrGBSaKOlF3oYcKsEIGUvzOjMCvFRBK8
	UcH+ySeSe4WvxxiL0STw6wMTvgGL08iVX0IYI8RY0u48EO6YLM4gdyp8THgVEV8IpK6wnP1z
	51RSXxJgC5Bo+89q+89q+2d1IOxESr0hI0WjT46L0WUZ9JkxO1JT3Gj0o4oP/thShfpbNzQg
	UUDq8YrN2hM6pUyTYcpKaUBEwOpIReKh0Uih1WTtk4yp24x7kiVTA5omsOooxYKhvVqluEuT
	LiVJUppk/FtlhAiVGVnbjg8vWztuhXZD0Wrv5JizaTUDnqRFrSN4o6H5du9tVdKyBJXS6lq9
	JdbjjXev6kqgriWqS+9Tdy9ecLj+NARvPhpemN2Ze9ISNyFhJxm8Hgq93/o8z2LeNGXVz/1R
	pzIzZifFutJ93mJT2rgJ67XTW7qtwqLElXGeziNOp9/Wq2ZNOk1sNDaaNL8BbhHtyE0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA03Sa0hTYRgHcN7znvOe4+rA8ZaHgoglFFKaYfREUdIXT0GXD0EXghp5cMO5
	ZEvTKJplmJLObpBzq0WktQRj6pymkpc27WLmrZW30kykMCuTdHbZjKhvP/7P838+PRwOsTKL
	OY3umKzXqbRKoqAVOzeeXd1BCtVrun1xYCkvI3DvewaUvnExYLE7EUzN9LHwq96N4GuLh8CH
	5i8Ibt2cxmB5nk3Dt/JZDKPuYRbuOXbAUMl7GupyqjEMm1oJ5Gf7MNTPTLBwxnWHAkuFkYVm
	axsDHc4CBq7M3sZQbXzDQlethcBg2S8G3jfl09BmvkvD5NUWDEMF8eC2LYLpJx8RtJRXUzB9
	wUqgp6iWgqr6HhYud9oIjGQPIehsHqbh6tx5AsVZBQh83/0nJwqnGCh+NMjGr5KyvF4iNX/8
	hKXKu68oydvwmJJqzAOsZHOkSRV3oqQ8byeWHPZcIjm+XGKl/t46IrVe89FSzdsNUo3rKyXl
	n50g0ufR1/Tu8AOKTYmyVpMu62M2H1aoPWUDTGp7REZu4w1sRJ3BeSiIE4U40VPYTQKmhUix
	ofccDpgIK0Svd2beYf48u6KIzkMKDgtVrOjz2OYLoYJarLg+QgXMCyBWjRlRwCHCQXHmvpP+
	kweLbUXv5o2FKNH7c9y/z/m9RCz9yQUYJMSKvfaTgY1wYbn40OmhChFv/q9s/q9s/le2IWxH
	YRpdeopKo10XbUhWZ+o0GdFHjqY4kP9pSk7NXXShqa6EJiRwSLmQ35doUocwqnRDZkoTEjms
	DOMPnvZHfKIq84SsP3pIn6aVDU1oCUcrI/jte+XDIUKS6picLMupsv7vlOKCFhsRo7u5jVrw
	I2elyamdjY/sn+zuS362ZtfYLj6U7l97kr0V+6K9vuQTNllydPsaeLTlaVxp6vj6udaW/S9c
	mnFeCN2TZuesPY1ddZH9C5YOTBSfIzh4f+6y0upVSR3Ht/a5SxJWPnI/03m6Te7K80MPXuaq
	9pKyM9aYhNiUSVudkjaoVbFRWG9Q/QZCp756MAMAAA==
X-CFilter-Loop: Reflected

On Fri, Aug 01, 2025 at 04:08:05PM -0700, Jakub Kicinski wrote:
> On Tue, 29 Jul 2025 20:02:10 +0900 Byungchul Park wrote:
> > [PATCH linux-next v3] mm, page_pool: introduce a new page type for page pool in page type
> 
> linux-next does not accept patches. This has to go either via networking or MM.

Yeah.  That's what I found.  Thanks for the confirmation.

> > -     if (unlikely(page_has_type(page)))
> > +     if (unlikely(page_has_type(page))) {
> 
> Maybe add :
> 
>                 /* networking expects to clear its page type before releasing */

I will.

> > +             WARN_ON_ONCE(PageNetpp(page));
> >               /* Reset the page_type (which overlays _mapcount) */
> >               page->page_type = UINT_MAX;
> > +     }
> 
> >  static inline bool netmem_is_pp(netmem_ref netmem)
> >  {
> > -     return (netmem_get_pp_magic(netmem) & PP_MAGIC_MASK) == PP_SIGNATURE;
> > +     /* Use ->pp for net_iov to identify if it's pp,
> 
> Please try to use precise language, this code is confusing as is.
> net_iov may _belong_ to a page pool.
> 
>         * which requires that non-pp net_iov should have ->pp NULL'd.

Thank you.  I will.

> I don't think this adds any information.
> 
> > +      */
> > +     if (netmem_is_net_iov(netmem))
> > +             return !!__netmem_clear_lsb(netmem)->pp;
> > +
> > +     /* For system memory, page type bit in struct page can be used
> 
> "page type bit" -> "page type", it's not a bit.
> 
> > +      * to identify if it's pp.
> 
> ... to identify pages which belong to a page pool.

I will.

> > +      */
> > +     return PageNetpp(__netmem_to_page(netmem));
> >  }
> >
> >  static inline void netmem_set_pp(netmem_ref netmem, struct page_pool *pool)
> > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > index 05e2e22a8f7c..37eeab76c41c 100644
> > --- a/net/core/page_pool.c
> > +++ b/net/core/page_pool.c
> > @@ -654,7 +654,6 @@ s32 page_pool_inflight(const struct page_pool *pool, bool strict)
> >  void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
> >  {
> >       netmem_set_pp(netmem, pool);
> > -     netmem_or_pp_magic(netmem, PP_SIGNATURE);
> >
> >       /* Ensuring all pages have been split into one fragment initially:
> >        * page_pool_set_pp_info() is only called once for every page when it
> > @@ -665,12 +664,19 @@ void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
> >       page_pool_fragment_netmem(netmem, 1);
> >       if (pool->has_init_callback)
> >               pool->slow.init_callback(netmem, pool->slow.init_arg);
> > +
> > +     /* If it's page-backed */
> 
> Please don't add obvious comments.

I added the comment since it's _not_ obvious.  !net_iov means it's not
net_iov, not it's page-backed.  However, since you, as the maintainer,
are okay, I will remove it.  Thanks.

	Byungchul

> > +     if (!netmem_is_net_iov(netmem))
> > +             __SetPageNetpp(__netmem_to_page(netmem));


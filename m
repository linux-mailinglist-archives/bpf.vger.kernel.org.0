Return-Path: <bpf+bounces-74836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1F5C66CBD
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 02:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6F077349243
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 01:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4912FF15B;
	Tue, 18 Nov 2025 01:07:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809D513DBA0;
	Tue, 18 Nov 2025 01:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763428070; cv=none; b=pxUNDjH8sShnG38C4Tthd5fb9ubL4B35Y2rSW9Ix7lI7U0iOXHn/lmo+hivGs7hZIncEclYolbbBZupEEHY20gSrrZLR5bewuN1fAyMgfjJdVKUIaxWnhnsgo8hMOgFLEWxmrnZZsj8X6geaUBjpA0QOAB7b/1SK8lzJfSk/AMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763428070; c=relaxed/simple;
	bh=RIa0Z588PhQvaw9WlnQRMw3efffdXt9Jp1nkopp6lP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CoyImNCV1L0vv1HCyqb/53AgSKIIDLPORe6zakYLkBoA+MHnwprPnXMe40jpuCsUYvim4zxnmgU+RrHiE4fGR5MRoMAqTX77zeDAhmHNg8XmTUyvmHJ29cSM4q9mUsiUfU5GflZIqMlIPs3CHHAPvWQNhqSqEOM5NyYsY8LwGfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-02-691bc6dc6af5
Date: Tue, 18 Nov 2025 10:07:35 +0900
From: Byungchul Park <byungchul@sk.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, linux-mm@kvack.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com, harry.yoo@oracle.com, ast@kernel.org,
	daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
	john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
	leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
	andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	ilias.apalodimas@linaro.org, willy@infradead.org,
	brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
	usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
	almasrymina@google.com, toke@redhat.com, asml.silence@gmail.com,
	bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
	sfr@canb.auug.org.au, dw@davidwei.uk, ap420073@gmail.com,
	dtatulea@nvidia.com
Subject: Re: [RFC mm v6] mm: introduce a new page type for page pool in page
 type
Message-ID: <20251118010735.GA73807@system.software.com>
References: <20251117052041.52143-1-byungchul@sk.com>
 <f25a95a4-5371-40bd-8cc8-d5f7ede9a6ac@kernel.org>
 <e470c73a-9867-4387-9a9a-a63cd3b2654f@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e470c73a-9867-4387-9a9a-a63cd3b2654f@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SW0wTaRTH881Mvxkaa8Za9NO+aI0xIYromnhWN17iy7eJJBp90hi3gYmM
	W9AtgmWzmqJEboKuSNKWkgCiAuIai1BaZaNcveyqywoOKuJWpbICmlqRAkFbiJG3X/7nnN85
	D0dgtfdUCwU55ZBkTjGaDFjNqYdmVax41q6X44Kn1oLzSi2GS6MWuPiiUQWhWj8DzpoGBMHQ
	Ux4+N7Uj+NDageFtSwDBufIRFpwPsjjw148h8Hj9CP63Xcbwut3HwyVXPPRd6OfgRrabBd+p
	2xgKssZZaAoN83CssSosrrPy8LChUAVnx86z4La+4OFfrxPD89rPKuhvLuDgjqOag/fFrSz0
	FW6C9rJ5MHJvEEHrFTcDIydLMXTZvQzUN3XxUNRZhuFlVh+CzhYfB8UTORhKMgsRjI+GlcOn
	gyooaXvOb4qlmYqCacvgO5Zeq+5haLftd44qf95lqMfRy9MyVxqtq4qheUonS101uZi6Amd4
	+qz7Bqa3beMc9fz3PfU0fmBowfFhvC16l/qHRMkkp0vmlRt+UicVnO9gD/boLJ9yb6qsyD87
	D0UJRFxDrjuC7Fd2u318hDlxKbHahlQRxuIyoiihqR5duOfNZWUqZ8UcgeQ5SYTnijtI1sfj
	U7lGBJKbXxlmtaAVSxEZsPfh6cIccsf+ipsejiHK5ACTh4Qw68nFSSESR4kbSK+nbWpXtLiE
	3GzoYCIeIg4KxHHfhacPXUBuVSncaSQ6ZmgdM7SOb9oyxNYgrZySnmyUTWtikzJSZEtswoFk
	Fwq/2IUjE7sbUeDhjmYkCsgwS0Oj9bJWZUxPzUhuRkRgDTpN9lYiazWJxoxfJfOBveY0k5Ta
	jPQCZ5ivWT1yOFEr7jMekn6WpIOS+WuVEaIWWtHRNLsrbVzXv7vClDiUXz56TZcAv6zIyUx/
	Jx39FJed31U82RJY3M2F/lrv3uI/Mbu7d7vO3hscK0zIXDcqLn9SCepFtr93DsJGduC3DtNG
	Zd3muAX40TxZt2fRFn29tyiw7HHyj5aTV3setV2tdv4x+V1CfPY/x4YmLPu9dSFflYFLTTKu
	imHNqcYveGMAdF4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRTHe967q8XbsnpyUbAuglAZFZyu9CHqKboq0eVLLn3JF92UrUyD
	YOXItNTu6ZxgVJrLZa1ym6jJNM0kMsN4pcxaF7taqZmmVJsR9e3H/5zf/3w5Aq1xsmGCbNwj
	mYz6RB2nYlQblqTPftqglSNzzk0Fe3kZB1cGUqHkuYeFwbIuCuyOCgR9g094+FXdgKC3vpGD
	D3U9CC6c76fB/sDKQNetHwi8lV0I3uc5OXjd4Ofhims9dBa/YaAqw02DP/cuB9nWIRqqB7t5
	OOS5HCi+YeGhrrCJhZaKHBZO/7hEg9vynIdHlXYOnpX9YuGNL5uBJlspA1/O1NPQmbMCGoom
	Qn/zRwT15W4K+o8VctCWX0nBreo2Hk61FnHw0tqJoLXOz8CZ4SMcFBzMQTA0EKjsPt7HQsGd
	Z/yKueSgonCk7uNnmtwsbafI47wTDFFq7lHEa+vgSZFrL7lxOYJkKa00cTkyOeLqOcmTp4+r
	OHI3b4gh3heLiNfTS5Hs9G5u08QdqqVxUqKcIpnmLo9RxWdfaqST20NTv2fWshbUNTYLhQhY
	XIDdbj8fZEaciS15n9ggc2I4VpRBOsihgZ23TmUkp8UjAs6y4yCPF6Ox9Vv6SK4WAWcevRhg
	laARCxF+l9/J/RmMw035r5g/cgRWfr6jspAQYC0u+SkE4xBxOe7w3hm5NUGcjmsrGqnjSG37
	z7b9Z9v+2UWIdqBQ2Zhi0MuJC+eYE+LTjHLqnNgkgwsFnqj4wPAJD+p7tNqHRAHpxqjJBK2s
	YfUp5jSDD2GB1oWqM9ZhWaOO06ftl0xJO017EyWzD2kFRjdJvXarFKMRd+v3SAmSlCyZ/k4p
	ISTMglpqt+yL651RKqdtD+OqrqUsC6v5anTeb++IXvDQMsWXOy22jb4dleARrK2nlkZH5eJd
	17/Hro+ZVa5drAp3nP3qVCT98OjkwqujRm3KaL4+dnxB9Ko1Ce5t+w5HGorTI9mNk/MHHGM2
	U3ytoWbtix2ek+Yee9IH78rwym7/wPz9SMeY4/XzImiTWf8bxcwYRUADAAA=
X-CFilter-Loop: Reflected

On Mon, Nov 17, 2025 at 05:47:05PM +0100, David Hildenbrand (Red Hat) wrote:
> On 17.11.25 17:02, Jesper Dangaard Brouer wrote:
> > 
> > On 17/11/2025 06.20, Byungchul Park wrote:
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index 600d9e981c23..01dd14123065 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -1041,7 +1041,6 @@ static inline bool page_expected_state(struct page *page,
> > >    #ifdef CONFIG_MEMCG
> > >                      page->memcg_data |
> > >    #endif
> > > -                    page_pool_page_is_pp(page) |
> > >                      (page->flags.f & check_flags)))
> > >              return false;
> > > 
> > > @@ -1068,8 +1067,6 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
> > >      if (unlikely(page->memcg_data))
> > >              bad_reason = "page still charged to cgroup";
> > >    #endif
> > > -    if (unlikely(page_pool_page_is_pp(page)))
> > > -            bad_reason = "page_pool leak";
> > >      return bad_reason;
> > >    }
> > 
> > This code have helped us catch leaks in the past.
> > When this happens the result is that the page is marked as a bad page.
> > 
> > > 
> > > @@ -1378,9 +1375,12 @@ __always_inline bool free_pages_prepare(struct page *page,
> > >              mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
> > >              folio->mapping = NULL;
> > >      }
> > > -    if (unlikely(page_has_type(page)))
> > > +    if (unlikely(page_has_type(page))) {
> > > +            /* networking expects to clear its page type before releasing */
> > > +            WARN_ON_ONCE(PageNetpp(page));
> > >              /* Reset the page_type (which overlays _mapcount) */
> > >              page->page_type = UINT_MAX;
> > > +    }
> > > 
> > >      if (is_check_pages_enabled()) {
> > >              if (free_page_is_bad(page))
> > 
> > What happens to the page? ... when it gets marked with:
> >     page->page_type = UINT_MAX
> > 
> > Will it get freed and allowed to be used by others?
> > - if so it can result in other hard-to-catch bugs
> 
> Yes, just like most other use-after-free from any other subsystem in the
> kernel :)
> 
> The expectation is that such BUGs are found early during testing
> (triggering a WARN) such that they can be fixed early.
> 
> But we could also report a bad page here and just stop (return false).

I think the WARN_ON_ONCE() makes the problematic situation detectable.
However, if we should prevent the page from being used on the detection,
sure, I can update the patch.

Thanks,
	Byungchul

> 
> --
> Cheers
> 
> David


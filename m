Return-Path: <bpf+bounces-58932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EAAAC3D24
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 11:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A0D53B82D9
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 09:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9451F2388;
	Mon, 26 May 2025 09:43:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1411DED51;
	Mon, 26 May 2025 09:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748252600; cv=none; b=IB8lR4UNIp7A4kVLqMbOgWs+sBYvAzB/BnaN05cVXM7l36LeeNdUVR4BoPo/yzPo7uPEPFGsuqqfZpz88j5RDfrd6x6a2vu830MCKGoxR2fDQ2JadRcvvvmqLU6cty2nxVa5JvBXZv9yT6iwmcPehTl7sGyfa70XWeRmvtwAE2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748252600; c=relaxed/simple;
	bh=RAownFC008qLgAz0i6YGuiM00cnuDux7xgF6Vj1jySM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZG3hOJuy4RH4v1y0E5hjOx9vhEJBZdcxpDMxGdCF/b2qqE3/5mSoYX2YyxiDlX6BjgXuqAKQeeuMFTg11TUgcRtFpXztfx46LR6IxcLbJ2cEn8+gJqAMVQf0MzOa4xn/P+wwKN7jsgapPUl+ZmFCjvFET1F/NWG6MH625w46mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-0e-683437af7710
Date: Mon, 26 May 2025 18:43:05 +0900
From: Byungchul Park <byungchul@sk.com>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: Mina Almasry <almasrymina@google.com>, willy@infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch,
	asml.silence@gmail.com, tariqt@nvidia.com, edumazet@google.com,
	pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	horms@kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	vishal.moola@gmail.com
Subject: Re: [PATCH 12/18] page_pool: use netmem APIs to access
 page->pp_magic in page_pool_page_is_pp()
Message-ID: <20250526094305.GA29080@system.software.com>
References: <20250523032609.16334-1-byungchul@sk.com>
 <20250523032609.16334-13-byungchul@sk.com>
 <CAHS8izN6QAcAr-qkFSYAy0JaTU+hdM56r-ug-AWDGGqLvHkNuQ@mail.gmail.com>
 <20250526022307.GA27145@system.software.com>
 <20250526023624.GB27145@system.software.com>
 <87o6vfahoh.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o6vfahoh.fsf@toke.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRzGe3fOzo7L0XFmvWkoLSQoKithf0rCiOAQFGF0QYMa7eSWc8o0
	0yjUNMp5zfygc9lUsrUuq2VuRWjpUIdRtlCm5QWvlV28NTSlcpPIbz+e932f3/PhpQlxJT+Q
	VqqTOY1appJQQlL4zbdqs1kargh7OxIAevN9Cu7NpMKdfhsf9KY6BNOzHwQwZW+hoLrSTYD+
	bTYJP82/CBhuHhBAX80ICS+uWgkYKGylID97joDLNiMP2usK+FDy6zYB1ox+Abx/rqeg9/4f
	Pow05pPg0N0loa8gEpoNq8Dd9hWB3WzlgTvvJgU3nAYKBrP7EDibBkgozyxAYK538WFuRk9F
	rmNr73bx2Ge6HgFrsJxjnxg3slqXk2AtphyKtUwWC9iPnS8otrV0jmSf2aZ4bH7Wd4qdGO4m
	2R/1HRRrru0g2dcGu4CdsgQfYqKFEXJOpUzhNFt3nxIqSgqPJObgVHfOI14G6hJrkQ+NmXD8
	OleL/nF7TwPpYZIJxa6rTsLDFLMBu1yzC0zTK5k9uG0mVouENMFM8bFpMt97x585i/O6RykP
	ixjADY5iby5mqni4q/XEYu6HHWVD3n5ioXO+wuntJJggfOc3vRiH4Kyn5d6nPgsTbk2/8U4L
	YNbjl3UtPI8XMw9ofH38DbG4eQ1+ZXSRRchPt0ShW6LQ/VfoligMiDQhsVKdEi9TqsK3KNLU
	ytQtpxPiLWjh49Rcmo+xocn2w42IoZHEV3RKskMh5stSktLiGxGmCclK0Vp9mEIsksvSLnCa
	hJOacyouqREF0aRktWi7+7xczMTKkrk4jkvkNP9OebRPYAZadWyscLSs6J10LLOyYnXZK1vz
	nuLQTQe/Fh+Q7vI3lqbaI0L+DPXkxcq/xwSMOTTRn5p7o/afkeyIuFC7z9oWJ093XHNpS1eM
	T+rnjwfvbeqNCv9y5ejOBwc+n2gZK8odEjGP/SY6VXsHw0o+FUgfjq/A6dWRcRdDS5ZJn9cE
	UteXS8gkhWzbRkKTJPsL/3bhnjQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRiA+845OzuuFqel9ZGSsAhLSo2MXqgsf/kVJPWjgpBy5Mktddam
	okUw20A0L138oXPVTHRm0WyVrpuKiilJycyamhesWT+66lze0LZF5L+H53vfh/fHx9Eyg2gd
	p1JnCBq1IlXOShhJ/C79VuvOaGWUpQGByXqPhbvT2WAZtYvAVOdV7plBMUy2v2ShqtJDg+mN
	gYEp6ywNro4xMYzUjDPwPK+RhrGSThaKDHM0XLLXUtB2o0sEPQ3FIiidraahUTcqht6nJhaG
	7y2KYLy1iIEu4x0GRor3QYd5DXhefUXQbm2kwFN4g4XrDjMLHw0jCBxtYwxU5BYjsDY5RTA3
	bWL3ycmjO/0UeWIcEhOzLZM8rA0nBU4HTWx1+SyxTVwTkw/vnrOks2yOIU/skxQp0n9nyS/X
	AEN+NPWxpOrLT4pYH/UxpNvcLj606rhkd5KQqsoSNJExiRJlacmRs/k425NfT+lQv6wABXCY
	j8Y9Q82Mjxl+I3bmOWgfs3wYdjpnvMxxgXwsfjWdXIAkHM1PinDdRJF/ZjV/BhcOfGZ9LOUB
	N3dd83sZf5vC/Z0Jf/0q3FX+yd+nvc35mw5/k+aDsWWB+6tDsf5xhX81wHvCLfdr5OMgfgNu
	aXhJXUErjUtKxiUl4/+ScUnJjJg6FKhSZ6UpVKk7IrQpyhy1KjviVHqaDXn/Rs3F+at25O6N
	a0U8h+QrpIny7UqZSJGlzUlrRZij5YHSEFOUUiZNUuScFzTpJzWZqYK2FQVzjHyt9MAxIVHG
	JysyhBRBOCto/r1SXMA6HQq/2b0psayF73Ddnw3ecjkEmpfNr30muXJB4TqcEXE1xPVtc+iE
	IFuPu5mYwQfvTxzVW8K01l3pNVMnLOVUi7viF3YkDdfXHlx8cTruNLWnOvLngni/u/JUu22b
	wZ5w5FysK63pcUKeUxcUB9XP7F/eGrRuw/LfOfF7K5WkJlfOaJWKbeG0Rqv4AwzywKAXAwAA
X-CFilter-Loop: Reflected

On Mon, May 26, 2025 at 10:40:30AM +0200, Toke Høiland-Jørgensen wrote:
> Byungchul Park <byungchul@sk.com> writes:
> 
> > On Mon, May 26, 2025 at 11:23:07AM +0900, Byungchul Park wrote:
> >> On Fri, May 23, 2025 at 10:21:17AM -0700, Mina Almasry wrote:
> >> > On Thu, May 22, 2025 at 8:26 PM Byungchul Park <byungchul@sk.com> wrote:
> >> > >
> >> > > To simplify struct page, the effort to seperate its own descriptor from
> >> > > struct page is required and the work for page pool is on going.
> >> > >
> >> > > To achieve that, all the code should avoid accessing page pool members
> >> > > of struct page directly, but use safe APIs for the purpose.
> >> > >
> >> > > Use netmem_is_pp() instead of directly accessing page->pp_magic in
> >> > > page_pool_page_is_pp().
> >> > >
> >> > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> >> > > ---
> >> > >  include/linux/mm.h   | 5 +----
> >> > >  net/core/page_pool.c | 5 +++++
> >> > >  2 files changed, 6 insertions(+), 4 deletions(-)
> >> > >
> >> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> >> > > index 8dc012e84033..3f7c80fb73ce 100644
> >> > > --- a/include/linux/mm.h
> >> > > +++ b/include/linux/mm.h
> >> > > @@ -4312,10 +4312,7 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
> >> > >  #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
> >> > >
> >> > >  #ifdef CONFIG_PAGE_POOL
> >> > > -static inline bool page_pool_page_is_pp(struct page *page)
> >> > > -{
> >> > > -       return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> >> > > -}
> >> > 
> >> > I vote for keeping this function as-is (do not convert it to netmem),
> >> > and instead modify it to access page->netmem_desc->pp_magic.
> >> 
> >> Once the page pool fields are removed from struct page, struct page will
> >> have neither struct netmem_desc nor the fields..
> >> 
> >> So it's unevitable to cast it to netmem_desc in order to refer to
> >> pp_magic.  Again, pp_magic is no longer associated to struct page.
> >
> > Options that come across my mind are:
> >
> >    1. use lru field of struct page instead, with appropriate comment but
> >       looks so ugly.
> >    2. instead of a full word for the magic, use a bit of flags or use
> >       the private field for that purpose.
> >    3. do not check magic number for page pool.
> >    4. more?
> 
> I'm not sure I understand Mina's concern about CPU cycles from casting.
> The casting is a compile-time thing, which shouldn't affect run-time

I didn't mention it but yes.

> performance as long as the check is kept as an inline function. So it's
> "just" a matter of exposing struct netmem_desc to mm.h so it can use it

Then.. we should expose net_iov as well, but I'm afraid it looks weird.
Do you think it's okay?

As I told in another thread, embedding strcut netmem_desc into struct
net_iov will require a huge single patch altering all the users of
struct net_iov.

	Byungchul

> in the inline definition. Unless I'm missing something?
> 
> -Toke


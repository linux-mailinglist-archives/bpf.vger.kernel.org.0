Return-Path: <bpf+bounces-59117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D097AC6119
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 07:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D402C3AB716
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC591FCF41;
	Wed, 28 May 2025 05:15:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2949BF9E8;
	Wed, 28 May 2025 05:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748409306; cv=none; b=jlQfXMsLckKzLBkAw/LA7kXKfOEqxVd1y90OwHmYH1bhlUEETFL1Gy/2Zh/GjQSSyqkEljoJb3g1iDi+tri2MGi3pmt9M1M+uNWfmCdMQ3W5UsFQ4rHrAHCYJFLSOph9Tew3YVCRb1ykR91QHgXwN5cAB0boXprRca6yp8Aqt9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748409306; c=relaxed/simple;
	bh=qg77Jn1t4n4pNDkgYzcnrL0En4dAcJZgYyt5l8GZ3uE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YrMcHUE/o1DfIjsZOn2XpUhxuxHSTo2pKiNKU1ARar0aEDUTaAg6M/PPgTZsSfEL8nJ0d3YWnQ8IRoWonfAxLFaGKMaPASDhKs6Z3DTbSXPkeW44VG3fn3USzwHON/KKQT93CPsONOw/S3R7pxUAqLf6U6CVkdy9NJPprx3F1pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-b5-68369bd1e143
Date: Wed, 28 May 2025 14:14:52 +0900
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
Message-ID: <20250528051452.GB59539@system.software.com>
References: <20250523032609.16334-1-byungchul@sk.com>
 <20250523032609.16334-13-byungchul@sk.com>
 <CAHS8izN6QAcAr-qkFSYAy0JaTU+hdM56r-ug-AWDGGqLvHkNuQ@mail.gmail.com>
 <20250526022307.GA27145@system.software.com>
 <20250526023624.GB27145@system.software.com>
 <87o6vfahoh.fsf@toke.dk>
 <20250526094305.GA29080@system.software.com>
 <87ldqjae92.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ldqjae92.fsf@toke.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRzGec85e3ccjU7L6k3p4iIKya5a/w9djL68EN3IoMuHGnlwq6k1
	0zRIZgrhULMb1Zwxu82WsZqlM0zWMtMMUlObVk7ULGgaaY2ZUnmUyG8Pv//D8zwf/jyrKpGF
	8bqkE6IhSaNXYwWnGJh2I6q5aK12pd27DiyOMgz3gulg63bJwGKvQPBj5L0chmtfYrhZEmDB
	8iaHg5+OXyx8quuRg+9OPwfVZytZ6DlXjyE/Z5SFM65SBpoqCmRw6ddtFiqN3XJ4+8SCoavs
	jwz6PfkcNJjvcuAriIU662wINPoR1DoqGQjkFWO42GLF0JvjQ9DyvIeDoqwCBI4arwxGgxYc
	G0Ef3e1gaJX5o5xanam0vDSSmrwtLHXaczF1Dl2Q0w/t1ZjWXx3laJVrmKH52YOYfv/UydFv
	NW2YOh61cfS1tVZOh53zdwr7FevjRb0uTTSs2HhIoe1sGOCOlUWkd1nfYyPqn2tCITwRokmN
	rQObED+hs9rjJMwJi8mVagsjaSwsIV7vCCtZQoXNpDGYYEIKnhWGZcQ+lM9KnpnCEZLX+RlL
	WikA6S10YsmkEvwMafTXyScPM0jDtT5O0ux46Nj1lolQVggntt/8JF5Ash8XTeCQ8Q3N7l0S
	niUsIu6Kl4wUSQQXTwLPupnJ+XPJs1IvV4hmmKc0mKc0mP83mKc0WBFnRypdUlqiRqePXq7N
	SNKlLz+cnOhE449z5/TYARcaatrtQQKP1NOU9EGMViXTpKVkJHoQ4Vl1qPLMprValTJek3FK
	NCQfNKTqxRQPCuc59Rzl6sDJeJWQoDkhHhXFY6Lh35XhQ8KMyPal/Hzcsr1x8vqR3K0x8yMv
	39vru22pZN58jFp4LtN4oC87199qVMX63b1X6J5r75buO+7e4Uu+PnC/0NXU4Ajed7+IKtkW
	n8Dnedd81Ze7S9r3tRXneX6+6szmZ221mTIfb6trHZreFx5R2GExbyg+v2XLdsPr+uDg03kP
	byVsH1NzKVrNqkjWkKL5C6HTqFw0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+c7l23G5OC2rU0aXRSRCWpHyllZWhB8RkRgUFeQpD245p21l
	WgnzEpE4u4I5ZyxETRMW07whEkvMZZQuMlNzprkK7Ool08icEvnfw/P8+PH+8XK0Motdxml0
	ZyS9TtSqsJyR7w/LXN9eEKreMJqxFiy2Cgz3x1OgtK+WBUt5NYKRX90yGG56gqHo7hgNlhdZ
	DIzaJmgYbO6XgbvEw0DD5Roa+q+2YDBlTdKQUXuPgseFThbaqnNZuDVRTEONsU8GL+stGHor
	pljwOEwMOM1lDLhzI6DZuhjGWocQNNlqKBjLKcRw02XFMJDlRuB63M9AQXouAltjJwuT4xYc
	oSJVZW8oUmd+KyNW+1lSeS+QZHe6aGIvv4KJ/ccNGenpaMCk5fYkQ+pqhyliyvyCyffBLoZ8
	bXyFSdHHbxSxVb1iyDNrk+zAgiPy8FhJq0mW9MHbY+TqLudnJqlidUqvtRsbkWdpNuI4gd8s
	pHcczEY+HMOvFfIaLJQ3Y36d0Nn5i/YifvxOoXU8LhvJOZofZoXyHybayyzkTwk5XR+wNyt4
	EAau2bEXUvJDlNA61CybHRYIzvz3jDfT09Lfd1wzUpr3F0r/cLP1SiHzYcFM7TN9Q/ujKG+9
	iF8jPKp+Ql1D881zROY5IvN/kXmOyIqYcuSn0SUniBptSJAhXp2q06QEnUxMsKPp3yhJ+329
	Fo28jHQgnkMqXwV5EKJWsmKyITXBgQSOVvkpMnaEqpWKWDH1vKRPPK4/q5UMDuTPMaolir2H
	pBglHyeekeIlKUnS/1spzmeZEe0pmZePRup357aJRcujexz7KrUBNe6n7Ie6SV37rhNRiREt
	DbFTdFiEafB1y3L8fs+mpAvBvc/d5475BrlCD+c8095dsWihylOsxHmN3+quhpxeJV40fnL+
	jNblh1OXjnJXfgaGWhJCPgaggsh35yq3TG1FaaNlbfrr23x9DxnvqBiDWtwYSOsN4l8K1Aqb
	FwMAAA==
X-CFilter-Loop: Reflected

On Mon, May 26, 2025 at 11:54:33AM +0200, Toke Høiland-Jørgensen wrote:
> Byungchul Park <byungchul@sk.com> writes:
> 
> > On Mon, May 26, 2025 at 10:40:30AM +0200, Toke Høiland-Jørgensen wrote:
> >> Byungchul Park <byungchul@sk.com> writes:
> >> 
> >> > On Mon, May 26, 2025 at 11:23:07AM +0900, Byungchul Park wrote:
> >> >> On Fri, May 23, 2025 at 10:21:17AM -0700, Mina Almasry wrote:
> >> >> > On Thu, May 22, 2025 at 8:26 PM Byungchul Park <byungchul@sk.com> wrote:
> >> >> > >
> >> >> > > To simplify struct page, the effort to seperate its own descriptor from
> >> >> > > struct page is required and the work for page pool is on going.
> >> >> > >
> >> >> > > To achieve that, all the code should avoid accessing page pool members
> >> >> > > of struct page directly, but use safe APIs for the purpose.
> >> >> > >
> >> >> > > Use netmem_is_pp() instead of directly accessing page->pp_magic in
> >> >> > > page_pool_page_is_pp().
> >> >> > >
> >> >> > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> >> >> > > ---
> >> >> > >  include/linux/mm.h   | 5 +----
> >> >> > >  net/core/page_pool.c | 5 +++++
> >> >> > >  2 files changed, 6 insertions(+), 4 deletions(-)
> >> >> > >
> >> >> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> >> >> > > index 8dc012e84033..3f7c80fb73ce 100644
> >> >> > > --- a/include/linux/mm.h
> >> >> > > +++ b/include/linux/mm.h
> >> >> > > @@ -4312,10 +4312,7 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
> >> >> > >  #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
> >> >> > >
> >> >> > >  #ifdef CONFIG_PAGE_POOL
> >> >> > > -static inline bool page_pool_page_is_pp(struct page *page)
> >> >> > > -{
> >> >> > > -       return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> >> >> > > -}
> >> >> > 
> >> >> > I vote for keeping this function as-is (do not convert it to netmem),
> >> >> > and instead modify it to access page->netmem_desc->pp_magic.
> >> >> 
> >> >> Once the page pool fields are removed from struct page, struct page will
> >> >> have neither struct netmem_desc nor the fields..
> >> >> 
> >> >> So it's unevitable to cast it to netmem_desc in order to refer to
> >> >> pp_magic.  Again, pp_magic is no longer associated to struct page.
> >> >
> >> > Options that come across my mind are:
> >> >
> >> >    1. use lru field of struct page instead, with appropriate comment but
> >> >       looks so ugly.
> >> >    2. instead of a full word for the magic, use a bit of flags or use
> >> >       the private field for that purpose.
> >> >    3. do not check magic number for page pool.
> >> >    4. more?
> >> 
> >> I'm not sure I understand Mina's concern about CPU cycles from casting.
> >> The casting is a compile-time thing, which shouldn't affect run-time
> >
> > I didn't mention it but yes.
> >
> >> performance as long as the check is kept as an inline function. So it's
> >> "just" a matter of exposing struct netmem_desc to mm.h so it can use it
> >
> > Then.. we should expose net_iov as well, but I'm afraid it looks weird.
> > Do you think it's okay?
> 
> Well, it'll be ugly, I grant you that :)
> 
> Hmm, so another idea could be to add the pp_magic field to the inner
> union that the lru field is in, and keep the page_pool_page_is_pp()
> as-is. Then add an assert for offsetof(struct page, pp_magic) ==
> offsetof(netmem_desc, pp_magic) on the netmem side, which can be removed
> once the two structs no longer shadow each other?
> 
> That way you can still get rid of the embedded page_pool struct in
> struct page, and the pp_magic field will just be a transition thing
> until things are completely separated...

Or what about to do that as mm folks did in page_is_pfmemalloc()?

static inline bool page_pool_page_is_pp(struct page *page)
{
	/*
	 * XXX: The space of page->lru.next is used as pp_magic in
	 * struct netmem_desc overlaying on struct page temporarily.
	 * This API will be unneeded shortly.  Let's use the ugly but
	 * temporal way to access pp_magic until struct netmem_desc has
	 * its own instance.
	 */
        return (((unsigned long)page->lru.next) & PP_MAGIC_MASK) == PP_SIGNATURE;
}

	Byungchul
> 
> -Toke


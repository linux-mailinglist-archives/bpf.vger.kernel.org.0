Return-Path: <bpf+bounces-59132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23418AC631E
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 09:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635483AB4B0
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 07:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37CA2459F7;
	Wed, 28 May 2025 07:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UH1m3jVC"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE8D24469A
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 07:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748417713; cv=none; b=GH4mgwwjt7WdgeOw4B3X+xqnEy+nJrzt3mdsUp2ppj90D0WU7qwtthGxigDOAq23vzFM53Cx5oH0h2vUqFJQeGxGwwSqfAvkxfTCYGvriu/qWuHrULlc4OGZ4HdjAM2drHi9yPMx9NgGWINsNqoPXKzKm8GcWeYHOaZJlGwD9SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748417713; c=relaxed/simple;
	bh=41l0i1YwK5vil3rIBOc/taM+bZvf9pzufhqTCafhYak=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RIDSZTTw7khfyM2B1gewarMOdC0LT0Vu5IjPeq90hTqcDtuBL+Mr4VFRfDjoPwbj6pfrtcHYgRz4R62P2s6Z83HXI3dwUVbZ7KGVvTPFBmDUwSV1ffNIAXUIz9IJnyxd057nz842I5KlRo5F9gKlENZK9eJXWzodCwBT0m/IUvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UH1m3jVC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748417710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hjtc3drrrmwK+A18ywqDKCDJFVmJvhPabCzpgN9quqU=;
	b=UH1m3jVC2sYWPUrYIIsxiqSCt1akQ4cfVYahkaGgflTNyUa7vRWyuzxqpkz/8BUE6atoj1
	SaJciZ8tyr5BvGvZCjNIuGYsDUBJiI0quogiiVhr/JJkw8OUrokbXjkVyKe+ApQPksHQCc
	hi65RPHSHaXTqlPASDHNO7Z7wxEZxI4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-yMBbajaVPxm-9bwiUgBA6g-1; Wed, 28 May 2025 03:35:06 -0400
X-MC-Unique: yMBbajaVPxm-9bwiUgBA6g-1
X-Mimecast-MFC-AGG-ID: yMBbajaVPxm-9bwiUgBA6g_1748417706
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ad52868da52so455817366b.2
        for <bpf@vger.kernel.org>; Wed, 28 May 2025 00:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748417705; x=1749022505;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjtc3drrrmwK+A18ywqDKCDJFVmJvhPabCzpgN9quqU=;
        b=n1nRUf4ymbiZu3EqyZrLLxK5HFQQ1xsNqkhyTMgVpjnVcb7loTIHTynPsflwj7jRsj
         OIaobfQEXKf0posNw3XA1ULNI9hGYK7mn+sn9pronLX4NLMVQPRJ+CY9kOexY8hDcMtk
         SdBEyVKYFtY59ZqtqLWWyNcXLEuP369Q0mB8GBmWV7yJhBG3Uiu2CYzDX+4+84j4ic2Y
         t/S6XhgS4Ibjye66T8ZJVzHuWks72ydyNpqzUVMByC282UxLwV8otHXVk46LfwwltQpa
         WSRpWwj4JvV2VEOJNfdEInFSrMDT5ohfLaJr0H7fKUiuU0by6lKcpqeSKrW1EmdJz/xY
         QUdw==
X-Forwarded-Encrypted: i=1; AJvYcCWgr4WlbuIo6Jr4bzR6jgmuxP+iDdqSf3tyd0BsFqeDkK4tof4HW6PP4sZRnJbpUIxp9wA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+U7VFwlPdBPDg+MM3pGjojA5v8Ooxes5iWqGYiEI+WX2GEKrb
	tn7M1JTDsG3HLNVazlrXtEREDW9eU9BZhwyuyyec0iHiI1CQjAS62wwH6CED+AaFXOGhQb3tLgZ
	drrcku1BJ4V3wBq7SJIJoaoL+Cs1hDmx6aef2O+9CB3paCi08VjlCfQ==
X-Gm-Gg: ASbGnctVLMmbwHyOM/zyhj0mk25BV0Orw+4NllLhJYrg6byLWBcFHkHCtGN2qmCjbxh
	E4uKz2sxGUVSroUc5dKyaR/LPEf2H3rGDo5TOgDqxWHWlRKqsHj91qeIZ4SJ2QO3eRKTH0Jsneu
	Kz5E4+A8dB3bjMOjUZZMmu1yixrkJkC3XfN79Do7H7WtEd7TJM4JzqEoCtoxRLRd+HgnSowcDYx
	jWpzOeaCdm5bPEZbC/1XeYEhqsyJGhU+QYZI/wn/hgENRnjoFt1/5f/WX4R8i0xj71r+dxJ0/0Q
	8MO+JmiDsQ62dSts0buZbt4Xn7JwCgkP/WC4
X-Received: by 2002:a17:907:72cb:b0:ad8:9909:20a3 with SMTP id a640c23a62f3a-ad8a1fcd782mr103806966b.43.1748417705392;
        Wed, 28 May 2025 00:35:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEga+XBDVDH9DawBJDd8Hl5ifnReBF7XNSAcatO9kDyc0ZPBxdlOaxJ/FBQIfPV1z0cx+rhA==
X-Received: by 2002:a17:907:72cb:b0:ad8:9909:20a3 with SMTP id a640c23a62f3a-ad8a1fcd782mr103801966b.43.1748417704872;
        Wed, 28 May 2025 00:35:04 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad8a1b482ffsm60794966b.146.2025.05.28.00.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 00:35:04 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 216321AA87CC; Wed, 28 May 2025 09:35:03 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Byungchul Park <byungchul@sk.com>
Cc: Mina Almasry <almasrymina@google.com>, willy@infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, ilias.apalodimas@linaro.org,
 harry.yoo@oracle.com, hawk@kernel.org, akpm@linux-foundation.org,
 davem@davemloft.net, john.fastabend@gmail.com, andrew+netdev@lunn.ch,
 asml.silence@gmail.com, tariqt@nvidia.com, edumazet@google.com,
 pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Subject: Re: [PATCH 12/18] page_pool: use netmem APIs to access
 page->pp_magic in page_pool_page_is_pp()
In-Reply-To: <20250528051452.GB59539@system.software.com>
References: <20250523032609.16334-1-byungchul@sk.com>
 <20250523032609.16334-13-byungchul@sk.com>
 <CAHS8izN6QAcAr-qkFSYAy0JaTU+hdM56r-ug-AWDGGqLvHkNuQ@mail.gmail.com>
 <20250526022307.GA27145@system.software.com>
 <20250526023624.GB27145@system.software.com> <87o6vfahoh.fsf@toke.dk>
 <20250526094305.GA29080@system.software.com> <87ldqjae92.fsf@toke.dk>
 <20250528051452.GB59539@system.software.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 28 May 2025 09:35:03 +0200
Message-ID: <87sekpmbmg.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> On Mon, May 26, 2025 at 11:54:33AM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Byungchul Park <byungchul@sk.com> writes:
>>=20
>> > On Mon, May 26, 2025 at 10:40:30AM +0200, Toke H=C3=B8iland-J=C3=B8rge=
nsen wrote:
>> >> Byungchul Park <byungchul@sk.com> writes:
>> >>=20
>> >> > On Mon, May 26, 2025 at 11:23:07AM +0900, Byungchul Park wrote:
>> >> >> On Fri, May 23, 2025 at 10:21:17AM -0700, Mina Almasry wrote:
>> >> >> > On Thu, May 22, 2025 at 8:26=E2=80=AFPM Byungchul Park <byungchu=
l@sk.com> wrote:
>> >> >> > >
>> >> >> > > To simplify struct page, the effort to seperate its own descri=
ptor from
>> >> >> > > struct page is required and the work for page pool is on going.
>> >> >> > >
>> >> >> > > To achieve that, all the code should avoid accessing page pool=
 members
>> >> >> > > of struct page directly, but use safe APIs for the purpose.
>> >> >> > >
>> >> >> > > Use netmem_is_pp() instead of directly accessing page->pp_magi=
c in
>> >> >> > > page_pool_page_is_pp().
>> >> >> > >
>> >> >> > > Signed-off-by: Byungchul Park <byungchul@sk.com>
>> >> >> > > ---
>> >> >> > >  include/linux/mm.h   | 5 +----
>> >> >> > >  net/core/page_pool.c | 5 +++++
>> >> >> > >  2 files changed, 6 insertions(+), 4 deletions(-)
>> >> >> > >
>> >> >> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
>> >> >> > > index 8dc012e84033..3f7c80fb73ce 100644
>> >> >> > > --- a/include/linux/mm.h
>> >> >> > > +++ b/include/linux/mm.h
>> >> >> > > @@ -4312,10 +4312,7 @@ int arch_lock_shadow_stack_status(struc=
t task_struct *t, unsigned long status);
>> >> >> > >  #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
>> >> >> > >
>> >> >> > >  #ifdef CONFIG_PAGE_POOL
>> >> >> > > -static inline bool page_pool_page_is_pp(struct page *page)
>> >> >> > > -{
>> >> >> > > -       return (page->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGN=
ATURE;
>> >> >> > > -}
>> >> >> >=20
>> >> >> > I vote for keeping this function as-is (do not convert it to net=
mem),
>> >> >> > and instead modify it to access page->netmem_desc->pp_magic.
>> >> >>=20
>> >> >> Once the page pool fields are removed from struct page, struct pag=
e will
>> >> >> have neither struct netmem_desc nor the fields..
>> >> >>=20
>> >> >> So it's unevitable to cast it to netmem_desc in order to refer to
>> >> >> pp_magic.  Again, pp_magic is no longer associated to struct page.
>> >> >
>> >> > Options that come across my mind are:
>> >> >
>> >> >    1. use lru field of struct page instead, with appropriate commen=
t but
>> >> >       looks so ugly.
>> >> >    2. instead of a full word for the magic, use a bit of flags or u=
se
>> >> >       the private field for that purpose.
>> >> >    3. do not check magic number for page pool.
>> >> >    4. more?
>> >>=20
>> >> I'm not sure I understand Mina's concern about CPU cycles from castin=
g.
>> >> The casting is a compile-time thing, which shouldn't affect run-time
>> >
>> > I didn't mention it but yes.
>> >
>> >> performance as long as the check is kept as an inline function. So it=
's
>> >> "just" a matter of exposing struct netmem_desc to mm.h so it can use =
it
>> >
>> > Then.. we should expose net_iov as well, but I'm afraid it looks weird.
>> > Do you think it's okay?
>>=20
>> Well, it'll be ugly, I grant you that :)
>>=20
>> Hmm, so another idea could be to add the pp_magic field to the inner
>> union that the lru field is in, and keep the page_pool_page_is_pp()
>> as-is. Then add an assert for offsetof(struct page, pp_magic) =3D=3D
>> offsetof(netmem_desc, pp_magic) on the netmem side, which can be removed
>> once the two structs no longer shadow each other?
>>=20
>> That way you can still get rid of the embedded page_pool struct in
>> struct page, and the pp_magic field will just be a transition thing
>> until things are completely separated...
>
> Or what about to do that as mm folks did in page_is_pfmemalloc()?
>
> static inline bool page_pool_page_is_pp(struct page *page)
> {
> 	/*
> 	 * XXX: The space of page->lru.next is used as pp_magic in
> 	 * struct netmem_desc overlaying on struct page temporarily.
> 	 * This API will be unneeded shortly.  Let's use the ugly but
> 	 * temporal way to access pp_magic until struct netmem_desc has
> 	 * its own instance.
> 	 */
>         return (((unsigned long)page->lru.next) & PP_MAGIC_MASK) =3D=3D P=
P_SIGNATURE;
> }

Sure, that can work as a temporary solution (maybe with a static assert
somewhere that pp_magic and lru have the same offsetof())?

-Toke



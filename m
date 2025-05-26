Return-Path: <bpf+bounces-58928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E50AAC3BCF
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 10:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00E6516F976
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 08:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AD91E834B;
	Mon, 26 May 2025 08:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJIekX7+"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E101DFDBB
	for <bpf@vger.kernel.org>; Mon, 26 May 2025 08:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748248839; cv=none; b=pUWcgJdapdG5+XFjnEFissjFgiOQXsFd8V/7Q2YnwS/SNqoB9Hky+teVyB3dL7Pd9bHb6/+/Uidkr2s/qjurxpx0iidR/IuEwE+YW+3+yCBGOUkpmyGtpfBkecqaCpOvurn17eOYZ2BfgGqNnrCFb5/Z5PMthB9UJyHkn1j1Jaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748248839; c=relaxed/simple;
	bh=rwTtRZWCBpccCiljfC4gt2cz8aSV2o9lUsihGbkmj+0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JDN/LdMyid1fyogLXDX4AQlYKrIJfZRZtbq7RI8LAEvTru4c1MXJg2p5ENrhmzELDiiswo3PekX9O+BbcfMo8OxFADzFnEKSXiUcEpfoYrLngBNZWTT5m/ouEpmQSK4yD75zdiUVLx0rwKjzXkcYfpHFzyW3/XG6WUFRL9aIs8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MJIekX7+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748248836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BORtL2zM0qRE1V/C8MwfA7aWdB6U+L7cFknUtojSlEg=;
	b=MJIekX7+yO2FcjZyDUp26CT2QQHSIm6NFdHHAldpJig93dfoMggC27QQ7/E8F5WuB2mAbJ
	pwievfUwnGqE58pioukXLQwq3mASCW6eTwaM0Cb2RdQ/fhvYLiXGGlWyXTGei7PO5UemMo
	MOnDcDU1F6j7ohGJdM5hcfJG4KRuKgU=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-cvlD0E5PM0q_fNQbfGWTpA-1; Mon, 26 May 2025 04:40:34 -0400
X-MC-Unique: cvlD0E5PM0q_fNQbfGWTpA-1
X-Mimecast-MFC-AGG-ID: cvlD0E5PM0q_fNQbfGWTpA_1748248833
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-30d6a0309f6so5247881fa.2
        for <bpf@vger.kernel.org>; Mon, 26 May 2025 01:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748248833; x=1748853633;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BORtL2zM0qRE1V/C8MwfA7aWdB6U+L7cFknUtojSlEg=;
        b=qYmVMhL92eIQi16/yBxQ98yryM4Ic56ZYUt/POMsR6Xys0sWfDvYQ2WyAQSh8ybd9n
         v3EEQTtdrR2Ihpbz+ZW++8X9SrTgWLW3gHMwYVWYUDXajqoUJ2QqJqROINU89xpb00qc
         B0M0aYshHuRvCedXGBst41HYmM4MY9tdASiwqL5YkD9ZlFzvEwAtCYCN8EixALm3JS7K
         HyuUJb1ct2L9nlPfR2ObfD6yQMHq67wwihevkxkkOdewOVUfiFCQn2+Ar/pg19wEsWqC
         cwerLQEKmBp9TewzQzsgH3/OY3lmMbX63BhK244tYJM66N1uBDNb16Rhy3EAlp+MLCue
         6YnA==
X-Forwarded-Encrypted: i=1; AJvYcCW4vYnLN8d+qjXYxPb1q+0SgKrj01awx3YgzICWbzcOsSLngU0NOFJZvJBf9ohZ5YNwuuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTXwZ4vjWiJOudLXprXDrWaQqvhU7e7gZcLxW4sjE6YFGAx3NK
	QlPKHBuXiVfz4n5QohjmvSjmKd/DSaHY+m/ld/PuhP8nzIPvIJUxuYxWH+LYEXTkAF+u172K3or
	XC1P3hfDKmBHEYCauEojb4DCtwybXImQR7YXm/sQ3uhxZkyHWHfvFzQ==
X-Gm-Gg: ASbGncsDCeEa+vSj7Zi3J791MhL2lopZ55WtAVhdkur3++TsZi7kCjoiGdLa4eiljLL
	vgpS8PS60VUguAXjOD4eXFZTXW9FuRbIx5miGd4gt/OpV04BRUWcZUVA3jSfHZvzfXDQR0AVyGq
	VR6UbFrEnPg9iCJ+IMd1xJ2HertlaukVC/mz4UiKasyhw4bIvNY7QeKckix9239XHK+EQ31wdT7
	MrQsKiNbQPReX9SvSVtypltg7MkJX14dJe8LXaPaPGMn+EVYKjzaQtw5kAW2DbePcJOZflrksyr
	PNrB+3iY
X-Received: by 2002:a05:6512:1054:b0:549:7354:e4d1 with SMTP id 2adb3069b0e04-5521cba97e8mr2217294e87.38.1748248832932;
        Mon, 26 May 2025 01:40:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSksxY/4SDl8nPx9ETpT8GNSo1fb9YNjKF6Ytk8769B3WbBYxWl3jw2VybR5HjV+gllf9dmg==
X-Received: by 2002:a05:6512:1054:b0:549:7354:e4d1 with SMTP id 2adb3069b0e04-5521cba97e8mr2217267e87.38.1748248831957;
        Mon, 26 May 2025 01:40:31 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e6f161c7sm5044691e87.24.2025.05.26.01.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 01:40:31 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 5CC4B1AA3EEA; Mon, 26 May 2025 10:40:30 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Byungchul Park <byungchul@sk.com>, Mina Almasry <almasrymina@google.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com,
 kuba@kernel.org, ilias.apalodimas@linaro.org, harry.yoo@oracle.com,
 hawk@kernel.org, akpm@linux-foundation.org, davem@davemloft.net,
 john.fastabend@gmail.com, andrew+netdev@lunn.ch, asml.silence@gmail.com,
 tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 horms@kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 vishal.moola@gmail.com
Subject: Re: [PATCH 12/18] page_pool: use netmem APIs to access
 page->pp_magic in page_pool_page_is_pp()
In-Reply-To: <20250526023624.GB27145@system.software.com>
References: <20250523032609.16334-1-byungchul@sk.com>
 <20250523032609.16334-13-byungchul@sk.com>
 <CAHS8izN6QAcAr-qkFSYAy0JaTU+hdM56r-ug-AWDGGqLvHkNuQ@mail.gmail.com>
 <20250526022307.GA27145@system.software.com>
 <20250526023624.GB27145@system.software.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 26 May 2025 10:40:30 +0200
Message-ID: <87o6vfahoh.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> On Mon, May 26, 2025 at 11:23:07AM +0900, Byungchul Park wrote:
>> On Fri, May 23, 2025 at 10:21:17AM -0700, Mina Almasry wrote:
>> > On Thu, May 22, 2025 at 8:26=E2=80=AFPM Byungchul Park <byungchul@sk.c=
om> wrote:
>> > >
>> > > To simplify struct page, the effort to seperate its own descriptor f=
rom
>> > > struct page is required and the work for page pool is on going.
>> > >
>> > > To achieve that, all the code should avoid accessing page pool membe=
rs
>> > > of struct page directly, but use safe APIs for the purpose.
>> > >
>> > > Use netmem_is_pp() instead of directly accessing page->pp_magic in
>> > > page_pool_page_is_pp().
>> > >
>> > > Signed-off-by: Byungchul Park <byungchul@sk.com>
>> > > ---
>> > >  include/linux/mm.h   | 5 +----
>> > >  net/core/page_pool.c | 5 +++++
>> > >  2 files changed, 6 insertions(+), 4 deletions(-)
>> > >
>> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
>> > > index 8dc012e84033..3f7c80fb73ce 100644
>> > > --- a/include/linux/mm.h
>> > > +++ b/include/linux/mm.h
>> > > @@ -4312,10 +4312,7 @@ int arch_lock_shadow_stack_status(struct task=
_struct *t, unsigned long status);
>> > >  #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
>> > >
>> > >  #ifdef CONFIG_PAGE_POOL
>> > > -static inline bool page_pool_page_is_pp(struct page *page)
>> > > -{
>> > > -       return (page->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
>> > > -}
>> >=20
>> > I vote for keeping this function as-is (do not convert it to netmem),
>> > and instead modify it to access page->netmem_desc->pp_magic.
>>=20
>> Once the page pool fields are removed from struct page, struct page will
>> have neither struct netmem_desc nor the fields..
>>=20
>> So it's unevitable to cast it to netmem_desc in order to refer to
>> pp_magic.  Again, pp_magic is no longer associated to struct page.
>
> Options that come across my mind are:
>
>    1. use lru field of struct page instead, with appropriate comment but
>       looks so ugly.
>    2. instead of a full word for the magic, use a bit of flags or use
>       the private field for that purpose.
>    3. do not check magic number for page pool.
>    4. more?

I'm not sure I understand Mina's concern about CPU cycles from casting.
The casting is a compile-time thing, which shouldn't affect run-time
performance as long as the check is kept as an inline function. So it's
"just" a matter of exposing struct netmem_desc to mm.h so it can use it
in the inline definition. Unless I'm missing something?

-Toke



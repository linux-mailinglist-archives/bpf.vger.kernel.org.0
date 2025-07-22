Return-Path: <bpf+bounces-64043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F005AB0D96A
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 14:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493331C8122A
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 12:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B5F2ECD3F;
	Tue, 22 Jul 2025 12:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsIIubAU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9BF2EBDFC
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 12:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753186621; cv=none; b=fKYGg5rdB9YEgbqh0L7v4PKQw+pkGFmbLmTl4UgABg2NvSYRnmfSVm+f85rDkm7jNZmmLRJurCjwPBrJGnWFUuInEzCij906CxFFPv8GwuYP2aGIzwSaY8nafcZuwUME14lRlsvj+c28zEfcklOAGcyWz/3HvVurbpffUTPb5zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753186621; c=relaxed/simple;
	bh=1+hfXiK3bFD0KCZfea5VOfPQwSaJGBGiuAGZGWs2KoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+D/sx3GBaUKY5uw8Vb6X8hqc388aAfFUMlAfhN9ZyRTlbGYgsRAg2g2XuGTQUF3jZfGJgqFbWbRrqBhSSEycebJy3+6t1wNThXvxdPN8+Ee1CXBN06UNNdi1PCErA/ng2pyVCCHed3wBBC+hPrhGKQ1733NPK8gW7dvE3Fg8cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsIIubAU; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6fadd3ad18eso52560776d6.2
        for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 05:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753186618; x=1753791418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2dh4GvcIefc0hFeVr2+yL7P2gWg4zPcsSe2xE6W3bs=;
        b=YsIIubAU7LtC/1LEsebev92hl7TnLVpufS/EUUbVJmQXNXLfi5aU5oucTAdeFFB2rk
         q/Qb9JCTo+2Xrg4WlGSDersdxQRtsnJMZobOY21F6DcUrxfE6FdHv8gh4PUW96G8wDrO
         CGvdzEfUUFtLEHspKV5+ESe+RGiHSXc4in80hveCEwev9OHKVDwvl4BfFhizI4viLQ0K
         91xbEK/H9z2Fm7Sn0rZXhAe5l6Mx5YXOvlyV+uUZrNP9K0myO2U5jPAyVIkRYJMGH5Yx
         sGtJfgFc0YENWn4L96q8hbmrXAJJFn8oHMGAftP5QGQxRTggDp91/8ktW8d71h0m7XiQ
         ucFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753186618; x=1753791418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d2dh4GvcIefc0hFeVr2+yL7P2gWg4zPcsSe2xE6W3bs=;
        b=MeH8hPxf+uvFYSLEqvUWCdXPFldkeGYsoDJ00V7bXfBr8FeAqmXc+RQ5BQC/1eNVn5
         ZPLy81k+Wu/O8cILtiUG5zaSAJVKEutEFF3Tq/QE+MEVRGlNdaCK/w5d5RquEMiIj4Gb
         IgvU6eftVRKxhRh+fnTI/TXHS3sAIff1fNgunZd515VgIgcFu5e0f5DF5UVXqUMuBGhB
         Ncc4epPQEcQVtoiKA7tvfy9QhyX3P/7O/eUqzk5HYImmJGmwXje0TcNDlhHYHbAk6BfN
         CnK2vz4e0SZXv/i2XOHkesLsfDM4yRK5ISXWt3ssZaU2BfstRO0gA9A4B72XHYymbleB
         i40g==
X-Forwarded-Encrypted: i=1; AJvYcCX6Zg31SRWDU/uqzsYxXD/hCnHWNdkt2LLRy8IhzB024F7QuO/2OqPhGophh9XwyR19qac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcb4aTflpFcW5+P7P9lHNf7Yp2GMBQiReWoZ47S6lVtAdof4Iz
	HJXW7dyU4DDYxntlHyDnVr7u0uaZbF7W90LRCLniStZbWZpa0vVoI09sXnaoXO1lCtgzSIVe7ZA
	IvB80CAVmTTYlZwAfyRVRMMRoPOFH9ck=
X-Gm-Gg: ASbGnct1UN6Nt4quQmrgmX0RoINunuuHM+mXwQsFfZQtKlJkYAetDhMyVFktx2VUzFp
	pF36YEGuVUjG03SmFmEujPgNCNauNDInS9kbdf6Rr5qecqJQg9UnPAym+Eo6C9JwMfwrjLfiUA8
	Q3dYlC0e0fS3qWVR/6C+KMk7wLrJiiLXfKyr7KDSZc6utgHqQJjsH6A1f2TmoMFM1OEU5Gs++5t
	AsvdQix
X-Google-Smtp-Source: AGHT+IHobXtgKhcXxKs5zE1UVYtEi4Qw+CLzI/vVtT8yLXo7N7RF6680jlqb/8T5JSOGZWQ0LwDWzc6hojOUMno0Hh4=
X-Received: by 2002:a05:6214:dc7:b0:6f8:a978:d46 with SMTP id
 6a1803df08f44-7050722961cmr354570346d6.19.1753186618099; Tue, 22 Jul 2025
 05:16:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608073516.22415-1-laoar.shao@gmail.com> <b2fc85fb-1c7b-40ab-922b-9351114aa994@redhat.com>
 <CALOAHbD2-f5CRXJy6wpXuCC5P9gqqsbVbjBzgAF4e+PqWv0xNg@mail.gmail.com>
 <9bc57721-5287-416c-aa30-46932d605f63@redhat.com> <CALOAHbBoZpAartkb-HEwxJZ90Zgn+u6G4fCC0_Wq-shKqnb6iQ@mail.gmail.com>
 <87a54cdb-1e13-4f6f-9603-14fb1210ae8a@redhat.com> <CALOAHbA5NUHXPs+DbQWaKUfMeMWY3SLCxHWK_dda9K1Orqi=WA@mail.gmail.com>
 <404de270-6d00-4bb7-b84b-ae3b1be1dba8@redhat.com> <694a8b10-6082-44ac-8239-2c28b4ba8640@lucifer.local>
 <CALOAHbBepZiORN2yLvDDQWbvom38HHvCyqAqvS7uKzQqy8zgjg@mail.gmail.com> <dda67ea5-2943-497c-a8e5-d81f0733047d@lucifer.local>
In-Reply-To: <dda67ea5-2943-497c-a8e5-d81f0733047d@lucifer.local>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 22 Jul 2025 20:16:20 +0800
X-Gm-Features: Ac12FXyMzY-ryTl9mU_SERXrlYB3V2uAa7Zc3M0QA5uuO-MZVuqrYonrF1COTzI
Message-ID: <CALOAHbDxjQrk4qjd4PouxfS=ZpR=HtL6Su53vsxvJWHckKoM_g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/5] mm, bpf: BPF based THP adjustment
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 8:05=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Tue, Jul 22, 2025 at 07:56:21PM +0800, Yafang Shao wrote:
> > On Tue, Jul 22, 2025 at 6:09=E2=80=AFPM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > On Tue, Jul 22, 2025 at 09:28:02AM +0200, David Hildenbrand wrote:
> > > > On 22.07.25 04:40, Yafang Shao wrote:
> > > > > On Sun, Jul 20, 2025 at 11:56=E2=80=AFPM David Hildenbrand <david=
@redhat.com> wrote:
> > > > > >
> > > > > > > >
> > > > > > > > We discussed this yesterday at a THP upstream meeting, and =
what we
> > > > > > > > should look into is:
> > > > > > > >
> > > > > > > > (1) Having a callback like
> > > > > > > >
> > > > > > > > unsigned int (*get_suggested_order)(.., bool in_pagefault);
> > > > > > >
> > > > > > > This interface meets our needs precisely, enabling allocation=
 orders
> > > > > > > of either 0 or 9 as required by our workloads.
> > >
> > > That's great to hear, and to be clear my views align with David on th=
is - I
> > > feel like having a _carefully chosen_ BPF interface could be valuable=
 here,
> > > especially in the short to medium term where it will allow us to more
> > > rapidly iterate on an automated [m]THP mechanism.
> > >
> > > I think one key question here is - do we want to retain a _permanent_=
 BPF
> > > hook here?
> > >
> > > In any cae, for the first experiments with this we absolutely _must_ =
be
> > > able to express that this is going away, NO, not based on whether it'=
s
> > > widely used, it IS going away.
> >
> > If this BPF kfunc provides clear user value with minimal maintenance
> > overhead, what would be the rationale for removing it? That said, if
> > you and David both agree it should be deprecated, I won't object -
> > though I'd suggest following the standard deprecation process.
>
> You see herein lies the problem... :) from my point of view we want to ha=
ve
> the ability to choose, fundamentally.
>
> We may find out the proposed interface is unworkable, or sets assumptions
> we don't want to make.
>
> So I think hiding ehhind a CONFIG_ flag is the best idea here to really
> enforce that and make it clear.
>
> Personally I have a sense that we _will_ introduce something permanent. W=
e
> just need to have the 'space' to positively decide to do that once the
> experimentation is complete.

Thanks for your explanation.

>
> > > I find this documentation super contradictory. I'm sorry but you can'=
t
> > > have:
> > >
> > > "...can therefore be modified or removed by a maintainer of the subsy=
stem
> > >  they=E2=80=99re defined in when it=E2=80=99s deemed necessary."
> > >
> > > And:
> > >
> > > "kfuncs that are widely used or have been in the kernel for a long ti=
me
> > > will be more difficult to justify being changed or removed by a
> > > maintainer."
> > >
> > > At the same time. Let alone:
> > >
> > > "A kfunc will never have any hard stability guarantees. BPF APIs cann=
ot and
> > > will not ever hard-block a change in the kernel purely for stability
> > > reasons"
> > >
> > > Make your mind up!!
> > >
> > > I mean the EXPORT_SYMBOL_GPL() example isn't accurate AT ALL - we can
> > > _absolutely_ change or remove those _at will_ as we don't care about
> > > external modules.
> > >
> > > Really this seems to be saying, in not so many words, that this is
> > > basically a kAPI and you can't change it.
> > >
> > > So this strictly violates what we need here.
> >
> > The maintainers have the authority to make the final determination ;-)
>
> Well the kernel doesn't entirely work this way... pressure can come which
> impacts what others may do.
>
> If you have people saying 'hey we rely on this and removing it will break
> our cloud deployment' and 'hey I checked the docs and it says you guys ha=
ve
> to take this into account', I am not so sure Andrew or Linus will accept
> the patch.

understood.

>
> > > I wonder if we can use a CONFIG_xxx and put this behind that, which
> > > specifically says 'WE WILL REMOVE THIS'
> > > CONFIG_EXPERIMENTAL_DO_NOT_USE_THP_THINGY :P
> >
> > That's a reasonable suggestion. We could implement this function under
> > CONFIG_EXPERIMENTAL to mark it as experimental infrastructure.
>
> Thanks! Yes, I was looking for this flag :P didn't know if we still had
> that or not actually...
>
> But, yeah, putting it behind that explicitly also makes it very clearly.
>
> CONFIG_EXPERIMENTAL_BPF_FAULT_ORDER relies on CONFIG_EXPERIMENTAL makes i=
t
> you know... pretty clear ;)

Agreed. Let's move forward with the CONFIG_EXPERIMENTAL_BPF_FAULT_ORDER opt=
ion.

--=20
Regards
Yafang


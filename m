Return-Path: <bpf+bounces-68264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD92B55805
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 23:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3801F7C66D2
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 21:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13FC28489B;
	Fri, 12 Sep 2025 21:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MMIvcHCh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0412AC17
	for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757710999; cv=none; b=ZlCQHMgsujzVPJVsUiaYb/SjioyI9JX+Jg9/qZnoruH4t2iYcr3CWmgTf1Z4KQ7ft+jz+ou2PIhDzKuRaR+LeGkBjPwRCB/0lH7116VLlwfE62Aauqd9NiXa+AnNtdTRIGFurx7dkwyIgRqij8I0CDwFTl7HR/ut+J9JEPFS6JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757710999; c=relaxed/simple;
	bh=8IVrJasJUbROdeu1YP3DMofoy+EUozqHN/Nt03ongJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SephrVJSGAK1qpH4OKE4gYqbjDcpKPb0Uo0o4SIOJExNoyUYVvc2bVkgtoAqEM+VXBMYKlYKt7mFPmifmdWboaXdOLWR4AzOPJLRssAT7nrtiNOKIiGC8n4o3ZANT9b0rp0ajcdVRiNgrSQu7zw6qhZVC6Pse3WJYAVWSU8wgWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MMIvcHCh; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b78657a35aso34541cf.0
        for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 14:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757710995; x=1758315795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVJ20harXnfzHnDKK1hOVgN5G5NhgZps321C9eNzyC8=;
        b=MMIvcHChnkTY5NZVHIIo82z8vHgZX1tRCp12OyNvYC1QwxCCb7g77dwZDFTc4YMSPZ
         tX+fTKiZxWEqmsLnQP1FOvApsDYc/1txyMSqtBkpzx9OOP2ZK6GL3nwdHy1fSgPEQJBj
         Q+EdKlhIRYF6QQieiMT3u7Oe+2cxDhMgbmyMAzkDoJCkIdR7mtY1VmckJsdzBI3Pf34S
         QdSzPy3yUDep+VZo1IZUtLSZyjXntVaLYjf4njWLc6bPaMUPpQ7x/FKx8tWPaqhf89bY
         lylQ0+v80ZPVo1oGVmTeTTDuN+MHt+alLn8E7zgDv6s7psaoYagfN4mqiP6R1uZ/5dCm
         ySbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757710995; x=1758315795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tVJ20harXnfzHnDKK1hOVgN5G5NhgZps321C9eNzyC8=;
        b=ph6dDqgtPeZW3FLV/8NJdKeh2QC0eMt+hotUTbjqxqGLP/bW32kSlDgSA0QS1RUtRk
         +mxZKOJVcx3tRaqUB2mLTDuEMacIcB4TBhQSL8bhUsQ9Jjf2QqPsKDd0rdTIwwdU6okB
         pshyMz5UcyIWuWLrWpkiSF5CRi/zy8E+575lW7PTFhl5JCU2dPwRfjv9TPKmK/nuWEZ6
         Xygc++KugJU9SjKm0WadaeAw/XnUKYeixxg17HSzGslXU3q8nf0KYZ+aS3WSYAZIpeuU
         hfDIb+3gw3qFl+W7mNzX0xkUbGUbeV5ODaaSypFJtfya6Oqh9hJf1iG0mz7liAJTe2ni
         wzWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKX7rjW+jXhgStKpodN95FS/a5oc89f/btxESLNtDJeLSoEOgyLKhTg1Kr5eQmxBxkADc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Dx4lA+wuZWHuaQGY3+9CwpHMJV13axC6sHMkQmmkPYh7Ut0Q
	KUCD9WN4wxaL1yF6xsY3gsfL4cJY1rWePqCZIiYTHjLfTgF2X53tQQjiR+spTLqHXCW51TXXasF
	trVo73BFB4lJr4/2M2Q8u4XLAESvc52LMHFrzuQHi
X-Gm-Gg: ASbGnctfqIjuBfk1wbKYDYZQCxR94I0u+LexV0cdp4KclyybHy0lXL7tqXMJ+vSU22T
	Jr1dCuHd+o6i7xQzIrSBkYFcRp9/xCKNX7mRWJXzGTnqyhJSUsvtwYvX1uA29rQV3+P7q7YjC9j
	03+NTmAdOLB1FOiSlJ5DeV8LDC95KlFCeiXjKCrHcLow5Rf+EHssxhv/ygkermGr+Lvc7tcQHFu
	2uF1beidiXbpa5dkCLjyqtiPE1NQ9BmJw==
X-Google-Smtp-Source: AGHT+IHseG9PtEuPE49/9tbUbIRhif36dOcTKh3RESUYQ0Xj0YcJ9huxjsg7Lumt1ghFNmsQrsmKynduT/0KDy32sIQ=
X-Received: by 2002:a05:622a:1a08:b0:4b3:19b2:d22 with SMTP id
 d75a77b69052e-4b78baee828mr1134171cf.13.1757710994465; Fri, 12 Sep 2025
 14:03:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909010007.1660-1-alexei.starovoitov@gmail.com>
 <20250909010007.1660-6-alexei.starovoitov@gmail.com> <jftidhymri2af5u3xtcqry3cfu6aqzte3uzlznhlaylgrdztsi@5vpjnzpsemf5>
In-Reply-To: <jftidhymri2af5u3xtcqry3cfu6aqzte3uzlznhlaylgrdztsi@5vpjnzpsemf5>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 12 Sep 2025 14:03:03 -0700
X-Gm-Features: AS18NWBlwC6GnqxcNf8gN0VWwblEoVKW3TIWvmUUYGCzInpHnPoKF5oCvFK5EWQ
Message-ID: <CAJuCfpGUjaZcs1r9ADKck_Ni7f41kHaiejR01Z0bE8pG0K1uXA@mail.gmail.com>
Subject: Re: [PATCH slab v5 5/6] slab: Reuse first bit for OBJEXTS_ALLOC_FAIL
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	vbabka@suse.cz, harry.yoo@oracle.com, mhocko@suse.com, bigeasy@linutronix.de, 
	andrii@kernel.org, memxor@gmail.com, akpm@linux-foundation.org, 
	peterz@infradead.org, rostedt@goodmis.org, hannes@cmpxchg.org, 
	roman.gushchin@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 12:27=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> +Suren, Roman
>
> On Mon, Sep 08, 2025 at 06:00:06PM -0700, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Since the combination of valid upper bits in slab->obj_exts with
> > OBJEXTS_ALLOC_FAIL bit can never happen,
> > use OBJEXTS_ALLOC_FAIL =3D=3D (1ull << 0) as a magic sentinel
> > instead of (1ull << 2) to free up bit 2.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>
> Are we low on bits that we need to do this or is this good to have
> optimization but not required?

That's a good question. After this change MEMCG_DATA_OBJEXTS and
OBJEXTS_ALLOC_FAIL will have the same value and they are used with the
same field (page->memcg_data and slab->obj_exts are aliases). Even if
page_memcg_data_flags can never be used for slab pages I think
overlapping these bits is not a good idea and creates additional
risks. Unless there is a good reason to do this I would advise against
it.

>
> I do have some questions on the state of slab->obj_exts even before this
> patch for Suren, Roman, Vlastimil and others:
>
> Suppose we newly allocate struct slab for a SLAB_ACCOUNT cache and tried
> to allocate obj_exts for it which failed. The kernel will set
> OBJEXTS_ALLOC_FAIL in slab->obj_exts (Note that this can only be set for
> new slab allocation and only for SLAB_ACCOUNT caches i.e. vec allocation
> failure for memory profiling does not set this flag).
>
> Now in the post alloc hook, either through memory profiling or through
> memcg charging, we will try again to allocate the vec and before that we
> will call slab_obj_exts() on the slab which has:
>
>         unsigned long obj_exts =3D READ_ONCE(slab->obj_exts);
>
>         VM_BUG_ON_PAGE(obj_exts && !(obj_exts & MEMCG_DATA_OBJEXTS), slab=
_page(slab));
>
> It seems like the above VM_BUG_ON_PAGE() will trigger because obj_exts
> will have OBJEXTS_ALLOC_FAIL but it should not, right? Or am I missing
> something? After the following patch we will aliasing be MEMCG_DATA_OBJEX=
TS
> and OBJEXTS_ALLOC_FAIL and will avoid this trigger though which also
> seems unintended.

You are correct. Current VM_BUG_ON_PAGE() will trigger if
OBJEXTS_ALLOC_FAIL is set and that is wrong. When
alloc_slab_obj_exts() fails to allocate the vector it does
mark_failed_objexts_alloc() and exits without setting
MEMCG_DATA_OBJEXTS (which it would have done if the allocation
succeeded). So, any further calls to slab_obj_exts() will generate a
warning because MEMCG_DATA_OBJEXTS is not set. I believe the proper
fix would not be to set MEMCG_DATA_OBJEXTS along with
OBJEXTS_ALLOC_FAIL because the pointer does not point to a valid
vector but to modify the warning to:

VM_BUG_ON_PAGE(obj_exts && !(obj_exts & (MEMCG_DATA_OBJEXTS |
OBJEXTS_ALLOC_FAIL)), slab_page(slab));

IOW, we expect the obj_ext to be either NULL or have either
MEMCG_DATA_OBJEXTS or OBJEXTS_ALLOC_FAIL set.
>
> Next question: OBJEXTS_ALLOC_FAIL is for memory profiling and we never
> set it when memcg is disabled and memory profiling is enabled or even
> with both memcg and memory profiling are enabled but cache does not have
> SLAB_ACCOUNT. This seems unintentional as well, right?

I'm not sure why you think OBJEXTS_ALLOC_FAIL is not set by memory
profiling (independent of CONFIG_MEMCG state).
__alloc_tagging_slab_alloc_hook()->prepare_slab_obj_exts_hook()->alloc_slab=
_obj_exts()
will attempt to allocate the vector and set OBJEXTS_ALLOC_FAIL if that
fails.

>
> Also I think slab_obj_exts() needs to handle OBJEXTS_ALLOC_FAIL explicitl=
y.

Agree, so is my proposal to update the warning sounds right to you?

>
>
> > ---
> >  include/linux/memcontrol.h | 10 ++++++++--
> >  mm/slub.c                  |  2 +-
> >  2 files changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 785173aa0739..d254c0b96d0d 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -341,17 +341,23 @@ enum page_memcg_data_flags {
> >       __NR_MEMCG_DATA_FLAGS  =3D (1UL << 2),
> >  };
> >
> > +#define __OBJEXTS_ALLOC_FAIL MEMCG_DATA_OBJEXTS
> >  #define __FIRST_OBJEXT_FLAG  __NR_MEMCG_DATA_FLAGS
> >
> >  #else /* CONFIG_MEMCG */
> >
> > +#define __OBJEXTS_ALLOC_FAIL (1UL << 0)
> >  #define __FIRST_OBJEXT_FLAG  (1UL << 0)
> >
> >  #endif /* CONFIG_MEMCG */
> >
> >  enum objext_flags {
> > -     /* slabobj_ext vector failed to allocate */
> > -     OBJEXTS_ALLOC_FAIL =3D __FIRST_OBJEXT_FLAG,
> > +     /*
> > +      * Use bit 0 with zero other bits to signal that slabobj_ext vect=
or
> > +      * failed to allocate. The same bit 0 with valid upper bits means
> > +      * MEMCG_DATA_OBJEXTS.
> > +      */
> > +     OBJEXTS_ALLOC_FAIL =3D __OBJEXTS_ALLOC_FAIL,
> >       /* the next bit after the last actual flag */
> >       __NR_OBJEXTS_FLAGS  =3D (__FIRST_OBJEXT_FLAG << 1),
> >  };
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 212161dc0f29..61841ba72120 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -2051,7 +2051,7 @@ static inline void handle_failed_objexts_alloc(un=
signed long obj_exts,
> >        * objects with no tag reference. Mark all references in this
> >        * vector as empty to avoid warnings later on.
> >        */
> > -     if (obj_exts & OBJEXTS_ALLOC_FAIL) {
> > +     if (obj_exts =3D=3D OBJEXTS_ALLOC_FAIL) {
> >               unsigned int i;
> >
> >               for (i =3D 0; i < objects; i++)
> > --
> > 2.47.3
> >


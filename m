Return-Path: <bpf+bounces-36797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A065594D81F
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 22:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C10541C22E5D
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 20:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B950168488;
	Fri,  9 Aug 2024 20:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ck3fp/yR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2852315534B
	for <bpf@vger.kernel.org>; Fri,  9 Aug 2024 20:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723235383; cv=none; b=CWvtIdjfW0dzi/iR1zfA6SqhpV8OOL8hfxTZeK93Xlos+9nDVSLykYuWM14qwQ1Cy1iX3z9j2kx1QD7EImTYnU1CYBAxsYvJ1xx1ugeNWJww+VdZXxsa7wEJ1wwdQI2QrAsZB4bF1SHn8q2abGC8vjCeCVhraxJQ0BhhLlCQMgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723235383; c=relaxed/simple;
	bh=FZUDcdZmTcWedPcN3i3caGXbz9vJlV57HZnsPFZgV1Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CxfUeVK+qW0WWwhd04S6wvpZkFvFnAlbWyCfHmeXdyj2XjUHmsOMd6KKfJnimX4o3hoF/bXmDG4CXzYotcfDbygavzPsLMqRx6tF4CbA7cQlykBTTfHk4U8zoypcagwZEbAKkklYrPZOWv7KVaW0poMYQwi3zoMPAga60BLntSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ck3fp/yR; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7a115c427f1so1775004a12.0
        for <bpf@vger.kernel.org>; Fri, 09 Aug 2024 13:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723235381; x=1723840181; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ye4rq6wWGyKQ1NqsBvDCNhjoCIL4bf50WQWs6P3LVzU=;
        b=Ck3fp/yRjGSa+zKxzQgoFjmxN7wN0skOY7QGeIVcBD5B7EhOOpUvFe2z+HZOadDNSK
         WQnlXEFvBVL0PEH2xLNxr5vZuOu+BEU1N3cu7KHUFipOsF68rEyPL3Nt+ufXcwVF0hEK
         P3th9wAcaKykSATTvMZH1RyL2Bw5x9VXjjzylbS7ed7zdAIHS4nt3N70iwGu+O3zyQm3
         6qwk+soFApxVeCGdd+lQHRSYGhAFE9/kumXY0SoVoFgZxI5VTzLHq7bJEL6NOsw2Gf39
         kzKZWX3kWo2H57JcyQjsTd4cWqz9S76hkezMHRJTqkTpfi4MwsqDDQkn49ua0LcftApD
         Kl8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723235381; x=1723840181;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ye4rq6wWGyKQ1NqsBvDCNhjoCIL4bf50WQWs6P3LVzU=;
        b=UyMc8FuwvoUynpEak+Un/PxTjne1Z7d31l1yyXPNxdRkOGFy2M17pdwLTFaqYvJcT6
         XS1DOwTK4qdMD1sEMloYdKlapbiGRSF+3kSh/OKvw+cfRNjL2UozfiqTXe3622hlKxSe
         6zwdDziicocfQYfquvRHkj5fFarRKSgags8m92epkzElIYs37uOOE+YKTkLIgKASYQjl
         IXAtsfZtv3oOOa0+H9fLVj60RVkYEFes4UzCOXKgsbQzwEmRffRNFOr1T0MLmDT9IG8c
         QRPg9Dc7rMVCBZ41g8MrDOVbS86mwEnqGrLCf7F7YwI/DJAM/AkUqitb28u5ROEA55JG
         +3cw==
X-Gm-Message-State: AOJu0YwPLJ91YRng+xGKewRm9TZY3L7Ng85t3a5nVRyw+hjfQyYFvFW/
	/naQwL3vXpIOxgOCy6DVDU/USMfI7HIfo7dDi1TlM7K14gqU+SyS
X-Google-Smtp-Source: AGHT+IHtJYMeYBwHIaO9R+Fwa1d0tZ+oWYdAyMvFqR7aY5s5yT+1o55yfmXOA5L9ZZ9Mr9D7tfgNcA==
X-Received: by 2002:a17:903:41d2:b0:1fa:7e0:d69a with SMTP id d9443c01a7336-200ae5cf5b0mr30768795ad.46.1723235381324;
        Fri, 09 Aug 2024 13:29:41 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5ab352fsm151258b3a.189.2024.08.09.13.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 13:29:40 -0700 (PDT)
Message-ID: <12302b09b8410132a6c6f761bee342fabd8bc1cf.camel@gmail.com>
Subject: Re: [PATCH] bpf: Fix percpu address space issues
From: Eduard Zingerman <eddyz87@gmail.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
Date: Fri, 09 Aug 2024 13:29:36 -0700
In-Reply-To: <CAFULd4b3BinvWTuHCAZvTeLjfuThAenK0G9V0yYN-LiHMzto3w@mail.gmail.com>
References: <20240804185604.54770-1-ubizjak@gmail.com>
	 <cbdf9051a35e8aa16478a2adc821403f53b4f4c0.camel@gmail.com>
	 <CAFULd4b3BinvWTuHCAZvTeLjfuThAenK0G9V0yYN-LiHMzto3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-08-09 at 12:15 +0200, Uros Bizjak wrote:
> On Fri, Aug 9, 2024 at 10:28=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Sun, 2024-08-04 at 20:55 +0200, Uros Bizjak wrote:
> >=20
> > [...]
> >=20
> > > Found by GCC's named address space checks.
> >=20
> > Please provide some additional details.
> > I assume that the definition of __percpu was changed from
> > __attribute__((btf_type_tag(percpu))) to
> > __attribute__((address_space(??)), is that correct?
>=20
> This is correct. The fixes in the patch are based on the patch series
> [1] that enable strict percpu check via GCC's x86 named address space
> qualifiers, and in its RFC state hacks __seg_gs into the __percpu
> qualifier (as can be seen in the 3/3 patch). The compiler will detect
> pointer address space mismatches for e.g.:
>=20
> --cut here--
> int __seg_gs m;
>=20
> int *foo (void) { return &m; }
> --cut here--
>=20
> v.c: In function =E2=80=98foo=E2=80=99:
> v.c:5:26: error: return from pointer to non-enclosed address space
>    5 | int *foo (void) { return &m; }
>      |                          ^~
> v.c:5:26: note: expected =E2=80=98int *=E2=80=99 but pointer is of type =
=E2=80=98__seg_gs int *=E2=80=99
>=20
> and expects explicit casts via uintptr_t when these casts are really
> intended ([2], please also see [3] for similar sparse requirement):
>=20
> int *foo (void) { return (int *)(uintptr_t)&m; }
>=20
> [1] https://lore.kernel.org/lkml/20240805184012.358023-1-ubizjak@gmail.co=
m/
> [2] https://gcc.gnu.org/onlinedocs/gcc/Named-Address-Spaces.html#x86-Name=
d-Address-Spaces
> [3] https://sparse.docs.kernel.org/en/latest/annotations.html#address-spa=
ce-name

Understood, thank you for the details.
Interestingly, clang does not require (uintptr_t) intermediate cast, e.g.:

    $ cat test.c
    #define __as(N) __attribute__((address_space(N)))

    void *foo(void __as(1)* x) { return x; }         // error
    void *bar(void __as(1)* x) { return (void *)x; } // fine

    $ clang -o /dev/null -c test.c
    test.c:3:37: error: returning '__as(1) void *' from a function with res=
ult type 'void *' changes address space of pointer
        3 | void *foo(void __as(1)* x) { return x; }         // error
          |                                     ^
    1 error generated.
   =20

[...]

> > > diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> > > index 188e3c2effb2..544ca433275e 100644
> > > --- a/kernel/bpf/arraymap.c
> > > +++ b/kernel/bpf/arraymap.c
> > > @@ -600,7 +600,7 @@ static void *bpf_array_map_seq_start(struct seq_f=
ile *seq, loff_t *pos)
> > >       array =3D container_of(map, struct bpf_array, map);
> > >       index =3D info->index & array->index_mask;
> > >       if (info->percpu_value_buf)
> > > -            return array->pptrs[index];
> > > +            return array->ptrs[index];
> >=20
> > I disagree with this change.
> > One might say that indeed the address space is cast away here,
> > however, value returned by this function is only used in functions
> > bpf_array_map_seq_{next,show,stop}(), where it is guarded by the same
> > 'if (info->percpu_value_buf)' condition to identify if per_cpu_ptr()
> > is necessary.
>=20
> If this is the case, you have to inform the compiler that address
> space is cast away with explicit (void *)(uintptr_t) cast, placed
> before return. But looking at the union with ptrs and pptrs members,
> it looked to me that it is just the case of wrong union member
> accessed.

I'd say it's better to use pptr and add a cast in this case.

[...]

> > > @@ -632,7 +632,7 @@ static int __bpf_array_map_seq_show(struct seq_fi=
le *seq, void *v)
> > >       struct bpf_iter_meta meta;
> > >       struct bpf_prog *prog;
> > >       int off =3D 0, cpu =3D 0;
> > > -     void __percpu **pptr;
> > > +     void * __percpu *pptr;
> >=20
> > Should this be 'void __percpu *pptr;?
> > The value comes from array->pptrs[*] field,
> > which has the above type for elements.
>=20
> I didn't want to introduce semantic changes, so I have just changed
> the base type fo __percpu one, due to:
>=20
> per_cpu_ptr(pptr, cpu));
>=20
> later in the code.

There would be no semantic changes if type of pptr is changed to 'void __pe=
rcpu *'.

[...]

> > > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > > index be1f64c20125..a49212bbda09 100644
> > > --- a/kernel/bpf/hashtab.c
> > > +++ b/kernel/bpf/hashtab.c
> > > @@ -1049,14 +1049,14 @@ static struct htab_elem *alloc_htab_elem(stru=
ct bpf_htab *htab, void *key,
> > >                       pptr =3D htab_elem_get_ptr(l_new, key_size);
> > >               } else {
> > >                       /* alloc_percpu zero-fills */
> > > -                     pptr =3D bpf_mem_cache_alloc(&htab->pcpu_ma);
> > > -                     if (!pptr) {
> > > +                     void *ptr =3D bpf_mem_cache_alloc(&htab->pcpu_m=
a);
> > > +                     if (!ptr) {
> >=20
> > Why adding an intermediate variable here?
>=20
> Mainly to avoid several inter-as casts, because l_new->ptr_to_pptr
> also expects assignment from generic address space.

Ok, makes sense.

[...]

> > > diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> > > index dec892ded031..b3858a76e0b3 100644
> > > --- a/kernel/bpf/memalloc.c
> > > +++ b/kernel/bpf/memalloc.c
> > > @@ -138,8 +138,8 @@ static struct llist_node notrace *__llist_del_fir=
st(struct llist_head *head)
> > >  static void *__alloc(struct bpf_mem_cache *c, int node, gfp_t flags)
> > >  {
> > >       if (c->percpu_size) {
> > > -             void **obj =3D kmalloc_node(c->percpu_size, flags, node=
);
> > > -             void *pptr =3D __alloc_percpu_gfp(c->unit_size, 8, flag=
s);
> > > +             void __percpu **obj =3D kmalloc_node(c->percpu_size, fl=
ags, node);
> >=20
> > Why __percpu is needed for obj?
>=20
> The new declaration declares "void pointer to percpu pointer", it is
> needed because some lines below we have:
>=20
>         obj[1] =3D pptr;

Oh, right.

[...]



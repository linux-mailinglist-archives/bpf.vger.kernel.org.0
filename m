Return-Path: <bpf+bounces-36766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9711594CE64
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 12:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02271C2189B
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 10:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A551922C1;
	Fri,  9 Aug 2024 10:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtRfttI+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B4419148D
	for <bpf@vger.kernel.org>; Fri,  9 Aug 2024 10:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723198519; cv=none; b=LxTzcaE93xyC9I/1ep0A/dkrpzZfjoDST+i+ZuN3Uro9Kl9elQjHnn5ECmQSNZD2aMZMWVech5nYCT3ZClpNlCWYOwV4V2qrp/R5lZC/hsB0ziODvicJ4TMvKF5nTcKw32i/bb1gUtvtTvn6CyHZCH/tUkcSCt+D2Os/1xwZgiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723198519; c=relaxed/simple;
	bh=DbJsEAXLN5oLXky9eLvm/6992PcVFaG5cEUtGr8+kQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aSL5l4J+SuUj7DXY+mVuBWO7c8sHzy0MUiwX2KKrdr6WuLlnmJvPV+mNKjXrr3lVMovTuu9qfDNstjneX9tLLVGqMh+mOZWH5A7OmNcfuPPKsp+gSybqcpiNijeVPfFzglgKMXr9WYnDa+OWh+Q+R84l9SSMQ2NrUAuvvSx6ZCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtRfttI+; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso29692991fa.2
        for <bpf@vger.kernel.org>; Fri, 09 Aug 2024 03:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723198515; x=1723803315; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5N08hYJ9aFPu3eGRi/xdJE4bo3L85WuxGD6+7VGAulU=;
        b=CtRfttI+R6f3kaKdnEHaL9pUYx8pW2+qM5KYptgQ3IkPBpbYl4VD446ADGiSOnrM67
         MoRBHdQY0LOGA32DKPl2BMXprFlwcbg7MM0R8UPFt0zbJX0mqEwIAEp88d3xp48bhO2o
         KE/gwHwhatwYJl0WjDktJoJrqgdlirP8UNoOxgcOAHN9lgc3Z4AqAUjoXljPZ6mvvQrL
         LIIqt0ed9NSqQ1/bLRRyOwWnylPMjkDgtGOzYF4WBL7tiPB6Y3XY+EFoHPiNZN2OAsBx
         XQSyME3TMmxACuwA2OMIW5QCQZmvbes3HcDtDt6QIEbF8LQPJoFOgxFR1QmqraEVHlr+
         ou5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723198515; x=1723803315;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5N08hYJ9aFPu3eGRi/xdJE4bo3L85WuxGD6+7VGAulU=;
        b=uy9Tn2SEV+IrcHaiLJtmGI6Ik7qMQoa/d8J6PFc1veiV0+DyhCebendr3aosF/l02o
         P6S6qDa+2lnb1u1ycKyJ+ExPPxuiYkIvS4Rx0Zr4Gf/MokroZf2iIV+q6vyGSrdb8WOg
         O+4hSljMfX2lrgJBfaug88oM+cvAowD+7QQVJT6/wZy4gIthc/gqs6izcsr//s57IW21
         AdSa3cSWWlbsygWCipmcsK71Bc77VqVOgTKRuf96fwsVo7jAnpoRGBwhzNqNyFCEAg7Z
         HgUtWMch4vSQ34OxsIWANwFDZf/qUSJx81y6lUuq25cyk2IrrI8JNxWrc+dGXKETXdSx
         /iyw==
X-Gm-Message-State: AOJu0YwHGqkziRaBTeHiFw8BwbZTKPTA1YysgKNSV5a1189+UT8ogFFk
	2Z2ud+wyh7etWolHuIRXX8XOAocMg37zJsCd+76t69yz5M4mzHGen35CaKr23agLkltSifNnBt7
	UNeJzMtO97cx/V2x0yqyE4jYTSORKeE3oRcM=
X-Google-Smtp-Source: AGHT+IGZqY1hQW1FU9tFIY/r15uIn/W91wQDzoxELHg1YbaGWy1bgt2YNvrZk1PrKOPaC9lJgk6B2XmTpAruyTgKNjk=
X-Received: by 2002:a2e:720d:0:b0:2ef:2dfd:15db with SMTP id
 38308e7fff4ca-2f1a6c5c78amr10387681fa.19.1723198514508; Fri, 09 Aug 2024
 03:15:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240804185604.54770-1-ubizjak@gmail.com> <cbdf9051a35e8aa16478a2adc821403f53b4f4c0.camel@gmail.com>
In-Reply-To: <cbdf9051a35e8aa16478a2adc821403f53b4f4c0.camel@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, 9 Aug 2024 12:15:02 +0200
Message-ID: <CAFULd4b3BinvWTuHCAZvTeLjfuThAenK0G9V0yYN-LiHMzto3w@mail.gmail.com>
Subject: Re: [PATCH] bpf: Fix percpu address space issues
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
Content-Type: multipart/mixed; boundary="00000000000055d1ee061f3d6b1e"

--00000000000055d1ee061f3d6b1e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 10:28=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Sun, 2024-08-04 at 20:55 +0200, Uros Bizjak wrote:
>
> [...]
>
> > Found by GCC's named address space checks.
>
> Please provide some additional details.
> I assume that the definition of __percpu was changed from
> __attribute__((btf_type_tag(percpu))) to
> __attribute__((address_space(??)), is that correct?

This is correct. The fixes in the patch are based on the patch series
[1] that enable strict percpu check via GCC's x86 named address space
qualifiers, and in its RFC state hacks __seg_gs into the __percpu
qualifier (as can be seen in the 3/3 patch). The compiler will detect
pointer address space mismatches for e.g.:

--cut here--
int __seg_gs m;

int *foo (void) { return &m; }
--cut here--

v.c: In function =E2=80=98foo=E2=80=99:
v.c:5:26: error: return from pointer to non-enclosed address space
   5 | int *foo (void) { return &m; }
     |                          ^~
v.c:5:26: note: expected =E2=80=98int *=E2=80=99 but pointer is of type =E2=
=80=98__seg_gs int *=E2=80=99

and expects explicit casts via uintptr_t when these casts are really
intended ([2], please also see [3] for similar sparse requirement):

int *foo (void) { return (int *)(uintptr_t)&m; }

[1] https://lore.kernel.org/lkml/20240805184012.358023-1-ubizjak@gmail.com/
[2] https://gcc.gnu.org/onlinedocs/gcc/Named-Address-Spaces.html#x86-Named-=
Address-Spaces
[3] https://sparse.docs.kernel.org/en/latest/annotations.html#address-space=
-name

For reference, I have attached a test source file with more complex
checks that also includes linux percpu verifier macro.

> What is the motivation for this patch?

With the percpu checker patch applied, the build will break with the
above error due to mismatched address space pointers.

> Currently __percpu is defined as a type tag and is used only by BPF verif=
ier,
> where it seems to be relevant only for structure fields and function para=
meters.
> This patch only changes local variables.

__percpu is also used for sparse checks (Use C=3D1 CHECK=3D"sparse
-Wcast-from-as"). Sparse also reports address space violations, but
its warnings are not fatal and are not as precise as the compiler. So,
if you try to compile the bpf source when the kernel source is patched
with the percpu checker, the compiler will report several errors that
my bpf patch tries to fix.

> > There were no changes in the resulting object files.
> >
> > [1] https://sparse.docs.kernel.org/en/latest/annotations.html#address-s=
pace-name
> >
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Martin KaFai Lau <martin.lau@linux.dev>
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Song Liu <song@kernel.org>
> > Cc: Yonghong Song <yonghong.song@linux.dev>
> > Cc: John Fastabend <john.fastabend@gmail.com>
> > Cc: KP Singh <kpsingh@kernel.org>
> > Cc: Stanislav Fomichev <sdf@fomichev.me>
> > Cc: Hao Luo <haoluo@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/bpf/arraymap.c |  8 ++++----
> >  kernel/bpf/hashtab.c  |  8 ++++----
> >  kernel/bpf/helpers.c  |  4 ++--
> >  kernel/bpf/memalloc.c | 12 ++++++------
> >  4 files changed, 16 insertions(+), 16 deletions(-)
> >
> > diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> > index 188e3c2effb2..544ca433275e 100644
> > --- a/kernel/bpf/arraymap.c
> > +++ b/kernel/bpf/arraymap.c
> > @@ -600,7 +600,7 @@ static void *bpf_array_map_seq_start(struct seq_fil=
e *seq, loff_t *pos)
> >       array =3D container_of(map, struct bpf_array, map);
> >       index =3D info->index & array->index_mask;
> >       if (info->percpu_value_buf)
> > -            return array->pptrs[index];
> > +            return array->ptrs[index];
>
> I disagree with this change.
> One might say that indeed the address space is cast away here,
> however, value returned by this function is only used in functions
> bpf_array_map_seq_{next,show,stop}(), where it is guarded by the same
> 'if (info->percpu_value_buf)' condition to identify if per_cpu_ptr()
> is necessary.

If this is the case, you have to inform the compiler that address
space is cast away with explicit (void *)(uintptr_t) cast, placed
before return. But looking at the union with ptrs and pptrs members,
it looked to me that it is just the case of wrong union member
accessed.

> >       return array_map_elem_ptr(array, index);
> >  }
> >
> > @@ -619,7 +619,7 @@ static void *bpf_array_map_seq_next(struct seq_file=
 *seq, void *v, loff_t *pos)
> >       array =3D container_of(map, struct bpf_array, map);
> >       index =3D info->index & array->index_mask;
> >       if (info->percpu_value_buf)
> > -            return array->pptrs[index];
> > +            return array->ptrs[index];
>
> Same as above.
>
> >       return array_map_elem_ptr(array, index);
> >  }
> >
> > @@ -632,7 +632,7 @@ static int __bpf_array_map_seq_show(struct seq_file=
 *seq, void *v)
> >       struct bpf_iter_meta meta;
> >       struct bpf_prog *prog;
> >       int off =3D 0, cpu =3D 0;
> > -     void __percpu **pptr;
> > +     void * __percpu *pptr;
>
> Should this be 'void __percpu *pptr;?
> The value comes from array->pptrs[*] field,
> which has the above type for elements.

I didn't want to introduce semantic changes, so I have just changed
the base type fo __percpu one, due to:

per_cpu_ptr(pptr, cpu));

later in the code.

>
> >       u32 size;
> >
> >       meta.seq =3D seq;
> > @@ -648,7 +648,7 @@ static int __bpf_array_map_seq_show(struct seq_file=
 *seq, void *v)
> >               if (!info->percpu_value_buf) {
> >                       ctx.value =3D v;
> >               } else {
> > -                     pptr =3D v;
> > +                     pptr =3D (void __percpu *)(uintptr_t)v;
> >                       size =3D array->elem_size;
> >                       for_each_possible_cpu(cpu) {
> >                               copy_map_value_long(map, info->percpu_val=
ue_buf + off,
> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > index be1f64c20125..a49212bbda09 100644
> > --- a/kernel/bpf/hashtab.c
> > +++ b/kernel/bpf/hashtab.c
> > @@ -1049,14 +1049,14 @@ static struct htab_elem *alloc_htab_elem(struct=
 bpf_htab *htab, void *key,
> >                       pptr =3D htab_elem_get_ptr(l_new, key_size);
> >               } else {
> >                       /* alloc_percpu zero-fills */
> > -                     pptr =3D bpf_mem_cache_alloc(&htab->pcpu_ma);
> > -                     if (!pptr) {
> > +                     void *ptr =3D bpf_mem_cache_alloc(&htab->pcpu_ma)=
;
> > +                     if (!ptr) {
>
> Why adding an intermediate variable here?

Mainly to avoid several inter-as casts, because l_new->ptr_to_pptr
also expects assignment from generic address space.

> Is casting bpf_mem_cache_alloc() result to percpu not sufficient?
> It looks like bpf_mem_cache_alloc() returns a percpu pointer,
> should it be declared as such?

This function is also used a couple of lines above changed hunk:

        l_new =3D bpf_mem_cache_alloc(&htab->ma);

where l_new is declared in generic address space.

>
> >                               bpf_mem_cache_free(&htab->ma, l_new);
> >                               l_new =3D ERR_PTR(-ENOMEM);
> >                               goto dec_count;
> >                       }
> > -                     l_new->ptr_to_pptr =3D pptr;
> > -                     pptr =3D *(void **)pptr;
> > +                     l_new->ptr_to_pptr =3D ptr;
> > +                     pptr =3D *(void __percpu **)ptr;
> >               }
> >
> >               pcpu_init_value(htab, pptr, value, onallcpus);
>
> [...]
>
> > diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> > index dec892ded031..b3858a76e0b3 100644
> > --- a/kernel/bpf/memalloc.c
> > +++ b/kernel/bpf/memalloc.c
> > @@ -138,8 +138,8 @@ static struct llist_node notrace *__llist_del_first=
(struct llist_head *head)
> >  static void *__alloc(struct bpf_mem_cache *c, int node, gfp_t flags)
> >  {
> >       if (c->percpu_size) {
> > -             void **obj =3D kmalloc_node(c->percpu_size, flags, node);
> > -             void *pptr =3D __alloc_percpu_gfp(c->unit_size, 8, flags)=
;
> > +             void __percpu **obj =3D kmalloc_node(c->percpu_size, flag=
s, node);
>
> Why __percpu is needed for obj?

The new declaration declares "void pointer to percpu pointer", it is
needed because some lines below we have:

        obj[1] =3D pptr;

and pptr needs to be declared in __percpu named address space due to:

    free_percpu(pptr);

> kmalloc_node is defined as 'alloc_hooks(kmalloc_node_noprof(__VA_ARGS__))=
',
> alloc_hooks(X) is a macro and it produces result of type typeof(X),
> kmalloc_node_noprof() returns void*, not __percpu void*.
> Do I miss something?

Yes, as explained above, the declaration:

void __percpu **obj

somehow unintuitively declares void pointer to percpu pointer, so the
types match (otherwise, the compiler would complain ;) ).

Thanks,
Uros.

--00000000000055d1ee061f3d6b1e
Content-Type: text/x-c-code; charset="US-ASCII"; name="named-as.c"
Content-Disposition: attachment; filename="named-as.c"
Content-Transfer-Encoding: base64
Content-ID: <f_lzmihnbo0>
X-Attachment-Id: f_lzmihnbo0

I2RlZmluZSBOVUxMIDAKCiNkZWZpbmUgX192ZXJpZnlfcGNwdV9wdHIocHRyKQkJCQkJCVwKZG8g
ewkJCQkJCQkJCVwKCWNvbnN0IHZvaWQgX19zZWdfZ3MgKl9fdnBwX3ZlcmlmeSA9ICh0eXBlb2Yo
KHB0cikgKyAwKSlOVUxMOwlcCgkodm9pZClfX3ZwcF92ZXJpZnk7CQkJCQkJXAp9IHdoaWxlICgw
KQoKdm9pZCBfX3NlZ19ncyAqKl9fcHB0cjsgLy8gdm9pZCBwb2ludGVyIG5hIHZvaWQgX19zZWdf
Z3MgcG9pbnRlcgoKdm9pZCAqZm9vMSAodm9pZCAqdikKewogIHZvaWQgX19zZWdfZ3MgKipwcHRy
ID0gdjsKICBfX3ZlcmlmeV9wY3B1X3B0ciAoKnBwdHIpOwogIHJldHVybiBwcHRyOwp9Cgp2b2lk
IF9fc2VnX2dzICpmb28yICh2b2lkICp2KQp7CiAgdm9pZCBfX3NlZ19ncyAqKnBwdHIgPSB2Owog
IF9fdmVyaWZ5X3BjcHVfcHRyICgqcHB0cik7CiAgcmV0dXJuICpwcHRyOwp9Cgp2b2lkICogX19z
ZWdfZ3MgKl9fcHRyOyAvLyBfX3NlZ19ncyB2b2lkIHBvaW50ZXIgdG8gdm9pZCBwb2ludGVyCgp2
b2lkIF9fc2VnX2dzICpiYXIxICh2b2lkIF9fc2VnX2dzICp2KQp7CiAgdm9pZCAqIF9fc2VnX2dz
ICpwdHIgPSB2OwogIF9fdmVyaWZ5X3BjcHVfcHRyIChwdHIpOwogIHJldHVybiBwdHI7Cn0KCnZv
aWQgKmJhcjIgKHZvaWQgX19zZWdfZ3MgKnYpCnsKICB2b2lkICogX19zZWdfZ3MgKnB0ciA9IHY7
CiAgX192ZXJpZnlfcGNwdV9wdHIgKHB0cik7CiAgcmV0dXJuICpwdHI7Cn0KCnZvaWQgX19zZWdf
Z3MgKnF1eCAodm9pZCAqcHRyKQp7CiAgcmV0dXJuICoodm9pZCBfX3NlZ19ncyAqKilwdHI7Cn0K
CnZvaWQgX19zZWdfZ3MgKnF1dXggKHZvaWQgKnB0cikKewogIHJldHVybiAoKHZvaWQgX19zZWdf
Z3MgKiopcHRyKVsxXTsKfQoKdm9pZCBfX3NlZ19ncyAqcXV1dXggKHZvaWQgX19zZWdfZ3MgKipw
dHIpCnsKICByZXR1cm4gKnB0cjsKfQoKdm9pZCBfX3NlZ19ncyAqdGVzdCAodm9pZCAqdikKewog
IHZvaWQgX19zZWdfZ3MgKipwcHRyID0gdjsKCiAgcmV0dXJuICpwcHRyOwp9Cgp2b2lkICp0ZXN0
XyAodm9pZCAqdikKewogIHZvaWQgX19zZWdfZ3MgKipwcHRyID0gdjsKCiAgcmV0dXJuIHBwdHI7
Cn0K
--00000000000055d1ee061f3d6b1e--


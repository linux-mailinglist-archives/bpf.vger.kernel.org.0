Return-Path: <bpf+bounces-13485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 334CF7DA1FE
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 22:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3AD2823EE
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 20:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F0D3C084;
	Fri, 27 Oct 2023 20:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Br4kW9+A"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A1A38BA8
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 20:49:52 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C42D6D
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 13:49:48 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9be02fcf268so370967466b.3
        for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 13:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698439786; x=1699044586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMCboBQyH3s0Cq9AAJESKVjwtOX2ihudFPiTTKAYrZg=;
        b=Br4kW9+AQPCfZaqg5SfHz//vrv9RDgI+YYEI1gIXzROkq82ochtguaqlOpLDo1KDSy
         JCe7ltxp5Fh4357uZXLcF0bBM9k2mLPw/46zluoOudStxAm8ke8OJKVWFN3JIYvqQtOD
         M/IpDtHz7zu8IXdmZl4EuSLONRvJC0HWZHbaPXXJAe8yx6NwOJU3Je+GBELQ56JtogsJ
         9rm/07z+t/brurSUatcX37hqMYjEcU9QEF3DfRfdNrY4KioaY2nsOhDeJG3M8Rm3PYJU
         tw/zR3L6KnVwwBzMRHh/LceI229solATvGsWLQIByXWAuI4d7Rd36scX6nXEJM9qdKb5
         E+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698439786; x=1699044586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMCboBQyH3s0Cq9AAJESKVjwtOX2ihudFPiTTKAYrZg=;
        b=E7dUFhNWWnnOJLhMZ5Z/Rm6xCNzCxujqI2lmPrpX/U/HhsN6i0vx7ATOaImTFQVI86
         kSXyk7GcS1gw9hVOYBUmGmZt3x+fsvaGUjq/1SGNPwQEBAs8tedldWEm6HcoygYpixBz
         K3U0nbQlTihOoOYpiYZm9W5Tf3AqW7ZgyssWpwtNMMXUgfVdOFVnR7WF21LMBqYCpRKM
         f/70S7s7W6jEFkE8avc9fNY+zpRuG7iCPKMFJkCHTpPRNqFAmeZ/cItrhpGcyewUM6FD
         aSv1V0tS2moEmNk0xTloB7Fu+tsHORw0rpEjO2OVfSZazlYA0PaOoYTKWGtqZRAcITmd
         Zfrg==
X-Gm-Message-State: AOJu0YwSjhEPnbcVv5IhAFrwQZfqFK95TN6JRx395+ZmL5iwJC/U4Be8
	z+T07mVKFDQ7AwvNDB3rSoswNK5kxYq4IZnsalw=
X-Google-Smtp-Source: AGHT+IGpHCVTTnQTGUgUcU9eBT03v1sDt2aXJB/m1EULwY2NLMyVwhNmq6lhGbiaUtL/67RAwu5zHDxojaMjFjEH0Io=
X-Received: by 2002:a17:907:3fa3:b0:9c5:1100:9b8c with SMTP id
 hr35-20020a1709073fa300b009c511009b8cmr3000154ejc.56.1698439786283; Fri, 27
 Oct 2023 13:49:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZTZxoDJJbX9mrQ9w@u94a> <CAEf4Bzb6kLMZo+VsUu=LS5V4WRY-_x-zinv0Pkr6XEbCrHvo-w@mail.gmail.com>
 <ZTtDCts772nPnKXR@u94a>
In-Reply-To: <ZTtDCts772nPnKXR@u94a>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 27 Oct 2023 13:49:34 -0700
Message-ID: <CAEf4BzYRSVUtO1ADdSy901UdudRELMET50ckH_tbDWV=Mx6HNQ@mail.gmail.com>
Subject: Re: Unifying signed and unsigned min/max tracking
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Dave Thaler <dthaler@microsoft.com>, Paul Chaignon <paul@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 9:57=E2=80=AFPM Shung-Hsi Yu <shung-hsi.yu@suse.com=
> wrote:
>
> On Mon, Oct 23, 2023 at 09:50:59AM -0700, Andrii Nakryiko wrote:
> > On Mon, Oct 23, 2023 at 6:14=E2=80=AFAM Shung-Hsi Yu <shung-hsi.yu@suse=
.com> wrote:
> > >
> > > Hi,
> > >
> > > CC those who had worked on bound tracking before for feedbacks, as we=
ll as
> > > Dave who works on PREVAIL (verifier used on Windows) and Paul who've =
written
> > > about PREVAIL[1], for whether there's existing knowledge on this topi=
c.
> > >
> > > Here goes a long one...
> > >
> > > ---
> > >
> > > While looking at Andrii's patches that improves bounds logic (specifi=
cally
> > > patches [2][3]). I realize we may be able to unify umin/umax/smin/sma=
x into
> > > just two u64. Not sure if this has already been discussed off-list or=
 is
> > > being worked upon, but I can't find anything regarding this by search=
ing
> > > within the BPF mailing list.
> > >
> > > For simplicity sake I'll focus on unsigned bounds for now. What we ha=
ve
> > > right in the Linux Kernel now is essentially
> > >
> > >     struct bounds {
> > >         u64 umin;
> > >         u64 umax;
> > >     }
> > >
> > > We can visualize the above as a number line, using asterisk to denote=
 the
> > > values between umin and umax.
> > >
> > >                  u64
> > >     |----------********************--|
> > >
> > > Say if we have umin =3D A, and umax =3D B (where B > 2^63). Represent=
ing the
> > > magnitude of umin and umax visually would look like this
> > >
> > >     <----------> A
> > >     |----------********************--|
> > >     <-----------------------------> B (larger than 2^63)
> > >
> > > Now if we go through a BPF_ADD operation and adds 2^(64 - 1) =3D 2^63=
,
> > > currently the verifier will detect that this addition overflows, and =
thus
> > > reset umin and umax to 0 and U64_MAX, respectively; blowing away exis=
ting
> > > knowledge.
> > >
> > >     |********************************|
> > >
> > > Had we used u65 (1-bit more than u64) and tracks the bound with u65_m=
in and
> > > u65_max, the verifier would have captured the bound just fine. (This =
idea
> > > comes from the special case mentioned in Andrii's patch[3])
> > >
> > >                                     u65
> > >     <---------------> 2^63
> > >                     <----------> A
> > >     <--------------------------> u65_min =3D A + 2^63
> > >     |--------------------------********************------------------=
|
> > >     <---------------------------------------------> u65_max =3D B + 2=
^63
> > >
> > > Continue on this thought further, let's attempting to map this back t=
o u64
> > > number lines (using two of them to fit everything in u65 range), it w=
ould
> > > look like
> > >
> > >                                     u65
> > >     |--------------------------********************------------------=
|
> > >                                vvvvvvvvvvvvvvvvvvvv
> > >     |--------------------------******|*************------------------=
|
> > >                    u64                              u64
> > >
> > > And would seems that we'd need two sets of u64 bounds to preserve our
> > > knowledge.
> > >
> > >     |--------------------------******| u64 bound #1
> > >     |**************------------------| u64 bound #2
> > >
> > > Or just _one_ set of u64 bound if we somehow are able to track the un=
ion of
> > > bound #1 and bound #2 at the same time
> > >
> > >     |--------------------------******| u64 bound #1
> > >   U |**************------------------| u64 bound #2
> > >      vvvvvvvvvvvvvv            vvvvvv  union on the above bounds
> > >     |**************------------******|
> > >
> > > However, this bound crosses the point between U64_MAX and 0, which is=
 not
> > > semantically possible to represent with the umin/umax approach. It ju=
st
> > > makes no sense.
> > >
> > >     |**************------------******| union of bound #1 and bound #2
> > >
> > > The way around this is that we can slightly change how we track the b=
ounds,
> > > and instead use
> > >
> > >     struct bounds {
> > >         u64 base; /* base =3D umin */
> > >         /* Maybe there's a better name other than "size" */
> > >         u64 size; /* size =3D umax - umin */
> > >     }
> > >
> > > Using this base + size approach, previous old bound would have looked=
 like
> > >
> > >     <----------> base =3D A
> > >     |----------********************--|
> > >                <------------------> size =3D B - A
> > >
> > > Looking at the bounds this way means we can now capture the union of =
bound
> > > #1 and bound #2 above. Here it is again for reference
> > >
> > >     |**************------------******| union of bound #1 and bound #2
> > >
> > > Because registers are u64-sized, they wraps, and if we extend the u64=
 number
> > > line, it would look like this due to wrapping
> > >
> > >                    u64                         same u64 wrapped
> > >     |**************------------******|*************------------******=
|
> > >
> > > Which can be capture with the base + size semantic
> > >
> > >     <--------------------------> base =3D (u64) A + 2^63
> > >     |**************------------******|*************------------******=
|
> > >                                <------------------> size =3D B - A,
> > >                                                     doesn't change af=
ter add
> > >
> > > Or looking it with just a single u64 number line again
> > >
> > >     <--------------------------> base =3D (u64) A + 2^63
> > >     |**************------------******|
> > >     <-------------> base + size =3D (u64) (B + 2^32)
> > >
> > > This would mean that umin and umax is no longer readily available, we=
 now
> > > have to detect whether base + size wraps to determin whether umin =3D=
 0 or
> > > base (and similar for umax). But the verifier already have the code t=
o do
> > > that in the existing scalar_min_max_add(), so it can be done by reusi=
ng
> > > existing code.
> > >
> > > ---
> > >
> > > Side tracking slightly, a benefit of this base + size approach is tha=
t
> > > scalar_min_max_add() can be made even simpler:
> > >
> > >     scalar_min_max_add(struct bpf_reg_state *dst_reg,
> > >                                struct bpf_reg_state *src_reg)
> > >     {
> > >         /* This looks too simplistic to have worked */
> > >         dst_reg.base =3D dst_reg.base + src_reg.base;
> > >         dst_reg.size =3D dst_reg.size + src_reg.size;
> > >     }
> > >
> > > Say we now have another unsigned bound where umin =3D C and umax =3D =
D
> > >
> > >     <--------------------> C
> > >     |--------------------*********---|
> > >     <----------------------------> D
> > >
> > > If we want to track the bounds after adding two registers on with umi=
n =3D A &
> > > umax =3D B, the other with umin =3D C and umin =3D D
> > >
> > >     <----------> A
> > >     |----------********************--|
> > >     <-----------------------------> B
> > >                      +
> > >     <--------------------> C
> > >     |--------------------*********---|
> > >     <----------------------------> D
> > >
> > > The results falls into the following u65 range
> > >
> > >     |--------------------*********---|-------------------------------=
|
> > >   + |----------********************--|-------------------------------=
|
> > >
> > >     |------------------------------**|**************************-----=
|
> > >
> > > This result can be tracked with base + size approach just fine. Where=
 the
> > > base and size are as follow
> > >
> > >     <------------------------------> base =3D A + C
> > >     |------------------------------**|**************************-----=
|
> > >                                    <--------------------------->
> > >                                       size =3D (B - A) + (D - C)
> > >
> > > ---
> > >
> > > Now back to the topic of unification of signed and unsigned range. Us=
ing the
> > > union of bound #1 and bound #2 again as an example (size =3D B - A, a=
nd
> > > base =3D (u64) A + 2^63)
> > >
> > >     |**************------------******| union of bound #1 and bound #2
> > >
> > > And look at it's wrapped number line form again
> > >
> > >                    u64                         same u64 wrapped
> > >     <--------------------------> base
> > >     |**************------------******|*************------------******=
|
> > >                                <------------------> size
> > >
> > > Now add in the s64 range and align both u64 range and s64 at 0, we ca=
n see
> > > what previously was a bound that umin/umax cannot track is simply a v=
alid
> > > smin/smax bound (idea drawn from patch [2]).
> > >
> > >                                      0
> > >     |**************------------******|*************------------******=
|
> > >                     |----------********************--|
> > >                                     s64
> > >
> > > The question now is be what is the "signed" base so we proceed to cal=
culate
> > > the smin/smax. Note that base starts at 0, so for s64 the line that
> > > represents base doesn't start from the left-most location.
> > > (OTOH size stays the same, so we know it already)
> > >
> > >                                     s64
> > >                                      0
> > >                                <-----> signed base =3D ?
> > >                     |----------********************--|
> > >                                <------------------> size is the same
> > >
> > > If we put u64 range back into the picture again, we can see that the =
"signed
> > > base" was, in fact, just base casted into s64, so there's really no n=
eed for
> > > a "signed" base at all
> > >
> > >     <--------------------------> base
> > >     |**************------------******|
> > >                                      0
> > >                                <-----> signed base =3D (s64) base
> > >                     |----------********************--|
> > >
> > > Which shows base + size approach capture signed and unsigned bounds a=
t the
> > > same time. Or at least its the best attempt I can make to show it.
> > >
> > > One way to look at this is that base + size is just a generalization =
of
> > > umin/umax, taking advantage of the fact that the similar underlying h=
ardware
> > > is used both for the execution of BPF program and bound tracking.
> > >
> > > I wonder whether this is already being done elsewhere, e.g. by PREVAI=
L or
> > > some of static code analyzer, and I can just borrow the code from the=
re
> > > (where license permits).
> >
> > A slight alternative, but the same idea, that I had (though after
> > looking at reg_bounds_sync() I became less enthusiastic about this)
> > was to unify signed/unsigned ranges by allowing umin u64> umax. That
> > is, invalid range where umin is greater than umax would mean the wrap
> > around case (which is also basically smin/smax case when it covers
> > negative and positive parts of s64/s32 range).
> >
> > Taking your diagram and annotating it a bit differently:
> >
> > |**************------------******|
> >              umax        umin
>
> Yes, that was exactly that's how I look at it at first (not that
> surprisingly given I was drawing ideas from you patchset :) ), and it
> certainly has the benefit of preserving both bounds, where as the base +
> size approach only preserve one of the bounds, leaving the other to be
> calculated.
>
> The problem I have with allowing umin u64> umax is mostly a naming one, t=
hat
> it would be rather error prone and too easy to assume umin is always smal=
ler
> than umax (after all, that how it works now); and I can't come up with a
> better name for them in that form.

min64/max64 and min32/max32 would be my proposal if/when we unify them.

>
> But as you've pointed out both approach are the same idea, if one works s=
o
> will the other.
>
> > It will make everything more tricky, but if someone is enthusiastic
> > enough to try it out and see if we can make this still understandable,
> > why not?
>
> I'll blindly assume reg_bounds_sync() can be worked out eventually to kee=
p
> my enthusiasm and look at just the u64/s64 case for now, let see how that
> goes...
>

probably, yes


> > > The glaring questions left to address are:
> > > 1. Lots of talk with no code at all:
> > >      Will try to work on this early November and send some result as =
RFC. In
> > >      the meantime if someone is willing to give it a try I'll do my b=
est to
> > >      help.
> > >
> > > 2. Whether the same trick applied to scalar_min_max_add() can be appl=
ied to
> > >    other arithmetic operations such as BPF_MUL or BPF_DIV:
> > >      Maybe not, but we should be able to keep on using most of the ex=
isting
> > >      bound inferring logic we have scalar_min_max_{mul,div}() since b=
ase +
> > >      size can be viewed as a generalization of umin/umax/smin/smax.
> > >
> > > 3. (Assuming this base + size approach works) how to integrate it int=
o our
> > >    existing codebase:
> > >      I think we may need to refactor out code that touches
> > >      umin/umax/smin/smax and provide set-operation API where possible=
. (i.e.
> > >      like tnum's APIs)
> > >
> > > 4. Whether the verifier loss to ability to track certain range that c=
omes
> > >    out of mixed u64 and s64 BPF operations, and this loss cause some =
BPF
> > >    program that passes the verfier to now be rejected.
> >
> > Very well might be, I've seen some crazy combinations in my testing.
> > Good thing is that I'm adding a quite exhaustive tests that try all
> > different boundary conditions. If you check seeds values I used, most
> > of them are some sort of boundary for signed/unsigned 32/64 bit
> > numbers. Add to that abstract interpretation model checking, and you
> > should be able to validate your ideas pretty easily.
>
> Thanks for the heads up. Would be glad to see the exhaustive tests being
> added!

Check [0]. You can run range vs consts (7.7mln cases) with

sudo SLOW_TESTS=3D1 ./test_progs -a 'reg_bounds_gen_consts*' -j

And range vs range (106mln cases right now) with

sudo SLOW_TESTS=3D1 ./test_progs -a 'reg_bounds_gen_ranges*' -j

The latter might take a bit, it runs for about 1.5 hours for me.

It's not exhaustive in a strict sense of this word, as we can't really
try all possible u64/s64 ranges, ever. But it tests a lot of edge
values on the border between min/max values for u32/s32 and u64/s32.
Give it a try.

  [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=3D797178&=
state=3D*

>
> > > 5. Probably more that I haven't think of, feel free to add or comment=
s :)
> > >
> > >
> > > Shung-Hsi
> > >
> > > 1: https://pchaigno.github.io/ebpf/2023/09/06/prevail-understanding-t=
he-windows-ebpf-verifier.html
> > > 2: https://lore.kernel.org/bpf/20231022205743.72352-2-andrii@kernel.o=
rg/
> > > 3: https://lore.kernel.org/bpf/20231022205743.72352-4-andrii@kernel.o=
rg/


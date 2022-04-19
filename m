Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EA8507A31
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 21:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350599AbiDST04 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Apr 2022 15:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356148AbiDST0y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 15:26:54 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81863EAA0
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 12:24:07 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id p10so31121962lfa.12
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 12:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Zzeym1q9fwXeXkyhUjPG1VYZ/CmTb5B19aE23OsyfGw=;
        b=kO41nrgAm1/KJaEjxOacny7isjiYlaGy6OZp1J+CWumDmMkZaA/ty3rBQAFmOpg9vn
         sESt6J4qtdUang8NOFXBsPa2d8brliwx4Y0Cw+IHi/FP/ZdwxZvQ23GQGrX/7rh6iTK0
         Yxq6JwB8yOTiuuznWYLapOlqjYyav1bysMa9N6cDbh8F410IfhF6aB5DELftME0FmfhI
         xdIf95ttW2A4/dNOXkZUE81E3H22jT4W2qp7KG3JDKG76KuqXX6snT0wMWuzuVmHUA96
         NOnpGDSSrmVMZgzcCIfR0Jt1cM+jLhV/hfGRdsQ5Slqis28Sybqc+IgxRHrKu9XbpjLR
         Ghew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Zzeym1q9fwXeXkyhUjPG1VYZ/CmTb5B19aE23OsyfGw=;
        b=7k5/Gs1TFzc4KTJXP6aSSGbtYbc0qSTC+CCPQ01IcBeOc3aMcz3wHoC0DIRU3tU7rH
         eQIu6g+tH4P8PUxX0Q9FZHrEmUBMh/HOlqwYMwmMqrIJwCbxEw33C0gxTtZmwD8q0k8h
         Re8o2tejZR64FCl1CHkh5/4TJata6SZQAe5XkaQWjYMdmE8xsk1jTbzk3k3Cjq/OZNAU
         sGhetyv+WZlwtyO01/AHU6iDyGc9ioWi3CIqLfxNnMRkFNIl2eQOCgBL9PW+qUmhpDXk
         Jdu+NC0IzmxBi72qJpM2UpQ1J3y98Kn1EGTMbg2q7Z+e6EyVQbR+KpqdC3TtzZTgvbOE
         obKQ==
X-Gm-Message-State: AOAM532p0UftQn/ATblRdSB9MgHPsxsmOACu137yQCUORCB5xO1/C0bL
        ar+uLLtAm0dDb3KaYwJxZ/nKGy7tUI/+8BvdqZI=
X-Google-Smtp-Source: ABdhPJwJ6/mj3gGUJDP1EWecIisUIOFDGfuUxGC/hm3Sk3o43tEgMu/Fr6Utbx9/YgoGwvBzKmK9uov1jqRxarFmHTE=
X-Received: by 2002:a05:6512:10c5:b0:471:924f:1eed with SMTP id
 k5-20020a05651210c500b00471924f1eedmr7755111lfg.641.1650396245899; Tue, 19
 Apr 2022 12:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220416063429.3314021-1-joannelkoong@gmail.com>
 <20220416063429.3314021-4-joannelkoong@gmail.com> <20220416174205.hezp2jnow3hqk6s6@apollo.legion>
 <CAJnrk1adv16+wgEN+euJgfhXFQ+TUDjL36Bo=w_TtzqgomX00Q@mail.gmail.com> <20220418235718.izeq7kkwinedpkuj@apollo.legion>
In-Reply-To: <20220418235718.izeq7kkwinedpkuj@apollo.legion>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Tue, 19 Apr 2022 12:23:55 -0700
Message-ID: <CAJnrk1ag9PT1iXMzB5cxJEnwESYndYE_LozvBuL_Db2degJ-CQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/7] bpf: Add bpf_dynptr_from_mem,
 bpf_dynptr_alloc, bpf_dynptr_put
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 18, 2022 at 4:57 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Tue, Apr 19, 2022 at 03:50:38AM IST, Joanne Koong wrote:
> > ()On Sat, Apr 16, 2022 at 10:42 AM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > > [...]
> > > >
> > > >       if (arg_type =3D=3D ARG_CONST_MAP_PTR) {
> > > > @@ -5565,6 +5814,44 @@ static int check_func_arg(struct bpf_verifie=
r_env *env, u32 arg,
> > > >               bool zero_size_allowed =3D (arg_type =3D=3D ARG_CONST=
_SIZE_OR_ZERO);
> > > >
> > > >               err =3D check_mem_size_reg(env, reg, regno, zero_size=
_allowed, meta);
> > > > +     } else if (arg_type_is_dynptr(arg_type)) {
> > > > +             /* Can't pass in a dynptr at a weird offset */
> > > > +             if (reg->off % BPF_REG_SIZE) {
> > >
> > > In invalid_helper2 test, you are passing &dynptr + 8, which means reg=
 will be
> > > fp-8 (assuming dynptr is at top of stack), get_spi will compute spi a=
s 0, so
> > > spi-1 will lead to OOB access for the second dynptr stack slot. If yo=
u run the
> > > dynptr test under KASAN, you should see a warning for this.
> > >
> > > So we should ensure here that reg->off is atleast -16.
> > I think this is already checked against in is_spi_bounds(), where we
> > explicitly check that spi - 1 and spi is between [0, the allocated
> > stack). is_spi_bounds() gets called in "is_dynptr_reg_valid_init()" a
> > few lines down where we check if the initialized dynptr arg that's
> > passed in by the program is valid.
> >
> > On my local environment, I simulated this "reg->off =3D -8" case and
> > this fails the is_dynptr_reg_valid_init() -> is_spi_bounds() check and
> > we get back the correct verifier error "Expected an initialized dynptr
> > as arg #3" without any OOB accesses. I also tried running it with
> > CONFIG_KASAN=3Dy as well and didn't see any warnings show up. But maybe
> > I'm missing something in this analysis - what are your thoughts?
>
> I should have been clearer, the report is for accessing state->stack[spi =
-
> 1].slot_type[0] in is_dynptr_reg_valid_init, when the program is being lo=
aded.
>
> I can understand why you might not see the warning. It is accessing
> state->stack[spi - 1], and the allocation comes from kmalloc slab cache, =
so if
> another allocation has an object that covers the region being touched, KA=
SAN
> probably won't complain, and you won't see the warning.
>
> Getting back the correct result for the test can also happen if you don't=
 load
> STACK_DYNPTR at the state->stack[spi - 1].slot_type[0] byte. The test is =
passing
> for me too, fwiw.
>
> Anyway, digging into this reveals the real problem.
>
> >>> static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, st=
ruct bpf_reg_state *reg,
> >>>                                  enum bpf_arg_type arg_type)
> >>> {
> >>>     struct bpf_func_state *state =3D func(env, reg);
> >>>     int spi =3D get_spi(reg->off);
> >>>
>
> Here, for reg->off =3D -8, get_spi is (-(-8) - 1)/BPF_REG_SIZE =3D 0.
" >
> >>>     if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
>
> is_spi_bounds_valid will return true, probably because of the unintended
> conversion of the expression (spi - nr_slots + 1) to unsigned, so the tes=
t
Oh interesting. I missed that arithmetic on int and unsigned always
casts the result to unsigned if both have the same conversion rank.
Thanks for pointing this out. I'll change nr_slots to int.

> against >=3D 0 is always true (compiler will optimize it out), and just t=
est
> whether spi < allocated_stacks.
>
> You should probably declare nr_slots as int, instead of u32. Just doing t=
his
> should be enough to prevent this, without ensuring reg->off is <=3D -16.
>
> >>>         state->stack[spi].slot_type[0] !=3D STACK_DYNPTR ||
>
> Execution moves on to this, which is (second dynptr slot is STACK_DYNPTR)=
.
>
> >>>         state->stack[spi - 1].slot_type[0] !=3D STACK_DYNPTR ||
>
> and it accesses state->stack[-1].slot_type[0] here, which triggers the KA=
SAN
> warning for me.
>
> >>>         !state->stack[spi].spilled_ptr.dynptr.first_slot)
> >>>             return false;
> >>>
> >>>     /* ARG_PTR_TO_DYNPTR takes any type of dynptr */
> >>>     if (arg_type =3D=3D ARG_PTR_TO_DYNPTR)
> >>>             return true;
> >>>
> >>>     return state->stack[spi].spilled_ptr.dynptr.type =3D=3D arg_to_dy=
nptr_type(arg_type);
> >>> }
>
> > > [...]
>
> There is another issue I noticed while basing other work on this. You hav=
e
> declared bpf_dynptr in UAPI header as:
>
>         struct bpf_dynptr {
>                 __u64 :64;
>                 __u64 :64;
>         } __attribute__((aligned(8)));
>
> Sadly, in C standard, the compiler is under no obligation to initialize p=
adding
> bits when the object is zero initialized (using =3D {}). It is worse, whe=
n
> unrelated struct fields are assigned the padding bits are assumed to atta=
in
> unspecified values, but compilers are usually conservative in that case (=
C11
> 6.2.6.1 p6).
Thanks for noting this. By "padding bits", you are referring to the
unnamed fields, correct?

From the commit message in 5eaed6eedbe9, I see:

INTERNATIONAL STANDARD =C2=A9ISO/IEC ISO/IEC 9899:201x
  Programming languages =E2=80=94 C
  http://www.open-std.org/Jtc1/sc22/wg14/www/docs/n1547.pdf
  page 157:
  Except where explicitly stated otherwise, for the purposes of
  this subclause unnamed members of objects of structure and union
  type do not participate in initialization. Unnamed members of
  structure objects have indeterminate value even after initialization.

so it seems like the best way to address that here is to just have the
fields be explicitly named, like something like

struct bpf_dynptr {
    __u64 anon1;
    __u64 anon2;
} __attribute__((aligned(8)))

Do you agree with this assessment?

>
> See 5eaed6eedbe9 ("bpf: Fix a bpf_timer initialization issue") on how thi=
s has
> bitten us once before.
>
> I was kinda surprised you don't hit this with your selftests, since in th=
e BPF
> assembly of dynptr_fail.o/dynptr_success.o I seldom see stack location of=
 dynptr
> being zeroed out. But after applying the fix for the above issue, I see t=
his
> error and many failing tests (only 26/36 passed).
>
> verifier internal error: variable not initialized on stack in mark_as_dyn=
ptr_data
>
> So I think the bug above was papering over this issue? I will look at it =
in more
> detail later.
>
> --
> Kartikeya

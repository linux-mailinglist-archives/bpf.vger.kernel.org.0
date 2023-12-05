Return-Path: <bpf+bounces-16698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A569804857
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 04:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2551F21497
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 03:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A353C14B;
	Tue,  5 Dec 2023 03:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNCPtGdN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B05EC6
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 19:56:30 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a0029289b1bso667465266b.1
        for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 19:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701748589; x=1702353389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyyxZiUdydzmN7a89vkdMa7xMZ0B2xYEZ7tdKLl6Aj0=;
        b=QNCPtGdNA+UEnMqKr6FNag0xbTTqDmhHaI+wjUqxIqSHIxm47eEQOaRTDiWlEOyvIJ
         3i3HEBi2+Sr16fGfQIVS7Ik0G45E5aMmkHwRtDAqJ3kU07YncVVQCHYANxS1+RcYZzWl
         UO0CG6xtv/NsuxWcSy8UyXGWtvpiWL5OHs2qD5cGXoG6EDTS8qvz4n1Rijz/ORnzFZ8K
         F5uIlQBnkNJm8EM0gxub6Y/DT/k7mtvhUjB59qexnJ1hNYWPZ6rM7nmW1/fJ6ItYiKYh
         bpQJaZ1TGtbIdqPTzJPJBl0pxgmLTYksgYfJzfyLiIdiKGIx6BrV9S63aPVJglYQnewp
         8Zgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701748589; x=1702353389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyyxZiUdydzmN7a89vkdMa7xMZ0B2xYEZ7tdKLl6Aj0=;
        b=tt7SWWF1pptrP0NMzIPUiAOqHwffv8+uGV9MtMDKPvPPa8GldyptUxipYqJYOPIQHp
         Ue2dHIpU0AJxyq7MSq9yL/OhBv4ld7JgNrXHWF1lbaGyYnNUI5lLK3V9MUITKwlDV5wt
         iyC24SDRV1i+bB9SybauO6evY1/9c71+6jrORp7suMw7nT75idQKRxNQ96FvkWYe3k/J
         el2WXhwGvJxQbeJKrbNH8YrJ/mUKBZ12YwW+NeeHxLRw/8TRD+qAx3iG1+fXfzDFR9AD
         rJKxAL/9i1oArWQFF+NrBMElv1EA0KRkgWSHcTFGi9f+5P4Q3u8+BWMH1Bh5u2GtLs5H
         4n3w==
X-Gm-Message-State: AOJu0YxLhgSeEvfuHKPkMOInR9IcDL2xg/LG6j4pPDr2V4zWnW7LtpWi
	7G0l+BuztUZuuGo6MCxJnLRrgkW7siArV62Q9RM=
X-Google-Smtp-Source: AGHT+IFfWHNIFGMX2aniuvzKAqjvZ2J6gvcbuBWMP5mEcONviVv9JoIq8MVXoZ4xdV9rESN/rz6lYl2bXMfIlV+oiOM=
X-Received: by 2002:a17:906:208d:b0:a18:c31e:c126 with SMTP id
 13-20020a170906208d00b00a18c31ec126mr3940944ejq.75.1701748588559; Mon, 04 Dec
 2023 19:56:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204192601.2672497-1-andrii@kernel.org> <20231204192601.2672497-4-andrii@kernel.org>
 <3fca38fdfd975f735e3dd31930637cfbc70948f4.camel@gmail.com>
 <CAEf4BzZ0Ao7EF4PodPBxTdQphEt-_ezZyNDOzqds2XfXYpjsHg@mail.gmail.com> <6875401e502049bfdfa128fc7bf37fabe5314e2f.camel@gmail.com>
In-Reply-To: <6875401e502049bfdfa128fc7bf37fabe5314e2f.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 4 Dec 2023 19:56:16 -0800
Message-ID: <CAEf4Bzb8LouFSSX5DED_ucgq_xuhukE1BQ7y=hxY0c17Nq4T+Q@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 03/10] bpf: fix check for attempt to corrupt
 spilled pointer
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 4:54=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2023-12-04 at 16:23 -0800, Andrii Nakryiko wrote:
> [...]
> > > > @@ -4431,7 +4431,7 @@ static int check_stack_write_fixed_off(struct=
 bpf_verifier_env *env,
> > > >        * so it's aligned access and [off, off + size) are within st=
ack limits
> > > >        */
> > > >       if (!env->allow_ptr_leaks &&
> > > > -         state->stack[spi].slot_type[0] =3D=3D STACK_SPILL &&
> > > > +         is_spilled_reg(&state->stack[spi]) &&
> > > >           size !=3D BPF_REG_SIZE) {
> > > >               verbose(env, "attempt to corrupt spilled pointer on s=
tack\n");
> > > >               return -EACCES;
> > >
> > > I think there is a small detail here.
> > > slot_type[0] =3D=3D STACK_SPILL actually checks if a spill is 64-bit.
> >
> > Hm... I wonder if the check was written like this deliberately to
> > prevent turning any spilled register into STACK_MISC?
>
> idk, the error is about pointers and forbidding turning pointers to
> STACK_MISC makes sense. Don't see why it would be useful to forbid
> this for scalars.

you are correct that this check doesn't make sense for SCALAR_VALUE
register spill, I think the intent was to prevent pointer spills. But
that's an orthogonal issue, this could be improved separately.

>
> > > Thus, with this patch applied the test below does not pass.
> > > Log fragment:
> > >
> > >     1: (57) r0 &=3D 65535                   ; R0_w=3Dscalar(...,var_o=
ff=3D(0x0; 0xffff))
> > >     2: (63) *(u32 *)(r10 -8) =3D r0
> > >     3: R0_w=3Dscalar(...,var_off=3D(0x0; 0xffff)) R10=3Dfp0 fp-8=3Dmm=
mmscalar(...,var_off=3D(0x0; 0xffff))
> > >     3: (b7) r0 =3D 42                       ; R0_w=3D42
> > >     4: (63) *(u32 *)(r10 -4) =3D r0
> > >     attempt to corrupt spilled pointer on stack
> >
> > What would happen if we have
> >
> > 4: *(u16 *)(r10 - 8) =3D 123; ?
>
> w/o this patch:
>
>   0: (85) call bpf_get_prandom_u32#7    ; R0_w=3Dscalar()
>   1: (57) r0 &=3D 65535                   ; R0_w=3Dscalar(...,var_off=3D(=
0x0; 0xffff))
>   2: (63) *(u32 *)(r10 -8) =3D r0         ; R0_w=3Dscalar(...,var_off=3D(=
0x0; 0xffff))
>                                           R10=3Dfp0 fp-8=3Dmmmmscalar(...=
,var_off=3D(0x0; 0xffff))
>   3: (b7) r0 =3D 123                      ; R0_w=3D123
>   4: (6b) *(u16 *)(r10 -8) =3D r0         ; R0_w=3D123 R10=3Dfp0 fp-8=3Dm=
mmmmm123
>   5: (95) exit
>
> with this patch:
>
>   0: (85) call bpf_get_prandom_u32#7    ; R0_w=3Dscalar()
>   1: (57) r0 &=3D 65535                   ; R0_w=3Dscalar(...,var_off=3D(=
0x0; 0xffff))
>   2: (63) *(u32 *)(r10 -8) =3D r0         ; R0_w=3Dscalar(...,var_off=3D(=
0x0; 0xffff))
>                                           R10=3Dfp0 fp-8=3Dmmmmscalar(...=
,var_off=3D(0x0; 0xffff))
>   3: (b7) r0 =3D 123                      ; R0_w=3D123
>   4: (6b) *(u16 *)(r10 -8) =3D r0
>   attempt to corrupt spilled pointer on stack

ok, so SCALAR_VALUE aside, if it was some pointer, we should be
rejecting these writes

>
> > and similarly
> >
> > 4: *(u16 *)(r10 - 6) =3D 123; ?
>
> w/o this patch:
>
>   0: (85) call bpf_get_prandom_u32#7    ; R0_w=3Dscalar()
>   1: (57) r0 &=3D 65535                   ; R0_w=3Dscalar(...,var_off=3D(=
0x0; 0xffff))
>   2: (63) *(u32 *)(r10 -8) =3D r0         ; R0_w=3Dscalar(....,var_off=3D=
(0x0; 0xffff))
>                                           R10=3Dfp0 fp-8=3Dmmmmscalar(...=
,var_off=3D(0x0; 0xffff))
>   3: (b7) r0 =3D 123                      ; R0_w=3D123
>   4: (6b) *(u16 *)(r10 -6) =3D r0         ; R0_w=3D123 R10=3Dfp0 fp-8=3Dm=
mmmmmmm
>   5: (95) exit
>
> with this patch:
>
>   0: (85) call bpf_get_prandom_u32#7    ; R0_w=3Dscalar()
>   1: (57) r0 &=3D 65535                   ; R0_w=3Dscalar(...,var_off=3D(=
0x0; 0xffff))
>   2: (63) *(u32 *)(r10 -8) =3D r0         ; R0_w=3Dscalar(...,var_off=3D(=
0x0; 0xffff))
>                                           R10=3Dfp0 fp-8=3Dmmmmscalar(...=
,var_off=3D(0x0; 0xffff))
>   3: (b7) r0 =3D 123                      ; R0_w=3D123
>   4: (6b) *(u16 *)(r10 -6) =3D r0
>   attempt to corrupt spilled pointer on stack
>
> > So it makes me feel like the intent was to reject any partial writes
> > with spilled reg slots. We could probably improve that to just make
> > sure that we don't turn spilled pointers into STACK_MISC in unpriv,
> > but I'm not sure if it's worth doing that instead of keeping things
> > simple?
>
> You mean like below?
>
>         if (!env->allow_ptr_leaks &&
>             is_spilled_reg(&state->stack[spi]) &&
>             is_spillable_regtype(state->stack[spi].spilled_ptr.type) &&

Honestly, I wouldn't trust is_spillable_regtype() the way it's
written, it's too easy to forget to add a new register type to the
list. I think the only "safe to spill" register is probably
SCALAR_VALUE, so I'd just do `type !=3D SCALAR_VALUE`.

But yes, I think that's the right approach.

If we were being pedantic, though, we'd need to take into account
offset and see if [offset, offset + size) overlaps with any
STACK_SPILL/STACK_DYNPTR/STACK_ITER slots.

But tbh, given it's unpriv programs we are talking about, I probably
wouldn't bother extending this logic too much.

>             size !=3D BPF_REG_SIZE) {
>                 verbose(env, "attempt to corrupt spilled pointer on stack=
\n");
>                 return -EACCES;
>         }


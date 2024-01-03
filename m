Return-Path: <bpf+bounces-18967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E25E382394B
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 00:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492EA1F25F0F
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 23:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80AF1F926;
	Wed,  3 Jan 2024 23:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHdh+Sch"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD4F1F607
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 23:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5537114380bso8647856a12.3
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 15:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704325430; x=1704930230; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gFmseUsMI41Cam7iaRLO+MUeVdN/+Onq65eZGeGVN9k=;
        b=LHdh+SchcgGb8g+Fw5XwKaN/s7WTzuT3ZeL8nkCPCpJgkOIrw85oGoTcfRwzlYy/oZ
         BZlzYwJDiIdcdWktw293cfBA9u8iBCv62CAF/LSfMJuxXynwYlcWQUCI3IPiuXkjWXpr
         RmvWh3sjRAQc6n1rkP+Q0cBfZq+4jgCTuqrbNPrCeU3mR8dmIgqf5Fr8rekelovHQp39
         0FsCu38FGCzwiUiJ1aZhAFo2ANEwn4NrP0UQOgooRcStYPor4r50C06EpveCS8cW4RdV
         Pxiry5u0UH4GAGdMd6Hje6KcNc2OlZ/blX2UczlQRlZ9Dp9gQF1NC/BEVXo628hsoif7
         J5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704325430; x=1704930230;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gFmseUsMI41Cam7iaRLO+MUeVdN/+Onq65eZGeGVN9k=;
        b=xCslBgPp+n3Y4oXwWC/rn0CY/dluSj4ILMQaRgi3SNb4NoHvPHLWy8DaFVHxRkDTRN
         u7Ji9HlZqiKjjBOCI/zKZEYcYZ7PN4oaK84xtoWBy05SAtxSqTofOPR1JL34pNDTMlao
         UBFS5I4ws6M29n++LKdkkIqgPuA5+vPAHhv6K+jSXdMoizSM/3glS98Bi7/DDOfpNNZU
         bETY1QTAXWyY1xIk9hCgCSeKuK1bI9rRN5Lg/egQ8cmJN3g0rgoh3SLqvzedKpFR7VW1
         dNHvdUUW9kePrl0DCqdBcwDPRTiK9p7Li7Yi5ctoQ92lZtL8nDIPU0DZd5QKkppuCKSy
         VTwA==
X-Gm-Message-State: AOJu0Yzm0rR36ifoJr63xhK2ncO4woyMQK0gSX5lCLlbwkYW92aNFFP2
	HjQkYFA3PVyrHGTJ7NlJEMo=
X-Google-Smtp-Source: AGHT+IGBhUFRG4CVAJhBbzc3fz95f4adgqNiQ0fsUPiaFGmSr2r1KsGIYAzXtGdYiGmT3crXKkwCmg==
X-Received: by 2002:a50:8d5a:0:b0:555:b361:4791 with SMTP id t26-20020a508d5a000000b00555b3614791mr5117274edt.60.1704325429829;
        Wed, 03 Jan 2024 15:43:49 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id b10-20020a0564021f0a00b00552d45bd8e7sm17989995edb.77.2024.01.03.15.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 15:43:49 -0800 (PST)
Message-ID: <7746c6fa67e655b288e069b0c1d6393dc8c46502.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 8/9] libbpf: implement __arg_ctx fallback
 logic
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org,
 kernel-team@meta.com, Jiri Olsa <jolsa@kernel.org>
Date: Thu, 04 Jan 2024 01:43:48 +0200
In-Reply-To: <CAEf4BzaB_dOz8QmG9kGM7ViD=iM7P-a1GsMAMyyJhdf1W2Kwng@mail.gmail.com>
References: <20240102190055.1602698-1-andrii@kernel.org>
	 <20240102190055.1602698-9-andrii@kernel.org>
	 <75cad82e8e11b6049c99dcd2170fb445e2d3d2ee.camel@gmail.com>
	 <CAEf4BzaB_dOz8QmG9kGM7ViD=iM7P-a1GsMAMyyJhdf1W2Kwng@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=mQGNBGKNNQEBDACwcUNXZOGTzn4rr7Sd18SA5Wv0Wna/ONE0ZwZEx+sIjyGrPOIhR14/DsOr3ZJer9UJ/WAJwbxOBj6E5Y2iF7grehljNbLr/jMjzPJ+hJpfOEAb5xjCB8xIqDoric1WRcCaRB+tDSk7jcsIIiMish0diTK3qTdu4MB6i/sh4aeFs2nifkNi3LdBuk8Xnk+RJHRoKFJ+C+EoSmQPuDQIRaF9N2m4yO0eG36N8jLwvUXnZzGvHkphoQ9ztbRJp58oh6xT7uH62m98OHbsVgzYKvHyBu/IU2ku5kVG9pLrFp25xfD4YdlMMkJH6l+jk+cpY0cvMTS1b6/g+1fyPM+uzD8Wy+9LtZ4PHwLZX+t4ONb/48i5AKq/jSsb5HWdciLuKEwlMyFAihZamZpEj+9n91NLPX4n7XeThXHaEvaeVVl4hfW/1Qsao7l1YjU/NCHuLaDeH4U1P59bagjwo9d1n5/PESeuD4QJFNqW+zkmE4tmyTZ6bPV6T5xdDRHeiITGc00AEQEAAbQkRWR1YXJkIFppbmdlcm1hbiA8ZWRkeXo4N0BnbWFpbC5jb20+iQHUBBMBCgA+FiEEx+6LrjApQyqnXCYELgxleklgRAkFAmKNNQECGwMFCQPCZwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQLgxleklgRAlWZAv/cJ5v3zlEyP0/jMKQBqbVCCHTirPEw+nqxbkeSO6r2FUds0NnGA9a6NPOpBH+qW7a6+n6q3sIbvH7jlss4pzLI7LYlDC6z+egTv7KR5X1xFrY1uR5UGs1beAjnzYeV2hK4yqRUfygsT0Wk5e4FiNBv4+DUZ8r0cNDkO6swJxU55DO21mcteC147+4aDoHZ40R0tsAu+brDGSSoOPpb0RWVsEf9XOBJqWWA+T7mluw
 nYzhLWGcczc6J71q1Dje0l5vIPaSFOgwmWD4DA+WvuxM/shH4rtWeodbv iCTce6yYIygHgUAtJcHozAlgRrL0jz44cggBTcoeXp/atckXK546OugZPnl00J3qmm5uWAznU6T5YDv2vCvAMEbz69ib+kHtnOSBvR0Jb86UZZqSb4ATfwMOWe9htGTjKMb0QQOLK0mTcrk/TtymaG+T4Fsos0kgrxqjgfrxxEhYcVNW8v8HISmFGFbqsJmFbVtgk68BcU0wgF8oFxo7u+XYQDdKbI1uQGNBGKNNQEBDADbQIdo8L3sdSWGQtu+LnFqCZoAbYurZCmUjLV3df1b+sg+GJZvVTmMZnzDP/ADufcbjopBBjGTRAY4L76T2niu2EpjclMMM3mtrOc738Kr3+RvPjUupdkZ1ZEZaWpf4cZm+4wH5GUfyu5pmD5WXX2i1r9XaUjeVtebvbuXWmWI1ZDTfOkiz/6Z0GDSeQeEqx2PXYBcepU7S9UNWttDtiZ0+IH4DZcvyKPUcK3tOj4u8GvO3RnOrglERzNCM/WhVdG1+vgU9fXO83TB/PcfAsvxYSie7u792s/I+yA4XKKh82PSTvTzg2/4vEDGpI9yubkfXRkQN28w+HKF5qoRB8/L1ZW/brlXkNzA6SveJhCnH7aOF0Yezl6TfX27w1CW5Xmvfi7X33V/SPvo0tY1THrO1c+bOjt5F+2/K3tvejmXMS/I6URwa8n1e767y5ErFKyXAYRweE9zarEgpNZTuSIGNNAqK+SiLLXt51G7P30TVavIeB6s2lCt1QKt62ccLqUAEQEAAYkBvAQYAQoAJhYhBMfui64wKUMqp1wmBC4MZXpJYEQJBQJijTUBAhsMBQkDwmcAAAoJEC4MZXpJYEQJkRAMAKNvWVwtXm/WxWoiLnXyF2WGXKoDe5+itTLvBmKcV/b1OKZF1s90V7WfSBz712eFAynEzyeezPbwU8QBiTpZcHXwQni3IYKvsh7s
 t1iq+gsfnXbPz5AnS598ScZI1oP7OrPSFJkt/z4acEbOQDQs8aUqrd46PV jsdqGvKnXZxzylux29UTNby4jTlz9pNJM+wPrDRmGfchLDUmf6CffaUYCbu4FiId+9+dcTCDvxbABRy1C3OJ8QY7cxfJ+pEZW18fRJ0XCl/fiV/ecAOfB3HsqgTzAn555h0rkFgay0hAvMU/mAW/CFNSIxV397zm749ZNLA0L2dMy1AKuOqH+/B+/ImBfJMDjmdyJQ8WU/OFRuGLdqOd2oZrA1iuPIa+yUYyZkaZfz/emQwpIL1+Q4p1R/OplA4yc301AqruXXUcVDbEB+joHW3hy5FwK5t5OwTKatrSJBkydSF9zdXy98fYzGniRyRA65P0Ix/8J3BYB4edY2/w0Ip/mdYsYQljBY0A==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-03 at 15:10 -0800, Andrii Nakryiko wrote:
> On Wed, Jan 3, 2024 at 12:57=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Tue, 2024-01-02 at 11:00 -0800, Andrii Nakryiko wrote:
> >=20
> > [...]
> >=20
> > > +static int clone_func_btf_info(struct btf *btf, int orig_fn_id, stru=
ct bpf_program *prog)
> > > +{
> >=20
> > [...]
> >=20
> > > +     /* clone FUNC first, btf__add_func() enforces
> > > +      * non-empty name, so use entry program's name as
> > > +      * a placeholder, which we replace immediately
> > > +      */
> > > +     fn_id =3D btf__add_func(btf, prog->name, btf_func_linkage(fn_t)=
, fn_t->type);
> >=20
> > Nit: Why not call this function near the end, when fn_proto_id is avail=
able?
> >      Thus avoiding need to "guess" fn_t->type.
> >=20
>=20
> I think I did it to not have to remember btf_func_linkage(fn_t)
> (because fn_t will be invalidated) and because name_off will be reused
> for parameters. Neither is a big deal, I'll adjust to your suggestion.
>=20
> But note, we are not guessing ID, it's guaranteed to be +1, it's an
> API contract of btf__add_xxx() APIs.

Noted, well, maybe just skip this nit in such a case.

> > [...]
> >=20
> > > +static int bpf_program_fixup_func_info(struct bpf_object *obj, struc=
t bpf_program *prog)
> > > +{
> >=20
> > [...]
> >=20
> > > +     for (i =3D 1, n =3D btf__type_cnt(btf); i < n; i++) {
> >=20
> > [...]
> >=20
> > > +
> > > +             /* clone fn/fn_proto, unless we already did it for anot=
her arg */
> > > +             if (func_rec->type_id =3D=3D orig_fn_id) {
> > > +                     int fn_id;
> > > +
> > > +                     fn_id =3D clone_func_btf_info(btf, orig_fn_id, =
prog);
> > > +                     if (fn_id < 0) {
> > > +                             err =3D fn_id;
> > > +                             goto err_out;
> > > +                     }
> > > +
> > > +                     /* point func_info record to a cloned FUNC type=
 */
> > > +                     func_rec->type_id =3D fn_id;
> >=20
> > Would it be helpful to add a log here, saying that BTF for function
> > so and so is changed before load?
>=20
> Would it? We don't have global subprog's name readily available, it
> seems. So I'd need to refetch it by fn_id, then btf__str_by_offset()
> just to emit cryptic (for most users) notifications that something
> about some func info was adjusted. And then the user would get this
> same message for the same subprog but in the context of a different
> entry program. Just confusing, tbh.
>=20
> Unless you insist, I'd leave it as is. This logic is supposed to be
> bullet-proof, so I'm not worried about debugging regressions with it
> (but maybe I'm delusional).

I was thinking about someone finding out that actual in-kernel BTF
is different from that in the program object file, while debugging
something. Might be a bit surprising. I'm not insisting on this, though.

> > > +             }
> > > +
> > > +             /* create PTR -> STRUCT type chain to mark PTR_TO_CTX a=
rgument;
> > > +              * we do it just once per main BPF program, as all glob=
al
> > > +              * funcs share the same program type, so need only PTR =
->
> > > +              * STRUCT type chain
> > > +              */
> > > +             if (ptr_id =3D=3D 0) {
> > > +                     struct_id =3D btf__add_struct(btf, ctx_name, 0)=
;
> >=20
> > Nit: Maybe try looking up existing id for type ctx_name first?
>=20
> It didn't feel important and I didn't want to do another linear BTF
> search for each such argument. It's trivial to look it up, but I still
> feel like that's a waste... I tried to avoid many linear searches,
> which is why I structured the logic to do one pass over BTF to find
> all decl_tags instead of going over each function and arg and
> searching for decl_tag.
>
> Let's keep it as is, if there are any reasons to try to reuse struct
> (if it is at all present, which for kprobe, for example, is quite
> unlikely due to fancy bpf_user_pt_regs_t name), then we can easily add
> it with no regressions.

I was thinking about possible interaction with btf_struct_access(),
but that is not used to verify context access at the moment.
So, probably not important.


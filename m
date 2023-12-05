Return-Path: <bpf+bounces-16678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D6E8043A0
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 01:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84FB628148A
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 00:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768AC1113;
	Tue,  5 Dec 2023 00:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTPtJcu2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08AC102
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 16:54:56 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-54c1cd8d239so5784054a12.0
        for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 16:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701737695; x=1702342495; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kw1eCdjrEw9P4QpBBCJg6B0nvB8pqfXw5q3/rvpkXXc=;
        b=QTPtJcu2aIkYXy1a73lTWQDETJwvRfBFmCe2nEB/QCvkJeY7ZfNkWQFkWPPJwsJAUc
         nKQIY2zpY58zz5KuCXDmOwRUiFCy03dTBq7HV4zH6Ve4YHgPVCr1fyOTtampfOzFMmLR
         uRKx6hoCo82fChj9uiSVGFGCQmIUTSIhh+6W9/Z0d3sTe2eOgJo3OVNQWDwnZxrxkhkq
         rCvdXoJGqMFhdbiQk/Hn0hMBqJplm7C3OZ3fSy/FM2/Ci/rxFUenr5z2WNe2WQCDtP7t
         hyRym4GR158eXunmQQUQxZERURuLA966eAAS9wmkKj5Jaa57jU0wh5O1qFquoiMA0UKT
         vv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701737695; x=1702342495;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kw1eCdjrEw9P4QpBBCJg6B0nvB8pqfXw5q3/rvpkXXc=;
        b=v98OdZdBn2rKJfGKQXHosOnuyC4vWnNF3hwvzby0K+1E6Qy1aimpVtMFcwdcM5fZBN
         WHUbgluQ5u/Wd7XkcQD6ZvuhKmktd/qB9BiFxYFBv1sWkKycFOGLE2fCbmGZTH+TvbRr
         FGp13qxl5ZKxMEzyNFrWX+Ws+fCziY/7Qpr2odVZ72tncVWs2eVygdJzafguKblbXilT
         IhU957jmub2JMYLD1H8+n2t7eyvvgQGYLiDcKFVcPWj0yqQOivMAenEFya3LeOECo/yh
         OVbKfaa/C2ycFpVac6A79etBr+b/HTL2ZCwCtWKq7qXtywxMuN0z12CcwHaqZtnsQdAS
         ZUKg==
X-Gm-Message-State: AOJu0Yx0Hrd3HoW5oZV6YL8l17K994x2b6zBt1xGxxlP1tw5r/XVJvJo
	+SkEOkvmU9ftzgpg6T3rM5U=
X-Google-Smtp-Source: AGHT+IHO1oTKxss4nDIRg6lklKtS0NbIt/6dMSm6JWMGUhzFKubhC9sKFlI/VivilIw1vJohs3L4Ig==
X-Received: by 2002:a17:906:7e11:b0:a19:a1ba:badc with SMTP id e17-20020a1709067e1100b00a19a1babadcmr1310741ejr.130.1701737695158;
        Mon, 04 Dec 2023 16:54:55 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id lc6-20020a170906dfe600b009ad7fc17b2asm5869583ejc.224.2023.12.04.16.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 16:54:54 -0800 (PST)
Message-ID: <6875401e502049bfdfa128fc7bf37fabe5314e2f.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 03/10] bpf: fix check for attempt to corrupt
 spilled pointer
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov
	 <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Date: Tue, 05 Dec 2023 02:54:53 +0200
In-Reply-To: <CAEf4BzZ0Ao7EF4PodPBxTdQphEt-_ezZyNDOzqds2XfXYpjsHg@mail.gmail.com>
References: <20231204192601.2672497-1-andrii@kernel.org>
	 <20231204192601.2672497-4-andrii@kernel.org>
	 <3fca38fdfd975f735e3dd31930637cfbc70948f4.camel@gmail.com>
	 <CAEf4BzZ0Ao7EF4PodPBxTdQphEt-_ezZyNDOzqds2XfXYpjsHg@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-12-04 at 16:23 -0800, Andrii Nakryiko wrote:
[...]
> > > @@ -4431,7 +4431,7 @@ static int check_stack_write_fixed_off(struct b=
pf_verifier_env *env,
> > >        * so it's aligned access and [off, off + size) are within stac=
k limits
> > >        */
> > >       if (!env->allow_ptr_leaks &&
> > > -         state->stack[spi].slot_type[0] =3D=3D STACK_SPILL &&
> > > +         is_spilled_reg(&state->stack[spi]) &&
> > >           size !=3D BPF_REG_SIZE) {
> > >               verbose(env, "attempt to corrupt spilled pointer on sta=
ck\n");
> > >               return -EACCES;
> >=20
> > I think there is a small detail here.
> > slot_type[0] =3D=3D STACK_SPILL actually checks if a spill is 64-bit.
>=20
> Hm... I wonder if the check was written like this deliberately to
> prevent turning any spilled register into STACK_MISC?

idk, the error is about pointers and forbidding turning pointers to
STACK_MISC makes sense. Don't see why it would be useful to forbid
this for scalars.

> > Thus, with this patch applied the test below does not pass.
> > Log fragment:
> >=20
> >     1: (57) r0 &=3D 65535                   ; R0_w=3Dscalar(...,var_off=
=3D(0x0; 0xffff))
> >     2: (63) *(u32 *)(r10 -8) =3D r0
> >     3: R0_w=3Dscalar(...,var_off=3D(0x0; 0xffff)) R10=3Dfp0 fp-8=3Dmmmm=
scalar(...,var_off=3D(0x0; 0xffff))
> >     3: (b7) r0 =3D 42                       ; R0_w=3D42
> >     4: (63) *(u32 *)(r10 -4) =3D r0
> >     attempt to corrupt spilled pointer on stack
>=20
> What would happen if we have
>=20
> 4: *(u16 *)(r10 - 8) =3D 123; ?

w/o this patch:

  0: (85) call bpf_get_prandom_u32#7    ; R0_w=3Dscalar()
  1: (57) r0 &=3D 65535                   ; R0_w=3Dscalar(...,var_off=3D(0x=
0; 0xffff))
  2: (63) *(u32 *)(r10 -8) =3D r0         ; R0_w=3Dscalar(...,var_off=3D(0x=
0; 0xffff))=20
                                          R10=3Dfp0 fp-8=3Dmmmmscalar(...,v=
ar_off=3D(0x0; 0xffff))
  3: (b7) r0 =3D 123                      ; R0_w=3D123
  4: (6b) *(u16 *)(r10 -8) =3D r0         ; R0_w=3D123 R10=3Dfp0 fp-8=3Dmmm=
mmm123
  5: (95) exit

with this patch:

  0: (85) call bpf_get_prandom_u32#7    ; R0_w=3Dscalar()
  1: (57) r0 &=3D 65535                   ; R0_w=3Dscalar(...,var_off=3D(0x=
0; 0xffff))
  2: (63) *(u32 *)(r10 -8) =3D r0         ; R0_w=3Dscalar(...,var_off=3D(0x=
0; 0xffff))
                                          R10=3Dfp0 fp-8=3Dmmmmscalar(...,v=
ar_off=3D(0x0; 0xffff))
  3: (b7) r0 =3D 123                      ; R0_w=3D123
  4: (6b) *(u16 *)(r10 -8) =3D r0
  attempt to corrupt spilled pointer on stack

> and similarly
>=20
> 4: *(u16 *)(r10 - 6) =3D 123; ?

w/o this patch:

  0: (85) call bpf_get_prandom_u32#7    ; R0_w=3Dscalar()
  1: (57) r0 &=3D 65535                   ; R0_w=3Dscalar(...,var_off=3D(0x=
0; 0xffff))
  2: (63) *(u32 *)(r10 -8) =3D r0         ; R0_w=3Dscalar(....,var_off=3D(0=
x0; 0xffff))
                                          R10=3Dfp0 fp-8=3Dmmmmscalar(...,v=
ar_off=3D(0x0; 0xffff))
  3: (b7) r0 =3D 123                      ; R0_w=3D123
  4: (6b) *(u16 *)(r10 -6) =3D r0         ; R0_w=3D123 R10=3Dfp0 fp-8=3Dmmm=
mmmmm
  5: (95) exit

with this patch:

  0: (85) call bpf_get_prandom_u32#7    ; R0_w=3Dscalar()
  1: (57) r0 &=3D 65535                   ; R0_w=3Dscalar(...,var_off=3D(0x=
0; 0xffff))
  2: (63) *(u32 *)(r10 -8) =3D r0         ; R0_w=3Dscalar(...,var_off=3D(0x=
0; 0xffff))
                                          R10=3Dfp0 fp-8=3Dmmmmscalar(...,v=
ar_off=3D(0x0; 0xffff))
  3: (b7) r0 =3D 123                      ; R0_w=3D123
  4: (6b) *(u16 *)(r10 -6) =3D r0
  attempt to corrupt spilled pointer on stack

> So it makes me feel like the intent was to reject any partial writes
> with spilled reg slots. We could probably improve that to just make
> sure that we don't turn spilled pointers into STACK_MISC in unpriv,
> but I'm not sure if it's worth doing that instead of keeping things
> simple?

You mean like below?

	if (!env->allow_ptr_leaks &&
	    is_spilled_reg(&state->stack[spi]) &&
	    is_spillable_regtype(state->stack[spi].spilled_ptr.type) &&
	    size !=3D BPF_REG_SIZE) {
		verbose(env, "attempt to corrupt spilled pointer on stack\n");
		return -EACCES;
	}


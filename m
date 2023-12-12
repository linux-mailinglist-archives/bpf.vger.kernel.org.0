Return-Path: <bpf+bounces-17620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F62480FB73
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 00:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94DA280D97
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 23:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D2264CFC;
	Tue, 12 Dec 2023 23:36:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06491B3
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 15:36:00 -0800 (PST)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7b701b75f36so241923039f.0
        for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 15:35:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702424159; x=1703028959;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymPHhcBF1wsZe4p4v1rwmGltvI+HZcU+L7hvSk0h4nE=;
        b=sUAbxe8+fHfLxD/HQhJecq1A104FKVzvb6PrNsT5+sHeA7wOHWc79kvWbjtrXMb2A5
         tI0rzmjUqpNwaHcGdok8XxwyUok3HqI+xZuuQ6TNx93T+caO7+TGQszIEHbaR68eu2RY
         vA4hKc1KHNKqiVZjlLSyXPtT1kocKAu5bsKsu6yn1IzzELquah84c3Dr9I15bNr16KwU
         ZIIRIoXgL8k6cZcf24blUyQGO0ZVafRcqcc+zVRfUOZe1e2eBZnQt2HV9gUrdV9NDZo3
         JjWO60SztEsIIag/69chRZVsk/tciUyF+0rC7ENtV0h4tLbKEcaNcOELaAOfIGqRKbco
         rEDw==
X-Gm-Message-State: AOJu0Yygs3pk3Nv8zhRQ9+5UKa2r7eD0vQAuJA1ybtv1NGyVKyd9cIsh
	Hgdgu5htdsusQvvjGS8x+L4=
X-Google-Smtp-Source: AGHT+IHPwI5kUfJFxCy8ChXVz7btz9wgCy8lumZEv0KgndNmAbO+cAiqcF+jPWsXNriPuS9eSwuU3A==
X-Received: by 2002:a6b:fe09:0:b0:7b3:8dae:6564 with SMTP id x9-20020a6bfe09000000b007b38dae6564mr8587767ioh.13.1702424159147;
        Tue, 12 Dec 2023 15:35:59 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id i21-20020a02cc55000000b004667006c370sm2566062jaq.76.2023.12.12.15.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 15:35:58 -0800 (PST)
Date: Tue, 12 Dec 2023 17:35:55 -0600
From: David Vernet <void@manifault.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Dave Thaler <dthaler1968@googlemail.com>, bpf@ietf.org,
	bpf <bpf@vger.kernel.org>, kuba@kernel.org
Subject: Re: [Bpf] BPF ISA conformance groups
Message-ID: <20231212233555.GA53579@maniforge>
References: <20231127201817.GB5421@maniforge>
 <072101da2558$fe5f5020$fb1df060$@gmail.com>
 <20231207215152.GA168514@maniforge>
 <CAADnVQ+Mhe6ean6J3vH1ugTyrgWNxupLoFfwKu6-U=3R8i1TNQ@mail.gmail.com>
 <20231212214532.GB1222@maniforge>
 <157b01da2d46$b7453e20$25cfba60$@gmail.com>
 <CAADnVQKd7X1v6CwCa2MyJjQkN8hKsHJ_g9Kk5CwWSbp9+1_3zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ex4QMkwi14/3Eoji"
Content-Disposition: inline
In-Reply-To: <CAADnVQKd7X1v6CwCa2MyJjQkN8hKsHJ_g9Kk5CwWSbp9+1_3zw@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--Ex4QMkwi14/3Eoji
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 02:55:19PM -0800, Alexei Starovoitov wrote:
> On Tue, Dec 12, 2023 at 2:01=E2=80=AFPM <dthaler1968@googlemail.com> wrot=
e:
> >
> > > > For example, let's take a look at #2 atomic...
> > > > Should it include or exclude atomic_add insn ? It was added at the
> > > > very beginning of BPF ISA and was used from day one.
> > > > Without it it's impossible to count stats. The typical network or
> > > > tracing use case needs to count events and one cannot do it without
> > > > atomic increment. Eventually per-cpu maps were added as an alternat=
ive.
> > > > I suspect any platform that supports #1 basic insn without atomic_a=
dd
> > > > will not be practically useful.
> > > > Should atomic_add be a part of "basic" then? But it's atomic.
> > > > Then what about atomic_fetch_add insn? It's pretty close semantical=
ly.
> > > > Part of atomic or part of basic?
> > >
> > > I think it's reasonable to expect that if you require an atomic add, =
that you
> > > may also require the other atomic instructions as well and that it wo=
uld be
> > > logical to group them together, yes. I believe that Netronome support=
s all of
> > > the atomic instructions, as one example. If you're providing a BPF ru=
ntime in
> > > an environment where atomic adds are required, I think it stands to r=
eason
> > > that you should probably support the other atomics as well, no?
> >
> > I agree.
>=20
> Your logical reasoning is indeed correct and
> I agree with it,
> but reality is different :)
>=20
> drivers/net/ethernet/netronome/nfp/bpf/jit.c:
> static int mem_atomic8(struct nfp_prog *nfp_prog, struct nfp_insn_meta *m=
eta)
> {
>         if (meta->insn.imm !=3D BPF_ADD)
>                 return -EOPNOTSUPP;
>=20
>         return mem_xadd(nfp_prog, meta, true);
> }
>=20
> It only supports atomic_add and no other atomics.

Ahh, I misunderstood when I discussed with Kuba. I guess they supported
only atomic_add because packets can be delivered out of order. So fair
enough on that point, but I still stand by the claim though that if you
need one type of atomic, it's reasonable to infer that you may need all
of them. I would be curious to hear how much work it would have been to
add support for the others. If there was an atomic conformance group,
maybe they would have.

> > > > Another example, #3 divide. bpf cpu=3Dv1 ISA only has unsigned div/=
mod.
> > > > Eventually we added a signed version. Integer division is one of the
> > > > slowest operations in a HW. Different cpus have different flavors of
> > > > them 64/32 64/64 32/32, etc. All with different quirks.
> > > > cpu=3Dv1 had modulo insn because in tracing one often needs to do i=
t to
> > > > select a slot in a table, but in networking there is rarely a need.
> > > > So bpf offload into netronome HW doesn't support it (iirc).
> > >
> > > Correct, my understanding is that BPF offload in netronome supports n=
either
> > > division nor modulo.
> >
> > In my opinion, this is a valid technical reason to put them into a sepa=
rate
> > conformance group, to allow hardware offload cards to support BPF witho=
ut
> > requiring division/modulo which they might not have space or other budg=
et for.
>=20
> Also logically correct and I agree with, but reality proves all of us wro=
ng.
> netronome doesn't support modulo,
> but it supports integer division when the verifier can determine
> property of the constant.
> BPF_ALU64 | BPF_DIV | BPF_K works for positive imm32,
> but BPF_X works when the verifier is smart with plenty of quirks
> and subtle conditions.
> It works with the help of cool math reciprocal_value_adv()
> in include/linux/reciprocal_div.h
> which converts div to shifts and muls.
>=20
> So should div_K and div_X be in separate groups ?
> Should mod_[K|X] be there as well or not?

Also fair enough r.e. the positive imm32 division. I clearly should have
read the netronome jit code. For devices I do agree with you that it's
questionable whether whether compliance is realistic. But I think we
just don't _really_ know at this point. And regardless, I do think
there's value in providing some kind of structure to inform what classes
of instructions should typically be provided when possible. I also
wonder whether we need to consider the cost calculus for whether they
would bother to support certain instructions if there was a conformance
group. To the atomic point above, I would be surprised if it would have
been hugely difficult to add support for the others for Netronome.

Also, I don't think we should only be looking at Netronome as the
canonical example here. From my understanding, while there's still quite
a bit of work to be done, a lot of Cilium progs can run on both Windows
and Linux.

> To determine the grouping should we use logic or reality?

Let's bear in mind that "reality" in the context of this conversation is
a single vendor. Part of the goal of the standard is to implement
something that has broad applicability. So while reality is of course
very relevant, I think we should also apply some degree of logic to
inform future implementations.

> I'm arguing that whatever clean and logical grouping we can come up with
> it won't stand a test of real use.

Well, maybe not for Netronome, or maybe not even for any vendor (though
we have no way of knowing that yet), but what about for other contexts
like Windows / Linux cross-platform compat?

The answer might be "no", but to go back to my previous message, if
we're going to get rid of conformance groups I think we should at least
be explicit that we're doing so because we don't think compliance is a
realistic goal in general.

--Ex4QMkwi14/3Eoji
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZXjuWwAKCRBZ5LhpZcTz
ZGN7AQC+X+8QEYqVUyLrDan287VCCUPSpCSxM0OpKgqp9A30nwD+M1nC1GuQsrco
eQa0xG/dxA+eFcBRCqgKJ6+G4wLy8gM=
=t5Ao
-----END PGP SIGNATURE-----

--Ex4QMkwi14/3Eoji--


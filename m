Return-Path: <bpf+bounces-17591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A83180F9A5
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 22:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 825B0B20F1E
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 21:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E607D64157;
	Tue, 12 Dec 2023 21:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="vX6L9WVF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="vX6L9WVF"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2D6F5
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 13:45:45 -0800 (PST)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 8E9AFC14CEFA
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 13:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1702417545; bh=o0sFYr5+HF2h5DDXW/4SWnYT1zOS+awx9rAwmMnule4=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=vX6L9WVFu9cqNKcHXDziDUEeTqRiVr+sEyEIut0HIv0mreZCQ+IVq5jup/BYQDbVl
	 HBhob19Wsb3nT/9y69W9j1pcIMg5QZ7SZJUIUWgb1eXcoAioc7Du8yPB/UzsmcSX4p
	 00fI/M9pee9Wfe2sc/9jIOyHZ01IgFsfp+Zghj6A=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue Dec 12 13:45:45 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 57CF1C14F5E8;
	Tue, 12 Dec 2023 13:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1702417545; bh=o0sFYr5+HF2h5DDXW/4SWnYT1zOS+awx9rAwmMnule4=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=vX6L9WVFu9cqNKcHXDziDUEeTqRiVr+sEyEIut0HIv0mreZCQ+IVq5jup/BYQDbVl
	 HBhob19Wsb3nT/9y69W9j1pcIMg5QZ7SZJUIUWgb1eXcoAioc7Du8yPB/UzsmcSX4p
	 00fI/M9pee9Wfe2sc/9jIOyHZ01IgFsfp+Zghj6A=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id DB4AFC14F5E7
 for <bpf@ietfa.amsl.com>; Tue, 12 Dec 2023 13:45:43 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.41
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kGUg7h3Is8tl for <bpf@ietfa.amsl.com>;
 Tue, 12 Dec 2023 13:45:38 -0800 (PST)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com
 [209.85.166.42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 685FFC14F5E8
 for <bpf@ietf.org>; Tue, 12 Dec 2023 13:45:38 -0800 (PST)
Received: by mail-io1-f42.google.com with SMTP id
 ca18e2360f4ac-7b6f4ee4f7fso135816239f.0
 for <bpf@ietf.org>; Tue, 12 Dec 2023 13:45:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702417537; x=1703022337;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VS83luOGitsp3r2Z6sGllTAWgV1LVpAdkBAgBngyo2A=;
 b=o73tuoGhYXXj8c0LK8ioQAk3iVX1wyuBMOf2QIEm6Gid0mOSxa2UnM2ywDMAmkTvUX
 ggvkgloVKAC+oT6WjOHM/liChxfYSNop5CP+rwvuvfAfYVzpWpsdrLwW+pStKvYLqvGq
 ZBGM0qQHIw6Ou+Y6JAJbvEq57Xf+YsewFBz8tV8Lz5inKLgdWIaedRatLu9DFUlwe72x
 i42mN/F+ePCMo6vNScKJGeIk9LIereTkkpy9y6rRCW0pd0pr0fohg+5LO3dtTobPA3Gu
 jl9nJ/xUgqbz23KJZTnhnB6bn988/DCpN0FzY6LsG731lpB/0J0vF/oTohOIvq5OhtKb
 LacQ==
X-Gm-Message-State: AOJu0Yz7840AyiWw/p+mL6b8Z3yy9Ltww6L4AOxYGksKsTcwUWYJsmip
 /Bua+4WXoYLI6CYbop6mUuM=
X-Google-Smtp-Source: AGHT+IGu+MNaoHk4rcVTO3hjdY08emI06kSOptIvICDV4cDfea38ltSKT6DPftEFt7Daw2imh0JSmA==
X-Received: by 2002:a05:6e02:1b06:b0:35d:59b3:2f87 with SMTP id
 i6-20020a056e021b0600b0035d59b32f87mr5786068ilv.28.1702417537375; 
 Tue, 12 Dec 2023 13:45:37 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
 by smtp.gmail.com with ESMTPSA id
 cx8-20020a056638490800b0042ad6abe0bbsm2673632jab.20.2023.12.12.13.45.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 13:45:36 -0800 (PST)
Date: Tue, 12 Dec 2023 15:45:32 -0600
From: David Vernet <void@manifault.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>,
 Christoph Hellwig <hch@infradead.org>, bpf@ietf.org,
 bpf <bpf@vger.kernel.org>
Message-ID: <20231212214532.GB1222@maniforge>
References: <20231127201817.GB5421@maniforge>
 <072101da2558$fe5f5020$fb1df060$@gmail.com>
 <20231207215152.GA168514@maniforge>
 <CAADnVQ+Mhe6ean6J3vH1ugTyrgWNxupLoFfwKu6-U=3R8i1TNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQ+Mhe6ean6J3vH1ugTyrgWNxupLoFfwKu6-U=3R8i1TNQ@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/5iZDs9eFzHCUT4c0E1BHkdIuptM>
Subject: Re: [Bpf] BPF ISA conformance groups
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============0363569721652768178=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


--===============0363569721652768178==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4gnRPP6CbWQ6hhXY"
Content-Disposition: inline


--4gnRPP6CbWQ6hhXY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 09, 2023 at 07:10:33PM -0800, Alexei Starovoitov wrote:
> On Thu, Dec 7, 2023 at 1:51=E2=80=AFPM David Vernet <void@manifault.com> =
wrote:
> >
> > On Sat, Dec 02, 2023 at 11:51:50AM -0800, dthaler1968=3D40googlemail.co=
m@dmarc.ietf.org wrote:
> > > >From David Vernet's WG summary:
> > > > After this update, the discussion moved to a topic for the BPF ISA
> > > document that has yet to be resolved:
> > > > ISA RFC compliance. Dave pointed out that we still need to specify =
which
> > > instructions in the ISA are
> > > > MUST, SHOULD, etc, to ensure interoperability.  Several different o=
ptions
> > > were presented, including
> > > >  having individual-instruction granularity, following the clang CPU
> > > versioning convention, and grouping
> > > > instructions by logical functionality.
> > > >
> > > > We did not obtain consensus at the conference on which was the best=
 way
> > > forward. Some of the points raised include the following:
> > > >
> > > > - Following the clang CPU versioning labels is somewhat arbitrary. =
It
> > > >   may not be appropriate to standardize around grouping that is a r=
esult
> > > >   of largely organic historical artifacts.
> > > > - If we decide to do logical grouping, there is a danger of
> > > >   bikeshedding. Looking at anecdotes from industry, some vendors su=
ch as
> > > >   Netronome elected to not support particular instructions for
> > > >   performance reasons.
> > >
> > > My sense of the feedback in general was to group instructions by logi=
cal
> > > functionality, and only create separate
> > > conformance groups where there is some legitimate technical reason th=
at a
> > > runtime might not want to support
> > > a given set of instructions.  Based on discussion during the meeting,=
 here's
> > > a strawman set of conformance
> > > groups to kick off discussion.  I've tried to use short (like 6 chara=
cters
> > > or fewer) names for ease of display in
> > > document tables, and potentially in command line options to tools tha=
t might
> > > want to use them.
> > >
> > > A given runtime platform would be compliant to some set of the follow=
ing
> > > conformance groups:
> > >
> > > 1. "basic": all instructions not covered by another group below.
> > > 2. "atomic": all Atomic operations.  I think Christoph argued for thi=
s one
> > > in the meeting.
> > > 3. "divide": all division and modulo operations.  Alexei said in the =
meeting
> > > that he'd heard demand for this one.
> > > 4. "legacy": all legacy packet access instructions (deprecated).
> > > 5. "map": 64-bit immediate instructions that deal with map fds or map
> > > indices.
> > > 6. "code": 64-bit immediate instruction that has a "code pointer" typ=
e.
> > > 7. "func": program-local functions.
> >
> > I thought for a while about whether this should be part of the basic
> > conformance group, and talked through it with Jakub Kicinski. I do think
> > it makes sense to keep it separate like this. For e.g. devices with
> > Harvard architectures, it could get quite non-trivial for the verifier
> > to determine whether accesses to arguments stored in special register
> > are safe. Definitely not impossible, and overall very useful to support
> > this, but in order to ease vendor adoption it's probably best to keep
> > this separate.
> >
> > > Things that I *think* don't need a separate conformance group (can ju=
st be
> > > in "basic") include:
> > > a. Call helper function by address or BTF ID.  A runtime that doesn't
> > > support these simply won't expose any
> > >     such helper functions to BPF programs.
> > > b. Platform variable instructions (dst =3D var_addr(imm)).  A runtime=
 that
> > > doesn't support this simply won't
> > >     expose any platform variables to BPF programs.
> > >
> > > Comments? (Let the bikeshedding begin...)
> >
> > This list seems logical to me,
>=20
> I think we should do just two categories: legacy and the rest,
> since any scheme will be flawed and infinite bikeshedding will ensue.

If we do this, then aren't we forcing every vendor that adds BPF support
to support every single instruction if they want to be compliant?

> For example, let's take a look at #2 atomic...
> Should it include or exclude atomic_add insn ? It was added
> at the very beginning of BPF ISA and was used from day one.
> Without it it's impossible to count stats. The typical network or
> tracing use case needs to count events and one cannot do it without
> atomic increment. Eventually per-cpu maps were added as an alternative.
> I suspect any platform that supports #1 basic insn without
> atomic_add will not be practically useful.
> Should atomic_add be a part of "basic" then? But it's atomic.
> Then what about atomic_fetch_add insn? It's pretty close semantically.
> Part of atomic or part of basic?

I think it's reasonable to expect that if you require an atomic add,
that you may also require the other atomic instructions as well and that
it would be logical to group them together, yes. I believe that
Netronome supports all of the atomic instructions, as one example. If
you're providing a BPF runtime in an environment where atomic adds are
required, I think it stands to reason that you should probably support
the other atomics as well, no?

> Another example, #3 divide. bpf cpu=3Dv1 ISA only has unsigned div/mod.
> Eventually we added a signed version. Integer division is one of the
> slowest operations in a HW. Different cpus have different flavors
> of them 64/32 64/64 32/32, etc. All with different quirks.
> cpu=3Dv1 had modulo insn because in tracing one often needs to do it
> to select a slot in a table, but in networking there is rarely a need.
> So bpf offload into netronome HW doesn't support it (iirc).

Correct, my understanding is that BPF offload in netronome supports
neither division nor modulo.

> Should div/mod signed/unsigned be a part of basic? or separate?
> Only 32 or 64 bit?
>=20
> Hence my point: legacy and the rest (as of cpu=3Dv4) are the only two cat=
egories
> we should have in _this_ version of the standard.
> Rest assured we will add new insn in the coming months.
> I suggest we figure out conformance groups for future insns at that time.
> That would be the time to argue and actually extract value out of discuss=
ion.
> Retroactive bike shedding is a bike shedding and nothing else.

I wouldn't personally categorize this as retroactive _bikeshedding_.
What we're trying to do is retroactive _grouping_, and I think what
you're really arguing for is that grouping in general isn't necessary.
So I think we should maybe take a step back and talk about what value it
brings at a higher level to determine if the complexity / ambiguity of
grouping is worth the benefit.

=46rom my perspective, the reason that we want conformance groups is
purely for compliance and cross compatibility. If someone has a BPF
program that does some class of operations, then conformance groups
inform them about whether their prog will be able to run on some vendor
implementation of BPF.  For example, if you're doing network packet
filtering and doing some atomics, hashing, etc on a Netronome NIC, you'd
like for it to be able to run on other NICs that implement offload as
well. If a NIC isn't compliant with the atomics group, it won't be able
to support your prog.

If we don't have conformance groups, I don't see how we can provide that
guarantee. I think there's essentially a 0% chance that vendors will
implement every instruction; nor should they have to. So if we just do
"legacy" and "other", the grouping won't really tell a vendor or BPF
developer anything other than what instructions are completely useless
and should be avoided.

If we want to get rid of conformance groups that's fine and I do think
there's an argument for it, but I think we need to discuss this in terms
of compliance and not the grouping aspect.

FWIW, my perspective is that we should be aiming to enable compliance.
I don't see any reason why a BPF prog that's offloaded to a NIC to do
packet filtering shouldn't be able to e.g. run on multiple devices.
That certainly won't be the case for every type of BPF program, but
classifying groups of instructions does seem prudent.

--4gnRPP6CbWQ6hhXY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZXjUfAAKCRBZ5LhpZcTz
ZPVjAQDcCdsM4Zc8Ic8NCNF0RiOuzUHYaguyrnuEi6VvU2hdjgEAz1PSehOByslU
eclTiTbOCRM0Zx9+8iOdej9pcOtd6gE=
=t7cS
-----END PGP SIGNATURE-----

--4gnRPP6CbWQ6hhXY--


--===============0363569721652768178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============0363569721652768178==--



Return-Path: <bpf+bounces-17590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CB580F9A3
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 22:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF6A0282186
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 21:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87BD64155;
	Tue, 12 Dec 2023 21:45:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C61AB
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 13:45:38 -0800 (PST)
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7b6f4ee4f7fso135816339f.0
        for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 13:45:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702417537; x=1703022337;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VS83luOGitsp3r2Z6sGllTAWgV1LVpAdkBAgBngyo2A=;
        b=u2D/XP8/3z6boBwYidS0sWXzceasEFPstCOEZkEtawp9yYk/41EuDfxxHfdvC2uDX0
         2LhFLaDrUW0pOs5l5M/WnngmCs03wvkU1M0wvlHhRZoO4R7tHCqzXfk3EaaG5DFdelpx
         Mzo6jKSvW/Xwhilue0IOccFklxJ3VEiSUkGFCnj/tSyOopptPP4taqSSDqfczp3t3QDx
         9K7UK6QcyIAh0gUKxuL8EFR48m7DxPRmp0eSuCm4FN24UGQP0asVay9HglMFWWZZh63P
         eK751ookZbrOj4F+BJuXZ1+c2lLVH+gcX9snhxjxo8S6WNMe2R6y8fDw0yHrpqba1GRi
         3Fuw==
X-Gm-Message-State: AOJu0YzLe6N+n0hiVNlTVFeHmi6NNS0KNptc8pQJBC2WtQhmxbr+Aabj
	M4V6tdDqPFiPTnfuJGdUA6UJNO/nPd4k9w==
X-Google-Smtp-Source: AGHT+IGu+MNaoHk4rcVTO3hjdY08emI06kSOptIvICDV4cDfea38ltSKT6DPftEFt7Daw2imh0JSmA==
X-Received: by 2002:a05:6e02:1b06:b0:35d:59b3:2f87 with SMTP id i6-20020a056e021b0600b0035d59b32f87mr5786068ilv.28.1702417537375;
        Tue, 12 Dec 2023 13:45:37 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id cx8-20020a056638490800b0042ad6abe0bbsm2673632jab.20.2023.12.12.13.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 13:45:36 -0800 (PST)
Date: Tue, 12 Dec 2023 15:45:32 -0600
From: David Vernet <void@manifault.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>,
	Christoph Hellwig <hch@infradead.org>, bpf@ietf.org,
	bpf <bpf@vger.kernel.org>
Subject: Re: [Bpf] BPF ISA conformance groups
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
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4gnRPP6CbWQ6hhXY"
Content-Disposition: inline
In-Reply-To: <CAADnVQ+Mhe6ean6J3vH1ugTyrgWNxupLoFfwKu6-U=3R8i1TNQ@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


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


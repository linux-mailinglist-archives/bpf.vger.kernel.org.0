Return-Path: <bpf+bounces-17867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3B7813906
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 18:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC9081C20DF8
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 17:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE642675CF;
	Thu, 14 Dec 2023 17:44:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5849CF
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 09:44:40 -0800 (PST)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7b79a23a075so21580039f.2
        for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 09:44:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702575880; x=1703180680;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwOJSwoOAETLG1CfVjsu4xlvZ4N/JEMZJRthIWFpdFA=;
        b=NqjGwaF2iBLiDSdMX/hPb8JI4vF9Jgv9vF1hXl5kbYyx7Mx25UydYf/if446OcQ69S
         d1aW3wbNGISedJaBECeSytawREO3xmSHjIZK4L1pftPeFJZJq2Q/phbZ8+2tRWYgQC0z
         WDuqSSQwXY2jGgZ/f8piR84F/N8DFFCsIPbf2zPSB9rdBvjolh5uPNx32DcKmL9DfsYa
         T3fF6+vQe7ogr02Cz+bBftzlNKTGmBSopEWjHVCVgihVlVnQi+wnPD7tfJR6h+0G8epj
         F1YKkwjbs2oU1cYWYF096H0SWGSb1QLPjfUmTcNYBgtrBMHHk9F6Y0dDNseTS67/2iFl
         XdpA==
X-Gm-Message-State: AOJu0YwrObO/PzhUP+t0UwwzMNU2fpiZIYSeHfTdp8XHyP4phQPi/riX
	B35ityhxCD6cFJfe9ztWHqU=
X-Google-Smtp-Source: AGHT+IEJ9ylaSdQqiLXKm3svLAs9z0lIgzQUDjNyKk9ELF+rfrkRkhw/nwi25m7cFHxvOLwgF3xhEA==
X-Received: by 2002:a05:6602:2be4:b0:7b3:942e:2df9 with SMTP id d4-20020a0566022be400b007b3942e2df9mr11353648ioy.6.1702575879744;
        Thu, 14 Dec 2023 09:44:39 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id gj2-20020a0566386a0200b004665ce094c4sm3589710jab.161.2023.12.14.09.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 09:44:39 -0800 (PST)
Date: Thu, 14 Dec 2023 11:44:37 -0600
From: David Vernet <void@manifault.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Dave Thaler <dthaler1968@googlemail.com>, bpf@ietf.org,
	bpf <bpf@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [Bpf] BPF ISA conformance groups
Message-ID: <20231214174437.GA2853@maniforge>
References: <072101da2558$fe5f5020$fb1df060$@gmail.com>
 <20231207215152.GA168514@maniforge>
 <CAADnVQ+Mhe6ean6J3vH1ugTyrgWNxupLoFfwKu6-U=3R8i1TNQ@mail.gmail.com>
 <20231212214532.GB1222@maniforge>
 <157b01da2d46$b7453e20$25cfba60$@gmail.com>
 <CAADnVQKd7X1v6CwCa2MyJjQkN8hKsHJ_g9Kk5CwWSbp9+1_3zw@mail.gmail.com>
 <20231212233555.GA53579@maniforge>
 <CAADnVQJ-JwNTY5fW-oXdTur9aDrv2NQoreTH3yYZemVBVtq9fQ@mail.gmail.com>
 <20231213185603.GA1968@maniforge>
 <CAADnVQLOjByUKJNyLdvDzwuegtjZFwrttHft_1o8BoyDCXQvDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="V4Dp/zrCXmcyzI53"
Content-Disposition: inline
In-Reply-To: <CAADnVQLOjByUKJNyLdvDzwuegtjZFwrttHft_1o8BoyDCXQvDQ@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--V4Dp/zrCXmcyzI53
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 04:12:28PM -0800, Alexei Starovoitov wrote:
> On Wed, Dec 13, 2023 at 10:56=E2=80=AFAM David Vernet <void@manifault.com=
> wrote:
> >
> > Something I want to make sure is clearly spelled out: are you of the
> > opinion that a program written for offload to a Netronome device cannot
> > and should not ever be able to run on any other NIC with BPF offload?
>=20
> It's certainly fine for vendors to try to replicate Netronome offload.
> The point is that it was done before any standard existed.
> If we add compliance groups to the standard now they won't fit
> netronome and won't help anyone trying to be compatible with it.
> See the point about compatibility with -mcpu=3Dv3 and not v1.

It's unfortunate that it would make Netronome non-compliant, but I think
we should be looking more at what makes sense for future implementations
when it comes to the standard. The claim is that future devices which
are compliant would be able to have replicated offload implementations.

> > Why else would they be asking for a standard if not to
> > have some guidelines of what to implement?
>=20
> Excellent question. I don't know why nvme folks need a standard.
> Lack of standard didn't stop netronome.

Christoph? Any chance you can shed some light here?

> > How do we know the semantics of the instructions won't be prohibitively
> > expensive or impractical for certain vendors? What value do we get out
> > of dictating semantics in the standard if we're not expecting any of
> > these programs to be cross-compatible anyways?
>=20
> and that's a problem. hw folks are not participating in this discussion.
> Without implementers there is little chance to have successful guidelines
> for compatibility levels.
> per-instruction compatibility is already accomplished.
> We don't need groups for that.

I definitely agree that it would be nice to have hw folks included in
these discussions. What I don't quite understand though is why it would
be necessary to have them included in the discussion to decide on
conformance groups, but not on instruction semantics.

> > > "Here is a standard. Go implement it" won't work.
> >
> > What is the point of a standard if not to say, "Here's what you should
> > go implement"?
>=20
> Rephrasing... "go implement it _all_" won't work.
> The standard has value without insn groups.
> Every instruction has specific meaning and encoding.
> That's what compatibility is about. Both sw and hw need to
> perform that operation.

I agree that there's value in instructions having specific meaning and
encodings, but my worry is that (for device offload) the value would be
minimized quite a bit if a developer writing a BPF offload program
doesn't also have some knowledge or guarantee of what instructions
vendors have actually implemented.

If we were to do away with conformance groups, then I as a BPF user
would have the guarantee: "Any hw device which happens to implement the
instructions in my program will behave in a predictable way". If that
user doesn't know what instructions it can count on being actually
available in devices, then they're going to end up just implementing the
program for a single device anyways. At that point, how useful was it
really to standardize on the semantics of the instructions? That user
just as soon could have read the specifications for the device and
implemented the prog according to the semantics that the vendor decided
were most appropriate for them.

That said, I definitely agree that there's value in standardizing the
semantics for _software_, because as you said, software can eventually
just be fully compliant. What's less clear to me is how useful it is for
device offload without conformance groups.

--V4Dp/zrCXmcyzI53
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZXs/BQAKCRBZ5LhpZcTz
ZC7/AP4oOsdUExch1h8gRtFLYWu5ZninBXad7des4ajkmg9xUAEAqnxMKE7bP+mw
ZP+ZBM4R/5hZgi22NjptMEmSMejceQU=
=ZElZ
-----END PGP SIGNATURE-----

--V4Dp/zrCXmcyzI53--


Return-Path: <bpf+bounces-17705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C77811D9A
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 19:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55B641F21D57
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 18:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD4B6168F;
	Wed, 13 Dec 2023 18:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="xel4TzAk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="xel4TzAk"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E05B0
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 10:56:10 -0800 (PST)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 6731CC14CE2C
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 10:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1702493770; bh=RQdHgpDowI36C4AQcltYzAjihzg02+OM/LSjgZfHKi8=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=xel4TzAkGH/D5wHkurYA9o4qTBDaUW60YaoHSTYgr6vnyZM1m4sBATUTd3skTMTwm
	 c/JQn7mtrBEMfMNUt3xAxam1+pdSLjBPXNCUOcZ2EZUK0oCy/v+evS/BvxqJ75nzwA
	 Cl3hE/hOVnuBNmYl/QEsmY+5/4qWwHPvbPguXOGw=
X-Mailbox-Line: From bpf-bounces@ietf.org  Wed Dec 13 10:56:10 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 34220C14CF13;
	Wed, 13 Dec 2023 10:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1702493770; bh=RQdHgpDowI36C4AQcltYzAjihzg02+OM/LSjgZfHKi8=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=xel4TzAkGH/D5wHkurYA9o4qTBDaUW60YaoHSTYgr6vnyZM1m4sBATUTd3skTMTwm
	 c/JQn7mtrBEMfMNUt3xAxam1+pdSLjBPXNCUOcZ2EZUK0oCy/v+evS/BvxqJ75nzwA
	 Cl3hE/hOVnuBNmYl/QEsmY+5/4qWwHPvbPguXOGw=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 11E37C14CF18
 for <bpf@ietfa.amsl.com>; Wed, 13 Dec 2023 10:56:09 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -6.41
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P_30cW7mzIMF for <bpf@ietfa.amsl.com>;
 Wed, 13 Dec 2023 10:56:07 -0800 (PST)
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com
 [209.85.166.182])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 5FFCBC14CF13
 for <bpf@ietf.org>; Wed, 13 Dec 2023 10:56:07 -0800 (PST)
Received: by mail-il1-f182.google.com with SMTP id
 e9e14a558f8ab-35f71436397so7615905ab.3
 for <bpf@ietf.org>; Wed, 13 Dec 2023 10:56:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702493766; x=1703098566;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k4dDdZ3MKuRAACo1naFZHHAvTOHd+AvXat8Uq/sNsq0=;
 b=Z3Q0QUWxYL0IVuaaWytCx/yH/aJ73zLzMl8oBiqtoVZnJSjN5cAecPhbVUzgrZIiyb
 2CVwJi4KBo9GhNLG4ocXQNikBe4ptlO7u+CoD0ocKyWWwl0Kpl1Td2ysjpGW/ykYzayg
 S+hzPcKbkhTtjr7U9fvbLZUcJrKUzGmfPkay0MkIdw+clzx6+WvpTsz8P/g6awHN1iNm
 Xz8wZpSGGHtG9GvjX6w7pT/JbnChtiz6QRBmzhkhGBQo0KCcUGitxlnw6/jIGDuV32dK
 XLE44xeBVTmKWJmHyvg+Jd57urodpk3Bsd603MeyjdwNEaXFLmMKY5iL9MCZv6hCh8Uk
 MDFg==
X-Gm-Message-State: AOJu0Yz7uGnoi2eqa4oNZN+jKujUzYZsbR/p/mgUc1klgIW3ZoBcWKNx
 otFrN5B0me9DDXQh47MAS0w=
X-Google-Smtp-Source: AGHT+IEvsx9f9koojouFaKcQ8ym/9GHGPcuuLFRWVvlRKQS8cOUORmQk5n2VpotqdCBSnZxfpx8FkQ==
X-Received: by 2002:a05:6e02:1a06:b0:35d:59a2:2a2 with SMTP id
 s6-20020a056e021a0600b0035d59a202a2mr12936277ild.66.1702493766332; 
 Wed, 13 Dec 2023 10:56:06 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
 by smtp.gmail.com with ESMTPSA id
 s2-20020a92cb02000000b0035f54df2401sm1820381ilo.72.2023.12.13.10.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Dec 2023 10:56:05 -0800 (PST)
Date: Wed, 13 Dec 2023 12:56:03 -0600
From: David Vernet <void@manifault.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Dave Thaler <dthaler1968@googlemail.com>, bpf@ietf.org,
 bpf <bpf@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Christoph Hellwig <hch@infradead.org>
Message-ID: <20231213185603.GA1968@maniforge>
References: <20231127201817.GB5421@maniforge>
 <072101da2558$fe5f5020$fb1df060$@gmail.com>
 <20231207215152.GA168514@maniforge>
 <CAADnVQ+Mhe6ean6J3vH1ugTyrgWNxupLoFfwKu6-U=3R8i1TNQ@mail.gmail.com>
 <20231212214532.GB1222@maniforge>
 <157b01da2d46$b7453e20$25cfba60$@gmail.com>
 <CAADnVQKd7X1v6CwCa2MyJjQkN8hKsHJ_g9Kk5CwWSbp9+1_3zw@mail.gmail.com>
 <20231212233555.GA53579@maniforge>
 <CAADnVQJ-JwNTY5fW-oXdTur9aDrv2NQoreTH3yYZemVBVtq9fQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQJ-JwNTY5fW-oXdTur9aDrv2NQoreTH3yYZemVBVtq9fQ@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/SJmWM5nkuM7shl_uzbnCq0ToH_k>
Subject: Re: [Bpf] BPF ISA conformance groups
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============3916828042015968922=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


--===============3916828042015968922==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RepyZayjlgm3zbRA"
Content-Disposition: inline


--RepyZayjlgm3zbRA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 05:32:33PM -0800, Alexei Starovoitov wrote:
> On Tue, Dec 12, 2023 at 3:36=E2=80=AFPM David Vernet <void@manifault.com>=
 wrote:
> >
> > > It only supports atomic_add and no other atomics.
> >
> > Ahh, I misunderstood when I discussed with Kuba. I guess they supported
> > only atomic_add because packets can be delivered out of order.
>=20
> Not sure why it has anything to do with packets.

My understanding is that the ordering of packets is an impedance with
the host's ordering model. If you offload a BPF program from the host
which expects to see packets in order, and then issues some atomics
which process the packets in order, it won't work on the device because
the packets are delivered out of order. Kuba (cc'd) can give more
details if he wants, but it doesn't really matter. The salient point is
that the chip could have done all of the BPF atomic instructions and it
wouldn't have been much more work to implement them.

> > So fair
> > enough on that point, but I still stand by the claim though that if you
> > need one type of atomic, it's reasonable to infer that you may need all
> > of them. I would be curious to hear how much work it would have been to
> > add support for the others. If there was an atomic conformance group,
> > maybe they would have.
>=20
> The netronome wasn't trying to offload this or that insn to be
> in compliance. Together, netronome and bpf folks decided to focus
> on a set of real XDP applications and try to offload as much as practical.
> At that time there were -mcpu=3Dv1 and v2 insn sets only and offloading
> wasn't really working well. alu32 in llvm, verifier and nfp was added
> to make offload practical. Eventually it became -mcpu=3Dv3.
> So compliance with any future group (basic, atomic, etc) in ISA cannot
> be evaluated in isolation, because nfp is not compliant with -mcpu=3Dv4
> and not compliant with -mcpu=3Dv1,
> but works well with -mcpu=3Dv3 while v3 is an extension of v1 and v2.
> Which is nonsensical from standard compliance pov.
> netronome offload is a success because it demonstrated
> how real production XDP applications can run in a NIC at speeds
> that traditional CPUs cannot dream of.
> It's a success despite the complexity and ugliness of BPF ISA.
> It's working because practical applications compiled with -mcpu=3Dv3 prod=
uce
> "compliant enough" bpf code.

Something I want to make sure is clearly spelled out: are you of the
opinion that a program written for offload to a Netronome device cannot
and should not ever be able to run on any other NIC with BPF offload?

> > Well, maybe not for Netronome, or maybe not even for any vendor (though
> > we have no way of knowing that yet), but what about for other contexts
> > like Windows / Linux cross-platform compat?
>=20
> bpf on windows started similar to netronome. The goal was to
> demonstrate real cilium progs running on windows. And it was done.
> Since windows is a software there was no need to add or remove anything
> from ISA, but due to licensing the prevail verifier had to be used which
> doesn't support a whole bunch of things.
> This software deficiencies of non-linux verifier shouldn't be
> dictating grouping of the insns in the standard.
>
> If linux can do it, windows should be able to do it just as well.
> So I see no problem saying that bpf on windows will be non-compliant
> until they support all of -mcpu=3Dv4 insns. It's a software project
> with a deterministic timeline.
>
> The standard should focus on compatibility between
> HW-ish offloads where no amount of software can add support for
> all of -mcpu=3Dv4.

I don't agree that there's no value in standardizing for the sake of
software as well, but yes it's different than what we're trying to
accomplish for hardware, and I agree that hardware is the main customer
here.

Even if you assume that we should completely ignore software and focus
on hardware compatibility though, that seems to be orthogonal to what
you're proposing here. What compatibility are we guaranteeing if there's
no compliance?

> And here I believe compliance with "basic" is not practical.
> When nvme HW architects will get to implement "basic" ISA they might
> realize that it has too much.
> Producing "conformance groups" without HW folks thinking through the
> implementation is not going to be a success.
> I worry that it will have the opposite effect.
> We'll have a standard with basic, atomic, etc.
> Then folks will deliver this standard on the desk of HW architects.
> They will give it a try and will reject the idea of implementing BPF in H=
W,
> because not implementing "basic" would mean that this vendor
> is not in compliance which means no business.

I don't know enough about how compliance informs the cost-calculus and
decision making of HW vendors to really make an intelligent point here,
but I have to imagine that there's an equally plausible scenario where a
vendor will look at the non-legacy instructions and think, "There's no
possible way we could support all of these instructions", and make the
same decision? Why else would they be asking for a standard if not to
have some guidelines of what to implement?

> Hence the standard shouldn't overfocus on compliance and groups.
> Just legacy and the rest will do for nvme.
> legacy means "don't bother looking at those".
> the rest means "pls implement these insns because they are useful,
> their semantics and encoding is standardized,
> but pick what makes sense for your use case and your HW".

How do we know the semantics of the instructions won't be prohibitively
expensive or impractical for certain vendors? What value do we get out
of dictating semantics in the standard if we're not expecting any of
these programs to be cross-compatible anyways?

> And to make such HW offload a success we'd need to work together.
> compiler, kernel, run-time, hw folks.

Which kernel? Which compiler? If we all need to be in the room every
time a decision is made by any vendor, then what value is the standard
even providing?

> "Here is a standard. Go implement it" won't work.

What is the point of a standard if not to say, "Here's what you should
go implement"?

--RepyZayjlgm3zbRA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZXn+QwAKCRBZ5LhpZcTz
ZBCwAQDLCeqxnDkHfUas7TH8y8NUkQcskNVSWc5JoSjJ/XsugAEAkfOnRmMXixza
HxJYomL3bUfNHvEzuU6+5TxY8X9P3A0=
=sKrs
-----END PGP SIGNATURE-----

--RepyZayjlgm3zbRA--


--===============3916828042015968922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============3916828042015968922==--



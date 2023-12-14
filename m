Return-Path: <bpf+bounces-17868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3DC813907
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 18:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53032282D77
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 17:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F40675CE;
	Thu, 14 Dec 2023 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="Qg85gmen";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="Qg85gmen"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4ECB7
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 09:44:46 -0800 (PST)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 642F3C14CEFF
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 09:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1702575886; bh=2YfV93Danb1EEudJRQ2TcbUm+ljeca3nhoXr6OQrIvA=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=Qg85gmenGL1IlA0RTseCrBaGEoQiw5Q76DQudlpy98YkReF/ZzD+wm2AuZ89llGW1
	 c6sus0s1RpBKmOftWQU+9WXxdo2sKvZqt+EAtW9NwZwNO4/pTU3eq5ypASGt/EOdld
	 bDTFEP2o8IJwdEw4B+OYQJCoiGZVcfW4CA5cK+6E=
X-Mailbox-Line: From bpf-bounces@ietf.org  Thu Dec 14 09:44:46 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 2836EC14F680;
	Thu, 14 Dec 2023 09:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1702575886; bh=2YfV93Danb1EEudJRQ2TcbUm+ljeca3nhoXr6OQrIvA=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=Qg85gmenGL1IlA0RTseCrBaGEoQiw5Q76DQudlpy98YkReF/ZzD+wm2AuZ89llGW1
	 c6sus0s1RpBKmOftWQU+9WXxdo2sKvZqt+EAtW9NwZwNO4/pTU3eq5ypASGt/EOdld
	 bDTFEP2o8IJwdEw4B+OYQJCoiGZVcfW4CA5cK+6E=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id EBE84C14F61C
 for <bpf@ietfa.amsl.com>; Thu, 14 Dec 2023 09:44:44 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.41
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Uj-TxZ27jcvT for <bpf@ietfa.amsl.com>;
 Thu, 14 Dec 2023 09:44:40 -0800 (PST)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com
 [209.85.166.47])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id A02E6C14F60B
 for <bpf@ietf.org>; Thu, 14 Dec 2023 09:44:40 -0800 (PST)
Received: by mail-io1-f47.google.com with SMTP id
 ca18e2360f4ac-7b71e389fb2so275479639f.3
 for <bpf@ietf.org>; Thu, 14 Dec 2023 09:44:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702575880; x=1703180680;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jwOJSwoOAETLG1CfVjsu4xlvZ4N/JEMZJRthIWFpdFA=;
 b=JWeDs2GpUlZEdyvFZ3AFSRWGjVDBR1v5YvtrWTqvIvLN5m3z+56430xyhuXlAnsSuj
 WpMscAqPUCPki17215fMHoqVHgOMLvlGjZ5a6bsgbnKYm9e+bgAZJrUN2GdN4yMSdl2R
 PBsAym0IpilcGnFKKyT1hp5pBcAzQ6hndwngE6HBuFNT830S8uOMWIsjqHRsv184pSzQ
 F8gd3WZOZ4hqnFF8Ga3XwbeXFj9yJU4VTI62lzQMFamXJ7jauOArV7dBURLxZ9n0Vguv
 ybamT/hsiMIqPzdQl1qMbBeCn4t/lrpwpTbOdcbQ4/IM6ofskXzsah17YieKXArA+Pz2
 oK7w==
X-Gm-Message-State: AOJu0YwRXpM5XSQsU8EjYRusFYOcWlfTyRi57eNMoYyx+qE4YKXAPnj/
 m5nfktJ4Wr0vGV/PU8Xa2hM=
X-Google-Smtp-Source: AGHT+IEJ9ylaSdQqiLXKm3svLAs9z0lIgzQUDjNyKk9ELF+rfrkRkhw/nwi25m7cFHxvOLwgF3xhEA==
X-Received: by 2002:a05:6602:2be4:b0:7b3:942e:2df9 with SMTP id
 d4-20020a0566022be400b007b3942e2df9mr11353648ioy.6.1702575879744; 
 Thu, 14 Dec 2023 09:44:39 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
 by smtp.gmail.com with ESMTPSA id
 gj2-20020a0566386a0200b004665ce094c4sm3589710jab.161.2023.12.14.09.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 09:44:39 -0800 (PST)
Date: Thu, 14 Dec 2023 11:44:37 -0600
From: David Vernet <void@manifault.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Dave Thaler <dthaler1968@googlemail.com>, bpf@ietf.org,
 bpf <bpf@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Christoph Hellwig <hch@infradead.org>
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
In-Reply-To: <CAADnVQLOjByUKJNyLdvDzwuegtjZFwrttHft_1o8BoyDCXQvDQ@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/gngynl4_BW2O6MAjQl56kciyU7s>
Subject: Re: [Bpf] BPF ISA conformance groups
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============1376902364253707746=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


--===============1376902364253707746==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="V4Dp/zrCXmcyzI53"
Content-Disposition: inline


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


--===============1376902364253707746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============1376902364253707746==--



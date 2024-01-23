Return-Path: <bpf+bounces-20133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B61A4839B77
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 22:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EFE11F21CCE
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 21:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C5348CCF;
	Tue, 23 Jan 2024 21:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="KmL0XLuf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="KmL0XLuf"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68299487AE
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 21:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706046749; cv=none; b=WXP4AUuuaWJy6/K01YOlx2p9/9oTXl3wC92MXRgJajB83LichxKWUjy4MLSUXHWTCnyDP9y2TKXrpWU4ekM6oCB2SAH7ZNtVMt0LoU3PP6B3obzrWPnxPeUm906WyA3/C+pJSmoELFUs727/vymoabxgftT509Irnl+IgOQvJJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706046749; c=relaxed/simple;
	bh=dWVX8CGPcAqBp4kt02b20dpa/l51OgMtKVQ2hBsKi9k=;
	h=Date:From:To:Cc:Message-ID:References:MIME-Version:In-Reply-To:
	 Subject:Content-Type; b=t68x+rT4RVxh9XLKeJ8ulPQj5oKGITtkCijo+44SjXClxCcexlYcK3ZeS+gszG4XzfTIjN4YLXk709IUhM5gDOyU+ybNjN2ryVFNr6I0apgwHDs3Btp10jWPZaqygBy3Ri9tr16Xe+XBLmQsmFH3aprSczM1P/WknzFeYdJ1sKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=KmL0XLuf; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=KmL0XLuf; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id A485EC151064
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 13:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706046746; bh=dWVX8CGPcAqBp4kt02b20dpa/l51OgMtKVQ2hBsKi9k=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=KmL0XLufvNxIK9WD+NDu8iuj7oINEvDx+6TgpG8omJBhCbI+HlRXjDyxp2Li2qrwr
	 ibXVSTllpumbdsy1d6W8xc7xY765+QI8ptIW83S6eHJwTz+HKvtNC5ry4PQvtJiXu/
	 Y/GLF+Ul/e9OK8EA7KoQB+0cpNoqgS+u+zj/Mhi0=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue Jan 23 13:52:26 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 66779C14F70E;
	Tue, 23 Jan 2024 13:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706046746; bh=dWVX8CGPcAqBp4kt02b20dpa/l51OgMtKVQ2hBsKi9k=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=KmL0XLufvNxIK9WD+NDu8iuj7oINEvDx+6TgpG8omJBhCbI+HlRXjDyxp2Li2qrwr
	 ibXVSTllpumbdsy1d6W8xc7xY765+QI8ptIW83S6eHJwTz+HKvtNC5ry4PQvtJiXu/
	 Y/GLF+Ul/e9OK8EA7KoQB+0cpNoqgS+u+zj/Mhi0=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id B96A6C14F70E
 for <bpf@ietfa.amsl.com>; Tue, 23 Jan 2024 13:52:24 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.41
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WZ_NYKa02-af for <bpf@ietfa.amsl.com>;
 Tue, 23 Jan 2024 13:52:20 -0800 (PST)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com
 [209.85.167.170])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 6EC30C14F6E9
 for <bpf@ietf.org>; Tue, 23 Jan 2024 13:52:20 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id
 5614622812f47-3bda741ad7dso3740204b6e.1
 for <bpf@ietf.org>; Tue, 23 Jan 2024 13:52:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706046739; x=1706651539;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FvJ+BaBwhV3UkswshjPW1gQt1pNqypy86XvcjGB9mYY=;
 b=gt4RenHpdkr1r5dcLAQXrtKhDsgWC1igWUBvGybuevLA8eQ/C6JJFECVISlMYoTjVj
 xoXLJIjLj2JI7vzGRfGtpnAeRRpnkGGj8RNcz/VBk+RNtMh8P3DNLrCYWXvyGYSGyR4y
 CmkIlYVNsw+LeUCWTFuukqVBcks+G1UibJvgvRrHFCztJ6IAjO5wU28AA1NmP7SV99ZS
 GS7dq830yY4mofS4KxbMj9NVRGN1DiclDrzPVb3kroEbHvklJLnG725byNbT7+WpkvWU
 Ndm3BBVIiXXXH0NkPilZWlcwfMrnvDUGtK4rOMdeqeRdWjUMxQCMhhH0e3y2lQsVNDDu
 4bIw==
X-Gm-Message-State: AOJu0YxeO7raUW+21sdBuGrlXmGdwr/DLOSVzoFFftKWBWI560uw5mhe
 tIsw8O4M5ztXS0Ng1MOEeaSPwgtVMKdwJSgGQzYfCVVUt8ZPwAmO
X-Google-Smtp-Source: AGHT+IEwYwAmMmNNhXg+SRfb9qd/dtfdcWVJfWJwpHi+KlS6JAglnoIOOuyZWcA/V0YTAkxZ88qcKw==
X-Received: by 2002:a05:6808:f8e:b0:3bd:caae:e87b with SMTP id
 o14-20020a0568080f8e00b003bdcaaee87bmr674812oiw.14.1706046739589; 
 Tue, 23 Jan 2024 13:52:19 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
 by smtp.gmail.com with ESMTPSA id
 jc11-20020a05622a714b00b00429d86c5c68sm3842950qtb.32.2024.01.23.13.52.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 13:52:17 -0800 (PST)
Date: Tue, 23 Jan 2024 15:52:14 -0600
From: David Vernet <void@manifault.com>
To: dthaler1968@googlemail.com
Cc: bpf@ietf.org, bpf@vger.kernel.org, jose.marchesi@oracle.com
Message-ID: <20240123215214.GC221862@maniforge>
References: <1b5d01da4e1b$95506b50$bff141f0$@gmail.com>
 <20240123213100.GA221838@maniforge>
 <1e9101da4e44$e24a1720$a6de4560$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1e9101da4e44$e24a1720$a6de4560$@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/uKxjRrCbjwhpEBBshlKYy4KSKYM>
Subject: Re: [Bpf] Standardizing BPF assembly language?
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============8187965241320894052=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


--===============8187965241320894052==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nZYOHgN8vDE0U4MF"
Content-Disposition: inline


--nZYOHgN8vDE0U4MF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 01:41:10PM -0800, dthaler1968@googlemail.com wrote:
> > -----Original Message-----
> > From: David Vernet <void@manifault.com>
> > Sent: Tuesday, January 23, 2024 1:31 PM
> > To: dthaler1968@googlemail.com
> > Cc: bpf@ietf.org; bpf@vger.kernel.org; jose.marchesi@oracle.com
> > Subject: Re: [Bpf] Standardizing BPF assembly language?
> >=20
> > On Tue, Jan 23, 2024 at 08:45:32AM -0800,
> > dthaler1968=3D40googlemail.com@dmarc.ietf.org wrote:
> > > At LSF/MM/BPF 2023, Jose gave a presentation about BPF assembly
> > > language (http://vger.kernel.org/bpfconf2023_material/compiled_bpf.tx=
t).
> > >
> > > Jose wrote in that link:
> > > > There are two dialects of BPF assembler in use today:
> > > >
> > > > - A "pseudo-c" dialect (originally "BPF verifier format")
> > > >  : r1 =3D *(u64 *)(r2 + 0x00f0)
> > > >  : if r1 > 2 goto label
> > > >  : lock *(u32 *)(r2 + 10) +=3D r3
> > > >
> > > > - An "assembler-like" dialect
> > > >  : ldxdw %r1, [%r2 + 0x00f0]
> > > >  : jgt %r1, 2, label
> > > >  : xaddw [%r2 + 2], r3
> > >
> > > During Jose's talk, I discovered that uBPF didn't quote match the
> > > second dialect and submitted a bug report.  By the time the conference
> > > was over, uBPF had been updated to match GCC, so that discussion
> > > worked to reduce the number of variants.
> > >
> > > As more instructions get added and supported by more tools and
> > > compilers there's the risk of even more variants unless it's
> standardized.
> > >
> > > Hence I'd recommend that BPF assembly language get documented in some
> > > WG draft.  If folks agree with that premise, the first question is
> > > then: which document?
> >=20
> > > One possible answer would be the ISA document that specifies the
> > > instructions, since that would the IANA registry could list the
> > > assembly for each instruction, and any future documents that add
> > > instructions would necessarily need to specify the assembly for them,
> > > preventing variants from springing up for new instructions.
> >=20
> > I'm not opposed to this, but would strongly prefer that we do it as an
> extension
> > if we go this route to avoid scope creep for the first iteration.
>=20
> If the first iteration does not have it, then presumably the initial
> IANA registry would not have it either, since this iteration creates
> the registry and the rules for it.
>=20
> That's doable, but may continue to proliferate more and more variants
> until it is addressed.

The same could be said for any new instructions that are added while we
sort out standardizing the assembly language as well, no?

> If it's in another document, do you agree it would still fall under
> the existing charter bullet about "defining the instructions"
> > [PS] the BPF instruction set architecture (ISA) that defines the
> > instructions and low-level virtual machine for BPF programs,
> ?

I wouldn't say it's illogical to group assembly language in this bucket,
but I would say that defining the assembly language does not need to be
tied at the hip with defining instruction encodings and semantics. So my
answer is "yes, I think it belongs here", but I also don't think it's
necessary or desirable for the first iteration.

> > > A second question would be, which dialect(s) to standardize.  Jose's
> > > link above argues that the second dialect should be the one
> > > standardized (tools are free to support multiple dialects for
> > > backwards compat if they want).  See the link for rationale.
> >=20
> > My recollection was that the outcome of that discussion is that we were
> going
> > to continue to support both. If we wanted to standardize, I have a hard
> time
> > seeing any other way other than to standardize both dialects unless
> there's
> > been a significant change in sentiment since LSFMM.
>=20
> If "standardize both", does that mean neither is mandatory and each tool
> is free to pick one or the other?  And would the IANA registry require a
> document
> adding any new instructions to specify the assembly in both dialects?

Well, if we're standardizing on both, then yes I think it would be
mandatory for a tool to support both, and I think instructions would
require assembly for both dialects. Practically speaking that's already
what's happening, no? Both dialects are already pervasive, so it seems
unlikely that a tool would succeed without supporting both regardless.
To Jose's point (pasted below), there are of course drawbacks:

> - Expensive :: it makes it very difficult to reuse infrastructure.
> - Problematic :: dis/assemblers, CGEN, LaTeX, editors, IDEs, etc.
> - Ambiguous :: with both GAS and llvm/MCParser: symbol assignments.
> - Pervasive :: because of the inline asm.

I think it would be a lot simpler to standardize on only a single
dialect, but I also think the standard should reflect how BPF is being
used in practice.

--nZYOHgN8vDE0U4MF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZbA1DQAKCRBZ5LhpZcTz
ZKawAQCMOLHMd2YqlC3rJG6dk4UcAd9lC+X0g93XRM8w3D3lUwD/V23jzepdCKP7
dnKIrk3c0mFQ907+J60P9HNPp7ld/wg=
=yNnj
-----END PGP SIGNATURE-----

--nZYOHgN8vDE0U4MF--


--===============8187965241320894052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============8187965241320894052==--



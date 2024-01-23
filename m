Return-Path: <bpf+bounces-20127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 396B0839B36
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 22:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 656E61C23715
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 21:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C995F3D542;
	Tue, 23 Jan 2024 21:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="uO95Qxgo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="uO95Qxgo"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCFA39848
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 21:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706045475; cv=none; b=fueWYXaeq7owsVsX2jZJ6rxHqm8St4TaOCi/s4rcSXK7vjs/NzuQ/V6Jpn47Ns/z4sPyV7+LiBCdnyh/Jfj94/xY1a2Tiglz0iTfNRgO+8Cb/5x4VGr1hNhboEmfzwet/MtIxtVrJdte2E+XdkKbhik1Dyka+Jh7bvXpl3A4oeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706045475; c=relaxed/simple;
	bh=KPsdXkHcKe8tBq8TTDglJ42i9TAGJSnblwVjwJoCbAY=;
	h=Date:From:To:Cc:Message-ID:References:MIME-Version:In-Reply-To:
	 Subject:Content-Type; b=dR7ZuxkMuCDMzqkLfPm0jj53+2pmwUYwZaZjCKX4CuMLIl8PwLGS0g4A7QmhUd7mtONoU+YWHkIQ4Q08qbkVgBRWayhS/4LxL0ai4jZr9tjZ9wZhya6sVR9uEUOMilJmPRoBJd/52KLQdpS1F2NZzKj9s9wVVIDGzncpbk+IkZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=uO95Qxgo; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=uO95Qxgo; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id F2A0FC151063
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 13:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706045472; bh=KPsdXkHcKe8tBq8TTDglJ42i9TAGJSnblwVjwJoCbAY=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=uO95Qxgo6cw0uJjXl1efAFsRjDjhQhWuL+no58gre2yrM0lTvRZyIRR4G890aXalz
	 EvHJkDeOjEKe1r567lwdp5LqpQv5JcsSnt4Q5qOWL0XIH800wJA66u2zadPf+9l8/F
	 YeEvjqs/EXGYYwwR3Rx7gZp4nS7ADuYcj9bA3EF4=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue Jan 23 13:31:12 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id B0B2DC14F6EF;
	Tue, 23 Jan 2024 13:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706045472; bh=KPsdXkHcKe8tBq8TTDglJ42i9TAGJSnblwVjwJoCbAY=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=uO95Qxgo6cw0uJjXl1efAFsRjDjhQhWuL+no58gre2yrM0lTvRZyIRR4G890aXalz
	 EvHJkDeOjEKe1r567lwdp5LqpQv5JcsSnt4Q5qOWL0XIH800wJA66u2zadPf+9l8/F
	 YeEvjqs/EXGYYwwR3Rx7gZp4nS7ADuYcj9bA3EF4=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 9519CC14F5F4
 for <bpf@ietfa.amsl.com>; Tue, 23 Jan 2024 13:31:11 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.41
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GcOV-9eyDNV7 for <bpf@ietfa.amsl.com>;
 Tue, 23 Jan 2024 13:31:09 -0800 (PST)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 85CD9C14F710
 for <bpf@ietf.org>; Tue, 23 Jan 2024 13:31:04 -0800 (PST)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-6818f3cf00aso29311966d6.0
 for <bpf@ietf.org>; Tue, 23 Jan 2024 13:31:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706045463; x=1706650263;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iV/Xh15fCZhFFlIAa0q4I8q/sKNXjwpkP5J28622nUE=;
 b=HX7WsXgaA9/L6THISRgsp/8w4MzmXcAq/6xIgrigkEY6by8GaIo6P9Rx8VaeeJhFSP
 x+xsogl207lkU7aiM2+oLGTVs05XMzIr+GGCDTDNlSOuAkr1IyIil68kQ1xJW7QDVesX
 DnuwTuWcYs6diE8tpW3zq9qMzh/VgtCIqx/LZU7rQMxkzk6Q/fzZSLQlwRRRNFMx+DDU
 QDv0xIyKjYgZMd5bl8Mkc6gBRH2Z80wUtRcLB+8ad1USei0BDQWbveq2LmPvSwJR3IfX
 dbDSe+61c6/MJlFONlwXNRCvMgmYKyNXiGMtD99635qVyt4XhU9g2ReY+Yunxkq3eSI/
 j3yg==
X-Gm-Message-State: AOJu0YyU1PM2phaGxJB6gPlt0yFapd8ZidDDvhY3L0qbpHQtk3jEAw0k
 l65+wWlflBrqEnDSVG5jORJE1eifgZNsCytMrsBIWYlkJ/bUViBK
X-Google-Smtp-Source: AGHT+IEIzokzqCv5vfH9w7fv+kSl36L1mg9kzKSamrgWcdg7BeV4bOMRK58NcCu0R5h4YzjhN2YE7Q==
X-Received: by 2002:a0c:e0d3:0:b0:685:d99e:117f with SMTP id
 x19-20020a0ce0d3000000b00685d99e117fmr1444584qvk.60.1706045463460; 
 Tue, 23 Jan 2024 13:31:03 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
 by smtp.gmail.com with ESMTPSA id
 j7-20020a0ceb07000000b00681092cb7b4sm3781929qvp.103.2024.01.23.13.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 13:31:02 -0800 (PST)
Date: Tue, 23 Jan 2024 15:31:00 -0600
From: David Vernet <void@manifault.com>
To: dthaler1968=40googlemail.com@dmarc.ietf.org
Cc: bpf@ietf.org, bpf@vger.kernel.org, jose.marchesi@oracle.com
Message-ID: <20240123213100.GA221838@maniforge>
References: <1b5d01da4e1b$95506b50$bff141f0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1b5d01da4e1b$95506b50$bff141f0$@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/_wSeom-j6q2a2n5paRFK_vJcXbM>
Subject: Re: [Bpf] Standardizing BPF assembly language?
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============6063956238828122083=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


--===============6063956238828122083==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hSlCmNz4qQUXX2xq"
Content-Disposition: inline


--hSlCmNz4qQUXX2xq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 08:45:32AM -0800, dthaler1968=3D40googlemail.com@dm=
arc.ietf.org wrote:
> At LSF/MM/BPF 2023, Jose gave a presentation about BPF assembly
> language (http://vger.kernel.org/bpfconf2023_material/compiled_bpf.txt).
>=20
> Jose wrote in that link:
> > There are two dialects of BPF assembler in use today:
> >
> > - A "pseudo-c" dialect (originally "BPF verifier format")
> >  : r1 =3D *(u64 *)(r2 + 0x00f0)
> >  : if r1 > 2 goto label
> >  : lock *(u32 *)(r2 + 10) +=3D r3
> >
> > - An "assembler-like" dialect
> >  : ldxdw %r1, [%r2 + 0x00f0]
> >  : jgt %r1, 2, label
> >  : xaddw [%r2 + 2], r3
>=20
> During Jose's talk, I discovered that uBPF didn't quote match the
> second dialect and submitted a bug report.  By the time the conference
> was over, uBPF had been updated to match GCC, so that discussion
> worked to reduce the number of variants.
>=20
> As more instructions get added and supported by more tools and compilers
> there's the risk of even more variants unless it's standardized.
>=20
> Hence I'd recommend that BPF assembly language get documented in some WG
> draft.  If folks agree with that premise, the first question is then: whi=
ch
> document?

> One possible answer would be the ISA document that specifies the
> instructions, since that would the IANA registry could list the
> assembly for each instruction, and any future documents that add
> instructions would necessarily need to specify the assembly for them,
> preventing variants from springing up for new instructions.

I'm not opposed to this, but would strongly prefer that we do it as an
extension if we go this route to avoid scope creep for the first
iteration.

> A second question would be, which dialect(s) to standardize.  Jose's
> link above argues that the second dialect should be the one
> standardized (tools are free to support multiple dialects for
> backwards compat if they want).  See the link for rationale.

My recollection was that the outcome of that discussion is that we were
going to continue to support both. If we wanted to standardize, I have a
hard time seeing any other way other than to standardize both dialects
unless there's been a significant change in sentiment since LSFMM.

--hSlCmNz4qQUXX2xq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZbAwFAAKCRBZ5LhpZcTz
ZLo7AP9s3InRJFMiQo28vmaSxIF2tJR6ZShWUv2BiGaqCqHOFwEAjdckPP4oq4vP
tonVgIMM511NKDHHkI9lt4y3dAkV1go=
=ozHj
-----END PGP SIGNATURE-----

--hSlCmNz4qQUXX2xq--


--===============6063956238828122083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============6063956238828122083==--



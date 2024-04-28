Return-Path: <bpf+bounces-28050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8081E8B4E6C
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 00:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9661B1C2099A
	for <lists+bpf@lfdr.de>; Sun, 28 Apr 2024 22:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CC8107B6;
	Sun, 28 Apr 2024 22:01:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5155DDDAE
	for <bpf@vger.kernel.org>; Sun, 28 Apr 2024 22:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714341675; cv=none; b=JKIr0y5Sim3EcueR+T1RM8BjHzBgc9SpEDPHEs6F+yC4nR+IeRx3AnSzzl9ALlmqFJGjRQZpfieY3awTPJnasYAMiaTBhex0uWyRo5uibJaDfa+uBbyTBM35f9aDO27F/9bID2JS2p1k6bRhCabuG4zXFinZ2Pi0ULVS1mR7Kz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714341675; c=relaxed/simple;
	bh=5Aq4YC+PRccnebQZtttVKVp6kSXbjoUVpwXVrRXU0hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmUXb5IiO0Un9kTNtV+oaVTbGIEDvlz8rho4scoJNztHZzsthgjXVF2oF1NOCB1SQq4Tsn6AgpFwUWXJFoPkY1N/haMD8wDUWdbXc02FVrjFpVcv7YlOdAWxD1GlVO4EP+x1PR63OfNA0R7kRHqKFAVcRv8nYCo08SpE8fpJEfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7da37436e36so179098539f.0
        for <bpf@vger.kernel.org>; Sun, 28 Apr 2024 15:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714341672; x=1714946472;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1rSEZ0uJLMLS6TADaoKbbKJSQj1pHqO0QBkdngdbebQ=;
        b=xHzq3X8SwVsP5d/5xk4yEahoYet1mnbyXbfI8TqoAJLE8ZLUt38TWkP1gnavYWxNla
         hVPzkFQysZsbxyV3Tkr8t2Rfr01icip7GhErBwP2HKhHNAFamS3lgk4wXsAkUieG8pb4
         Tmg7mwhhJ1MHRlrYKK00TJSD/U7Bl/19DdoXwqiiYpCp0CAS4xVdbjCSdHcmp7QcuTrM
         z0IUCck7f8C407j3C7j2g1DuMNStjSNllVh9R7wDP96IC0bS0C+lXn3h6/gfZ3Aklx+Y
         PgCNWr4u5rJlyRrL795Hh260wFdnclYZJN1ba+qS90fqDFOwtb1aKSNJNTbqu0/Cbsk7
         jYbA==
X-Gm-Message-State: AOJu0YzHW+KYZUZgykuQrqPvanQYvxyif8tb/3GZfOOavKM4HAcHvB5Y
	GmduVr/pN+Q+gGt63MF0RmxMhsHeWOh7EiFsQ9D2KgW6F8aPFKG6
X-Google-Smtp-Source: AGHT+IHgt6RN8ipT5cwAmYfDxMriZycZUdurc65/N+C556e5XdPU6TLS/thpptRI1OS3/u7lJbps/A==
X-Received: by 2002:a5d:8e16:0:b0:7da:bccd:c3ec with SMTP id e22-20020a5d8e16000000b007dabccdc3ecmr10564903iod.5.1714341672311;
        Sun, 28 Apr 2024 15:01:12 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
        by smtp.gmail.com with ESMTPSA id iv15-20020a056638868f00b0048792a75bb1sm830354jab.111.2024.04.28.15.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 15:01:11 -0700 (PDT)
Date: Sun, 28 Apr 2024 17:01:08 -0500
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>,
	Dave Thaler <dthaler1968@googlemail.com>
Subject: Re: [Bpf] [PATCH bpf-next v3] bpf, docs: Clarify PC use in
 instruction-set.rst
Message-ID: <20240428220108.GB21308@maniforge>
References: <20240426231126.5130-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jLF0M3BlpDlPplJb"
Content-Disposition: inline
In-Reply-To: <20240426231126.5130-1-dthaler1968@gmail.com>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--jLF0M3BlpDlPplJb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 04:11:26PM -0700, Dave Thaler wrote:
> This patch elaborates on the use of PC by expanding the PC acronym,
> explaining the units, and the relative position to which the offset
> applies.
>=20
> v1->v2: reword per feedback from Alexei
>=20
> v2->v3: reword per feedback from David Vernet
>=20
> Signed-off-by: Dave Thaler <dthaler1968@googlemail.com>

Reviewed-by: David Vernet <void@manifault.com>

> ---
>  Documentation/bpf/standardization/instruction-set.rst | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Docu=
mentation/bpf/standardization/instruction-set.rst
> index b44bdacd0..997560aba 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -469,6 +469,12 @@ JSLT      0xc    any      PC +=3D offset if dst < sr=
c          signed
>  JSLE      0xd    any      PC +=3D offset if dst <=3D src         signed
>  =3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> +where 'PC' denotes the program counter, and the offset to increment by
> +is in units of 64-bit instructions relative to the instruction following
> +the jump instruction.  Thus 'PC +=3D 1' skips execution of the next
> +instruction if it's a basic instruction or results in undefined behavior
> +if the next instruction is a 128-bit wide instruction.
> +
>  The BPF program needs to store the return value into register R0 before =
doing an
>  ``EXIT``.
> =20
> --=20
> 2.40.1
>=20
> --=20
> Bpf mailing list
> Bpf@ietf.org
> https://www.ietf.org/mailman/listinfo/bpf

--jLF0M3BlpDlPplJb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZi7HJAAKCRBZ5LhpZcTz
ZByRAQC2QFtgliqW/7CMUHUnEnVIs+TfZFayYWZEElNx/y37RAD/QLAGp3E+LDUL
3ZVkVeVLSvnSnvu4qDWkjdkEyWDUqAU=
=YSPW
-----END PGP SIGNATURE-----

--jLF0M3BlpDlPplJb--


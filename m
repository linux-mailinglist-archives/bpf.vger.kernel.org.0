Return-Path: <bpf+bounces-32832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0AB913861
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 08:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7F791F22923
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 06:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCABF2E62B;
	Sun, 23 Jun 2024 06:53:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0BA36120
	for <bpf@vger.kernel.org>; Sun, 23 Jun 2024 06:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719125604; cv=none; b=HQ9Dr/D0GAAsCrT4PbnF6lXpZ+Ka3RY/waR+KVUA3JWk+P0ywr2nVI95Aks9RBR4DZ2srVEzMsuZTb5TY0iXv95p3ZvvxB3v1umO1H0u0RfrotHkGkIcZwe0ZqY+1vCG4/tZhdeOy/zgI8XHGOvQovl/J2FudLk86bFr833Q1m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719125604; c=relaxed/simple;
	bh=tTqSgL1hcGFjaakjzwjSYk5YiBIzWkQzohZuNQ3aMYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lE6VM4E4dRBHjDJrdsxCs42PyGY62D/dV+dhwejuxiSkSNEJomUpeSqIKdG77d3vibr0e5KfU2fIqncPdHb4ul6OoVHJPHd17vRqqlx/Yr6itV5IDGXLqsAh8JnpkfvZVMY+6Np9IjqaGglb2/M4QgtSpGivDEUehMBGGq3RF8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7953f1dcb01so319443985a.3
        for <bpf@vger.kernel.org>; Sat, 22 Jun 2024 23:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719125601; x=1719730401;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Dt5Zf36Dzb1UNdTfxr0jHhu1nufyrLEliOYs++JiSE=;
        b=PJt4fBscZzXNUGUmASnTYWPWDJHXy2SoKWYDhZf8im8vqmUPhkV+Gta5rmLVNDPwao
         vVTCVrxx2J9dCp0YUYKW6VKVUadmj/3aTZzfL+d/XiUvyxVPdP6Nenqv5wHlVg7E2gB6
         v/nt8Zmilh7GXI+3UrjGrjdBe/JhWkp9sX2f5JbyzZ0a691CumDFvOI4uoTk5U1AZ2R1
         AXg3KRr9ZW54GGBvYDmDi6PZelKyGWHeFwWrm117+edZmZ8Wiv7/4yIaEA7cumz2lAr1
         7m7i8zd176waU/QNTjO8aj8T1goPsd82ZiTeksn75ZMTV5SzZLw7KW9DUJU0mpte/8mM
         ee3g==
X-Gm-Message-State: AOJu0YyT1x5E23UzBESbfAiY3gfJVxBkELHyWUvLxE2zMV5NIxLRNUo7
	KzJ1gW8expbZp2V7fymNVeurFDSO5RgroXKdINS//KnvaqKfY5jY
X-Google-Smtp-Source: AGHT+IF3lRaGwHNZ80XlgKrq5SnyJkK/uVY9Z9xGJnb+u3km2o6QER8j5HEhzPT7lXXFddcTz9b6Pw==
X-Received: by 2002:a05:6214:d4b:b0:6b5:4a2:79a2 with SMTP id 6a1803df08f44-6b5409e0714mr18278866d6.28.1719125601073;
        Sat, 22 Jun 2024 23:53:21 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ef30a92sm23399366d6.82.2024.06.22.23.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 23:53:19 -0700 (PDT)
Date: Sun, 23 Jun 2024 01:53:16 -0500
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>,
	Dave Thaler <dthaler1968@googlemail.com>
Subject: Re: [Bpf] [PATCH bpf-next] bpf, docs: Address comments from IETF
 Area Directors
Message-ID: <20240623065316.GA6519@maniforge>
References: <20240623015531.9433-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8U7UC5LvPyWivjW1"
Content-Disposition: inline
In-Reply-To: <20240623015531.9433-1-dthaler1968@gmail.com>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--8U7UC5LvPyWivjW1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 22, 2024 at 06:55:31PM -0700, Dave Thaler wrote:
> This patch does the following to address IETF feedback:
>=20
> * Remove mention of "program type" and reference future
>   docs (and mention platform-specific docs exist) for
>   helper functions and BTF. Addresses Roman Danyliw's
>   comments based on GENART review from Ines Robles [0].
>=20
> * Add reference for endianness as requested by John
>   Scudder [1].
>=20
> * Added bit numbers to top of 32-bit wide format diagrams
>   as requested by Paul Wouters [2].
>=20
> * Added more text about why BPF doesn't stand for anything, based
>   on text from ebpf.io [3], as requested by Eric Vyncke and
>   Gunter Van de Velde [4].
>=20
> * Replaced "htobe16" (and similar) and the direction-specific
>   description with just "be16" (and similar) and a direction-agnostic
>   description, to match the direction-agnostic description in
>   the Byteswap Instructions section. Based on feedback from Eric
>   Vyncke [5].
>=20
> [0] https://mailarchive.ietf.org/arch/msg/bpf/DvDgDWOiwk05OyNlWlAmELZFPlM/
>=20
> [1] https://mailarchive.ietf.org/arch/msg/bpf/eKNXpU4jCLjsbZDSw8LjI29M3tM/
>=20
> [2] https://mailarchive.ietf.org/arch/msg/bpf/hGk8HkYxeZTpdu9qW_MvbGKj7WU/
>=20
> [3] https://ebpf.io/what-is-ebpf/#what-do-ebpf-and-bpf-stand-for
>=20
> [4] https://mailarchive.ietf.org/arch/msg/bpf/i93lzdN3ewnzzS_JMbinCIYxAIU/
>=20
> [5] https://mailarchive.ietf.org/arch/msg/bpf/KBWXbMeDcSrq4vsKR_KkBbV6hI4/
>=20
> Signed-off-by: Dave Thaler <dthaler1968@googlemail.com>

Acked-by: David Vernet <void@manifault.com>

Dave, please feel free to ignore any of these suggestions; especially if th=
ey
slow down the ratification process beyond just iterating on the list here.

> ---
>  .../bpf/standardization/instruction-set.rst   | 80 +++++++++++--------
>  1 file changed, 45 insertions(+), 35 deletions(-)
>=20
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Docu=
mentation/bpf/standardization/instruction-set.rst
> index 398f27bab..84f581dd2 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -5,12 +5,19 @@
>  BPF Instruction Set Architecture (ISA)
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> -eBPF (which is no longer an acronym for anything), also commonly
> +eBPF, also commonly
>  referred to as BPF, is a technology with origins in the Linux kernel
>  that can run untrusted programs in a privileged context such as an
>  operating system kernel. This document specifies the BPF instruction
>  set architecture (ISA).
> =20
> +As a historical note, BPF originally stood for Berkeley Packet Filter,
> +but now that it can do so much more than packet filtering, the acronym
> +no longer makes sense. BPF is now considered a standalone term that
> +doesn't stand for anything.  The original BPF is sometimes referred to

Given that we don't use conjunctions anywhere else, should we expand this to
"does not"? Feel free to ignore if this is normal.

> +as cBPF (classic BPF) to distinguish it from the now widely deployed
> +eBPF (extended BPF).
> +
>  Documentation conventions
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> =20
> @@ -18,7 +25,7 @@ The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", =
"SHALL NOT",
>  "SHOULD", "SHOULD NOT", "RECOMMENDED", "NOT RECOMMENDED", "MAY", and
>  "OPTIONAL" in this document are to be interpreted as described in
>  BCP 14 `<https://www.rfc-editor.org/info/rfc2119>`_
> -`RFC8174 <https://www.rfc-editor.org/info/rfc8174>`_
> +`<https://www.rfc-editor.org/info/rfc8174>`_
>  when, and only when, they appear in all capitals, as shown here.
> =20
>  For brevity and consistency, this document refers to families
> @@ -59,24 +66,18 @@ numbers.
> =20
>  Functions
>  ---------
> -* htobe16: Takes an unsigned 16-bit number in host-endian format and
> -  returns the equivalent number as an unsigned 16-bit number in big-endi=
an
> -  format.
> -* htobe32: Takes an unsigned 32-bit number in host-endian format and
> -  returns the equivalent number as an unsigned 32-bit number in big-endi=
an
> -  format.
> -* htobe64: Takes an unsigned 64-bit number in host-endian format and
> -  returns the equivalent number as an unsigned 64-bit number in big-endi=
an
> -  format.
> -* htole16: Takes an unsigned 16-bit number in host-endian format and
> -  returns the equivalent number as an unsigned 16-bit number in little-e=
ndian
> -  format.
> -* htole32: Takes an unsigned 32-bit number in host-endian format and
> -  returns the equivalent number as an unsigned 32-bit number in little-e=
ndian
> -  format.
> -* htole64: Takes an unsigned 64-bit number in host-endian format and
> -  returns the equivalent number as an unsigned 64-bit number in little-e=
ndian
> -  format.
> +
> +The following byteswap functions are direction-agnostic.  That is,
> +the same function is used for conversion in either direction discussed
> +below.
> +
> +* be16: Takes an unsigned 16-bit number and converts it between
> +  host byte order and big-endian
> +  (`IEN137 <https://www.rfc-editor.org/ien/ien137.txt>`_) byte order.
> +* be32: Takes an unsigned 32-bit number and converts it between
> +  host byte order and big-endian byte order.
> +* be64: Takes an unsigned 64-bit number and converts it between
> +  host byte order and big-endian byte order.
>  * bswap16: Takes an unsigned 16-bit number in either big- or little-endi=
an
>    format and returns the equivalent number with the same bit width but
>    opposite endianness.
> @@ -86,7 +87,12 @@ Functions
>  * bswap64: Takes an unsigned 64-bit number in either big- or little-endi=
an
>    format and returns the equivalent number with the same bit width but
>    opposite endianness.
> -
> +* le16: Takes an unsigned 16-bit number and converts it between
> +  host byte order and little-endian byte order.
> +* le32: Takes an unsigned 32-bit number and converts it between
> +  host byte order and little-endian byte order.
> +* le64: Takes an unsigned 64-bit number and converts it between
> +  host byte order and little-endian byte order.
> =20
>  Definitions
>  -----------
> @@ -441,8 +447,8 @@ and MUST be set to 0.
>    =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    class  source    value  description
>    =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  ALU    TO_LE     0      convert between host byte order and little end=
ian
> -  ALU    TO_BE     1      convert between host byte order and big endian
> +  ALU    LE        0      convert between host byte order and little end=
ian
> +  ALU    BE        1      convert between host byte order and big endian
>    ALU64  Reserved  0      do byte swap unconditionally
>    =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> @@ -453,19 +459,19 @@ conformance group.
> =20
>  Examples:
> =20
> -``{END, TO_LE, ALU}`` with 'imm' =3D 16/32/64 means::
> +``{END, LE, ALU}`` with 'imm' =3D 16/32/64 means::
> =20
> -  dst =3D htole16(dst)
> -  dst =3D htole32(dst)
> -  dst =3D htole64(dst)
> +  dst =3D le16(dst)
> +  dst =3D le32(dst)
> +  dst =3D le64(dst)
> =20
> -``{END, TO_BE, ALU}`` with 'imm' =3D 16/32/64 means::
> +``{END, BE, ALU}`` with 'imm' =3D 16/32/64 means::
> =20
> -  dst =3D htobe16(dst)
> -  dst =3D htobe32(dst)
> -  dst =3D htobe64(dst)
> +  dst =3D be16(dst)
> +  dst =3D be32(dst)
> +  dst =3D be64(dst)
> =20
> -``{END, TO_LE, ALU64}`` with 'imm' =3D 16/32/64 means::
> +``{END, TO, ALU64}`` with 'imm' =3D 16/32/64 means::
> =20
>    dst =3D bswap16(dst)
>    dst =3D bswap32(dst)
> @@ -545,13 +551,17 @@ Helper functions are a concept whereby BPF programs=
 can call into a
>  set of function calls exposed by the underlying platform.
> =20
>  Historically, each helper function was identified by a static ID
> -encoded in the 'imm' field.  The available helper functions may differ
> -for each program type, but static IDs are unique across all program type=
s.
> +encoded in the 'imm' field.  Further documentation of helper functions
> +is outside the scope of this document and standardization is left for
> +future work, but use is widely deployed and more information can be
> +found in platform-specific documentation (e.g., Linux kernel documentati=
ons).
> =20
>  Platforms that support the BPF Type Format (BTF) support identifying
>  a helper function by a BTF ID encoded in the 'imm' field, where the BTF =
ID
>  identifies the helper name and type.  Further documentation of BTF
> -is outside the scope of this document and is left for future work.
> +is outside the scope of this document and standardization is left for
> +future work, but use is widely deployed and more information can be
> +found in platform-specific documentation (e.g., Linux kernel documentati=
ons).

Here and above, can we please change this to say "documentation" instead of
"documentations"? "Documentations" is technically a valid word but
"documentation" is also a valid plural, uncountable form and IMO reads more
naturally.

> =20
>  Program-local functions
>  ~~~~~~~~~~~~~~~~~~~~~~~
> --=20
> 2.40.1
>=20
> --=20
> Bpf mailing list -- bpf@ietf.org
> To unsubscribe send an email to bpf-leave@ietf.org

--8U7UC5LvPyWivjW1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZnfGXAAKCRBZ5LhpZcTz
ZBCqAQD6P3MOyqQ9bW5qIakDBZtKDL5w2Co9dGwhNd6FXhZ6eAD+NjIX0JXfun1O
x8mrlGyFvZCueYOFdKEYbPIOs9wwWgg=
=qPaU
-----END PGP SIGNATURE-----

--8U7UC5LvPyWivjW1--


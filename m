Return-Path: <bpf+bounces-32847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5310B913C84
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 17:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C771D1F2270C
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 15:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6219D1802C0;
	Sun, 23 Jun 2024 15:43:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094591822C1
	for <bpf@vger.kernel.org>; Sun, 23 Jun 2024 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719157402; cv=none; b=HryoNDDQRkVAQpWA7uytGOSidveBodZBUEpFBcAGdMmUyf7apWYMP/vZU9SU6me1HY7QfhgW629S4KPYt2LL0ErxhzfeuqpqZjLq7B0QITDwKPUuHgR1Yslo6jbvfhZH9hy36NHVjkbc6bOPg1T31iWqNlwcT7XF/DfQo/1hbFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719157402; c=relaxed/simple;
	bh=OyAd9BvPZN8/Z8e1VTO1lJWmVHBH/5vTFGMbBBIndug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XeBkO5A2U8x8xBtyTjnfM3CkKPSWFXrCQ6hDF0CyYdeY+dSv0DrOC73vj/t4DPIHZsV2QP+XNCu3dKs0IAvR58ptAiSnFFYMC6VbK92sVJ+fKoDRsSqoUHdfvjQXVyIecgVAPbIRplsWZyxo2JH9PHRscOjHXhPggKzCTkpPy5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7961fb2d1cfso284099985a.0
        for <bpf@vger.kernel.org>; Sun, 23 Jun 2024 08:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719157399; x=1719762199;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yvqvd1NwrKhrX3IFFs7AU9xrMVtWEFFxjHdzqsvw/Ig=;
        b=G0XTj/RPkcNcerl1sogTTC5SkbZjd1P8ztoKiJPSqS7/S7mD5wJrcx5s8CSgoa7R7k
         W1/RK6euA4Mm3FPToHITkQ2XJzEBDkR953DkKdstBJn6LuG5DHAZG67UcFk83toceLHi
         EnLmAY+UkRvFxZ2hU/aoVgNbPo9jinw4M9nQ3FaAKgwM/hDvFe4GJZoW1HXLrAx+xpWe
         6nK/01p9UHLDN1l4TzMjhwJpSvoI5g03GIj7TTRyslJ2rUhzORkk3ZAb/OEatq7VvNBD
         ORtFKs+XNXUFDfnwnGrvL84ThmdeNtNWNgaZnnsN6eae7Vj6FWV5sd1T7e0tPivH9N/0
         9aPg==
X-Gm-Message-State: AOJu0Yw16bWo062NoP14m4ZOT6Rx30bNttStyER5zlSIyaBjHnNS99U7
	QU68CYGF91GRaJKhIN1TxNWX7yKy+d4ttW7kVY3eWAoGxHRiUge7
X-Google-Smtp-Source: AGHT+IF/w6Pw5iONzDHHk9eM57QHV2UV97TASOsP/i+1PDi5FVEdb9Rl1WdQkvDev7wkPkoPwTj0eA==
X-Received: by 2002:ad4:5c4e:0:b0:6b0:86ab:feaf with SMTP id 6a1803df08f44-6b540aaa87cmr32733866d6.48.1719157398675;
        Sun, 23 Jun 2024 08:43:18 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ef54b40sm26094056d6.114.2024.06.23.08.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 08:43:18 -0700 (PDT)
Date: Sun, 23 Jun 2024 10:43:15 -0500
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>,
	Dave Thaler <dthaler1968@googlemail.com>
Subject: Re: [Bpf] [PATCH bpf-next v2] bpf, docs: Address comments from IETF
 Area Directors
Message-ID: <20240623154315.GA52273@maniforge>
References: <20240623150453.10613-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="U61e/pCbZPMS5KHI"
Content-Disposition: inline
In-Reply-To: <20240623150453.10613-1-dthaler1968@gmail.com>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--U61e/pCbZPMS5KHI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 23, 2024 at 08:04:53AM -0700, Dave Thaler wrote:
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
> ---
>=20
> 1->2: Addressed nits from David Vernet
>=20
> Signed-off-by: Dave Thaler <dthaler1968@googlemail.com>

Acked-by: David Vernet <void@manifault.com>

> ---
>  .../bpf/standardization/instruction-set.rst   | 80 +++++++++++--------
>  1 file changed, 45 insertions(+), 35 deletions(-)
>=20
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Docu=
mentation/bpf/standardization/instruction-set.rst
> index 398f27bab..7e636299a 100644
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
> +does not stand for anything.  The original BPF is sometimes referred to
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
on).
> =20
>  Platforms that support the BPF Type Format (BTF) support identifying
>  a helper function by a BTF ID encoded in the 'imm' field, where the BTF =
ID
>  identifies the helper name and type.  Further documentation of BTF
> -is outside the scope of this document and is left for future work.
> +is outside the scope of this document and standardization is left for
> +future work, but use is widely deployed and more information can be
> +found in platform-specific documentation (e.g., Linux kernel documentati=
on).
> =20
>  Program-local functions
>  ~~~~~~~~~~~~~~~~~~~~~~~
> --=20
> 2.40.1
>=20
> --=20
> Bpf mailing list -- bpf@ietf.org
> To unsubscribe send an email to bpf-leave@ietf.org

--U61e/pCbZPMS5KHI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZnhCkwAKCRBZ5LhpZcTz
ZG1QAP4/aakNEiQ3KIhJ1vvhTnTzKa8UoaC0kCaYAIy1CNLkVgEAwejmhuzuiRnK
oqd7fATkgp7orZuSJN0rm7AyQERQqAs=
=/eh0
-----END PGP SIGNATURE-----

--U61e/pCbZPMS5KHI--


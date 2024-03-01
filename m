Return-Path: <bpf+bounces-23198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6ED486EB63
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 22:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63AFB284216
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 21:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCE658AB2;
	Fri,  1 Mar 2024 21:49:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206B958AA5
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 21:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709329778; cv=none; b=e5DTUQwiD/Zjqon7oGhHf1Gu9Z64yicFhNkckF5DEl+i/8Kvte0mj2YaknYLm620FtCtTgPysgoGiPX1mOo4sMu5aWnk93+nCC7BBbWq5dBPBQ2KO80Io7+Qs/1GUaEfc771ffnuYw2Evu8jCNAbPwvQCdtiLIjcyohg5D6K53s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709329778; c=relaxed/simple;
	bh=xbj9N4JX+4TqSUnyfG0UcYStAHdppdJUSzQ9NSUJTR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwH3afrcQSXMM54BhSOvtmd77FbHJe0+Amx+Y5RAcnHS14gudJreIEkAkwsajOysIEJr10OEW/m0t/usJIwHgGomkygjTRY6nxozsgFR8yCEOBHwQyXsaDWCVZyQlob0+0kNVNAV5+85OiwVA11V53T9PVCNkORDsFBFV3h8Lqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so2734660276.1
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 13:49:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709329774; x=1709934574;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r7igmuxmZwYYcE/euTDb6HJTLC6nknh4YA8tjKPHqK4=;
        b=cnzYw05TU9r0ZnsXCBl3NXFhlEBOXuz4Z6Z8/TbBCp3r1pFeyUTJd0fgSMEyg+Jzq+
         0GS1A7Hc1XtuEqMDsAu6QVx+pc5bapUPb+iMiZu7wg3s0avVFuWorIpzeCef3DpQeYRs
         dnoiDWDbBLmYDY8uXTrMEu7ozmJ+2kEzFfhGid2BUdE5CNtQHt26IzvbVd/K3m8p2cTb
         VCX7PYMh/75sQhQbnOPiZ/S8NQISjBA/v+I2NOHi8vD/ahivPnG7mBlKMkttkaA3r4hT
         R4omdZVleiZXiiluaIO7A+aexhHWG//MTeTYK2f5u+x/oVwiIGzehakwvsBbmAWelbuM
         Lvaw==
X-Gm-Message-State: AOJu0YyGJtkP4spDNqZKjQbquaJ25kzxbAhsevRZ74aSwYoFextQmuGr
	R7wjYDtmRozobt2D+w0tmcFwYNsluoDdgiqaMUXXkFk/jpcFuzm6
X-Google-Smtp-Source: AGHT+IE8WjHllp02suDsAxHaEailQZBb43M/zH4PCBkIWh311Yq05ZPxcBb8XFPbL1Sw0ZxcvueHow==
X-Received: by 2002:a25:bc12:0:b0:dc7:4806:4fb with SMTP id i18-20020a25bc12000000b00dc7480604fbmr2696781ybh.8.1709329773714;
        Fri, 01 Mar 2024 13:49:33 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id a9-20020a5b0909000000b00dc22f4bf808sm963793ybq.32.2024.03.01.13.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 13:49:31 -0800 (PST)
Date: Fri, 1 Mar 2024 15:49:29 -0600
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Subject: Re: [Bpf] [PATCH bpf-next] bpf, docs: Use IETF format for field
 definitions in instruction-set.rst
Message-ID: <20240301214929.GB192865@maniforge>
References: <20240301192020.15644-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VLfuO3E7K25YLsYh"
Content-Disposition: inline
In-Reply-To: <20240301192020.15644-1-dthaler1968@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--VLfuO3E7K25YLsYh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2024 at 11:20:20AM -0800, Dave Thaler wrote:
> In preparation for publication as an IETF RFC, the WG chairs asked me
> to convert the document to use IETF packet format for field layout, so
> this patch attempts to make it consistent with other IETF documents.
>=20
> Some fields that are not byte aligned were previously inconsistent
> in how values were defined.  Some were defined as the value of the
> byte containing the field (like 0x20 for a field holding the high
> four bits of the byte), and others were defined as the value of the
> field itself (like 0x2).  This PR makes them be consistent in using
> just the values of the field itself, which is IETF convention.
>=20
> As a result, some of the defines that used BPF_* would no longer
> match the value in the spec, and so this patch also drops the BPF_*
> prefix to avoid confusion with the defines that are the full-byte
> equivalent values.  For consistency, BPF_* is then dropped from
> other fields too.  BPF_<foo> is thus the Linux implementation-specific
> define for <foo> as it appears in the BPF ISA specification.
>=20
> The syntax BPF_ADD | BPF_X | BPF_ALU only worked for full-byte
> values so the convention {ADD, X, ALU} is proposed for referring
> to field values instead.
>=20
> Also replace the redundant "LSB bits" with "least significant bits".
>=20
> A preview of what the resulting Internet Draft would look like can
> be seen at:
> https://htmlpreview.github.io/?https://raw.githubusercontent.com/dthaler/=
ebp
> f-docs-1/format/draft-ietf-bpf-isa.html
>=20
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>

Very glad that we were able to do this before sending to WG last call. Thank
you, Dave. I left a couple of comments below but here's my AB:

Acked-by: David Vernet <void@manifault.com>

It's probably worth noting that this probably will make it a tiny bit more
difficult for vendors to implement directly from the standard, but I think
that's a small price to pay for having a doc that's properly formatted and
resembles typical IETF standards.

Thanks,
David

> ---
>  .../bpf/standardization/instruction-set.rst   | 531 ++++++++++--------
>  1 file changed, 290 insertions(+), 241 deletions(-)
>=20
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Docu=
mentation/bpf/standardization/instruction-set.rst
> index f3269d6dd..a0c8fe2f2 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -24,22 +24,22 @@ a type's signedness (`S`) and bit width (`N`), respec=
tively.
>  .. table:: Meaning of signedness notation.
> =20
>    =3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  `S`  Meaning
> +  S    Meaning
>    =3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  `u`  unsigned
> -  `s`  signed
> +  u    unsigned
> +  s    signed
>    =3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
>  .. table:: Meaning of bit-width notation.
> =20
>    =3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  `N`   Bit width
> +  N     Bit width
>    =3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  `8`   8 bits
> -  `16`  16 bits
> -  `32`  32 bits
> -  `64`  64 bits
> -  `128` 128 bits
> +  8     8 bits
> +  16    16 bits
> +  32    32 bits
> +  64    64 bits
> +  128   128 bits
>    =3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
>  For example, `u32` is a type whose valid values are all the 32-bit unsig=
ned
> @@ -48,31 +48,31 @@ numbers.
> =20
>  Functions
>  ---------
> -* `htobe16`: Takes an unsigned 16-bit number in host-endian format and
> +* htobe16: Takes an unsigned 16-bit number in host-endian format and
>    returns the equivalent number as an unsigned 16-bit number in big-endi=
an
>    format.
> -* `htobe32`: Takes an unsigned 32-bit number in host-endian format and
> +* htobe32: Takes an unsigned 32-bit number in host-endian format and
>    returns the equivalent number as an unsigned 32-bit number in big-endi=
an
>    format.
> -* `htobe64`: Takes an unsigned 64-bit number in host-endian format and
> +* htobe64: Takes an unsigned 64-bit number in host-endian format and
>    returns the equivalent number as an unsigned 64-bit number in big-endi=
an
>    format.
> -* `htole16`: Takes an unsigned 16-bit number in host-endian format and
> +* htole16: Takes an unsigned 16-bit number in host-endian format and
>    returns the equivalent number as an unsigned 16-bit number in little-e=
ndian
>    format.
> -* `htole32`: Takes an unsigned 32-bit number in host-endian format and
> +* htole32: Takes an unsigned 32-bit number in host-endian format and
>    returns the equivalent number as an unsigned 32-bit number in little-e=
ndian
>    format.
> -* `htole64`: Takes an unsigned 64-bit number in host-endian format and
> +* htole64: Takes an unsigned 64-bit number in host-endian format and
>    returns the equivalent number as an unsigned 64-bit number in little-e=
ndian
>    format.
> -* `bswap16`: Takes an unsigned 16-bit number in either big- or little-en=
dian
> +* bswap16: Takes an unsigned 16-bit number in either big- or little-endi=
an
>    format and returns the equivalent number with the same bit width but
>    opposite endianness.
> -* `bswap32`: Takes an unsigned 32-bit number in either big- or little-en=
dian
> +* bswap32: Takes an unsigned 32-bit number in either big- or little-endi=
an
>    format and returns the equivalent number with the same bit width but
>    opposite endianness.
> -* `bswap64`: Takes an unsigned 64-bit number in either big- or little-en=
dian
> +* bswap64: Takes an unsigned 64-bit number in either big- or little-endi=
an
>    format and returns the equivalent number with the same bit width but
>    opposite endianness.
> =20
> @@ -135,34 +135,63 @@ Instruction encoding
>  BPF has two instruction encodings:
> =20
>  * the basic instruction encoding, which uses 64 bits to encode an instru=
ction
> -* the wide instruction encoding, which appends a second 64-bit immediate=
 (i.e.,
> -  constant) value after the basic instruction for a total of 128 bits.
> +* the wide instruction encoding, which appends a second 64 bits
> +  after the basic instruction for a total of 128 bits.
> =20
> -The fields conforming an encoded basic instruction are stored in the
> -following order::
> +Basic instruction encoding
> +--------------------------
> =20
> -  opcode:8 src_reg:4 dst_reg:4 offset:16 imm:32 // In little-endian BPF.
> -  opcode:8 dst_reg:4 src_reg:4 offset:16 imm:32 // In big-endian BPF.
> +A basic instruction is encoded as follows::
> =20
> -**imm**
> -  signed integer immediate value
> +  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> +  |    opcode     |     regs      |            offset             |
> +  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> +  |                              imm                              |
> +  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> =20
> -**offset**
> -  signed integer offset used with pointer arithmetic
> +**opcode**
> +  operation to perform, encoded as follows::
> =20
> -**src_reg**
> -  the source register number (0-10), except where otherwise specified
> -  (`64-bit immediate instructions`_ reuse this field for other purposes)
> +    +-+-+-+-+-+-+-+-+
> +    |specific |class|
> +    +-+-+-+-+-+-+-+-+
> =20
> -**dst_reg**
> -  destination register number (0-10)
> +  **specific**
> +    The format of these bits varies by instruction class
> =20
> -**opcode**
> -  operation to perform
> +  **class**
> +    The instruction class (see `Instruction classes`_)
> +
> +**regs**
> +  The source and destination register numbers, encoded as follows
> +  on a little-endian host::
> +
> +    +-+-+-+-+-+-+-+-+
> +    |src_reg|dst_reg|
> +    +-+-+-+-+-+-+-+-+
> +
> +  and as follows on a big-endian host::
> +
> +    +-+-+-+-+-+-+-+-+
> +    |dst_reg|src_reg|
> +    +-+-+-+-+-+-+-+-+
> +
> +  **src_reg**
> +    the source register number (0-10), except where otherwise specified
> +    (`64-bit immediate instructions`_ reuse this field for other purpose=
s)
> +
> +  **dst_reg**
> +    destination register number (0-10)
> +
> +**offset**
> +  signed integer offset used with pointer arithmetic
> +
> +**imm**
> +  signed integer immediate value
> =20
> -Note that the contents of multi-byte fields ('imm' and 'offset') are
> -stored using big-endian byte ordering in big-endian BPF and
> -little-endian byte ordering in little-endian BPF.
> +Note that the contents of multi-byte fields ('offset' and 'imm') are
> +stored using big-endian byte ordering on big-endian hosts and
> +little-endian byte ordering on little-endian hosts.
> =20
>  For example::
> =20
> @@ -175,66 +204,83 @@ For example::
>  Note that most instructions do not use all of the fields.
>  Unused fields shall be cleared to zero.
> =20
> -As discussed below in `64-bit immediate instructions`_, a 64-bit immedia=
te
> -instruction uses two 32-bit immediate values that are constructed as fol=
lows.
> -The 64 bits following the basic instruction contain a pseudo instruction
> -using the same format but with 'opcode', 'dst_reg', 'src_reg', and 'offs=
et' all
> -set to zero, and imm containing the high 32 bits of the immediate value.
> +Wide instruction encoding
> +--------------------------
> +
> +Some instructions are defined to use the wide instruction encoding,
> +which uses two 32-bit immediate values.  The 64 bits following
> +the basic instruction format contain a pseudo instruction
> +with 'opcode', 'dst_reg', 'src_reg', and 'offset' all set to zero.
> =20
>  This is depicted in the following figure::
> =20
> -        basic_instruction
> -  .------------------------------.
> -  |                              |
> -  opcode:8 regs:8 offset:16 imm:32 unused:32 imm:32
> -                                   |              |
> -                                   '--------------'
> -                                  pseudo instruction
> +  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> +  |    opcode     |     regs      |            offset             |
> +  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> +  |                              imm                              |
> +  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> +  |                           reserved                            |
> +  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> +  |                           next_imm                            |
> +  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> +
> +**opcode**
> +  operation to perform, encoded as explained above
> +
> +**regs**
> +  The source and destination register numbers, encoded as explained above
> +
> +**offset**
> +  signed integer offset used with pointer arithmetic
> +
> +**imm**
> +  signed integer immediate value
> +
> +**reserved**
> +  unused, set to zero
> =20
> -Here, the imm value of the pseudo instruction is called 'next_imm'. The =
unused
> -bytes in the pseudo instruction are reserved and shall be cleared to zer=
o.
> +**next_imm**
> +  second signed integer immediate value
> =20
>  Instruction classes
>  -------------------
> =20
> -The three LSB bits of the 'opcode' field store the instruction class:
> -
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -class      value  description                      reference
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -BPF_LD     0x00   non-standard load operations     `Load and store instr=
uctions`_
> -BPF_LDX    0x01   load into register operations    `Load and store instr=
uctions`_
> -BPF_ST     0x02   store from immediate operations  `Load and store instr=
uctions`_
> -BPF_STX    0x03   store from register operations   `Load and store instr=
uctions`_
> -BPF_ALU    0x04   32-bit arithmetic operations     `Arithmetic and jump =
instructions`_
> -BPF_JMP    0x05   64-bit jump operations           `Arithmetic and jump =
instructions`_
> -BPF_JMP32  0x06   32-bit jump operations           `Arithmetic and jump =
instructions`_
> -BPF_ALU64  0x07   64-bit arithmetic operations     `Arithmetic and jump =
instructions`_
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +The three least significant bits of the 'opcode' field store the instruc=
tion class:
> +
> +=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +class  value  description                      reference
> +=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +LD     0x0    non-standard load operations     `Load and store instructi=
ons`_
> +LDX    0x1    load into register operations    `Load and store instructi=
ons`_
> +ST     0x2    store from immediate operations  `Load and store instructi=
ons`_
> +STX    0x3    store from register operations   `Load and store instructi=
ons`_
> +ALU    0x4    32-bit arithmetic operations     `Arithmetic and jump inst=
ructions`_
> +JMP    0x5    64-bit jump operations           `Arithmetic and jump inst=
ructions`_
> +JMP32  0x6    32-bit jump operations           `Arithmetic and jump inst=
ructions`_
> +ALU64  0x7    64-bit arithmetic operations     `Arithmetic and jump inst=
ructions`_
> +=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> =20
>  Arithmetic and jump instructions
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> -For arithmetic and jump instructions (``BPF_ALU``, ``BPF_ALU64``, ``BPF_=
JMP`` and
> -``BPF_JMP32``), the 8-bit 'opcode' field is divided into three parts:
> +For arithmetic and jump instructions (``ALU``, ``ALU64``, ``JMP`` and
> +``JMP32``), the 8-bit 'opcode' field is divided into three parts::
> =20
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -4 bits (MSB)    1 bit   3 bits (LSB)
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -code            source  instruction class
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +  +-+-+-+-+-+-+-+-+
> +  |  code |s|class|
> +  +-+-+-+-+-+-+-+-+
> =20
>  **code**
>    the operation code, whose meaning varies by instruction class
> =20
> -**source**
> +**s (source)**
>    the source operand location, which unless otherwise specified is one o=
f:
> =20
>    =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    source  value  description
>    =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  BPF_K   0x00   use 32-bit 'imm' value as source operand
> -  BPF_X   0x08   use 'src_reg' register value as source operand
> +  K       0      use 32-bit 'imm' value as source operand
> +  X       1      use 'src_reg' register value as source operand
>    =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
>  **instruction class**
> @@ -243,75 +289,75 @@ code            source  instruction class
>  Arithmetic instructions
>  -----------------------
> =20
> -``BPF_ALU`` uses 32-bit wide operands while ``BPF_ALU64`` uses 64-bit wi=
de operands for
> -otherwise identical operations. ``BPF_ALU64`` instructions belong to the
> +``ALU`` uses 32-bit wide operands while ``ALU64`` uses 64-bit wide opera=
nds for
> +otherwise identical operations. ``ALU64`` instructions belong to the
>  base64 conformance group unless noted otherwise.
>  The 'code' field encodes the operation as below, where 'src' and 'dst' r=
efer
>  to the values of the source and destination registers, respectively.
> =20
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> -code       value  offset   description
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> -BPF_ADD    0x00   0        dst +=3D src
> -BPF_SUB    0x10   0        dst -=3D src
> -BPF_MUL    0x20   0        dst \*=3D src
> -BPF_DIV    0x30   0        dst =3D (src !=3D 0) ? (dst / src) : 0
> -BPF_SDIV   0x30   1        dst =3D (src !=3D 0) ? (dst s/ src) : 0
> -BPF_OR     0x40   0        dst \|=3D src
> -BPF_AND    0x50   0        dst &=3D src
> -BPF_LSH    0x60   0        dst <<=3D (src & mask)
> -BPF_RSH    0x70   0        dst >>=3D (src & mask)
> -BPF_NEG    0x80   0        dst =3D -dst
> -BPF_MOD    0x90   0        dst =3D (src !=3D 0) ? (dst % src) : dst
> -BPF_SMOD   0x90   1        dst =3D (src !=3D 0) ? (dst s% src) : dst
> -BPF_XOR    0xa0   0        dst ^=3D src
> -BPF_MOV    0xb0   0        dst =3D src
> -BPF_MOVSX  0xb0   8/16/32  dst =3D (s8,s16,s32)src
> -BPF_ARSH   0xc0   0        :term:`sign extending<Sign Extend>` dst >>=3D=
 (src & mask)
> -BPF_END    0xd0   0        byte swap operations (see `Byte swap instruct=
ions`_ below)
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +name   code   offset   description
> +=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +ADD    0x0    0        dst +=3D src
> +SUB    0x1    0        dst -=3D src
> +MUL    0x2    0        dst \*=3D src
> +DIV    0x3    0        dst =3D (src !=3D 0) ? (dst / src) : 0
> +SDIV   0x3    1        dst =3D (src !=3D 0) ? (dst s/ src) : 0
> +OR     0x4    0        dst \|=3D src
> +AND    0x5    0        dst &=3D src
> +LSH    0x6    0        dst <<=3D (src & mask)
> +RSH    0x7    0        dst >>=3D (src & mask)
> +NEG    0x8    0        dst =3D -dst
> +MOD    0x9    0        dst =3D (src !=3D 0) ? (dst % src) : dst
> +SMOD   0x9    1        dst =3D (src !=3D 0) ? (dst s% src) : dst
> +XOR    0xa    0        dst ^=3D src
> +MOV    0xb    0        dst =3D src
> +MOVSX  0xb    8/16/32  dst =3D (s8,s16,s32)src
> +ARSH   0xc    0        :term:`sign extending<Sign Extend>` dst >>=3D (sr=
c & mask)
> +END    0xd    0        byte swap operations (see `Byte swap instructions=
`_ below)
> +=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> =20
>  Underflow and overflow are allowed during arithmetic operations, meaning
>  the 64-bit or 32-bit value will wrap. If BPF program execution would
>  result in division by zero, the destination register is instead set to z=
ero.
> -If execution would result in modulo by zero, for ``BPF_ALU64`` the value=
 of
> -the destination register is unchanged whereas for ``BPF_ALU`` the upper
> +If execution would result in modulo by zero, for ``ALU64`` the value of
> +the destination register is unchanged whereas for ``ALU`` the upper
>  32 bits of the destination register are zeroed.
> =20
> -``BPF_ADD | BPF_X | BPF_ALU`` means::
> +``{ADD, X, ALU}``, where 'code'=3D``ADD``, 'source'=3D``X``, and 'class'=
=3D``ALU``, means::

For some reason ``ADD``, ``X`` and ``ALU`` aren't rendering correctly when
built with sphinx. It looks like we need to do this:

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Docume=
ntation/bpf/standardization/instruction-set.rst
index a0c8fe2f230a..ffcba257e004 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -324,7 +324,7 @@ If execution would result in modulo by zero, for ``ALU6=
4`` the value of
 the destination register is unchanged whereas for ``ALU`` the upper
 32 bits of the destination register are zeroed.

-``{ADD, X, ALU}``, where 'code'=3D``ADD``, 'source'=3D``X``, and 'class'=
=3D``ALU``, means::
+``{ADD, X, ALU}``, where 'code' =3D ``ADD``, 'source' =3D ``X``, and 'clas=
s' =3D ``ALU``, means::

   dst =3D (u32) ((u32) dst + (u32) src)


> =20
>    dst =3D (u32) ((u32) dst + (u32) src)
> =20
>  where '(u32)' indicates that the upper 32 bits are zeroed.
> =20
> -``BPF_ADD | BPF_X | BPF_ALU64`` means::
> +``{ADD, X, ALU64}`` means::
> =20
>    dst =3D dst + src
> =20
> -``BPF_XOR | BPF_K | BPF_ALU`` means::
> +``{XOR, K, ALU}`` means::
> =20
>    dst =3D (u32) dst ^ (u32) imm
> =20
> -``BPF_XOR | BPF_K | BPF_ALU64`` means::
> +``{XOR, K, ALU64}`` means::

I do certainly personally prefer the notation that was there before, but if
this more closely matches IETF norms then LGTM.

>    dst =3D dst ^ imm
> =20
>  Note that most instructions have instruction offset of 0. Only three ins=
tructions
> -(``BPF_SDIV``, ``BPF_SMOD``, ``BPF_MOVSX``) have a non-zero offset.
> +(``SDIV``, ``SMOD``, ``MOVSX``) have a non-zero offset.
> =20
> -Division, multiplication, and modulo operations for ``BPF_ALU`` are part
> +Division, multiplication, and modulo operations for ``ALU`` are part
>  of the "divmul32" conformance group, and division, multiplication, and
> -modulo operations for ``BPF_ALU64`` are part of the "divmul64" conforman=
ce
> +modulo operations for ``ALU64`` are part of the "divmul64" conformance
>  group.
>  The division and modulo operations support both unsigned and signed flav=
ors.
> =20
> -For unsigned operations (``BPF_DIV`` and ``BPF_MOD``), for ``BPF_ALU``,
> -'imm' is interpreted as a 32-bit unsigned value. For ``BPF_ALU64``,
> +For unsigned operations (``DIV`` and ``MOD``), for ``ALU``,
> +'imm' is interpreted as a 32-bit unsigned value. For ``ALU64``,
>  'imm' is first :term:`sign extended<Sign Extend>` from 32 to 64 bits, an=
d then
>  interpreted as a 64-bit unsigned value.
> =20
> -For signed operations (``BPF_SDIV`` and ``BPF_SMOD``), for ``BPF_ALU``,
> -'imm' is interpreted as a 32-bit signed value. For ``BPF_ALU64``, 'imm'
> +For signed operations (``SDIV`` and ``SMOD``), for ``ALU``,
> +'imm' is interpreted as a 32-bit signed value. For ``ALU64``, 'imm'
>  is first :term:`sign extended<Sign Extend>` from 32 to 64 bits, and then
>  interpreted as a 64-bit signed value.
> =20
> @@ -323,15 +369,15 @@ etc. This specification requires that signed modulo=
 use truncated division
> =20
>     a % n =3D a - n * trunc(a / n)
> =20
> -The ``BPF_MOVSX`` instruction does a move operation with sign extension.
> -``BPF_ALU | BPF_MOVSX`` :term:`sign extends<Sign Extend>` 8-bit and 16-b=
it operands into 32
> +The ``MOVSX`` instruction does a move operation with sign extension.
> +``{MOVSX, X, ALU}`` :term:`sign extends<Sign Extend>` 8-bit and 16-bit o=
perands into 32
>  bit operands, and zeroes the remaining upper 32 bits.
> -``BPF_ALU64 | BPF_MOVSX`` :term:`sign extends<Sign Extend>` 8-bit, 16-bi=
t, and 32-bit
> +``{MOVSX, X, ALU64}`` :term:`sign extends<Sign Extend>` 8-bit, 16-bit, a=
nd 32-bit
>  operands into 64 bit operands.  Unlike other arithmetic instructions,
> -``BPF_MOVSX`` is only defined for register source operands (``BPF_X``).
> +``MOVSX`` is only defined for register source operands (``X``).
> =20
> -The ``BPF_NEG`` instruction is only defined when the source bit is clear
> -(``BPF_K``).
> +The ``NEG`` instruction is only defined when the source bit is clear
> +(``K``).
> =20
>  Shift operations use a mask of 0x3F (63) for 64-bit operations and 0x1F =
(31)
>  for 32-bit operations.
> @@ -339,24 +385,24 @@ for 32-bit operations.
>  Byte swap instructions
>  ----------------------
> =20
> -The byte swap instructions use instruction classes of ``BPF_ALU`` and ``=
BPF_ALU64``
> -and a 4-bit 'code' field of ``BPF_END``.
> +The byte swap instructions use instruction classes of ``ALU`` and ``ALU6=
4``
> +and a 4-bit 'code' field of ``END``.
> =20
>  The byte swap instructions operate on the destination register
>  only and do not use a separate source register or immediate value.
> =20
> -For ``BPF_ALU``, the 1-bit source operand field in the opcode is used to
> +For ``ALU``, the 1-bit source operand field in the opcode is used to
>  select what byte order the operation converts from or to. For
> -``BPF_ALU64``, the 1-bit source operand field in the opcode is reserved
> +``ALU64``, the 1-bit source operand field in the opcode is reserved
>  and must be set to 0.
> =20
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> -class      source     value  description
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> -BPF_ALU    BPF_TO_LE  0x00   convert between host byte order and little =
endian
> -BPF_ALU    BPF_TO_BE  0x08   convert between host byte order and big end=
ian
> -BPF_ALU64  Reserved   0x00   do byte swap unconditionally
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +class  source    value  description
> +=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +ALU    TO_LE     0      convert between host byte order and little endian
> +ALU    TO_BE     1      convert between host byte order and big endian
> +ALU64  Reserved  0      do byte swap unconditionally
> +=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
>  The 'imm' field encodes the width of the swap operations.  The following=
 widths
>  are supported: 16, 32 and 64.  Width 64 operations belong to the base64
> @@ -365,19 +411,19 @@ conformance group.
> =20
>  Examples:
> =20
> -``BPF_ALU | BPF_TO_LE | BPF_END`` with imm =3D 16/32/64 means::
> +``{END, TO_LE, ALU}`` with imm =3D 16/32/64 means::
> =20
>    dst =3D htole16(dst)
>    dst =3D htole32(dst)
>    dst =3D htole64(dst)
> =20
> -``BPF_ALU | BPF_TO_BE | BPF_END`` with imm =3D 16/32/64 means::
> +``{END, TO_BE, ALU}`` with imm =3D 16/32/64 means::
> =20
>    dst =3D htobe16(dst)
>    dst =3D htobe32(dst)
>    dst =3D htobe64(dst)
> =20
> -``BPF_ALU64 | BPF_TO_LE | BPF_END`` with imm =3D 16/32/64 means::
> +``{END, TO_LE, ALU64}`` with imm =3D 16/32/64 means::
> =20
>    dst =3D bswap16(dst)
>    dst =3D bswap32(dst)
> @@ -386,59 +432,59 @@ Examples:
>  Jump instructions
>  -----------------
> =20
> -``BPF_JMP32`` uses 32-bit wide operands and indicates the base32
> -conformance group, while ``BPF_JMP`` uses 64-bit wide operands for
> +``JMP32`` uses 32-bit wide operands and indicates the base32
> +conformance group, while ``JMP`` uses 64-bit wide operands for
>  otherwise identical operations, and indicates the base64 conformance
>  group unless otherwise specified.
>  The 'code' field encodes the operation as below:
> =20
> -=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>  code      value  src_reg  description                      notes
> -=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -BPF_JA    0x0    0x0      PC +=3D offset                     BPF_JMP | B=
PF_K only
> -BPF_JA    0x0    0x0      PC +=3D imm                        BPF_JMP32 |=
 BPF_K only
> -BPF_JEQ   0x1    any      PC +=3D offset if dst =3D=3D src
> -BPF_JGT   0x2    any      PC +=3D offset if dst > src        unsigned
> -BPF_JGE   0x3    any      PC +=3D offset if dst >=3D src       unsigned
> -BPF_JSET  0x4    any      PC +=3D offset if dst & src
> -BPF_JNE   0x5    any      PC +=3D offset if dst !=3D src
> -BPF_JSGT  0x6    any      PC +=3D offset if dst > src        signed
> -BPF_JSGE  0x7    any      PC +=3D offset if dst >=3D src       signed
> -BPF_CALL  0x8    0x0      call helper function by address  BPF_JMP | BPF=
_K only, see `Helper functions`_
> -BPF_CALL  0x8    0x1      call PC +=3D imm                   BPF_JMP | B=
PF_K only, see `Program-local functions`_
> -BPF_CALL  0x8    0x2      call helper function by BTF ID   BPF_JMP | BPF=
_K only, see `Helper functions`_
> -BPF_EXIT  0x9    0x0      return                           BPF_JMP | BPF=
_K only
> -BPF_JLT   0xa    any      PC +=3D offset if dst < src        unsigned
> -BPF_JLE   0xb    any      PC +=3D offset if dst <=3D src       unsigned
> -BPF_JSLT  0xc    any      PC +=3D offset if dst < src        signed
> -BPF_JSLE  0xd    any      PC +=3D offset if dst <=3D src       signed
> -=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -The BPF program needs to store the return value into register R0 before =
doing a
> -``BPF_EXIT``.
> +=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +JA        0x0    0x0      PC +=3D offset                     {JA, K, JMP=
} only
> +JA        0x0    0x0      PC +=3D imm                        {JA, K, JMP=
32} only
> +JEQ       0x1    any      PC +=3D offset if dst =3D=3D src
> +JGT       0x2    any      PC +=3D offset if dst > src        unsigned
> +JGE       0x3    any      PC +=3D offset if dst >=3D src       unsigned
> +JSET      0x4    any      PC +=3D offset if dst & src
> +JNE       0x5    any      PC +=3D offset if dst !=3D src
> +JSGT      0x6    any      PC +=3D offset if dst > src        signed
> +JSGE      0x7    any      PC +=3D offset if dst >=3D src       signed
> +CALL      0x8    0x0      call helper function by address  {CALL, K, JMP=
} only, see `Helper functions`_
> +CALL      0x8    0x1      call PC +=3D imm                   {CALL, K, J=
MP} only, see `Program-local functions`_
> +CALL      0x8    0x2      call helper function by BTF ID   {CALL, K, JMP=
} only, see `Helper functions`_
> +EXIT      0x9    0x0      return                           {CALL, K, JMP=
} only
> +JLT       0xa    any      PC +=3D offset if dst < src        unsigned
> +JLE       0xb    any      PC +=3D offset if dst <=3D src       unsigned
> +JSLT      0xc    any      PC +=3D offset if dst < src        signed
> +JSLE      0xd    any      PC +=3D offset if dst <=3D src       signed
> +=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +
> +The BPF program needs to store the return value into register R0 before =
doing an
> +``EXIT``.
> =20
>  Example:
> =20
> -``BPF_JSGE | BPF_X | BPF_JMP32`` (0x7e) means::
> +``{JSGE, X, JMP32}`` means::
> =20
>    if (s32)dst s>=3D (s32)src goto +offset
> =20
>  where 's>=3D' indicates a signed '>=3D' comparison.
> =20
> -``BPF_JA | BPF_K | BPF_JMP32`` (0x06) means::
> +``{JA, K, JMP32}`` means::
> =20
>    gotol +imm
> =20
>  where 'imm' means the branch offset comes from insn 'imm' field.
> =20
> -Note that there are two flavors of ``BPF_JA`` instructions. The
> -``BPF_JMP`` class permits a 16-bit jump offset specified by the 'offset'
> -field, whereas the ``BPF_JMP32`` class permits a 32-bit jump offset
> +Note that there are two flavors of ``JA`` instructions. The
> +``JMP`` class permits a 16-bit jump offset specified by the 'offset'
> +field, whereas the ``JMP32`` class permits a 32-bit jump offset
>  specified by the 'imm' field. A > 16-bit conditional jump may be
>  converted to a < 16-bit conditional jump plus a 32-bit unconditional
>  jump.
> =20
> -All ``BPF_CALL`` and ``BPF_JA`` instructions belong to the
> +All ``CALL`` and ``JA`` instructions belong to the
>  base32 conformance group.
> =20
>  Helper functions
> @@ -459,80 +505,83 @@ Program-local functions
>  ~~~~~~~~~~~~~~~~~~~~~~~
>  Program-local functions are functions exposed by the same BPF program as=
 the
>  caller, and are referenced by offset from the call instruction, similar =
to
> -``BPF_JA``.  The offset is encoded in the imm field of the call instruct=
ion.
> -A ``BPF_EXIT`` within the program-local function will return to the call=
er.
> +``JA``.  The offset is encoded in the imm field of the call instruction.
> +A ``EXIT`` within the program-local function will return to the caller.
> =20
>  Load and store instructions
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> =20
> -For load and store instructions (``BPF_LD``, ``BPF_LDX``, ``BPF_ST``, an=
d ``BPF_STX``), the
> -8-bit 'opcode' field is divided as:
> -
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -3 bits (MSB)  2 bits  3 bits (LSB)
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -mode          size    instruction class
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -The mode modifier is one of:
> -
> -  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  mode modifier  value  description                           reference
> -  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  BPF_IMM        0x00   64-bit immediate instructions         `64-bit im=
mediate instructions`_
> -  BPF_ABS        0x20   legacy BPF packet access (absolute)   `Legacy BP=
F Packet access instructions`_
> -  BPF_IND        0x40   legacy BPF packet access (indirect)   `Legacy BP=
F Packet access instructions`_
> -  BPF_MEM        0x60   regular load and store operations     `Regular l=
oad and store operations`_
> -  BPF_MEMSX      0x80   sign-extension load operations        `Sign-exte=
nsion load operations`_
> -  BPF_ATOMIC     0xc0   atomic operations                     `Atomic op=
erations`_
> -  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -The size modifier is one of:
> -
> -  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  size modifier  value  description
> -  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  BPF_W          0x00   word        (4 bytes)
> -  BPF_H          0x08   half word   (2 bytes)
> -  BPF_B          0x10   byte
> -  BPF_DW         0x18   double word (8 bytes)
> -  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -Instructions using ``BPF_DW`` belong to the base64 conformance group.
> +For load and store instructions (``LD``, ``LDX``, ``ST``, and ``STX``), =
the
> +8-bit 'opcode' field is divided as::
> +
> +  +-+-+-+-+-+-+-+-+
> +  |mode |sz |class|
> +  +-+-+-+-+-+-+-+-+
> +
> +**mode**
> +  The mode modifier is one of:
> +
> +    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +    mode modifier  value  description                           reference
> +    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +    IMM            0      64-bit immediate instructions         `64-bit =
immediate instructions`_
> +    ABS            1      legacy BPF packet access (absolute)   `Legacy =
BPF Packet access instructions`_
> +    IND            2      legacy BPF packet access (indirect)   `Legacy =
BPF Packet access instructions`_
> +    MEM            3      regular load and store operations     `Regular=
 load and store operations`_
> +    MEMSX          4      sign-extension load operations        `Sign-ex=
tension load operations`_
> +    ATOMIC         6      atomic operations                     `Atomic =
operations`_
> +    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +**sz (size)**
> +  The size modifier is one of:
> +
> +    =3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +    size  value  description
> +    =3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +    W     0      word        (4 bytes)
> +    H     1      half word   (2 bytes)
> +    B     2      byte
> +    DW    3      double word (8 bytes)
> +    =3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +  Instructions using ``DW`` belong to the base64 conformance group.
> +
> +**class**
> +  The instruction class (see `Instruction classes`_)
> =20
>  Regular load and store operations
>  ---------------------------------
> =20
> -The ``BPF_MEM`` mode modifier is used to encode regular load and store
> +The ``MEM`` mode modifier is used to encode regular load and store
>  instructions that transfer data between a register and memory.
> =20
> -``BPF_MEM | <size> | BPF_STX`` means::
> +``{MEM, <size>, STX}`` means::
> =20
>    *(size *) (dst + offset) =3D src
> =20
> -``BPF_MEM | <size> | BPF_ST`` means::
> +``{MEM, <size>, ST}`` means::
> =20
>    *(size *) (dst + offset) =3D imm
> =20
> -``BPF_MEM | <size> | BPF_LDX`` means::
> +``{MEM, <size>, LDX}`` means::
> =20
>    dst =3D *(unsigned size *) (src + offset)
> =20
> -Where size is one of: ``BPF_B``, ``BPF_H``, ``BPF_W``, or ``BPF_DW`` and
> -'unsigned size' is one of u8, u16, u32 or u64.
> +Where '<size>' is one of: ``B``, ``H``, ``W``, or ``DW``, and
> +'unsigned size' is one of: u8, u16, u32, or u64.
> =20
>  Sign-extension load operations
>  ------------------------------
> =20
> -The ``BPF_MEMSX`` mode modifier is used to encode :term:`sign-extension<=
Sign Extend>` load
> +The ``MEMSX`` mode modifier is used to encode :term:`sign-extension<Sign=
 Extend>` load
>  instructions that transfer data between a register and memory.
> =20
> -``BPF_MEMSX | <size> | BPF_LDX`` means::
> +``{MEMSX, <size>, LDX}`` means::
> =20
>    dst =3D *(signed size *) (src + offset)
> =20
> -Where size is one of: ``BPF_B``, ``BPF_H`` or ``BPF_W``, and
> -'signed size' is one of s8, s16 or s32.
> +Where size is one of: ``B``, ``H``, or ``W``, and
> +'signed size' is one of: s8, s16, or s32.
> =20
>  Atomic operations
>  -----------------
> @@ -542,11 +591,11 @@ interrupted or corrupted by other access to the sam=
e memory region
>  by other BPF programs or means outside of this specification.
> =20
>  All atomic operations supported by BPF are encoded as store operations
> -that use the ``BPF_ATOMIC`` mode modifier as follows:
> +that use the ``ATOMIC`` mode modifier as follows:
> =20
> -* ``BPF_ATOMIC | BPF_W | BPF_STX`` for 32-bit operations, which are
> +* ``{ATOMIC, W, STX}`` for 32-bit operations, which are
>    part of the "atomic32" conformance group.
> -* ``BPF_ATOMIC | BPF_DW | BPF_STX`` for 64-bit operations, which are
> +* ``{ATOMIC, DW, STX}`` for 64-bit operations, which are
>    part of the "atomic64" conformance group.
>  * 8-bit and 16-bit wide atomic operations are not supported.
> =20
> @@ -557,18 +606,18 @@ arithmetic operations in the 'imm' field to encode =
the atomic operation:
>  =3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>  imm       value  description
>  =3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> -BPF_ADD   0x00   atomic add
> -BPF_OR    0x40   atomic or
> -BPF_AND   0x50   atomic and
> -BPF_XOR   0xa0   atomic xor
> +ADD       0x00   atomic add
> +OR        0x40   atomic or
> +AND       0x50   atomic and
> +XOR       0xa0   atomic xor
>  =3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> =20
> =20
> -``BPF_ATOMIC | BPF_W  | BPF_STX`` with 'imm' =3D BPF_ADD means::
> +``{ATOMIC, W, STX}`` with 'imm' =3D ADD means::
> =20
>    *(u32 *)(dst + offset) +=3D src
> =20
> -``BPF_ATOMIC | BPF_DW | BPF_STX`` with 'imm' =3D BPF_ADD means::
> +``{ATOMIC, DW, STX}`` with 'imm' =3D ADD means::
> =20
>    *(u64 *)(dst + offset) +=3D src
> =20
> @@ -578,20 +627,20 @@ two complex atomic operations:
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>  imm          value             description
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> -BPF_FETCH    0x01              modifier: return old value
> -BPF_XCHG     0xe0 | BPF_FETCH  atomic exchange
> -BPF_CMPXCHG  0xf0 | BPF_FETCH  atomic compare and exchange
> +FETCH        0x01              modifier: return old value
> +XCHG         0xe0 | FETCH      atomic exchange
> +CMPXCHG      0xf0 | FETCH      atomic compare and exchange
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> =20
> -The ``BPF_FETCH`` modifier is optional for simple atomic operations, and
> -always set for the complex atomic operations.  If the ``BPF_FETCH`` flag
> +The ``FETCH`` modifier is optional for simple atomic operations, and
> +always set for the complex atomic operations.  If the ``FETCH`` flag
>  is set, then the operation also overwrites ``src`` with the value that
>  was in memory before it was modified.
> =20
> -The ``BPF_XCHG`` operation atomically exchanges ``src`` with the value
> +The ``XCHG`` operation atomically exchanges ``src`` with the value
>  addressed by ``dst + offset``.
> =20
> -The ``BPF_CMPXCHG`` operation atomically compares the value addressed by
> +The ``CMPXCHG`` operation atomically compares the value addressed by
>  ``dst + offset`` with ``R0``. If they match, the value addressed by
>  ``dst + offset`` is replaced with ``src``. In either case, the
>  value that was at ``dst + offset`` before the operation is zero-extended
> @@ -600,25 +649,25 @@ and loaded back to ``R0``.
>  64-bit immediate instructions
>  -----------------------------
> =20
> -Instructions with the ``BPF_IMM`` 'mode' modifier use the wide instructi=
on
> +Instructions with the ``IMM`` 'mode' modifier use the wide instruction
>  encoding defined in `Instruction encoding`_, and use the 'src_reg' field=
 of the
>  basic instruction to hold an opcode subtype.
> =20
> -The following table defines a set of ``BPF_IMM | BPF_DW | BPF_LD`` instr=
uctions
> +The following table defines a set of ``{IMM, DW, LD}`` instructions
>  with opcode subtypes in the 'src_reg' field, using new terms such as "ma=
p"
>  defined further below:
> =20
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -opcode construction        opcode  src_reg  pseudocode                  =
               imm type     dst type
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -BPF_IMM | BPF_DW | BPF_LD  0x18    0x0      dst =3D (next_imm << 32) | i=
mm               integer      integer
> -BPF_IMM | BPF_DW | BPF_LD  0x18    0x1      dst =3D map_by_fd(imm)      =
                 map fd       map
> -BPF_IMM | BPF_DW | BPF_LD  0x18    0x2      dst =3D map_val(map_by_fd(im=
m)) + next_imm   map fd       data pointer
> -BPF_IMM | BPF_DW | BPF_LD  0x18    0x3      dst =3D var_addr(imm)       =
                 variable id  data pointer
> -BPF_IMM | BPF_DW | BPF_LD  0x18    0x4      dst =3D code_addr(imm)      =
                 integer      code pointer
> -BPF_IMM | BPF_DW | BPF_LD  0x18    0x5      dst =3D map_by_idx(imm)     =
                 map index    map
> -BPF_IMM | BPF_DW | BPF_LD  0x18    0x6      dst =3D map_val(map_by_idx(i=
mm)) + next_imm  map index    data pointer
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +src_reg  pseudocode                                 imm type     dst type
> +=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +0x0      dst =3D (next_imm << 32) | imm               integer      integ=
er
> +0x1      dst =3D map_by_fd(imm)                       map fd       map
> +0x2      dst =3D map_val(map_by_fd(imm)) + next_imm   map fd       data =
pointer
> +0x3      dst =3D var_addr(imm)                        variable id  data =
pointer
> +0x4      dst =3D code_addr(imm)                       integer      code =
pointer
> +0x5      dst =3D map_by_idx(imm)                      map index    map
> +0x6      dst =3D map_val(map_by_idx(imm)) + next_imm  map index    data =
pointer
> +=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> =20
>  where
> =20
> @@ -657,8 +706,8 @@ Legacy BPF Packet access instructions
> =20
>  BPF previously introduced special instructions for access to packet data=
 that were
>  carried over from classic BPF. These instructions used an instruction
> -class of BPF_LD, a size modifier of BPF_W, BPF_H, or BPF_B, and a
> -mode modifier of BPF_ABS or BPF_IND.  The 'dst_reg' and 'offset' fields =
were
> -set to zero, and 'src_reg' was set to zero for BPF_ABS.  However, these
> +class of ``LD``, a size modifier of ``W``, ``H``, or ``B``, and a
> +mode modifier of ``ABS`` or ``IND``.  The 'dst_reg' and 'offset' fields =
were
> +set to zero, and 'src_reg' was set to zero for ``ABS``.  However, these
>  instructions are deprecated and should no longer be used.  All legacy pa=
cket
>  access instructions belong to the "legacy" conformance group.
> --=20
> 2.40.1
>=20
>=20
> --=20
> Bpf mailing list
> Bpf@ietf.org
> https://www.ietf.org/mailman/listinfo/bpf

--VLfuO3E7K25YLsYh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZeJNaQAKCRBZ5LhpZcTz
ZFUAAPwMfUv72bgxAi1cqZC38hnYPesJ/h2F17ocNvtEgmrsoAD/XvANnxBSVPRb
PdFBeAH8SYLmUvdt8AOlIeKXyPgzbwo=
=xDDv
-----END PGP SIGNATURE-----

--VLfuO3E7K25YLsYh--


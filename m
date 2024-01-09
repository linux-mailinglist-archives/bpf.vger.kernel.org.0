Return-Path: <bpf+bounces-19270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E8B828B51
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 18:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDA22B215A6
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 17:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB45B3B780;
	Tue,  9 Jan 2024 17:32:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6145E3A8F1
	for <bpf@vger.kernel.org>; Tue,  9 Jan 2024 17:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-680285e7ce8so24935236d6.0
        for <bpf@vger.kernel.org>; Tue, 09 Jan 2024 09:32:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704821550; x=1705426350;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gil9TCcz70cjrnfTlo7t4MCUDEskdNthMK8C2ql1I/M=;
        b=qEFOvEllQpbo0om+kSsXFbctsijuJ87MbmALwdY8Eob4fdY73hmR6JwQX0l6lryjIg
         bgpkTODspIQum6d8gRJD9yIKO1rUiXoKDCy+c2/SqlS+9SxsPmTQLYhz6qn/90eNB7Ww
         227WU3OqnXuZA9wrNNQ9/YLYYXeZfWeSwyip0imfdk1TliNdBkI3rsIFY3XV77cCGhnf
         oUjD8B4yXsFv/B/NBaDe7o8k9JiZKyW1tM4uqRIsaRqfKrySjvbuJNAu+pWc68UP13Fa
         xHp6nQoKWqQdgp8HFmhBIAZxKD3vcxJQmxqKWkoU7CZsqLjMzZGNL1vg2gq++j7Cqjm/
         02Jw==
X-Gm-Message-State: AOJu0YxJ5WTb06X7fcZ+sC2JrejJGh7u0FLQyr61rPIdzbQuvN+OXpAj
	Ysqq0Heg5oBq8VaWDmeD8qg=
X-Google-Smtp-Source: AGHT+IEJJyOWG2GTCXcE5C0UaM/jPlmKnELLoMVQz/qK3h10M2or9Fqqb+sM0y9XTdVvZaDjB9+dGw==
X-Received: by 2002:ad4:5d63:0:b0:67a:a714:d963 with SMTP id fn3-20020ad45d63000000b0067aa714d963mr7760958qvb.55.1704821549987;
        Tue, 09 Jan 2024 09:32:29 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id u25-20020a05620a121900b007831f5c6b65sm958555qkj.47.2024.01.09.09.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 09:32:29 -0800 (PST)
Date: Tue, 9 Jan 2024 11:32:27 -0600
From: David Vernet <void@manifault.com>
To: Aoyang Fang <aoyangfang@link.cuhk.edu.cn>
Cc: bpf@vger.kernel.org, bpf@ietf.org, dthaler1968@googlemail.com
Subject: Re: [PATCH bpf-next] The original document has some inconsistency.
Message-ID: <20240109173227.GB79024@maniforge>
References: <20240105031450.57681-2-aoyangfang@link.cuhk.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4mn7ABAeff0rqV63"
Content-Disposition: inline
In-Reply-To: <20240105031450.57681-2-aoyangfang@link.cuhk.edu.cn>
User-Agent: Mutt/2.2.12 (2023-09-09)


--4mn7ABAeff0rqV63
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 05, 2024 at 11:14:51AM +0800, Aoyang Fang wrote:

Hi Aoyang,

Thanks a lot for your contribution. I agree that we need to fix the
document to be consistent, though I'm afraid that I think this patch
goes in the wrong direction by making everything match the jump
instruction class. More below.

nit: Could you please update the patch subject to be more
self-describing. For example, something like:

Use consistent numerical widths in instructions.rst encodings

> For example:
> 1. 1.3.1 Arithmetic instructions use '8 bits length' encoding to
>    express the 'code' value, e.g., BPF_ADD=3D0x00, BPF_SUB=3D0x10,
>    BPF_MUL=3D0x20. However the length of the 'code' is 4 bits. On the
>    other hand, 1.3.3 Jump instructions use '4 bits length' encoding,
>    e.g., BPF_JEQ=3D0x1 and BPF_JGT=3D0x2.
> 2. There are also many places that use '8 bits length' encoding to
>    express the corresponding contents, e.g., 1.4 Load and store
>    instructions, BPF_ABS=3D0x20, BPF_IND=3D0x40. However, the length of
>    'mode modifier' is 3 bits.
>=20
> To summarize, the only place that has inconsistent encoding is Jump
> instructions. After discussing with Dave, dthaler1968@googlemail.com,
> we agree that the document should be more clear.
>=20
> Signed-off-by: Aoyang Fang <aoyangfang@link.cuhk.edu.cn>
>
> ---
>  .../bpf/standardization/instruction-set.rst   | 170 +++++++++---------
>  1 file changed, 85 insertions(+), 85 deletions(-)
>=20
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Docu=
mentation/bpf/standardization/instruction-set.rst
> index 245b6defc..57dd1fa00 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -172,18 +172,18 @@ Instruction classes
> =20
>  The three LSB bits of the 'opcode' field store the instruction class:
> =20
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
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +class      value(3 bits)  description                      reference
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +BPF_LD     0x0            non-standard load operations     `Load and sto=
re instructions`_
> +BPF_LDX    0x1            load into register operations    `Load and sto=
re instructions`_
> +BPF_ST     0x2            store from immediate operations  `Load and sto=
re instructions`_
> +BPF_STX    0x3            store from register operations   `Load and sto=
re instructions`_
> +BPF_ALU    0x4            32-bit arithmetic operations     `Arithmetic a=
nd jump instructions`_
> +BPF_JMP    0x5            64-bit jump operations           `Arithmetic a=
nd jump instructions`_
> +BPF_JMP32  0x6            32-bit jump operations           `Arithmetic a=
nd jump instructions`_
> +BPF_ALU64  0x7            64-bit arithmetic operations     `Arithmetic a=
nd jump instructions`_
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Hmm, I presonally think this is more confusing. The opcode field is 8
bits. We already specify that the value is the three LSB of the opcode
field. It's certainly subjective, but I think we should have the value
reflect the actual value in the field it's embedded in. In my opinion,
changing the value to not reflect its place in the actual opcode in my
opinion imposes a burden on the reader to go back and reference where
the field actually belongs in the full opcode. It's a tradeoff, but I
think we're already on the winning end of that tradeoff.

>  Arithmetic and jump instructions
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> @@ -203,12 +203,12 @@ code            source  instruction class
>  **source**
>    the source operand location, which unless otherwise specified is one o=
f:
> =20
> -  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  source  value  description
> -  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  BPF_K   0x00   use 32-bit 'imm' value as source operand
> -  BPF_X   0x08   use 'src_reg' register value as source operand
> -  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +  source  value(1 bit)  description
> +  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +  BPF_K   0x0           use 32-bit 'imm' value as source operand
> +  BPF_X   0x1           use 'src_reg' register value as source operand
> +  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Same here as well. The value isn't really 0x1, it's 0x8. And 0x08 is
even more clear yet, given that we're representing the value of the bit
in the 8 bit opcode field.

>  **instruction class**
>    the instruction class (see `Instruction classes`_)
> @@ -221,27 +221,27 @@ otherwise identical operations.
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
>
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =
=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +code       value(4 bits)  offset   description
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =
=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +BPF_ADD    0x0            0        dst +=3D src
> +BPF_SUB    0x1            0        dst -=3D src
> +BPF_MUL    0x2            0        dst \*=3D src
> +BPF_DIV    0x3            0        dst =3D (src !=3D 0) ? (dst / src) : 0
> +BPF_SDIV   0x3            1        dst =3D (src !=3D 0) ? (dst s/ src) :=
 0
> +BPF_OR     0x4            0        dst \|=3D src
> +BPF_AND    0x5            0        dst &=3D src
> +BPF_LSH    0x6            0        dst <<=3D (src & mask)
> +BPF_RSH    0x7            0        dst >>=3D (src & mask)
> +BPF_NEG    0x8            0        dst =3D -dst
> +BPF_MOD    0x9            0        dst =3D (src !=3D 0) ? (dst % src) : =
dst
> +BPF_SMOD   0x9            1        dst =3D (src !=3D 0) ? (dst s% src) :=
 dst
> +BPF_XOR    0xa            0        dst ^=3D src
> +BPF_MOV    0xb            0        dst =3D src
> +BPF_MOVSX  0xb            8/16/32  dst =3D (s8,s16,s32)src
> +BPF_ARSH   0xc            0        :term:`sign extending<Sign Extend>` d=
st >>=3D (src & mask)
> +BPF_END    0xd            0        byte swap operations (see `Byte swap =
instructions`_ below)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =
=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Same here.

>  Underflow and overflow are allowed during arithmetic operations, meaning
>  the 64-bit or 32-bit value will wrap. If BPF program execution would
> @@ -314,13 +314,13 @@ select what byte order the operation converts from =
or to. For
>  ``BPF_ALU64``, the 1-bit source operand field in the opcode is reserved
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
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +class      source     value(1 bit)  description
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +BPF_ALU    BPF_TO_LE  0x0           convert between host byte order and =
little endian
> +BPF_ALU    BPF_TO_BE  0x1           convert between host byte order and =
big endian
> +BPF_ALU64  Reserved   0x0           do byte swap unconditionally
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

Same here. Which bit does the 0x1 actually correspond to? It's
self-evident in the former, not the latter.

> =20
>  The 'imm' field encodes the width of the swap operations.  The following=
 widths
>  are supported: 16, 32 and 64.
> @@ -352,27 +352,27 @@ Jump instructions
>  otherwise identical operations.
>  The 'code' field encodes the operation as below:
> =20
> -=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D  =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> -code      value  src  description                                  notes
> -=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D  =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> -BPF_JA    0x0    0x0  PC +=3D offset                                 BPF=
_JMP class
> -BPF_JA    0x0    0x0  PC +=3D imm                                    BPF=
_JMP32 class
> -BPF_JEQ   0x1    any  PC +=3D offset if dst =3D=3D src
> -BPF_JGT   0x2    any  PC +=3D offset if dst > src                    uns=
igned
> -BPF_JGE   0x3    any  PC +=3D offset if dst >=3D src                   u=
nsigned
> -BPF_JSET  0x4    any  PC +=3D offset if dst & src
> -BPF_JNE   0x5    any  PC +=3D offset if dst !=3D src
> -BPF_JSGT  0x6    any  PC +=3D offset if dst > src                    sig=
ned
> -BPF_JSGE  0x7    any  PC +=3D offset if dst >=3D src                   s=
igned
> -BPF_CALL  0x8    0x0  call helper function by address              see `=
Helper functions`_
> -BPF_CALL  0x8    0x1  call PC +=3D imm                               see=
 `Program-local functions`_
> -BPF_CALL  0x8    0x2  call helper function by BTF ID               see `=
Helper functions`_
> -BPF_EXIT  0x9    0x0  return                                       BPF_J=
MP only
> -BPF_JLT   0xa    any  PC +=3D offset if dst < src                    uns=
igned
> -BPF_JLE   0xb    any  PC +=3D offset if dst <=3D src                   u=
nsigned
> -BPF_JSLT  0xc    any  PC +=3D offset if dst < src                    sig=
ned
> -BPF_JSLE  0xd    any  PC +=3D offset if dst <=3D src                   s=
igned
> -=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D  =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=
=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +code      value(4 bits)  src  description                               =
   notes
> +=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=
=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +BPF_JA    0x0            0x0  PC +=3D offset                            =
     BPF_JMP class
> +BPF_JA    0x0            0x0  PC +=3D imm                               =
     BPF_JMP32 class
> +BPF_JEQ   0x1            any  PC +=3D offset if dst =3D=3D src
> +BPF_JGT   0x2            any  PC +=3D offset if dst > src               =
     unsigned
> +BPF_JGE   0x3            any  PC +=3D offset if dst >=3D src            =
       unsigned
> +BPF_JSET  0x4            any  PC +=3D offset if dst & src
> +BPF_JNE   0x5            any  PC +=3D offset if dst !=3D src
> +BPF_JSGT  0x6            any  PC +=3D offset if dst > src               =
     signed
> +BPF_JSGE  0x7            any  PC +=3D offset if dst >=3D src            =
       signed
> +BPF_CALL  0x8            0x0  call helper function by address           =
   see `Helper functions`_
> +BPF_CALL  0x8            0x1  call PC +=3D imm                          =
     see `Program-local functions`_
> +BPF_CALL  0x8            0x2  call helper function by BTF ID            =
   see `Helper functions`_
> +BPF_EXIT  0x9            0x0  return                                    =
   BPF_JMP only
> +BPF_JLT   0xa            any  PC +=3D offset if dst < src               =
     unsigned
> +BPF_JLE   0xb            any  PC +=3D offset if dst <=3D src            =
       unsigned
> +BPF_JSLT  0xc            any  PC +=3D offset if dst < src               =
     signed
> +BPF_JSLE  0xd            any  PC +=3D offset if dst <=3D src            =
       signed
> +=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=
=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Good catch, this definitely needed to be fixed. I personally would vote
to update it to match the other instruction classes, rather than
updating the other ones to match jump instructions. What do you think?

Thanks,
David

--4mn7ABAeff0rqV63
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZZ2DKwAKCRBZ5LhpZcTz
ZEVwAP443MjFq5VJ9D8/Hz0Z3QJ/T3tEAJw440JUC5CMoku7KQEAo2AWeWLbi5/N
NUp3O8Vaqf5HeXtTE1Mk0V7SuI+HPAY=
=qKnd
-----END PGP SIGNATURE-----

--4mn7ABAeff0rqV63--


Return-Path: <bpf+bounces-19005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FA9823B28
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 04:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6F891C24A1C
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 03:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055025681;
	Thu,  4 Jan 2024 03:40:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DE35258
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 03:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dbdc52f2359so104344276.3
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 19:39:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704339597; x=1704944397;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUqPSUfrIPOL1uXR1pm95hr2+CVxs8yp09wLUY6ssNo=;
        b=LfEIP0t36QPsS/r7nBSLIPZC0amypn5gaFHIJHeFXVnNWelAsICC67cBE+LtjiYIBW
         YeR9WDh/Nej5Q30c2JcvH7BiLQFqJ5vI5oFZGxq2VMBrE9pSUTtt7/1Dwo3MeyR7awYP
         7YS5GSizTCn90oqZmgpXxaro9m7I14U/YS6iag1b6dsULly3rHTfmiqfjO/b7eY+2P79
         cobU4H8lXbilJCnS+L3UQjiYJa+4g4AtqY7zA81Pe2CIJKYhBOrbL9AXZApcvP6+4V3G
         Iamw6/xMS+u5qZF3OO7ZcKbuCtw3GooAkuxnTuxw8xHh6fvlnrk9qktP1VsdHLU4VlZJ
         TRTw==
X-Gm-Message-State: AOJu0YxKZrOMrjQ+REHyTkuEFvYvsA1QdaaVUA3/kI4YejRd62s6lXBd
	Rndl9EVGzfzF5DK4jpq1TYM0htmV3DavrQ==
X-Google-Smtp-Source: AGHT+IFO+87vWRR8RS1szy3Pcb6hJD5nj6OhfAJKpOjoGCYle6aBaEw+ugceWsf69tgOiyF8F8midA==
X-Received: by 2002:a25:dc44:0:b0:dbd:b5e8:6303 with SMTP id y65-20020a25dc44000000b00dbdb5e86303mr28494ybe.108.1704339597434;
        Wed, 03 Jan 2024 19:39:57 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id dm6-20020ad44e26000000b0067f6ec98ae9sm11406751qvb.32.2024.01.03.19.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 19:39:56 -0800 (PST)
Date: Wed, 3 Jan 2024 21:39:54 -0600
From: David Vernet <void@manifault.com>
To: "Aoyang Fang (SSE, 222010547)" <aoyangfang@link.cuhk.edu.cn>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"bpf@ietf.org" <bpf@ietf.org>
Subject: Re: [PATCH] update the consistency issue in documentation
Message-ID: <20240104033954.GC303539@maniforge>
References: <F349E672-63EB-4DA3-84F8-45E360E02594@link.cuhk.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1brf73tkHEfxX8Ia"
Content-Disposition: inline
In-Reply-To: <F349E672-63EB-4DA3-84F8-45E360E02594@link.cuhk.edu.cn>
User-Agent: Mutt/2.2.12 (2023-09-09)


--1brf73tkHEfxX8Ia
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 04, 2024 at 03:09:32AM +0000, Aoyang Fang (SSE, 222010547) wrot=
e:
> From fa9f3f47ddeb3e9a615c17aea57d2ecd53a7d201 Mon Sep 17 00:00:00 2001
> From: lincyawer <53161583+Lincyaw@users.noreply.github.com>
> Date: Thu, 4 Jan 2024 10:51:36 +0800
> Subject: [PATCH] The original documentation of BPF_JMP instructions is so=
mehow
> misleading. The code part of instruction, e.g., BPF_JEQ's value is noted =
as
> 0x1, however, in `include/uapi/linux/bpf.h`, the value of BPF_JEQ is 0x10=
=2E At
> the same time, the description convention is inconsistent with the BPF_AL=
U,
> whose code are also 4bit, but the value of BPF_ADD is 0x00
>=20
> Signed-off-by: lincyawer <53161583+Lincyaw@users.noreply.github.com>

Hi Aoyang,

Could you please resend this patch to the lists in plain text? The Linux
kernel mailing lists will drop html-encoded emails. Please see [0] for
more information. You can just use git send-email with a patch file as
follows:

$ git format-patch HEAD~ --subject-prefix=3D'PATCH bpf-next' HEAD~
$ git send-email <patch> --to bpf@vger.kernel.org --cc bpf@ietf.org

[0]: https://docs.kernel.org/process/submitting-patches.html#no-mime-no-lin=
ks-no-compression-no-attachments-just-plain-text

Please make sure that the Signed-off-by tag includes your name and real
email address as well.

Thanks,
David

> ---
> .../bpf/standardization/instruction-set.rst | 34 +++++++++----------
> 1 file changed, 17 insertions(+), 17 deletions(-)
>=20
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Docu=
mentation/bpf/standardization/instruction-set.rst
> index 245b6defc..dee3b1fa8 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -355,23 +355,23 @@ The 'code' field encodes the operation as below:
> =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D =3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> code value src description notes
> =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D =3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> -BPF_JA 0x0 0x0 PC +=3D offset BPF_JMP class
> -BPF_JA 0x0 0x0 PC +=3D imm BPF_JMP32 class
> -BPF_JEQ 0x1 any PC +=3D offset if dst =3D=3D src
> -BPF_JGT 0x2 any PC +=3D offset if dst > src unsigned
> -BPF_JGE 0x3 any PC +=3D offset if dst >=3D src unsigned
> -BPF_JSET 0x4 any PC +=3D offset if dst & src
> -BPF_JNE 0x5 any PC +=3D offset if dst !=3D src
> -BPF_JSGT 0x6 any PC +=3D offset if dst > src signed
> -BPF_JSGE 0x7 any PC +=3D offset if dst >=3D src signed
> -BPF_CALL 0x8 0x0 call helper function by address see `Helper functions`_
> -BPF_CALL 0x8 0x1 call PC +=3D imm see `Program-local functions`_
> -BPF_CALL 0x8 0x2 call helper function by BTF ID see `Helper functions`_
> -BPF_EXIT 0x9 0x0 return BPF_JMP only
> -BPF_JLT 0xa any PC +=3D offset if dst < src unsigned
> -BPF_JLE 0xb any PC +=3D offset if dst <=3D src unsigned
> -BPF_JSLT 0xc any PC +=3D offset if dst < src signed
> -BPF_JSLE 0xd any PC +=3D offset if dst <=3D src signed
> +BPF_JA 0x00 0x0 PC +=3D offset BPF_JMP class
> +BPF_JA 0x00 0x0 PC +=3D imm BPF_JMP32 class
> +BPF_JEQ 0x10 any PC +=3D offset if dst =3D=3D src
> +BPF_JGT 0x20 any PC +=3D offset if dst > src unsigned
> +BPF_JGE 0x30 any PC +=3D offset if dst >=3D src unsigned
> +BPF_JSET 0x40 any PC +=3D offset if dst & src
> +BPF_JNE 0x50 any PC +=3D offset if dst !=3D src
> +BPF_JSGT 0x60 any PC +=3D offset if dst > src signed
> +BPF_JSGE 0x70 any PC +=3D offset if dst >=3D src signed
> +BPF_CALL 0x80 0x0 call helper function by address see `Helper functions`_
> +BPF_CALL 0x80 0x1 call PC +=3D imm see `Program-local functions`_
> +BPF_CALL 0x80 0x2 call helper function by BTF ID see `Helper functions`_
> +BPF_EXIT 0x90 0x0 return BPF_JMP only
> +BPF_JLT 0xa0 any PC +=3D offset if dst < src unsigned
> +BPF_JLE 0xb0 any PC +=3D offset if dst <=3D src unsigned
> +BPF_JSLT 0xc0 any PC +=3D offset if dst < src signed
> +BPF_JSLE 0xd0 any PC +=3D offset if dst <=3D src signed
> =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D =3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> The BPF program needs to store the return value into register R0 before d=
oing a
> --
> 2.42.0
>=20
>=20

--1brf73tkHEfxX8Ia
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZZYoigAKCRBZ5LhpZcTz
ZAiTAQCGSefNSKJEKIHA2oxbXKhV97CnsS7R5/MQANdhe+Qk+QEA4ziQyYdU4Zjs
gSjkFSZtyJ1D0ZbmxzLBSMVQq+/EIAM=
=NYDe
-----END PGP SIGNATURE-----

--1brf73tkHEfxX8Ia--


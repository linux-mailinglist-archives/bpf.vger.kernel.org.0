Return-Path: <bpf+bounces-20463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE43983EB88
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 07:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126B81C220FF
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 06:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6891CF9B;
	Sat, 27 Jan 2024 06:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WLvzjtye"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B1918E00
	for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 06:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706338579; cv=none; b=rh4LL1Qx6tpaZ1BuZ/ok9u2r2H6bW7h3eaiaUcStDtH28fZxZb9P6j4XjX+2OvEL9xV5S5ObqbeUVgbq0/9PS770Ya2XfDwMiuVimvcbDQXKNz5Qolkwg5fNdlE46yl+AubFj2H5c2c/y39O6TwbXurSB4sqz2Of8xX+R0QT+LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706338579; c=relaxed/simple;
	bh=912LIXmg9bE5QUOHeG1G6Ur6ag6iu4kjUV331Jv7GQs=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=cQ2DHMAH0QNUWVmetUysAjMzHDCplYID5Thj2WT+TMEKqjiynuN9wBeOVhHzeiDEbGvK8JfpWTfxW0ldgGivBI2ZkKfH2YWtdhbYPpxvyM7LYZKfyBihUIMUYqErANMgh9PbIUg1ZjL6m6fbqJnDfhHCDE42e46zuwJ90/bNfAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=WLvzjtye; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2185d5f4366so8185fac.2
        for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 22:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1706338576; x=1706943376; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KGvE6v01C4DhqEoiBZDrLfyyWs5/Dsb3shPR65IciOg=;
        b=WLvzjtyeMsonQ0TcXMJIwpoSN1IW5Xv7bkkGu0yRzUOvGftx02P3lBSMAirwPdvpqe
         pNyIyMdazIimHs4WWGm0Yemf9S4Hca6SZzvD4u8L/DeIwD6+IIZj0NFlaqFY5ETPlSXE
         tNnCAbnxkB/RUWJpQ2IJXmP9BM5OQLELSdkka/nvMqUcwexIKys03ah4YAlDV0ijIEFb
         AJPJV3ehEDJsdCyxanTjsc/jPq5DFnDo6XPFM2HElBLoixNfiGOI88aH4q75+xCX85lD
         lrgig5d8pRfyeRN679X/l+ImePox5yDcPjzuVUm6qbXGiC6+85kbRF1Z89spccphCEY9
         Mu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706338576; x=1706943376;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KGvE6v01C4DhqEoiBZDrLfyyWs5/Dsb3shPR65IciOg=;
        b=UVVbI9qWXbvl1SCcvmiEzY1+GeCIbAIcR3Rsc58DapBTTCLcTPmKW7kdSFchRx9HMp
         3BbrrFO7kSYB0U5QQVyH1TMhBM5AOuID/7+u9O52brY1JX+39VeUtIvMxc5w2u7QEz0R
         UxiXnuVMtMcpD164zBMrOpAgVntR8Yve95WDDjqX6xk422FRWCcfdClZq+ftcYOiHU7Y
         4jOV4U+C7Ph8J4aLQXz9PTUee5n+uWL0QApRC5cYAS+5Ya63XSrECKQtBKP2y9Q4kHMm
         2bOh8lI7k/JmupEA+4JPABPoKdT9obuQM+sjQaAPxwX7899z1xL7uAbZINvY5CRQ5nM8
         vQTQ==
X-Gm-Message-State: AOJu0Yzqobr0k9GdLKEWEXp+e1USoazP2zaLzJUmDb7IJMG1fiYfNGSY
	3tRUjaagUWPN01//NOpempxiw34Ww0u/sD5+JOpRe6ItlDnB5aiDcjZTvsqxPJw=
X-Google-Smtp-Source: AGHT+IE9wyEUuOyjSfqCJ3mD/FFrvNkAyDdrBxRPdUzCWVILrNf/Xhw2mtGTgt5H+T9QJ72YZ9sWAQ==
X-Received: by 2002:a05:6358:3421:b0:175:fc44:2654 with SMTP id h33-20020a056358342100b00175fc442654mr874785rwd.15.1706338576252;
        Fri, 26 Jan 2024 22:56:16 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id w18-20020a639352000000b005b458aa0541sm2166874pgm.15.2024.01.26.22.56.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jan 2024 22:56:15 -0800 (PST)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Yonghong Song'" <yonghong.song@linux.dev>
Cc: <bpf@ietf.org>,
	<bpf@vger.kernel.org>
References: <085f01da48bb$fe0c3cb0$fa24b610$@gmail.com> <08ab01da48be$603541a0$209fc4e0$@gmail.com> <829aa552-b04e-4f08-9874-b3f929741852@linux.dev> <095f01da48e8$611687d0$23439770$@gmail.com> <4dfb0d6a-aa48-4d96-82f0-09a960b1012f@linux.dev> <1fc001da4e6a$2848cad0$78da6070$@gmail.com> <9d077ed4-6a30-49db-8160-83d8c525ff3e@linux.dev> <259a01da4ff4$adfe9c50$09fbd4f0$@gmail.com> <dc839efe-2382-440d-bcf6-b9ddc252f35e@linux.dev> <294f01da50a6$ce3d0670$6ab71350$@gmail.com> <79b0ad25-47a8-4e72-adaf-318d73481c86@linux.dev>
In-Reply-To: <79b0ad25-47a8-4e72-adaf-318d73481c86@linux.dev>
Subject: RE: 64-bit immediate instructions clarification
Date: Fri, 26 Jan 2024 22:56:13 -0800
Message-ID: <2a2401da50ed$ebae7080$c30b5180$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGkwaT1bS2nmU/D6EzqCIA6r6THFAGlkngPAiWOVp0CBJjXigIgg/ivAZjEuOEC/rKUjQJO4XhxARE1PEYBZGvoUQIfm2JysLz5yIA=
Content-Language: en-us

> -----Original Message-----
> From: Yonghong Song <yonghong.song@linux.dev>
> Sent: Friday, January 26, 2024 7:41 PM
> To: dthaler1968@googlemail.com
> Cc: bpf@ietf.org; bpf@vger.kernel.org
> Subject: Re: 64-bit immediate instructions clarification
>=20
>=20
> On 1/26/24 2:27 PM, dthaler1968@googlemail.com wrote:
> > Yonghong Song <yonghong.song@linux.dev> wrote:
> >> On 1/25/24 5:12 PM, dthaler1968@googlemail.com wrote:
> >>> The spec defines:
> >>>> As discussed below in `64-bit immediate instructions`_, a 64-bit
> >>>> immediate instruction uses a 64-bit immediate value that is
> >>>> constructed as
> >> follows.
> >>>> The 64 bits following the basic instruction contain a pseudo
> >>>> instruction using the same format but with opcode, dst_reg,
> >>>> src_reg, and offset all set to zero, and imm containing the high =
32
> >>>> bits of the
> >> immediate value.
> >>> [...]
> >>>> imm64 =3D (next_imm << 32) | imm
> >>> The 64-bit immediate instructions section then says:
> >>>> Instructions with the ``BPF_IMM`` 'mode' modifier use the wide
> >>>> instruction encoding defined in `Instruction encoding`_, and use
> >>>> the 'src' field of the basic instruction to hold an opcode =
subtype.
> >>> Some instructions then nicely state how to use the full 64 bit
> >>> immediate value, such as
> >>>> BPF_IMM | BPF_DW | BPF_LD  0x18    0x0  dst =3D imm64
> >> integer      integer
> >>>> BPF_IMM | BPF_DW | BPF_LD  0x18    0x2  dst =3D
> map_val(map_by_fd(imm))
> >> + next_imm   map fd       data pointer
> >>>> BPF_IMM | BPF_DW | BPF_LD  0x18    0x6  dst =3D
> map_val(map_by_idx(imm))
> >> + next_imm  map index    data pointer
> >>> Others don't:
> >>>> BPF_IMM | BPF_DW | BPF_LD  0x18    0x1  dst =3D map_by_fd(imm)
> >> map fd       map
> >>>> BPF_IMM | BPF_DW | BPF_LD  0x18    0x3  dst =3D var_addr(imm)
> >> variable id  data pointer
> >>>> BPF_IMM | BPF_DW | BPF_LD  0x18    0x4  dst =3D code_addr(imm)
> >> integer      code pointer
> >>>> BPF_IMM | BPF_DW | BPF_LD  0x18    0x5  dst =3D map_by_idx(imm)
> >> map index    map
> >>> How is next_imm used in those four?  Must it be 0?  Or can it be
> >>> anything and
> >> it's ignored?
> >>> Or is it used for something?
> >> The other four must have next_imm to be 0. No use of next_imm in =
thee
> >> four insns kindly implies this.
> >> See uapi bpf.h for details (search BPF_PSEUDO_MAP_FD).
> > Thanks for confirming.  The "Instruction encoding" section has
> > misleading text in my opinion.
> >
> > It nicely says:
> >> Note that most instructions do not use all of the fields. Unused =
fields shall
> be cleared to zero.
> > But then goes on to say:
> >> As discussed below in 64-bit immediate instructions (Section 4.4), =
a
> >> 64-bit immediate instruction uses a 64-bit immediate value that is
> constructed as follows.
> > [...]
> >> imm64 =3D (next_imm << 32) | imm
> > Under a normal English reading, that could imply that all 64-bit
> > immediate instructions use imm64, which is not the case.  The whole =
imm64
> discussion there only applies today to src=3D0 (though I
> > suppose it could be used by future 64-bit immediate instructions).   =
Minimally
> I think
> > "a 64-bit immediate instruction uses" should be "some 64-bit =
immediate
> instructions use"
> > but at present there's only one.
> >
> > It would actually be simpler to remove the imm64 text and just have
> > the definition of src 0x0 change from: "dst =3D imm64" to "dst =3D =
(next_imm <<
> 32) | imm".
> >
> > What do you think?
>=20
> it does sound better. Something like below?
>=20
> diff --git a/Documentation/bpf/standardization/instruction-set.rst
> b/Documentation/bpf/standardization/instruction-set.rst
> index af43227b6ee4..fceacca46299 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -166,7 +166,7 @@ Note that most instructions do not use all of the =
fields.
>   Unused fields shall be cleared to zero.
>=20
>   As discussed below in `64-bit immediate instructions`_, a 64-bit =
immediate -
> instruction uses a 64-bit immediate value that is constructed as =
follows.
> +instruction uses two 32-bit immediate values that are constructed as =
follows.
>   The 64 bits following the basic instruction contain a pseudo =
instruction
>   using the same format but with opcode, dst_reg, src_reg, and offset =
all set to
> zero,
>   and imm containing the high 32 bits of the immediate value.
> @@ -181,13 +181,8 @@ This is depicted in the following figure::
>                                      '--------------'
>                                     pseudo instruction
>=20
> -Thus the 64-bit immediate value is constructed as follows:
> -
> -  imm64 =3D (next_imm << 32) | imm
> -
> -where 'next_imm' refers to the imm value of the pseudo instruction =
-following
> the basic instruction.  The unused bytes in the pseudo -instruction =
are reserved
> and shall be cleared to zero.
> +Here, the imm value of the pseudo instruction is called 'next_imm'. =
The
> +unused bytes in the pseudo instruction are reserved and shall be =
cleared to
> zero.
>=20
>   Instruction classes
>   -------------------
> @@ -590,7 +585,7 @@ defined further below:
>   =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
  =3D=3D=3D=3D=3D=3D  =3D=3D=3D
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   opcode construction        opcode  src  pseudocode                   =
              imm type
> dst type
>   =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
  =3D=3D=3D=3D=3D=3D  =3D=3D=3D
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -BPF_IMM | BPF_DW | BPF_LD  0x18    0x0  dst =3D imm64
> integer      integer
> +BPF_IMM | BPF_DW | BPF_LD  0x18    0x0  dst =3D (next_imm << 32) | =
imm
> integer      integer
>   BPF_IMM | BPF_DW | BPF_LD  0x18    0x1  dst =3D map_by_fd(imm)
> map fd       map
>   BPF_IMM | BPF_DW | BPF_LD  0x18    0x2  dst =3D =
map_val(map_by_fd(imm)) +
> next_imm   map fd       data pointer
>   BPF_IMM | BPF_DW | BPF_LD  0x18    0x3  dst =3D var_addr(imm)
> variable id  data pointer

Acked-by: Dave Thaler <dthaler1968@gmail.com>




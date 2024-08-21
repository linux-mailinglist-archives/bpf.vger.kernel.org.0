Return-Path: <bpf+bounces-37773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 529C695A6BB
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 23:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A3B7281683
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 21:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F17178CE4;
	Wed, 21 Aug 2024 21:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="XRJHg57M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C43317BB31
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 21:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724276150; cv=none; b=NQS5sqOsybRXd/F/oT13+Vx4FuJ0xVJ7KRWfXNLckRcdlhWlPgfrI071jPSZ3xzJ6vFEe1XdwOcw+cGANGZZ98OKIXUFeEkF8wsg6GV+ezA5QU9hfjYBhnvmLGYNtVkJ4tDq8kwKto8YR7ZM5BNlUqE13mqlTapnmlADudVr2JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724276150; c=relaxed/simple;
	bh=w1FL4UykgjnpgpGTxFgIQ7mUz2J1i3vyBFKU0TNmNrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hzn5onfAISG7CinrQ3WknKzg83Lqwh6q2kQAA92/qi1uJnYD31AV6WIAC4Ykzz79p7bZYCPj8tXFeu2rwB8dTMK8pIt4G/HAm1WtYeHTcKjU2HrJtNs3m/XP+yHgd+5LKHT8g65b6RT5rtDFeJgdEpjqe/c3s/oIRCbtN7olvuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr; spf=none smtp.mailfrom=obs.cr; dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b=XRJHg57M; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=obs.cr
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a1e0ff6871so10640885a.2
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 14:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1724276147; x=1724880947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LuLScUXbCy7Fak1DCkUGU1maWwDf16GZc3pQB1Yli8=;
        b=XRJHg57My/sRoMRzU4wT6Zj4jawYseumaMDVESRMBCOpqJbQtQA80gp9xNus50VM3E
         fQueB3dtahRgxsR/nh7CyAkZmo1Bbii8rBnPLDooUTZcel+oVVciVa0oaZH7RU9i/qUF
         ZSQf6SpbvZhoR6mThROLfkbTnSeaYqsogLpazEMM7XrWQtBVdSHlPDTEf7Q+hahrj9b1
         05qJreEKGOiNkGborK5vcgDBncybt0auJ9fibEjfSyRKALickCNW9iZnextP5NR6SsgM
         c5bXXCQ3tPLM0p+XBIbb6gzh9ZRDXy8PDeYf+66olYsqPv8BGhJkw8tIODTqUqx8tvgc
         /Ubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724276147; x=1724880947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0LuLScUXbCy7Fak1DCkUGU1maWwDf16GZc3pQB1Yli8=;
        b=qDdqX4GKwrZ69W25xtI4kzFSYtHYQOIZZSXarZkgzUAf0rUvx/swsY7wWpAahA03Re
         df1YpR2j0hmaYkBNT67hfI90wc/40NgosMWKBTZYTDSTD7fgF1rp63PJ/bHDEGDNfVyP
         ILb/g2+RVU6gc9/CXek4tKV5TxO47SEyC1MdjHuB0yUvpsL8FX+7RiMaq0Sh5GcU//Ab
         CEhKfulRvvPoFyn0MQEWed0jrVaCjBogfmepGX1L9Kaex9S2C8oEvf7K/b/4Jtcy3sDZ
         WFYvPaZAQbU+nRvVt4H8BFcrCojs45n0MYruRFnAEunSyRZNKe65f2gAqxHkyq9bhxN1
         hmDg==
X-Gm-Message-State: AOJu0YxJRExTCK7uz1OHO9xyuk5TrbtRXFqTLFA54jrfkC784JFgEOJu
	cVbMSvLvpPym1tdx+icjeO6VkSl0ntlKfKzP7vzkl6iMYmoSCEnyb2fbASTRPFsj908yL23Ggdr
	bzTP6Sdmio2w5Pt3v6G0DwVc8z4O7rFLLCp3KxpCK4dlaCIXe
X-Google-Smtp-Source: AGHT+IFuH0AIkuoNhZ5hEhd5NX9DiTdqzOM8ceNjyb86tyUxPfuYqgl/x4M4/CFcjEOjhzPIet2rid8Qfscwxttzq8Y=
X-Received: by 2002:a05:6214:3d01:b0:6bf:916a:66ac with SMTP id
 6a1803df08f44-6c155d725aamr42457876d6.17.1724276146746; Wed, 21 Aug 2024
 14:35:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819223008.469271-1-hawkinsw@obs.cr> <0de00576-e102-4586-8695-62f2bf37eb3f@linux.dev>
In-Reply-To: <0de00576-e102-4586-8695-62f2bf37eb3f@linux.dev>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Wed, 21 Aug 2024 17:35:34 -0400
Message-ID: <CADx9qWh-JSVVP9Stu3gz4aLpwrB9cVnK-RO3TveqjpWuxWQJ_w@mail.gmail.com>
Subject: Re: [PATCH] docs/bpf: Add constant values for linkages
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, bpf@ietf.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 5:30=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 8/19/24 3:30 PM, Will Hawkins wrote:
> > Make the values of the symbolic constants that define the valid linkage=
s
> > for functions and variables explicit.
> >
> > Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
> > ---
> >   Documentation/bpf/btf.rst | 44 +++++++++++++++++++++++++++++++++++---=
-
> >   1 file changed, 40 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
> > index 257a7e1cdf5d..cce03f1e552a 100644
> > --- a/Documentation/bpf/btf.rst
> > +++ b/Documentation/bpf/btf.rst
> > @@ -368,7 +368,7 @@ No additional type data follow ``btf_type``.
> >     * ``info.kind_flag``: 0
> >     * ``info.kind``: BTF_KIND_FUNC
> >     * ``info.vlen``: linkage information (BTF_FUNC_STATIC, BTF_FUNC_GLO=
BAL
> > -                   or BTF_FUNC_EXTERN)
> > +                   or BTF_FUNC_EXTERN - see :ref:`BTF_Function_Linkage=
_Constants`)
> >     * ``type``: a BTF_KIND_FUNC_PROTO type
> >
> >   No additional type data follow ``btf_type``.
> > @@ -424,9 +424,9 @@ following data::
> >           __u32   linkage;
> >       };
> >
> > -``struct btf_var`` encoding:
> > -  * ``linkage``: currently only static variable 0, or globally allocat=
ed
> > -                 variable in ELF sections 1
> > +``btf_var.linkage`` may take the values: BTF_VAR_STATIC (for a static =
variable),
> > +or BTF_VAR_GLOBAL_ALLOCATED (for a globally allocated variable stored =
in ELF sections 1) -
>
> Let us remove the above '1', just say '(... stored in explicit ELF sectio=
ns)'.

Great! I only kept that because it was there in the existing documentation!

>
> Actually, for btf_var linkage, we actually have 3 values. See
>
> enum {
>         BTF_VAR_STATIC =3D 0,
>         BTF_VAR_GLOBAL_ALLOCATED =3D 1,
>         BTF_VAR_GLOBAL_EXTERN =3D 2,
> };
>
> See https://github.com/torvalds/linux/blob/master/include/uapi/linux/btf.=
h#L150-L154
>

Great! I will make that update!

> Similar to BTF_VAR_GLOBAL_ALLOCATED, BTF_VAR_GLOBAL_EXTERN is encoded in =
datasec only
> if the variable is stored in explicit ELF sections.
>
> Since you are touching this doc, could you add BTF_VAR_GLOBAL_EXTERN as w=
ell?
>

Of course!

> > +see :ref:`BTF_Var_Linkage_Constants`.
> >
> >   Not all type of global variables are supported by LLVM at this point.
> >   The following is currently available:
> > @@ -549,6 +549,42 @@ The ``btf_enum64`` encoding:
> >   If the original enum value is signed and the size is less than 8,
> >   that value will be sign extended into 8 bytes.
> >
> > +2.3 Constant Values
> > +-------------------
> > +
> > +.. _BTF_Function_Linkage_Constants:
> > +
> > +2.3.1 Function Linkage Constant Values
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +.. list-table::
> > +   :widths: 1 1
> > +   :header-rows: 1
> > +
> > +   * - Name
> > +     - Value
> > +   * - ``BTF_FUNC_STATIC``
> > +     - ``0``
> > +   * - ``BTF_FUNC_GLOBAL``
> > +     - ``1``
> > +   * - ``BTF_FUNC_EXTERN``
> > +     - ``2``
> > +
> > +.. _BTF_Var_Linkage_Constants:
> > +
> > +2.3.2 Variable Linkage Constant Values
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +.. list-table::
> > +   :widths: 1 1
> > +   :header-rows: 1
> > +
> > +   * - Name
> > +     - Value
> > +   * - ``BTF_VAR_STATIC``
> > +     - ``0``
> > +   * - ``BTF_VAR_GLOBAL_ALLOCATED``
> > +     - ``1``
> > +
> > +
>
> Form the above, could you use similar format as in Documentation/bpf/stan=
dardization/instruction-set.rst? For example,
>
> .. table:: Instruction class
>
>    =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>    class  value  description                      reference
>    =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>    LD     0x0    non-standard load operations     `Load and store instruc=
tions`_
>    LDX    0x1    load into register operations    `Load and store instruc=
tions`_
>    ST     0x2    store from immediate operations  `Load and store instruc=
tions`_
>    STX    0x3    store from register operations   `Load and store instruc=
tions`_
>    ALU    0x4    32-bit arithmetic operations     `Arithmetic and jump in=
structions`_
>    JMP    0x5    64-bit jump operations           `Arithmetic and jump in=
structions`_
>    JMP32  0x6    32-bit jump operations           `Arithmetic and jump in=
structions`_
>    ALU64  0x7    64-bit arithmetic operations     `Arithmetic and jump in=
structions`_
>    =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>
> I would like we have consistant table presentation between instruction se=
t and btf.
>

Absolutely. I volunteered to edit the document that will ultimately
turn into the IETF spec draft for BTF and this is the first fix that
jumped out to me when I was proofreading.

Thank you for the review! I will have a v2 of the patch in just a few minut=
es!

Thank you, again!
Will


> >   3. BTF Kernel API
> >   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >


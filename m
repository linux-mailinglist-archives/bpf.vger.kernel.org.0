Return-Path: <bpf+bounces-7092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3182977134C
	for <lists+bpf@lfdr.de>; Sun,  6 Aug 2023 04:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 551381C2091B
	for <lists+bpf@lfdr.de>; Sun,  6 Aug 2023 02:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019C517D8;
	Sun,  6 Aug 2023 02:56:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D031B15B7
	for <bpf@vger.kernel.org>; Sun,  6 Aug 2023 02:56:47 +0000 (UTC)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817C9130
	for <bpf@vger.kernel.org>; Sat,  5 Aug 2023 19:56:45 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-63cf96c37beso15615916d6.0
        for <bpf@vger.kernel.org>; Sat, 05 Aug 2023 19:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1691290604; x=1691895404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=damG5vm/t1J7f2L/xa/KtKQxE5kVs8bz0pP4WdiMRBg=;
        b=p0NZex5o+2aRJiA22hXKm3Va/8iAB8k87Hkqv3Tbk1P+4env6aCM5YDQgSGP2BoOt4
         V5xk37oP1c2uPvjuNgTCwtbEKg+eeyYl8TqVTPfWM5ohaaeS/kTA8kWusDogfH39/umF
         9oIjQQ2cI6XkZ15Xpy3gf1WXlRezpK1bUrZP2Dd7vTY4Xdg5nBQP6uweCjCK9mW4i3MQ
         lPgxDUTNZWpwYHmh3yx2/GeaEts0EGQG/g1HO+Br8NTjwSzxRBREtjuSUhUKWYwDhOZM
         SNmWyrvHLnzV956WW84yN08bSdMafew+0BZAo8HGTW2Fmh4bmldT/gaTdxMmDORCiNXn
         Q7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691290604; x=1691895404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=damG5vm/t1J7f2L/xa/KtKQxE5kVs8bz0pP4WdiMRBg=;
        b=BFt8hlhAQEwO2gY/hPOYxflFl8fRgNXdVA2Ne7ncfVUTHmD6vEe+YIoBzysKEe+1pD
         Gm4mez3sRK2sJf94ZUyn+GIPlBubg9UriAvqKZpiUOP46XjcJqV/s+IsDx2irAC5FB2Z
         JZb4isvZr5rW911srKFcY0SvYojgW3NcDNlkjVhY7bGlreNXyYp0mC7cFWVcXvwFZ9fI
         idJys3H9wKxj7LXFVkJhMX7IjTFfjlOKHlP/nG+nX/WNn7m/3LBVdXKYmo/kJV09FlvO
         9DRbjJ/Kk64YD1cKKs8Hy64nz74cA4Szw8CE/g/aAH/I3+aS4gXzFSql3lk+nnODzNJL
         dvGw==
X-Gm-Message-State: AOJu0Yw5yaUyXkoCflzEiX8ohICG3MI5dERc6GMyQNA8wuHUDUgBNrIt
	BEVZIQzl1ai0DT/6HCmAnqkbLrZSTtibWuKHZ9QgBQ==
X-Google-Smtp-Source: AGHT+IER4QXi06Gwi3d4PW89UL+km9emxHdz72ZAKIBjM7+yi9mch1xdyKLdYs2XcHGOwasWARTrAX1IjhzAKIHduAE=
X-Received: by 2002:ad4:5cc7:0:b0:636:3f18:4c2b with SMTP id
 iu7-20020ad45cc7000000b006363f184c2bmr5136441qvb.29.1691290604587; Sat, 05
 Aug 2023 19:56:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230805030921.52035-1-hawkinsw@obs.cr> <20230805030921.52035-2-hawkinsw@obs.cr>
 <20230805141856.GD519395@maniforge>
In-Reply-To: <20230805141856.GD519395@maniforge>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Sat, 5 Aug 2023 22:56:33 -0400
Message-ID: <CADx9qWi4xvnq9qRO+dyRnRwRm9TEFg3e0YT0zLOMfC40sCmqng@mail.gmail.com>
Subject: Re: [Bpf] [PATCH v3 2/2] bpf, docs: Fix small typo and define
 semantics of sign extension
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 5, 2023 at 10:18=E2=80=AFAM David Vernet <void@manifault.com> w=
rote:
>
> On Fri, Aug 04, 2023 at 11:09:19PM -0400, Will Hawkins wrote:
> > Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
>
> Hi Will,
>
> Given that this is a separate patch, it should also have its own commit
> summary as it would be merged as a separate commit to the kernel.

Agree -- sorry for adding it to this set. It was contingent on the
first going on so that there was not a merge conflict so I just added
it here. In v3 of the patch I will make the change!!

>
> - David
>
> > ---
> >  .../bpf/standardization/instruction-set.rst   | 31 ++++++++++++++++---
> >  1 file changed, 26 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Do=
cumentation/bpf/standardization/instruction-set.rst
> > index fe296f35e5a7..6f3b34ef7b7c 100644
> > --- a/Documentation/bpf/standardization/instruction-set.rst
> > +++ b/Documentation/bpf/standardization/instruction-set.rst
> > @@ -73,6 +73,27 @@ Functions
> >    format and returns the equivalent number with the same bit width but
> >    opposite endianness.
> >
> > +
> > +Definitions
> > +-----------
> > +
> > +.. glossary::
> > +
> > +  Sign Extend
> > +    To `sign extend an` ``X`` `-bit number, A, to a` ``Y`` `-bit numbe=
r, B  ,` means to
> > +
> > +    #. Copy all ``X`` bits from `A` to the lower ``X`` bits of `B`.
> > +    #. Set the value of the remaining ``Y`` - ``X`` bits of `B` to the=
 value of
> > +       the  most-significant bit of `A`.
> > +
> > +.. admonition:: Example
> > +
> > +  Sign extend an 8-bit number ``A`` to a 16-bit number ``B`` on a big-=
endian platform:
> > +  ::
> > +
> > +    A:          10000110
> > +    B: 11111111 10000110
> > +
> >  Registers and calling convention
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > @@ -263,17 +284,17 @@ where '(u32)' indicates that the upper 32 bits ar=
e zeroed.
> >  Note that most instructions have instruction offset of 0. Only three i=
nstructions
> >  (``BPF_SDIV``, ``BPF_SMOD``, ``BPF_MOVSX``) have a non-zero offset.
> >
> > -The devision and modulo operations support both unsigned and signed fl=
avors.
> > +The division and modulo operations support both unsigned and signed fl=
avors.
> >
> >  For unsigned operations (``BPF_DIV`` and ``BPF_MOD``), for ``BPF_ALU``=
,
> >  'imm' is interpreted as a 32-bit unsigned value. For ``BPF_ALU64``,
> > -'imm' is first sign extended from 32 to 64 bits, and then interpreted =
as
> > -a 64-bit unsigned value.
> > +'imm' is first :term:`sign extended<Sign Extend>` from 32 to 64 bits, =
and then
> > +interpreted as a 64-bit unsigned value.
> >
> >  For signed operations (``BPF_SDIV`` and ``BPF_SMOD``), for ``BPF_ALU``=
,
> >  'imm' is interpreted as a 32-bit signed value. For ``BPF_ALU64``, 'imm=
'
> > -is first sign extended from 32 to 64 bits, and then interpreted as a
> > -64-bit signed value.
> > +is first :term:`sign extended<Sign Extend>` from 32 to 64 bits, and th=
en
> > +interpreted as a 64-bit signed value.
> >
> >  The ``BPF_MOVSX`` instruction does a move operation with sign extensio=
n.
> >  ``BPF_ALU | BPF_MOVSX`` sign extends 8-bit and 16-bit operands into 32
>
> There are some other places where we say e.g. "sign extend", "sign
> extending", etc. Can we link those places to your handy new section as
> well, please?

Absolutely! Sorry that I missed them!

>
> Thanks,
> David


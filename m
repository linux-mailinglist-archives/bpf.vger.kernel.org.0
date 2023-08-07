Return-Path: <bpf+bounces-7167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBA47726E1
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 16:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCA52281356
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 14:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725AD10952;
	Mon,  7 Aug 2023 14:02:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F566443A
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 14:02:01 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991CB2708
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 07:01:56 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1bfce114ef9so1050243fac.1
        for <bpf@vger.kernel.org>; Mon, 07 Aug 2023 07:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1691416916; x=1692021716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3p47eUi+34rCRXY22J4MldsiLN4h+zU8wuiEtA7A1LA=;
        b=Tpo4PSRSGSyj+3GwDRzncDaAOvJj2BcKs7Da3DRgSY0FekoFjQ7hkfYoi1a+gqExzM
         rmYggFCYKCHYvlUCoZas9gzYdLN7m8TuRoG1UYP8j2NL3+UUJDvUE1ctNwnV1lRJxwKA
         MUzMiz7PYUDNQqk8+YKJckqe8dBGhRg+4nWnytX9cHhJ6Lp/Lhz82d+y/lnXjMHpXTtJ
         CFh+SBSn8R6tgXnGrmqGp8ZDfA8HA4y2D2OdT9TM3kMdY1D/YruHsjhAqjGPwz+T3LcI
         EcMPwGUvUJ66TnZEr2LfRkVuusAuSwSoued4cN5EeVik5Z12Rl/aoW2IKWNNPkTaxFsT
         N5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691416916; x=1692021716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3p47eUi+34rCRXY22J4MldsiLN4h+zU8wuiEtA7A1LA=;
        b=KedUVIuo+jT+Agm7iwGiY7e75eEBGwFOAe1tbirwgkZglwKTX/J8jV21VnU+nTWWop
         D7ng3qRBjP2WXabJn1BN0i/SJUeIFDukxJZ7Pm1tM+pATctCDi76pAW1FueDYSntIIto
         pVSRqbXaoK44VUIYMqWJKS4pc8IW7OVZEMIknJEqJB9u+RkfL1o6iIeDxaqyjQWTBN0X
         NQMgDU/5bsJegSi+FX/Sr5WHhzRFHJ6WxbEFfYQHF74y+WoqMZVRtJ6ocZazV2Wa+TF4
         fJtOmGFdyrbXNR+81VCbgAJ+HWd69E2Ng7y9/nBjFdqI4Ln3oKgTvwNKITCS5wqBmt/n
         F6dw==
X-Gm-Message-State: AOJu0YzoiUYSscckZ6gNZb5S0ukPj2+2zbiwEFMzwh9zUbEHad/T1kNy
	WeCqWO+9aIqLucjKLxf8NrW8GuPITYR+J5uNt5O4JtqXEmMbXsix
X-Google-Smtp-Source: AGHT+IHC77WW6SFX8LyWQVfP44h4aM7G3pHLO18AwhTOaA3J37M4W1YrgCKJRmV3VMrew+W7HwUZA25iprp1bFYzFvY=
X-Received: by 2002:aca:1314:0:b0:3a3:76c6:a46f with SMTP id
 e20-20020aca1314000000b003a376c6a46fmr10496969oii.38.1691416915747; Mon, 07
 Aug 2023 07:01:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230805030921.52035-1-hawkinsw@obs.cr> <20230805141427.GC519395@maniforge>
 <CADx9qWh5Z6epKSMA=nN+D7r6Q5O3t-6mdSjyx6SquZhAPHb5DA@mail.gmail.com>
In-Reply-To: <CADx9qWh5Z6epKSMA=nN+D7r6Q5O3t-6mdSjyx6SquZhAPHb5DA@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Mon, 7 Aug 2023 10:01:44 -0400
Message-ID: <CADx9qWjNFTEutq+yaHUqcbVoEyT4QfTjoUCt2z5TYe-n7O_mjw@mail.gmail.com>
Subject: Re: [Bpf] [PATCH v3 1/2] bpf, docs: Formalize type notation and
 function semantics in ISA standard
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 5, 2023 at 11:01=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> wrot=
e:
>
> On Sat, Aug 5, 2023 at 10:14=E2=80=AFAM David Vernet <void@manifault.com>=
 wrote:
> >
> > On Fri, Aug 04, 2023 at 11:09:18PM -0400, Will Hawkins wrote:
> > > Give a single place where the shorthand for types are defined, the
> > > semantics of helper functions are described, and certain terms can
> > > be defined.
> > >
> > > Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
> >
> > Hi Will,
> >
> > This is looking great. Left a couple more comments below, let me know
> > what you think.
>
> Thanks for the feedback!
>
> >
> > > ---
> > >  .../bpf/standardization/instruction-set.rst   | 79 +++++++++++++++++=
--
> > >  1 file changed, 71 insertions(+), 8 deletions(-)
> > >
> > >  Changelog:
> > >    v1 -> v2:
> > >          - Remove change to Sphinx version
> > >                - Address David's comments
> > >                - Address Dave's comments
> > >    v2 -> v3:
> > >          - Add information about sign extending
> > >
> > > diff --git a/Documentation/bpf/standardization/instruction-set.rst b/=
Documentation/bpf/standardization/instruction-set.rst
> > > index 655494ac7af6..fe296f35e5a7 100644
> > > --- a/Documentation/bpf/standardization/instruction-set.rst
> > > +++ b/Documentation/bpf/standardization/instruction-set.rst
> > > @@ -10,9 +10,68 @@ This document specifies version 1.0 of the eBPF in=
struction set.
> > >  Documentation conventions
> > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > >
> > > -For brevity, this document uses the type notion "u64", "u32", etc.
> > > -to mean an unsigned integer whose width is the specified number of b=
its,
> > > -and "s32", etc. to mean a signed integer of the specified number of =
bits.
> > > +For brevity and consistency, this document refers to families
> > > +of types using a shorthand syntax and refers to several expository,
> > > +mnemonic functions when describing the semantics of opcodes. The ran=
ge
> >
> > Hmm, I wonder if it's slightly more accurate to say that those function=
s
> > are describing the semantics of "instructions" rather than "opcodes",
> > given that the value in the immediate for the byte swap instructions
> > dictate the width. What do you think?
>
> Great point!
>
> >
> > > +of valid values for those types and the semantics of those functions
> > > +are defined in the following subsections.
> > > +
> > > +Types
> > > +-----
> > > +This document refers to integer types with a notation of the form `S=
N`
> > > +that succinctly defines whether their values are signed or unsigned
> >
> > Suggestion: I don't think we need the word "succinctly" here. I'm also
> > inclined to suggest that we avoid using the word "define" here, as the
> > notation itself isn't really defining the values of the types, but is
> > rather just a shorthand.
>
> Yes!
>
> >
> > > +numbers and the bit widths:
> >
> > What do you think about this phrasing:
> >
> > This document refers to integer types with the notation `SN` to specify
> > a type's signedness and bit width respectively.
> >
> > Feel free to disagree. My thinking here is that it might make more sens=
e
> > to explain the notation as an informal shorthand rather than as a forma=
l
> > defnition, as making it a formal definition might open its own can of
> > worms (e.g. we would probably also have to define what signedness means=
,
> > etc).
>
> I think that you make an excellent point. We have already gone
> back/forth about whether there is going to be a definition for the
> "type" of signedness that we use in the representation (i.e., two's
> complement, one's complement, sign magnitude, etc) and we definitely
> don't want to rush in to that rabbit hole again. I will incorporate
> your suggestion in the next revision.
>
> >
> > > +
> > > +=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D
> > > +`S` Meaning
> > > +=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D
> > > +`u` unsigned
> > > +`s` signed
> > > +=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +`N`   Bit width
> > > +=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +`8`   8 bits
> > > +`16`  16 bits
> > > +`32`  32 bits
> > > +`64`  64 bits
> > > +`128` 128 bits
> > > +=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Is it by any chance possible to put these two tables on the same row?
> > Not sure if rst is up to that challenge, and if not feel free to ignore=
.
>
> I would love to make that happen. My rst skills are developing and I
> will see what I can do!

FYI: In the upcoming version of this patch, you will see that I did
not do the side-by-side table. I want you to know that I tried very
hard and ultimately got it to work. However, it looked terrible and
the result was confusing (I thought). If you would strongly prefer a
side-by-side (ish) table, please let me know and I will send a patch
to show what it looked like.

I just wanted to note that I *tried* to incorporate your suggestion,
but could not ultimately bend RST to my will (yes, pun intended)!

Will

>
> >
> > > +
> > > +For example, `u32` is a type whose valid values are all the 32-bit u=
nsigned
> > > +numbers and `s16` is a types whose valid values are all the 16-bit s=
igned
> > > +numbers.
> > > +
> > > +Functions
> > > +---------
> > > +* `htobe16`: Takes an unsigned 16-bit number in host-endian format a=
nd
> > > +  returns the equivalent number as an unsigned 16-bit number in big-=
endian
> > > +  format.
> > > +* `htobe32`: Takes an unsigned 32-bit number in host-endian format a=
nd
> > > +  returns the equivalent number as an unsigned 32-bit number in big-=
endian
> > > +  format.
> > > +* `htobe64`: Takes an unsigned 64-bit number in host-endian format a=
nd
> > > +  returns the equivalent number as an unsigned 64-bit number in big-=
endian
> > > +  format.
> > > +* `htole16`: Takes an unsigned 16-bit number in host-endian format a=
nd
> > > +  returns the equivalent number as an unsigned 16-bit number in litt=
le-endian
> > > +  format.
> > > +* `htole32`: Takes an unsigned 32-bit number in host-endian format a=
nd
> > > +  returns the equivalent number as an unsigned 32-bit number in litt=
le-endian
> > > +  format.
> > > +* `htole64`: Takes an unsigned 64-bit number in host-endian format a=
nd
> > > +  returns the equivalent number as an unsigned 64-bit number in litt=
le-endian
> > > +  format.
> > > +* `bswap16`: Takes an unsigned 16-bit number in either big- or littl=
e-endian
> > > +  format and returns the equivalent number with the same bit width b=
ut
> > > +  opposite endianness.
> > > +* `bswap32`: Takes an unsigned 32-bit number in either big- or littl=
e-endian
> > > +  format and returns the equivalent number with the same bit width b=
ut
> > > +  opposite endianness.
> > > +* `bswap64`: Takes an unsigned 64-bit number in either big- or littl=
e-endian
> > > +  format and returns the equivalent number with the same bit width b=
ut
> > > +  opposite endianness.
> >
> > Upon further reflection, maybe this belongs in the Byte swap
> > instructions section of the document? The types make sense to list abov=
e
> > because they're ubiquitous throughout the doc, but these are really 100=
%
> > specific to byte swap.
>
> I am not opposed to that. The only reason that I put them here was to
> make it fully centralized. They are also going to be used in the
> Appendix and I was hoping not to have to reproduce them there. In v4
> of the patch I will leave them here and then if we do feel like we
> should move them I will happily make a v5!
>
> Thank you again for the feedback! A new revision of the patch will be
> out shortly!
>
> Have a great rest of the weekend!
> Will
>
> >
> > >
> > >  Registers and calling convention
> > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > @@ -252,19 +311,23 @@ are supported: 16, 32 and 64.
> > >
> > >  Examples:
> > >
> > > -``BPF_ALU | BPF_TO_LE | BPF_END`` with imm =3D 16 means::
> > > +``BPF_ALU | BPF_TO_LE | BPF_END`` with imm =3D 16/32/64 means::
> > >
> > >    dst =3D htole16(dst)
> > > +  dst =3D htole32(dst)
> > > +  dst =3D htole64(dst)
> > >
> > > -``BPF_ALU | BPF_TO_BE | BPF_END`` with imm =3D 64 means::
> > > +``BPF_ALU | BPF_TO_BE | BPF_END`` with imm =3D 16/32/64 means::
> > >
> > > +  dst =3D htobe16(dst)
> > > +  dst =3D htobe32(dst)
> > >    dst =3D htobe64(dst)
> > >
> > >  ``BPF_ALU64 | BPF_TO_LE | BPF_END`` with imm =3D 16/32/64 means::
> > >
> > > -  dst =3D bswap16 dst
> > > -  dst =3D bswap32 dst
> > > -  dst =3D bswap64 dst
> > > +  dst =3D bswap16(dst)
> > > +  dst =3D bswap32(dst)
> > > +  dst =3D bswap64(dst)
> > >
> >
> > [...]
> >
> > - David


Return-Path: <bpf+bounces-7094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9CB77134E
	for <lists+bpf@lfdr.de>; Sun,  6 Aug 2023 05:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA44328147F
	for <lists+bpf@lfdr.de>; Sun,  6 Aug 2023 03:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C92E17D8;
	Sun,  6 Aug 2023 03:02:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A2315B7
	for <bpf@vger.kernel.org>; Sun,  6 Aug 2023 03:02:10 +0000 (UTC)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65D71BD0
	for <bpf@vger.kernel.org>; Sat,  5 Aug 2023 20:02:08 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-63f7f16553fso3538956d6.0
        for <bpf@vger.kernel.org>; Sat, 05 Aug 2023 20:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1691290928; x=1691895728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwVtGyJoygHRbKK7G//JOBv2hhfyU7zcS7PGe4tdbw8=;
        b=Rchn3asYxI0E/Otv0nktwPUg6KWe8N3AWaHpfgPIksLt5ZhPshOwU4+ufBO877qv4G
         kjkYtLj67ZranxJ+dIKBxedQFOKjT4AvusVAoPJJDLMGD9YJE4KoLKD9RTixbZqHGCC2
         WD8wv8lx+b8o65lg5g6eWfOlI1NIsIX9GsSCgrxUDJ6TjS2NhCbG4VrloUlbkx0QD5G5
         70HChI4VKq3+mX+3mx4ZVrxIM77FAV96SpQ2mSPe8HqcHPrSUet4ie5RPp6nVzwrhi33
         d6OZVsUeqHLhcXyohTqZXgUKOjSIfS0ObXv8CC82X9CEay8wRFaQ2iscTMB+2EZLm69q
         G9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691290928; x=1691895728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GwVtGyJoygHRbKK7G//JOBv2hhfyU7zcS7PGe4tdbw8=;
        b=l6ONfeR5IEYz0mhED29KHjuXW+3T1lYaobJuWnausCywDFNUBXY5vqxEfuhKVPJu3l
         23GmYNotr1cheoQDwf/Mbq1r2K0O4g2EAz4UX9PwUa4Q7rKykelTimhcDdp5dqoNPDBr
         WLQBR5kYzHKvb8Ee2y4C1O7DVyvi2+dRPH8YkSLaMHKwTf+DpLFwZgtcXTcIbs32Pj5h
         kn8AZvvz3TPE7AzmgwUgeck33CWzLyNKN0NqZacK6tu/wAvIz+qY0gX82jtyFqBrNkDI
         LjiiPfRac2J1RttupHkBUah2mlTHqvRydQYpaKG1qUi4D9DScnQjwtyvZ9csHEN4tCHR
         G3TA==
X-Gm-Message-State: AOJu0YxxihDc+tYkjAjSV8QpR4l1RkSLgrv0nt6Aq76sByEv4cuBlCgp
	5mXWsBm9sF55IRTtnppt8vudFPYV/1lUO+d8qMM1Ww==
X-Google-Smtp-Source: AGHT+IGhCG+dAlFjfneKh06y7MKelhVSPsyZc2CNCl6A9NgfIJVlNJPPyBpTwo0Xr9cGorweHfmSVDXTit1F3n/sgmY=
X-Received: by 2002:a0c:f249:0:b0:63d:6330:b53a with SMTP id
 z9-20020a0cf249000000b0063d6330b53amr5609882qvl.52.1691290927602; Sat, 05 Aug
 2023 20:02:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230805030921.52035-1-hawkinsw@obs.cr> <20230805141427.GC519395@maniforge>
In-Reply-To: <20230805141427.GC519395@maniforge>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Sat, 5 Aug 2023 23:01:57 -0400
Message-ID: <CADx9qWh5Z6epKSMA=nN+D7r6Q5O3t-6mdSjyx6SquZhAPHb5DA@mail.gmail.com>
Subject: Re: [Bpf] [PATCH v3 1/2] bpf, docs: Formalize type notation and
 function semantics in ISA standard
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 5, 2023 at 10:14=E2=80=AFAM David Vernet <void@manifault.com> w=
rote:
>
> On Fri, Aug 04, 2023 at 11:09:18PM -0400, Will Hawkins wrote:
> > Give a single place where the shorthand for types are defined, the
> > semantics of helper functions are described, and certain terms can
> > be defined.
> >
> > Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
>
> Hi Will,
>
> This is looking great. Left a couple more comments below, let me know
> what you think.

Thanks for the feedback!

>
> > ---
> >  .../bpf/standardization/instruction-set.rst   | 79 +++++++++++++++++--
> >  1 file changed, 71 insertions(+), 8 deletions(-)
> >
> >  Changelog:
> >    v1 -> v2:
> >          - Remove change to Sphinx version
> >                - Address David's comments
> >                - Address Dave's comments
> >    v2 -> v3:
> >          - Add information about sign extending
> >
> > diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Do=
cumentation/bpf/standardization/instruction-set.rst
> > index 655494ac7af6..fe296f35e5a7 100644
> > --- a/Documentation/bpf/standardization/instruction-set.rst
> > +++ b/Documentation/bpf/standardization/instruction-set.rst
> > @@ -10,9 +10,68 @@ This document specifies version 1.0 of the eBPF inst=
ruction set.
> >  Documentation conventions
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >
> > -For brevity, this document uses the type notion "u64", "u32", etc.
> > -to mean an unsigned integer whose width is the specified number of bit=
s,
> > -and "s32", etc. to mean a signed integer of the specified number of bi=
ts.
> > +For brevity and consistency, this document refers to families
> > +of types using a shorthand syntax and refers to several expository,
> > +mnemonic functions when describing the semantics of opcodes. The range
>
> Hmm, I wonder if it's slightly more accurate to say that those functions
> are describing the semantics of "instructions" rather than "opcodes",
> given that the value in the immediate for the byte swap instructions
> dictate the width. What do you think?

Great point!

>
> > +of valid values for those types and the semantics of those functions
> > +are defined in the following subsections.
> > +
> > +Types
> > +-----
> > +This document refers to integer types with a notation of the form `SN`
> > +that succinctly defines whether their values are signed or unsigned
>
> Suggestion: I don't think we need the word "succinctly" here. I'm also
> inclined to suggest that we avoid using the word "define" here, as the
> notation itself isn't really defining the values of the types, but is
> rather just a shorthand.

Yes!

>
> > +numbers and the bit widths:
>
> What do you think about this phrasing:
>
> This document refers to integer types with the notation `SN` to specify
> a type's signedness and bit width respectively.
>
> Feel free to disagree. My thinking here is that it might make more sense
> to explain the notation as an informal shorthand rather than as a formal
> defnition, as making it a formal definition might open its own can of
> worms (e.g. we would probably also have to define what signedness means,
> etc).

I think that you make an excellent point. We have already gone
back/forth about whether there is going to be a definition for the
"type" of signedness that we use in the representation (i.e., two's
complement, one's complement, sign magnitude, etc) and we definitely
don't want to rush in to that rabbit hole again. I will incorporate
your suggestion in the next revision.

>
> > +
> > +=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D
> > +`S` Meaning
> > +=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D
> > +`u` unsigned
> > +`s` signed
> > +=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D
> > +
> > +=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +`N`   Bit width
> > +=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +`8`   8 bits
> > +`16`  16 bits
> > +`32`  32 bits
> > +`64`  64 bits
> > +`128` 128 bits
> > +=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Is it by any chance possible to put these two tables on the same row?
> Not sure if rst is up to that challenge, and if not feel free to ignore.

I would love to make that happen. My rst skills are developing and I
will see what I can do!

>
> > +
> > +For example, `u32` is a type whose valid values are all the 32-bit uns=
igned
> > +numbers and `s16` is a types whose valid values are all the 16-bit sig=
ned
> > +numbers.
> > +
> > +Functions
> > +---------
> > +* `htobe16`: Takes an unsigned 16-bit number in host-endian format and
> > +  returns the equivalent number as an unsigned 16-bit number in big-en=
dian
> > +  format.
> > +* `htobe32`: Takes an unsigned 32-bit number in host-endian format and
> > +  returns the equivalent number as an unsigned 32-bit number in big-en=
dian
> > +  format.
> > +* `htobe64`: Takes an unsigned 64-bit number in host-endian format and
> > +  returns the equivalent number as an unsigned 64-bit number in big-en=
dian
> > +  format.
> > +* `htole16`: Takes an unsigned 16-bit number in host-endian format and
> > +  returns the equivalent number as an unsigned 16-bit number in little=
-endian
> > +  format.
> > +* `htole32`: Takes an unsigned 32-bit number in host-endian format and
> > +  returns the equivalent number as an unsigned 32-bit number in little=
-endian
> > +  format.
> > +* `htole64`: Takes an unsigned 64-bit number in host-endian format and
> > +  returns the equivalent number as an unsigned 64-bit number in little=
-endian
> > +  format.
> > +* `bswap16`: Takes an unsigned 16-bit number in either big- or little-=
endian
> > +  format and returns the equivalent number with the same bit width but
> > +  opposite endianness.
> > +* `bswap32`: Takes an unsigned 32-bit number in either big- or little-=
endian
> > +  format and returns the equivalent number with the same bit width but
> > +  opposite endianness.
> > +* `bswap64`: Takes an unsigned 64-bit number in either big- or little-=
endian
> > +  format and returns the equivalent number with the same bit width but
> > +  opposite endianness.
>
> Upon further reflection, maybe this belongs in the Byte swap
> instructions section of the document? The types make sense to list above
> because they're ubiquitous throughout the doc, but these are really 100%
> specific to byte swap.

I am not opposed to that. The only reason that I put them here was to
make it fully centralized. They are also going to be used in the
Appendix and I was hoping not to have to reproduce them there. In v4
of the patch I will leave them here and then if we do feel like we
should move them I will happily make a v5!

Thank you again for the feedback! A new revision of the patch will be
out shortly!

Have a great rest of the weekend!
Will

>
> >
> >  Registers and calling convention
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > @@ -252,19 +311,23 @@ are supported: 16, 32 and 64.
> >
> >  Examples:
> >
> > -``BPF_ALU | BPF_TO_LE | BPF_END`` with imm =3D 16 means::
> > +``BPF_ALU | BPF_TO_LE | BPF_END`` with imm =3D 16/32/64 means::
> >
> >    dst =3D htole16(dst)
> > +  dst =3D htole32(dst)
> > +  dst =3D htole64(dst)
> >
> > -``BPF_ALU | BPF_TO_BE | BPF_END`` with imm =3D 64 means::
> > +``BPF_ALU | BPF_TO_BE | BPF_END`` with imm =3D 16/32/64 means::
> >
> > +  dst =3D htobe16(dst)
> > +  dst =3D htobe32(dst)
> >    dst =3D htobe64(dst)
> >
> >  ``BPF_ALU64 | BPF_TO_LE | BPF_END`` with imm =3D 16/32/64 means::
> >
> > -  dst =3D bswap16 dst
> > -  dst =3D bswap32 dst
> > -  dst =3D bswap64 dst
> > +  dst =3D bswap16(dst)
> > +  dst =3D bswap32(dst)
> > +  dst =3D bswap64(dst)
> >
>
> [...]
>
> - David


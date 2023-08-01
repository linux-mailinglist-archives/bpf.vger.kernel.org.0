Return-Path: <bpf+bounces-6610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FA276BE1D
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 21:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75905280E74
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 19:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A05253BC;
	Tue,  1 Aug 2023 19:49:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F114DC6B
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 19:49:38 +0000 (UTC)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4D826AA
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 12:49:28 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-63d3583d0efso41344566d6.1
        for <bpf@vger.kernel.org>; Tue, 01 Aug 2023 12:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1690919367; x=1691524167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4VsubkDRJqP44SKDtlYDzRR13m+oCWB54EA9z/XG5i4=;
        b=4aCyC3oPgRtDj9S5F91+Pv5oHrgzl47up+HZbM3yv21dRNxPFOBzmFOZlwVMhVlWbl
         mdvfFYLSm1gOk8tBRh9UZ0FbdHF91GgcP+ib64+l1/nJRj5erL9rAYTwWPIH7jf0cIsT
         TdEgg36waR6AvDCJR4PnuArPiu2ooZLUCCavpBWzmUbTtGc6xgIEGwkXLdo4ppJiYPAS
         7mO6OtIaKH3pR+mt9yJUFmALIJLz32tQSsZFG9UzehABgwUTnxQmvj9XRQLDt4bYxUII
         TtV/pwt7yt8jPfV24PnjoLcxgCIPZa0a14YWRpWGGPwMTUkMBxc9VATko9zH1H1xaPJ7
         RcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690919367; x=1691524167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4VsubkDRJqP44SKDtlYDzRR13m+oCWB54EA9z/XG5i4=;
        b=i0YsaPzGLtIXtQFIO+E9qvprCetiRjxPE4B09ar70gNYxnN6eYdc9x4qksOs9sfNRs
         XrJ1t4p2w0a+PInZMENGgoFcL/DSInAuPzpBh/zwmbakRkwD+BrSBmaepIyn9thWO8C4
         aH1Tj1y+BzRIorCdG5HpDI+019V8+6UZS4n0JJ9ZEFqMc8YVtEdjhzAOGqw+kdMPYZGa
         HEP4UKuXY7ADBeCI7LlEVOl4dDcNmkByMO0ltv50BGleP4pJQC5UOWGyfjK1UZLpHCzu
         Z4OZnTZf1g59ij9xRxwxxyKB6KWWV/nsPFbwHxJi6sVVCiXOHjJ5oURHh9k9CbYtDE4y
         5Lxw==
X-Gm-Message-State: ABy/qLYXDup50YsX6TP7XycM9Pwjsa3DP7e0m76Ftp8C3K3pC98G6BAb
	jso+aFbe8CG0Q1DuYfk+VIcrXJQUQnYpXheiXw0GRjvxpARt/31Q
X-Google-Smtp-Source: APBJJlGgu6pvmnvYuAmQNc9KhJ/t4bc1s5FP49nh5MgDSTnQKTNjVLO5ATb10VmojNTJi7RFPxDLG6VTkwpvo4AX1vM=
X-Received: by 2002:a0c:a792:0:b0:632:2649:d719 with SMTP id
 v18-20020a0ca792000000b006322649d719mr11994174qva.30.1690919367034; Tue, 01
 Aug 2023 12:49:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230730035156.2728106-1-hawkinsw@obs.cr> <20230730035156.2728106-2-hawkinsw@obs.cr>
 <20230801193538.GA472124@maniforge>
In-Reply-To: <20230801193538.GA472124@maniforge>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Tue, 1 Aug 2023 15:49:16 -0400
Message-ID: <CADx9qWizG61pAwGROHaJuHY3DtKHPn28nXypuAaUtjs7T=qs8A@mail.gmail.com>
Subject: Re: [Bpf] [PATCH 1/1] bpf, docs: Formalize type notation and function
 semantics in ISA standard
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thank you for the feedback! Responses inline.

On Tue, Aug 1, 2023 at 3:35=E2=80=AFPM David Vernet <void@manifault.com> wr=
ote:
>
> On Sat, Jul 29, 2023 at 11:51:56PM -0400, Will Hawkins wrote:
> > Give a single place where the shorthand for types are defined and the
> > semantics of helper functions are described.
> >
> > Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
> > ---
> >  .../bpf/standardization/instruction-set.rst   | 65 ++++++++++++++++++-
> >  Documentation/sphinx/requirements.txt         |  2 +-
> >  2 files changed, 63 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Do=
cumentation/bpf/standardization/instruction-set.rst
> > index fb8154cedd84..97378388e20b 100644
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
> > +of types using a shorthand syntax and refers to several helper
> > +functions when explaining the semantics of opcodes. The range
>
> nit: Can we use a different term than "helper functions" here, just
> because it's an overloaded term for BPF. Maybe "shorthand functions" or
> "mnemonic functions"? Or just "functions"?

Great idea. I like the term mnemonic functions (given that we talk
about mnemonics with opcodes). I will go with that unless there is
additional guidance.

>
> > +of valid values for those types and the semantics of those functions
> > +are defined in the following subsections.
> > +
> > +Types
> > +-----
> > +This document refers to integer types with a notation of the form `SX`
>
> I suggest replacing `SX` with `Sn`, as `SX` is short for sign-extension
> in several instructions.

Good point! Will do!

>
> > +that succinctly defines whether their values are signed or unsigned
> > +numbers and the bit widths:
> > +
> > +=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D
> > +`S` Meaning
> > +=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D
> > +`u` unsigned
> > +`s` signed
> > +=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D
> > +
> > +=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +`X`   Bit width
> > +=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +`8`   8 bits
> > +`16`  16 bits
> > +`32`  32 bits
> > +`64`  64 bits
> > +`128` 128 bits
> > +=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D
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
>
> Hmm, some of these functions aren't actually used elsewhere in the
> document. Maybe update the hto{b,l}eN examples later in the Byte swap
> instructions section to match bswapN where all widths are illustrated in
> the example?
>

Another great point. Will do!


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
> >
> >  Registers and calling convention
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > diff --git a/Documentation/sphinx/requirements.txt b/Documentation/sphi=
nx/requirements.txt
> > index 335b53df35e2..9479c5c2e338 100644
> > --- a/Documentation/sphinx/requirements.txt
> > +++ b/Documentation/sphinx/requirements.txt
> > @@ -1,3 +1,3 @@
> >  # jinja2>=3D3.1 is not compatible with Sphinx<4.0
> >  jinja2<3.1
> > -Sphinx=3D=3D2.4.4
> > +Sphinx=3D=3D7.1.1
>
> I don't think we can unilaterally update the whole kernel docs tree to
> require a new version of Sphinx like this. Could you please clarify why
> you needed to update it? Was it for the tables or something?

An absolute git typo on my part. I will remove in v2.

Thanks again for the feedback!
Will


>
> > --
> > 2.40.1
> >
> > --
> > Bpf mailing list
> > Bpf@ietf.org
> > https://www.ietf.org/mailman/listinfo/bpf


Return-Path: <bpf+bounces-71446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C61BF39DF
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 23:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3ADD4FEF9A
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 21:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29732E9EAA;
	Mon, 20 Oct 2025 20:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPwwf6hS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B0D2E62BF
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 20:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760993895; cv=none; b=HDpx5RsFySHCqTvGhpCindak/72nVVirTWtygh/XfX3jhFibbr89PdyMdBwg8QOaZSwHCCDZSsNL5UG6RWlEPPBMmYUsTVEVQKUe6vKKH9jTqEef1PO9xA5prCLErIjIB46BZcYKd5PrZ9SwrRyAf6JNoExPP4im83cqwnYzcGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760993895; c=relaxed/simple;
	bh=ZG9UCd889CQdz4r4zfVS51ATPlBclEmo0Uk2C5eHUq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJBakjtBJ1eGDCDLu16Chl1s3Gw3a47dSb+AENRUJAQ0LYZ4HpbfgObxHrUwHTe5FK7lC6lFmgAJfqdCjMv5p0G6GlkGm1Ssyvj7oXR45CTSTGH5yw8oGcoh5l/cxqu+Wu7vFpijWX6bx9RcuyTFe5vIQyySpJPVMuB494kxnFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPwwf6hS; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77f5d497692so5878142b3a.1
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 13:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760993893; x=1761598693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=185KjAz9KJe26nN7W/KSrP4Gwt2yR9qFTTm5RW75sN4=;
        b=aPwwf6hSZUxz0MqKBPWkXDpp0i9Xkz+jtyodO2qAJHGmlLZ/DqAhnIzwzMQaYt53Te
         6xVQ6jF+GIpPedHe3GhsQk5r7kjlT2y4Nsg/jMs/s7a7coOqCR6N806SgftuLMbTl/bz
         giJ6uwyt4Dc8+7ScgiJYtNr21dGGLTcfyRfRfbAaTTq/0Hx8p4zHRPX4E5FUDKEnwHDh
         HPEzR9bdLz8dhg7Y+n2rMNu6ibEDN7eiJ4uJFM3uTTEka+CFPT27zoB4GTR1BFw1wAbm
         OY7en0WX9KLMPcZ2f1l2mCF+bskPFQEmailx4XZqfkhMJiAUDPhjwRHjnH4PqKkueHB2
         WpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760993893; x=1761598693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=185KjAz9KJe26nN7W/KSrP4Gwt2yR9qFTTm5RW75sN4=;
        b=bZFVghWuZbb8liDc538bR58vG0QP9WoOj1Vt7yWw8IKVhas7XVD+fl9LnArkLzEQxY
         +mTey8AuXSQtVSthbe/v943LCn9K3CqdNNQFQ7uBt3chiwqhPGQRkJBiZy0he669J+lD
         r07vJ43Os/08sXCNouzE6djHrTARoweNvsk5g94E742/XSSJORcxBrDdM+uB3VhqzlHv
         MUR1SJ4984BYkS6udK4/0Im7oHb43M++owsE0a6BFbdru3Y/nuIGm5cKdDkQAqM+eHze
         LF9zGNle6n6VbYwe4VFgzXdcGp4fTeau5CCnMPasMmzJsrRc0rIfsXBZJhfTjGyYkh8B
         +l5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXXEDRDnZ0recFu2Tm+J5y4sxD8si7O46D4mthe8YF4fOgZ1ux0eWZRTQCYL/kHSvvAKlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZxSIXDkHJjgbeNEu/ZuWTEirpPDJ56oxk1JYAkpXWu6LHr6LP
	/fRgI9+wcNHwBEL+9ZRUAzVjhxvYsJNKB3VbgG3bRdXvmmOkselI50OUdVTkljVRF2MUHuKzY5a
	bmKo5o/1rcU+G5tylrJgyDuct7wQi10s=
X-Gm-Gg: ASbGncv7uqP3xF+jrkBEfrDUA1MHvCEz2anXNorW3I2CplCcYPFKbR7er2v1J1wVHsX
	UXFyMmeV6NsidqbrM6vlB5Iaae7/8oOCbisjP7koqFCeWwk6wG1i72t4jXWd8Xj23NVdoj291ng
	Qm+0LKfIPahr55JcwivMhjiOdvlz/OtBhCa6FTDFntsV3Wrq9ELaLB6nnbONIIUPtcPfndQGmQA
	NSdIlHcbdOUea6ILmPt73TZRyN9CqQEG+efedGjb9m0vC3WgtqizHlVgapY/Eb+Ok0awhpfJ8l1
X-Google-Smtp-Source: AGHT+IFRM0tB0GqmxwcdVG/edv6LRSqdWFd7Y/s6q2iQyRP7YrAMsHVAxvF+RKEbnuA6W7X8OnugvZ/Am22WWMs8tr8=
X-Received: by 2002:a17:90b:5111:b0:330:84c8:92d0 with SMTP id
 98e67ed59e1d1-33bcf8e57e3mr18929384a91.24.1760993892584; Mon, 20 Oct 2025
 13:58:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008173512.731801-1-alan.maguire@oracle.com>
 <20251008173512.731801-2-alan.maguire@oracle.com> <CAEf4BzZ-0POy7UyFbyN37Y6zx+_2Q0kKR3hrQffq+KW6MOkZ1w@mail.gmail.com>
 <f2e1fd61-7d3a-4aa6-9d36-a74987d040fe@oracle.com>
In-Reply-To: <f2e1fd61-7d3a-4aa6-9d36-a74987d040fe@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 20 Oct 2025 13:57:57 -0700
X-Gm-Features: AS18NWAaoYD76Qt5SNWA4V9Eclhn2pa280Syktic9rVx1Llzttt0AZsdwWfiLog
Message-ID: <CAEf4Bza+zCKVHPHFDnNtKoYNGfeq+y7Oi96-+GGWOb8kop8tHA@mail.gmail.com>
Subject: Re: [RFC bpf-next 01/15] bpf: Extend UAPI to support location information
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com, 
	yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	qmo@kernel.org, ihor.solodrai@linux.dev, david.faust@oracle.com, 
	jose.marchesi@oracle.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 1:43=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 16/10/2025 19:36, Andrii Nakryiko wrote:
> > On Wed, Oct 8, 2025 at 10:35=E2=80=AFAM Alan Maguire <alan.maguire@orac=
le.com> wrote:
> >>
> >> Add BTF_KIND_LOC_PARAM, BTF_KIND_LOC_PROTO and BTF_KIND_LOCSEC
> >> to help represent location information for functions.
> >>
> >> BTF_KIND_LOC_PARAM is used to represent how we retrieve data at a
> >> location; either via a register, or register+offset or a
> >> constant value.
> >>
> >> BTF_KIND_LOC_PROTO represents location information about a location
> >> with multiple BTF_KIND_LOC_PARAMs.
> >>
> >> And finally BTF_KIND_LOCSEC is a set of location sites, each
> >> of which has
> >>
> >> - a name (function name)
> >> - a function prototype specifying which types are associated
> >>   with parameters
> >> - a location prototype specifying where to find those parameters
> >> - an address offset
> >>
> >> This can be used to represent
> >>
> >> - a fully-inlined function
> >> - a partially-inlined function where some _LOC_PROTOs represent
> >>   inlined sites as above and others have normal _FUNC representations
> >> - a function with optimized parameters; again the FUNC_PROTO
> >>   represents the original function, with LOC info telling us
> >>   where to obtain each parameter (or 0 if the parameter is
> >>   unobtainable)
> >>
> >> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >> ---
> >>  include/linux/btf.h            |  29 +++++-
> >>  include/uapi/linux/btf.h       |  85 ++++++++++++++++-
> >>  kernel/bpf/btf.c               | 168 ++++++++++++++++++++++++++++++++=
-
> >>  tools/include/uapi/linux/btf.h |  85 ++++++++++++++++-
> >>  4 files changed, 359 insertions(+), 8 deletions(-)
> >>
> >
> > [...]
> >
> >> @@ -78,6 +80,9 @@ enum {
> >>         BTF_KIND_DECL_TAG       =3D 17,   /* Decl Tag */
> >>         BTF_KIND_TYPE_TAG       =3D 18,   /* Type Tag */
> >>         BTF_KIND_ENUM64         =3D 19,   /* Enumeration up to 64-bit =
values */
> >> +       BTF_KIND_LOC_PARAM      =3D 20,   /* Location parameter inform=
ation */
> >> +       BTF_KIND_LOC_PROTO      =3D 21,   /* Location prototype for si=
te */
> >> +       BTF_KIND_LOCSEC         =3D 22,   /* Location section */
> >>
> >>         NR_BTF_KINDS,
> >>         BTF_KIND_MAX            =3D NR_BTF_KINDS - 1,
> >> @@ -198,4 +203,78 @@ struct btf_enum64 {
> >>         __u32   val_hi32;
> >>  };
> >>
> >> +/* BTF_KIND_LOC_PARAM consists a btf_type specifying a vlen of 0, nam=
e_off is 0
> >
> > what if we make LOC_PARAM variable-length (i.e., use vlen). We can
> > always have a fixed 4 bytes value that will contain an arg size, maybe
> > some flags, and an enum representing what kind of location spec it is
> > (constant, register, reg-deref, reg+off, reg+off-deref, etc). And then
> > depending on that enum we'll know how to interpret those vlen * 4
> > bytes. This will give us extensibility to support more complicated
> > expressions, when we will be ready to tackle them. Still nicely
> > dedupable, though. WDYT?
> >
>
> It's a great idea; extensibility is really important here as I hope we
> can learn to cover some of the additional location cases we don't
> currently. Also we can retire the whole "continue" flag thing for cases
> like multi-register representations of structs; we can instead have a
> vlen 2 representation with registers in each slot. What's also nice
> about that is that it lines up the LOC_PROTO and FUNC_PROTO indices for
> parameters so the same index in LOC_PROTO has its type in FUNC_PROTO.
>
> In terms of specifics, I think removing the arg size from the type/size
> btf_type field is a good thing as you suggest; having to reinterpret
> negative values there is messy. So what about
>
> /* BTF_KIND_LOC_PARAM consists a btf_type specifying a vlen of 0,
> name_off and type/size are 0.
>  * It is followed by a singular "struct btf_loc_param" and a
> vlen-specified set of "struct btf_loc_param_data".
>  */
>
> enum {

nit: name this enum, so we can refer to it from comments

>         BTF_LOC_PARAM_REG_DATA,
>         BTF_LOC_PARAM_CONST_DATA,
> };
>
> struct btf_loc_param {
>         __u8 size;      /* signed size; negative values represent signed
>                          * values of the specified size, for example -8
>                          * is an 8-byte signed value.
>                          */
>         __u8 data;      /* interpret struct btf_loc_param_data */

e.g., this will mention that this is enum btf_loc_param_kind from the above

>         __u16 flags;
> };
>
> struct btf_loc_param_data {
>         union {
>                 struct {
>                         __u16   reg;            /* register number */
>                         __u16   flags;          /* register dereference *=
/
>                         __s32   offset;         /* offset from
> register-stored address */
>                 };
>                 struct {
>                         __u32 val_lo32;         /* lo 32 bits of 64-bit
> value */
>                         __u32 val_hi32;         /* hi 32 bits of 64-bit
> value */
>                 };
>         };
> };

I'd actually specify that each vlen element is 4 byte long (that's
minimal reasonable size we can use to keep everything aligned well),
and then just specify how to interpret those values depending on that
loc_param_kind. I.e., for register we can use vlen=3D1, and say that
those 4 bytes define register number (or whatever we will use to
identify the register). But for reg+offset we have vlen=3D2, where first
is register as before, second is offset value. And so on.

>
> I realize we have flags in two places (loc_param and loc_param_data for
> registers); just in case we needed some sort of mix of register value
> and register dereference I think that makes sense; haven't seen that in
> practice yet though. Let me know if the above is what you have in mind.

see above, I think having spec for each kind of param location and
using minimal amount of data will give us this future-proof approach.
We don't even have to define flags until we have them, just specify
that all unused bits/bytes should be zero, until used in the future.

>
>
> >> + * and is followed by a singular "struct btf_loc_param". type/size sp=
ecifies
> >> + * the size of the associated location value.  The size value should =
be
> >> + * cast to a __s32 as negative sizes can be specified; -8 to indicate=
 a signed
> >> + * 8 byte value for example.
> >> + *
> >> + * If kind_flag is 1 the btf_loc is a constant value, otherwise it re=
presents
> >> + * a register, possibly dereferencing it with the specified offset.
> >> + *
> >> + * "struct btf_type" is followed by a "struct btf_loc_param" which co=
nsists
> >> + * of either the 64-bit value or the register number, offset etc.
> >> + * Interpretation depends on whether the kind_flag is set as describe=
d above.
> >> + */
> >> +
> >> +/* BTF_KIND_LOC_PARAM specifies a signed size; negative values repres=
ent signed
> >> + * values of the specific size, for example -8 is an 8-byte signed va=
lue.
> >> + */
> >> +#define BTF_TYPE_LOC_PARAM_SIZE(t)     ((__s32)((t)->size))
> >> +
> >> +/* location param specified by reg + offset is a dereference */
> >> +#define BTF_LOC_FLAG_REG_DEREF         0x1
> >> +/* next location param is needed to specify parameter location also; =
for example
> >> + * when two registers are used to store a 16-byte struct by value.
> >> + */
> >> +#define BTF_LOC_FLAG_CONTINUE          0x2
> >> +
> >> +struct btf_loc_param {
> >> +       union {
> >> +               struct {
> >> +                       __u16   reg;            /* register number */
> >> +                       __u16   flags;          /* register dereferenc=
e */
> >> +                       __s32   offset;         /* offset from registe=
r-stored address */
> >> +               };
> >> +               struct {
> >> +                       __u32 val_lo32;         /* lo 32 bits of 64-bi=
t value */
> >> +                       __u32 val_hi32;         /* hi 32 bits of 64-bi=
t value */
> >> +               };
> >> +       };
> >> +};
> >> +
> >> +/* BTF_KIND_LOC_PROTO specifies location prototypes; i.e. how locatio=
ns relate
> >> + * to parameters; a struct btf_type of BTF_KIND_LOC_PROTO is followed=
 by a
> >> + * a vlen-specified number of __u32 which specify the associated
> >> + * BTF_KIND_LOC_PARAM for each function parameter associated with the
> >> + * location.  The type should either be 0 (no location info) or point=
 at
> >> + * a BTF_KIND_LOC_PARAM.  Multiple BTF_KIND_LOC_PARAMs can be used to
> >> + * represent a single function parameter; in such a case each should =
specify
> >> + * BTF_LOC_FLAG_CONTINUE.
> >> + *
> >> + * The type field in the associated "struct btf_type" should point at=
 an
> >> + * associated BTF_KIND_FUNC_PROTO.
> >> + */
> >> +
> >> +/* BTF_KIND_LOCSEC consists of vlen-specified number of "struct btf_l=
oc"
> >> + * containing location site-specific information;
> >> + *
> >> + * - name associated with the location (name_off)
> >> + * - function prototype type id (func_proto)
> >> + * - location prototype type id (loc_proto)
> >> + * - address offset (offset)
> >> + */
> >> +
> >> +struct btf_loc {
> >> +       __u32 name_off;
> >> +       __u32 func_proto;
> >> +       __u32 loc_proto;
> >> +       __u32 offset;
> >> +};
> >
> > What is that offset relative to? Offset within the function in which
> > we were inlined? Do we know what that function is? I might have missed
> > how we represent that.
>
> The offset is relative to kernel base address (at compile-time the
> address of .text, at runtime the address of _start). The reasoning is we
> have to deal with kASLR which means any compile-time absolute address
> will likely change when the kernel is loaded. So we cannot deal in raw
> addresses, and to fixup the addresses we then gather kernel/module base
> address at runtime to compute the actual location of the inline site.
> See get_base_addr() in tools/lib/bpf/loc.c in patch 14 for an example of
> how this is done.

this makes sense, but this should be documented, IMO

>
> Given this, it might make sense to have a convention where the LOCSEC
> specifies the section name also, something like
>
> "inline.text"
>
> What do you think?

hm... I'd specify offsets relative to the KASLR base, uniformly.
Section name is a somewhat superficial detail in terms of tracing
kernel functions, I don't know if it's that important to group
functions by ELF section. (unless I'm missing where this would be
important for correctness?)

>
> >
> >> +
> >> +/* helps libbpf know that location declarations are present; libbpf
> >> + * can then work around absence if this value is not set.
> >> + */
> >> +#define BTF_KIND_LOC_UAPI_DEFINED 1
> >> +
> >
> > you don't mention that in the commit, I'll have to figure this out
> > from subsequent patches, but it would be nice to give an overview of
> > the purpose of this in this patch
> >
>
> This is a bit ugly, but is intended to help deal with the situation -
> which happens a lot with distros where we might want to build libbpf
> without latest UAPI headers (some distros may not get new UAPI headers
> for a while). The libbpf patches check if the above is defined, and if
> not supply their own location-related definitions. If in turn libbpf
> needs to define them, it defines BTF_KIND_LOC_LIBBPF_DEFINED. Finally
> pahole - which needs to compile both with a checkpointed libbpf commit
> and a libbpf that may be older and not have location definitions -
> checks for either, and if not present does a similar set of declarations
> to ensure compilation still succeeds. We use weak declarations of libbpf
> location-related functions locally to check if they are available at
> runtime; this dynamically determines if the inline feature is available.
>
> Not pretty, but it will help avioid some of the issues we had with BTF
> enum64 and compilation.

um... all this is completely unnecessary because libbpf is supplying
its own freshest UAPI headers it needs in Github mirror under
include/uapi/linux subdir. Distros should use those UAPI headers to
build libbpf from source.

So the above BTF_KIND_LOC_UAPI_DEFINED hack is not necessary.

>
> Thanks!
>
> Alan


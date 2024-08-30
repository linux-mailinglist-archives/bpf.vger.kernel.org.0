Return-Path: <bpf+bounces-38616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C14966C32
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2024 00:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12641B230CA
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 22:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF6C1C1754;
	Fri, 30 Aug 2024 22:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dk06jZn1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B668136337
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 22:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725056313; cv=none; b=OyplehjX2pH0B8vQvCm2XoiaqzbU5+RfKu0yip3VASEO05/s9aGK3rSlzQvDpvj09qGzW2HRNGp/7SLIOAO3oQfxGHDwQw5nAWsly1UfSoUzKTMBwizgRc8Q3HWp0nFP7Uu8ZLzxOM1OTg9muMCdyx7AqsZqqn3lXbpRPvwY4U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725056313; c=relaxed/simple;
	bh=DUUEc5xLtgC6XgwKvC2RwxuL6VSixQO9Cmrh5LiBg0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XwGoPJFORbii2DCLVOrUdO/mXKzMbwO1/ePXYQHvxbU2pVGl42v5YTStkyWHnx+JlAF+WuxAk4Vod4Kc2EBHJ0ovq/tDGgNcwisFlcVxlbYbL06dTpo0k9k0JfAMWKhH5zGOcqjG4uxnO1SEddg0dUpmeGFix8et8wMM2ZYYSmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dk06jZn1; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d3bae081efso1744922a91.1
        for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 15:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725056311; x=1725661111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acf6/fHSPHwGSCd2XYxg9Uw4r27tCcLgOvZlDI7ltb0=;
        b=dk06jZn1n2yOKDAQOGczALTGg+WsukQF+oy7anOVcNELfnmipHwP5/1IdN3QYEJ5Yh
         9eg6+yvsPky8sOEo1TnNRY/gEBIcf5AI8uH9d5n22l2mLS5J15g5I+68i7OsRyApNuJq
         ATq37ZYMp4glCHP2JK1K46ZvlZoph9TLFpONDpqyzvHFNchhzPql5unBfVeyeNHzJErM
         y3qiRnZ30ox6OYmJ01qAtzr7FSf1Mg/tIoZmcR6tdAvkcZG2eQz4T7QA78gJOVY5atDy
         c9hcTVb0PAL7ACGRttCF8RhmyGm5gjxwc7ntQRWUaW/TRfw+U/54bC8oSlS99X3uKw9+
         R7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725056311; x=1725661111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=acf6/fHSPHwGSCd2XYxg9Uw4r27tCcLgOvZlDI7ltb0=;
        b=sbIm7LTNNvNQhr1kS3P8v2VTog/LnVmlf91cfaowee4eI/o9lnnnRBfixmG3JGXGER
         qtAiKmFsONti6JvgGv5QZ3TqWx0GKOgw9HShTesG4I122uw6L/hO6ebpAuHRPFKEfsKT
         L7yT23uGpYDp3pttPEArkvJaP3fGzXX5T0K1cc2KhBP+5LO6lN226emwRkoquY/lZ8pR
         E3Z7EgrTWaxBuyVyB3KeUJP6dDyob8406GxZviCoxddfkWj7EMnmLPhl+gjxbtEzT+54
         lOd93iJs+bb2aoFg3KiTZm88C/Chv0vKUW2k/fbHNyUfnnxOlfJfI/mEeY4CaZEN3O3B
         UwlA==
X-Forwarded-Encrypted: i=1; AJvYcCV1Ctrnp/iuv2+vanfAUspDJ73ISOUfJ8rJJ430aVBPGm4evtdxTVe2DwOvnrh3JINdEwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwRHAMb3gQyiKbApRWwt2Aj+2xoKVgoed/VzjzYbjO55sQFwq6
	awAt7Pd7obXpLKNEnQSQ7j5z4+ugMuThjiiWNX2tOE+MlYRKLv1ZDk/htJaNMI/2A/jzIbB7rmd
	UQpjtIDzuElf7LmMm6H1cArX5e1A=
X-Google-Smtp-Source: AGHT+IHHxbpAti6EAwEllMCkh8IEuUd2b81IljSuXX/NCFZMhd50fgB13QOoxUZNtMZ/y+Leyq+iWAR7irh3DznJGsI=
X-Received: by 2002:a17:90a:be17:b0:2d8:7804:b3a with SMTP id
 98e67ed59e1d1-2d878040ba9mr3051724a91.26.1725056311413; Fri, 30 Aug 2024
 15:18:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828174608.377204-1-ihor.solodrai@pm.me> <20240828174608.377204-2-ihor.solodrai@pm.me>
 <b48f348c76dd5b724384aef7c7c067877b28ee5b.camel@gmail.com>
 <CAEf4BzaBMhb4a2Y-2_mcLmYjJ2UWQuwNF-2sPVJXo39+0ziqzw@mail.gmail.com> <45a24817-358d-4d25-ae7c-118539ec2ba7@gmail.com>
In-Reply-To: <45a24817-358d-4d25-ae7c-118539ec2ba7@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Aug 2024 15:18:19 -0700
Message-ID: <CAEf4BzaZ=dRxXquS+zNqbKSOsAsiGTDMcEH+WwfgS=5D0D0+-Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: do not update vmlinux.h unnecessarily
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>, Ihor Solodrai <ihor.solodrai@pm.me>, bpf@vger.kernel.org, 
	andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, mykolal@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 2:23=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 30/08/2024 21:34, Andrii Nakryiko wrote:
> > On Wed, Aug 28, 2024 at 3:02=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> >> On Wed, 2024-08-28 at 17:46 +0000, Ihor Solodrai wrote:
> >>> %.bpf.o objects depend on vmlinux.h, which makes them transitively
> >>> dependent on unnecessary libbpf headers. However vmlinux.h doesn't
> >>> actually change as often.
> >>>
> >>> When generating vmlinux.h, compare it to a previous version and updat=
e
> >>> it only if there are changes.
> >>>
> >>> Example of build time improvement (after first clean build):
> >>>    $ touch ../../../lib/bpf/bpf.h
> >>>    $ time make -j8
> >>> Before: real  1m37.592s
> >>> After:  real  0m27.310s
> >>>
> >>> Notice that %.bpf.o gen step is skipped if vmlinux.h hasn't changed.
> >>>
> >>> Link: https://lore.kernel.org/bpf/CAEf4BzY1z5cC7BKye8=3DA8aTVxpsCzD=
=3Dp1jdTfKC7i0XVuYoHUQ@mail.gmail.com
> >>>
> >>> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> >>> ---
> >> Unfortunately, I think that this is a half-measure.
> >> E.g. the following command forces tests rebuild for me:
> >>
> >>    touch ../../../../kernel/bpf/verifier.c; \
> >>    make -j22 -C ../../../../; \
> >>    time make test_progs
> >>
> >> To workaround this we need to enable reproducible_build option:
> >>
> >>      diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> >>      index b75f09f3f424..8cd648f3e32b 100644
> >>      --- a/scripts/Makefile.btf
> >>      +++ b/scripts/Makefile.btf
> >>      @@ -19,7 +19,7 @@ pahole-flags-$(call test-ge, $(pahole-ver), 125=
)      +=3D --skip_encoding_btf_inconsis
> >>       else
> >>
> >>       # Switch to using --btf_features for v1.26 and later.
> >>      -pahole-flags-$(call test-ge, $(pahole-ver), 126)  =3D -j --btf_f=
eatures=3Dencode_force,var,float,enum64,decl_tag,type_tag,optimized_func,co=
nsistent_func,decl_tag_kfuncs
> >>      +pahole-flags-$(call test-ge, $(pahole-ver), 126)  =3D -j --btf_f=
eatures=3Dencode_force,var,float,enum64,decl_tag,type_tag,optimized_func,co=
nsistent_func,decl_tag_kfuncs,reproducible_build
> >>
> >>       ifneq ($(KBUILD_EXTMOD),)
> >>       module-pahole-flags-$(call test-ge, $(pahole-ver), 126) +=3D --b=
tf_features=3Ddistilled_base
> >>
> >> Question to the mailing list: do we want this?
> > Alan, can you please give us a summary of what are the consequences of
> > the reproducible_build pahole option? In terms of performance and
> > otherwise.
> >
> > I've applied patches as is, despite them not solving the issue
> > completely, as they are moving us in the right direction anyways. I do
> > get slightly different BTF every single time I rebuild my kernel, so
> > the change in patch #2 doesn't yet help me.
> >
> > For libbpf headers, Ihor, can you please follow up with adding
> > bpf_helper_defs.h as a dependency?
> >
> > I have some ideas on how to make BTF regeneration in vmlinux.h itself
> > unnecessary, that might help with this issue. Separately (depending on
> > what are the negatives of the reproducible_build option) we can look
> > into making pahole have more consistent internal BTF type ordering
> > without negatively affecting the overall BTF dedup performance in
> > pahole. Hopefully I can work with Ihor on this as follow ups.
> >
> > P.S. I also spent more time than I'm willing to admit trying to
> > improve bpftool's BTF sorting to minimize the chance of vmlinux.h
> > contents being different, and I think I removed a bunch of cases where
> > we had unnecessary differences, but still, it's fundamentally
> > non-deterministic to do everything based on type and field names,
> > unfortunately.
> >
> > Anyways, Mykyta (cc'ed), what do you think about the changes below?
> > Note that I'm also fixing the incorrect handling of enum64 (would be
> > nice to prepare a proper patch and send it upstream, if you get a
> > chance).
> >

[...]

> >   static struct sort_datum *sort_btf_c(const struct btf *btf)
> > @@ -615,8 +680,9 @@ static struct sort_datum *sort_btf_c(const struct b=
tf *btf)
> >
> >                  d->index =3D i;
> >                  d->type_rank =3D btf_type_rank(btf, i, false);
> > -               d->sort_name =3D btf_type_sort_name(btf, i, false);
> > +               d->sort_name =3D btf_type_sort_name(btf, i, false, "");
> >                  d->own_name =3D btf__name_by_offset(btf, t->name_off);
> > +               d->disambig_hash =3D btf_type_disambig_hash(btf, i);
> >          }
> >
> >          qsort(datums, n, sizeof(struct sort_datum), btf_type_compare);
> >
> Thanks for pointing to the bug of enum64 handling. I'll create a patch.

great, thanks

> Reading the rest of the code, hashing struct/union/enum fields is
> introduced:
> this is only useful for disambiguating ordering of the anonymous
> structs/unions/enums.

yes, I was trying to have some sort of fixed order. What I was doing
was basically:

touch kernel/bpf/verifier.c && make -j$(nproc)

and after that generated vmlinux.h and compared with the previous version.

And every single time it differs a bit due to a) there being types
that are named the same, but really are different types and b) as a
consequence, different order of types will cause different ___2, ___3
suffixes, which causes tiny changes to vmlinux.h)

Reproducible build would help with the ordering, but I was hoping to
achieve similar effect with bpftool (and I did remove some of the
unnecessary changes, but not all).

>
> I suspect the biggest source of the issues are structs and unions, though=
.
> Are definitions like this create problems?
> typedef struct {...} foo_t;
> ?
> I'll check what other differences this change makes.

just try the kernel rebuild and vmlinux.h generation steps above, you'll se=
e :)

> >> [...]
> >>
>


Return-Path: <bpf+bounces-29326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5378C191B
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D23A6B21737
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 22:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE90F1292E6;
	Thu,  9 May 2024 22:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXEUPeIH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A058564E;
	Thu,  9 May 2024 22:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715292081; cv=none; b=ABevcFfWUc8//5SIP1di120ja+JhiKpindRDjlt+ArgNggRvlX0yB3jrmisbhxpP9kscAVZhyTGwVb+glt4ly/A8Cjt2miTeWM3RNTJUAraGtxb72IkHLXea9NSV7F1wMPzZjtOhhzYBEEyDLYc0xLWISN40kMTawHqa+XdZ8LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715292081; c=relaxed/simple;
	bh=2/w28/GNQZgDAzE1NWP3JOTHqnw1GXCJ9V87Zugb8kg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bdRXtPa3FqJUKdWz7STIXTeMcA4HY3WNeWC1qMvqxYL9nMKgaTpZ5D5AVGdgLoWlln8NHXkPfJsTM8Hc8MYkTP+bOZtT7t5Br+ml9Ozc6K0EEZbe7ba7XsrD5tr+VnmGaZjebcfLdfS5FwyZpx9UaJXBJlB8czIMx+iVSBsUEM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXEUPeIH; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5f80aa2d4a3so1207228a12.0;
        Thu, 09 May 2024 15:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715292079; x=1715896879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3CeutlPgLy3qquLRxmV7HOgQfxGU3KIQ2sZr9gsx/s=;
        b=iXEUPeIHiPHyp8CyZOSuOSczxtQMXcKnjU3Q83FmT5ziyV1z5paDn5xY0pbbdjd52s
         1of8qgADMfs07I20QjtD2xfMcj20L4KMtLePixbyV2HxmFi3TPBOA63MNYc0mI2aR8z4
         I1xCloQUC50J//aT20dZLkdzW7LKg+gHjhEgquDtGRDrGlKMDXDDf21Se4qtxEaT4v8j
         1SPdKOIIQhDVYZuLyaHkI/W9LdR2eC9Ar/D6bnNlt5+y5ac04MTMcLSDJB+YxVJPueku
         UgxVi1meKR7WFIPLpgLSik4mqFP8x9mK1ipFCaollnz4Igc2U03CBcGYjZ8hf8i4Rmmf
         AOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715292079; x=1715896879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3CeutlPgLy3qquLRxmV7HOgQfxGU3KIQ2sZr9gsx/s=;
        b=YTasHznpZXKI+KX/T5oejK2jc/6hpl7ug/kAzxgmmrmiK6j69HQBjJ5TAon18vmODf
         qdVGeGyqhVxQY8KnnipRfSxSmdsdbUJuwofzbywP7bEsab7GMG/N9VHHCmWG4mmcUOGj
         U9iiVZAA0gsvwC0lSUgKB7wxHFEW6CPHVj0H8lcCbMS2YqM+5pmyXE/Bqp4UMn4rWKYA
         zjMycLueIwVD1MwRNy1t4afaBzgvfo3tnLNEbeg0WgvZwMAhLuwA+RmOrU1FVRViyWHu
         T+X69wT4JaWbmxuc3nIONKO3U0eeQzfZirR8YJuh/45WUjmhYhIe1AUwvFyWIuA0X3Wn
         ISVw==
X-Forwarded-Encrypted: i=1; AJvYcCUnxg4m+OqfDh+UmWSdjzbvHGecgd/5Jov0o7dAB83A4Dl7xlpJeVOO3OOpqKKFGZz6rBsvk+8le1DglS7qimWmiXLjHyuA2X+hZkmO3yUVsHvmrTSfnj8MbSCvkZEys3ky
X-Gm-Message-State: AOJu0Yz1+cwcnitEqli3HJZirtQgTPndqHOoF2ACITqaVn/9cho7JvLU
	e3cpcSMwvFVqiss9JJhPDGHvNgFrUUT7OpnKNR1OgeoLb1I7Du20b8K1/wBHSUZGnmRl0lL2y2A
	m3M5dB60/mTUfMIzdiCLvLKH+vy4=
X-Google-Smtp-Source: AGHT+IGKSu9vVYwrf0fzTBtVLprWq6WXsag4cURO+SJyBpOnCGjO4A6e6lPI9tLqmN8X+tnQ2LrE95mAz28J18rP2h0=
X-Received: by 2002:a17:90a:d345:b0:2b3:c011:d28c with SMTP id
 98e67ed59e1d1-2b6cd1ef673mr683485a91.48.1715292079051; Thu, 09 May 2024
 15:01:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507135514.490467-1-alan.maguire@oracle.com>
 <CAEf4BzbWANm+Bf63hcFAB3Tn51tOeBLhyabV3NNz8tjaMnThjg@mail.gmail.com> <339b9430-145f-402a-a93c-8440797c98a4@oracle.com>
In-Reply-To: <339b9430-145f-402a-a93c-8440797c98a4@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 9 May 2024 15:01:07 -0700
Message-ID: <CAEf4BzY_xwD+7b31VtS4SPh-p+ES4BUDV2um+QGcdD878Onn=Q@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] kbuild,bpf: switch to using --btf_features
 for pahole v1.26 and later
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, andrii@kernel.org, jolsa@kernel.org, 
	acme@redhat.com, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, bpf@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 1:20=E2=80=AFAM Alan Maguire <alan.maguire@oracle.co=
m> wrote:
>
> On 07/05/2024 17:48, Andrii Nakryiko wrote:
> > On Tue, May 7, 2024 at 6:55=E2=80=AFAM Alan Maguire <alan.maguire@oracl=
e.com> wrote:
> >>
> >> The btf_features list can be used for pahole v1.26 and later -
> >> it is useful because if a feature is not yet implemented it will
> >> not exit with a failure message.  This will allow us to add feature
> >> requests to the pahole options without having to check pahole versions
> >> in future; if the version of pahole supports the feature it will be
> >> added.
> >>
> >> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >> Tested-by: Eduard Zingerman <eddyz87@gmail.com>
> >> ---
> >>  scripts/Makefile.btf | 15 +++++++++++++--
> >>  1 file changed, 13 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> >> index 82377e470aed..2d6e5ed9081e 100644
> >> --- a/scripts/Makefile.btf
> >> +++ b/scripts/Makefile.btf
> >> @@ -3,6 +3,8 @@
> >>  pahole-ver :=3D $(CONFIG_PAHOLE_VERSION)
> >>  pahole-flags-y :=3D
> >>
> >> +ifeq ($(call test-le, $(pahole-ver), 125),y)
> >> +
> >>  # pahole 1.18 through 1.21 can't handle zero-sized per-CPU vars
> >>  ifeq ($(call test-le, $(pahole-ver), 121),y)
> >>  pahole-flags-$(call test-ge, $(pahole-ver), 118)       +=3D --skip_en=
coding_btf_vars
> >> @@ -12,8 +14,17 @@ pahole-flags-$(call test-ge, $(pahole-ver), 121)   =
  +=3D --btf_gen_floats
> >>
> >>  pahole-flags-$(call test-ge, $(pahole-ver), 122)       +=3D -j
> >>
> >> -pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)         +=3D --lang_ex=
clude=3Drust
> >> +ifeq ($(pahole-ver), 125)
> >
> > it's a bit of a scope creep, but isn't it strange that we don't have
> > test-eq and have to work-around that with more verbose constructs?
>
> Looking at the history, I _think_ the concern that motivated the numeric
> comparison constructs was the shell process fork required for numeric
> comparisons. In the equality case, ifeq would work for both strings and
> numeric values. Adding a test-eq (in a similar form to test-ge) would
> require a fallback to shell expansion for older Make without intcmp, and
> that would be slower than using ifeq, if less verbose.
>
> > Let's do a good service to the community and add test-eq (and maybe
> > test-ne while at it, don't know, up to Masahiro)?
> >
>
> Sure, I'm happy to do this if kbuild folks agree. I've cc'ed them; I
> neglected to do this in the original patch, apologies about that.
>

Ok, let's see if Masahiro would like this improvement or not. For now
this patch gets us into a nicer place where there are legacy parts and
a better --btf_features setup completely separate, so I applied the
patch as is to bpf-next. If we decide to do test-eq, we can improve
this further separately. Thanks!


> Thanks!
>
> Alan
>
> > Overall the change looks OK to me, so if people are opposed to adding
> > test-eq, I'm fine with it as well:
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
> >> +pahole-flags-y +=3D --skip_encoding_btf_inconsistent_proto --btf_gen_=
optimized
> >> +endif
> >> +
> >> +else
> >>
> >> -pahole-flags-$(call test-ge, $(pahole-ver), 125)       +=3D --skip_en=
coding_btf_inconsistent_proto --btf_gen_optimized
> >> +# Switch to using --btf_features for v1.26 and later.
> >> +pahole-flags-$(call test-ge, $(pahole-ver), 126)  =3D -j --btf_featur=
es=3Dencode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consist=
ent_func
> >> +
> >> +endif
> >> +
> >> +pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)         +=3D --lang_ex=
clude=3Drust
> >>
> >>  export PAHOLE_FLAGS :=3D $(pahole-flags-y)
> >> --
> >> 2.39.3
> >>


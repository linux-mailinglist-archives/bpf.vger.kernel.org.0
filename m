Return-Path: <bpf+bounces-29705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5948C591D
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 17:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BFF31C2191F
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 15:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6BB17EBB4;
	Tue, 14 May 2024 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWwjvqM4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E6F17EBA9;
	Tue, 14 May 2024 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715702034; cv=none; b=uqQwzsu6GaXuBolBudrKLz8LsnZL8aYg3zmemdPTvjlehyDbuCG8DFnUfPDvPq0vTlgQWHYEL2Zu9mOuIgFgTwkDyoLoQRP/7kKQDD9MDpVv118DrmuRDZWTK4rYaLZwQtZZNr9QzDEbk9R8gze+X/ZbivCOXy/P02X7nljVoLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715702034; c=relaxed/simple;
	bh=1sgHrh+VStrgrhME0G31C6ncTvBBpSLc7XxfTlBo5Ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=izNa5gcdmPDzteOMhhdK34KawvGEK5uBesoQV9XypE3Bxu7+1kIoApr0jWF32dTjT4bjTx2NCjc/aNp8OjL+ZDyqmuRO3AE7Li8lTcxQIrwrjT+0SJE8WM2Y81a+qESy4fxPCZoMcgW+5JFgErd0gnYn1llRbqzbB7HpmAbdmDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWwjvqM4; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2b387e2e355so4283305a91.3;
        Tue, 14 May 2024 08:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715702032; x=1716306832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuIOPid9IYL1zuAzTBpIP0ni6HCWjLrfWnLqkz9kwuA=;
        b=bWwjvqM4OOUZ1J8g9J8k47+WBz8VV1kfyR+Bd72AUPLFyX1VF6vwJ4wfCH0kKjolef
         5xgKj+2AnvQGLX1UjkEyxF7CssCGZ7CofYVqlY15+d0FuFPBx5Qa9SvJ2anrB91pV78H
         PPdt77HqgiY9Ss/r2NVU717i/0bZRgKE8gk0jwbe2np/iQ3b2Uuqba61/zD1zYF7bNgB
         nDXVg0UfscsoWaSpVc/QNMIOGKnZMaTBR4q6kSHj8tfZ6ol7/BLVU7AE2mUVDynGr3Pr
         ICSA7YiW3r7p68XagX28ME6hOWVIHL28X9sGD755/oOOnAt2xpj+PNosrz/1sug/mTtm
         QTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715702032; x=1716306832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fuIOPid9IYL1zuAzTBpIP0ni6HCWjLrfWnLqkz9kwuA=;
        b=ZNkDfstmytmqsjs8xvdOnKUA9gKVCykcCw/l55lmFzNQicPvEJSvjc5cGm3ZKPyJzB
         xFLm2C1Fe60XzSMxX/NNv3om6wiTPibwSDs0gVp80o9TMtBOpF6TB6YQA+X2KUpcsRyr
         uLjZR7Wt6r7ga9M3Kflca20MRsR7C7VQ4XOW+EOuvTYlycG0c4v/8S3n/0ruy4TlIRlP
         crkEXIcy/v2oEsgTH59VhuZR+HZfgYDn2ssRhUvkT5aoSXyp8ReXAN6AWhI/CPoliE/T
         cpkqbIbpFrGm17KFjGDfq7HSkCWWdiB0ZXpJFkq0YSayMHzpOxf51CUSIfAPGM0olRJc
         Lt6g==
X-Forwarded-Encrypted: i=1; AJvYcCVtgNSZOukaq+NGjWUWxnPj/zBTrcEueiopItcFjJ6jE2KsE8pPiKBMY8k3ki2Ml196RxtfKB66pffxrSths0MVL6EQEZWVbh1idfLuJ8b9KKHJh/OWFvVI5nHrpbZRr9kJ
X-Gm-Message-State: AOJu0YwxVmBlwDPph7wLxzrWfmL6wQSxdH/gWGDftwo2wr+IzovaDnHf
	qrxWmvBZimx00a5GZkGNIRTE2MonTCaaegy6sXkDdLvTJHsn7CAhaDPd9Q3CkJYkyudyvMvrzNB
	BLExddM0LUdvXIZ9WcxI6lbW0dcyZBQ==
X-Google-Smtp-Source: AGHT+IGmtwkPlOry/FjSGDmVWRzqFYcAjkpcpFmYoWdTxMEOzXpx65C2w8swp+LHsNV3JBuDlsx0xYGedVNFkZ3H0dA=
X-Received: by 2002:a17:90a:51a2:b0:2b4:329e:e373 with SMTP id
 98e67ed59e1d1-2b6cc45030bmr13817250a91.6.1715702031900; Tue, 14 May 2024
 08:53:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507135514.490467-1-alan.maguire@oracle.com>
 <CAEf4BzbWANm+Bf63hcFAB3Tn51tOeBLhyabV3NNz8tjaMnThjg@mail.gmail.com>
 <339b9430-145f-402a-a93c-8440797c98a4@oracle.com> <CAEf4BzY_xwD+7b31VtS4SPh-p+ES4BUDV2um+QGcdD878Onn=Q@mail.gmail.com>
 <CAK7LNATyMpKGK=7SMawHeZFg7MBJa0i5xsvyc+=dOxw9g0RWGA@mail.gmail.com>
 <CAEf4BzZrAf9GberDcC+Q3iR375Y2gzpnvGBvihftmK2WWUS3qA@mail.gmail.com> <CAK7LNAT1Apq4bNRstNgH8nQ4SMdFGqwGnQgWaSiBke0KPUyksQ@mail.gmail.com>
In-Reply-To: <CAK7LNAT1Apq4bNRstNgH8nQ4SMdFGqwGnQgWaSiBke0KPUyksQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 14 May 2024 09:53:39 -0600
Message-ID: <CAEf4BzZrak8+F+b-OXJOppws=88RNi_mpiSP=Z0dD=QJZKPF4A@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] kbuild,bpf: switch to using --btf_features
 for pahole v1.26 and later
To: Masahiro Yamada <masahiroy@kernel.org>, Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com, eddyz87@gmail.com, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, bpf@vger.kernel.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2024 at 3:01=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Sat, May 11, 2024 at 6:45=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, May 9, 2024 at 11:30=E2=80=AFPM Masahiro Yamada <masahiroy@kern=
el.org> wrote:
> > >
> > > On Fri, May 10, 2024 at 7:01=E2=80=AFAM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Thu, May 9, 2024 at 1:20=E2=80=AFAM Alan Maguire <alan.maguire@o=
racle.com> wrote:
> > > > >
> > > > > On 07/05/2024 17:48, Andrii Nakryiko wrote:
> > > > > > On Tue, May 7, 2024 at 6:55=E2=80=AFAM Alan Maguire <alan.magui=
re@oracle.com> wrote:
> > > > > >>
> > > > > >> The btf_features list can be used for pahole v1.26 and later -
> > > > > >> it is useful because if a feature is not yet implemented it wi=
ll
> > > > > >> not exit with a failure message.  This will allow us to add fe=
ature
> > > > > >> requests to the pahole options without having to check pahole =
versions
> > > > > >> in future; if the version of pahole supports the feature it wi=
ll be
> > > > > >> added.
> > > > > >>
> > > > > >> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > > > > >> Tested-by: Eduard Zingerman <eddyz87@gmail.com>
> > > > > >> ---
> > > > > >>  scripts/Makefile.btf | 15 +++++++++++++--
> > > > > >>  1 file changed, 13 insertions(+), 2 deletions(-)
> > > > > >>
> > > > > >> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> > > > > >> index 82377e470aed..2d6e5ed9081e 100644
> > > > > >> --- a/scripts/Makefile.btf
> > > > > >> +++ b/scripts/Makefile.btf
> > > > > >> @@ -3,6 +3,8 @@
> > > > > >>  pahole-ver :=3D $(CONFIG_PAHOLE_VERSION)
> > > > > >>  pahole-flags-y :=3D
> > > > > >>
> > > > > >> +ifeq ($(call test-le, $(pahole-ver), 125),y)
> > > > > >> +
> > > > > >>  # pahole 1.18 through 1.21 can't handle zero-sized per-CPU va=
rs
> > > > > >>  ifeq ($(call test-le, $(pahole-ver), 121),y)
> > > > > >>  pahole-flags-$(call test-ge, $(pahole-ver), 118)       +=3D -=
-skip_encoding_btf_vars
> > > > > >> @@ -12,8 +14,17 @@ pahole-flags-$(call test-ge, $(pahole-ver),=
 121)     +=3D --btf_gen_floats
> > > > > >>
> > > > > >>  pahole-flags-$(call test-ge, $(pahole-ver), 122)       +=3D -=
j
> > > > > >>
> > > > > >> -pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)         +=3D -=
-lang_exclude=3Drust
> > > > > >> +ifeq ($(pahole-ver), 125)
> > > > > >
> > > > > > it's a bit of a scope creep, but isn't it strange that we don't=
 have
> > > > > > test-eq and have to work-around that with more verbose construc=
ts?
> > > > >
> > > > > Looking at the history, I _think_ the concern that motivated the =
numeric
> > > > > comparison constructs was the shell process fork required for num=
eric
> > > > > comparisons. In the equality case, ifeq would work for both strin=
gs and
> > > > > numeric values. Adding a test-eq (in a similar form to test-ge) w=
ould
> > > > > require a fallback to shell expansion for older Make without intc=
mp, and
> > > > > that would be slower than using ifeq, if less verbose.
> > > > >
> > > > > > Let's do a good service to the community and add test-eq (and m=
aybe
> > > > > > test-ne while at it, don't know, up to Masahiro)?
> > > > > >
> > > > >
> > > > > Sure, I'm happy to do this if kbuild folks agree. I've cc'ed them=
; I
> > > > > neglected to do this in the original patch, apologies about that.
> > > > >
> > > >
> > > > Ok, let's see if Masahiro would like this improvement or not. For n=
ow
> > > > this patch gets us into a nicer place where there are legacy parts =
and
> > > > a better --btf_features setup completely separate, so I applied the
> > > > patch as is to bpf-next. If we decide to do test-eq, we can improve
> > > > this further separately. Thanks!
> > >
> > >
> > > That is a noise change.
> > > You did not need to modify the line in the first place.
> > >
> >
> > Not sure which specific line you are referring to. But the idea here
> > is that starting from pahole 1.26 we want to stop to set those
> > "legacy" arguments (like --skip_encoding_btf_vars, --btf_gen_floats)
> > and *only* use more usable and forward-compatible --btf_features.
> >
> > >
> > > The previous
> > >
> > >   pahole-flags-$(call test-ge, $(pahole-ver), 125)
> > >
> > > works as-is.
>
>
> You did not not need to change
>
>   pahole-flags-$(call test-ge, $(pahole-ver), 125) +=3D ...
>
>
> to
>
>
>   ifeq ($(pahole-ver), 125)
>   pahole-flags-y +=3D ...
>   endif
>
>
>
> Please note it exists in
>
>   ifeq ($(call test-le, $(pahole-ver), 125),y)
>      ...
>   else
>
>
>
>
>
> if (pahole_ver <=3D 125) {
>       do_something();
>       if (pahole_ver >=3D 125)
>              do_other();
> }
>
>
>   and
>
>
> if (pahole_ver <=3D 125) {
>       do_something();
>       if (pahole_ver =3D=3D 125)
>             do_other();
> }
>
>
> are equivalent, don't they?
>
>
>
> The former is more intuitive because pahole 1.25+ supports
> --skip_encoding_btf_inconsistent_proto --btf_gen_optimized

The point here is to not specify these "legacy" arguments starting
from pahole v1.26, and the patch makes it more obvious, IMO.

But I don't mind adding (test-ge,125) check back, Alan, please send a
follow up patch.

>
>
>
> I attached a simpler and more correct patch.

It's not more correct, because this patch didn't break anything. It's
just as correct.

>
>
>
>
>
>
>
>
>
>
> --
> Best Regards
> Masahiro Yamada


Return-Path: <bpf+bounces-29434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B268A8C1E1F
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 08:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3AF91C21422
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 06:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F845E099;
	Fri, 10 May 2024 06:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiwTMUd7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7F61F171;
	Fri, 10 May 2024 06:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715322632; cv=none; b=jfQwq/SW/VuO3EoIFk0uLIOSHvpQ3DfzWau6CfT88ZmBalgoKvFI+KAwyFI1E58pO4WzRvubPy3X1Xum13ieZOmmz5rZ0VeeVXdwrdg4qoI49n8CrE2ROUAigip2TOG9pSBdAOXcZAW+76DgyCb/ScrwX7sQeLBGS9CvoQQ1O+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715322632; c=relaxed/simple;
	bh=OPJHkBDfeGghyPDQDmdYUX1NMHXumeAbhGmbN+1eiIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGDxgJp5Hwim1B3S6QXw8vUYzbcXfEinWWJ3V+7ftu1pSoV4jmvI1rXktOgQTCalaxpLtNy0z5yIn5Mc3MN74+NjbNLYTGaUgd1WjrZGVIDOHuvdtmeecZQl1/UAcQrmHrgSkVEtuOG3JbCx57uEfSERahbfvOTSlJvgGX2kFbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiwTMUd7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0B8C32786;
	Fri, 10 May 2024 06:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715322631;
	bh=OPJHkBDfeGghyPDQDmdYUX1NMHXumeAbhGmbN+1eiIA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CiwTMUd7d7A39Lpg3MUhYu2pRDkwC8tp5+Idm7gnNmN2odbyxP4/KADwR1224XRlZ
	 kFWItsShrkdttjL30UWhVvMXivse5tdyV5daQk7yLIsd5FvfXWBoZbRZDUGqPxeFHG
	 1sYf9mjwpBGFGQw05WJQNvJ5NMvhPnsbnXoKZjFX7Beb9I1ZEr9uCpQqI7vmRRg/Kq
	 LVmF25eBMO86KFG1w5zZ24wxaNzuPGOjNAAAtPi5j8uw8ymh7JwFMK4ZD2SlQPUXT5
	 SZJSAdCxBL62N7Fm4uueDFX42e7DXe2fG9mo9ur5yvyNKFpXvrsz7WpKYHDMRL5aUM
	 GU2Hrfu9N+RDw==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51f1b378ca5so2906548e87.1;
        Thu, 09 May 2024 23:30:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWd5GdJBxlad9ro73Ox9flIxHHJxPZg2GSRN4UzRKbxJQkBI7rhzs/AutoSDmGI+PlApWDdzQdKkKoge9/W/BtaYApa/dT4IJdrezXZI8Lq7IqkYzO1pUauQvjiDow9iCOt
X-Gm-Message-State: AOJu0YznCyPh/5a6otiM63hAd75M7lmqXqmLsklbvLXIOAfmZ+k+4VLk
	tm9W+iDeDtiGTdAGbIfGH7J80R4W1cPzEGC8X0tqTlpGGzIL/n72br+kQ+qDA8wFdCZmzR4lgwP
	o8y/MCgN/11PXMcn/MDaGruhAEmk=
X-Google-Smtp-Source: AGHT+IGnINIHV3z9/8S7hVcZBgrRa098I0bNkR2Ea0ZXUnD0MjTQ+ownzg82NBaWbEzBrKxmY0LeccGh/M8dYHbg1+s=
X-Received: by 2002:a05:6512:ba2:b0:518:e7ed:3c7c with SMTP id
 2adb3069b0e04-5220fc7c570mr1650903e87.14.1715322629773; Thu, 09 May 2024
 23:30:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507135514.490467-1-alan.maguire@oracle.com>
 <CAEf4BzbWANm+Bf63hcFAB3Tn51tOeBLhyabV3NNz8tjaMnThjg@mail.gmail.com>
 <339b9430-145f-402a-a93c-8440797c98a4@oracle.com> <CAEf4BzY_xwD+7b31VtS4SPh-p+ES4BUDV2um+QGcdD878Onn=Q@mail.gmail.com>
In-Reply-To: <CAEf4BzY_xwD+7b31VtS4SPh-p+ES4BUDV2um+QGcdD878Onn=Q@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 10 May 2024 15:29:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNATyMpKGK=7SMawHeZFg7MBJa0i5xsvyc+=dOxw9g0RWGA@mail.gmail.com>
Message-ID: <CAK7LNATyMpKGK=7SMawHeZFg7MBJa0i5xsvyc+=dOxw9g0RWGA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] kbuild,bpf: switch to using --btf_features
 for pahole v1.26 and later
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, jolsa@kernel.org, 
	acme@redhat.com, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, bpf@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 7:01=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, May 9, 2024 at 1:20=E2=80=AFAM Alan Maguire <alan.maguire@oracle.=
com> wrote:
> >
> > On 07/05/2024 17:48, Andrii Nakryiko wrote:
> > > On Tue, May 7, 2024 at 6:55=E2=80=AFAM Alan Maguire <alan.maguire@ora=
cle.com> wrote:
> > >>
> > >> The btf_features list can be used for pahole v1.26 and later -
> > >> it is useful because if a feature is not yet implemented it will
> > >> not exit with a failure message.  This will allow us to add feature
> > >> requests to the pahole options without having to check pahole versio=
ns
> > >> in future; if the version of pahole supports the feature it will be
> > >> added.
> > >>
> > >> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > >> Tested-by: Eduard Zingerman <eddyz87@gmail.com>
> > >> ---
> > >>  scripts/Makefile.btf | 15 +++++++++++++--
> > >>  1 file changed, 13 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> > >> index 82377e470aed..2d6e5ed9081e 100644
> > >> --- a/scripts/Makefile.btf
> > >> +++ b/scripts/Makefile.btf
> > >> @@ -3,6 +3,8 @@
> > >>  pahole-ver :=3D $(CONFIG_PAHOLE_VERSION)
> > >>  pahole-flags-y :=3D
> > >>
> > >> +ifeq ($(call test-le, $(pahole-ver), 125),y)
> > >> +
> > >>  # pahole 1.18 through 1.21 can't handle zero-sized per-CPU vars
> > >>  ifeq ($(call test-le, $(pahole-ver), 121),y)
> > >>  pahole-flags-$(call test-ge, $(pahole-ver), 118)       +=3D --skip_=
encoding_btf_vars
> > >> @@ -12,8 +14,17 @@ pahole-flags-$(call test-ge, $(pahole-ver), 121) =
    +=3D --btf_gen_floats
> > >>
> > >>  pahole-flags-$(call test-ge, $(pahole-ver), 122)       +=3D -j
> > >>
> > >> -pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)         +=3D --lang_=
exclude=3Drust
> > >> +ifeq ($(pahole-ver), 125)
> > >
> > > it's a bit of a scope creep, but isn't it strange that we don't have
> > > test-eq and have to work-around that with more verbose constructs?
> >
> > Looking at the history, I _think_ the concern that motivated the numeri=
c
> > comparison constructs was the shell process fork required for numeric
> > comparisons. In the equality case, ifeq would work for both strings and
> > numeric values. Adding a test-eq (in a similar form to test-ge) would
> > require a fallback to shell expansion for older Make without intcmp, an=
d
> > that would be slower than using ifeq, if less verbose.
> >
> > > Let's do a good service to the community and add test-eq (and maybe
> > > test-ne while at it, don't know, up to Masahiro)?
> > >
> >
> > Sure, I'm happy to do this if kbuild folks agree. I've cc'ed them; I
> > neglected to do this in the original patch, apologies about that.
> >
>
> Ok, let's see if Masahiro would like this improvement or not. For now
> this patch gets us into a nicer place where there are legacy parts and
> a better --btf_features setup completely separate, so I applied the
> patch as is to bpf-next. If we decide to do test-eq, we can improve
> this further separately. Thanks!


That is a noise change.
You did not need to modify the line in the first place.


The previous

  pahole-flags-$(call test-ge, $(pahole-ver), 125)

works as-is.




--
Best Regards
Masahiro Yamada


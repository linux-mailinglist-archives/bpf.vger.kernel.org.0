Return-Path: <bpf+bounces-29591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C99618C304A
	for <lists+bpf@lfdr.de>; Sat, 11 May 2024 11:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ECCA1F2174A
	for <lists+bpf@lfdr.de>; Sat, 11 May 2024 09:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92F45337E;
	Sat, 11 May 2024 09:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4cDyO+N"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F491078B;
	Sat, 11 May 2024 09:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715418100; cv=none; b=Vmaxjd369Rm3X8+PSMMBmkoZpLwdli4A2Pew0SZkXFKxun4e2hXCDz+pRKL+H2iNmAA2LkifRPTisCnvtyE+KMPhZUUTnOGtwBqMIb2Tp4zpZak3f213mV6RbsimEWyZCkXm4PZLbVQAKuIPaAURQHL8QRpgyy0yetHcLz+ePnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715418100; c=relaxed/simple;
	bh=UXfj5lFcvJ4W1teWY9I0W87pbbpt/JTExtI+/GJsPy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJB63qj0lYrteFxJzFUTpoW+EED0ROqbZ2BN9L2CZbLeGIk4NQY3uuLu8EjUviGSLHcCzxh9Vhp8FoIwoLLiiW0SbS1KqseHoUdRdf/kr2dPGp0xciaCYQMXl6N+2RJGpilH8LU7hM7tH3we/AEfcFKIwSUHcR+cKQbylcBlmFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4cDyO+N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6615C2BD10;
	Sat, 11 May 2024 09:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715418099;
	bh=UXfj5lFcvJ4W1teWY9I0W87pbbpt/JTExtI+/GJsPy4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=G4cDyO+N42i3dEA3sre9JyrEora13i4wueQ99kwmrT2AKuByNqk5voHnb0VKFty1J
	 hZOIUmuaLzd3GoQs+TMRAw121ly1dt4PFD2Mr3N3Z9u7lGexbV0fi7kACEAksuYCgR
	 nguw5Ap13kr6iwMCkORv+2FniLZQiOb3DnhI41iZmrmPLJYOt+qZ0UVllMnP2po5Gn
	 u7WR6PuERoViL/exzqDpD6ysUM03DpMfZ1+sjvOsxlc4Cn6kYAU/Bbp4R3yUepGln9
	 h0qbDrt3N7vXDhmGixCDoKSt5HKqP3RDAPjgZAtsPB2Jac69nYy41P81eXueAjkbK+
	 QR6yDblnk/Cwg==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51f2ebbd8a7so2948827e87.2;
        Sat, 11 May 2024 02:01:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7vjzW+IVUgYd2ss/Wul654iunRYI4kikkj3/ScV6s81BqHyGtnpd6yll/nLAoYRlXoGgFPTrKUvw1BrOiGQXtgDm/cDnWoXwUzl4RaUHGpm19CGtpy0ViUSXkk4L+k84A
X-Gm-Message-State: AOJu0YzYLetqkKFBfuny9AD93U+CScsuIiI5sQIKpwcfON2Th7gNtiMK
	ykDc/kbyYxIaHWg8g0IyT3Bg0I+hi41QCyi7GkMtfEuMYLBcbBTKHLH9Ir3vpuHW5yCQWeZSfNz
	uza6qeWyFr/NqR0aNevwkUK4+g2o=
X-Google-Smtp-Source: AGHT+IGZJfVpFi6NAef61Rd+Fr/mUbDOFXxxXeYKElRz+ia3OM48iIgg5Tm0UeLBgvI0uexiXH4NV7pmpcidTQMZqF4=
X-Received: by 2002:a19:8c1a:0:b0:51a:f3b9:f774 with SMTP id
 2adb3069b0e04-5220fb74698mr3044191e87.21.1715418098557; Sat, 11 May 2024
 02:01:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507135514.490467-1-alan.maguire@oracle.com>
 <CAEf4BzbWANm+Bf63hcFAB3Tn51tOeBLhyabV3NNz8tjaMnThjg@mail.gmail.com>
 <339b9430-145f-402a-a93c-8440797c98a4@oracle.com> <CAEf4BzY_xwD+7b31VtS4SPh-p+ES4BUDV2um+QGcdD878Onn=Q@mail.gmail.com>
 <CAK7LNATyMpKGK=7SMawHeZFg7MBJa0i5xsvyc+=dOxw9g0RWGA@mail.gmail.com> <CAEf4BzZrAf9GberDcC+Q3iR375Y2gzpnvGBvihftmK2WWUS3qA@mail.gmail.com>
In-Reply-To: <CAEf4BzZrAf9GberDcC+Q3iR375Y2gzpnvGBvihftmK2WWUS3qA@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 11 May 2024 18:01:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT1Apq4bNRstNgH8nQ4SMdFGqwGnQgWaSiBke0KPUyksQ@mail.gmail.com>
Message-ID: <CAK7LNAT1Apq4bNRstNgH8nQ4SMdFGqwGnQgWaSiBke0KPUyksQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] kbuild,bpf: switch to using --btf_features
 for pahole v1.26 and later
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, jolsa@kernel.org, 
	acme@redhat.com, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, bpf@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000680ea5061829e69c"

--000000000000680ea5061829e69c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2024 at 6:45=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, May 9, 2024 at 11:30=E2=80=AFPM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > On Fri, May 10, 2024 at 7:01=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Thu, May 9, 2024 at 1:20=E2=80=AFAM Alan Maguire <alan.maguire@ora=
cle.com> wrote:
> > > >
> > > > On 07/05/2024 17:48, Andrii Nakryiko wrote:
> > > > > On Tue, May 7, 2024 at 6:55=E2=80=AFAM Alan Maguire <alan.maguire=
@oracle.com> wrote:
> > > > >>
> > > > >> The btf_features list can be used for pahole v1.26 and later -
> > > > >> it is useful because if a feature is not yet implemented it will
> > > > >> not exit with a failure message.  This will allow us to add feat=
ure
> > > > >> requests to the pahole options without having to check pahole ve=
rsions
> > > > >> in future; if the version of pahole supports the feature it will=
 be
> > > > >> added.
> > > > >>
> > > > >> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > > > >> Tested-by: Eduard Zingerman <eddyz87@gmail.com>
> > > > >> ---
> > > > >>  scripts/Makefile.btf | 15 +++++++++++++--
> > > > >>  1 file changed, 13 insertions(+), 2 deletions(-)
> > > > >>
> > > > >> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> > > > >> index 82377e470aed..2d6e5ed9081e 100644
> > > > >> --- a/scripts/Makefile.btf
> > > > >> +++ b/scripts/Makefile.btf
> > > > >> @@ -3,6 +3,8 @@
> > > > >>  pahole-ver :=3D $(CONFIG_PAHOLE_VERSION)
> > > > >>  pahole-flags-y :=3D
> > > > >>
> > > > >> +ifeq ($(call test-le, $(pahole-ver), 125),y)
> > > > >> +
> > > > >>  # pahole 1.18 through 1.21 can't handle zero-sized per-CPU vars
> > > > >>  ifeq ($(call test-le, $(pahole-ver), 121),y)
> > > > >>  pahole-flags-$(call test-ge, $(pahole-ver), 118)       +=3D --s=
kip_encoding_btf_vars
> > > > >> @@ -12,8 +14,17 @@ pahole-flags-$(call test-ge, $(pahole-ver), 1=
21)     +=3D --btf_gen_floats
> > > > >>
> > > > >>  pahole-flags-$(call test-ge, $(pahole-ver), 122)       +=3D -j
> > > > >>
> > > > >> -pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)         +=3D --l=
ang_exclude=3Drust
> > > > >> +ifeq ($(pahole-ver), 125)
> > > > >
> > > > > it's a bit of a scope creep, but isn't it strange that we don't h=
ave
> > > > > test-eq and have to work-around that with more verbose constructs=
?
> > > >
> > > > Looking at the history, I _think_ the concern that motivated the nu=
meric
> > > > comparison constructs was the shell process fork required for numer=
ic
> > > > comparisons. In the equality case, ifeq would work for both strings=
 and
> > > > numeric values. Adding a test-eq (in a similar form to test-ge) wou=
ld
> > > > require a fallback to shell expansion for older Make without intcmp=
, and
> > > > that would be slower than using ifeq, if less verbose.
> > > >
> > > > > Let's do a good service to the community and add test-eq (and may=
be
> > > > > test-ne while at it, don't know, up to Masahiro)?
> > > > >
> > > >
> > > > Sure, I'm happy to do this if kbuild folks agree. I've cc'ed them; =
I
> > > > neglected to do this in the original patch, apologies about that.
> > > >
> > >
> > > Ok, let's see if Masahiro would like this improvement or not. For now
> > > this patch gets us into a nicer place where there are legacy parts an=
d
> > > a better --btf_features setup completely separate, so I applied the
> > > patch as is to bpf-next. If we decide to do test-eq, we can improve
> > > this further separately. Thanks!
> >
> >
> > That is a noise change.
> > You did not need to modify the line in the first place.
> >
>
> Not sure which specific line you are referring to. But the idea here
> is that starting from pahole 1.26 we want to stop to set those
> "legacy" arguments (like --skip_encoding_btf_vars, --btf_gen_floats)
> and *only* use more usable and forward-compatible --btf_features.
>
> >
> > The previous
> >
> >   pahole-flags-$(call test-ge, $(pahole-ver), 125)
> >
> > works as-is.


You did not not need to change

  pahole-flags-$(call test-ge, $(pahole-ver), 125) +=3D ...


to


  ifeq ($(pahole-ver), 125)
  pahole-flags-y +=3D ...
  endif



Please note it exists in

  ifeq ($(call test-le, $(pahole-ver), 125),y)
     ...
  else





if (pahole_ver <=3D 125) {
      do_something();
      if (pahole_ver >=3D 125)
             do_other();
}


  and


if (pahole_ver <=3D 125) {
      do_something();
      if (pahole_ver =3D=3D 125)
            do_other();
}


are equivalent, don't they?



The former is more intuitive because pahole 1.25+ supports
--skip_encoding_btf_inconsistent_proto --btf_gen_optimized



I attached a simpler and more correct patch.










--=20
Best Regards
Masahiro Yamada

--000000000000680ea5061829e69c
Content-Type: text/x-patch; charset="US-ASCII"; name="diff.patch"
Content-Disposition: attachment; filename="diff.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lw1vf08t0>
X-Attachment-Id: f_lw1vf08t0

ZGlmZiAtLWdpdCBhL3NjcmlwdHMvTWFrZWZpbGUuYnRmIGIvc2NyaXB0cy9NYWtlZmlsZS5idGYK
aW5kZXggODIzNzdlNDcwYWVkLi5iY2E4YThmMjZlYTQgMTAwNjQ0Ci0tLSBhL3NjcmlwdHMvTWFr
ZWZpbGUuYnRmCisrKyBiL3NjcmlwdHMvTWFrZWZpbGUuYnRmCkBAIC0zLDYgKzMsOCBAQAogcGFo
b2xlLXZlciA6PSAkKENPTkZJR19QQUhPTEVfVkVSU0lPTikKIHBhaG9sZS1mbGFncy15IDo9CiAK
K2lmZXEgKCQoY2FsbCB0ZXN0LWxlLCAkKHBhaG9sZS12ZXIpLCAxMjUpLHkpCisKICMgcGFob2xl
IDEuMTggdGhyb3VnaCAxLjIxIGNhbid0IGhhbmRsZSB6ZXJvLXNpemVkIHBlci1DUFUgdmFycwog
aWZlcSAoJChjYWxsIHRlc3QtbGUsICQocGFob2xlLXZlciksIDEyMSkseSkKIHBhaG9sZS1mbGFn
cy0kKGNhbGwgdGVzdC1nZSwgJChwYWhvbGUtdmVyKSwgMTE4KQkrPSAtLXNraXBfZW5jb2Rpbmdf
YnRmX3ZhcnMKQEAgLTEyLDggKzE0LDE1IEBAIHBhaG9sZS1mbGFncy0kKGNhbGwgdGVzdC1nZSwg
JChwYWhvbGUtdmVyKSwgMTIxKQkrPSAtLWJ0Zl9nZW5fZmxvYXRzCiAKIHBhaG9sZS1mbGFncy0k
KGNhbGwgdGVzdC1nZSwgJChwYWhvbGUtdmVyKSwgMTIyKQkrPSAtagogCi1wYWhvbGUtZmxhZ3Mt
JChDT05GSUdfUEFIT0xFX0hBU19MQU5HX0VYQ0xVREUpCQkrPSAtLWxhbmdfZXhjbHVkZT1ydXN0
Ci0KIHBhaG9sZS1mbGFncy0kKGNhbGwgdGVzdC1nZSwgJChwYWhvbGUtdmVyKSwgMTI1KQkrPSAt
LXNraXBfZW5jb2RpbmdfYnRmX2luY29uc2lzdGVudF9wcm90byAtLWJ0Zl9nZW5fb3B0aW1pemVk
CiAKK2Vsc2UKKworIyBTd2l0Y2ggdG8gdXNpbmcgLS1idGZfZmVhdHVyZXMgZm9yIHYxLjI2IGFu
ZCBsYXRlci4KK3BhaG9sZS1mbGFncy0kKGNhbGwgdGVzdC1nZSwgJChwYWhvbGUtdmVyKSwgMTI2
KSAgPSAtaiAtLWJ0Zl9mZWF0dXJlcz1lbmNvZGVfZm9yY2UsdmFyLGZsb2F0LGVudW02NCxkZWNs
X3RhZyx0eXBlX3RhZyxvcHRpbWl6ZWRfZnVuYyxjb25zaXN0ZW50X2Z1bmMKKworZW5kaWYKKwor
cGFob2xlLWZsYWdzLSQoQ09ORklHX1BBSE9MRV9IQVNfTEFOR19FWENMVURFKQkJKz0gLS1sYW5n
X2V4Y2x1ZGU9cnVzdAorCiBleHBvcnQgUEFIT0xFX0ZMQUdTIDo9ICQocGFob2xlLWZsYWdzLXkp
Cg==
--000000000000680ea5061829e69c--


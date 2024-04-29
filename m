Return-Path: <bpf+bounces-28123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1161C8B5F55
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 18:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ABC4B2488F
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 16:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5DE86136;
	Mon, 29 Apr 2024 16:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lddsnsx4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D225839FD;
	Mon, 29 Apr 2024 16:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714409177; cv=none; b=ApxV2rWlVTdRKenZQLCmCRmurE4EpPHYLpMcCiSN34nbqsiuuBkr19Bu3uLnUsEGjq/DCjMLRBOVUt3Hb8mOW6WOzVU4GkR31bbgy3ATXHwDqgUG0f5819ALmNpUmcMyUN77zSF3La66q6Zv1ZDgd2L+tQA8uQXuwKZ8Y5mISyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714409177; c=relaxed/simple;
	bh=kJl1Pvf+QmsGXRQsPFm/qZRAd1kGgTvi2ktcaHWotR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z3j44QP6KyYE8CVwXJdVnKLjD0zKPXWfDNb5Wd4OKeKkjh/ZLQCDOM60K2WhjEFYi81fkZ5mnXaqnWu4jyZl08LZBBoL5fqrKViSJJGKtySAS+gjLUPm7CYBgTOhwWsyTgz96Y2YsNNFscd6eVBjzB1YoBWPogVjwVCrJFxkvYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lddsnsx4; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5e8470c1cb7so3190351a12.2;
        Mon, 29 Apr 2024 09:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714409175; x=1715013975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U80iD/8RiPpwGxO+V9WytMLR2ZFEkdHXCUuK39Xo+ek=;
        b=Lddsnsx4U9ohZjNogCh/D2rsyVc7+lL6meln6Vd/zbqQmDLQFV3WtG05YWTNWrJhO2
         PJnuoRmiT3CGthmHnXNRjOeJrBxMEgAzDC4S2jtdQArzQEnfl3gqKzCSj9+ozgkQTboB
         vpP3ljRAwx+D6gxZKHRajRhzrZQRKLthudNlWly083LeJEh0v4lLNmT5scgW34hx7vPs
         LFrEvExrqBRMuMNkHoQgtc3rCBYebISi4k6TH7LhNAyNs0C7X7qbmTczjRia40ayIbyT
         Vwvv2SNdeBFsw3mdZCyBTkr9sWkjsfAAh6TdEznKgo7TBHIZRulPo5XMzmwHYD5r0BrQ
         8fSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714409175; x=1715013975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U80iD/8RiPpwGxO+V9WytMLR2ZFEkdHXCUuK39Xo+ek=;
        b=h6gv/HtYuLZBoyAQ75ieG3evODafw91ExZYeOJ+04xi53G/+0gwrVUqOaqeYc3e2ib
         Sr8d1EcKqxUPxKOD1I3jn0da3+Ag0bBSgLbTcJdenDGuRWcp80IBbHO7AuQrG4vCBfKf
         t4HYr8nkND1qR9js2rI5OGP7XrNHfR7nTOE6jZYOBTU/lVZ+Q4RfSlTTwNnTm7+lZssq
         PK6gkxgG7x6bNcEF+tyJVDmSabEJlaaiK8LxgP/jCZTLj4zniUovbro0N0Rxx66HSwyT
         xlc65JTwqUACqsVafPaXTKHZo2LwHlBWd8iZvev0vIpp6d/+GstUTU+0xEgyuAyDnFlh
         P1Yw==
X-Forwarded-Encrypted: i=1; AJvYcCXdv2IfaB3xj/3x1x65A0Eb6kvIF3PHObGX74F/SJTCJrajJKKcOl3IrYvafLQSwF1FvqKk1YpjTcqdlaovnkPvm43/yRO//wUSFYAgX5nhsNL7WrBf1a2yERPt9g==
X-Gm-Message-State: AOJu0Yzg40ayajD4J4rA35cZWFDef4iOKqK9jQqrXt88Q4JEh+tF0Kzj
	AaeHNUWlX8tPoAhkVzLmhIEPI+CnHA41zV4gcrKcr2y+OX45sLJvbKygiE03bUEHe/xLVJSmOlG
	FFqXhyst2/5odlVB/8PUp9gokISU=
X-Google-Smtp-Source: AGHT+IFNZO7Q+MdhTCB1a2y7mXmghJBWFR1TC8XTJCVVLTFi+M0Smd0LV+32Y3/e/zimcG9/Zdp8VekjmX4SKlXw2z0=
X-Received: by 2002:a17:90a:4a90:b0:2ae:7f27:82cd with SMTP id
 f16-20020a17090a4a9000b002ae7f2782cdmr6428137pjh.7.1714409173155; Mon, 29 Apr
 2024 09:46:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419205747.1102933-1-acme@kernel.org> <20240419205747.1102933-3-acme@kernel.org>
 <CAEf4Bzb0pyc_0AuP3O6wekpR3YcfEkk5bPGOOmS6_yJ3G5bKwQ@mail.gmail.com>
 <ZiwS0_O_CTesvjLC@x1> <d9e3a7ab-9799-42b0-9c6f-1809a0527867@oracle.com>
In-Reply-To: <d9e3a7ab-9799-42b0-9c6f-1809a0527867@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 29 Apr 2024 09:46:01 -0700
Message-ID: <CAEf4Bzb4Yw7GyyhdMu7fbPQSHE5PumRWB4nRaoi=BYax57hSTg@mail.gmail.com>
Subject: Re: [PATCH 2/2] pahole: Allow asking for extra features using the '+'
 prefix in --btf_features
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, dwarves@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, 
	Clark Williams <williams@redhat.com>, Kate Carcia <kcarcia@redhat.com>, bpf@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Daniel Xu <dxu@dxuuu.xyz>, Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 4:16=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 26/04/2024 21:47, Arnaldo Carvalho de Melo wrote:
> > On Fri, Apr 26, 2024 at 01:26:40PM -0700, Andrii Nakryiko wrote:
> >> On Fri, Apr 19, 2024 at 1:58=E2=80=AFPM Arnaldo Carvalho de Melo
> >> <acme@kernel.org> wrote:
> >>>
> >>> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> >>>
> >>> Instead of the somewhat confusing:
> >>>
> >>>   --btf_features=3Dall,reproducible_build
> >>>
> >>> That means "'all' the standard BTF features plus the 'reproducible_bu=
ild'
> >>> extra BTF feature", use + directly, making it more compact:
> >>>
> >>>   --btf_features=3D+reproducible_build
> >>>
> >>
> >> for older paholes that don't yet know about + syntax, but support
> >> --btf_features, will this effectively disable all features or how will
> >> it work?
> >>
> >> I'm thinking from the perspective of using +reproducible_build
> >> unconditionally in kernel's build scripts, will it regress something
> >> for current pahole versions?
> >
> > Well, I think it will end up being discarded just like "all" or
> > "default", no? I.e. those were keywords not grokked by older pahole
> > versions, so ignored as we're not using --btf_features_strict, right?
> >
> > Alan?
> >
>
> Yep, it would just be ignored, so wouldn't have the desired behaviour
> of enabling defaults + reproducible build option.
>
> > But then we're not yet using --btf_features in scripts/Makefile.btf,
> > right?
> >
> > But as Daniel pointed out and Alan (I think) agreed, for things like
> > scripts we probably end up using the most verbose thing as:
> >
> >       --btf_features=3Ddefault,reproducible_build
> >
> > to mean a set (the default set of BTF options) + an optional/extra
> > feature (reproducibe_build), that for people not used to the + syntax
> > may be more descriptive (I really think that both are confusing for
> > beginners knowing nothing about BTF and its evolution, etc).
> >
> > Alan, also we released 1.26 with "all" meaning what we now call
> > "default", so we need to keep both meaning the same thing, right?
> >
>
> I might be missing something here, but I think we should always call out
> explicitly the set of features we want in the kernel Makefile.btf
> (something like [1]). The reason for this is that the concept of what is
> "default" may evolve over time; for example it's going to include
> Daniel's kfunc definitions for soon. That's a good thing, but it could
> conceivably cause problems down the line. Consider a newer pahole - with
> a newer set of defaults - running on an older kernel. In that case, we
> could end up encoding BTF features we don't want.  By contrast, if we
> always call out the full set of BTF features we want via
> --btf_features=3Dfeature1,feature2 etc we'll always get the expected set.
> Plus for folks consulting the code, it's much clearer which BTF features
> are in use when they look at the Makefiles for a particular kernel.
> So my sense of the value of "default" is as a shortcut for testing the
> latest and greatest set of BTF feature encoding, but not for use in the
> kernel tree Makefiles. Thanks!

Yep, I agree, the whole point was to not regress older kernel builds
with newer pahole, so we need to explicitly list used features.

>
> Alan
>
> [1]
> https://lore.kernel.org/bpf/20240424154806.3417662-7-alan.maguire@oracle.=
com/
>
> > - Arnaldo
> >
> >>> In the future we may want the '-' counterpart as a way to _remove_ so=
me
> >>> of the standard set of BTF features.
> >>>
> >>> Cc: Alan Maguire <alan.maguire@oracle.com>
> >>> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> >>> Cc: Daniel Xu <dxu@dxuuu.xyz>
> >>> Cc: Eduard Zingerman <eddyz87@gmail.com>
> >>> Cc: Jiri Olsa <jolsa@kernel.org>
> >>> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >>> ---
> >>>  man-pages/pahole.1          | 6 ++++++
> >>>  pahole.c                    | 6 ++++++
> >>>  tests/reproducible_build.sh | 2 +-
> >>>  3 files changed, 13 insertions(+), 1 deletion(-)
> >>>
> >>
> >> [...]


Return-Path: <bpf+bounces-64426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE299B12833
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 02:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF0771C23676
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 00:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF3713790B;
	Sat, 26 Jul 2025 00:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EvfJPXFb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF812B9BA
	for <bpf@vger.kernel.org>; Sat, 26 Jul 2025 00:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753490533; cv=none; b=k56B9cc0UspprQoWr2QAbf5ursZb9FUGYVhx3SN9/o4GHjfh9g9+5PjJSwEFXAztJVIhdzBLT503ieYeoa2GcJiR1oKjwzZXHWy4vyiOK7QxywHwemxjvjLcRwKzXgaV23yFOZIDygucH0pbOTkdfChKyFcT4fDEEquLjECVl4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753490533; c=relaxed/simple;
	bh=i2KMGB5jXlYrZOEVyEEtlYkBMWkUvJBvYvMLMWjqryY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MVcDYr9P4zcjpl+MoPYsBBOwqi7I3lRqso1r+V9FCYsOPhGHnHPoIuMYpncmBmwAukuIxKo5Vzt2AXY19A1VJDz8siVmaR8v8DmvVHasOSEz4CSi/B2TdIXoBai/2TSTSQg8PoXWJg07jpmAsy58yR9oI1SxerkvicQvIb4y0BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EvfJPXFb; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-87f36c458afso1587945241.1
        for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 17:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753490531; x=1754095331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2KMGB5jXlYrZOEVyEEtlYkBMWkUvJBvYvMLMWjqryY=;
        b=EvfJPXFb+WTFp+kudxv6YHLf0TPkAJgThkffhKdWGbmjz30u3nn9Zduz8zDqdlAlOM
         j84jklBeCiSyQDNfKpHoY5KNobAq6ly+8cqJzhXgfvrDLMLhOd5Q5uKfRcYjfGDNgRZz
         ogAL316jEF7qhlCIN0GxRdmjwnvYEup+IgHiRL5ctFSsMTZL6akOHKtSdMMO4JJiCdIV
         TvRPGEx/yWQS5hFrEuaWpx/B5s5KwO9XHoz3ODbAkAPDR5f8SRt3NE8Jincs43nR3SAU
         WYSMBjATDMryH65U06Fb6gbmMPWUSEXJolRVXv+99OhwGwr47TCESyJEYVYy555ouxuH
         U7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753490531; x=1754095331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2KMGB5jXlYrZOEVyEEtlYkBMWkUvJBvYvMLMWjqryY=;
        b=H6RviLDhXODDy5HCgxSvYO8Tg7pqlPvurjAjxJTVmedoKsbgzPpabIU6CWgcmN0Kha
         wCrgV911yyoXg+kUPAMxwf++VQqpAsAbaC0ELWsy7Xp+EzcjauS+f2p4wRSKtgKF0bPb
         CzVV5udaAIIYZHmnsW5liSiYmph2M/Ovzy8JUiL/lyOSyp4h5UPFCpitJXxu/pb1gJEL
         qOd8IedPNZ3A53l9jGaTkXRvvQ3a+sUdW7O4dK1cvX+XgU9nVTyKgtAHRqhLzp2k1Ih1
         ZVWJM1OWOgNesqYB/J2/rk4cDd9dzWSt5PSkxbdkVnCpNJ6JxX5+LvzOX+Nl2vVwZac9
         Wa9A==
X-Forwarded-Encrypted: i=1; AJvYcCUNcmiU04BpSUEFe7woE3I5uHyp8YiEhhO3xdqZE+SN4GmO1P+mfpA8b3T9twUwdstaxIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Ua8sNA3t9l1KpGKiJ/dARDXDUA0vq89oqPtH8lACdgCNLR29
	EkLmVpFdINEEyG/XJM2xl5Kz7l57AyTrTwVURuHy8YzpGQFNYV/WvGc6RjPfkTBFXFGWS7myLkx
	AtBfUrqyTL7hj+BMCicO4W3blkLmpjfSxUbACwyuy
X-Gm-Gg: ASbGncvTrmkVvKV4NzE/0ZdTH5FwDZrTS6KOyjpUKQsC5li/s2eIkjYsOdVp4m8czpT
	ys/iGMOKMEDosoaKGrw7SMwzsQI450P9ZOcVRuA20aRyWSEswu2aPxd75y3vYyO6G/NOz8goVwo
	GIhhinGo4mkg6bnqidYAWKbcgmFUXRTQwd6Qk+nQNsepESqvYXL0Ju58YhS0I+7qWDhLEMD3U9U
	ZARW0k=
X-Google-Smtp-Source: AGHT+IHrA3GZZD0wwju8aMv9Qz7fcPczk9FABOxxb3E5ADsq04AqPwLpKjr7JRvL4/0iuqFoC974FPIiSp+z8XfswSE=
X-Received: by 2002:a05:6102:8087:b0:4e9:c652:6a1e with SMTP id
 ada2fe7eead31-4fa3fa67872mr2000007137.3.1753490530877; Fri, 25 Jul 2025
 17:42:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605233934.1881839-1-blakejones@google.com>
 <20250605233934.1881839-5-blakejones@google.com> <CAP-5=fVX_Qohsf=f=-fR8mYsTq4zitURit2=4BYyD5HPJHOT7Q@mail.gmail.com>
 <CAP_z_Cjuh9HJvcnsARaX-QUwDMbRPMDr9AtxbBxYUR_BTSzwCg@mail.gmail.com> <CAP-5=fWuU8Xhzvjx8FgQpOJCJXewOw9S3Vdm+aXYgw64bsq0UA@mail.gmail.com>
In-Reply-To: <CAP-5=fWuU8Xhzvjx8FgQpOJCJXewOw9S3Vdm+aXYgw64bsq0UA@mail.gmail.com>
From: Blake Jones <blakejones@google.com>
Date: Fri, 25 Jul 2025 17:41:59 -0700
X-Gm-Features: Ac12FXz0LtMLKb3jLJLRjLCQ4NRMLoH85zHPh6h6oQV6X5PeOP12nXzMnjePzzA
Message-ID: <CAP_z_CjEzaPo=V+rzyDWFgnnHfNGAe_jHm7g=++V72GPs1A-fw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] perf: add test for PERF_RECORD_BPF_METADATA collection
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Chun-Tse Shao <ctshao@google.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Yujie Liu <yujie.liu@intel.com>, 
	Graham Woodward <graham.woodward@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Ben Gainey <ben.gainey@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I just sent https://lore.kernel.org/linux-perf-users/20250726004023.3466563=
-1-blakejones@google.com/T/#u
to address this issue. Sorry for the delay.

On Wed, Jul 9, 2025 at 2:45=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Wed, Jul 9, 2025 at 2:08=E2=80=AFPM Blake Jones <blakejones@google.com=
> wrote:
> >
> > On Wed, Jul 9, 2025 at 2:02=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> > > > +++ b/tools/perf/tests/shell/test_bpf_metadata.sh
> > > > @@ -0,0 +1,76 @@
> > > > +#!/bin/sh
> > > > +# SPDX-License-Identifier: GPL-2.0
> > >
> > > The 2nd line in a shell test script is taken to be the name of the te=
st, so
> > > ```
> > > $ perf test list 108
> > > 108: SPDX-License-Identifier: GPL-2.0
> > > ```
> > >
> > > > +#
> > > > +# BPF metadata collection test.
> > >
> > > This should be on line 2 instead.
> >
> > Oof, that sure wasn't on my radar. Should I do a followup patch, or is
> > it not worth bothering?
>
> The patch has been in perf-tools-next for a few weeks:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/commit/?h=3Dperf-tools-next&id=3Dedf2cadf01e8f2620af25b337d15ebc584911b=
46
> so modifying it is probably not a good idea (it'd need a forced push
> and break people downstream). If you could send a follow up, that'd be
> great just so that we have >1 person in the
> author/reviewer/signed-off-by tag!
>
> Thanks,
> Ian


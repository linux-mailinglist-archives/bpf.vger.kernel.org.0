Return-Path: <bpf+bounces-62836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6537EAFF419
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 23:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345981C235AF
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 21:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEAA242D63;
	Wed,  9 Jul 2025 21:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e9zOKqmu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CCA23D2B6
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 21:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752097505; cv=none; b=WFtBSRwQOxpgpE/6MUR5amdENZjw+ltG9at26fiMjwsOARpiXdRpb0aPC64gQbdcDDT6B51y9hAAi+ROyp8KASyOw+Z14zDDcahvveoON2Wg+ZSRj2sSRvMbtT4GNQ+Cbc+mDxlr9MtdLPJ2eyc7aV8+XsKWOoBfk0xOkbgDqqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752097505; c=relaxed/simple;
	bh=01CE7K4ho1r55YJJxScMbaBt5qLzuHA3R4MFUcguS6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pfOHGd/b61zlyG8ttEmeXCavqooDcpA+at50zTK+B1GXW6yI7+EJvSQQkzsXPP76h5AtjlVIHU1yZLotNhaMSAibsSiQ7HSWszJoCiIn8ty0YFFL9N/dzjGws96JqDw7ao66d2kJaXpt9wurOd0chzLzOngpLRUN752ZK0ti8VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e9zOKqmu; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3df2fa612c4so27885ab.1
        for <bpf@vger.kernel.org>; Wed, 09 Jul 2025 14:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752097503; x=1752702303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01CE7K4ho1r55YJJxScMbaBt5qLzuHA3R4MFUcguS6Q=;
        b=e9zOKqmuxujH8ZRJY2hFqqVGnoQ9ruCzy5vQHAz94w+CuInpJWCxyROAdSoKvdSxWO
         KnDilMxnnLYYzsz4ipYSSwg4Cf9klV3bL2H46lZNz4hid2WCLYgbs5YcFX5rBwh+MmaT
         6RBWhF9a89n6dWRg+ZUeWvGVvrhXjGXLjyvuKjTaawbPOVxTe32iacljTBic+LuyvN55
         lrFdO7UCvCKDYxRDp3uYss1XHfvwKYWU45yke42LkWfQsnsrY4uPqI25FA8u+lR/1ISz
         mjAi+W/eaKUmEbQImxdXf8ZudJ1BoAvL+h8yOZcw0D4mzpMZudnpxkRn8NX+Ok0RuYwB
         hU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752097503; x=1752702303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01CE7K4ho1r55YJJxScMbaBt5qLzuHA3R4MFUcguS6Q=;
        b=ujUbFPhaN6AViytCHl0bKo6oq8K2nyQCQF84uVrzV4gM4e/WxQ7BGL2laYKZuAHFqu
         HZeneWVgvFAJ0ii7NqE3SchNOnJgfBGk4D+BD0r3S6zJF9BZm9sOjmkmho0fHcknfNwm
         dJsabrfsWPALa2Kv1h5mLrfs+u5cREQpB6c912Ys39HlnTouYZIGo6sCKmo4uWobI0sm
         CvnOfqbEUOvOxx7v5qUHYt6Z5XXlWVcgD6bSmxG5Ut5B5bX2qruLuwGpuo9cGPQHro3N
         xgJ4vl3FUoyzs5pX7cIip8aLL1j3my7reDFHcQGxvYJcPv+i0xnsyng8dUYqWyWka3Ww
         g32A==
X-Forwarded-Encrypted: i=1; AJvYcCUeUUnyrf2iDSBB0ce5dPAcz3L78jTu2gYmPs3K+XJz2j1JBWXLcRQ2B8ojwInzDMGDics=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZOtVdzK4DMCxls7Vr1fx/l1zLoWOUoGnn+9d/iZjx5raCFx1+
	5PIS2eohoWQ9SyuCGAFdz6XfQp3hsQz9iXjqUi2yOvN4jLbfGqQhP7LnXyvpOsw5aGvtLud02Jt
	b11/gd4bT5zOA9Vp/9e1XqK6eKcnxf4M0L5e4L0tC
X-Gm-Gg: ASbGncuJYnXvA1OmrprM91l+W2JUweiD+XN+75Kbw1+Vf0WwQkxXymghwFjvJuT0djk
	SZU1xtf3kuLhvEgYy61X7x+bZH5qQuUCE1wlroEQKF1CHag1GBc6kUVp37Qgn8Zf204iKh1Bnak
	pcPtoyPW5daLXC7RVF/pUFESo+pLBd74h6YRkXeFJazeGYE2IOWUgSDGYjbFDdBblE2Ii+nJ8TR
	A==
X-Google-Smtp-Source: AGHT+IGDvj8bx1fUmHxUSGQwiRfqgJ6KJHVT7FwiSP+jXeC2yBdD2wVOmYrSlzEzt+sNBRZD1B3BeFp1DsOQ9W/wMMU=
X-Received: by 2002:a05:6e02:190c:b0:3dc:866b:e8b5 with SMTP id
 e9e14a558f8ab-3e24511ba21mr1237475ab.16.1752097502734; Wed, 09 Jul 2025
 14:45:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605233934.1881839-1-blakejones@google.com>
 <20250605233934.1881839-5-blakejones@google.com> <CAP-5=fVX_Qohsf=f=-fR8mYsTq4zitURit2=4BYyD5HPJHOT7Q@mail.gmail.com>
 <CAP_z_Cjuh9HJvcnsARaX-QUwDMbRPMDr9AtxbBxYUR_BTSzwCg@mail.gmail.com>
In-Reply-To: <CAP_z_Cjuh9HJvcnsARaX-QUwDMbRPMDr9AtxbBxYUR_BTSzwCg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 9 Jul 2025 14:44:51 -0700
X-Gm-Features: Ac12FXxX2i29FTlYpzGRKLDLjekPcUXfK3HNPeuDfy_kcrXMjcag4_NirKBxz6g
Message-ID: <CAP-5=fWuU8Xhzvjx8FgQpOJCJXewOw9S3Vdm+aXYgw64bsq0UA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] perf: add test for PERF_RECORD_BPF_METADATA collection
To: Blake Jones <blakejones@google.com>
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

On Wed, Jul 9, 2025 at 2:08=E2=80=AFPM Blake Jones <blakejones@google.com> =
wrote:
>
> On Wed, Jul 9, 2025 at 2:02=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> > > +++ b/tools/perf/tests/shell/test_bpf_metadata.sh
> > > @@ -0,0 +1,76 @@
> > > +#!/bin/sh
> > > +# SPDX-License-Identifier: GPL-2.0
> >
> > The 2nd line in a shell test script is taken to be the name of the test=
, so
> > ```
> > $ perf test list 108
> > 108: SPDX-License-Identifier: GPL-2.0
> > ```
> >
> > > +#
> > > +# BPF metadata collection test.
> >
> > This should be on line 2 instead.
>
> Oof, that sure wasn't on my radar. Should I do a followup patch, or is
> it not worth bothering?

The patch has been in perf-tools-next for a few weeks:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/commit/?h=3Dperf-tools-next&id=3Dedf2cadf01e8f2620af25b337d15ebc584911b46
so modifying it is probably not a good idea (it'd need a forced push
and break people downstream). If you could send a follow up, that'd be
great just so that we have >1 person in the
author/reviewer/signed-off-by tag!

Thanks,
Ian


Return-Path: <bpf+bounces-70449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34167BBF8D9
	for <lists+bpf@lfdr.de>; Mon, 06 Oct 2025 23:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2072B18861B1
	for <lists+bpf@lfdr.de>; Mon,  6 Oct 2025 21:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E758C25FA13;
	Mon,  6 Oct 2025 21:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PwpEJP8o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC719A932
	for <bpf@vger.kernel.org>; Mon,  6 Oct 2025 21:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759785662; cv=none; b=cs3dAenSnQivde7nKQMmvp4OI2qRtNj4T5MUS9SL61d08jFvyuUzzvqtZ5h+0luBcDEAkqDRzXExAoEd9u8YS6TNUOsR91QfeuevZ92E/6zKCqRr+mKzUARV7u2ouP8ffLAaYdE5uOTA4aYcerFcy+aucNuDPIEG73g/ayekTqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759785662; c=relaxed/simple;
	bh=HfIeuybg/mn5ITts2VpFu5Joc84hMYJsBY3p3oUxuIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mzw6V2uBJBcBePfD1zc8g8McHJhG7sgP3dSMoK/y0xfls4nlcsqv0IKYgOsBQXKVzfeP9YHeDxEkaMJOAKza5eTzeuE59tAATCmHOE2v7Yr77pjCib10xJlD+vSXymH/D7rXlVVXfnl71NrIxM9MIPQvpszUPAYTZszZLaHjqUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PwpEJP8o; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27eeafd4882so77045ad.0
        for <bpf@vger.kernel.org>; Mon, 06 Oct 2025 14:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759785660; x=1760390460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yygezgppwmN8TaXy2XddLNQ6K72ee2TsBC22bb6zw+c=;
        b=PwpEJP8og450/iTp4E3+bi54Fs/jRZSd32DyswyasobvxhKrimz2WxeF4BvKKMLUEW
         4p57QogXdr2rr0N+Y4JJBlA1+qJNW9FLEMDxVnV3Zf7itWuHglIIDM7av603/4DUZ96r
         JiNymH9YZadPv5+bAqZt/uq/zPoK9nnqS1NoFwrtsZlolQi4mX4TmuydPOsaGfZqUv9Z
         yLeehYH9kkwGHxnYkoV1S0xZbYCtcYUNvTp3mkWFTkULfxJobXAJ/OkOLo2ZqDCfwcZv
         UncJSh88XNQRkScKds9hGFMtuoFGN6a5s2izLOZLL8irh7vsBGGvZZNqLKaCOa8PLnjP
         O0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759785660; x=1760390460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yygezgppwmN8TaXy2XddLNQ6K72ee2TsBC22bb6zw+c=;
        b=kC/j/ZN0afmiw6VP81dfkznILt7OMqw0JdTFT/F2aGWB9Sto3riKfd2FJsK4EVRP3r
         DlayKb2WMyXnb1chrJaMIx8gFOLpSfwA8+xu4+cK4D7jF4AfRhhBcbNPTp+TCtqGPWwU
         xi9mhOwEqb+x2ZLnbOHSErreKp5+2YPGtWWQ1WunDm4hWuRWjC1xjMz4HPqdWVNvQwUd
         jepa9UJg4a6Y0neQwR7wiltRni8jKy6mZzPoFY/23oedDp4zyJ6nH99jOHeDVtxRi3GG
         79p4MWSuB4W2gPB9+AxdQEBcuDe/WyCzasVvz3Nyoqy5yshbY3M1G1WafEYT6qsFNq+0
         E6Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVik2O6+dev6S0Ol/9V2v2Qh2ym4hDi9oc3WlNjB070rmiWMznRVPPREU0ssXiL8s96qjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzl3UQJYNdCO7m7ZBGnvcyW5LAN9m75owZKvvTWRJl9ULn4/iz
	z95iwpeldEyPWT6veWFcUpGorQbesFPqCsz7qlzPtvMY8PgiUrvcgQu9VU4AT9qEGeIzpDApP4U
	dcY8YGZ17IWKcxtH7KKnbBqi9d5iQE1H8aWKXJ2Mb
X-Gm-Gg: ASbGncvFWXA5C3h2OoCCrwmsxLdSlLgl/OwIC7U6jhaQ3ZoCLxiobjg40GkD2qfqPxb
	OU15JYqpkCHyjK/Qapj6bIbm9tlbgmpeZllbSKGHNZV31iw3GE4yBG7cbOuhN5REzDzeTUiz7j2
	/tlWrcsEggWLgQ7lsUYeFTzeYB2IBmPfRPdwG75f6wNI+rMts48UJMbRb+Gi3V/wxTwRKomFsDc
	9mnSu5DaMM3KMhFchwkIw7DRXl2P2eT8R5zUn+epfPJBVjIQUb8tAVvJszdcA4pfcR1EbuCwgvD
	LjTU/C4tVCmUsQ==
X-Google-Smtp-Source: AGHT+IHfTLW5dyXHYQEkC/161hfyYQ3YoYrzeoe+Ds3RuuOmM3FdzL7oX5omaWNuFuoeoDhi+lMYcYEr9UYzi3r4iOA=
X-Received: by 2002:a17:903:292:b0:266:b8a2:f605 with SMTP id
 d9443c01a7336-28ecb5a0d4dmr485375ad.3.1759785659818; Mon, 06 Oct 2025
 14:20:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001181229.1010340-1-irogers@google.com> <20251001181229.1010340-2-irogers@google.com>
 <CAP-5=fVHetc8DqdqxURJm_VtaH6apJKoyVOSpfQrE2ntkEa+4g@mail.gmail.com> <aOQfQW5WODbioEiA@x1>
In-Reply-To: <aOQfQW5WODbioEiA@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 6 Oct 2025 14:20:47 -0700
X-Gm-Features: AS18NWCk2I9RDjWf4Ty0o9SSdCAq1mkn4MWFQHKRsxoJqJ0SW43PlbtyI2nArh0
Message-ID: <CAP-5=fX3YDUUZm9K82fxw5a_LYfXh6uYF7HRJ=c4xMwJ1=cXCA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] perf bpf_counter: Fix handling of cpumap fixing hybrid
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Falcon <thomas.falcon@intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, Song Liu <songliubraving@fb.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Howard Chu <howardchu95@gmail.com>, Gabriele Monaco <gmonaco@redhat.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, James Clark <james.clark@linaro.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Tengda Wu <wutengda@huaweicloud.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 12:57=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Oct 06, 2025 at 09:18:22AM -0700, Ian Rogers wrote:
> > On Wed, Oct 1, 2025 at 11:12=E2=80=AFAM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > Don't open evsels on all CPUs, open them just on the CPUs they
> > > support. This avoids opening say an e-core event on a p-core and
> > > getting a failure - achieve this by getting rid of the "all_cpu_map".
> > >
> > > In install_pe functions don't use the cpu_map_idx as a CPU number,
> > > translate the cpu_map_idx, which is a dense index into the cpu_map
> > > skipping holes at the beginning, to a proper CPU number.
> > >
> > > Before:
> > > ```
> > > $ perf stat --bpf-counters -a -e cycles,instructions -- sleep 1
> > >
> > >  Performance counter stats for 'system wide':
> > >
> > >    <not supported>      cpu_atom/cycles/
> > >        566,270,672      cpu_core/cycles/
> > >    <not supported>      cpu_atom/instructions/
> > >        572,792,836      cpu_core/instructions/           #    1.01  i=
nsn per cycle
> > >
> > >        1.001595384 seconds time elapsed
> > > ```
> > >
> > > After:
> > > ```
> > > $ perf stat --bpf-counters -a -e cycles,instructions -- sleep 1
> > >
> > >  Performance counter stats for 'system wide':
> > >
> > >        443,299,201      cpu_atom/cycles/
> > >      1,233,919,737      cpu_core/cycles/
> > >        213,634,112      cpu_atom/instructions/           #    0.48  i=
nsn per cycle
> > >      2,758,965,527      cpu_core/instructions/           #    2.24  i=
nsn per cycle
> > >
> > >        1.001699485 seconds time elapsed
> > > ```
> > >
> > > Fixes: 7fac83aaf2ee ("perf stat: Introduce 'bperf' to share hardware =
PMCs with BPF")
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > +Thomas Falcon
> >
> > I think it'd be nice to get this quite major fix for
> > --bpf-counters/bperf for hybrid architectures into v6.18 and stable
> > builds. Thomas would it be possible for you to give a Tested-by tag
> > using the reproduction in the commit message?
>
> Its even already in linux-next:
>
> =E2=AC=A2 [acme@toolbx perf-tools-next]$ git log -5 --oneline linux-next/=
master tools/perf/util/bpf_counter.c
> b91917c0c6fa6df9 perf bpf_counter: Fix handling of cpumap fixing hybrid
> 8c519a825b4add85 perf bpf_counter: Move header declarations into C code
> 07dc3a6de33098b0 perf stat: Support inherit events during fork() for bper=
f
> effe957c6bb70cac libperf cpumap: Replace usage of perf_cpu_map__new(NULL)=
 with perf_cpu_map__new_online_cpus()
> b84b3f47921568a8 perf bpf_counter: Fix a few memory leaks
> =E2=AC=A2 [acme@toolbx perf-tools-next]$

Oh, thanks! Sorry for missing it. Thanks Thomas for the tag!

Ian


Return-Path: <bpf+bounces-39068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FA796E422
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 22:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 931DC1C23940
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 20:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C4B1A38F5;
	Thu,  5 Sep 2024 20:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuXMphDT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0393D193434;
	Thu,  5 Sep 2024 20:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725568394; cv=none; b=o9pzmPBVONGOQoCUy4s8oHlOP4g84gOOQSYgUE6wlb1j6h75I/C78VedmvCg2oAK2Wvpo3cgu9EaZfcCW+0SolJmYEM4EHDp/2vX9HpSyipG8eqhWYqgC1tPP9stDnLDeT36cuIEPtOzK5WpFb0bEDhdRJ4uuOkJpL74mvt6PW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725568394; c=relaxed/simple;
	bh=viMiY27T/DgIEp5cOuLMmVddL2dV80RqDvknoGpCrPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oWuA5I7DcH7c6LuemNeZZiTbx2ZUnuLX3nwlZCjM6HYe/63THInV0sp8UEnEiCWBrmJxWW11O/ekKkpnP/YXHEa9dhaenWn0Ycdv5djIlBUMBHEuMRWwfXKCPYcpz9Aid/szl6Tf8PCBppEbjpulfOMHari/zLW6qxEaB9rl2W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TuXMphDT; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d873dc644dso940609a91.3;
        Thu, 05 Sep 2024 13:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725568392; x=1726173192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkO2Onh5KBMN7JfbUKWIxqBcqXRVZ028mK8ANWdd19g=;
        b=TuXMphDTBPY050SJUZr8hUXoDh87KqxEqDqDdtMToaCQyHEHu0wrdHXSxHlJIy+dWY
         WVjpep2SAqR+Kh0dnyU0kr9qUrzd7WS729ZZkXKA8PkH4o/uohDKDqlcepFnF9Yjtg8/
         lyo6zO6tkO0VWKGagV8Hi302a3Q6ZIgbZPA8LMBzrIScG6IDQtZNw0ygGxHLgAqji1UL
         prCEMMFYstQWrch+lJ9wvIwCo8VkGq2NjFSdnggjRYydbi6Ogy8vUTjRHgazM6EY8gFG
         zCCYd3bfUrlPmDn+AlfJQBK7LbySPnDhBzES2ytVLuKVkn6w8eCIUXgZng0xOGZ+cUk0
         sIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725568392; x=1726173192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AkO2Onh5KBMN7JfbUKWIxqBcqXRVZ028mK8ANWdd19g=;
        b=OiZAjEWRSPmajvfjVGzA8a+RrABMubQEKLDBCoQA3Qi+ecmMJO1p9VCYqtLvdUGW3T
         Yv/X3sBMhZ6uBDaxD+cXDN983zm5GulL85e8pxnu9wOw593+L93eOGhISX8oup/iBvZE
         nNrv119abokVjZO/9EiSogeJ5kp7HA8ry1rslXxVbvapYmHyJj2P0pexFRg8b9ZkhRPx
         HJPaKH6vZOO6TjlptkZb8LokBh/yfc5ftkt6IvxaG2pyJ2PdJccdMccuQggkA/eVOX9B
         Hme0RrfWGK5ls1/le21TobFqsHDr+p9PuJMDW1FUdO/oBTUdRt2CuKRzg+By3fsVKgck
         jIrA==
X-Forwarded-Encrypted: i=1; AJvYcCUBz1yKoWtoVa7iHU++Wo57v5m2Gy2Va6CvKN3UUX/+h68EipJW8eBsooFX1hW6Qw9XWOs=@vger.kernel.org, AJvYcCVDyBJ5ogz+TwLW70Hi2S3gsmfewzgjaUki+Ht+Yy9JS/Ac4y6wUuLqqpriyVjWZ2FqcqRT2uIs@vger.kernel.org, AJvYcCWRF9B7biMnpNZHNnorfkLoVmR50JeSPDrqETQZbFJXNMlinYTE+e9YI4VsBtgLadiCqIfPTNpBFPlnHUBd@vger.kernel.org, AJvYcCXjXqei4JxIZazSbDRLKuBMjsdlj4c9XrfYG90ogOnKtl5he6PjKhfUXKDMWt4nJ7C9ixJywEl9BRqNzsJiDTvsaw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzHRl7+A02UxXBdJw/j0JVygBjIdtuJDNG26ZYXd1Ao3iVtiTT
	kmDe0i/2kspoLS4LfHwuCAPgQ6IvXAvNuJhw2yu9zgEfqQtUsM3dvnuO3hsUlHMKz7DkL67cy8I
	UZ998wK/7sy9Sr2BjeFuxnIFSUwU=
X-Google-Smtp-Source: AGHT+IFGJCAgnJYeXefctM/aCpjEwCU9o1FLKd+Gk9XLYIoN+C+xgJO+mQaDQ59X4EEpegOzU+jpbnScO/xrznGIrIQ=
X-Received: by 2002:a17:90a:2f04:b0:2d8:83ce:d4c0 with SMTP id
 98e67ed59e1d1-2d883ceeab5mr23306821a91.13.1725568392151; Thu, 05 Sep 2024
 13:33:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905180055.1221620-1-andrii@kernel.org> <ddfd906c-83cc-490a-a4bb-4fa43793d882@linux.intel.com>
 <CAEf4Bza9H=nH4+=dDNm55X5LZp4MVSkKyBcnuNq3+8cP6qt=uQ@mail.gmail.com> <e7e0ef26-2335-4e67-984c-705cb33ff4c3@linux.intel.com>
In-Reply-To: <e7e0ef26-2335-4e67-984c-705cb33ff4c3@linux.intel.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Sep 2024 13:33:00 -0700
Message-ID: <CAEf4BzYOxpLAowE=4A=qUreLkgKBkDYbOxnidbnQNKQdLx7=WQ@mail.gmail.com>
Subject: Re: [PATCH] perf/x86: fix wrong assumption that LBR is only useful
 for sampling events
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-perf-users@vger.kernel.org, 
	peterz@infradead.org, x86@kernel.org, mingo@redhat.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, acme@kernel.org, 
	kernel-team@meta.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 1:29=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
>
>
>
> On 2024-09-05 4:22 p.m., Andrii Nakryiko wrote:
> > On Thu, Sep 5, 2024 at 12:21=E2=80=AFPM Liang, Kan <kan.liang@linux.int=
el.com> wrote:
> >>
> >>
> >>
> >> On 2024-09-05 2:00 p.m., Andrii Nakryiko wrote:
> >>> It's incorrect to assume that LBR can/should only be used with sampli=
ng
> >>> events. BPF subsystem provides bpf_get_branch_snapshot() BPF helper,
> >>> which expects a properly setup and activated perf event which allows
> >>> kernel to capture LBR data.
> >>>
> >>> For instance, retsnoop tool ([0]) makes an extensive use of this
> >>> functionality and sets up perf event as follows:
> >>>
> >>>       struct perf_event_attr attr;
> >>>
> >>>       memset(&attr, 0, sizeof(attr));
> >>>       attr.size =3D sizeof(attr);
> >>>       attr.type =3D PERF_TYPE_HARDWARE;
> >>>       attr.config =3D PERF_COUNT_HW_CPU_CYCLES;
> >>>       attr.sample_type =3D PERF_SAMPLE_BRANCH_STACK;
> >>>       attr.branch_sample_type =3D PERF_SAMPLE_BRANCH_KERNEL;
> >>>
> >>> Commit referenced in Fixes tag broke this setup by making invalid ass=
umption
> >>> that LBR is useful only for sampling events. Remove that assumption.
> >>>
> >>> Note, earlier we removed a similar assumption on AMD side of LBR supp=
ort,
> >>> see [1] for details.
> >>>
> >>>   [0] https://github.com/anakryiko/retsnoop
> >>>   [1] 9794563d4d05 ("perf/x86/amd: Don't reject non-sampling events w=
ith configured LBR")
> >>>
> >>> Cc: stable@vger.kernel.org # 6.8+
> >>> Fixes: 85846b27072d ("perf/x86: Add PERF_X86_EVENT_NEEDS_BRANCH_STACK=
 flag")
> >>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >>> ---
> >>>  arch/x86/events/intel/core.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/cor=
e.c
> >>> index 9e519d8a810a..f82a342b8852 100644
> >>> --- a/arch/x86/events/intel/core.c
> >>> +++ b/arch/x86/events/intel/core.c
> >>> @@ -3972,7 +3972,7 @@ static int intel_pmu_hw_config(struct perf_even=
t *event)
> >>>                       x86_pmu.pebs_aliases(event);
> >>>       }
> >>>
> >>> -     if (needs_branch_stack(event) && is_sampling_event(event))
> >>> +     if (needs_branch_stack(event))
> >>>               event->hw.flags  |=3D PERF_X86_EVENT_NEEDS_BRANCH_STACK=
;
> >>
> >> To limit the LBR for a sampling event is to avoid unnecessary branch
> >> stack setup for a counting event in the sample read. The above change
> >> should break the sample read case.
> >>
> >> How about the below patch (not test)? Is it good enough for the BPF us=
age?
> >>
> >> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core=
.c
> >> index 0c9c2706d4ec..8d67cbda916b 100644
> >> --- a/arch/x86/events/intel/core.c
> >> +++ b/arch/x86/events/intel/core.c
> >> @@ -3972,8 +3972,12 @@ static int intel_pmu_hw_config(struct perf_even=
t
> >> *event)
> >>                 x86_pmu.pebs_aliases(event);
> >>         }
> >>
> >> -       if (needs_branch_stack(event) && is_sampling_event(event))
> >> -               event->hw.flags  |=3D PERF_X86_EVENT_NEEDS_BRANCH_STAC=
K;
> >> +       if (needs_branch_stack(event)) {
> >> +               /* Avoid branch stack setup for counting events in SAM=
PLE READ */
> >> +               if (is_sampling_event(event) ||
> >> +                   !(event->attr.sample_type & PERF_SAMPLE_READ))
> >> +                       event->hw.flags  |=3D PERF_X86_EVENT_NEEDS_BRA=
NCH_STACK;
> >> +       }
> >>
> >
> > I'm sure it will be fine for my use case, as I set only
> > PERF_SAMPLE_BRANCH_STACK.
> >
> > But I'll leave it up to perf subsystem experts to decide if this
> > condition makes sense, because looking at what PERF_SAMPLE_READ is:
> >
> >           PERF_SAMPLE_READ
> >                  Record counter values for all events in a group,
> >                  not just the group leader.
> >
> > It's not clear why this would disable LBR, if specified.
>
> It only disables the counting event with SAMPLE_READ, since LBR is only
> read in the sampling event's overflow.
>

Ok, sounds good! Would you like to send a proper patch with your
proposed changes?

> Thanks,
> Kan
> >
> >>         if (branch_sample_counters(event)) {
> >>                 struct perf_event *leader, *sibling;
> >>
> >>
> >> Thanks,
> >> Kan
> >>>
> >>>       if (branch_sample_counters(event)) {


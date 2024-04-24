Return-Path: <bpf+bounces-27760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB518B169E
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 00:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A29601C23DE2
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 22:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9624F16EC0B;
	Wed, 24 Apr 2024 22:57:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29181E86F;
	Wed, 24 Apr 2024 22:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713999433; cv=none; b=eupzBi7QvzE+jXXPcg0cmkWMfr3uagnhzENi6dEG5A6IEy1vfBd14YW83pGUlGSfnnVpr/u29V4WWmhc7IftO2ch4wvAsGKrTMFlU6ZnjI03lReJzaWxxKtnAWVaBxumjVZzl3X1+u2MDPv7aLanUeEyLrWknyHCH78a2lnDeTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713999433; c=relaxed/simple;
	bh=lwbYYbsXsxGhuf73dizS9HwSfF5+RHFNMCGuUOEMxTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nDgRka9yI7h8Wx6HkueouTISUs57bTsSc6cpGUVmKY0oM/sHhNUtr3EByeGmbTrrBOD31J9KGoc7KCIgeObEylHvNCy6tQctyL1ntXjRW1cBvJ9BBgBkILGc9xnJ/3W3gSza/iWhma2qz9oA4dDj46ENT1XWaJAaZqLQqNkJNxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ab88634cfaso369769a91.0;
        Wed, 24 Apr 2024 15:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713999431; x=1714604231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uzrWXePhPUiWACNXAmGYhUpfT1p86M5As1cmuIlv4Ac=;
        b=b/+xAZUukfW7kxchLmzBjR11XAbufj2Z7E/4GoOO8/OIFzeakoMq/Ejqyn8v2kP8IF
         fUbyE25BLWXQLyHIgsGiWST7MsANAZduXFz6mcogCTdmjXiH/HxZ4cJSVQpJQF5Exvlc
         kIatI2IlrCMI2qfavnf9FnglIZfWJcmDyWpvaFuhzLfKov0uEpd0poYwnrF3sV72xPKC
         pqWTHR1rXINCgL5JyG/9zNa3DFbX/opzNOYQpldkCPlTsfJ8K+bqa/yGc1TO5ZI5FKDH
         i/1AZpN47Tf6MbT0h10fES2VWKaknaxUABZpKesVddqVOboTrHjfTeJ0uTB/B1514ZLG
         RFZw==
X-Forwarded-Encrypted: i=1; AJvYcCWgve+T1/0hnymFXppxS4Yb2higu8/Ztjm8HzrrJXI17Lr+ald6r49KXKw8lnP0gg7VWmct9os0mhtFVrwarVO7UHjaqvv7CBMjvPVbl1u1XaDQxmSf+JvJj6hGK+EF9z9qjeMB/MN6kqtuclu8FLSNiXlw5Ht7ws+ceybDT4aW7lQ56Q==
X-Gm-Message-State: AOJu0Yw3Oi0KzacMt68snhJz/M3pVSIJ/GeXsxaQvzlpGGzkmcDlMLR/
	TC40RyOdooM8DcjeFioroc17NRjJYn7Fb1M0ndLUPy0twB23yH+X3fFuSP63s6XFu6Pg8Sv1XVj
	C8ZLQP7FEroV1kNCLXOeedreCZj0=
X-Google-Smtp-Source: AGHT+IFRrbis0uqy/2CD0kwIlu5gblq93SIG+YoYnvbyRD4H07Pfm1cgyimWYJUENRLrNfLYbJtYySJK9WXohedY+DM=
X-Received: by 2002:a17:90b:316:b0:2a5:24ab:1a94 with SMTP id
 ay22-20020a17090b031600b002a524ab1a94mr3352838pjb.49.1713999431268; Wed, 24
 Apr 2024 15:57:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424024805.144759-1-howardchu95@gmail.com>
 <CAM9d7chOdrPyeGk=O+7Hxzdm5ziBXLES8PLbpNJvA7_DMrrGHA@mail.gmail.com>
 <Zil1ZKc7mibs6ONQ@x1> <CAP-5=fVYHjUk8OyidXbutBvZMPxf48LW7v-N3zvHBe5QME1vVQ@mail.gmail.com>
In-Reply-To: <CAP-5=fVYHjUk8OyidXbutBvZMPxf48LW7v-N3zvHBe5QME1vVQ@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 24 Apr 2024 15:57:00 -0700
Message-ID: <CAM9d7cggak7qZcX7tFZvJ69H3cwEnWvNOnBsQrkFQkQVf+bUjQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Dump off-cpu samples directly
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Howard Chu <howardchu95@gmail.com>, peterz@infradead.org, 
	mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	zegao2021@gmail.com, leo.yan@linux.dev, ravi.bangoria@amd.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 3:19=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Apr 24, 2024 at 2:11=E2=80=AFPM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Wed, Apr 24, 2024 at 12:12:26PM -0700, Namhyung Kim wrote:
> > > Hello,
> > >
> > > On Tue, Apr 23, 2024 at 7:46=E2=80=AFPM Howard Chu <howardchu95@gmail=
.com> wrote:
> > > >
> > > > As mentioned in: https://bugzilla.kernel.org/show_bug.cgi?id=3D2073=
23
> > > >
> > > > Currently, off-cpu samples are dumped when perf record is exiting. =
This
> > > > results in off-cpu samples being after the regular samples. Also, s=
amples
> > > > are stored in large BPF maps which contain all the stack traces and
> > > > accumulated off-cpu time, but they are eventually going to fill up =
after
> > > > running for an extensive period. This patch fixes those problems by=
 dumping
> > > > samples directly into perf ring buffer, and dispatching those sampl=
es to the
> > > > correct format.
> > >
> > > Thanks for working on this.
> > >
> > > But the problem of dumping all sched-switch events is that it can be
> > > too frequent on loaded machines.  Copying many events to the buffer
> > > can result in losing other records.  As perf report doesn't care abou=
t
> > > timing much, I decided to aggregate the result in a BPF map and dump
> > > them at the end of the profiling session.
> >
> > Should we try to adapt when there are too many context switches, i.e.
> > the BPF program can notice that the interval from the last context
> > switch is too small and then avoid adding samples, while if the interva=
l
> > is a long one then indeed this is a problem where the workload is
> > waiting for a long time for something and we want to know what is that,
> > and in that case capturing callchains is both desirable and not costly,
> > no?

Sounds interesting.  Yeah we could make it adaptive based on the
off-cpu time at the moment.

> >
> > The tool could then at the end produce one of two outputs: the most
> > common reasons for being off cpu, or some sort of counter stating that
> > there are way too many context switches?
> >
> > And perhaps we should think about what is best to have as a default, no=
t
> > to present just plain old cycles, but point out that the workload is
> > most of the time waiting for IO, etc, i.e. the default should give
> > interesting clues instead of expecting that the tool user knows all the
> > possible knobs and try them in all sorts of combinations to then reach
> > some conclusion.
> >
> > The default should use stuff that isn't that costly, thus not getting i=
n
> > the way of what is being observed, but at the same time look for common
> > patterns, etc.
> >
> > - Arnaldo
>
> I really appreciate Howard doing this work!
>
> I wonder there are other cases where we want to synthesize events in
> BPF, for example, we may have fast and slow memory on a system, we
> could turn memory events on a system into either fast or slow ones in
> BPF based on the memory accessed, so that fast/slow memory systems can
> be simulated without access to hardware. This also feels like a perf
> script type problem. Perhaps we can add something to the bpf-output
> event so it can have multiple uses and not just off-cpu.
>
> To turn the bpf-output samples into off-cpu events there is a pass
> added to the saving. I wonder if that can be more generic, like a save
> time perf inject.
>
> I worry about dropping short samples we can create a property that
> off-cpu time + on-cpu time !=3D wall clock time. Perhaps such short
> things can get pushed into Namhyung's "at the end" approach while
> longer things get samples. Perhaps we only do that when the frequency
> is too great.

Sounds good.  We might add an option to specify the threshold to
determine whether to dump the data or to save it for later.  But ideally
it should be able to find a good default.

>
> It would be nice to start landing this work so I'm wondering what the
> minimal way to do that is. It seems putting behavior behind a flag is
> a first step.

Agreed!

Thanks,
Namhyung


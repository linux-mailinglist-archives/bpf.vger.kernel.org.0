Return-Path: <bpf+bounces-50796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EABADA2C9FB
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 18:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 509D01647DD
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 17:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6510919343E;
	Fri,  7 Feb 2025 17:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="m9h8IScZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7E818DB21
	for <bpf@vger.kernel.org>; Fri,  7 Feb 2025 17:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738948743; cv=none; b=i5aclqX7saje0HTLt48to17ZnS5LFx5IIZycIW90ofvHnlXEup9BZ7nX3eTQA9f2JIMnnM21+rZa8zG2YjUqcuvavffxqvANmCzQfLqsQIe5q+v2kD8MclR6gBszxS603joEsPNKh58q/UA4ghT+H7io2ns8BZy+ou3e+yo2ijk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738948743; c=relaxed/simple;
	bh=bCyLI4LdJFH3HYJ+mp58RKBb7vU+yOgcEAiFrzYDgxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=guv7/ZawCeeZqL2E90cttou0NLuHNvm27k7BCvnJK+goWcvMtW74EH2VThs2TiZOXfOY0I44lqM+L6bf9aOFmmWdk5N5J7N+DDY5bm+x+mgRV+en1ZatjPxACjSN0x6WfqmpO2Fh1JiWUfLaIaN6ziJpjjhQ7Cp1g8PbBTi7drk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=m9h8IScZ; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5fa3714d4bbso1076756eaf.1
        for <bpf@vger.kernel.org>; Fri, 07 Feb 2025 09:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738948741; x=1739553541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ur5RSQfj/6q4nsk1ykW3bsaGkSYhTmlbRHhJKO1AJt4=;
        b=m9h8IScZ9/MusYk77DltC9SySE5u6Uy+jNNGobYeoT6U6sCY4UnYbObe0hsdnXuNn0
         0eofyT7rCRQaiAt8tSFeStzaZGnFj+3yZ2O8G9OsyDrBgeCVWSKzvbuGsIof95dSlhyM
         BAILhNj2GvviHz+2/PElo7QYCcAEDFVVIsIyGLtVWjNTMlTAj978CHYRYkIGQ7KZ/Zir
         ZubWwFU4JDPIkdz6PssfOGocm4XAb22qBSZ+diFZVfoI6/8wtm9LvbYE8matoOmUHO7t
         H1RMNBZjTvWm+VnA9Me4rpYp/4NlDfE4iCpyRBZ1hnm9OSXDoBFom2VJby4gBCBMxNJL
         SXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738948741; x=1739553541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ur5RSQfj/6q4nsk1ykW3bsaGkSYhTmlbRHhJKO1AJt4=;
        b=ivg9Xb0Nr4PZfyZy6w9M9vVvo/Cshncd2U0n1dmOf176T/Albge9TRtE9EtScyKxrA
         XmxhdSoAThG3ZpB2vxz8FkEjp/uHX3X/Df8+5QO6DJ2W4Ij7qjDSzuPJrvr9sfatffh6
         Bl1by2IrSpAxOkyvHUJ9DagcEgsf72dqa1D4QUC4uGypQdIRZ8ePnOqoblJDz3mIDMFR
         C2MNKFjzEAvWh8N1lbHfHiEe1I5Ard7+pMkQ8EQlRtvFmp5daf5LdnTEHSdoEIC/yJdB
         nmMem7qj1U7VP/76lnoSoBfJWuFQRO2tBWe0g+si5hAaoGEfYeu1UvWrlrlO92lFl3jY
         HZpw==
X-Forwarded-Encrypted: i=1; AJvYcCXNOT9QRjUwS4x6jQyElQhUen00BVnTR1npRHyIG8T8jQQk2c1fkEUSFdzS4W6DkQ/hPjk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw3XhqEk62ydeXj4jQ5iLHvAPDs6y8m/mmvQ+L+rpKKi16qdkU
	a2DMeDfpn6pozQRhV3CXneLWdjbk03/TaENs9RZQE/VDnUDSMF5gLj06TnRBlIsHNYYiPTc+eQO
	2qdny/XHJ/nvbYIDSbMYkJWAoDFVzhsMeax9Nbw==
X-Gm-Gg: ASbGnctfGGIABZPPnqYiV5EJbjmF/T1c2C+8XR3btdJ+KdiAQys/G5KnucgEMWXIFpR
	DykHZdBDqeijFDRMe57LNeL8nIKtugM5KGg7r7uRhl1dTOa3kIF9BEw8RM/RgEVaDrQSnDvHBHg
	==
X-Google-Smtp-Source: AGHT+IHsi/ZbRUCDTbGa+S4gwnuDQ0P9Att1TuOKE8XNTpFBKDDvlXJ7rYRr+HChTgTlCLe9hSF0zVph0a2miEpRufY=
X-Received: by 2002:a05:6820:1803:b0:5f8:89bd:b99b with SMTP id
 006d021491bc7-5fc5e746f98mr2746002eaf.8.1738948740668; Fri, 07 Feb 2025
 09:19:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z5qjwRG5jX9zAGtf@google.com> <CAHBxVyHL4CO1xGpzkNfvxk71gUYdVyrXZkqZHZ+ZV2VxeGFf8w@mail.gmail.com>
 <Z51RxQslsfSrW2ub@google.com> <CAP-5=fWzzWqNAgmrDHav63Z+HMnSP0RZJ3Q7PQpuzP7Tf_HP7g@mail.gmail.com>
 <Z6FcHJFYGc7HzSna@google.com> <CAP-5=fW9f2mxuTV2FGCdhKm7M9g8v6VsLJJXTPTLRr5tUv9rOA@mail.gmail.com>
 <Z6LFp5jiED7_-weN@google.com> <CAP-5=fU6WSOK_N0NoLcMSSdaWAkdC2DUBwLqsLn_KA7m6dJyeQ@mail.gmail.com>
 <Z6RD7NuT9IPhOkIV@google.com> <CAP-5=fV8rRMQyMDuy1vcxyEX9Gf8x0QJdVEP-K5krBec_A7mpA@mail.gmail.com>
 <Z6WPmYCJcc6pPKDA@google.com> <CAP-5=fU0263rZx+i_dpeBWVUiKHuNNp4ER7WhDe2zHPUsq=wmw@mail.gmail.com>
In-Reply-To: <CAP-5=fU0263rZx+i_dpeBWVUiKHuNNp4ER7WhDe2zHPUsq=wmw@mail.gmail.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Fri, 7 Feb 2025 09:18:49 -0800
X-Gm-Features: AWEUYZk70S5T78s7X_Ye6HV7heVIayUb8TmEoaV5jzwQHEtQtI3ikzbJKW6UgUg
Message-ID: <CAHBxVyH1q5CRW3emWTZu1oLZEfTWWVRH6B0OVggFxt-0NRzvwQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] perf parse-events: Reapply "Prefer sysfs/JSON
 hardware events over legacy"
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>, Leo Yan <leo.yan@arm.com>, 
	Beeman Strong <beeman@rivosinc.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 10:15=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, Feb 6, 2025 at 8:44=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
> > On Wed, Feb 05, 2025 at 11:44:57PM -0800, Ian Rogers wrote:
> > > Why was adding a PMU to an event name, working around ARM's PMU bug,
> > > such an unsurmontable problem that the original change was reverted?
> > > Because 1 person didn't want to have to write a PMU prefix and
> > > considered it a monumental regression having to do so.
> >
> > Because it's a legacy event 'cycles' and he didn't expect the wildcard
> > behavior?
>
> And someone who say with perf v6.14 can type `perf stat -e data_read
> ...` and then with your proposal now has to type `perf stat -e
> uncore_imc_free_running/data_read/ ...` because data_read isn't a core
> event, this is expected behavior because the error message mentions
> perf list?
>
> > > > 1. RISC-V is working on a solution with the current status and it's=
 not
> > > >    absoluted needed to change the current behavior.
> > >
> > > They said to you directly it was what they wanted, that's why I
> > > reposted this change and it is, has always been, in the cover letter.
> > > They've then followed up expressing their desire for this behavior bu=
t
> > > having to have a plan b as the original change was reverted and you
> > > are blocking this change landing.
> >
> > So they have the plan B.  But still prefer overriding legacy with JSON?
>
> Yes.
>
Even though the driver encoding was envisioned as plan B, I think we
have to keep that irrespective of
legacy overriding with json is available or not due to the reasons I
iterated earlier
(e.g direct legacy event usage and hypervisor) and some renewed
interest in standardizing event encodings in RISC-V[1]

If the overriding legacy with JSON is available, each future vendor
may just provide the json file instead of modifying the driver.
However, it will be a matter of convenience and clutter free future
rather than a necessity at this point.

[1] https://lists.riscv.org/g/sig-perf-analysis/topic/110906276#msg458

> > > > 2. Apple-M is fixed already.
> > >
> > > No, James tried to repro the bug on a Juno board, not an Apple M, and
> > > didn't succeed. I don't know what kernel he tried. I was told by Mark
> > > Rutland (at LPC) that the tool fix was absolutely necessary and the
> > > PMU driver wouldn't be fixed, hence the series flipping behavior that
> > > I thought Intel would most likely block and wasn't keen to do in the
> > > 1st place (not least wade through all the test behavior changes and
> > > the bug tail). All of this was premised on a threat of reverting all
> > > of the hybrid support so that Apple M could be made to work again, an=
d
> > > I was trying to do a less worse alternative.
> > > https://lore.kernel.org/r/20231123042922.834425-1-irogers@google.com
> >
> > Sorry, it's not clear to me what's the problem exactly.  Can you give m=
e
> > an example command line?
>
> What broke: when arm PMUs were recognized as core and not uncore PMUs,
> as part of fixing hybrid, we encoded legacy events on them. So
> arm_blah/cycles/ became a type 0 config 0 event, no extended type as
> PMU support for that is tested first. A type 0 config 0 event is
> broken on the Apple-M PMUs, an event that doesn't count or something
> like that. Because they had a sysfs event of arm_blah/cycles/ before
> the change the broken legacy encoding on the PMU was never used, the
> legacy event broke things.
>
> Because they had this problem the Apple-M users were used to using
> arm_blah/cycles/ rather than cycles to avoid legacy events. This
> change, not your proposal, is making it so that without a PMU they
> also don't get legacy events because in no uncertain terms it was
> expressed they weren't going to work. There was a lot of advocating
> for removing all hybrid support from the tool.
>
> > > I don't understand what you are trying to say. I'm saying the behavio=
r
> > > of perf list in its output is arbitrary. We use the same printing cod=
e
> > > for every kind of event. An aesthetic decision to put things on a lin=
e
> > > does not imply that it is more valid to use or not use a PMU, it just
> > > happens to be what the tool does. Did I break perf list as if you loo=
k
> > > in old perf list you see:
> > > ```
> > > $ perf list
> > > List of pre-defined events (to be used in -e or -M):
> > >
> > >  duration_time                                      [Tool event]
> > > ...
> > > ```
> > > while now you see:
> > > ```
> > > $ perf list
> > > List of pre-defined events (to be used in -e or -M):
> > > ...
> > > tool:
> > >  duration_time
> > >       [Wall clock interval time in nanoseconds. Unit: tool]
> > > ...
> > > ```
> > > I'm hoping people find it useful to have the unit documented.
> >
> > The most important information I think is the name of the event
> > (duration_time).  It'd be appropriate if you could call it
> > 'tool/duration_time/' but I'm not sure if it's acceptable cause
> > tool events are not real PMU events.  If so, maybe
> >
> >  duration_time or tool/duration_time/
> >
> > ?
>
> I don't mind showing a PMU and not showing a PMU. duration_time isn't
> a core event, does it also get allowed no PMU prefix in your new
> scheme? My point isn't to discuss duration_time it is to point out
> that `perf list` output isn't sacred and says different things over
> time. Those things may or may not include a PMU as there has never
> been any rigor, it is a mush of strings that are printed.
>
> In the perf list code we have an event and an alias. In my opinion if
> something is an alias of something else then it implies having the
> same perf_event_attr encoding. In your proposal this wouldn't be true
> for legacy events as it isn't true today. Which has always been my
> point about wanting to get this fixed.
>
> > I think people should use a PMU prefix before wildcard is enabled.
>
> I don't understand. You want to break uncore events without a PMU and
> disable wild carding, then enable wildcarding again. Like I say I
> think it is better you work on this behavior under a non `-e` command
> line option.
>
> > > > > What happens if an event is both in sysfs and json? Well the sysf=
s event
> > > > > will get the description from the json and then I believe it won'=
t
> > > > > behave as you show. Did the event get broken, as perf list no lon=
ger
> > > > > shows it with a PMU, by having a json description written? I thin=
k not
> > > > > and I think having descriptions with events is a good thing.
> > > >
> > > > That's bad.  Probably we should fix it takes only one of the source=
s and
> > > > change the JSON event not to clash with sysfs.
> > >
> > > No, you are talking about breaking everything already, let's not brea=
k
> > > it yet further - not least as we lack a reasonable way to test it. I
> > > think if you are serious about having such breaking changes then it i=
s
> > > best you add a new command line option, like with libpfm events.
> >
> > I don't want to break things.  What's the intended behavior in that cas=
e?
>
> The behavior is in pmu's update_event, but basically we prefer the
> json data over the sysfs data:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/=
tree/tools/perf/util/pmu.c?h=3Dperf-tools-next#n506
> This allows the json/tool data to correct the sysfs data - as well as
> to add information like descriptions and topic.
> But my point isn't that I support your let's have two events instead
> of updating events. I have maintained this behavior as it has always
> been the behavior and I care about not breaking everything. Something
> that I assumed was taken for granted hence making `perf top` behave in
> a way where it is showing samples for processes that have terminated
> by default.
>
> Thanks,
> Ian


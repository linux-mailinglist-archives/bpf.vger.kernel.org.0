Return-Path: <bpf+bounces-50748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CACEA2BB42
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 07:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0FC73A8228
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 06:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E8E18B475;
	Fri,  7 Feb 2025 06:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LwCAw8S4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8143913B791
	for <bpf@vger.kernel.org>; Fri,  7 Feb 2025 06:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738908959; cv=none; b=STcVfmP97S9cGlxEDa0MmuDYM/CAAYg2chejr4OjD2/YFcwYGw8PTXT9qD2xGCSwsM0k3yG/LxwVVWmEp931xMCv27HDyL8Zun3WlXWALVe5PWVqPsvdExkFTLfCqTLNEt8KJ8PHcpOm70i4rDrKrzLECC/u82+G/U0kHG2Rt18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738908959; c=relaxed/simple;
	bh=zL0uFr5zuW1LbxTLRGhclxaqp0jHaXqVnQ8FzK29zzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jlbGrnF1v0IxPnf9qFyPrCLJH8GDYJewbYZtolM61yGgIMwyDnQL4wjJFxmpblAPqq8yftyYbJv/RFFaGr27Xum7SVFVcx/wqnwFZ2JcUyHoAe4CuUfbfNw54s/aen397b4pE3rUL1O7m0X04qEQ3aur9ag3IY3asmETwCG15Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LwCAw8S4; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3d13fe99d03so62295ab.0
        for <bpf@vger.kernel.org>; Thu, 06 Feb 2025 22:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738908955; x=1739513755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmT4YAJ/bMVgNv3L+lDdg4yrssrAeEO5RGqNN+S9m1Q=;
        b=LwCAw8S48UJoWZer8+iLpYLnZdTEl/9jL8eglkOyIBaz/4LMV77ooUuiOH7WWjdcqL
         dKYzgQVjRUOuBm8P432J6vXBZeKn/i1u8E6QJF7iblacczNtCgf88a1WpFOoNT+CPq+k
         zb9Jeethp40mVJudXbptqUuZ0A3GTvCk5Mx72r+7vx5CHrl3AZLL8A1KvJDaNkohuJ0w
         BO4/mXEP99/bSoTlK/MrC7d+4xs0+HQqLQD0q7LwBj+dPJu45rz3BygDD1hLYo1nQROh
         mRVCz8VPr56oqojYJMQ7Hr8a5goDbblppoD5cxdk/S/NTyQwr5FLYYSlFNQb8gGwTkuB
         o9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738908955; x=1739513755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PmT4YAJ/bMVgNv3L+lDdg4yrssrAeEO5RGqNN+S9m1Q=;
        b=cXv/lOSe8jShrJSRMPAztascEqHLlgSOHCpK9gjrTAxwDQr897S8m9SD5XO/NusbIb
         fPmbXvPBGymZXqrvc9/EAW0bDdZiacftnrsxlWd41e3LiJMdML+i+TTmwcHv2qhJyMqd
         8PsCD7dQ03SAW53HaM0peYYHst44R3EKpKgAGFgd3SjmXS8REY/u9xG541i6lAzvfIEc
         FUddm3iyH7zUV/CQT6usCxosx1ZMjBKKBbCqF30NKqelC6Q4I0MLqsDHmacD9pD8mLyB
         e+vrVP9+w/5TDUNgCGlGKBVnBnOjOhmmxNMM8KdojPnsCD0ytI4oK9lf3M8W1Gi43QXk
         v8ig==
X-Forwarded-Encrypted: i=1; AJvYcCVDQqDiKtVdrUbZR5WdswIHDVVp8wIwSSUtXXnDP6owWa3cGQ182F9bbYYq58scM5/LYwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz75K/lEelCXpY7CldPMKUxO6ukwpZssY2TObTq/MI48aFpa2XK
	HDxgOtrVZEz6p+mDm8Rzme0tWbwBEGZFZDsuy+iEsve09PJJgjMS5Z7y+BVhVLIM+XbCqxBwrj/
	KagxQ8+Lzy7dBHw/yLMKtNUWak1MBCOi1bKX3
X-Gm-Gg: ASbGncsAeg3rO9sO3Mo4Uw0343KqZTGjIg6/aZX9rw46O6FbjAGbrqWsaumirAt1MUH
	GGUKwwx3L82ikZ7iNTbHGf+SgY9HMa6VuH0nCpHLfzhn8KzDxdOVfqy6l17K1kAk3SJkaBJzrUg
	==
X-Google-Smtp-Source: AGHT+IF+wCm4E7tTq8Y1HQ78eRvqCBryQCd6UY10sEhy6TB5WXiDni0BwJKrZn/RYKRJFGSYm53sATxTEQyBVh99/24=
X-Received: by 2002:a92:ca09:0:b0:3a7:dea7:87a6 with SMTP id
 e9e14a558f8ab-3d13f25d537mr1413515ab.29.1738908955359; Thu, 06 Feb 2025
 22:15:55 -0800 (PST)
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
 <Z6WPmYCJcc6pPKDA@google.com>
In-Reply-To: <Z6WPmYCJcc6pPKDA@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 6 Feb 2025 22:15:43 -0800
X-Gm-Features: AWEUYZlep2lJ_fdPrUZD0QpJbnnI-471NkyNtX9_ZJAnqoEA_Ii0syWQ7AP9Uhs
Message-ID: <CAP-5=fU0263rZx+i_dpeBWVUiKHuNNp4ER7WhDe2zHPUsq=wmw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] perf parse-events: Reapply "Prefer sysfs/JSON
 hardware events over legacy"
To: Namhyung Kim <namhyung@kernel.org>
Cc: Atish Kumar Patra <atishp@rivosinc.com>, Peter Zijlstra <peterz@infradead.org>, 
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

On Thu, Feb 6, 2025 at 8:44=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
> On Wed, Feb 05, 2025 at 11:44:57PM -0800, Ian Rogers wrote:
> > Why was adding a PMU to an event name, working around ARM's PMU bug,
> > such an unsurmontable problem that the original change was reverted?
> > Because 1 person didn't want to have to write a PMU prefix and
> > considered it a monumental regression having to do so.
>
> Because it's a legacy event 'cycles' and he didn't expect the wildcard
> behavior?

And someone who say with perf v6.14 can type `perf stat -e data_read
...` and then with your proposal now has to type `perf stat -e
uncore_imc_free_running/data_read/ ...` because data_read isn't a core
event, this is expected behavior because the error message mentions
perf list?

> > > 1. RISC-V is working on a solution with the current status and it's n=
ot
> > >    absoluted needed to change the current behavior.
> >
> > They said to you directly it was what they wanted, that's why I
> > reposted this change and it is, has always been, in the cover letter.
> > They've then followed up expressing their desire for this behavior but
> > having to have a plan b as the original change was reverted and you
> > are blocking this change landing.
>
> So they have the plan B.  But still prefer overriding legacy with JSON?

Yes.

> > > 2. Apple-M is fixed already.
> >
> > No, James tried to repro the bug on a Juno board, not an Apple M, and
> > didn't succeed. I don't know what kernel he tried. I was told by Mark
> > Rutland (at LPC) that the tool fix was absolutely necessary and the
> > PMU driver wouldn't be fixed, hence the series flipping behavior that
> > I thought Intel would most likely block and wasn't keen to do in the
> > 1st place (not least wade through all the test behavior changes and
> > the bug tail). All of this was premised on a threat of reverting all
> > of the hybrid support so that Apple M could be made to work again, and
> > I was trying to do a less worse alternative.
> > https://lore.kernel.org/r/20231123042922.834425-1-irogers@google.com
>
> Sorry, it's not clear to me what's the problem exactly.  Can you give me
> an example command line?

What broke: when arm PMUs were recognized as core and not uncore PMUs,
as part of fixing hybrid, we encoded legacy events on them. So
arm_blah/cycles/ became a type 0 config 0 event, no extended type as
PMU support for that is tested first. A type 0 config 0 event is
broken on the Apple-M PMUs, an event that doesn't count or something
like that. Because they had a sysfs event of arm_blah/cycles/ before
the change the broken legacy encoding on the PMU was never used, the
legacy event broke things.

Because they had this problem the Apple-M users were used to using
arm_blah/cycles/ rather than cycles to avoid legacy events. This
change, not your proposal, is making it so that without a PMU they
also don't get legacy events because in no uncertain terms it was
expressed they weren't going to work. There was a lot of advocating
for removing all hybrid support from the tool.

> > I don't understand what you are trying to say. I'm saying the behavior
> > of perf list in its output is arbitrary. We use the same printing code
> > for every kind of event. An aesthetic decision to put things on a line
> > does not imply that it is more valid to use or not use a PMU, it just
> > happens to be what the tool does. Did I break perf list as if you look
> > in old perf list you see:
> > ```
> > $ perf list
> > List of pre-defined events (to be used in -e or -M):
> >
> >  duration_time                                      [Tool event]
> > ...
> > ```
> > while now you see:
> > ```
> > $ perf list
> > List of pre-defined events (to be used in -e or -M):
> > ...
> > tool:
> >  duration_time
> >       [Wall clock interval time in nanoseconds. Unit: tool]
> > ...
> > ```
> > I'm hoping people find it useful to have the unit documented.
>
> The most important information I think is the name of the event
> (duration_time).  It'd be appropriate if you could call it
> 'tool/duration_time/' but I'm not sure if it's acceptable cause
> tool events are not real PMU events.  If so, maybe
>
>  duration_time or tool/duration_time/
>
> ?

I don't mind showing a PMU and not showing a PMU. duration_time isn't
a core event, does it also get allowed no PMU prefix in your new
scheme? My point isn't to discuss duration_time it is to point out
that `perf list` output isn't sacred and says different things over
time. Those things may or may not include a PMU as there has never
been any rigor, it is a mush of strings that are printed.

In the perf list code we have an event and an alias. In my opinion if
something is an alias of something else then it implies having the
same perf_event_attr encoding. In your proposal this wouldn't be true
for legacy events as it isn't true today. Which has always been my
point about wanting to get this fixed.

> I think people should use a PMU prefix before wildcard is enabled.

I don't understand. You want to break uncore events without a PMU and
disable wild carding, then enable wildcarding again. Like I say I
think it is better you work on this behavior under a non `-e` command
line option.

> > > > What happens if an event is both in sysfs and json? Well the sysfs =
event
> > > > will get the description from the json and then I believe it won't
> > > > behave as you show. Did the event get broken, as perf list no longe=
r
> > > > shows it with a PMU, by having a json description written? I think =
not
> > > > and I think having descriptions with events is a good thing.
> > >
> > > That's bad.  Probably we should fix it takes only one of the sources =
and
> > > change the JSON event not to clash with sysfs.
> >
> > No, you are talking about breaking everything already, let's not break
> > it yet further - not least as we lack a reasonable way to test it. I
> > think if you are serious about having such breaking changes then it is
> > best you add a new command line option, like with libpfm events.
>
> I don't want to break things.  What's the intended behavior in that case?

The behavior is in pmu's update_event, but basically we prefer the
json data over the sysfs data:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/pmu.c?h=3Dperf-tools-next#n506
This allows the json/tool data to correct the sysfs data - as well as
to add information like descriptions and topic.
But my point isn't that I support your let's have two events instead
of updating events. I have maintained this behavior as it has always
been the behavior and I care about not breaking everything. Something
that I assumed was taken for granted hence making `perf top` behave in
a way where it is showing samples for processes that have terminated
by default.

Thanks,
Ian


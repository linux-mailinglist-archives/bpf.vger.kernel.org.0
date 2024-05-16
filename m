Return-Path: <bpf+bounces-29836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B018C70E8
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 06:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADB55B22DE6
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 04:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F8A249F7;
	Thu, 16 May 2024 04:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/3QOg6m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FF0C122;
	Thu, 16 May 2024 04:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715833487; cv=none; b=IK2OgI/JogpcoLLD/MhKMm5qyg7rsEhv64gIAODmKEErF0bOt0+iB05ZDJ7/ql5BxECNyR97XgnIsSne1spnnRLuUPFlTV9BYpKmAkhBYoxQcPjFHeAZSDqQeyMnNVBn3dL7N3U/tFpO3FLogW3NK1mGC824NaLr/vChgtk1UoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715833487; c=relaxed/simple;
	bh=Vw1rnovZ3kSZznO33mQPPLn+pu/qeWT1waEdoc60JJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FUFV64phgsHihHDIwcC9AOJNUok4iZ7F31l/3AxfU1VmUaCOjlQ9J4RxkzImSmqEq9OfzgVZbxgGB7aXqX4PdZX4lJSyvbNu0RY6FVB3r5AWmJMaDMVRdnc6OQLTWXuWzFBBepYXCbD7JM/sKkCZAxwnnRrdRnuOihauBdb+6eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/3QOg6m; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso7541445276.2;
        Wed, 15 May 2024 21:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715833485; x=1716438285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7sNtJiLBmDSHTmJWdKPMhgeGWXRuOt2VavSv0QaiwA=;
        b=W/3QOg6mSeyyHHJDpKrATnMmM9g2g5rVzikTVbER98QRvWuFuDX2RMpLmPg3vIllw5
         AZlgKD0CDuDrTOFjBMvzJCcOa37QR/P1T0jBUbjgKNCthcOnsA3ETH2QgM5X23Go/KrR
         +NGTQmSKbzb6k5ad19kjF4xbZR4hxcnD+PT3nCcSGJfgU37BRaEWBIbC6WTTjeG8MdlW
         Y949FxvlWPmfaE/hKYJE9002XrFfeVPkt8uk8LiMsccZruWwwZUi6lB5EId17S3mTqw/
         GGQOo3ue8ICyajFi0LzIcgszVvHiIAcxh4/SjltGLW2Bny06NqjuwuplJ487gYy5+6l9
         IrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715833485; x=1716438285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7sNtJiLBmDSHTmJWdKPMhgeGWXRuOt2VavSv0QaiwA=;
        b=B9qPzTY1+eQanaTjOpenZlkQV94Y1oKYbo7XsrGIebzy700jYZAupZQQWyyknSAwDJ
         l0e6D3drmfgN9/vo9ZfQnmdHt5XG+J7NGoriWEviMCQocKGvZ6mst2i3KdKUyXckSC/r
         TaBM3f2sMDAo1qhPFl93GmdFwVmFXXNat9W6MHTeDjdOcILLzdGt7cO5v6CcQdNGrDRU
         EeErs5H2pDKgJBMr322/8EazVLYOfuZD2c7YSnKnFFeWeEEsX1ZBDR+e2TxUokwie5ge
         Stmnd0c8BxzY2XbCEku4xv7GUdWsktUTyBKl52YDH8dHBn1v/zWfzUgp3U0sWndpdzA5
         0vOA==
X-Forwarded-Encrypted: i=1; AJvYcCUVp1jtDvsG1OXlG8dHt/5bwGF2XrVW8oZuE2Sb5Xf+RbQbg8VAkiNN6GIafOKzLwWbRChIDwtgaNZpP4c25d/J6PhJah0J5qo12HNQK3YaSaYLZfB5Ndz0oDIgF460alh4tO8qMBVpJ8sZFHT9gBS6XKysTBeYyR3ITUAf2SHkp6XK9A==
X-Gm-Message-State: AOJu0YygOSPU+6NkvdWevVfJcLYeG31S2AlQw/U0yqhumt0AxcxMa3ky
	KVL571/9WCw06D3e0IhuLZVdp5KV7aCoU9SzIXeHC+ohFQI5x9baSVCyZWSWqrUGzFvn9tIEhCr
	ltTbwqE6dJqFIbTlLA8mkyv7HaPk=
X-Google-Smtp-Source: AGHT+IFzkhsxlNQ+uTA5Rtn5ioJYT3eJlsWKyaqFJ12+u04LVzAqV6u6kHySl/fNEOCZQ9ZBfIHZBJtCHTBzk7zvPGQ=
X-Received: by 2002:a25:db54:0:b0:de6:12ce:abce with SMTP id
 3f1490d57ef6-dee4f314b11mr15918288276.43.1715833484676; Wed, 15 May 2024
 21:24:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424024805.144759-1-howardchu95@gmail.com>
 <CAM9d7chOdrPyeGk=O+7Hxzdm5ziBXLES8PLbpNJvA7_DMrrGHA@mail.gmail.com>
 <Zil1ZKc7mibs6ONQ@x1> <CAP-5=fVYHjUk8OyidXbutBvZMPxf48LW7v-N3zvHBe5QME1vVQ@mail.gmail.com>
 <CAM9d7cggak7qZcX7tFZvJ69H3cwEnWvNOnBsQrkFQkQVf+bUjQ@mail.gmail.com>
In-Reply-To: <CAM9d7cggak7qZcX7tFZvJ69H3cwEnWvNOnBsQrkFQkQVf+bUjQ@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 16 May 2024 12:24:35 +0800
Message-ID: <CAH0uvohPg7LtSOLDNaPwnC5ePwjwg0NtKzLZ_oJcAz7zOwdwdw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Dump off-cpu samples directly
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, peterz@infradead.org, 
	mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	zegao2021@gmail.com, leo.yan@linux.dev, ravi.bangoria@amd.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Here is a little update on --off-cpu.

> > It would be nice to start landing this work so I'm wondering what the
> > minimal way to do that is. It seems putting behavior behind a flag is
> > a first step.

The flag to determine output threshold of off-cpu has been implemented.
If the accumulated off-cpu time exceeds this threshold, output the sample
directly; otherwise, save it later for off_cpu_write.

But adding an extra pass to handle off-cpu samples introduces performance
issues, here's the processing rate of --off-cpu sampling(with the
extra pass to extract raw
sample data) and without. The --off-cpu-threshold is in nanoseconds.

+-----------------------------------------------------+--------------------=
-------------------+----------------------+
| comm                                                | type
                       | process rate         |
+-----------------------------------------------------+--------------------=
-------------------+----------------------+
| -F 4999 -a                                          | regular
samples (w/o extra pass)      | 13128.675 samples/ms |
+-----------------------------------------------------+--------------------=
-------------------+----------------------+
| -F 1 -a --off-cpu --off-cpu-threshold 100           | offcpu samples
(extra pass)           |  2843.247 samples/ms |
+-----------------------------------------------------+--------------------=
-------------------+----------------------+
| -F 4999 -a --off-cpu --off-cpu-threshold 100        | offcpu &
regular samples (extra pass) |  3910.686 samples/ms |
+-----------------------------------------------------+--------------------=
-------------------+----------------------+
| -F 4999 -a --off-cpu --off-cpu-threshold 1000000000 | few offcpu &
regular (extra pass)     |  4661.229 samples/ms |
+-----------------------------------------------------+--------------------=
-------------------+----------------------+

It's not ideal. I will find a way to reduce overhead. For example
process them samples
at save time as Ian mentioned.

> > To turn the bpf-output samples into off-cpu events there is a pass
> > added to the saving. I wonder if that can be more generic, like a save
> > time perf inject.

And I will find a default value for such a threshold based on performance
and common use cases.

> Sounds good.  We might add an option to specify the threshold to
> determine whether to dump the data or to save it for later.  But ideally
> it should be able to find a good default.

These will be done before the GSoC kick-off on May 27.

Thanks,
Howard

On Thu, Apr 25, 2024 at 6:57=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Apr 24, 2024 at 3:19=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Wed, Apr 24, 2024 at 2:11=E2=80=AFPM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Wed, Apr 24, 2024 at 12:12:26PM -0700, Namhyung Kim wrote:
> > > > Hello,
> > > >
> > > > On Tue, Apr 23, 2024 at 7:46=E2=80=AFPM Howard Chu <howardchu95@gma=
il.com> wrote:
> > > > >
> > > > > As mentioned in: https://bugzilla.kernel.org/show_bug.cgi?id=3D20=
7323
> > > > >
> > > > > Currently, off-cpu samples are dumped when perf record is exiting=
. This
> > > > > results in off-cpu samples being after the regular samples. Also,=
 samples
> > > > > are stored in large BPF maps which contain all the stack traces a=
nd
> > > > > accumulated off-cpu time, but they are eventually going to fill u=
p after
> > > > > running for an extensive period. This patch fixes those problems =
by dumping
> > > > > samples directly into perf ring buffer, and dispatching those sam=
ples to the
> > > > > correct format.
> > > >
> > > > Thanks for working on this.
> > > >
> > > > But the problem of dumping all sched-switch events is that it can b=
e
> > > > too frequent on loaded machines.  Copying many events to the buffer
> > > > can result in losing other records.  As perf report doesn't care ab=
out
> > > > timing much, I decided to aggregate the result in a BPF map and dum=
p
> > > > them at the end of the profiling session.
> > >
> > > Should we try to adapt when there are too many context switches, i.e.
> > > the BPF program can notice that the interval from the last context
> > > switch is too small and then avoid adding samples, while if the inter=
val
> > > is a long one then indeed this is a problem where the workload is
> > > waiting for a long time for something and we want to know what is tha=
t,
> > > and in that case capturing callchains is both desirable and not costl=
y,
> > > no?
>
> Sounds interesting.  Yeah we could make it adaptive based on the
> off-cpu time at the moment.
>
> > >
> > > The tool could then at the end produce one of two outputs: the most
> > > common reasons for being off cpu, or some sort of counter stating tha=
t
> > > there are way too many context switches?
> > >
> > > And perhaps we should think about what is best to have as a default, =
not
> > > to present just plain old cycles, but point out that the workload is
> > > most of the time waiting for IO, etc, i.e. the default should give
> > > interesting clues instead of expecting that the tool user knows all t=
he
> > > possible knobs and try them in all sorts of combinations to then reac=
h
> > > some conclusion.
> > >
> > > The default should use stuff that isn't that costly, thus not getting=
 in
> > > the way of what is being observed, but at the same time look for comm=
on
> > > patterns, etc.
> > >
> > > - Arnaldo
> >
> > I really appreciate Howard doing this work!
> >
> > I wonder there are other cases where we want to synthesize events in
> > BPF, for example, we may have fast and slow memory on a system, we
> > could turn memory events on a system into either fast or slow ones in
> > BPF based on the memory accessed, so that fast/slow memory systems can
> > be simulated without access to hardware. This also feels like a perf
> > script type problem. Perhaps we can add something to the bpf-output
> > event so it can have multiple uses and not just off-cpu.
> >
> >
> > I worry about dropping short samples we can create a property that
> > off-cpu time + on-cpu time !=3D wall clock time. Perhaps such short
> > things can get pushed into Namhyung's "at the end" approach while
> > longer things get samples. Perhaps we only do that when the frequency
> > is too great.
>
> Sounds good.  We might add an option to specify the threshold to
> determine whether to dump the data or to save it for later.  But ideally
> it should be able to find a good default.
>
> >

>
> Agreed!
>
> Thanks,
> Namhyung


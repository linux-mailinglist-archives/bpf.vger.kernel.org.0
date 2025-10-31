Return-Path: <bpf+bounces-73173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EEFC26162
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 17:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FAC75829E1
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 16:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696552F5A24;
	Fri, 31 Oct 2025 16:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hwb9f8FM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7AD2EC0BF
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926693; cv=none; b=CP0RjSkse/212tKh6fzNH31H5FgtDIa5DEYvsw1ntUGxbOk1N3wS3zDzwqo7P2A4B1/nlmYNcx7TOgEyBoJ8Fov3ZhI5Q8rj67ezTQDBG10MTWnNsnkOTLWBfa6rDL9vIQ/5r/p4+IIQpY8HA1rGXWMbWwUDZLb3hjS+BqSL+XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926693; c=relaxed/simple;
	bh=bKTxsXPniedvZveiJEwt7RUcC0psBlMO8tL7pHglkeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mPVJ+JVtR9YyfT3BSae8r+gYsdK6bC9Wpm5OR8AxtH76+4z/C2ezDuWE0mPDcfRvN5vgRbjHJ/G2VIvYnrh39pSVI66xI0r+0MCwTEVTkRL8p0MIcGf3XSn0ToCcMtyOhwugcUzzQIufeLFuxvvhHrsdjRfeAxn7VS8+9H0zb04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hwb9f8FM; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27d67abd215so262075ad.0
        for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 09:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761926690; x=1762531490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLVC4iHlDAqCvKvsojHxwUrg7mXLg1rTWMixQxC3wXw=;
        b=hwb9f8FMYbHo76pst2oDpPVbsGN9niKiF+VuUl7uniOk+7Dalt6ffnU29138wJ9jyv
         8w4EhqbGXrATGpbQMiWKdYOym0yoNkgYP6siiK9OqGlEL0Yo8xSX2QUYBT79z46GXCU4
         GqRsbpatnzEhdL7omIe5Gye9x8sjkvqHUyjypx1IgOw8NfaDe1UZnaHACL0UzsVmG5cd
         OWLL+nZPVOkns3vru+C6GD0BaLBUNKwyEhz8N3Q73dvFE/cbdVMH2aSm4iPhFnyhvRjY
         ll3axdIaMkWSZ4ICDOP2/sNetUuVjcfBVGXIRWOzDkw8m6idlZJDUkuv+fM64PxN3jFO
         tNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761926690; x=1762531490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLVC4iHlDAqCvKvsojHxwUrg7mXLg1rTWMixQxC3wXw=;
        b=fjEIVTMd7pRDmtz5t0SYt1uEE10qblzzQsik99T0+HN+jGU/O2RUNtUtCq7r/mbGQ2
         wPn6zKM3aWyJYF4K5Id3x6n0Qf3K9z4mnCmV9Khz0DbSSWAR91z3Npzog1gGw/i0Hutp
         Pm6qIObr9cg4bfpaAnpqcuAqJddAdiSLHJ5YFZqCRr9oSzaVuplcTdoBkuvc+n5Xm94F
         1lWSK1poqTMgCLADVh9EUInu+9yrc/OWoKzj4sdcF4Lv6ZfVdd4Yl9lWTeSfC9A/xtqb
         ZpT2v7SjUs0oP4hkqOpHZHfmy//HbdT97jh5l2wOKacser3KZ0X4ZGMGcicUyr/o5v4U
         0eig==
X-Forwarded-Encrypted: i=1; AJvYcCUo2py1ISA7kFlm4MQmnbngtPgSUA1ki/Yu7rU1YeMrih5Pt57H/751KnQPdffQoaobYk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqG1PfIEFSOxQwPgQKdfNctvtP23sdeZGam3+leK7EKdoOSLUG
	l06gYGBizY4b4sH7J5GQ8Hz4tUJCZbZ+Jj9bwPxn4tQAeoid8iTgkWaWcohioEXWfa5jo6fDEiw
	Whx/QuR+TSQWQaBwBIEertzqjGnloIIRpjhvSmEoJ
X-Gm-Gg: ASbGncvD7JgE3jIH5uA89+crX9OXVgOk3B6CnF4VcfC9CBol9mgmEoE614YOKWVZyd2
	pvqqecdRfLiZxWnvpQlnZTQnD+FuLSdjL/DG2zkzkFu7quJUGT+zmS0PsMVLAbWvO9gMtu7noFp
	E/nvfJXDT67T2xasTHpaUHe25Xb/poAe/03DIqa91Yy/7XeaMT/bstqSCCI2FLNGIaSGgJkJtfJ
	BYwf2Iqf0dPYiwjAfQ1w05bsYFMWjHq4+reFGn3OpentSbsgAWcoI/XotDC5sGDngNSRyCGwGDZ
	76NFrjbFd0+Er4k=
X-Google-Smtp-Source: AGHT+IEcB+8h5eOHGJ2YPKcye/aiEf9ENj87BXKVudOlNz+B6I519uQ0kYlL9DP9225qjguMeBiXUTLElwPTer24Mu0=
X-Received: by 2002:a17:902:e811:b0:290:d4dd:b042 with SMTP id
 d9443c01a7336-2951e77995amr5957285ad.16.1761926689972; Fri, 31 Oct 2025
 09:04:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023015043.38868-1-xueshuai@linux.alibaba.com>
 <CAP-5=fWupb62_QKM3bZO9K9yeJqC2H-bdi6dQNM7zAsLTJoDow@mail.gmail.com>
 <fc75b170-86c1-49b6-a321-7dca56ad824a@linux.alibaba.com> <eed27aaf-fd0a-4609-a30b-68e7c5c11890@linux.alibaba.com>
 <CAP-5=fVLGRsn7icH1cgmb==f5_D6Vr2CbzirAv7DY4Afjm4O2A@mail.gmail.com> <5a06462a-697d-47b6-b51e-6438005b6130@linux.alibaba.com>
In-Reply-To: <5a06462a-697d-47b6-b51e-6438005b6130@linux.alibaba.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 31 Oct 2025 09:04:38 -0700
X-Gm-Features: AWmQ_bkelkfpf4y93i1UE_icgV-ko7nWCsbmdO2_BgOqFLH2IQ2RjuUM-6Q_tIE
Message-ID: <CAP-5=fUvwokP=MYmS7kZqjCk+ZYs8A-9G+i3zt-zvjdZA6E_Jg@mail.gmail.com>
Subject: Re: [PATCH] perf record: skip synthesize event when open evsel failed
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: alexander.shishkin@linux.intel.com, peterz@infradead.org, 
	james.clark@arm.com, leo.yan@linaro.org, mingo@redhat.com, 
	baolin.wang@linux.alibaba.com, acme@kernel.org, mark.rutland@arm.com, 
	jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nathan@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 7:36=E2=80=AFPM Shuai Xue <xueshuai@linux.alibaba.c=
om> wrote:
>
> =E5=9C=A8 2025/10/31 01:32, Ian Rogers =E5=86=99=E9=81=93:
> > On Wed, Oct 29, 2025 at 5:55=E2=80=AFAM Shuai Xue <xueshuai@linux.aliba=
ba.com> wrote:
> >>
> >>
> >>
> >> =E5=9C=A8 2025/10/24 10:45, Shuai Xue =E5=86=99=E9=81=93:
> >>>
> >>>
> >>> =E5=9C=A8 2025/10/24 00:08, Ian Rogers =E5=86=99=E9=81=93:
> >>>> On Wed, Oct 22, 2025 at 6:50=E2=80=AFPM Shuai Xue <xueshuai@linux.al=
ibaba.com> wrote:
> >>>>>
> >>>>> When using perf record with the `--overwrite` option, a segmentatio=
n fault
> >>>>> occurs if an event fails to open. For example:
> >>>>>
> >>>>>     perf record -e cycles-ct -F 1000 -a --overwrite
> >>>>>     Error:
> >>>>>     cycles-ct:H: PMU Hardware doesn't support sampling/overflow-int=
errupts. Try 'perf stat'
> >>>>>     perf: Segmentation fault
> >>>>>         #0 0x6466b6 in dump_stack debug.c:366
> >>>>>         #1 0x646729 in sighandler_dump_stack debug.c:378
> >>>>>         #2 0x453fd1 in sigsegv_handler builtin-record.c:722
> >>>>>         #3 0x7f8454e65090 in __restore_rt libc-2.32.so[54090]
> >>>>>         #4 0x6c5671 in __perf_event__synthesize_id_index synthetic-=
events.c:1862
> >>>>>         #5 0x6c5ac0 in perf_event__synthesize_id_index synthetic-ev=
ents.c:1943
> >>>>>         #6 0x458090 in record__synthesize builtin-record.c:2075
> >>>>>         #7 0x45a85a in __cmd_record builtin-record.c:2888
> >>>>>         #8 0x45deb6 in cmd_record builtin-record.c:4374
> >>>>>         #9 0x4e5e33 in run_builtin perf.c:349
> >>>>>         #10 0x4e60bf in handle_internal_command perf.c:401
> >>>>>         #11 0x4e6215 in run_argv perf.c:448
> >>>>>         #12 0x4e653a in main perf.c:555
> >>>>>         #13 0x7f8454e4fa72 in __libc_start_main libc-2.32.so[3ea72]
> >>>>>         #14 0x43a3ee in _start ??:0
> >>>>>
> >>>>> The --overwrite option implies --tail-synthesize, which collects no=
n-sample
> >>>>> events reflecting the system status when recording finishes. Howeve=
r, when
> >>>>> evsel opening fails (e.g., unsupported event 'cycles-ct'), session-=
>evlist
> >>>>> is not initialized and remains NULL. The code unconditionally calls
> >>>>> record__synthesize() in the error path, which iterates through the =
NULL
> >>>>> evlist pointer and causes a segfault.
> >>>>>
> >>>>> To fix it, move the record__synthesize() call inside the error chec=
k block, so
> >>>>> it's only called when there was no error during recording, ensuring=
 that evlist
> >>>>> is properly initialized.
> >>>>>
> >>>>> Fixes: 4ea648aec019 ("perf record: Add --tail-synthesize option")
> >>>>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> >>>>
> >>>> This looks great! I wonder if we can add a test, perhaps here:
> >>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-=
next.git/tree/tools/perf/tests/shell/record.sh?h=3Dperf-tools-next#n435
> >>>> something like:
> >>>> ```
> >>>> $ perf record -e foobar -F 1000 -a --overwrite -o /dev/null -- sleep=
 0.1
> >>>> ```
> >>>> in a new test subsection for test_overwrite? foobar would be an even=
t
> >>>> that we could assume isn't present. Could you help with a test
> >>>> covering the problems you've uncovered and perhaps related flags?
> >>>>
> >>>
> >>> Hi, Ian,
> >>>
> >>> Good suggestion, I'd like to add a test. But foobar may not a good ca=
se.
> >>>
> >>> Regarding your example:
> >>>
> >>>     perf record -e foobar -a --overwrite -o /dev/null -- sleep 0.1
> >>>     event syntax error: 'foobar'
> >>>                          \___ Bad event name
> >>>
> >>>     Unable to find event on a PMU of 'foobar'
> >>>     Run 'perf list' for a list of valid events
> >>>
> >>>      Usage: perf record [<options>] [<command>]
> >>>         or: perf record [<options>] -- <command> [<options>]
> >>>
> >>>         -e, --event <event>   event selector. use 'perf list' to list=
 available events
> >>>
> >>>
> >>> The issue with using foobar is that it's an invalid event name, and t=
he
> >>> perf parser will reject it much earlier. This means the test would ex=
it
> >>> before reaching the part of the code path we want to verify (where
> >>> record__synthesize() could be called).
> >>>
> >>> A potential alternative could be testing an error case such as EACCES=
:
> >>>
> >>>     perf record -e cycles -C 0 --overwrite -o /dev/null -- sleep 0.1
> >>>
> >>> This could reproduce the scenario of a failure when attempting to acc=
ess
> >>> a valid event, such as due to permission restrictions. However, the
> >>> limitation here is that users may override
> >>> /proc/sys/kernel/perf_event_paranoid, which affects whether or not th=
is
> >>> test would succeed in triggering an EACCES error.
> >>>
> >>>
> >>> If you have any other suggestions or ideas for a better way to simula=
te
> >>> this situation, I'd love to hear them.
> >>>
> >>> Thanks.
> >>> Shuai
> >>
> >> Hi, Ian,
> >>
> >> Gentle ping.
> >
> > Sorry, for the delay. I was trying to think of a better way given the
> > problems you mention and then got distracted. I wonder if a legacy
> > event that core PMUs never implement would be a good candidate to
> > test. For example, the event "node-prefetch-misses" is for "Local
> > memory prefetch misses" but the memory controller tends to be a
> > separate PMU and this event is never implemented to my knowledge.
> > Running this locally I see:
> >
> > ```
> > $ perf record -e node-prefetch-misses -a --overwrite -o /dev/null -- sl=
eep 0.1
> > Lowering default frequency rate from 4000 to 1750.
> > Please consider tweaking /proc/sys/kernel/perf_event_max_sample_rate.
> > Error:
> > Failure to open event 'cpu_atom/node-prefetch-misses/' on PMU
> > 'cpu_atom' which will be removed.
> > No fallback found for 'cpu_atom/node-prefetch-misses/' for error 2
> > Error:
> > Failure to open event 'cpu_core/node-prefetch-misses/' on PMU
> > 'cpu_core' which will be removed.
> > No fallback found for 'cpu_core/node-prefetch-misses/' for error 2
> > Error:
> > Failure to open any events for recording.
> > perf: Segmentation fault
> >     #0 0x55a487ad8b87 in dump_stack debug.c:366
> >     #1 0x55a487ad8bfd in sighandler_dump_stack debug.c:378
> >     #2 0x55a4878c6f94 in sigsegv_handler builtin-record.c:722
> >     #3 0x7f72aae49df0 in __restore_rt libc_sigaction.c:0
> >     #4 0x55a487b57ef8 in __perf_event__synthesize_id_index
> > synthetic-events.c:1862
> >     #5 0x55a487b58346 in perf_event__synthesize_id_index synthetic-even=
ts.c:1943
> >     #6 0x55a4878cb2a3 in record__synthesize builtin-record.c:2150
> >     #7 0x55a4878cdada in __cmd_record builtin-record.c:2963
> >     #8 0x55a4878d11ca in cmd_record builtin-record.c:4453
> >     #9 0x55a48795b3cc in run_builtin perf.c:349
> >     #10 0x55a48795b664 in handle_internal_command perf.c:401
> >     #11 0x55a48795b7bd in run_argv perf.c:448
> >     #12 0x55a48795bb06 in main perf.c:555
> >     #13 0x7f72aae33ca8 in __libc_start_call_main libc_start_call_main.h=
:74
> >     #14 0x7f72aae33d65 in __libc_start_main_alias_2 libc-start.c:128
> >     #15 0x55a4878acf41 in _start perf[52f41]
> > Segmentation fault
> > ```
>
>
> Hi, Ian=EF=BC=8C
>
> Is node-prefetch-misses a platform specific event? Running it on ARM Yiti=
an 710
> and Intel SPR platform, I see:
>
> $sudo perf record -e node-prefetch-misses
> Error:
> The node-prefetch-misses event is not supported.

Hi Shuai,

So node-prefetch-misses is a legacy event. Perf has a notion of events
that are inbuilt to the kernel/PMU driver and get special fixed
encodings. That said, the PMU driver in the kernel can just fail to
support the events and I think that's uniformly the case for
node-prefetch-misses. As shown by my reproduction of the crash, which
I hope this suffices for a test - i.e. it is an event that parses but
one that is never supported.

Thanks,
Ian


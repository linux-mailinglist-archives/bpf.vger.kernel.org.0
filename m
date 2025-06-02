Return-Path: <bpf+bounces-59448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C64F4ACBAFE
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 20:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4EE2164B4F
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 18:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B3D229B18;
	Mon,  2 Jun 2025 18:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeC+kyPP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77849211C;
	Mon,  2 Jun 2025 18:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748888114; cv=none; b=Yi+spty4PgoAvlsW1KL91b8GJzZp4xPPEFoFaLmTHAiEorMTMaCEGDljk7fqh+KzyfWfaNygAaukAxlTy4XPwjmyZJ9YsJP6biRrqCv9BjxPure1X051qqTVX28J+GFojBIS/YFrMuaY4+9JsCgoMadGguPGJBDclWdkDWi0pxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748888114; c=relaxed/simple;
	bh=hedc1slK+9Lv61TDwSQNxLU1CfM474XSEdPMgVna/Ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tuh+AhYFyAvATucMPKzcpzF5KJbF6ihR0csT1Iwz5GVA+GLoOlUr5s12eyQRg3xbR3VTH0EY0gsKyPtWtfvjqQ6ZfdqgxAEbNEy9qTLUO/AQu3g/UcgmRDA4TgzxdrdEEM8/TrBylbxWJV3Jxf3s2pbWSlWv4uW5ohO428exjZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeC+kyPP; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-442f9043f56so28507635e9.0;
        Mon, 02 Jun 2025 11:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748888111; x=1749492911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mX/pCZ6QPtF7g93rpLdt86rmKoHi6yL8n3t0sLvtHpg=;
        b=DeC+kyPPIcVujpo05GyoYfXLyxu3sZzQTfiXD9D4SDPN8miMJVFKjbSt0VGFiHTdlk
         Re469aXMTNoDig86b313tc+z5yocOMQLYbtaHXL4B2NJvUlER9RII7LYhCA58GPDeEbs
         /14r1egkiMucq+i6fM3/UGhvw0KymPvhZmkiT+I0O1i0pQBblqQO6I3gmpO1HzXr3JdE
         UzJm3xvboZP7yeqKSbDuD5Dymne1Lx5RoPHoW+IvINy8OaNxD76vsQz0zMO55gOvx6Kq
         77CzB2sosacTIjInbo9mCqHfYdec1+nrrGnDpVSBgVvmbE3u+AEX4C6iKutJPE1Egr/K
         ETrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748888111; x=1749492911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mX/pCZ6QPtF7g93rpLdt86rmKoHi6yL8n3t0sLvtHpg=;
        b=sglPAajMXSRlcXYRTNdU9lLxTfgZlGGYNE4EWAG1eVuZQqk18YLWR4p1Og/+J5SLQ6
         SOEPLIk5xylKniJSIQphwb0wnnv4xvvB10ygMjXWT/HBau8amDrhN0hbvqGFnsF8Kk4j
         pYgVbN12iVuEqiPRU5ZFxMNk+cYxizqS6+P4PV22sNj3gYN/b5v72Z7+XDVIfTK8fGYx
         2q7cxDZeCJMUTBWePREj+0EQqsfmDQl/EQzPt0RXDd9iVe1+ygMYJ0sJTF0TH6vA8NCi
         kLtCqxj6N8zuKWpGGJkAN9Ware4lnsZ8Mh0Si+co44F6GVJ8HYWb5QjPnH4N4rwfbUF7
         ZfwA==
X-Forwarded-Encrypted: i=1; AJvYcCWt1Bql4mz88cgpWC7y1bLcslulHbVOtLTCKDzUfYOkGRvBHMWpZM4Haq001BsuUKhYHgc=@vger.kernel.org, AJvYcCX9ytnvTB8F/Nls5yC1cv+SeRd1WxnKpUhQ7hreWnVj1bhPU17WkrG3DktIC+79/uPQB/sxrPQh1dJP9tu1wEsXKg==@vger.kernel.org, AJvYcCXib3QOcgJQkbcnx1tOq0FQdN47FxgHRyX3gclyTm14769Q0sZn9eH7fz/KK7bbT4cfffRp27GkM1Dmv8Ut@vger.kernel.org
X-Gm-Message-State: AOJu0YxXWaYgeK6cYNMIKwiwUaI5HvL4mT8jY2s9mAx0DUrIQQiDvz3A
	ZhsoTl9wPE8Hd4Cv4yPofbFNhL+7iFT34oRsJ2D7NSsKJdp2GRiZ2fsnsX4bWVUIoFleAGzYIjl
	oAAT5rNcl5vXHlBHQdIFrw9+QXlA0rm0=
X-Gm-Gg: ASbGncvtV7OwwFBQHo+2fahwNqVZL2N3Umpg3UhCwybbZF8a2Ii9dtprdIRtEmRYDWi
	yVjknclWrugCyARE/sUVRlmJZfxNmyO1uv0XI8mvriMQHcVm+4YbhbmxIuqdqbLiBu7hmWYo9Oy
	ry9teTG56NV4mCuWoIz6GDcLUBPHo5LSId+pnc6XlmlvxSd5gN
X-Google-Smtp-Source: AGHT+IGpJYuInbfHGFM0Zs7ZYiwunfyj5vlSoTMHxj6LUcKavVkEz4WNHuG4znOYLPTBJU4BgCL66MJAHdk+hUyWB1w=
X-Received: by 2002:a05:6000:2dca:b0:3a4:e706:532b with SMTP id
 ffacd0b85a97d-3a4fe398f49mr6954997f8f.43.1748888110368; Mon, 02 Jun 2025
 11:15:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520181644.2673067-1-kan.liang@linux.intel.com>
 <20250520181644.2673067-2-kan.liang@linux.intel.com> <djxlh5fx326gcenwrr52ry3pk4wxmugu4jccdjysza7tlc5fef@ktp4rffawgcw>
 <d3c6b899-7281-4f97-a449-96f506181bab@linux.intel.com> <CAADnVQL_v4SscxVK5fLxKo5Z4+LJtVfpvrJ4+ztu-ecPfxwrhQ@mail.gmail.com>
 <fb64520f-3890-4cdf-9c12-73d6b8de584b@linux.intel.com>
In-Reply-To: <fb64520f-3890-4cdf-9c12-73d6b8de584b@linux.intel.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 2 Jun 2025 11:14:59 -0700
X-Gm-Features: AX0GCFtaVFimDMEvqxIFdbLFiBresthrljCeNVzlQTI2Dmecz-iAlJlh5ai8MYA
Message-ID: <CAADnVQ+h24Sez9iaa9DdwS9sWQ4m1LXeXQM7XMPKfZO7FmUtMg@mail.gmail.com>
Subject: Re: perf regression. Was: [PATCH V4 01/16] perf: Fix the throttle
 logic for a group
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Mark Rutland <mark.rutland@arm.com>, LKML <linux-kernel@vger.kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, Stephane Eranian <eranian@google.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, Leo Yan <leo.yan@arm.com>, 
	bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 10:51=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2025-06-02 12:24 p.m., Alexei Starovoitov wrote:
> > On Mon, Jun 2, 2025 at 5:55=E2=80=AFAM Liang, Kan <kan.liang@linux.inte=
l.com> wrote:
> >>
> >> Hi Alexei,
> >>
> >> On 2025-06-01 8:30 p.m., Alexei Starovoitov wrote:
> >>> On Tue, May 20, 2025 at 11:16:29AM -0700, kan.liang@linux.intel.com w=
rote:
> >>>> From: Kan Liang <kan.liang@linux.intel.com>
> >>>>
> >>>> The current throttle logic doesn't work well with a group, e.g., the
> >>>> following sampling-read case.
> >>>>
> >>>> $ perf record -e "{cycles,cycles}:S" ...
> >>>>
> >>>> $ perf report -D | grep THROTTLE | tail -2
> >>>>             THROTTLE events:        426  ( 9.0%)
> >>>>           UNTHROTTLE events:        425  ( 9.0%)
> >>>>
> >>>> $ perf report -D | grep PERF_RECORD_SAMPLE -a4 | tail -n 5
> >>>> 0 1020120874009167 0x74970 [0x68]: PERF_RECORD_SAMPLE(IP, 0x1):
> >>>> ... sample_read:
> >>>> .... group nr 2
> >>>> ..... id 0000000000000327, value 000000000cbb993a, lost 0
> >>>> ..... id 0000000000000328, value 00000002211c26df, lost 0
> >>>>
> >>>> The second cycles event has a much larger value than the first cycle=
s
> >>>> event in the same group.
> >>>>
> >>>> The current throttle logic in the generic code only logs the THROTTL=
E
> >>>> event. It relies on the specific driver implementation to disable
> >>>> events. For all ARCHs, the implementation is similar. Only the event=
 is
> >>>> disabled, rather than the group.
> >>>>
> >>>> The logic to disable the group should be generic for all ARCHs. Add =
the
> >>>> logic in the generic code. The following patch will remove the buggy
> >>>> driver-specific implementation.
> >>>>
> >>>> The throttle only happens when an event is overflowed. Stop the enti=
re
> >>>> group when any event in the group triggers the throttle.
> >>>> The MAX_INTERRUPTS is set to all throttle events.
> >>>>
> >>>> The unthrottled could happen in 3 places.
> >>>> - event/group sched. All events in the group are scheduled one by on=
e.
> >>>>   All of them will be unthrottled eventually. Nothing needs to be
> >>>>   changed.
> >>>> - The perf_adjust_freq_unthr_events for each tick. Needs to restart =
the
> >>>>   group altogether.
> >>>> - The __perf_event_period(). The whole group needs to be restarted
> >>>>   altogether as well.
> >>>>
> >>>> With the fix,
> >>>> $ sudo perf report -D | grep PERF_RECORD_SAMPLE -a4 | tail -n 5
> >>>> 0 3573470770332 0x12f5f8 [0x70]: PERF_RECORD_SAMPLE(IP, 0x2):
> >>>> ... sample_read:
> >>>> .... group nr 2
> >>>> ..... id 0000000000000a28, value 00000004fd3dfd8f, lost 0
> >>>> ..... id 0000000000000a29, value 00000004fd3dfd8f, lost 0
> >>>>
> >>>> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> >>>> ---
> >>>>  kernel/events/core.c | 66 ++++++++++++++++++++++++++++++-----------=
---
> >>>>  1 file changed, 46 insertions(+), 20 deletions(-)
> >>>
> >>> This patch breaks perf hw events somehow.
> >>>
> >>> After merging this into bpf trees we see random "watchdog: BUG: soft =
lockup"
> >>> with various stack traces followed up:
> >>> [   78.620749] Sending NMI from CPU 8 to CPUs 0:
> >>> [   76.387722] NMI backtrace for cpu 0
> >>> [   76.387722] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G       =
    O L      6.15.0-10818-ge0f0ee1c31de #1163 PREEMPT
> >>> [   76.387722] Tainted: [O]=3DOOT_MODULE, [L]=3DSOFTLOCKUP
> >>> [   76.387722] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),=
 BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> >>> [   76.387722] RIP: 0010:_raw_spin_lock_irqsave+0xc/0x40
> >>> [   76.387722] Call Trace:
> >>> [   76.387722]  <IRQ>
> >>> [   76.387722]  hrtimer_try_to_cancel.part.0+0x24/0xe0
> >>> [   76.387722]  hrtimer_cancel+0x21/0x40
> >>> [   76.387722]  cpu_clock_event_stop+0x64/0x70
> >>
> >>
> >> The issues should be fixed by the patch.
> >> https://lore.kernel.org/lkml/20250528175832.2999139-1-kan.liang@linux.=
intel.com/
> >>
> >> Could you please give it a try?
> >
> > Thanks. It fixes it, but the commit log says that
> > only cpu-clock and task_clock are affected,
> > which are SW events.
>
> Yes, only the two SW events are affected.
>
> >
> > While our tests are locking while setting up:
> >
> >         struct perf_event_attr attr =3D {
> >                 .freq =3D 1,
> >                 .type =3D PERF_TYPE_HARDWARE,
> >                 .config =3D PERF_COUNT_HW_CPU_CYCLES,
> >         };
> >
> > Is it because we run in x86 VM and HW_CPU_CYCLES is mapped
> > to cpu-clock sw ?
>
> No, that's from different PMU. We never map HW_CPU_CYCLES to a SW event.
> It will error our if the PMU is not available.
>
> I'm not familiar with your test case and env. At least, I saw
> PERF_COUNT_SW_CPU_CLOCK is used in the case unpriv_bpf_disabled.

I see. The first test was necessary to create throttle conditions
for the 2nd test that actually used cpu-clock.

Feel free to add
Tested-by: Alexei Starovoitov <ast@kernel.org>

I've applied your patch to bpf tree for now to stop the bleeding.
Will drop it when the fix gets to Linus through perf trees.


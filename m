Return-Path: <bpf+bounces-59441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF249ACB99E
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 18:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42DA0189AC72
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 16:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB97224B0D;
	Mon,  2 Jun 2025 16:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAMEls5B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4001DDC37;
	Mon,  2 Jun 2025 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748881476; cv=none; b=CgdRCg9QuXuogQa/2skNBw1GIBEs+irAIG59YzHRsH+EQN9vLZI/Li2DCJ6mI9ywaAVqaQpzcoPCJHBtiGVNOFOgG3PPEK/EKrf3inPYli/fl9U8UrYIupJnDRLCOaGktUw0r/djIMDqKkHvEEXWyIfCjRuRXd2+DjG0Jgisb2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748881476; c=relaxed/simple;
	bh=VTBB6S6T9CYtENIK9amegBgyMcLfyoBbf6sQJw/Vg2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a00ya5w2G2L/73bQes1y7f1/WZlbmTNlfZoljtYmPXnvUydTxoGclmh63FpxwpRalWW1VuNTwelXuV0P1ljFMO9OhbHDsSMWFkgG6ftO7qKh4H/5bkkYaylMZ/x+ZjgZtzZSSC4Q3rmTI3BUIwKuExkvsVqPi7Rlj1V4/GjNlhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAMEls5B; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a36e090102so2655176f8f.2;
        Mon, 02 Jun 2025 09:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748881473; x=1749486273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Hf4awDBXsGRvLnA3GnF3C2CVs5TAWdo9HF9pPM5WH0=;
        b=iAMEls5BcOFW+9R/xNC8uG3epiHllwuc1QFs4hb92Z2fu+RvdrCGjQYAzWYt65a7jf
         vmrwd9HEzC1VjX9wXm/WZSUS3GahCzHw1Puk54EuAcdvID9bq0QTs6maL8q84GQKkCk+
         xujrpx/SbgXndBM24yP3E27Mxk1OAX37rMly4NZhVbLnT/28lIfEDCKu4TNBCx9axjMl
         HihccNGlRGHDMk5pJ3u8q3Vj/tkIvW8hCbBNJZOhQS5InBNyEV25eBWw+SzO9yXgTyzD
         Ojh/RGNEP1dD28tgWyZzy1uyba9z6mCAfiP4SyZhMiafshzn643RDfL+oyFWcMlPI/J1
         c/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748881473; x=1749486273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Hf4awDBXsGRvLnA3GnF3C2CVs5TAWdo9HF9pPM5WH0=;
        b=VAfF13Ctu5f50qOvJGqwkxv7LP0VzBJH4V5ztEXSYfTInsP+RJTMZ4zTk7+yauLZyW
         i1FAgUvNmqhIuakkKfgv4U8vvMqH9jBv2PSpwkdGsJB+b5OP9ekMQLXECInUxTmrJ+nn
         eIFQ9aLa/KV3y4TklQaB8A/vLnV/WNQqzoJZ9GUt5NbtXUGPhGqpwikmPNSLhnbxV3sh
         00/Du6/eR+V/QQGYXCLoHpcpQcPJAOhZcecZWqW9uLj36aE2Oj/f3OWDjeP9n0zcCJF2
         mqHauWmgUrMgndSsEGJqXlCMOMqaoNBwFOrnVhgRTnGAxG91FUiffbPI2IRRm31KqNfQ
         PlzA==
X-Forwarded-Encrypted: i=1; AJvYcCUBpr5x3b05QzhyNOObmTAKHohiCeAq0xP8Y4tDLOoEyxqwRkjZr/ow4v0Z5hpC4iLeqqUL2Yk4RyJprF/0@vger.kernel.org, AJvYcCUWscuJVtheGYFt2PwGepczslaa9YimGIECkQuoZOH8kpOmuE9k17AKLFUmKWfm00XPnDU=@vger.kernel.org, AJvYcCWkBC1y9GMWUQaM7m0bO6xCjgyl+3fYWQwEAouTQ+5b7Ctzl3BeN40fbtlsiSZ1iySKlxXXHMApr2LZSVxbvRzEiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YydtUVB9Y91dRxmbS+fN0Vq6SnIweAimL/WnQ2o+qoTKQXyC5Wx
	6ZCn3MmPECnrKl6JW3Kj4l2P6t4yD+rNcNLh6N+QtDV5pIlznLXIGeLDA09GVBervY8rlO35iSg
	jrA8Z3i23Lc6esSsfd8qlQ8WlbhtzHAD+Xrwl
X-Gm-Gg: ASbGnctA5mXAWzhp5LBrRamvoVBzkE/TAZFkenZE0/DeuyvAulmzWvscltnkd+LL1DA
	HgD8bu2o0nzD4Nf31VdwwehIfVZYPLSCF9Lp8i23QdwbQwaGtH9LwvPGtgBY1u9SQbxFLRpZdpN
	pP+LDSLWSLAkDdHZ6D1FDbAKkjAmQCZ/PjM7Dvsq7gLwA+zvSK
X-Google-Smtp-Source: AGHT+IHe08an4JNIFcJK4cpXI820F+nqTybaZjc6XNMNs55Ubnp7qLnvs85PIfG9HSe2TO0FnW/ObkqflH7Ctk5oroA=
X-Received: by 2002:a05:6000:1447:b0:3a4:d41d:8f40 with SMTP id
 ffacd0b85a97d-3a4f7a6d2bcmr10499625f8f.46.1748881472942; Mon, 02 Jun 2025
 09:24:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520181644.2673067-1-kan.liang@linux.intel.com>
 <20250520181644.2673067-2-kan.liang@linux.intel.com> <djxlh5fx326gcenwrr52ry3pk4wxmugu4jccdjysza7tlc5fef@ktp4rffawgcw>
 <d3c6b899-7281-4f97-a449-96f506181bab@linux.intel.com>
In-Reply-To: <d3c6b899-7281-4f97-a449-96f506181bab@linux.intel.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 2 Jun 2025 09:24:21 -0700
X-Gm-Features: AX0GCFvADJbbPaSyYnAXh1Shx0VxwiPeDyPR931crj8K5fpdnLUXNqnq89qaelw
Message-ID: <CAADnVQL_v4SscxVK5fLxKo5Z4+LJtVfpvrJ4+ztu-ecPfxwrhQ@mail.gmail.com>
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

On Mon, Jun 2, 2025 at 5:55=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
>
> Hi Alexei,
>
> On 2025-06-01 8:30 p.m., Alexei Starovoitov wrote:
> > On Tue, May 20, 2025 at 11:16:29AM -0700, kan.liang@linux.intel.com wro=
te:
> >> From: Kan Liang <kan.liang@linux.intel.com>
> >>
> >> The current throttle logic doesn't work well with a group, e.g., the
> >> following sampling-read case.
> >>
> >> $ perf record -e "{cycles,cycles}:S" ...
> >>
> >> $ perf report -D | grep THROTTLE | tail -2
> >>             THROTTLE events:        426  ( 9.0%)
> >>           UNTHROTTLE events:        425  ( 9.0%)
> >>
> >> $ perf report -D | grep PERF_RECORD_SAMPLE -a4 | tail -n 5
> >> 0 1020120874009167 0x74970 [0x68]: PERF_RECORD_SAMPLE(IP, 0x1):
> >> ... sample_read:
> >> .... group nr 2
> >> ..... id 0000000000000327, value 000000000cbb993a, lost 0
> >> ..... id 0000000000000328, value 00000002211c26df, lost 0
> >>
> >> The second cycles event has a much larger value than the first cycles
> >> event in the same group.
> >>
> >> The current throttle logic in the generic code only logs the THROTTLE
> >> event. It relies on the specific driver implementation to disable
> >> events. For all ARCHs, the implementation is similar. Only the event i=
s
> >> disabled, rather than the group.
> >>
> >> The logic to disable the group should be generic for all ARCHs. Add th=
e
> >> logic in the generic code. The following patch will remove the buggy
> >> driver-specific implementation.
> >>
> >> The throttle only happens when an event is overflowed. Stop the entire
> >> group when any event in the group triggers the throttle.
> >> The MAX_INTERRUPTS is set to all throttle events.
> >>
> >> The unthrottled could happen in 3 places.
> >> - event/group sched. All events in the group are scheduled one by one.
> >>   All of them will be unthrottled eventually. Nothing needs to be
> >>   changed.
> >> - The perf_adjust_freq_unthr_events for each tick. Needs to restart th=
e
> >>   group altogether.
> >> - The __perf_event_period(). The whole group needs to be restarted
> >>   altogether as well.
> >>
> >> With the fix,
> >> $ sudo perf report -D | grep PERF_RECORD_SAMPLE -a4 | tail -n 5
> >> 0 3573470770332 0x12f5f8 [0x70]: PERF_RECORD_SAMPLE(IP, 0x2):
> >> ... sample_read:
> >> .... group nr 2
> >> ..... id 0000000000000a28, value 00000004fd3dfd8f, lost 0
> >> ..... id 0000000000000a29, value 00000004fd3dfd8f, lost 0
> >>
> >> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> >> ---
> >>  kernel/events/core.c | 66 ++++++++++++++++++++++++++++++-------------=
-
> >>  1 file changed, 46 insertions(+), 20 deletions(-)
> >
> > This patch breaks perf hw events somehow.
> >
> > After merging this into bpf trees we see random "watchdog: BUG: soft lo=
ckup"
> > with various stack traces followed up:
> > [   78.620749] Sending NMI from CPU 8 to CPUs 0:
> > [   76.387722] NMI backtrace for cpu 0
> > [   76.387722] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G         =
  O L      6.15.0-10818-ge0f0ee1c31de #1163 PREEMPT
> > [   76.387722] Tainted: [O]=3DOOT_MODULE, [L]=3DSOFTLOCKUP
> > [   76.387722] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> > [   76.387722] RIP: 0010:_raw_spin_lock_irqsave+0xc/0x40
> > [   76.387722] Call Trace:
> > [   76.387722]  <IRQ>
> > [   76.387722]  hrtimer_try_to_cancel.part.0+0x24/0xe0
> > [   76.387722]  hrtimer_cancel+0x21/0x40
> > [   76.387722]  cpu_clock_event_stop+0x64/0x70
>
>
> The issues should be fixed by the patch.
> https://lore.kernel.org/lkml/20250528175832.2999139-1-kan.liang@linux.int=
el.com/
>
> Could you please give it a try?

Thanks. It fixes it, but the commit log says that
only cpu-clock and task_clock are affected,
which are SW events.

While our tests are locking while setting up:

        struct perf_event_attr attr =3D {
                .freq =3D 1,
                .type =3D PERF_TYPE_HARDWARE,
                .config =3D PERF_COUNT_HW_CPU_CYCLES,
        };

Is it because we run in x86 VM and HW_CPU_CYCLES is mapped
to cpu-clock sw ?


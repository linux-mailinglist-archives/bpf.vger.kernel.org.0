Return-Path: <bpf+bounces-39670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEEC975D97
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 01:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D15CD1F23E93
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 23:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5E51AE87C;
	Wed, 11 Sep 2024 23:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmzsuzHv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5232F30;
	Wed, 11 Sep 2024 23:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726096147; cv=none; b=ZndmM5Rf5BSMBf1HEHorso2H48IxUi4mBP2MsjhaBTsec1+RwDmYApbruQEehHWJ/Is4vlehWDxFEoodp9zAF4s4Ki2k/6KacWMlcRB2XaEAmdIRumc+nJuGDT5U2X3rZFATtwK9ek0HBw9V8atrpssvav8iTJPzYWToaufN7gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726096147; c=relaxed/simple;
	bh=p24kuALb+FG8YQuEcIZoujnRVAslQjvHFviywETxW1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=An4lYzambqO+xi8lgNK3zvaLbU0l2AOja/D9cfJtKHABMZaArDaNdTCK5ah5vQXQTghemGddw3N/McI66M0WfuIOTVP/vEymGkXgfUeI0PHfr02U6cBWmaks9m+N25M55a9Yw73LMFbWYKD/nGX8uwqvWw7gIhvF+5MI0DOZ9b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmzsuzHv; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d877e9054eso242031a91.3;
        Wed, 11 Sep 2024 16:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726096145; x=1726700945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+MlP7oJ5M6c/yucbQWoK+I4lVCxaQaoagzwBt4NfHEY=;
        b=EmzsuzHvFNEKxEgH01Ww49RVwsdA7g4FYnFGStgE4uLOoe9mtEQw9DrpIvRQ97fLdz
         2EhFguaUMXIj2W5w/UPk1w/mUx+WP4HsSGaAX8pRqrKKfd5Wna5Y9BO26CThFIRoHRuJ
         37NzQHK5kD5C9g/aqOQBtb6PxGOe6NW54KViqsnT1KSaKPxdq4aJJv3H5WrVHdop41JZ
         xIrDgxs9gaA4WKderSScrEawERrS0q4/BfAO3t+h1ztoLHtp24tn3AXSjmNig+t4gl3P
         cEmglk08hxRnCOc0iEli8JFYiMaPjIQx1LdlA7OPw/TB41BbtYThcmCj4dT57Q823yrE
         AEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726096145; x=1726700945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+MlP7oJ5M6c/yucbQWoK+I4lVCxaQaoagzwBt4NfHEY=;
        b=dyzERZtg4EWUV5WZpQATWzgEaFBN5Z7o0g/Jj0gUPFG8wnPhXR9nbcAvzEhkD5+VT6
         j3xrWW2Bvb7WQJO5zSUWvVTyouimQD1biq926DP66b+I1qpgC8GRUaqCBOGADBksYrIS
         yKtzWRu6f0Iifi8XP+/POZu0SzfXk9/h3RVLnkYNRrznHcNo5QJ2l9y2P4ojEw08N8O2
         THdW++qyhlAktBsooAOO99tcEPy2L5474Gy/+I/hLGupWNUJSjh/uRCjOogHmF+SuKvS
         uzK+6ucWfcqrSv25T4ekOfTiMjwuQn3yH1dRH2g8NicPoCcELEbODNsBdo+RjjNgT9Kt
         57kg==
X-Forwarded-Encrypted: i=1; AJvYcCVAhjd/VVQ2FkenMZA2Vli5njCu1EvKhdBucxFr7zQqwkEWrAaFZGyCvReepidOArNImuPFZnxV4jcAR8N0JSnF6BBb@vger.kernel.org, AJvYcCVZb+Mw2tgOfxkwf8wDM15ergkgNFAmcsHZofMSuGzQ7vqXwNI7W8sT5V4dZFulu3BUm6SMpdnVH3bpjw/X@vger.kernel.org, AJvYcCWdtcBP0/NLT8IeXdO8LmpVAGk+ZutbFPDhnDuO28tMYcQOFSjbhkdM4sQ8BTaTLgjfhDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YywNvn+QaK/xRf5kRSDEz40emW5Revd120lxPrXovvhn2afzAyb
	DGaX8VdQrquMpwQ+guG5+ouagiSFkC5KJLoFagS2J3QlCM1YqGe3olWYs4MRFzlXeWGzPtSSG4J
	eWM8Iyj0QN1gZv5XSAQmAK5Z+G7Q=
X-Google-Smtp-Source: AGHT+IErDGlO3QfmC/bCljTP5Yl+jxppb6u5ajt/5AHexXT74blBUjsTtAiIp3upUCN4ne53tTyObwraG52RmAp5L/s=
X-Received: by 2002:a17:90a:a78e:b0:2d8:a350:683a with SMTP id
 98e67ed59e1d1-2db9ffb49e9mr882459a91.19.1726096145515; Wed, 11 Sep 2024
 16:09:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909201652.319406-1-mathieu.desnoyers@efficios.com>
 <CAEf4BzaOh6+G3qkPjW7HYkMBhys+=WU=d3cErnm8ykTt2W3y5g@mail.gmail.com> <d294fc4c-45c1-49ec-98e3-5b42b7ab3b4b@efficios.com>
In-Reply-To: <d294fc4c-45c1-49ec-98e3-5b42b7ab3b4b@efficios.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Sep 2024 16:08:53 -0700
Message-ID: <CAEf4BzZrN3moj2_JCGcc5z+LQeWUvGtx1e3J4c7tQtJyQE=3PA@mail.gmail.com>
Subject: Re: [PATCH 0/8] tracing: Allow system call tracepoints to handle page faults
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 5:36=E2=80=AFPM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2024-09-09 19:53, Andrii Nakryiko wrote:
> > On Mon, Sep 9, 2024 at 1:17=E2=80=AFPM Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> >>
> >> Wire up the system call tracepoints with Tasks Trace RCU to allow
> >> the ftrace, perf, and eBPF tracers to handle page faults.
> >>
> >> This series does the initial wire-up allowing tracers to handle page
> >> faults, but leaves out the actual handling of said page faults as futu=
re
> >> work.
> >>
> >> This series was compile and runtime tested with ftrace and perf syscal=
l
> >> tracing and raw syscall tracing, adding a WARN_ON_ONCE() in the
> >> generated code to validate that the intended probes are used for raw
> >> syscall tracing. The might_fault() added within those probes validate
> >> that they are called from a context where handling a page fault is OK.
> >>
> >> For ebpf, this series is compile-tested only.
> >
> > What tree/branch was this based on? I can't apply it cleanly anywhere I=
 tried...
>
> This series was based on tag v6.10.6
>

Didn't find 6.10.6, but it applied cleanly to 6.10.3. I tested that
BPF parts work:

Tested-by: Andrii Nakryiko <andrii@kernel.org> # BPF parts

> Sorry I should have included this information in patch 0.
>
> Thanks,
>
> Mathieu
>
> >
> >>
> >> This series replaces the "Faultable Tracepoints v6" series found at [1=
].
> >>
> >> Thanks,
> >>
> >> Mathieu
> >>
> >> Link: https://lore.kernel.org/lkml/20240828144153.829582-1-mathieu.des=
noyers@efficios.com/ # [1]
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Cc: Alexei Starovoitov <ast@kernel.org>
> >> Cc: Yonghong Song <yhs@fb.com>
> >> Cc: Paul E. McKenney <paulmck@kernel.org>
> >> Cc: Ingo Molnar <mingo@redhat.com>
> >> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> >> Cc: Namhyung Kim <namhyung@kernel.org>
> >> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> >> Cc: bpf@vger.kernel.org
> >> Cc: Joel Fernandes <joel@joelfernandes.org>
> >> Cc: linux-trace-kernel@vger.kernel.org
> >>
> >> Mathieu Desnoyers (8):
> >>    tracing: Declare system call tracepoints with TRACE_EVENT_SYSCALL
> >>    tracing/ftrace: guard syscall probe with preempt_notrace
> >>    tracing/perf: guard syscall probe with preempt_notrace
> >>    tracing/bpf: guard syscall probe with preempt_notrace
> >>    tracing: Allow system call tracepoints to handle page faults
> >>    tracing/ftrace: Add might_fault check to syscall probes
> >>    tracing/perf: Add might_fault check to syscall probes
> >>    tracing/bpf: Add might_fault check to syscall probes
> >>
> >>   include/linux/tracepoint.h      | 87 +++++++++++++++++++++++++------=
--
> >>   include/trace/bpf_probe.h       | 13 +++++
> >>   include/trace/define_trace.h    |  5 ++
> >>   include/trace/events/syscalls.h |  4 +-
> >>   include/trace/perf.h            | 43 ++++++++++++++--
> >>   include/trace/trace_events.h    | 61 +++++++++++++++++++++--
> >>   init/Kconfig                    |  1 +
> >>   kernel/entry/common.c           |  4 +-
> >>   kernel/trace/trace_syscalls.c   | 36 ++++++++++++--
> >>   9 files changed, 218 insertions(+), 36 deletions(-)
> >>
> >> --
> >> 2.39.2
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
>


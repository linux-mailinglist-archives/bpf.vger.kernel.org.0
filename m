Return-Path: <bpf+bounces-39385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E509725F1
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 01:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70EBF1F20C16
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 23:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1851F18F2E8;
	Mon,  9 Sep 2024 23:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVzaPSNm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E704E210EC;
	Mon,  9 Sep 2024 23:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725926032; cv=none; b=WeU4BfA7ByMdg5syKRQ/uNSWBAvkrZ5TZKQVqONVV9U8k87kuBx+MZh7gnKly6JMPp4KFNqsDrR2hwQtDtq/o6BK+VR0ArmlKGCoZnVbH8xbrkyPoCN9/g4lxGKB4piA1prv7sxvjvpyFHoJClo0+tt1TM1jrrUNBjfmJQRUQ2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725926032; c=relaxed/simple;
	bh=L+ek0A1OGVp1oYN1ZH/Q/1LDDgscX7DdrYv1BLXqeKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hFPg1nMyoNnDykNxik3z5zJRHgvqH2+wVV7Q5PonOg5o71NdTtF7qWXU/weEaLfjN9MF2RYz1ewkAcNhqv0JxjB+H1OtCvjaDWq7VCMVCabG6Uf5/FadNPt0NGC0HQrQqWPKnpAimB71ayHobC/CAQ8dlRSyQmS5NMRqzZXjVYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVzaPSNm; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d889207d1aso3418040a91.3;
        Mon, 09 Sep 2024 16:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725926027; x=1726530827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5K5RcEf3k2OEiR6pRFXjpmCMTG8fO8xMCj1mjNM55uE=;
        b=AVzaPSNmpU175J3U1+QXHDgJuwlgjQywns4H4iCR737iW4i2jYt2WBZzc6qW++qEKP
         u+gYUropStvYS3f9KYSNLScta39r4R2iO3msfvDLGaMwpI5XG2HXxiNw+XCH1j8Gop3L
         /g9SpXSxtdYuzppcTvtv/hV5A/5wydMp6OGlnbB4YTWCBy/088C+cHV+L20mabjwUZcl
         +SkHmCKGgv54a56dLCqcG7bAoXigLmzgfbYkTZNajK8yhz+4AQr32uxyIJic8U9cfQ1E
         YwelH9UY/mrlgITxMvid0FGyBXrWgYCUEeYb2vdedz6J5+dmtLgVBqUIiy17meRu3OEP
         6iyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725926027; x=1726530827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5K5RcEf3k2OEiR6pRFXjpmCMTG8fO8xMCj1mjNM55uE=;
        b=kV96xrvSLeHzsV8FgepByxtOF6W9yIokPoJXH/WQUxw8fuh0kyLwrg3WlCQpBVysdL
         7dGIgVTaaXvhugfmpuYRfbrYGxTie9JXg+bxe+OQplzvQ12bCZuF3mV4+46BeOSsbo2a
         iJ9Wu+qeoTq+BhE+1IMqo/ShtPFYs9A7fzPBQEF3tKZAkXcXay70KwVFtcoElmIZJWNA
         Txnu60+6sC0M0piHBUTZFz1BdCoxFfeWk89stnuMayjf5TYtYfzBtxEfwDMLo4e0kDxT
         7BwpKhGjsu+7V+1SaMZonC4hwNTThIeDrpVyHraGdrS4BAmMpHhIkgGIAxyS5MRo4RCj
         ufSA==
X-Forwarded-Encrypted: i=1; AJvYcCW2c8yKYHO7FMQ4eblhyrWd2/gzhO9EjMDtPNxsZeID+NYrU0tCv0O1wNf0fex4j9hGPRfM9Uw3QrZVXffe@vger.kernel.org, AJvYcCXBpxuolVQdG79PVaFB0Io/ahbknA+nWhsuJ2/bCeJL3I3kvfZQLQU+uFHOTpIVsyBO96UNiqpBj3TdGJV483fxYKEA@vger.kernel.org, AJvYcCXr3XAsoEQ7E+OwxfmwRHg4ApZJYo6moMmQwwDgmS4qIJgH9chEAgErbBGdxFGyePlhQhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpgoZIbu/P8LEY4bMQuS/8gfstNtSGnFPNNhdX4Z3zRGvr9qUf
	hHKIiq/lsdLc+ZqBEm3afIHaCU4/OYIR339/NrEpLWS/4zQo2+bhys254p2y/JB36t4/d9C9zN0
	sh3CKj8fRyFGSheU7+N6IOSRpd24=
X-Google-Smtp-Source: AGHT+IFhiFHEFkJooCujGpp80nM61QY7wIUU77zVsYj1xcxgD4jYZCI0eKkGpw72714pmMDNLFt/IEvkrLKdYriTRxM=
X-Received: by 2002:a17:90b:1b4b:b0:2c8:64a:5f77 with SMTP id
 98e67ed59e1d1-2dad5196e14mr12777850a91.37.1725926027080; Mon, 09 Sep 2024
 16:53:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909201652.319406-1-mathieu.desnoyers@efficios.com>
In-Reply-To: <20240909201652.319406-1-mathieu.desnoyers@efficios.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 9 Sep 2024 16:53:34 -0700
Message-ID: <CAEf4BzaOh6+G3qkPjW7HYkMBhys+=WU=d3cErnm8ykTt2W3y5g@mail.gmail.com>
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

On Mon, Sep 9, 2024 at 1:17=E2=80=AFPM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Wire up the system call tracepoints with Tasks Trace RCU to allow
> the ftrace, perf, and eBPF tracers to handle page faults.
>
> This series does the initial wire-up allowing tracers to handle page
> faults, but leaves out the actual handling of said page faults as future
> work.
>
> This series was compile and runtime tested with ftrace and perf syscall
> tracing and raw syscall tracing, adding a WARN_ON_ONCE() in the
> generated code to validate that the intended probes are used for raw
> syscall tracing. The might_fault() added within those probes validate
> that they are called from a context where handling a page fault is OK.
>
> For ebpf, this series is compile-tested only.

What tree/branch was this based on? I can't apply it cleanly anywhere I tri=
ed...

>
> This series replaces the "Faultable Tracepoints v6" series found at [1].
>
> Thanks,
>
> Mathieu
>
> Link: https://lore.kernel.org/lkml/20240828144153.829582-1-mathieu.desnoy=
ers@efficios.com/ # [1]
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: bpf@vger.kernel.org
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: linux-trace-kernel@vger.kernel.org
>
> Mathieu Desnoyers (8):
>   tracing: Declare system call tracepoints with TRACE_EVENT_SYSCALL
>   tracing/ftrace: guard syscall probe with preempt_notrace
>   tracing/perf: guard syscall probe with preempt_notrace
>   tracing/bpf: guard syscall probe with preempt_notrace
>   tracing: Allow system call tracepoints to handle page faults
>   tracing/ftrace: Add might_fault check to syscall probes
>   tracing/perf: Add might_fault check to syscall probes
>   tracing/bpf: Add might_fault check to syscall probes
>
>  include/linux/tracepoint.h      | 87 +++++++++++++++++++++++++--------
>  include/trace/bpf_probe.h       | 13 +++++
>  include/trace/define_trace.h    |  5 ++
>  include/trace/events/syscalls.h |  4 +-
>  include/trace/perf.h            | 43 ++++++++++++++--
>  include/trace/trace_events.h    | 61 +++++++++++++++++++++--
>  init/Kconfig                    |  1 +
>  kernel/entry/common.c           |  4 +-
>  kernel/trace/trace_syscalls.c   | 36 ++++++++++++--
>  9 files changed, 218 insertions(+), 36 deletions(-)
>
> --
> 2.39.2


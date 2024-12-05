Return-Path: <bpf+bounces-46172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BA39E5E35
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 19:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD3051883F58
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 18:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB2A227BAB;
	Thu,  5 Dec 2024 18:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGGfBYP5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C08221461;
	Thu,  5 Dec 2024 18:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733423037; cv=none; b=W7iX+118kWBaU3GaGJgXjQZDATSMIMolzWk5gkKhBDuHTLf05ZWRIMYrlm0FRwyDVR9oJrnBQ2jbdG0fDG4YkR2km1kFKw/Q4gqjOt/hCFfEupcTs4MS87j1C+uR3pNWlqbbfAEbspmXQwiS0PLXzzQa2Y2moY5pI6o0CnWVczw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733423037; c=relaxed/simple;
	bh=7MIvOXpQRwWgNGJBKXXgJfGLLuz2ziCk05E11zLyLBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrv8I46QoPl3EdhCEiFbW6uZwbXTVYUMaX/DYEBNt9rNe8muHsJBomKcSBm2D1KpqDgIlPUiaUowfiESge4aJCiscGaCigBUvbYiq3EzIPqYTnHwm29hp8DJtVla+50tVLac6Sa9QtxrI1nqxmWDEwljO1GmrLMPTaUrCuwavoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGGfBYP5; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7fd21e4aa2eso324271a12.2;
        Thu, 05 Dec 2024 10:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733423034; x=1734027834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6vYqS8Uyw6PERcNHV3WQMwZ3bQaTaY3sWZxipW8AOs=;
        b=TGGfBYP5XfX8+1k2/Dr4qCUPxFwSyPE135RbvnWci8NIz1vfDVMb3qC1stw6SE8X2x
         F9KwuxJMu3dCxDg+GvecYHhpQfrXGMpUyuvVR5McDeGR75viYHA9ABq0JVu7u1Avwwkz
         jBBDfITOD2E2kDDvKwan4X5AeCIT/AvnnEiqlvmk8NWmco6BYGCykLNUMjew3rb1y/Y5
         yHminiU4I5ct/j3FCaVpeBdsT3tgMyuLnWq0PprZdDikI90ldkYbDNHnxYt3NE2Yi7Uq
         GIpSuWO0g2rFY3N0XavuLp2hMrb/lgIGua7IiiykR7bDp+v3ObzXYfFwWoTfXvslP4J3
         EjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733423034; x=1734027834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6vYqS8Uyw6PERcNHV3WQMwZ3bQaTaY3sWZxipW8AOs=;
        b=ZH+cRIgU5LdaLrJlEIivSPBZ3Km1mT10nmHCs4Cj6DtKRzzjXu6W7pKbHIc1bGH1KH
         tG0TjaIhCvncMF5Se9TE94+u4+qaycQ5nxKvtutSSB74I3BjUIPuWaWmNkO0ylhuO7Tq
         wVBVZ0MyTLepzTry363oNuS6KZMNHMiptCmJXWofwtWUGXH2Y0byMCPTFMzUv66Pe7j/
         0lQz2K8VbL2qxim9ydVkK/FFV5rK/tZvvPwDIXZOaJLx1Iy8Ma7DwRsvJKKzUiaCFuMv
         oSrnot6hMXdL6PSvGVu87AM75lA/IL/HssOEwEcDcoJCU6Jyw1ES4vCyBoU1L7DOmqE7
         JoSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNn53yWwQVwkzj4NSHLi9hOdHQNJUjdfJdbmMz+7yviFaOgXBZEM+LdtlupLDfOdYsGoGuE3pRDJUZyj5IAy+nq5AV@vger.kernel.org, AJvYcCV9Akgat/pMTCmq5ppiEc0vur7HyGDpE7nV7DyW7Yq0n8hRvzvpC4pyvqGfgmXK/+qLXUc=@vger.kernel.org, AJvYcCWAqgPLI1J1Orgn1dGAHtpO6gMKYDILF834iKW5tbQsQaTyCU5eXV85ZV/K4UHGWWuofifSAHNAD6S4dso2@vger.kernel.org, AJvYcCWwPYnY/PU6JWm7SDxv2R/FtKUUyngykjY+tEnTPREjWbWVZLA8Tyfqo9eXx1Rcv4P5aVEBVG0S8Ltkl+I8ZVCljg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXdQLYfJoJ75Flao2sBQs8qVbNgCOL7xuDOBbhvAnO0lZEiH4S
	61xOBJvR7kqcPjyJ+apNrmURJDkka2Yt+wPn/XqSsZ42xZZrcyqOM47FTgQgM25vN9xYeGaKhoi
	DZfn9Kr2z8mlXTGwyKAxzxMBhBV4=
X-Gm-Gg: ASbGncttcis3LjJljm9AEBfABXWUGcnx8BPpr77xgdiOEjoKKRhTShk7bubf9+G/VHn
	RT6PdOJ/zG9OYU9ojXNkLoy2W6VKoCLd8F66McLo0UwmmZTA=
X-Google-Smtp-Source: AGHT+IG02vwYnNGUnRdTtdLBBLBjtBWHIEK/29fwZCfadVa3BPrhggnUUP4hwsu2IUQT6N/MVYql0aoQrx3C2F9Pu5o=
X-Received: by 2002:a17:90b:520b:b0:2ee:b6c5:1def with SMTP id
 98e67ed59e1d1-2ef6955f713mr269512a91.8.1733423034015; Thu, 05 Dec 2024
 10:23:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022073141.3291245-1-liaochang1@huawei.com> <CAEf4BzY-0Eu27jyT_s2kRO1UuUPOkE9_SRrBOqu2gJfmxsv+3A@mail.gmail.com>
In-Reply-To: <CAEf4BzY-0Eu27jyT_s2kRO1UuUPOkE9_SRrBOqu2gJfmxsv+3A@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Dec 2024 10:23:42 -0800
Message-ID: <CAEf4BzaRzHFs-gyC5FGsbh4EX4=-QP4_i7A5ts++-J0JPaOb1g@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] uprobes: Improve scalability by reducing the
 contention on siglock
To: Liao Chang <liaochang1@huawei.com>
Cc: mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 6:07=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Oct 22, 2024 at 12:42=E2=80=AFAM Liao Chang <liaochang1@huawei.co=
m> wrote:
> >
> > The profiling result of BPF selftest on ARM64 platform reveals the
> > significant contention on the current->sighand->siglock is the
> > scalability bottleneck. The reason is also very straightforward that al=
l
> > producer threads of benchmark have to contend the spinlock mentioned to
> > resume the TIF_SIGPENDING bit in thread_info that might be removed in
> > uprobe_deny_signal().
> >
> > The contention on current->sighand->siglock is unnecessary, this series
> > remove them thoroughly. I've use the script developed by Andrii in [1]
> > to run benchmark. The CPU used was Kunpeng916 (Hi1616), 4 NUMA nodes,
> > 64 cores@2.4GHz running the kernel on next tree + the optimization in
> > [2] for get_xol_insn_slot().
> >
> > before-opt
> > ----------
> > uprobe-nop      ( 1 cpus):    0.907 =C2=B1 0.003M/s  (  0.907M/s/cpu)
> > uprobe-nop      ( 2 cpus):    1.676 =C2=B1 0.008M/s  (  0.838M/s/cpu)
> > uprobe-nop      ( 4 cpus):    3.210 =C2=B1 0.003M/s  (  0.802M/s/cpu)
> > uprobe-nop      ( 8 cpus):    4.457 =C2=B1 0.003M/s  (  0.557M/s/cpu)
> > uprobe-nop      (16 cpus):    3.724 =C2=B1 0.011M/s  (  0.233M/s/cpu)
> > uprobe-nop      (32 cpus):    2.761 =C2=B1 0.003M/s  (  0.086M/s/cpu)
> > uprobe-nop      (64 cpus):    1.293 =C2=B1 0.015M/s  (  0.020M/s/cpu)
> >
> > uprobe-push     ( 1 cpus):    0.883 =C2=B1 0.001M/s  (  0.883M/s/cpu)
> > uprobe-push     ( 2 cpus):    1.642 =C2=B1 0.005M/s  (  0.821M/s/cpu)
> > uprobe-push     ( 4 cpus):    3.086 =C2=B1 0.002M/s  (  0.771M/s/cpu)
> > uprobe-push     ( 8 cpus):    3.390 =C2=B1 0.003M/s  (  0.424M/s/cpu)
> > uprobe-push     (16 cpus):    2.652 =C2=B1 0.005M/s  (  0.166M/s/cpu)
> > uprobe-push     (32 cpus):    2.713 =C2=B1 0.005M/s  (  0.085M/s/cpu)
> > uprobe-push     (64 cpus):    1.313 =C2=B1 0.009M/s  (  0.021M/s/cpu)
> >
> > uprobe-ret      ( 1 cpus):    1.774 =C2=B1 0.000M/s  (  1.774M/s/cpu)
> > uprobe-ret      ( 2 cpus):    3.350 =C2=B1 0.001M/s  (  1.675M/s/cpu)
> > uprobe-ret      ( 4 cpus):    6.604 =C2=B1 0.000M/s  (  1.651M/s/cpu)
> > uprobe-ret      ( 8 cpus):    6.706 =C2=B1 0.005M/s  (  0.838M/s/cpu)
> > uprobe-ret      (16 cpus):    5.231 =C2=B1 0.001M/s  (  0.327M/s/cpu)
> > uprobe-ret      (32 cpus):    5.743 =C2=B1 0.003M/s  (  0.179M/s/cpu)
> > uprobe-ret      (64 cpus):    4.726 =C2=B1 0.016M/s  (  0.074M/s/cpu)
> >
> > after-opt
> > ---------
> > uprobe-nop      ( 1 cpus):    0.985 =C2=B1 0.002M/s  (  0.985M/s/cpu)
> > uprobe-nop      ( 2 cpus):    1.773 =C2=B1 0.005M/s  (  0.887M/s/cpu)
> > uprobe-nop      ( 4 cpus):    3.304 =C2=B1 0.001M/s  (  0.826M/s/cpu)
> > uprobe-nop      ( 8 cpus):    5.328 =C2=B1 0.002M/s  (  0.666M/s/cpu)
> > uprobe-nop      (16 cpus):    6.475 =C2=B1 0.002M/s  (  0.405M/s/cpu)
> > uprobe-nop      (32 cpus):    4.831 =C2=B1 0.082M/s  (  0.151M/s/cpu)
> > uprobe-nop      (64 cpus):    2.564 =C2=B1 0.053M/s  (  0.040M/s/cpu)
> >
> > uprobe-push     ( 1 cpus):    0.964 =C2=B1 0.001M/s  (  0.964M/s/cpu)
> > uprobe-push     ( 2 cpus):    1.766 =C2=B1 0.002M/s  (  0.883M/s/cpu)
> > uprobe-push     ( 4 cpus):    3.290 =C2=B1 0.009M/s  (  0.823M/s/cpu)
> > uprobe-push     ( 8 cpus):    4.670 =C2=B1 0.002M/s  (  0.584M/s/cpu)
> > uprobe-push     (16 cpus):    5.197 =C2=B1 0.004M/s  (  0.325M/s/cpu)
> > uprobe-push     (32 cpus):    5.068 =C2=B1 0.161M/s  (  0.158M/s/cpu)
> > uprobe-push     (64 cpus):    2.605 =C2=B1 0.026M/s  (  0.041M/s/cpu)
> >
> > uprobe-ret      ( 1 cpus):    1.833 =C2=B1 0.001M/s  (  1.833M/s/cpu)
> > uprobe-ret      ( 2 cpus):    3.384 =C2=B1 0.003M/s  (  1.692M/s/cpu)
> > uprobe-ret      ( 4 cpus):    6.677 =C2=B1 0.004M/s  (  1.669M/s/cpu)
> > uprobe-ret      ( 8 cpus):    6.854 =C2=B1 0.005M/s  (  0.857M/s/cpu)
> > uprobe-ret      (16 cpus):    6.508 =C2=B1 0.006M/s  (  0.407M/s/cpu)
> > uprobe-ret      (32 cpus):    5.793 =C2=B1 0.009M/s  (  0.181M/s/cpu)
> > uprobe-ret      (64 cpus):    4.743 =C2=B1 0.016M/s  (  0.074M/s/cpu)
> >
> > Above benchmark results demonstrates a obivious improvement in the
> > scalability of trig-uprobe-nop and trig-uprobe-push, the peak throughpu=
t
> > of which are from 4.5M/s to 6.4M/s and 3.3M/s to 5.1M/s individually.
> >
> > v4->v3:
> > 1. Rebase v3 [3] to the lateset tip/perf/core.
> > 2. Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 3. Acked-by: Oleg Nesterov <oleg@redhat.com>
> >
> > v3->v2:
> > Renaming the flag in [2/2], s/deny_signal/signal_denied/g.
> >
> > v2->v1:
> > Oleg pointed out the _DENY_SIGNAL will be replaced by _ACK upon the
> > completion of singlestep which leads to handle_singlestep() has no
> > chance to restore the removed TIF_SIGPENDING [3] and some case in
> > question. So this revision proposes to use a flag in uprobe_task to
> > track the denied TIF_SIGPENDING instead of new UPROBE_SSTEP state.
> >
> > [1] https://lore.kernel.org/all/20240731214256.3588718-1-andrii@kernel.=
org
> > [2] https://lore.kernel.org/all/20240727094405.1362496-1-liaochang1@hua=
wei.com
> > [3] https://lore.kernel.org/all/20240815014629.2685155-1-liaochang1@hua=
wei.com/
> >
> > Liao Chang (2):
> >   uprobes: Remove redundant spinlock in uprobe_deny_signal()
> >   uprobes: Remove the spinlock within handle_singlestep()
> >
> >  include/linux/uprobes.h |  1 +
> >  kernel/events/uprobes.c | 10 +++++-----
> >  2 files changed, 6 insertions(+), 5 deletions(-)
> >
> > --
> > 2.34.1
> >
>
> This patch set has been ready for a long while, can we please apply it
> to perf/core as well? Thank you!

Liao,

This patch set doesn't apply cleanly to perf/core anymore, can you
please rebase one more time and resend? Thanks!


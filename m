Return-Path: <bpf+bounces-27857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 897278B29E0
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 22:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4BD2287782
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 20:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9225A0EA;
	Thu, 25 Apr 2024 20:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkK0T2sV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3475A2E642;
	Thu, 25 Apr 2024 20:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714077128; cv=none; b=FsXdfQILLG6vUSYf7srJB0DNcXzxPMSkcMkQ4Ske9fGPm8yvuLaZyn51jz0ZNhr0RkfublvwYoG2Ngv1d7u4wUyzlkz0ALdaMXWhRLgmz67EVJVuO8+l+ejxm9xRnsXnBR2K70+FYBfyLWKM3uE2XOlnylCofxcS6lAxLBmDcNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714077128; c=relaxed/simple;
	bh=hS/jArw8vMu09B6tBaWl8LvJP6mCxjtob00NxtV0vHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X74vC2Ga9g/EoLtP1lKK4PNyxRO0SftYw6TXt95LWGTcs/jTxOjuR0GGXtxZ+D9eD/uQSqFRxBAembhEy7ohXaPWvaM+0emp8oVS7xl94CHQU8MKZb+M6BEl58q+cIr8DvO0luSydqkM/py6H1wGgs3y2r1uXLK3PsVhkwEgbns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkK0T2sV; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ab791bce6fso1055592a91.1;
        Thu, 25 Apr 2024 13:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714077126; x=1714681926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ecCYdsRfAq9F7QiyokWt4NqIBEh3jL8fX+LDwEHR2g=;
        b=nkK0T2sVtEffXdEurJ8MlDzjXufMGtGtTbQHDqzlQ9QMQ4wHvNh2AWNwJem0XybCrD
         KatGeue954tdU7UcM96hsq+DMcVkQfp6ufP1qk2pCi7jMXxH552op1auQZJXp/YbKylL
         LbmVIBDQGptl8pblp0CrU05uHUS6lJBZ5LLG9b5HdsW48/McxZiUkd9IISCI3u6ctFEb
         OUV1v1V2HUjrL8MJeqLQ2poqd5UNfnpDyP+8qrYpAxuF3fc8dvyax5SVTB2Jwx8renMG
         3WsELoDbeUaPT51qGDJ9NMZE3xIx0pRcP1lcM8xhmDJSKj5DvD6+lRAKQsgkp5lVtYPb
         pwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714077126; x=1714681926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ecCYdsRfAq9F7QiyokWt4NqIBEh3jL8fX+LDwEHR2g=;
        b=SYhQARmlFhNaod1IaZc0I8Mbz3qm1WO8mHSbqJ874yhT8VeL7K7PWdk4pMXV0F5Rqz
         7jcvqHg3fc4nyimkSXwvGueuI1kGMSj4g+LT43NhXBdtJ9Otr/yRgHs++7724wC1c8SW
         PqiXl4pPhocBR21XcNMDeWEEQoqc5nihrMj99W8CWF+LNjjsIKyIAddivga/RbZOg6ZI
         2ObwKJaZjyjJ3SbP6VE6l94N/w6ZwkWv4YSIh4k/8bSmtCWi1tkfUaFo0kU+Ue/ZoZcR
         Ha25LTYHUkbskD0FZ2UvrdQsJHWHG5x8che0CVDmwbyVTQ8m1Gb4VwVhNouqo+b0rmal
         0brg==
X-Forwarded-Encrypted: i=1; AJvYcCWMKCgf2UU0vOFbKWmP91icc/vKr+hiPYVmotD1+AHksZeLLw9ox4Q0CB0z90FgMGXauEohj/VeSO7bLPdIVbgixrmTP9W4+WZ9TYHCTVlQLe3yKDMiKTF1iGj6SATPisycBVAKu5urwDdeL+4sRW6iw6FtDq0v64Z8VKxlV7iWeXAasqCa
X-Gm-Message-State: AOJu0YwTFD6UFZ8v2XhsDdv1XlMxRJYSy25vJv32/otLfYSwoSUYp9PC
	26huiCuxCRgj7ZJiiQkDgGj1c+sdvuUVPGBSX6Wzya0OrrA/0k9cuA01drdNqoKjJ6D1PGFdAeJ
	O9925XRm+VEGNL5ux8QaZcpyxq1E=
X-Google-Smtp-Source: AGHT+IH/LWFyAEfI/t2wcLsabsOk6rYcAK7fNyj6a+L8dH+sRryfqyZaprCZU27xKJ5ThMZfHpqQC31TIbuC8Rb11Uw=
X-Received: by 2002:a17:90a:e2cd:b0:2ac:8198:848b with SMTP id
 fr13-20020a17090ae2cd00b002ac8198848bmr827513pjb.18.1714077126413; Thu, 25
 Apr 2024 13:32:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171318533841.254850.15841395205784342850.stgit@devnote2>
In-Reply-To: <171318533841.254850.15841395205784342850.stgit@devnote2>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Apr 2024 13:31:53 -0700
Message-ID: <CAEf4BzYMToveELxsOJ9dXz3H-9omhxRLKgGK-ppYvmK8pgDsfA@mail.gmail.com>
Subject: Re: [PATCH v9 00/36] tracing: fprobe: function_graph: Multi-function
 graph and fprobe on fgraph
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Florent Revest <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, 
	Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alan Maguire <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 5:49=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> Hi,
>
> Here is the 9th version of the series to re-implement the fprobe on
> function-graph tracer. The previous version is;
>
> https://lore.kernel.org/all/170887410337.564249.6360118840946697039.stgit=
@devnote2/
>
> This version is ported on the latest kernel (v6.9-rc3 + probes/for-next)
> and fixed some bugs + performance optimization patch[36/36].
>  - [12/36] Fix to clear fgraph_array entry in registration failure, also
>            return -ENOSPC when fgraph_array is full.
>  - [28/36] Add new store_fprobe_entry_data() for fprobe.
>  - [31/36] Remove DIV_ROUND_UP() and fix entry data address calculation.
>  - [36/36] Add new flag to skip timestamp recording.
>
> Overview
> --------
> This series does major 2 changes, enable multiple function-graphs on
> the ftrace (e.g. allow function-graph on sub instances) and rewrite the
> fprobe on this function-graph.
>
> The former changes had been sent from Steven Rostedt 4 years ago (*),
> which allows users to set different setting function-graph tracer (and
> other tracers based on function-graph) in each trace-instances at the
> same time.
>
> (*) https://lore.kernel.org/all/20190525031633.811342628@goodmis.org/
>
> The purpose of latter change are;
>
>  1) Remove dependency of the rethook from fprobe so that we can reduce
>    the return hook code and shadow stack.
>
>  2) Make 'ftrace_regs' the common trace interface for the function
>    boundary.
>
> 1) Currently we have 2(or 3) different function return hook codes,
>  the function-graph tracer and rethook (and legacy kretprobe).
>  But since this  is redundant and needs double maintenance cost,
>  I would like to unify those. From the user's viewpoint, function-
>  graph tracer is very useful to grasp the execution path. For this
>  purpose, it is hard to use the rethook in the function-graph
>  tracer, but the opposite is possible. (Strictly speaking, kretprobe
>  can not use it because it requires 'pt_regs' for historical reasons.)
>
> 2) Now the fprobe provides the 'pt_regs' for its handler, but that is
>  wrong for the function entry and exit. Moreover, depending on the
>  architecture, there is no way to accurately reproduce 'pt_regs'
>  outside of interrupt or exception handlers. This means fprobe should
>  not use 'pt_regs' because it does not use such exceptions.
>  (Conversely, kprobe should use 'pt_regs' because it is an abstract
>   interface of the software breakpoint exception.)
>
> This series changes fprobe to use function-graph tracer for tracing
> function entry and exit, instead of mixture of ftrace and rethook.
> Unlike the rethook which is a per-task list of system-wide allocated
> nodes, the function graph's ret_stack is a per-task shadow stack.
> Thus it does not need to set 'nr_maxactive' (which is the number of
> pre-allocated nodes).
> Also the handlers will get the 'ftrace_regs' instead of 'pt_regs'.
> Since eBPF mulit_kprobe/multi_kretprobe events still use 'pt_regs' as
> their register interface, this changes it to convert 'ftrace_regs' to
> 'pt_regs'. Of course this conversion makes an incomplete 'pt_regs',
> so users must access only registers for function parameters or
> return value.
>
> Design
> ------
> Instead of using ftrace's function entry hook directly, the new fprobe
> is built on top of the function-graph's entry and return callbacks
> with 'ftrace_regs'.
>
> Since the fprobe requires access to 'ftrace_regs', the architecture
> must support CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS and
> CONFIG_HAVE_FTRACE_GRAPH_FUNC, which enables to call function-graph
> entry callback with 'ftrace_regs', and also
> CONFIG_HAVE_FUNCTION_GRAPH_FREGS, which passes the ftrace_regs to
> return_to_handler.
>
> All fprobes share a single function-graph ops (means shares a common
> ftrace filter) similar to the kprobe-on-ftrace. This needs another
> layer to find corresponding fprobe in the common function-graph
> callbacks, but has much better scalability, since the number of
> registered function-graph ops is limited.
>
> In the entry callback, the fprobe runs its entry_handler and saves the
> address of 'fprobe' on the function-graph's shadow stack as data. The
> return callback decodes the data to get the 'fprobe' address, and runs
> the exit_handler.
>
> The fprobe introduces two hash-tables, one is for entry callback which
> searches fprobes related to the given function address passed by entry
> callback. The other is for a return callback which checks if the given
> 'fprobe' data structure pointer is still valid. Note that it is
> possible to unregister fprobe before the return callback runs. Thus
> the address validation must be done before using it in the return
> callback.
>
> This series can be applied against the probes/for-next branch, which
> is based on v6.9-rc3.
>
> This series can also be found below branch.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/log/?h=
=3Dtopic/fprobe-on-fgraph
>
> Thank you,
>
> ---

Hey Masami,

I can't really review most of that code as I'm completely unfamiliar
with all those inner workings of fprobe/ftrace/function_graph. I left
a few comments where there were somewhat more obvious BPF-related
pieces.

But I also did run our BPF benchmarks on probes/for-next as a baseline
and then with your series applied on top. Just to see if there are any
regressions. I think it will be a useful data point for you.

You should be already familiar with the bench tool we have in BPF
selftests (I used it on some other patches for your tree).

BASELINE
=3D=3D=3D=3D=3D=3D=3D=3D
kprobe         :   24.634 =C2=B1 0.205M/s
kprobe-multi   :   28.898 =C2=B1 0.531M/s
kretprobe      :   10.478 =C2=B1 0.015M/s
kretprobe-multi:   11.012 =C2=B1 0.063M/s

THIS PATCH SET ON TOP
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
kprobe         :   25.144 =C2=B1 0.027M/s (+2%)
kprobe-multi   :   28.909 =C2=B1 0.074M/s
kretprobe      :    9.482 =C2=B1 0.008M/s (-9.5%)
kretprobe-multi:   13.688 =C2=B1 0.027M/s (+24%)

These numbers are pretty stable and look to be more or less representative.

As you can see, kprobes got a bit faster, kprobe-multi seems to be
about the same, though.

Then (I suppose they are "legacy") kretprobes got quite noticeably
slower, almost by 10%. Not sure why, but looks real after re-running
benchmarks a bunch of times and getting stable results.

On the other hand, multi-kretprobes got significantly faster (+24%!).
Again, I don't know if it is expected or not, but it's a nice
improvement.

If you have any idea why kretprobes would get so much slower, it would
be nice to look into that and see if you can mitigate the regression
somehow. Thanks!


>  51 files changed, 2325 insertions(+), 882 deletions(-)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_re=
move_fprobe_repeat.tc
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>


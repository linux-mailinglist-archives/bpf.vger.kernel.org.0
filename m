Return-Path: <bpf+bounces-28156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BD78B6376
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 22:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 600D61F21EAA
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 20:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3151420A8;
	Mon, 29 Apr 2024 20:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4xufAP6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE5E1411DD;
	Mon, 29 Apr 2024 20:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714422318; cv=none; b=kthEZgimGAtLjNhXbgVjR4e0dr3UIBYbMIn3w4o8b3Cfdi2p9KyVkLDwQg6iDzi25td84ccMZuix6cDuACwYgc/InzVY7w6h7Lz28wVoRdWesndUMDbr/jInRM5/DS6/ncwKpzIwiaBUXhNyGlr5GZWRQjEmwPQzXizsg+nA0M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714422318; c=relaxed/simple;
	bh=pwghGgL6we/Ml2C/J3V6Adbah1A6tVb7wbS4TO2icFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNKQz/QkHJYGXyeKKZYMOd7NXs4+TP2p5+2RCDzkAg4ECvnsPhd6xCl9cBfA+kqPkinpKX03osu5gUxGFJ98O54pFAv4PfCA1GEO+/TKJCZXYWekmp5xTnNA1grgmfzX1NOEiw8Hl2g5L4OoRY7ODVMXX3hMENYIb5pl7Svq/y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4xufAP6; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso3502489a12.3;
        Mon, 29 Apr 2024 13:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714422317; x=1715027117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhvp4E4fp/vgpdAzYCAoNC2wEtSAZOXyDAc7Z10R4aM=;
        b=b4xufAP6dL23XCJR9UBGVTYH4YoBExeL8FiFrcOizSZOEGLT4cOYeWRkgKh2nq9mSA
         l2uq69OsZxATFdJeDuEN5TayfarL4eclLRZz/O9+ZMltYD433wBO11DV9Y93LXvDPQWd
         CSPb8vq02ERAkFZ7WDcbn8L8TqRZ+4ibII3X2ikP6AbSp4CK0HEpbkBMzNwv8mOJ4U/N
         K6wNyFu8doFJ2wmFtWLziOVSH+HsQF/4OC1uA1xpRsr8mELChzmLjLbIbL58ANcmIHUg
         c+YEPp0Om0ousm9OJM0t/bxHDffTuC1+JDfsHObefTEpABg/RwfspG/OusA9TnKry8Fa
         wRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714422317; x=1715027117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bhvp4E4fp/vgpdAzYCAoNC2wEtSAZOXyDAc7Z10R4aM=;
        b=fPtnjz/9lga3YyhPs2YFUwrNibJvME1Bxr7AlPswWwuw2YG+8XHA075xrBPNBHpBOk
         RU7Kzo4AFDULLqyx5fZzeRIo5dqfT30gPliI+1VOxBsNiSRcT5lMV5jhBEIklXrbADvD
         4qJkKFGBz+YwHSAc1i+sRbY0KZ2fFwOajIomxKZRkRHZ9axYmPpE7PpgZlFwa23m6wd5
         fwMvhyXn1fVYcKHBUAdEgwcXKGyBYJZA5ZSQRJzax5Lgjpi2uDGxLYYXT4sIawG/b2dy
         LHOPsa2uJ18Muin+c8PwrZ4amp60YgEJTZnWrjp663y0HRNdYAXOapOv6xSkzUYs16XU
         Q68g==
X-Forwarded-Encrypted: i=1; AJvYcCU43OM7GzWZbwt2lNVWU5vRJBkOEPldSNce06eVK1kTeaM1ukjVydb03i24UIgcuJ/ZeKm9QG9EbeKuChbpn8d7gP71/iMUFkzAkTggZ4z1by5GVQNk0y5HFkIP/TnS6KaRYLuoDncp2Lk7FDP2M1n5rpxIKC9hJYy+fde282cSzpbqf3yU
X-Gm-Message-State: AOJu0YzIiZmV8e8Id2HnCble6rak1Q+GTjsYgYGAYVItWH+IHjY7JMqz
	iQyPW468bZgqvAWZSavjk/p94zm5wbWNC4Qc9LX6xguRyjFUcNQyCPnwmmEXCGuHm/pWpkb8rmd
	CKSprMBDv//LSGThvuGnwDunmprw=
X-Google-Smtp-Source: AGHT+IGySLgDTP6dTrK6KqBdi2BSk+WMAzY8a8b3ch2XV4CNogHHJNZ0ZbejpB1apgT0HONLxS4ACmPNzQf3+Uy5sLI=
X-Received: by 2002:a17:90a:4dc7:b0:2b1:782:8827 with SMTP id
 r7-20020a17090a4dc700b002b107828827mr729722pjl.20.1714422316584; Mon, 29 Apr
 2024 13:25:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171318533841.254850.15841395205784342850.stgit@devnote2>
 <CAEf4BzYMToveELxsOJ9dXz3H-9omhxRLKgGK-ppYvmK8pgDsfA@mail.gmail.com> <20240429225119.410833c12d9f6fbcce0a58db@kernel.org>
In-Reply-To: <20240429225119.410833c12d9f6fbcce0a58db@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 29 Apr 2024 13:25:04 -0700
Message-ID: <CAEf4BzZDqD4fyLpoq9r2M0HnES7aO7YW=ZNH-k8uPJWd_VbAJg@mail.gmail.com>
Subject: Re: [PATCH v9 00/36] tracing: fprobe: function_graph: Multi-function
 graph and fprobe on fgraph
To: Masami Hiramatsu <mhiramat@kernel.org>
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

On Mon, Apr 29, 2024 at 6:51=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> Hi Andrii,
>
> On Thu, 25 Apr 2024 13:31:53 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > Hey Masami,
> >
> > I can't really review most of that code as I'm completely unfamiliar
> > with all those inner workings of fprobe/ftrace/function_graph. I left
> > a few comments where there were somewhat more obvious BPF-related
> > pieces.
> >
> > But I also did run our BPF benchmarks on probes/for-next as a baseline
> > and then with your series applied on top. Just to see if there are any
> > regressions. I think it will be a useful data point for you.
>
> Thanks for testing!
>
> >
> > You should be already familiar with the bench tool we have in BPF
> > selftests (I used it on some other patches for your tree).
>
> What patches we need?
>

You mean for this `bench` tool? They are part of BPF selftests (under
tools/testing/selftests/bpf), you can build them by running:

$ make RELEASE=3D1 -j$(nproc) bench

After that you'll get a self-container `bench` binary, which has all
the self-contained benchmarks.

You might also find a small script (benchs/run_bench_trigger.sh inside
BPF selftests directory) helpful, it collects final summary of the
benchmark run and optionally accepts a specific set of benchmarks. So
you can use it like this:

$ benchs/run_bench_trigger.sh kprobe kprobe-multi
kprobe         :   18.731 =C2=B1 0.639M/s
kprobe-multi   :   23.938 =C2=B1 0.612M/s

By default it will run a wider set of benchmarks (no uprobes, but a
bunch of extra fentry/fexit tests and stuff like this).

> >
> > BASELINE
> > =3D=3D=3D=3D=3D=3D=3D=3D
> > kprobe         :   24.634 =C2=B1 0.205M/s
> > kprobe-multi   :   28.898 =C2=B1 0.531M/s
> > kretprobe      :   10.478 =C2=B1 0.015M/s
> > kretprobe-multi:   11.012 =C2=B1 0.063M/s
> >
> > THIS PATCH SET ON TOP
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > kprobe         :   25.144 =C2=B1 0.027M/s (+2%)
> > kprobe-multi   :   28.909 =C2=B1 0.074M/s
> > kretprobe      :    9.482 =C2=B1 0.008M/s (-9.5%)
> > kretprobe-multi:   13.688 =C2=B1 0.027M/s (+24%)
>
> This looks good. Kretprobe should also use kretprobe-multi (fprobe)
> eventually because it should be a single callback version of
> kretprobe-multi.
>
> >
> > These numbers are pretty stable and look to be more or less representat=
ive.
> >
> > As you can see, kprobes got a bit faster, kprobe-multi seems to be
> > about the same, though.
> >
> > Then (I suppose they are "legacy") kretprobes got quite noticeably
> > slower, almost by 10%. Not sure why, but looks real after re-running
> > benchmarks a bunch of times and getting stable results.
>
> Hmm, kretprobe on x86 should use ftrace + rethook even with my series.
> So nothing should be changed. Maybe cache access pattern has been
> changed?
> I'll check it with tracefs (to remove the effect from bpf related changes=
)
>
> >
> > On the other hand, multi-kretprobes got significantly faster (+24%!).
> > Again, I don't know if it is expected or not, but it's a nice
> > improvement.
>
> Thanks!
>
> >
> > If you have any idea why kretprobes would get so much slower, it would
> > be nice to look into that and see if you can mitigate the regression
> > somehow. Thanks!
>
> OK, let me check it.
>
> Thank you!
>
> >
> >
> > >  51 files changed, 2325 insertions(+), 882 deletions(-)
> > >  create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/ad=
d_remove_fprobe_repeat.tc
> > >
> > > --
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


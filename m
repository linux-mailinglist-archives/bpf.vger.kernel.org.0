Return-Path: <bpf+bounces-28157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04ACF8B6387
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 22:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D1F1B2309F
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 20:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB231442E3;
	Mon, 29 Apr 2024 20:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYjmG/98"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0498514262C;
	Mon, 29 Apr 2024 20:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714422538; cv=none; b=FUDODrJsLgROLGwKOizET2GAeE8t1Dzbeye/sbwj9GmMEDHXW1qMngprlZdO1/FFxcW/glekvBWRI4TgMoH7K0aoOWgOvBixkYBa0ZtHRCH2RwVVyPN8uUOlWReD4hRxI8UVxd6jhOXwuWqzESeZwu9FZyhbwTTICvF6EfjwG5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714422538; c=relaxed/simple;
	bh=j1QRSZ5OruzsGFwaFs+K9v6w+Z1q7xCcJnmc+J/tF+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FNJ0sukXW+B6HmvmCyr/fHhE/dWYbo08A2o1Dve/wBtpkxcb0qR0FgrdJXraNfJzrZSJCDLzosrBbDmeOzP4oVVfFhA10+whaoDDdichdFmrZY6b1eluuKwgG1wclGi3oCMxPOQrwIolKi0zHpn9P9P82i4H6AxKVSqJirbv1gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYjmG/98; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2a559928f46so3353161a91.0;
        Mon, 29 Apr 2024 13:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714422536; x=1715027336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yokQIPHiZ4cYpK5/Hrt6FWyO6M/zwcNjQu1CZ6YXzSs=;
        b=RYjmG/98kshwMV88M5hyr++uBPRL5l1UURVP2/e9l4FYXbgWWVYc8uq06FqMO0IL1M
         U2FZ3V2qh6LoBBkmrThbKCDgl8qASMiU67VXwL50n6VfERY01etvs4gLZV+3PKGxyUX9
         +4zA4YHq2ofk+4Gs3MP6WbYHvQSvJ/vflCGBfcrfmJ+QIkW/rlQGPIh8+r4C0Tl5kxdd
         gl1neU138VJOQIuiFz7Hp5WjegVC6v5mcaM0dPbYT5hgutvW0VlH+nFqtEi+++KNarJF
         njF9Z4MYASbVhjYxpuyVGXDkKmhBXcBo23V82kt8rv/iUtTiYDiCRE+LXvDM8QW9lvJr
         XTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714422536; x=1715027336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yokQIPHiZ4cYpK5/Hrt6FWyO6M/zwcNjQu1CZ6YXzSs=;
        b=u2GwzyCeafpxGzUAdA0t0V3Y5VvJ5aMYcUfpKi/ntHXXL0vc8NesOqcXYEp2GTPxWF
         yYXNdKzWkpLm4/etuNP53n0qrbrXFKtdT5onpX85Zb3LV2K2ufZ14IujQlHYVza1j1RH
         hL1RAmAuD43HCIobr3PxmZiM6hthlOmKxh2GYBSTTFKthkRLbhh/+UY9fTJGGATmSmXm
         Z+hU7Ea10nTs/FEmyVOjW5E/ED9KKXy1tZBKp63tuA+2rkJ0PQL+Xvnn3EbRHsHQcOFx
         RUaP5FprNWiM0d2Bv89IODnn+BZEphe6Tvjo8dYyI6pWjlb/2RNBQCJM17mgT2oSJkDo
         eZiA==
X-Forwarded-Encrypted: i=1; AJvYcCWQzTKlgBjVhK5hQECYE7A989V2QowQVmYQwqxwsXVSJjo4JnW691LIuK1L+9Jq3gBamImgMLYe+HctLaDqmnuky0ra7ndXqcfzu90SP7Uy6UHwX7QssrCgvvasCUNfedMzYrJZqrWoRW8LdxRj0WVS7ZHv62Pk7MjBstmldrsPHM07ZenA
X-Gm-Message-State: AOJu0Yyw25Vatx6Z3gDhsqdMqehaOuCEpseBLEfHk6LZ8jWDXhQ/kaiN
	6D3UVSy8rKlp1RAc4N7VkY/P6w71JnmW721do+EaHrmvXHxUlHBCbHIqAD/pyYpILnNRql33BZV
	0DeO81+6O1uVTqqKHcjLEER3Qk98=
X-Google-Smtp-Source: AGHT+IEcKpz0kCzyKt+ymuuc69CeTchfc8CdR312rjP5Z0eGUnWPRpC+XGnRzDSDwvJGsVNsIM3l0z/gqcgg/+scljI=
X-Received: by 2002:a17:90b:4f48:b0:2b2:6834:e983 with SMTP id
 pj8-20020a17090b4f4800b002b26834e983mr675590pjb.45.1714422536190; Mon, 29 Apr
 2024 13:28:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171318533841.254850.15841395205784342850.stgit@devnote2>
 <CAEf4BzYMToveELxsOJ9dXz3H-9omhxRLKgGK-ppYvmK8pgDsfA@mail.gmail.com> <20240428192549.7898bf6b@rorschach.local.home>
In-Reply-To: <20240428192549.7898bf6b@rorschach.local.home>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 29 Apr 2024 13:28:44 -0700
Message-ID: <CAEf4BzazmnBOr+sq7w_KeUQpP7v9o+k418tuzCMEbXXbUeg7bQ@mail.gmail.com>
Subject: Re: [PATCH v9 00/36] tracing: fprobe: function_graph: Multi-function
 graph and fprobe on fgraph
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Florent Revest <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, 
	Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alan Maguire <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 28, 2024 at 4:25=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 25 Apr 2024 13:31:53 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> I'm just coming back from Japan (work and then a vacation), and
> catching up on my email during the 6 hour layover in Detroit.
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
> >
> > You should be already familiar with the bench tool we have in BPF
> > selftests (I used it on some other patches for your tree).
>
> I should get familiar with your tools too.
>

It's a nifty and self-contained tool to do some micro-benchmarking, I
replied to Masami with a few details on how to build and use it.

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
> >
> > These numbers are pretty stable and look to be more or less representat=
ive.
>
> Thanks for running this.
>
> >
> > As you can see, kprobes got a bit faster, kprobe-multi seems to be
> > about the same, though.
> >
> > Then (I suppose they are "legacy") kretprobes got quite noticeably
> > slower, almost by 10%. Not sure why, but looks real after re-running
> > benchmarks a bunch of times and getting stable results.
> >
> > On the other hand, multi-kretprobes got significantly faster (+24%!).
> > Again, I don't know if it is expected or not, but it's a nice
> > improvement.
> >
> > If you have any idea why kretprobes would get so much slower, it would
> > be nice to look into that and see if you can mitigate the regression
> > somehow. Thanks!
>
> My guess is that this patch set helps generic use cases for tracing the
> return of functions, but will likely add more overhead for single use
> cases. That is, kretprobe is made to be specific for a single function,
> but kretprobe-multi is more generic. Hence the generic version will
> improve at the sacrifice of the specific function. I did expect as much.
>
> That said, I think there's probably a lot of low hanging fruit that can
> be done to this series to help improve the kretprobe performance. I'm
> not sure we can get back to the baseline, but I'm hoping we can at
> least make it much better than that 10% slowdown.

That would certainly be appreciated, thanks!

But I'm also considering trying to switch to multi-kprobe/kretprobe
automatically on libbpf side, whenever possible, so that users can get
the best performance. There might still be situations where this can't
be done, so singular kprobe/kretprobe can't be completely deprecated,
but multi variants seems to be universally faster, so I'm going to
make them a default (I need to handle some backwards compat aspect,
but that's libbpf-specific stuff you shouldn't be concerned with).

>
> I'll be reviewing this patch set this week as I recover from jetlag.
>
> -- Steve


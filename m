Return-Path: <bpf+bounces-60297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A260AD4962
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 05:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C339189EA36
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 03:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA271991A9;
	Wed, 11 Jun 2025 03:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKO6vSi1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9169186A;
	Wed, 11 Jun 2025 03:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749612754; cv=none; b=OWXlM/uNa2TfZInpXV2FYm1RCN1k08siyXoikslaBKkSGNll8L7enElTsc8IoOZ4z6nM/YbLwx8+i7r9o7umR78UmixlEHfV97iGJ7unaQpufRcwLyyCxHMtrvCtbSgFJW3t0AwrTAsWIytaUlpjYPhSVC3OIIZsCPm94wLOtzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749612754; c=relaxed/simple;
	bh=1E/wjok6CGwwgtqBs99Yk4TdTKJQWmkuSCyoxzkv1wI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lUdjLIOiuXxGPug8n6sm0PB2Q60gZjWXu5J2u9/aj3WFrRDq7tfF53LL3kYaLEFO+T9yvVZIcj6UyPO4RsmmeA2boIkgdcL8hGXR6UwL0DmiESkdD8mLl6LqXjIfHTaQYVOR+eWQbaLxgI9yROepLSFqkdHeYCMBiiTTGCqVHg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKO6vSi1; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a4fd1ba177so307474f8f.0;
        Tue, 10 Jun 2025 20:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749612751; x=1750217551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLenIOOCLQXfsIRKzbAicYiRT1mXnLSvtehG1XdOuXw=;
        b=lKO6vSi1/MI3Tz6r7fT1bc1gpxgHvUTloI7SGcGsORyIM3KKZ+eP61jPUFS4kDEL10
         J1N0B0t9jjOSdkFPlHN2x4JSErccTnv4s3ey5TIXKWKt7fwuNahs5zuwmecIL6uhO/xl
         Mx6YkyeHbL9J1WKkeTo+80cDCVrv7uFuM6F0helCsH1AMpYWI4eKyC8AmEbUg36+G2vt
         SZp/JEnwU0E6Sdk/EeHtkpl0yieZaBwkZYnwHpps+3OJOxYPKep9Oe6HoQ+J2z79brM3
         PYmDMPuyqTVm8flHS1ul97OHqRivOEtcErNaSoUjjTtmsn53f7T0vi5blBiEJIq4ok2c
         dYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749612751; x=1750217551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLenIOOCLQXfsIRKzbAicYiRT1mXnLSvtehG1XdOuXw=;
        b=OpHVZpeJirHzPrh8o5072We9uWX40yl5+5Ug0ubpMb2Cxz7fCrvpgRdSvBTezWNhmp
         U1wSo7X6pASYxpe21lqcfB8H2yKrKg4AT82YSAb9JzIg6IAQKOe/xLpQqgmWwnFq6Y7H
         SS4MXxEvjjd+5lBPyxEtUKNj70zu0wX9FpM0PEBMhhac0zHn3CFSssZVYsXvX7ZbKIMa
         76pU91O7ZjcxY+p1pnBxEhvcq2vZFWuObers6HPtSN+6mbUsyZunAFt8FtK3eZVy8jJv
         tlldVqdpRoIo+RFPQEXKqQ+tB8YytNuLXDW5sCjRHWY4e9VFQyTiBc12CUFQers+WtvQ
         F9Zw==
X-Forwarded-Encrypted: i=1; AJvYcCU+dZrxwY/v0i/E/sLUaRkwhDMhkhBu0g0NwvPDMX7RJ0WNZxM6AWh4g3fKjR9NE8ihHoc=@vger.kernel.org, AJvYcCVaSmLpUnYdun2uqkx2KIqWw1auT/3BQjb0oZLDAYOtOlw7L1WTdHsOZbj2Yn6sqPfWJkGfAt/sy+b81Afy@vger.kernel.org
X-Gm-Message-State: AOJu0YzGUKnq4keXjhF5OBnZrGnn36ChYhXGm2Qa9rEd1V3CqCDxVmad
	/trJpcHisrtWAdjcdMhMXujAFmgfWgPMhSXSRbxj5jucODyHtkk6AETameaU/wYzZMHpfYG5m/l
	zXrhoz6srMuuo98hUfHDvDEubtKGaTVA=
X-Gm-Gg: ASbGncuxmOuDslDRaQ6j7mVusFD03IxaxAn8G5qAT6BKCR3zxiWs3p4bql7XU+UrGnc
	3aUfJffTYfSrTRA1Hf+3ZBMJ2niH0EP6uZppdkH8xcqzOxgEDL1uvPAgX2ZZib6Xte/oKTs5r0c
	1gb4AG12NyhYSSoq9VtxdqRuS6rd5k1TOs/8y1Iuv06el9pyXo6nry9yYQ7pYWa+7mxtYgJwuO
X-Google-Smtp-Source: AGHT+IH/r58d0YG7LtQz9Os1cCp4W28yg6nFPp8bPRjmdKTBD8o5lW2KoBCX4QfjTf911mmlc2+WvBofQjVI+4GjbLw=
X-Received: by 2002:a05:6000:2405:b0:3a5:281b:9fac with SMTP id
 ffacd0b85a97d-3a5582431f7mr1118417f8f.17.1749612751076; Tue, 10 Jun 2025
 20:32:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528034712.138701-1-dongml2@chinatelecom.cn>
In-Reply-To: <20250528034712.138701-1-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 10 Jun 2025 20:32:20 -0700
X-Gm-Features: AX0GCFtkUmz4z26cipOWR3NlyYNmRVyLxzGnqs4BY6NbTkQ2hzmnJshZZYUpsOE
Message-ID: <CAADnVQ+G+mQPJ+O1Oc9+UW=J17CGNC5B=usCmUDxBA-ze+gZGw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/25] bpf: tracing multi-link support
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Menglong Dong <dongml2@chinatelecom.cn>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 8:49=E2=80=AFPM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> 1. Add per-function metadata storage support.
> 2. Add bpf global trampoline support for x86_64.
> 3. Add bpf global trampoline link support.
> 4. Add tracing multi-link support.
> 5. Compatibility between tracing and tracing_multi.

...

> ... and I think it will be a
> liberation to split it out to another series :/

There are lots of interesting ideas here and you know
already what the next step should be...
Split it into small chunks.
As presented it's hard to review and even if maintainers take on
that challenge the set is unlandable, since it spans various
subsystems.

In a small reviewable patch set we can argue about
approach A vs B while the current set has too many angles
to argue about.
Like the new concept of global trampoline.
It's nice to write bpf_global_caller() in asm
compared to arch_prepare_bpf_trampoline() that emits asm
on the fly, but it seems the only thing where it truly
needs asm is register save/restore. The rest can be done in C.
I suspect the whole gtramp can be written in C.
There is an attribute(interrupt) that all compilers support...
or use no attributes and inline asm for regs save/restore ?
or attribute(naked) and more inline asm ?

> no-mitigate + hash table mode
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> nop     | fentry    | fm_single | fm_all    | km_single | km_all
> 9.014ms | 162.378ms | 180.511ms | 446.286ms | 220.634ms | 1465.133ms
> 9.038ms | 161.600ms | 178.757ms | 445.807ms | 220.656ms | 1463.714ms
> 9.048ms | 161.435ms | 180.510ms | 452.530ms | 220.943ms | 1487.494ms
> 9.030ms | 161.585ms | 178.699ms | 448.167ms | 220.107ms | 1463.785ms
> 9.056ms | 161.530ms | 178.947ms | 445.609ms | 221.026ms | 1560.584ms

...

> no-mitigate + function padding mode
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> nop     | fentry    | fm_single | fm_all    | km_single | km_all
> 9.320ms | 166.454ms | 184.094ms | 193.884ms | 227.320ms | 1441.462ms
> 9.326ms | 166.651ms | 183.954ms | 193.912ms | 227.503ms | 1544.634ms
> 9.313ms | 170.501ms | 183.985ms | 191.738ms | 227.801ms | 1441.284ms
> 9.311ms | 166.957ms | 182.086ms | 192.063ms | 410.411ms | 1489.665ms
> 9.329ms | 166.332ms | 182.196ms | 194.154ms | 227.443ms | 1511.272ms
>
> The overhead of fentry_multi_all is a little higher than the
> fentry_multi_single. Maybe it is because the function
> ktime_get_boottime_ns(), which is used in bpf_testmod_bench_run(), is als=
o
> traced? I haven't figured it out yet, but it doesn't matter :/

I think it matters a lot.
Looking at patch 25 the fm_all (in addition to fm_single) only
suppose to trigger from ktime_get_boottime,
but for hash table mode the difference is huge.
10M bpf_fentry_test1() calls are supposed to dominate 2 calls
to ktime_get and whatever else is called there,
but this is not what numbers tell.

Same discrepancy with kprobe_multi. 7x difference has to be understood,
since it's a sign that the benchmark is not really measuring
what it is supposed to measure. Which casts doubts on all numbers.

Another part is how come fentry is 20x slower than nop.
We don't see it in the existing bench-es. That's another red flag.

You need to rethink benchmarking strategy. The bench itself
should be spotless. Don't invent new stuff. Add to existing benchs.
They already measure nop, fentry, kprobe, kprobe-multi.

Then only introduce a global trampoline with a simple hash tab.
Compare against current numbers for fentry.
fm_single has to be within couple percents of fentry.
Then make fm_all attach to everything except funcs that bench trigger calls=
.
fm_all has to be exactly equal to fm_single.
If the difference is 2.5x like here (180 for fm_single vs 446 for fm_all)
something is wrong. Investigate it and don't proceed without full
understanding.

And only then introduce 5 byte special insn that indices into
an array for fast access to metadata.
Your numbers are a bit suspicious, but they show that fm_single
with hash tab is the same speed as the special kfunc_md_arch_support().
Which is expected.
With fm_all that triggers small set of kernel function
in a tight benchmark loop the performance of hashtab vs special
should _also_ be the same, because hashtab will perform O(1) lookup
that is hot in the cache (or hashtab has bad collisions and should be fixed=
).
fm_all should have the same speed as fm_single too,
because bench will only attach to things outside of the tight bench loop.
So attaching to thousands of kernel functions that are not being
triggered by the benchmark should not affect results.

The performance advantage of special kfunc_md_arch_support()
can probably only be seen in production when fentry.multi attaches
to thousands of kernel functions and random functions are called.
Then hash tab cache misses will be noticeable vs direct access.
There will be cache misses in both cases, but significantly more misses
for hash tab. Only then we can decide where special stuff is truly necessar=
y.
So patches 2 and 3 are really last. After everything had already landed.


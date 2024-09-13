Return-Path: <bpf+bounces-39868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 873AE978AAD
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 23:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152901F21032
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 21:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBEC15539D;
	Fri, 13 Sep 2024 21:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTspgCEE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940CC1E884;
	Fri, 13 Sep 2024 21:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726263427; cv=none; b=DOH0vIY3kJrXGVq2e2KTCIAhmm9WsJisWeZYvEbmuy62IgbJiH/wte6niVuaCd+bntu33cFeXNWW9Aah7abvMgSlr02U2fIjNm+XfCROrFWYvXEkxVK31TgBmJh4ajgppMGe0GoEzF61Qm99eKJrdMl+J7y+b9ZEba3wtzcUpKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726263427; c=relaxed/simple;
	bh=vb+rHDerVoW5b0X5DQj9tZH6EoL//ykjxLDpApsZaWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=se7E4C1zWgNY+FVnEWqxVN5muNVHpxBlXk+f2iiOxkCPMIe2ZAPa4EWUgsGucQSXy9nQGwASfp0gdMkjjs3FgD2X4dRF6k69HPabIxRWuQX8MoBy+agvSye2uk6eGLNtU3nBJJQiyweo3AGP3lMLWoJP2nQUOmEM+xZmZDWNL8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTspgCEE; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d86f71353dso1930511a91.2;
        Fri, 13 Sep 2024 14:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726263425; x=1726868225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufuODkYRAPVANRv1dPBGY6G0b9qqTcEIHXtDX+U2lRw=;
        b=KTspgCEEdKH80GiOAYw+4j2CEy5Rfjt90hy5Hd+pjjVouG51ha2hZXLlp23defAs/a
         1OzQDAAzSel38AB0AhBxt2X9pWg5Swvp+/+nLb9JVdfNdTbcnLtWN1JNBj9biUM0tJXb
         l6IzxWKo9VJbcpIFs1/7XtxAOaBI6PR67itDk6cknAChDUB2YeA4+GqWMbyNIgsvXCbC
         XRMwBLPRcoVTZoEXTMPGVLKfY9+fnX1FnCMoa9A+HlbmePUHngIObD11yT2GA+pwFr5J
         OKEUeQ+xT4cKQu7VbmjAYSuiPmaJJMsm1i2CtNvY3VxO5ihORfGZI/mKKIp4SHjGpoL0
         WrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726263425; x=1726868225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufuODkYRAPVANRv1dPBGY6G0b9qqTcEIHXtDX+U2lRw=;
        b=HWKifG54XysD3d52PmLd/dY7shoL0Ah3qDNgKw2ft3l5uHOCWHgsylDfaZEngs7qYu
         lzFRFMIQr8xpa8FZkSWaDJjtN+MIH07iclJGTJ8iF+fxw2ld5M2VigD7Mn6JBZo0nqLx
         mpEIzer1y00nJPx9MuwD7TF0sZbvA/tEOaD/aKgY7l4ELBjC09MOwRGMNJ0CV++AsDRC
         0hvAmbQ0T6UXwEYtLIw97W4qbnJlfVK9pdGV/xs4tGIVTaSkeZ+SK6CoY6AUgFfCxzqQ
         5OUjIPTdlo1GlCyFuHOf21OaMvKiD6SR9gJ+G7f3C07otgTxPIGoXfN5hehsxVgprlPN
         /S8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV66e+3Z8DhUiZxjXP5U0ndvJdhoCxGLYqlCEGaQB3SuV9VIow+sv1VUMw3SRK01LHz2AE=@vger.kernel.org, AJvYcCWme7GTiFCg/ocpwTRpApdsgpNTsez5G8Q70k5vW+idYJNf95sOMp9JPWDH+GoZ13TQHqYLcN+uiKM7ahod@vger.kernel.org
X-Gm-Message-State: AOJu0YwskOAk7AYBMXxZ0wA6tpsbQVGn34YNz86oFKN83MFINxALAHH2
	9QmuTqj5QB5XGLjlwxJQDPiGec7SIBOjXZ7JbbqmL3z378iePa0/sVC8K0HWwFTDRRM+1i7FYC/
	pvuMBG+nPvCFifKGnUK5QY2TVNo8=
X-Google-Smtp-Source: AGHT+IEFKApS///oMb0n1UxSVQ36wqC+1R1mMCqxzCL4yxI+RigDDVRsD36joNxkerIubYatgYfo906sEC/GVrJjcSQ=
X-Received: by 2002:a17:90a:a598:b0:2d8:f515:3169 with SMTP id
 98e67ed59e1d1-2db9ff79c90mr7418409a91.6.1726263424810; Fri, 13 Sep 2024
 14:37:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910174312.3646590-1-andrii@kernel.org>
In-Reply-To: <20240910174312.3646590-1-andrii@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 13 Sep 2024 14:36:52 -0700
Message-ID: <CAEf4BzaVW_HXTCJDx=iHs9AJOSaUQq3Bwg+hFc3FCdqxb5Ah6Q@mail.gmail.com>
Subject: Re: [PATCH] uprobes: switch to RCU Tasks Trace flavor for better performance
To: Andrii Nakryiko <andrii@kernel.org>, peterz@infradead.org, mingo@kernel.org
Cc: linux-trace-kernel@vger.kernel.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jolsa@kernel.org, paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 10:43=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org=
> wrote:
>
> This patch switches uprobes SRCU usage to RCU Tasks Trace flavor, which
> is optimized for more lightweight and quick readers (at the expense of
> slower writers, which for uprobes is a fine tradeof) and has better
> performance and scalability with number of CPUs.
>
> Similarly to baseline vs SRCU, we've benchmarked SRCU-based
> implementation vs RCU Tasks Trace implementation.
>
> SRCU
> =3D=3D=3D=3D
> uprobe-nop      ( 1 cpus):    3.276 =C2=B1 0.005M/s  (  3.276M/s/cpu)
> uprobe-nop      ( 2 cpus):    4.125 =C2=B1 0.002M/s  (  2.063M/s/cpu)
> uprobe-nop      ( 4 cpus):    7.713 =C2=B1 0.002M/s  (  1.928M/s/cpu)
> uprobe-nop      ( 8 cpus):    8.097 =C2=B1 0.006M/s  (  1.012M/s/cpu)
> uprobe-nop      (16 cpus):    6.501 =C2=B1 0.056M/s  (  0.406M/s/cpu)
> uprobe-nop      (32 cpus):    4.398 =C2=B1 0.084M/s  (  0.137M/s/cpu)
> uprobe-nop      (64 cpus):    6.452 =C2=B1 0.000M/s  (  0.101M/s/cpu)
>
> uretprobe-nop   ( 1 cpus):    2.055 =C2=B1 0.001M/s  (  2.055M/s/cpu)
> uretprobe-nop   ( 2 cpus):    2.677 =C2=B1 0.000M/s  (  1.339M/s/cpu)
> uretprobe-nop   ( 4 cpus):    4.561 =C2=B1 0.003M/s  (  1.140M/s/cpu)
> uretprobe-nop   ( 8 cpus):    5.291 =C2=B1 0.002M/s  (  0.661M/s/cpu)
> uretprobe-nop   (16 cpus):    5.065 =C2=B1 0.019M/s  (  0.317M/s/cpu)
> uretprobe-nop   (32 cpus):    3.622 =C2=B1 0.003M/s  (  0.113M/s/cpu)
> uretprobe-nop   (64 cpus):    3.723 =C2=B1 0.002M/s  (  0.058M/s/cpu)
>
> RCU Tasks Trace
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> uprobe-nop      ( 1 cpus):    3.396 =C2=B1 0.002M/s  (  3.396M/s/cpu)
> uprobe-nop      ( 2 cpus):    4.271 =C2=B1 0.006M/s  (  2.135M/s/cpu)
> uprobe-nop      ( 4 cpus):    8.499 =C2=B1 0.015M/s  (  2.125M/s/cpu)
> uprobe-nop      ( 8 cpus):   10.355 =C2=B1 0.028M/s  (  1.294M/s/cpu)
> uprobe-nop      (16 cpus):    7.615 =C2=B1 0.099M/s  (  0.476M/s/cpu)
> uprobe-nop      (32 cpus):    4.430 =C2=B1 0.007M/s  (  0.138M/s/cpu)
> uprobe-nop      (64 cpus):    6.887 =C2=B1 0.020M/s  (  0.108M/s/cpu)
>
> uretprobe-nop   ( 1 cpus):    2.174 =C2=B1 0.001M/s  (  2.174M/s/cpu)
> uretprobe-nop   ( 2 cpus):    2.853 =C2=B1 0.001M/s  (  1.426M/s/cpu)
> uretprobe-nop   ( 4 cpus):    4.913 =C2=B1 0.002M/s  (  1.228M/s/cpu)
> uretprobe-nop   ( 8 cpus):    5.883 =C2=B1 0.002M/s  (  0.735M/s/cpu)
> uretprobe-nop   (16 cpus):    5.147 =C2=B1 0.001M/s  (  0.322M/s/cpu)
> uretprobe-nop   (32 cpus):    3.738 =C2=B1 0.008M/s  (  0.117M/s/cpu)
> uretprobe-nop   (64 cpus):    4.397 =C2=B1 0.002M/s  (  0.069M/s/cpu)
>
> Peak throughput for uprobes increases from 8 mln/s to 10.3 mln/s
> (+28%!), and for uretprobes from 5.3 mln/s to 5.8 mln/s (+11%), as we
> have more work to do on uretprobes side.
>
> Even single-thread (no contention) performance is slightly better: 3.276
> mln/s to 3.396 mln/s (+3.5%) for uprobes, and 2.055 mln/s to 2.174 mln/s
> (+5.8%) for uretprobes.
>
> We also select TASKS_TRACE_RCU for UPROBES in Kconfig due to the new
> dependency.
>
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  arch/Kconfig            |  1 +
>  kernel/events/uprobes.c | 38 ++++++++++++++++----------------------
>  2 files changed, 17 insertions(+), 22 deletions(-)
>

Just in case this slipped through the cracks (and is not just waiting
its turn to be applied), ping. It would be nice to have this patch
with the rest of uprobe patches from the original patch set to go in
together. Thanks!

> diff --git a/arch/Kconfig b/arch/Kconfig
> index 975dd22a2dbd..a0df3f3dc484 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -126,6 +126,7 @@ config KPROBES_ON_FTRACE
>  config UPROBES
>         def_bool n
>         depends on ARCH_SUPPORTS_UPROBES
> +       select TASKS_TRACE_RCU
>         help
>           Uprobes is the user-space counterpart to kprobes: they
>           enable instrumentation applications (such as 'perf probe')

[...]


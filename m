Return-Path: <bpf+bounces-61176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D370AE1D92
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 16:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC02C4A7A3E
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 14:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE6D28C855;
	Fri, 20 Jun 2025 14:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kG0AjHQs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com [209.85.219.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680AC28FD;
	Fri, 20 Jun 2025 14:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750430346; cv=none; b=FykTK8v3Nvr8YLyXMyqUL9onPjvCTB3JJ00TRL4MtpmUX/tuB3miIbKWw9kk/VR8MIkk9XctulFyymjSS6dyMZlU1TDtL//pM3i5N8keWeh1dRYgLxYEaAqwCg6PriaM0uf3hTCaF36B2zfbKRP3v1al2VQwEImYiK+Zgd/fizo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750430346; c=relaxed/simple;
	bh=GXfhSEQtzREoIv/G+KioVKxr9pE5y3dI9y/hyAVzvYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VOACQJgJeWryed9+Qw19nXXjNbpfX0Vbw7to7QS3UrUDTCIC4C8IIKt3HCrWTK6qCEzULjK528xM70zeQt6d5ajsn+lbJXJ9BPciG99Gl8d3IrUrncLj60BqyA8pTDnJ2alP7sUXzDrDWRfc7s4Ojoa6xAaT0Iadpczy5TdUVt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kG0AjHQs; arc=none smtp.client-ip=209.85.219.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f196.google.com with SMTP id 3f1490d57ef6-e8275f110c6so1559974276.2;
        Fri, 20 Jun 2025 07:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750430343; x=1751035143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jwzj9SK0aHKRv0bEfUf04rTwKrHOht8Mlzar8pF+Has=;
        b=kG0AjHQsAi8Sz102m0qEbjR5x1yMi4GNPsrxParz92SumTSt0AO0YshAegCxRqfcNu
         +sfgd+y1FyfHl9gw6VZsI+OnGGBC5h7clY1UuumoNmYSsGfjggOGRrXPfeSPoXw+mR7b
         U1oF0H2cifMvs/MmcKPzxjzAIbUhOaFvuRyRW/kLgJ/Dukv4isp5xJrlhD3yU3Ryu0qL
         39+FLepuq22QVfuwkH738A//cUsRsjtxn+HtBjV9Tk/mzR4Mm4y4tALihin1cxNLSqiF
         avopf0U+oNmpgb03Hqln2gnaDEvDK1ItnaC4H47SqtaCK2C5eqdoTeRyzCjgtiqJTEcF
         pgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750430343; x=1751035143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jwzj9SK0aHKRv0bEfUf04rTwKrHOht8Mlzar8pF+Has=;
        b=xCkZTTvfn+4Asa473e0Ib3aTm+CvxDhsp7g2PQBVPSs88gVz8mdmps9GneIydujLLs
         Rwh9Br5FUc5JwCL+UVRzAvtF7+wCCBwfDooDrYhxBlNR/qdk67ejCz5ShQzJDesqP8Rl
         0xFbGTBdXS87HJIPhIYRVFuCDdxU4FunQKl8C73RJcmBQD2cPMI0XclLDW3rbvpQxyGQ
         whF4+UWFVOgK9vBarApfCnHaWkBW9XQLCwso0bCQw/07VuQ56K26zqDcjfyOgHNHtdI7
         yTf9XjLB7Nbwtod4Bg186fWvCPj9MqXove+MlVoBx1JA1b8D02x9ApyaJrYbWRJ2zPut
         opxA==
X-Forwarded-Encrypted: i=1; AJvYcCU6ysuPVndIUb/0rxgLFKsDqC3Krt3AYdYSF62vhyOoFo6z9bPr77Wj37gMFKHqgOcfbCA=@vger.kernel.org, AJvYcCXruP4pCkfLiF27FDcVMWWT2bVOR8yllKGqHCSg8E9w44v3HBt5q5U4s/kv7Th+x2oKplf8r3YLo6WL66T2@vger.kernel.org
X-Gm-Message-State: AOJu0YwaevA8xXva4rRkV5y/Wg1oKXuo5SOOIV488atTPvxBIbvQepNb
	P6TwhFMYq+kfmRkvn5Djk3vd3ol1WkMcnQQfClsVtlTEXj/jBVa/TB10vnXJNvwMBfrSPso7nZE
	EQht1+G4pBQvXW+tkQ2uAxVYwAzD0Ti4=
X-Gm-Gg: ASbGncs5wn559D7V+cp58zxz8o4y8g6BvLqCczLfBhykw8AdHq9cdauLaKerR5Zpphk
	qCJ0N60zwLQ6ibGTJKi2wVL6ny8B6DPoUfefbDVtFf3hDaNvso2hULm0VItJbeIlmAlzuX1iO4b
	cubxXwdyRchsONLonyaD0tI2a4C2ZCsHvO96TqjLIWuCH8H/yKJvV/VA==
X-Google-Smtp-Source: AGHT+IEhmV47KRzCLJuFrjGZNNmzZHcc6s0uq8ijlkfL0DWNrYq/D/nIZMGYq1uzXP6Iwj4qOJnvp519uUE45duOGT0=
X-Received: by 2002:a05:6902:1617:b0:e82:65e3:86bc with SMTP id
 3f1490d57ef6-e842bd33744mr4200776276.47.1750430343186; Fri, 20 Jun 2025
 07:39:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618085609.1876111-1-dongml2@chinatelecom.cn> <CAADnVQ+5HOFu=bwQekwZOmOe+FKk26UJW=S1wZY3bSye_7C23w@mail.gmail.com>
In-Reply-To: <CAADnVQ+5HOFu=bwQekwZOmOe+FKk26UJW=S1wZY3bSye_7C23w@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 20 Jun 2025 22:38:55 +0800
X-Gm-Features: Ac12FXyX_xPzPsNXEJvIAmjf_kBoDJjLo0yOhcINjHv3H7GZUQwPToqSD5L4ASY
Message-ID: <CADxym3Yh630_NqGsvg3=w_D=K1WdvJ1v=7gvEYg4k0x_jAKAUA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: make update_prog_stats always_inline
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Menglong Dong <dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 2:07=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jun 18, 2025 at 1:58=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > The function update_prog_stats() will be called in the bpf trampoline.
> > Make it always_inline to reduce the overhead.
>
> What kind of difference did you measure ?

Hi, Alexei. I think I made some things wrong. The update_prog_stats is alre=
ady
optimized by the compiler for the current code by inline it. I observed the=
 CPU
consumption of update_prog_stats() by perf in my global trampoline, but it
doesn't exist in bpf trampoline.

Anyway, I think it is worth to make it inline manually here, as we can't re=
ly on
the compiler all the time. When I add noinline to update_prog_stats(), the
performance of bench/trig-fentry decrease from 120M/s to 113M/s.

>
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  kernel/bpf/trampoline.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index c4b1a98ff726..134bcfd00b15 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> > @@ -911,8 +911,8 @@ static u64 notrace __bpf_prog_enter_recur(struct bp=
f_prog *prog, struct bpf_tram
> >         return bpf_prog_start_time();
> >  }
> >
> > -static void notrace update_prog_stats(struct bpf_prog *prog,
> > -                                     u64 start)
> > +static __always_inline void notrace update_prog_stats(struct bpf_prog =
*prog,
> > +                                                     u64 start)
> >  {
>
> How about the following instead:
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index c4b1a98ff726..728bb2845f41 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -911,28 +911,23 @@ static u64 notrace __bpf_prog_enter_recur(struct
> bpf_prog *prog, struct bpf_tram
>      return bpf_prog_start_time();
>  }
>
> -static void notrace update_prog_stats(struct bpf_prog *prog,
> -                      u64 start)
> +static noinline void notrace __update_prog_stats(struct bpf_prog *prog,

Does "noinline" have any special meaning here? It seems that
we don't need it :/

> +                         u64 start)
>  {
>      struct bpf_prog_stats *stats;
> -
> -    if (static_branch_unlikely(&bpf_stats_enabled_key) &&
> -        /* static_key could be enabled in __bpf_prog_enter*
> -         * and disabled in __bpf_prog_exit*.
> -         * And vice versa.
> -         * Hence check that 'start' is valid.
> -         */
> -        start > NO_START_TIME) {
> -        u64 duration =3D sched_clock() - start;
> -        unsigned long flags;
> -
> -        stats =3D this_cpu_ptr(prog->stats);
> -        flags =3D u64_stats_update_begin_irqsave(&stats->syncp);
> -        u64_stats_inc(&stats->cnt);
> -        u64_stats_add(&stats->nsecs, duration);
> -        u64_stats_update_end_irqrestore(&stats->syncp, flags);
> -    }
> +    u64 duration =3D sched_clock() - start;
> +    unsigned long flags;
> +
> +    stats =3D this_cpu_ptr(prog->stats);
> +    flags =3D u64_stats_update_begin_irqsave(&stats->syncp);
> +    u64_stats_inc(&stats->cnt);
> +    u64_stats_add(&stats->nsecs, duration);
> +    u64_stats_update_end_irqrestore(&stats->syncp, flags);
>  }
> +#define update_prog_stats(prog, start) \
> +    if (static_branch_unlikely(&bpf_stats_enabled_key) && \
> +        start > NO_START_TIME) \
> +        __update_prog_stats(prog, start)
>
>  static void notrace __bpf_prog_exit_recur(struct bpf_prog *prog, u64 sta=
rt,
>                        struct bpf_tramp_run_ctx *run_ctx)
>
>
> Maybe
> if (start > NO_START_TIME)
> should stay within __update_prog_stats().
>
> pls run a few experiments.

Yeah, I think it is much better in this way. And the performance stay exact=
ly
the same after the midifition, which means it has the same effect as
the compiler's automatical optimization.

Thanks!
Menglong Dong


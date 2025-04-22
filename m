Return-Path: <bpf+bounces-56436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FF9A97396
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 19:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90CAD189EF30
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 17:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660782980A5;
	Tue, 22 Apr 2025 17:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFIJLaqt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D9E28C5A6;
	Tue, 22 Apr 2025 17:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745342936; cv=none; b=NtWXFA4EfROrQIyxb/FB+BzP8wKKDskmEXp+NqnS/1KzKzbI7YHA43qwicj168r7fy3jl3eQclDYPbCjtMhlcHkG7jJS1tC+039h8rWWvkXVJJXqMV/V03lZyA22zJE/eWSxuj9SjDt+z1zS4nu8tu9JEzkILO2YXDD6niaSthE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745342936; c=relaxed/simple;
	bh=eFcP2GiIfYlz5vX4x81qW5td0rrszSQH+tjWOMNxdFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tPxnXV6XrSI3oZ2jwFjYCiX2NGmHH56AOB3No4kWhzkAdsVPAVFE6ovX8F34ma9BUzj5ZC9+hdR6POm+IWLykiLwr6J1WObu5tqu1+4wgH2q4nxd43+p7kttiD6szkz08JR6Z+wwAgDtrnGvHrOuVDUa6vD3if7OYdywrvoT1HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFIJLaqt; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso64287595e9.3;
        Tue, 22 Apr 2025 10:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745342933; x=1745947733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dwRtx2MWi5keXq5RhARdEN3lNKJTVMlJXLO8mAzi0I=;
        b=fFIJLaqtjNGd1XCKem+bodEEo5anzRD/PqTg53eS+lTS7mmnEsi6MzH8oRhIlP9x4L
         Tx7Z4YiD+4vfRFw8rFKmPkmqo5UsnsuXFimCUmGQasgmwYwz7uPeRpxGw+WzExkukGPd
         KbkINsw/QSQvwTP5HWS8qTXJZK2+O7qFpTXSTeVeJtZUcoCvtm8aM0fN7PaTD0Dm2ODa
         tPGIEjAggOynWHPqeNx95+q9IPDLuJ43w4Q+nCI+GEFTVWesHphN45RxHNhf2eh/DicQ
         paiqSxb3sp0CkJ5kaYPnVlaKriFI8TxBHd+QDVFx2mF2Q5nglLaD0NlZ6+kmIgVcgEoQ
         YKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745342933; x=1745947733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dwRtx2MWi5keXq5RhARdEN3lNKJTVMlJXLO8mAzi0I=;
        b=H+iYnxupjh0yRGQq5GRp8qZ647nAuceUtUiUDKvHaffre/B7Ov/k5ORCu1qCqmpwEd
         FBxdvr5saD1XS8TGcX+8ME3D0T7uRYAyGJyYv57wA/jLpsZKU3Ca0bTIohBILrhd3cfu
         DQA6M3Q1EsbL1dxOfeomo8ccAK9mzbEY+tJO35XMcl1m5Bk/OQOPTW6+cWozM3RirEt+
         JkwWD9+SAkJVfWOSVSUFWVs8QiKTYpFUMsANfQpow9ZqtpF0wr6UVyant6KeeTtHvl6A
         JJanX3mWNmED7XOmNtw+6TuaHnj8kUoz44Cb/QpvSPATz1ZES5X7OrjpQM5vNxyE5Qel
         hwAA==
X-Forwarded-Encrypted: i=1; AJvYcCWBbnGNwaBgMhyVvflhLtgZBbt46m4j6mjVdHllrOrL45Ps/S5iCXtzd4eHN8jEIq52dm625cj5ai6ZRGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws6So01wl9ZUSfh20+8nE0xjZz3JevM6tKOSvoRqj8Vsc1wcck
	zpOg/ybvMpOBFWp/6pkR/ZlGCPPWW/5ZDWKVfbLWwY5TgkTDjaysY9EVMtu31TQaxXVzRVHJYbl
	3I8L02UgSW2O4NKtAXAYGyrzdBWs=
X-Gm-Gg: ASbGncvZbv+gmIJoRWr16/knMjn4JtGbe/wNcJMgrINMofJJ/o1yst+2vqsWxePeLXT
	afyjSwiNVFX9/i5ENGdVpwvySssh6FyZK1udG9bSG0hHbUlmkJJpj5I/wjKGWV5jEUk1QJd0LZZ
	8Z2ky0LKmsFBdYGYL7zvCvWfourk1u+cOjc7O5DWkQ78yEXBP4
X-Google-Smtp-Source: AGHT+IHX+RLtkAyFXfCCwJvsB7FXqs2T++5aqezs/ZM9C6DcovLr8jbPDrc0RmXaKbeQjrVGqP5+hsJV4ddEhccdJyc=
X-Received: by 2002:a5d:47aa:0:b0:39c:cd5:4bc0 with SMTP id
 ffacd0b85a97d-39efbaf70bfmr13250986f8f.52.1745342933260; Tue, 22 Apr 2025
 10:28:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1745250534.git.iecedge@gmail.com> <73fdbbf9aafd3e24e12bb58f89c70959fb3a37f1.1745250534.git.iecedge@gmail.com>
In-Reply-To: <73fdbbf9aafd3e24e12bb58f89c70959fb3a37f1.1745250534.git.iecedge@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 22 Apr 2025 10:28:42 -0700
X-Gm-Features: ATxdqUFNF7npKiSkLt4UNdkUZRCVdnqqXcfQWuiSBdYWZe7QzjVRWlvmeYgHCog
Message-ID: <CAADnVQ+m8F0BsJr_T1ePpB_zQ2vS+3OD2h+Wrfv1x+an9fSLkw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/2] Enhance BPF execution timing by
 excluding IRQ time
To: Jianlin Lv <iecedge@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Benjamin Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, LKML <linux-kernel@vger.kernel.org>, jianlv@ebay.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 6:47=E2=80=AFAM Jianlin Lv <iecedge@gmail.com> wrot=
e:
>
> From: Jianlin Lv <iecedge@gmail.com>
>
> This commit excludes IRQ time from the total execution duration of BPF
> programs. When CONFIG_IRQ_TIME_ACCOUNTING is enabled, IRQ time is
> accounted for separately, offering a more accurate assessment of CPU
> usage for BPF programs.
>
> Signed-off-by: Jianlin Lv <iecedge@gmail.com>
> ---
>  include/linux/filter.h | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index f5cf4d35d83e..3e0f975176a6 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -703,12 +703,32 @@ static __always_inline u32 __bpf_prog_run(const str=
uct bpf_prog *prog,
>         cant_migrate();
>         if (static_branch_unlikely(&bpf_stats_enabled_key)) {
>                 struct bpf_prog_stats *stats;
> -               u64 duration, start =3D sched_clock();
> +               u64 duration, start, start_time, end_time, irq_delta;
>                 unsigned long flags;
> +               unsigned int cpu;
>
> -               ret =3D dfunc(ctx, prog->insnsi, prog->bpf_func);
> +               #ifdef CONFIG_IRQ_TIME_ACCOUNTING
> +               if (in_task()) {
> +                       cpu =3D get_cpu();
> +                       put_cpu();
> +                       start_time =3D irq_time_read(cpu);
> +               }
> +               #endif
>
> +               start =3D sched_clock();
> +               ret =3D dfunc(ctx, prog->insnsi, prog->bpf_func);
>                 duration =3D sched_clock() - start;
> +
> +               #ifdef CONFIG_IRQ_TIME_ACCOUNTING
> +               if (in_task()) {
> +                       end_time =3D irq_time_read(cpu);
> +                       if (end_time > start_time) {
> +                               irq_delta =3D end_time - start_time;
> +                               duration -=3D irq_delta;
> +                       }
> +               }
> +               #endif
> +

This is way too much overhead.
This timing loop is optimized to measure bpf prog runtime.
See commit ce09cbdd9888 ("bpf: Improve program stats run-time calculation")
IRQ can happen and distort the numbers, but you shouldn't
be running with bpf_stats_enabled for a long time.
You need to sample it instead.
Every couple minutes turn it on for a second, capture the stats
and aggregate over time. Filter out outliers due to IRQ or whatever.


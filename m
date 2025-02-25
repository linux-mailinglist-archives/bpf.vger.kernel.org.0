Return-Path: <bpf+bounces-52472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A906A4323E
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 02:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7034F7A3BF1
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 01:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC80363CB;
	Tue, 25 Feb 2025 01:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0PZ3QMA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB556610D
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 01:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740445595; cv=none; b=e25axQPWBUbvb+7YOhbb1hscxj9WbkCvJhxjZnmHbKagEDRCM2oPsp+q8n2XcRX667EylzAhxHqHWXP+z+9N2y7scE7yCCX2uIW1ong6Uw0rndT7UBs66KFk890g2NTQUgjVfj38JuSm4yvlXUlofM67AiLN+XoNAD4FfdQyzRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740445595; c=relaxed/simple;
	bh=ZjYGc3u7hUAxe+K6E8f4K2NtEWnQYo1I0UL39P/B0CI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ANQrZ1zlnL6rKfvez9DMd0+SZSzH8BGDHoMmoLzy6T8c/ubjI5a5OvWvnA0E6X/yIUV2fYHqtJ5qs0LgCszBngyrSsDCwiFkEuVUWQuOUsEhID1N29k6/fpLxdN/Hb1fKIW5FdsrWWKG77elURdWqzwiIVdJ4m4MnYN67kYngX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0PZ3QMA; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fc4418c0e1so10384410a91.1
        for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 17:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740445593; x=1741050393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFwbLY1xqipT52L9m4sdOpuvbhDwsVKHhxi89YiBIIM=;
        b=g0PZ3QMAecKs/8Ky2iC8kPycp7oxhOH8O5wY/i9Qkk3Dmsw3RHVTTl9q5wvLDGeA/4
         U2h06fdHi+D5IzCEm94Umfs4IPbV9iZiWXg5lmaz8t6KraZU+UTRVglUMKWgvx5D93yh
         20x3A1x16hMcsNjtuBet3N/IpCmIgd2IWcR2fud7pixSTkUa40Cgo+3DQEMOsoGQpmu/
         xTMt+zmUKeyzpKyEzEui/UXt8ZPatAtG8IC6mvCMotvQb/yhuiTIIqB3SQXiEwbLvn8p
         mxi04NzI0YoM9322YvNLLvp8Mluoscb6lb7xJMJIc/HlWepBs7bz+Q8fPN1IvheBof3m
         QCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740445593; x=1741050393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFwbLY1xqipT52L9m4sdOpuvbhDwsVKHhxi89YiBIIM=;
        b=glMAAuv88n/ihOfwbM1Y+tprBm1y6yUTo5ZJbHIH5zO6nRcDnUKxJU0CgAKn2PwGP6
         eRWkRBwhZA1lWxc1dN9PZgKEaMYuR0w/dFJrw2pF5vCvE1CsfN/6wWE+Ktq0MSD115HX
         7/kTH0OD+jrnaVsz8iSgH8cYiv6UaLAuDGRltrQHh2hdclsouaCkaSnatEaZC/txiy/A
         B+7Z44YtFYz3wzikn/0lI3xCi7TzFmj1QI83eL0fdO6nEKpX6hQDSoEK+N40ZTErtZ1e
         Kuarw2Ytxbph5QcDY3Ik6susU3LHRbt8lY4uOCh3oWu1TSoG+RCpocLWtxTCKfPsbfPv
         cnTg==
X-Gm-Message-State: AOJu0Yw7h8DNRyHVkrt38QCt0TwXhg1gWFNOOvXRYnhBqIMgoa68We2V
	UYD7K0zysKaP0xTENqxKHv5EihZpiPgvQ6CO3L6xBrfUwdibvmHMGz52FxvnQbX7ided1egSVXo
	eJks+VBDSLJwYutPCYgo4/ECNPfoLV7A8
X-Gm-Gg: ASbGnctus3Md7w1LJDKGnFxKPQlgMTCM0s5RmLWIVsXbRkb+kauGrlsOBCDDk9EzUxv
	kl50lAIdlP09L8Ev3CrCMUNJ5D8xiFI8PBLfcIZ6hQU0IOwkwRW5nuTXAWtp0VErnV9QxHBczE0
	ZBXwlcDUbgDaBF68HtoTC860o=
X-Google-Smtp-Source: AGHT+IE8eS0aOM8cdGdcK1F2saKS93Pv1dCYydyeP7atJzxdQ1Hbqz2mx0RzeMGFo4WnkxAmy3QpddfI8zWr8bCH04U=
X-Received: by 2002:a17:90a:c105:b0:2fb:fe21:4841 with SMTP id
 98e67ed59e1d1-2fccc117c76mr36031879a91.8.1740445593181; Mon, 24 Feb 2025
 17:06:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224221637.4780-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20250224221637.4780-1-alexei.starovoitov@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 24 Feb 2025 17:06:21 -0800
X-Gm-Features: AQ5f1JqyjUG3eA9KIxEr5I2b13iWnWqKh7P6XgGu_KOcnC0dQ3qvBFudxjA7_JA
Message-ID: <CAEf4BzZ1GHkBBu73aeyBRQ3MZ9Lp0ar7FKBrk5F-fAOJXxDhEg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix deadlock between rcu_tasks_trace and event_mutex.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com, 
	kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 2:16=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Fix the following deadlock:
> CPU A
> _free_event()
>   perf_kprobe_destroy()
>     mutex_lock(&event_mutex)
>       perf_trace_event_unreg()
>         synchronize_rcu_tasks_trace()
>
> There are several paths where _free_event() grabs event_mutex
> and calls sync_rcu_tasks_trace. Above is one such case.
>
> CPU B
> bpf_prog_test_run_syscall()
>   rcu_read_lock_trace()
>     bpf_prog_run_pin_on_cpu()
>       bpf_prog_load()
>         bpf_tracing_func_proto()
>           trace_set_clr_event()
>             mutex_lock(&event_mutex)
>
> Delegate trace_set_clr_event() to workqueue to avoid
> such lock dependency.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  kernel/trace/bpf_trace.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>

There is a tiny chance that bpf_printk() might not produce data (for a
little bit) if the time between program verification and its
triggering right after that is shorter than workqueue delay, right?
It's probably negligible in practice, so lgtm

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index a612f6f182e5..13bef2462e94 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -392,7 +392,7 @@ static const struct bpf_func_proto bpf_trace_printk_p=
roto =3D {
>         .arg2_type      =3D ARG_CONST_SIZE,
>  };
>
> -static void __set_printk_clr_event(void)
> +static void __set_printk_clr_event(struct work_struct *work)
>  {
>         /*
>          * This program might be calling bpf_trace_printk,
> @@ -405,10 +405,11 @@ static void __set_printk_clr_event(void)
>         if (trace_set_clr_event("bpf_trace", "bpf_trace_printk", 1))
>                 pr_warn_ratelimited("could not enable bpf_trace_printk ev=
ents");
>  }
> +static DECLARE_WORK(set_printk_work, __set_printk_clr_event);
>
>  const struct bpf_func_proto *bpf_get_trace_printk_proto(void)
>  {
> -       __set_printk_clr_event();
> +       schedule_work(&set_printk_work);
>         return &bpf_trace_printk_proto;
>  }
>
> @@ -451,7 +452,7 @@ static const struct bpf_func_proto bpf_trace_vprintk_=
proto =3D {
>
>  const struct bpf_func_proto *bpf_get_trace_vprintk_proto(void)
>  {
> -       __set_printk_clr_event();
> +       schedule_work(&set_printk_work);
>         return &bpf_trace_vprintk_proto;
>  }
>
> --
> 2.43.5
>


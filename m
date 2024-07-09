Return-Path: <bpf+bounces-34299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ED892C522
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 23:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2E901C22027
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 21:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25E3182A6E;
	Tue,  9 Jul 2024 21:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDVc2Ao9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EBF12E1E9
	for <bpf@vger.kernel.org>; Tue,  9 Jul 2024 21:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720559222; cv=none; b=eRrG+hhst/pOTue5HQyJuo+1x78TOud+li1YtrrU87Gg3x5PzNuvTKC8jpa7sKuin2soKJb5KwK+ZE1/L0S3byB6VuCB+7l4Iuckw8PUKIv3OBHYGcexLsQMB8EnltxbCIV4U3hHI2hccXSo6+5Ej+9anIU21bvx/ElqPjoxQvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720559222; c=relaxed/simple;
	bh=4x/suYjT3LrvXsPMSvOEWOMgQ5gpmln+c7PDcKivc6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E8ozHNudOk1eQ9zeVSUNCF8sTVkoSCCuu3C599eZIQeHQW8wOAqakBTU9uLJotYTW5Icywj6anRqe6TAKUKeX84tm1Ur8gf6TonzuKrvMkdiFYwqean4aZjoFU0EaO6JwcVgTSDi6Ash6HVOLl5WjXPfg6ve/kJV97NcbAquPb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDVc2Ao9; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-a77c1658c68so597917666b.0
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 14:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720559219; x=1721164019; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sME2XSRIO5WzCPdqu7hjSfrXx2FjItoOVCWgQNF3Xdg=;
        b=ZDVc2Ao9dhiP+YWuWLcUD5/IVii3Tbr4JtnwKYT/++pMNb4KbATtNVP5ZEK75LdQip
         k0vH+HfDExtdUfmEJPPHo5nd0U15DNl+wP/9AzTDUliIym3eTFPIhFgFfBudbAuFGz3c
         LumW4aTjl1NA3DDwGFe+CqFtN0yj4/xcNIGsmTnMbpYdVBcSmCWO4WzV3HSe8FbLjTt9
         1x6NS61RvfKDmTJk3xSP/4r373284kqzp7s1w9ESnqYCCfZ0RdgQU/AFfN3mKsACds65
         j/Hct1tPsWLFW6mvLoeiT0Dx6TJcALNzcWFb5krXuoiqRSjHNrm0FFW33t5g5WDbjlB6
         +jFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720559219; x=1721164019;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sME2XSRIO5WzCPdqu7hjSfrXx2FjItoOVCWgQNF3Xdg=;
        b=WBYEsUdl8Z9ueiI6jf+LyqBpVkJIerMNOiJD3Ux1aXzmJji5ErV/ym/Tq4csxO9BwR
         mdzNEkbaXv+XRf4KFHyCjUp16k+Al+o1gC9A5OHeUQZFu8hxGa8iaDdxzVKkpy/NDDwd
         XaXUYxZZogGY0WDBEuiKJGi6VO36B+umfUv9OozB8fCX5Y9ykvR94OiHf5LiuUm9b7Zy
         NSNSPtTRJ4tv0/dNW6Ydgc7rm9Ja7MuqEnUmmrHx4CNcao/81HQkDun/Kz7f/wFr9rbl
         WS00xP8ETznaHtsnR+xP3ksTsPgbciVdInPCK6zTX0h3YGfzNrKYv7iRWNl1GwM2ada9
         4pAA==
X-Gm-Message-State: AOJu0Yy6VPUOA48deH1EA3kI62lp4V3F/gjncw8LAQHBrk+MQ7juX0pJ
	VfrlyHI/iD7QQkhZ8N92OKArjsdncRk2ycmX7wXK8zAK6zaGRlSQQOqQ+bf0qTqqgKO9PB1zT3b
	w2kwvYQJIRVBmMy2vQACdelcBkhd/KBMy
X-Google-Smtp-Source: AGHT+IGevfsvytVF1QZ52LG9BsqGnA1SNiHO4K34P61SQ5UZMeYdax6VjQIaWL9qKiK7Dm2BDZsQRSLHmGA+KLXQjuI=
X-Received: by 2002:a17:906:c007:b0:a72:6f10:52da with SMTP id
 a640c23a62f3a-a780b8848d0mr240180966b.59.1720559218485; Tue, 09 Jul 2024
 14:06:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709185440.1104957-1-memxor@gmail.com> <20240709185440.1104957-4-memxor@gmail.com>
In-Reply-To: <20240709185440.1104957-4-memxor@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 9 Jul 2024 23:06:22 +0200
Message-ID: <CAP01T77vmSEZ=cgb499s1jP1Usjdz6yR2C2W9jXDOMi9arg7Hg@mail.gmail.com>
Subject: Re: [PATCH bpf v1 3/3] selftests/bpf: Add timer lockup selftest
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Dohyun Kim <dohyunkim@google.com>, 
	Neel Natu <neelnatu@google.com>, Barret Rhoden <brho@google.com>, Tejun Heo <htejun@gmail.com>, 
	David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jul 2024 at 20:54, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> Add a selftest that tries to trigger a situation where two timer
> callbacks are attempting to cancel each other's timer. By running them
> continuously, we hit a condition where both run in parallel and cancel
> each other. Without the fix in the previous patch, this would cause a
> lockup as hrtimer_cancel on either side will wait for forward progress
> from the callback.
>
> Ensure that this situation leads to a EDEADLK error.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/timer_lockup.c   | 65 ++++++++++++++
>  .../selftests/bpf/progs/timer_lockup.c        | 85 +++++++++++++++++++
>  2 files changed, 150 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/timer_lockup.c
>  create mode 100644 tools/testing/selftests/bpf/progs/timer_lockup.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/timer_lockup.c b/tools/testing/selftests/bpf/prog_tests/timer_lockup.c
> new file mode 100644
> index 000000000000..73e376fc5bbd
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/timer_lockup.c
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +#include <sched.h>
> +#include <test_progs.h>
> +#include <pthread.h>
> +#include <network_helpers.h>
> +#include "timer_lockup.skel.h"
> +
> +long cpu;
> +int *timer1_err;
> +int *timer2_err;
> +
> +static void *timer_lockup_thread(void *arg)
> +{
> +       LIBBPF_OPTS(bpf_test_run_opts, opts,
> +               .data_in = &pkt_v4,
> +               .data_size_in = sizeof(pkt_v4),
> +               .repeat = 10000,
> +       );
> +       int prog_fd = *(int *)arg;
> +       cpu_set_t cpuset;
> +
> +       CPU_ZERO(&cpuset);
> +       CPU_SET(__sync_fetch_and_add(&cpu, 1), &cpuset);
> +       ASSERT_OK(pthread_setaffinity_np(pthread_self(), sizeof(cpuset), &cpuset), "cpu affinity");
> +
> +       while (!*timer1_err && !*timer2_err)
> +               bpf_prog_test_run_opts(prog_fd, &opts);
> +
> +       return NULL;
> +}
> +
> +void test_timer_lockup(void)
> +{
> +       struct timer_lockup *skel;
> +       pthread_t thrds[2];
> +       void *ret;
> +
> +       skel = timer_lockup__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "timer_lockup__open_and_load"))
> +               return;
> +
> +       int timer1_prog = bpf_program__fd(skel->progs.timer1_prog);
> +       int timer2_prog = bpf_program__fd(skel->progs.timer2_prog);
> +
> +       timer1_err = &skel->bss->timer1_err;
> +       timer2_err = &skel->bss->timer2_err;
> +
> +       if (!ASSERT_OK(pthread_create(&thrds[0], NULL, timer_lockup_thread, &timer1_prog), "pthread_create thread1"))
> +               return;
> +       if (!ASSERT_OK(pthread_create(&thrds[1], NULL, timer_lockup_thread, &timer2_prog), "pthread_create thread2")) {
> +               pthread_exit(&thrds[0]);
> +               return;

A goto out: timer_lockup___destroy(skel) is missing here and above
this. Will wait for a day or so before respinning.

> [...]


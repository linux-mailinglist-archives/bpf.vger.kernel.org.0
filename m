Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9D13A8996
	for <lists+bpf@lfdr.de>; Tue, 15 Jun 2021 21:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhFOTgl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Jun 2021 15:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhFOTgk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Jun 2021 15:36:40 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F173AC061574
        for <bpf@vger.kernel.org>; Tue, 15 Jun 2021 12:34:35 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id r5so96606lfr.5
        for <bpf@vger.kernel.org>; Tue, 15 Jun 2021 12:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Njqzng99kcjuB+MO3j3ZJSHd2FVA4YrNOTWJJbAlKPY=;
        b=aB8s11Q6tDlsckmjIoWh9vftyAS1Mu/Sqs2LHDjQBaaYDhFXsKb1DQRzEAHdc5I2Yo
         Q13eyfAnDyZpJYzmNTgCP5UCaxB/12+4XVAjcYIIXTaRRrrgBnZJ79f+ghXASNQESJvZ
         le7akAg8cYP/DrCtPgczgWEhTeaKbmaxFI0GSEp3D54Az9F+gUy/YqhbD48ac5MsyIFG
         YavrrqoJql+iUzTEFBSrzE+mt0rhvmS7EKgutDdjfwqYfiDaJe8FYMLq7jzhrxAVTTee
         YdYL1iCVMWKcg+P4j8HlCqqP6p80p8T6tQDht+DBcrRLcRcHHY4PLdueOubOh6d2ZnX3
         Gz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Njqzng99kcjuB+MO3j3ZJSHd2FVA4YrNOTWJJbAlKPY=;
        b=e+TaLJhRLi2Tk3PXekVPdB8iA5awlQVRCiFdcGSFIL4IyxnjmnN/6lelpQItR8RopF
         YbZp+tPpYZONSqvqCARQD+dfVtT6GgVC6EBPRKOQtUFzZNxDMQTxLkNDmCkovdK0xXt4
         syC+PelOAFXzGgLygiIpFkHdDE+88PDyR2H7x7YNfRFGQMixmmtNRfxJCKHXrW/3aQoS
         V33Wy88tch4d/dqU5OXtRRfpG/3SCHNUgNpQHLLOEVWbI6DZv5jSd5ZWiH9mRr/TD+Ud
         wod0VFv9opoLTaM9enpXQ4ZlOIcHZdEX5UjtAk09+6pkYCFdbsfD5JeicS6YeDmMvz4f
         IKNg==
X-Gm-Message-State: AOAM5322D3QtuArsts0rmMA0MYItzrXuKdlNSOhidXDrf+WYN7IAdI4t
        HIklvY0Yf4fGkkrfl19xaOLd2A9nJdDBW4O4qrA=
X-Google-Smtp-Source: ABdhPJzFrLuWfK0ZzBkZ1Evhgi5xx34TOsHS6qBWVHJ5ZDbjYmqSr6Qnt8xyLWyAyXcAQwBiJZQotLS3sVVWS7pnUhQ=
X-Received: by 2002:a05:6512:39ca:: with SMTP id k10mr683974lfu.473.1623785674328;
 Tue, 15 Jun 2021 12:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAOWid-drUQKifjPgzQ3MQiKUUrHp5eKOydgSToadW1fNkUME7g@mail.gmail.com>
 <20210604061303.v22is6a7qmlbvkmq@kafai-mbp> <f08f6a20-2cd6-7bf0-c680-52869917d0c7@fb.com>
 <CAOWid-f_UivcZ1zW5qjPJ=0wD1NM+s+S9qT6nZuvtpv0o+NMxw@mail.gmail.com>
 <CAOWid-eXi36N7-qPHT0Or9v5OBbhYx6J5rX3uVbVQWJs_90LOg@mail.gmail.com> <ad426c37-d810-1d1b-91d8-6d9922ba52f0@fb.com>
In-Reply-To: <ad426c37-d810-1d1b-91d8-6d9922ba52f0@fb.com>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Tue, 15 Jun 2021 15:34:14 -0400
Message-ID: <CAOWid-evaph=7b2GW+oj=38Hv1cHgdwya9A8XqL2eS5n3oL6yw@mail.gmail.com>
Subject: Re: Headers for whitelisted kernel functions available to BPF programs
To:     Yonghong Song <yhs@fb.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 9, 2021 at 2:42 AM Yonghong Song <yhs@fb.com> wrote:
> So your intention is to call functions in
> drivers/gpu/drm/drm_gem_ttm_helper.c, right? How do you get function
> parameters? What kinds of programs you intend to call
> this functions?
ok... sounds like my use case was not concret enough.  Perhaps I can
elaborate further with the following examples:

In the GPU scheduler, there's a trace point
"trace_drm_run_job(sched_job, entity)":

https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/scheduler/sched_main.c#L813

If I want to analyze the jobs being scheduled, I can potentially
attach a bpf prog with this tracepoint.  Each driver has its own
run_job and sched_job implementation so I was thinking the drivers can
provide a bpf helper function to resolve this.  Alternatively, there
could be tracepoint in the driver implementation that one can attach
bpf to, but tracepoints are not universally put in place (have trace:
https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c#L221;
not have trace:
https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/etnaviv/etnaviv_sched.c#L72
.)  So in cases without tracepoint, I guess I would be using kprobe or
fentry?

Note that all of these are in kernel modules.  My understanding is
that BTF will work but having helper functions from the kernel modules
are not yet available?  So let say I want to whitelist and call "
amdgpu_device_gpu_recover"
(https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c#L4521)
from inside a bpf prog, or whitelist and call
"drm_sched_increase_karma"
https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/scheduler/sched_main.c#L362,
I wouldn't be able to do so?  Are there any criteria in terms of what
kernel function should or should not be whitelisted (separate from the
kernel module support question)?  For example, would
amdgpu_device_gpu_recover be not "whitelist-able" because of the hw
interaction or complexity or likelihood to crash the kernel while
drm_sched_increase_karma is ok because it's more or less manipulation
of some data structure?

A quick side question, does container_of work inside a bpf prog?

> kprobe probably won't work as kernel does not capture
> traced function types. fentry program might be a good
> choice.
Thanks for the pointer.  I am not familiar with fentry but I will look
into it.  By function type, what do you mean by that?

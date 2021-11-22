Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDE84596D2
	for <lists+bpf@lfdr.de>; Mon, 22 Nov 2021 22:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhKVVkH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 16:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbhKVVkG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Nov 2021 16:40:06 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E23C061574
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 13:36:59 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id y68so53888152ybe.1
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 13:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lnn+trbCmDvWfhrUaViIuCQbu204ZuhZR0K7OqBujYY=;
        b=QdF/LYdgagvStv/97KUvcz1YBUUdmvvzQtWDd47O+IFp7a9cCxcKgaQVxVy4xVA5qb
         HvlQSwRXQW8rAN+pMYEZZkRkTy4fjEB8nmWUwBBb+G5A3k8q/Cg9V2SXFPYREXIry+Zj
         oihMc2d7KZpnMihjIG8U6ioZxQ0OlTQYjuhGPIreeI6wwleM29rKcbniU2ffc+rP9klG
         0t7dIeWeNChpRN+1qBeofZtwupPhceP0c+eVKNKiT1gxT7WAvuyySWDGtFHD/8imq7xK
         5+9hrsOOTE0mtUSIXrF0HB9vHZWPH8Cxpd+380o+XW4I2/yUha6zNKIsJW05a0/O35/A
         fLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lnn+trbCmDvWfhrUaViIuCQbu204ZuhZR0K7OqBujYY=;
        b=E3SrnessLgdjQa614gCg8OtHIEU/VWJh2CraUr1VH/gM/nSK9l0cGfFR1rU9qFeGUT
         Bt/aON/PRFNepJuxygpLDMT8pL9xZFa+aCUm0Pc3HfTCOBbQi++OtwesVDNcvSGoAIIt
         3K90SAP2WMG4VEeN8KNPct8awQcPawNQhzEIsNv4z0O5xHIhv9unp6VpOA+kKWqRkkbs
         RA4WOL9jsI0HmxhyUV+fTjjTqOpuC+Xb7qeeFF4PkYKKxqZGhWqo4hbcemGnBhXdaEt+
         rtpA5NyDfCB0Zu6z3khL+tfnpA+yPzBQvVCefpbNZOMwfMjjnWs/I8Gui0Mvnh7f/FYH
         rsBQ==
X-Gm-Message-State: AOAM533aR2yuPTVgSieoZDKvIEyM8amWQonCayqpbCp0GfE2SljU65pG
        J3egJBuyyNz5St+HUY4hU2fW9wLFJZHxI4RDOAc=
X-Google-Smtp-Source: ABdhPJwSzCiUl0bjO1xFoolrn4M6Lt0+u6Fq75oM5Av6kRuc3enCaAT1LKp9hdt7PG8CKE/SiqkDjBLPakWILoLFCSM=
X-Received: by 2002:a25:42c1:: with SMTP id p184mr155790yba.433.1637617018421;
 Mon, 22 Nov 2021 13:36:58 -0800 (PST)
MIME-Version: 1.0
References: <20211120033255.91214-1-alexei.starovoitov@gmail.com>
 <20211120033255.91214-4-alexei.starovoitov@gmail.com> <CAFnufp1ncBbD=K3bJxjzLNCg-VgHeQruJTdVE+9rj+E85+kc9w@mail.gmail.com>
 <CAADnVQLA-A2WiEjFUpEMebz_W=4mdzFYX-K0VYG1Ny_2uUyYVg@mail.gmail.com>
In-Reply-To: <CAADnVQLA-A2WiEjFUpEMebz_W=4mdzFYX-K0VYG1Ny_2uUyYVg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 22 Nov 2021 13:36:47 -0800
Message-ID: <CAEf4BzZmiAX60dGZv8Pyqjus0r6KQbYgWiSDWGKrNnCt7iKZAg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 03/13] bpf: Prepare relo_core.c for kernel duty.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Matteo Croce <mcroce@linux.microsoft.com>,
        David Miller <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Nov 20, 2021 at 8:24 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Nov 20, 2021 at 7:27 AM Matteo Croce <mcroce@linux.microsoft.com> wrote:
> >
> > On Sat, Nov 20, 2021 at 4:33 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > Make relo_core.c to be compiled for the kernel and for user space libbpf.
> > >
> > > Note the patch is reducing BPF_CORE_SPEC_MAX_LEN from 64 to 32.
> > > This is the maximum number of nested structs and arrays.
> > > For example:
> > >  struct sample {
> > >      int a;
> > >      struct {
> > >          int b[10];
> > >      };
> > >  };
> > >
> > >  struct sample *s = ...;
> > >  int y = &s->b[5];
> >
> > I don't understand this. Is this intentional, or it should be one of:
> >
> > int y = s->b[5];
> > int *y = &s->b[5];
>
> Eagle eye. I copy pasted this typo from libbpf.
> Will fix in all places at once either in a respin or in a separate patch.
> For the purpose of the example it could be either.
> int *y = &s->b[5]; is a relocatable ADD.

I think this was the intention (getting address in CO-RE-relocatable
way) at the time, we didn't yet have the direct memory access that
fentry provides. So that `int *` was intended to be then passed to
bpf_probe_read_kernel().

Now both options would work, but the first one only works in
fentry/fexit and similar program types.

> int y = s->b[5]; is a relocatable LDX.

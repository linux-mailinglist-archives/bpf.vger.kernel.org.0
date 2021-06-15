Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27763A88EC
	for <lists+bpf@lfdr.de>; Tue, 15 Jun 2021 20:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhFOSzb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Jun 2021 14:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhFOSza (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Jun 2021 14:55:30 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CA8C0617AF
        for <bpf@vger.kernel.org>; Tue, 15 Jun 2021 11:53:23 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id i4so22032396ybe.2
        for <bpf@vger.kernel.org>; Tue, 15 Jun 2021 11:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BmNxKBmhcmIv04npyGlwS8x8LpMH1wmnYFET2WEI0zw=;
        b=uPJXiwocBvyHRIgOZA1GPNpy7xcrxCbO18a86jT7c6uNn+yGCV69kNn1snR3BpqRxp
         CvCR+CJ7TOaR26YySU4V/BRzVXHd0z8om3fEPmrlSnDkVmGImecEFnjYhgJT/rFCziof
         HuhOeD6TIVhSO/NQ7P9OrHQIvwo2RQN8LF/3YesCqhRYk3VI2JttqBSDzSPhcYYSyavM
         NoNXgOtEhA1caF5MlpvLW+uQ6QQb8qFCEi8GYbXx0RfscyeReZX6rrwm+YtjxkOAZ7j4
         eZrrxYK065ptYS/IYyZlcpHupZ6gvVwq71g5rILkRTkIr5qfkGECmAShPImpVoi6ppHW
         icgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BmNxKBmhcmIv04npyGlwS8x8LpMH1wmnYFET2WEI0zw=;
        b=bIlw7lh/E8CnzZTXz3Cfe5ECq0+nPgn0/zPvVe3h2NePSRhYaVVA+dEpI834qfwwJl
         rJcu+QzD2W3pcrMDe/42Sg08rcJHsHf06n4XZZYzv96EnsgSVcJW3qXw2EmR0YB319Su
         DMGmzysHJnlzhHkAKz72h+nxuMWVlScVKfpS35KHUxMfk0FfJ2wpq2UcD1bPd9aqpJmO
         pmc6YGWiWxa2t+NnDx+sFc2znGcTUc2MVhLq4MrpPLxO5F3UUx87GF5WIq1C/QHtsaa8
         E9rGIEwRgByVctXy07WCbrw2dS4gwwW//V9s36ryLAX+HzqB1f3PiCxjLEI1Bn82jD05
         wrwg==
X-Gm-Message-State: AOAM530LaKaX4iBHTodADJwVLkopqM2kAi8488T2WMiPl6PTLRgCNyGz
        MMTemYSqdYbisffQkizGNmNKArOdQmIZdT4lVTo=
X-Google-Smtp-Source: ABdhPJxZj5DCL03s/PpKjM6IQqsC/CMgyy3R86C5QU8ppQXRlKjnyidOXohiqflzXH69chTZo9nkkAy9sZ4oyjOzBQ8=
X-Received: by 2002:a25:7246:: with SMTP id n67mr829269ybc.510.1623783202289;
 Tue, 15 Jun 2021 11:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210610161027.255372-1-lmb@cloudflare.com> <CAEf4BzZDDuyybofAjxm8QG9VYFMGAF8gZ9g-rnoD1-8R_9LExw@mail.gmail.com>
 <CACAyw9-UbOD_H5=KfscPHzwOHL13nTUpojhtQnOTNJpTS-DVzQ@mail.gmail.com>
 <CAEf4BzbFhGkRi0YSa0pB+2SFYtJKXLEVKx=hQpVbBO_D4KUjtQ@mail.gmail.com> <CACAyw9-0qDakujnUBT3uZcgnBZr0dZ8o=GbLx_OEiF1xXvRdzQ@mail.gmail.com>
In-Reply-To: <CACAyw9-0qDakujnUBT3uZcgnBZr0dZ8o=GbLx_OEiF1xXvRdzQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 15 Jun 2021 11:53:11 -0700
Message-ID: <CAEf4Bzb8piZg29fTpfSqUPEE69hHEqdnFbYHN-bp3qEossLkww@mail.gmail.com>
Subject: Re: [PATCH bpf] lib: bpf: tracing: fail compilation if target arch is missing
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 15, 2021 at 3:11 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> On Tue, 15 Jun 2021 at 00:27, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > It doesn't seem avoidable. But I'm surprised you are satisfied with
> > your patch, it doesn't seem to solve your problem, because you'll
> > never trigger those _Pragmas as you'll just fallback to using your
> > host architecture. Isn't that right? How did you test your patch?
>
> I tested the patch by removing -D__TARGET_ARCH_$(SRCARCH) from
> BPF_CFLAGS in the Makefile. The pragmas are triggered because the
> testsuite compiles with -target bpf. This prevents the "host arch"
> fallback from activating. bpf2go specifies -target bpf(el|eb) as well,
> so any users will get the _Pragma if they use a new enough
> bpf_tracing.h.

Oh, I didn't realize  -target bpf will prevent host architecture
fallback. In that case we don't need a new #define, cool.

>
> > >
> > > Without it we sometimes get an integer cast warning, something about
> > > an int to void* cast I think?
> >
> > hmm.. ok
>
> This is the error I get:
>
> progs/lsm.c:166:14: warning: cast to 'void *' from smaller integer
> type 'int' [-Wint-to-void-pointer-cast]
>         void *ptr = (void *)PT_REGS_PARM1(regs);
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~

oh, ok, but then those zeros probably best to mark as longs, not long
longs (even thought for BPF it's the same), as (unsigned) long is a
logical equivalent of a pointer, right?

>
> --
> Lorenz Bauer  |  Systems Engineer
> 6th Floor, County Hall/The Riverside Building, SE1 7PB, UK
>
> www.cloudflare.com

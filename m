Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2183EBE8F
	for <lists+bpf@lfdr.de>; Sat, 14 Aug 2021 01:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbhHMXIl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Aug 2021 19:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbhHMXIk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Aug 2021 19:08:40 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6433AC061756
        for <bpf@vger.kernel.org>; Fri, 13 Aug 2021 16:08:13 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id z128so21681002ybc.10
        for <bpf@vger.kernel.org>; Fri, 13 Aug 2021 16:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2PP666ZhMDVeem1jITvuuu1K1Z/WKPN5/d2cEq2cQ8k=;
        b=RIgj6XNWJ7lzCBpoIk8lWdQC19tHNrV6EPmQlce+0vZqbEX7VYHMqFis4CCOYcSm8C
         6pQAGdKgrskIxYn28QZX+9qgfOoBMWEUVtKuA6KLzhaN4X12yQ7WqUcFQbDEbgh+Y/4m
         uxA/rLJxNr9Igaive+aSnJ/2O4ezZcQKh6OuDFGMz0xWFzGcqW0b/mnR5ffydXqNruyb
         PFqRqtc5jFxKkKVAvU4U9p/57rZtxPvLYf9Y9vPwhEboYo3+UxKqX5xQbM+0gQm4vxOq
         8UkaTVsDW9yrXW13WCDQTED3fhQ2EgJVlfBdlx7UBRHkydOYS+19+ZruLyplNl2vyp8Q
         tAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2PP666ZhMDVeem1jITvuuu1K1Z/WKPN5/d2cEq2cQ8k=;
        b=nKn3y4TNNvr4m94gifxixNntr8M3mCip+sWc7T5lepCNo34m/WIGBUoXSUsAfpYHqb
         Gldfx/acB+OSmNwYEc+yfpc5EgmJdGVrN/c6jF9utVcGmLW6oLzUxHarMUU03Po8JZqf
         R+Y6M9sbnIOZw6gfwqqwmV73sMkeuMrETnjjm/rPOw1nVmwCbOHH6XO+KWED+AdNwqsD
         v58Z8flw4bu4DEx9ym3Ju+1jNYG+zyGz2K62jUf3NDbVis/4xJarIq8T6J/vtMA1kTy2
         cG/xuseo4QKPzZs9rWxJJmtdDaiO1IS2UYxubEjjCuDoPNj0h8o32F/B5EJPaI4qSpKQ
         8kow==
X-Gm-Message-State: AOAM530YfVYPw6scuBpK/NQJaK9CfJHkgqKb+K0fuaTfr0NfMO4fSMrI
        kUtmnvAABNrasIw3g+QnP7Cxh6EuzqUJrzdq7l8=
X-Google-Smtp-Source: ABdhPJwl8s0591lBJGA4PsAd2b5qp+NvcskLSZy4rb2cLtPCpAKLOPUI9xbkY37rzGel8pGeOLxuh4EBwvDHv/Z04C4=
X-Received: by 2002:a25:bb13:: with SMTP id z19mr6461316ybg.347.1628896092749;
 Fri, 13 Aug 2021 16:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <HE1PR83MB038015B1D19B02219FB1315BFBFA9@HE1PR83MB0380.EURPRD83.prod.outlook.com>
 <bda97fe2-d8b5-2539-273e-275276947b49@fb.com>
In-Reply-To: <bda97fe2-d8b5-2539-273e-275276947b49@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 13 Aug 2021 16:08:01 -0700
Message-ID: <CAEf4BzaPAdRpQ7Pi-GxqRG1f_7+EmAZKu=FLNchO3EnnyFhrjg@mail.gmail.com>
Subject: Re: signal/signal_deliver and bpf_send_signal()
To:     Yonghong Song <yhs@fb.com>
Cc:     Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 13, 2021 at 10:20 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 8/13/21 2:57 AM, Kevin Sheldrake wrote:
> > Hello
> >
> > I have a requirement to catch a specific signal hitting a specific proc=
ess and to send it a SIGSTOP before that signal arrives.  This is so that t=
he process can then be attached with ptrace(), but without the necessity of=
 ptrace()ing the process continuously beforehand (due to performance and st=
ability reasons).  I thought this might be possible with an eBPF program at=
tached to a tracepoint.
> >
> > I attached a program to the signal/signal_deliver tracepoint and used b=
pf_send_signal() to send the SIGSTOP but it didn't stop the process.  If I =
sent SIGTERM or SIGHUP instead it worked as expected, just not SIGSTOP or S=
IGTSTP.
> >
> > Sending a SIGSTOP prior to another signal (eg SIGSEGV) works from userl=
and - the process stops and the other signal is queued.
> >
> > I'm guessing that the reason is that bpf_send_signal() adds the (non-st=
ate transitioning) signal to the process signal queue, ignoring SIGSTOP, SI=
GTSTP, SIGKILL, SIGCONT, but doesn't change the state of processes.  Can an=
yone confirm if that is correct or if there's another possible reason that =
bpf_send_signal seems to fail to send a SIGSTOP?  If so, is this documented=
 anywhere?  Is there another way to do this with eBPF?
>
> Kernel has SIG_KERNEL_IGNORE_MASK like below
>
> #define SIG_KERNEL_IGNORE_MASK (\
>          rt_sigmask(SIGCONT)   |  rt_sigmask(SIGCHLD)   | \
>          rt_sigmask(SIGWINCH)  |  rt_sigmask(SIGURG)    )
>
> So SIGCONT will be ignored for bpf_send_signal() helper.
>
> For other signals e.g., SIGSTOP/SIGKILL, there are some comments saying
> special processing might be needed. But I think they may still get
> delivered. If you use signal/signal_deliver when SIGSEGV is delivered,
> is it already too late to do bpf_send_signal() SIGSTOP since that
> will be processed after SIGSEGV? Note that SIGSEGV is already delivered?
>

Too lazy to read the code to know if this will work, but I'll ask
anyway. Would it work to do fmod_ret BPF prog right on the entry point
in the kernel where the signal is just starting to be processed, and
ignoring SIGSEGV completely? Then doing send_signal(SIGSTOP), and then
again for SIGSEGV?

So, intercept and cancel original signal, inject SIGSTOP, re-introduce
original signal?

> >
> > Many thanks
> >
> > Kev
> >
> > --
> > Kevin Sheldrake
> > Microsoft Threat Intelligence Centre
> >

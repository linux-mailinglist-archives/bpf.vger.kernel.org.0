Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8DF4276E5
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 05:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244171AbhJIDWt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 23:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbhJIDWs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 23:22:48 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F87AC061570
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 20:20:52 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id s64so25073561yba.11
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 20:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oq2TcWT8iJaNi/hy+9YOkxeS2TtuL51Eey32L1khk2g=;
        b=EMZE5j83QrQvvAlJjjwMU1QOtN8JmkD5zqR3Kgu2TThiFVi4e0RdWzLCcjB2TSsVsh
         S6EvaqbNcmTvjX6ijZnbqdZvExQYFogpzze5qbd6ya6WiHliLZ7CQiHBrVX5Ic/5ZTfe
         E4OijL4JOrtjywFhcyHR0BASHt3+nP5rVDJ5FKxHtZ+l9/V2I8C/H1sGUCdlZFmW0dvm
         jHSkd7Q6F9meNpYX0nbMsj2IDht3ozDhXvwINSWIq+pvshorbQFDPLOWICXX8h3cVdB7
         k1XKjygUVQQTBLJNAepz3x2JZe8Dmz0pufI4JPKgpfMbjfd3aWvIap9dx0UWXBt2tzYV
         zHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oq2TcWT8iJaNi/hy+9YOkxeS2TtuL51Eey32L1khk2g=;
        b=6qFfruxta3si5PNjl5F1d98hIeA4RoUD9aq3zsop+ZgmAEr1nbTC5BlnedEAn58KpO
         HSkayr8v0eBqvMexDltkVTZ8y/QpSl5XthcjQ7VzZPlfmJKcRMN3QBg8WRwmMDB+ctTK
         gaYkwJr9eTA4GSgV/a46zrRE8A7mp/paTKGLXvvpSqYsDbAd7DR3QC3CADhvGLooyPNF
         uMkWsCT/y9jkeqqlv2Apd/AJ9OSoWnvzLZeNyc7Qnfa/P741lFN7HVmeEPU5hjUxOhpP
         OFzs1UkTq/0sXxOSf23P4zsxnXteB9H1jeYSDWFUww2O3uNIteUuEB2Z/KylPa1z/KEW
         l1qg==
X-Gm-Message-State: AOAM531SrKRe/cSLts9008pZg7yAaeQvi0zEvkdWa0mB4v6t83TnmDMn
        b5D6nI0zEv+UZNqe8TuoZZLNtWye4LbHY9Y2cpeJ31dzF/Q=
X-Google-Smtp-Source: ABdhPJxk7hfINIKB3XGFyKiyECtvrblITxHoEkcGLEtlGScn2tKl5hVmTXCFd53JhYwQ5Nfm+7XjEqyR/1/gBo06RHQ=
X-Received: by 2002:a25:e7d7:: with SMTP id e206mr7244265ybh.267.1633749651668;
 Fri, 08 Oct 2021 20:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <20211006185619.364369-1-fallentree@fb.com> <CAEf4BzaE-vXu0zFi=ePTbRfZ=XMCV12oBAz+3p7QBa-E=CAdWw@mail.gmail.com>
 <CAEf4BzZAiZWfKEtc=1qpu8W+WQAcJ6L6BJOftCjjQbF6mzAeoQ@mail.gmail.com> <20211008193717.21d93a47@oasis.local.home>
In-Reply-To: <20211008193717.21d93a47@oasis.local.home>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Oct 2021 20:20:38 -0700
Message-ID: <CAEf4BzYCUZBmO6qY0VtUshnepVEGRn3Cfiiw4cbVmYBH7ztAUw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 00/14] selftests/bpf: Add parallelism to test_progs
To:     Steven Rostedt <rostedt@goodmis.org>,
        Jussi Maki <joamaki@gmail.com>
Cc:     Yucong Sun <fallentree@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yucong Sun <sunyucong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 8, 2021 at 4:37 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 8 Oct 2021 15:42:31 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > orgot to actually cc Steven, oops. Steven, I've run into the problem
> > when running a few selftests that do uprobe/kprobe attachment. At some
> > point, they started complaining that files like
> > /sys/kernel/debug/tracing/events/syscalls/sys_enter_nanosleep/id don't
> > exist. And this condition persisted. When I checked
> > /sys/kernel/debug/tracing in QEMU, it was empty. Is this a known
> > problem?
>
> The tracefs directory should automatically be mounted in the debugfs
> "tracing" directory when debugfs is mounted.

Yeah, we do that for our testing environment and it works reliably.
This time we started running a bunch of tests completely in parallel,
and in one case I ran into this situation that caused "permanent
damage". Unfortunately I haven't checked if debugfs is still mounted
or not.

Yucong mentioned that one of the selftests (tc_redirect.c) is
manipulating /sys mount, so I wonder if this could have caused some
consequences like this... Jussi, any idea?

>
> Does /sys/kernel/tracing exist?

Yeah, it was there, but was empty.

>
> -- Steve

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379C939E6E8
	for <lists+bpf@lfdr.de>; Mon,  7 Jun 2021 20:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhFGSyf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Jun 2021 14:54:35 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:40528 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbhFGSyf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Jun 2021 14:54:35 -0400
Received: by mail-ej1-f47.google.com with SMTP id my49so11684048ejc.7
        for <bpf@vger.kernel.org>; Mon, 07 Jun 2021 11:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nametag.social; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ScXrC8JzROe4oik0nKr4Zt97X1eNIvPR3vNcHFbWFVw=;
        b=zNYJK3b0Nb8HpGi/aABY5z2iapsdx7yAQtFWXWDFPJbKUfJQRiCc4K3VvQzVgBNVV7
         WmcbojERHJ6iCdEs9d2RqP7whPvdiFbmY/hEO9hD7unbLU1FJCZjPcn0fa3AXh17EJvt
         n1bDhfDzsCeih8kV5nUptWol/9UYaSzIPzwsjT6P4otB7wjamQ/cdTSrNoBOxdMm2TCw
         nzGkMLQXg75dYNSIbXaUv9J7X2nnp+CO2+Xss/4obDx7I5daox9uJ0pE142qL5X+MKzy
         svxWHQMtvw3F2N1yxMEHFRXR17tTdive8JPi5xi9sSzu7+c5DTerRO422bt36YGuJTMy
         v2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ScXrC8JzROe4oik0nKr4Zt97X1eNIvPR3vNcHFbWFVw=;
        b=m6zOqOs0mtUTFSs1maFvKTZ6YjyKMtaZICtYFIpwA8bdN4LWtTP91EQqKWpJ6p0VOW
         zt3YEV8iTNLpRkdAEZ0fNppdH72fxuaVl6UJmwW9B3Ppap5cXNYq+XF6YjRUOeED+DhF
         2oV+4cHqMwTDRzBZ3o7EjT7AMVGQHLUR3AHLjRL7JFWS3k+kPvfgo0+r4rMZrgoztClC
         bbhQRFdCziPDHwDYSnRqCtC8uwlQXXAIMx4etufREmiXZE4H76roEMY5TdT1T/MZ4j6g
         yAPV9gtQisCQVcjHZphbI+nOAvePjRyGAqaUlMOjdUU7hZrFHe7NcCAz4s4Ylo2bA6ms
         fs/A==
X-Gm-Message-State: AOAM530u+evaSdyFfDPV8thEOZxQ5lkgEGU34K0bUnYfUWQJPk8juPLh
        B4TSbbP5R3sfUQfWuL98g1Yt19/YMtFCsezcyWLVmg==
X-Google-Smtp-Source: ABdhPJzGcWFGWbIbsY89L7lxhJBfNHplKZCa8ow1UNqgMe/NUtgdE/5lRdP7v1aSFE5Cm6Z9w/5qLJg6WT/lTXHQNYY=
X-Received: by 2002:a17:906:c010:: with SMTP id e16mr19541841ejz.214.1623091890615;
 Mon, 07 Jun 2021 11:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <23168ac0-0f05-3cd7-90dc-08855dd275b2@gmail.com>
In-Reply-To: <23168ac0-0f05-3cd7-90dc-08855dd275b2@gmail.com>
From:   Victor Stewart <v@nametag.social>
Date:   Mon, 7 Jun 2021 14:51:19 -0400
Message-ID: <CAM1kxwjHrf74u5OLB=acP2fBy+cPG4NNxa-51O35caY4VKdkkg@mail.gmail.com>
Subject: Re: io_uring: BPF controlled I/O
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     io-uring <io-uring@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        lsf-pc@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jun 5, 2021 at 5:09 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>
> One of the core ideas behind io_uring is passing requests via memory
> shared b/w the userspace and the kernel, a.k.a. queues or rings. That
> serves a purpose of reducing number of context switches or bypassing
> them, but the userspace is responsible for controlling the flow,
> reaping and processing completions (a.k.a. Completion Queue Entry, CQE),
> and submitting new requests, adding extra context switches even if there
> is not much work to do. A simple illustration is read(open()), where
> io_uring is unable to propagate the returned fd to the read, with more
> cases piling up.
>
> The big picture idea stays the same since last year, to give out some
> of this control to BPF, allow it to check results of completed requests,
> manipulate memory if needed and submit new requests. Apart from being
> just a glue between two requests, it might even offer more flexibility
> like keeping a QD, doing reduce/broadcast and so on.
>
> The prototype [1,2] is in a good shape but some work need to be done.
> However, the main concern is getting an understanding what features and
> functionality have to be added to be flexible enough. Various toy
> examples can be found at [3] ([1] includes an overview of cases).
>
> Discussion points:
> - Use cases, feature requests, benchmarking

hi Pavel,

coincidentally i'm tossing around in my mind at the moment an idea for
offloading
the PING/PONG of a QUIC server/client into the kernel via eBPF.

problem being, being that QUIC is userspace run transport and that NAT-ed UDP
mappings can't be expected to stay open longer than 30 seconds, QUIC
applications
bare a large cost of context switching wake-up to conduct connection lifetime
maintenance... especially when managing a large number of mostly idle long lived
connections. so offloading this maintenance service into the kernel
would be a great
efficiency boon.

the main impediment is that access to the kernel crypto libraries
isn't currently possible
from eBPF. that said, connection wide crypto offload into the NIC is a
frequently mentioned
subject in QUIC circles, so one could argue better to allocate the
time to NIC crypto offload
and then simply conduct this PING/PONG offload in plain text.

CQEs would provide a great way for the offloaded service to be able to
wake up the
application when it's input is required.

anyway food for thought.

Victor

> - Userspace programming model, code reuse (e.g. liburing)
> - BPF-BPF and userspace-BPF synchronisation. There is
>   CQE based notification approach and plans (see design
>   notes), however need to discuss what else might be
>   needed.
> - Do we need more contexts passed apart from user_data?
>   e.g. specifying a BPF map/array/etc fd io_uring requests?
> - Userspace atomics and efficiency of userspace reads/writes. If
>   proved to be not performant enough there are potential ways to take
>   on it, e.g. inlining, having it in BPF ISA, and pre-verifying
>   userspace pointers.
>
> [1] https://lore.kernel.org/io-uring/a83f147b-ea9d-e693-a2e9-c6ce16659749@gmail.com/T/#m31d0a2ac6e2213f912a200f5e8d88bd74f81406b
> [2] https://github.com/isilence/linux/tree/ebpf_v2
> [3] https://github.com/isilence/liburing/tree/ebpf_v2/examples/bpf
>
>
> -----------------------------------------------------------------------
> Design notes:
>
> Instead of basing it on hooks it adds support of a new type of io_uring
> requests as it gives a better control and let's to reuse internal
> infrastructure. These requests run a new type of io_uring BPF programs
> wired with a bunch of new helpers for submitting requests and dealing
> with CQEs, are allowed to read/write userspace memory in virtue of a
> recently added sleepable BPF feature. and also provided with a token
> (generic io_uring token, aka user_data, specified at submission and
> returned in an CQE), which may be used to pass a userspace pointer used
> as a context.
>
> Besides running BPF programs, they are able to request waiting.
> Currently it supports CQ waiting for a number of completions, but others
> might be added and/or needed, e.g. futex and/or requeueing the current
> BPF request onto an io_uring request/link being submitted. That hides
> the overhead of creating BPF requests by keeping them alive and
> invoking multiple times.
>
> Another big chunk solved is figuring out a good way of feeding CQEs
> (potentially many) to a BPF program. The current approach
> is to enable multiple completion queues (CQ), and specify for each
> request to which one steer its CQE, so all the synchronisation
> is in control of the userspace. For instance, there may be a separate
> CQ per each in-flight BPF request, and they can work with their own
> queues and send an CQE to the main CQ so notifying the userspace.
> It also opens up a notification-like sync through CQE posting to
> neighbours' CQs.
>
>
> --
> Pavel Begunkov

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85AF5FE803
	for <lists+bpf@lfdr.de>; Fri, 14 Oct 2022 06:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJNEhA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Oct 2022 00:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiJNEhA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Oct 2022 00:37:00 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF65618C414
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 21:36:57 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id y72so3951184oia.3
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 21:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OnYLSD2OypS0Uent7BXmwBd+4DlgLNwAMehMf+rH4Xc=;
        b=tYgN7DxuXOQ4PsGCeAxogoF1GWVfRlNZ9Y7LzymSSSkJLzDEvNRtwBtuYui9OOYqzk
         5oMLVhOLMH3R+q0m12mGm3EG2h1sFbpEIl1e/B0y6IzwrvG+nPmuHkC9DGM4yw/BwAoB
         Mi2OTNTi/spUDcWHVeVzkIiWonCLhf8j1xvzaTAEyGsMd20bLUX01KxK2lexfVZ60al+
         SOmHkxkQCwyAuTalb0B0TZ8zfwS6kasCQHVVDbqYS73iFGgUMC54parNbbJUB4VbDA2i
         bBMpke53SXfzi4plr1UJdLARkcwu6OhY+hqLq+SwcHhVoOCdm8RfMn0huOkJKllfj5Sv
         XnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OnYLSD2OypS0Uent7BXmwBd+4DlgLNwAMehMf+rH4Xc=;
        b=XbeEmdNxEjoMUkF5aC4RfrNyw7FdwPf+cQIjsEqsvkdCwPzEogyq0SAsKkKCErzL9+
         824ob0SQxHA03/4bR2633dCOx//vTyq56CIkD6N/Ji2P0M2NeNHCJDbzLTfubu6/Er8d
         O2deFL4YSB4gestaR+GX6p/IiQjBnZQQoXIUWhcdnqe3/rYbAsIr6DaQogSCbXZ8ovXH
         EAlGuhGiKy79M1Ji11FZq1BTJmqQBR2qnxKyXHgg2QH67V3WKriMBWtsJky/26/ZgWCP
         3OOH8P735lkEPOBCB3FCV+fFURy6GIF1nJPpEGg3yqGBoeP6LjyruRC1cf/TQKz0pn2g
         FWmA==
X-Gm-Message-State: ACrzQf3eUd6fkCrDqvUKnE1dllr/qTVYlSa3Cw1HeumqXEP+7KxrVf5j
        P3PWxIxYCMUdl0dv71q7U+viUHz5yz0Xbt9rCzj04w==
X-Google-Smtp-Source: AMsMyM4leE0KhwTlTAnPFxGFHx8sUzWEJTlnMBYFXN4MOd9EfH5nk8PW2WE8e5eaQsgPlMx/hzO1nXVyZ71aPqAK/NY=
X-Received: by 2002:aca:3083:0:b0:355:afb:cdb5 with SMTP id
 w125-20020aca3083000000b003550afbcdb5mr2632053oiw.110.1665722216982; Thu, 13
 Oct 2022 21:36:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkZkY9nfaVDmjzhDG4zzezNn7bXnGrK+kpn0zQFwPhdorw@mail.gmail.com>
 <CANDhNCq-ewTnuuRPoDtq+14TCFEwUpyo-pxn3J8=x1qCZzcgKQ@mail.gmail.com>
 <CAJD7tkayXxKEPpRE7QvBN4CikqeQcUe3_qfrUaH4V+cJrk0y=Q@mail.gmail.com>
 <CANDhNCp6MOfWnHZKkd_pQbkJqJqPmArVK0JQKKzH4=GbyBVeSQ@mail.gmail.com>
 <CAJD7tkZ6dmbFS4wba8bcYaHWyMJCi+M1PPEc_WbuaHtvMY4HaA@mail.gmail.com> <CANDhNCrkceUi=+S8xzcBzf8=uUpD4namcm5U-MoACTSVEpcMrg@mail.gmail.com>
In-Reply-To: <CANDhNCrkceUi=+S8xzcBzf8=uUpD4namcm5U-MoACTSVEpcMrg@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 13 Oct 2022 21:36:20 -0700
Message-ID: <CAJD7tkajQz=houWcmYvjtpp+xL_=hyn3g3BASgwO_zJWnraWHA@mail.gmail.com>
Subject: Re: Question about ktime_get_mono_fast_ns() non-monotonic behavior
To:     John Stultz <jstultz@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 13, 2022 at 9:13 PM John Stultz <jstultz@google.com> wrote:
>
> On Thu, Oct 13, 2022 at 8:47 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > On Thu, Oct 13, 2022 at 8:42 PM John Stultz <jstultz@google.com> wrote:
> > >
> > > On Thu, Oct 13, 2022 at 8:26 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > > On Thu, Oct 13, 2022 at 7:39 PM John Stultz <jstultz@google.com> wrote:
> > > > > On Mon, Sep 26, 2022 at 2:18 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > > > >
> > > > > > I have a question about ktime_get_mono_fast_ns(), which is used by the
> > > > > > BPF helper bpf_ktime_get_ns() among other use cases. The comment above
> > > > > > this function specifies that there are cases where the observed clock
> > > > > > would not be monotonic.
> > > > > >
> > > > > > I had 2 beginner questions:
> > > > >
> > > > > Thinking about this a bit more, I have my own "beginner question": Why
> > > > > does bpf_ktime_get_ns() need to use the ktime_get_mono_fast_ns()
> > > > > accessor instead of ktime_get_ns()?
> > > > >
> > > > > I don't know enough about the contexts that bpf logic can run, so it's
> > > > > not clear to me and it's not obviously commented either.
> > > >
> > > > I am not the best person to answer this question (the BPF list is
> > > > CC'd, it's full of more knowledgeable people).
> > > >
> > > > My understanding is that because BPF programs can basically be run in
> > > > any context (because they can attach to almost all functions /
> > > > tracepoints in the kernel), the time accessor needs to be safe in all
> > > > contexts.
> > >
> > > Ah. Ok, the tracepoint connection is indeed likely the case. Thanks
> > > for clarifying.
> > >
> > > > Now that I know that ktime_get_mono_fast_ns() can drift significantly,
> > > > I am wondering why we don't just read sched_clock(). Can the
> > > > difference between sched_clock() on different cpus be even higher than
> > > > the potential drift from ktime_get_mono_fast_ns()?
> > >
> > > sched_clock is also lock free and so I think it's possible to have
> > > inconsistencies.
> >
> > Right, I am just trying to figure out which is worse,
> > ktime_get_mono_fast_ns() or sched_clock(). It appears to me that both
> > can be inconsistent, but at least AFAICT sched_clock() can only be
> > inconsistent if read across different cpus, right? It should also be
> > faster (at least in my experimentation).
> >
> > I am wondering if there is a bound on the inconsistency we might
> > observe from sched_clock() if we read it across different cpus, and if
> > there is, how does it compare to ktime_get_mono_fast_ns() in that
> > regard.
>
> Again, I think ktime_get_raw_fast_ns() (so CLOCK_MONOTONIC_RAW) is
> likely to be closer to sched_clock() as neither of them are NTP
> adjusted.
> (Which also likely makes them unusable for the case where timestamps
> are compared with userland CLOCK_MONOTONIC timestamps).
>
> So folks might need a new bpf interface for that.
>
> Also I think folks would want to avoid exporting sched_clock
> timestamps out to userland as they aren't connected to a well defined
> clockid, and may have odd behavior around suspend/resume, etc.

I think I should have described my use case long ago, sorry :) My use
case does not involve exporting any timestamps. It involves using BPF
programs to measure the duration of events, so running one BPF program
before and one after, then subtracting the acquired timestamps.

What I was looking for is something fast enough for hot paths and also
consistent enough (in case the two BPF programs end up running on
different cpus), and also safe from all contexts to satisfy this
general BPF restriction.

>
> thanks
> -john

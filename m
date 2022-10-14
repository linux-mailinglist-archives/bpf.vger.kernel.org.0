Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748D25FE7E2
	for <lists+bpf@lfdr.de>; Fri, 14 Oct 2022 06:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiJNENi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Oct 2022 00:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJNENh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Oct 2022 00:13:37 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB539182C66
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 21:13:36 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id r14so5445798lfm.2
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 21:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M0Zb4Gh4HbVmrxl10ZnRLvHF9xqvPuI3TrgDJgYmXLc=;
        b=WiuG3nA/mEEF+tB0Cu7qtD/X77t5gELPt2UjJim26Jolseqj2CpQKOQ39FvB9H+u5/
         kE4NxBcjFWzRA7IO0pYC2TNBH28M6gVi6Kw+etAsWUvuJSrRhMUqV7l5GQ0NAn8x4yF+
         0rTLmCk9uJvVZXRUHlgWdnE2zM2zUQyyiY7Mkx8wJULbkj54R+ZFEc++pKcQNKMKB3nO
         Fylgs/jTXhcIg783OSh1m9s27v3N0hxMyn5Jh3UcjL3i2V8aCZhI0At0bc+9vErsrm42
         3g/XaZHimvYqewaHECdLKNZ/DyTkaaYkHc/mJjyfDZIl3s6G/bIFczNCqagPz7txeh64
         wfwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M0Zb4Gh4HbVmrxl10ZnRLvHF9xqvPuI3TrgDJgYmXLc=;
        b=jKFAb/myJKqS5LGziewUPHNrd98j7MI/yhk6dTKfP9P+F17yyY4Wnrbfv2y2MhIPXj
         4ehbjWZ9fO1GsSEUVW0NHd7oMHXRhGgrw/cHtmqDwy4ihvH3+QbzgJ4hNSrjvWGaN5KU
         i9mRQuEaSvl08EcS3kmL+2M6mBOg4mir3NxHQQG823KM7h4F0m+QdVUPGdfCJCmvGO+O
         YNLVsNBUb8gBVKVyzTHM9Eqxl1eK4ug64UINs2ctyPbfNAEYT/fIqjZayhUH/Eb5Uc21
         f66SVOghjoN6MxtO1d9MeGK6HVTgbt8T056iTd7GC156jWdWCTFEpQZtWF1saxIur4yL
         7e2A==
X-Gm-Message-State: ACrzQf2lZw3LDpCuuDQmnD5oaS4nQyZUo4w3cu1YMWZc6ASFI/4p9I8T
        V1o4JsDVj3mvTx6slC8rJmX3QUKHsM5EtCHxLP3M
X-Google-Smtp-Source: AMsMyM5wQxejuDW4HsZY+imzG7LH2jdiB8d+Pa95gEoVkV7r7dtZgoEfC3WBDa1/iQiXUAoYOR5UfKT2EKJ10r55/mI=
X-Received: by 2002:a19:7704:0:b0:4a4:5d9d:2f66 with SMTP id
 s4-20020a197704000000b004a45d9d2f66mr1099703lfc.515.1665720814872; Thu, 13
 Oct 2022 21:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkZkY9nfaVDmjzhDG4zzezNn7bXnGrK+kpn0zQFwPhdorw@mail.gmail.com>
 <CANDhNCq-ewTnuuRPoDtq+14TCFEwUpyo-pxn3J8=x1qCZzcgKQ@mail.gmail.com>
 <CAJD7tkayXxKEPpRE7QvBN4CikqeQcUe3_qfrUaH4V+cJrk0y=Q@mail.gmail.com>
 <CANDhNCp6MOfWnHZKkd_pQbkJqJqPmArVK0JQKKzH4=GbyBVeSQ@mail.gmail.com> <CAJD7tkZ6dmbFS4wba8bcYaHWyMJCi+M1PPEc_WbuaHtvMY4HaA@mail.gmail.com>
In-Reply-To: <CAJD7tkZ6dmbFS4wba8bcYaHWyMJCi+M1PPEc_WbuaHtvMY4HaA@mail.gmail.com>
From:   John Stultz <jstultz@google.com>
Date:   Thu, 13 Oct 2022 21:13:22 -0700
Message-ID: <CANDhNCrkceUi=+S8xzcBzf8=uUpD4namcm5U-MoACTSVEpcMrg@mail.gmail.com>
Subject: Re: Question about ktime_get_mono_fast_ns() non-monotonic behavior
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 13, 2022 at 8:47 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> On Thu, Oct 13, 2022 at 8:42 PM John Stultz <jstultz@google.com> wrote:
> >
> > On Thu, Oct 13, 2022 at 8:26 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > On Thu, Oct 13, 2022 at 7:39 PM John Stultz <jstultz@google.com> wrote:
> > > > On Mon, Sep 26, 2022 at 2:18 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > > >
> > > > > I have a question about ktime_get_mono_fast_ns(), which is used by the
> > > > > BPF helper bpf_ktime_get_ns() among other use cases. The comment above
> > > > > this function specifies that there are cases where the observed clock
> > > > > would not be monotonic.
> > > > >
> > > > > I had 2 beginner questions:
> > > >
> > > > Thinking about this a bit more, I have my own "beginner question": Why
> > > > does bpf_ktime_get_ns() need to use the ktime_get_mono_fast_ns()
> > > > accessor instead of ktime_get_ns()?
> > > >
> > > > I don't know enough about the contexts that bpf logic can run, so it's
> > > > not clear to me and it's not obviously commented either.
> > >
> > > I am not the best person to answer this question (the BPF list is
> > > CC'd, it's full of more knowledgeable people).
> > >
> > > My understanding is that because BPF programs can basically be run in
> > > any context (because they can attach to almost all functions /
> > > tracepoints in the kernel), the time accessor needs to be safe in all
> > > contexts.
> >
> > Ah. Ok, the tracepoint connection is indeed likely the case. Thanks
> > for clarifying.
> >
> > > Now that I know that ktime_get_mono_fast_ns() can drift significantly,
> > > I am wondering why we don't just read sched_clock(). Can the
> > > difference between sched_clock() on different cpus be even higher than
> > > the potential drift from ktime_get_mono_fast_ns()?
> >
> > sched_clock is also lock free and so I think it's possible to have
> > inconsistencies.
>
> Right, I am just trying to figure out which is worse,
> ktime_get_mono_fast_ns() or sched_clock(). It appears to me that both
> can be inconsistent, but at least AFAICT sched_clock() can only be
> inconsistent if read across different cpus, right? It should also be
> faster (at least in my experimentation).
>
> I am wondering if there is a bound on the inconsistency we might
> observe from sched_clock() if we read it across different cpus, and if
> there is, how does it compare to ktime_get_mono_fast_ns() in that
> regard.

Again, I think ktime_get_raw_fast_ns() (so CLOCK_MONOTONIC_RAW) is
likely to be closer to sched_clock() as neither of them are NTP
adjusted.
(Which also likely makes them unusable for the case where timestamps
are compared with userland CLOCK_MONOTONIC timestamps).

So folks might need a new bpf interface for that.

Also I think folks would want to avoid exporting sched_clock
timestamps out to userland as they aren't connected to a well defined
clockid, and may have odd behavior around suspend/resume, etc.

thanks
-john

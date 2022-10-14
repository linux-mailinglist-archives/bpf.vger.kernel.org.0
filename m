Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034F75FE7AC
	for <lists+bpf@lfdr.de>; Fri, 14 Oct 2022 05:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiJNDrZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 23:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiJNDrY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 23:47:24 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862B0165508
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 20:47:22 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id c9-20020a05600c100900b003c6da0f9b62so2271596wmc.1
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 20:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lBYeeMiTYgEmcLoN4YT7BigiJQggANfOkTLwUlVkdks=;
        b=AYFZy6I8WS+2S7x3EFYoGPrqlEx+ZSRURXX0jQonI3iNCahSfVtNUGQVoujxxMmnu4
         z3+0jvufKfoMguGHzTxdwv7bDETMs9tzWG/81cqP+/ltuZlGg/vtCwWmCg0iqKxxyp4y
         xItFOMZekgLkApASaTj/FJzltP/8jOyJ4iMlURFh6BaLEhZJHm5hIWDVVX8K/auF64BE
         9kbJG/3vFfQXchnbW2vPYu1yzRmFse0JO6Fbj0At1CfhaGgYPsv/+nemUZtJfUx3lkH7
         h6cYaZcBlwPEcpH7HyVOtEqLBDQjPztbiCl86wF8ROZqPs1K5Jegwvfd1zVn9LAS4iEz
         PXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lBYeeMiTYgEmcLoN4YT7BigiJQggANfOkTLwUlVkdks=;
        b=q7fq8GpUTyqe738gwwgDb/cFKYOR+RSriwxLJy/C/a4MGfxdM/EkCqFaQhwgUtoxwX
         VDzytAOHvBJfRyxgjhHcfT7hXB1eqHktDxljRR6vYO+RArRIEhHa8/GsSflj8nDQcbIj
         iZ5ulNAcsrF97EwsLgS2RP01TNVrC2pCPtnAR+6kEqliEEj7lO3/Q+lJERleWp/2qg+d
         //nKt9X8V2QyHQgUke/hfWj4R8w8kilm7FnN2XkU71VK0psvnR656Qf33odPwJHQaNWc
         fnk/1kKHdrQH54RFV7PxQTHnaqfNzPLl0MbJ4bjPh1LS5xDmVz3MWz0pat1f5xR88+Wh
         apUw==
X-Gm-Message-State: ACrzQf1M80UmFR53MyGO4JiHxODPnWSUhD3ttZM7VGEWnkRs13R4qQlm
        pKG2N1DPuOgpOc+soET1S9rZwoV1mV0cB3nKUkdbmw==
X-Google-Smtp-Source: AMsMyM6x4zv3f/r/YEqEQ1AQbQyWie8F+pZNsSohWX+AAZkTnk/qJs4VpAJuGAl3pwKmRgzFaKb5bLlARy+bXVSgblc=
X-Received: by 2002:a7b:cb92:0:b0:3c4:cf60:7a7 with SMTP id
 m18-20020a7bcb92000000b003c4cf6007a7mr1923550wmi.24.1665719240995; Thu, 13
 Oct 2022 20:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkZkY9nfaVDmjzhDG4zzezNn7bXnGrK+kpn0zQFwPhdorw@mail.gmail.com>
 <CANDhNCq-ewTnuuRPoDtq+14TCFEwUpyo-pxn3J8=x1qCZzcgKQ@mail.gmail.com>
 <CAJD7tkayXxKEPpRE7QvBN4CikqeQcUe3_qfrUaH4V+cJrk0y=Q@mail.gmail.com> <CANDhNCp6MOfWnHZKkd_pQbkJqJqPmArVK0JQKKzH4=GbyBVeSQ@mail.gmail.com>
In-Reply-To: <CANDhNCp6MOfWnHZKkd_pQbkJqJqPmArVK0JQKKzH4=GbyBVeSQ@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 13 Oct 2022 20:46:44 -0700
Message-ID: <CAJD7tkZ6dmbFS4wba8bcYaHWyMJCi+M1PPEc_WbuaHtvMY4HaA@mail.gmail.com>
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

On Thu, Oct 13, 2022 at 8:42 PM John Stultz <jstultz@google.com> wrote:
>
> On Thu, Oct 13, 2022 at 8:26 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > On Thu, Oct 13, 2022 at 7:39 PM John Stultz <jstultz@google.com> wrote:
> > > On Mon, Sep 26, 2022 at 2:18 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > >
> > > > I have a question about ktime_get_mono_fast_ns(), which is used by the
> > > > BPF helper bpf_ktime_get_ns() among other use cases. The comment above
> > > > this function specifies that there are cases where the observed clock
> > > > would not be monotonic.
> > > >
> > > > I had 2 beginner questions:
> > >
> > > Thinking about this a bit more, I have my own "beginner question": Why
> > > does bpf_ktime_get_ns() need to use the ktime_get_mono_fast_ns()
> > > accessor instead of ktime_get_ns()?
> > >
> > > I don't know enough about the contexts that bpf logic can run, so it's
> > > not clear to me and it's not obviously commented either.
> >
> > I am not the best person to answer this question (the BPF list is
> > CC'd, it's full of more knowledgeable people).
> >
> > My understanding is that because BPF programs can basically be run in
> > any context (because they can attach to almost all functions /
> > tracepoints in the kernel), the time accessor needs to be safe in all
> > contexts.
>
> Ah. Ok, the tracepoint connection is indeed likely the case. Thanks
> for clarifying.
>
> > Now that I know that ktime_get_mono_fast_ns() can drift significantly,
> > I am wondering why we don't just read sched_clock(). Can the
> > difference between sched_clock() on different cpus be even higher than
> > the potential drift from ktime_get_mono_fast_ns()?
>
> sched_clock is also lock free and so I think it's possible to have
> inconsistencies.

Right, I am just trying to figure out which is worse,
ktime_get_mono_fast_ns() or sched_clock(). It appears to me that both
can be inconsistent, but at least AFAICT sched_clock() can only be
inconsistent if read across different cpus, right? It should also be
faster (at least in my experimentation).

I am wondering if there is a bound on the inconsistency we might
observe from sched_clock() if we read it across different cpus, and if
there is, how does it compare to ktime_get_mono_fast_ns() in that
regard.

>
> ktime_get_raw_fast_ns() is possibly closer to what you are looking
> for, as it is similarly un-adjusted by NTP.
> However that also means the time intervals it measures (especially
> long ones) may not be accurate.
>
> Also I worry that if it's already established as a CLOCK_MONOTONIC
> interface, switching it to MONOTONIC_RAW might break some applications
> that mix collected timestamps with CLOCK_MONOTONIC.
>
> thanks
> -john

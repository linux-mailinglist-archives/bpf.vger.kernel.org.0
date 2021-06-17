Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621B03AAA13
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 06:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhFQE2s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 00:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhFQE2r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Jun 2021 00:28:47 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34337C061574;
        Wed, 16 Jun 2021 21:26:38 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id i4so6274042ybe.2;
        Wed, 16 Jun 2021 21:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7vajil0LwVWhtg4ci7rYI9ZTuF5RlNqwdJCGUIVMam4=;
        b=siMq/0LLPT7ZYeJXjnhFlPQd6OzkBa9Qi0z/WLbEM6eR8FT2zjlxXhYFV4Xnzl0g6b
         xXr8YxHAJ+q86pp64SRPM4Dz6Yu1/cX50WMwzE7obYQ/8A2nmfM9+O5Omoxj66fPOJWT
         dszFvW8v2EEdDV8FmfaWMOwOl0CociYArLyhyehaAwpbXR0C4J0M0tVyzt273zfe+91I
         ZdBX3JRDq27CtPXB+0/6EM+hJLWeCX6hXZ3Ri/BHvhhQrAYwl4qJc5Jt9xPrwmjVPub3
         Zh67NJf7ogllNCBHV8ssUo2cD3zagn+TJvh3pRHhsXQ732m+u7B0W1BOALLwrWOgYUwV
         kuAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7vajil0LwVWhtg4ci7rYI9ZTuF5RlNqwdJCGUIVMam4=;
        b=eVQKsjXNXGJcuEKzgNIqG/HdLcAShy4lYgVtcd5RR5ztLsXeFTUtpnnVoOBPGiW91u
         PrXTMLyePGBF8m5p4+srB6ouroAFjTlBOevwJsKapynomLpVRv8ZH4qanPO8OzJdfmjZ
         hB9+ZaQIr4cGbH1pGkaVe+1VBJRZ1VQhEh49sfzKceNwwIn0m+ED7jSi77Lnlydr/ZqB
         vaVO+xhwNBpuXCjdOZM0V8/7smfqPjbNM+mq7YkOYMHIk6ksYCmOIxOAqPEZxvoIRWO+
         0wym6h/84jC84mjHLa8PXeDrV48Kf84Xo84kem/F0CviQsd3tznEAdXrNAl6c2PdXInU
         q63g==
X-Gm-Message-State: AOAM533S8ITA9D8/+jV+l5OyNO51Dmgf2c9ZcEaIh/gAJdt3u12aoCrx
        5b8gdbkBxJCgEh8+CPbMoo9iUgOQeX96wIfKvXM=
X-Google-Smtp-Source: ABdhPJwH/6Oe2m9ohQDYdSNDYXV9AI6aXlOmAiu7cJM/WVqR1b2wWsgR+Iar93hwYSKJhCbu7Gv2nn7FK6aZDt3ILuA=
X-Received: by 2002:a25:aa66:: with SMTP id s93mr3901969ybi.260.1623903997472;
 Wed, 16 Jun 2021 21:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4BzZnZN2mt4+5F-00ggO9YHWrL3Jru_u3Qt2JJ+SMkHwg+w@mail.gmail.com>
 <YMoRBvTdD0qzjYf4@kernel.org> <CAEf4BzZ7KDcsViCY8MbUZuWu2BdkjymkgJtyVUMBrCaiimUCxQ@mail.gmail.com>
 <YMpCDuEO/mItxdR7@kernel.org> <CAEf4BzYn31_93G_f924HR8dSW=oGqyFaneRa0fo5Btcg-Y2xJg@mail.gmail.com>
 <YMqURLBNxKgNpjTN@kernel.org>
In-Reply-To: <YMqURLBNxKgNpjTN@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 16 Jun 2021 21:26:26 -0700
Message-ID: <CAEf4BzZR-q6Bjm1QWZ77EPH7YzoC-BSM8tCc2VFQo6CRg3ZZrA@mail.gmail.com>
Subject: Re: latest pahole breaks libbpf CI and let's talk about staging
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org, siudin@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 16, 2021 at 5:16 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Wed, Jun 16, 2021 at 03:38:38PM -0700, Andrii Nakryiko escreveu:
> > On Wed, Jun 16, 2021 at 11:25 AM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > > Em Wed, Jun 16, 2021 at 10:40:45AM -0700, Andrii Nakryiko escreveu:
> > > > On Wed, Jun 16, 2021 at 7:56 AM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > > > > Em Tue, Jun 15, 2021 at 04:30:03PM -0700, Andrii Nakryiko escreveu:
> > > > > > Hey Arnaldo,
>
> > > > > > Seems like de3a7f912559 ("btf_encoder: Reduce the size of encode_cu()
> > > > > > by moving function encoding to separate method") break two selftests
> > > > > > in libbpf CI (see [0]). Please take a look. I suspect some bad BTF,
> > > > > > because both tests rely on kernel BTF info.
>
> > > > > > You've previously asked about staging pahole changes. Did you make up
> > > > > > your mind about branch names and the process overall? Seems like a
> > > > > > good chance to bring this up ;-P
>
> > > > > >   [0] https://travis-ci.com/github/libbpf/libbpf/jobs/514329152
>
> > > > > Ok, please add tmp.master as the staging branch, I'll move things to
> > > > > master only after it passing thru CI.
> > > >
> > > > So I'm thinking about what's the best setup to catch pahole staging
> > > > problems, but not break main libbpf CI and kernel-patches CI flows.
>
> > > > How about we keep all the existing CI jobs to use pahole's master.
>
> > > Agreed.
>
> > > > Then add a separate job to do full kernel build with pahole built from
> > > > staging branch. And mark it as non-critical (or whatever the
> > > > terminology), so it doesn't mark the build red. I'd do that as a cron
> > > > job that runs every day. That way if you don't have anything urgent,
> > > > next day you'll get staging tested automatically. If you need to test
> > > > right now, there is a way to re-trigger previous build and it will
> > > > re-fetch latest staging (so there is a way for you to proactively
> > > > test).
>
> > > > Basically, I want broken staging pahole to not interrupt anything we
> > > > are doing. WDYT?
>
> > > Sounds like a plan, please hand hold me on this, I'm not versed on
> > > github.
>
> > I'll set up everything from my side, and then we'll just setup proper
> > access rights for you to be able to trigger builds. We are migrating
> > everything from Travis CI to Github Actions, and I'm not yet too
> > familiar with Github Actions, so I might need a few iterations.
>
> Ok dokey

Please see https://github.com/libbpf/libbpf/pull/325, Sergey is
setting up staging pahole testing.

>
> > BTW, while you are investigating pahole regression, can you please
> > revert the offending commit and push it to master to make out CIs
> > green again?
>
> Sure, just did it. Lets see if makes things green again.

It did, thanks!

>
> - Arnaldo

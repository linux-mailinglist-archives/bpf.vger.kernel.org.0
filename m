Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB30B3AA6AD
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 00:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbhFPWk6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Jun 2021 18:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbhFPWk6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Jun 2021 18:40:58 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB250C061574;
        Wed, 16 Jun 2021 15:38:50 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id g38so5270510ybi.12;
        Wed, 16 Jun 2021 15:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=12VmBMfkyKDL623at/Z3A+VtlIGF3I18xQla4TOQBt4=;
        b=r0OZnUdoIo/SCtMgO4C8V95xK7rd8JP3s9IUiJ5o1oTGiyEBvimp5oDb4yFTqnUPIQ
         sDDo1+/s5uNOmhkxkJdKJY7k4DUShAd9uKf4wPatp2rYzZ05ZBO5Wy0H6AfXnKohwrM2
         Lyz2xCyDts20Mj+cHoY0UvRO16AWmsduGHqtj0M9upTBoaS4qXyzCIxBVIzVwGMaElib
         nBdxN+ynpUiFyv38zPvoiA2F53MHX6+sfRnmvha3YUiy65arpJ0TTOsYto8IKlEzrwTe
         UlKOAcw8ohIi+4V4b0qJNqquG+hoAqWBjwH3tJRKvFk5CZIsJkACFj8kAlrPySXXwAY6
         sQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=12VmBMfkyKDL623at/Z3A+VtlIGF3I18xQla4TOQBt4=;
        b=pcWLW/PSqns0yHTrKODDQrxe/1JAD3AN94SV4PE8nG30OJD4b13vYK1tcRKhm/MIXI
         FWLDV+8s32dfsB4Ip5h9+ITL8tZQf3i4txQ6WEB3HSdeFMw9AJVx9oS2FxyFJomY0XvK
         PNT/kpgYjjeBbW5o24w1z9ZQMHvkcVA4qxYJouXl3erTFd+2KRSiGegkrGrlusGcVmKo
         lsyOzO6x1dg7JIK/lk+zOcP6/IdIelIRuuwH5P9JP0IHW1sPLl9E0LdMAbb1POmsI68d
         nWc52bCzWEXkykijKb8xpb69Q6yiNOwVZCgk7fZimFt/C/w9pCDtfKWZCAbO8amLiYEH
         0Zvg==
X-Gm-Message-State: AOAM533JvrIoHjE9ttiqpuCBDVRF8VMmwZCCdVDAOBpuzh7tttEmfDQ9
        siGCKCiT/dAuSJy7rg0QKXKpMqsTeviXGpmKXdc=
X-Google-Smtp-Source: ABdhPJxFfry9DwwISlvpPslaM7hki0Rjn46T1wYneXtQCzMb1SS+Na2MuQSVcrZy0K0RRlRqMNJBMvAFd7tZN67sEVY=
X-Received: by 2002:a25:4182:: with SMTP id o124mr1888512yba.27.1623883129966;
 Wed, 16 Jun 2021 15:38:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4BzZnZN2mt4+5F-00ggO9YHWrL3Jru_u3Qt2JJ+SMkHwg+w@mail.gmail.com>
 <YMoRBvTdD0qzjYf4@kernel.org> <CAEf4BzZ7KDcsViCY8MbUZuWu2BdkjymkgJtyVUMBrCaiimUCxQ@mail.gmail.com>
 <YMpCDuEO/mItxdR7@kernel.org>
In-Reply-To: <YMpCDuEO/mItxdR7@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 16 Jun 2021 15:38:38 -0700
Message-ID: <CAEf4BzYn31_93G_f924HR8dSW=oGqyFaneRa0fo5Btcg-Y2xJg@mail.gmail.com>
Subject: Re: latest pahole breaks libbpf CI and let's talk about staging
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org, siudin@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 16, 2021 at 11:25 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Wed, Jun 16, 2021 at 10:40:45AM -0700, Andrii Nakryiko escreveu:
> > On Wed, Jun 16, 2021 at 7:56 AM Arnaldo Carvalho de Melo
> > <arnaldo.melo@gmail.com> wrote:
> > >
> > > Em Tue, Jun 15, 2021 at 04:30:03PM -0700, Andrii Nakryiko escreveu:
> > > > Hey Arnaldo,
> > > >
> > > > Seems like de3a7f912559 ("btf_encoder: Reduce the size of encode_cu()
> > > > by moving function encoding to separate method") break two selftests
> > > > in libbpf CI (see [0]). Please take a look. I suspect some bad BTF,
> > > > because both tests rely on kernel BTF info.
> > > >
> > > > You've previously asked about staging pahole changes. Did you make up
> > > > your mind about branch names and the process overall? Seems like a
> > > > good chance to bring this up ;-P
> > > >
> > > >   [0] https://travis-ci.com/github/libbpf/libbpf/jobs/514329152
> > >
> > > Ok, please add tmp.master as the staging branch, I'll move things to
> > > master only after it passing thru CI.
> > >
> >
> > So I'm thinking about what's the best setup to catch pahole staging
> > problems, but not break main libbpf CI and kernel-patches CI flows.
>
> > How about we keep all the existing CI jobs to use pahole's master.
>
> Agreed.
>
> > Then add a separate job to do full kernel build with pahole built from
> > staging branch. And mark it as non-critical (or whatever the
> > terminology), so it doesn't mark the build red. I'd do that as a cron
> > job that runs every day. That way if you don't have anything urgent,
> > next day you'll get staging tested automatically. If you need to test
> > right now, there is a way to re-trigger previous build and it will
> > re-fetch latest staging (so there is a way for you to proactively
> > test).
> >
> > Basically, I want broken staging pahole to not interrupt anything we
> > are doing. WDYT?
>
> Sounds like a plan, please hand hold me on this, I'm not versed on
> github.

I'll set up everything from my side, and then we'll just setup proper
access rights for you to be able to trigger builds. We are migrating
everything from Travis CI to Github Actions, and I'm not yet too
familiar with Github Actions, so I might need a few iterations.

BTW, while you are investigating pahole regression, can you please
revert the offending commit and push it to master to make out CIs
green again?

>
> - Arnaldo
>
> > > Now looking at that code, must be something subtle...
> > >
> > > - Arnaldo
>
> --
>
> - Arnaldo

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA08C397AE2
	for <lists+bpf@lfdr.de>; Tue,  1 Jun 2021 21:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbhFAT4z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Jun 2021 15:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbhFAT4y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Jun 2021 15:56:54 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2B1C06174A
        for <bpf@vger.kernel.org>; Tue,  1 Jun 2021 12:55:12 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id v14so241748pgi.6
        for <bpf@vger.kernel.org>; Tue, 01 Jun 2021 12:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ApMBV5fRu56qu4SK6yHlizJ6W1eRv0wSD3z+NP9p+0U=;
        b=N5hDZSfq/UlXfJ8hJLChOlY7XWu+QxfPXzk5Md44NJjRpsBwF8bGJFVpPeig2SNQcV
         QPaQUIQ5glLKlIY7qr2qPfE2TxakmhIXNEsbID6ecUP4bMFzZIZWgPBOvCaCJ+/oSUGn
         lNPLusLe+lAlv+nEN9XaEwzAbSutg+ee8Igc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ApMBV5fRu56qu4SK6yHlizJ6W1eRv0wSD3z+NP9p+0U=;
        b=OnvnTPrhVRuepf+jy2TwyeeMPOhZGzXSznSnf5gjadccJSsdPCbUH7jejQE46VjQlJ
         XS4vdgB+r0P2k/w0lvK6f/m0bD6t9/DEzoiWhy4SR2qzHJYKAMuOMd9efhnPVjt5T1GG
         gvyOmYwR5gk5a4eYvEYikn8G4kRkPhKQvzcO/zTJPMVirz0WLrgAjqwaKLBeYMFK5k9+
         7SkupO8z3Hir5cvrDV7c2XbdX1NKxkSuKsEsYNBM2eI+0/SrHBxWkjhbu8r2xvBaTepi
         UME1i80bGfmh+naXh0UBbwLuNGIlTff2NxYI+Ouwgme8a7XTNOEwjc3hzPwhNP+ThbKW
         spkg==
X-Gm-Message-State: AOAM531b7SeQ455PqpgSnk3I5sfSydZy7HRqXT0EBVH3A0zL2f26nNK4
        Wp5iUVBJO5TF5HihD8OZLazeOw==
X-Google-Smtp-Source: ABdhPJy80Hs3KzZN3hBYzAEXNt+CQstTWbNv7MoTTvMu1cm6s5ZsF1KQjsVPyifZ3wlORwX61iM4Kw==
X-Received: by 2002:aa7:8551:0:b029:2e9:f46e:c560 with SMTP id y17-20020aa785510000b02902e9f46ec560mr5993875pfn.14.1622577311708;
        Tue, 01 Jun 2021 12:55:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a129sm9613791pfa.118.2021.06.01.12.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 12:55:11 -0700 (PDT)
Date:   Tue, 1 Jun 2021 12:55:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Tianyin Xu <tyxu@illinois.edu>, Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@kernel.org>,
        YiFei Zhu <zhuyifei1999@gmail.com>,
        "containers@lists.linux.dev" <containers@lists.linux.dev>,
        bpf <bpf@vger.kernel.org>, "Zhu, YiFei" <yifeifz2@illinois.edu>,
        LSM List <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kuo, Hsuan-Chi" <hckuo2@illinois.edu>,
        Claudio Canella <claudio.canella@iaik.tugraz.at>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jann Horn <jannh@google.com>,
        "Jia, Jinghao" <jinghao7@illinois.edu>,
        "Torrellas, Josep" <torrella@illinois.edu>,
        Sargun Dhillon <sargun@sargun.me>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        Will Drewry <wad@chromium.org>
Subject: Re: [RFC PATCH bpf-next seccomp 00/12] eBPF seccomp filters
Message-ID: <202106011244.76762C210@keescook>
References: <cover.1620499942.git.yifeifz2@illinois.edu>
 <CALCETrUQBonh5BC4eomTLpEOFHVcQSz9SPcfOqNFTf2TPht4-Q@mail.gmail.com>
 <CABqSeASYRXMwTQwLfm_Tapg45VUy9sPfV7BeeV8p7XJrDoLf+Q@mail.gmail.com>
 <fffbea8189794a8da539f6082af3de8e@DM5PR11MB1692.namprd11.prod.outlook.com>
 <CAGMVDEGzGB4+6gJPTw6Tdng5ur9Jua+mCbqwPoNZ16EFaDcmjA@mail.gmail.com>
 <108b4b9c2daa4123805d2b92cf51374b@DM5PR11MB1692.namprd11.prod.outlook.com>
 <CAGMVDEEkDeUBcJAswpBjcQNWk7QDcO8BZR=uvVfm-+qe714tYg@mail.gmail.com>
 <20210520085613.gvshk4jffmzggvsm@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520085613.gvshk4jffmzggvsm@wittgenstein>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 20, 2021 at 10:56:13AM +0200, Christian Brauner wrote:
> On Thu, May 20, 2021 at 03:16:10AM -0500, Tianyin Xu wrote:
> > On Mon, May 17, 2021 at 10:40 AM Tycho Andersen <tycho@tycho.pizza> wrote:
> > >
> > > On Sun, May 16, 2021 at 03:38:00AM -0500, Tianyin Xu wrote:
> > > > On Sat, May 15, 2021 at 10:49 AM Andy Lutomirski <luto@kernel.org> wrote:
> > > > >
> > > > > On 5/10/21 10:21 PM, YiFei Zhu wrote:
> > > > > > On Mon, May 10, 2021 at 12:47 PM Andy Lutomirski <luto@kernel.org> wrote:
> > > > > >> On Mon, May 10, 2021 at 10:22 AM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> > > > > >>>
> > > > > >>> From: YiFei Zhu <yifeifz2@illinois.edu>
> > > > > >>>
> > > > > >>> Based on: https://urldefense.com/v3/__https://lists.linux-foundation.org/pipermail/containers/2018-February/038571.html__;!!DZ3fjg!thbAoRgmCeWjlv0qPDndNZW1j6Y2Kl_huVyUffr4wVbISf-aUiULaWHwkKJrNJyo$
> > > > > >>>
> > > > > >>> This patchset enables seccomp filters to be written in eBPF.

Before I dive in, I do want to say that this is very interesting work.
Thanks for working on it, even if we're all so grumpy about accepting
it. :)

> > > > > >>> Supporting eBPF filters has been proposed a few times in the past.
> > > > > >>> The main concerns were (1) use cases and (2) security. We have
> > > > > >>> identified many use cases that can benefit from advanced eBPF
> > > > > >>> filters, such as:
> > > > > >>
> > > > > >> I haven't reviewed this carefully, but I think we need to distinguish
> > > > > >> a few things:
> > > > > >>
> > > > > >> 1. Using the eBPF *language*.

Likely everyone is aware, but I'll point out for anyone new reading this
thread: seccomp uses eBPF under the hood: all the cBPF is transformed to
eBPF at filter attach time. But yes, I get the point: using the _entire_
eBPF language. Though I'd remind folks that seccomp doesn't even use
the entire cBPF language...

> [...] but Andy's point stands that this brings a slew of issues on
> the table that need clear answers. Bringing stateful ebpf features into
> seccomp is a pretty big step and especially around the
> privilege/security model it looks pretty handwavy right now.

This is the blocker as far as I'm concerned: there is no story for
unprivileged eBPF. And even IF there was a story there, I find the rate
of security-related flaws in eBPF to be way too high for a sandboxing
primitive to depend on. There have been around a dozen a year for the
last 4 years:

$ git log --oneline --no-merges --pretty=format:'%as %h %s' \
   -i -E \ --all-match --grep '^Fixes:' --grep \
   '(over|under)flow|\bleak|escalat|expos(e[ds]?|ure)\b|use[- ]?after[- ]?free' \
   -- kernel/bpf/ | cut -d- -f1 | sort | uniq -c
      4 2015
      4 2016
     13 2017
     16 2018
     18 2019
     12 2020
      6 2021

I just can't bring myself to accept that level of risk for seccomp. (And
yes, this might be mitigated by blocking the bpf() syscall within a
filter, but then eBPF seccomp would become kind of useless inside a
container launcher, etc etc.)

-Kees

-- 
Kees Cook

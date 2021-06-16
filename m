Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0B13AA323
	for <lists+bpf@lfdr.de>; Wed, 16 Jun 2021 20:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhFPS11 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Jun 2021 14:27:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231379AbhFPS11 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Jun 2021 14:27:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D32F613C1;
        Wed, 16 Jun 2021 18:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623867921;
        bh=XjMk9YNMpR5e1qF2encb/G45NGZYlb5CreC/GHLURVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ScVLQd00FRWS77ut+D4kBKrOJknwa3/mLtklGK2F1P3LDIepfM4jWuSlshXPSckEn
         gG+IVAwS4lrZKd4OZmET6DTEXOhbOId92AvFZXwulWQVBdMWmBF1uq91Q3iXvvHUpH
         zQWOP4+/Uxw8Es0pdhGqrn6Gt6wxnXTMw0B5wHgWzeUEv6JuxKIIj0bxqOXLdEoVe5
         7bUIPyyh+6V1VyRLmuib7skESNt7GUUZmnwOj28OszPkZcxkj+vch4fxAc7buxUfJw
         d6NxF8CiWdVYYkjnOsGxSsAOYZh6bKVnt6ZBhHw7nW7QnIjJeCd9Ccugf/EbT6GGlw
         I46a5VXggV5wQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 631CA40B1A; Wed, 16 Jun 2021 15:25:18 -0300 (-03)
Date:   Wed, 16 Jun 2021 15:25:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org, siudin@fb.com
Subject: Re: latest pahole breaks libbpf CI and let's talk about staging
Message-ID: <YMpCDuEO/mItxdR7@kernel.org>
References: <CAEf4BzZnZN2mt4+5F-00ggO9YHWrL3Jru_u3Qt2JJ+SMkHwg+w@mail.gmail.com>
 <YMoRBvTdD0qzjYf4@kernel.org>
 <CAEf4BzZ7KDcsViCY8MbUZuWu2BdkjymkgJtyVUMBrCaiimUCxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ7KDcsViCY8MbUZuWu2BdkjymkgJtyVUMBrCaiimUCxQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Jun 16, 2021 at 10:40:45AM -0700, Andrii Nakryiko escreveu:
> On Wed, Jun 16, 2021 at 7:56 AM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > Em Tue, Jun 15, 2021 at 04:30:03PM -0700, Andrii Nakryiko escreveu:
> > > Hey Arnaldo,
> > >
> > > Seems like de3a7f912559 ("btf_encoder: Reduce the size of encode_cu()
> > > by moving function encoding to separate method") break two selftests
> > > in libbpf CI (see [0]). Please take a look. I suspect some bad BTF,
> > > because both tests rely on kernel BTF info.
> > >
> > > You've previously asked about staging pahole changes. Did you make up
> > > your mind about branch names and the process overall? Seems like a
> > > good chance to bring this up ;-P
> > >
> > >   [0] https://travis-ci.com/github/libbpf/libbpf/jobs/514329152
> >
> > Ok, please add tmp.master as the staging branch, I'll move things to
> > master only after it passing thru CI.
> >
> 
> So I'm thinking about what's the best setup to catch pahole staging
> problems, but not break main libbpf CI and kernel-patches CI flows.
 
> How about we keep all the existing CI jobs to use pahole's master.

Agreed.

> Then add a separate job to do full kernel build with pahole built from
> staging branch. And mark it as non-critical (or whatever the
> terminology), so it doesn't mark the build red. I'd do that as a cron
> job that runs every day. That way if you don't have anything urgent,
> next day you'll get staging tested automatically. If you need to test
> right now, there is a way to re-trigger previous build and it will
> re-fetch latest staging (so there is a way for you to proactively
> test).
> 
> Basically, I want broken staging pahole to not interrupt anything we
> are doing. WDYT?

Sounds like a plan, please hand hold me on this, I'm not versed on
github.

- Arnaldo
 
> > Now looking at that code, must be something subtle...
> >
> > - Arnaldo

-- 

- Arnaldo

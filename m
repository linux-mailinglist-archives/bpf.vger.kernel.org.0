Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC3235FAB3
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 20:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353257AbhDNSUC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 14:20:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353215AbhDNST4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Apr 2021 14:19:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8FC6960FF0;
        Wed, 14 Apr 2021 18:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618424374;
        bh=aOSzYbb6UyX+jNuUFmbQ2HkO9J34deV2uGEys5JiEGk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kgojq+O9jlOfVqHvIBvAa9WQbVN7NhsLNxdgiGTy2sm4X1xCG/BxOyTfBcM9WXRsG
         YOOqDxqP+1CSkV5fHBCo7SlX8WOtYDCzV6HDQpuUIQ2i9f4XbKWPEJSWVUhbo/phBe
         L7C1aHH01YqiwHILMVZSn+0hYLPqAh409jy7Dt9K0cR0+rzDxZadD1OA4HONC5bNp5
         IR51fMEN4BcFOB0kUAy3TjQ+s/OEtBCXrcLvRXFrM0oikpJeoEFJ/Ej5FiqYmuAdqH
         cq/KPgS3q9ZvWB6Vv5GmbFiFbQi5FZNvKesSGghY721HqwX6sFFxh1WygDtkq+z78P
         1GaxEGZNT1x+w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5A3CE5C23EB; Wed, 14 Apr 2021 11:19:34 -0700 (PDT)
Date:   Wed, 14 Apr 2021 11:19:34 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: Selftest failures related to kern_sync_rcu()
Message-ID: <20210414181934.GV4510@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <87blaozi20.fsf@toke.dk>
 <CAEf4Bzb4LDi1ZVrhNEojpWhxi33tkv4rv6F7Czj28Y0tHxXh0w@mail.gmail.com>
 <87im4qo9ey.fsf@toke.dk>
 <CAEf4Bzahxw5-KTb2yOk8PHQmEyc6gDgTTR6znZjH2OhZ66wiUw@mail.gmail.com>
 <CAADnVQ+6xoBaD1GSSm=U3n67ooHvjGgxXPAHmFD6AhksrM8BoQ@mail.gmail.com>
 <20210414175245.GT4510@paulmck-ThinkPad-P17-Gen-1>
 <CAADnVQKyHb-j3-DSzF1wbzxYR39HdQiJVTVv1NkBS+9ZEeiEvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKyHb-j3-DSzF1wbzxYR39HdQiJVTVv1NkBS+9ZEeiEvg@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 14, 2021 at 10:59:23AM -0700, Alexei Starovoitov wrote:
> On Wed, Apr 14, 2021 at 10:52 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > > > > >                 if (num_online_cpus() > 1)
> > > > > >                         synchronize_rcu();
> >
> > In CONFIG_PREEMPT_NONE=y and CONFIG_PREEMPT_VOLUNTARY=y kernels, this
> > synchronize_rcu() will be a no-op anyway due to there only being the
> > one CPU.  Or are these failures all happening in CONFIG_PREEMPT=y kernels,
> > and in tests where preemption could result in the observed failures?
> >
> > Could you please send your .config file, or at least the relevant portions
> > of it?
> 
> That's my understanding as well. I assumed Toke has preempt=y.
> Otherwise the whole thing needs to be root caused properly.

Given that there is only a single CPU, I am still confused about what
the tests are expecting the membarrier() system call to do for them.

							Thanx, Paul

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F6835FAE3
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 20:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbhDNSlz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 14:41:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:47812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234462AbhDNSlz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Apr 2021 14:41:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A241610CB;
        Wed, 14 Apr 2021 18:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618425693;
        bh=3kghFRblUkOBEy6eAWiZL1tdyUrYgVTJu8MiG9t+JRc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XPVFb67nXYSxkmOx0NvlJYWvCr/yjmtFLdPfCzpYCeSCuFRTIERaFinsZ0zTsQRp0
         hRZTL8cMEQP6MG0cIG/Rxp2uSHkXzjG9MZ419+uSz4hRkvr4Vv8OMtO/xjb+nUv7yi
         /afz4XNOUByZ2uuwoq35+wNjeJ/SiyjcTaR+fe84fRdvfbTtu4DWrq2wA0Y6547IfI
         QpoGNrEAcDq1Egf2BCpNG978OqHR60K8gyxuNjyUu5Q1NCYi57SBthbiZ+gS/qGLyg
         ILSNVhT+yQgVeUVrIYqowqllby3xKDppLUi5yalhCbPFjd/PaJfQVP6A2P/BNs1S8q
         f/0s8G8wJoKBg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 30E095C23EB; Wed, 14 Apr 2021 11:41:33 -0700 (PDT)
Date:   Wed, 14 Apr 2021 11:41:33 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: Selftest failures related to kern_sync_rcu()
Message-ID: <20210414184133.GW4510@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <87blaozi20.fsf@toke.dk>
 <CAEf4Bzb4LDi1ZVrhNEojpWhxi33tkv4rv6F7Czj28Y0tHxXh0w@mail.gmail.com>
 <87im4qo9ey.fsf@toke.dk>
 <CAEf4Bzahxw5-KTb2yOk8PHQmEyc6gDgTTR6znZjH2OhZ66wiUw@mail.gmail.com>
 <CAADnVQ+6xoBaD1GSSm=U3n67ooHvjGgxXPAHmFD6AhksrM8BoQ@mail.gmail.com>
 <20210414175245.GT4510@paulmck-ThinkPad-P17-Gen-1>
 <CAADnVQKyHb-j3-DSzF1wbzxYR39HdQiJVTVv1NkBS+9ZEeiEvg@mail.gmail.com>
 <20210414181934.GV4510@paulmck-ThinkPad-P17-Gen-1>
 <87czuwlnhz.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87czuwlnhz.fsf@toke.dk>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 14, 2021 at 08:39:04PM +0200, Toke Høiland-Jørgensen wrote:
> "Paul E. McKenney" <paulmck@kernel.org> writes:
> 
> > On Wed, Apr 14, 2021 at 10:59:23AM -0700, Alexei Starovoitov wrote:
> >> On Wed, Apr 14, 2021 at 10:52 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >> >
> >> > > > > >                 if (num_online_cpus() > 1)
> >> > > > > >                         synchronize_rcu();
> >> >
> >> > In CONFIG_PREEMPT_NONE=y and CONFIG_PREEMPT_VOLUNTARY=y kernels, this
> >> > synchronize_rcu() will be a no-op anyway due to there only being the
> >> > one CPU.  Or are these failures all happening in CONFIG_PREEMPT=y kernels,
> >> > and in tests where preemption could result in the observed failures?
> >> >
> >> > Could you please send your .config file, or at least the relevant portions
> >> > of it?
> >> 
> >> That's my understanding as well. I assumed Toke has preempt=y.
> >> Otherwise the whole thing needs to be root caused properly.
> >
> > Given that there is only a single CPU, I am still confused about what
> > the tests are expecting the membarrier() system call to do for them.
> 
> It's basically a proxy for waiting until the objects are freed on the
> kernel side, as far as I understand...

There are in-kernel objects that are freed via call_rcu(), and the idea
is to wait until these objects really are freed?  Or am I still missing
out on what is going on?

							Thanx, Paul

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133E032B35D
	for <lists+bpf@lfdr.de>; Wed,  3 Mar 2021 04:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352546AbhCCDvJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Mar 2021 22:51:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:49388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1837232AbhCBUmi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Mar 2021 15:42:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EC4B60234;
        Tue,  2 Mar 2021 20:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614717718;
        bh=wJMln0/8S/r/7xCDmW9iZBDmp/NIg3AeCK78nY6Wc4I=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fScgFUmL8qw85ni5YQNv5VJPj6aBA0hLKhJusz09Lt8h3FZ4yWCbRv9gZxcAfPNYN
         1LnUm+efxhaD3sUcyRULdmgkIaoDwlLD11BJPGuISkOBvCrHnOZIVQYTSlQh1YvBNQ
         kQFRW/6JuXIhTarhhrF9ldCuqMJ23DhlRPHw6wNsoYTjwNfzlzMNrQ7rhK/uJp3tF+
         /42z4qGkxTfYgYsawg0Cxuz4afxPnoDtcdE25mZTYxM2qlxiy6g/1tiALwlvwM9hDW
         6FWNnVxsTNvfsB54u5mmCrwMoQPbFz+UKFV9UYyHVg/6W6SIVKYx8+uHj2rv5wTp/W
         FWtjvYEgFQ3Rg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C1262352259C; Tue,  2 Mar 2021 12:41:57 -0800 (PST)
Date:   Tue, 2 Mar 2021 12:41:57 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        stern@rowland.harvard.edu, parri.andrea@gmail.com,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>
Subject: Re: XDP socket rings, and LKMM litmus tests
Message-ID: <20210302204157.GR2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAJ+HfNhxWFeKnn1aZw-YJmzpBuCaoeGkXXKn058GhY-6ZBDtZA@mail.gmail.com>
 <20210302195758.GQ2696@paulmck-ThinkPad-P72>
 <CAJ+HfNj-_P=LpkrUjxcOR73ffMXwsJ+o+zMTfmkiuH2zZ5XCLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+HfNj-_P=LpkrUjxcOR73ffMXwsJ+o+zMTfmkiuH2zZ5XCLQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 02, 2021 at 09:24:04PM +0100, Björn Töpel wrote:
> On Tue, 2 Mar 2021 at 20:57, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Tue, Mar 02, 2021 at 07:46:27PM +0100, Björn Töpel wrote:
> 
> [...]
> 
> >
> > Before digging in too deeply, does the following simplification
> > still capture your intent?
> >
> 
> Thanks for having a look, Paul!
> 
> > P0(int *prod, int *cons, int *data)
> > {
> >     int p;
> >     int cond = 0;
> >
> >     p = READ_ONCE(*prod);
> >     if (p == READ_ONCE(*cons))
> >             cond = 1;
> 
> With this, yes!
> 
> >     if (cond) {
> >         smp_mb();
> >         WRITE_ONCE(*data, 1);
> >         smp_wmb();
> >         WRITE_ONCE(*prod, p ^ 1);
> >     }
> > }
> >
> > P1(int *prod, int *cons, int *data)
> > {
> >     int c;
> >     int d = -1;
> >     int cond = 0;
> >
> >     c = READ_ONCE(*cons);
> >     if (READ_ONCE(*prod) == c)
> >             cond = 1;
> 
> Hmm, this would not be the correct state transition.
> 
> c==1 && p==1 would set cond to 1, right?
> 
> I would agree with:
>   c = READ_ONCE(*cons);
>   if (READ_ONCE(*prod) != c)

Right you are!

With that, it looks to me like LKMM is OK with removing the smp_mb().
My guess is that the issue is that LKMM confines the effect of control
dependencies to a single "if" statement, hence my reworking of your
original.

							Thanx, Paul

> >
> >     if (cond == 1) {
> >         smp_rmb();
> >         d = READ_ONCE(*data);
> >         smp_mb();
> >         WRITE_ONCE(*cons, c ^ 1);
> >     }
> > }
> >
> >                                                         Thanx, Paul
> >
> 
> [...]
> 
> Björn

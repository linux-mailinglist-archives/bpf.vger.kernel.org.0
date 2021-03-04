Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A7B32DA16
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 20:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbhCDTIE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Mar 2021 14:08:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:39378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232710AbhCDTHs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Mar 2021 14:07:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95E0E64F67;
        Thu,  4 Mar 2021 19:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614884828;
        bh=/l5VRbFrTvmvmZN6qivrMkjUAbW4Ls8Cqu5YjvGDB4s=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ZpRJN5aOV7cObKde1Ofpz6SLKUmpDsDsfxvxkDLHqsaMBZ18Kb0OzKC2NUxOF/33l
         kJj4G4ziC9D02NkcLaZyLofnNDUGUGWqXQE51ZwMRNBddHbIm1LJp97QtjPovhzd6r
         6CbtVxH72i2iXg9Gd4g1FZhppIb7KkOYzBjSC8z7/ITrN3ws6rJDv5AAAqfJdyP20e
         pRWQoxELUvus4zQ+JSHCH9y6jjDf6qTiNnMK1QC9IzutbXX564JJ+GQj5z3DbGIN87
         ticul84ntHTmODQ57k/JTRDdX28G/Ddq82dxj9LxWpnIilQ6ua1pGWOSZbwFaY5ZqE
         l3ofPf5Y8OdTA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 67E613520831; Thu,  4 Mar 2021 11:07:08 -0800 (PST)
Date:   Thu, 4 Mar 2021 11:07:08 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     maranget <luc.maranget@inria.fr>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        "Alglave, Jade" <j.alglave@ucl.ac.uk>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>, joel@joelfernandes.org,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>
Subject: Re: XDP socket rings, and LKMM litmus tests
Message-ID: <20210304190708.GT2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAJ+HfNhxWFeKnn1aZw-YJmzpBuCaoeGkXXKn058GhY-6ZBDtZA@mail.gmail.com>
 <20210302211446.GA1541641@rowland.harvard.edu>
 <20210302235019.GT2696@paulmck-ThinkPad-P72>
 <20210303171221.GA1574518@rowland.harvard.edu>
 <20210303174022.GD2696@paulmck-ThinkPad-P72>
 <20210303202246.GC1582185@rowland.harvard.edu>
 <EF3F87BF-2AA1-4F96-A2A0-EA8A9D6FC8F7@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EF3F87BF-2AA1-4F96-A2A0-EA8A9D6FC8F7@inria.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 04, 2021 at 04:44:34PM +0100, maranget wrote:
> 
> 
> > On 3 Mar 2021, at 21:22, Alan Stern <stern@rowland.harvard.edu> wrote:
> > 
> >>> 
> >>> Local variables absolutely should be treated just like CPU registers, if 
> >>> possible.  In fact, the compiler has the option of keeping local 
> >>> variables stored in registers.
> >>> 
> >>> (Of course, things may get complicated if anyone writes a litmus test 
> >>> that uses a pointer to a local variable,  Especially if the pointer 
> >>> could hold the address of a local variable in one execution and a 
> >>> shared variable in another!  Or if the pointer is itself a shared 
> >>> variable and is dereferenced in another thread!)
> >> 
> >> Good point!  I did miss this complication.  ;-)
> > 
> > I suspect it wouldn't be so bad if herd7 disallowed taking addresses of 
> > local variables.
> 
> Herd7 does disallow taking addresses of local variables.

Good to know, and thank you!

> However, such  tests can still be run on machine, provided function bodies are accepted by the C compiler.

True, but that would be outside of the LKMM proper, correct?

							Thanx, Paul

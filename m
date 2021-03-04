Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627FE32DA00
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 20:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbhCDTG1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Mar 2021 14:06:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:38636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhCDTF4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Mar 2021 14:05:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2626C64F62;
        Thu,  4 Mar 2021 19:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614884716;
        bh=JDlrgpDqWIhApydlb10ONN+UktROsuzfop0m6TWYfM4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UGRIsbPaMRbi4/Oq4c/ZwjLvYOBsqY0kPPyxkAVhRpgQp/lrpZ0IQYXL0aBExBdse
         vp4BhJq2Ph1a+C8OPami/aZctacVL22bF+CaHEKRaM7spN9qlafJf9g5TGYPyX+A1t
         APblOpIiBTapm5iUd0J1rtNONfkvJxySZ0sMSyJu6tU3qy1GPPzuxenP8kxzhygXIU
         oQI7xc4L2zYrQmeEQPOIVchfzmaKVAajyDZLzSkDW9jmb2phoEL9mNumzNfoccRtn1
         TldeJxVFzHfpSdyI1d/+O8gYLMzOGlLR4lrlcMWsRhN05xCEzXqo1rSZ060qddQAbq
         df7OnKEp5MZ2Q==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D0AF43520831; Thu,  4 Mar 2021 11:05:15 -0800 (PST)
Date:   Thu, 4 Mar 2021 11:05:15 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        parri.andrea@gmail.com, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>
Subject: Re: XDP socket rings, and LKMM litmus tests
Message-ID: <20210304190515.GS2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAJ+HfNhxWFeKnn1aZw-YJmzpBuCaoeGkXXKn058GhY-6ZBDtZA@mail.gmail.com>
 <20210302211446.GA1541641@rowland.harvard.edu>
 <20210302235019.GT2696@paulmck-ThinkPad-P72>
 <20210303171221.GA1574518@rowland.harvard.edu>
 <20210303174022.GD2696@paulmck-ThinkPad-P72>
 <20210303202246.GC1582185@rowland.harvard.edu>
 <20210303220348.GL2696@paulmck-ThinkPad-P72>
 <20210304032101.GB1594980@rowland.harvard.edu>
 <20210304050407.GN2696@paulmck-ThinkPad-P72>
 <20210304153524.GA1612307@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304153524.GA1612307@rowland.harvard.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 04, 2021 at 10:35:24AM -0500, Alan Stern wrote:
> On Wed, Mar 03, 2021 at 09:04:07PM -0800, Paul E. McKenney wrote:
> > On Wed, Mar 03, 2021 at 10:21:01PM -0500, Alan Stern wrote:
> > > On Wed, Mar 03, 2021 at 02:03:48PM -0800, Paul E. McKenney wrote:
> > > > On Wed, Mar 03, 2021 at 03:22:46PM -0500, Alan Stern wrote:
> 
> > > > > >  And I cannot immediately think of a situation where
> > > > > > this approach would break that would not result in a data race being
> > > > > > flagged.  Or is this yet another failure of my imagination?
> > > > > 
> > > > > By definition, an access to a local variable cannot participate in a 
> > > > > data race because all such accesses are confined to a single thread.
> > > > 
> > > > True, but its value might have come from a load from a shared variable.
> > > 
> > > Then that load could have participated in a data race.  But the store to 
> > > the local variable cannot.
> > 
> > Agreed.  My thought was that if the ordering from the initial (non-local)
> > load mattered, then that initial load must have participated in a
> > data race.  Is that true, or am I failing to perceive some corner case?
> 
> Ordering can matter even when no data race is involved.  Just think
> about how much of the memory model is concerned with ordering of
> marked accesses, which don't participate in data races unless there is
> a conflicting plain access somewhere.

Fair point.  Should I have instead said "then that initial load must
have run concurrently with a store to that same variable"?

							Thanx, Paul

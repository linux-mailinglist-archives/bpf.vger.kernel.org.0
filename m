Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D13AA32C22C
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391983AbhCCW7x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 17:59:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:58026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1390402AbhCCWH3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Mar 2021 17:07:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 431BE64E41;
        Wed,  3 Mar 2021 21:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614808580;
        bh=nvrsaAh1K0woYB6MB0qOBTsrWHC2pRAqyUQ7YOcgOmE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jxMo3UHRY983ulV04oVNJRGmaQbNneITowiQtIrOMKMkyCKk5/vViO569UHoFZmiP
         0X5Ef/TU4LNLgvJhF7YO9xzL3D/aewmELC/3NAfAQjoYPweC+c6kr8bQdQtRHRd0WL
         ZQPzWzK1PF/gyS7WwVwddhgzP1JfV3DJcIdeQ5Xu5bdoT4Pd33fi4Q7DTrqkzpBxo0
         c/G9K75AKFQZnVSRIQZ9x+snWeQVFyig37aY1QPail9jPubQ22Wt0KfyYpMipmend9
         kjumS5ZxwfkaH4hHPde0N2Zs/B/Ufb62V+11OFMbjNslODlDMH0kqEKrLwqeOW86oR
         Cyg4bOUSk+X0g==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 083183522591; Wed,  3 Mar 2021 13:56:20 -0800 (PST)
Date:   Wed, 3 Mar 2021 13:56:20 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     maranget <luc.maranget@inria.fr>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        parri.andrea@gmail.com, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>
Subject: Re: XDP socket rings, and LKMM litmus tests
Message-ID: <20210303215619.GK2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAJ+HfNhxWFeKnn1aZw-YJmzpBuCaoeGkXXKn058GhY-6ZBDtZA@mail.gmail.com>
 <20210302211446.GA1541641@rowland.harvard.edu>
 <20210302235019.GT2696@paulmck-ThinkPad-P72>
 <20210303171221.GA1574518@rowland.harvard.edu>
 <29736B0B-9960-473C-85BB-5714F181198B@inria.fr>
 <F6EF0AE0-F0AA-4158-988B-C2638738B054@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F6EF0AE0-F0AA-4158-988B-C2638738B054@inria.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 03, 2021 at 06:39:14PM +0100, maranget wrote:
> 
> 
> > On 3 Mar 2021, at 18:37, maranget <luc.maranget@inria.fr> wrote:
> > 
> > I have made a PR to herd7 that performs the change. The commit message states the new definition.
> 
> For those who are interested
> <https://github.com/herd/herdtools7/pull/183>

And I just confirmed that with this change, Björn's original litmus
test behaves as desired.  Merci beaucoup, Luc!

The new herd7 also passes the in-kernel regression test, and also all
of the github "litmus" archive's tests up to six processes that are
flagged with expected outcomes except for these five tests, which
are expected failures:

	litmus/manual/deps/LB-addr-equals.litmus
	litmus/manual/deps/LB-ctls-bothvals-a.litmus
	litmus/manual/deps/LB-ctls-diffvals-det.litmus
	litmus/manual/deps/LB-ctls-sameval-barrier.litmus
	litmus/manual/deps/LB-ctls-sameval.litmus

This situation is a bit silly, so I changed the "Results" clause
and added a comment noting that LKMM does not yet know about these
corner cases.

I just started a longer regression test, but this will take some time.

							Thanx, Paul

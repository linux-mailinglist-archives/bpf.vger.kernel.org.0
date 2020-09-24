Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14BFC2767E3
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 06:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgIXE3g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 00:29:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:48768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbgIXE3g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 00:29:36 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A4C020888;
        Thu, 24 Sep 2020 04:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600921776;
        bh=vMTPxsuZ6SRzpJC0xTX5yCd+YWzo04WVJM/7L6AUrsY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MsOmAxgg+jysqlFTskUiS43OIWcfhjb3IBqqvPrxciN9Ur/8QQpDAgVGugXdCw6Vy
         k7+jMW9x2yPqiZYQaSP0jA2AfwTTIMLpO9aX2iUwBLNWdjMV94A/7Ijpg5sGpTTGkG
         4wV85SHLPay1YhrIxUkkCIkUZtEHcPJ7NuBkU21w=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E88A935226CB; Wed, 23 Sep 2020 21:29:35 -0700 (PDT)
Date:   Wed, 23 Sep 2020 21:29:35 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, rcu@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@redhat.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [GIT PULL rcu-tasks-trace] 50x speedup for
 synchronize_rcu_tasks_trace()
Message-ID: <20200924042935.GV29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200922162542.GA18664@paulmck-ThinkPad-P72>
 <CAADnVQJfmFjVRqJopeqy_7bHVdQ9x+i9d94Sv7Dshnh40FisTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJfmFjVRqJopeqy_7bHVdQ9x+i9d94Sv7Dshnh40FisTA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 23, 2020 at 07:46:15PM -0700, Alexei Starovoitov wrote:
> On Tue, Sep 22, 2020 at 9:25 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Hello, Alexei,
> >
> > This pull request contains eight commits that speed up RCU Tasks Trace
> > grace periods by a factor of 50, fix a few race conditions exposed
> > by this speedup, and clean up a couple of minor issues.  These have
> > been exposed to 0day and -next testing, and have passed well over 1,000
> > hours of rcutorture testing, some of which has contained ad-hoc changes
> > to further increase race probabilities.  So they should be solid!
> > (Famous last words...)
> >
> > I would normally have sent this series up through -tip, but as we
> > discussed, going up through the BFP and networking trees provides the
> > needed exposure to real-world testing of these changes.  Please note
> > that the first patch is already in mainline, but given identical SHA-1
> > commit IDs, git should have no problem figuring this out.  I will also
> > be retaining these commits in -rcu in order to continue exposing them
> > to rcutorture testing, but again the identical SHA-1 commit IDs will
> > make everything work out.
> 
> Pulled into bpf-next. Thanks a lot.
> 
> Also confirming 50x speedup.
> Really nice to see that selftests/bpf are now fast again.
> 
> Not only all bpf developers will be running these patches now,
> but the bpf CI system will be exercising them as well.

Sounds very good, thank you!  If problems arise, you know where
to find me.  As do most of the people running these patches, I
would guess.  ;-)

							Thanx, Paul

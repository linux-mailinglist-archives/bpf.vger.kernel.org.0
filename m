Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17AAB14654D
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2020 11:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgAWKDU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 05:03:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:56588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbgAWKDU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jan 2020 05:03:20 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4C7E24655;
        Thu, 23 Jan 2020 10:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579773799;
        bh=N3XkL17Wojfkt7YhtPf2926Re43uxA07Wv9vZpSBb/8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=QaIBvsqKSXYB8353wgwEwkkc29yIvr18EsYDsUYa+GpFtF33BglxppddXaqLCGLjw
         X5pnL419hiTzCYpn9jAwkw8rQwYE0n/MsZ3hhPVBXYauddJ6qdBIQAeB+p4LfmwY8z
         XxQNKjFzORJ/SmuHbreDtejZzDkCuUeuJUTyl/ss=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AC26E3522727; Thu, 23 Jan 2020 02:03:18 -0800 (PST)
Date:   Thu, 23 Jan 2020 02:03:18 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "David S . Miller" <davem@davemloft.net>, joel@joelfernandes.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: Re: [RFT PATCH 04/13] kprobes: Make optimizer delay to 1 second
Message-ID: <20200123100318.GP2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <157918584866.29301.6941815715391411338.stgit@devnote2>
 <157918589199.29301.4419459150054220408.stgit@devnote2>
 <20200121192905.0f001c61@gandalf.local.home>
 <20200122162317.0299cf722dd618147d97e89c@kernel.org>
 <20200122071115.28e3c763@gandalf.local.home>
 <20200122221240.cef447446785f46862fee97a@kernel.org>
 <20200122165432.GH2935@paulmck-ThinkPad-P72>
 <20200123103334.6e1821625643d007297ecf94@kernel.org>
 <20200123022647.GO2935@paulmck-ThinkPad-P72>
 <20200123151328.f977525ea447da3b7fe4256d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123151328.f977525ea447da3b7fe4256d@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 23, 2020 at 03:13:28PM +0900, Masami Hiramatsu wrote:
> On Wed, 22 Jan 2020 18:26:47 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > > Anyway, without this update, I added a printk to count optimizer
> > > queue-length and found that all optimizer call with a single kprobe
> > > on the quenes. I think this depends on the machine, but as far as
> > > I tested on 8-threads qemu x86, shows this result...
> > > 
> > > Probes: 256 kprobe_events
> > > Enable events
> > > real	0m 0.02s
> > > user	0m 0.00s
> > > sys	0m 0.02s
> > > [   17.730548] Queue-update: 180, skipped, Total Queued: 180
> > > [   17.739445] Queue-update: 1, go, Total Queued: 180
> > > Disable events
> [...]
> > > [   41.135594] Queue-update: 1, go, Total Queued: 1
> > > real	0m 21.40s
> > > user	0m 0.00s
> > > sys	0m 0.04s
> > 
> > So 21.4s/256 = 84 milliseconds per event disable, correct?
> 
> Actually, it seems only 172 probes are on the unoptimized list, so
> the number will be a bit different.
> 
> Anyway, that above elapsed time is including non-batch optimizer
> working time as below.
> 
> (1) start looping on probe events
>   (2) disabling-kprobe
>     (2.1) wait kprobe_mutex if optimizer is running
>     (2.2) if the kprobe is on optimized kprobe, queue it to unoptimizing
>           list and kick optimizer with 5 jiffies delay
>   (4) unlink enabled event
>   (5) wait synchronize_rcu()
>   (6) optimizer start optimization before finishing (5)
> (7) goto (1)
> 
> I think the disabling performance issue came from (6) (and (2.1)).
> Thus, if we change (2.2) to 1 HZ jiffies, the optimizer will start
> after some loops are done. (and the optimizer detects "active"
> queuing, postpone the process)
> 
> > 
> > It might be worth trying synchronize_rcu_expedited() just as an experiment
> > to see if it speeds things up significantly.
> 
> Would you mean replacing synchronize_rcu() in disabling loop, or
> replacing synchronize_rcu_tasks() in optimizer?

The former.  (There is no synchronize_rcu_tasks_expedited().)

> I think that is not a root cause of this behavior, since if we
> make the optimizer delay to 1 sec, it seems enough for making
> it a batch operation. See below, this is the result with patched
> kernel (1 HZ delay).
> 
> Probes: 256 kprobe_events
> Enable events
> real	0m 0.07s
> user	0m 0.00s
> sys	0m 0.07s
> [   19.191181] Queue-update: 180, skipped, Total Queued: 180
> Disable events
> [   20.214966] Queue-update: 1, go, Total Queued: 172
> [   21.302924] Queue-update: 86, skipped, Total Queued: 86
> real	0m 2.11s
> user	0m 0.00s
> sys	0m 0.03s
> [   22.327173] Queue-update: 87, skipped, Total Queued: 172
> [   23.350933] Queue-update: 1, go, Total Queued: 172
> Remove events
> real	0m 2.13s
> user	0m 0.02s
> sys	0m 0.02s
> 
> As you can see, the optimizer ran outside of the disabling loop.
> In that case, it is OK to synchronize RCU tasks in the optimizer
> because it just runs *once* per multiple probe events.

Even better!

> >From above result, 86 probes are disabled per 1 sec delay.
> Each probe disabling took 11-12 msec in average. So 
> (HZ / 10) can also be good. (But note that the optimizer
> will retry to run each time until the disabling loop is
> finished.)
> 
> BTW, testing kernel was build with HZ=1000, if HZ=250 or HZ=100,
> the result will be different in the current code. So I think
> we should use HZ-based delay instead of fixed number.

Agreed, the HZ-based delay seems worth a try.

							Thanx, Paul

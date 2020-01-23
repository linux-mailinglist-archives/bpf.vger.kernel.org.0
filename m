Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC3031461E6
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2020 07:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgAWGNe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 01:13:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:57356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgAWGNe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jan 2020 01:13:34 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3611F24655;
        Thu, 23 Jan 2020 06:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579760014;
        bh=HgwXTG7/lJmoAGRVP88B5zaZHvQNCymL2+iVP33OqMQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ex0JaWa4OWOF+IKz1tBJ8l/tTXPp21JrNC5XYh4u24KYHeHf+5ZPuLW36/VI8IdeW
         PwkV2CJqwI6V3Lyn3ZrTgDcYziqxmt0l75rfQ/DtD3rQQrKeMmIea6amfj0+h8doHq
         FgCGYODIBR1HDnQODYbeaUXAezYDXYgwlVO+Ko4I=
Date:   Thu, 23 Jan 2020 15:13:28 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     paulmck@kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "David S . Miller" <davem@davemloft.net>, joel@joelfernandes.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [RFT PATCH 04/13] kprobes: Make optimizer delay to 1 second
Message-Id: <20200123151328.f977525ea447da3b7fe4256d@kernel.org>
In-Reply-To: <20200123022647.GO2935@paulmck-ThinkPad-P72>
References: <157918584866.29301.6941815715391411338.stgit@devnote2>
        <157918589199.29301.4419459150054220408.stgit@devnote2>
        <20200121192905.0f001c61@gandalf.local.home>
        <20200122162317.0299cf722dd618147d97e89c@kernel.org>
        <20200122071115.28e3c763@gandalf.local.home>
        <20200122221240.cef447446785f46862fee97a@kernel.org>
        <20200122165432.GH2935@paulmck-ThinkPad-P72>
        <20200123103334.6e1821625643d007297ecf94@kernel.org>
        <20200123022647.GO2935@paulmck-ThinkPad-P72>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 22 Jan 2020 18:26:47 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > Anyway, without this update, I added a printk to count optimizer
> > queue-length and found that all optimizer call with a single kprobe
> > on the quenes. I think this depends on the machine, but as far as
> > I tested on 8-threads qemu x86, shows this result...
> > 
> > Probes: 256 kprobe_events
> > Enable events
> > real	0m 0.02s
> > user	0m 0.00s
> > sys	0m 0.02s
> > [   17.730548] Queue-update: 180, skipped, Total Queued: 180
> > [   17.739445] Queue-update: 1, go, Total Queued: 180
> > Disable events
[...]
> > [   41.135594] Queue-update: 1, go, Total Queued: 1
> > real	0m 21.40s
> > user	0m 0.00s
> > sys	0m 0.04s
> 
> So 21.4s/256 = 84 milliseconds per event disable, correct?

Actually, it seems only 172 probes are on the unoptimized list, so
the number will be a bit different.

Anyway, that above elapsed time is including non-batch optimizer
working time as below.

(1) start looping on probe events
  (2) disabling-kprobe
    (2.1) wait kprobe_mutex if optimizer is running
    (2.2) if the kprobe is on optimized kprobe, queue it to unoptimizing
          list and kick optimizer with 5 jiffies delay
  (4) unlink enabled event
  (5) wait synchronize_rcu()
  (6) optimizer start optimization before finishing (5)
(7) goto (1)

I think the disabling performance issue came from (6) (and (2.1)).
Thus, if we change (2.2) to 1 HZ jiffies, the optimizer will start
after some loops are done. (and the optimizer detects "active"
queuing, postpone the process)

> 
> It might be worth trying synchronize_rcu_expedited() just as an experiment
> to see if it speeds things up significantly.

Would you mean replacing synchronize_rcu() in disabling loop, or
replacing synchronize_rcu_tasks() in optimizer?

I think that is not a root cause of this behavior, since if we
make the optimizer delay to 1 sec, it seems enough for making
it a batch operation. See below, this is the result with patched
kernel (1 HZ delay).

Probes: 256 kprobe_events
Enable events
real	0m 0.07s
user	0m 0.00s
sys	0m 0.07s
[   19.191181] Queue-update: 180, skipped, Total Queued: 180
Disable events
[   20.214966] Queue-update: 1, go, Total Queued: 172
[   21.302924] Queue-update: 86, skipped, Total Queued: 86
real	0m 2.11s
user	0m 0.00s
sys	0m 0.03s
[   22.327173] Queue-update: 87, skipped, Total Queued: 172
[   23.350933] Queue-update: 1, go, Total Queued: 172
Remove events
real	0m 2.13s
user	0m 0.02s
sys	0m 0.02s

As you can see, the optimizer ran outside of the disabling loop.
In that case, it is OK to synchronize RCU tasks in the optimizer
because it just runs *once* per multiple probe events.

From above result, 86 probes are disabled per 1 sec delay.
Each probe disabling took 11-12 msec in average. So 
(HZ / 10) can also be good. (But note that the optimizer
will retry to run each time until the disabling loop is
finished.)

BTW, testing kernel was build with HZ=1000, if HZ=250 or HZ=100,
the result will be different in the current code. So I think
we should use HZ-based delay instead of fixed number.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>

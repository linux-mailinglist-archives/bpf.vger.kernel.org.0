Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F354144C6C
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2020 08:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgAVHXX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jan 2020 02:23:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:51794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbgAVHXX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jan 2020 02:23:23 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3E8F2253D;
        Wed, 22 Jan 2020 07:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579677802;
        bh=bbAh3rhHmfmleomVp4XItkwvBRm3+pggpqJQcYaj0pw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Nw68NfTqgmtfdHWRdZhjK8XTTkzkkBbqDAlHJguxpOQHBCZ9k0h8oHLITVrXovekX
         Jbs/lNg5w1Fhwq+h/+Sj6hWzQT0taikEShjBomAjFAmx8I0ztz8GbX86VAoaHPc8rI
         8XZgNtFfpn/UKaMgEwOfoMsF67orejhKxLrwHoFI=
Date:   Wed, 22 Jan 2020 16:23:17 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Brendan Gregg <brendan.d.gregg@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "David S . Miller" <davem@davemloft.net>, paulmck@kernel.org,
        joel@joelfernandes.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: Re: [RFT PATCH 04/13] kprobes: Make optimizer delay to 1 second
Message-Id: <20200122162317.0299cf722dd618147d97e89c@kernel.org>
In-Reply-To: <20200121192905.0f001c61@gandalf.local.home>
References: <157918584866.29301.6941815715391411338.stgit@devnote2>
        <157918589199.29301.4419459150054220408.stgit@devnote2>
        <20200121192905.0f001c61@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 21 Jan 2020 19:29:05 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 16 Jan 2020 23:44:52 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Since the 5 jiffies delay for the optimizer is too
> > short to wait for other probes, make it longer,
> > like 1 second.
> 
> Hi Masami,
> 
> Can you explain more *why* 5 jiffies is too short.

Yes, I had introduced this 5 jiffies delay for multiple probe registration
and unregistration like systemtap, which will use array-based interface to
register/unregister. In that case, 5 jiffies will be enough for the delay
to wait for other kprobe registration/unregsitration.

However, since perf and ftrace register/unregister probes one-by-one with
RCU synchronization interval, the optimizer will be started before
finishing to register/unregister all probes.
And the optimizer locks kprobe_mutex a while -- RCU-tasks synchronization.
Since the kprobe_mutex is also involved in disabling kprobes, this also
stops probe-event disabling.

Maybe 5 jiffies is enough for adding/removing a few probe events, but
not enough for dozens of probe events.

Thank you,

> 
> Thanks!
> 
> -- Steve
> 
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  kernel/kprobes.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index 0dacdcecc90f..9c6e230852ad 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -469,7 +469,8 @@ static int kprobe_optimizer_queue_update;
> >  
> >  static void kprobe_optimizer(struct work_struct *work);
> >  static DECLARE_DELAYED_WORK(optimizing_work, kprobe_optimizer);
> > -#define OPTIMIZE_DELAY 5
> > +/* Wait 1 second for starting optimization */
> > +#define OPTIMIZE_DELAY HZ
> >  
> >  /*
> >   * Optimize (replace a breakpoint with a jump) kprobes listed on
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

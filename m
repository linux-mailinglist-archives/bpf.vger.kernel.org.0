Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2BD31454DD
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2020 14:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgAVNM5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jan 2020 08:12:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:59898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbgAVNM5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jan 2020 08:12:57 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8585B20678;
        Wed, 22 Jan 2020 13:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579698776;
        bh=rF36Oz7wXrvLS/QAc8njrTJvSrYg9SsTB5g+8LbuheA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LZC22PoSaj/z5pRc6iN1xz6R0PhJMSUaC9G+vHh3R1q1i31rZRmlNd26EvmG8YbT+
         KQlSs1Wux++EWx0OR5ypDezuXdhpFHiAr9BThDa/CwiA5qR56fvkViSL7nRHNtLAjC
         fjoVvVN7PinQsm1wfBu/t0uPvgWpuQF6uTWJFMC8=
Date:   Wed, 22 Jan 2020 22:12:40 +0900
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
Message-Id: <20200122221240.cef447446785f46862fee97a@kernel.org>
In-Reply-To: <20200122071115.28e3c763@gandalf.local.home>
References: <157918584866.29301.6941815715391411338.stgit@devnote2>
        <157918589199.29301.4419459150054220408.stgit@devnote2>
        <20200121192905.0f001c61@gandalf.local.home>
        <20200122162317.0299cf722dd618147d97e89c@kernel.org>
        <20200122071115.28e3c763@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 22 Jan 2020 07:11:15 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 22 Jan 2020 16:23:17 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Tue, 21 Jan 2020 19:29:05 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > On Thu, 16 Jan 2020 23:44:52 +0900
> > > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >   
> > > > Since the 5 jiffies delay for the optimizer is too
> > > > short to wait for other probes, make it longer,
> > > > like 1 second.  
> > > 
> > > Hi Masami,
> > > 
> > > Can you explain more *why* 5 jiffies is too short.  
> > 
> > Yes, I had introduced this 5 jiffies delay for multiple probe registration
> > and unregistration like systemtap, which will use array-based interface to
> > register/unregister. In that case, 5 jiffies will be enough for the delay
> > to wait for other kprobe registration/unregsitration.
> > 
> > However, since perf and ftrace register/unregister probes one-by-one with
> > RCU synchronization interval, the optimizer will be started before
> > finishing to register/unregister all probes.
> > And the optimizer locks kprobe_mutex a while -- RCU-tasks synchronization.
> > Since the kprobe_mutex is also involved in disabling kprobes, this also
> > stops probe-event disabling.
> > 
> > Maybe 5 jiffies is enough for adding/removing a few probe events, but
> > not enough for dozens of probe events.
> > 
> 
> Perhaps we should have a mechanism that can detect new probes being
> added, and just continue to delay the optimization, instead of having
> some arbitrary delay.

Yes, that is what [03/13] does :) 
Anyway, it seems that the RCU-synchronization takes more than 5 jiffies.
And in that case, [03/13] still doesn't work. That's why I added this patch
after that.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>

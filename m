Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC73B146065
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2020 02:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgAWBdk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jan 2020 20:33:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:49102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgAWBdk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jan 2020 20:33:40 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E96D24125;
        Thu, 23 Jan 2020 01:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579743219;
        bh=myHd0xxtAYA4MzDv/+EBMBjMsqwHwg57OhyKIipZXAY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YvUplKxyBu/kXyrKrUWaX35kMfrQbDAC1x8bfqJtEhZyjFz4ekoD1uGrPk7tyNe2A
         kroibVymaR9XGqpzdU1U0qVLrZQ6XuW0BM6nkP5IdAWvSIbX5CnGOyvchLO7m+3V3V
         rqBnJAgz+WgsrSf45hnSM0201PehjecRVFsHvDz8=
Date:   Thu, 23 Jan 2020 10:33:34 +0900
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
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: Re: [RFT PATCH 04/13] kprobes: Make optimizer delay to 1 second
Message-Id: <20200123103334.6e1821625643d007297ecf94@kernel.org>
In-Reply-To: <20200122165432.GH2935@paulmck-ThinkPad-P72>
References: <157918584866.29301.6941815715391411338.stgit@devnote2>
        <157918589199.29301.4419459150054220408.stgit@devnote2>
        <20200121192905.0f001c61@gandalf.local.home>
        <20200122162317.0299cf722dd618147d97e89c@kernel.org>
        <20200122071115.28e3c763@gandalf.local.home>
        <20200122221240.cef447446785f46862fee97a@kernel.org>
        <20200122165432.GH2935@paulmck-ThinkPad-P72>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 22 Jan 2020 08:54:32 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Wed, Jan 22, 2020 at 10:12:40PM +0900, Masami Hiramatsu wrote:
> > On Wed, 22 Jan 2020 07:11:15 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > On Wed, 22 Jan 2020 16:23:17 +0900
> > > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > 
> > > > On Tue, 21 Jan 2020 19:29:05 -0500
> > > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > > > 
> > > > > On Thu, 16 Jan 2020 23:44:52 +0900
> > > > > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > > >   
> > > > > > Since the 5 jiffies delay for the optimizer is too
> > > > > > short to wait for other probes, make it longer,
> > > > > > like 1 second.  
> > > > > 
> > > > > Hi Masami,
> > > > > 
> > > > > Can you explain more *why* 5 jiffies is too short.  
> > > > 
> > > > Yes, I had introduced this 5 jiffies delay for multiple probe registration
> > > > and unregistration like systemtap, which will use array-based interface to
> > > > register/unregister. In that case, 5 jiffies will be enough for the delay
> > > > to wait for other kprobe registration/unregsitration.
> > > > 
> > > > However, since perf and ftrace register/unregister probes one-by-one with
> > > > RCU synchronization interval, the optimizer will be started before
> > > > finishing to register/unregister all probes.
> > > > And the optimizer locks kprobe_mutex a while -- RCU-tasks synchronization.
> > > > Since the kprobe_mutex is also involved in disabling kprobes, this also
> > > > stops probe-event disabling.
> > > > 
> > > > Maybe 5 jiffies is enough for adding/removing a few probe events, but
> > > > not enough for dozens of probe events.
> > > > 
> > > 
> > > Perhaps we should have a mechanism that can detect new probes being
> > > added, and just continue to delay the optimization, instead of having
> > > some arbitrary delay.
> > 
> > Yes, that is what [03/13] does :) 
> > Anyway, it seems that the RCU-synchronization takes more than 5 jiffies.
> > And in that case, [03/13] still doesn't work. That's why I added this patch
> > after that.
> 
> If the RCU synchronization is synchronize_rcu_tasks(), then yes, it
> will often take way more than 5 jiffies.  If it is synchronize_rcu(),
> 5 jiffies would not be unusual, especially on larger systems.
> But in the case of synchronize_rcu(), one option is to instead use
> synchronize_rcu_expedited().  It is not clear that this last is really
> justified in this case, but figured it might be worth mentioning.

It is synchronize_rcu(), but it seems sometimes it is called several
times on one probe disabling.

Anyway, without this update, I added a printk to count optimizer
queue-length and found that all optimizer call with a single kprobe
on the quenes. I think this depends on the machine, but as far as
I tested on 8-threads qemu x86, shows this result...

Probes: 256 kprobe_events
Enable events
real	0m 0.02s
user	0m 0.00s
sys	0m 0.02s
[   17.730548] Queue-update: 180, skipped, Total Queued: 180
[   17.739445] Queue-update: 1, go, Total Queued: 180
Disable events
[   19.744634] Queue-update: 1, go, Total Queued: 1
[   19.770743] Queue-update: 1, go, Total Queued: 1
[   19.886625] Queue-update: 1, go, Total Queued: 1
[   20.006631] Queue-update: 1, go, Total Queued: 1
[   20.126628] Queue-update: 1, go, Total Queued: 1
[   20.246620] Queue-update: 1, go, Total Queued: 1
[   20.374665] Queue-update: 1, go, Total Queued: 1
[   20.486617] Queue-update: 1, go, Total Queued: 1
[   20.606608] Queue-update: 1, go, Total Queued: 1
[   20.726596] Queue-update: 1, go, Total Queued: 1
[   20.846608] Queue-update: 1, go, Total Queued: 1
[   20.966723] Queue-update: 1, go, Total Queued: 1
[   21.086611] Queue-update: 1, go, Total Queued: 1
[   21.206605] Queue-update: 1, go, Total Queued: 1
[   21.326603] Queue-update: 1, go, Total Queued: 1
[   21.462609] Queue-update: 1, go, Total Queued: 1
[   21.566755] Queue-update: 1, go, Total Queued: 1
[   21.686606] Queue-update: 1, go, Total Queued: 1
[   21.806611] Queue-update: 1, go, Total Queued: 1
[   21.926609] Queue-update: 1, go, Total Queued: 1
[   22.046621] Queue-update: 1, go, Total Queued: 1
[   22.166729] Queue-update: 1, go, Total Queued: 1
[   22.302609] Queue-update: 1, go, Total Queued: 1
[   22.510627] Queue-update: 1, go, Total Queued: 1
[   22.536638] Queue-update: 1, go, Total Queued: 1
[   22.654618] Queue-update: 1, go, Total Queued: 1
[   22.774643] Queue-update: 1, go, Total Queued: 1
[   22.902609] Queue-update: 1, go, Total Queued: 1
[   23.022608] Queue-update: 1, go, Total Queued: 1
[   23.158606] Queue-update: 1, go, Total Queued: 1
[   23.254618] Queue-update: 1, go, Total Queued: 1
[   23.374647] Queue-update: 1, go, Total Queued: 1
[   23.494605] Queue-update: 1, go, Total Queued: 1
[   23.614610] Queue-update: 1, go, Total Queued: 1
[   23.734606] Queue-update: 1, go, Total Queued: 1
[   23.854609] Queue-update: 1, go, Total Queued: 1
[   23.974615] Queue-update: 1, go, Total Queued: 1
[   24.094609] Queue-update: 1, go, Total Queued: 1
[   24.230607] Queue-update: 1, go, Total Queued: 1
[   24.342625] Queue-update: 1, go, Total Queued: 1
[   24.475478] Queue-update: 1, go, Total Queued: 1
[   24.574554] Queue-update: 1, go, Total Queued: 1
[   24.694605] Queue-update: 1, go, Total Queued: 1
[   24.814585] Queue-update: 1, go, Total Queued: 1
[   24.934591] Queue-update: 1, go, Total Queued: 1
[   25.054614] Queue-update: 1, go, Total Queued: 1
[   25.174628] Queue-update: 1, go, Total Queued: 1
[   25.294637] Queue-update: 1, go, Total Queued: 1
[   25.414620] Queue-update: 1, go, Total Queued: 1
[   25.534553] Queue-update: 1, go, Total Queued: 1
[   25.654610] Queue-update: 1, go, Total Queued: 1
[   25.774627] Queue-update: 1, go, Total Queued: 1
[   25.894609] Queue-update: 1, go, Total Queued: 1
[   26.030548] Queue-update: 1, go, Total Queued: 1
[   26.134626] Queue-update: 1, go, Total Queued: 1
[   26.254620] Queue-update: 1, go, Total Queued: 1
[   26.373603] Queue-update: 1, go, Total Queued: 1
[   26.502606] Queue-update: 1, go, Total Queued: 1
[   26.614607] Queue-update: 1, go, Total Queued: 1
[   26.734610] Queue-update: 1, go, Total Queued: 1
[   26.854620] Queue-update: 1, go, Total Queued: 1
[   26.974660] Queue-update: 1, go, Total Queued: 1
[   27.094620] Queue-update: 1, go, Total Queued: 1
[   27.214596] Queue-update: 1, go, Total Queued: 1
[   27.334640] Queue-update: 1, go, Total Queued: 1
[   27.494606] Queue-update: 1, go, Total Queued: 1
[   27.574703] Queue-update: 1, go, Total Queued: 1
[   27.694609] Queue-update: 1, go, Total Queued: 1
[   27.814607] Queue-update: 1, go, Total Queued: 1
[   27.934631] Queue-update: 1, go, Total Queued: 1
[   28.054606] Queue-update: 1, go, Total Queued: 1
[   28.182685] Queue-update: 1, go, Total Queued: 1
[   28.318568] Queue-update: 1, go, Total Queued: 1
[   28.422610] Queue-update: 1, go, Total Queued: 1
[   28.534621] Queue-update: 1, go, Total Queued: 1
[   28.654618] Queue-update: 1, go, Total Queued: 1
[   28.774622] Queue-update: 1, go, Total Queued: 1
[   28.894609] Queue-update: 1, go, Total Queued: 1
[   29.022609] Queue-update: 1, go, Total Queued: 1
[   29.150615] Queue-update: 1, go, Total Queued: 1
[   29.262610] Queue-update: 1, go, Total Queued: 1
[   29.374621] Queue-update: 1, go, Total Queued: 1
[   29.494606] Queue-update: 1, go, Total Queued: 1
[   29.614616] Queue-update: 1, go, Total Queued: 1
[   29.734607] Queue-update: 1, go, Total Queued: 1
[   29.854601] Queue-update: 1, go, Total Queued: 1
[   29.974610] Queue-update: 1, go, Total Queued: 1
[   30.094625] Queue-update: 1, go, Total Queued: 1
[   30.214606] Queue-update: 1, go, Total Queued: 1
[   30.334602] Queue-update: 1, go, Total Queued: 1
[   30.454634] Queue-update: 1, go, Total Queued: 1
[   30.574606] Queue-update: 1, go, Total Queued: 1
[   30.694589] Queue-update: 1, go, Total Queued: 1
[   30.814613] Queue-update: 1, go, Total Queued: 1
[   30.934602] Queue-update: 1, go, Total Queued: 1
[   31.054605] Queue-update: 1, go, Total Queued: 1
[   31.182596] Queue-update: 1, go, Total Queued: 1
[   31.318621] Queue-update: 1, go, Total Queued: 1
[   31.414615] Queue-update: 1, go, Total Queued: 1
[   31.534610] Queue-update: 1, go, Total Queued: 1
[   31.670608] Queue-update: 1, go, Total Queued: 1
[   31.774626] Queue-update: 1, go, Total Queued: 1
[   31.894607] Queue-update: 1, go, Total Queued: 1
[   32.014609] Queue-update: 1, go, Total Queued: 1
[   32.134607] Queue-update: 1, go, Total Queued: 1
[   32.254611] Queue-update: 1, go, Total Queued: 1
[   32.374608] Queue-update: 1, go, Total Queued: 1
[   32.494619] Queue-update: 1, go, Total Queued: 1
[   32.614607] Queue-update: 1, go, Total Queued: 1
[   32.734612] Queue-update: 1, go, Total Queued: 1
[   32.862616] Queue-update: 1, go, Total Queued: 1
[   32.974620] Queue-update: 1, go, Total Queued: 1
[   33.110609] Queue-update: 1, go, Total Queued: 1
[   33.214609] Queue-update: 1, go, Total Queued: 1
[   33.342611] Queue-update: 1, go, Total Queued: 1
[   33.454607] Queue-update: 1, go, Total Queued: 1
[   33.574611] Queue-update: 1, go, Total Queued: 1
[   33.694619] Queue-update: 1, go, Total Queued: 1
[   33.814607] Queue-update: 1, go, Total Queued: 1
[   33.950614] Queue-update: 1, go, Total Queued: 1
[   34.062609] Queue-update: 1, go, Total Queued: 1
[   34.174609] Queue-update: 1, go, Total Queued: 1
[   34.294619] Queue-update: 1, go, Total Queued: 1
[   34.430533] Queue-update: 1, go, Total Queued: 1
[   34.534594] Queue-update: 1, go, Total Queued: 1
[   34.654605] Queue-update: 1, go, Total Queued: 1
[   34.790596] Queue-update: 1, go, Total Queued: 1
[   34.902611] Queue-update: 1, go, Total Queued: 1
[   35.014630] Queue-update: 1, go, Total Queued: 1
[   35.134634] Queue-update: 1, go, Total Queued: 1
[   35.262608] Queue-update: 1, go, Total Queued: 1
[   35.374634] Queue-update: 1, go, Total Queued: 1
[   35.494617] Queue-update: 1, go, Total Queued: 1
[   35.622608] Queue-update: 1, go, Total Queued: 1
[   35.742610] Queue-update: 1, go, Total Queued: 1
[   35.854572] Queue-update: 1, go, Total Queued: 1
[   35.982596] Queue-update: 1, go, Total Queued: 1
[   36.094603] Queue-update: 1, go, Total Queued: 1
[   36.222612] Queue-update: 1, go, Total Queued: 1
[   36.334610] Queue-update: 1, go, Total Queued: 1
[   36.454619] Queue-update: 1, go, Total Queued: 1
[   36.574619] Queue-update: 1, go, Total Queued: 1
[   36.694643] Queue-update: 1, go, Total Queued: 1
[   36.814614] Queue-update: 1, go, Total Queued: 1
[   36.934610] Queue-update: 1, go, Total Queued: 1
[   37.062609] Queue-update: 1, go, Total Queued: 1
[   37.198611] Queue-update: 1, go, Total Queued: 1
[   37.294618] Queue-update: 1, go, Total Queued: 1
[   37.414618] Queue-update: 1, go, Total Queued: 1
[   37.534595] Queue-update: 1, go, Total Queued: 1
[   37.662594] Queue-update: 1, go, Total Queued: 1
[   37.774610] Queue-update: 1, go, Total Queued: 1
[   37.894618] Queue-update: 1, go, Total Queued: 1
[   38.014619] Queue-update: 1, go, Total Queued: 1
[   38.142612] Queue-update: 1, go, Total Queued: 1
[   38.254609] Queue-update: 1, go, Total Queued: 1
[   38.374619] Queue-update: 1, go, Total Queued: 1
[   38.502481] Queue-update: 1, go, Total Queued: 1
[   38.614596] Queue-update: 1, go, Total Queued: 1
[   38.734597] Queue-update: 1, go, Total Queued: 1
[   38.854606] Queue-update: 1, go, Total Queued: 1
[   38.974620] Queue-update: 1, go, Total Queued: 1
[   39.094617] Queue-update: 1, go, Total Queued: 1
[   39.222597] Queue-update: 1, go, Total Queued: 1
[   39.334610] Queue-update: 1, go, Total Queued: 1
[   39.454609] Queue-update: 1, go, Total Queued: 1
[   39.574633] Queue-update: 1, go, Total Queued: 1
[   39.694611] Queue-update: 1, go, Total Queued: 1
[   39.814608] Queue-update: 1, go, Total Queued: 1
[   39.934610] Queue-update: 1, go, Total Queued: 1
[   40.054621] Queue-update: 1, go, Total Queued: 1
[   40.174611] Queue-update: 1, go, Total Queued: 1
[   40.297471] Queue-update: 1, go, Total Queued: 1
[   40.414504] Queue-update: 1, go, Total Queued: 1
[   40.534601] Queue-update: 1, go, Total Queued: 1
[   40.654611] Queue-update: 1, go, Total Queued: 1
[   40.774609] Queue-update: 1, go, Total Queued: 1
[   40.894628] Queue-update: 1, go, Total Queued: 1
[   41.014608] Queue-update: 1, go, Total Queued: 1
[   41.135594] Queue-update: 1, go, Total Queued: 1
real	0m 21.40s
user	0m 0.00s
sys	0m 0.04s
Remove events
real	0m 2.14s
user	0m 0.00s
sys	0m 0.04s


Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>

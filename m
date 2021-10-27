Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8611C43D17F
	for <lists+bpf@lfdr.de>; Wed, 27 Oct 2021 21:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240552AbhJ0TQ7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Oct 2021 15:16:59 -0400
Received: from linux.microsoft.com ([13.77.154.182]:43700 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240526AbhJ0TQ7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Oct 2021 15:16:59 -0400
Received: from kbox (unknown [24.17.193.74])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6E44820A5C61;
        Wed, 27 Oct 2021 12:14:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6E44820A5C61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1635362073;
        bh=0up9HDY1ud1cNjZdsG8dJiMycYEcONBTeIzk10Rrlc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dKK2gqdO2G7vAfTphyxiO7FUkJV6KmfrkwdkmTiGm9GK6431eDndREqvF4nrG5Qjw
         VD+wTWEeXSv1aKJEPX0vsXOUXScIK1wqJ8g1HsvZ0PzlLCr3XAEp7Ca2s3JxaMX/ff
         O4W3OmfGmgF9ryEKob6nTyagsUDvPFdQZz2BxOM4=
Date:   Wed, 27 Oct 2021 12:14:28 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, bpf@vger.kernel.org
Subject: Re: [PATCH v3] user_events: Enable user processes to create and
 write to trace events
Message-ID: <20211027191428.GA1462@kbox>
References: <20211018230957.3032-1-beaub@linux.microsoft.com>
 <20211022223811.d0b5f03a7eee147c619d0202@kernel.org>
 <20211022224202.GA27683@kbox>
 <20211025104006.a322e4a5b4a56cdf3552ebac@kernel.org>
 <20211025172655.GA27927@kbox>
 <20211026172602.55843a03c5a5ba049b567b5a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026172602.55843a03c5a5ba049b567b5a@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 26, 2021 at 05:26:02PM +0900, Masami Hiramatsu wrote:
> > > > > > +	} else if (strstr(field, "flag ") == field) {
> > > > > > +		field += sizeof("flag");
> > > > > > +
> > > > > > +		if (!strcmp(field, "bpf_iter"))
> > > > > > +			user->flags |= FLAG_BPF_ITER;
> > > > > > +
> > > > > 
> > > > > What is this flag?
> > > > > 
> > > > We want to enable certain sensitive events the ability to mark that
> > > > there should never be a buffer copy. When FLAG_BPF_ITER is used the raw
> > > > iovecs are exposed out to eBPF instead of any sort of copy to reduce
> > > > latency. We run user_events in some highly performant code and want to
> > > > monitor things with the least amount of overhead possible.
> > > 
> > > Would you mean the event with this flag is only available from eBPF?
> > > 
> > It means that if eBPF attaches we will honor the users request to make
> > the data as cheap as possible to them. If a user with proper access
> > enables ftrace or perf on these high performant events they will still
> > come through (we don't want to hide them).
> > 
> > We will not be able to do that at all if we copy to heap or stack. At
> > that point we've lost the ability to delay copy/probing up until the
> > eBPF states it is actually required.
> 
> I think the bpf optimization should be discussed in the other thread.
> 

Yep

> Anyway, here I would like to know is that the syntax of this flag. 
> If the flag is for the user event itself, it would be better to add the flag
> with a special separator, not the "flag", so that user puts the flags
> after fieldN.
> 
> name[:FLAG1[,FLAG2...]] [field1[;field2...]] 
> 

Agreed, will do that.

> > > > I also ran with CONFIG_PROVE_RCU and didn't see anything show up in
> > > > dmesg.
> > > 
> > > Hmm, that's strange, because copy_from_iter(user) may cause a fault
> > > and yielded. Isn't it an iovec?
> > > 
> > Yeah, likely I just haven't hit a page fault case. I'll try to force one
> > in our testing to ensure this case is properly covered and doesn't cause
> > issues.
> 
> If you can suppress the fault (just skip copying when the fault occurs),
> I think it is OK. e.g. copy_from_user_nofault().
> 

We want to handle faults in these paths, which means handling them
outside of preemption disabled. This limits where we can have the buffer.

> > > > > > +				/*
> > > > > > +				 * Probes advance the iterator so we
> > > > > > +				 * need to have a copy for each probe.
> > > > > > +				 */
> > > > > > +				copy = *i;
> > > > > > +
> > > > > > +				probe_func = probe_func_ptr->func;
> > > > > > +				tpdata = probe_func_ptr->data;
> > > > > > +				probe_func(user, &copy, tpdata);
> > > > > 
> > > > > You seems to try to copy in from user space in each probe func, but
> > > > > please copy it here to the temporary buffer and pass it to the
> > > > > each probe function. Such performacne optimization can postpone.
> > > > > Start with simple implementation.
> > > > > 
> > > > Yes, this avoids double copying of the data in the normal paths. Moving
> > > > to a temp buffer only really changes 1 line in the probe functions
> > > > (copy_from_iter to copy_from_user).
> > > > 
> > > > If I were to create a temp buffer for simplicity I guess I would have to
> > > > kmalloc on each call or move to a per-cpu buffer or use stack memory and
> > > > limit how much data can be copied.
> > > 
> > > Anyway, it should be limited. You can not write more than 1 page, and
> > > do you really need it? And allocating kmalloc object is relatively low
> > > cost compared with a system call.
> > > 
> > Really, it's that low?
> > 
> > We are tracking cycles counts to compare user_events with other
> > telemetry data we have. Some people care a lot about that number, some
> > don't.
> 
> OK, then you can use a static per-cpu buffer for copying.
> 

I can only use static per-cpu buffers if preemption is disabled during
the copy. This limits to not being able to fault in data. For example
simple migration disabled could still see another user_event getting
traced on the same processor and corrupt / partial fill that per-CPU
buffer.

For the simple version I will use kmalloc and then we can talk on the
other threads about better ways to go about it.

Thanks,
-Beau

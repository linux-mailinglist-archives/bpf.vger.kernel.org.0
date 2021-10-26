Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D64243ADEE
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 10:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhJZI23 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 04:28:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230179AbhJZI23 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Oct 2021 04:28:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7171E60E96;
        Tue, 26 Oct 2021 08:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635236765;
        bh=RLffhc2JMhPOvyB0jMwCSZdBYrP9GPlEDYIPyyRRGSw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nJPqqC1e5piJWKtPCcHvQGH5c3Nzi6Zz+M5Af+HRbSr326tNB2C3gQuUSzjp5yrk8
         2XC2ezwaKebTSfriHAQr/nzyXsPA9IYsPRL0YTN/zj11sEARJzqLYWyXGqdXFczCNA
         J1kWfkv5cuEvTSwDEpQqMo/FIDr1PjMr7y6hD6GdnAgaWRgVnER4APdYCV53rIPLbj
         V6NIzrXRzrwurqZbGo73SZ68KzNmVTMoLRirAb+m0XtLXuvtMFljStIYTfSI2/nocc
         O6/FlKWrkUwWLbNOvYKAfvIA1A7RKSrtAr6mO51S0rjyNyRxpcCEmbbuMRhxSAKLM7
         kO6ts2mKwosdA==
Date:   Tue, 26 Oct 2021 17:26:02 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     rostedt@goodmis.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, bpf@vger.kernel.org
Subject: Re: [PATCH v3] user_events: Enable user processes to create and
 write to trace events
Message-Id: <20211026172602.55843a03c5a5ba049b567b5a@kernel.org>
In-Reply-To: <20211025172655.GA27927@kbox>
References: <20211018230957.3032-1-beaub@linux.microsoft.com>
        <20211022223811.d0b5f03a7eee147c619d0202@kernel.org>
        <20211022224202.GA27683@kbox>
        <20211025104006.a322e4a5b4a56cdf3552ebac@kernel.org>
        <20211025172655.GA27927@kbox>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 25 Oct 2021 10:26:55 -0700
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> On Mon, Oct 25, 2021 at 10:40:06AM +0900, Masami Hiramatsu wrote:
> > On Fri, 22 Oct 2021 15:42:02 -0700
> > Beau Belgrave <beaub@linux.microsoft.com> wrote:
> > 
> > > On Fri, Oct 22, 2021 at 10:38:11PM +0900, Masami Hiramatsu wrote:
> > > The idea is to allow user mode processes to describe their own data
> > > types if required. For that we need offset or size to be passed. If we
> > > require all user mode to only describe in types the kernel understands
> > > then I can remove the size field.
> > 
> > Hmm, I got it. I think it should be optional, and only for the types
> > which has "struct" prefix. Basic types like char, int, long etc should
> > keep the size as it is.
> > 
> Ok, sounds good.
> 
> > > Sorry, are you asking for several isolated patches? Or a single patch
> > > with multiple commits to the same file?
> > 
> > I mean the several isolated patches which commit to the same file.
> > (like upgrading it step by step.) You can make it a series.
> > 
> > > Typically after addition I am running a set of tests and benchmarks
> > > against the code, so having full functioning code is required to ensure
> > > I haven't broken anything.
> > 
> > Yes, you can put the test in the end of the series :)
> > 
> > > We are actively using these patches for various projects, which require
> > > ftrace, perf and eBPF to be functional.
> > 
> > The series usually merged at once :) I just asked you to break it
> > down to the several patches, so that I can review and discuss on
> > each feature in different threads.
> > 
> Got it, that's what I thought, but wanted to make sure.
> 
> > > If we don't care about either, then I can remove this. For custom types
> > > we are fine with using __rel_loc instead.
> > 
> > Or, as I said, you can pass the size when it has "struct" prefix. :)
> > The __rel_loc and __data_loc is usually used for storing arrays, especially
> > dynamic size array like null terminated string. But of course you can use
> > it for storing a big data structure.
> > Let's check how the libtraceevent(tools/lib/traceevent) parses the recorded
> > data.
> > 
> Ok, I'll go for struct prefix.
> 
> > > We have several events that describe the print format to use instead of
> > > using the default, like we allow in the kernel. This is currently how it
> > > is passed, it could be described in the new struct to the reg ioctl
> > > instead.
> > 
> > OK, the 'print_fmt' in 'format' file will show how the trace entry will be
> > printed in the trace buffer (in human readable style). But that is not
> > done automatically. You have to write the corresponding printout function
> > for the event. This means that user-specific format needs to be verified
> > and you need a programmable printout function. This is why it is hard to
> > support the custom data structure in ftrace.
> > Anyway, I think you'd better to start without this option. (and please
> > start with describing how the user-event arguments are shown in trace
> > buffer.)
> > 
> Got it, by that I assume you mean auto-generating a print_fmt statement
> for the user like the other probes. I will do that.

Yes, thanks :)

> 
> > > 
> > > > > +	} else if (strstr(field, "flag ") == field) {
> > > > > +		field += sizeof("flag");
> > > > > +
> > > > > +		if (!strcmp(field, "bpf_iter"))
> > > > > +			user->flags |= FLAG_BPF_ITER;
> > > > > +
> > > > 
> > > > What is this flag?
> > > > 
> > > We want to enable certain sensitive events the ability to mark that
> > > there should never be a buffer copy. When FLAG_BPF_ITER is used the raw
> > > iovecs are exposed out to eBPF instead of any sort of copy to reduce
> > > latency. We run user_events in some highly performant code and want to
> > > monitor things with the least amount of overhead possible.
> > 
> > Would you mean the event with this flag is only available from eBPF?
> > 
> It means that if eBPF attaches we will honor the users request to make
> the data as cheap as possible to them. If a user with proper access
> enables ftrace or perf on these high performant events they will still
> come through (we don't want to hide them).
> 
> We will not be able to do that at all if we copy to heap or stack. At
> that point we've lost the ability to delay copy/probing up until the
> eBPF states it is actually required.

I think the bpf optimization should be discussed in the other thread.

Anyway, here I would like to know is that the syntax of this flag. 
If the flag is for the user event itself, it would be better to add the flag
with a special separator, not the "flag", so that user puts the flags
after fieldN.

name[:FLAG1[,FLAG2...]] [field1[;field2...]] 

> 
> > > > > +	return strcmp(EVENT_NAME(user), event) == 0 &&
> > > > > +		(!system || strcmp(system, USER_EVENTS_SYSTEM) == 0);
> > > > 
> > > > For the minimal implementation, this is OK.
> > > > 
> > > > Note that it is better to check the rest of arguments with the event
> > > > parameters. E.g. if you have "myuevent int var", user cant try to remove
> > > > "-:myuevent char var".
> > > > 
> > > Ok, the reason we do this is because the events are going to be
> > > versioned. They might change their arguments and having a way to clear
> > > without knowing the exact arguments is not a bad thing in our cases.
> > 
> > Actually, as other dynamic events do, user can remove only by name, or
> > specifically with the arguments. So argument check is optional but
> > if user specified it, we should verify it.
> > 
> Ok, I will look into that.
> 
> > > 
> > > No one can remove an event while it's being used and the name cannot
> > > conflict since all user events go to the user_events sub-system and
> > > cannot be overriden.
> > > 
> > > > > +/*
> > > > > + * Validates the user payload and writes via iterator.
> > > > > + */
> > > > > +static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
> > > > > +{
> > > > > +	struct user_event_refs *refs;
> > > > > +	struct user_event *user = NULL;
> > > > > +	struct tracepoint *tp;
> > > > > +	ssize_t ret = i->count;
> > > > > +	int idx;
> > > > > +
> > > > > +	preempt_disable();
> > > > 
> > > > Why do you disable preemption here?
> > > > 
> > > My understanding was that preemption is to be disabled when using rcu
> > > protected by sched, which tracepoints and the refs are. We also want the
> > > correct processor to log the event (as near as we can).
> > > 
> > > Did I misunderstand rcu_dereference_sched_check()? I may be off in the
> > > weeds.
> > 
> > I see that you want to fix the processor id, but preempt_disable()
> > section should be minimum as possible and should not involve the
> > function which can access to user memeory.
> > 
> I guess I could use disable migration or just live with the rare event
> of a processor swap.

I think you can keep using preempt_disable(), of course it should avoid
including faultable code.

> 
> > > 
> > > I also ran with CONFIG_PROVE_RCU and didn't see anything show up in
> > > dmesg.
> > 
> > Hmm, that's strange, because copy_from_iter(user) may cause a fault
> > and yielded. Isn't it an iovec?
> > 
> Yeah, likely I just haven't hit a page fault case. I'll try to force one
> in our testing to ensure this case is properly covered and doesn't cause
> issues.

If you can suppress the fault (just skip copying when the fault occurs),
I think it is OK. e.g. copy_from_user_nofault().

> > > > > +
> > > > > +	if (unlikely(copy_from_iter(&idx, sizeof(idx), i) != sizeof(idx))) {
> > > > > +		ret = -EFAULT;
> > > > > +		goto out;
> > > > > +	}
> > > > 
> > > > Isn't this copy_from_iter() sleepable function?
> > > > 
> > > Yes, if we need to fault in data we want the data to come in. This is in
> > > the user process context of write() and writev() which I believe is the
> > > expected target for copy_from_iter().
> > > 
> > > During the probe copies we are not holding a lock or have interrupts
> > > disabled, under what circumstances would a page fault cause an issue in
> > > these paths? What is recommended here if we want to have page faults be
> > > allowed (Hoping they are rare)?
> > 
> > They are rare, but possibly the process is yielded if it is under heavy
> > memory pressure. I recommend you to copy the user write data in the stack
> > or thread-local buffer at once and pass it to probe functions. That is
> > safe way.
> > 
> > So, can you make it something like below?;
> > 
> > /* Copy event from user space */
> > copy_from_iter(&idx, sizeof(idx), i);
> > buf_len = copy_from_iter(local_buf, i->count, &i);
> > 
> > /* loop on recording functions */
> > preempt_disable();
> > user_event = get_user_event(file, idx);
> > if (user_event && user_event_is_enabled(user_event)) {
> > 	user_event_for_each_probe_func(user_event, probe_func, tpdata) {
> > 		probe_func(user_event, thread_buf, buf_len, tpdata);
> > 	}
> > }
> > preempt_enable();
> > 
> Yeah, I will start with the simple version above.
> 
> Ultimately I would like to do more of the following in the series:
> iov_iter_fault_in_readable(&i, i->count);
> 
> And then pass the iter to each probe and use copy_from_iter_nocache.

Good, that's easier for me to focus on each topic. :-)

> 
> That would pre-fault in the data and then copy_from_iter_nocache cannot
> take a fault and if for some reason it did, it would zero fill.

Shouldn't we drop the whole event? or leave the null data?
Anyway, it is switchable by the tracing option. For making histogram,
it is better to drop the null data. But for recording RAS data, user
might want to keep the event 'existance' recorded.

> I can disable migrations instead of preempt disable (eBPF does this).
> I could also disable page faults entirely as well to further protect
> against this.

yes, in that case it is OK to me.

> 
> > > 
> > > > > +				/*
> > > > > +				 * Probes advance the iterator so we
> > > > > +				 * need to have a copy for each probe.
> > > > > +				 */
> > > > > +				copy = *i;
> > > > > +
> > > > > +				probe_func = probe_func_ptr->func;
> > > > > +				tpdata = probe_func_ptr->data;
> > > > > +				probe_func(user, &copy, tpdata);
> > > > 
> > > > You seems to try to copy in from user space in each probe func, but
> > > > please copy it here to the temporary buffer and pass it to the
> > > > each probe function. Such performacne optimization can postpone.
> > > > Start with simple implementation.
> > > > 
> > > Yes, this avoids double copying of the data in the normal paths. Moving
> > > to a temp buffer only really changes 1 line in the probe functions
> > > (copy_from_iter to copy_from_user).
> > > 
> > > If I were to create a temp buffer for simplicity I guess I would have to
> > > kmalloc on each call or move to a per-cpu buffer or use stack memory and
> > > limit how much data can be copied.
> > 
> > Anyway, it should be limited. You can not write more than 1 page, and
> > do you really need it? And allocating kmalloc object is relatively low
> > cost compared with a system call.
> > 
> Really, it's that low?
> 
> We are tracking cycles counts to compare user_events with other
> telemetry data we have. Some people care a lot about that number, some
> don't.

OK, then you can use a static per-cpu buffer for copying.

> 
> Anyway, I can break it up in the series so we'll have a simple version
> and a faster version.
> 
> > > > > +	atomic_inc(&user->refs);
> > 
> > BTW, I recommend you to use a different name for this reference counter,
> > e.g. refcnt, since refs is used for "file-local reference user event tables".
> > 
> Sure.
> 
> > > > > +	case DIAG_IOCSREG:
> > > > > +		/* Register/lookup on behalf of user process */
> > > > > +		name = strndup_user(ubuf, MAX_EVENT_DESC);
> > > > > +
> > > > > +		if (IS_ERR(name)) {
> > > > > +			ret = PTR_ERR(name);
> > > > > +			goto out;
> > > > > +		}
> > > > > +
> > > > > +		mutex_lock(&event_mutex);
> > > > > +
> > > > > +		ret = user_event_parse_cmd(name, &user);
> > > > > +
> > > > > +		if (ret < 0)
> > > > > +			goto reg_out;
> > > > > +
> > > > > +		preempt_disable();
> > > > 
> > > > Why do you need to disable preemption here? It is enough to
> > > > use a mutex.
> > > > 
> > > Because user_events_ref_add use rcu protected by sched. It appears that
> > > preemption is supposed to be disabled when using that from my read of
> > > the code. Is this not correct or not required?
> > 
> > No not required, the "event_mutex" prevents other user from invoking
> > the user_events_ref_add(), thus the "file->private_data" will not be
> > updated from others. Thus you don't need to care the scenario of
> > "file->private_data" is changed between dereference and reassign it.
> > I think what you need is "lockdep_assert_held(&event_mutex)" in the
> > user_events_ref_add().
> > 
> I assume each rcu_dereference_sched should be wrapped with preemption
> disabled for a very short period of time? It seems to imply that's
> expected. I'm not sure if that's really required or just guidance.

Hm, indeed. rcu_dereference_sched() requires rcu_read_lock() but the
rcu_assign_pointer() doesn't. I guess we don't need rcu_dereference_sched()
for update side because we are sure no others update it. (and event_mutex
makes a memory barrier) Maybe READ_ONCE() is enough??

I mean if the update is protected by the 'event_mutex', we don't need
to disable preemption, because no one can update that. Or, if you concern
about warning, maybe you can write it as;

static int user_events_ref_add(struct file *file, struct user_event *user)
{
...
	lockdep_assert_held(&event_mutex);
	rcu_read_lock_sched();
        refs = rcu_dereference_sched(file->private_data);
	rcu_read_unlock_sched();

        if (refs) {
...
        rcu_assign_pointer(file->private_data, new_refs);


> 
> The reason I'm unsure is that the sched held check looks for preemption
> being disabled (!preemptible();). rcu_read_lock_sched() disables
> preeemption. For our case, I'm not sure if we really need
> rcu_read_lock_sched or if we can just dereference it with preemption
> disabled.

Yes, so you can just disable preemption only when accessing file->private_data as above :)

> 
> My guess is I should make these clear and have rcu_read_lock_sched() /
> unlock around each rcu_dereference_sched() call, it seems to enable
> debugging bad callers easier if things go bad.

Yeah, for the probing function side, you can keep using the preempt_disable().
For the other parts, rcu_read_lock_sched() will be more clear.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>

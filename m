Return-Path: <bpf+bounces-567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1A9703DAC
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 21:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC7B51C20BD3
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 19:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088681951F;
	Mon, 15 May 2023 19:24:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D5F19503
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 19:24:16 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B78916939;
	Mon, 15 May 2023 12:24:14 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
	by linux.microsoft.com (Postfix) with ESMTPSA id 209A320AECB0;
	Mon, 15 May 2023 12:24:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 209A320AECB0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1684178653;
	bh=263uRXBwzajWMvEDFtW2NIkluW3wByeKo+J7pz+n0M8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EV0Pk8R8bX5znJMh+FtaUeOnQ+fJ+E1JM80E+dCUTiXErrALlm/We0wI8xKCMtET/
	 5s1/0pLCnN24wP+HppqPm72bhWn9LC6o70GOPgyx1jPN+2to60Yktu+N0/i8N63BhD
	 Th27GMw3e/pOqspiuE4sTvzRfhQ2odvw84USGpFA=
Date: Mon, 15 May 2023 12:24:07 -0700
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	David Vernet <void@manifault.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	dthaler@microsoft.com, brauner@kernel.org, hch@infradead.org
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
Message-ID: <20230515192407.GA85@W11-BEAU-MD.localdomain>
References: <20230508163751.841-1-beaub@linux.microsoft.com>
 <CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
 <20230509130111.62d587f1@rorschach.local.home>
 <20230509163050.127d5123@rorschach.local.home>
 <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, May 15, 2023 at 09:57:07AM -0700, Alexei Starovoitov wrote:
> On Tue, May 09, 2023 at 04:30:50PM -0400, Steven Rostedt wrote:
> > On Tue, 9 May 2023 13:01:11 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > > I see no practical use case for bpf progs to be connected to user events.  
> > > 
> > > That's not a technical reason. Obviously they have a use case.
> > 
> > Alexei,
> > 
> > It was great having a chat with you during lunch at LSFMM/BPF!
> 
> Yeah. It was great catching up!
> 
> > Looking forward to your technical response that I believe are
> > legitimate requests. I'm replying here, as during our conversation, you
> > had the misperception that the user events had a system call when the
> > event was disabled. I told you I will point out the code that shows
> > that the kernel sets the bit, and that user space does not do a system
> > call when the event is disable.
> 
> Thank you for these details. Answer below...
> 
> > From the user space side, which does:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/samples/user_events/example.c#n60
> > 
> > 	/* Check if anyone is listening */
> > 	if (enabled) {
> > 		/* Yep, trace out our data */
> > 		writev(data_fd, (const struct iovec *)io, 2);
> > 
> > 		/* Increase the count */
> > 		count++;
> > 
> > 		printf("Something was attached, wrote data\n");
> > 	}
> > 
> > 
> > Where it told the kernel about that "enabled" variable:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/samples/user_events/example.c#n47
> > 
> > 	if (event_reg(data_fd, "test u32 count", &write, &enabled) == -1)
> > 		return errno;
> > 
> > static int event_reg(int fd, const char *command, int *write, int *enabled)
> > {
> > 	struct user_reg reg = {0};
> > 
> > 	reg.size = sizeof(reg);
> > 	reg.enable_bit = 31;
> > 	reg.enable_size = sizeof(*enabled);
> > 	reg.enable_addr = (__u64)enabled;
> > 	reg.name_args = (__u64)command;
> > 
> > 	if (ioctl(fd, DIAG_IOCSREG, &reg) == -1)
> > 		return -1;
> > 
> > 	*write = reg.write_index;
> > 
> > 	return 0;
> > }
> > 
> > The above will add a trace event into tracefs. When someone does:
> > 
> >  # echo 1 > /sys/kernel/tracing/user_events/test/enable
> > 
> > The kernel will trigger the class->reg function, defined by:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/trace/trace_events_user.c#n1804
> > 
> > 	user->class.reg = user_event_reg;
> > 
> > Which calls: 
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/trace/trace_events_user.c#n1555
> > 
> > 	update_enable_bit_for(user);
> > 
> > Which does:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/trace/trace_events_user.c#n1465
> > 
> > update_enable_bit_for() { 
> > 	[..]
> > 	user_event_enabler_update(user);
> > 
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/trace/trace_events_user.c#n451
> > 
> > user_event_enabler_update() {
> > 	[..]
> > 	user_event_enabler_write(mm, enabler, true, &attempt);
> 
> Which will do
> rcu_read_lock()
> and then call user_event_enabler_write() under lock...
> 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/trace/trace_events_user.c#n385
> > 
> > static int user_event_enabler_write(struct user_event_mm *mm,
> > 				    struct user_event_enabler *enabler,
> > 				    bool fixup_fault, int *attempt)
> > {
> > 	unsigned long uaddr = enabler->addr;
> > 	unsigned long *ptr;
> > 	struct page *page;
> > 	void *kaddr;
> > 	int ret;
> > 
> > 	lockdep_assert_held(&event_mutex);
> > 	mmap_assert_locked(mm->mm);
> > 
> > 	*attempt += 1;
> > 
> > 	/* Ensure MM has tasks, cannot use after exit_mm() */
> > 	if (refcount_read(&mm->tasks) == 0)
> > 		return -ENOENT;
> > 
> > 	if (unlikely(test_bit(ENABLE_VAL_FAULTING_BIT, ENABLE_BITOPS(enabler)) ||
> > 		     test_bit(ENABLE_VAL_FREEING_BIT, ENABLE_BITOPS(enabler))))
> > 		return -EBUSY;
> > 
> > 	ret = pin_user_pages_remote(mm->mm, uaddr, 1, FOLL_WRITE | FOLL_NOFAULT,
> > 				    &page, NULL, NULL);
> 
> ... which will call pin_user_pages_remote() in RCU CS.
> This looks buggy, since pin_user_pages_remote() may schedule.
> 

If it's possible to schedule, I can change this to cache the probe
callbacks under RCU then drop it. However, when would
pin_user_pages_remote() schedule with FOLL_NOFAULT? I couldn't pick up
where it might schedule?

> > 	if (unlikely(ret <= 0)) {
> > 		if (!fixup_fault)
> > 			return -EFAULT;
> > 
> > 		if (!user_event_enabler_queue_fault(mm, enabler, *attempt))
> > 			pr_warn("user_events: Unable to queue fault handler\n");
> 
> This part looks questionable.
> 
> The only users of fixup_user_fault() were futex and KVM.
> Now user_events are calling it too from user_event_mm_fault_in() where
> "bool unlocked;" is uninitialized and state of this flag is not checked
> after fixup_user_fault() call.
> Not an MM expert, but this is suspicious.
> 

fixup_user_fault() seems like a good function to use for this, especially
with with a pointer to unlocked passed (handles killable process and
does an internal retry). I understand the unlocked value states the
mmap_read_lock() that was taken was unlocked then reacquired. This does
not seem like an issue for our scenario. Would love someone from MM to
chime in (these patches were sent out to MM for comments, but didn't get
any).

> > 
> > 		return -EFAULT;
> > 	}
> > 
> > 	kaddr = kmap_local_page(page);
> > 	ptr = kaddr + (uaddr & ~PAGE_MASK);
> > 
> > 	/* Update bit atomically, user tracers must be atomic as well */
> > 	if (enabler->event && enabler->event->status)
> > 		set_bit(enabler->values & ENABLE_VAL_BIT_MASK, ptr);
> > 	else
> > 		clear_bit(enabler->values & ENABLE_VAL_BIT_MASK, ptr);
> 
> Furthermore.
> Here the kernel writes bits in user pages.
> It's missing user_access_begin/end.
> Early on there was an access_ok() check during user_event registration,
> but it's not enough.
> I believe user_access_begin() has to be done before the actual access,
> since it does __uaccess_begin_nospec().
> 
> Another issue is that the user space could have supplied any address as
> enabler->addr including addr in a huge page or a file backed mmaped address.
> I don't know whether above code can handle it.
> 
> I'm not a GUP expert either, but direct use of pin_user_pages_remote() looks
> suspicious too.
> I think ptrace_may_access() is missing.
> I guess it has to be a root user to do 
> echo 1 > /sys/kernel/tracing/user_events/test/enable
> 
> to trigger the kernel writes into various MM of user processes, but still.
> There are security/LSM checks in many paths that accesses user memory.
> These checks are bypassed here.
> 

I don't see uprobes using ptrace_may_access() either, it replaces a page
under the same situation. I modelled a lot of this based on what both
futex and uprobes do for this.

If I missed something, I'm happy to add it. My understanding is that
tracefs is acting as the security boundary here.

> > 	kunmap_local(kaddr);
> > 	unpin_user_pages_dirty_lock(&page, 1, true);
> > 
> > 	return 0;
> > }
> > 
> > The above maps the user space address and then sets the bit that was
> > registered.
> > 
> > That is, it changes "enabled" to true, and the if statement:
> > 
> > 	if (enabled) {
> 
> and not just 'volatile' is missing, but this is buggy in general.
> The kernel only wrote one bit into 'enabled' variable.
> The user space should be checking that one bit only.
> Since samples/user_events/example.c registering with reg.enable_bit = 31;
> it probably should be
>   if (READ_ONCE(enabled) & (1u << 31))
> 
> > 		/* Yep, trace out our data */
> > 		writev(data_fd, (const struct iovec *)io, 2);
> > 
> > 		/* Increase the count */
> > 		count++;
> > 
> > 		printf("Something was attached, wrote data\n");
> 
> Another misleading example. The writev() could have failed,
> but the message will say "success".
> And it's easy to make mistake here.
> The iovec[0] should be write_index that was received by user space
> after registration via ioctl.
> 

Yes, it's easy to make mistakes when using the ABI directly. We have a
library [1] to help with this, and libside [2] will also help here.

> If my understanding of user_events design is correct, various user
> process (all running as root) will open /sys/kernel/tracing/user_events_data
> then will do multiple ioctl(fd, DIAG_IOCSREG) for various events and
> remember write_index-es and enabled's addresses.
> Then in various places in the code they will do
> if (READ_ONCE(enabled_X) & (1u << correct_bit)) {
>     io[0].iov_base = &write_index_X;
>     io[1].iov_base = data_to_send_to_kernel;
> 
> and write_index has to match with the format of data.
> During the writev() the kernel will validate user_event_validate(),
> but this is expensive.

Validation is only done for certain types of data, and is required to
ensure the kernel doesn't do bad things when filtering the data.

> The design of user events looks fragile to me. One user process can write
> into user_event of another process by supplying wrong 'write_index' and the
> kernel won't catch it if data formats are compatible.
>

The write_index is a per-process, per-fd index, you cannot do what you state
unless a process shares it's internal FD and goes out of it's way to
achieve that.

Even then the validators WILL catch if any data gets put in that will
try to perform bad accesses, etc. Currently the only check is for
__rel_loc / __data_loc (variable sized payloads) that are of type char.
In those cases we ensure the end of the buffer is 0 to ensure string
compares are null terminated.

> All such processes have to be root to access /sys/kernel/tracing/user_events_data,
> so not a security issue, but use cases for user_events seems to be very limited.
> During LSFMMBPF, Steven, you've mentioned that you want to use user_event in chrome.
> I think you didn't imply that chrome browser will be running as root.
> You probably meant something else.
> 
> Now as far as this particular patch.
> 

Thanks for the time you took to look at the above code outside this
patch.

> s/perf_trace_buf_submit/perf_trace_run_bpf_submit/
> 
> may look trivial, but there is a lot to unpack here.
> 
> How bpf prog was attached to user event?
> What is the life time of bpf prog?
> What happens when user process crashes?
> What happens when user event is unregistered ?
> What is bpf prog context? Like, what helpers are allowed to be called?
> Does libbpf need updating?
> etc etc
> 
> No selftests were provided with this patch, so impossible to answer.
> 

I thought it being a GPL export symbol that this kind of stuff would be
documented somewhere if there are requirements to use the method. As it
stands in the patch, the data that is sent to BPF is from the buffer
returned from perf_trace_buf_alloc() after it has been copied from the
user process.

If the process crashes, that shouldn't affect the actual data. The
tracepoint remains even upon a crash. If you try to unregister the
tracepoint while BPF is attached, it is prevented, as the tracepoints
are ref-counted and cannot be unregistered if anything is using it
(user processes, ftrace, perf/bpf).

We have been using libbpf to attach and monitor user_events with this
patch and haven't hit issues for what we plan to use it for (decode
the payload, aggregate, and track what's happening per-TID/PID). The
data we care about is already in kernel memory via the perf trace
buffer.

> In general we don't want bpf to be called in various parts of the kernel
> just because bpf was used in similar parts elsewhere.
> bpf needs to provide real value for a particular kernel subsystem.
> 

For sure. I've had a lot of requests within Microsoft to wire up BPF to
user_events which prompted this patch. I've been in a few conversations
where we start talking about perf_event buffers and teams stop and ask
why it cannot go to BPF directly.

> For user events it's still not clear to me what bpf can bring to the table.
> 
> The commit log of this proposed patch says:
> "When BPF programs are attached to tracepoints created by user_events
> the BPF programs do not get run even though the attach succeeds."
> 
> It looks to me that it's a bug in attaching.
> The kernel shouldn't have allowed attaching bpf prog to user events,
> since they cannot be run.
> 
> Then the commit log says:
> "This keeps user_events consistent
> with how other kernel, modules, and probes expose tracepoint data to allow
> attachment of a BPF program."
> 
> "keep consistent" is not a reason to use bpf with user_events.
> 

Yeah, keep consistent was more about using the GPL export symbol, which
the kernel tracepoints currently utilize. I wanted to avoid any special
casing BPF needed to add for user_events, and I also expect users would
like one way to write a BPF program for tracepoints/trace_events even
if they are from user processes vs kernel.

> Beau,
> please provide a detailed explanation of your use case and how bpf helps.
> 

There are teams that have existing BPF programs that want to also pull
in data from user processes in addition to the data they already collect
from the kernel.

We are also seeing a trend of teams wanting to drop buffering approaches
and move into non-buffered analysis of problems. An example is as soon
as a fault happens in a user-process, they would like the ability to see
what that thread has done, what the kernel did a bit before the error
(or other processes that have swapped in, etc).

We also have needs to aggregate operation duration live, and as soon as
they deviate, trigger corrective actions. BPF is ideal for us to use for
aggregating data cheaply, comparing that to other kernel and user
processes, and then making a decision quickly on how to mitigate or flag
it. We are working with OpenTelemetry teams to make this work via
certain exporters in various languages (C#/C++/Rust).

> Also please explain why uprobe/USDT and bpf don't achieve your goals.
> Various user space applications have USDTs in them.
> This is an existing mechanism that was proven to be useful to many projects
> including glibc, python, mysql.
> 
> Comparing to user_events the USDTs work fine in unprivileged applications
> and have zero overhead when not turned on. USDT is a single 'nop' instruction
> while user events need if(enabled & bit) check plus iov prep and write.
> 
> When enabled the write() is probably faster than USDT trap, but all the extra
> overhead in tracepoint and user_event_validate() probably makes it the same speed.
> So why not USDT ?

User_events is being used in several production environments. These
environments are heavily locked down for security and have several
policies that prevent any modifications to executable pages (SELinux,
IPE, etc). There are also other scenarios, such as runtime integrity
checked processes, where the running code pages are periodically
compared to known hashes that can be affected by patching as well.

We also have to support languages, like C# and Java, which don't have a
stable location to apply a nop/int 3 patch, even when environments
allow patching.

We've used branch + syscall approaches in Windows for a long time and
have found them to work well in these locked down environments as well
as for JIT'd languages like C#.

In our usages of user_events, this has worked well for us, we imagine it
will work well for other folks in the same situation(s). Some folks
might not want to use it, that's fine, it's an optional KConfig with
default N.

Thanks,
-Beau

[1] https://github.com/microsoft/LinuxTracepoints
[2] https://github.com/compudj/libside


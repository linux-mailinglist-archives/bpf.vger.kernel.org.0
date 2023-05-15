Return-Path: <bpf+bounces-558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A5D703548
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 18:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFF4C1C208E7
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 16:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83303FBFD;
	Mon, 15 May 2023 16:57:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFF8FBF3
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 16:57:20 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904C55278;
	Mon, 15 May 2023 09:57:12 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-643bb9cdd6eso10846514b3a.1;
        Mon, 15 May 2023 09:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684169831; x=1686761831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KpreuUE6kTm23wGfHPgfYB6z110qkQQg2AooPPBZmJ0=;
        b=eCWbBnZNtdqR/VtPd2wqhHlnTp7Jt/qYgvmJJpVtdanKicVKkLBEo1P4t57Yu6ww5d
         RYa7LqQah34/dD8Syn+uFGO8LAYJvUZlK72wEZCEHVaEkGpiSOroboBW0ZEH714q2qFz
         VR0RaA2YkuOzVjI+mVP0/Fdi53hFXKHAWJYCbdHDgzM1sVdXH90ZOPMMBkZiV5mKe3qW
         XRCuVe5kZchJ4Bbb5b9dbJ7Dj/WAofURauywbsyWL/LnlCCFxhMmKF4dLZ1p310p3Tlp
         CvVyjthxKMOvdcSoYX6rBX9ESAr4tO0GHvmc8+uy9kCEqYVWgGHM1aWHt1+c10oXWK4b
         nlZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684169831; x=1686761831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KpreuUE6kTm23wGfHPgfYB6z110qkQQg2AooPPBZmJ0=;
        b=eMNJ1CP2v/9Iffp9PrdF5Fb8evTQypmG0sYRyJGjoL4IW8FenpRNNCcpf0CoU3Hjdg
         4C8SdTsnm5oL7NsnSQ6vZLCNlyL7iox6kHtFL48BdnP4oSMSzN4wJYE5HSIjW2/UCeDu
         aO7MW9F9uCX4ZYKmF5WaSq7kXWFI/cRJrfprdDMV4yFf/1GFvWsoVIbgl2Vxz4pfpvjY
         Ku9K2Z1L/8TbyM1G4vG9zVs2aCHsutluLR2Pm8HnaYdLugLaDNa9rQMKGeTdXRd1IeA5
         qbXkMCHl3s/vpEx0QYhyR6r440fspb9k0ITsweyokW97vpJUlaPAi9x+n7J4J8702t47
         VlwQ==
X-Gm-Message-State: AC+VfDxsTkS7nvNI9HUpT9dyvkPig8q2fVWu14wdOeXlrwCS+4K1uF/t
	hfxKm439tM4SRHy9SwfxCwg=
X-Google-Smtp-Source: ACHHUZ4OziP+DjD7hnGJ5rL6rAmf3N2jBC7uhex4jOLxSi0KRN1nQr6lvfaMT5sJy4782ssC20PtbQ==
X-Received: by 2002:a05:6a00:1951:b0:64b:256:204c with SMTP id s17-20020a056a00195100b0064b0256204cmr11381057pfk.20.1684169831136;
        Mon, 15 May 2023 09:57:11 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:2d34])
        by smtp.gmail.com with ESMTPSA id m14-20020aa7900e000000b006466d70a30esm12395959pfo.91.2023.05.15.09.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 09:57:10 -0700 (PDT)
Date: Mon, 15 May 2023 09:57:07 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Beau Belgrave <beaub@linux.microsoft.com>,
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
Message-ID: <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local>
References: <20230508163751.841-1-beaub@linux.microsoft.com>
 <CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
 <20230509130111.62d587f1@rorschach.local.home>
 <20230509163050.127d5123@rorschach.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509163050.127d5123@rorschach.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 09, 2023 at 04:30:50PM -0400, Steven Rostedt wrote:
> On Tue, 9 May 2023 13:01:11 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > > I see no practical use case for bpf progs to be connected to user events.  
> > 
> > That's not a technical reason. Obviously they have a use case.
> 
> Alexei,
> 
> It was great having a chat with you during lunch at LSFMM/BPF!

Yeah. It was great catching up!

> Looking forward to your technical response that I believe are
> legitimate requests. I'm replying here, as during our conversation, you
> had the misperception that the user events had a system call when the
> event was disabled. I told you I will point out the code that shows
> that the kernel sets the bit, and that user space does not do a system
> call when the event is disable.

Thank you for these details. Answer below...

> From the user space side, which does:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/samples/user_events/example.c#n60
> 
> 	/* Check if anyone is listening */
> 	if (enabled) {
> 		/* Yep, trace out our data */
> 		writev(data_fd, (const struct iovec *)io, 2);
> 
> 		/* Increase the count */
> 		count++;
> 
> 		printf("Something was attached, wrote data\n");
> 	}
> 
> 
> Where it told the kernel about that "enabled" variable:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/samples/user_events/example.c#n47
> 
> 	if (event_reg(data_fd, "test u32 count", &write, &enabled) == -1)
> 		return errno;
> 
> static int event_reg(int fd, const char *command, int *write, int *enabled)
> {
> 	struct user_reg reg = {0};
> 
> 	reg.size = sizeof(reg);
> 	reg.enable_bit = 31;
> 	reg.enable_size = sizeof(*enabled);
> 	reg.enable_addr = (__u64)enabled;
> 	reg.name_args = (__u64)command;
> 
> 	if (ioctl(fd, DIAG_IOCSREG, &reg) == -1)
> 		return -1;
> 
> 	*write = reg.write_index;
> 
> 	return 0;
> }
> 
> The above will add a trace event into tracefs. When someone does:
> 
>  # echo 1 > /sys/kernel/tracing/user_events/test/enable
> 
> The kernel will trigger the class->reg function, defined by:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/trace/trace_events_user.c#n1804
> 
> 	user->class.reg = user_event_reg;
> 
> Which calls: 
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/trace/trace_events_user.c#n1555
> 
> 	update_enable_bit_for(user);
> 
> Which does:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/trace/trace_events_user.c#n1465
> 
> update_enable_bit_for() { 
> 	[..]
> 	user_event_enabler_update(user);
> 
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/trace/trace_events_user.c#n451
> 
> user_event_enabler_update() {
> 	[..]
> 	user_event_enabler_write(mm, enabler, true, &attempt);

Which will do
rcu_read_lock()
and then call user_event_enabler_write() under lock...

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/trace/trace_events_user.c#n385
> 
> static int user_event_enabler_write(struct user_event_mm *mm,
> 				    struct user_event_enabler *enabler,
> 				    bool fixup_fault, int *attempt)
> {
> 	unsigned long uaddr = enabler->addr;
> 	unsigned long *ptr;
> 	struct page *page;
> 	void *kaddr;
> 	int ret;
> 
> 	lockdep_assert_held(&event_mutex);
> 	mmap_assert_locked(mm->mm);
> 
> 	*attempt += 1;
> 
> 	/* Ensure MM has tasks, cannot use after exit_mm() */
> 	if (refcount_read(&mm->tasks) == 0)
> 		return -ENOENT;
> 
> 	if (unlikely(test_bit(ENABLE_VAL_FAULTING_BIT, ENABLE_BITOPS(enabler)) ||
> 		     test_bit(ENABLE_VAL_FREEING_BIT, ENABLE_BITOPS(enabler))))
> 		return -EBUSY;
> 
> 	ret = pin_user_pages_remote(mm->mm, uaddr, 1, FOLL_WRITE | FOLL_NOFAULT,
> 				    &page, NULL, NULL);

... which will call pin_user_pages_remote() in RCU CS.
This looks buggy, since pin_user_pages_remote() may schedule.

> 	if (unlikely(ret <= 0)) {
> 		if (!fixup_fault)
> 			return -EFAULT;
> 
> 		if (!user_event_enabler_queue_fault(mm, enabler, *attempt))
> 			pr_warn("user_events: Unable to queue fault handler\n");

This part looks questionable.

The only users of fixup_user_fault() were futex and KVM.
Now user_events are calling it too from user_event_mm_fault_in() where
"bool unlocked;" is uninitialized and state of this flag is not checked
after fixup_user_fault() call.
Not an MM expert, but this is suspicious.

> 
> 		return -EFAULT;
> 	}
> 
> 	kaddr = kmap_local_page(page);
> 	ptr = kaddr + (uaddr & ~PAGE_MASK);
> 
> 	/* Update bit atomically, user tracers must be atomic as well */
> 	if (enabler->event && enabler->event->status)
> 		set_bit(enabler->values & ENABLE_VAL_BIT_MASK, ptr);
> 	else
> 		clear_bit(enabler->values & ENABLE_VAL_BIT_MASK, ptr);

Furthermore.
Here the kernel writes bits in user pages.
It's missing user_access_begin/end.
Early on there was an access_ok() check during user_event registration,
but it's not enough.
I believe user_access_begin() has to be done before the actual access,
since it does __uaccess_begin_nospec().

Another issue is that the user space could have supplied any address as
enabler->addr including addr in a huge page or a file backed mmaped address.
I don't know whether above code can handle it.

I'm not a GUP expert either, but direct use of pin_user_pages_remote() looks
suspicious too.
I think ptrace_may_access() is missing.
I guess it has to be a root user to do 
echo 1 > /sys/kernel/tracing/user_events/test/enable

to trigger the kernel writes into various MM of user processes, but still.
There are security/LSM checks in many paths that accesses user memory.
These checks are bypassed here.

> 	kunmap_local(kaddr);
> 	unpin_user_pages_dirty_lock(&page, 1, true);
> 
> 	return 0;
> }
> 
> The above maps the user space address and then sets the bit that was
> registered.
> 
> That is, it changes "enabled" to true, and the if statement:
> 
> 	if (enabled) {

and not just 'volatile' is missing, but this is buggy in general.
The kernel only wrote one bit into 'enabled' variable.
The user space should be checking that one bit only.
Since samples/user_events/example.c registering with reg.enable_bit = 31;
it probably should be
  if (READ_ONCE(enabled) & (1u << 31))

> 		/* Yep, trace out our data */
> 		writev(data_fd, (const struct iovec *)io, 2);
> 
> 		/* Increase the count */
> 		count++;
> 
> 		printf("Something was attached, wrote data\n");

Another misleading example. The writev() could have failed,
but the message will say "success".
And it's easy to make mistake here.
The iovec[0] should be write_index that was received by user space
after registration via ioctl.

If my understanding of user_events design is correct, various user
process (all running as root) will open /sys/kernel/tracing/user_events_data
then will do multiple ioctl(fd, DIAG_IOCSREG) for various events and
remember write_index-es and enabled's addresses.
Then in various places in the code they will do
if (READ_ONCE(enabled_X) & (1u << correct_bit)) {
    io[0].iov_base = &write_index_X;
    io[1].iov_base = data_to_send_to_kernel;

and write_index has to match with the format of data.
During the writev() the kernel will validate user_event_validate(),
but this is expensive.
The design of user events looks fragile to me. One user process can write
into user_event of another process by supplying wrong 'write_index' and the
kernel won't catch it if data formats are compatible.

All such processes have to be root to access /sys/kernel/tracing/user_events_data,
so not a security issue, but use cases for user_events seems to be very limited.
During LSFMMBPF, Steven, you've mentioned that you want to use user_event in chrome.
I think you didn't imply that chrome browser will be running as root.
You probably meant something else.

Now as far as this particular patch.

s/perf_trace_buf_submit/perf_trace_run_bpf_submit/

may look trivial, but there is a lot to unpack here.

How bpf prog was attached to user event?
What is the life time of bpf prog?
What happens when user process crashes?
What happens when user event is unregistered ?
What is bpf prog context? Like, what helpers are allowed to be called?
Does libbpf need updating?
etc etc

No selftests were provided with this patch, so impossible to answer.

In general we don't want bpf to be called in various parts of the kernel
just because bpf was used in similar parts elsewhere.
bpf needs to provide real value for a particular kernel subsystem.

For user events it's still not clear to me what bpf can bring to the table.

The commit log of this proposed patch says:
"When BPF programs are attached to tracepoints created by user_events
the BPF programs do not get run even though the attach succeeds."

It looks to me that it's a bug in attaching.
The kernel shouldn't have allowed attaching bpf prog to user events,
since they cannot be run.

Then the commit log says:
"This keeps user_events consistent
with how other kernel, modules, and probes expose tracepoint data to allow
attachment of a BPF program."

"keep consistent" is not a reason to use bpf with user_events.

Beau,
please provide a detailed explanation of your use case and how bpf helps.

Also please explain why uprobe/USDT and bpf don't achieve your goals.
Various user space applications have USDTs in them.
This is an existing mechanism that was proven to be useful to many projects
including glibc, python, mysql.

Comparing to user_events the USDTs work fine in unprivileged applications
and have zero overhead when not turned on. USDT is a single 'nop' instruction
while user events need if(enabled & bit) check plus iov prep and write.

When enabled the write() is probably faster than USDT trap, but all the extra
overhead in tracepoint and user_event_validate() probably makes it the same speed.
So why not USDT ?


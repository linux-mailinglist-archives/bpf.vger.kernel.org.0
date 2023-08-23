Return-Path: <bpf+bounces-8354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F367859AB
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 15:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5743C2812F4
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 13:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3FAC134;
	Wed, 23 Aug 2023 13:45:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B9CBE7B
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 13:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FB2C433C7;
	Wed, 23 Aug 2023 13:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692798316;
	bh=ci9fhFEBfc2LOR3YE6dug7Bi9rUdN4KE74Fag1xJbKA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=URyvVvLx8IMphIGwz3hAGSaGP/qSBBB8To95ZF9PJLlTifOrRf5SZ3zWxkyNEB1DN
	 ed3wAa8GEjwD+MSV3cWTtJCG85PPDBTaJqvuEEyv1AbGq1tdG0fCQS0A8pJg9YJlR2
	 gSDDIdlcJYNdq7DZTtOAKvOcJjsG5AzJvr4RPYdj7bZKSfx1K1ziNq8QgpBRtoi0iP
	 i7gR21lQuYr6vPkla/K2qMS1CyRSMqefumvLUyE4WloObQpxk9bytGUl+oT/2Y9TDe
	 Qv+tgIYc1sH8nbK6AWv1FORATwCNy38NT5yQvmWSm3uFkvsOCgdw7Bniu/iNTyr4Ed
	 1fxRllDtA1JDw==
Date: Wed, 23 Aug 2023 22:45:12 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Francis Laniel <flaniel@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, Song Liu <songliubraving@fb.com>,
 bpf@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] tracing/kprobe: Add multi-probe support for
 'perf_kprobe' PMU
Message-Id: <20230823224512.660dac2ff384aea739f61098@kernel.org>
In-Reply-To: <5964493.lOV4Wx5bFT@pwmachine>
References: <20230816163517.112518-1-flaniel@linux.microsoft.com>
	<2237127.iZASKD2KPV@pwmachine>
	<20230823093614.fd704a98387d0ba1d23a29fb@kernel.org>
	<5964493.lOV4Wx5bFT@pwmachine>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 23 Aug 2023 11:54:48 +0200
Francis Laniel <flaniel@linux.microsoft.com> wrote:

> Hi.
> 
> Le mercredi 23 août 2023, 02:36:14 CEST Masami Hiramatsu a écrit :
> > Hi,
> > 
> > On Mon, 21 Aug 2023 14:55:14 +0200
> > 
> > Francis Laniel <flaniel@linux.microsoft.com> wrote:
> > > > Could you tell me how do you use this feature, for what perpose?
> > > 
> > > Sure (I think I detailed this in the cover letter but I only sent it to
> > > the
> > > "main" mailing list and not the tracing one, sorry for this
> > > inconvenience)!
> > > 
> > > Basically, I was adding NTFS tracing to an existing tool which monitors
> > > slow I/Os using BPF [1].
> > > To test the tool, I compiled a kernel with both NTFS module built-in and
> > > figured out the write operations when done on ntfs3 were missing from the
> > > output of the tool.
> > > The problem comes from the library I use in the tool which does not handle
> > > well when it exists different symbols with the same name.
> > > Contrary to perf, which only handles kprobes through sysfs, the library
> > > handles it in both way (sysfs and PMU) with a preference for PMU when
> > > available [2].
> > > 
> > > After some discussion, I thought there could be a way to handle this
> > > automatically in the kernel when using PMU kprobes, hence this patch.
> > > I totally understand the case I described above is really a corner one,
> > > but I thought this feature could be useful for other people.
> > > In the case of the library itself, we could indeed find the address in
> > > /proc/ kallsyms but it would mean having CAP_SYS_ADMIN which is not
> > > forcefully something we want to enforce.
> > > Also, if we need to read /boot/vmlinuz or /boot/System.map we also need to
> > > be root as these files often belong to root and cannot be read by others.
> > > So, this patch solves the above problem while not needing specific
> > > capabilities as the kernel will solve it for us.
> > 
> > Thanks for the explanation. I got the background, and still have some
> > questions.
> > 
> > - Is the analysis tool really necessary to be used by users other than
> >   CAP_SYS_ADMIN? Even if it is useful, I still doubt CAP_PERFMON is safer
> >   than CAP_SYS_ADMIN, because BPF program can access any kernel register.
> 
> For the tool itself, this is indeed not a problem as we rely on CAP_SYS_ADMIN.
> But this one for the library, as they do not want to enforce CAP_SYS_ADMIN to 
> use the library.

Hmm, however, that means the library also does not consider (or support) the
same-name symbols, because there is no way to identify the address without
accessing vmlinux. Since the address is still not clear whether one of
the same name symbols is what the user wants to trace, it needs to access
the vmlinux including debuginfo. It also need to use tools like 'eu-addr2line'
or 'readelf' etc. to identify the actual symbol and address.
The vmlinux is usually not installed to the system, because it is for the
kernel development, it may not need to access CAP_SYS_ADMIN.

> 
> > - My concern about this solution (enabling kprobe PMU on all symbols which
> >   have the same name) makes it hard to run the same BPF program on it.
> >   This is because symbols with the same name do not necessarily have the
> >   same arguments (theoretically). Also, the BPF will trace unwanted symbols
> >   at unwanted timing.
> 
> Good point for the same name but different arguments!
> I was too focused on my case (ntfs_file_write_iter()) and forgot about this.

Yeah, and the same reason, I think I should check the symbol is unique too
on kprobe event. I also found that fprobe event has similar issue.

> 
> > - Can you expand that library to handle the same name symbols differently?
> >   I think this should be done in the user space, or in the kallsyms like
> >   storing symbols with source line information.
> 
> I think we can find a way to handle this in user space by potentially 
> abstracting the several PMU probe under one.
> Or we can simply explode if a name correspond to several symbols and ask the 
> user to use addr + offset to precise the symbol in this case.

Yeah, I think that is a better way to handle this situation.

> 
> > I understand this demand, but solving that with probing *all* symbols seems
> > like a brute force solution and may cause another problem later.
> > 
> > But this is a good discussion item. Last month Alessandro sent a script
> > which makes such symbols unique. Current problem is that the numbering is
> > not enough to identify which one is from which source code.
> 
> Definitely, I wrote this specifically to create a discussion and gather some 
> comments, hence the RFC tag.
> 
> > https://lore.kernel.org/all/20230714150326.1152359-1-alessandro.carminati@gm
> > ail.com/
> 
> I will definitely take a look at this contribution! Thank you for sharing the 
> link!

You're welcome!

> 
> > > > If you just need to trace/profile a specific function which has the same
> > > > name symbols, you might be better to use `perf probe` +
> > > > `/sys/kernel/tracing` or `perf record -e EVENT`.
> > > > 
> > > > Or if you need to run it with CAP_PERFMON, without CAP_SYS_ADMIN,
> > > > we need to change a userspace tool to find the correct address and
> > > > pass it to the perf_event_open().
> > > > 
> > > > > > > Added new events:
> > > > > > >   probe:ntfs_file_write_iter (on ntfs_file_write_iter)
> > > > > > >   probe:ntfs_file_write_iter (on ntfs_file_write_iter)
> > > > > > > 
> > > > > > > You can now use it in all perf tools, such as:
> > > > > > >         perf record -e probe:ntfs_file_write_iter -aR sleep 1
> > > > > > > 
> > > > > > > root@vm-amd64:~# cat /sys/kernel/tracing/kprobe_events
> > > > > > > p:probe/ntfs_file_write_iter _text+5088544
> > > > > > > p:probe/ntfs_file_write_iter _text+5278560
> > > > > > > 
> > > > > > > > Thought?
> > > > > > > 
> > > > > > > This contribution is basically here to sort of mimic what perf
> > > > > > > does
> > > > > > > but
> > > > > > > with PMU kprobes, as this is not possible to write in a sysfs file
> > > > > > > with
> > > > > > > this type of probe.
> > > > > > 
> > > > > > OK, I see it is for BPF only. Maybe BPF program can filter correct
> > > > > > one
> > > > > > to access the argument etc.
> > > > > 
> > > > > I am not sure I understand, can you please precise?
> > > > > The eBPF program will be run when the kprobe will be triggered, so if
> > > > > the
> > > > > kprobe is armed for the function (e.g. old ntfs_file_write_iter()),
> > > > > the
> > > > > eBPF program will never be called.
> > > > 
> > > > As I said above, it is userspace BPF loader issue, because it has to
> > > > specify the correct address via unique symbol + offset, instead of
> > > > attaching all of them. I think that will be more side-effects.
> > > > 
> > > > But anyway, thanks for pointing this issue. I should fix kprobe event to
> > > > reject the symbols which is not unique. That should be pointed by other
> > > > unique symbols.
> > > 
> > > You are welcome and I thank you for the discussion.
> > > Can you please precise more what you think about "reject the symbols which
> > > is not unique"?
> > 
> > > Basically something like this:
> > Yes, that's what I said.
> 
> OK, I will write something and send it as an RFC before end of the week then.

Thank you!

> 
> > > struct trace_event_call *
> > > create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
> > > 
> > > 			  bool is_return)
> > > 
> > > {
> > > 
> > > 	...
> > > 	if (!addr && func) {
> > 
> > if (func) {  /* because anyway if user specify "func" we have to solve
> >  the symbol address */
> > 
> > > 		array.addrs = NULL;
> > > 		array.size = 0;
> > > 		ret = kallsyms_on_each_match_symbol(add_addr, func, &array);
> > > 		if (ret)
> > > 		
> > > 			goto error_free;
> > > 		
> > > 		if (array.size != 1) {
> > > 		
> > > 			/*
> > > 			
> > > 			 * Function name corresponding to several symbols must
> > > 			 * be passed by address only.
> > > 			 */
> > > 			
> > > 			return -EINVAL;
> > 
> > This case may return a unique error code so that the caller can notice
> > the problem.
> 
> Is it OK to add a dedicated error code for such a case?
> 
> > Thank you,
> > 
> > > 		}
> > > 	
> > > 	}
> > > 	
> > > 	
> > > 	
> > > 	...
> > > 
> > > }
> > > ?
> > > If my understanding is correct, I think I can write a patch to achieve
> > > this.
> > > 
> > > 
> > > 
> > > Best regards.
> > > ---
> > > [1]: https://github.com/inspektor-gadget/inspektor-gadget/pull/1879
> > > [2]: https://github.com/cilium/ebpf/blob/
> > > 270c859894bd38cdd0c7783317b16343409e4df8/link/kprobe.go#L165-L191
> 
> Best regards.
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


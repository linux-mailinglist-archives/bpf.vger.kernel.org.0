Return-Path: <bpf+bounces-8331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD3D784DDD
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 02:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50936281221
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 00:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1113610F2;
	Wed, 23 Aug 2023 00:36:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2DA7E2
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 00:36:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD2EC433C8;
	Wed, 23 Aug 2023 00:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692750979;
	bh=xNTKQwORwsCD8O9TsOJK6CO4peKiHi/Jma3poQjjDDY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iBLisRyxZjunYu7v+KK7zXWuQ+BiRRMSZ3jRQEN5Uh4DplCxl6r3VWUeH4eIvYKLG
	 gM7SAXFQ4mG5QbhwGHlukcKuM6gw2BYbFcoQ4+beguMOe38bAmwBDELZt/JInsr8tf
	 pK7BoTENAIyYgzAStm1aYsELWvPr/dTNYM+pH1AT8VeLWz0BCCShly6bcHJDAtvgxH
	 1eWFHAifnX5a1rCsMDvec69goQmuX0F3Gokvo0pKtC23Rbs/iy9H2SA0uzriw6V8v8
	 yTMi+l2uKpNAXlqr5eS+4p94aMxSoDhuSuTK5kV6h+kfG7zQb1jls9ZM9WZ7ZUiEUU
	 G8vbUTqnG3C9Q==
Date: Wed, 23 Aug 2023 09:36:14 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Francis Laniel <flaniel@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, Song Liu <songliubraving@fb.com>,
 bpf@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] tracing/kprobe: Add multi-probe support for
 'perf_kprobe' PMU
Message-Id: <20230823093614.fd704a98387d0ba1d23a29fb@kernel.org>
In-Reply-To: <2237127.iZASKD2KPV@pwmachine>
References: <20230816163517.112518-1-flaniel@linux.microsoft.com>
	<5702263.DvuYhMxLoT@pwmachine>
	<20230819101105.b0c104ae4494a7d1f2eea742@kernel.org>
	<2237127.iZASKD2KPV@pwmachine>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On Mon, 21 Aug 2023 14:55:14 +0200
Francis Laniel <flaniel@linux.microsoft.com> wrote:

> > Could you tell me how do you use this feature, for what perpose?
> 
> Sure (I think I detailed this in the cover letter but I only sent it to the 
> "main" mailing list and not the tracing one, sorry for this inconvenience)!
> 
> Basically, I was adding NTFS tracing to an existing tool which monitors slow 
> I/Os using BPF [1].
> To test the tool, I compiled a kernel with both NTFS module built-in and 
> figured out the write operations when done on ntfs3 were missing from the 
> output of the tool.
> The problem comes from the library I use in the tool which does not handle 
> well when it exists different symbols with the same name.
> Contrary to perf, which only handles kprobes through sysfs, the library 
> handles it in both way (sysfs and PMU) with a preference for PMU when 
> available [2].
> 
> After some discussion, I thought there could be a way to handle this 
> automatically in the kernel when using PMU kprobes, hence this patch.
> I totally understand the case I described above is really a corner one, but I 
> thought this feature could be useful for other people.
> In the case of the library itself, we could indeed find the address in /proc/
> kallsyms but it would mean having CAP_SYS_ADMIN which is not forcefully 
> something we want to enforce.
> Also, if we need to read /boot/vmlinuz or /boot/System.map we also need to be 
> root as these files often belong to root and cannot be read by others.
> So, this patch solves the above problem while not needing specific capabilities 
> as the kernel will solve it for us.

Thanks for the explanation. I got the background, and still have some questions.

- Is the analysis tool really necessary to be used by users other than
  CAP_SYS_ADMIN? Even if it is useful, I still doubt CAP_PERFMON is safer
  than CAP_SYS_ADMIN, because BPF program can access any kernel register.

- My concern about this solution (enabling kprobe PMU on all symbols which
  have the same name) makes it hard to run the same BPF program on it.
  This is because symbols with the same name do not necessarily have the
  same arguments (theoretically). Also, the BPF will trace unwanted symbols
  at unwanted timing.

- Can you expand that library to handle the same name symbols differently?
  I think this should be done in the user space, or in the kallsyms like
  storing symbols with source line information.

I understand this demand, but solving that with probing *all* symbols seems
like a brute force solution and may cause another problem later.

But this is a good discussion item. Last month Alessandro sent a script which
makes such symbols unique. Current problem is that the numbering is not enough
to identify which one is from which source code.

https://lore.kernel.org/all/20230714150326.1152359-1-alessandro.carminati@gmail.com/ 

> 
> > If you just need to trace/profile a specific function which has the same
> > name symbols, you might be better to use `perf probe` +
> > `/sys/kernel/tracing` or `perf record -e EVENT`.
> > 
> > Or if you need to run it with CAP_PERFMON, without CAP_SYS_ADMIN,
> > we need to change a userspace tool to find the correct address and
> > pass it to the perf_event_open().
> > 
> > > > > Added new events:
> > > > >   probe:ntfs_file_write_iter (on ntfs_file_write_iter)
> > > > >   probe:ntfs_file_write_iter (on ntfs_file_write_iter)
> > > > > 
> > > > > You can now use it in all perf tools, such as:
> > > > >         perf record -e probe:ntfs_file_write_iter -aR sleep 1
> > > > > 
> > > > > root@vm-amd64:~# cat /sys/kernel/tracing/kprobe_events
> > > > > p:probe/ntfs_file_write_iter _text+5088544
> > > > > p:probe/ntfs_file_write_iter _text+5278560
> > > > > 
> > > > > > Thought?
> > > > > 
> > > > > This contribution is basically here to sort of mimic what perf does
> > > > > but
> > > > > with PMU kprobes, as this is not possible to write in a sysfs file
> > > > > with
> > > > > this type of probe.
> > > > 
> > > > OK, I see it is for BPF only. Maybe BPF program can filter correct one
> > > > to access the argument etc.
> > > 
> > > I am not sure I understand, can you please precise?
> > > The eBPF program will be run when the kprobe will be triggered, so if the
> > > kprobe is armed for the function (e.g. old ntfs_file_write_iter()), the
> > > eBPF program will never be called.
> > 
> > As I said above, it is userspace BPF loader issue, because it has to specify
> > the correct address via unique symbol + offset, instead of attaching all of
> > them. I think that will be more side-effects.
> > 
> > But anyway, thanks for pointing this issue. I should fix kprobe event to
> > reject the symbols which is not unique. That should be pointed by other
> > unique symbols.
> 
> You are welcome and I thank you for the discussion.
> Can you please precise more what you think about "reject the symbols which is 
> not unique"?
> Basically something like this:

Yes, that's what I said.

> struct trace_event_call *
> create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
> 			  bool is_return)
> {
> 	...
> 	if (!addr && func) {

if (func) {  /* because anyway if user specify "func" we have to solve
 the symbol address */

> 		array.addrs = NULL;
> 		array.size = 0;
> 		ret = kallsyms_on_each_match_symbol(add_addr, func, &array);
> 		if (ret)
> 			goto error_free;
> 
> 		if (array.size != 1) {
> 			/* 
> 			 * Function name corresponding to several symbols must
> 			 * be passed by address only.
> 			 */
> 			return -EINVAL;

This case may return a unique error code so that the caller can notice
the problem.

Thank you,

> 		}
> 	}



> 	...
> }
> ?
> If my understanding is correct, I think I can write a patch to achieve this.
> 

> 
> Best regards.
> ---
> [1]: https://github.com/inspektor-gadget/inspektor-gadget/pull/1879
> [2]: https://github.com/cilium/ebpf/blob/
> 270c859894bd38cdd0c7783317b16343409e4df8/link/kprobe.go#L165-L191
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


Return-Path: <bpf+bounces-8108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A3F781657
	for <lists+bpf@lfdr.de>; Sat, 19 Aug 2023 03:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2E1B1C20B09
	for <lists+bpf@lfdr.de>; Sat, 19 Aug 2023 01:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D0E652;
	Sat, 19 Aug 2023 01:11:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039B0634
	for <bpf@vger.kernel.org>; Sat, 19 Aug 2023 01:11:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2590CC433C7;
	Sat, 19 Aug 2023 01:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692407469;
	bh=ND/elSFP0LDa9LHfEGoxNyf8ETj0MRNmMw4MPU1D6oQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L224TTMEcJ2opg1gQ/2NGhtwmeq+boKg4CyifrE07fEYBBF8ZV92xoIiJ4zTNRQis
	 OMiowtKJPoBZBPHmb01f9e9Na8JZjpjlTfYb++A6A3hfC8fxnKHXUyjI0NlV72OL3E
	 aMyNXlPcSbwhRHQjAzen8fqcF7kgIAUpxhl3kW40V0WqaKdHrC3s/JGWKj5/qSA4AF
	 Nd+CItxc/mjXfuGrfqbOVeJRA0FTmHLOdYmQPUWn99tWvgs7/I8JcBpAa2jA5Nqcyy
	 xrz/WUUuN9MiI3Ta2eiH7aQroPjHyR2WfC5zmYifh2TAqgQ++UB471FZcuJrsj3WTb
	 qxGWfgoHq5fAg==
Date: Sat, 19 Aug 2023 10:11:05 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Francis Laniel <flaniel@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, Song Liu <songliubraving@fb.com>,
 bpf@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] tracing/kprobe: Add multi-probe support for
 'perf_kprobe' PMU
Message-Id: <20230819101105.b0c104ae4494a7d1f2eea742@kernel.org>
In-Reply-To: <5702263.DvuYhMxLoT@pwmachine>
References: <20230816163517.112518-1-flaniel@linux.microsoft.com>
	<2154216.irdbgypaU6@pwmachine>
	<20230818220537.75ce8210c6a4c80a5a8d16f8@kernel.org>
	<5702263.DvuYhMxLoT@pwmachine>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Francis,
(Cc: Song Liu and BPF ML)

On Fri, 18 Aug 2023 20:12:11 +0200
Francis Laniel <flaniel@linux.microsoft.com> wrote:

> Hi.
> 
> Le vendredi 18 août 2023, 15:05:37 CEST Masami Hiramatsu a écrit :
> > On Thu, 17 Aug 2023 13:06:20 +0200
> > 
> > Francis Laniel <flaniel@linux.microsoft.com> wrote:
> > > Hi.
> > > 
> > > Le jeudi 17 août 2023, 09:50:57 CEST Masami Hiramatsu a écrit :
> > > > Hi,
> > > > 
> > > > On Wed, 16 Aug 2023 18:35:17 +0200
> > > > 
> > > > Francis Laniel <flaniel@linux.microsoft.com> wrote:
> > > > > When using sysfs, it is possible to create kprobe for several kernel
> > > > > functions sharing the same name, but of course with different
> > > > > addresses,
> > > > > by writing their addresses in kprobe_events file.
> > > > > 
> > > > > When using PMU, if only the symbol name is given, the event will be
> > > > > created for the first address which matches the symbol, as returned by
> > > > > kallsyms_lookup_name().
> > > > 
> > > > Do you mean probing the same name symbols? Yes, it is intended behavior,
> > > > since it is not always true that the same name function has the same
> > > > prototype (it is mostly true but is not ensured), it is better to leave
> > > > user to decide which one is what you want to probe.
> > > 
> > > This is what I meant.
> > > I also share your mind regarding leaving the users deciding which one they
> > > want to probe but in my case (which I agree is a bit a corner one) it
> > > leaded me to misunderstanding as the PMU kprobe was only added to the
> > > first ntfs_file_write_iter() which is not the one for ntfs3.
> > 
> > Hmm, OK. I think in that case (multiple same-name symbols exist) the default
> > behavior is rejecting with error message. And optionally, it will probe all
> > or them like your patch.
> 
> I am not sure to understand.
> Can you please precise the default behavior of which software component?

I meant that the behavior of the kprobe-events via /sys/kernel/tracing.
But your patch is for the other interface for perf as kprobe-event PMU.
In that case, I think we should CC to other users like BPF because
this may change the expected behavior.

> 
> > > > Have you used 'perf probe' tool? It tries to find the appropriate
> > > > function
> > > > by line number and creates the probe by 'text+OFFSET' style, not by
> > > > symbol.
> > > > I think this is the correct way to do that, because user will not know
> > > > which 'address' of the symbol is what the user want.
> > > 
> > > 'perf probe' perfectly does the trick, as it would find all the kernel
> > > addresses which correspond to the symbol name and create as many probes as
> > > corresponding symbols [1]:
> > > root@vm-amd64:~# perf probe --add ntfs_file_write_iter
> > 
> > If you can specify the (last part of) file path as below,
> > 
> > perf probe --add ntfs_file_write_iter@ntfs3/file.c
> > 
> > Then it will choose correct one. :)
> 
> Nice! TIL thank you! perf is really powerful!

Yeah, but note that the perf-probe is a tool to setup a 'visible' tracepoint
event. After making a new tracepoint event, the perf tool can use such
"[Tracepoint event]" instead of PMU.

Unfortunately, kprobe-event 'PMU' version doesn't support this
because it has been introduced for BPF. See the original series;

https://lore.kernel.org/lkml/20171206224518.3598254-1-songliubraving@fb.com/

So, the "local_kprobe_event" is making a kprobe PMU which is a event for
local session, that is designed for using such event from BPF (if I
understand correctly). Of course BPF tool can setup its local
event with a unique symbol + offset (not just a symbol) in a BPF tool with
perf-probe but it doesn't.

Could you tell me how do you use this feature, for what perpose?

If you just need to trace/profile a specific function which has the same
name symbols, you might be better to use `perf probe` + `/sys/kernel/tracing`
or `perf record -e EVENT`.

Or if you need to run it with CAP_PERFMON, without CAP_SYS_ADMIN,
we need to change a userspace tool to find the correct address and
pass it to the perf_event_open().

> 
> > > Added new events:
> > >   probe:ntfs_file_write_iter (on ntfs_file_write_iter)
> > >   probe:ntfs_file_write_iter (on ntfs_file_write_iter)
> > > 
> > > You can now use it in all perf tools, such as:
> > >         perf record -e probe:ntfs_file_write_iter -aR sleep 1
> > > 
> > > root@vm-amd64:~# cat /sys/kernel/tracing/kprobe_events
> > > p:probe/ntfs_file_write_iter _text+5088544
> > > p:probe/ntfs_file_write_iter _text+5278560
> > > 
> > > > Thought?
> > > 
> > > This contribution is basically here to sort of mimic what perf does but
> > > with PMU kprobes, as this is not possible to write in a sysfs file with
> > > this type of probe.
> > 
> > OK, I see it is for BPF only. Maybe BPF program can filter correct one
> > to access the argument etc.
> 
> I am not sure I understand, can you please precise?
> The eBPF program will be run when the kprobe will be triggered, so if the 
> kprobe is armed for the function (e.g. old ntfs_file_write_iter()), the eBPF 
> program will never be called.

As I said above, it is userspace BPF loader issue, because it has to specify
the correct address via unique symbol + offset, instead of attaching all of them.
I think that will be more side-effects.

But anyway, thanks for pointing this issue. I should fix kprobe event to reject
the symbols which is not unique. That should be pointed by other unique symbols. 

Thank you,

> 
> > 
> > Thank you,
> > 
> > > > Thank you,
> > > > 
> > > > > The idea here is to search all kernel functions which match this
> > > > > symbol
> > > > > and
> > > > > create a trace_kprobe for each of them.
> > > > > All these trace_kprobes are linked together by sharing the same
> > > > > trace_probe.
> > > > > 
> > > > > Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
> > > > > ---
> > > > > 
> > > > >  kernel/trace/trace_kprobe.c | 86
> > > > >  +++++++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 86 insertions(+)
> > > > > 
> > > > > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > > > > index 1b3fa7b854aa..08580f1466c7 100644
> > > > > --- a/kernel/trace/trace_kprobe.c
> > > > > +++ b/kernel/trace/trace_kprobe.c
> > > > > @@ -1682,13 +1682,42 @@ static int unregister_kprobe_event(struct
> > > > > trace_kprobe *tk)>
> > > > > 
> > > > >  }
> > > > >  
> > > > >  #ifdef CONFIG_PERF_EVENTS
> > > > > 
> > > > > +
> > > > > +struct address_array {
> > > > > +	unsigned long *addrs;
> > > > > +	size_t size;
> > > > > +};
> > > > > +
> > > > > +static int add_addr(void *data, unsigned long addr)
> > > > > +{
> > > > > +	struct address_array *array = data;
> > > > > +	unsigned long *p;
> > > > > +
> > > > > +	array->size++;
> > > > > +	p = krealloc(array->addrs,
> > > > > +				sizeof(*array->addrs) * array->size,
> > > > > +				GFP_KERNEL);
> > > > > +	if (!p) {
> > > > > +		kfree(array->addrs);
> > > > > +		return -ENOMEM;
> > > > > +	}
> > > > > +
> > > > > +	array->addrs = p;
> > > > > +	array->addrs[array->size - 1] = addr;
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > 
> > > > >  /* create a trace_kprobe, but don't add it to global lists */
> > > > >  struct trace_event_call *
> > > > >  create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
> > > > >  
> > > > >  			  bool is_return)
> > > > >  
> > > > >  {
> > > > >  
> > > > >  	enum probe_print_type ptype;
> > > > > 
> > > > > +	struct address_array array;
> > > > > 
> > > > >  	struct trace_kprobe *tk;
> > > > > 
> > > > > +	unsigned long func_addr;
> > > > > +	unsigned int i;
> > > > > 
> > > > >  	int ret;
> > > > >  	char *event;
> > > > > 
> > > > > @@ -1722,7 +1751,64 @@ create_local_trace_kprobe(char *func, void
> > > > > *addr,
> > > > > unsigned long offs,>
> > > > > 
> > > > >  	if (ret < 0)
> > > > >  	
> > > > >  		goto error;
> > > > > 
> > > > > +	array.addrs = NULL;
> > > > > +	array.size = 0;
> > > > > +	ret = kallsyms_on_each_match_symbol(add_addr, func, &array);
> > > > > +	if (ret)
> > > > > +		goto error_free;
> > > > > +
> > > > > +	if (array.size == 1)
> > > > > +		goto end;
> > > > > +
> > > > > +	/*
> > > > > +	 * Below loop allocates a trace_kprobe for each function with the
> > > > > same
> > > > > +	 * name in kernel source code.
> > > > > +	 * All this differente trace_kprobes will be linked together through
> > > > > +	 * append_trace_kprobe().
> > > > > +	 * NOTE append_trace_kprobe() is called in register_trace_kprobe()
> > > 
> > > which
> > > 
> > > > > +	 * is called when a kprobe is added through sysfs.
> > > > > +	 */
> > > > > +	func_addr = kallsyms_lookup_name(func);
> > > > > +	for (i = 0; i < array.size; i++) {
> > > > > +		struct trace_kprobe *tk_same_name;
> > > > > +		unsigned long address;
> > > > > +
> > > > > +		address = array.addrs[i];
> > > > > +		/* Skip the function address as we already registered it. */
> > > > > +		if (address == func_addr)
> > > > > +			continue;
> > > > > +
> > > > > +		/*
> > > > > +		 * alloc_trace_kprobe() first considers symbol name, so we set
> > > > > +		 * this to NULL to allocate this kprobe on the given address.
> > > > > +		 */
> > > > > +		tk_same_name = alloc_trace_kprobe(KPROBE_EVENT_SYSTEM, event,
> > > > > +						  (void *)address, NULL, offs,
> > > > > +						  0 /* maxactive */,
> > > > > +						  0 /* nargs */, is_return);
> > > > > +
> > > > > +		if (IS_ERR(tk_same_name)) {
> > > > > +			ret = -ENOMEM;
> > > > > +			goto error_free;
> > > > > +		}
> > > > > +
> > > > > +		init_trace_event_call(tk_same_name);
> > > > > +
> > > > > +		if (traceprobe_set_print_fmt(&tk_same_name->tp, ptype) < 0) {
> > > > > +			ret = -ENOMEM;
> > > > > +			goto error_free;
> > > > > +		}
> > > > > +
> > > > > +		ret = append_trace_kprobe(tk_same_name, tk);
> > > > > +		if (ret)
> > > > > +			goto error_free;
> > > > > +	}
> > > > > +
> > > > > +end:
> > > > > +	kfree(array.addrs);
> > > > > 
> > > > >  	return trace_probe_event_call(&tk->tp);
> > > > > 
> > > > > +error_free:
> > > > > +	kfree(array.addrs);
> > > > > 
> > > > >  error:
> > > > >  	free_trace_kprobe(tk);
> > > > >  	return ERR_PTR(ret);
> > > 
> > > ---
> > > [1]: https://github.com/torvalds/linux/blob/
> > > 57012c57536f8814dec92e74197ee96c3498d24e/tools/perf/util/probe-event.c#L29
> > > 89- L2993
> 
> 
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


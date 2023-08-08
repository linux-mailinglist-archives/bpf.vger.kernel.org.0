Return-Path: <bpf+bounces-7224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F39A7773ABD
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 16:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A47A728182B
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 14:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0829312B62;
	Tue,  8 Aug 2023 14:32:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903F537C
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 14:32:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB906C433C7;
	Tue,  8 Aug 2023 14:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691505149;
	bh=8oSLRbPi1UGHjtxwyw5/uxm2DNIMM6w7TI7hzgcelSs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E2Vayy9tMZSt/kuGuKpUbXWbi/uQ5AAx94B8x+EW8/l93GmhPF2+DGjCjG8GyP9Dr
	 CCYf4bhJUxJBqz5a6YQtjj4RXvSGA4eRZIlhQgxIjsRdVws9KpVwfC10D0/1lzdFHv
	 u6Yv2GeBk+2+K61vDqiZPQ4+Y1C36EKhgIZlUBmdchmNFL6MGal/IOXXVbi4lTIX3j
	 ijDfhJIGVj7aQ+ISeHwyFgbkzTIBf0kHD3cBVXB5UZ0JP9i2vvWhetVgZeA2rXgOVV
	 pC/a8k1lHHy3fX2cCWgd1KE6aH9YYKw/LDdawIVQArSAQV0g3avY8qi2I2qlc9P58i
	 blQz6ReO5xvdQ==
Date: Tue, 8 Aug 2023 23:32:23 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Florent Revest <revest@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>, Mark
 Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 3/9] bpf/btf: Add a function to search a member of a
 struct/union
Message-Id: <20230808233223.bd2b356fb410745276ae2350@kernel.org>
In-Reply-To: <ZNFYnbqlyOjo5dkH@krava>
References: <CAADnVQ+C64_C1w1kqScZ6C5tr6_juaWFaQdAp9Mt3uzaQp2KOw@mail.gmail.com>
	<20230801085724.9bb07d2c82e5b6c6a6606848@kernel.org>
	<CAADnVQLaFpd2OhqP7W3xWB1b9P2GAKgrVQU1FU2yeNYKbCkT=Q@mail.gmail.com>
	<20230802000228.158f1bd605e497351611739e@kernel.org>
	<20230801112036.0d4ee60d@gandalf.local.home>
	<20230801113240.4e625020@gandalf.local.home>
	<CAADnVQ+N7b8_0UhndjwW9-5Vx2wUVvojujFLOCFr648DUv-Y2Q@mail.gmail.com>
	<20230801190920.7a1abfd5@gandalf.local.home>
	<CABRcYmJjtVq-330ktqTAUiNO1=yG_aHd0xz=c550O5C7QP++UA@mail.gmail.com>
	<20230804004206.9fdfae0b9270b9acca2c096f@kernel.org>
	<ZNFYnbqlyOjo5dkH@krava>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Aug 2023 22:48:29 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Fri, Aug 04, 2023 at 12:42:06AM +0900, Masami Hiramatsu wrote:
> 
> SNIP
> 
> > > 
> > > On the other hand, untangling all code paths that come from
> > > trampolines (with a light regs structure) from those that come from an
> > > exception (with a pt_regs) could lead to a lot of duplicated code, and
> > > converting between each subsystem's idea of a light regs structure
> > > (what if perf introduces a perf_regs now ?) would be tedious and slow
> > > (lots of copies ?).
> > 
> > This is one discussion point I think. Actually, using pt_regs in kretprobe
> > (and rethook) is histrical accident. Originally, it had put a kprobe on
> > the function return trampoline to hook it. So keep the API compatiblity
> > I made the hand assembled code to save the pt_regs on the stack.
> > 
> > My another question is if we have the fprobe to trace (hook) the function
> > return, why we still need the kretprobe itself. I think we can remove
> > kretprobe and use fprobe exit handler, because "function" probing will
> > be done by fprobe, not kprobe. And then, we can simplify the kprobe
> > interface and clarify what it is -- "kprobe is a wrapper of software
> > breakpoint". And we don't need to think about duplicated code anymore :)
> 
> 1+ sounds like good idea

Thanks! the downside will be that it requires to enable CONFIG_FPROBE
instead of CONFIG_KPROBES, but I think it is natural that the user, who 
wants to trace function boundary, enables CONFIG_FUNCTION_TRACER.

> > > > Otherwise, ftrace_regs() has support on arm64 for getting to the argument
> > > > registers and the stack. Even live kernel patching now uses ftrace_regs().
> > > >
> > > > >
> > > > > If you guys decide to convert fprobe to ftrace_regs please
> > > > > make it depend on kconfig or something.
> > > > > bpf side needs full pt_regs.
> > > 
> > > Some wild ideas that I brought up once in a BPF office hour: BPF
> > > "multi_kprobe" could provide a fake pt_regs (either by constructing a
> > > sparse one on the stack or by JIT-ing different offset accesses and/or
> > > by having the verifier deny access to unpopulated fields) or break the
> > > current API (is it conceivable to phase out BPF "multi_kprobe"
> > > programs in favor of BPF "fprobe" programs that don't lie about their
> > > API and guarantees and just provide a ftrace_regs ?)
> > 
> > +1 :)
> 
> so multi_kprobe link was created to allow fast attach of BPF kprobe-type
> programs to multiple functions.. I don't think there's need for new fprobe
> program

Ah, OK. So the focus point is shortening registration time.

> 
> > 
> > > 
> > > > Then use kprobes. When I asked Masami what the difference between fprobes
> > > > and kprobes was, he told me that it would be that it would no longer rely
> > > > on the slower FTRACE_WITH_REGS. But currently, it still does.
> > > 
> > > Actually... Moving fprobe to ftrace_regs should get even more spicy!
> > > :) Fprobe also wraps "rethook" which is basically the same thing as
> > > kretprobe: a return trampoline that saves a pt_regs, to the point that
> > > on x86 kretprobe's trampoline got dropped in favor of rethook's
> > > trampoline. But for the same reasons that we don't want ftrace to save
> > > pt_regs on arm64, rethook should probably also just save a ftrace_regs
> > > ? (also, to keep the fprobe callback signatures consistent between
> > > pre- and post- handlers). But if we want fprobe "post" callbacks to
> > > save a ftrace_regs now, either we need to re-introduce the kretprobe
> > > trampoline or also change the API of kretprobe (and break its symmetry
> > > with kprobe and we'd have the same problem all over again with BPF
> > > kretprobe program types...). All of this is "beautifully" entangled...
> > > :)
> > 
> > As I said, I would like to phase out the kretprobe itself because it
> > provides the same feature of fprobe, which is confusing. jprobe was
> > removed a while ago, and now kretprobe is. But we can not phase out
> > it at once. So I think we will keep current kretprobe trampoline on
> > arm64 and just add new ftrace_regs based rethook. Then remove the
> > API next release. (after all users including systemtap is moved) 
> > 
> > > 
> > > > The reason I started the FTRACE_WITH_ARGS (which gave us ftrace_regs) in
> > > > the first place, was because of the overhead you reported to me with
> > > > ftrace_regs_caller and why you wanted to go the direct trampoline approach.
> > > > That's when I realized I could use a subset because those registers were
> > > > already being saved. The only reason FTRACE_WITH_REGS was created was it
> > > > had to supply full pt_regs (including flags) and emulate a breakpoint for
> > > > the kprobes interface. But in reality, nothing really needs all that.
> > > >
> > > > > It's not about access to args.
> > > > > pt_regs is passed from bpf prog further into all kinds of perf event
> > > > > functions including stack walking.
> > > 
> > > If all accesses are done in BPF bytecode, we could (theoretically)
> > > have the verifier and JIT work together to deny accesses to
> > > unpopulated fields, or relocate pt_regs accesses to ftrace_regs
> > > accesses to keep backward compatibility with existing multi_kprobe BPF
> > > programs.
> > 
> > Yeah, that is what I would like to suggest, and what my patch does.
> > (let me update rethook too, it'll be a bit tricky since I don't want
> > break anything) 
> > 
> > Thanks,
> > 
> > > 
> > > Is there a risk that a "multi_kprobe" program could call into a BPF
> > > helper or kfunc that reads this pt_regs pointer and expect certain
> > > fields to be set ? I suppose we could also deny giving that "pt_regs"
> > > pointer to a helper... :/
> 
> I think Alexei answered this earlier in the thread:
> 
>  >From bpf side we don't care that such pt_regs is 100% filled in or
>  >only partial as long as this pt_regs pointer is valid for perf_event_output
>  >and stack walking that consume pt_regs.
>  >I believe that was and still is the case for both x86 and arm64.

OK, so I've made the ftrace_partial_regs() according to the idea now.

Thanks,

> 
> 
> jirka


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


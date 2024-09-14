Return-Path: <bpf+bounces-39881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A96978CB3
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 04:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8C8DB25F1D
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 02:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D94FC2F2;
	Sat, 14 Sep 2024 02:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWGW7170"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888012F24
	for <bpf@vger.kernel.org>; Sat, 14 Sep 2024 02:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726279853; cv=none; b=WVhaQi3Sx6QYF2zYsQRUf4oE713vk3MqoBBOJqrLKccVyku9YigECGe6AulJP3xsow2E4H5YULYbXKj72bjVBANhPPrkAsk8jfRnxCes6vdarRFWJz+n5dhTqmRjkuW0OEkOBtxAgHyFQ7d8iX7Fu71T4MBFHjwZ41Wun4LhQKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726279853; c=relaxed/simple;
	bh=kumBRc/p8rXgaxd95CFhI1GtlI/LICqhrgoe+a9SEak=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gdTQ4kCjIY79KdfDAw3+W7oP2ujxNApUUFxTz/8cM3g8lmZTHvVvScbF1q+pf6Vp0iUtjJ7+vJLuqcC19YcCztSimomoqqcMy5WsMLme6UWTwEOZgpG2cjggDgQ/hMQYcRiHDb3fo1kVJ0n5pnFSs4GoNQBtgkpIzBHSSV39zKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWGW7170; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C87AC4CEC0;
	Sat, 14 Sep 2024 02:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726279853;
	bh=kumBRc/p8rXgaxd95CFhI1GtlI/LICqhrgoe+a9SEak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WWGW7170vpYC1V9mi05XBQ8nDV6DWinNJQikDE1fqXAc5AcoAnZla91Un9hQslMOR
	 qQRrbiuLzAr8rEFerJeY9aiCcuuLTYUKn2WlHbqCcI9ZaG56g1cRasvCt8zygfrXTC
	 F3GitCWau6pIUgW/bsXKScoNKwzv5ybk/bxwit2SnVV2oIq1e3wAzQSaLSxLaVSQq5
	 wQPFbhC5f+OV9wsyyf1M2xREosQs3O8aAR18r6VsOzRkhjjzlk3bVpmnAp4oBrVHlG
	 ygnCjPobZghFEMXb2t4sw2WXMrqd1tNr4aPxCBaCeefvN6Y1wQm2rFfzq4hRB0cOMl
	 Twr7FjkEMkSag==
Date: Sat, 14 Sep 2024 11:10:49 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri Olsa
 <jolsa@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, kernel-ci@meta.com, bot+bpf-ci@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, bpf
 <bpf@vger.kernel.org>
Subject: Re: [PATCH v14 00/19] tracing: fprobe: function_graph:
 Multi-function graph and fprobe on fgraph
Message-Id: <20240914111049.cf71f777ec87b68abe46bd35@kernel.org>
In-Reply-To: <CAEf4BzaCixhyFHH1Ut56sCLh2n-twtP6_0YPUcvv9dP+GXF-DA@mail.gmail.com>
References: <172615368656.133222.2336770908714920670.stgit@devnote2>
	<0170cd7d95df0583770c385c1e11bd27dfacf618b71b6e723f0952efc0ce9040@mail.kernel.org>
	<CAEf4BzZgAkSkMd6Vk3m1D-0AVqXp06PaBPr+2L7Dd3WRgJ8JvA@mail.gmail.com>
	<20240913085402.9e5b2c506a8973b099679d04@kernel.org>
	<CAEf4BzZEoNHgcLDPTPQ=yyQTZtEZoVrGbBbeTf3vqe_wcpS6EA@mail.gmail.com>
	<20240913175935.bb0892ab1e6052efc12c6423@kernel.org>
	<20240913214515.894c868a1ef4968550553b86@kernel.org>
	<20240913224957.5bfa380429020f3cbe9eeb63@kernel.org>
	<CAEf4BzaCixhyFHH1Ut56sCLh2n-twtP6_0YPUcvv9dP+GXF-DA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 13 Sep 2024 14:23:38 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Fri, Sep 13, 2024 at 6:50 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Fri, 13 Sep 2024 21:45:15 +0900
> > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> >
> > > On Fri, 13 Sep 2024 17:59:35 +0900
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > >
> > > > >
> > > > > Taking failing output from the test:
> > > > >
> > > > > > > > kprobe_multi_testmod_check:FAIL:kretprobe_test3_result unexpected kretprobe_test3_result: actual 0 != expected 1
> > > > >
> > > > > kretprobe_test3_result is a sort of identifier for a test condition,
> > > > > you can find a corresponding line in user space .c file grepping for
> > > > > that:
> > > > >
> > > > > ASSERT_EQ(skel->bss->kretprobe_testmod_test3_result, 1,
> > > > > "kretprobe_test3_result");
> > > > >
> > > > > Most probably the problem is in:
> > > > >
> > > > > __u64 addr = bpf_get_func_ip(ctx);
> > > >
> > > > Yeah, and as I replyed to another thread, the problem is
> > > > that the ftrace entry_ip is not symbol ip.
> > > >
> > > > We have ftrace_call_adjust() arch function for reverse
> > > > direction (symbol ip to ftrace entry ip) but what we need
> > > > here is the reverse translate function (ftrace entry to symbol)
> > > >
> > > > The easiest way is to use kallsyms to find it, but this is
> > > > a bit costful (but it just increase bsearch in several levels).
> > > > Other possible options are
> > > >
> > > >  - Change bpf_kprobe_multi_addrs_cmp() to accept a range
> > > >    of address. [sym_addr, sym_addr + offset) returns true,
> > > >    bpf_kprobe_multi_cookie() can find the entry address.
> > > >    The offset depends on arch, but 16 is enough.
> > >
> > > Oops. no, this bpf_kprobe_multi_cookie() is used only for storing
> > > test data. Not a general problem solving. (I saw kprobe_multi_check())
> > >
> > > So solving problem is much costly, we need to put more arch-
> > > dependent in bpf_trace, and make sure it does reverse translation
> > > of ftrace_call_adjust(). (this means if you expand arch support,
> > > you need to add such implementation)
> >
> > OK, can you try this one?
> >
> 
> I'm running out of time today, so I won't have time to try this, sorry.
> 
> But see my last reply, I think adjusting link->addrs once before
> attachment is the way to go. It gives us fast and simple lookups at
> runtime.
> 
> In my last reply I assumed that we won't need to keep a copy of
> original addrs (because we can dynamically adjust for
> bpf_kprobe_multi_link_fill_link_info()), but I now realize that we do
> need that for bpf_get_func_ip() anyways.

Yes, that's the point.

> 
> Still, I'd rather have an extra link->adj_addrs with a copy and do a
> quick and simple lookup at runtime. So I suggest going with that. At
> the very worst case it's a few kilobytes of memory for thousands of
> attached functions, no big deal, IMO.

But if you look carefully the below code, it should be faster than
looking up from `link->adj_addrs` since most of conditions are
build-time condition. (Only when the kernel enables BTI and the
function entry(+8bytes) is on the page boundary, we will call
get_kernel_nofault(), but it is very rare case.)

The only one concern about the below code is that is architecture
dependent. It should be provided by arch/arm64/kernel/ftrace.c.

> 
> It's vastly better than maintaining arch-specific reverse of
> ftrace_call_adjust(), isn't it?

Yes, it should be (and x86_64 ENDBR part too).

> 
> Jiri, any opinion here?


Thank you,

> 
> >
> > From 81bc599911507215aa9faa1077a601880cbd654a Mon Sep 17 00:00:00 2001
> > From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
> > Date: Fri, 13 Sep 2024 21:43:46 +0900
> > Subject: [PATCH] bpf: Add get_entry_ip() for arm64
> >
> > Add get_entry_ip() implementation for arm64. This is based on
> > the information in ftrace_call_adjust() for arm64.
> >
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/bpf_trace.c | 64 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 64 insertions(+)
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index deb629f4a510..b0cf6e5b8965 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -1066,6 +1066,70 @@ static unsigned long get_entry_ip(unsigned long fentry_ip)
> >                 fentry_ip -= ENDBR_INSN_SIZE;
> >         return fentry_ip;
> >  }
> > +#elif defined (CONFIG_ARM64)
> > +#include <asm/insn.h>
> > +
> > +static unsigned long get_entry_ip(unsigned long fentry_ip)
> > +{
> > +       u32 insn;
> > +
> > +       /*
> > +        * When using patchable-function-entry without pre-function NOPS, ftrace
> > +        * entry is the address of the first NOP after the function entry point.
> > +        *
> > +        * The compiler has either generated:
> > +        *
> > +        * func+00:     func:   NOP             // To be patched to MOV X9, LR
> > +        * func+04:             NOP             // To be patched to BL <caller>
> > +        *
> > +        * Or:
> > +        *
> > +        * func-04:             BTI     C
> > +        * func+00:     func:   NOP             // To be patched to MOV X9, LR
> > +        * func+04:             NOP             // To be patched to BL <caller>
> > +        *
> > +        * The fentry_ip is the address of `BL <caller>` which is at `func + 4`
> > +        * bytes in either case.
> > +        */
> > +       if (!IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS))
> > +               return fentry_ip - AARCH64_INSN_SIZE;
> > +
> > +       /*
> > +        * When using patchable-function-entry with pre-function NOPs, BTI is
> > +        * a bit different.
> > +        *
> > +        * func+00:     func:   NOP             // To be patched to MOV X9, LR
> > +        * func+04:             NOP             // To be patched to BL <caller>
> > +        *
> > +        * Or:
> > +        *
> > +        * func+00:     func:   BTI     C
> > +        * func+04:             NOP             // To be patched to MOV X9, LR
> > +        * func+08:             NOP             // To be patched to BL <caller>
> > +        *
> > +        * The fentry_ip is the address of `BL <caller>` which is at either
> > +        * `func + 4` or `func + 8` depends on whether there is a BTI.
> > +        */
> > +
> > +       /* If there is no BTI, the func address should be one instruction before. */
> > +       if (!IS_ENABLED(CONFIG_ARM64_BTI_KERNEL))
> > +               return fentry_ip - AARCH64_INSN_SIZE;
> > +
> > +       /* We want to be extra safe in case entry ip is on the page edge,
> > +        * but otherwise we need to avoid get_kernel_nofault()'s overhead.
> > +        */
> > +       if ((fentry_ip & ~PAGE_MASK) < AARCH64_INSN_SIZE * 2) {
> > +               if (get_kernel_nofault(insn, (u32 *)(fentry_ip - AARCH64_INSN_SIZE * 2)))
> > +                       return fentry_ip - AARCH64_INSN_SIZE;
> > +       } else {
> > +               insn = *(u32 *)(fentry_ip - AARCH64_INSN_SIZE * 2);
> > +       }
> > +
> > +       if (aarch64_insn_is_bti(le32_to_cpu((__le32)insn)))
> > +               return fentry_ip - AARCH64_INSN_SIZE * 2;
> > +
> > +       return fentry_ip - AARCH64_INSN_SIZE;
> > +}
> >  #else
> >  #define get_entry_ip(fentry_ip) fentry_ip
> >  #endif
> > --
> > 2.34.1
> >
> >
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


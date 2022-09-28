Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACA45EE20E
	for <lists+bpf@lfdr.de>; Wed, 28 Sep 2022 18:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbiI1QmL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 12:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbiI1QmK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 12:42:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A71EAD4DD4;
        Wed, 28 Sep 2022 09:42:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4B2D143D;
        Wed, 28 Sep 2022 09:42:14 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.80.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2F413F792;
        Wed, 28 Sep 2022 09:42:03 -0700 (PDT)
Date:   Wed, 28 Sep 2022 17:42:01 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Xu Kuohai <xukuohai@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Xu Kuohai <xukuohai@huaweicloud.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Florent Revest <revest@chromium.org>,
        Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH bpf-next v2 0/4] Add ftrace direct call for arm64
Message-ID: <YzR5WSLux4mmFIXg@FVFF77S0Q05N>
References: <20220913162732.163631-1-xukuohai@huaweicloud.com>
 <f1e14934-dc54-9bf7-501a-89affdb7371e@iogearbox.net>
 <YzG51Jyd5zhvygtK@arm.com>
 <YzHk1zRf1Dp8YTEe@FVFF77S0Q05N>
 <970a25e4-9b79-9e0c-b338-ed1a934f2770@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <970a25e4-9b79-9e0c-b338-ed1a934f2770@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 27, 2022 at 12:49:58PM +0800, Xu Kuohai wrote:
> On 9/27/2022 1:43 AM, Mark Rutland wrote:
> > On Mon, Sep 26, 2022 at 03:40:20PM +0100, Catalin Marinas wrote:
> > > On Thu, Sep 22, 2022 at 08:01:16PM +0200, Daniel Borkmann wrote:
> > > > On 9/13/22 6:27 PM, Xu Kuohai wrote:
> > > > > This series adds ftrace direct call for arm64, which is required to attach
> > > > > bpf trampoline to fentry.
> > > > > 
> > > > > Although there is no agreement on how to support ftrace direct call on arm64,
> > > > > no patch has been posted except the one I posted in [1], so this series
> > > > > continues the work of [1] with the addition of long jump support. Now ftrace
> > > > > direct call works regardless of the distance between the callsite and custom
> > > > > trampoline.
> > > > > 
> > > > > [1] https://lore.kernel.org/bpf/20220518131638.3401509-2-xukuohai@huawei.com/
> > > > > 
> > > > > v2:
> > > > > - Fix compile and runtime errors caused by ftrace_rec_arch_init
> > > > > 
> > > > > v1: https://lore.kernel.org/bpf/20220913063146.74750-1-xukuohai@huaweicloud.com/
> > > > > 
> > > > > Xu Kuohai (4):
> > > > >     ftrace: Allow users to disable ftrace direct call
> > > > >     arm64: ftrace: Support long jump for ftrace direct call
> > > > >     arm64: ftrace: Add ftrace direct call support
> > > > >     ftrace: Fix dead loop caused by direct call in ftrace selftest
> > > > 
> > > > Given there's just a tiny fraction touching BPF JIT and most are around core arm64,
> > > > it probably makes sense that this series goes via Catalin/Will through arm64 tree
> > > > instead of bpf-next if it looks good to them. Catalin/Will, thoughts (Ack + bpf-next
> > > > could work too, but I'd presume this just results in merge conflicts)?
> > > 
> > > I think it makes sense for the series to go via the arm64 tree but I'd
> > > like Mark to have a look at the ftrace changes first.
> > 
> > > From a quick scan, I still don't think this is quite right, and as it stands I
> > believe this will break backtracing (as the instructions before the function
> > entry point will not be symbolized correctly, getting in the way of
> > RELIABLE_STACKTRACE). I think I was insufficiently clear with my earlier
> > feedback there, as I have a mechanism in mind that wa a little simpler.
> 
> Thanks for the review. I have some thoughts about reliable stacktrace.
> 
> If PC is not in the range of literal_call, stacktrace works as before without
> changes.
> 
> If PC is in the range of literal_call, for example, interrupted by an
> irq, I think there are 2 problems:
> 
> 1. Caller LR is not pushed to the stack yet, so caller's address and name
>    will be missing from the backtrace.
> 
> 2. Since PC is not in func's address range, no symbol name will be found, so
>    func name is also missing.
> 
> Problem 1 is not introduced by this patchset, but the occurring probability
> may be increased by this patchset. I think this problem should be addressed by
> a reliable stacktrace scheme, such as ORC on x86.

I agree problem 1 is not introduced by this patch set; I have plans fo how to
address that for reliable stacktrace based on identifying the ftrace
trampoline. This is one of the reasons I do not want direct calls, as
identifying all direct call trampolines is going to be very painful and slow,
whereas identifying a statically allocated ftrace trampoline is far simpler.

> Problem 2 is indeed introduced by this patchset. I think there are at least 3
> ways to deal with it:

What I would like to do here, as mentioned previously in other threads, is to
avoid direct calls, and implement "FTRACE_WITH_OPS", where we can associate
each patch-site with a specific set of ops, and invoke that directly from the
regular ftrace trampoline.

With that, the patch site would look like:

	pre_func_literal:
		NOP		// Patched to a pointer to 
		NOP		// ftrace_ops
	func:
		< optional BTI here >
		NOP		// Patched to MOV X9, LR
		NOP		// Patched to a BL to the ftrace trampoline

... then in the ftrace trampoline we can recover the ops pointer at a negative
offset from the LR based on the LR, and invoke the ops from there (passing a
struct ftrace_regs with the saved regs).

That way the patch-site is less significantly affected, and there's no impact
to backtracing. That gets most of the benefit of the direct calls avoiding the
ftrace ops list traversal, without having to do anything special at all. That
should be much easier to maintain, too.

I started implementing that before LPC (and you can find some branches on my
kernel.org repo), but I haven't yet had the time to rebase those and sort out
the remaining issues:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/ftrace/per-callsite-ops

Note that as a prerequisite for that I also want to reduce the set of registers
we save/restore down to the set required by our calling convention, as the
existing pt_regs is both large and generally unsound (since we can not and do
not fill in many of the fields we only acquire at an exception boundary).
That'll further reduce the ftrace overhead generally, and remove the needs for
the two trampolines we currently have. I have a WIP at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/ftrace/minimal-regs

I intend to get back to both of those shortly (along with some related bits for
kretprobes and stacktracing); I just haven't had much time recently due to
other work and illness.

> 1. Add a symbol name for literal_call.

That'll require a number of invasive changes to make RELIABLE_STACKTRACE work,
so I don't think we want to do that.

> 2. Hack the backtrace routine, if no symbol name found for a PC during backtrace,
>    we can check if the PC is in literal_call, then adjust PC and try again.

The problem is that the existing symbolization code doesn't know the length of
the prior symbol, so it will find *some* symbol associated with the previous
function rather than finding no symbol.

To bodge around this we'dd need to special-case each patchable-function-entry
site in symbolization, which is going to be painful and slow down unwinding
unless we try to fix this up at boot-time or compile time.

> 3. Move literal_call to the func's address range, for example:
> 
>         a. Compile with -fpatchable-function-entry=7
>         func:
>                 BTI C
>                 NOP
>                 NOP
>                 NOP
>                 NOP
>                 NOP
>                 NOP
>                 NOP

This is a non-starter. We are not going to add 7 NOPs at the start of every
function.

Thanks,
Mark.

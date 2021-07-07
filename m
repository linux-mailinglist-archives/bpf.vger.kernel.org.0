Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329563BE67D
	for <lists+bpf@lfdr.de>; Wed,  7 Jul 2021 12:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhGGKsP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Jul 2021 06:48:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230354AbhGGKsO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Jul 2021 06:48:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB93661C73;
        Wed,  7 Jul 2021 10:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625654734;
        bh=8aOJz6m5RJlTXs6gh0uc/O0I73BykATmNxUl6cB0w3w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MhrN/1tlrnCGavOeEq49Qur6+PSu6kg6J7gm7/e2okTmQNBoTXp0PLI9KFjtWKTPA
         1QZPIC7znIe+kzZ8FLmTkHZyc6JWs8/HNOOjD0zrh7jNm87gSy3mTyw8lKcfpcVbWu
         4/z5YHEng+CYOkg8GS+AsqR/1w+eTseE7YfUnr3SCQHvFC/g78yvLrhuVlEyyVnZvR
         ykdZYGLKMEpykcsGTpj6fyPSNkY0aLpDhZhuoQHACwX8TuInO2O99+F+7gNu8zvT8X
         N/pgISSE5SIUgg2cPuMz0HAofJOcoOfoudYr8g8hx5IU8wgR6TsfDA++IfPnCCwwwW
         NzwRfBd3elcYg==
Date:   Wed, 7 Jul 2021 19:45:30 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, kernel-team@fb.com, yhs@fb.com,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        wuqiang.matt@bytedance.com
Subject: Re: [PATCH -tip v8 11/13] x86/unwind: Recover kretprobe trampoline
 entry
Message-Id: <20210707194530.766a9c8364f3b2d7714ca590@kernel.org>
In-Reply-To: <YOWACec65qVdTD1y@hirez.programming.kicks-ass.net>
References: <162399992186.506599.8457763707951687195.stgit@devnote2>
        <162400002631.506599.2413605639666466945.stgit@devnote2>
        <YOLurg5mGHdBc+fz@hirez.programming.kicks-ass.net>
        <20210706004257.9e282b98f447251a380f658f@kernel.org>
        <YOQMV8uE/2bVkPOY@hirez.programming.kicks-ass.net>
        <20210706111136.7c5e9843@oasis.local.home>
        <YOVj2VoyrcOvJfEB@hirez.programming.kicks-ass.net>
        <20210707191510.cb48ca4a20f0502ce6c46508@kernel.org>
        <YOWACec65qVdTD1y@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 7 Jul 2021 12:20:57 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Jul 07, 2021 at 07:15:10PM +0900, Masami Hiramatsu wrote:
> 
> > I actually don't want to keep this feature because no one use it.
> > (only systemtap needs it?)
> 
> Yeah, you mentioned systemtap, but since that's out-of-tree I don't
> care. Their problem.
> 
> > Anyway, if we keep the idea-level compatibility (not code level),
> > what we need is 'void *data' in the struct kretprobe_instance.
> > User who needs it can allocate their own instance data for their
> > kretprobes when initialising it and sets in their entry handler.
> > 
> > Then we can have a simple kretprobe_instance.
> 
> When would you do the alloc? When installing the retprobe, but that
> might be inside the allocator, which means you can't call the allocator
> etc.. :-)

Yes, so the user may need to allocate a pool right before register_kretprobe().
(whether per-kretprobe or per-task or global pool, that is user's choice.)

> 
> If we look at struct ftrace_ret_stack, it has a few fixed function
> fields. The calltime one is all that is needed for the kretprobe
> example code.

kretprobe consumes 3 fields, a pointer to 'struct kretprobe' (which
stores callee function address in 'kretprobe::kp.addr'), a return
address and a frame pointer (*).

* note that this frame pointer might be used for fixing up the
stack trace, but the fixup method depends on the architecture.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>

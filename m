Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71D03C3D3B
	for <lists+bpf@lfdr.de>; Sun, 11 Jul 2021 16:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbhGKOMB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Jul 2021 10:12:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:40930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232544AbhGKOMA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Jul 2021 10:12:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C7EE61156;
        Sun, 11 Jul 2021 14:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626012554;
        bh=i2fNzSjVsNS7h5czCODLDyPYDvbmFr0lvLFj67DgUho=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AH/UnpLXKJqBzTKfaPEPvgAFQbwrjI/ubNwdP4j8ChqB6Vb/rAIATXv/NqnImWz4K
         sZ+lOMp407S3ym1dvHf7rCvYggASAeQlGNuY9Rau0fgVKjA6mMOyjLJqFPGWVAyARd
         vmHwVw3SjMas3CZibt1oUT+M4kz9P1Lkz3EbYpwjeUFdMMeR1wW7oGB7O444NFWFMm
         BIBEKy4QGXiOO9j/Z9qM2lP2kVFERtNbx1vdFsjTHXjWx9Y2uLh+I5hKoPpgWt5MhO
         4bI7ThCIsfTDzHt99iawJP/Kf3MIsHxWj0roiAmKhO1ON6yo9AmYlVM+G0UgCzkntd
         eqf3YHN7Fm7Lw==
Date:   Sun, 11 Jul 2021 23:09:09 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Matt Wu <wuqiang.matt@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, kernel-team@fb.com, yhs@fb.com,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH -tip v8 11/13] x86/unwind: Recover kretprobe trampoline
 entry
Message-Id: <20210711230909.dac1ff010a94831d5e9c25cd@kernel.org>
In-Reply-To: <3fc578e0-5b26-6067-d026-5b5d230d6720@bytedance.com>
References: <162399992186.506599.8457763707951687195.stgit@devnote2>
        <162400002631.506599.2413605639666466945.stgit@devnote2>
        <YOLurg5mGHdBc+fz@hirez.programming.kicks-ass.net>
        <20210706004257.9e282b98f447251a380f658f@kernel.org>
        <YOQMV8uE/2bVkPOY@hirez.programming.kicks-ass.net>
        <20210706111136.7c5e9843@oasis.local.home>
        <YOVj2VoyrcOvJfEB@hirez.programming.kicks-ass.net>
        <20210707191510.cb48ca4a20f0502ce6c46508@kernel.org>
        <YOWACec65qVdTD1y@hirez.programming.kicks-ass.net>
        <20210707194530.766a9c8364f3b2d7714ca590@kernel.org>
        <20210707222925.87ecc1391d0ab61db3d8398e@kernel.org>
        <3fc578e0-5b26-6067-d026-5b5d230d6720@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 7 Jul 2021 22:42:47 +0800
Matt Wu <wuqiang.matt@bytedance.com> wrote:

> On 2021/7/7 PM9:29, Masami Hiramatsu wrote:
> > On Wed, 7 Jul 2021 19:45:30 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> >> On Wed, 7 Jul 2021 12:20:57 +0200
> >> Peter Zijlstra <peterz@infradead.org> wrote:
> >>
> >>> On Wed, Jul 07, 2021 at 07:15:10PM +0900, Masami Hiramatsu wrote:
> >>>
> >>>> I actually don't want to keep this feature because no one use it.
> >>>> (only systemtap needs it?)
> >>>
> >>> Yeah, you mentioned systemtap, but since that's out-of-tree I don't
> >>> care. Their problem.
> > 
> > Yeah, maybe it is not hard to update.
> > 
> >>>
> >>>> Anyway, if we keep the idea-level compatibility (not code level),
> >>>> what we need is 'void *data' in the struct kretprobe_instance.
> >>>> User who needs it can allocate their own instance data for their
> >>>> kretprobes when initialising it and sets in their entry handler.
> >>>>
> >>>> Then we can have a simple kretprobe_instance.
> >>>
> >>> When would you do the alloc? When installing the retprobe, but that
> >>> might be inside the allocator, which means you can't call the allocator
> >>> etc.. :-)
> >>
> >> Yes, so the user may need to allocate a pool right before register_kretprobe().
> >> (whether per-kretprobe or per-task or global pool, that is user's choice.)
> >>
> >>>
> >>> If we look at struct ftrace_ret_stack, it has a few fixed function
> >>> fields. The calltime one is all that is needed for the kretprobe
> >>> example code.
> >>
> >> kretprobe consumes 3 fields, a pointer to 'struct kretprobe' (which
> >> stores callee function address in 'kretprobe::kp.addr'), a return
> >> address and a frame pointer (*).
> >  > Oops, I forgot to add "void *data" for storing user data.
> > 
> 
> Should use "struct kretprobe_holder *rph", since "struct kretprobe" belongs
> to 3rd-party module (which might be unloaded any time).

Good catch. Yes, instead of 'struct kretprobe', we need to use the holder.

> User's own pool might not work if the module can be unloaded. Better manage
> the pool in kretprobe_holder, which needs no changes from user side.

No, since the 'data' will be only refered from user handler. If the kretprobe
is released, then the kretprobe_holder will clear the refernce to the 'struct
kretprobe'. Then, the user handler is never called. No one access the 'data'.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>

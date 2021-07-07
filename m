Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DA63BE639
	for <lists+bpf@lfdr.de>; Wed,  7 Jul 2021 12:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhGGKRz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Jul 2021 06:17:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231137AbhGGKRy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Jul 2021 06:17:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40D1961C99;
        Wed,  7 Jul 2021 10:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625652914;
        bh=WoOLCe/573KQNlOrEEqMXmu+eiiCZloj8cqFm7v8pTg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hDoYXpKtBEZ6RTCdoT1foEgQNZLF/DXPZA94tU6t7o7UVFjk4J9VllvYY+3Hjh90m
         PrPyRVe7Ej7L/zrv6J8l4f5g12jAqhs+oqnTkA6lxXHfDaoE8yhgAxXim3IFTkkWB1
         Eq0ptKEhYDxpvwf3De4k02ADOcxfgp69ExdK4GI0etFfPK8psWGKJDVkF+gZoJInSd
         37iqG/hWz4zXLuTPSdfwEvrppigj7dmBwxPhEFg9Lf2xUXQdKwpVZm4mqPkHMlqey5
         PuptKA042B2c0l1UceV5ALGegOvafz69i1ml+dcDHWmmgueFsyiswj7JyK+DVGk+aD
         k1GfH0q+xDApg==
Date:   Wed, 7 Jul 2021 19:15:10 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
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
Message-Id: <20210707191510.cb48ca4a20f0502ce6c46508@kernel.org>
In-Reply-To: <YOVj2VoyrcOvJfEB@hirez.programming.kicks-ass.net>
References: <162399992186.506599.8457763707951687195.stgit@devnote2>
        <162400002631.506599.2413605639666466945.stgit@devnote2>
        <YOLurg5mGHdBc+fz@hirez.programming.kicks-ass.net>
        <20210706004257.9e282b98f447251a380f658f@kernel.org>
        <YOQMV8uE/2bVkPOY@hirez.programming.kicks-ass.net>
        <20210706111136.7c5e9843@oasis.local.home>
        <YOVj2VoyrcOvJfEB@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 7 Jul 2021 10:20:41 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > > Steve, can you clarify the ftrace side here? Afaict return_to_handler()
> > > is similarly affected.
> > 
> > I'm not exactly sure what the issue is. As Masami stated, kretprobe
> > uses a ret to return to the calling function, but ftrace uses a jmp.
> 
> I'll have to re-read the ftrace bits, but from the top of my head you
> cannot do an indirect jump and preserve all registers at the same time,
> so a return stub must use jump from stack aka. ret.
> 
> > kretprobe return tracing is more complex than the function graph return
> > tracing is (which is one of the issues I need to overcome to unify
> > them),
> 
> I'm not sure it is. IIRC the biggest pain point with kretprobe is that
> 'silly' property that the kretprobe_instance are not the same between
> kretprobes. Luckily, that's not actually used anywhere, so we can simply
> rip that out.

I actually don't want to keep this feature because no one use it.
(only systemtap needs it?)

Anyway, if we keep the idea-level compatibility (not code level),
what we need is 'void *data' in the struct kretprobe_instance.
User who needs it can allocate their own instance data for their
kretprobes when initialising it and sets in their entry handler.

Then we can have a simple kretprobe_instance.

Thank you,



-- 
Masami Hiramatsu <mhiramat@kernel.org>

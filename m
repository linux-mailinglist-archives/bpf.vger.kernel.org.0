Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81EBE3BE442
	for <lists+bpf@lfdr.de>; Wed,  7 Jul 2021 10:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbhGGIYA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Jul 2021 04:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhGGIYA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Jul 2021 04:24:00 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47849C061574;
        Wed,  7 Jul 2021 01:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1MtL1A9VbWDqAz9G+RKHDgKdomGvf9eXlb2nS700iHw=; b=eSm04NKEp6I0tmZtveeceH8Ryg
        Nk3SyJa0tT8CfCPqA6lqlYh0EHGqaUqKOHFpqYl8lCTU1duc8FMfcPhUr2p5HbEtjrnB2yctxoV/5
        x+WNkYOSPsmqWPG9ZMu3I3ldtj7y+I3Q7RX45vYzUCf8N7papwDuZawcYsZv0BYUDp7oXSPZ3AYTf
        5Q/3UANpxb1QrFu7Lgjeu1Q6haTklGogNFQWzvKh1LBhLnZn3M+wPY0LvHrls0xb+ZLRMEzSLJFYu
        gkPZOYtk9SqoMpmKdeVlmMPldv/nkOYfhVD5cyWn0lD1Ghqr6lXxVj1TZrdDgMa4i3PRs0bGy5unx
        HbGZEAYw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m12nT-00FIQU-Uz; Wed, 07 Jul 2021 08:20:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A7F35300233;
        Wed,  7 Jul 2021 10:20:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4BBEC236676E9; Wed,  7 Jul 2021 10:20:41 +0200 (CEST)
Date:   Wed, 7 Jul 2021 10:20:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
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
Message-ID: <YOVj2VoyrcOvJfEB@hirez.programming.kicks-ass.net>
References: <162399992186.506599.8457763707951687195.stgit@devnote2>
 <162400002631.506599.2413605639666466945.stgit@devnote2>
 <YOLurg5mGHdBc+fz@hirez.programming.kicks-ass.net>
 <20210706004257.9e282b98f447251a380f658f@kernel.org>
 <YOQMV8uE/2bVkPOY@hirez.programming.kicks-ass.net>
 <20210706111136.7c5e9843@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706111136.7c5e9843@oasis.local.home>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 06, 2021 at 11:11:36AM -0400, Steven Rostedt wrote:
> On Tue, 6 Jul 2021 09:55:03 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > But I'm not so sure how ftrace treat it. It seems that the return_to_handler()
> > > doesn't care such case. (anyway, return_to_handler() does not return but jump
> > > to the original call-site, in that case, the information will be lost.)  
> > 
> > I find it bothersome (OCD, sorry :-) that both return trampolines behave
> > differently. Doubly so because I know people (Steve in particular) have
> > been talking about unifying them.
> 
> They were developed separately, and designed differently with different
> goals in mind. Yes, I want to unify them, but trying to get the
> different goals together, compounded by the fact that almost every arch
> also implemented them differently (in which case, we need to find a way
> to do it one arch at a time), makes the process extremely frustrating.

Yeah.. that's going to be somewhat painful.

> > Steve, can you clarify the ftrace side here? Afaict return_to_handler()
> > is similarly affected.
> 
> I'm not exactly sure what the issue is. As Masami stated, kretprobe
> uses a ret to return to the calling function, but ftrace uses a jmp.

I'll have to re-read the ftrace bits, but from the top of my head you
cannot do an indirect jump and preserve all registers at the same time,
so a return stub must use jump from stack aka. ret.

> kretprobe return tracing is more complex than the function graph return
> tracing is (which is one of the issues I need to overcome to unify
> them),

I'm not sure it is. IIRC the biggest pain point with kretprobe is that
'silly' property that the kretprobe_instance are not the same between
kretprobes. Luckily, that's not actually used anywhere, so we can simply
rip that out.

That should also help Matt make the whole freelist thing faster, because
now the kretprobe instances are global.

> and when the function graph return trampoline was created, it
> did things as simple as possible (and before ORC existed).
> 
> Is this something to worry about now, or should we look to fix his in
> the unifying process?

There seems to be a lot of kretprobe activity now; so I figured we ought
to at least consider where we want to go so we don't make it harder
still.


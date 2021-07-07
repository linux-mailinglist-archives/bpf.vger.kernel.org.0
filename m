Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F203BE482
	for <lists+bpf@lfdr.de>; Wed,  7 Jul 2021 10:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhGGIjd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Jul 2021 04:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhGGIjc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Jul 2021 04:39:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC697C061574;
        Wed,  7 Jul 2021 01:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JBNHLBALM9UU1Je7M8kW2VY0g6MP+oLBuN5BGCPLZEc=; b=BAfWSkBhcBARgj6LUYUIuZnc7R
        60ifflEb+GoYtSGsar1MTPhtOfdoBzWxJkNijyLGQpLeUEUCazc0Z/Mru4EGHlnPvbSa6QNtN30X7
        k4VK9ELPgT68yILG3m8O9xtj2a7gxkNd2zIHovu51PfRAXlmPdNMFUb68RMem8+Mb/cp30YX/rRYs
        cMpwSgZC2fhdb1eNQ1M7tuFCpW5h2HsvkuAWv5wx6c3C5VRgK4ejjlEQOGT0WhbPY7eA4hC761PQE
        3NY1vZj8a07PyqikHL5MQVqMexh7xOqy42nC3vr1JGzdyRg5J0gMtBRvIKh6ZxGi2RSVWRYSgceQy
        O0oZJGuw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m132j-00FIcj-MI; Wed, 07 Jul 2021 08:36:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B630F30007E;
        Wed,  7 Jul 2021 10:36:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A17A12CB20D82; Wed,  7 Jul 2021 10:36:28 +0200 (CEST)
Date:   Wed, 7 Jul 2021 10:36:28 +0200
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
Message-ID: <YOVnjCxOORB4epjr@hirez.programming.kicks-ass.net>
References: <162399992186.506599.8457763707951687195.stgit@devnote2>
 <162400002631.506599.2413605639666466945.stgit@devnote2>
 <YOLurg5mGHdBc+fz@hirez.programming.kicks-ass.net>
 <20210706004257.9e282b98f447251a380f658f@kernel.org>
 <YOQMV8uE/2bVkPOY@hirez.programming.kicks-ass.net>
 <20210706111136.7c5e9843@oasis.local.home>
 <YOVj2VoyrcOvJfEB@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOVj2VoyrcOvJfEB@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 07, 2021 at 10:20:41AM +0200, Peter Zijlstra wrote:

> > > Steve, can you clarify the ftrace side here? Afaict return_to_handler()
> > > is similarly affected.
> > 
> > I'm not exactly sure what the issue is. As Masami stated, kretprobe
> > uses a ret to return to the calling function, but ftrace uses a jmp.
> 
> I'll have to re-read the ftrace bits, but from the top of my head you
> cannot do an indirect jump and preserve all registers at the same time,
> so a return stub must use jump from stack aka. ret.

Hmm... there's callee clobbered regs ofcourse, which don't need to be
preserved. And that's exactly what ftrace seems to be doing, and I don't
think there's any reason why kretprobe cannot do the same. Lemme try.

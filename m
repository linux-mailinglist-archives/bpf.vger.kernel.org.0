Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87EC83BE64D
	for <lists+bpf@lfdr.de>; Wed,  7 Jul 2021 12:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhGGKYA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Jul 2021 06:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhGGKX7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Jul 2021 06:23:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60956C061574;
        Wed,  7 Jul 2021 03:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8Bz/yO9KCbr0wl/w1meI8HRfwaKExJhduf42tQGjlNY=; b=jsE0yDDvkwoazgfq0gwSY0ybBX
        8ZHB+cTjzhjEmQyInW9YCXgIC7AQ+7hnqZddXthRy2GooOIpqHFsWrPeLTHxQg5W4LQMDcE02gSxg
        2LE4g0KH4/48rnFVv80EIo9JjyBZ8cc+xSyoRQognTwFFn4l+Q0levcQOtvtcTGVlefWFRnFWu2nq
        geNts06LEyQIpsV4BrUhgewFI88lKAjZ9PPyDqL3epENQQojKi+hS9KeK+xBBR2ltDwjogRK8+6LE
        jOCHSJr90fuK4hwu8OkkMAzFuIu9kEmBK1i2JfM1biT4c0MtL/jY9wDNa8WPfTaVL/r/QBA2Czr8i
        wdesLoEg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m14fq-00FKCQ-Sm; Wed, 07 Jul 2021 10:20:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CBD2530007E;
        Wed,  7 Jul 2021 12:20:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B66D82019D9F8; Wed,  7 Jul 2021 12:20:57 +0200 (CEST)
Date:   Wed, 7 Jul 2021 12:20:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
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
Message-ID: <YOWACec65qVdTD1y@hirez.programming.kicks-ass.net>
References: <162399992186.506599.8457763707951687195.stgit@devnote2>
 <162400002631.506599.2413605639666466945.stgit@devnote2>
 <YOLurg5mGHdBc+fz@hirez.programming.kicks-ass.net>
 <20210706004257.9e282b98f447251a380f658f@kernel.org>
 <YOQMV8uE/2bVkPOY@hirez.programming.kicks-ass.net>
 <20210706111136.7c5e9843@oasis.local.home>
 <YOVj2VoyrcOvJfEB@hirez.programming.kicks-ass.net>
 <20210707191510.cb48ca4a20f0502ce6c46508@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707191510.cb48ca4a20f0502ce6c46508@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 07, 2021 at 07:15:10PM +0900, Masami Hiramatsu wrote:

> I actually don't want to keep this feature because no one use it.
> (only systemtap needs it?)

Yeah, you mentioned systemtap, but since that's out-of-tree I don't
care. Their problem.

> Anyway, if we keep the idea-level compatibility (not code level),
> what we need is 'void *data' in the struct kretprobe_instance.
> User who needs it can allocate their own instance data for their
> kretprobes when initialising it and sets in their entry handler.
> 
> Then we can have a simple kretprobe_instance.

When would you do the alloc? When installing the retprobe, but that
might be inside the allocator, which means you can't call the allocator
etc.. :-)

If we look at struct ftrace_ret_stack, it has a few fixed function
fields. The calltime one is all that is needed for the kretprobe
example code.


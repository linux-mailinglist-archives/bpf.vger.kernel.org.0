Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECF624FFDA
	for <lists+bpf@lfdr.de>; Mon, 24 Aug 2020 16:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgHXOeA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Aug 2020 10:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgHXOeA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Aug 2020 10:34:00 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57EFC061573;
        Mon, 24 Aug 2020 07:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5TRjc06cjrAIo1ZfkhKU/1+DTjwdh2i/eNpjyD9I8Vk=; b=NErKgbZ/Bz82zy/5ueiDeI2Npx
        ooHQfo1FKSEOsbBLrU/oArD5Yg/aR4AU/Uk37kR9ODYzLl5HbVBkTBeuQmGvHz+jaGsTkzm6ZdBFB
        rRWNOTIVHriKms4E/79tlYjPJbLdPCqz33MIRsWrQOHJsRbxP3au1l2iiTvp5XDyUn8VjXeyHsIqh
        BLP1q6DW5sA1nxT8kVw+02umkVPt5i6XpHo7p+c/0h5xPsQoweanQJwSbpMMUaHCZfr4hfgPL/OrB
        Kwjk3eiW7HPz6+dvVPikbUnu5x5Dy0GA8f1j++5dgy5E920dmQOS23dMMSlRKI2fSr5ZGb6wEdVUP
        lPuaPrhg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kADXd-0002ut-Vt; Mon, 24 Aug 2020 14:33:46 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4FC6B980DCC; Mon, 24 Aug 2020 16:33:44 +0200 (CEST)
Date:   Mon, 24 Aug 2020 16:33:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Brendan Jackman <jackmanb@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Paul Renauld <renauld@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, pjt@google.com,
        Jann Horn <jannh@google.com>, rafael.j.wysocki@intel.com,
        thgarnie@chromium.org, KP Singh <kpsingh@google.com>,
        paul.renauld.epfl@gmail.com
Subject: Re: [RFC] security: replace indirect calls with static calls
Message-ID: <20200824143344.GB3982@worktop.programming.kicks-ass.net>
References: <20200820164753.3256899-1-jackmanb@chromium.org>
 <202008201435.97CF8296@keescook>
 <CA+i-1C0XEuWWRm5nMPWCzEPUao7rp5346Eotpt1A_S3Za3Wysw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+i-1C0XEuWWRm5nMPWCzEPUao7rp5346Eotpt1A_S3Za3Wysw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 24, 2020 at 04:09:09PM +0200, Brendan Jackman wrote:

> > > Why this trick with a switch statement? The table of static call is defined
> > > at compile time. The number of hook callbacks that will be defined is
> > > unknown at that time, and the table cannot be resized at runtime.  Static
> > > calls do not define a conditional execution for a non-void function, so the
> > > executed slots must be non-empty.  With this use of the table and the
> > > switch, it is possible to jump directly to the first used slot and execute
> > > all of the slots after. This essentially makes the entry point of the table
> > > dynamic. Instead, it would also be possible to start from 0 and break after
> > > the final populated slot, but that would require an additional conditional
> > > after each slot.
> >
> > Instead of just "NOP", having the static branches perform a jump would
> > solve this pretty cleanly, yes? Something like:
> >
> >         ret = DEFAULT_RET;
> >
> >         ret = A(args); <--- direct call, no retpoline
> >         if ret != 0:
> >                 goto out;
> >
> >         ret = B(args); <--- direct call, no retpoline
> >         if ret != 0:
> >                 goto out;
> >
> >         goto out;
> >         if ret != 0:
> >                 goto out;
> >
> > out:
> >         return ret;
> 
> Hmm yeah that's a cool idea. This would either need to be implemented
> with custom code-modification logic for the LSM hooks, or we'd need to
> think of a way to express it in a sensible addition to the static_call
> API. I do wonder if the latter could take the form of a generic system
> for arrays of static calls.

So you basically want something like:

	if (A[0] && (ret = static_call(A[0])(...)))
		return ret;

	if (A[1] && (ret = static_call(A[1])(...)))
		return ret;

	....

	return ret;

Right? The problem with static_call_cond() is that we don't know what to
do with the return value when !func, which is why it's limited to void
return type.

You can however construct something like the above with a combination of
static_branch() and static_call() though. It'll not be pretty, but it
ought to work:

	if (static_branch_likely(A[0].key)) {
		ret = static_call(A[0].call)(...);
		if (ret)
			return ret;
	}

	...

	return ret;


> It would also need to handle the fact that IIUC at the moment the last
> static_call may be a tail call, so we'd be patching an existing jump
> into a jump to a different target, I don't know if we can do that
> atomically.

Of course we can, the static_call() series supports tail-calls just
fine. In fact, patching jumps is far easier, it was patching call that
was the real problem because it mucks about with the stack.


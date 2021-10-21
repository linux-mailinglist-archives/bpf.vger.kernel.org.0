Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13E5435D47
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 10:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbhJUIth (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 04:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhJUItd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Oct 2021 04:49:33 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B358C06161C;
        Thu, 21 Oct 2021 01:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/1hQGMgB+pbBjKU+GtBo7/RGdYg+za5wlQN/5rpq/IM=; b=m0CFh2xpa30BQIh8WFy2hP3iRW
        f+llIEBdmbeYYsigAu0L2a/9h6IR5g/VqHFHJN7hgJHFP6P1bJLBoI/BLroWZ+QuIuLkqqFlUNGh6
        RZVQZ89p8WOSakL3j6f7RN2fbD16H1aRyft9etjZUIHYgEx79yFg3JHjPii431N4qI27fegI6o9RG
        xaNKNZr5aQZLWHQFoUZa4w3SSD5O7fEmDo/wxlafEr8mI0/iaNbdcYhMhadFPvHeFX4djrQpMri6V
        4fhI2YtI0xit+szqZ/kBVCEada8Tq99t/d/1KPmnkD5462NlI8k/fykGUcJCRJdGnrxZp6IYODT4G
        FQf6BKew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdTj5-00BGZ5-OE; Thu, 21 Oct 2021 08:47:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 41B3F300221;
        Thu, 21 Oct 2021 10:47:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 18CA52D4101EC; Thu, 21 Oct 2021 10:47:00 +0200 (CEST)
Date:   Thu, 21 Oct 2021 10:47:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        daniel@iogearbox.net, bpf@vger.kernel.org, andrii@kernel.org
Subject: Re: [PATCH v2 14/14] bpf,x86: Respect X86_FEATURE_RETPOLINE*
Message-ID: <YXEpBKxUICIPVj14@hirez.programming.kicks-ass.net>
References: <20211020104442.021802560@infradead.org>
 <20211020105843.345016338@infradead.org>
 <YW/4/7MjUf3hWfjz@hirez.programming.kicks-ass.net>
 <20211021000502.ltn5o6ji6offwzeg@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021000502.ltn5o6ji6offwzeg@ast-mbp.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 20, 2021 at 05:05:02PM -0700, Alexei Starovoitov wrote:
> On Wed, Oct 20, 2021 at 01:09:51PM +0200, Peter Zijlstra wrote:

> > @@ -446,25 +440,8 @@ static void emit_bpf_tail_call_indirect(
> >  {
> >  	int tcc_off = -4 - round_up(stack_depth, 8);
> >  	u8 *prog = *pprog, *start = *pprog;
> > -	int pop_bytes = 0;
> > -	int off1 = 42;
> > -	int off2 = 31;
> > -	int off3 = 9;
> > -
> > -	/* count the additional bytes used for popping callee regs from stack
> > -	 * that need to be taken into account for each of the offsets that
> > -	 * are used for bailing out of the tail call
> > -	 */
> > -	pop_bytes = get_pop_bytes(callee_regs_used);
> > -	off1 += pop_bytes;
> > -	off2 += pop_bytes;
> > -	off3 += pop_bytes;
> > -
> > -	if (stack_depth) {
> > -		off1 += 7;
> > -		off2 += 7;
> > -		off3 += 7;
> > -	}
> > +	static int out_label = -1;
> 
> Interesting idea!

I nicked it from emit_bpf_tail_call() in the 32bit jit :-) It seemed a
lot more robust than the 64bit one and I couldn't figure out why the
difference.

> All insn emits trying to do the right thing from the start.
> Here the logic assumes that there will be at least two passes over image.
> I think that is correct, but we never had such assumption.

That's not exactly true; I think image is NULL on every first run, so
all insn that depend on it will be wrong to start with. Equally there's
a number of insn that seem to depend on addrs[i], that also requires at
least two passes.

> A comment is certainly must have.

I can certainly add one, although I think we'll disagree on the comment
style :-)

> The race is possible too. Not sure whether READ_ONCE/WRITE_ONCE
> are really warranted though. Might be overkill.

Is there concurrency on the jit?

> Once you have a git branch with all the changes I can give it a go.

Ok, I'll go polish this thing and stick it in the tree mentioned in the
cover letter.

> Also you can rely on our BPF CI.
> Just cc your patchset to bpf@vger and add [PATCH bpf-next] to a subject.
> In patchwork there will be "bpf/vmtest-bpf-next" link that
> builds kernel, selftests and runs everything.

What's a patchwork and where do I find it?

> It's pretty much the same as selftests/bpf/vmtest.sh, but with the latest
> clang nightly and other deps like pahole.

nice.

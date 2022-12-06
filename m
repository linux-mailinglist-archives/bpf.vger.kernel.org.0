Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CABC643D93
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 08:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbiLFHUp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 02:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiLFHUp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 02:20:45 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88D21006B;
        Mon,  5 Dec 2022 23:20:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 59A6CCE168F;
        Tue,  6 Dec 2022 07:20:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5851DC433C1;
        Tue,  6 Dec 2022 07:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670311240;
        bh=7qMs1MctDN0tIseFpP+n9YopH4FHOJ7vglltxXDIcoA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dsq/HbUJk8y/c/dGU/eyHKb4ekNS95fiiVHNnft5rctoCsKabNp9tdav1qNEozryd
         NSY2etQ7cF7fcJFKXOu8QH2NeTH4CaMwKceRnGTdIRQYfk6jQo8BZ4POyzseZ5Vvit
         d9yNFHyCCTJt6dKTEowY6Ow1n3kZt8BYpBM3VVWzLd4gZtz2jffGB9+Kah9gxAhi5r
         lNITizk6X5Vy/vPZqTlYMZcD7NSuvTedRosfuq9zwCn6Sv3/2Oiwd/+PgcJTviodcf
         TZmriNC8qP1Mh7lPARgp6zHeP3iajpZT/BjCqHwrC0t8rRlGVSW+gchApogqgAilV/
         ZqKqLIFa0pCuw==
Date:   Tue, 6 Dec 2022 16:20:35 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Chris Mason <clm@meta.com>
Subject: Re: [PATCH v2] panic: Taint kernel if fault injection has been used
Message-Id: <20221206162035.97ae19674d6d17108bed1910@kernel.org>
In-Reply-To: <20221206021700.oryt26otos7vpxjh@macbook-pro-6.dhcp.thefacebook.com>
References: <167019256481.3792653.4369637751468386073.stgit@devnote3>
        <20221204223001.6wea7cgkofjsiy2z@macbook-pro-6.dhcp.thefacebook.com>
        <20221205075921.02edfe6b54abc5c2f9831875@kernel.org>
        <20221206021700.oryt26otos7vpxjh@macbook-pro-6.dhcp.thefacebook.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 5 Dec 2022 18:17:00 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Mon, Dec 05, 2022 at 07:59:21AM +0900, Masami Hiramatsu wrote:
> > On Sun, 4 Dec 2022 14:30:01 -0800
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > 
> > > On Mon, Dec 05, 2022 at 07:22:44AM +0900, Masami Hiramatsu (Google) wrote:
> > > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > 
> > > > Since the function error injection framework in the fault injection
> > > > subsystem can change the function code flow forcibly, it may cause
> > > > unexpected behavior (and that is the purpose of this feature) even
> > > > if it is applied to the ALLOW_ERROR_INJECTION functions.
> > > > So this feature must be used only for debugging or testing purpose.
> > > 
> > > The whole idea of tainting for kernel debugging is questionable.
> > > There are many other *inject* kconfigs and other debug flags
> > > for link lists, RCU, sleeping, etc.
> > > None of them taint the kernel.
> > > 
> > > > To identify this in the kernel oops message, add a new taint flag
> > > 
> > > Have you ever seen a single oops message because of this particular
> > > error injection?
> > 
> > No, but there is no guarantee that the FEI doesn't cause any issue
> > in the future too. If it happens, we need to know the precise
> > information about what FEI/bpf does.
> > FEI is a kind of temporal Livepatch for testing. If Livepatch taints
> > the kernel, why doesn't the FEI taint it too?
> 
> Live patching can replace an arbitrary function and the kernel has
> no visibility into what KLP module is doing.
> While 'bpf error injection' is predictable.

No, not much predictable because the kernel code can be changed.

> The functions marked with [BPF_]ALLOW_ERROR_INJECTION can return errors
> in the normal execution. So the callers of these functions have to deal with errors.

Right, but it might change something before checking the input, and
if it rejects the sane input, the caller may go into unexpected
status (e.g. the caller already checked input value, and does not
expect the call is fail). Such behaviors are buggy, yes. And the
FEI is designed for finding such buggy behavior.
(e.g. injecting error, but the caller passed successfully, it
means the caller code has some issue.)

> If kernel panics on such injected error it potentially would have paniced
> on it anyway.

Yes, but that doesn't cover all cases. If the function doesn't have
any internal state but returns an error according to the input,
FEI can make it return an error even if the input is correct.
And if it cause a kernel panic, that is a panic that must not
happen without FEI.

Thus, the ALLOW_ERROR_INJECTION should only be applied to the
function which has so-called 'side-effect', e.g. memory allocation,
external data (except for input data) read, etc. that could cause
an error regardless of the input value. Then the caller must
handle such errors.

> At this point crash dump might be necessary to debug.

Yes. So the TAINT flag can help. Please consider that the TAINT flag
doesn't mean you are guilty, but this is just a hint for debugging.
(good for the first triage)

> Whether oops happened because of bpf, kprobe or normal execution
> doesn't matter much. The bug is in the caller that wasn't prepared
> to deal with that error.
> 
> One can still walk all bpf progs from crash dump with tool "drgn"
> (it has nice scripts to examine the dumps) or "crash" or other tools.
> 
> > > 
> > > > for the fault injection. This taint flag will be set by either
> > > > function error injection is used or the BPF use the kprobe_override
> > > > on error injectable functions (identified by ALLOW_ERROR_INJECTION).
> > > 
> > > ...
> > > 
> > > >  	/* set the new array to event->tp_event and set event->prog */
> > > > +	if (prog->kprobe_override)
> > > > +		add_taint(TAINT_FAULT_INJECTED, LOCKDEP_NOW_UNRELIABLE);
> > > 
> > > Nack for bpf bits.
> > 
> > I think this is needed especially for bpf bits. If we see this flag,
> > we can ask reporters to share the bpf programs which they used.
> 
> You can ask reporters to share bpf progs, but you can repro
> the oops just as well without bpf. It's not bpf to blame, but the
> bug in the caller that you should worry about.

I don't blame the bpf, but just it points that undesigned behavior has
been injected. So we have to take it into account.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

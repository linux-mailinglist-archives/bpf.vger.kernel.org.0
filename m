Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3C664202A
	for <lists+bpf@lfdr.de>; Sun,  4 Dec 2022 23:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiLDW7b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Dec 2022 17:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiLDW71 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Dec 2022 17:59:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D643710064;
        Sun,  4 Dec 2022 14:59:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A59960F19;
        Sun,  4 Dec 2022 22:59:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4867AC433C1;
        Sun,  4 Dec 2022 22:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670194765;
        bh=LRkUe4XABlC9VBeCPJzhz6PTyyn3i1YDevmOH4lKMA4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GrfY35+txbbtOxDfwufQw7dlLTxFTY+3KB6z9sNdtYva1nDOHkjee4Wk9nsWbugO5
         ixPxSG4dEr6Cc4u1kX5x1tyCSxS8uW7oC91N0zIarLvzV1kYvCif748THPEv56T0RE
         XdKtqeG7PwNWWwArWJvWKv0afON+vDCBk1px1t/bpbvVB0nCsM+KsZcH99cWFyq1cf
         CZPNmdvSlHY3Segr5bYTRrNxZNhU1WTky7QcuUbjh/gp1iUvDt02ZBw3qkGCwj/vAm
         0dOJCa76tv62JeZBOVrc/8XqwtoKimxloJyOcHi9Z9cJMXuJYPvniV6E+KadXceAx8
         otxtt0Em9UjPQ==
Date:   Mon, 5 Dec 2022 07:59:21 +0900
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
Message-Id: <20221205075921.02edfe6b54abc5c2f9831875@kernel.org>
In-Reply-To: <20221204223001.6wea7cgkofjsiy2z@macbook-pro-6.dhcp.thefacebook.com>
References: <167019256481.3792653.4369637751468386073.stgit@devnote3>
        <20221204223001.6wea7cgkofjsiy2z@macbook-pro-6.dhcp.thefacebook.com>
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

On Sun, 4 Dec 2022 14:30:01 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Mon, Dec 05, 2022 at 07:22:44AM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Since the function error injection framework in the fault injection
> > subsystem can change the function code flow forcibly, it may cause
> > unexpected behavior (and that is the purpose of this feature) even
> > if it is applied to the ALLOW_ERROR_INJECTION functions.
> > So this feature must be used only for debugging or testing purpose.
> 
> The whole idea of tainting for kernel debugging is questionable.
> There are many other *inject* kconfigs and other debug flags
> for link lists, RCU, sleeping, etc.
> None of them taint the kernel.
> 
> > To identify this in the kernel oops message, add a new taint flag
> 
> Have you ever seen a single oops message because of this particular
> error injection?

No, but there is no guarantee that the FEI doesn't cause any issue
in the future too. If it happens, we need to know the precise
information about what FEI/bpf does.
FEI is a kind of temporal Livepatch for testing. If Livepatch taints
the kernel, why doesn't the FEI taint it too?

> 
> > for the fault injection. This taint flag will be set by either
> > function error injection is used or the BPF use the kprobe_override
> > on error injectable functions (identified by ALLOW_ERROR_INJECTION).
> 
> ...
> 
> >  	/* set the new array to event->tp_event and set event->prog */
> > +	if (prog->kprobe_override)
> > +		add_taint(TAINT_FAULT_INJECTED, LOCKDEP_NOW_UNRELIABLE);
> 
> Nack for bpf bits.

I think this is needed especially for bpf bits. If we see this flag,
we can ask reporters to share the bpf programs which they used.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

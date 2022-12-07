Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98DC8645A19
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 13:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiLGMsM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 07:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLGMsL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 07:48:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BCCF592;
        Wed,  7 Dec 2022 04:48:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62EF5615F7;
        Wed,  7 Dec 2022 12:48:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D30C433D7;
        Wed,  7 Dec 2022 12:48:07 +0000 (UTC)
Date:   Wed, 7 Dec 2022 07:48:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
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
Message-ID: <20221207074806.6f869be2@gandalf.local.home>
In-Reply-To: <CAADnVQKDZfP51WeVOeY-6RNH=MHT2BhtW6F8PaJV5-RoJOtMkQ@mail.gmail.com>
References: <167019256481.3792653.4369637751468386073.stgit@devnote3>
        <20221204223001.6wea7cgkofjsiy2z@macbook-pro-6.dhcp.thefacebook.com>
        <20221205075921.02edfe6b54abc5c2f9831875@kernel.org>
        <20221206021700.oryt26otos7vpxjh@macbook-pro-6.dhcp.thefacebook.com>
        <20221206162035.97ae19674d6d17108bed1910@kernel.org>
        <20221207040146.zhm3kyduqp7kosqa@macbook-pro-6.dhcp.thefacebook.com>
        <20221206233947.4c27cc9d@gandalf.local.home>
        <CAADnVQKDZfP51WeVOeY-6RNH=MHT2BhtW6F8PaJV5-RoJOtMkQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 6 Dec 2022 20:45:17 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> > "G - Proprietary module" - "O - out of tree module"
> >
> > Can you reproduce this without those taints?  
> 
> Lol. That question is exactly the reason why my Nack stands.

First, that's a BS reason for a NACK.

But in all seriousness, what I would actually ask (and what I'll ask now)
is, what module did you use that is out of tree, and was it relevant to
this test?

That's a reasonable question to ask, and one that only gets asked with a
taint.


If there's a BPF injection taint, one can ask that same question, as the
bug may happen sometime after the injection but be caused by that injection,
and not be in the backtrace. Not all kernel developers have the access to
debugging utilities that backend production servers have. A lot of bugs that
kernel developers debug are from someone's laptop. Where all they have is
that backtrace. If a tool or root kit, added function error injection, it
would be extremely useful information to debug what happened.

I don't understand the push back here.

-- Steve

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9522649525
	for <lists+bpf@lfdr.de>; Sun, 11 Dec 2022 18:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiLKRCg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Dec 2022 12:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiLKRCf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Dec 2022 12:02:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E0AB2E;
        Sun, 11 Dec 2022 09:02:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C504FB80A2B;
        Sun, 11 Dec 2022 17:02:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7FA3C433EF;
        Sun, 11 Dec 2022 17:02:28 +0000 (UTC)
Date:   Sun, 11 Dec 2022 12:02:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Chris Mason <clm@meta.com>
Subject: Re: [PATCH v2] panic: Taint kernel if fault injection has been used
Message-ID: <20221211120226.11c97578@rorschach.local.home>
In-Reply-To: <CACYkzJ72-hJweZoFN_YN8u3NOmp5x82M2xA-ZKBi5ubt6yrzZA@mail.gmail.com>
References: <167019256481.3792653.4369637751468386073.stgit@devnote3>
        <20221204223001.6wea7cgkofjsiy2z@macbook-pro-6.dhcp.thefacebook.com>
        <20221205075921.02edfe6b54abc5c2f9831875@kernel.org>
        <20221206021700.oryt26otos7vpxjh@macbook-pro-6.dhcp.thefacebook.com>
        <20221206162035.97ae19674d6d17108bed1910@kernel.org>
        <20221207040146.zhm3kyduqp7kosqa@macbook-pro-6.dhcp.thefacebook.com>
        <20221206233947.4c27cc9d@gandalf.local.home>
        <CAADnVQKDZfP51WeVOeY-6RNH=MHT2BhtW6F8PaJV5-RoJOtMkQ@mail.gmail.com>
        <20221207074806.6f869be2@gandalf.local.home>
        <20221208043628.el5yykpjr4j45zqx@macbook-pro-6.dhcp.thefacebook.com>
        <20221211115218.2e6e289bb85f8cf53c11aa97@kernel.org>
        <CACYkzJ72-hJweZoFN_YN8u3NOmp5x82M2xA-ZKBi5ubt6yrzZA@mail.gmail.com>
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

On Sun, 11 Dec 2022 08:49:01 +0100
KP Singh <kpsingh@kernel.org> wrote:

> Let's take a step back and focus on solving debuggability and
> introspection as we clearly have some perception issues about taints
> in the community. (distro maintainers, users) before we go and add
> more taints.

Note, you will likely get the same push back if the dump includes bpf
programs known to change the return of a function that may be involved
with the bug report. That is, if a crash is reported to code I
maintain, and I see that the bug report includes a list of BPF programs
that can modify the return of a function, and one of those functions
could affect the place that crashed, I'd push back and ask if the crash
could be done without that BPF program loaded, regardless of taints.

I agree that a taint is just a hint and it can include something that
caused the bug or it may not. I would like to see more details in how
the crashed kernel was configured. That includes loaded BPF programs
(just like we include loaded modules). And if any BPF program modifies
a core function (outside of syscall returns) I'd be a bit suspect of
what happened.

I also agree that if a function that checks error paths fails, it
should be fixed, but knowing that the error path was caused by fault
injection will prevent the wasted effort that most developers will go
through to find out why the error path was hit in the first place.

-- Steve

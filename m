Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3ED75932C2
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 18:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiHOQIy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 12:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiHOQIx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 12:08:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396971CFEA;
        Mon, 15 Aug 2022 09:08:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B204561199;
        Mon, 15 Aug 2022 16:08:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30CD4C433C1;
        Mon, 15 Aug 2022 16:08:50 +0000 (UTC)
Date:   Mon, 15 Aug 2022 12:08:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <olsajiri@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] ftrace: Add support to keep some functions out of ftrace
Message-ID: <20220815120856.6d632c5d@gandalf.local.home>
In-Reply-To: <CAADnVQ+QTMRnCpmqPcovcbAXmtVz2Kefyr0E++P7CTRq6=PCVw@mail.gmail.com>
References: <20220813150252.5aa63650@rorschach.local.home>
        <Yvn9xR7qhXW7FnFL@worktop.programming.kicks-ass.net>
        <YvoVgMzMuQbAEayk@krava>
        <Yvo+EpO9dN30G0XE@worktop.programming.kicks-ass.net>
        <CAADnVQJfvn2RYydqgO-nS_K+C8WJL7BdCnR44MiMF4rnAwWM5A@mail.gmail.com>
        <YvpZJQGQdVaa2Oh4@worktop.programming.kicks-ass.net>
        <CAADnVQKyfrFTZOM9F77i0NbaXLZZ7KbvKBvu7p6kgdnRgG+2=Q@mail.gmail.com>
        <Yvpf67eCerqaDmlE@worktop.programming.kicks-ass.net>
        <CAADnVQKX5xJz5N_mVyf7wg4BT8Q2cNh8ze-SxTRfk6KtcFQ0=Q@mail.gmail.com>
        <YvpmAnFldR0iwAFC@worktop.programming.kicks-ass.net>
        <YvppJ7TjMXD3cSdZ@worktop.programming.kicks-ass.net>
        <CAADnVQ+QTMRnCpmqPcovcbAXmtVz2Kefyr0E++P7CTRq6=PCVw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 15 Aug 2022 08:49:11 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> > > The whole problem is that it isn't a notrace function and you're abusing
> > > a __fentry__ site.  
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=x86/fineibt&id=8d075bdf11193f1d276bf19fa56b4b8dfe24df9e  
> 
> Brand new stuff.
> Awesome. That should fit perfectly.
> 
> > foo.c:
> >
> > __attribute__((__no_instrument_function__))
> > __attribute__((patchable_function_entry(5)))  
> 
> Interesting. Didn't know about this attribute.
> 
> > void my_func(void)
> > {
> > }
> >
> > void my_foo(void)
> > {
> > }  
> 
> Great.
> Jiri, could you please revise your patch with this approach?

This is the exact result I was looking for. Something we can all agree to.

The point being, include others when developing code that is similar to
what other subsystems do. On the code modification front, please Cc the
ftrace, kprobe, static_call and jump_label maintainers, as we like to work
together. The BPF dispatcher modifications should be no different. There's
a lot of experience in this field throughout the kernel. Please utilize it.
If it wasn't for this thread, we would never had found out about this easy
solution.

-- Steve

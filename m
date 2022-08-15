Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679755931EA
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 17:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbiHOPdS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 11:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiHOPcx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 11:32:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232E41EEE1;
        Mon, 15 Aug 2022 08:32:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4766610A2;
        Mon, 15 Aug 2022 15:32:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4ECC433C1;
        Mon, 15 Aug 2022 15:32:34 +0000 (UTC)
Date:   Mon, 15 Aug 2022 11:32:40 -0400
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
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC] ftrace: Add support to keep some functions out of ftrace
Message-ID: <20220815113240.71edf5cf@gandalf.local.home>
In-Reply-To: <CAADnVQKX5xJz5N_mVyf7wg4BT8Q2cNh8ze-SxTRfk6KtcFQ0=Q@mail.gmail.com>
References: <20220722174120.688768a3@gandalf.local.home>
        <YtxqjxJVbw3RD4jt@krava>
        <YvbDlwJCTDWQ9uJj@krava>
        <20220813150252.5aa63650@rorschach.local.home>
        <Yvn9xR7qhXW7FnFL@worktop.programming.kicks-ass.net>
        <YvoVgMzMuQbAEayk@krava>
        <Yvo+EpO9dN30G0XE@worktop.programming.kicks-ass.net>
        <CAADnVQJfvn2RYydqgO-nS_K+C8WJL7BdCnR44MiMF4rnAwWM5A@mail.gmail.com>
        <YvpZJQGQdVaa2Oh4@worktop.programming.kicks-ass.net>
        <CAADnVQKyfrFTZOM9F77i0NbaXLZZ7KbvKBvu7p6kgdnRgG+2=Q@mail.gmail.com>
        <Yvpf67eCerqaDmlE@worktop.programming.kicks-ass.net>
        <CAADnVQKX5xJz5N_mVyf7wg4BT8Q2cNh8ze-SxTRfk6KtcFQ0=Q@mail.gmail.com>
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

On Mon, 15 Aug 2022 08:17:42 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> Ask yourself: should static_call patching logic go through
> ftrace infra ? No. Right?

I agree that static_call (and jump_labels) are not part of the ftrace
infrastructure (but ftrace was a strong motivator for those).

> static_call has nothing to do with ftrace (function tracing).

Besides the motivation, I agree.

> Same thing here. bpf dispatching logic is nothing to do with
> function tracing.

But it used fentry, which is part of function tracing. Which is what I'm
against. And why it broke ftrace.

> In this case bpf_dispatcher_xdp_func is a placeholder written C.
> If it was written in asm, fentry recording wouldn't have known about it.

And I would not have had an issue with that approach (for ftrace that is).
But that brings up other concerns (see below).

> And that's more or less what Jiri patch is doing.
> It's hiding a fake function from ftrace, since it's not a function
> and ftrace infra shouldn't show it tracing logs.
> In other words it's a _notrace_ function with nop5.

On the ftrace side, I'm perfectly happy with Jiri's approach (the one I
help extend).

But dynamic code modification is something we need to take very seriously.
It's very similar to writing your own locking primitives (which Linus
always says "Don't do"). It's complex and easy to get wrong. The more
dynamic code modifications we have, the less secure the kernel is.

Here's the list of dynamic code modification infrastructures:

 ftrace
 kprobes
 jump_labels
 static_calls

We now have the bpf dispatcher.

The ftrace, kprobes, jump_labels and static_calls developers work together
to make sure that we are all in line, not breaking anything, and try to
consolidate when possible. We also review each others code.

The issue I have is that BPF is largely doing it alone, and not
communicating with the others. This gives me cause for concern on both a
robustness and security point of view.

-- Steve

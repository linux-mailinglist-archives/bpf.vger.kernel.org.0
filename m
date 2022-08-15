Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF85593248
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 17:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiHOPox (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 11:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbiHOPow (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 11:44:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C1A11C35;
        Mon, 15 Aug 2022 08:44:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D744B80F2B;
        Mon, 15 Aug 2022 15:44:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB5FC433D6;
        Mon, 15 Aug 2022 15:44:46 +0000 (UTC)
Date:   Mon, 15 Aug 2022 11:44:53 -0400
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
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC] ftrace: Add support to keep some functions out of ftrace
Message-ID: <20220815114453.08625089@gandalf.local.home>
In-Reply-To: <CAADnVQJuDS22o7fi9wPZx9siAWgu1grQXXB02KfasxZ-RPdRSw@mail.gmail.com>
References: <YvbDlwJCTDWQ9uJj@krava>
        <20220813150252.5aa63650@rorschach.local.home>
        <Yvn9xR7qhXW7FnFL@worktop.programming.kicks-ass.net>
        <YvoVgMzMuQbAEayk@krava>
        <Yvo+EpO9dN30G0XE@worktop.programming.kicks-ass.net>
        <CAADnVQJfvn2RYydqgO-nS_K+C8WJL7BdCnR44MiMF4rnAwWM5A@mail.gmail.com>
        <YvpZJQGQdVaa2Oh4@worktop.programming.kicks-ass.net>
        <CAADnVQKyfrFTZOM9F77i0NbaXLZZ7KbvKBvu7p6kgdnRgG+2=Q@mail.gmail.com>
        <Yvpf67eCerqaDmlE@worktop.programming.kicks-ass.net>
        <CAADnVQKX5xJz5N_mVyf7wg4BT8Q2cNh8ze-SxTRfk6KtcFQ0=Q@mail.gmail.com>
        <YvpmAnFldR0iwAFC@worktop.programming.kicks-ass.net>
        <CAADnVQJuDS22o7fi9wPZx9siAWgu1grQXXB02KfasxZ-RPdRSw@mail.gmail.com>
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

On Mon, 15 Aug 2022 08:35:53 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> > Then make it a notrace function with a nop5 in it. That isn't hard.  
> 
> That's exactly what we're trying to do.
> Jiri's patch is one way to achieve that.
> What is your suggestion?
> Move it from C to asm ?
> Make it naked function with explicit inline asm?
> What else?

The dispatcher is already in the kernel so it's too late to complain about
it. Jiri's patch (with my extensions) will hopefully fix the breakage BPF
did to ftrace.

My ask now is to be more inclusive when doing anything that deals with
modification of text, or other infrastructures. This "go it alone" approach
really needs to stop. Linux is an open source project and collaboration is
key. I know you don't care about others use cases (as you told me in that
BPF meeting last year), but any maintainer in the Linux kernel must care
about the use case of others or this will all fail.

-- Steve

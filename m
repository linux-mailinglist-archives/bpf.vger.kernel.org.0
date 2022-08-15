Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80B35932D1
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 18:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiHOQNs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 12:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiHOQNs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 12:13:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50688DEE7;
        Mon, 15 Aug 2022 09:13:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E21BE6118B;
        Mon, 15 Aug 2022 16:13:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3ADC433C1;
        Mon, 15 Aug 2022 16:13:44 +0000 (UTC)
Date:   Mon, 15 Aug 2022 12:13:50 -0400
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
Message-ID: <20220815121350.56db328d@gandalf.local.home>
In-Reply-To: <CAADnVQK9v8nW4rSwqB3rOkL5POogMQxyTJVUSAOyT=sS6Rv4QA@mail.gmail.com>
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
        <20220815114453.08625089@gandalf.local.home>
        <CAADnVQK9v8nW4rSwqB3rOkL5POogMQxyTJVUSAOyT=sS6Rv4QA@mail.gmail.com>
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

On Mon, 15 Aug 2022 08:53:05 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> > My ask now is to be more inclusive when doing anything that deals with
> > modification of text, or other infrastructures. This "go it alone" approach
> > really needs to stop. Linux is an open source project and collaboration is
> > key. I know you don't care about others use cases (as you told me in that
> > BPF meeting last year), but any maintainer in the Linux kernel must care
> > about the use case of others or this will all fail.  
> 
> Please don't misrepresent. Not cool.

Sorry. To quote exactly what you told me when you cut me off in that
meeting, "I don't care about your use cases". I guess you care about others
use cases, just not mine.

-- Steve

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27EA598EFD
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 23:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346666AbiHRVLW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Aug 2022 17:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346853AbiHRVKi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Aug 2022 17:10:38 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA2DD8E3C;
        Thu, 18 Aug 2022 14:05:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 615AACE22C3;
        Thu, 18 Aug 2022 21:05:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D025FC433D7;
        Thu, 18 Aug 2022 21:05:32 +0000 (UTC)
Date:   Thu, 18 Aug 2022 17:05:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20220818170543.2e361e7d@gandalf.local.home>
In-Reply-To: <CAADnVQ+n=x=CuBk23UNnD9CHVXjrXLUofbockh-SWaLwH3H9fw@mail.gmail.com>
References: <Yvn9xR7qhXW7FnFL@worktop.programming.kicks-ass.net>
        <YvoVgMzMuQbAEayk@krava>
        <Yvo+EpO9dN30G0XE@worktop.programming.kicks-ass.net>
        <CAADnVQJfvn2RYydqgO-nS_K+C8WJL7BdCnR44MiMF4rnAwWM5A@mail.gmail.com>
        <YvpZJQGQdVaa2Oh4@worktop.programming.kicks-ass.net>
        <CAADnVQKyfrFTZOM9F77i0NbaXLZZ7KbvKBvu7p6kgdnRgG+2=Q@mail.gmail.com>
        <Yvpf67eCerqaDmlE@worktop.programming.kicks-ass.net>
        <CAADnVQKX5xJz5N_mVyf7wg4BT8Q2cNh8ze-SxTRfk6KtcFQ0=Q@mail.gmail.com>
        <YvpmAnFldR0iwAFC@worktop.programming.kicks-ass.net>
        <YvppJ7TjMXD3cSdZ@worktop.programming.kicks-ass.net>
        <Yv6gm09CMdZ/HMr5@krava>
        <20220818165024.433f56fd@gandalf.local.home>
        <CAADnVQ+n=x=CuBk23UNnD9CHVXjrXLUofbockh-SWaLwH3H9fw@mail.gmail.com>
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

On Thu, 18 Aug 2022 14:00:21 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> > #ifdef CONFIG_X86
> > # define NON_MCOUNT_PATCHABLE KEEP(*(__patchable_function_entries))
> > # define MCOUNT_PATCHABLE
> > #else
> > # define NON_MCOUNT_PATCHABLE
> > # define MCOUNT_PATCHABLE  KEEP(*(__patchable_function_entries))
> > #endif
> >
> >   #define MCOUNT_REC()    . = ALIGN(8);     \
> >     __start_mcount_loc = .;                 \
> >     KEEP(*(__mcount_loc))                   \
> >     MCOUNT_PATCHABLE                        \
> >     __stop_mcount_loc = .;                  \
> >     NON_MCOUNT_PATCHABLE                    \
> >    ...
> >
> > ??  
> 
> That's what more or less Peter's patch is doing:

Heh.

> Here it is again for reference:
> https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=8d075bdf11193f1d276bf19fa56b4b8dfe24df9e

Thanks, I missed seeing this.

-- Steve

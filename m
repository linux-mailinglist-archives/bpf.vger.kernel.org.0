Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16AB598E53
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 22:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343961AbiHRUuU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Aug 2022 16:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbiHRUuT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Aug 2022 16:50:19 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99237CE496;
        Thu, 18 Aug 2022 13:50:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E841BCE232A;
        Thu, 18 Aug 2022 20:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630B9C433C1;
        Thu, 18 Aug 2022 20:50:13 +0000 (UTC)
Date:   Thu, 18 Aug 2022 16:50:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
Message-ID: <20220818165024.433f56fd@gandalf.local.home>
In-Reply-To: <Yv6gm09CMdZ/HMr5@krava>
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

On Thu, 18 Aug 2022 22:27:07 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> ok, so the problem with __attribute__((patchable_function_entry(5))) is that
> it puts function address into __patchable_function_entries section, which is
> one of ftrace locations source:
> 
>   #define MCOUNT_REC()    . = ALIGN(8);     \
>     __start_mcount_loc = .;                 \
>     KEEP(*(__mcount_loc))                   \
>     KEEP(*(__patchable_function_entries))   \
>     __stop_mcount_loc = .;                  \
>    ...
> 
> 
> it looks like __patchable_function_entries is used for other than x86 archs,
> so we perhaps we could have x86 specific MCOUNT_REC macro just with
> __mcount_loc section?

So something like this:

#ifdef CONFIG_X86
# define NON_MCOUNT_PATCHABLE KEEP(*(__patchable_function_entries))
# define MCOUNT_PATCHABLE
#else
# define NON_MCOUNT_PATCHABLE
# define MCOUNT_PATCHABLE  KEEP(*(__patchable_function_entries))
#endif

  #define MCOUNT_REC()    . = ALIGN(8);     \
    __start_mcount_loc = .;                 \
    KEEP(*(__mcount_loc))                   \
    MCOUNT_PATCHABLE			    \
    __stop_mcount_loc = .;                  \
    NON_MCOUNT_PATCHABLE		    \
   ...

??

-- Steve

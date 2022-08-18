Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E463598DFE
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 22:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345954AbiHRU1O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Aug 2022 16:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbiHRU1N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Aug 2022 16:27:13 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F592DEE;
        Thu, 18 Aug 2022 13:27:11 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id o22so3262270edc.10;
        Thu, 18 Aug 2022 13:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=I/1x6/iHbBuNqucpvMeT3iP7IohY0BCErMO71CeWc6A=;
        b=lLyif36eNB+DAogNmA5rnBXdV/1pETqV7lgGpvKAhSEYYdb1pAZfd2RwZEc2T7x9OE
         NCxLOysq7OH6CwI5g6fTQUhus7zn4IbH8C/77i2svSh1GokhKe6yn8lEPq8UTB98F5G7
         aIYtXX9tKlBmqRSk0AZKVNd355lHaYvzlxKzYN1lqC0axaPMAmlUBfOXwLV6QJrkMj9G
         tLTOKQNoAnwmIBs2V6yZKyUHbNMbQfP/5SjX4/x3iNj3N7sZC6tWxUK/q4VjFdipZhD7
         2Gqh+8xNmZtSTRIpg6trp4Y5kBXUzYU71HeKWmGgjmbpBSgAssjNcMXhbDDguo8Zqqqz
         JXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=I/1x6/iHbBuNqucpvMeT3iP7IohY0BCErMO71CeWc6A=;
        b=qu1jGvtXl/g1M1FQ3iuTkVHLszrFt7RhWfThZMZvdLqv6A1sLNExnBzRwuDC2619Ef
         0e4iqzFx/jDXMXQ4OB6lj+i3SvfkyKej4bEa7s2HniIoSoBdDrR3kDcU0gcvCd4M30yz
         b7qbLpMzq+HPw2g0HiovFdysjgTxtMyHwbqL4zanhra8bKb3x6j/dCw8AzJWvqSQgODe
         sJWsmJBC91+jSjvkTOon/vVRROTzEh8HnkOOFmtfkUlx0nnHbu5qPO54FTfBsqzzfVu4
         YcpTjT283oFKo1WMcyHLHBgHuLb0v8PWxI3lJ6TWjyN6LSxMCSbuyBph1i/Ou+l2I8/F
         qFtw==
X-Gm-Message-State: ACgBeo1Nk1QiZj2Z0GgHDPpTgNPjv2Ac3DewYnyXn0Pynlfyip3QN9Mq
        boo8lT0G4/RkXQVFVt1uCdk=
X-Google-Smtp-Source: AA6agR7M243Vcesn4ldSGw0kbmEGw+WsqdE1ru718eTLRausIEArDnC9nXlkVqfieFHIbDx40Pw0Tg==
X-Received: by 2002:a05:6402:28ca:b0:43b:5235:f325 with SMTP id ef10-20020a05640228ca00b0043b5235f325mr3481566edb.320.1660854430167;
        Thu, 18 Aug 2022 13:27:10 -0700 (PDT)
Received: from krava ([83.240.63.36])
        by smtp.gmail.com with ESMTPSA id h17-20020a056402095100b0044629b54b00sm633182edz.46.2022.08.18.13.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 13:27:09 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 18 Aug 2022 22:27:07 +0200
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiri Olsa <olsajiri@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <Yv6gm09CMdZ/HMr5@krava>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvppJ7TjMXD3cSdZ@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 15, 2022 at 05:41:27PM +0200, Peter Zijlstra wrote:
> On Mon, Aug 15, 2022 at 05:28:02PM +0200, Peter Zijlstra wrote:
> > On Mon, Aug 15, 2022 at 08:17:42AM -0700, Alexei Starovoitov wrote:
> > > It's hiding a fake function from ftrace, since it's not a function
> > > and ftrace infra shouldn't show it tracing logs.
> > > In other words it's a _notrace_ function with nop5.
> > 
> > Then make it a notrace function with a nop5 in it. That isn't hard.
> > 
> > The whole problem is that it isn't a notrace function and you're abusing
> > a __fentry__ site.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=x86/fineibt&id=8d075bdf11193f1d276bf19fa56b4b8dfe24df9e
> 
> foo.c:
> 
> __attribute__((__no_instrument_function__))
> __attribute__((patchable_function_entry(5)))
> void my_func(void)
> {
> }
> 
> void my_foo(void)
> {
> }
> 
> gcc -c foo.c -pg -mfentry -mcmodel=kernel -fno-PIE -O2
> 
> foo.o:     file format elf64-x86-64
> 
> 
> Disassembly of section .text:
> 
> 0000000000000000 <my_func>:
>    0:   f3 0f 1e fa             endbr64 
>    4:   90                      nop
>    5:   90                      nop
>    6:   90                      nop
>    7:   90                      nop
>    8:   90                      nop
>    9:   c3                      ret    
>    a:   66 0f 1f 44 00 00       nopw   0x0(%rax,%rax,1)
> 
> 0000000000000010 <my_foo>:
>   10:   f3 0f 1e fa             endbr64 
>   14:   e8 00 00 00 00          call   19 <my_foo+0x9>  15: R_X86_64_PLT32      __fentry__-0x4
>   19:   c3                      ret    
> 

ok, so the problem with __attribute__((patchable_function_entry(5))) is that
it puts function address into __patchable_function_entries section, which is
one of ftrace locations source:

  #define MCOUNT_REC()    . = ALIGN(8);     \
    __start_mcount_loc = .;                 \
    KEEP(*(__mcount_loc))                   \
    KEEP(*(__patchable_function_entries))   \
    __stop_mcount_loc = .;                  \
   ...


it looks like __patchable_function_entries is used for other than x86 archs,
so we perhaps we could have x86 specific MCOUNT_REC macro just with
__mcount_loc section?

jirka

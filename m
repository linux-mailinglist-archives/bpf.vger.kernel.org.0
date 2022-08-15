Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A82593228
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 17:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbiHOPl6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 11:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbiHOPlp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 11:41:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D47E0A7;
        Mon, 15 Aug 2022 08:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RqH1kAkjrnR3j/vdtYu6rW+fESWnaxFrU4NkHAF6vNI=; b=uPhfv9XO1VpipMfVxK4ub8qlnI
        YOJkBDYjJNJ8qVCd1DM8qS9v+jZjW2dATV/UEF3vWRs3z20nWroKrc5dNMY0KXl+8wZ53mOEL9zYf
        vZ9AHsP5C/J/W1NHTMpovc3LMAAOBGXuEHAGQ2q5ewW0gWkGzChFXTqwgx1wcL3mQi7NfFrQN1zOm
        F5XGh34LDqcs69twWpP/d/xPhmHE5ySbAVx2YCps5JJDTVXxVRpg72go1AtSm2Mv2eNRvJ1J3wv/+
        SPY5N7MWhQXqXbN/E+X7TUqDwCyR2Xex8CNhCuHyVLhVdKFf4S9DYJt5H6o90vQdc3+4Z+TbYImcR
        UlD6Vzhg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNcDZ-005pmp-4T; Mon, 15 Aug 2022 15:41:29 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 528529801D4; Mon, 15 Aug 2022 17:41:27 +0200 (CEST)
Date:   Mon, 15 Aug 2022 17:41:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
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
Message-ID: <YvppJ7TjMXD3cSdZ@worktop.programming.kicks-ass.net>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvpmAnFldR0iwAFC@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 15, 2022 at 05:28:02PM +0200, Peter Zijlstra wrote:
> On Mon, Aug 15, 2022 at 08:17:42AM -0700, Alexei Starovoitov wrote:
> > It's hiding a fake function from ftrace, since it's not a function
> > and ftrace infra shouldn't show it tracing logs.
> > In other words it's a _notrace_ function with nop5.
> 
> Then make it a notrace function with a nop5 in it. That isn't hard.
> 
> The whole problem is that it isn't a notrace function and you're abusing
> a __fentry__ site.

https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=x86/fineibt&id=8d075bdf11193f1d276bf19fa56b4b8dfe24df9e

foo.c:

__attribute__((__no_instrument_function__))
__attribute__((patchable_function_entry(5)))
void my_func(void)
{
}

void my_foo(void)
{
}

gcc -c foo.c -pg -mfentry -mcmodel=kernel -fno-PIE -O2

foo.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <my_func>:
   0:   f3 0f 1e fa             endbr64 
   4:   90                      nop
   5:   90                      nop
   6:   90                      nop
   7:   90                      nop
   8:   90                      nop
   9:   c3                      ret    
   a:   66 0f 1f 44 00 00       nopw   0x0(%rax,%rax,1)

0000000000000010 <my_foo>:
  10:   f3 0f 1e fa             endbr64 
  14:   e8 00 00 00 00          call   19 <my_foo+0x9>  15: R_X86_64_PLT32      __fentry__-0x4
  19:   c3                      ret    


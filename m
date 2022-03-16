Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A76B4DAD98
	for <lists+bpf@lfdr.de>; Wed, 16 Mar 2022 10:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354912AbiCPJh1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Mar 2022 05:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354895AbiCPJh0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Mar 2022 05:37:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C39A2E0A4;
        Wed, 16 Mar 2022 02:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HKAJxnccbCH8SVoVSxbMHEcQALU/pnAeMKrlnhcXp/Y=; b=p2fyhQDcSw+sHfWh3GcbF885Io
        QnXtC0/r7t047SOI7P8AqzCJWpH+n2WGLwzSOFyPGotkeOnnsXMCgIq6ALKjNqhaxdBr8S3gn/QJ4
        NyrQiOukv3VC+Nuv4qbn0H9sWr2BBt9J88ZW3FSp3mK+4e30Lso89OPSdoDwbaZEK2k1bDILvK4gO
        znlw+izoUywE4T/ew3SYRQzr1VHlEtQZ36bBdxjyHVfKhW+xMc2N6zQfvlDGwEkGVl8j81JA16yiG
        A8O93ZdERMl4Q/VYj+LfprTp1+0DtF1aO88VP/YVnNNdUR0fwQ88BV3uiA0OuIYGWVEhC2NyVbG14
        V/K7tjwQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUQ4D-001VCf-Fy; Wed, 16 Mar 2022 09:35:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F261D30021B;
        Wed, 16 Mar 2022 10:35:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CF34B2D60BAF6; Wed, 16 Mar 2022 10:35:38 +0100 (CET)
Date:   Wed, 16 Mar 2022 10:35:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        X86 ML <x86@kernel.org>, joao@overdrivepizza.com,
        hjl.tools@gmail.com, Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Mark Rutland <mark.rutland@arm.com>, alyssa.milburn@intel.com,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v4 00/45] x86: Kernel IBT
Message-ID: <YjGvauc0NYh2XXoc@hirez.programming.kicks-ass.net>
References: <20220309190917.w3tq72alughslanq@ast-mbp.dhcp.thefacebook.com>
 <YinGZObp37b27LjK@hirez.programming.kicks-ass.net>
 <YioBZmicMj7aAlLf@hirez.programming.kicks-ass.net>
 <YionV0+v/cUBiOh0@hirez.programming.kicks-ass.net>
 <YisnG9lW6kp8lBp3@hirez.programming.kicks-ass.net>
 <CAADnVQJfffD9tH_cWThktCCwXeoRV1XLZq69rKK5vKy_y6BN8A@mail.gmail.com>
 <20220312154407.GF28057@worktop.programming.kicks-ass.net>
 <CAADnVQL7xrafAviUJg47LfvFSJpgZLwyP18Bm3S_KQwRyOpheQ@mail.gmail.com>
 <20220314204402.rpd5hqzzev4ugtdt@apollo>
 <20220315090043.GB8939@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315090043.GB8939@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 15, 2022 at 10:00:43AM +0100, Peter Zijlstra wrote:
> On Tue, Mar 15, 2022 at 02:14:02AM +0530, Kumar Kartikeya Dwivedi wrote:
> 
> > [ Note: I have no experience with trampoline code or IBT so what follows might
> > 	be incorrect. ]
> > 
> > In case of fexit and fmod_ret, we call original function (but skip
> > X86_PATCH_SIZE bytes), with ENDBR we must also skip those 4 bytes, but in some
> > cases like bpf_fentry_test1, for which this test has fmod_ret prog, compiler
> > (gcc 11) emits endbr64, but not for do_init_module, for which we do fexit.
> > 
> > This means for do_init_module module, orig_call += X86_PATCH_SIZE +
> > ENDBR_INSN_SIZE would skip more bytes than needed to emit call to original
> > function, which explains why I was seeing crash in the middle of
> > 'mov edx, 0x10' instruction.
> > 
> > The diff below fixes the problem for me, and allows the test to pass.
> > 
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index b98e1c95bcc4..760c9a3c075f 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -2031,11 +2031,14 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
> > 
> >         ip_off = stack_size;
> > 
> > -       if (flags & BPF_TRAMP_F_SKIP_FRAME)
> > +       if (flags & BPF_TRAMP_F_SKIP_FRAME) {
> >                 /* skip patched call instruction and point orig_call to actual
> >                  * body of the kernel function.
> >                  */
> > -               orig_call += X86_PATCH_SIZE + ENDBR_INSN_SIZE;
> > +               if (is_endbr(*(u32 *)orig_call))
> > +                       orig_call += ENDBR_INSN_SIZE;
> > +               orig_call += X86_PATCH_SIZE;
> > +       }
> > 
> >         prog = image;
> 
> Hmm, so I was under the impression that this was targeting the NOP from
> emit_prologue(), and that has an unconditional ENDBR. If this is instead
> targeting the 'start of random kernel function' then yes, what you
> propose will work.

Can you confirm that orig_call can be any kernel function? Because if
so, I'm thinking it will still do the wrong thing for a notrace
function, that will not have a __fentry__ site, so unconditionally
skipping those 5 bytes will place you somewhere non-sensible.

This would not be a new issue; but perhaps it should be clarified and or
fixed.

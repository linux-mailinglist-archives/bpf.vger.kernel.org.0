Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A97A4D96F9
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 10:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346073AbiCOJCf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 05:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238477AbiCOJCd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 05:02:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638604D9E9;
        Tue, 15 Mar 2022 02:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ky05SS0dLP9h7QzHiJvGTANI4WZNzfmgs3YRQLEcx58=; b=curqcvVdYc3eIzjLKBHdPBB9+s
        G3CwawKkSnWcWe6FAT9Vz/58zfyVv4TM8srf1+VSlJPsk3Aahsqii4DBP1/rb6wr65CiyLm13zRe3
        ElM5AeTzBAdRDPr3XWS3mefEnMhKdRwfB4MXMbXoyYMnk5zTu7BFKjskib6kon2UVE85hkVc73af1
        smWSajASTzMJKZsausXwWrtVdjkLWaYDroy0Ovq5molIR90WGUNnSBaiAdFbCRI38BkiP412HDAne
        eYfgh5WA+y2vKx0ZMh95NyHBnv1HrOjdzMJGRuFXgsnXabC0Imcq1LWDdqoTguIens/OQ/TxUZxRe
        A5LWBuVA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nU32r-004ro6-Eg; Tue, 15 Mar 2022 09:00:45 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 42AC8986205; Tue, 15 Mar 2022 10:00:43 +0100 (CET)
Date:   Tue, 15 Mar 2022 10:00:43 +0100
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
Message-ID: <20220315090043.GB8939@worktop.programming.kicks-ass.net>
References: <Yif8nO2xg6QnVQfD@hirez.programming.kicks-ass.net>
 <20220309190917.w3tq72alughslanq@ast-mbp.dhcp.thefacebook.com>
 <YinGZObp37b27LjK@hirez.programming.kicks-ass.net>
 <YioBZmicMj7aAlLf@hirez.programming.kicks-ass.net>
 <YionV0+v/cUBiOh0@hirez.programming.kicks-ass.net>
 <YisnG9lW6kp8lBp3@hirez.programming.kicks-ass.net>
 <CAADnVQJfffD9tH_cWThktCCwXeoRV1XLZq69rKK5vKy_y6BN8A@mail.gmail.com>
 <20220312154407.GF28057@worktop.programming.kicks-ass.net>
 <CAADnVQL7xrafAviUJg47LfvFSJpgZLwyP18Bm3S_KQwRyOpheQ@mail.gmail.com>
 <20220314204402.rpd5hqzzev4ugtdt@apollo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314204402.rpd5hqzzev4ugtdt@apollo>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 15, 2022 at 02:14:02AM +0530, Kumar Kartikeya Dwivedi wrote:

> [ Note: I have no experience with trampoline code or IBT so what follows might
> 	be incorrect. ]
> 
> In case of fexit and fmod_ret, we call original function (but skip
> X86_PATCH_SIZE bytes), with ENDBR we must also skip those 4 bytes, but in some
> cases like bpf_fentry_test1, for which this test has fmod_ret prog, compiler
> (gcc 11) emits endbr64, but not for do_init_module, for which we do fexit.
> 
> This means for do_init_module module, orig_call += X86_PATCH_SIZE +
> ENDBR_INSN_SIZE would skip more bytes than needed to emit call to original
> function, which explains why I was seeing crash in the middle of
> 'mov edx, 0x10' instruction.
> 
> The diff below fixes the problem for me, and allows the test to pass.
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index b98e1c95bcc4..760c9a3c075f 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -2031,11 +2031,14 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
> 
>         ip_off = stack_size;
> 
> -       if (flags & BPF_TRAMP_F_SKIP_FRAME)
> +       if (flags & BPF_TRAMP_F_SKIP_FRAME) {
>                 /* skip patched call instruction and point orig_call to actual
>                  * body of the kernel function.
>                  */
> -               orig_call += X86_PATCH_SIZE + ENDBR_INSN_SIZE;
> +               if (is_endbr(*(u32 *)orig_call))
> +                       orig_call += ENDBR_INSN_SIZE;
> +               orig_call += X86_PATCH_SIZE;
> +       }
> 
>         prog = image;

Hmm, so I was under the impression that this was targeting the NOP from
emit_prologue(), and that has an unconditional ENDBR. If this is instead
targeting the 'start of random kernel function' then yes, what you
propose will work.

(obviously, once we go do more complicated CFI schemes, all this needs
revisiting yet again).

I don't seem able to run this mod_race test, it keeps saying:

  tgl-build# ./test_progs -v -t mod_race
  bpf_testmod.ko is already unloaded.
  Loading bpf_testmod.ko...
  Successfully loaded bpf_testmod.ko.
  Summary: 0/0 PASSED, 0 SKIPPED, 0 FAILED
  Successfully unloaded bpf_testmod.ko.

Which I'm taking to mean I'm doing it wrong... so I can't immediately
verify, but your proposal looks sane so I'll fold it in.

Thanks!

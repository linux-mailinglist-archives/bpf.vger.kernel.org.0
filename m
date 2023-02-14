Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EC0696835
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 16:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjBNPhO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 10:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjBNPhN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 10:37:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019024231
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 07:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xDPWxkb1Dpl/Rsp18kmYjvpgSfwJsX8cvah/ksG9Rvk=; b=EWkh9thJQtSTNp2DxQKM6ZPiy+
        2RpiNP0J7Yi0kuPipB4sWfAWJIYzNUXDfhZWmDlawtC1CbdQBUsVMbTZWbQ833S5jzaCDcNoz0/lF
        RyM4bn1MTIxVMTSCAeYTkgV8Inw3o/iFXDfyNlcRRnT6+sOEoCJ6yuzgBOEaPvq/ei7glISZrJmX0
        0i6WOOG/v63zLXFhE9oNYyN4ybnIqWYHdt214bP6RBgQltXFW+S8FachyDT7N/pWmBnazGS+S2Pqm
        dSvBk5OuYkUFZXIYLBhGPlsV5NDaSC7Rjv2mazP5v7VflxWD3kjh0vazX1G7i08alnhchb2gHbwgA
        aPjm7wpQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRxMO-006bVL-Py; Tue, 14 Feb 2023 15:36:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 18569300244;
        Tue, 14 Feb 2023 12:21:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F3EAC20B4E943; Tue, 14 Feb 2023 12:21:08 +0100 (CET)
Date:   Tue, 14 Feb 2023 12:21:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        kernel test robot <lkp@intel.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        bpf <bpf@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>,
        Joao Moreira <joao@overdrivepizza.com>
Subject: Re: [PATCH v5 bpf-next 3/9] bpf: Add bpf_rbtree_{add,remove,first}
 kfuncs
Message-ID: <Y+tupCQ/X38AlvY0@hirez.programming.kicks-ass.net>
References: <20230212092715.1422619-4-davemarchevsky@fb.com>
 <202302121936.t36vlAFG-lkp@intel.com>
 <d04d33ff-0f8f-2bbd-3a67-9b8b813a799b@meta.com>
 <CAKwvOdketskm5z25aPRY7OsBOZe2kzvXV-i9RDTbwcLpZSAT0A@mail.gmail.com>
 <CAADnVQ+qJMAugDDQXaerRbh0g4QdRygMZ_0UVmXViR2aJ4OLDQ@mail.gmail.com>
 <CABCJKucDXNeGCdD6uT7phYhpm+OgYm19EkfCNMB9AJ66k4NcvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKucDXNeGCdD6uT7phYhpm+OgYm19EkfCNMB9AJ66k4NcvQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 13, 2023 at 03:31:21PM -0800, Sami Tolvanen wrote:
> On Mon, Feb 13, 2023 at 2:17 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Feb 13, 2023 at 12:49 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > I haven't looked at the series in question, but note that this compile
> > > time warning is meant to help us catch Control Flow Integrity runtime
> > > violations, which may result in a panic.
> 
> Here's the tracking issue for the other warnings of this type in the
> kernel, nearly all the warnings are in one driver:
> 
> https://github.com/ClangBuiltLinux/linux/issues/1724
> 
> > It's a transition from kernel to bpf prog.
> > If CFI trips on it it will trip on all transitions.
> > All calls from kernel into bpf are more or less the same.
> > Not sure what it means for other archs, but on x86 JIT emits 'endbr'
> > insn to make IBT/CFI happy.
> 
> While IBT allows indirect calls to any function that starts with
> endbr, CFI is more fine-grained and requires the function pointer type
> to match the function type, which further limits possible call
> targets. To actually enforce this, the compiler emits a type hash
> prefix for each function, and a check before each indirect call to
> ensure the call target has the expected prefix. The commit message
> here has an example of the code the compiler generates:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3c516f89e17e56b4738f05588e51267e295b5e63

Another good commit to look at is:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=931ab63664f02b17d2213ef36b83e1e50190a0aa

That includes the FineIBT variant too.

> As calling a JIT compiled function would obviously trip CFI, indirect
> call checking is currently disabled in BPF dispatcher functions (using
> the __nocfi attribute). However, BPF trampolines still have the same
> problem, I believe. I wouldn't mind coming up with a solution for
> CFI+BPF JIT compatibility, but I haven't had much time to look into
> this. Basically, in places where we currently emit an endbr
> instruction, we should also emit a type hash prefix.
> 
> Generating type prefixes for functions called through a dispatcher
> shouldn't be that hard because the function type is always the same,
> but figuring out the correct type for indirect calls that don't go
> through a dispatcher might not be entirely trivial, although I'm sure
> the BPF verifier/compiler must have this information. FineIBT also
> complicates matters a bit here as the actual prefix format differs
> from the basic KCFI prefix.
> 
> I'm not sure if Peter or Joao have had time to look at this, but I
> would be happy to hear any suggestions you might have.

I've not had time to look at this -- but afair BPF will only emit an
indirect jump (tail-call even, irrc), it doesn't do indirect calls
otherwise (this is also the only place we have RETPOLINE magic in the
JIT).

(ooh, also dispatcher thing)

This generates an unadorned indirect jump, that is, it doesn't have any
kCFI magic included, eg. traditional calling convention.

The other case, which you allude to I think, is control transfer to the
JIT'ed code which is currently __nocfi annotated. I've only briefly
thought about how to change this, but basically it would entail the JIT
emitting the correct prefix bytes and setting the entry point at +16.

Given the JIT will only run after we've selected kCFI/FineIBT it knows
which form to pick from and can emit the right prefix. Then if we remove
the __nocfi annotation from the call into JIT'ed code, everything should
work.

None of this should be exceptionally hard, but I've not had time to
actually do much about it yet.



Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D5E6954CF
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 00:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjBMXcD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Feb 2023 18:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjBMXcA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Feb 2023 18:32:00 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CA62114
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 15:31:59 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id c1so11331347edt.4
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 15:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AdtOWowEtcNb0fBYdv2IT4vsABesICSFaMSOMAEIWRA=;
        b=cMkCqggcOpdERZkrVimIABE58AgahEXS7SwagsUDcIRe0tNifo2rJfrWITLM84bj3K
         VT5r6oGAIGSGGDmoZBcOwmMPCOvD3aq/FKOf9TwOedY7huCgbqUgCnQ6+X86crrWF7SZ
         5VDY9yc3NpyZDyY9eqTyFXhi4MAyC4IRGt3fF3EF9LXiwuNUfJ7Vh1EP7wzHIAz+zeMk
         LQNPZ+j+qikdWWBHXQ/JyifmHUPvaLcYGRYJaNsjunDi4EJQuNa/aJ+GqU2VMkfOvLMC
         I1o6GsFdF+x/Zfx8Yi9iQHJMlpt4NzVFNMbxqcXxBCVg5Tpwb4V8B8nM7pNf0K89hzOU
         M+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AdtOWowEtcNb0fBYdv2IT4vsABesICSFaMSOMAEIWRA=;
        b=gbDgFCtp4ACAEIt4/TNPfX3mq9qlkGABkZQEC2XTzc95xlFYeIlfjWcTnO0D6L85Yq
         5moOaSOx300npmFnpQjS89uwRP+ocpAzUeyBbbpd4wmyTfN11haA2LZobYDEqCRHhsqs
         aCY/XSQf55nSdazLuFU5yHGdnNR8uOoHVIDeREgZ9QMq2WLfpTJdRlyoQjYfugPJyZjw
         Zk+mHKb+FtGbb9/p4dioYDWgdDrkG9Wcz089ilT3pRPbRM+bfvhvCbVGQKhaa19KPq85
         EPvG06ZURhUeuib7cHFw1Txeb9xGYcFVZDx6TZjZPS+NKx6WHRYQQijfhHObrR5Ym1j1
         FK9w==
X-Gm-Message-State: AO0yUKUZIFSPcYbcoRIWqzIInjttrFqcn5hLFnLdv2geOWycS+s8nz+D
        TtE11qYCghv1bva0yJLe6f0xuQ/uIlzrQud4QW0f1Q==
X-Google-Smtp-Source: AK7set+4DODG3YNHkQGmaxQz8GUJTeGHYRXYvtMPa+YrS0XW+8xHHLnTrKDEV48T4miR6kX7dk0P0b0Y8J5TeDE8q/A=
X-Received: by 2002:a50:d513:0:b0:4ac:c720:207c with SMTP id
 u19-20020a50d513000000b004acc720207cmr198637edi.5.1676331117332; Mon, 13 Feb
 2023 15:31:57 -0800 (PST)
MIME-Version: 1.0
References: <20230212092715.1422619-4-davemarchevsky@fb.com>
 <202302121936.t36vlAFG-lkp@intel.com> <d04d33ff-0f8f-2bbd-3a67-9b8b813a799b@meta.com>
 <CAKwvOdketskm5z25aPRY7OsBOZe2kzvXV-i9RDTbwcLpZSAT0A@mail.gmail.com> <CAADnVQ+qJMAugDDQXaerRbh0g4QdRygMZ_0UVmXViR2aJ4OLDQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+qJMAugDDQXaerRbh0g4QdRygMZ_0UVmXViR2aJ4OLDQ@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 13 Feb 2023 15:31:21 -0800
Message-ID: <CABCJKucDXNeGCdD6uT7phYhpm+OgYm19EkfCNMB9AJ66k4NcvQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 3/9] bpf: Add bpf_rbtree_{add,remove,first} kfuncs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
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
        Peter Zijlstra <peterz@infradead.org>,
        Joao Moreira <joao@overdrivepizza.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 13, 2023 at 2:17 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Feb 13, 2023 at 12:49 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > I haven't looked at the series in question, but note that this compile
> > time warning is meant to help us catch Control Flow Integrity runtime
> > violations, which may result in a panic.

Here's the tracking issue for the other warnings of this type in the
kernel, nearly all the warnings are in one driver:

https://github.com/ClangBuiltLinux/linux/issues/1724

> It's a transition from kernel to bpf prog.
> If CFI trips on it it will trip on all transitions.
> All calls from kernel into bpf are more or less the same.
> Not sure what it means for other archs, but on x86 JIT emits 'endbr'
> insn to make IBT/CFI happy.

While IBT allows indirect calls to any function that starts with
endbr, CFI is more fine-grained and requires the function pointer type
to match the function type, which further limits possible call
targets. To actually enforce this, the compiler emits a type hash
prefix for each function, and a check before each indirect call to
ensure the call target has the expected prefix. The commit message
here has an example of the code the compiler generates:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3c516f89e17e56b4738f05588e51267e295b5e63

As calling a JIT compiled function would obviously trip CFI, indirect
call checking is currently disabled in BPF dispatcher functions (using
the __nocfi attribute). However, BPF trampolines still have the same
problem, I believe. I wouldn't mind coming up with a solution for
CFI+BPF JIT compatibility, but I haven't had much time to look into
this. Basically, in places where we currently emit an endbr
instruction, we should also emit a type hash prefix.

Generating type prefixes for functions called through a dispatcher
shouldn't be that hard because the function type is always the same,
but figuring out the correct type for indirect calls that don't go
through a dispatcher might not be entirely trivial, although I'm sure
the BPF verifier/compiler must have this information. FineIBT also
complicates matters a bit here as the actual prefix format differs
from the basic KCFI prefix.

I'm not sure if Peter or Joao have had time to look at this, but I
would be happy to hear any suggestions you might have.

Sami

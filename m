Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137D5697251
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 01:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjBOAAm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 19:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbjBOAAL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 19:00:11 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1853D28D07
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 16:00:10 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a3so10125836ejb.3
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 16:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ml68Rjbm2jv1Pw4N7+/TMuVyATAVk8oCCsCtXQ5RxM8=;
        b=Ya4uqE6kNEd5rMY17nxtM+tu14BYNuRSeFq63qe5JVAaBVMQViBJpy2nzF1Dw/im/1
         zrj/dzS6/T/itDetn9FBabf3YEZ4MbftaFciX0a7J4KEiltPBMB0a8lWEzLknPHgkkJk
         QOLxXVog6rvSp3tyM/e2giUGE6Losl+uXCr/RonfYNCoCgX2NA6F9twgI6GdWwgQwQhf
         zW4LijQBw0nxI5y9zeCDRj1/SNb4cOMV/dva9NNZgks+RqW5AHHsDZrHiMgjAkQEiQU8
         yJnVfxs+I0uKMp701h1Cjj5GUXne7NRTA2lVdbpxZF9xhxWet4C6I3LG9ena206NBwxQ
         NxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ml68Rjbm2jv1Pw4N7+/TMuVyATAVk8oCCsCtXQ5RxM8=;
        b=aUSOyRP5/RABu4NX4TifFb3vQkqlQoilIntqT/Xk3Z49bzVr9WkNLCtmsFR86k+GKw
         bqlnE26SlkRVa8h/9hlmRIzfNjTEU5FuvvX/X3LWOlVj4I1cI3IAjREED7craWnGR0wm
         mqhy1Dbq2SxGCyicL9h1DvHelcIpjGfTlyEk65oZbmQQX1qhyCouPAm3cElt+IiXnl05
         Fv0ouRVCADMwWpzG7NuZH29GGwtDFy2DhrcpqxBCFfDU9p/CRSaaN4IpnNBtqXhoW+c4
         o04Uy30vWmed637GdZdM4Pii7QfR0GzxomtL/zTMfmNvj5Xw1dscbIfpAxXuIkEPtCgT
         uU0Q==
X-Gm-Message-State: AO0yUKW7aHcG5N9KrrBU7jCScCO9J8z/REEFkXlVczN1BpfD8D4owhfO
        g6IMEWvlbNbc4+bC/+bupE25m0j0gM7fjWTXg0I=
X-Google-Smtp-Source: AK7set8EjNzUYXDJDFmmlD3ly12jkrDWUtB4am2pXmECRB4M5i8eCFl99Q061x5LZ0X8b9NtEjlnypWFEP6W28V+nI4=
X-Received: by 2002:a17:906:f205:b0:8af:b63:b4ba with SMTP id
 gt5-20020a170906f20500b008af0b63b4bamr138421ejb.3.1676419208438; Tue, 14 Feb
 2023 16:00:08 -0800 (PST)
MIME-Version: 1.0
References: <20230212092715.1422619-4-davemarchevsky@fb.com>
 <202302121936.t36vlAFG-lkp@intel.com> <d04d33ff-0f8f-2bbd-3a67-9b8b813a799b@meta.com>
 <CAKwvOdketskm5z25aPRY7OsBOZe2kzvXV-i9RDTbwcLpZSAT0A@mail.gmail.com>
 <CAADnVQ+qJMAugDDQXaerRbh0g4QdRygMZ_0UVmXViR2aJ4OLDQ@mail.gmail.com>
 <CABCJKucDXNeGCdD6uT7phYhpm+OgYm19EkfCNMB9AJ66k4NcvQ@mail.gmail.com>
 <Y+tupCQ/X38AlvY0@hirez.programming.kicks-ass.net> <CABCJKuc1iqHjg9ERVXMHO00rOqaNGM=d7xTvB4f6fTM4J4-nTA@mail.gmail.com>
In-Reply-To: <CABCJKuc1iqHjg9ERVXMHO00rOqaNGM=d7xTvB4f6fTM4J4-nTA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 14 Feb 2023 15:59:57 -0800
Message-ID: <CAADnVQJz4uCWwLigFUXi-W=fnW-AencgNz52SwKBuDCkzNNMpQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 3/9] bpf: Add bpf_rbtree_{add,remove,first} kfuncs
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 14, 2023 at 2:00 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> On Tue, Feb 14, 2023 at 7:36 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > The other case, which you allude to I think, is control transfer to the
> > JIT'ed code which is currently __nocfi annotated. I've only briefly
> > thought about how to change this, but basically it would entail the JIT
> > emitting the correct prefix bytes and setting the entry point at +16.
> >
> > Given the JIT will only run after we've selected kCFI/FineIBT it knows
> > which form to pick from and can emit the right prefix. Then if we remove
> > the __nocfi annotation from the call into JIT'ed code, everything should
> > work.
> >
> > None of this should be exceptionally hard, but I've not had time to
> > actually do much about it yet.
>
> The dispatcher path shouldn't be terribly hard to fix, but when I
> looked into this briefly half a year ago and ran BPF self-tests with
> CFI enabled, I found a few more places that indirectly call jitted
> code (or trampolines) using a different function pointer type:
>
> https://github.com/ClangBuiltLinux/linux/issues/1727
>
> For some of these, determining the correct type didn't look all that
> simple, but then again, I'm not super familiar with BPF internals.

How is 'kcfi' 32-bit hash computed?
Some kind of hash of type id-s?
Here we'll be dealing with bpf side callbacks with its own types
that are called from the kernel side with its own types.
I don't quite see how clang can come up with the same hashing
algorithm for both.
Also what to do with the situation when kernel is compiled with GCC
while bpf progs are with clang? and the other way around ?
gcc-bpf can compile all of selftests/bpf, but not yet run them.

kcfi is addressing the case when endbr/ibt is not supported by cpu
or some other reason?

btw even for bpf_tail_call we're using direct call most of the time.
Even when bpf progs look like a callback through an indirect call we
are using direct call whenever possible.

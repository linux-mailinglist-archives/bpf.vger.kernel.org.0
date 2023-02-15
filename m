Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE03B69816C
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 17:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjBOQ44 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 11:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjBOQ4z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 11:56:55 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901793646A
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 08:56:53 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id a10so23255790edu.9
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 08:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p1cg1DRRz1JaMZzQz5gjyIGRehXA474aTNt2f/uRSJM=;
        b=IF764ANRJyJU6rYoxIAVp600GErFsJFtOfOrweZTY0EZxhCMGg8kYMwmPB79DFXQX6
         9ksZNgzzzHFUpgOhlMX6VtbAf8ro5CIEfRzIfDEzAVWqFAn/SeZm7jGolFrMEKOxLl0t
         bhEqAp0flrWasbRkAgTP7MO+IBu2OSkWo6rmqVKLcMRz2LXBk8tlOEBtUQPLml9amAZA
         ISxnQEY+DIzlJL0DWbbCDV0OoEnZ2h6nXcefvREEzUZILgTsTwRqiwM+thBauoc1oAUM
         dJEhj+DbMefbj/i9Q87hzP6W+Epk31x8vQEenktbihmSrc1bG62OrLCMvC+/vczz2kVT
         ZI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p1cg1DRRz1JaMZzQz5gjyIGRehXA474aTNt2f/uRSJM=;
        b=YxhbWMIJnmpBSe/WiRJ6zxdG9AT1rGLnfpNbxmDwdjDhkOHTI78UG6MBQb/2odoZxo
         5U8XUbcH469PlH0z1PRxmJ89k+aS4A4lkf3A96DpVL6F605JNmfgct2ag13+6Rv+7pNg
         cSoaRt+hx6nelKE9kVC7BAfCvlVid6Rq+IKJpt6hqRlHKD7KYSygdcXfui9gkbQp28PC
         wE7k6MOnPtHRwfp70j46cIM72qowMMcczB4rdVZb23ehom5gXnbeYPo7riGIfGP0UoeD
         4HwLpNpoHdZi32QMdWDFIUcVhqAIhAQ2VzufybQY+Qo5ukeDS3XpUw049B/SydkBJ9lU
         8zLg==
X-Gm-Message-State: AO0yUKVtnZ550A9AzabLWUXrn4WbzDht3iNsvsv8ZqugA5jlr+l31l0W
        xNCiAkZLW8RcmqUkKMiCyWnDn+RbAbefZT3GWnGUuEhdx3aEAOfy
X-Google-Smtp-Source: AK7set/orVNgERaoDcGFR7X5BTU7TYwffuscXH0ZtL+qYOwGEL8EdaONdtfrxp4hHOSVReHJAO1mKX38bhTMGemL9+M=
X-Received: by 2002:a50:d51a:0:b0:4ac:be68:c0f8 with SMTP id
 u26-20020a50d51a000000b004acbe68c0f8mr1516714edi.5.1676480211799; Wed, 15 Feb
 2023 08:56:51 -0800 (PST)
MIME-Version: 1.0
References: <20230212092715.1422619-4-davemarchevsky@fb.com>
 <202302121936.t36vlAFG-lkp@intel.com> <d04d33ff-0f8f-2bbd-3a67-9b8b813a799b@meta.com>
 <CAKwvOdketskm5z25aPRY7OsBOZe2kzvXV-i9RDTbwcLpZSAT0A@mail.gmail.com>
 <CAADnVQ+qJMAugDDQXaerRbh0g4QdRygMZ_0UVmXViR2aJ4OLDQ@mail.gmail.com>
 <CABCJKucDXNeGCdD6uT7phYhpm+OgYm19EkfCNMB9AJ66k4NcvQ@mail.gmail.com>
 <Y+tupCQ/X38AlvY0@hirez.programming.kicks-ass.net> <CABCJKuc1iqHjg9ERVXMHO00rOqaNGM=d7xTvB4f6fTM4J4-nTA@mail.gmail.com>
 <CAADnVQJz4uCWwLigFUXi-W=fnW-AencgNz52SwKBuDCkzNNMpQ@mail.gmail.com> <Y+ypV+Ninap11QeX@hirez.programming.kicks-ass.net>
In-Reply-To: <Y+ypV+Ninap11QeX@hirez.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 15 Feb 2023 08:56:15 -0800
Message-ID: <CABCJKufd8fnaLYH+Mujq2ijsA40+6+QjDahfFej0=gkEad+ikQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 3/9] bpf: Add bpf_rbtree_{add,remove,first} kfuncs
To:     Peter Zijlstra <peterz@infradead.org>
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

On Wed, Feb 15, 2023 at 1:44 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Feb 14, 2023 at 03:59:57PM -0800, Alexei Starovoitov wrote:
> > How is 'kcfi' 32-bit hash computed?
> > Some kind of hash of type id-s?
>
> Yes. Specifically I think a hash of the C++ name mangled function
> signature. (which is giving pain with eg. Rust because then the C++
> mangling isn't specific enough or somesuch, I'm sure Sami can easily
> find it if you want to know more)

The Rust pain is mostly about type system differences when it comes to
integer types, but we're working on fixing that.

> > Also what to do with the situation when kernel is compiled with GCC
> > while bpf progs are with clang? and the other way around ?
> > gcc-bpf can compile all of selftests/bpf, but not yet run them.
>
> As of yet GCC doesn't support kCFI, so mixing is not possible at
> present. kCFI fundamentally changes the C ABI in incompatible ways.

When it comes to the BPF programs themselves, it shouldn't matter
which compiler you use to compile them as the BPF back-end doesn't
emit CFI instrumentation. I'm also fairly sure that the function type
in the BPF C program doesn't necessarily have to exactly match the
function pointer type used to call the JIT compiled version of that
function in the kernel, and the latter one is what actually matters.

Sami

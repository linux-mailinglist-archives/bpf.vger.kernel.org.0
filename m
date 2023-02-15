Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C857E697939
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 10:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjBOJo0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 04:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbjBOJoU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 04:44:20 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79434ED3
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 01:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aQDu1YFaKb5b0Kremz3dWSYLo+xqI+o4S2j4E0VWVh4=; b=d94kZGUDVH4uDIo9iqVLlz+ixy
        NzLRG4R0E3gLp/01xQuv4Qf4bn4NdaB6xAxKUwi7W/jeVqIgyrY3OxcNVdzrMYhp11dvOCEKmFfr2
        YsZGIW2YpdfulGr8BJz3RPjZLNtyWnz1QHw/EK0sbVlkM5Dd44eqqtW+fV94a7/AIDz8NmvUGAuW9
        pU2TMzzk1tTGp0uDSL9IjP/O+dlbJIxdtoN6XBOvhINhDJR6JeIAW77kp9Xl7/WSyiEIfC/3rZljY
        60s4Y0vcHYAz9dGJi9EDJtXgNNODh1O8UTRzNGJlHOc1OR+lF0pPOb8y0Ekbaepi1Vc9sjFtKy2KN
        A6HrPWhQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pSEJi-009uVG-2a;
        Wed, 15 Feb 2023 09:43:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 201E83001E7;
        Wed, 15 Feb 2023 10:43:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 07F1C233D4DE5; Wed, 15 Feb 2023 10:43:52 +0100 (CET)
Date:   Wed, 15 Feb 2023 10:43:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
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
Message-ID: <Y+ypV+Ninap11QeX@hirez.programming.kicks-ass.net>
References: <20230212092715.1422619-4-davemarchevsky@fb.com>
 <202302121936.t36vlAFG-lkp@intel.com>
 <d04d33ff-0f8f-2bbd-3a67-9b8b813a799b@meta.com>
 <CAKwvOdketskm5z25aPRY7OsBOZe2kzvXV-i9RDTbwcLpZSAT0A@mail.gmail.com>
 <CAADnVQ+qJMAugDDQXaerRbh0g4QdRygMZ_0UVmXViR2aJ4OLDQ@mail.gmail.com>
 <CABCJKucDXNeGCdD6uT7phYhpm+OgYm19EkfCNMB9AJ66k4NcvQ@mail.gmail.com>
 <Y+tupCQ/X38AlvY0@hirez.programming.kicks-ass.net>
 <CABCJKuc1iqHjg9ERVXMHO00rOqaNGM=d7xTvB4f6fTM4J4-nTA@mail.gmail.com>
 <CAADnVQJz4uCWwLigFUXi-W=fnW-AencgNz52SwKBuDCkzNNMpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJz4uCWwLigFUXi-W=fnW-AencgNz52SwKBuDCkzNNMpQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 14, 2023 at 03:59:57PM -0800, Alexei Starovoitov wrote:
> How is 'kcfi' 32-bit hash computed?
> Some kind of hash of type id-s?

Yes. Specifically I think a hash of the C++ name mangled function
signature. (which is giving pain with eg. Rust because then the C++
mangling isn't specific enough or somesuch, I'm sure Sami can easily
find it if you want to know more)

> Here we'll be dealing with bpf side callbacks with its own types
> that are called from the kernel side with its own types.

As long as there's a kernel side function declaration (definition not
required) the compiler will generate you a usable __kcfi_typeid_##name
symbol that contains the hash.

If it is a pure BPF internal (C never sees either the declaration of
definition) then it doesn't matter and you can make up your own scheme
as long as caller and callee agree on the magic number.

> Also what to do with the situation when kernel is compiled with GCC
> while bpf progs are with clang? and the other way around ?
> gcc-bpf can compile all of selftests/bpf, but not yet run them.

As of yet GCC doesn't support kCFI, so mixing is not possible at
present. kCFI fundamentally changes the C ABI in incompatible ways.

Ideally the GCC implementation of kCFI (when it happens) will use the
same hashing scheme as LLVM so that mutual compatibility is possible.

> kcfi is addressing the case when endbr/ibt is not supported by cpu
> or some other reason?

kCFI/FineIBT are supplementary to regular IBT. kCFI works regardless of
hardware support, but the same infrastructure is employed with FineIBT
to provide more fine-gained target control.

Specifically, with bare IBT all that is required is the indirect target
be an ENDBR instruction, *any* ENDBR instruction.

The kCFI/FineIBT improvement over that is that caller and callee need to
agree on the hash, thereby further limiting which functions can be
called.

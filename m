Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1FE349EC5C
	for <lists+bpf@lfdr.de>; Thu, 27 Jan 2022 21:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343960AbiA0USL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jan 2022 15:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343953AbiA0USL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Jan 2022 15:18:11 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692BCC061714
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 12:18:11 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id d5so4184386pjk.5
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 12:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JRztxCEXRkYqVcx8cR6KmBrcEp0VUsVgPz7qryXQ21Q=;
        b=dVxPohU2MJ2aB1MFJWyRhVBYqpa3sIz/KWenfSPBc2BY4Shm5NyNn+0U6kJ5m0WUJ/
         9cKDHLqEwBCTct05VyUsh0g/4Gt7daW+KlPsGHwPA9SzQS7j4PDp6npNhNYbr/fzD3dX
         4N7FWi4mb8pX1PrNdfPk7f/gai41nzJ7+Gm3/bMgN/Jn2R7AZ+HN9P2a81wVyVMHE0c+
         BGhn8xPHJMjmiZZTL3Muf8Nx+93DK2ReEmEYpWwsfagzaQD5Wzw6b7nzVdEXPSOtFlL1
         eZM6lLgWLde2EzNiqbofuGr6ZAyMUGRRgp8rvwcbuHqTYiKAxXxT6T5+weSUU7D02uCE
         EgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JRztxCEXRkYqVcx8cR6KmBrcEp0VUsVgPz7qryXQ21Q=;
        b=ZnQs6zZR9HjuYFqAglOEfqeY7OkZ1QNAQ/VCJ3Jz7gdQqvHaVAAp0LgmEKKuSHTZ1z
         1DR+i9K+z3NETbbSGX9kYklqY99yyfk4UYjLMjRCG2eo840/nrnOjd+oNA1DzhfBZ5fS
         vqy5VHc6pFrBHZ9IZqpeU7UhtmbwiULXlx1YzGVH1TkCveD+aGdg+rpTYFW0rpZw4pgZ
         0qqjMSbdORJB2lqFi5LuZb1uo/opmxYJzJaYYayPwATuCFfKxZhXl0zqXSYZd9u4anrX
         ybL4zdUtywjB1rU75KH1iXZU+1Skga9Pk4+Lo2uo42+cVifq5GtspfsKNaxIGLtMLSMX
         tV+Q==
X-Gm-Message-State: AOAM5310glJ+m+3n8n2mSVFb8hv+02p09whFXAMxM2Eb+4mNhlg5EFKD
        Yw8s42TIdgMZI5GHRmvutCGI2y7lXJB/cJDuzlk=
X-Google-Smtp-Source: ABdhPJz9rtHGV2h+2+bHSAtVZICYJIo/k/uswrrjwkd5G0KaNOOGbkw5B7rnXdymspPvTk1WeKKJRsgg7QBupzqQvTA=
X-Received: by 2002:a17:902:b682:: with SMTP id c2mr4673082pls.126.1643314690821;
 Thu, 27 Jan 2022 12:18:10 -0800 (PST)
MIME-Version: 1.0
References: <20220127154555.650886-1-yhs@fb.com>
In-Reply-To: <20220127154555.650886-1-yhs@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 27 Jan 2022 12:17:59 -0800
Message-ID: <CAADnVQLWL5Dx00FJGdQ6BgsAYW1p4bJ=juLNk4-uk+oe-f9Mcg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/6] bpf: add __user tagging support in
 vmlinux BTF
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Kernel Team <kernel-team@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 27, 2022 at 7:46 AM Yonghong Song <yhs@fb.com> wrote:
>
> The __user attribute is currently mainly used by sparse for type checking.
> The attribute indicates whether a memory access is in user memory address
> space or not. Such information is important during tracing kernel
> internal functions or data structures as accessing user memory often
> has different mechanisms compared to accessing kernel memory. For example,
> the perf-probe needs explicit command line specification to indicate a
> particular argument or string in user-space memory ([1], [2], [3]).
> Currently, vmlinux BTF is available in kernel with many distributions.
> If __user attribute information is available in vmlinux BTF, the explicit
> user memory access information from users will not be necessary as
> the kernel can figure it out by itself with vmlinux BTF.
>
> Besides the above possible use for perf/probe, another use case is
> for bpf verifier. Currently, for bpf BPF_PROG_TYPE_TRACING type of bpf
> programs, users can write direct code like
>   p->m1->m2
> and "p" could be a function parameter. Without __user information in BTF,
> the verifier will assume p->m1 accessing kernel memory and will generate
> normal loads. Let us say "p" actually tagged with __user in the source
> code.  In such cases, p->m1 is actually accessing user memory and direct
> load is not right and may produce incorrect result. For such cases,
> bpf_probe_read_user() will be the correct way to read p->m1.
>
> To support encoding __user information in BTF, a new attribute
>   __attribute__((btf_type_tag("<arbitrary_string>")))
> is implemented in clang ([4]). For example, if we have
>   #define __user __attribute__((btf_type_tag("user")))
> during kernel compilation, the attribute "user" information will
> be preserved in dwarf. After pahole converting dwarf to BTF, __user
> information will be available in vmlinux BTF and such information
> can be used by bpf verifier, perf/probe or other use cases.
>
> Currently btf_type_tag is only supported in clang (>= clang14) and
> pahole (>= 1.23). gcc support is also proposed and under development ([5]).
>
> In the rest of patch set, Patch 1 added support of __user btf_type_tag
> during compilation. Patch 2 added bpf verifier support to utilize __user
> tag information to reject bpf programs not using proper helper to access
> user memories. Patches 3-5 are for bpf selftests which demonstrate verifier
> can reject direct user memory accesses.
>
>   [1] http://lkml.kernel.org/r/155789874562.26965.10836126971405890891.stgit@devnote2
>   [2] http://lkml.kernel.org/r/155789872187.26965.4468456816590888687.stgit@devnote2
>   [3] http://lkml.kernel.org/r/155789871009.26965.14167558859557329331.stgit@devnote2
>   [4] https://reviews.llvm.org/D111199
>   [5] https://lore.kernel.org/bpf/0cbeb2fb-1a18-f690-e360-24b1c90c2a91@fb.com/
>
> Changelog:
>   v2 -> v3:
>     - remove FLAG_DONTCARE enumerator and just use 0 as dontcare flag.
>     - explain how btf type_tag is encoded in btf type chain.

Applied. Thanks

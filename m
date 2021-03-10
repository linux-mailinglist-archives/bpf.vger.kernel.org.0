Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2474B3348E1
	for <lists+bpf@lfdr.de>; Wed, 10 Mar 2021 21:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhCJU0e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Mar 2021 15:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhCJU0B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Mar 2021 15:26:01 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F11AC061574;
        Wed, 10 Mar 2021 12:26:01 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id p186so19281793ybg.2;
        Wed, 10 Mar 2021 12:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ONufA5MfqwwxL6Ms/dM+N1X8h2zLIoC9I/XMghgTWzo=;
        b=ooVsfrRNF0h2YbIH2/C3sE+h9AFoh1F6bcJU6wUL8jSPizyRtXAX3aPQn66g2xehA7
         Q/GuV92CURL/Z9PBmxVMHtffev+uckrZ9L2bQt7QdY60x9DfZtktVEvUXKEHaiSIyvHY
         p3e+D9dsL3TlOLm4Gn3kGmLEGmQseKniGTI0QEK0S0TSA04RNMHBm9hZrMiozYGhFpKl
         TmMEPJREs+f2QSQrq/ZReMYF/a7U5hoKkrUUbX3UJMAqaLFFWnPh7IygTVYDkprU15ZP
         h+vm9X7mTe5M/M7PUWu8syikuX5MWzD94vq6P2lH9kuZzWACTwF0bkZrvxZn3pOI533i
         ruXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ONufA5MfqwwxL6Ms/dM+N1X8h2zLIoC9I/XMghgTWzo=;
        b=bvB/wADqiOx+4VLkls1CZwKocF6whRTctt9q2CIYiMkpcJDxXm2hS8tI60RPF/vu8K
         Y6r3ImppK9Fn/eAt1vBHOEAz5d6ZxZzWp7JcLNNcs0pYIWa3Cmx+idRBuwjZ8GDvX0ES
         TAnWkZKE1bTVAosUxChL6r9EBwl2NIFZv6xsm2eZyltgy+7Hy6FGZ3GnfKXkYEu6mlt9
         OMOTM12dUR0tqZsFIkcAhFbtol8V0D/cVTK1omcdgujBZ3jlT7RalIDS/OfaEFfamcxP
         OnsicbJzR9LOGiCamT0IJFdXxYkmzTY6iq5vg4T/9J4kYcd4ZBRFMVby2rED6MyOQ4gq
         05Sw==
X-Gm-Message-State: AOAM531GVwfFq/dE8igH5gTuOpHersD1SNG3fKRr6qBv26kvdOr0Rxp6
        nV8ObrDTMUzKUp/VDaUR3uub4pgeQPqgyh8+HyY=
X-Google-Smtp-Source: ABdhPJyH1L+L4u+pwy9n8pOOWvxtrNq+cx3ENraKN9zVzP4hvtIqplVA9t2cYKFTWnqsd68E4wZlU6TYcHF+mQ2sEGA=
X-Received: by 2002:a25:7d07:: with SMTP id y7mr6509181ybc.425.1615407960310;
 Wed, 10 Mar 2021 12:26:00 -0800 (PST)
MIME-Version: 1.0
References: <20210310201550.170599-1-iii@linux.ibm.com>
In-Reply-To: <20210310201550.170599-1-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 10 Mar 2021 12:25:49 -0800
Message-ID: <CAEf4BzY0++YuU7+a3vSfWWZNLoov7mu7Q1ty4FqqH78gkqgqQw@mail.gmail.com>
Subject: Re: [PATCH v4 dwarves] btf: Add support for the floating-point types
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 10, 2021 at 12:16 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> Some BPF programs compiled on s390 fail to load, because s390
> arch-specific linux headers contain float and double types.
>
> Fix as follows:
>
> - Make the DWARF loader fill base_type.float_type.
>
> - Introduce the --btf_gen_floats command-line parameter, so that
>   pahole could be used to build both the older and the newer kernels.
>
> - libbpf introduced the support for the floating-point types in commit
>   986962fade5, so update the libbpf submodule to that version and use
>   the new btf__add_float() function in order to emit the floating-point
>   types when not in the compatibility mode.
>
> - Make the BTF loader recognize the new BTF kind.
>
> Example of the resulting entry in the vmlinux BTF:
>
>     [7164] FLOAT 'double' size=8
>
> when building with:
>
>     LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1} --btf_gen_floats
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---

So it looks good to me overall, but here's the question about using
this --btf-gen-floats flag from link-vmlinux.sh script. If you specify
that flag for an old pahole, it will probably error out, right? So
that means we'll need to do feature detection for pahole supported
features, right?..

>
> v1: https://lore.kernel.org/dwarves/20210306022203.152930-1-iii@linux.ibm.com/
> v1 -> v2: Introduce libbpf compatibility level command-line parameter.
>           The code should now work for both bpf-next/master and
>           v5.12-rc2.
>
> v2: https://lore.kernel.org/dwarves/20210308235913.162038-1-iii@linux.ibm.com/
> v2 -> v3: Use the feature flag (--encode_btf_kind_float) instead of the
>           libbpf version flag.
>
> v3: https://lore.kernel.org/dwarves/20210310141517.169698-1-iii@linux.ibm.com/
> v3 -> v4: Rename the flag to --btf_gen_floats.
>
>  btf_loader.c       | 21 +++++++++++++++++++--
>  dwarf_loader.c     | 11 +++++++++++
>  lib/bpf            |  2 +-
>  libbtf.c           | 36 ++++++++++++++++++++++++++++++++++--
>  libbtf.h           |  1 +
>  man-pages/pahole.1 |  5 +++++
>  pahole.c           |  8 ++++++++
>  7 files changed, 79 insertions(+), 5 deletions(-)
>

[...]

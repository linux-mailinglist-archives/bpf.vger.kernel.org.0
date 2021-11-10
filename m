Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F4844C536
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 17:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhKJQnY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Nov 2021 11:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhKJQnX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Nov 2021 11:43:23 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED175C061764
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 08:40:35 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id x7so1979932pjn.0
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 08:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WtDXkkLfhJJlvz1TWqE/UZEbVzfp3rsbDHExotldUto=;
        b=MO42zaXuhkKwvA9c6fhFGooJT7CxGixPyFctB2/zCN+jZqBxUoO1rSLL9ADpezAXDG
         QLSuUcS0qNkztt80+CFS1/9nvXijTi8qniksQXMCRrHi03SNnKE4SqAbdVUqX9EbIXLG
         vVZJsL0+gxi+Q2oyo12HlV7IA+JIA1ppXg5RWRn51Al5iwq0AfHAxWPbzPekS4XwSdhj
         yZbPKIUelhizzEbKhvLS+eerBkFUNZ5zeSC63gFvXUrLJz+ymcNKJbdBAQdy1ZBrVJaP
         mqD6Kr3fol9Hf5/5ZZjgf2PV43kQDaMD6ISkLqMfOltPubZV6XzO0bzBp94duOA+1tIs
         O76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WtDXkkLfhJJlvz1TWqE/UZEbVzfp3rsbDHExotldUto=;
        b=G3emWf9wbGtHMp3P1pmgEkT9zn2JGGwNgH7AhFwXlC8DE7pCKpMaqY4TQDr6nLMBWZ
         sld1sQJ6imdCKMG16EDphZJMpeaxupOKh2LR8JZr8OULl7CHVRb5z5YycduM6xIj/YYh
         Ab54GxFB0hnX+YedQ0Y7nAYUKv9lsHqFwml9EWSLtnx2cquQnwVnrPDNpdtdFLkJZhgK
         msEYWNaqNuFboDFACAnK409NO5tq38xzwUUkqOpma6rKjXMouvroIkJ1etoZu10yNKZ3
         UeMxweLFq1x9IhJggtW5yujBCWCqMZXNoeyDcryEcOjvfeUWc9OYTE5wftCS3Ew1G4Im
         vQpQ==
X-Gm-Message-State: AOAM53262ZJaDB8N6N43GNtXPvcI0HqGpTealM5xaxIdQWBUpbxPr2vR
        NZoOVklMAtU4UNpoEJ3mqrlszFn4p46JcxlGgOA=
X-Google-Smtp-Source: ABdhPJzromnj9V0CSjlWuxXhmGl5OThvR128yoCKECK7oYNdO1Q6KGkNfHUHWh4dO/08c4OUB/0f5jmsmyGr3QmbVAo=
X-Received: by 2002:a17:902:d491:b0:142:892d:a89 with SMTP id
 c17-20020a170902d49100b00142892d0a89mr344322plg.20.1636562435354; Wed, 10 Nov
 2021 08:40:35 -0800 (PST)
MIME-Version: 1.0
References: <20211110051940.367472-1-yhs@fb.com> <20211110052805.qds3qzhabhdr3ah4@ast-mbp.dhcp.thefacebook.com>
 <d2546d58-67ee-0aee-5741-113f0583365b@fb.com>
In-Reply-To: <d2546d58-67ee-0aee-5741-113f0583365b@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 10 Nov 2021 08:40:24 -0800
Message-ID: <CAADnVQLeW3s2Dx8+t8ajt=H3r-r8x40wFF18ia+wMbv6WYqdnw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/10] Support BTF_KIND_TYPE_TAG for btf_type_tag attributes
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 9, 2021 at 10:26 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 11/9/21 9:28 PM, Alexei Starovoitov wrote:
> > On Tue, Nov 09, 2021 at 09:19:40PM -0800, Yonghong Song wrote:
> >> LLVM patches ([1] for clang, [2] and [3] for BPF backend)
> >> added support for btf_type_tag attributes. This patch
> >> added support for the kernel.
> >>
> >> The main motivation for btf_type_tag is to bring kernel
> >> annotations __user, __rcu etc. to btf. With such information
> >> available in btf, bpf verifier can detect mis-usages
> >> and reject the program. For example, for __user tagged pointer,
> >> developers can then use proper helper like bpf_probe_read_kernel()
> >> etc. to read the data.
> >
> > +#define __tag1 __attribute__((btf_type_tag("tag1")))
> > +#define __tag2 __attribute__((btf_type_tag("tag2")))
> > +
> > +struct btf_type_tag_test {
> > +       int __tag1 * __tag1 __tag2 *p;
> > +} g;
> >
> > Can we build the kernel with the latest clang and get __user in BTF ?
>
> Not yet. The following are the steps:
>    1. land this patch set in the kernel
>    2. sync to libbpf repo.
>    3. pahole sync with libbpf repo, and pahole convert btf_type_tag
>       in llvm to BTF
>    4. another kernel patch to define __user as
>       __attribute__((btf_type_tag("user")))
> and then we will get __user in vmlinux BTF.

Makes sense. I was wondering whether clang can handle
the whole kernel source code with
#define __user __attribute__((btf_type_tag("user")))
Steps 1,2,3 are necessary to make use of it,
but step 4 can be tried out already?

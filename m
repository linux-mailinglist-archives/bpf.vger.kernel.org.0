Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB0C1FAABB
	for <lists+bpf@lfdr.de>; Tue, 16 Jun 2020 10:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgFPIGL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Jun 2020 04:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgFPIGK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Jun 2020 04:06:10 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFE1C05BD43
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2020 01:06:09 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id l27so20527443ejc.1
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2020 01:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CYPGUpnPlNHV5xdesZl/CopvXoMDZYoV0KFV4/fJquM=;
        b=Q9q47H/Te5UUUO6K0hadi62+rjXSP+ZpCoTIut5wiviBYXIOLGZAlwU3pBLgnZoSoW
         dNdqL+AVAgaoYNo6eEqw2hNvcuJYNcwsKnD/2Nt2al+eA8zmKQiKbMAyzr2ZD2+Ud235
         +p+6qlksH3FXFxRZI3faglpSa+S/rW0EhzjXL2r9elyHMWr2CHaTrmXLCDdWgqTjDrMZ
         DGuGEXM9emG2yvBPmz9Mhwrt0gvvBXtiTICOANFUwxowBvrWOllVnJCHZBIRMQmX6hZ2
         iosJzNrrxSrDyHgFWRja19QmRSbrK5B2CyNqZUrz+bK8OcLxAX3AFpkRTxnN9iQoExVs
         oibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CYPGUpnPlNHV5xdesZl/CopvXoMDZYoV0KFV4/fJquM=;
        b=lkrMtyBPoyZUZL4AKB6ThuK0o4H7jJNTI7N500FYjBjYOjlaJ9YqXGmdVmQbbMYxb3
         h/M5udTnwj8zug6Y3nTNNNMv3SaB3Jr6ZhyeL6urZXU2TGtY42qUynFRbd/fwNRT0DFT
         JGvKbXlOGvk9T4JfjRaXK5viI16Fy4Viw0iziK1lDkGmExCKBM8XjVjjgTuNSEbZQo2/
         g3Ep7aUJpk4RT9RJ9Y+m+hPXFb2k+eM52331sTymQQm8iMtupWy7KpOl7zIod1IWP4tw
         Bp8YlpoqwsbpXgmkvqaGyksLM9TSpB8bDJQxmWxysChUilgm0fK1CtbMwvOYf1+jKk8x
         Pf6Q==
X-Gm-Message-State: AOAM531J79+o4l2VnS1BjOwF5iWmI0DZEl35B5FSiOSktkFbrRL15cl6
        OSF2pj8CvseisBx7Z3J4wL/oiV5PzDXvHJluCk+7mQ==
X-Google-Smtp-Source: ABdhPJw1F4BEgMOzwzqu3CwWQkTWRL6wybcrPz1vU/ttTpFLsrmNRMaYrcvdeSXqanvV4y/bnxQr8HOxTjfw/uxhhLU=
X-Received: by 2002:a17:906:a385:: with SMTP id k5mr1735383ejz.44.1592294767970;
 Tue, 16 Jun 2020 01:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200612223150.1177182-1-andriin@fb.com> <20200612223150.1177182-3-andriin@fb.com>
 <CA+khW7hFZzp_K_xydSFw0O3LYB22_fC=Z4wG7i9Si+phGHn4cQ@mail.gmail.com> <CAEf4BzYVY-sA_SRqxr-dxrkR5DPW6tv3tnNonK=4WPx6eEiZFQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYVY-sA_SRqxr-dxrkR5DPW6tv3tnNonK=4WPx6eEiZFQ@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 16 Jun 2020 01:05:56 -0700
Message-ID: <CA+khW7iU4oT3N2fYK6ym7XtWAnyD4fmiMpkuNybrJSROJeuk8A@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/8] libbpf: add support for extracting
 kernel symbol addresses
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 15, 2020 at 12:08 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Jun 15, 2020 at 9:44 AM Hao Luo <haoluo@google.com> wrote:
> >
> > Thanks, Andrii,
> >
> > This change looks nice! A couple of comments:
> >
> > 1. A 'void' type variable looks slightly odd from a user's perspective. How about using 'u64' or 'void *'? Or at least, a named type, which aliases to 'void'?
>
> That choice is very deliberate one. `extern const void` is the right
> way in C language to access linker-generated symbols, for instance,
> which is quite similar to what the intent is her. Having void type is
> very explicit that you don't know/care about that value pointed to by
> extern address, the only operation you can perform is to get it's
> address.
>
> Once we add kernel variables support, that's when types will start to
> be specified and libbpf will do extra checks (type matching) and extra
> work (generating ldimm64 with BTF ID, for instance), to allow C code
> to access data pointed to by extern address.
>
> Switching type to u64 would be misleading in allowing C code to
> implicitly dereference value of extern. E.g., there is a big
> difference between:
>
> extern u64 bla;
>
> printf("%lld\n", bla); /* de-reference happens here, we get contents
> of memory pointed to by "bla" symbol */
>
> printf("%p\n", &bla); /* here we get value of linker symbol/address of
> extern variable */
>
> Currently I explicitly support only the latter and want to prevent the
> former, until we have kernel variables in BTF. Using `extern void`
> makes compiler enforce that only the &bla form is allowed. Everything
> else is compilation error.
>

Ah, I see. I've been taking the extern variable as an actual variable
that contains the symbol's address, which is the first case. Your
approach makes sense. Thanks for explaining.

> > 2. About the type size of ksym, IIUC, it looks strange that the values read from kallsyms have 8 bytes but their corresponding vs->size is 4 bytes and vs->type points to 4-byte int. Can we make them of the same size?
>
> That's a bit of a hack on my part. Variable needs to point to some
> type, which size will match the size of datasec's varinfo entry. This
> is checked and enforced by kernel. I'm looking for 4-byte int, because
> it's almost guaranteed that it will be present in program's BTF and I
> won't have to explicitly add it (it's because all BPF programs return
> int, so it must be in program's BTF already). While 8-byte long is
> less likely to be there.
>
> In the future, if we have a nicer way to extend BTF (and we will
> soon), we can do this a bit better, but either way that .ksyms DATASEC
> type isn't used for anything (there is no map with that DATASEC as a
> value type), so it doesn't matter.
>

Thanks for explaining, Andrii.

These explanations as comments in the code would be quite helpful, IMHO.

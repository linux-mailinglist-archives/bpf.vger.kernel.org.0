Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB50417E55
	for <lists+bpf@lfdr.de>; Sat, 25 Sep 2021 01:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhIXXhW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Sep 2021 19:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343603AbhIXXhW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Sep 2021 19:37:22 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EA9C061571
        for <bpf@vger.kernel.org>; Fri, 24 Sep 2021 16:35:48 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id m70so9207142ybm.5
        for <bpf@vger.kernel.org>; Fri, 24 Sep 2021 16:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q1f1F0R526VS8IGNctXa3uHzJyCZrFgOJFnk72iks0s=;
        b=Vqle47wG+aP+ERI9e0ilWIyo0Mfbzr7oN1PPOyjxrtpTCD2nuaOFexcu8klFn267ZY
         50kH9feRxBozHIb+IBNjA/zvW9HEMPck7zihaa870iOCHK6oIT0pyBhFSfA4P1b8OZa3
         tYQdulbgE1mBm6l7kWeQgLJBi5VkC7gHsp7m8rfYbeI71JRmsTjjDLHuwR1F06AmivoG
         U6zPyXFqPL3UVUecTKGT6bFoL5irQMbUQcnV7rM0xjrwaXHvjs1AezZXEFKSb7TQcOao
         bBn3JyLQA7BugemEfoGcL02TednXbv0WmQNS3cso4TOoe9BbE2f2Hr3TLn2mDBCGssV4
         Udeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q1f1F0R526VS8IGNctXa3uHzJyCZrFgOJFnk72iks0s=;
        b=5l/WwH7/4RXWvHvOXIu/UA9H0knftljm6DGinusWblLOtBqB9oOd79ewUezilitDRo
         3f5FZRbDuWuz2Mo/1Q/8GnGedqu8bF/ZYKV6bg5ohlE943fj0sxoQlMTLmJ9A0goOuF5
         ZJsw48zLGPjo7XTppwPnhOoD1qEWom1JzjGFcwXaGGfZG17UOvyaufj+3kZUO3wg0JXO
         CrPrOmDr6r+haBtcilJelBBUHphDG46ROdozOCbGlDWKS7rvA2bqCuMTqyPjdW9B+1IP
         402zQ2KLD9PRa6GmhV3V2obqUgZOBxWGG/sIzgfw7qUjFznwCvpU49D3d+nh22xT8NcP
         730g==
X-Gm-Message-State: AOAM530/tTvhcNOnoicv9ok9v0NDXq7d52uoHEyMrUIcKb6f65A1UDXS
        Q2eGhapSQRqKPxVkeNDlmbrzQZVw51bAnIrCLIXI1NYI
X-Google-Smtp-Source: ABdhPJzGXfu+0VV0opjtkSoMADdozq+z3JZTosKD5hN+0D/apVy4YsNHxeetwNw5LA8miwMYUGoT6BokJNKtoDfGkyI=
X-Received: by 2002:a25:1884:: with SMTP id 126mr15852201yby.114.1632526548236;
 Fri, 24 Sep 2021 16:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210924023725.70228-1-memxor@gmail.com>
In-Reply-To: <20210924023725.70228-1-memxor@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 24 Sep 2021 16:35:37 -0700
Message-ID: <CAEf4BzbzeX4XvSvGNp4S=5secgRMma7=FGAFTvP+tP6HeRdzPQ@mail.gmail.com>
Subject: Re: [PATCH bpf] libbpf: Fix segfault in static linker for objects
 without BTF
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 23, 2021 at 7:39 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> When a BPF object is compiled without BTF info (without -g),
> trying to link such objects using bpftool causes a SIGSEGV due to
> btf__get_nr_types accessing obj->btf which is NULL. Fix this by
> checking for the NULL pointer, and return error.
>
> Reproducer:
> $ cat a.bpf.c
> extern int foo(void);
> int bar(void) { return foo(); }
> $ cat b.bpf.c
> int foo(void) { return 0; }
> $ clang -O2 -target bpf -c a.bpf.c
> $ clang -O2 -target bpf -c b.bpf.c
> $ bpftool gen obj out a.bpf.o b.bpf.o
> Segmentation fault (core dumped)
>
> After fix:
> $ bpftool gen obj out a.bpf.o b.bpf.o
> libbpf: failed to find BTF info for object 'a.bpf.o'
> Error: failed to link 'a.bpf.o': Unknown error -22 (-22)
>
> Fixes: a46349227cd8 (libbpf: Add linker extern resolution support for functions and global variables)
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  tools/lib/bpf/linker.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>

Applied to bpf, thanks.

[...]

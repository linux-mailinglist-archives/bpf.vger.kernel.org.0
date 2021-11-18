Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 518DE4565C9
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 23:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbhKRWma (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 17:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbhKRWma (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Nov 2021 17:42:30 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D91C061574
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 14:39:29 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id v64so22610083ybi.5
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 14:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ccC/K4H1VoL2Ge0Ae32TLp83ekKe+WlIXZqkGc3TxbI=;
        b=a5I6JqMQW7sJzsBI9/P8ne6krJZsyHNvI1DAyO8eEsvw7WF3UXNuahQjjhjP+CxWyF
         V781j+3tJSiHPu5j+7Gn5KYQGac3yjP3Pv+ExY4ZVTRQFttTUN4UH+5wrHResIqRJ/8E
         VaFFNCrH4/Gxw0nUe/jWXZNdV9x/9SloMwImkGxar6Fmu4Mqr3TPzpeGTU+7FxSE1Tae
         VqmUzJwzx9c6p792Wob9uZFe6/W3S3c7+f424aMipoAxnQbh8iyx+O01/XsuEqIA4t26
         8oUsecbkDYwg7GOrMnki8KlwkZYHfH1KIEKm1MSzfpfaoZxVsKMr4n+eDNZhH2MFVqDu
         OZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ccC/K4H1VoL2Ge0Ae32TLp83ekKe+WlIXZqkGc3TxbI=;
        b=POhIcudv2c+FosGZ61tZvduOItKvRUtyy1Xz7GrdIfuytp6T071nVMJjhs7icUr9mS
         XQg6SHKEK5StaO5zNWCM3SWvKHPwS2v21grAxrmFCUz5YR+JldT04kU/l3MN58n5+Rq3
         ZBTPqKc1IlNw2MHWxybS9Clq6g3WRq4ufpL3kzUrsz3B9xZgikbtCxLuKw8vzgA37YIC
         MeTAXLwb+lFlVtu1BkWkK0uBl1B4+fki0oeJY+SJnS9FLJukDR8B1U9ceCYk4xEfY80P
         UTO254iDxkHBnI6pnR5obtkcfminM/LGaR7HpIgFqdBe8//GJn08KhMlrwqrYOlN+X68
         hzPA==
X-Gm-Message-State: AOAM533j8QrXsG+30xGTJyTSJShGLmpweHFrXL5OeXwniWDjsO/QE8bd
        BpUJG5uWzRiNBMu0t9CRT5/1Dl/iinIAAWKVL/Lf76eB
X-Google-Smtp-Source: ABdhPJyJZKWq+bK7wf/AYv4tI9yliAqYPmHvwNrfc6iVgs5TUVY4sITSiIwnq4rboJmLrVyHmfUcAQAMF5d7ni/NhSg=
X-Received: by 2002:a25:d16:: with SMTP id 22mr31499988ybn.51.1637275168820;
 Thu, 18 Nov 2021 14:39:28 -0800 (PST)
MIME-Version: 1.0
References: <CAK-59YFPU3qO+_pXWOH+c1LSA=8WA1yabJZfREjOEXNHAqgXNg@mail.gmail.com>
In-Reply-To: <CAK-59YFPU3qO+_pXWOH+c1LSA=8WA1yabJZfREjOEXNHAqgXNg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 18 Nov 2021 14:39:17 -0800
Message-ID: <CAEf4BzZM480NkS+At2Cb=mJaj1FowgUTbepp5QPreXXDriTBLg@mail.gmail.com>
Subject: Re: Custom 'hello' BPF CO-RE example failed on Debian 10 again for
 some reason
To:     Pony Sew <poony20115@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 15, 2021 at 1:48 AM Pony Sew <poony20115@gmail.com> wrote:
>
> Hello,
> This (https://github.com/sartura/ebpf-core-sample) is the code I'm using.
> But I add " #define BPF_NO_GLOBAL_DATA 1 " on 'hello.bpf.c' so that
> Debian 10 is able to execute it.
> Compiled on default Debian11 amd64 environment with clang package
> installed from mirror source.
> Both 'hello' and 'maps' used to work on Debian10 about a month ago.
> But 'hello' now can't. I'd like to improve this result.
> -----------------------------------------------------------------------------------------
> This is how I compiled them in steps:
>
> # bpftool btf dump file /sys/kernel/btf/vmlinux format c > vmlinux.h
> # clang -g -O2 -target bpf -D__TARGET_ARCH_x86_64 -I . -c hello.bpf.c -o
> # hello.bpf.o
> # bpftool gen skeleton hello.bpf.o > hello.skel.h
> # clang -g -O2 -Wall -I . -c hello.c -o hello.o
> # git clone https://github.com/libbpf/libbpf
> # cd libbpf/src
> # make BUILD_STATIC_ONLY=1 OBJDIR=../build/libbpf DESTDIR=../build
> INCLUDEDIR= LIBDIR= UAPIDIR= install
> # cd ../../
> # clang -Wall -O2 -g hello.o libbpf/build/libbpf.a -lelf -lz -o hello
>
> There was only one warning message: "libbpf: elf: skipping
> unrecognized data section(4) .rodata.str1.1", which appeared during
> the generation of 'hello.skel.h'. There are no other warning and error
> messages during this whole 'hello' and 'maps' compilation.
> -------------------------------------------------------------------------------------------------------------------
> Result of executing 'hello' on default amd64 Debian10 environment:
>
> libbpf: kernel doesn't support global data

Sorry for the late reply, I didn't ignore or forget, I was trying to
come up with the best solution.

In short, I suspect it's because of the recent libbpf feature to
support multiple .rodata.* sections. In your case, kernel is old and
doesn't support those special maps, but Clang actually sometimes emits
unused .rodata.strN.M sections. No code is referencing them, yet
compiler stubbornly emits them. After recent changes libbpf will try
to create a map for such sections which is causing "kernel doesn't
support global data" error.

I think I'm going to teach libbpf to recognize such maps that are not
referenced from BPF program code and not create them, if kernel
doesn't support global data. Will need to see how to do it in the
least intrusive way, but I'm going to solve this before official 0.6
release.

Thanks for reporting. Stay tuned for the solution.

> libbpf: failed to load object 'hello_bpf'
> libbpf: failed to load BPF skeleton 'hello_bpf': -95
> failed to load BPF object -95
> -------------------------------------------------------------------------------------------------------------------
> From what I can remember, That warning message used to appear even
> when I'm executing 'hello' on Debian10. But the BPF program work just
> fine then. Maybe there is something else I can do?
>
> Sincerely,
> Poony.

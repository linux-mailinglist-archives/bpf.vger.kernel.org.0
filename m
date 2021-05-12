Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44AA037B4E6
	for <lists+bpf@lfdr.de>; Wed, 12 May 2021 06:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhELEZX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 00:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhELEZX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 May 2021 00:25:23 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0457FC061574
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 21:24:16 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id y2so29095909ybq.13
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 21:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=80I0ZhRDGI/2egsa3DtWH/1YV8Pw7fH/27cxaE0FKxk=;
        b=YER3DXkOfljxYAdg4mUKJjQCah97RTB8npC3k1wqywFjpmbCK692OxhCFmgb1RjbTS
         d3UeVehHb5CYM9rIO9/NzW/64QrGezSyY1umTu9E7Ap1PJs0+KSRTdEeKTAn/SYhXxx+
         lz6Y7M235j+eNfxl+1Tt/3CdAhLcWZsvgYTg/KCvrnrT/4f3dRdhIdIEUrlO88Y4aUtH
         XJLm/pm6RxqWkiQqL0udLcggnEw2up5+eEBQPzhjU9bk2gVn36F5eehxcazshXLeGCMT
         J8Eft1jUgZwG08m2HF8Mgng4ZjvSW5G+IKYfsUQLPZRNdZJKWboXdssZmNjE91vP6CTt
         JwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=80I0ZhRDGI/2egsa3DtWH/1YV8Pw7fH/27cxaE0FKxk=;
        b=BPiGD+Ad14uyod3RmvCodWpMUAaFfu2xHyhXwAUdupwLfHBAYg7wG4Tw6iCApZAV7l
         QbWCp2ngFPClRSJiw1iNZMgLVyrmKPzj3rXaKAD9Iky8PEEl0WrTvkup1Fh1EyoijT/I
         Nn86IsUgXFq8a7Q3fXGehQ8TljpLvavXPeDB4QzuBB92vU/2hp0VuDyssePLjsyU/fUg
         IxF7R6K7vyFFpxsEPPtj4kCFAfYrv4JnprfEKNLW3aifvlwbiZdUZSMwM2xvI9MjgSVp
         0yH0lNqVJZNhP/jeXYGOoOx+SdjAFP36R0NunANdhAOJNvuYQRaqsW5wqc4/vPG3ZYHk
         EEWQ==
X-Gm-Message-State: AOAM5313f+vvKzkEUhQXtLDeyi6IN1i3HcSk9mWqfuPtDSVha29rAz1v
        0aVN5vs2vfw6t3QYsFSETArtQanAmMdcob6sHB8=
X-Google-Smtp-Source: ABdhPJz+zqmwgMgkxdY3Ht83K0JNKha3kd10FgnZMEObboJ4VqWMjwDW3kQhnXA5HWlBeqrrbYib//pVFmOCqG0x7r4=
X-Received: by 2002:a5b:f05:: with SMTP id x5mr1952048ybr.425.1620793455382;
 Tue, 11 May 2021 21:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210508034837.64585-1-alexei.starovoitov@gmail.com> <20210508034837.64585-23-alexei.starovoitov@gmail.com>
In-Reply-To: <20210508034837.64585-23-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 11 May 2021 21:24:04 -0700
Message-ID: <CAEf4BzYG4J=A0J4m4KHFfdE4iTP9nZzdsJsbT61WUTs1hppmsA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 22/22] selftests/bpf: Convert test
 trace_printk to lskel.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 7, 2021 at 8:49 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Convert test trace_printk to light skeleton to check
> rodata support in lskel.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/testing/selftests/bpf/Makefile                  | 2 +-
>  tools/testing/selftests/bpf/prog_tests/trace_printk.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 4f50e4367e42..8d252238b005 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -313,7 +313,7 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h               \
>                 linked_vars.skel.h linked_maps.skel.h
>
>  LSKELS := kfunc_call_test.c fentry_test.c fexit_test.c fexit_sleep.c \
> -       test_ksyms_module.c test_ringbuf.c atomics.c
> +       test_ksyms_module.c test_ringbuf.c atomics.c trace_printk.c
>  SKEL_BLACKLIST += $$(LSKELS)
>
>  test_static_linked.skel.h-deps := test_static_linked1.o test_static_linked2.o
> diff --git a/tools/testing/selftests/bpf/prog_tests/trace_printk.c b/tools/testing/selftests/bpf/prog_tests/trace_printk.c
> index 60c2347a3181..e67268e929bd 100644
> --- a/tools/testing/selftests/bpf/prog_tests/trace_printk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/trace_printk.c
> @@ -3,7 +3,7 @@
>
>  #include <test_progs.h>
>
> -#include "trace_printk.skel.h"
> +#include "trace_printk.lskel.h"
>
>  #define TRACEBUF       "/sys/kernel/debug/tracing/trace_pipe"
>  #define SEARCHMSG      "testing,testing"
> --
> 2.30.2
>

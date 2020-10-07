Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C1928676D
	for <lists+bpf@lfdr.de>; Wed,  7 Oct 2020 20:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgJGSfi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Oct 2020 14:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgJGSfh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Oct 2020 14:35:37 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6610C061755
        for <bpf@vger.kernel.org>; Wed,  7 Oct 2020 11:35:37 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id h9so2570632ybm.4
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2020 11:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lqk1Qy7eFZghG9XyOgh3yW5pG7dq3iu69ZCVZV06LPI=;
        b=ghar1w+iQtBLvGLQNDrnJ799gRgo+eEnixtCoNQoKIAy4qwBWbAnxw3LXTJyas3rO8
         gF18nCSdbL7PQdljVy/PNqNtRmzTgnzwYSCCfG4JolwtoaqJPjZ/m7Cte99ajsZFjimD
         SyZmnWYJosNcrkzuhQPUjBNG8uH11d+2VwHCv8OYmvc6LPooQRZyXZE7cGNUwAF/ImTP
         0hyhH6ntvFaPVGcum2F3O3ExG7QPTkrdUbDh2EqMLGVcrh1vK2hLgl1v/LAdH656gY8B
         QlMWd3mp1AkD3gPM2gwzBY7gZq4hFDFbHRPwsA8qWIoTW/Mp24189XB/npqs7NHL38II
         EKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lqk1Qy7eFZghG9XyOgh3yW5pG7dq3iu69ZCVZV06LPI=;
        b=ntF/IZ54wG2+ueIPQA7ItadwQ6omMFwo5meyDSbGhPxq1NelXJ7jnFaxOdmiozVs/z
         UqZfycBxxCAdpCpFc+F4sHSZYTLHHXv6kyFtL+hWSXhGxU6Xog2rzf/Osm3la+TzieGV
         CQZBeMkm9KDMEMmBF/YI9H41MbLIfWFEEwZNsOUCLBRbNzS2a6Y1VTIB7T7Hq5xD1NR/
         JgF2cT1I9k/MfGrzZcfm+puDT1WYuynED6Mrrp8ENBcEquy8cv/bPeKOG59WcjSTjLbd
         zcPYmzDBWvIRrYhYOJpA2ig4pn8/iQ6Pvf8nv/KZqAET5tYmrXCuseOC16RTkwvRBBun
         T+Jw==
X-Gm-Message-State: AOAM530Ff8tld9Zig4AtBUW+FK5anRbSB2XX6MOIRReX9kmeXjVLY+Ml
        W1JUkmRHh/b+LPtYLTZDjEk9tEZIIsjX4J7TPTo=
X-Google-Smtp-Source: ABdhPJzYxcq1GdmQo7IQTty8CwZqdorNODapSgzuptLqM0BNrz5YcdwuoHDbkaTX7HuSqf2l/1dto8s0XrpO6rBdgw8=
X-Received: by 2002:a25:cbc4:: with SMTP id b187mr6206979ybg.260.1602095736811;
 Wed, 07 Oct 2020 11:35:36 -0700 (PDT)
MIME-Version: 1.0
References: <CA+hQ2+gb_y7TViv13K_JpJTP=yHFqORmY+=6PrO4eAjgrBSitw@mail.gmail.com>
In-Reply-To: <CA+hQ2+gb_y7TViv13K_JpJTP=yHFqORmY+=6PrO4eAjgrBSitw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 7 Oct 2020 11:35:25 -0700
Message-ID: <CAEf4BzbjUbYDrMc13-bYBBxicDmuokjLHyRaOVA-1JHD6vVbYg@mail.gmail.com>
Subject: Re: libbpf/bpftool inconsistent handling og .data and .bss ?
To:     Luigi Rizzo <rizzo@iet.unipi.it>
Cc:     bpf <bpf@vger.kernel.org>, Petar Penkov <ppenkov@google.com>,
        Luigi Rizzo <lrizzo@google.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 7, 2020 at 9:03 AM Luigi Rizzo <rizzo@iet.unipi.it> wrote:
>
> I am experiencing some weirdness in global variables handling
> in bpftool and libbpf, as described below.
>
> This happens happen with code in foo_bpf.c compiled with
>    clang-10 -O2 -Wall -Werror -target bpf ...
> and subsequently exported with
>    bpftool gen skeleton ...
> (i have tried bpftool 5.8.7 and 5.9.0-rc6)
>
> 1. uninitialized globals are not recognised
>    The following code in the bpf program
>
>      int x;
>      SEC("fentry/bar")
>      int BPF_PROG(bar) { return 0;}
>
>    compiles ok but bpftool then complains
>
>       libbpf: prog 'bar': invalid relo against 'x' in special section
> 0xfff2; forgot to initialize global var?..
>
>    The error disappears if I initialize x=0 or x=1
>    (in the skeleton, x=0 ends up in .bss, x=1 ends up in .data)

Yonghong addressed this. Just zero-initialize them.

>
> 2. .bss overrides from userspace are not seen in bpf at runtime
>
>     In foo_bpf.c I have "int x = 0;"
>     In the userspace program, before foo_bpf__load(), I do
>        obj->bss->x = 1
>     but after attach, the bpf code does not see the change, ie
>         "if (x == 0) { .. } else { .. }"
>     always takes the first branch.
>
>     If I initialize "int x = 2" and then do
>        obj->data->x = 1
>     the update is seen correctly ie
>           "if (x == 2) { .. } else { .. }"
>      takes one or the other depending on whether userspace overrides
>      the value before foo_bpf__load()

This is quite surprising, given we have explicit selftests validating
that all this works. And it seems to work. Please check
prog_tests/skeleton.c and progs/test_skeleton.c. Can you try running
it and confirm that it works in your setup?


>
> 3. .data overrides do not seem to work for non-scalar types
>     In foo_bpf.c I have
>           struct one { int a; }; // type also visible to userspace
>           struct one x { .a = 2 }; // avoid bugs #1 and #2
>     If in userspace I do
>           obj->data->x.a = 1
>     the update is not seen in the kernel, ie
>             "if (x.a == 2) { .. } else { .. }"
>      always takes the first branch
>

Similarly, the same skeleton selftest tests this situation. So please
check selftests first and report if selftests for some reason don't
work in your case.

> Are these known issues ?
>
> thanks
> luigi

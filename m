Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2284F6E6B
	for <lists+bpf@lfdr.de>; Thu,  7 Apr 2022 01:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiDFXPQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Apr 2022 19:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbiDFXPP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Apr 2022 19:15:15 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD181728BB
        for <bpf@vger.kernel.org>; Wed,  6 Apr 2022 16:13:16 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id h63so4828415iof.12
        for <bpf@vger.kernel.org>; Wed, 06 Apr 2022 16:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HrORoox92gaXiHc4pltW5nuitC+0KZgnH6vSwLoRJ2s=;
        b=diqL+S8R2dtUrDfqqYhnnamaPK16EojteAT5r/NUaeBhI9wounO6++MKpjnoN/QgFd
         tQZK5MaXfWP0nk4OPUtmqoZDfFZ3APu7VbY3ZLAPATBr6SFcr9JD7LDucZ69gGzp5AjK
         FhFooshiUBmGcGxUj5SZCstIWrcR1h4JLLSMRpO3/n/A5KB6ryjyPDBM4nQbW3waTeIL
         3RtQ3ejTWz9TfQ+85v5Zjx7hfvs6kanPX2HheN9RQmL42MGcqKkSMf+7Xn0fpEQYo0T8
         8zbWwGldDEos+UNmqSIiRWngYb0CB/fHW4f8U9i/4HdfeklK9Arunl2hSyK4dxTlTVXM
         holA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HrORoox92gaXiHc4pltW5nuitC+0KZgnH6vSwLoRJ2s=;
        b=pOShrF6iMukuOE4qgbJ8c7fk0ESR14syVmQ8656yxCh88pctscs58LShESvLZpFuOB
         NQRTulotZ886T2clu/gzznBYkir+lDia9mPfY0l5LCBVY9xEDTL2yR91bd28b5OuUU26
         mBQODmuWLTvEzUKMP7ThlnKSac0VyW33x5L/suAE11LtzE3iam0bhJzLKX5IXgm6AaRr
         gu2jqdoiPTWq7aCnRxoOfXZGJtiZemERtSIcstRG6YGcz5HqSUqLOHw9cM0ic1ZuInYb
         gNsUtDzm6NL8dg+Z3Wn1HJEG7oBcTggK8T3oUoZIsN+i3N+iA8Q7NdCAIzqj3vOU/dWS
         lAiA==
X-Gm-Message-State: AOAM5313v6eyBKktyH0JRBBfnGLVkYcKWRxmo1g41BwrMKLxnr8jhFiK
        gJAPsbSypYMzHTa9fUalUndSLscR6RuMAS4+KL4=
X-Google-Smtp-Source: ABdhPJzEaMScoHiVxJVDzHOuCx+P7ZSQq9uUmOjkG17kHSg+YDs5mNVJDADhnE4UCZG/nuokRThROfOVb8E7KomFfeI=
X-Received: by 2002:a05:6602:735:b0:64c:adf1:ae09 with SMTP id
 g21-20020a056602073500b0064cadf1ae09mr5013511iox.79.1649286796229; Wed, 06
 Apr 2022 16:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220402015826.3941317-1-joannekoong@fb.com>
In-Reply-To: <20220402015826.3941317-1-joannekoong@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 6 Apr 2022 16:13:05 -0700
Message-ID: <CAEf4BzbfFtgebrWOyfOP71Cn6ZAYXGfjLDPDNmyhzTJ3uTPFpQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/7] Dynamic pointers
To:     Joanne Koong <joannekoong@fb.com>, KP Singh <kpsingh@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 1, 2022 at 6:59 PM Joanne Koong <joannekoong@fb.com> wrote:
>
> From: Joanne Koong <joannelkoong@gmail.com>
>
> This patchset implements the basics of dynamic pointers in bpf.
>
> A dynamic pointer (struct bpf_dynptr) is a pointer that stores extra metadata
> alongside the address it points to. This abstraction is useful in bpf, given
> that every memory access in a bpf program must be safe. The verifier and bpf
> helper functions can use the metadata to enforce safety guarantees for things
> such as dynamically sized strings and kernel heap allocations.
>
> From the program side, the bpf_dynptr is an opaque struct and the verifier
> will enforce that its contents are never written to by the program.
> It can only be written to through specific bpf helper functions.
>
> There are several uses cases for dynamic pointers in bpf programs. A list of
> some are: dynamically sized ringbuf reservations without any extra memcpys,
> dynamic string parsing and memory comparisons, dynamic memory allocations that
> can be persisted in a map, and dynamic parsing of sk_buff and xdp_md packet
> data.
>
> At a high-level, the patches are as follows:
> 1/7 - Adds MEM_UNINIT as a bpf_type_flag
> 2/7 - Adds MEM_RELEASE as a bpf_type_flag
> 3/7 - Adds bpf_dynptr_from_mem, bpf_malloc, and bpf_free
> 4/7 - Adds bpf_dynptr_read and bpf_dynptr_write
> 5/7 - Adds dynptr data slices (ptr to underlying dynptr memory)
> 6/7 - Adds dynptr support for ring buffers
> 7/7 - Tests to check that verifier rejects certain fail cases and passes
> certain success cases
>
> This is the first dynptr patchset in a larger series. The next series of
> patches will add persisting dynamic memory allocations in maps, parsing packet
> data through dynptrs, dynptrs to referenced objects, convenience helpers for
> using dynptrs as iterators, and more helper functions for interacting with
> strings and memory dynamically.
>
> Joanne Koong (7):
>   bpf: Add MEM_UNINIT as a bpf_type_flag
>   bpf: Add MEM_RELEASE as a bpf_type_flag
>   bpf: Add bpf_dynptr_from_mem, bpf_malloc, bpf_free
>   bpf: Add bpf_dynptr_read and bpf_dynptr_write
>   bpf: Add dynptr data slices
>   bpf: Dynptr support for ring buffers
>   bpf: Dynptr tests
>
>  include/linux/bpf.h                           | 107 +++-
>  include/linux/bpf_verifier.h                  |  23 +-
>  include/uapi/linux/bpf.h                      | 100 ++++
>  kernel/bpf/bpf_lsm.c                          |   4 +-
>  kernel/bpf/btf.c                              |   3 +-
>  kernel/bpf/cgroup.c                           |   4 +-
>  kernel/bpf/helpers.c                          | 190 ++++++-
>  kernel/bpf/ringbuf.c                          |  75 ++-
>  kernel/bpf/stackmap.c                         |   6 +-
>  kernel/bpf/verifier.c                         | 406 ++++++++++++--
>  kernel/trace/bpf_trace.c                      |  20 +-
>  net/core/filter.c                             |  28 +-
>  scripts/bpf_doc.py                            |   2 +
>  tools/include/uapi/linux/bpf.h                | 100 ++++
>  .../testing/selftests/bpf/prog_tests/dynptr.c | 303 ++++++++++
>  .../testing/selftests/bpf/progs/dynptr_fail.c | 527 ++++++++++++++++++
>  .../selftests/bpf/progs/dynptr_success.c      | 147 +++++
>  17 files changed, 1955 insertions(+), 90 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/dynptr.c
>  create mode 100644 tools/testing/selftests/bpf/progs/dynptr_fail.c
>  create mode 100644 tools/testing/selftests/bpf/progs/dynptr_success.c
>

KP, Florent, Brendan,

You always wanted a way to work with runtime-sized BPF ringbuf samples
without extra copies. This is the way we can finally do this with good
usability and simplicity. Please take a look and provide feedback.
Thanks!

> --
> 2.30.2
>

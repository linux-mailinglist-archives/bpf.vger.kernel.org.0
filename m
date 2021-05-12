Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B7037B4DB
	for <lists+bpf@lfdr.de>; Wed, 12 May 2021 06:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhELEUs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 00:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhELEUr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 May 2021 00:20:47 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCF5C061574
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 21:19:40 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id h202so29092854ybg.11
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 21:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qpd8syiGfNziwL90v7//Caol0qt1VKnCxoi2zr8xTLM=;
        b=PrC1XSEg2POjqHQyY1wQSGwFOrZ1de5Kw1FPbJAz0ePPTUB8KeIpYAfS3V/nlEgbrw
         4cVfelIhsB8WLMckZA7gOyEoGYt3eAvrR8IqDXeNc5+Yek+MhD19VQkftyjpR0N84gAp
         sGtx7q3JLsJ/1rXEVWPst9S4Ws8tI3j6E7e+lFCkeNiPiIQFHIaK2zH2UgqQsKJ3R4eX
         A2b27YL9kbCtSyTiOv5w3S8UwVbh74JEJYnBAeJGIg9tD2aCPfL0fyAkUksA4WFyun/s
         T6Ealez538c97tjNj2v3O9v/oHZB5ZHoIxf2oPWabin7R8e93rCgGMVYO2KWVRg2SiGy
         4ybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qpd8syiGfNziwL90v7//Caol0qt1VKnCxoi2zr8xTLM=;
        b=eRQXlfdo0JXuyYuAg8WJ+tvEd+LDEaKDnWhYajFT4yOOWq8H901nGX3w59ZwVdeI10
         Ls3spuchE+FBqUsEIGaD0NfrrGimKslN2BcXegjoA98eyCWyoEWcIGEhVJb5oVDPMdBA
         zppqaDlUL0ywuRyhlmKtqa4L2MzPnqEYLD2orLLj5/xjx3NC2EioNTHBIZ8taHdu6vHd
         S8hUD5Z77nloJG/y6VdQrdwGBzKtUYjvfFwK61LErf2TAlhoQEtMtfsnAor/I+HIY5wT
         Y2CzSri/UWPd9m7cFjP16jE+Qk5M4qTxXXcsyiHCau4k5rwEJnNBjKagN4n83HCd8xJB
         24qg==
X-Gm-Message-State: AOAM532gqt45wu/tehTPQK3tl0LnDo4w7exbMI9BbZUBWCe5XNp5i5vX
        Hr3n5hakPe/KhV93orMXG+itEvpw0SekFQ+nKnc=
X-Google-Smtp-Source: ABdhPJxW00PPs4OPcCvsDshgfzQzM00JpxucpMyFyIT+d2V3OEoag7Evx3mI3EwD/FsDHt4f13nTckDyViogSg3B1eQ=
X-Received: by 2002:a25:ba06:: with SMTP id t6mr43806729ybg.459.1620793179953;
 Tue, 11 May 2021 21:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210508034837.64585-1-alexei.starovoitov@gmail.com> <20210508034837.64585-20-alexei.starovoitov@gmail.com>
In-Reply-To: <20210508034837.64585-20-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 11 May 2021 21:19:28 -0700
Message-ID: <CAEf4BzYdYhaNes0Fmgk=wXQ8f+L_JCVkW8qesN8ib6R6O3-_8g@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 19/22] selftests/bpf: Convert few tests to
 light skeleton.
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
> Convert few tests that don't use CO-RE to light skeleton.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/testing/selftests/bpf/.gitignore           |  1 +
>  tools/testing/selftests/bpf/Makefile             | 16 +++++++++++++++-
>  .../selftests/bpf/prog_tests/fentry_fexit.c      |  6 +++---
>  .../selftests/bpf/prog_tests/fentry_test.c       | 10 +++++-----
>  .../selftests/bpf/prog_tests/fexit_sleep.c       |  6 +++---
>  .../selftests/bpf/prog_tests/fexit_test.c        | 10 +++++-----
>  .../selftests/bpf/prog_tests/kfunc_call.c        |  6 +++---
>  .../selftests/bpf/prog_tests/ksyms_module.c      |  2 +-
>  tools/testing/selftests/bpf/prog_tests/ringbuf.c |  8 +++-----
>  tools/testing/selftests/bpf/progs/test_ringbuf.c |  4 ++--
>  10 files changed, 41 insertions(+), 28 deletions(-)
>

[...]

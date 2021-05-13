Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC30F37FFC6
	for <lists+bpf@lfdr.de>; Thu, 13 May 2021 23:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbhEMV1w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 May 2021 17:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhEMV1w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 May 2021 17:27:52 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A48C061574
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 14:26:41 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id h202so36367627ybg.11
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 14:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2HI3Yo8cjJLeBkVTuAPbLuQva2CRY/4Nu5D9j44fisQ=;
        b=Ybno3zgalq7+sgcD9aRpC/1qtzrMSnM0ugERP7qjyFDDDUuKcKFDxzAnnm6snXKbRG
         EYQV4gEjK0fC3nTpDP+q9Y8Rd84iX6G9yz7632AekeloBT5gwlFyJXaLggWlDGNSH7hi
         M65NLw12JGL5jwpsCxhNJjoOFatXxhMKojIoWcBqDtNHKk8Zqsi5HnxkzCYceRDmAhQw
         OyD4ClcwQLsTsgQArPmyjDAwN3oqkNGLKzZPA9+8c9jA1pMC5sT1V20HVFg7Luwx/g3V
         UlDSyPQv2cPXPn5z3t/eucQlkG6/w+IhEOhI1tMp6gt4i84cxhANavLjbI9/aVkAU6H5
         W0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2HI3Yo8cjJLeBkVTuAPbLuQva2CRY/4Nu5D9j44fisQ=;
        b=Y5Kh+VNgm/lAdzVCb5TfrBYmr4UCqbz8X/jHMb9hUFs26usGw93nNMVFp0AT6sbAZ0
         Ie0zFXhcLNmvp0F1rkeGHVgD8CWrVEvKLa/rlxBZGTKbMEXwE+I9y0pS9V94eGaQgG3x
         Y1L/nHwZNRV60SFu+3VNuZN+wRnYCoOksC0HmOrfBExezck/xjS2U6Fa8I6heVqHLBU0
         WgqXYnSCs7kE7HjTAk7JI9wyFTS/KYsaKt4tcvYHktg3SnJMoTbih0hP8bOQsASEhQwl
         yoWHayL/NCAnNuVqhe8PVQ1DCCpRv+ySuxssx45c7HfBTPcgAI3O5kL6tfx3gyMzDJO9
         T4dA==
X-Gm-Message-State: AOAM530xbvHGuaoYM9I8P5ZSRxIAm0419DrsHVsQXu8ZG0YfxYzF2qwK
        JFJCqCMxdmI1MNHyTEy9jsvdhAHNEYXaePhfauE=
X-Google-Smtp-Source: ABdhPJyelJnMIODscjq6Ur90ala0sCf3Byb9lJwskFTf9sEGugsdG4ByNvm1wY3AIqlayGJswhoGil7oW3bxCzWF70A=
X-Received: by 2002:a25:1455:: with SMTP id 82mr58342615ybu.403.1620941200718;
 Thu, 13 May 2021 14:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210512213256.31203-1-alexei.starovoitov@gmail.com> <20210512213256.31203-19-alexei.starovoitov@gmail.com>
In-Reply-To: <20210512213256.31203-19-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 13 May 2021 14:26:29 -0700
Message-ID: <CAEf4BzbNcptb4wqrE3is4bgj_c28KsMB_VESq5i6d86xpioLXQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 18/21] selftests/bpf: Convert few tests to
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

On Wed, May 12, 2021 at 2:33 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Convert few tests that don't use CO-RE to light skeleton.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> ---

I don't see any problems in Makefile changes, but we'll need to figure
out why kernel-patches CI doesn't like this.

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

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E4637B4E1
	for <lists+bpf@lfdr.de>; Wed, 12 May 2021 06:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbhELEXK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 00:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhELEXJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 May 2021 00:23:09 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7268FC061574
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 21:22:02 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id s37so4643342ybi.6
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 21:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8d0XDPwFIj54BXo6dkfnDE/6p30uLh/h62cl+kG4PAw=;
        b=OYdmO2U36IkPmuEX32jMuFS5qtGNsfguwVqyZgBWN6hleHWriNZVrutcV9An3H1wlK
         pCDgXrRVjh2LLRKh54aMWVpJIeuaT/2wThO58Z0/xhCtkFpUcEpw5mDU+oYw6ZJnbfB9
         GEh1+Y/5TuStcRRPIhrVmGiRgMrxBxUOykeqbh8+NZUBR5G83Wm7GfzfffcV1hon3aOq
         +3A8itsFvaKOIEttmC4Ne6IPq8ae5NbkTEI+wHzfAIUg/N7RWSPO5irdTpFHH68uagqD
         WGTY/3ISjmM+XRxsMzXybspodBIJiPbirqxjGMCx/8WR+0pSVU/sHJ4jKYR5kae5La2D
         hZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8d0XDPwFIj54BXo6dkfnDE/6p30uLh/h62cl+kG4PAw=;
        b=iNyvsTc4ddkHp/y1Txh3w8+mhoyYXkyFrp/2RYhb1PAyojP5diQpVTeK0rJi9Ulhsh
         qq5pK4Ssxj8UixnuNtI+aWw1LA9MlUmSW+u9tHTzZdchly5JRDYYvs343pnMV7MTNYv6
         CNeZbD5vOFt43A2AMfERLiPjap9jHmGMwXwQ4tqkUHylgj5yTI7mBCnq4BnmmcK+L1pB
         GyKiletIDmYCwKt4BvDCQUSIa2d8c7H0HRvZytjqzwa70AtyAamAehh0xjLWdcTpqdZl
         BMRtzptSMJ/QgzUqzue7/nrxyGA1RSOk70GlfdjWSiRp8hVd0G5rPo0QHWl4WjSTobGr
         kFNg==
X-Gm-Message-State: AOAM530YKXzypZGKGRbV/VYIuDWhXba1+VYOP0AJEtCS2JQSxdSPuA+J
        /wgTttf6apVGxmu1kjwlCMur54L6jkMKFZJt9Yo=
X-Google-Smtp-Source: ABdhPJx6rBfpwfe9qJlUy5ovop/Lt8v/dl83gsAhYhlbz731LgzX4IS2nkYAXD3FWE2PbD08LBMD/77Ai4J7xGByB50=
X-Received: by 2002:a25:ba06:: with SMTP id t6mr43815701ybg.459.1620793321573;
 Tue, 11 May 2021 21:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210508034837.64585-1-alexei.starovoitov@gmail.com> <20210508034837.64585-21-alexei.starovoitov@gmail.com>
In-Reply-To: <20210508034837.64585-21-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 11 May 2021 21:21:50 -0700
Message-ID: <CAEf4BzafK=Mgpupr6JFUWOCvsE-CxdXqprt8NTGqW6A4Ym6V8Q@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 20/22] selftests/bpf: Convert atomics test to
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
> Convert prog_tests/atomics.c to lskel.h
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Less CHECK()s, yay.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/testing/selftests/bpf/Makefile          |  2 +-
>  .../selftests/bpf/prog_tests/atomics.c        | 73 ++++++++++---------
>  2 files changed, 38 insertions(+), 37 deletions(-)
>

[...]

> @@ -32,21 +32,22 @@ static void test_add(struct atomics *skel)
>
>         ASSERT_EQ(skel->data->add_noreturn_value, 3, "add_noreturn_value");
>
> +

why extra empty line?

>  cleanup:
> -       bpf_link__destroy(link);
> +       close(link_fd);
>  }
>

[...]

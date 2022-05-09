Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7912D5204CA
	for <lists+bpf@lfdr.de>; Mon,  9 May 2022 20:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240366AbiEIS6T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 14:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240379AbiEIS6R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 14:58:17 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D029201385
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 11:54:23 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id h85so16321720iof.12
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 11:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iPHCVjStJ1pagBcMHHT7YIZoWLvWYah+wYdXl1aOGKM=;
        b=ikaIWSzqlPURWOGOyn24hMoa/JsZluCwd18h+nv6YrO7/i4qIG3f73YYcmBrDA7k8m
         JGMjXWaNpP11Wxhe8ArQr69NgjQe3doZLzw/5iPd4zLjJfva3MYyHN+sZ77RgU533aru
         Ota7RKIxLitKJ0aYQP+AZtN86w7ZQPMO5Z+6dYxb0/zRV3wDJeWrt1u0l497cYAPps0w
         t5zLio52kSl69+HkxU4guKa1qHA/0e4B9icVTdwpqviDm0ySUga+qTI3/1PWHJA0h6XB
         3n7QH2H58C7sKUu81DkqIBgi0y/qIsKN9MVi8/kI8jCvhRIlPu8Nz4ZcUVtlLZ1ge/m7
         h3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iPHCVjStJ1pagBcMHHT7YIZoWLvWYah+wYdXl1aOGKM=;
        b=5CYV09/+F/Fg9MZF4g7a5qDEq6/H1W6W2x1F3acKRilooY5Ps5yok4Wfvt4stKsq6+
         U9lV99ctnv4CqwS8TozwsU09KKTA17c9wkALDlTAb1puTO+0sm5JS9Njf4xiNRaQ215T
         CZiRUIHL1QZ+sHrRZfMscSQ9FGfnS7PJRBgaL8F7q0aq/owA1u9ryVFJEA3ob5A37Gc1
         XS9PblJPEq2Qgzn8GZiVyERtQaC37LX4z+xQyS2dbwz1j3V+OZnq8h4TTFbZhhXWfYVy
         nOBn0JGnPAk/eVgFHMK37Mkl5lBQNwzvj0B6tihZ+aJiMEjfPvCht2uAoUrMCRDGqkaq
         T4Eg==
X-Gm-Message-State: AOAM531pDd6kHZ810W0kUcwM4770W5CF2EYjRXb/dX1Lw0BEreVXoMpA
        WEHjIARwSEdu1FRtl57Ou6GEho7kPWxyrU5KIBU=
X-Google-Smtp-Source: ABdhPJzPRF3hx4IdVRk/gwvWxjmIWhHxdp8UOPeLEhdNtQhSD5KoLUg62aqqCdbcevrGGtFQVPSvlg+B0xBNGJyK9lI=
X-Received: by 2002:a05:6638:16d6:b0:32b:a283:a822 with SMTP id
 g22-20020a05663816d600b0032ba283a822mr8054251jat.145.1652122462774; Mon, 09
 May 2022 11:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220508032117.2783209-1-kuifeng@fb.com> <20220508032117.2783209-3-kuifeng@fb.com>
In-Reply-To: <20220508032117.2783209-3-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 9 May 2022 11:54:12 -0700
Message-ID: <CAEf4Bzb6xwtu4T3Na75V9tTfxUZuD4LE_--ajqDFHyGSennxRw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 2/5] bpf, x86: Create bpf_tramp_run_ctx on the
 caller thread's stack
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
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

On Sat, May 7, 2022 at 8:21 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> BPF trampolines will create a bpf_tramp_run_ctx, a bpf_run_ctx, on
> stacks and set/reset the current bpf_run_ctx before/after calling a
> bpf_prog.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---

Please preserve received Acked-by/Reviewed-by/etc tags that you got on
previous iterations, unless you feel like you did some major changes
that might invalidate reviewer's "approval".

Still looks good to me:

Acked-by: Andrii Nakryiko <andrii@kernel.org>


>  arch/x86/net/bpf_jit_comp.c | 38 +++++++++++++++++++++++++++++++++++++
>  include/linux/bpf.h         | 17 +++++++++++++----
>  kernel/bpf/syscall.c        |  7 +++++--
>  kernel/bpf/trampoline.c     | 20 +++++++++++++++----
>  4 files changed, 72 insertions(+), 10 deletions(-)
>

[...]

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D843F3D4388
	for <lists+bpf@lfdr.de>; Sat, 24 Jul 2021 01:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbhGWXSK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Jul 2021 19:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbhGWXSK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Jul 2021 19:18:10 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D76C061575
        for <bpf@vger.kernel.org>; Fri, 23 Jul 2021 16:58:42 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id l145so4812407ybf.7
        for <bpf@vger.kernel.org>; Fri, 23 Jul 2021 16:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XopyvSgMGpoLlNxDfjeb8DOHkMfaTr9uJhS87aa1qAs=;
        b=LMoaSvTJJmhgB74YGf0ehSdSLt6Yc1hbfw/uaQTZ8jXQWySjVu9vLaHirKEHGHIxlE
         4g3KplK9GavlunIM1F9cceQ5SFl9fv1jfiFkQ/L/TrdtPArj0ELjBaVQtg2SjzYElxyt
         nmJWRdfbgvU2Tu9VTneguAs57JsUWam1nNmNF6tJkC134bxl5wG8HnVitKk0aYYWjWwu
         /eBP2RPi8FEB3Lm0y/pKBlwZGrg8/4JlL/BwihMIpMUUlu1sJ3rX3HF742tV2KtMwLJz
         ys91ASSWBW3unkbkd1YfYWd2+fXGa6inJ7iAJW9D0Hnie3DtJaMhGos1Y2UFwFpS1dC+
         Q+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XopyvSgMGpoLlNxDfjeb8DOHkMfaTr9uJhS87aa1qAs=;
        b=KhMBMMXSLet9EVOlDO+nn/PL8GBCVt8PTFQ6Lbd1f/DeVMHKxdSLmS2zxR8YdohEOR
         PloteiO4llT4K/k5QrLLqgNKDpetq6ho/kFmNQm7jMVn3lrqPoJJT6r1bLe+83orSw3n
         ZOeik40MSUDXGcutGyTjbW3BYct1qDMEB6p3GvmT+23lmqYYC8sOh+DWYArorfJhAKHH
         MJYDATeHTgmaxaka0QKognGuEC86clHiNEPKUCgJP5p1HVJVmRFNbmuOHh8rhASYcHHn
         r7xeocA0QN6Paj5S7qg62d0lFlATeLU3dG7YuYsojaVdvrNLBgCSagqOTS0t3uTho204
         lOaw==
X-Gm-Message-State: AOAM531AqhBXkIkhXB9+ZaMfioY+KfbyxXe0436hutkhRGT0/JyjYNsC
        RKVJ0OuspWo5o3GeFS92vUOC9kaAm36jYAyES/0=
X-Google-Smtp-Source: ABdhPJyDozM5+LS1HNMAomVqO7zFaKOnbDkCrwwgDACTTxUZSXT2udRIMB+tLg3z1n101/b1ZbiJkuUeiTHJ2HZpN+g=
X-Received: by 2002:a25:d349:: with SMTP id e70mr9946995ybf.510.1627084721354;
 Fri, 23 Jul 2021 16:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210723221511.803683-1-evgeniyl@fb.com>
In-Reply-To: <20210723221511.803683-1-evgeniyl@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 23 Jul 2021 16:58:30 -0700
Message-ID: <CAEf4BzZ8gaD=3Ga4j2E8SuvKTL41zGqzr9MWhD8xWu0GvPk_rw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] libbpf: Add bpf_map__pin_path function
To:     Evgeniy Litvinenko <evgeniyl@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 23, 2021 at 3:16 PM Evgeniy Litvinenko <evgeniyl@fb.com> wrote:
>
> Add bpf_map__pin_path, so that the inconsistently named
> bpf_map__get_pin_path can be deprecated later. This is part of the
> effort towards libbpf v1.0: https://github.com/libbpf/libbpf/issues/307
>
> Also, add a selftest for the new function.
>
> Signed-off-by: Evgeniy Litvinenko <evgeniyl@fb.com>
> ---
> v1->v2:
>  - Fix a rookie whitespace issue.

Congrats with the first kernel patch!

LGTM, applied to bpf-next.

>
>  tools/lib/bpf/libbpf.c                           | 5 +++++
>  tools/lib/bpf/libbpf.h                           | 1 +
>  tools/lib/bpf/libbpf.map                         | 1 +
>  tools/testing/selftests/bpf/prog_tests/pinning.c | 9 +++++++++
>  4 files changed, 16 insertions(+)
>

[...]

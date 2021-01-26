Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C0C30354B
	for <lists+bpf@lfdr.de>; Tue, 26 Jan 2021 06:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbhAZFiv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jan 2021 00:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732010AbhAZCeu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jan 2021 21:34:50 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C60EC061573
        for <bpf@vger.kernel.org>; Mon, 25 Jan 2021 18:34:08 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id e206so3085073ybh.13
        for <bpf@vger.kernel.org>; Mon, 25 Jan 2021 18:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g3pjtshA3y0EzC6IGe5deZzOWbI81Aa8oxWCKQUy+JY=;
        b=ZphAAVdvIBzWIx/Lu1/7Ynjj5kw6jZSJnc30oZZRiXXnq+A9wVSoO/yJZ7+r4PihuY
         AFx3EdgcZ+Jbr4S+2HnRSLMQ8Q1HgbNixMrem+krfRMcgsI/dUJrdLYxRVi4rG4ZvEuM
         xQQxT/UXHrK+/wxOqxUPEsF8ZDkWQniUvhKItBJ1njIy/qqhYEOwQr0OwRm0Ry+6IWBP
         n/4K97CNFtT8YAM1dt2+RhiVcXNOg0jycytlRAGn8Zn0D5jExqP3WB9y3A/mKxNJpFcb
         BcWjgcWxrK7qlwTtqH3vCIoOUZGo342exXtlNnBcrCvgUpOUyMiyhBP5z+gTs2WhVuEc
         k/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g3pjtshA3y0EzC6IGe5deZzOWbI81Aa8oxWCKQUy+JY=;
        b=Yl5GFwluTyBxCPjihd3cgYjBH257GpcwZ5vAiKbBX7jU4zvDf+TQr9V3S8Zusk/wJ7
         jEm4JS+SPiMAWDYcwBr450fKCZ//zRaUn2mkVwXumZRsX0jFqSwom3FDBTk7ykAB6EXj
         fo7hK3UZPX8KxpruprhY5S8tYBlx+SgOSq1DRvUTb7rqxlXRXFxQ8Aj4jCojqsIeVFN8
         kzNKSv1cpiKurBURpSFjg2hX2C2vUNbV/EqcDyrm04ZgnPUyL+1437JhRpbqXLhQml22
         uVwL1D9Z83+unWjChz+HlsGYiKe9Z1qNkIasTWjRYW0BnhwnAoO59sfsXcuKtQC8EonR
         DOcg==
X-Gm-Message-State: AOAM5311cw3ARH+M96MY+AakGpe7KjJ0VvS/4mZf8jxz+ZDKsCxICIFY
        uMX7+LzcVHKUTX67JRpZ8FEY94XKYuNM7pxmTfc=
X-Google-Smtp-Source: ABdhPJwABHXfa2uwMuDI1JICdbqnt9NYWTOJmgfLDa2s0Yp+9s+s8E+gQJUnakKRF/Hi3fjBMho8rcHB6rD0TZSi9Qs=
X-Received: by 2002:a25:548:: with SMTP id 69mr5013514ybf.510.1611628447506;
 Mon, 25 Jan 2021 18:34:07 -0800 (PST)
MIME-Version: 1.0
References: <20210124194909.453844-1-andreimatei1@gmail.com> <20210124194909.453844-5-andreimatei1@gmail.com>
In-Reply-To: <20210124194909.453844-5-andreimatei1@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 25 Jan 2021 18:33:56 -0800
Message-ID: <CAEf4BzYncMLH8z0D-TMjzekSp0eAPw963dWg91uaKR+nFiBg8w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/5] selftest/bpf: move utility function to
 tests header
To:     Andrei Matei <andreimatei1@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jan 24, 2021 at 11:54 AM Andrei Matei <andreimatei1@gmail.com> wrote:
>
> get_base_addr is generally useful for tests attaching uprobes. This
> patch moves it from one particular test to test_progs.{h,c}. The
> function will be used by a second test in the next patch.
>
> Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
> ---

trace_helpers.{c,h} seem more appropriate as a destination

>  .../selftests/bpf/prog_tests/attach_probe.c   | 21 ----------------
>  tools/testing/selftests/bpf/test_progs.c      | 25 +++++++++++++++++++
>  tools/testing/selftests/bpf/test_progs.h      |  1 +
>  3 files changed, 26 insertions(+), 21 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> index a0ee87c8e1ea..3bda8acbbafb 100644
> --- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> +++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> @@ -2,27 +2,6 @@
>  #include <test_progs.h>
>  #include "test_attach_probe.skel.h"
>

[...]

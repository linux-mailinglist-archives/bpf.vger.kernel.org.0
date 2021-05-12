Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F6D37B4E5
	for <lists+bpf@lfdr.de>; Wed, 12 May 2021 06:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhELEY1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 00:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhELEY1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 May 2021 00:24:27 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35601C061574
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 21:23:19 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id v188so29160622ybe.1
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 21:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j4pF86lQzDYxhregwGWynE9Nf75s4QdGNFDKRkAomes=;
        b=OVcrZtlV8NdKkiX+txVravIE0ru73hGB5igmrV7NWglKwLHa1tiDGcVqOcvXIL3Hhg
         YkxQc5RvcH1ScByxuU8ZVT73OlQzUDN5PBObjvBSLIodA5FiyssXfZZPg5AkDjDVeamz
         5bTpoG5juJZCuNWlVTUzGs27DAHRLEXZNqvqD/cLcJWr7ZUAXTGlvjWpClj35tfWNX54
         sCtFlWMBzqj/dkptE8kZoCzepfoH9f2DdCZopkojHeGtzgg2DuWwCHMvNBfit97/7K/s
         bB93pL2e5KZKEdfNw69POE0dpefRdZDG7WIjQKSOdsIFD+fMa3XCYOmGt1mN45PE/k8o
         16Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j4pF86lQzDYxhregwGWynE9Nf75s4QdGNFDKRkAomes=;
        b=fdurq69rUtxDLpKLvzaNmR8NJ1nABtT1eZ+UPN0PNR7yojliW3E8cRaNUkCa5MhEoZ
         dOP+BxleRIijTj+PlaGoQTU/Q6qxeYNy4jk08P3qGehqydAWzbTyNmoDpHFrY4U9UBtc
         VKbMumBKI9vjlNcMMQgLZsxzEKKojRhFJqL6He1TIPqM61z09xDYCSnRd+d/LhCwmXiu
         3Y9xb37D46sMFlTH44qWcqP0zsslTE4xH69ZkEtE7o3GJ/a29TvhtIvQ4vbMZ2OSLlGZ
         xs1M0+aQkpWhzj7f+YdBA1N3c31YJrJrsfpmYHzrULKq5Jl1soQjHsKmWnLMqZHNix1j
         3nEA==
X-Gm-Message-State: AOAM531k3mWK4t8Zxdpgr6Rg82GfYHSsA/lD4Uco1++fcDfqeFQa/AXI
        SpKML+Oe1Utd7Pc/yhnTVrLUO+l0n7P4Ir7VonaElpzv
X-Google-Smtp-Source: ABdhPJy/lzoevRCadJ94jSXDTYUmVgspFq76WeoG+5b4PjuE4SDCp04zJGyvmL+nIML3yifqh2UqHJZ2kXLCbJNZym0=
X-Received: by 2002:a25:1455:: with SMTP id 82mr44935826ybu.403.1620793398526;
 Tue, 11 May 2021 21:23:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210508034837.64585-1-alexei.starovoitov@gmail.com> <20210508034837.64585-22-alexei.starovoitov@gmail.com>
In-Reply-To: <20210508034837.64585-22-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 11 May 2021 21:23:07 -0700
Message-ID: <CAEf4BzYzDkVuWn4SzKwfw01sLWBbdV=Bpd9sZB=moyQvZKa=hQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 21/22] selftests/bpf: Convert test printk to
 use rodata.
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
> Convert test trace_printk to more aggressively validate and use rodata.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  tools/testing/selftests/bpf/prog_tests/trace_printk.c | 3 +++
>  tools/testing/selftests/bpf/progs/trace_printk.c      | 4 ++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/trace_printk.c b/tools/testing/selftests/bpf/prog_tests/trace_printk.c
> index 39b0decb1bb2..60c2347a3181 100644
> --- a/tools/testing/selftests/bpf/prog_tests/trace_printk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/trace_printk.c
> @@ -21,6 +21,9 @@ void test_trace_printk(void)
>         if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
>                 return;
>
> +       ASSERT_EQ(skel->rodata->sys_enter_fmt[0], 'T', "invalid printk fmt string");
> +       skel->rodata->sys_enter_fmt[0] = 't';

sys_enter.fmt is no more, need to make it into a global variable.

> +
>         err = trace_printk__load(skel);
>         if (CHECK(err, "skel_load", "failed to load skeleton: %d\n", err))
>                 goto cleanup;
> diff --git a/tools/testing/selftests/bpf/progs/trace_printk.c b/tools/testing/selftests/bpf/progs/trace_printk.c
> index 8ca7f399b670..18c8baaf1143 100644
> --- a/tools/testing/selftests/bpf/progs/trace_printk.c
> +++ b/tools/testing/selftests/bpf/progs/trace_printk.c
> @@ -10,10 +10,10 @@ char _license[] SEC("license") = "GPL";
>  int trace_printk_ret = 0;
>  int trace_printk_ran = 0;
>
> -SEC("tp/raw_syscalls/sys_enter")
> +SEC("fentry/__x64_sys_nanosleep")

this will break on non-x64 systems, can more stable raw_tp be used here?

>  int sys_enter(void *ctx)
>  {
> -       static const char fmt[] = "testing,testing %d\n";
> +       static const char fmt[] = "Testing,testing %d\n";
>
>         trace_printk_ret = bpf_trace_printk(fmt, sizeof(fmt),
>                                             ++trace_printk_ran);
> --
> 2.30.2
>

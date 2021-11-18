Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42D64563D3
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 21:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbhKRUDV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 15:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbhKRUDV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Nov 2021 15:03:21 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C14C061574
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 12:00:20 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id g17so21358816ybe.13
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 12:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Tpt3xUMGv7KT7y1sDNzYZMMoXk9VdGPwQD6MqCkYLmE=;
        b=jWxWF1P/9oRprh0UFqKA9+x4K4XEIs2NbigeZzrXGYGjpPuVHnl4nxbcE9Lh25AKOv
         45VvDMs6n5DmM3jIFXMPbvdnPOw2L75AFoE4uRDEmZPVv+cQpLwop+8B8BTchhRctA58
         06P6tOkVXixQKp3tIt44IfR7pHnrd7d+U2Ou7rug4TlydHj1cvSDGtIjnf42McetGnXV
         Ph8huhU6uLjpxWrrMTNMExv8FKankVFmtrKpLY2g2037CuurbQNgfGufmzcAvJAOecfd
         KlqXOsbQVjb3pxkf3DRjCon+vjvyi0Yrtvs5rZP7589N6T2Lmzso/s7W7mHra5tgxIa6
         MyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Tpt3xUMGv7KT7y1sDNzYZMMoXk9VdGPwQD6MqCkYLmE=;
        b=V+kZGx1Fb1xc+u0w8RzKsUY9Kw1K7qgvwmCdoxPJfL3y/TDo8+5ADsDwbY+EPFJkZ5
         yHpZdUpmYZS3fuoWIoRw/EQp2McTCbwHIhMrMF0DpJK6Wv8aBM2yYBYi6uvLMuPKx8jc
         /ezxcU0Az41kj6+JCt4VVVUZv+9+wRTx8sVJWWBC/g77aa5B4y8KsyZ8fUNoFrJHvHaI
         rwEv8cF0gJAiQ4qyftEg+VHxfCcDe/EnkCDj/ZLythBK8koYwZ94rHjD2gutBE1jB6/d
         r1kKoRT5h8JtCWFhgcLXaNgyhAE7tsIX32fln10eKhd15O6HFwR3zwylL4nXp5EX5rmF
         vh3Q==
X-Gm-Message-State: AOAM531PAA1kMjWw3fcTNK7J1bf+0nUzMFlVSq/SVXibAMBI6tCvoYp6
        iAAIP4apHwa6ylXvGgz3Bx5Yz1dJW1T/HP6MNbo=
X-Google-Smtp-Source: ABdhPJzo2bcv8AsaRMyfdxBOBWrySn/CUFxXEIYH9F0ORuhO+P4ciewVs+2dPLxp98ghNC9cjGRfJTCF9r321mQxby4=
X-Received: by 2002:a25:afcd:: with SMTP id d13mr30820452ybj.504.1637265620203;
 Thu, 18 Nov 2021 12:00:20 -0800 (PST)
MIME-Version: 1.0
References: <20211118010404.2415864-1-joannekoong@fb.com> <20211118010404.2415864-4-joannekoong@fb.com>
In-Reply-To: <20211118010404.2415864-4-joannekoong@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 18 Nov 2021 12:00:08 -0800
Message-ID: <CAEf4BzZvhx15uSt+5-1379RLfDiY0THb+QtMfD0G35L0Knx=eg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftest/bpf/benchs: add bpf_for_each benchmark
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 17, 2021 at 5:07 PM Joanne Koong <joannekoong@fb.com> wrote:
>
> Add benchmark to measure the overhead of the bpf_for_each call
> for a specified number of iterations.
>
> Testing this on qemu on my dev machine on 1 thread, the data is
> as follows:
>
>         nr_iterations: 1
> bpf_for_each helper - total callbacks called:  42.949 =C2=B1 1.404M/s
>
>         nr_iterations: 10
> bpf_for_each helper - total callbacks called:  73.645 =C2=B1 2.077M/s
>
>         nr_iterations: 100
> bpf_for_each helper - total callbacks called:  73.058 =C2=B1 1.256M/s
>
>         nr_iterations: 500
> bpf_for_each helper - total callbacks called:  78.255 =C2=B1 2.845M/s
>
>         nr_iterations: 1000
> bpf_for_each helper - total callbacks called:  79.439 =C2=B1 1.805M/s
>
>         nr_iterations: 5000
> bpf_for_each helper - total callbacks called:  81.639 =C2=B1 2.053M/s
>
>         nr_iterations: 10000
> bpf_for_each helper - total callbacks called:  80.577 =C2=B1 1.824M/s
>
>         nr_iterations: 50000
> bpf_for_each helper - total callbacks called:  76.773 =C2=B1 1.578M/s
>
>         nr_iterations: 100000
> bpf_for_each helper - total callbacks called:  77.073 =C2=B1 2.200M/s
>
>         nr_iterations: 500000
> bpf_for_each helper - total callbacks called:  75.136 =C2=B1 0.552M/s
>
>         nr_iterations: 1000000
> bpf_for_each helper - total callbacks called:  76.364 =C2=B1 1.690M/s

bit clear why numbers go down with increased nr_iterations, I'd expect
them to stabilize. Try running bench with -a argument to set CPU
affinity, that usually improves stability of test results

>
> From this data, we can see that we are able to run the loop at
> least 40 million times per second on an empty callback function.
>
> From this data, we can also see that as the number of iterations
> increases, the overhead per iteration decreases and steadies towards
> a constant value.
>
> Signed-off-by: Joanne Koong <joannekoong@fb.com>
> ---
>  tools/testing/selftests/bpf/Makefile          |   3 +-
>  tools/testing/selftests/bpf/bench.c           |   4 +
>  .../selftests/bpf/benchs/bench_for_each.c     | 105 ++++++++++++++++++
>  .../bpf/benchs/run_bench_for_each.sh          |  16 +++
>  .../selftests/bpf/progs/for_each_helper.c     |  13 +++

$ ls progs/*bench*
progs/bloom_filter_bench.c  progs/perfbuf_bench.c
progs/ringbuf_bench.c  progs/trigger_bench.c

let's keep the naming pattern


>  5 files changed, 140 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/benchs/bench_for_each.c
>  create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_for_each=
.sh
>

[...]

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A109462803
	for <lists+bpf@lfdr.de>; Tue, 30 Nov 2021 00:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbhK2XRq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Nov 2021 18:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbhK2XRQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Nov 2021 18:17:16 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9E9C048F79
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 15:02:28 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id f186so46816183ybg.2
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 15:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kGdciiRtU2zcsEj4DOiueJ4koz7w2ZBp7qEunWQfGAM=;
        b=TQHK+Lf+TkAkktwdhggL67OHRnWPdbYkgHifKNyaCWLKiITMzTMx0Ub7sq6NNo8p4i
         yZuDPn9i6FkaTG7R8My5CWh0gMjZL4FnHi7Ulp/c/xD9fVwojdIflEoGxxyDtkCBHGQD
         glkvxNM0XmFkgfvLrzICY1dVKNyz2ncOPu11e4hX7Ymz1JQYJs1pudynTFaKVyREGFfk
         NWDuJ/VGfacm68uTXLILEryIffJz2r5vvSmcVp9tH2xuKqqcSV2KVc+n2rFJfGpcPrkb
         FjwBUdT9BgQvrDmqP9bGNoAy+bMlLr7OuevQMASdrMHtp1Tly5Uz4Wqk76u3buDTf1qA
         HzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kGdciiRtU2zcsEj4DOiueJ4koz7w2ZBp7qEunWQfGAM=;
        b=71foVymkh8cVn72RTBZjo1aJDF74CqcIZrNUOEwGh6fYErvTnTTj3Tc+XZJ/TYehWN
         QTsskejJkpUB1NEEZfDX/C3BQjSOdVjbs4IMAAvALr3FXrwyXxYyTTqnKgD0hVUF9vD/
         6hQ4PmytIzMRSwrBlvH0zXsOip6AfsXt/ddea4B37Inr83otAO5ZBImQs/ZwmwZopCJD
         H7mtErHkW4GYbDfmqdeRxlRClVD7ZoZIFpZFExKGcJah7eD1jbIcmD1voWG6aojdQQ6U
         6ryli0gV/P715xRKRZ9RhrWWEn+tKI1GseQnxDvNyZQ049aHZlrYSj4FHIEIAU2X56md
         851Q==
X-Gm-Message-State: AOAM532ncN0It3F777Yj0oYn4Ds3DlW14LfvdwnLAgJGD3NGRKigmzx+
        F2srK/Ie8TAdyx3tiTnEkuxSqSRPQjvH1ZG2QQ8=
X-Google-Smtp-Source: ABdhPJwpZB3BtcLuGPjCXdiwubzAuvpS/4GAZ6+56DY3ZJOMNQOtOjFW3OrAmpcCCBC50R0Pao5BVJh1X0Q2J8c2Umk=
X-Received: by 2002:a25:b204:: with SMTP id i4mr38191007ybj.263.1638226947873;
 Mon, 29 Nov 2021 15:02:27 -0800 (PST)
MIME-Version: 1.0
References: <20211129223725.2770730-1-joannekoong@fb.com> <20211129223725.2770730-5-joannekoong@fb.com>
In-Reply-To: <20211129223725.2770730-5-joannekoong@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 29 Nov 2021 15:02:16 -0800
Message-ID: <CAEf4BzauvgM0zd1f5UX2rAqHG2cgp0r578nvG_QRhmfN8i+jqw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 4/4] selftest/bpf/benchs: add bpf_loop benchmark
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 29, 2021 at 2:39 PM Joanne Koong <joannekoong@fb.com> wrote:
>
> Add benchmark to measure the throughput and latency of the bpf_loop
> call.
>
> Testing this on my dev machine on 1 thread, the data is as follows:
>
>         nr_loops: 10
> bpf_loop - throughput: 198.519 =C2=B1 0.155 M ops/s, latency: 5.037 ns/op
>
>         nr_loops: 100
> bpf_loop - throughput: 247.448 =C2=B1 0.305 M ops/s, latency: 4.041 ns/op
>
>         nr_loops: 500
> bpf_loop - throughput: 260.839 =C2=B1 0.380 M ops/s, latency: 3.834 ns/op
>
>         nr_loops: 1000
> bpf_loop - throughput: 262.806 =C2=B1 0.629 M ops/s, latency: 3.805 ns/op
>
>         nr_loops: 5000
> bpf_loop - throughput: 264.211 =C2=B1 1.508 M ops/s, latency: 3.785 ns/op
>
>         nr_loops: 10000
> bpf_loop - throughput: 265.366 =C2=B1 3.054 M ops/s, latency: 3.768 ns/op
>
>         nr_loops: 50000
> bpf_loop - throughput: 235.986 =C2=B1 20.205 M ops/s, latency: 4.238 ns/o=
p
>
>         nr_loops: 100000
> bpf_loop - throughput: 264.482 =C2=B1 0.279 M ops/s, latency: 3.781 ns/op
>
>         nr_loops: 500000
> bpf_loop - throughput: 309.773 =C2=B1 87.713 M ops/s, latency: 3.228 ns/o=
p
>
>         nr_loops: 1000000
> bpf_loop - throughput: 262.818 =C2=B1 4.143 M ops/s, latency: 3.805 ns/op
>
> From this data, we can see that the latency per loop decreases as the
> number of loops increases. On this particular machine, each loop had an
> overhead of about ~4 ns, and we were able to run ~250 million loops
> per second.
>
> Signed-off-by: Joanne Koong <joannekoong@fb.com>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/testing/selftests/bpf/Makefile          |   4 +-
>  tools/testing/selftests/bpf/bench.c           |  37 ++++++
>  tools/testing/selftests/bpf/bench.h           |   2 +
>  .../selftests/bpf/benchs/bench_bpf_loop.c     | 105 ++++++++++++++++++
>  .../bpf/benchs/run_bench_bpf_loop.sh          |  15 +++
>  .../selftests/bpf/benchs/run_common.sh        |  15 +++
>  .../selftests/bpf/progs/bpf_loop_bench.c      |  26 +++++
>  7 files changed, 203 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/benchs/bench_bpf_loop.c
>  create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_bpf_loop=
.sh
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_loop_bench.c

[...]

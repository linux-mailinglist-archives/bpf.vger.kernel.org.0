Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF59B47815E
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 01:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhLQAfI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Dec 2021 19:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbhLQAfI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Dec 2021 19:35:08 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8FEC061574
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 16:35:08 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id v203so1725169ybe.6
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 16:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YraQaE9LDuMTScX6sEVbDxFlcX2eiWG9hqWi+/P9mIg=;
        b=GxefTaxeGk5KtPcjbhZkHy9T2p04VtJJdN3NnRD6bbveM24y14u35Lrm0SzB8X2rSq
         xKPHrXP/3FRmdvnkyGpwv4xDxTq9cuTLMlU3mTPpYl0u4yFp6IaDTgXN3m9YCZqVEHiH
         imv0cVLHkOWEV9mZlPqQsJFfRqTs4C4/IJFwLQkO3n5fjMsQZ2MNgjB+eka0YFNPGJqi
         Mc8FFzgqGI53Ay1uVsgWWYXjupKZ5Xb9mrzg2JUUPnP13MKQGr1/iA28AJIE0b8mBQoV
         AM1VB8IiZQF2RdWSwENux1Nz61bEg5i5ljUjD60V8KNY6DAFEiDR1YeA/zwKGRXv6Suw
         DC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YraQaE9LDuMTScX6sEVbDxFlcX2eiWG9hqWi+/P9mIg=;
        b=tZMQdh5EWKepOY/cl3Ye1wGk8JctuCBk17Ez8fYgNNz0FKdbSuYTiy5d0PsYE5wz2M
         fu0Te4RzKguLA6IC+G4LZpsFCr8DbSfRQtuMV6JmywQtWwcmT4oAR+Sr95X8xb9YDROQ
         y8WHcOjHLZ/OifUTHXCGzvV6eXOfOhCxttFHT8dOsUUcCIjxwQEqPvtODRM3IwW8nGmC
         nRtlSXLIgjAHWlN1zaQLoVd4CzbqpEj9ZabaAMNdBbeFqaADglb2lgg35E3kovwWfR5O
         3rl+06DDpeuHipTo9YmFP1h42yrBbhfLOka3SJfazJyPLbl/xLZ/tEzkb2kL613JQPyF
         9YGQ==
X-Gm-Message-State: AOAM532AXNw3JKKHf9pZvry7hRT45B5B9tOosXkGpXLR1AURo1QFychT
        ah3qLj3blSRm5AXA4EDJLhINlm+cmapeBoSBhIU=
X-Google-Smtp-Source: ABdhPJyGdrN+Fp/j7hdCGWkY+RtjRVUjp+qXOwtsEuVllsqgj28bn+sThHMtCXgd0XiCNnExzXfbuDQdLy30guXPwHU=
X-Received: by 2002:a25:cf46:: with SMTP id f67mr908940ybg.362.1639701307212;
 Thu, 16 Dec 2021 16:35:07 -0800 (PST)
MIME-Version: 1.0
References: <20211216213358.3374427-1-christylee@fb.com> <20211216213358.3374427-3-christylee@fb.com>
In-Reply-To: <20211216213358.3374427-3-christylee@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 16 Dec 2021 16:34:55 -0800
Message-ID: <CAEf4BzaYsQwVnubjWhM057aa64T4j9TkeCMAkyWDyQofLwUwQQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/3] Right align verifier states in verifier logs
To:     Christy Lee <christylee@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Christy Lee <christyc.y.lee@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 16, 2021 at 1:34 PM Christy Lee <christylee@fb.com> wrote:
>
> Make the verifier logs more readable, print the verifier states
> on the corresponding instruction line. If the previous line was
> not a bpf instruction, then print the verifier states on its own
> line.
>
> Before:
>
> Validating test_pkt_access_subprog3() func#3...
> 86: R1=invP(id=0) R2=ctx(id=0,off=0,imm=0) R10=fp0
> ; int test_pkt_access_subprog3(int val, struct __sk_buff *skb)
> 86: (bf) r6 = r2
> 87: R2=ctx(id=0,off=0,imm=0) R6_w=ctx(id=0,off=0,imm=0)
> 87: (bc) w7 = w1
> 88: R1=invP(id=0) R7_w=invP(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
> ; return get_skb_len(skb) * get_skb_ifindex(val, skb, get_constant(123));
> 88: (bf) r1 = r6
> 89: R1_w=ctx(id=0,off=0,imm=0) R6_w=ctx(id=0,off=0,imm=0)
> 89: (85) call pc+9
> Func#4 is global and valid. Skipping.
> 90: R0_w=invP(id=0)
> 90: (bc) w8 = w0
> 91: R0_w=invP(id=0) R8_w=invP(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
> ; return get_skb_len(skb) * get_skb_ifindex(val, skb, get_constant(123));
> 91: (b7) r1 = 123
> 92: R1_w=invP123
> 92: (85) call pc+65
> Func#5 is global and valid. Skipping.
> 93: R0=invP(id=0)
>
> After:
>
> 86: R1=invP(id=0) R2=ctx(id=0,off=0,imm=0) R10=fp0
> ; int test_pkt_access_subprog3(int val, struct __sk_buff *skb)
> 86: (bf) r6 = r2                      ; R2=ctx(id=0,off=0,imm=0) R6_w=ctx(id=0,off=0,imm=0)
> 87: (bc) w7 = w1                      ; R1=invP(id=0) R7_w=invP(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
> ; return get_skb_len(skb) * get_skb_ifindex(val, skb, get_constant(123));
> 88: (bf) r1 = r6                      ; R1_w=ctx(id=0,off=0,imm=0) R6_w=ctx(id=0,off=0,imm=0)
> 89: (85) call pc+9
> Func#4 is global and valid. Skipping.
> 90: R0_w=invP(id=0)
> 90: (bc) w8 = w0                      ; R0_w=invP(id=0) R8_w=invP(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
> ; return get_skb_len(skb) * get_skb_ifindex(val, skb, get_constant(123));
> 91: (b7) r1 = 123                     ; R1_w=invP123
> 92: (85) call pc+65
> Func#5 is global and valid. Skipping.
> 93: R0=invP(id=0)
>
> Signed-off-by: Christy Lee <christylee@fb.com>
> ---
>  include/linux/bpf_verifier.h                  |   3 +
>  kernel/bpf/verifier.c                         |  61 ++++--
>  .../testing/selftests/bpf/prog_tests/align.c  | 196 ++++++++++--------
>  3 files changed, 147 insertions(+), 113 deletions(-)
>

Checked pyperf50 output, looks great. Thanks for improving verifier logs!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index c66f238c538d..ee931398f311 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -388,6 +388,8 @@ static inline bool bpf_verifier_log_full(const struct bpf_verifier_log *log)
>  #define BPF_LOG_LEVEL  (BPF_LOG_LEVEL1 | BPF_LOG_LEVEL2)
>  #define BPF_LOG_MASK   (BPF_LOG_LEVEL | BPF_LOG_STATS)
>  #define BPF_LOG_KERNEL (BPF_LOG_MASK + 1) /* kernel internal flag */
> +#define BPF_LOG_MIN_ALIGNMENT 8U
> +#define BPF_LOG_ALIGNMENT 40U
>

[...]

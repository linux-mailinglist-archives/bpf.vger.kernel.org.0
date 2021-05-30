Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F7E394FC1
	for <lists+bpf@lfdr.de>; Sun, 30 May 2021 08:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbhE3GBF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 30 May 2021 02:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhE3GBF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 30 May 2021 02:01:05 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DFDC061574
        for <bpf@vger.kernel.org>; Sat, 29 May 2021 22:59:26 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id s107so8011534ybi.3
        for <bpf@vger.kernel.org>; Sat, 29 May 2021 22:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6k1iqnRHu0ZAozGTSa4AIg/hgHRDLMs4qR91UwP4VzU=;
        b=foY7Qc7JHg6bGe9L9HpfpOzLdbukMIFVuQePRa87FZTnl4BMtMpdjr2M79PVPPvSQP
         vizdIVRv2gBnuTap+WK29bkH8YBzNh3Yd4iWkdS/cuQ1bIsdIVl0S/8uwuqr4r8uW9cM
         WMMV9UQdfBMLF/QF3d4IcYJMffJ7Ns0AWFyR2z0bcLWW3eyr46HFOf+d7oQBf6GRhyiI
         /D5VCm4RIamkG8NKYJndDJoKBvF3qjEzzs8BJWlpPXlbfQ+a8kRWzszD8pDmPD7j7m2X
         7lhhBXbJmmhksKAYOzRWqtkMsuAcQTDuJZJCCJFaxO1mIYlmuZ6Y/TIndjne0Xz7LZWd
         0KZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6k1iqnRHu0ZAozGTSa4AIg/hgHRDLMs4qR91UwP4VzU=;
        b=A8Bzu0MRcUXW39401S0t65/hSjy/uo10m1U/xHQSjKt2dTYhe7jb386L65dLIWPxWo
         Nw+SsQ1y/KpAI9JYvjxWX/Baurivi89XSDvY6skoWLtRslKCoT/EDApQHZVDPXioI8YP
         T0MY1Z79A924PwWBwZSq1ndHsrZelwqhjO2ApDRnz1thrJJKf+KQmR3CU1TNs+AIGBL0
         f49jipYIoQG6MgI/nxoWAJl4Bwz5eUKo8YirAgAC6W2Tn9dhbJ8vZ5zPUC6JfaBdcsaG
         TJKwvNOmuLDYqUzl/dslMfyeU3wPMXnhCfPKEEWuwE0X+fMhPSD4GhzW0FWuRqhk0F4m
         2yHw==
X-Gm-Message-State: AOAM533cXDR/aRkmd+mGQcILmom7hiGaQ58p6YH7pR2HMmh0pczXlOFv
        f8K2rpV74wtMafa0MYprI0K3m+uFdnp5H8bqoEI=
X-Google-Smtp-Source: ABdhPJyh4ntxpRjgytDNXBSp/GCx1wJN72I3vfYkHM1bEqs5ZkW/DRifi/iObHjnChuqWQE4tF2d2dEZ4AX2vQR8nPo=
X-Received: by 2002:a25:7246:: with SMTP id n67mr23976787ybc.510.1622354365261;
 Sat, 29 May 2021 22:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210528035520.3445-1-harishankar.vishwanathan@rutgers.edu>
In-Reply-To: <20210528035520.3445-1-harishankar.vishwanathan@rutgers.edu>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 29 May 2021 22:59:14 -0700
Message-ID: <CAEf4BzYnTYdDnVuEuiHpg=LWT_JvwJim8kTEBpGKrH3wePez2Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: tnums: Provably sound, faster, and more
 precise algorithm for tnum_mul
To:     hv90@scarletmail.rutgers.edu
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Harishankar Vishwanathan <harishankar.vishwanathan@rutgers.edu>,
        Matan Shachnai <m.shachnai@rutgers.edu>,
        Srinivas Narayana <srinivas.narayana@rutgers.edu>,
        Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>,
        Edward Cree <ecree@solarflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 27, 2021 at 11:14 PM <hv90@scarletmail.rutgers.edu> wrote:
>
> From: Harishankar Vishwanathan <harishankar.vishwanathan@rutgers.edu>
>
> This patch introduces a new algorithm for multiplication of tristate
> numbers (tnums) that is provably sound. It is faster and more precise when
> compared to the existing method.
>
> Like the existing method, this new algorithm follows the long
> multiplication algorithm. The idea is to generate partial products by
> multiplying each bit in the multiplier (tnum a) with the multiplicand
> (tnum b), and adding the partial products after appropriately bit-shifting
> them. The new algorithm, however, uses just a single loop over the bits of
> the multiplier (tnum a) and accumulates only the uncertain components of
> the multiplicand (tnum b) into a mask-only tnum. The following paper
> explains the algorithm in more detail: https://arxiv.org/abs/2105.05398.

This is a nice paper, I appreciated tables with algorithms pseudo-code
and specific examples with uncertain bits, thanks!

I think your algorithm makes sense, but I've also CC'ed original
author of tnum logic. Edward, please take a look as well.

See below mostly styling nits.

>
> A natural way to construct the tnum product is by performing a tnum
> addition on all the partial products. This algorithm presents another
> method of doing this: decompose each partial product into two tnums,
> consisting of the values and the masks separately. The mask-sum is
> accumulated within the loop in acc_m. The value-sum tnum is generated
> using a.value * b.value. The tnum constructed by tnum addition of the
> value-sum and the mask-sum contains all possible summations of concrete
> values drawn from the partial product tnums pairwise. We prove this result
> in the paper.
>
> Our evaluations show that the new algorithm is overall more precise
> (producing tnums with less uncertain components) than the existing method.
> As an illustrative example, consider the input tnums A and B. The numbers
> in the paranthesis correspond to (value;mask).
>
> A                = 000000x1 (1;2)
> B                = 0010011x (38;1)
> A * B (existing) = xxxxxxxx (0;255)
> A * B (new)      = 0x1xxxxx (32;95)
>
> Importantly, we present a proof of soundness of the new algorithm in the
> aforementioned paper. Additionally, we show that this new algorithm is
> empirically faster than the existing method.
>
> Co-developed-by: Matan Shachnai <m.shachnai@rutgers.edu>
> Signed-off-by: Matan Shachnai <m.shachnai@rutgers.edu>
> Co-developed-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
> Signed-off-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
> Co-developed-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
> Signed-off-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
> Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@rutgers.edu>
> ---
>  kernel/bpf/tnum.c | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
> index ceac5281bd31..bb1fa1cc181d 100644
> --- a/kernel/bpf/tnum.c
> +++ b/kernel/bpf/tnum.c
> @@ -111,30 +111,30 @@ struct tnum tnum_xor(struct tnum a, struct tnum b)
>         return TNUM(v & ~mu, mu);
>  }
>
> -/* half-multiply add: acc += (unknown * mask * value).
> - * An intermediate step in the multiply algorithm.
> - */
> -static struct tnum hma(struct tnum acc, u64 value, u64 mask)
> +struct tnum tnum_mul(struct tnum a, struct tnum b)

It's probably a good idea to have a short description (from your
commit description above) of the algorithm in the comment above this
function, with a link to your paper.

>  {
> -       while (mask) {
> -               if (mask & 1)
> -                       acc = tnum_add(acc, TNUM(0, value));
> -               mask >>= 1;
> -               value <<= 1;
> -       }
> -       return acc;
> -}
> +       u64 acc_v = a.value * b.value;
> +       struct tnum acc_m = TNUM(0, 0);
>
> -struct tnum tnum_mul(struct tnum a, struct tnum b)
> -{
> -       struct tnum acc;
> -       u64 pi;
> +       while (a.value > 0 || a.mask > 0) {

`while (a.value || a.mask)` is shorter and doesn't imply that a.value
or a.mask can be < 0 (otherwise you'd write != 0, right? ;)

> +

unnecessary empty line

> +               // LSB of tnum a is a certain 1

please use C-style comments /* */

> +               if (((a.value & 1) == 1) && ((a.mask & 1) == 0))

just if (a.value & 1) is enough. if a.value == 1, a.mask has to be 0,
right? and (x & 1) == 1 is just a more verbose way of saying (x & 1)
is non-zero, which in C is just if (x & 1).

> +                       acc_m = tnum_add(acc_m, TNUM(0, b.mask));
>
> -       pi = a.value * b.value;
> -       acc = hma(TNUM(pi, 0), a.mask, b.mask | b.value);
> -       return hma(acc, b.mask, a.value);
> +               // LSB of tnum a is uncertain
> +               else if ((a.mask & 1) == 1)

same about comment style and simpler if statement; also another comment below

> +                       acc_m = tnum_add(acc_m, TNUM(0, b.value | b.mask));
> +
> +               // Note: no case for LSB is certain 0
> +               a = tnum_rshift(a, 1);
> +               b = tnum_lshift(b, 1);
> +       }
> +
> +       return tnum_add(TNUM(acc_v, 0), acc_m);
>  }
>
> +

another unnecessary empty line

>  /* Note that if a and b disagree - i.e. one has a 'known 1' where the other has
>   * a 'known 0' - this will return a 'known 1' for that bit.
>   */
> --
> 2.25.1
>

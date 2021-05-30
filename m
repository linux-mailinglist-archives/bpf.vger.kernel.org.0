Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADE3395357
	for <lists+bpf@lfdr.de>; Mon, 31 May 2021 01:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhE3XHr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 30 May 2021 19:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhE3XHr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 30 May 2021 19:07:47 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF5FC061574
        for <bpf@vger.kernel.org>; Sun, 30 May 2021 16:06:07 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id d25so10160952ioe.1
        for <bpf@vger.kernel.org>; Sun, 30 May 2021 16:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scarletmail.rutgers.edu; s=google-20180529;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=LakjWdnDAno7HxIc48J9MTwSZOZKfKDJWjlCDkDj24k=;
        b=F094EM+XvQgaC1l7v7BO6Jk3FXcNQU5a8+GWj7yrK9+AS/8TfHv0ftj7QW60+wHeHF
         vLDgtya6fiHFCLE5Ai3AAPbCI+qFU8zjNcaPxoO75UlwWuu/YU3fPW/E2Yxrz5y52nGi
         gxaFJXa6Pbvm6AI+T1gxlNDhSu9xOq5/jDSLdpT7BvIpiQjBp5xhuXjWXOht15KOUYYd
         sKR+V4QeXRKf8GklIrqArfDyTi648qruynoJEvQY9AY7tO8XZTapKDhXyXu9xq9IPLGZ
         UhwHAtO6ZyOLMZlCceUcDREHihGqCn4HZ9Au/mZjDNqDDr4c451MHVVdtVl39178vHYv
         Kyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=LakjWdnDAno7HxIc48J9MTwSZOZKfKDJWjlCDkDj24k=;
        b=YQppyN3J9X/sXEiBNcAe9arZvCqIv9J9W2O+Bce+rQ8G9Lyn3e92h0h0xB35kJ9QNQ
         94epDoBv8Mys8HrOOzTo5XUQ/lvMgD7tCGRXVYV6A0FEWmFSmybFTYBasWHgtM79dyAH
         OXyRbsfWakMgxkmA/go9MXC3tMkG9BdgG5xZlWDfzKkwJ9TLq7aT5Nd/xHCbg3bleHUv
         5Q0Pbf6DRYLzXg16YKvrFbcrutojvKgTfXwW8y51tYlUe+aDxrsiwSq/QjS7jPKkS992
         IKElQ5quy/o9gCP2J6e+wnin0YHf5XUaE8aFeAR4UZ0Rymn9NQz8XxN640wJurVYIwkC
         Twtg==
X-Gm-Message-State: AOAM531i1GeQi0HncQR5bxBN6gJgJfQ9qBUK9juYOb9S8OACiGpYOumP
        NBmfb/qnYNtDhIZxO+5B/hik9sx0zebqoXkjljfdtPySd14ecETD
X-Google-Smtp-Source: ABdhPJzYEnBXSuCzqNZ5QyGC7ChF3e4UDdPyBvx+4nmvI3rSPrrVL6qpNTHTUF/TnTPQQA46XsHgYJcBiOlgWL35YvE=
X-Received: by 2002:a5d:9916:: with SMTP id x22mr14845663iol.160.1622415966440;
 Sun, 30 May 2021 16:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210528035520.3445-1-harishankar.vishwanathan@rutgers.edu> <CAEf4BzYnTYdDnVuEuiHpg=LWT_JvwJim8kTEBpGKrH3wePez2Q@mail.gmail.com>
In-Reply-To: <CAEf4BzYnTYdDnVuEuiHpg=LWT_JvwJim8kTEBpGKrH3wePez2Q@mail.gmail.com>
From:   HARISHANKAR VISHWANATHAN <hv90@scarletmail.rutgers.edu>
Date:   Sun, 30 May 2021 19:05:55 -0400
Message-ID: <CAFGy+khFuxtPskgoGvHcsVUBHscC9-FvSqC16A3rw=+V7S8kyA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: tnums: Provably sound, faster, and more
 precise algorithm for tnum_mul
To:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thanks for reviewing this patch, Andrii. All of your comments make sense to us.
We will resend the patch with the fixes you requested.


On Sun, May 30, 2021 at 1:59 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, May 27, 2021 at 11:14 PM <hv90@scarletmail.rutgers.edu> wrote:
> >
> > From: Harishankar Vishwanathan <harishankar.vishwanathan@rutgers.edu>
> >
> > This patch introduces a new algorithm for multiplication of tristate
> > numbers (tnums) that is provably sound. It is faster and more precise when
> > compared to the existing method.
> >
> > Like the existing method, this new algorithm follows the long
> > multiplication algorithm. The idea is to generate partial products by
> > multiplying each bit in the multiplier (tnum a) with the multiplicand
> > (tnum b), and adding the partial products after appropriately bit-shifting
> > them. The new algorithm, however, uses just a single loop over the bits of
> > the multiplier (tnum a) and accumulates only the uncertain components of
> > the multiplicand (tnum b) into a mask-only tnum. The following paper
> > explains the algorithm in more detail: https://arxiv.org/abs/2105.05398.
>
> This is a nice paper, I appreciated tables with algorithms pseudo-code
> and specific examples with uncertain bits, thanks!
>
> I think your algorithm makes sense, but I've also CC'ed original
> author of tnum logic. Edward, please take a look as well.
>
> See below mostly styling nits.
>
> >
> > A natural way to construct the tnum product is by performing a tnum
> > addition on all the partial products. This algorithm presents another
> > method of doing this: decompose each partial product into two tnums,
> > consisting of the values and the masks separately. The mask-sum is
> > accumulated within the loop in acc_m. The value-sum tnum is generated
> > using a.value * b.value. The tnum constructed by tnum addition of the
> > value-sum and the mask-sum contains all possible summations of concrete
> > values drawn from the partial product tnums pairwise. We prove this result
> > in the paper.
> >
> > Our evaluations show that the new algorithm is overall more precise
> > (producing tnums with less uncertain components) than the existing method.
> > As an illustrative example, consider the input tnums A and B. The numbers
> > in the paranthesis correspond to (value;mask).
> >
> > A                = 000000x1 (1;2)
> > B                = 0010011x (38;1)
> > A * B (existing) = xxxxxxxx (0;255)
> > A * B (new)      = 0x1xxxxx (32;95)
> >
> > Importantly, we present a proof of soundness of the new algorithm in the
> > aforementioned paper. Additionally, we show that this new algorithm is
> > empirically faster than the existing method.
> >
> > Co-developed-by: Matan Shachnai <m.shachnai@rutgers.edu>
> > Signed-off-by: Matan Shachnai <m.shachnai@rutgers.edu>
> > Co-developed-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
> > Signed-off-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
> > Co-developed-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
> > Signed-off-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
> > Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@rutgers.edu>
> > ---
> >  kernel/bpf/tnum.c | 38 +++++++++++++++++++-------------------
> >  1 file changed, 19 insertions(+), 19 deletions(-)
> >
> > diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
> > index ceac5281bd31..bb1fa1cc181d 100644
> > --- a/kernel/bpf/tnum.c
> > +++ b/kernel/bpf/tnum.c
> > @@ -111,30 +111,30 @@ struct tnum tnum_xor(struct tnum a, struct tnum b)
> >         return TNUM(v & ~mu, mu);
> >  }
> >
> > -/* half-multiply add: acc += (unknown * mask * value).
> > - * An intermediate step in the multiply algorithm.
> > - */
> > -static struct tnum hma(struct tnum acc, u64 value, u64 mask)
> > +struct tnum tnum_mul(struct tnum a, struct tnum b)
>
> It's probably a good idea to have a short description (from your
> commit description above) of the algorithm in the comment above this
> function, with a link to your paper.
>
> >  {
> > -       while (mask) {
> > -               if (mask & 1)
> > -                       acc = tnum_add(acc, TNUM(0, value));
> > -               mask >>= 1;
> > -               value <<= 1;
> > -       }
> > -       return acc;
> > -}
> > +       u64 acc_v = a.value * b.value;
> > +       struct tnum acc_m = TNUM(0, 0);
> >
> > -struct tnum tnum_mul(struct tnum a, struct tnum b)
> > -{
> > -       struct tnum acc;
> > -       u64 pi;
> > +       while (a.value > 0 || a.mask > 0) {
>
> `while (a.value || a.mask)` is shorter and doesn't imply that a.value
> or a.mask can be < 0 (otherwise you'd write != 0, right? ;)
>
> > +
>
> unnecessary empty line
>
> > +               // LSB of tnum a is a certain 1
>
> please use C-style comments /* */
>
> > +               if (((a.value & 1) == 1) && ((a.mask & 1) == 0))
>
> just if (a.value & 1) is enough. if a.value == 1, a.mask has to be 0,
> right? and (x & 1) == 1 is just a more verbose way of saying (x & 1)
> is non-zero, which in C is just if (x & 1).
>
> > +                       acc_m = tnum_add(acc_m, TNUM(0, b.mask));
> >
> > -       pi = a.value * b.value;
> > -       acc = hma(TNUM(pi, 0), a.mask, b.mask | b.value);
> > -       return hma(acc, b.mask, a.value);
> > +               // LSB of tnum a is uncertain
> > +               else if ((a.mask & 1) == 1)
>
> same about comment style and simpler if statement; also another comment below
>
> > +                       acc_m = tnum_add(acc_m, TNUM(0, b.value | b.mask));
> > +
> > +               // Note: no case for LSB is certain 0
> > +               a = tnum_rshift(a, 1);
> > +               b = tnum_lshift(b, 1);
> > +       }
> > +
> > +       return tnum_add(TNUM(acc_v, 0), acc_m);
> >  }
> >
> > +
>
> another unnecessary empty line
>
> >  /* Note that if a and b disagree - i.e. one has a 'known 1' where the other has
> >   * a 'known 0' - this will return a 'known 1' for that bit.
> >   */
> > --
> > 2.25.1
> >

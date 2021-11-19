Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3870D457917
	for <lists+bpf@lfdr.de>; Fri, 19 Nov 2021 23:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhKSWxR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Nov 2021 17:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhKSWxR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Nov 2021 17:53:17 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB45C061574
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 14:50:14 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id e71so32253113ybh.10
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 14:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jFnAyqRNBDZXgciB9ocFvfGpVuJAFrXbU4gUZrut3RA=;
        b=OxzUxx19XgCmBs/Mpz/zPlIuuGUHEE/mNnQg26O9g+Y2VbhPVV9TLDYw+DA+jerm6R
         Ijf4T3Y2mqxhmvQ9pQrkHo21NNw1EsqYGsaD8aT1dqbqdQ73dy+2yaLeCCazo90WNlwn
         gbsvwIDbVZ9YPP3PQ4/DxQrRHZCtJ1DUJHZxNOErLI0yrnBjp1TLFvqnSlN/J5wU/xBb
         wS6VcviLdxCKkR+HLuAF7e4VPuSx9vASi8fxpyJ6mhdd5yPfRo7xT06s3BjuBXP39wq5
         Yy745v9wXSWRcIAfzP98xl+3sm0K/qT64tGEsW5M+ZHr6+Cl9dsoV7+xSkjIUtZOUrkR
         HupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jFnAyqRNBDZXgciB9ocFvfGpVuJAFrXbU4gUZrut3RA=;
        b=rdfUFMp/uk+4C0aJvJq6YUefwMSvDLeg9OQuiF9Xzrm+2EaNs+Tmf9fVfvz/KQV94D
         6x60Bow5gt/SW5rJ14gVhGzhgMrYk7IC9XcG63fhXmCmUjlxZzyxe5WPpf/SfZiI3Atl
         nyH7KZe4KTlFZXajFiExwl0fTeYLPHubKZsRTC+4ZDHOillG3bKoy2CBHO3vZbywuU5I
         g23IFkmvwDB4c1BGQdxIN9Qo4UgbcQhlpPCDh/cZX2SOlUP6A2BCaQS/mYvORSL1zcnE
         olBU7GVa0LMZnVXlPdSoS7SVcQr0h4kiENgc4xiALg7Dq7qvUrtYY6bPsgqA+HJiIKzM
         mjzw==
X-Gm-Message-State: AOAM530dHgB+NJJbfXcAXFEvnhU9YgOAIIi3/jPpedir6QFX+YpsQBIj
        nzI+mgXiYWlpHEzlqaVpcujUtm9jb9x3meGWmJE=
X-Google-Smtp-Source: ABdhPJx8KqKDgpQw7jUgi3+q/eC8G0k7RxMR8S494+8QV/nIgfD0sweO/eG8tfN0JUc35r1SGq2KJ9FZxAacdWpVMDo=
X-Received: by 2002:a25:d16:: with SMTP id 22mr40872759ybn.51.1637362214196;
 Fri, 19 Nov 2021 14:50:14 -0800 (PST)
MIME-Version: 1.0
References: <20211118010404.2415864-1-joannekoong@fb.com> <20211118010404.2415864-4-joannekoong@fb.com>
 <87r1bdemq4.fsf@toke.dk> <CAEf4BzZMJfSqx9wLq9ntSK+n4kE82S_ifgFhBVtjYiy0vz4Gyg@mail.gmail.com>
 <874k88e1or.fsf@toke.dk>
In-Reply-To: <874k88e1or.fsf@toke.dk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 19 Nov 2021 14:50:03 -0800
Message-ID: <CAEf4BzZKtV1_=s7mXUnvvR4BQT6CFm60uuc8F1gv5Hzb=_xkKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftest/bpf/benchs: add bpf_for_each benchmark
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Joanne Koong <joannekoong@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 19, 2021 at 5:04 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > On Thu, Nov 18, 2021 at 3:18 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@=
redhat.com> wrote:
> >>
> >> Joanne Koong <joannekoong@fb.com> writes:
> >>
> >> > Add benchmark to measure the overhead of the bpf_for_each call
> >> > for a specified number of iterations.
> >> >
> >> > Testing this on qemu on my dev machine on 1 thread, the data is
> >> > as follows:
> >>
> >> Absolute numbers from some random dev machine are not terribly useful;
> >> others have no way of replicating your tests. A more meaningful
> >> benchmark would need a baseline to compare to; in this case I guess th=
at
> >> would be a regular loop? Do you have any numbers comparing the callbac=
k
> >> to just looping?
> >
> > Measuring empty for (int i =3D 0; i < N; i++) is meaningless, you shoul=
d
> > expect a number in billions of "operations" per second on modern
> > server CPUs. So that will give you no idea. Those numbers are useful
> > as a ballpark number of what's the overhead of bpf_for_each() helper
> > and callbacks. And 12ns per "iteration" is meaningful to have a good
> > idea of how slow that can be. Depending on your hardware it can be
> > different by 2x, maybe 3x, but not 100x.
> >
> > But measuring inc + cmp + jne as a baseline is both unrealistic and
> > doesn't give much more extra information. But you can assume 2B/s,
> > give or take.
> >
> > And you also can run this benchmark on your own on your hardware to
> > get "real" numbers, as much as you can expect real numbers from
> > artificial microbenchmark, of course.
> >
> >
> > I read those numbers as "plenty fast" :)
>
> Hmm, okay, fair enough, but I think it would be good to have the "~12 ns
> per iteration" figure featured prominently in the commit message, then :)
>

We discussed with Joanne offline adding an ops_report_final() helper
that will output both throughput (X ops/s) and latency/overhead (
(1000000000/X) ns/op), so that no one had to do any math.

> -Toke
>

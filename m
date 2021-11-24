Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E0445CD30
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 20:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244488AbhKXT3j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Nov 2021 14:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243875AbhKXT3h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Nov 2021 14:29:37 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46B7C061574
        for <bpf@vger.kernel.org>; Wed, 24 Nov 2021 11:26:26 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 131so10274560ybc.7
        for <bpf@vger.kernel.org>; Wed, 24 Nov 2021 11:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a+dI2wDLsS1/9fyg0rnaZfOnD56qRBuT9MS1O04U1Xw=;
        b=WTlaoE87eF/vuzS9yF3g+5UIDJ4Dlnla7NBwW2ssZYAMS27iOPg8NhNCQxJpoO68hl
         Lbp70XeVzvslWXyE13duHCNy6EhQIzHMv31b1ouDChNurxWH2jbuaZK08q8/eyw61ft6
         5SHzBXNCuhJX9lCfkUJitlIZO5t9m1FTU5kLWlQwu0p12QDpWgvaUAP2qi8A3tFsG8dg
         qIqSZRkW5Ma1nrm2QpmF4ENpoqrWQFmB3zv0qMa7PZyqoI565CeM21N6vkcDNwJ5ztnQ
         q11LoTPCwyCvN8Lfnfl72EyOON5sCtbvJx02dTUhfKGgyZbFicdjlKmeTW5MK5Qu+s4b
         ZiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a+dI2wDLsS1/9fyg0rnaZfOnD56qRBuT9MS1O04U1Xw=;
        b=4KqSHsvuHAZqms5wt1uG113zxpJwRG7j86leQNdkkpBVnIcQKKG+EBJbFD7Y8vtMRA
         oLzWpCQ4SJSzyxA1V85BI7EBng6LwQ1mLHcGkR7k/I2aoaYXA8tWoy18FK4VsZqti723
         KpfP2pl5NXQGoRCRLNzeKnzjJQne4mns8Zyidk1MyAdMUFW3+vLn00E4NQJwtbHHdDM7
         iurs/im+oPAhGmoX8Rwnygbfhv8U3pxVfjIy+kUlmdgrbuSAkz3vCVK5qpnyXOr6x/Qx
         tCAFbXACZWEVJjwVgp8kAnUtvtETJq2KtqBG4V6wDMQKQSx3F/UqYHMCBfmUE6TvsWza
         YJTQ==
X-Gm-Message-State: AOAM531acZdOfg/hXemrz9ZGWvC1WKVTb2m+bCbTD17w35ijWWPNUyHs
        Idy4Zeq/O/IFt3ExtPJ2U/I7rVt9iwxSZBYFCsFVGSj3WjsacQ==
X-Google-Smtp-Source: ABdhPJxiV4BZKlGOFcIoBsL8MAUQDr6mhQUL2qyCKWrbM67x87RBbUwmcGgeYajemOyLdJy4vaOI7PS7yyoIC5g/INo=
X-Received: by 2002:a25:42c1:: with SMTP id p184mr17400916yba.433.1637781986112;
 Wed, 24 Nov 2021 11:26:26 -0800 (PST)
MIME-Version: 1.0
References: <20211123183409.3599979-1-joannekoong@fb.com> <20211123183409.3599979-5-joannekoong@fb.com>
 <87y25ebry1.fsf@toke.dk> <3eaa1a93-c3f1-830a-b711-117b27102cc5@fb.com> <87r1b5btl0.fsf@toke.dk>
In-Reply-To: <87r1b5btl0.fsf@toke.dk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 24 Nov 2021 11:26:15 -0800
Message-ID: <CAEf4BzbB6utDjOJLZzwbBEoAgdO774=PX8O9dWeZJRzM2kdxaQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/4] selftest/bpf/benchs: add bpf_loop benchmark
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Joanne Koong <joannekoong@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 24, 2021 at 4:56 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Joanne Koong <joannekoong@fb.com> writes:
>
> > On 11/23/21 11:19 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >
> >> Joanne Koong <joannekoong@fb.com> writes:
> >>
> >>> Add benchmark to measure the throughput and latency of the bpf_loop
> >>> call.
> >>>
> >>> Testing this on qemu on my dev machine on 1 thread, the data is
> >>> as follows:
> >>>
> >>>          nr_loops: 1
> >>> bpf_loop - throughput: 43.350 =C2=B1 0.864 M ops/s, latency: 23.068 n=
s/op
> >>>
> >>>          nr_loops: 10
> >>> bpf_loop - throughput: 69.586 =C2=B1 1.722 M ops/s, latency: 14.371 n=
s/op
> >>>
> >>>          nr_loops: 100
> >>> bpf_loop - throughput: 72.046 =C2=B1 1.352 M ops/s, latency: 13.880 n=
s/op
> >>>
> >>>          nr_loops: 500
> >>> bpf_loop - throughput: 71.677 =C2=B1 1.316 M ops/s, latency: 13.951 n=
s/op
> >>>
> >>>          nr_loops: 1000
> >>> bpf_loop - throughput: 69.435 =C2=B1 1.219 M ops/s, latency: 14.402 n=
s/op
> >>>
> >>>          nr_loops: 5000
> >>> bpf_loop - throughput: 72.624 =C2=B1 1.162 M ops/s, latency: 13.770 n=
s/op
> >>>
> >>>          nr_loops: 10000
> >>> bpf_loop - throughput: 75.417 =C2=B1 1.446 M ops/s, latency: 13.260 n=
s/op
> >>>
> >>>          nr_loops: 50000
> >>> bpf_loop - throughput: 77.400 =C2=B1 2.214 M ops/s, latency: 12.920 n=
s/op
> >>>
> >>>          nr_loops: 100000
> >>> bpf_loop - throughput: 78.636 =C2=B1 2.107 M ops/s, latency: 12.717 n=
s/op
> >>>
> >>>          nr_loops: 500000
> >>> bpf_loop - throughput: 76.909 =C2=B1 2.035 M ops/s, latency: 13.002 n=
s/op
> >>>
> >>>          nr_loops: 1000000
> >>> bpf_loop - throughput: 77.636 =C2=B1 1.748 M ops/s, latency: 12.881 n=
s/op
> >>>
> >>>  From this data, we can see that the latency per loop decreases as th=
e
> >>> number of loops increases. On this particular machine, each loop had =
an
> >>> overhead of about ~13 ns, and we were able to run ~70 million loops
> >>> per second.
> >> The latency figures are great, thanks! I assume these numbers are with
> >> retpolines enabled? Otherwise 12ns seems a bit much... Or is this
> >> because of qemu?
> > I just tested it on a machine (without retpoline enabled) that runs on
> > actual
> > hardware and here is what I found:
> >
> >              nr_loops: 1
> >      bpf_loop - throughput: 46.780 =C2=B1 0.064 M ops/s, latency: 21.37=
7 ns/op
> >
> >              nr_loops: 10
> >      bpf_loop - throughput: 198.519 =C2=B1 0.155 M ops/s, latency: 5.03=
7 ns/op
> >
> >              nr_loops: 100
> >      bpf_loop - throughput: 247.448 =C2=B1 0.305 M ops/s, latency: 4.04=
1 ns/op
> >
> >              nr_loops: 500
> >      bpf_loop - throughput: 260.839 =C2=B1 0.380 M ops/s, latency: 3.83=
4 ns/op
> >
> >              nr_loops: 1000
> >      bpf_loop - throughput: 262.806 =C2=B1 0.629 M ops/s, latency: 3.80=
5 ns/op
> >
> >              nr_loops: 5000
> >      bpf_loop - throughput: 264.211 =C2=B1 1.508 M ops/s, latency: 3.78=
5 ns/op
> >
> >              nr_loops: 10000
> >      bpf_loop - throughput: 265.366 =C2=B1 3.054 M ops/s, latency: 3.76=
8 ns/op
> >
> >              nr_loops: 50000
> >      bpf_loop - throughput: 235.986 =C2=B1 20.205 M ops/s, latency: 4.2=
38 ns/op
> >
> >              nr_loops: 100000
> >      bpf_loop - throughput: 264.482 =C2=B1 0.279 M ops/s, latency: 3.78=
1 ns/op
> >
> >              nr_loops: 500000
> >      bpf_loop - throughput: 309.773 =C2=B1 87.713 M ops/s, latency: 3.2=
28 ns/op
> >
> >              nr_loops: 1000000
> >      bpf_loop - throughput: 262.818 =C2=B1 4.143 M ops/s, latency: 3.80=
5 ns/op
> >
> > The latency is about ~4ns / loop.
> >
> > I will update the commit message in v3 with these new numbers as well.
>
> Right, awesome, thank you for the additional test. This is closer to
> what I would expect: on the hardware I'm usually testing on, a function
> call takes ~1.5ns, but the difference might just be the hardware, or
> because these are indirect calls.
>
> Another comparison just occurred to me (but it's totally OK if you don't
> want to add any more benchmarks):
>
> The difference between a program that does:
>
> bpf_loop(nr_loops, empty_callback, NULL, 0);
>
> and
>
> for (i =3D 0; i < nr_loops; i++)
>   empty_callback();

You are basically trying to measure the overhead of bpf_loop() helper
call itself, because other than that it should be identical. We can
estimate that already from the numbers Joanne posted above:

             nr_loops: 1
      bpf_loop - throughput: 46.780 =C2=B1 0.064 M ops/s, latency: 21.377 n=
s/op
             nr_loops: 1000
      bpf_loop - throughput: 262.806 =C2=B1 0.629 M ops/s, latency: 3.805 n=
s/op

nr_loops:1 is bpf_loop() overhead and one static callback call.
bpf_loop()'s own overhead will be in the ballpark of 21.4 - 3.8 =3D
17.6ns. I don't think we need yet another benchmark just for this.


>
> should show the difference between the indirect call in the helper and a
> direct call from BPF (and show what the potential performance gain from
> having the verifier inline the helper would be). This was more
> interesting when there was a ~10x delta than a ~2x between your numbers
> and mine, so also totally OK to leave this as-is, and we can cycle back
> to such optimisations if it turns out to be necessary...
>
> -Toke
>

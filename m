Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E51E45CF85
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 22:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244786AbhKXWC1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Nov 2021 17:02:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50965 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244346AbhKXWC0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Nov 2021 17:02:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637791156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tne9DSPkYK3oYpj21wMODg7Pkl387TQe224GfF4MK60=;
        b=WdAhKz0U+nCQJA8weBzHbVADvU2m8B4ovNhX3EIhQQfVLg10YqCiV92d6L/qElOcTqj62Z
        n6I8uJv5B+LDyNHE14dPehnhXNwdNxbS9dqRgbtR+UxJrSbJ/C4FcNqQdbvSVUeJEOjjff
        lKD2OQvTDxKmZf3LiIB9WgFDfj/bqgo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-425-A7R83Sa-NxiHbMjKjCK6ZA-1; Wed, 24 Nov 2021 16:59:14 -0500
X-MC-Unique: A7R83Sa-NxiHbMjKjCK6ZA-1
Received: by mail-ed1-f70.google.com with SMTP id bx28-20020a0564020b5c00b003e7c42443dbso3566132edb.15
        for <bpf@vger.kernel.org>; Wed, 24 Nov 2021 13:59:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=tne9DSPkYK3oYpj21wMODg7Pkl387TQe224GfF4MK60=;
        b=6KtNON2GsKRI5HOxQLl47RrACu/4vg2oo60zwtKTAcSGEOVEenNon8q5sy8AHk5YhN
         44RaujcScc2GhHVRd3S3glenAodEGM25k0dDGlYIR2lAMXHB755XUnng6An7Nm7UmYSL
         k7jf4EdR5XIfvRCvMWlg4D5pfsbAocc5lJPDtVhSM8yf1FNVJ/NfYiHvfmblZ95NyZl1
         B5STPCaPcmNwu/INIKwoWQtNjKrmGdRGrB7iFIrCNFMNxnuSm2lkndiZuur/tGKnkh1u
         mYbbt2MljNiZXDBml/KWpmwFy2/Z/ydw1G8DcGdoljCRPdk9fAgPNL1uDVOJBWTfiV3P
         1rFg==
X-Gm-Message-State: AOAM5333pk7SXd5r6xlHuGCbTqLvGJY3orFfaMhuKglYBTn6WZri1OZw
        0LrGr0cprHm+eQ/Y2LFHJUX2i8rolaFEeo6LPE0tebkn08/3wd3xUWlUseXyCKCk8x+vQUgvn1R
        sxZAHRXfASxOY
X-Received: by 2002:a17:907:3f04:: with SMTP id hq4mr24401499ejc.202.1637791152996;
        Wed, 24 Nov 2021 13:59:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzqew4EIen51FrsivFPvoEFJO/NRGk99pcb6iyivDuFKGgInYOvRXdy3mDsSaYbh4MJMK5KmA==
X-Received: by 2002:a17:907:3f04:: with SMTP id hq4mr24401378ejc.202.1637791152094;
        Wed, 24 Nov 2021 13:59:12 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id jy28sm495734ejc.118.2021.11.24.13.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 13:59:11 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A588D18029C; Wed, 24 Nov 2021 22:59:10 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Joanne Koong <joannekoong@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 4/4] selftest/bpf/benchs: add bpf_loop
 benchmark
In-Reply-To: <CAEf4BzbB6utDjOJLZzwbBEoAgdO774=PX8O9dWeZJRzM2kdxaQ@mail.gmail.com>
References: <20211123183409.3599979-1-joannekoong@fb.com>
 <20211123183409.3599979-5-joannekoong@fb.com> <87y25ebry1.fsf@toke.dk>
 <3eaa1a93-c3f1-830a-b711-117b27102cc5@fb.com> <87r1b5btl0.fsf@toke.dk>
 <CAEf4BzbB6utDjOJLZzwbBEoAgdO774=PX8O9dWeZJRzM2kdxaQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 24 Nov 2021 22:59:10 +0100
Message-ID: <87lf1db4gh.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Wed, Nov 24, 2021 at 4:56 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Joanne Koong <joannekoong@fb.com> writes:
>>
>> > On 11/23/21 11:19 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> >
>> >> Joanne Koong <joannekoong@fb.com> writes:
>> >>
>> >>> Add benchmark to measure the throughput and latency of the bpf_loop
>> >>> call.
>> >>>
>> >>> Testing this on qemu on my dev machine on 1 thread, the data is
>> >>> as follows:
>> >>>
>> >>>          nr_loops: 1
>> >>> bpf_loop - throughput: 43.350 =C2=B1 0.864 M ops/s, latency: 23.068 =
ns/op
>> >>>
>> >>>          nr_loops: 10
>> >>> bpf_loop - throughput: 69.586 =C2=B1 1.722 M ops/s, latency: 14.371 =
ns/op
>> >>>
>> >>>          nr_loops: 100
>> >>> bpf_loop - throughput: 72.046 =C2=B1 1.352 M ops/s, latency: 13.880 =
ns/op
>> >>>
>> >>>          nr_loops: 500
>> >>> bpf_loop - throughput: 71.677 =C2=B1 1.316 M ops/s, latency: 13.951 =
ns/op
>> >>>
>> >>>          nr_loops: 1000
>> >>> bpf_loop - throughput: 69.435 =C2=B1 1.219 M ops/s, latency: 14.402 =
ns/op
>> >>>
>> >>>          nr_loops: 5000
>> >>> bpf_loop - throughput: 72.624 =C2=B1 1.162 M ops/s, latency: 13.770 =
ns/op
>> >>>
>> >>>          nr_loops: 10000
>> >>> bpf_loop - throughput: 75.417 =C2=B1 1.446 M ops/s, latency: 13.260 =
ns/op
>> >>>
>> >>>          nr_loops: 50000
>> >>> bpf_loop - throughput: 77.400 =C2=B1 2.214 M ops/s, latency: 12.920 =
ns/op
>> >>>
>> >>>          nr_loops: 100000
>> >>> bpf_loop - throughput: 78.636 =C2=B1 2.107 M ops/s, latency: 12.717 =
ns/op
>> >>>
>> >>>          nr_loops: 500000
>> >>> bpf_loop - throughput: 76.909 =C2=B1 2.035 M ops/s, latency: 13.002 =
ns/op
>> >>>
>> >>>          nr_loops: 1000000
>> >>> bpf_loop - throughput: 77.636 =C2=B1 1.748 M ops/s, latency: 12.881 =
ns/op
>> >>>
>> >>>  From this data, we can see that the latency per loop decreases as t=
he
>> >>> number of loops increases. On this particular machine, each loop had=
 an
>> >>> overhead of about ~13 ns, and we were able to run ~70 million loops
>> >>> per second.
>> >> The latency figures are great, thanks! I assume these numbers are with
>> >> retpolines enabled? Otherwise 12ns seems a bit much... Or is this
>> >> because of qemu?
>> > I just tested it on a machine (without retpoline enabled) that runs on
>> > actual
>> > hardware and here is what I found:
>> >
>> >              nr_loops: 1
>> >      bpf_loop - throughput: 46.780 =C2=B1 0.064 M ops/s, latency: 21.3=
77 ns/op
>> >
>> >              nr_loops: 10
>> >      bpf_loop - throughput: 198.519 =C2=B1 0.155 M ops/s, latency: 5.0=
37 ns/op
>> >
>> >              nr_loops: 100
>> >      bpf_loop - throughput: 247.448 =C2=B1 0.305 M ops/s, latency: 4.0=
41 ns/op
>> >
>> >              nr_loops: 500
>> >      bpf_loop - throughput: 260.839 =C2=B1 0.380 M ops/s, latency: 3.8=
34 ns/op
>> >
>> >              nr_loops: 1000
>> >      bpf_loop - throughput: 262.806 =C2=B1 0.629 M ops/s, latency: 3.8=
05 ns/op
>> >
>> >              nr_loops: 5000
>> >      bpf_loop - throughput: 264.211 =C2=B1 1.508 M ops/s, latency: 3.7=
85 ns/op
>> >
>> >              nr_loops: 10000
>> >      bpf_loop - throughput: 265.366 =C2=B1 3.054 M ops/s, latency: 3.7=
68 ns/op
>> >
>> >              nr_loops: 50000
>> >      bpf_loop - throughput: 235.986 =C2=B1 20.205 M ops/s, latency: 4.=
238 ns/op
>> >
>> >              nr_loops: 100000
>> >      bpf_loop - throughput: 264.482 =C2=B1 0.279 M ops/s, latency: 3.7=
81 ns/op
>> >
>> >              nr_loops: 500000
>> >      bpf_loop - throughput: 309.773 =C2=B1 87.713 M ops/s, latency: 3.=
228 ns/op
>> >
>> >              nr_loops: 1000000
>> >      bpf_loop - throughput: 262.818 =C2=B1 4.143 M ops/s, latency: 3.8=
05 ns/op
>> >
>> > The latency is about ~4ns / loop.
>> >
>> > I will update the commit message in v3 with these new numbers as well.
>>
>> Right, awesome, thank you for the additional test. This is closer to
>> what I would expect: on the hardware I'm usually testing on, a function
>> call takes ~1.5ns, but the difference might just be the hardware, or
>> because these are indirect calls.
>>
>> Another comparison just occurred to me (but it's totally OK if you don't
>> want to add any more benchmarks):
>>
>> The difference between a program that does:
>>
>> bpf_loop(nr_loops, empty_callback, NULL, 0);
>>
>> and
>>
>> for (i =3D 0; i < nr_loops; i++)
>>   empty_callback();
>
> You are basically trying to measure the overhead of bpf_loop() helper
> call itself, because other than that it should be identical.

No, I'm trying to measure the difference between the indirect call in
the helper, and the direct call from the BPF program. Should be minor
without retpolines, and somewhat higher where they are enabled...

> We can estimate that already from the numbers Joanne posted above:
>
>              nr_loops: 1
>       bpf_loop - throughput: 46.780 =C2=B1 0.064 M ops/s, latency: 21.377=
 ns/op
>              nr_loops: 1000
>       bpf_loop - throughput: 262.806 =C2=B1 0.629 M ops/s, latency: 3.805=
 ns/op
>
> nr_loops:1 is bpf_loop() overhead and one static callback call.
> bpf_loop()'s own overhead will be in the ballpark of 21.4 - 3.8 =3D
> 17.6ns. I don't think we need yet another benchmark just for this.

That seems really high, though? The helper is a pretty simple function,
and the call to it should just be JIT'ed into a single regular function
call, right? So why the order-of-magnitude difference?

-Toke


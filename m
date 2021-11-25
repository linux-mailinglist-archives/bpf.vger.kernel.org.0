Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5240A45D956
	for <lists+bpf@lfdr.de>; Thu, 25 Nov 2021 12:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhKYLkk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Nov 2021 06:40:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59041 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237335AbhKYLik (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 25 Nov 2021 06:38:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637840129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NI/gNqi3N+vZdomXUYOU6ci4Q+Mp+HGhk30IjdDA2MI=;
        b=c6w9d6jPQfOWfBkte/UsuUs2bTuD+lb94B+ZT1Zp+m8v73o7GYW7rg/M2qtduxzHE1gHkd
        tn1p0LSXTYrxkGvHSaVg4WAOWLZVNMaIilfn3WrX7tC+MF+SrBPASX2J1ZnF6+Cgs14RkY
        SOu4uH86PICX/8UmFjoLt45nsAxHKuw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-123-fV4xAdWQMLura89BpUOpJQ-1; Thu, 25 Nov 2021 06:35:27 -0500
X-MC-Unique: fV4xAdWQMLura89BpUOpJQ-1
Received: by mail-qk1-f199.google.com with SMTP id u8-20020a05620a454800b00468482aac5dso6218023qkp.18
        for <bpf@vger.kernel.org>; Thu, 25 Nov 2021 03:35:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=NI/gNqi3N+vZdomXUYOU6ci4Q+Mp+HGhk30IjdDA2MI=;
        b=KWyGDE7OlHrJVc9C4mvP9WNYqfMN4Hyl2f3ym6ZwOgD+iSJo9rSO9yDYrI3eJM6tDh
         NNRJLMIpLnd5HKK4MQGJqtqfyGW0ocrWGQOm2dVBjG8f2RafWBHzUTSxAfMNaWnWDge1
         T4kLO7Cu0iv9CMbxzAmSCdQa+TroyV1uWaCKvWI1X4r4s7ShlphHlNGRk/rGDrhFDC2d
         PzBuG4r/jk6/4HfvZLgVv5QHRnY5BK5lIfuCyMGWFPEet8GLLnKBhDs9UGxVAeUl4WTX
         wrZLyidsTZ2ycJS8A5ScovXG5Kz0pAttMP1xaVlQ2qtnQodAVGBcC4sQbkwyUAmdMrp2
         6BVQ==
X-Gm-Message-State: AOAM532GAxDYD8eNf75ELQowNYNocR4cg1ZUD2yIcRAh4/17oH9WTDNA
        xBI/hDK2GbBMP31RDwZu0cXX0DHcbAvY1EtGtVy6S/xLWFXrWaVPXldR4VaGBNhb/JT3DW+OeD5
        bGcUX5tOE+teM
X-Received: by 2002:a0c:80e4:: with SMTP id 91mr16314885qvb.57.1637840126481;
        Thu, 25 Nov 2021 03:35:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwtjxv7gf2/ZabGmh0Tktgq8kJTmAPofpqBlVqjBhx3MmoyMh0V8V72ZwVbddSlIEUUdc/YLA==
X-Received: by 2002:a0c:80e4:: with SMTP id 91mr16314757qvb.57.1637840125529;
        Thu, 25 Nov 2021 03:35:25 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a15sm1391223qtb.5.2021.11.25.03.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 03:35:25 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 384411802A0; Thu, 25 Nov 2021 12:35:23 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Joanne Koong <joannekoong@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 4/4] selftest/bpf/benchs: add bpf_loop
 benchmark
In-Reply-To: <5d363ea7-16c6-b8e8-b6ee-11cbe9bf1cf2@fb.com>
References: <20211123183409.3599979-1-joannekoong@fb.com>
 <20211123183409.3599979-5-joannekoong@fb.com> <87y25ebry1.fsf@toke.dk>
 <3eaa1a93-c3f1-830a-b711-117b27102cc5@fb.com> <87r1b5btl0.fsf@toke.dk>
 <CAEf4BzbB6utDjOJLZzwbBEoAgdO774=PX8O9dWeZJRzM2kdxaQ@mail.gmail.com>
 <87lf1db4gh.fsf@toke.dk> <5d363ea7-16c6-b8e8-b6ee-11cbe9bf1cf2@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 25 Nov 2021 12:35:23 +0100
Message-ID: <87ee74bh8k.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Joanne Koong <joannekoong@fb.com> writes:

> On 11/24/21 1:59 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>
>>> On Wed, Nov 24, 2021 at 4:56 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@=
redhat.com> wrote:
>>>> Joanne Koong <joannekoong@fb.com> writes:
>>>>
>>>>> On 11/23/21 11:19 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>
>>>>>> Joanne Koong <joannekoong@fb.com> writes:
>>>>>>
>>>>>>> Add benchmark to measure the throughput and latency of the bpf_loop
>>>>>>> call.
>>>>>>>
>>>>>>> Testing this on qemu on my dev machine on 1 thread, the data is
>>>>>>> as follows:
>>>>>>>
>>>>>>>           nr_loops: 1
>>>>>>> bpf_loop - throughput: 43.350 =C2=B1 0.864 M ops/s, latency: 23.068=
 ns/op
>>>>>>>
>>>>>>>           nr_loops: 10
>>>>>>> bpf_loop - throughput: 69.586 =C2=B1 1.722 M ops/s, latency: 14.371=
 ns/op
>>>>>>>
>>>>>>>           nr_loops: 100
>>>>>>> bpf_loop - throughput: 72.046 =C2=B1 1.352 M ops/s, latency: 13.880=
 ns/op
>>>>>>>
>>>>>>>           nr_loops: 500
>>>>>>> bpf_loop - throughput: 71.677 =C2=B1 1.316 M ops/s, latency: 13.951=
 ns/op
>>>>>>>
>>>>>>>           nr_loops: 1000
>>>>>>> bpf_loop - throughput: 69.435 =C2=B1 1.219 M ops/s, latency: 14.402=
 ns/op
>>>>>>>
>>>>>>>           nr_loops: 5000
>>>>>>> bpf_loop - throughput: 72.624 =C2=B1 1.162 M ops/s, latency: 13.770=
 ns/op
>>>>>>>
>>>>>>>           nr_loops: 10000
>>>>>>> bpf_loop - throughput: 75.417 =C2=B1 1.446 M ops/s, latency: 13.260=
 ns/op
>>>>>>>
>>>>>>>           nr_loops: 50000
>>>>>>> bpf_loop - throughput: 77.400 =C2=B1 2.214 M ops/s, latency: 12.920=
 ns/op
>>>>>>>
>>>>>>>           nr_loops: 100000
>>>>>>> bpf_loop - throughput: 78.636 =C2=B1 2.107 M ops/s, latency: 12.717=
 ns/op
>>>>>>>
>>>>>>>           nr_loops: 500000
>>>>>>> bpf_loop - throughput: 76.909 =C2=B1 2.035 M ops/s, latency: 13.002=
 ns/op
>>>>>>>
>>>>>>>           nr_loops: 1000000
>>>>>>> bpf_loop - throughput: 77.636 =C2=B1 1.748 M ops/s, latency: 12.881=
 ns/op
>>>>>>>
>>>>>>>   From this data, we can see that the latency per loop decreases as=
 the
>>>>>>> number of loops increases. On this particular machine, each loop ha=
d an
>>>>>>> overhead of about ~13 ns, and we were able to run ~70 million loops
>>>>>>> per second.
>>>>>> The latency figures are great, thanks! I assume these numbers are wi=
th
>>>>>> retpolines enabled? Otherwise 12ns seems a bit much... Or is this
>>>>>> because of qemu?
>>>>> I just tested it on a machine (without retpoline enabled) that runs on
>>>>> actual
>>>>> hardware and here is what I found:
>>>>>
>>>>>               nr_loops: 1
>>>>>       bpf_loop - throughput: 46.780 =C2=B1 0.064 M ops/s, latency: 21=
.377 ns/op
>>>>>
>>>>>               nr_loops: 10
>>>>>       bpf_loop - throughput: 198.519 =C2=B1 0.155 M ops/s, latency: 5=
.037 ns/op
>>>>>
>>>>>               nr_loops: 100
>>>>>       bpf_loop - throughput: 247.448 =C2=B1 0.305 M ops/s, latency: 4=
.041 ns/op
>>>>>
>>>>>               nr_loops: 500
>>>>>       bpf_loop - throughput: 260.839 =C2=B1 0.380 M ops/s, latency: 3=
.834 ns/op
>>>>>
>>>>>               nr_loops: 1000
>>>>>       bpf_loop - throughput: 262.806 =C2=B1 0.629 M ops/s, latency: 3=
.805 ns/op
>>>>>
>>>>>               nr_loops: 5000
>>>>>       bpf_loop - throughput: 264.211 =C2=B1 1.508 M ops/s, latency: 3=
.785 ns/op
>>>>>
>>>>>               nr_loops: 10000
>>>>>       bpf_loop - throughput: 265.366 =C2=B1 3.054 M ops/s, latency: 3=
.768 ns/op
>>>>>
>>>>>               nr_loops: 50000
>>>>>       bpf_loop - throughput: 235.986 =C2=B1 20.205 M ops/s, latency: =
4.238 ns/op
>>>>>
>>>>>               nr_loops: 100000
>>>>>       bpf_loop - throughput: 264.482 =C2=B1 0.279 M ops/s, latency: 3=
.781 ns/op
>>>>>
>>>>>               nr_loops: 500000
>>>>>       bpf_loop - throughput: 309.773 =C2=B1 87.713 M ops/s, latency: =
3.228 ns/op
>>>>>
>>>>>               nr_loops: 1000000
>>>>>       bpf_loop - throughput: 262.818 =C2=B1 4.143 M ops/s, latency: 3=
.805 ns/op
>>>>>
>>>>> The latency is about ~4ns / loop.
>>>>>
>>>>> I will update the commit message in v3 with these new numbers as well.
>>>> Right, awesome, thank you for the additional test. This is closer to
>>>> what I would expect: on the hardware I'm usually testing on, a function
>>>> call takes ~1.5ns, but the difference might just be the hardware, or
>>>> because these are indirect calls.
>>>>
>>>> Another comparison just occurred to me (but it's totally OK if you don=
't
>>>> want to add any more benchmarks):
>>>>
>>>> The difference between a program that does:
>>>>
>>>> bpf_loop(nr_loops, empty_callback, NULL, 0);
>>>>
>>>> and
>>>>
>>>> for (i =3D 0; i < nr_loops; i++)
>>>>    empty_callback();
>>> You are basically trying to measure the overhead of bpf_loop() helper
>>> call itself, because other than that it should be identical.
>> No, I'm trying to measure the difference between the indirect call in
>> the helper, and the direct call from the BPF program. Should be minor
>> without retpolines, and somewhat higher where they are enabled...
>>
>>> We can estimate that already from the numbers Joanne posted above:
>>>
>>>               nr_loops: 1
>>>        bpf_loop - throughput: 46.780 =C2=B1 0.064 M ops/s, latency: 21.=
377 ns/op
>>>               nr_loops: 1000
>>>        bpf_loop - throughput: 262.806 =C2=B1 0.629 M ops/s, latency: 3.=
805 ns/op
>>>
>>> nr_loops:1 is bpf_loop() overhead and one static callback call.
>>> bpf_loop()'s own overhead will be in the ballpark of 21.4 - 3.8 =3D
>>> 17.6ns. I don't think we need yet another benchmark just for this.
>> That seems really high, though? The helper is a pretty simple function,
>> and the call to it should just be JIT'ed into a single regular function
>> call, right? So why the order-of-magnitude difference?
> I think the overhead of triggering the bpf program from the userspace
> benchmarking program is also contributing to this. When nr_loops =3D 1, we
> have to do the context switch between userspace + kernel per every 1000=20
> loops;
> this overhead also contributes to the latency numbers above

Right okay. But then that data point is not really measuring what it's
purporting to measure? That's a bit misleading, so maybe better to leave
it out entirely?

-Toke


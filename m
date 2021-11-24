Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C32545BFCA
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 13:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243009AbhKXNBs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Nov 2021 08:01:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37483 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344550AbhKXM7q (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Nov 2021 07:59:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637758593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KvJo17w3AzF6psBun0Cr8Cnk63p8S8i8yRQn8UTwtu4=;
        b=gWrx9ilokxNHTZqFkQUirDzJbcC3YXqet31XGWbWw8pdPojEu+RjiS6JTYXRXpiWykX7Q+
        /dokPEZYWDsL4nvBM70Lh2bPkNgEjFQ2OYznNEPHfAujLW4oszELM0Sqz6Yn0sVQ1CorQy
        mY7+Q7tLkhQumaUEFc25qppI+nnL2qw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-128-ressrui9M-6uQofPGwN_8g-1; Wed, 24 Nov 2021 07:56:31 -0500
X-MC-Unique: ressrui9M-6uQofPGwN_8g-1
Received: by mail-ed1-f69.google.com with SMTP id v10-20020aa7d9ca000000b003e7bed57968so2204141eds.23
        for <bpf@vger.kernel.org>; Wed, 24 Nov 2021 04:56:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=KvJo17w3AzF6psBun0Cr8Cnk63p8S8i8yRQn8UTwtu4=;
        b=ctAN5TCyEFJJ/Ove5aETvli4IVVfNAr5W/X1IePnxfQ1NF0PydTR2m+XLHd9h+DKWq
         KtmpLxUChR6kltGkhC5RulwJ9hz29aADSEbI+tp3UuVRKR4f6yU37g3ekce2ltPoCWyB
         GpxYCaRkQ/IJYfOoY2zKfTU1F6wEfm5KvEzVHq/wKC28Q+ReMZsKFHJ8xoYah2wTxRod
         RznprnI1VScSigS9I5p91VnIpA1LwXUsaU2RJJ3LkzcJuN0cDPtnNCNvqQJnlYAXIHOF
         XdYDJUKgD2XSe676+x5OlkoJLDpkm7kI3MJZUfPC0j4kYL1axXPxUD1v8Zcdq/NyBSU0
         xSBg==
X-Gm-Message-State: AOAM531C+dMrH9VPIDZn3xRtHNB3GOMZW2OLwNFSu9ZlQHqN5WfqSVsx
        BFyqX4UVxQ0EWQeCp+jxMczHCW7PY3rVawsg/l7yt5XmrX77u+6mxbYa7ZSv1xG11T8Fd69ZRfI
        RnSJd5h8Oqkby
X-Received: by 2002:a05:6402:1014:: with SMTP id c20mr24888852edu.186.1637758590474;
        Wed, 24 Nov 2021 04:56:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx2/aJt1ltutjgWP8o1DjyvzcHrs2yQ8NZoqfs3Y/catJq78G8r2MN9F2qCJarhSIDxif6/sw==
X-Received: by 2002:a05:6402:1014:: with SMTP id c20mr24888761edu.186.1637758590024;
        Wed, 24 Nov 2021 04:56:30 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id sb8sm7244229ejc.51.2021.11.24.04.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 04:56:29 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 6D94C18029C; Wed, 24 Nov 2021 13:56:27 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Joanne Koong <joannekoong@fb.com>, bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Kernel-team@fb.com
Subject: Re: [PATCH v2 bpf-next 4/4] selftest/bpf/benchs: add bpf_loop
 benchmark
In-Reply-To: <3eaa1a93-c3f1-830a-b711-117b27102cc5@fb.com>
References: <20211123183409.3599979-1-joannekoong@fb.com>
 <20211123183409.3599979-5-joannekoong@fb.com> <87y25ebry1.fsf@toke.dk>
 <3eaa1a93-c3f1-830a-b711-117b27102cc5@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 24 Nov 2021 13:56:27 +0100
Message-ID: <87r1b5btl0.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Joanne Koong <joannekoong@fb.com> writes:

> On 11/23/21 11:19 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>
>> Joanne Koong <joannekoong@fb.com> writes:
>>
>>> Add benchmark to measure the throughput and latency of the bpf_loop
>>> call.
>>>
>>> Testing this on qemu on my dev machine on 1 thread, the data is
>>> as follows:
>>>
>>>          nr_loops: 1
>>> bpf_loop - throughput: 43.350 =C2=B1 0.864 M ops/s, latency: 23.068 ns/=
op
>>>
>>>          nr_loops: 10
>>> bpf_loop - throughput: 69.586 =C2=B1 1.722 M ops/s, latency: 14.371 ns/=
op
>>>
>>>          nr_loops: 100
>>> bpf_loop - throughput: 72.046 =C2=B1 1.352 M ops/s, latency: 13.880 ns/=
op
>>>
>>>          nr_loops: 500
>>> bpf_loop - throughput: 71.677 =C2=B1 1.316 M ops/s, latency: 13.951 ns/=
op
>>>
>>>          nr_loops: 1000
>>> bpf_loop - throughput: 69.435 =C2=B1 1.219 M ops/s, latency: 14.402 ns/=
op
>>>
>>>          nr_loops: 5000
>>> bpf_loop - throughput: 72.624 =C2=B1 1.162 M ops/s, latency: 13.770 ns/=
op
>>>
>>>          nr_loops: 10000
>>> bpf_loop - throughput: 75.417 =C2=B1 1.446 M ops/s, latency: 13.260 ns/=
op
>>>
>>>          nr_loops: 50000
>>> bpf_loop - throughput: 77.400 =C2=B1 2.214 M ops/s, latency: 12.920 ns/=
op
>>>
>>>          nr_loops: 100000
>>> bpf_loop - throughput: 78.636 =C2=B1 2.107 M ops/s, latency: 12.717 ns/=
op
>>>
>>>          nr_loops: 500000
>>> bpf_loop - throughput: 76.909 =C2=B1 2.035 M ops/s, latency: 13.002 ns/=
op
>>>
>>>          nr_loops: 1000000
>>> bpf_loop - throughput: 77.636 =C2=B1 1.748 M ops/s, latency: 12.881 ns/=
op
>>>
>>>  From this data, we can see that the latency per loop decreases as the
>>> number of loops increases. On this particular machine, each loop had an
>>> overhead of about ~13 ns, and we were able to run ~70 million loops
>>> per second.
>> The latency figures are great, thanks! I assume these numbers are with
>> retpolines enabled? Otherwise 12ns seems a bit much... Or is this
>> because of qemu?
> I just tested it on a machine (without retpoline enabled) that runs on=20
> actual
> hardware and here is what I found:
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nr_lo=
ops: 1
>  =C2=A0=C2=A0=C2=A0 bpf_loop - throughput: 46.780 =C2=B1 0.064 M ops/s, l=
atency: 21.377 ns/op
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nr_lo=
ops: 10
>  =C2=A0=C2=A0=C2=A0 bpf_loop - throughput: 198.519 =C2=B1 0.155 M ops/s, =
latency: 5.037 ns/op
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nr_lo=
ops: 100
>  =C2=A0=C2=A0=C2=A0 bpf_loop - throughput: 247.448 =C2=B1 0.305 M ops/s, =
latency: 4.041 ns/op
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nr_lo=
ops: 500
>  =C2=A0=C2=A0=C2=A0 bpf_loop - throughput: 260.839 =C2=B1 0.380 M ops/s, =
latency: 3.834 ns/op
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nr_lo=
ops: 1000
>  =C2=A0=C2=A0=C2=A0 bpf_loop - throughput: 262.806 =C2=B1 0.629 M ops/s, =
latency: 3.805 ns/op
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nr_lo=
ops: 5000
>  =C2=A0=C2=A0=C2=A0 bpf_loop - throughput: 264.211 =C2=B1 1.508 M ops/s, =
latency: 3.785 ns/op
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nr_lo=
ops: 10000
>  =C2=A0=C2=A0=C2=A0 bpf_loop - throughput: 265.366 =C2=B1 3.054 M ops/s, =
latency: 3.768 ns/op
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nr_lo=
ops: 50000
>  =C2=A0=C2=A0=C2=A0 bpf_loop - throughput: 235.986 =C2=B1 20.205 M ops/s,=
 latency: 4.238 ns/op
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nr_lo=
ops: 100000
>  =C2=A0=C2=A0=C2=A0 bpf_loop - throughput: 264.482 =C2=B1 0.279 M ops/s, =
latency: 3.781 ns/op
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nr_lo=
ops: 500000
>  =C2=A0=C2=A0=C2=A0 bpf_loop - throughput: 309.773 =C2=B1 87.713 M ops/s,=
 latency: 3.228 ns/op
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nr_lo=
ops: 1000000
>  =C2=A0=C2=A0=C2=A0 bpf_loop - throughput: 262.818 =C2=B1 4.143 M ops/s, =
latency: 3.805 ns/op
>
> The latency is about ~4ns / loop.
>
> I will update the commit message in v3 with these new numbers as well.

Right, awesome, thank you for the additional test. This is closer to
what I would expect: on the hardware I'm usually testing on, a function
call takes ~1.5ns, but the difference might just be the hardware, or
because these are indirect calls.

Another comparison just occurred to me (but it's totally OK if you don't
want to add any more benchmarks):

The difference between a program that does:

bpf_loop(nr_loops, empty_callback, NULL, 0);

and

for (i =3D 0; i < nr_loops; i++)
  empty_callback();


should show the difference between the indirect call in the helper and a
direct call from BPF (and show what the potential performance gain from
having the verifier inline the helper would be). This was more
interesting when there was a ~10x delta than a ~2x between your numbers
and mine, so also totally OK to leave this as-is, and we can cycle back
to such optimisations if it turns out to be necessary...

-Toke


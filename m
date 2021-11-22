Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43E2459030
	for <lists+bpf@lfdr.de>; Mon, 22 Nov 2021 15:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239491AbhKVOar (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 09:30:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59002 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239459AbhKVOaq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Nov 2021 09:30:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637591259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zFQJvfa4OZk16n3wLOP2Dt0JQ9f6i9EOHANKKj/bnX8=;
        b=YN+amN4jeUgIJQiA8mD8bm3nxIJun0qOw5Pmko36/y+GCU8ScGcm6921urjOITWhJiT/g2
        wMezknNPzS50CUxcVYC8fqWz4MPkZOJd2huNpnt9vepOia0TWWKa+Daom8wQXhvoFE6H9w
        YO/g8U5VADpEr/5/xzgqhTij3yIwJnk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-ctQ7vpQfNIiIFRCBlQYizw-1; Mon, 22 Nov 2021 09:27:11 -0500
X-MC-Unique: ctQ7vpQfNIiIFRCBlQYizw-1
Received: by mail-ed1-f71.google.com with SMTP id n11-20020aa7c68b000000b003e7d68e9874so14990147edq.8
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 06:27:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=zFQJvfa4OZk16n3wLOP2Dt0JQ9f6i9EOHANKKj/bnX8=;
        b=O+OkVU69XfE/hgSOk87m7onSeSXneiVK06uQyzXYI1tF4o6Q2Z4zec8V16uF3O1PoE
         89fq590XeV73zm8RCcw9NosdDeGGnak+ihgjiWFpKUkiQ/MF78u+MY+/PUqkeF15Qatw
         CHXPvWGbTLrD2Vf0ecKmgbERpS/VRP+M9WQVIpHqOlk/OIxxAUhJKHNdV8T3pplBIjoP
         9d00U4rleLUm7Eoo7WQP1tlwkpr2bRRvk4e0+JmYeo8AoOfikEwYblzL3i64kTXtrmyS
         ilN+swovplCp1G2hJzkCIl7w4fDD8Bo7Ia9Zh6TRhHFDU+KhwlBrtGWXSA1MtKfqan4U
         UaNA==
X-Gm-Message-State: AOAM531vozECxIzb5S+u6KiItqhqYiQRdN4+mC9qZD55xF1pb1ycOYgD
        Bu1mA1qD/jzUtTt+tZpS2DTZCfLPXqWMr26W6wHhgqmQd8ihR772B1m51ej0mFJWXKm3FdA67WC
        1cNq6G8ZpwBQ0
X-Received: by 2002:a17:906:31c2:: with SMTP id f2mr41581509ejf.341.1637591227495;
        Mon, 22 Nov 2021 06:27:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy2CoDdLaLQFnvzR6cn6Ze4ae/9QmiYWP4g20CkeX0fiyRQRyHkXp+mxoV4rBTxK/5eB9/zSQ==
X-Received: by 2002:a17:906:31c2:: with SMTP id f2mr41581454ejf.341.1637591227143;
        Mon, 22 Nov 2021 06:27:07 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id z6sm4327061edc.76.2021.11.22.06.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 06:27:03 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1F391180270; Mon, 22 Nov 2021 15:27:02 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Joanne Koong <joannekoong@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 3/3] selftest/bpf/benchs: add bpf_for_each
 benchmark
In-Reply-To: <CAEf4BzZKtV1_=s7mXUnvvR4BQT6CFm60uuc8F1gv5Hzb=_xkKQ@mail.gmail.com>
References: <20211118010404.2415864-1-joannekoong@fb.com>
 <20211118010404.2415864-4-joannekoong@fb.com> <87r1bdemq4.fsf@toke.dk>
 <CAEf4BzZMJfSqx9wLq9ntSK+n4kE82S_ifgFhBVtjYiy0vz4Gyg@mail.gmail.com>
 <874k88e1or.fsf@toke.dk>
 <CAEf4BzZKtV1_=s7mXUnvvR4BQT6CFm60uuc8F1gv5Hzb=_xkKQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 22 Nov 2021 15:27:02 +0100
Message-ID: <87lf1gcll5.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Fri, Nov 19, 2021 at 5:04 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>
>> > On Thu, Nov 18, 2021 at 3:18 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke=
@redhat.com> wrote:
>> >>
>> >> Joanne Koong <joannekoong@fb.com> writes:
>> >>
>> >> > Add benchmark to measure the overhead of the bpf_for_each call
>> >> > for a specified number of iterations.
>> >> >
>> >> > Testing this on qemu on my dev machine on 1 thread, the data is
>> >> > as follows:
>> >>
>> >> Absolute numbers from some random dev machine are not terribly useful;
>> >> others have no way of replicating your tests. A more meaningful
>> >> benchmark would need a baseline to compare to; in this case I guess t=
hat
>> >> would be a regular loop? Do you have any numbers comparing the callba=
ck
>> >> to just looping?
>> >
>> > Measuring empty for (int i =3D 0; i < N; i++) is meaningless, you shou=
ld
>> > expect a number in billions of "operations" per second on modern
>> > server CPUs. So that will give you no idea. Those numbers are useful
>> > as a ballpark number of what's the overhead of bpf_for_each() helper
>> > and callbacks. And 12ns per "iteration" is meaningful to have a good
>> > idea of how slow that can be. Depending on your hardware it can be
>> > different by 2x, maybe 3x, but not 100x.
>> >
>> > But measuring inc + cmp + jne as a baseline is both unrealistic and
>> > doesn't give much more extra information. But you can assume 2B/s,
>> > give or take.
>> >
>> > And you also can run this benchmark on your own on your hardware to
>> > get "real" numbers, as much as you can expect real numbers from
>> > artificial microbenchmark, of course.
>> >
>> >
>> > I read those numbers as "plenty fast" :)
>>
>> Hmm, okay, fair enough, but I think it would be good to have the "~12 ns
>> per iteration" figure featured prominently in the commit message, then :)
>>
>
> We discussed with Joanne offline adding an ops_report_final() helper
> that will output both throughput (X ops/s) and latency/overhead (
> (1000000000/X) ns/op), so that no one had to do any math.

Alright, sounds good, thanks!

-Toke


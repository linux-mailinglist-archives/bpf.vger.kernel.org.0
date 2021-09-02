Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEC73FF215
	for <lists+bpf@lfdr.de>; Thu,  2 Sep 2021 19:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346533AbhIBRJH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Sep 2021 13:09:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50311 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346538AbhIBRJG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 2 Sep 2021 13:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630602487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k+uDesInFuRexRO1lWLZaUErkyo/kRjkjvT+Y1LURy4=;
        b=datXzIMANl2ChlfZqB7DpEUufuBP0s0RZMQ9XOi4U1j3Sq9lPVIzBKwr7mPU+Ivhkm8Ull
        6LJYCsD5UOw81LeZBNari/m30ES9UJ6eWadRo9vyHFYcYuxnRP2Dj6T+qKKpxkN0KYAnXu
        tXI9NxlXh250yTppr2V1mkE1+jkFdKo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-MJGYJmFHOfOfmkayRM7kEQ-1; Thu, 02 Sep 2021 13:08:06 -0400
X-MC-Unique: MJGYJmFHOfOfmkayRM7kEQ-1
Received: by mail-ed1-f70.google.com with SMTP id ch11-20020a0564021bcb00b003c8021b61c4so1282645edb.23
        for <bpf@vger.kernel.org>; Thu, 02 Sep 2021 10:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=k+uDesInFuRexRO1lWLZaUErkyo/kRjkjvT+Y1LURy4=;
        b=FeSeHUw+Y7DCf94Qi0pwCg5VWZaTV98sEED0q6ZQhjHQWAcLlA62+FtrmQC+68zQyV
         T2fipUNbzZ0ju9dsYXGItG9MroJFSXIrU0rzRVpfrvkApMDX8LolY4h8hddNRTRYRn4N
         0hBMpMzHOuQmLHW5VsnWlN1o5l0i5IWUDGc8MV7aN9ZSgKE+H0dPqsLURmj2kuzkLxJS
         q37ZkMxWWVVjYg7N+CAqfpvrIHNG57gbRpPG2TBL0KF6Ok+YqvEAobB2QxoraCjp/SIn
         3KCbs86kQ5TcXsVGtpFe5SD8IpzMZwrPJI+o8D4C1WLUFcqUUzyNfQqfUHu0HVKKm4bJ
         //Ng==
X-Gm-Message-State: AOAM533+gwQz3S0rWout1pxwSUtvLEvmUuekroOEXB/1tx63Rnrmdiv/
        E5B2GEmGxFg4jiUNcckd+acGU2n610QF3KzMN1CjNqS4eHBUEhQ5216O/H84R7Hh9X7b87I6HLB
        A2/u5fxWTrCkn
X-Received: by 2002:a05:6402:5c9:: with SMTP id n9mr4578890edx.336.1630602485539;
        Thu, 02 Sep 2021 10:08:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOoPh8tnGcT2vsuQ7eJoSy2dO8ioPhaKct5AHAGarbvs8SmNA5RgTEUllYMHRJj2aNiJ7aHA==
X-Received: by 2002:a05:6402:5c9:: with SMTP id n9mr4578865edx.336.1630602485273;
        Thu, 02 Sep 2021 10:08:05 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id jz16sm1399675ejc.34.2021.09.02.10.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 10:08:04 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 84BA61800EB; Thu,  2 Sep 2021 19:08:03 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2] libbpf: ignore .eh_frame sections when
 parsing elf files
In-Reply-To: <a65e20f9-d554-761e-9a9e-8a9dfcf13919@fb.com>
References: <20210826120953.11041-1-toke@redhat.com>
 <CAEf4BzZ7dcYrGRgOczk-mLC_VcRW3rucj3TRgkRqLgKXFHgtog@mail.gmail.com>
 <87lf4hvrgc.fsf@toke.dk> <a65e20f9-d554-761e-9a9e-8a9dfcf13919@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 02 Sep 2021 19:08:03 +0200
Message-ID: <87wnnysy6k.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song <yhs@fb.com> writes:

> On 8/31/21 3:28 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>=20
>>> On Thu, Aug 26, 2021 at 5:10 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@=
redhat.com> wrote:
>>>>
>>>> When .eh_frame and .rel.eh_frame sections are present in BPF object fi=
les,
>>>> libbpf produces errors like this when loading the file:
>>>>
>>>> libbpf: elf: skipping unrecognized data section(32) .eh_frame
>>>> libbpf: elf: skipping relo section(33) .rel.eh_frame for section(32) .=
eh_frame
>>>>
>>>> It is possible to get rid of the .eh_frame section by adding
>>>> -fno-asynchronous-unwind-tables to the compilation, but we have seen
>>>> multiple examples of these sections appearing in BPF files in the wild,
>>>> most recently in samples/bpf, fixed by:
>>>> 5a0ae9872d5c ("bpf, samples: Add -fno-asynchronous-unwind-tables to BP=
F Clang invocation")
>>>>
>>>> While the errors are technically harmless, they look odd and confuse u=
sers.
>>>
>>> These warnings point out invalid set of compiler flags used for
>>> compiling BPF object files, though. Which is a good thing and should
>>> incentivize anyone getting those warnings to check and fix how they do
>>> BPF compilation. Those .eh_frame sections shouldn't be present in BPF
>>> object files at all, and that's what libbpf is trying to say.
>>=20
>> Apart from triggering that warning, what effect does this have, though?
>> The programs seem to work just fine (as evidenced by the fact that
>> samples/bpf has been built this way for years, for instance)...
>>=20
>> Also, how is a user supposed to go from that cryptic error message to
>> figuring out that it has something to do with compiler flags?
>>=20
>>> I don't know exactly in which situations that .eh_frame section is
>>> added, but looking at our selftests (and now samples/bpf as well),
>>> where we use -target bpf, we don't need
>>> -fno-asynchronous-unwind-tables at all.
>>=20
>> This seems to at least be compiler-dependent. We ran into this with
>> bpftool as well (for the internal BPF programs it loads whenever it
>> runs), which already had '-target bpf' in the Makefile. We're carrying
>> an internal RHEL patch adding -fno-asynchronous-unwind-tables to the
>> bpftool build to fix this...
>
> I haven't seen an instance of .eh_frame as well with -target bpf.
> Do you have a reproducible test case? I would like to investigate
> what is the possible cause and whether we could do something in llvm
> to prevent its generatin. Thanks!

We found this in the RHEL builds of bpftool. I don't think we're doing
anything special, other than maybe building with a clang version that's
a few versions behind:

# clang --version
clang version 11.0.0 (Red Hat 11.0.0-1.module+el8.4.0+8598+a071fcd5)
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /usr/bin

So I suppose it may resolve itself once we upgrade LLVM?

-Toke


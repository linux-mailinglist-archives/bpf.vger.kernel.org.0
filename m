Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927853FC5A3
	for <lists+bpf@lfdr.de>; Tue, 31 Aug 2021 12:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240995AbhHaK3W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Aug 2021 06:29:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52384 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240985AbhHaK3V (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 31 Aug 2021 06:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630405705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zNImg2MTtOIvPkfoEZBKYQflvCbrhkcRvwv6Z7KRDQY=;
        b=GiBOGi9NuvUS1vTmTdKvVeP9ypaSFBYQp43IOzRZiSjeq1LbhDWtyjx77DGDiZ5KUSdfLw
        TvTwkcljzo02IH9PaE++rk7i9QRzYe0RbrWhAnb4/S3qmJMFNRA6rwAGWnSG9O4EIJYmb0
        iUU2nxIKEDsXzC/Tdvb/hpWxg8dbyys=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-LeVZKSoPPo-txZCmF2V-0w-1; Tue, 31 Aug 2021 06:28:24 -0400
X-MC-Unique: LeVZKSoPPo-txZCmF2V-0w-1
Received: by mail-ed1-f69.google.com with SMTP id s25-20020a50d499000000b003c1a8573042so8048305edi.11
        for <bpf@vger.kernel.org>; Tue, 31 Aug 2021 03:28:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=zNImg2MTtOIvPkfoEZBKYQflvCbrhkcRvwv6Z7KRDQY=;
        b=bbgc/T3StsLtC1KG2Dmxb2kr6ieouu1HVaPIQomZ2IpCmelBGWfKuBrOKAhDxfBQgd
         cKb+u0OuqXafyk1poaKolRb8drpFj9LSEJjuLMfLZdy6QI1DjLwHB20u8iWy+GJuDovt
         +jspjODAOGMnVJgznZ4fpjF6nwC3jS0lMmnV1oLt4VsHJmON3t5+LjwaTEobNcaXB35c
         15dGYBN5A3oaWRSVxum3Ows5L5k5cQpTfjZE1p8wujY0jql2YdjVY03DXdGpb0941GQ0
         RwyQT60DFuGczvR0wwP6oN4GTZ2qejwmkxpVKeAtvmnAwJu/kZPo8fQv4M8d6gOoHCva
         vTrA==
X-Gm-Message-State: AOAM5335oNakyBL2y+4UTwfFWxbENdt4a/yMG3APhowYacxLPKSU4tFQ
        SIkaySh6EB/P31leNOT6UtvItC2+1qwnX/R6ka7yLaI57yGZc1gOj8INYtPnvgHN0yUoS6DxItM
        l9B+q9bcktVz9
X-Received: by 2002:a17:906:c317:: with SMTP id s23mr30252142ejz.83.1630405702868;
        Tue, 31 Aug 2021 03:28:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0hrku4cvtZGOf/X7jxMbvDMh074FBCX+3GJYq344hZGWcHGyPdG1OQoFZ0ccreJhYsKHWww==
X-Received: by 2002:a17:906:c317:: with SMTP id s23mr30252126ejz.83.1630405702670;
        Tue, 31 Aug 2021 03:28:22 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id l23sm9221717eds.29.2021.08.31.03.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 03:28:22 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D27CF1800EB; Tue, 31 Aug 2021 12:28:19 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2] libbpf: ignore .eh_frame sections when
 parsing elf files
In-Reply-To: <CAEf4BzZ7dcYrGRgOczk-mLC_VcRW3rucj3TRgkRqLgKXFHgtog@mail.gmail.com>
References: <20210826120953.11041-1-toke@redhat.com>
 <CAEf4BzZ7dcYrGRgOczk-mLC_VcRW3rucj3TRgkRqLgKXFHgtog@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 31 Aug 2021 12:28:19 +0200
Message-ID: <87lf4hvrgc.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Thu, Aug 26, 2021 at 5:10 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> When .eh_frame and .rel.eh_frame sections are present in BPF object file=
s,
>> libbpf produces errors like this when loading the file:
>>
>> libbpf: elf: skipping unrecognized data section(32) .eh_frame
>> libbpf: elf: skipping relo section(33) .rel.eh_frame for section(32) .eh=
_frame
>>
>> It is possible to get rid of the .eh_frame section by adding
>> -fno-asynchronous-unwind-tables to the compilation, but we have seen
>> multiple examples of these sections appearing in BPF files in the wild,
>> most recently in samples/bpf, fixed by:
>> 5a0ae9872d5c ("bpf, samples: Add -fno-asynchronous-unwind-tables to BPF =
Clang invocation")
>>
>> While the errors are technically harmless, they look odd and confuse use=
rs.
>
> These warnings point out invalid set of compiler flags used for
> compiling BPF object files, though. Which is a good thing and should
> incentivize anyone getting those warnings to check and fix how they do
> BPF compilation. Those .eh_frame sections shouldn't be present in BPF
> object files at all, and that's what libbpf is trying to say.

Apart from triggering that warning, what effect does this have, though?
The programs seem to work just fine (as evidenced by the fact that
samples/bpf has been built this way for years, for instance)...

Also, how is a user supposed to go from that cryptic error message to
figuring out that it has something to do with compiler flags?

> I don't know exactly in which situations that .eh_frame section is
> added, but looking at our selftests (and now samples/bpf as well),
> where we use -target bpf, we don't need
> -fno-asynchronous-unwind-tables at all.

This seems to at least be compiler-dependent. We ran into this with
bpftool as well (for the internal BPF programs it loads whenever it
runs), which already had '-target bpf' in the Makefile. We're carrying
an internal RHEL patch adding -fno-asynchronous-unwind-tables to the
bpftool build to fix this...

> So instead of hiding the problem, let's use this as an opportunity to
> fix those user's compilation flags instead.

This really doesn't seem like something that's helping anyone, it's just
annoying and confusing users...

-Toke


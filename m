Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE0B49B3A2
	for <lists+bpf@lfdr.de>; Tue, 25 Jan 2022 13:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382750AbiAYMPH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jan 2022 07:15:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27240 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346834AbiAYMKX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 25 Jan 2022 07:10:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643112609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=42Z6BCPlgS1+hVY7pB4+6uGo5ji54cdCInILV50rNl4=;
        b=i++A+IbiQNfoN6V4b8DRfdQ2ANWIsZ6VtmBwBNu+SsHBdz1xsMWbhqEdSANvUCix9LCc8G
        EKe8IfNnEYB/0Wpl8FsK5xn7IZaYzpl100Zz7rdHEYFBj/IyunVXV1tHQGh0jUOv10rA3j
        hnV8cYCmJFVA+OmKozw0yNhlPnVcNoo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644---RRu4VwMTePrsbUpjX01A-1; Tue, 25 Jan 2022 07:10:08 -0500
X-MC-Unique: --RRu4VwMTePrsbUpjX01A-1
Received: by mail-ej1-f71.google.com with SMTP id x16-20020a170906135000b006b5b4787023so3446330ejb.12
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 04:10:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=42Z6BCPlgS1+hVY7pB4+6uGo5ji54cdCInILV50rNl4=;
        b=pYtCmwlgyMD4geXMJ1Ici6r+2LofM6CMnPSyBrt6eysYwAbyJnNQ0KLcvKc/1ackHA
         rScRpmO5rKuPhLRSm2yfbGS3n0zFHVSh6WR4A5wTcAGutzTRVVJ2Q4LHKY3LpUOXEWOG
         KrspqrK7LNaWxP9rPShINWa4ybX5PVzCr312JQ72xUHoy96MxP0YuawNgnDDTsULRGDo
         bM8Lr20r0z8WwNzc3TM+vjrVPRh3ECYhZBIeBiY9tuftGHkWbsMN1W4nvGS4+cTKayH9
         6KJu4dWwLxpwSYJ9VCgv89xiN5FFU3ApAeU43Xp406BNDRcZhE3nXrI/dX4QKxuRvMdZ
         ThTw==
X-Gm-Message-State: AOAM5308R40E2qMpYsVxxtUkcjwlm6/vBFYvuRrV+fis0P0DfHtRFs0l
        llsPieNRt8BYw2DeTRZHjnSwXErmNs/mZXIJk8Yc5JaDotsIqcqUBSsw1yFVKkcDEqLh6mVNEbN
        fwCqCMJoWb6HM
X-Received: by 2002:a17:906:90b:: with SMTP id i11mr16444748ejd.661.1643112607118;
        Tue, 25 Jan 2022 04:10:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyy2JHArd+XerdRh9ICOs+QUEpJZrnqBkT+hSh9sSxhUCcC+g8rCsJft6WzhLhwMjet0V7nHA==
X-Received: by 2002:a17:906:90b:: with SMTP id i11mr16444704ejd.661.1643112606564;
        Tue, 25 Jan 2022 04:10:06 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id lv15sm6061140ejb.51.2022.01.25.04.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 04:10:05 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A2CA51805FA; Tue, 25 Jan 2022 13:10:03 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        David Ahern <dsahern@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v2 bpf-next 3/4] libbpf: deprecate legacy BPF map
 definitions
In-Reply-To: <CAEf4BzYJ9_1OpfCe9KZnDUDvezbc=bLFjq78n4tjBh=p_WFb3Q@mail.gmail.com>
References: <20220120060529.1890907-1-andrii@kernel.org>
 <20220120060529.1890907-4-andrii@kernel.org> <87wniu7hss.fsf@toke.dk>
 <CAEf4BzYpwK+iPPSx7G2-fTSc8dO-4+ObVP72cmu46z+gzFT0Cg@mail.gmail.com>
 <87lez87rbm.fsf@toke.dk>
 <CAEf4BzYJ9_1OpfCe9KZnDUDvezbc=bLFjq78n4tjBh=p_WFb3Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 25 Jan 2022 13:10:03 +0100
Message-ID: <87lez43tk4.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Fri, Jan 21, 2022 at 12:43 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@r=
edhat.com> wrote:
>>
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>
>> > On Thu, Jan 20, 2022 at 3:44 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke=
@redhat.com> wrote:
>> >>
>> >> Andrii Nakryiko <andrii@kernel.org> writes:
>> >>
>> >> > Enact deprecation of legacy BPF map definition in SEC("maps") ([0])=
. For
>> >> > the definitions themselves introduce LIBBPF_STRICT_MAP_DEFINITIONS =
flag
>> >> > for libbpf strict mode. If it is set, error out on any struct
>> >> > bpf_map_def-based map definition. If not set, libbpf will print out
>> >> > a warning for each legacy BPF map to raise awareness that it goes
>> >> > away.
>> >>
>> >> We've touched upon this subject before, but I (still) don't think it'=
s a
>> >> good idea to remove this support entirely: It makes it impossible to
>> >> write a loader that can handle both new and old BPF objects.
>> >>
>> >> So discourage the use of the old map definitions, sure, but please do=
n't
>> >> make it completely impossible to load such objects.
>> >
>> > BTF-defined maps have been around for quite a long time now and only
>> > have benefits on top of the bpf_map_def way. The source code
>> > translation is also very straightforward. If someone didn't get around
>> > to update their BPF program in 2 years, I don't think we can do much
>> > about that.
>> >
>> > Maybe instead of trying to please everyone (especially those that
>> > refuse to do anything to their BPF programs), let's work together to
>> > nudge laggards to actually modernize their source code a little bit
>> > and gain some benefits from that along the way?
>>
>> I'm completely fine with nudging people towards the newer features, and
>> I think the compile-time deprecation warning when someone is using the
>> old-style map definitions in their BPF programs is an excellent way to
>> do that.
>>
>> I'm also fine with libbpf *by default* refusing to load programs that
>> use the old-style map definitions, but if the code is removed completely
>> it becomes impossible to write general-purpose loaders that can handle
>> both old and new programs. The obvious example of such a loader is
>> iproute2, the loader in xdp-tools is another.
>
> This is because you want to deviate from underlying BPF loader's
> behavior and feature set and dictate your own extended feature set in
> xdp-tools/iproute2/etc. You can technically do that, but with a lot of
> added complexity and headaches. But demanding libbpf to maintain
> deprecated and discouraged features/APIs/practices for 10+ years and
> accumulate all the internal cruft and maintenance burden isn't a great
> solution either.

Right, so work with me to find a solution? I already suggested several
ideas, and you just keep repeating "just use the old library", which is
tantamount to saying "take a hike".

I'm perfectly fine with having to jump through some more hoops to load
old programs, and moving the old maps section parsing out of libbpf and
into the caller is fine as well; but then we'd need to add some hooks to
libbpf to create the maps inside the bpf_object. I can submit patches to
do this, but I'm not going to bother if you're just going to reject them
because you don't want to accommodate anything other than your way of
doing things :/

-Toke


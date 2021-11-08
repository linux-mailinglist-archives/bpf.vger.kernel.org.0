Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5AD447F67
	for <lists+bpf@lfdr.de>; Mon,  8 Nov 2021 13:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239495AbhKHMTQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Nov 2021 07:19:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51528 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239523AbhKHMTL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 8 Nov 2021 07:19:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636373786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vocr124ad3jPXg2gEgxmsFweYoUU2YKye8AipAjolqA=;
        b=OpzdCjy6HyG7DQf6GYyQL4qCcResCSM3pqrY+aAJ84E6XwIW+ZvgesPgsUJbV2L8CGTptG
        v2h4JVTC/XTVmFBq/taO092QKewZOVEK/XieF8u6QOPSQJcbr+bmLm/NEsd4FN1lOd6ZOI
        I8JwV8o/20+hURVODPFxfxtTSpKeHPo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-BxkAPfyEORiy5VPUY1zeLg-1; Mon, 08 Nov 2021 07:16:25 -0500
X-MC-Unique: BxkAPfyEORiy5VPUY1zeLg-1
Received: by mail-ed1-f71.google.com with SMTP id d11-20020a50cd4b000000b003da63711a8aso14623084edj.20
        for <bpf@vger.kernel.org>; Mon, 08 Nov 2021 04:16:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Vocr124ad3jPXg2gEgxmsFweYoUU2YKye8AipAjolqA=;
        b=OKakQezeWLWWp1PQRcepHEWLVbNa4/q0r9oUKwHtckYKFWpCpSBAigqkHnImfcfjnX
         C5Yb0fT7pmXO3OAtcNt90rKT9VPX4QvdK23tlRtVS8ug3zVpypKM84oxOufY2M/rRObl
         pJlLyIPUlaIiFz8XTWwzosKypNwTaHxOeT7wJPnXZqUf2j8YhOoQwgHsSPB4Cxa2mduC
         L9blGRvNVSf3vuior9y60Cm/ObKHxQ+X4FOg5alfnPxobt6ph9ejivpnESCFSV7fYvXc
         P6FGmPmuozVwsMRj2Ql7cmrqSMN195dWRgXyWxqT/ycnhCZ2WD6BtQIgvzyp/SBUrj2X
         +PJw==
X-Gm-Message-State: AOAM531FJvepa/dLTKw+rGhnb2LFWdDIrEZb2dnKlWOpJkX8UBfNTAAu
        zPRtK0b8S0hoJYjyRpeB0hSkgtiYyY+IigiPZcGi8rmH/bRnwvXY2Y+7yLphp2ZSZif4ulXPzVE
        tzZljZV6KXwJm
X-Received: by 2002:a17:906:1450:: with SMTP id q16mr101147344ejc.213.1636373784481;
        Mon, 08 Nov 2021 04:16:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwfa461Zcf2DxifgkuloXCvQmSLdTKSU2K/+OR/eAFgmifmQ9YjqS6nqyBvyQa4BprFeJJVCw==
X-Received: by 2002:a17:906:1450:: with SMTP id q16mr101147288ejc.213.1636373784132;
        Mon, 08 Nov 2021 04:16:24 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id i15sm9297892edk.2.2021.11.08.04.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 04:16:23 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2F3D618026D; Mon,  8 Nov 2021 13:16:23 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Ciara Loftus <ciara.loftus@intel.com>
Subject: Re: [PATCH bpf-next] libbpf: demote log message about unrecognised
 data sections back down to debug
In-Reply-To: <CAEf4BzY9WxjBX65sa=8SJh4XGLGfHgxGKciRGiSUMJAxbQWWYg@mail.gmail.com>
References: <20211104122911.779034-1-toke@redhat.com>
 <CAEf4BzYGjV5DQB7tqRkSKz6pz-3QtU7uSWQVNJMW4eSjnpF98A@mail.gmail.com>
 <87a6iismca.fsf@toke.dk>
 <CAEf4BzY9WxjBX65sa=8SJh4XGLGfHgxGKciRGiSUMJAxbQWWYg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 08 Nov 2021 13:16:23 +0100
Message-ID: <87pmrargfc.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Fri, Nov 5, 2021 at 7:34 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>>
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>
>> > On Thu, Nov 4, 2021 at 5:29 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@=
redhat.com> wrote:
>> >>
>> >> When loading a BPF object, libbpf will output a log message when it
>> >> encounters an unrecognised data section. Since commit
>> >> 50e09460d9f8 ("libbpf: Skip well-known ELF sections when iterating EL=
F")
>> >> they are printed at "info" level so they will show up on the console =
by
>> >> default.
>> >>
>> >> The rationale in the commit cited above is to "increase visibility" o=
f such
>> >> errors, but there can be legitimate, and completely harmless, uses of=
 extra
>> >> data sections. In particular, libxdp uses custom data sections to sto=
re
>> >
>> > What if we make those extra sections to be ".rodata.something" and
>> > ".data.something", but without ALLOC flag in ELF, so that libbpf won't
>> > create maps for them. Libbpf also will check that program code never
>> > references anything from those sections.
>> >
>> > The worry I have about allowing arbitrary sections is that if in the
>> > future we want to add other special sections, then we might run into a
>> > conflict with some applications. So having some enforced naming
>> > convention would help prevent this. WDYT?
>>
>> Hmm, I see your point, but as the libxdp example shows, this has not
>> really been "disallowed" before. I.e., having these arbitrary sections
>> has worked just fine.
>
> A bunch of things were not disallowed, but that is changing for libbpf
> 1.0, so now is the right time :)
>
>>
>> How about we do the opposite: claim a namespace for future libbpf
>> extensions and disallow (as in, hard fail) if anything unrecognised is
>> in those sections? For instance, this could be any section names
>> starting with .BPF?
>
> Looking at what we added (.maps, .kconfig, .ksym), there is no common
> prefix besides ".". I'd be ok to reserve anything starting with "."
> for future use by libbpf. We can allow any non-dot section without a
> warning (but it would have to be non-allocatable section). Would that
> work?

Not really :(

We already use .xdp_run_config as one of the section names in libxdp, so
if libbpf errors out on any .-prefixed section, we'll no longer be able
to load old BPF files. While we can update the calling code to deal with
any compatibility issues by detecting the libbpf version at compile-time
we don't have control over the BPF files we load. So there has to be a
way to opt out of any new stricter libbpf behaviour when loading BPF
files; I believe we had a similar discussion around map section names.

Any application using libbpf to load BPF files that wants to stay
compatible with old programs will have the same issue, BTW. iproute2
comes to mind as one...

-Toke


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE68496683
	for <lists+bpf@lfdr.de>; Fri, 21 Jan 2022 21:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiAUUnh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Jan 2022 15:43:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45637 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230112AbiAUUng (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 21 Jan 2022 15:43:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642797815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S1XX4m9Bmr/HmfkdNEEyVnFBNYxuSsoCPaheUwNGuAo=;
        b=el1naVEuWcbrzMPmie9Fy4D0r0PjAEEwWi68t9G4r1c78hiVF8HSC4k4ublQTfwB8ZgOOG
        pZhEzYaXu/HvXuACfJEMnifgFNaDhDYJqy+6/IfXg3kT0SYNVrhPlzYjxWryH+QX+Q7rDm
        7tuVTMz2rsVQEP48q+vtY9LXQMs5fJo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-osfhSRPzMIOxcMFtGvQqBA-1; Fri, 21 Jan 2022 15:43:34 -0500
X-MC-Unique: osfhSRPzMIOxcMFtGvQqBA-1
Received: by mail-ed1-f70.google.com with SMTP id w3-20020a50c443000000b0040696821132so2518063edf.22
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 12:43:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=S1XX4m9Bmr/HmfkdNEEyVnFBNYxuSsoCPaheUwNGuAo=;
        b=oBxDjTLHAcavnFsRY4qGtZBu+imOaCWteWwWz3rJ8UBUyrcRvML/Ct/Gj/lxtAVUsa
         eA32l9o2Lm5z6BKetpRucKC2t10qu8gVxGTm99A0FGp6iOkbO7tFzaymxwk2pMsIsZfi
         EuzdZH5RyVgbVE8tVFOGCc9bm1M2D6zJEQDn4anvV8hMmpHnBnkIi3mpDbwbaAXrijA6
         dTCYJQo94+7qc5dVDQI8wJo+a1XyO70XEfKQDy/TMcBMWopNUFihIf6Hxm34KPUimiuw
         2WT3SGnQ7e7ItQWDAs0da4vyT1HZt0M/GV5GSzEAJq1xby+kCX+DFCOl6lYO8IyjArx0
         ipow==
X-Gm-Message-State: AOAM530RZBk9QCCZxLVm6Og17TRGRQifObiKXBNPwQwUf20BgG12n2kQ
        yG2aSSLacGAb48Nvoj8kxQZ4FWyGDqxV447syN4mAHyS0lC1b3/uCfJQ2UwoEQs5AHnYJeSGeSJ
        RthpUI5FgOLYY
X-Received: by 2002:a17:906:35c4:: with SMTP id p4mr4702968ejb.221.1642797810590;
        Fri, 21 Jan 2022 12:43:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw9HiMmCOLxbFkD034zWlVFbrVFwHYjZep3VY0TsU68HkkinQe8UMn46gQKw5zTGvlPp9VTKw==
X-Received: by 2002:a17:906:35c4:: with SMTP id p4mr4702878ejb.221.1642797807879;
        Fri, 21 Jan 2022 12:43:27 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id i24sm2354626ejh.41.2022.01.21.12.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 12:43:27 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 7AE3A1802F8; Fri, 21 Jan 2022 21:43:25 +0100 (CET)
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
In-Reply-To: <CAEf4BzYpwK+iPPSx7G2-fTSc8dO-4+ObVP72cmu46z+gzFT0Cg@mail.gmail.com>
References: <20220120060529.1890907-1-andrii@kernel.org>
 <20220120060529.1890907-4-andrii@kernel.org> <87wniu7hss.fsf@toke.dk>
 <CAEf4BzYpwK+iPPSx7G2-fTSc8dO-4+ObVP72cmu46z+gzFT0Cg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 21 Jan 2022 21:43:25 +0100
Message-ID: <87lez87rbm.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Thu, Jan 20, 2022 at 3:44 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Andrii Nakryiko <andrii@kernel.org> writes:
>>
>> > Enact deprecation of legacy BPF map definition in SEC("maps") ([0]). F=
or
>> > the definitions themselves introduce LIBBPF_STRICT_MAP_DEFINITIONS flag
>> > for libbpf strict mode. If it is set, error out on any struct
>> > bpf_map_def-based map definition. If not set, libbpf will print out
>> > a warning for each legacy BPF map to raise awareness that it goes
>> > away.
>>
>> We've touched upon this subject before, but I (still) don't think it's a
>> good idea to remove this support entirely: It makes it impossible to
>> write a loader that can handle both new and old BPF objects.
>>
>> So discourage the use of the old map definitions, sure, but please don't
>> make it completely impossible to load such objects.
>
> BTF-defined maps have been around for quite a long time now and only
> have benefits on top of the bpf_map_def way. The source code
> translation is also very straightforward. If someone didn't get around
> to update their BPF program in 2 years, I don't think we can do much
> about that.
>
> Maybe instead of trying to please everyone (especially those that
> refuse to do anything to their BPF programs), let's work together to
> nudge laggards to actually modernize their source code a little bit
> and gain some benefits from that along the way?

I'm completely fine with nudging people towards the newer features, and
I think the compile-time deprecation warning when someone is using the
old-style map definitions in their BPF programs is an excellent way to
do that.=20

I'm also fine with libbpf *by default* refusing to load programs that
use the old-style map definitions, but if the code is removed completely
it becomes impossible to write general-purpose loaders that can handle
both old and new programs. The obvious example of such a loader is
iproute2, the loader in xdp-tools is another.

> It's the same thinking with stricter section names, and all the other
> backwards incompatible changes that libbpf 1.0 will do.

If the plan is to refuse entirely to load programs that use the older
section names, then I obviously have the same objection to that idea :)

> If you absolutely cannot afford to drop support for all the
> to-be-removed things from libbpf, you'll have to stick to 0.x libbpf
> version. I assume (it will be up to disto maintainers, I suppose)
> you'll have that option.

As in, you expect distributions to package up the old libbpf in a
separate package? Really?

But either way, that doesn't really help; it just makes it a choice
between supporting new or old programs. Can't very well link to two
versions of the same library...

I really don't get why you're so insistent on removing that code either;
it's not like it's code that has a lot of churn (by definition), nor is
it very much code in the first place. But if it's a question of
maintenance burden I'm happy to help maintain it; or we could find some
other way of letting applications hook into the ELF object parsing so
the code doesn't have to live inside libbpf proper if that's more to you
liking?

-Toke


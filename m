Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA494739A7
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 01:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235667AbhLNAhf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Dec 2021 19:37:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25343 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234762AbhLNAhf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Dec 2021 19:37:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639442254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N7Q3e2ko+rvmCWDe27t5CmJ3VC5aNXn3jBycIN5bA28=;
        b=NGAwESVxAGl1luPFvbTDY6czqORKSxUw1k/wd1cGVL0v0cKIy6KCDJXq+tCam9clQJmxmd
        qeaGZDkxU/VX5wtbuvbVpKVpjwAYz7Q30s7md0dxPFIQhaEdGWGJ4joaz+hEblnBxSOlGC
        Joaa+7O8bB0f1lzzx4TUdlBjJozCx6k=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-140-4XPhQhylO4WD-sJy0GGTAQ-1; Mon, 13 Dec 2021 19:37:33 -0500
X-MC-Unique: 4XPhQhylO4WD-sJy0GGTAQ-1
Received: by mail-ed1-f71.google.com with SMTP id b15-20020aa7c6cf000000b003e7cf0f73daso15399618eds.22
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 16:37:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=N7Q3e2ko+rvmCWDe27t5CmJ3VC5aNXn3jBycIN5bA28=;
        b=XRGZXTJToA0Tg34D/TuEcuNUupr7b5YAKc1blQpaT5SwVzKIRxPLjjFA7nbewlZs9Y
         LIIzw59cUX8Q+tJX0LaluQaaNEuxtXh5yx91jQEhS9H+nf6gsWYVwmnZVb0v7QzF5kfQ
         UPGim9RVDU73JDDs0Kx/Zz57d9EVXFhF/ACii+Ew7hWh1EHSSEfu3qon0JAsHM6oozNn
         5SiHaBFS7omludjeoWEeA4ueFlNnDN2N8BCjgi8RwTkZmxuT7nbJYgwsBbXwaoGCtIAp
         KlxmiPQhkIIkacjE6BAHvlFlfBBg4ghqWFDXUWWMPf5R791/JV7nOiqph+wnhJqrOvYx
         2LZA==
X-Gm-Message-State: AOAM5300OSwsG6slE61jC7Zo+3m3PKPsCfJdsOyYukaKEcFdPuAxOp3b
        C90infSxvkv5oNHO6FLSlR2r1f4W+BGJvNyUymDiqatZDQ2fnCXP4nZeKaMbhj7hHxY9rG3okMk
        8qduKKXlHrtCr
X-Received: by 2002:a17:907:7244:: with SMTP id ds4mr2047244ejc.55.1639442251519;
        Mon, 13 Dec 2021 16:37:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx2tU817eooQh0uYasNGE4FLArqonKJkM54b6iWlphSMsTzuufG9DLiY2g6W4tDjSSJKaqrOg==
X-Received: by 2002:a17:907:7244:: with SMTP id ds4mr2047134ejc.55.1639442250362;
        Mon, 13 Dec 2021 16:37:30 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id k21sm6822217edo.87.2021.12.13.16.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 16:37:29 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3C966183566; Tue, 14 Dec 2021 01:37:29 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 8/8] samples/bpf: Add xdp_trafficgen sample
In-Reply-To: <CAADnVQL6yL6hVGWL0cni-t+Lvpe91ST8moF69u5CwOLBKZT-GQ@mail.gmail.com>
References: <20211211184143.142003-1-toke@redhat.com>
 <20211211184143.142003-9-toke@redhat.com>
 <CAADnVQKiPgDtEUwg7WQ2YVByBUTRYuCZn-Y17td+XHazFXchaA@mail.gmail.com>
 <87r1ageafo.fsf@toke.dk>
 <CAADnVQL6yL6hVGWL0cni-t+Lvpe91ST8moF69u5CwOLBKZT-GQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 14 Dec 2021 01:37:29 +0100
Message-ID: <87czm0yqba.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Mon, Dec 13, 2021 at 8:28 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>>
>> > On Sat, Dec 11, 2021 at 10:43 AM Toke H=C3=B8iland-J=C3=B8rgensen <tok=
e@redhat.com> wrote:
>> >>
>> >> This adds an XDP-based traffic generator sample which uses the DO_RED=
IRECT
>> >> flag of bpf_prog_run(). It works by building the initial packet in
>> >> userspace and passing it to the kernel where an XDP program redirects=
 the
>> >> packet to the target interface. The traffic generator supports two mo=
des of
>> >> operation: one that just sends copies of the same packet as fast as i=
t can
>> >> without touching the packet data at all, and one that rewrites the
>> >> destination port number of each packet, making the generated traffic =
span a
>> >> range of port numbers.
>> >>
>> >> The dynamic mode is included to demonstrate how the bpf_prog_run() fa=
cility
>> >> enables building a completely programmable packet generator using XDP.
>> >> Using the dynamic mode has about a 10% overhead compared to the static
>> >> mode, because the latter completely avoids touching the page data.
>> >>
>> >> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> >> ---
>> >>  samples/bpf/.gitignore            |   1 +
>> >>  samples/bpf/Makefile              |   4 +
>> >>  samples/bpf/xdp_redirect.bpf.c    |  34 +++
>> >>  samples/bpf/xdp_trafficgen_user.c | 421 ++++++++++++++++++++++++++++=
++
>> >>  4 files changed, 460 insertions(+)
>> >>  create mode 100644 samples/bpf/xdp_trafficgen_user.c
>> >
>> > I think it deserves to be in tools/bpf/
>> > samples/bpf/ bit rots too often now.
>> > imo everything in there either needs to be converted to selftests/bpf
>> > or deleted.
>>
>> I think there's value in having a separate set of utilities that are
>> more user-facing than the selftests. But I do agree that it's annoying
>> they bit rot. So how about we fix that instead? Andrii suggested just
>> integrating the build of samples/bpf into selftests[0], so I'll look
>> into that after the holidays. But in the meantime I don't think there's
>> any harm in adding this utility here?
>
> I think samples/bpf building would help to stabilize bitroting,
> but the question of the right home for this trafficgen tool remains.
> I think it's best to keep it outside of the kernel tree.
> It's not any more special than all other libbpf and bcc tools.
> I think xdp-tools repo or bcc could be a home for it.

Alright, I'll drop it from the next version and put it into xdp-tools.
I've been contemplating doing the same for some of the other tools
(xdp_redirect* and xdp_monitor, for instance). Any opinion on that?

-Toke


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446A94354D0
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 22:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhJTU4o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 16:56:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34538 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230020AbhJTU4o (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 20 Oct 2021 16:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634763268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JlVQH1uLv7ZatNMq1r21H30ERd3KdAhMXJbH64TljGg=;
        b=egK39gZq3s9uqQYqZOtXXVqUmjg1+CgVk1+LoCtSwhzuVTPYX/dzMoNToq620wPIm7i9ga
        aIj/OntW0YuhsDerSEuqD2P4w5iegdmXKbPBdBruVFqTkPvqr+e+lBk+o7+F1RlLHk44UG
        JJQO/7x1+TU0yUFXWxUhYVYFgWX/DBI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-wxA6L9xKMgaUzy7KCVV5YA-1; Wed, 20 Oct 2021 16:54:27 -0400
X-MC-Unique: wxA6L9xKMgaUzy7KCVV5YA-1
Received: by mail-ed1-f70.google.com with SMTP id i7-20020a50d747000000b003db0225d219so17565879edj.0
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 13:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=JlVQH1uLv7ZatNMq1r21H30ERd3KdAhMXJbH64TljGg=;
        b=mYk9Q6q1kb+rkosCieVmbpdvzcmMj0znKhHKzlaaEgeO242122KzmupB02EybEfR6F
         J/WakmNIGz7+WRZOA7m133Rzse1H0a1TFwW6FXnZAE3skF+/hxkx1+G21EJR/mjFr1s4
         Sd0ZODAhSsCq7CyD/YK3mLe9J6c8DLhwzNY1pXl4TqPk5qrUv2KtJ+1EayMAj0sRJNwk
         UOoaBgYBFcci1uZlDxCa4/blTP4v+fgvxt4x0pR18o3Z7mtXP2g+21dxdcEOiCICpdBj
         patqgzVYbyzmqEWc9TA6ICaU+F7BQA2rr3jKftbpRTRRvxXoJecrqNnaRfZwfvDXaGr/
         IPog==
X-Gm-Message-State: AOAM530UyB3j/OgbS4oz0nBFDm8J4Ihzlk2yBAFRrpgiZHjO27FH7WGG
        Q5EFD7B/64Y6/Qnk++MyujzweSMV5bKDAgK/R0CyddUGmu7R17t4WXaocGFv5szkaRUkmqEWS7s
        43rmEWO8nnk5Z
X-Received: by 2002:aa7:c952:: with SMTP id h18mr1775575edt.18.1634763265098;
        Wed, 20 Oct 2021 13:54:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGgpDILve4QU+ct7o+I2FcDLkohe/7Gcx2dPo5XAylibimIm0Ab7EUT/mMtP/nr2u79KjuaA==
X-Received: by 2002:aa7:c952:: with SMTP id h18mr1775390edt.18.1634763263555;
        Wed, 20 Oct 2021 13:54:23 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id u8sm1728823edo.50.2021.10.20.13.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 13:54:22 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 12B14180262; Wed, 20 Oct 2021 22:54:22 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     Florian Westphal <fw@strlen.de>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Maxim Mikityanskiy <maximmi@nvidia.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@chromium.org>,
        Joe Stringer <joe@cilium.io>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Tariq Toukan <tariqt@nvidia.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH bpf-next 07/10] bpf: Add helpers to query conntrack info
In-Reply-To: <20211020124457.GA7604@breakpoint.cc>
References: <20211019144655.3483197-1-maximmi@nvidia.com>
 <20211019144655.3483197-8-maximmi@nvidia.com>
 <20211020035622.lgrxnrwfeak2e75a@apollo.localdomain>
 <20211020092844.GI28644@breakpoint.cc> <87h7dcf2n4.fsf@toke.dk>
 <20211020095815.GJ28644@breakpoint.cc> <875ytrga3p.fsf@toke.dk>
 <20211020124457.GA7604@breakpoint.cc>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 20 Oct 2021 22:54:22 +0200
Message-ID: <87r1cfe7sx.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Florian Westphal <fw@strlen.de> writes:

> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> wrote:
>> > Lookups should be fine.  Insertions are the problem.
>> >
>> > NAT hooks are expected to execute before the insertion into the
>> > conntrack table.
>> >
>> > If you insert before, NAT hooks won't execute, i.e.
>> > rules that use dnat/redirect/masquerade have no effect.
>>=20
>> Well yes, if you insert the wrong state into the conntrack table, you're
>> going to get wrong behaviour. That's sorta expected, there are lots of
>> things XDP can do to disrupt the packet flow (like just dropping the
>> packets :)).
>
> Sure, but I'm not sure I understand the use case.
>
> Insertion at XDP layer turns off netfilters NAT capability, so its
> incompatible with the classic forwarding path.
>
> If thats fine, why do you need to insert into the conntrack table to
> begin with?  The entire infrastructure its designed for is disabled...

One of the major selling points of XDP is that you can reuse the
existing kernel infrastructure instead of having to roll your own. So
sure, one could implement their own conntrack using BPF maps (as indeed,
e.g., Cilium has done), but why do that when you can take advantage of
the existing one in the kernel? Same reason we have the bpf_fib_lookup()
helper...

>> > I don't think there is anything that stands in the way of replicating
>> > this via XDP.
>>=20
>> What I want to be able to do is write an XDP program that does the follo=
wing:
>>=20
>> 1. Parse the packet header and determine if it's a packet type we know
>>    how to handle. If not, just return XDP_PASS and let the stack deal
>>    with corner cases.
>>=20
>> 2. If we know how to handle the packet (say, it's TCP or UDP), do a
>>    lookup into conntrack to figure out if there's state for it and we
>>    need to do things like NAT.
>>=20
>> 3. If we need to NAT, rewrite the packet based on the information we got
>>    back from conntrack.
>
> You could already do that by storing that info in bpf maps The
> ctnetlink event generated on conntrack insertion contains the NAT
> mapping information, so you could have a userspace daemon that
> intercepts those to update the map.

Sure, but see above.

>> 4. Update the conntrack state to be consistent with the packet, and then
>>    redirect it out the destination interface.
>>=20
>> I.e., in the common case the packet doesn't go through the stack at all;
>> but we need to make conntrack aware that we processed the packet so the
>> entry doesn't expire (and any state related to the flow gets updated).
>
> In the HW offload case, conntrack is bypassed completely. There is an
> IPS_(HW)_OFFLOAD_BIT that prevents the flow from expiring.

That's comparable in execution semantics (stack is bypassed entirely),
but not in control plane semantics (we lookup from XDP instead of
pushing flows down to an offload).

>> Ideally we should also be able to create new state for a flow we haven't
>> seen before.
>
> The way HW offload was intended to work is to allow users to express
> what flows should be offloaded via 'flow add' expression in nftables, so
> they can e.g. use byte counters or rate estimators etc. to make such
> a decision.  So initial packet always passes via normal stack.
>
> This is also needed to consider e.g. XFRM -- nft_flow_offload.c won't
> offload if the packet has a secpath attached (i.e., will get encrypted
> later).
>
> I suspect we'd want a way to notify/call an ebpf program instead so we
> can avoid the ctnetlink -> userspace -> update dance and do the XDP
> 'flow bypass information update' from inside the kernel and ebpf/XDP
> reimplementation of the nf flow table (it uses the netfilter ingress
> hook on the configured devices; everyhing it does should be doable
> from XDP).

But the point is exactly that we don't have to duplicate the state into
BPF, we can make XDP look it up directly.

>> This requires updating of state, but I see no reason why this shouldn't
>> be possible?
>
> Updating ct->status is problematic, there would have to be extra checks
> that prevent non-atomic writes and toggling of special bits such as
> CONFIRMED, TEMPLATE or DYING.  Adding a helper to toggle something
> specific, e.g. the offload state bit, should be okay.

We can certainly constrain the update so it's not possible to get into
an unsafe state. The primary use case is accelerating the common case,
punting to the stack is fine for corner cases.

-Toke


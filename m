Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D911488959
	for <lists+bpf@lfdr.de>; Sun,  9 Jan 2022 13:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbiAIMaH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 9 Jan 2022 07:30:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:37706 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233804AbiAIMaG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 9 Jan 2022 07:30:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641731405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uGtcNUPgCpAPxalFmcbbBthB7bt7xLf4gKTyYHWILFc=;
        b=TYwtDJu/d8ztdb123Ep4rjX/wG+lqXy2PKN+ytDXsoMsKOszaFnrUjpMlv/lLBiFvrwZm+
        +A4j+9I5pwrpinTAjyUbNHTUgogTC94tXl2nzNLjMLxhxtKsxBAcla56/GSkG0k+67NK55
        UhC/sG+o9W1DZlAenqscv/EKuvOjoB0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-277-0J5YN-BfPHy0zoQtv3AtlQ-1; Sun, 09 Jan 2022 07:30:03 -0500
X-MC-Unique: 0J5YN-BfPHy0zoQtv3AtlQ-1
Received: by mail-ed1-f70.google.com with SMTP id m16-20020a056402431000b003fb60bbe0e2so5289457edc.3
        for <bpf@vger.kernel.org>; Sun, 09 Jan 2022 04:30:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=uGtcNUPgCpAPxalFmcbbBthB7bt7xLf4gKTyYHWILFc=;
        b=o5AMFZIuPRKYXkXURsMzVsrS4OiwyByu0/1DE1KM+1I7W1dlRicF5BmRQYkJn1SIGK
         kU1UnHP7ki3nm6VuHgD8QZn9lpfl+T+18qHmp/seP/QZMm/DFE7wDiLkFp5z67UiPDSx
         pmHeCK3ODIV3K6NRhFrHZa6JSqrQE+hGa4eg9IHGoM1RcnH+q4ahFO+VNKRXybnwy0aE
         d47K7ZO9KGXIoPOmVBQQL+FzClxnOalKH0nXVGjjj59sXa94wS0PHffk3KVk5WuiiaoV
         VcTE1T7DOSYi79a/aFS7TrAXA0H67u/dwoFMGT6lzQec5ViMGaRAbJve17XIE/TB48zw
         HFvA==
X-Gm-Message-State: AOAM530MqXEWcHABitg9tQEPUgxn3vhbMJYSgG5xToVm2nU+oqqxqsMO
        j5QnS80reKRyA+b1qnL5Y93yxVXi8wpTO2LSEhiLBoWmDX6q4u1fEPRPgUpNB5PCdP16sBFQ6Uj
        ZbnXcylp4aFes
X-Received: by 2002:a17:906:b89a:: with SMTP id hb26mr13756747ejb.147.1641731402580;
        Sun, 09 Jan 2022 04:30:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwZSmGRnTJ/ZMrVH6vSQZfeFF8ZuooZ2ShhLeAb8P4J6LtP5pZw/RmEeRgK5MDoSyjRMuSp2Q==
X-Received: by 2002:a17:906:b89a:: with SMTP id hb26mr13756729ejb.147.1641731402106;
        Sun, 09 Jan 2022 04:30:02 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id kz9sm1348083ejc.152.2022.01.09.04.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 04:30:01 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 75501181F2E; Sun,  9 Jan 2022 13:30:00 +0100 (CET)
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
Subject: Re: [PATCH bpf-next v7 1/3] bpf: Add "live packet" mode for XDP in
 bpf_prog_run()
In-Reply-To: <20220109022448.bxgatdsx3obvipbu@ast-mbp.dhcp.thefacebook.com>
References: <20220107215438.321922-1-toke@redhat.com>
 <20220107215438.321922-2-toke@redhat.com>
 <CAADnVQ+uftgnRQa5nvG4FTJga_=_FMAGxuiPB3O=AFKfEdOg=A@mail.gmail.com>
 <87pmp28iwe.fsf@toke.dk>
 <CAADnVQLWjbm03-3NHYyEx98tWRN68LSaOd3R9fjJoHY5cYoEJg@mail.gmail.com>
 <87mtk67zfm.fsf@toke.dk>
 <20220109022448.bxgatdsx3obvipbu@ast-mbp.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sun, 09 Jan 2022 13:30:00 +0100
Message-ID: <87ee5h852v.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Sat, Jan 08, 2022 at 09:19:41PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>>=20
>> Sure, totally fine with documenting it. Just seems to me the most
>> obvious place to put this is in a new
>> Documentation/bpf/prog_test_run.rst file with a short introduction about
>> the general BPF_PROG_RUN mechanism, and then a subsection dedicated to
>> this facility.
>
> sgtm

Great!

>> > I guess it's ok-ish to get stuck with 128.
>> > It will be uapi that we cannot change though.
>> > Are you comfortable with that?
>>=20
>> UAPI in what sense? I'm thinking of documenting it like:
>>=20
>> "The packet data being supplied as data_in to BPF_PROG_RUN will be used
>>  for the initial run of the XDP program. However, when running the
>>  program multiple times (with repeat > 1), only the packet *bounds*
>>  (i.e., the data, data_end and data_meta pointers) will be reset on each
>>  invocation, the packet data itself won't be rewritten. The pages
>>  backing the packets are recycled, but the order depends on the path the
>>  packet takes through the kernel, making it hard to predict when a
>>  particular modified page makes it back to the XDP program. In practice,
>>  this means that if the XDP program modifies the packet payload before
>>  sending out the packet, it has to be prepared to deal with subsequent
>>  invocations seeing either the initial data or the already-modified
>>  packet, in arbitrary order."
>>=20
>> I don't think this makes any promises about any particular size of the
>> page pool, so how does it constitute UAPI?
>
> Could you explain out-of-order scanario again?
> It's possible only if xdp_redirect is done into different netdevs.
> Then they can xmit at different times and cycle pages back into
> the loop in different order. But TX or REDIRECT into the same netdev
> will keep the pages in the same order. So the program can rely on
> that.

I left that out on purpose: I feel it's exposing an internal
implementation detail as UAPI (as you said). And I'm not convinced it
really needed (or helpful) - see below.

>> >
>> > reinit doesn't feel necessary.
>> > How one would use this interface to send N different packets?
>> > The api provides an interface for only one.
>>=20
>> By having the XDP program react appropriately. E.g., here is the XDP
>> program used by the trafficgen tool to cycle through UDP ports when
>> sending out the packets - it just reads the current value and updates
>> based on that, so it doesn't matter if it sees the initial page or one
>> it already modified:
>
> Sure. I think there is an untapped potential here.
> With this live packet prog_run anyone can buy 10G or 100G nic equipped
> server and for free transform it into $300k+ IXIA beating machine.
> It could be a game changer. pktgen doesn't come close.
> I'm thinking about generating and consuming test TCP traffic.
> TCP blaster would xmit 1M TCP connections through this live prog_run
> into eth0 and consume the traffic returning from "server under test"
> via a different XDP program attached to eth0.
> The prog_run's xdp prog would need to send SYN, increment sequence number,
> and keep sane data in the packets. It could be HTTP request, for example.

I'm glad you see the potential :)

> To achive this IXIA beating setup the TCP blaster would need a full
> understanding of what page pool is doing with the packets.
> Just saying "in arbitrary order" is a non starter. It diminishes
> this live prog_run into pktgen equivalent which is still useful,
> but lots of potential is lost.

I don't think a detailed knowledge of how the pages are recycled is
needed to implement a TCP stream? Even if you just rely on the packets
being recycled with a fixed period of 128 pages, how does that make your
XDP program simpler? You'll still have to update the packet header for
each packet, with state kept in a map; so why is it helpful to know when
a particular page comes back?

I'll try implementing a TCP stream mode in xdp_trafficgen just to make
sure I'm not missing something. But I believe that sending out a stream
of packets that looks like a coherent TCP stream should be simple
enough, at least. Dealing with the full handshake + CWND control loop
will be harder, though, and right now I think it'll require multiple
trips back to userspace.

>> Another question seeing as the merge window is imminent: How do you feel
>> about merging this before the merge window? I can resubmit before it
>> opens with the updated selftest and documentation, and we can deal with
>> any tweaks during the -rcs; or would you rather postpone the whole
>> thing until the next cycle?
>
> It's already too late for this merge window, but bpf-next is always open.
> Just like it was open for the last year. So please resubmit as soon as
> the tests are green and this discussion is over.

Ah, OK. I was under the impression that the cutoff date was tomorrow;
has that changed? But no worries, I'll spend my Sunday outside instead
of coding, then, and come back to this tomorrow :)

-Toke


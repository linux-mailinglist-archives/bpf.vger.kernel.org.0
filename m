Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD2D4192600
	for <lists+bpf@lfdr.de>; Wed, 25 Mar 2020 11:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgCYKnE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Mar 2020 06:43:04 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:27724 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726139AbgCYKnD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 25 Mar 2020 06:43:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585132982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PsY1afjqXUvOhhLtl0Ou26hpywvwcP5IhlNh1OY1bj4=;
        b=UmB7Dqz8emVQnIVvB4pYMGVDrPeNULKLovT0rnDoNyDaAdXSyZ/yf/6hMV1ojBkJM4gq33
        AZxFKFONVVOfWf+/vJAYGTsniEwP5fBql7yXCkDB+uS7tC7g3o9MYrnTpuoFXjnWsuh3ga
        dHSmlarjfLYw5Vox8DwVUnqEW9Tvpko=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-gvpUC5oJMqyvYe_3h7Fmow-1; Wed, 25 Mar 2020 06:43:00 -0400
X-MC-Unique: gvpUC5oJMqyvYe_3h7Fmow-1
Received: by mail-lf1-f72.google.com with SMTP id x19so692769lfg.0
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2020 03:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=PsY1afjqXUvOhhLtl0Ou26hpywvwcP5IhlNh1OY1bj4=;
        b=O0bDouffcvw5YCVXq7b6lvfqob90zT1Erq+nPt7e1NhbufqYf5eUwLWctg0r4DRfUG
         qHHB7PgTwt9KQ3AQHax4eA9KMOZW2UCRLRAHLMZzrUGD6x79OARU+5BJORSoaKO+tw6a
         LD21Kev6ldp5KAod0xC4uvkU2w31uBd9ovwnDkCQzdGYVhnB4BjTWXjCJ2QPEPu/qfO9
         lCWSFWpae0MngPz2ZcEuyFr5EUMGdF3okR8tUCKenCfc1lBBWD34OdBPF6tf28zVyKe4
         fB7OBAnh1el6y3AvgBU5vCSBEMh2oBTsiqXkJj752jzMqXRhdzKJ4mlrjBbBrB4nsiA1
         jaOA==
X-Gm-Message-State: AGi0PuY6zAEdI+RkJCJpJoIuE2mOpmAPGUz1SHelIpY6mQNNO+jKwYrs
        4Lpt6jDP2e+wnMfRFn7TaRvbIpaFyDkNUS//ycdTNgUqcR47LxXIprefcLKKjzFOQlG68KOmWOB
        QzxUAPu/MmiBA
X-Received: by 2002:a2e:b302:: with SMTP id o2mr1644046lja.289.1585132979223;
        Wed, 25 Mar 2020 03:42:59 -0700 (PDT)
X-Google-Smtp-Source: APiQypJqC2CZ7MeUywLdP0GgN0NM9BSM6xSTLHdv9Tk+vvwIztLKJ8LVZLuGoJCCqFYxOSqlnHxvsQ==
X-Received: by 2002:a2e:b302:: with SMTP id o2mr1644027lja.289.1585132978951;
        Wed, 25 Mar 2020 03:42:58 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id q4sm13333841lfp.18.2020.03.25.03.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 03:42:58 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A253C18158B; Wed, 25 Mar 2020 11:42:57 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Andrey Ignatov <rdna@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/4] xdp: Support specifying expected existing program when attaching XDP
In-Reply-To: <20200325013631.vuncsvkivexdb3fr@ast-mbp>
References: <875zez76ph.fsf@toke.dk> <20200320103530.2853c573@kicinski-fedora-PC1C0HJN> <5e750bd4ebf8d_233f2ab4c81425c4ce@john-XPS-13-9370.notmuch> <CAEf4BzbWa8vdyLuzr_nxFM3BtT+hhzjCe9UQF8Y5cN+sVqa72g@mail.gmail.com> <87tv2f48lp.fsf@toke.dk> <CAEf4BzYutqP0yAy-KyToUNHM6Z-6C-XaEwK25pK123gejG0s9Q@mail.gmail.com> <87h7ye3mf3.fsf@toke.dk> <CAEf4BzY+JsmxCfjMVizLWYU05VS6DiwKE=e564Egu1jMba6fXQ@mail.gmail.com> <87tv2e10ly.fsf@toke.dk> <5e7a5e07d85e8_74a82ad21f7a65b88d@john-XPS-13-9370.notmuch> <20200325013631.vuncsvkivexdb3fr@ast-mbp>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 25 Mar 2020 11:42:57 +0100
Message-ID: <87wo78pvf2.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Tue, Mar 24, 2020 at 12:22:47PM -0700, John Fastabend wrote:
>> > 
>> > Well, I wasn't talking about any of those subsystems, I was talking
>> > about networking :)
>> 
>> My experience has been that networking in the strict sense of XDP no
>> longer exists on its own without cgroups, flow dissector, sockops,
>> sockmap, tracing, etc. All of these pieces are built, patched, loaded,
>> pinned and otherwise managed and manipulated as BPF objects via libbpf.
>> 
>> Because I have all this infra in place for other items its a bit odd
>> imo to drop out of BPF apis to then swap a program differently in the
>> XDP case from how I would swap a program in any other place. I'm
>> assuming ability to swap links will be enabled at some point.
>> 
>> Granted it just means I have some extra functions on the side to manage
>> the swap similar to how 'qdisc' would be handled today but still not as
>> nice an experience in my case as if it was handled natively.
>> 
>> Anyways the netlink API is going to have to call into the BPF infra
>> on the kernel side for verification, etc so its already not pure
>> networking.
>> 
>> > 
>> > In particular, networking already has a consistent and fairly
>> > well-designed configuration mechanism (i.e., netlink) that we are
>> > generally trying to move more functionality *towards* not *away from*
>> > (see, e.g., converting ethtool to use netlink).
>> 
>> True. But BPF programs are going to exist and interop with other
>> programs not exactly in the networking space. Actually library calls
>> might be used in tracing, cgroups, and XDP side. It gets a bit more
>> interesting if the "same" object file (with some patching) runs in both
>> XDP and sockops land for example.
>
> Thanks John for summarizing it very well.
> It looks to me that netlink proponents fail to realize that "bpf for
> networking" goes way beyond what netlink is doing and capable of doing in the
> future. BPF_*_INET_* progs do core networking without any smell of netlink
> anywhere. "But, but, but, netlink is the way to configure networking"... is
> simply not true.

That was not what I was saying. Obviously there are other components to
the networking stack than netlink.

What I'm saying is that netlink is the interface the kernel uses to
*configure network devices*. And that attaching an XDP program is a
network device configuration operation. I mean, it:

- Relies on the RTNL lock for synchronisation
- Fundamentally alters the flow of network packets on the device
- Potentially has side effects like link up/down, HWQ reconfig etc

I'm wondering if there's a way to reconcile these views? Maybe making
the bpf_link attachment work by passing the link fd to the netlink API?
That would keep the network interface configuration over netlink, but
would still allow a BPF application to swap out "its" programs via the
bpf_link APIs?

-Toke


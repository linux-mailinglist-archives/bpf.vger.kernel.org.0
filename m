Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA75434842
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 11:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhJTJuo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 05:50:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47369 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230164AbhJTJuj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 20 Oct 2021 05:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634723301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qwhcV7+62mZC/QuDizoFELn4/8v9RpDLeJdqv9FXywc=;
        b=G78ZvvikD4PqvSHsX3XRTcKrM3voJKTTw/BWPQIV7+szQpMEYmgQ0ILVt/wuhNlOZCmQJ7
        c52kayLw/2/vG7bLPFZPoPBET4UqQDdEjYLiSv5f6cbLh/2+AO33NoMb55h2Nql5Y++1bR
        MSStYPRqYrxzio0MvbYNib0ZF66GqPs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-6qfIoawkNNmCSPqJwvgAYw-1; Wed, 20 Oct 2021 05:48:20 -0400
X-MC-Unique: 6qfIoawkNNmCSPqJwvgAYw-1
Received: by mail-ed1-f72.google.com with SMTP id g28-20020a50d0dc000000b003dae69dfe3aso20441354edf.7
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 02:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=qwhcV7+62mZC/QuDizoFELn4/8v9RpDLeJdqv9FXywc=;
        b=0jop4T97bQVmpvHwR0OVvlCf24TpoEsJMObyrk8c2WAXQoFDXbTduBwRQPyrV2RWcC
         BU7b021AZ1CBJ+nHN78sEQwF0MknbXwamDDLCnj4f6kLkC06sSJPTdkd3fLGQQi832EH
         X8gudnPk9lUk3Q6pQ8UOOSP9POtCaCrQX8v25P0xd871+psFsvfwcftIy7DChE1WEPIS
         Dsil8cPfHfWhh5YEdv7UXZz1ZdzxtkDRjHtWlWxs1Ewa0R0FvIt8mGSsLK6bA20EUicK
         nT21+4M2APbmDccY5ol1XM7YxDgk/7+vYGrjVEq53+DvuzU0vNey64qwosAj5XUYXfsN
         dA3g==
X-Gm-Message-State: AOAM531qndxhICXbVafC1Nx5Dzbn5e3jfr0FAXYjgnw9NsHoLnT4GpFd
        ZxLr/34O4OgHRRnZGBosjY+Az0XShNHt0E8wEHa5CZ685ndgorlBR+C9x58QkeUr3KPe+6ZMQpD
        h6x/O06rZTFUp
X-Received: by 2002:a17:906:4a09:: with SMTP id w9mr44543695eju.419.1634723297474;
        Wed, 20 Oct 2021 02:48:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAoxItpasgNrCGgFTGs0Me5gRR0AarUPeZTF7qRa7e84TjoB2m/fuRoRFa4DZXaYylJ8yv0Q==
X-Received: by 2002:a17:906:4a09:: with SMTP id w9mr44543586eju.419.1634723296599;
        Wed, 20 Oct 2021 02:48:16 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id e7sm959484edz.95.2021.10.20.02.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 02:48:15 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 62278180262; Wed, 20 Oct 2021 11:48:15 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Florian Westphal <fw@strlen.de>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Maxim Mikityanskiy <maximmi@nvidia.com>,
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
In-Reply-To: <20211020092844.GI28644@breakpoint.cc>
References: <20211019144655.3483197-1-maximmi@nvidia.com>
 <20211019144655.3483197-8-maximmi@nvidia.com>
 <20211020035622.lgrxnrwfeak2e75a@apollo.localdomain>
 <20211020092844.GI28644@breakpoint.cc>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 20 Oct 2021 11:48:15 +0200
Message-ID: <87h7dcf2n4.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Florian Westphal <fw@strlen.de> writes:

> Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>> On Tue, Oct 19, 2021 at 08:16:52PM IST, Maxim Mikityanskiy wrote:
>> > The new helpers (bpf_ct_lookup_tcp and bpf_ct_lookup_udp) allow to query
>> > connection tracking information of TCP and UDP connections based on
>> > source and destination IP address and port. The helper returns a pointer
>> > to struct nf_conn (if the conntrack entry was found), which needs to be
>> > released with bpf_ct_release.
>> >
>> > Signed-off-by: Maxim Mikityanskiy <maximmi@nvidia.com>
>> > Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
>> 
>> The last discussion on this [0] suggested that stable BPF helpers for conntrack
>> were not desired, hence the recent series [1] to extend kfunc support to modules
>> and base the conntrack work on top of it, which I'm working on now (supporting
>> both CT lookup and insert).
>
> This will sabotage netfilter pipeline and the way things work more and
> more 8-(

Why?

> If you want to use netfilter with ebpf, please have a look at the RFC
> I posted and lets work on adding a netfilter specific program type
> that can run ebpf programs directly from any of the existing netfilter
> hook points.

Accelerating netfilter using BPF is a worthy goal in itself, but I also
think having the ability to lookup into conntrack from XDP is useful for
cases where someone wants to bypass the stack entirely (for accelerating
packet forwarding, say). I don't think these goals are in conflict
either, what makes you say they are?

-Toke


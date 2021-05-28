Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D895393FE1
	for <lists+bpf@lfdr.de>; Fri, 28 May 2021 11:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbhE1J1i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 May 2021 05:27:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37748 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235393AbhE1J1h (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 28 May 2021 05:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622193962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rCZj0KeRsRDbORMk4xZQhbpJRGIsjZXeaT4F9o2C3zo=;
        b=iJyRRJ8VCFkl7m8wlCkQTjri9SOjUSJ1bQ7kKvucD1pxS1itGI2sW4RW6yPpWowxAm8IqD
        vuTWh8QDO+sTvc2M7AlPhwQqKd4H3RboyfZmW3paowBtHKZr7PSb0xxDx/gZ5Zgu3BfVyn
        QWTn40QUroAjn+LjtJbdctvAY5Yvies=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-DDxOVsiVMLSv1zzm7BR7OA-1; Fri, 28 May 2021 05:25:59 -0400
X-MC-Unique: DDxOVsiVMLSv1zzm7BR7OA-1
Received: by mail-ej1-f69.google.com with SMTP id x20-20020a1709061354b02903cff4894505so916351ejb.14
        for <bpf@vger.kernel.org>; Fri, 28 May 2021 02:25:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=rCZj0KeRsRDbORMk4xZQhbpJRGIsjZXeaT4F9o2C3zo=;
        b=n/H/O66aO5mGgiAUmQx9uWVZCB8cvr9eRWuXLrLei4rUKD+gYE+dzr7jpfRGZyLP1e
         q8QMSFNAGL/Y1Vnu0YB1jA6ho093hxmtBgetUXQNzOZZAQXZnmKHpcpYdz9ajFpheUAx
         A0LPcPz0qDZ5sMvg8SLDoDEU4NR2Wo8gVjEXZAmNgdARpzNjer5RQk0guGjvwaEr/N2M
         jT6XE1KeyDhrKQ71nXwMVFOYrg5XrgDiHzKpaaSh0R57RZuvtsPevEu+G576mZEhiHBh
         zsiRhwIKy7qaztYru5WLRxcHhVUaMIxhz/66onEGTkEXdy2TvsKJ49vF4WWPtXAqd/pZ
         ZCRw==
X-Gm-Message-State: AOAM531eGR00qfQPT3Li3hdELrF4NtvmHlyy18iYEuiSLL2+hCaS20rF
        q+9Ht4w4zpJq2bWrj4RJSgu4CI6Xw/h2CQjjmovD0IxEodC2hhhynkG8f/84hMRdtHJRaNdKJdJ
        ZN2r9X/w5KKf0
X-Received: by 2002:a17:906:6bd8:: with SMTP id t24mr716795ejs.501.1622193957958;
        Fri, 28 May 2021 02:25:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwx1sRUoS9OH67HNclJ1NGntV7/GyBB2KWpub9RFUNqrM9RaNvZml+xjZQ5Ek7wAoqte+MmTw==
X-Received: by 2002:a17:906:6bd8:: with SMTP id t24mr716773ejs.501.1622193957772;
        Fri, 28 May 2021 02:25:57 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id u4sm2131950eje.81.2021.05.28.02.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:25:57 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8E34718071B; Fri, 28 May 2021 11:25:56 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Xie He <xie.he.0141@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        John Ogness <john.ogness@linutronix.de>,
        Wang Hai <wanghai38@huawei.com>,
        Tanner Love <tannerlove@google.com>,
        Eyal Birger <eyal.birger@gmail.com>,
        Menglong Dong <dong.menglong@zte.com.cn>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] xsk: support AF_PACKET
In-Reply-To: <1622192521.5931044-1-xuanzhuo@linux.alibaba.com>
References: <1622192521.5931044-1-xuanzhuo@linux.alibaba.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 28 May 2021 11:25:56 +0200
Message-ID: <87cztbgqfv.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Xuan Zhuo <xuanzhuo@linux.alibaba.com> writes:

> On Fri, 28 May 2021 10:55:58 +0200, Toke H=C3=B8iland-J=C3=B8rgensen <tok=
e@redhat.com> wrote:
>> Xuan Zhuo <xuanzhuo@linux.alibaba.com> writes:
>>
>> > In xsk mode, users cannot use AF_PACKET(tcpdump) to observe the current
>> > rx/tx data packets. This feature is very important in many cases. So
>> > this patch allows AF_PACKET to obtain xsk packages.
>>
>> You can use xdpdump to dump the packets from the XDP program before it
>> gets redirected into the XSK:
>> https://github.com/xdp-project/xdp-tools/tree/master/xdp-dump
>
> Wow, this is a good idea.
>
>>
>> Doens't currently work on egress, but if/when we get a proper TX hook
>> that should be doable as well.
>>
>> Wiring up XSK to AF_PACKET sounds a bit nonsensical: XSK is already a
>> transport to userspace, why would you need a second one?
>
> I have some different ideas. In my opinion, just like AF_PACKET can monit=
or
> tcp/udp packets, AF_PACKET monitors xsk packets is the same.

But you're adding code in the fast path to do this, in a code path where
others have been working quite hard to squeeze out every drop of
performance (literally chasing single nanoseconds). So I'm sorry, but
this approach is just not going to fly.

What is your use case anyway? Yes, being able to run tcpdump and see the
packets is nice and convenient, but what do you actually want to use
this for? Just for debugging your application? System monitoring?
Something else?

-Toke


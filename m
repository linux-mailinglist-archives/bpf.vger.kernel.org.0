Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E25736B4DC
	for <lists+bpf@lfdr.de>; Mon, 26 Apr 2021 16:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbhDZOaY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Apr 2021 10:30:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51246 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231862AbhDZOaX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 26 Apr 2021 10:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619447382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n46EzFusagW/ahDlcIl8UfUPxeR1VDuzUwzOh9SYcv0=;
        b=AJ/Zia0M3hgHtxiofwKZv37qTiQEVFqpNUMz/it4rdwy1r1mZ2Us8I0D0Swa5Sm8bBF2ZZ
        bhIxE9gMX5fsKQCVgAKCx3s0alRAeRc571o2f9zcKCtgkXO6nffgVsqVlO862Z67b2VF+F
        DAG62NlkGjKWvszO6SsVacaQSQZvGqE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-SnWlB_nNN5OlNFcpFGiRDg-1; Mon, 26 Apr 2021 10:29:38 -0400
X-MC-Unique: SnWlB_nNN5OlNFcpFGiRDg-1
Received: by mail-ed1-f69.google.com with SMTP id i2-20020a0564020542b02903875c5e7a00so3727918edx.6
        for <bpf@vger.kernel.org>; Mon, 26 Apr 2021 07:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=n46EzFusagW/ahDlcIl8UfUPxeR1VDuzUwzOh9SYcv0=;
        b=o3UO7YQ/SIG/6GucwbOAcdBtKXpzJjJ95fPC+MOL+maXEJ/BjjN8EbGzN72TamXrBp
         +4I2JhwmuJIet2vgSpLTNlvX46YyAws5JjRClVtQtexdm8mT9Rn0Ig6dBaV7QwOQ5M4E
         Xxps3znzk5VMPwV64C4k+XmMBWiW0aMvjf5hmRo4iu0rHw0T64grAnxt5dst+XmzR6IC
         GRa6CRakeTA5zC0cEn78namdfoFluL+cofnrOdDBuu4OLmAGG4reMfGy+bOX38xDH2hj
         2Qhko5BPZUzlWK2SrWtoCyvXSMHjvg//7pDaBX2Xk/ocMl82zwDNd2uuryTM/qtf0LgY
         LrRA==
X-Gm-Message-State: AOAM5308XraQWIfm4+T09pUexjfqregnXFS7Zwio9qvqwLQ2elVKVw3N
        XSWRa74QYVvXCKe5fjQyS24GdBkg4QLHEuQlpHge/diZ+dXwIo7LNuTl/MOXYXZup1cLmymwVOl
        5rCxM7puLCOhj
X-Received: by 2002:a17:906:3949:: with SMTP id g9mr18990011eje.7.1619447376591;
        Mon, 26 Apr 2021 07:29:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/vyK35PDWKExWj9FjIbhZnWZPZu/9axc5kKeS2p7CnpOoAsINFe2QXhzu02C2aENU0YLqbA==
X-Received: by 2002:a17:906:3949:: with SMTP id g9mr18989967eje.7.1619447376154;
        Mon, 26 Apr 2021 07:29:36 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 9sm11378126ejv.73.2021.04.26.07.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 07:29:35 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B1A08180615; Mon, 26 Apr 2021 16:29:33 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>, ast@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        =?utf-8?B?QmrDtnJuIFQ=?= =?utf-8?B?w7ZwZWw=?= 
        <bjorn.topel@gmail.com>, Martin KaFai Lau <kafai@fb.com>
Subject: Re: [PATCHv9 bpf-next 4/4] selftests/bpf: add xdp_redirect_multi test
In-Reply-To: <20210426101940.GP3465@Leo-laptop-t470s>
References: <20210422071454.2023282-1-liuhangbin@gmail.com>
 <20210422071454.2023282-5-liuhangbin@gmail.com>
 <20210426112832.0b746447@carbon> <20210426101940.GP3465@Leo-laptop-t470s>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 26 Apr 2021 16:29:33 +0200
Message-ID: <878s55ce5u.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hangbin Liu <liuhangbin@gmail.com> writes:

> On Mon, Apr 26, 2021 at 11:28:32AM +0200, Jesper Dangaard Brouer wrote:
>> On Thu, 22 Apr 2021 15:14:54 +0800
>> Hangbin Liu <liuhangbin@gmail.com> wrote:
>> 
>> > Add a bpf selftest for new helper xdp_redirect_map_multi(). In this
>> > test there are 3 forward groups and 1 exclude group. The test will
>> > redirect each interface's packets to all the interfaces in the forward
>> > group, and exclude the interface in exclude map.
>> > 
>> > Two maps (DEVMAP, DEVMAP_HASH) and two xdp modes (generic, drive) will
>> > be tested. XDP egress program will also be tested by setting pkt src MAC
>> > to egress interface's MAC address.
>> > 
>> > For more test details, you can find it in the test script. Here is
>> > the test result.
>> > ]# ./test_xdp_redirect_multi.sh
>> 
>> Running this test takes a long time around 3 minutes.
>
> Yes, there are some sleeps, ping tests. Don't know if I missed
> anything, is there a time limit for the selftest?

Not formally, but we already get complaints about tests running too
long, and if you write a test that takes three minutes to run you all
but guarantee that no one is going to run it in practice... :)

You could play with things like decreasing the ping interval (with -i),
maybe running fewer of them, and getting rid of all those 'sleep'
statements to decrease the runtime...

-Toke


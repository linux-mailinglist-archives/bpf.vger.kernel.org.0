Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2D51EE82C
	for <lists+bpf@lfdr.de>; Thu,  4 Jun 2020 18:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbgFDQDD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Jun 2020 12:03:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41978 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729668AbgFDQDC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 4 Jun 2020 12:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591286580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GetV94UZMx3iwG3dSG7sWxSDjBbf5Asdk1B0geH0iFc=;
        b=btHqHc7jeXmud42KmkYt2wq8Q9qvDCjEcJtN42maL1yzhButLuNIqQweKDeXinoKoD6PkS
        tfwGqUkyM+IVaXXrNhG0Pt3Ggy6/Z3v1dT8nheQe5dtyF1NC6Eq2yena3ROz53hc3jIqyh
        DNkZ382Olo4PKVKgd6UM0XSbRvhOhKA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-SHhQNKYUMXyf4HORMpfzDA-1; Thu, 04 Jun 2020 12:02:58 -0400
X-MC-Unique: SHhQNKYUMXyf4HORMpfzDA-1
Received: by mail-ed1-f71.google.com with SMTP id n17so2851615eda.13
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2020 09:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=GetV94UZMx3iwG3dSG7sWxSDjBbf5Asdk1B0geH0iFc=;
        b=sew8eIGmj0o3oy5LSWzBhis8ajldEimpW6quuoTdd7lTo+c/zxRi1Gn5xrN1byBwOJ
         s9qjekZ0hh1G5vsjzxa5hpsnCus2V2EaV5m1T1dhHBprFKzNttjVbCTFgnmQyo7GOiqN
         Xmpk7AbK/OIEB01nhOfTvtUy5jCaC/6m2mvX+VDk3lig1AKxqGojHmcRXFYpIX6U+9N3
         R0Sh754edvgonsF7ZR5rFGerGCq2oDHfns6vlqNNl4s0ApT7oMCSKujdOq+CMj02F97r
         bLfw3FqGSBlEH5uoXZLxT7aRSZJEnFPSUqPApMwMLsW39txI2JmG5ln4qZnNbQF8Wiyv
         KSbw==
X-Gm-Message-State: AOAM533/DuXxuaT4fpWUPuBZKH36mcu8TAERRktXB7zhq6EjN+eoPEs6
        QSn7oiiC6sFnOvPLmXmk3cBUAbKwLY+APikXwjMh3cNTjcKOs9vsXiTOqeQQIBZSEzhnZABJkv+
        lqZfmJ7O1IrwB
X-Received: by 2002:a17:906:4554:: with SMTP id s20mr4355663ejq.241.1591286577590;
        Thu, 04 Jun 2020 09:02:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxj1WooMjrjElh/e8ydLJAadDGMijBwwoIWZZaK71BZ5Ky7c7I9m65gzSvoxuA9fIyDmq4+kQ==
X-Received: by 2002:a17:906:4554:: with SMTP id s20mr4355633ejq.241.1591286577322;
        Thu, 04 Jun 2020 09:02:57 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id f11sm2774951edl.52.2020.06.04.09.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 09:02:55 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id EEAA1182018; Thu,  4 Jun 2020 18:02:54 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Hangbin Liu <liuhangbin@gmail.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>, ast@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Subject: Re: [PATCHv4 bpf-next 0/2] xdp: add dev map multicast support
In-Reply-To: <20200604144145.GN102436@dhcp-12-153.nay.redhat.com>
References: <20200415085437.23028-1-liuhangbin@gmail.com> <20200526140539.4103528-1-liuhangbin@gmail.com> <87zh9t1xvh.fsf@toke.dk> <20200603024054.GK102436@dhcp-12-153.nay.redhat.com> <87img8l893.fsf@toke.dk> <20200604040940.GL102436@dhcp-12-153.nay.redhat.com> <871rmvkvwn.fsf@toke.dk> <20200604121212.GM102436@dhcp-12-153.nay.redhat.com> <87bllzj9bw.fsf@toke.dk> <20200604144145.GN102436@dhcp-12-153.nay.redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 04 Jun 2020 18:02:54 +0200
Message-ID: <87d06ees41.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hangbin Liu <liuhangbin@gmail.com> writes:

> On Thu, Jun 04, 2020 at 02:37:23PM +0200, Toke H=C3=83=C6=92=C3=82=C2=B8i=
land-J=C3=83=C6=92=C3=82=C2=B8rgensen wrote:
>> > Now I use the ethtool_stats.pl to count forwarding speed and here is t=
he result:
>> >
>> > With kernel 5.7(ingress i40e, egress i40e)
>> > XDP:
>> > bridge: 1.8M PPS
>> > xdp_redirect_map:
>> >   generic mode: 1.9M PPS
>> >   driver mode: 10.4M PPS
>>=20
>> Ah, now we're getting somewhere! :)
>>=20
>> > Kernel 5.7 + my patch(ingress i40e, egress i40e)
>> > bridge: 1.8M
>> > xdp_redirect_map:
>> >   generic mode: 1.86M PPS
>> >   driver mode: 10.17M PPS
>>=20
>> Right, so this corresponds to a ~2ns overhead (10**9/10400000 -
>> 10**9/10170000). This is not too far from being in the noise, I suppose;
>> is the difference consistent?
>
> Sorry, I didn't get, what different consistent do you mean?

I meant, how much do the numbers vary between each test run?

>> > xdp_redirect_map_multi:
>> >   generic mode: 1.53M PPS
>> >   driver mode: 7.22M PPS
>> >
>> > Kernel 5.7 + my patch(ingress i40e, egress veth)
>> > xdp_redirect_map:
>> >   generic mode: 1.38M PPS
>> >   driver mode: 4.15M PPS
>> > xdp_redirect_map_multi:
>> >   generic mode: 1.13M PPS
>> >   driver mode: 3.55M PPS
>
> With XDP_DROP in veth perr, the number looks much better
>
> xdp_redirect_map:
>   generic mode: 1.64M PPS
>   driver mode: 13.3M PPS
> xdp_redirect_map_multi:
>   generic mode: 1.29M PPS
>   driver mode: 8.5M PPS

Is this for a single interface in both cases? Look a bit odd that you
get such a big difference all of a sudden; is the redirect failing in
one of those cases (should be a hint in the ethtool stats, I think,
otherwise check xdp_monitor)?

>> > Kernel 5.7 + my patch(ingress i40e, egress i40e + veth)
>> > xdp_redirect_map_multi:
>> >   generic mode: 1.13M PPS
>> >   driver mode: 3.47M PPS
>
> But I don't know why this one get even a little slower..
>
> xdp_redirect_map_multi:
>   generic mode: 0.96M PPS
>   driver mode: 3.14M PPS

Yeah, this does seem a bit odd. Don't have any good ideas off the top of
my head, but maybe worth double-checking where the time is spent. You
can use 'perf' for this, but you need to make sure it's recording the
CPU that is processing packets...

-Toke


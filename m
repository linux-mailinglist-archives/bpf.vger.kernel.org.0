Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079071ECDF6
	for <lists+bpf@lfdr.de>; Wed,  3 Jun 2020 13:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgFCLFg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Jun 2020 07:05:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44053 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726003AbgFCLFf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Jun 2020 07:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591182333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7/UZ1k1Tnz+0aL6W1DGoxSSobfkMGETgBO+uk6FERaM=;
        b=ilWFgepJztXU8paZnksYiDLX1VCU0fMtCNRPrDMphganF9C0gkEV7afQtU0zppAG+Bd7cS
        1H7tswEKd0Ni4S1AS/X7YOHGJC1NYaqnCr/vXtT4TMd1AT4qzugSZ0h4Xi7jTsCZc5PGGB
        0AxT1M2obov90WLVf1izK5BNgghIT80=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-KDeOwqGPMUKn62QpSnVlvA-1; Wed, 03 Jun 2020 07:05:31 -0400
X-MC-Unique: KDeOwqGPMUKn62QpSnVlvA-1
Received: by mail-ed1-f69.google.com with SMTP id k17so907204edo.20
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2020 04:05:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=7/UZ1k1Tnz+0aL6W1DGoxSSobfkMGETgBO+uk6FERaM=;
        b=QtNR5gtabNDSzmNJ09iVCbR0wYx92iGdvxL36C3E4Kw72+kDNEvXzA4Vdhd0ozG5QS
         GmOx1BjC++Fh9wWvfSyODa4sy9TCD31HJrNlD5ss7kCzjTX6qui13JhkxX0McGZV3dtO
         MfhiW4TwUrt44mV8V5+Ie5YUxmQpvBBdldXTkhCNnpO7DTafeN9Penc0JSoC/nAiu0qa
         KQ6Ucg7GFo+XzM4KjlLLO+RmmZG10NFnCym6ZxnFxVg79GgavIS8svmoALkUf9kwZzD5
         TT2ZT8wwXDuBZZu8s40l6LYZ4Bv5n5aiTkfExDmNCZI19zXlZpT0YiaOsZ9IlZFn/AYO
         jCZA==
X-Gm-Message-State: AOAM532m3j8EAy3l0d+/veYuNJdIcA4dDtPRK5ZBBXFI4CRjzeA8xols
        4yg9pzysn2wo4mjbEQhErKqhh5N2D4s8Lso2TgClarSvgMGz/g4fczADCg/pXXWXFx/hubOykBL
        67yQaZm+CxhwS
X-Received: by 2002:a05:6402:311c:: with SMTP id dc28mr15417535edb.184.1591182330459;
        Wed, 03 Jun 2020 04:05:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPv1J7mEIffBwXirBApKMnotEG2ItUqEy0W7mVGX7vHKGQMpxhiGMUsPP5lgXN4El4jaQIDg==
X-Received: by 2002:a05:6402:311c:: with SMTP id dc28mr15417508edb.184.1591182330204;
        Wed, 03 Jun 2020 04:05:30 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id s14sm933965ejd.111.2020.06.03.04.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 04:05:28 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 64AED182797; Wed,  3 Jun 2020 13:05:28 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Hangbin Liu <liuhangbin@gmail.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>, ast@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Subject: Re: [PATCHv4 bpf-next 0/2] xdp: add dev map multicast support
In-Reply-To: <20200603024054.GK102436@dhcp-12-153.nay.redhat.com>
References: <20200415085437.23028-1-liuhangbin@gmail.com> <20200526140539.4103528-1-liuhangbin@gmail.com> <87zh9t1xvh.fsf@toke.dk> <20200603024054.GK102436@dhcp-12-153.nay.redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 03 Jun 2020 13:05:28 +0200
Message-ID: <87img8l893.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hangbin Liu <liuhangbin@gmail.com> writes:

> On Wed, May 27, 2020 at 12:21:54PM +0200, Toke H=C3=83=C6=92=C3=82=C2=B8i=
land-J=C3=83=C6=92=C3=82=C2=B8rgensen wrote:
>> > The example in patch 2 is functional, but not a lot of effort
>> > has been made on performance optimisation. I did a simple test(pkt siz=
e 64)
>> > with pktgen. Here is the test result with BPF_MAP_TYPE_DEVMAP_HASH
>> > arrays:
>> >
>> > bpf_redirect_map() with 1 ingress, 1 egress:
>> > generic path: ~1600k pps
>> > native path: ~980k pps
>> >
>> > bpf_redirect_map_multi() with 1 ingress, 3 egress:
>> > generic path: ~600k pps
>> > native path: ~480k pps
>> >
>> > bpf_redirect_map_multi() with 1 ingress, 9 egress:
>> > generic path: ~125k pps
>> > native path: ~100k pps
>> >
>> > The bpf_redirect_map_multi() is slower than bpf_redirect_map() as we l=
oop
>> > the arrays and do clone skb/xdpf. The native path is slower than gener=
ic
>> > path as we send skbs by pktgen. So the result looks reasonable.
>>=20
>> How are you running these tests? Still on virtual devices? We really
>> need results from a physical setup in native mode to assess the impact
>> on the native-XDP fast path. The numbers above don't tell much in this
>> regard. I'd also like to see a before/after patch for straight
>> bpf_redirect_map(), since you're messing with the fast path, and we want
>> to make sure it's not causing a performance regression for regular
>> redirect.
>>=20
>> Finally, since the overhead seems to be quite substantial: A comparison
>> with a regular network stack bridge might make sense? After all we also
>> want to make sure it's a performance win over that :)
>
> Hi Toke,
>
> Here is the result I tested with 2 i40e 10G ports on physical machine.
> The pktgen pkt_size is 64.

These numbers seem a bit low (I'm getting ~8.5MPPS on my test machine
for a simple redirect). Some of that may just be performance of the
machine, I guess (what are you running this on?), but please check that
you are not limited by pktgen itself - i.e., that pktgen is generating
traffic at a higher rate than what XDP is processing.

> Bridge forwarding(I use sample/bpf/xdp1 to count the PPS, so there are tw=
o modes data):
> generic mode: 1.32M PPS
> driver mode: 1.66M PPS

I'm not sure I understand this - what are you measuring here exactly?

> xdp_redirect_map:
> generic mode: 1.88M PPS
> driver mode: 2.74M PPS

Please add numbers without your patch applied as well, for comparison.

> xdp_redirect_map_multi:
> generic mode: 1.38M PPS
> driver mode: 2.73M PPS

I assume this is with a single interface only, right? Could you please
add a test with a second interface (so the packet is cloned) as well?
You can just use a veth as the second target device.

-Toke


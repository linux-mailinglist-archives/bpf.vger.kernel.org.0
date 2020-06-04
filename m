Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1471EE1AF
	for <lists+bpf@lfdr.de>; Thu,  4 Jun 2020 11:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgFDJoc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Jun 2020 05:44:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34315 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727993AbgFDJoc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Jun 2020 05:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591263870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uZHdoObDjTElR9UN5P0vaZwCPB+TZB2WZjwDmEDQVDw=;
        b=DQwunvmb5P48Cv/I1QjLIb6H00CdzCeV4foPc/cYmhmCFrIy7PAjv1+/j+cgNjDJ6eFw9o
        nlpEvUez9eXCYLvOp97LvYSwBkiEek8wX7s4LDI/p6A58VOsQl1MMkEIOEqIE60v3VdiIN
        GBf8ukXKTMgsfYFGsSQryG/xPbwyCqU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-7BbuxaQeOcub_z6ILmiGww-1; Thu, 04 Jun 2020 05:44:28 -0400
X-MC-Unique: 7BbuxaQeOcub_z6ILmiGww-1
Received: by mail-ej1-f71.google.com with SMTP id w12so1920526ejf.5
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2020 02:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=uZHdoObDjTElR9UN5P0vaZwCPB+TZB2WZjwDmEDQVDw=;
        b=jVdXM646MRK+i5EWm9rKvb/8001uqmPIOB/uwispquiK8dA67bdPMHuGjidq58z75k
         XREjorBvIVaUOd3Q2JhjMVnvZXqgxb+CKtiIjRHSZaWVJ+PbEgwtVmp+W/JBNwGi72PT
         Ir/c8xkaAwqjMA8S+tFbFFwIm+mBRyQjNvhyWJZw/PV8oOtIZ1riCf86gRCo26XyZpxy
         tYbD5WvDh4jc9+r20vDe+q30ZEnIPRYyoaX0o84ktDd2GdJ2kBXmdJwJnRzLvmKVeJG7
         XlSI08o+pjJd8e5hK+ZMg3TWrSJasFzP8bRw+PkaYydnALpxu6b1usDcO/gXTSZSecB4
         V/wQ==
X-Gm-Message-State: AOAM531WNWW4zUVsIjSCHNvK7fgGfTgcFkJB7vHVULxif9MeRQsJWJTz
        M5riuORelzLjSY/CX3JOglTDT1YiljL65y8ToKXcdZVkMRltOUaAS03udiIcSaJzJp74TxG7JeA
        iAntXun/0jzqI
X-Received: by 2002:a17:906:ce2f:: with SMTP id sd15mr3033154ejb.445.1591263866912;
        Thu, 04 Jun 2020 02:44:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9U7Wk9/8k4fdL3F2ZW+JJ20/SRb3lDEepDfF9ATJXCTZc8SjjEWNmX6F77AOLfRhOWwu5eA==
X-Received: by 2002:a17:906:ce2f:: with SMTP id sd15mr3033139ejb.445.1591263866674;
        Thu, 04 Jun 2020 02:44:26 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id j10sm1931787edf.97.2020.06.04.02.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 02:44:25 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D6D68182797; Thu,  4 Jun 2020 11:44:24 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Hangbin Liu <liuhangbin@gmail.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>, ast@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Subject: Re: [PATCHv4 bpf-next 0/2] xdp: add dev map multicast support
In-Reply-To: <20200604040940.GL102436@dhcp-12-153.nay.redhat.com>
References: <20200415085437.23028-1-liuhangbin@gmail.com> <20200526140539.4103528-1-liuhangbin@gmail.com> <87zh9t1xvh.fsf@toke.dk> <20200603024054.GK102436@dhcp-12-153.nay.redhat.com> <87img8l893.fsf@toke.dk> <20200604040940.GL102436@dhcp-12-153.nay.redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 04 Jun 2020 11:44:24 +0200
Message-ID: <871rmvkvwn.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hangbin Liu <liuhangbin@gmail.com> writes:

> On Wed, Jun 03, 2020 at 01:05:28PM +0200, Toke H=C3=83=C6=92=C3=82=C2=B8i=
land-J=C3=83=C6=92=C3=82=C2=B8rgensen wrote:
>> > Hi Toke,
>> >
>> > Here is the result I tested with 2 i40e 10G ports on physical machine.
>> > The pktgen pkt_size is 64.
>>=20
>> These numbers seem a bit low (I'm getting ~8.5MPPS on my test machine
>> for a simple redirect). Some of that may just be performance of the
>> machine, I guess (what are you running this on?), but please check that
>> you are not limited by pktgen itself - i.e., that pktgen is generating
>> traffic at a higher rate than what XDP is processing.
>
> Here is the test topology, which looks like
>
>  Host A    |     Host B        |        Host C
>  eth0      +    eth0 - eth1    +        eth0
>
> I did pktgen sending on Host A, forwarding on Host B.
> Host B is a Dell PowerEdge R730 (128G memory, Intel(R) Xeon(R) CPU E5-269=
0 v3)
> eth0, eth1 is an onboard i40e 10G driver
>
> Test 1: add eth0, eth1 to br0 and test bridge forwarding
> Test 2: Test xdp_redirect_map(), eth0 is ingress, eth1 is egress
> Test 3: Test xdp_redirect_map_multi(), eth0 is ingress, eth1 is egress

Right, that all seems reasonable, but that machine is comparable to
my test machine, so you should be getting way more than 2.75 MPPS on a
regular redirect test. Are you bottlenecked on pktgen or something?

Could you please try running Jesper's ethtool stats poller:
https://github.com/netoptimizer/network-testing/blob/master/bin/ethtool_sta=
ts.pl

on eth0 on Host B, and see what PPS values you get on the different counter=
s?

>> > Bridge forwarding(I use sample/bpf/xdp1 to count the PPS, so there are=
 two modes data):
>> > generic mode: 1.32M PPS
>> > driver mode: 1.66M PPS
>>=20
>> I'm not sure I understand this - what are you measuring here exactly?
>
>> Finally, since the overhead seems to be quite substantial: A comparison
>> with a regular network stack bridge might make sense? After all we also
>> want to make sure it's a performance win over that :)
>
> I though you want me also test with bridge forwarding. Am I missing somet=
hing?

Yes, but what does this mean:
> (I use sample/bpf/xdp1 to count the PPS, so there are two modes data):

or rather, why are there two numbers? :)

>> > xdp_redirect_map:
>> > generic mode: 1.88M PPS
>> > driver mode: 2.74M PPS
>>=20
>> Please add numbers without your patch applied as well, for comparison.
>
> OK, I will.
>>=20
>> > xdp_redirect_map_multi:
>> > generic mode: 1.38M PPS
>> > driver mode: 2.73M PPS
>>=20
>> I assume this is with a single interface only, right? Could you please
>> add a test with a second interface (so the packet is cloned) as well?
>> You can just use a veth as the second target device.
>
> OK, so the topology on Host B should be like
>
> eth0 + eth1 + veth0, eth0 as ingress, eth1 and veth0 as egress, right?

Yup, exactly!

-Toke


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F83486623
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 15:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240186AbiAFOfA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 09:35:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:39546 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240183AbiAFOe7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 Jan 2022 09:34:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641479699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2WuXtGkDpAo/ntSMRFokvG8f43rf3nWbW3WKOjxk68M=;
        b=Lzxl37UucW6QoGLAkFPLJykVCIKd4p1EaaiCmbM9Qrudd/dqG+7xymTa1+zZG9BSHnCazq
        e83hjek6D9ZZbTnqqVrskcAVqKwVYm85zbJqULv1nBkNMSpuC25QHqG5AqX6vAMN/kua23
        0KqrkycIq1G/xiUlSOayaIi61qCjfXM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-M2FyB9LNMEGoGqqIruoekw-1; Thu, 06 Jan 2022 09:34:58 -0500
X-MC-Unique: M2FyB9LNMEGoGqqIruoekw-1
Received: by mail-ed1-f72.google.com with SMTP id x19-20020a05640226d300b003f8b80f5729so2067382edd.13
        for <bpf@vger.kernel.org>; Thu, 06 Jan 2022 06:34:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=2WuXtGkDpAo/ntSMRFokvG8f43rf3nWbW3WKOjxk68M=;
        b=lA9DPJWJirJMIbFc0rongdsKy7pgRadWGXNPeerBB0Z6xeVKuoYAiFRLZsLZkxWMxW
         Cc7Gk1DYDeq1ijtBT1O9+Cj7z29+/0bFKQjw7/+vWnx58oSqMntSxau4VtDikP0p2JKa
         veCKB6Ang1yXOcrmXpckomZPnylxKPuyHYOf4g/vGvEoVHT31hI+fUNQLlUQBGPhqxkU
         b/Y/AQ1qzU4qbRXjWQKibWr6cO5fjc2yD90HrVBOmWmEtUewWoFk/l0n0qrKN7fuBVGU
         /8I6vj/3X6jULUjQUa1vzaCPxxcp0YYz0uG6FADXhwFkw22aNC2v7QNf0apsWGHPqM2m
         wUtQ==
X-Gm-Message-State: AOAM530ntuw6dehvcT4N8LXnZCKZV8MTwuj8B6SoVpRz+8uqkr1nS46O
        CjhUy0v1iRbnI6F+kwkAdlnBEbMe+Pvd7l5/EmPNCh5c1IdLc0Hl3ynbmHLi8oglFOLIVGZspCZ
        IDMVGhDzaBjiD
X-Received: by 2002:a17:907:94d6:: with SMTP id dn22mr806452ejc.541.1641479696792;
        Thu, 06 Jan 2022 06:34:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyDCgJ2Wu+QbfvbTq9G/i0J9CNkAJCohUf+MBvFhiDIoUR5ShVWwd804DOkKmHO+ExX2mJqBw==
X-Received: by 2002:a17:907:94d6:: with SMTP id dn22mr806428ejc.541.1641479696367;
        Thu, 06 Jan 2022 06:34:56 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id o12sm784810edz.71.2022.01.06.06.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 06:34:55 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3B8A3181F2A; Thu,  6 Jan 2022 15:34:55 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 7/7] selftests/bpf: Add selftest for
 XDP_REDIRECT in bpf_prog_run()
In-Reply-To: <20220106042027.zy6j4a72nxaqmocw@ast-mbp.dhcp.thefacebook.com>
References: <20220103150812.87914-1-toke@redhat.com>
 <20220103150812.87914-8-toke@redhat.com>
 <20220106042027.zy6j4a72nxaqmocw@ast-mbp.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 06 Jan 2022 15:34:55 +0100
Message-ID: <87y23t9blc.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Mon, Jan 03, 2022 at 04:08:12PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> +
>> +#define NUM_PKTS 3
>
> May be send a bit more than 3 packets?
> Just to test skb_list logic for XDP_PASS.

OK, can do.

>> +
>> +	/* We setup a veth pair that we can not only XDP_REDIRECT packets
>> +	 * between, but also route them. The test packet (defined above) has
>> +	 * address information so it will be routed back out the same interface
>> +	 * after it has been received, which will allow it to be picked up by
>> +	 * the XDP program on the destination interface.
>> +	 *
>> +	 * The XDP program we run with bpf_prog_run() will cycle through all
>> +	 * four return codes (DROP/PASS/TX/REDIRECT), so we should end up with
>> +	 * NUM_PKTS - 1 packets seen on the dst iface. We match the packets on
>> +	 * the UDP payload.
>> +	 */
>> +	SYS("ip link add veth_src type veth peer name veth_dst");
>> +	SYS("ip link set dev veth_src address 00:11:22:33:44:55");
>> +	SYS("ip link set dev veth_dst address 66:77:88:99:aa:bb");
>> +	SYS("ip link set dev veth_src up");
>> +	SYS("ip link set dev veth_dst up");
>> +	SYS("ip addr add dev veth_src fc00::1/64");
>> +	SYS("ip addr add dev veth_dst fc00::2/64");
>> +	SYS("ip neigh add fc00::2 dev veth_src lladdr 66:77:88:99:aa:bb");
>> +	SYS("sysctl -w net.ipv6.conf.all.forwarding=3D1");
>
> These commands pollute current netns. The test has to create its own netns
> like other tests do.

Right, will fix.

> The forwarding=3D1 is odd. Nothing in the comments or commit logs
> talks about it.

Hmm, yeah, should probably have added an explanation, sorry about that :)

> I'm guessing it's due to patch 6 limitation of picking loopback
> for XDP_PASS and XDP_TX, right?
> There is ingress_ifindex field in struct xdp_md.
> May be use that to setup dev and rxq in test_run in patch 6?
> Then there will be no need to hack through forwarding=3D1 ?

No, as you note there's already ingress_ifindex to set the device, and
the test does use that:

+	memcpy(skel->rodata->expect_dst, &pkt_udp.eth.h_dest, ETH_ALEN);
+	skel->rodata->ifindex_out =3D ifindex_src;
+	ctx_in.ingress_ifindex =3D ifindex_src;

I enable forwarding because the XDP program that counts the packets is
running on the other end of the veth pair (on veth_dst), while the
traffic gen is using veth_src as its ingress ifindex. So for XDP_TX and
XDP_REDIRECT we send the frame back out the veth device, and it ends up
being processed by the XDP program on veth_dst, and counted. But when
the test program returns XDP_PASS, the packet will go up the frame; so
to get it back to the counting program I enable forwarding and set the
packet dst IP so that the stack routes it back out the same interface.

I'll admit this is a bit hacky; I guess I can add a second TC ingress
program that will count the packets being XDP_PASS'ed instead...

-Toke


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9C74C584D
	for <lists+bpf@lfdr.de>; Sat, 26 Feb 2022 22:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiBZVcn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 26 Feb 2022 16:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiBZVcm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 26 Feb 2022 16:32:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29A32583AD
        for <bpf@vger.kernel.org>; Sat, 26 Feb 2022 13:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645911126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nK0PVAC4y+xiFwMO8Vk7u/GCZxcWQNhJP8dZSYh/Vc4=;
        b=RxV5AUVhKwz0FJ0co5aDVcNc/iUW0Vtd0V+WsxcA5/JzqIvCQIcOAQUy178mWiswx7X4GX
        3Ad7AE5ehGiJnxAdMeWjTHQIILhdoC2GPsNubH7EZFbBr6ViPzdiCNaqtM5dniGQepEPYI
        qjOTkBum/HTw05bmGpItdmaocQZSU6w=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-pZ7lq5afM2SVgO2irEdqBA-1; Sat, 26 Feb 2022 16:32:04 -0500
X-MC-Unique: pZ7lq5afM2SVgO2irEdqBA-1
Received: by mail-ed1-f72.google.com with SMTP id d11-20020a50c88b000000b00410ba7a14acso3391248edh.6
        for <bpf@vger.kernel.org>; Sat, 26 Feb 2022 13:32:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=nK0PVAC4y+xiFwMO8Vk7u/GCZxcWQNhJP8dZSYh/Vc4=;
        b=Nhi+mZtx/AVKeydvy/J0RAUIwDHjQzCCnsNEYbQPS+PZk7MjKerPeIdF5g9CDpcQ6a
         nBkypu6comV1gyoiWQKobU8lehe3vILkNIxSB1e8k0mbhtAhrHOj06AXBuGF7wgF/4Pc
         +RUJOIjJYl1q+TdE7qMgwy0oy8va4EpbYGxDklk6DGUHABmd3708cwcFDkbFg1ytvXCR
         BjG5Xv379sZYhrx+cLTeg1V8yZ8nvyM6jlhnY8aJNG2HjqqJPmyy96pQeTwUXvmeKeVG
         ALkhPTWxJ/pLhFkmMFqPKvcYUBmFSS0rl9Ch9k5NJLdaDUhznmDYb0vd7iPxhReVJ/Ty
         II+g==
X-Gm-Message-State: AOAM532CUXREuyJsM0Hn40mAeEC0OpMeyEwtD1Ajt3bWa0EEG77JGfs7
        B5ttTm1LYPu7M3J0SKSd6jT518BEf324YhLv17sEP1XUXlr7EzZZIEHtinQPqHIunxApkRN1TqY
        P0h3DdwOSYilv
X-Received: by 2002:a17:906:4ad6:b0:6b8:33e5:c3a1 with SMTP id u22-20020a1709064ad600b006b833e5c3a1mr10400084ejt.472.1645911123553;
        Sat, 26 Feb 2022 13:32:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxEljZLRVtBTXEAe1NQIb725EdQdUWhZA+Ki0dAr06/KvUxNPZPmGrD2t5VyS5x2NAGeKUdiw==
X-Received: by 2002:a17:906:4ad6:b0:6b8:33e5:c3a1 with SMTP id u22-20020a1709064ad600b006b833e5c3a1mr10400062ejt.472.1645911123129;
        Sat, 26 Feb 2022 13:32:03 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id u10-20020a50d94a000000b004131aa2525esm3471782edj.49.2022.02.26.13.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 13:32:02 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id EBEB2130DD6; Sat, 26 Feb 2022 22:32:00 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v8 5/5] selftests/bpf: Add selftest for
 XDP_REDIRECT in BPF_PROG_RUN
In-Reply-To: <20220224011949.7mt4pluj4apqr44h@kafai-mbp.dhcp.thefacebook.com>
References: <20220218175029.330224-1-toke@redhat.com>
 <20220218175029.330224-6-toke@redhat.com>
 <20220224011949.7mt4pluj4apqr44h@kafai-mbp.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 26 Feb 2022 22:32:00 +0100
Message-ID: <87a6eduxf3.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martin KaFai Lau <kafai@fb.com> writes:

> On Fri, Feb 18, 2022 at 06:50:29PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
> [ .. ]
>
>> diff --git a/tools/testing/selftests/bpf/progs/test_xdp_do_redirect.c b/=
tools/testing/selftests/bpf/progs/test_xdp_do_redirect.c
>> new file mode 100644
>> index 000000000000..af3cffccc794
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/test_xdp_do_redirect.c
>> @@ -0,0 +1,85 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <vmlinux.h>
>> +#include <bpf/bpf_helpers.h>
>> +
>> +#define ETH_ALEN 6
>> +const volatile int ifindex_out;
>> +const volatile int ifindex_in;
>> +const volatile __u8 expect_dst[ETH_ALEN];
>> +volatile int pkts_seen_xdp =3D 0;
>> +volatile int pkts_seen_tc =3D 0;
>> +volatile int retcode =3D XDP_REDIRECT;
>> +
>> +SEC("xdp")
>> +int xdp_redirect(struct xdp_md *xdp)
>> +{
>> +	__u32 *metadata =3D (void *)(long)xdp->data_meta;
>> +	void *data =3D (void *)(long)xdp->data;
>> +	int ret =3D retcode;
>> +
>> +	if (xdp->ingress_ifindex !=3D ifindex_in)
>> +		return XDP_ABORTED;
>> +
>> +	if (metadata + 1 > data)
>> +		return XDP_ABORTED;
>> +
>> +	if (*metadata !=3D 0x42)
>> +		return XDP_ABORTED;
>> +
>> +	if (bpf_xdp_adjust_meta(xdp, 4))
>> +		return XDP_ABORTED;
>> +
>> +	if (retcode > XDP_PASS)
>> +		retcode--;
>> +
>> +	if (ret =3D=3D XDP_REDIRECT)
>> +		return bpf_redirect(ifindex_out, 0);
>> +
>> +	return ret;
>> +}
>> +
>> +static bool check_pkt(void *data, void *data_end)
>> +{
>> +	struct ethhdr *eth =3D data;
>> +	struct ipv6hdr *iph =3D (void *)(eth + 1);
>> +	struct udphdr *udp =3D (void *)(iph + 1);
>> +	__u8 *payload =3D (void *)(udp + 1);
>> +
>> +	if (payload + 1 > data_end)
>> +		return false;
>> +
>> +	if (iph->nexthdr !=3D IPPROTO_UDP || *payload !=3D 0x42)
>> +		return false;
>> +
>> +	/* reset the payload so the same packet doesn't get counted twice when
>> +	 * it cycles back through the kernel path and out the dst veth
>> +	 */
>> +	*payload =3D 0;
>> +	return true;
>> +}
>> +
>> +SEC("xdp")
>> +int xdp_count_pkts(struct xdp_md *xdp)
>> +{
>> +	void *data =3D (void *)(long)xdp->data;
>> +	void *data_end =3D (void *)(long)xdp->data_end;
>> +
>> +	if (check_pkt(data, data_end))
>> +		pkts_seen_xdp++;
>> +
>> +	return XDP_PASS;
> If it is XDP_DROP here (@veth-ingress), the packet will be put back to
> the page pool with zero-ed payload and that will be closer to the real
> scenario when xmit-ing out of a real NIC instead of veth? Just to
> ensure I understand the recycling and pkt rewrite description in patch
> 2 correctly because it seems the test always getting a data init-ed
> page.

Ah, yeah, good point, we do end up releasing all the pages on the other
end of the veth, so they don't get recycled. I'll change to XDP_DROP the
packets, and change the xdp_redirect() function to explicitly set the
payload instead of expecting it to come from userspace.

> Regarding to the tcp trafficgen in the xdptool repo,
> do you have thoughts on how to handle retransmit (e.g. after seeing
> SACK or dupack)?  Is it possible for the regular xdp receiver (i.e.
> not test_run) to directly retransmit it after seeing SACK if it knows
> the tcp payload?

Hmm, that's an interesting idea. Yeah, I think it should be possible for
the XDP program on the interface to reply with the missing packet
directly: it can just resize the ACK coming in, rewrite the TCP header,
fill it out with the payload, and return XDP_TX. However, this will
obviously only work if every SACK can be fulfilled with a single
re-transmission, which I don't think we can assume in the general case?
So I think some more state needs to be kept; however, such direct reply
hole-filling could potentially be a nice optimisation to have on top in
any case, so thank you for the idea!

> An off topic question, I expect the test_run approach is faster.
> Mostly curious, do you have a rough guess on what may be the perf
> difference with doing it in xsk?

Good question. There certainly exists very high performance DPDK-based
traffic generators; and AFAIK, XSK can more or less match DPDK
performance in zero-copy mode, so in this case I think it should be
possible to match the test_run in raw performance. Not sure about copy
mode; and of course in both cases it comes with the usual limitation of
having to dedicate a suitably configured NIC queue, whereas the
in-kernel trafficgen can run without interfering with other traffic
(except for taking up the link capacity, of course).

-Toke


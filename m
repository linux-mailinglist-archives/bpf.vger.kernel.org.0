Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19FE4199EA
	for <lists+bpf@lfdr.de>; Mon, 27 Sep 2021 19:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbhI0RFV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Sep 2021 13:05:21 -0400
Received: from www62.your-server.de ([213.133.104.62]:56290 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235492AbhI0RFU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Sep 2021 13:05:20 -0400
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mUu2K-0005pc-TZ; Mon, 27 Sep 2021 19:03:28 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1mUu2K-0000Qp-EN; Mon, 27 Sep 2021 19:03:28 +0200
Subject: Re: [PATCH v2 1/2] tools/include: Update if_link.h and netlink.h
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     Ian Rogers <irogers@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Igor Russkikh <irusskikh@marvell.com>,
        Mark Starovoytov <mstarovoitov@marvell.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Vlad Buslov <vladbu@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Alexandre Cassen <acassen@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
References: <20210922222935.495290-1-irogers@google.com>
 <e126f901-f3ce-1325-b3c1-9d325bbc8249@iogearbox.net>
Message-ID: <014c2f18-cede-ccc6-6d45-ca09093a6c76@iogearbox.net>
Date:   Mon, 27 Sep 2021 19:03:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <e126f901-f3ce-1325-b3c1-9d325bbc8249@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.3/26305/Mon Sep 27 11:04:42 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/27/21 7:02 PM, Daniel Borkmann wrote:
> On 9/23/21 12:29 AM, Ian Rogers wrote:
>> Sync the uAPI headers so that userspace and the kernel match. These
>> changes make the tools version match the updates to the files in the
>> kernel directory that were updated by commits:
>>
>> if_link.h:
>> 8f4c0e01789c hsr: enhance netlink socket interface to support PRP
>> 427f0c8c194b macvlan: Add nodst option to macvlan type source
>> 583be982d934 mctp: Add device handling and netlink interface
>> c7fa1d9b1fb1 net: bridge: mcast: dump ipv4 querier state
>> 2dba407f994e net: bridge: multicast: make tracked EHT hosts limit configurable
>> b6e5d27e32ef net: ethernet: rmnet: Add support for MAPv5 egress packets
>> 14452ca3b5ce net: qualcomm: rmnet: Export mux_id and flags to netlink
>> 78a3ea555713 net: remove comments on struct rtnl_link_stats
>> 0db0c34cfbc9 net: tighten the definition of interface statistics
>> 571912c69f0e net: UDP tunnel encapsulation module for tunnelling different protocols like MPLS, IP, NSH etc.
>> 00e77ed8e64d rtnetlink: add IFLA_PARENT_[DEV|DEV_BUS]_NAME
>> 829eb208e80d rtnetlink: add support for protodown reason
>>
>> netlink.h:
>> d07dcf9aadd6 netlink: add infrastructure to expose policies to userspace
>> 44f3625bc616 netlink: export policy in extended ACK
>> d409989b59ad netlink: simplify NLMSG_DATA with NLMSG_HDRLEN
>> a85cbe6159ff uapi: move constants from <linux/kernel.h> to <linux/const.h>
>>
>> v2. Is a rebase and sync to the latest versions. A list of changes
>>      computed via diff and blame was added to the commit message as suggested
>>      in:
>> https://lore.kernel.org/lkml/20201015223119.1712121-1-irogers@google.com/
>>
>> Signed-off-by: Ian Rogers <irogers@google.com>
> 
> With both patches applied to bpf-next, this would break our CI:
> 
> [...]
>    CC       bench.o
>    CC       bench_count.o
>    CC       bench_rename.o
>    CC       bench_trigger.o
>    CC       bench_ringbufs.o
>    BINARY   bench
>    BINARY   xdpxceiver
> xdpxceiver.c: In function ‘testapp_invalid_desc’:
> xdpxceiver.c:1223:41: warning: implicit declaration of function ‘ARRAY_SIZE’ [-Wimplicit-function-declaration]
>   1223 |  pkt_stream_generate_custom(test, pkts, ARRAY_SIZE(pkts));
>        |                                         ^~~~~~~~~~
> /usr/bin/ld: /tmp/ccoQONpi.o: in function `testapp_invalid_desc':
> /root/daniel/bpf/tools/testing/selftests/bpf/xdpxceiver.c:1223: undefined reference to `ARRAY_SIZE'
> collect2: error: ld returned 1 exit status
> make: *** [Makefile:166: /root/daniel/bpf/tools/testing/selftests/bpf/xdpxceiver] Error 1
> 
> Please take a look and submit v3 of the series with the build issue fixed.

See also: https://github.com/kernel-patches/bpf/pull/1822/checks?check_run_id=3714445336

Thanks,
Daniel

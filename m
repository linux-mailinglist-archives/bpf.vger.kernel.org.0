Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB533C7ACD
	for <lists+bpf@lfdr.de>; Wed, 14 Jul 2021 03:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237283AbhGNBIX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Jul 2021 21:08:23 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6812 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237288AbhGNBIW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Jul 2021 21:08:22 -0400
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GPfKz5z3nzXpcc;
        Wed, 14 Jul 2021 08:59:51 +0800 (CST)
Received: from [10.174.178.171] (10.174.178.171) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 14 Jul 2021 09:05:28 +0800
Subject: Re: Ask for help about bpf map
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        David Ahern <dahern@digitalocean.com>
References: <5aebe6f4-ca0d-4f64-8ee6-b68c58675271@huawei.com>
 <CAEf4BzZpSo8Kqz8mgPdbWTTVLqJ1AgE429_KHTiXgEVpbT97Yw@mail.gmail.com>
 <8735sidtwe.fsf@toke.dk>
From:   "luwei (O)" <luwei32@huawei.com>
Message-ID: <d1f47a24-6328-5121-3a1f-5a102444e50c@huawei.com>
Date:   Wed, 14 Jul 2021 09:05:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <8735sidtwe.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.171]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I have updated the iproute2 according this page: 
https://github.com/cilium/cilium/issues/7446

Now I use this version of iproute2: https://github.com/shemminger/iproute2

The version of iproute2 is 5.11, and the kernel version is 5.13(the 
latest version).


在 2021/7/14 1:07 AM, Toke Høiland-Jørgensen 写道:
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
>> On Mon, Jul 12, 2021 at 11:35 PM luwei (O) <luwei32@huawei.com> wrote:
>>> Hi, List:
>>>
>>>         I am a beginner about bpf and working on XDP now. I meet a
>>> problem and feel difficult to figure it out.
>>>
>>>         In my following codes, I use two ways to define my_map: in SEC
>>> maps and SEC .maps respectively. When I load the xdp_kern.o file,
>>>
>>> It has different results. The way I load is: ip link set dev ens3 xdp
>>> obj xdp1_kern.o sec xdp1.
>>>
>>>         when I define my_map using SEC maps, it loads successfully but
>>> fails to load using SEC .maps, it reports:
>>>
>>> "
>>>
>>> [12] TYPEDEF __u32 type_id=13
>>> [13] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
>>> [14] FUNC_PROTO (anon) return=2 args=(10 ctx)
>>> [15] FUNC xdp_prog1 type_id=14
>>> [16] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
>>> [17] ARRAY (anon) type_id=16 index_type_id=4 nr_elems=4
>>> [18] VAR _license type_id=17 linkage=1
>>> [19] DATASEC .maps size=0 vlen=1 size == 0
>>>
>>>
>>> Prog section 'xdp1' rejected: Permission denied (13)!
>>>    - Type:         6
>>>    - Instructions: 9 (0 over limit)
>>>    - License:      GPL
>>>
>>> Verifier analysis:
>>>
>>> 0: (b7) r1 = 0
>>> 1: (63) *(u32 *)(r10 -4) = r1
>>> last_idx 1 first_idx 0
>>> regs=2 stack=0 before 0: (b7) r1 = 0
>>> 2: (bf) r2 = r10
>>> 3: (07) r2 += -4
>>> 4: (18) r1 = 0x0
>> this shouldn't be 0x0.
>>
>> I suspect you have an old iproute2 which doesn't yet use libbpf to
>> load BPF programs, so .maps definition is not yet supported. cc'ing
>> netdev@vger, David and Toke
> That would be my guess as well; what's the output of 'ip -V'?
>
> -Toke
>
> .

-- 
Best Regards,
Lu Wei


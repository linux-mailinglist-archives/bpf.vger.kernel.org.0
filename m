Return-Path: <bpf+bounces-54276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CE3A66ADB
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 07:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2819C3BC446
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 06:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC25C1DF27F;
	Tue, 18 Mar 2025 06:50:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6051DE880;
	Tue, 18 Mar 2025 06:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742280618; cv=none; b=LxzrGLK5zY8qJxT3avyUqTN3HQrNTcc4rKjtI/8otwv69owHo1DWsqhpoEveTpS3JDtFHFTuij5uuQtn1a2El05SDsEAjxwoGbek7aTQnY4RpYSmueVWvWmVOV+eCTlFSD3SRci4QAVF7jmt4j8cUzdNvxjD3ysTNIaFyCSdo1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742280618; c=relaxed/simple;
	bh=RjbR+qoqPHGhyvEjVqVR/Fl/pkTbqueGH69RzYFxo4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QGlOPNZ8LAmC269/Fiq+DPxMDa8O8tonEf0qr/xriCXIG8o/VgySUqYSG9ieq2K4+s5gcwp+MEW9Nc2tSaPdcJ0uRDShnLz2thIGZwkE69YpwYgfuZmD+PpTHk1+5NAEhqLHGZ4cUgqpXRFUYVWx5m09bIIttnddGCoh8JMiVME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZH2SY5xByz2CcpP;
	Tue, 18 Mar 2025 14:46:53 +0800 (CST)
Received: from kwepemg200005.china.huawei.com (unknown [7.202.181.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 3488C14022D;
	Tue, 18 Mar 2025 14:50:07 +0800 (CST)
Received: from [10.174.176.70] (10.174.176.70) by
 kwepemg200005.china.huawei.com (7.202.181.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 18 Mar 2025 14:50:05 +0800
Message-ID: <ef48d387-fb22-4059-a887-c9438c6e33b1@huawei.com>
Date: Tue, 18 Mar 2025 14:50:04 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bonding: check xdp prog when set bond mode
To: Nikolay Aleksandrov <razor@blackwall.org>,
	=?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	<jv@jvosburgh.net>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <joamaki@gmail.com>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
References: <20250314073549.1030998-1-wangliang74@huawei.com>
 <87y0x7rkck.fsf@toke.dk> <21d52659-622a-4b2a-b091-787bf0f5d67f@blackwall.org>
 <96a4043b-fdac-4ca1-a7b9-a6352b1d7dfe@blackwall.org>
 <fad4cb08-be38-4f43-ba61-db147e4d26d0@huawei.com>
 <6ea34ad0-8456-4e49-8eb1-372cf571d91b@blackwall.org>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <6ea34ad0-8456-4e49-8eb1-372cf571d91b@blackwall.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg200005.china.huawei.com (7.202.181.32)


在 2025/3/17 15:39, Nikolay Aleksandrov 写道:
> On 3/17/25 06:07, Wang Liang wrote:
>> 在 2025/3/14 18:44, Nikolay Aleksandrov 写道:
>>> On 3/14/25 12:22 PM, Nikolay Aleksandrov wrote:
>>>> On 3/14/25 12:13 PM, Toke Høiland-Jørgensen wrote:
>>>>> Wang Liang <wangliang74@huawei.com> writes:
>>>>>
>>>>>> Following operations can trigger a warning[1]:
>>>>>>
>>>>>>       ip netns add ns1
>>>>>>       ip netns exec ns1 ip link add bond0 type bond mode balance-rr
>>>>>>       ip netns exec ns1 ip link set dev bond0 xdp obj af_xdp_kern.o sec xdp
>>>>>>       ip netns exec ns1 ip link set bond0 type bond mode broadcast
>>>>>>       ip netns del ns1
>>>>>>
>>>>>> When delete the namespace, dev_xdp_uninstall() is called to remove xdp
>>>>>> program on bond dev, and bond_xdp_set() will check the bond mode. If bond
>>>>>> mode is changed after attaching xdp program, the warning may occur.
>>>>>>
>>>>>> Some bond modes (broadcast, etc.) do not support native xdp. Set bond mode
>>>>>> with xdp program attached is not good. Add check for xdp program when set
>>>>>> bond mode.
>>>>>>
>>>>>>       [1]
>>>>>>       ------------[ cut here ]------------
>>>>>>       WARNING: CPU: 0 PID: 11 at net/core/dev.c:9912 unregister_netdevice_many_notify+0x8d9/0x930
>>>>>>       Modules linked in:
>>>>>>       CPU: 0 UID: 0 PID: 11 Comm: kworker/u4:0 Not tainted 6.14.0-rc4 #107
>>>>>>       Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
>>>>>>       Workqueue: netns cleanup_net
>>>>>>       RIP: 0010:unregister_netdevice_many_notify+0x8d9/0x930
>>>>>>       Code: 00 00 48 c7 c6 6f e3 a2 82 48 c7 c7 d0 b3 96 82 e8 9c 10 3e ...
>>>>>>       RSP: 0018:ffffc90000063d80 EFLAGS: 00000282
>>>>>>       RAX: 00000000ffffffa1 RBX: ffff888004959000 RCX: 00000000ffffdfff
>>>>>>       RDX: 0000000000000000 RSI: 00000000ffffffea RDI: ffffc90000063b48
>>>>>>       RBP: ffffc90000063e28 R08: ffffffff82d39b28 R09: 0000000000009ffb
>>>>>>       R10: 0000000000000175 R11: ffffffff82d09b40 R12: ffff8880049598e8
>>>>>>       R13: 0000000000000001 R14: dead000000000100 R15: ffffc90000045000
>>>>>>       FS:  0000000000000000(0000) GS:ffff888007a00000(0000) knlGS:0000000000000000
>>>>>>       CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>>       CR2: 000000000d406b60 CR3: 000000000483e000 CR4: 00000000000006f0
>>>>>>       Call Trace:
>>>>>>        <TASK>
>>>>>>        ? __warn+0x83/0x130
>>>>>>        ? unregister_netdevice_many_notify+0x8d9/0x930
>>>>>>        ? report_bug+0x18e/0x1a0
>>>>>>        ? handle_bug+0x54/0x90
>>>>>>        ? exc_invalid_op+0x18/0x70
>>>>>>        ? asm_exc_invalid_op+0x1a/0x20
>>>>>>        ? unregister_netdevice_many_notify+0x8d9/0x930
>>>>>>        ? bond_net_exit_batch_rtnl+0x5c/0x90
>>>>>>        cleanup_net+0x237/0x3d0
>>>>>>        process_one_work+0x163/0x390
>>>>>>        worker_thread+0x293/0x3b0
>>>>>>        ? __pfx_worker_thread+0x10/0x10
>>>>>>        kthread+0xec/0x1e0
>>>>>>        ? __pfx_kthread+0x10/0x10
>>>>>>        ? __pfx_kthread+0x10/0x10
>>>>>>        ret_from_fork+0x2f/0x50
>>>>>>        ? __pfx_kthread+0x10/0x10
>>>>>>        ret_from_fork_asm+0x1a/0x30
>>>>>>        </TASK>
>>>>>>       ---[ end trace 0000000000000000 ]---
>>>>>>
>>>>>> Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
>>>>>> Signed-off-by: Wang Liang <wangliang74@huawei.com>
>>>>>> ---
>>>>>>    drivers/net/bonding/bond_options.c | 3 +++
>>>>>>    1 file changed, 3 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
>>>>>> index 327b6ecdc77e..127181866829 100644
>>>>>> --- a/drivers/net/bonding/bond_options.c
>>>>>> +++ b/drivers/net/bonding/bond_options.c
>>>>>> @@ -868,6 +868,9 @@ static bool bond_set_xfrm_features(struct bonding *bond)
>>>>>>    static int bond_option_mode_set(struct bonding *bond,
>>>>>>                    const struct bond_opt_value *newval)
>>>>>>    {
>>>>>> +    if (bond->xdp_prog)
>>>>>> +        return -EOPNOTSUPP;
>>>>>> +
>>>>> Should we allow changing as long as the new mode also supports XDP?
>>>>>
>>>>> -Toke
>>>>>
>>>>>
>>>> +1
>>>> I think we should allow it, the best way probably is to add a new option
>>>> BOND_VALFLAG_XDP_UNSUPP (for example) as a bond option flag and to set
>>>> it in bond_options.c for each mode that doesn't support XDP, then you
>>>> can do the check in a generic way (for any option) in
>>>> bond_opt_check_deps. Any bond option that can't be changed with XDP prog
>>> err, I meant any bond option's value that isn't supported with XDP, for
>>> a whole option it would be a bit different
>> Thanks for your suggestions!
>>
>> When install xdp prog, bond_xdp_set() use bond_xdp_check() to check whether the bond mode support xdp.
>>
>> When uninstall xdp prog, the paramter prog of bond_xdp_set() is NULL. How about not call bond_xdp_check() to avoid the warning when the prog is NULL, like:
>>
>> static int bond_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>>              struct netlink_ext_ack *extack)
>>      ...
>>      if (prog && !bond_xdp_check(bond))
> No, this could cause other problems. Actually, for -net I think the best would be to stick to
> a simpler fix and just do bond_xdp_check() if there's a XDP program attached when changing
> the mode so it can be backported easier. The option value flag can be done in the future
> if more option values (or options) need to be disabled for XDP.
>
> Cheers,
>   Nik
Excuse me again. I hope that I haven't misunderstood your suggestions.

When I try to do bond_xdp_check() if there's a XDP program attached when
changing the mode in function bond_option_mode_set(). bond_xdp_check()
visit bond->params.mode and bond->params.xmit_policy, should I create a
new function, whose paramter is int mode?

Looking forward to getting more replies. Thanks.
>>>> should have that flag set.
>>>>
>>>> Cheers,
>>>>    Nik
>>>>
>


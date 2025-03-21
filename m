Return-Path: <bpf+bounces-54535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DD1A6B688
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 10:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F5EF18832FF
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 09:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450961F03D5;
	Fri, 21 Mar 2025 09:01:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA94D1EB19A;
	Fri, 21 Mar 2025 09:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742547702; cv=none; b=GFkj+IChmCYb7ywDvpoomW2IEzhA7b+0icn77hDI+OYhOaZ3yuqX+/qNPQvWBcHj51ZXq9d/Vnua1xq/Dq6LfwRIJk/ayVknJbVmn3RV7bTiMu32wjXEEx5ZnlibSHHeZvA75rS3cSAfUz6zN7hXYM7VigaoLYcRsakU3Fd2xFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742547702; c=relaxed/simple;
	bh=e4M4/yfL4oWL2Z5SMIc2ThiJGneEk+8KDomEk/eSqsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EDWXxuErI1bNljzOeWNVCa1RN6xPCx06m6P0hufqBKXwlCftA2A58sknKwhSGWKs0EWe2b+/pwiylOQpJFz+YQ3Aj05BN6ikDg3pXVss7FvHy66YuthTq4PIoqwOjqu6o/mwhtVyplnC1bgkntjjx9wMoI6oaydPOvg9Ck13O2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZJxDs2GSrz2CcQf;
	Fri, 21 Mar 2025 16:58:21 +0800 (CST)
Received: from kwepemg200005.china.huawei.com (unknown [7.202.181.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 0F82514010C;
	Fri, 21 Mar 2025 17:01:36 +0800 (CST)
Received: from [10.174.176.70] (10.174.176.70) by
 kwepemg200005.china.huawei.com (7.202.181.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 21 Mar 2025 17:01:34 +0800
Message-ID: <63bba360-473c-47fd-b7b4-06cadf995704@huawei.com>
Date: Fri, 21 Mar 2025 17:01:33 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] bonding: check xdp prog when set bond mode
To: Nikolay Aleksandrov <razor@blackwall.org>, <jv@jvosburgh.net>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<joamaki@gmail.com>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
References: <20250321044852.1086551-1-wangliang74@huawei.com>
 <977fc7da-b7dc-4518-b7c9-0c492e2508f6@blackwall.org>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <977fc7da-b7dc-4518-b7c9-0c492e2508f6@blackwall.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg200005.china.huawei.com (7.202.181.32)


在 2025/3/21 16:49, Nikolay Aleksandrov 写道:
> On 3/21/25 06:48, Wang Liang wrote:
>> Following operations can trigger a warning[1]:
>>
>>      ip netns add ns1
>>      ip netns exec ns1 ip link add bond0 type bond mode balance-rr
>>      ip netns exec ns1 ip link set dev bond0 xdp obj af_xdp_kern.o sec xdp
>>      ip netns exec ns1 ip link set bond0 type bond mode broadcast
>>      ip netns del ns1
>>
>> When delete the namespace, dev_xdp_uninstall() is called to remove xdp
>> program on bond dev, and bond_xdp_set() will check the bond mode. If bond
>> mode is changed after attaching xdp program, the warning may occur.
>>
>> Some bond modes (broadcast, etc.) do not support native xdp. Set bond mode
>> with xdp program attached is not good. Add check for xdp program when set
>> bond mode.
>>
>>      [1]
>>      ------------[ cut here ]------------
>>      WARNING: CPU: 0 PID: 11 at net/core/dev.c:9912 unregister_netdevice_many_notify+0x8d9/0x930
>>      Modules linked in:
>>      CPU: 0 UID: 0 PID: 11 Comm: kworker/u4:0 Not tainted 6.14.0-rc4 #107
>>      Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
>>      Workqueue: netns cleanup_net
>>      RIP: 0010:unregister_netdevice_many_notify+0x8d9/0x930
>>      Code: 00 00 48 c7 c6 6f e3 a2 82 48 c7 c7 d0 b3 96 82 e8 9c 10 3e ...
>>      RSP: 0018:ffffc90000063d80 EFLAGS: 00000282
>>      RAX: 00000000ffffffa1 RBX: ffff888004959000 RCX: 00000000ffffdfff
>>      RDX: 0000000000000000 RSI: 00000000ffffffea RDI: ffffc90000063b48
>>      RBP: ffffc90000063e28 R08: ffffffff82d39b28 R09: 0000000000009ffb
>>      R10: 0000000000000175 R11: ffffffff82d09b40 R12: ffff8880049598e8
>>      R13: 0000000000000001 R14: dead000000000100 R15: ffffc90000045000
>>      FS:  0000000000000000(0000) GS:ffff888007a00000(0000) knlGS:0000000000000000
>>      CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>      CR2: 000000000d406b60 CR3: 000000000483e000 CR4: 00000000000006f0
>>      Call Trace:
>>       <TASK>
>>       ? __warn+0x83/0x130
>>       ? unregister_netdevice_many_notify+0x8d9/0x930
>>       ? report_bug+0x18e/0x1a0
>>       ? handle_bug+0x54/0x90
>>       ? exc_invalid_op+0x18/0x70
>>       ? asm_exc_invalid_op+0x1a/0x20
>>       ? unregister_netdevice_many_notify+0x8d9/0x930
>>       ? bond_net_exit_batch_rtnl+0x5c/0x90
>>       cleanup_net+0x237/0x3d0
>>       process_one_work+0x163/0x390
>>       worker_thread+0x293/0x3b0
>>       ? __pfx_worker_thread+0x10/0x10
>>       kthread+0xec/0x1e0
>>       ? __pfx_kthread+0x10/0x10
>>       ? __pfx_kthread+0x10/0x10
>>       ret_from_fork+0x2f/0x50
>>       ? __pfx_kthread+0x10/0x10
>>       ret_from_fork_asm+0x1a/0x30
>>       </TASK>
>>      ---[ end trace 0000000000000000 ]---
>>
>> Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
>> Signed-off-by: Wang Liang <wangliang74@huawei.com>
>> ---
>>   drivers/net/bonding/bond_main.c    | 8 ++++----
>>   drivers/net/bonding/bond_options.c | 3 +++
>>   include/net/bonding.h              | 1 +
>>   3 files changed, 8 insertions(+), 4 deletions(-)
> Just fyi you should include what changed since v1 below the ---.
Got it. Thank you very much for the reminder!
> Anyway, thanks! This is exactly what I meant.
>
> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
>
>


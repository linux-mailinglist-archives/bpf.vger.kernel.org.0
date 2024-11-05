Return-Path: <bpf+bounces-44046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C58179BCEC6
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 15:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E0891F21FED
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 14:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABFC1D8A0A;
	Tue,  5 Nov 2024 14:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rt2ttlRS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44433BBC9;
	Tue,  5 Nov 2024 14:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730815906; cv=none; b=SzC7r6phxhAc2w93ytEDahIly2NQ6Dp75NrqUrISfYPn85tX8nqcvRlQmCOmdmC3Ca9aY86ENy+GiF/BD9Bu/aUSORLmHXVYXe37h532+HsVyMw+5M2nBNLQrB6BJ8TGCf6xOLpjVPHLckkHq11oSDRlP0IHXffD16uoQMkMewY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730815906; c=relaxed/simple;
	bh=0WSBsfn0zyqfURqVyS/eb9dxqlw503vfFy1homl8FaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tUGzrQ+wclYsBbkEpMCUVpUG228nRndceKR+WkA4fFhWLYtgq2BAffRmKFbmiIFtdgB6DVYIFNeYn0B3hjrA7dzGQBpCuZhEW2Nfp+kFnwN4HptbtgnrCHIZWsm3O1mNGxelQXWlCuV4CoCMA4n3yCpVSGh6GRwKYYqxG20RqN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rt2ttlRS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BD5C4CECF;
	Tue,  5 Nov 2024 14:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730815906;
	bh=0WSBsfn0zyqfURqVyS/eb9dxqlw503vfFy1homl8FaE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Rt2ttlRSlUu5ayiMA1HyQol4hUW6t6hMd5LLqvX4+J/rW8IwpyrDU2k39RctrpHA2
	 sJlC1x3zfbkb2HqFvmkC3oKWJb2tzqUlmDJKR6JdJUFuggoQztW1FTzFYJsq888i4m
	 d+3//7p+/p1J2f+2N4qy5k1XSQgMrP7YQhZ4OmTDz2mgSZzm7xvVamNG4nFMsBS4JT
	 bYvEBf6HdnnTjzGJ2A1KBasZSXeJ39lMoXF/DQNnHmQHjUzPiLU9J8EJlWo8of5pE9
	 Sb12/uwAAAXk4pMH08V0qNsr/LLSh+r6hOQ1ELk+qKN11+NjlHf8cWpvtJoYaZIZyA
	 qLRtL3SiDdkVA==
Message-ID: <ea828032-d211-463c-8d34-1e6497399149@kernel.org>
Date: Tue, 5 Nov 2024 16:11:40 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/2] net: ethernet: ti: am65-cpsw: fix warning in
 am65_cpsw_nuss_remove_rx_chns()
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Md Danish Anwar <danishanwar@ti.com>,
 Govindarajan Sriramakrishnan <srk@ti.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20241101-am65-cpsw-multi-rx-j7-fix-v3-0-338fdd6a55da@kernel.org>
 <20241101-am65-cpsw-multi-rx-j7-fix-v3-2-338fdd6a55da@kernel.org>
 <20241105133042.GD4507@kernel.org>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241105133042.GD4507@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Simon,

On 05/11/2024 15:30, Simon Horman wrote:
> On Fri, Nov 01, 2024 at 12:18:51PM +0200, Roger Quadros wrote:
>> flow->irq is initialized to 0 which is a valid IRQ. Set it to -EINVAL
>> in error path of am65_cpsw_nuss_init_rx_chns() so we do not try
>> to free an unallocated IRQ in am65_cpsw_nuss_remove_rx_chns().
>>
>> If user tried to change number of RX queues and am65_cpsw_nuss_init_rx_chns()
>> failed due to any reason, the warning will happen if user tries to change
>> the number of RX queues after the error condition.
>>
>> root@am62xx-evm:~# ethtool -L eth0 rx 3
>> [   40.385293] am65-cpsw-nuss 8000000.ethernet: set new flow-id-base 19
>> [   40.393211] am65-cpsw-nuss 8000000.ethernet: Failed to init rx flow2
>> netlink error: Invalid argument
>> root@am62xx-evm:~# ethtool -L eth0 rx 2
>> [   82.306427] ------------[ cut here ]------------yes.
>> [   82.311075] WARNING: CPU: 0 PID: 378 at kernel/irq/devres.c:144 devm_free_irq+0x84/0x90
>> [   82.469770] Call trace:
>> [   82.472208]  devm_free_irq+0x84/0x90
>> [   82.475777]  am65_cpsw_nuss_remove_rx_chns+0x6c/0xac [ti_am65_cpsw_nuss]
>> [   82.482487]  am65_cpsw_nuss_update_tx_rx_chns+0x2c/0x9c [ti_am65_cpsw_nuss]
>> [   82.489442]  am65_cpsw_set_channels+0x30/0x4c [ti_am65_cpsw_nuss]
>> [   82.495531]  ethnl_set_channels+0x224/0x2dc
>> [   82.499713]  ethnl_default_set_doit+0xb8/0x1b8
>> [   82.504149]  genl_family_rcv_msg_doit+0xc0/0x124
>> [   82.508757]  genl_rcv_msg+0x1f0/0x284
>> [   82.512409]  netlink_rcv_skb+0x58/0x130
>> [   82.516239]  genl_rcv+0x38/0x50
>> [   82.519374]  netlink_unicast+0x1d0/0x2b0
>> [   82.523289]  netlink_sendmsg+0x180/0x3c4
>> [   82.527205]  __sys_sendto+0xe4/0x158
>> [   82.530779]  __arm64_sys_sendto+0x28/0x38
>> [   82.534782]  invoke_syscall+0x44/0x100
>> [   82.538526]  el0_svc_common.constprop.0+0xc0/0xe0
>> [   82.543221]  do_el0_svc+0x1c/0x28
>> [   82.546528]  el0_svc+0x28/0x98
>> [   82.549578]  el0t_64_sync_handler+0xc0/0xc4
>> [   82.553752]  el0t_64_sync+0x190/0x194
>> [   82.557407] ---[ end trace 0000000000000000 ]---
>>
>> Fixes: da70d184a8c3 ("net: ethernet: ti: am65-cpsw: Introduce multi queue Rx")
> 
> Hi Roger,
> 
> I wonder if the problem predates the cited commit and was, rather,
> introduced by:
> 
> Fixes: 24bc19b05f1f ("net: ethernet: ti: am65-cpsw: Add suspend/resume support")

Partly yes. But at that commit AM65_CPSW_MAX_RX_FLOWS is 1 so there is no
opportunity for user to change the number of RX queues.

-- 
cheers,
-roger


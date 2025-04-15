Return-Path: <bpf+bounces-55968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4C5A8A42D
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 18:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C50F189C4D6
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 16:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC2F1DF963;
	Tue, 15 Apr 2025 16:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFN3xWrF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3D7946F;
	Tue, 15 Apr 2025 16:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744734644; cv=none; b=vFSXtwcBb+Z+hK38zlonMdOOIaeSYLAYtT85BXcRWzz2NAv7y4zspH1Q/7jY4ji8Dp2QBMOAdfXTh80cDYmhhSIcxV0ErImcAoMpjq57oem5/BvPjI7HQYr1v6iPCmNB/f7s7Rl6A9UNHtDtYvR8guqS1/mC86Q9vH7zWl8UTDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744734644; c=relaxed/simple;
	bh=weFLulQd64Nt8wSZqx8JH29VMOiyErt5HVf/jr1Jwis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y7bo50L0am4sZipl/gX9cnjzc1pASFsHoax7UKErX41NkMfi5vco83xuvG37WdfJvHbl4NmP9qdgBo5bCT7E4iOsiaTk1gIcjzSv6dRrz5TPoHzJpFZvWPzEs482qNmfE+Y4eOeLptire1hi01toJYm0qJzDrroWdS9Svlrj9Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFN3xWrF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39342C4CEEB;
	Tue, 15 Apr 2025 16:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744734643;
	bh=weFLulQd64Nt8wSZqx8JH29VMOiyErt5HVf/jr1Jwis=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JFN3xWrFVTdxpPrfi7cXgOlUtYWAdqvI481ubvKvsdOizS7JomWgFGpl2+12Oshwn
	 5h598+LtreCcO9iIK3DuomULfVKJu0mQzjtedtTcL+n+gD9tduCC/YjA/zA1VTTKFV
	 tI8rsh1xksUtIABS4AhaDhzy1+WX5RscTdXqLPQNlAW5ycK2ImdSP4qrHDhu1GaFzI
	 IAtCM+ZodyWa7+A4/qgSrvSov6DXtZ4vyxjByIBZC+rHO5JAOHSZDHh6e4Fe2AecW1
	 fxCINsp6qCnQzts3iPpoMzLv9r93UHArtxtXFRp+qB/qdny1l8msQu79Z9A65kZa6A
	 0k3WKQ3N0p/FQ==
Message-ID: <a9af244c-37c5-460a-9128-c020173c591d@kernel.org>
Date: Tue, 15 Apr 2025 18:30:38 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V4 1/2] net: sched: generalize check for no-queue
 qdisc on TX queue
To: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, tom@herbertland.com,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 makita.toshiaki@lab.ntt.co.jp, kernel-team@cloudflare.com, phil@nwl.cc
References: <174472463778.274639.12670590457453196991.stgit@firesoul>
 <174472469906.274639.14909448343817900822.stgit@firesoul>
 <f448fcb8-6330-4517-863f-4bf0a2242313@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <f448fcb8-6330-4517-863f-4bf0a2242313@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/04/2025 17.43, David Ahern wrote:
> On 4/15/25 7:44 AM, Jesper Dangaard Brouer wrote:
>> The "noqueue" qdisc can either be directly attached, or get default
>> attached if net_device priv_flags has IFF_NO_QUEUE. In both cases, the
>> allocated Qdisc structure gets it's enqueue function pointer reset to
>> NULL by noqueue_init() via noqueue_qdisc_ops.
>>
>> This is a common case for software virtual net_devices. For these devices
>> with no-queue, the transmission path in __dev_queue_xmit() will bypass
>> the qdisc layer. Directly invoking device drivers ndo_start_xmit (via
>> dev_hard_start_xmit).  In this mode the device driver is not allowed to
>> ask for packets to be queued (either via returning NETDEV_TX_BUSY or
>> stopping the TXQ).
>>
>> The simplest and most reliable way to identify this no-queue case is by
>> checking if enqueue == NULL.
>>
>> The vrf driver currently open-codes this check (!qdisc->enqueue). While
>> functionally correct, this low-level detail is better encapsulated in a
>> dedicated helper for clarity and long-term maintainability.
>>
>> To make this behavior more explicit and reusable, this patch introduce a
>> new helper: qdisc_txq_has_no_queue(). Helper will also be used by the
>> veth driver in the next patch, which introduces optional qdisc-based
>> backpressure.
>>
>> This is a non-functional change.
>>
>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
>> ---
>>   drivers/net/vrf.c         |    4 +---
>>   include/net/sch_generic.h |    8 ++++++++
>>   2 files changed, 9 insertions(+), 3 deletions(-)
>>
> 
> 
>>   /* Local traffic destined to local address. Reinsert the packet to rx
>> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
>> index d48c657191cd..b6c177f7141c 100644
>> --- a/include/net/sch_generic.h
>> +++ b/include/net/sch_generic.h
>> @@ -803,6 +803,14 @@ static inline bool qdisc_tx_changing(const struct net_device *dev)
>>   	return false;
>>   }
>>   
>> +/* "noqueue" qdisc identified by not having any enqueue, see noqueue_init() */
>> +static inline bool qdisc_txq_has_no_queue(const struct netdev_queue *txq)
>> +{
>> +	struct Qdisc *qdisc = rcu_access_pointer(txq->qdisc);
>> +
>> +	return qdisc->enqueue == NULL;
> 
> Did checkpatch not complain that this should be '!qdisc->enqueue' ?
> 

Nope:

./scripts/checkpatch.pl 
patches-veth_pushback_to_qdisc03/01-0001-net-sched-generalize-noop.patch
total: 0 errors, 0 warnings, 30 lines checked

patches-veth_pushback_to_qdisc03/01-0001-net-sched-generalize-noop.patch 
has no obvious style problems and is ready for submission.

> 
> Reviewed-by: David Ahern <dsahern@kernel.org>

Thx for review :-)

--Jesper



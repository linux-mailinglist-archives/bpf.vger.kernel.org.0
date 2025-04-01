Return-Path: <bpf+bounces-55024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AB3A772C7
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 04:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60791188DDE1
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 02:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA59F1A704B;
	Tue,  1 Apr 2025 02:35:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940D81519B9;
	Tue,  1 Apr 2025 02:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743474953; cv=none; b=VfSZLdMIbiLeRUIeJP32zwOW2eGJ1Zx9WEiw1COBP5F7dql/AWVpmaxW84JDik6FZ41jYkXqnCmNbygSeugjbAUDL5Xw1VJLCEQT5df3FCn0futh5WykvCDGTVrlwSp7d3hdzqPr/fe1b84YYCh3jTbaPyLpee8PhnW+thnNc6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743474953; c=relaxed/simple;
	bh=HGc9dhFhuKzkHVwyXlWb3E5x5TBalZYItz7+9JKWtVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XWuhOUMUa/n/JL2lQb+UgnvDe/+XlUdgDTzZPFjHC9CEFnG7+PN/SCyP5oTM/61+gtKVWqFuf++gzcnagC7QT+d7hhMtdttPSX2skFqiZQBTs/G/qX06kQ+loylL95Wu86BqE4h9pxvowB3OBXF6AdcnIuNAsq/54MlBBp87KWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZRX8X0K1HzHrJ2;
	Tue,  1 Apr 2025 10:32:28 +0800 (CST)
Received: from kwepemg200005.china.huawei.com (unknown [7.202.181.32])
	by mail.maildlp.com (Postfix) with ESMTPS id BB5BB140154;
	Tue,  1 Apr 2025 10:35:47 +0800 (CST)
Received: from [10.174.176.70] (10.174.176.70) by
 kwepemg200005.china.huawei.com (7.202.181.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 1 Apr 2025 10:35:46 +0800
Message-ID: <0d1b689c-c0ef-460a-9969-ff5aebbb8fac@huawei.com>
Date: Tue, 1 Apr 2025 10:35:45 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] xsk: correct tx_ring_empty_descs count statistics
To: Stanislav Fomichev <stfomichev@gmail.com>
CC: <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<maciej.fijalkowski@intel.com>, <jonathan.lemon@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250329061548.1357925-1-wangliang74@huawei.com>
 <Z-qzLyGKskaqgFh5@mini-arch> <Z-sRF0G43HpGiGwH@mini-arch>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <Z-sRF0G43HpGiGwH@mini-arch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg200005.china.huawei.com (7.202.181.32)


在 2025/4/1 6:03, Stanislav Fomichev 写道:
> On 03/31, Stanislav Fomichev wrote:
>> On 03/29, Wang Liang wrote:
>>> The tx_ring_empty_descs count may be incorrect, when set the XDP_TX_RING
>>> option but do not reserve tx ring. Because xsk_poll() try to wakeup the
>>> driver by calling xsk_generic_xmit() for non-zero-copy mode. So the
>>> tx_ring_empty_descs count increases once the xsk_poll()is called:
>>>
>>>    xsk_poll
>>>      xsk_generic_xmit
>>>        __xsk_generic_xmit
>>>          xskq_cons_peek_desc
>>>            xskq_cons_read_desc
>>>              q->queue_empty_descs++;
>>>
>>> To avoid this count error, add check for tx descs before send msg in poll.
>>>
>>> Fixes: df551058f7a3 ("xsk: Fix crash in poll when device does not support ndo_xsk_wakeup")
>>> Signed-off-by: Wang Liang <wangliang74@huawei.com>
>> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> Hmm, wait, I stumbled upon xskq_has_descs again and it looks only at
> cached prod/cons. How is it supposed to work when the actual tx
> descriptor is posted? Is there anything besides xskq_cons_peek_desc from
> __xsk_generic_xmit that refreshes cached_prod?


Yes, you are right!

How about using xskq_cons_nb_entries() to check free descriptors?

Like this:


diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index e5d104ce7b82..babb7928d335 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -993,7 +993,7 @@ static __poll_t xsk_poll(struct file *file, struct 
socket *sock,
         if (pool->cached_need_wakeup) {
                 if (xs->zc)
                         xsk_wakeup(xs, pool->cached_need_wakeup);
-               else if (xs->tx)
+               else if (xs->tx && xskq_cons_nb_entries(xs->tx, 1))
                         /* Poll needs to drive Tx also in copy mode */
                         xsk_generic_xmit(sk);
         }



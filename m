Return-Path: <bpf+bounces-55044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F07A77578
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 09:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D625169B6A
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 07:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1914A1E9B3F;
	Tue,  1 Apr 2025 07:44:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD011E98F9;
	Tue,  1 Apr 2025 07:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743493442; cv=none; b=UUoy43ALCEGkKRm5XrXtF9H8PKlo6WW4JqNosf688K70T9Wuwu3ix8ftThyLrW/du3RPM3uH1WqV7L5APC6LvMwrEII4N082YsXT2Fu/za2pIu85MNfCSe+6gfI3LaigvHaw3ag0Zjv6G0Mot+V6qEbVy1wf4URCrarXkzvO7O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743493442; c=relaxed/simple;
	bh=THngXZIhQioKCrZCm1xvnaDv2uQrZPu+UxuNcjKLAD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X93YDxZREl349oXhhA+pipBoK0Jft49fcj/aalNGax2+ZH6DAtqLFtaHvLcExRsq+LIaqA+cMKTLV3Zbaf7FbV76+R8M+krGCVGOHfySn+HS+4yubHbO00XZgHaQprBztbr0F5A3UiRAPTfmu50FDtHxawuiOirEZQOTUBXszpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZRg050xggzHrJW;
	Tue,  1 Apr 2025 15:40:37 +0800 (CST)
Received: from kwepemg200005.china.huawei.com (unknown [7.202.181.32])
	by mail.maildlp.com (Postfix) with ESMTPS id EE786180080;
	Tue,  1 Apr 2025 15:43:56 +0800 (CST)
Received: from [10.174.176.70] (10.174.176.70) by
 kwepemg200005.china.huawei.com (7.202.181.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 1 Apr 2025 15:43:55 +0800
Message-ID: <ed10eea2-0bf2-4747-b519-f9b9089e434e@huawei.com>
Date: Tue, 1 Apr 2025 15:43:54 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] xsk: correct tx_ring_empty_descs count statistics
To: Magnus Karlsson <magnus.karlsson@gmail.com>
CC: Stanislav Fomichev <stfomichev@gmail.com>, <bjorn@kernel.org>,
	<magnus.karlsson@intel.com>, <maciej.fijalkowski@intel.com>,
	<jonathan.lemon@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250329061548.1357925-1-wangliang74@huawei.com>
 <Z-qzLyGKskaqgFh5@mini-arch> <Z-sRF0G43HpGiGwH@mini-arch>
 <0d1b689c-c0ef-460a-9969-ff5aebbb8fac@huawei.com>
 <CAJ8uoz1JxhXFkzW8n_Dud8SR-4zE7gim5vS_UZHELiA7d0k+wQ@mail.gmail.com>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <CAJ8uoz1JxhXFkzW8n_Dud8SR-4zE7gim5vS_UZHELiA7d0k+wQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg200005.china.huawei.com (7.202.181.32)


在 2025/4/1 14:57, Magnus Karlsson 写道:
> On Tue, 1 Apr 2025 at 04:36, Wang Liang <wangliang74@huawei.com> wrote:
>>
>> 在 2025/4/1 6:03, Stanislav Fomichev 写道:
>>> On 03/31, Stanislav Fomichev wrote:
>>>> On 03/29, Wang Liang wrote:
>>>>> The tx_ring_empty_descs count may be incorrect, when set the XDP_TX_RING
>>>>> option but do not reserve tx ring. Because xsk_poll() try to wakeup the
>>>>> driver by calling xsk_generic_xmit() for non-zero-copy mode. So the
>>>>> tx_ring_empty_descs count increases once the xsk_poll()is called:
>>>>>
>>>>>     xsk_poll
>>>>>       xsk_generic_xmit
>>>>>         __xsk_generic_xmit
>>>>>           xskq_cons_peek_desc
>>>>>             xskq_cons_read_desc
>>>>>               q->queue_empty_descs++;
> Sorry, but I do not understand how to reproduce this error. So you
> first issue a setsockopt with the XDP_TX_RING option and then you do
> not "reserve tx ring". What does that last "not reserve tx ring" mean?
> No mmap() of that ring, or something else? I guess you have bound the
> socket with a bind()? Some pseudo code on how to reproduce this would
> be helpful. Just want to understand so I can help. Thank you.
Sorry, the last email is garbled, and send again.

Ok. Some pseudo code like below:

     fd = socket(AF_XDP, SOCK_RAW, 0);
     setsockopt(fd, SOL_XDP, XDP_UMEM_REG, &mr, sizeof(mr));

     setsockopt(fd, SOL_XDP, XDP_UMEM_FILL_RING, &fill_size, 
sizeof(fill_size));
     setsockopt(fd, SOL_XDP, XDP_UMEM_COMPLETION_RING, &comp_size, 
sizeof(comp_size));
     mmap(NULL, off.fr.desc + fill_size * sizeof(__u64), ..., 
XDP_UMEM_PGOFF_FILL_RING);
     mmap(NULL, off.cr.desc + comp_size * sizeof(__u64), ..., 
XDP_UMEM_PGOFF_COMPLETION_RING);

     setsockopt(fd, SOL_XDP, XDP_RX_RING, &rx_size, sizeof(rx_size));
     setsockopt(fd, SOL_XDP, XDP_TX_RING, &tx_size, sizeof(tx_size));
     mmap(NULL, off.rx.desc + rx_size * sizeof(struct xdp_desc), ..., 
XDP_PGOFF_RX_RING);
     mmap(NULL, off.tx.desc + tx_size * sizeof(struct xdp_desc), ..., 
XDP_PGOFF_TX_RING);

     bind(fd, (struct sockaddr *)&sxdp, sizeof(sxdp));
     bpf_map_update_elem(xsk_map_fd, &queue_id, &fd, 0);

     while(!global_exit) {
         poll(fds, 1, -1);
         handle_receive_packets(...);
     }

The xsk is created success, and xs->tx is initialized.

The "not reserve tx ring" means user app do not update tx ring producer.
Like:

     xsk_ring_prod__reserve(tx, 1, &tx_idx);
     xsk_ring_prod__tx_desc(tx, tx_idx)->addr = frame;
     xsk_ring_prod__tx_desc(tx, tx_idx)->len = pkg_length;
     xsk_ring_prod__submit(tx, 1);

These functions (xsk_ring_prod__reserve, etc.) is provided by libxdp.

The tx->producer is not updated, so the xs->tx->cached_cons and
xs->tx->cached_prod are always zero.

When receive packets and user app call poll(), xsk_generic_xmit() will be
triggered by xsk_poll(), leading to this issue.
>>>>> To avoid this count error, add check for tx descs before send msg in poll.
>>>>>
>>>>> Fixes: df551058f7a3 ("xsk: Fix crash in poll when device does not support ndo_xsk_wakeup")
>>>>> Signed-off-by: Wang Liang <wangliang74@huawei.com>
>>>> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
>>> Hmm, wait, I stumbled upon xskq_has_descs again and it looks only at
>>> cached prod/cons. How is it supposed to work when the actual tx
>>> descriptor is posted? Is there anything besides xskq_cons_peek_desc from
>>> __xsk_generic_xmit that refreshes cached_prod?
>>
>> Yes, you are right!
>>
>> How about using xskq_cons_nb_entries() to check free descriptors?
>>
>> Like this:
>>
>>
>> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
>> index e5d104ce7b82..babb7928d335 100644
>> --- a/net/xdp/xsk.c
>> +++ b/net/xdp/xsk.c
>> @@ -993,7 +993,7 @@ static __poll_t xsk_poll(struct file *file, struct
>> socket *sock,
>>           if (pool->cached_need_wakeup) {
>>                   if (xs->zc)
>>                           xsk_wakeup(xs, pool->cached_need_wakeup);
>> -               else if (xs->tx)
>> +               else if (xs->tx && xskq_cons_nb_entries(xs->tx, 1))
>>                           /* Poll needs to drive Tx also in copy mode */
>>                           xsk_generic_xmit(sk);
>>           }
>>
>>


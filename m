Return-Path: <bpf+bounces-52478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47999A43293
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 02:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84E7E189C64C
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 01:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79CB7081B;
	Tue, 25 Feb 2025 01:45:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CF0FC1D;
	Tue, 25 Feb 2025 01:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740447932; cv=none; b=ZeFnJXXOywbFZAVgbTp51v18e5eK4n8LfjuIHrc+t7DdqzTjeSqon7gJ+NmFKI7fSefb/RqqCP6kdAHPERwk829cQwxfSd6f4yW20GO93Buu0ghwMKgzr8XDnItzhdjhLaNHSmQoVsaVW3tQdVTqZKnMQcuZhvO6dw5xaARsSTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740447932; c=relaxed/simple;
	bh=2+6V7qQVaa6iDdECCvN7iEz0i0TmM7x99EjDo6Sdr7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fYX2S9cy9EJ7PgrmBxYzCRVJr/tSIsxvs35GUlb6CFJZWegeTIjioSYFZO3B1JAV9H2o6lKQbpMUZ/SH6QBV10U/7FBpxwlGPq4wwkDmJ7rWKqgR8SalbaJEVoUKPuukSPmRd7Gd2vPbQ1D6aAmW7ulDsCoYMmtlJmbTdzJpZpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Z20fz3Lz5zdb7N;
	Tue, 25 Feb 2025 09:40:43 +0800 (CST)
Received: from kwepemg200005.china.huawei.com (unknown [7.202.181.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 137501402C3;
	Tue, 25 Feb 2025 09:45:27 +0800 (CST)
Received: from [10.174.176.70] (10.174.176.70) by
 kwepemg200005.china.huawei.com (7.202.181.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 25 Feb 2025 09:45:25 +0800
Message-ID: <df5b1deb-7d72-4f52-86c2-959ea4dffad4@huawei.com>
Date: Tue, 25 Feb 2025 09:45:12 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] xsk: fix __xsk_generic_xmit() error code when cq is
 full
To: Magnus Karlsson <magnus.karlsson@gmail.com>, Stanislav Fomichev
	<stfomichev@gmail.com>
CC: <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<maciej.fijalkowski@intel.com>, <jonathan.lemon@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250222093007.3607691-1-wangliang74@huawei.com>
 <CAJ8uoz1fZ3zYVKergPn-QYRQEpPfC_jNgtY3wzoxxJWFF22LKA@mail.gmail.com>
 <Z7yXhHezJTgYh76T@mini-arch>
 <CAJ8uoz12bmCPsr_LFwCDypiwzmH+U7TeLqqykgRhp=8vKX4nQw@mail.gmail.com>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <CAJ8uoz12bmCPsr_LFwCDypiwzmH+U7TeLqqykgRhp=8vKX4nQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg200005.china.huawei.com (7.202.181.32)


在 2025/2/25 1:14, Magnus Karlsson 写道:
> On Mon, 24 Feb 2025 at 17:00, Stanislav Fomichev <stfomichev@gmail.com> wrote:
>> On 02/24, Magnus Karlsson wrote:
>>> On Sat, 22 Feb 2025 at 10:18, Wang Liang <wangliang74@huawei.com> wrote:
>>>> When the cq reservation is failed, the error code is not set which is
>>>> initialized to zero in __xsk_generic_xmit(). That means the packet is not
>>>> send successfully but sendto() return ok.
>>>>
>>>> Set the error code and make xskq_prod_reserve_addr()/xskq_prod_reserve()
>>>> return values more meaningful when the queue is full.
>>> Hi Wang,
>>>
>>> I agree that this would have been a really good idea if it was
>>> implemented from day one, but now I do not dare to change this since
>>> it would be changing the uapi. Let us say you have the following quite
>>> common code snippet for sending a packet with AF_XDP in skb mode:
>>>
>>> err = sendmsg();
>>> if (err && err != -EAGAIN && err != -EBUSY)
>>>      goto die_due_to_error;
>>> continue with code
>>>
>>> This code would with your change go and die suddenly when the
>>> completion ring is full instead of working. Maybe there is a piece of
>>> code that cleans the completion ring after these lines of code and
>>> next time sendmsg() is called, the packet will get sent, so the
>>> application used to work.
>>>
>>> So I say: let us not do this. But if anyone has another opinion, please share.
>> Can we return -EBUSY from this 'if (xsk_cq_reserve_addr_locked())' case as
>> well?
> That is a good idea! Though I would return -EAGAIN. When -EBUSY is
> returned, the buffer was consumed but not sent. But -EAGAIN means that
> the user just has to perform then sendmsg() again and that is exactly
> what the user has to do here too.


Thank you for the suggestion!
Changing the uapi is indeed a high-risk act. Return -EAGAIN is a much 
better choice.
The cq is full usually because it is not released in time, try to send 
msg again is appropriate.
I will send a new patch later, and look forward to getting more advice. 
Thanks.




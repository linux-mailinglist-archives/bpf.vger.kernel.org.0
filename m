Return-Path: <bpf+bounces-76535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BB1CB903F
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 15:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DCCF305E21F
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 14:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD9A30F811;
	Fri, 12 Dec 2025 14:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asBwIPhk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B532275B03
	for <bpf@vger.kernel.org>; Fri, 12 Dec 2025 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765551326; cv=none; b=dphDEjJ1oCJ/LscwK7IuEkxCGd8YBU5IBqwqQOqpiJiJev1j70blhOy05qB15szNpH3zJgLaI4gA777EbK7dCNTFyC7e0gMv08vjZSEFwNlE6LXAxor2putGrqkX9ZSOMrSWOBVscGj66VMwA/PH2VgGFP+mGSZZmZjgsUKQfbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765551326; c=relaxed/simple;
	bh=BuBsP/S9exo7ef25H/bTv1jkoOJ5+yaoF96W6Iu+7mQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ff0YIaNNjQLw8CnzZ0e/FPbxRDJQnuN/1ieBvqq0LGyYIsTv19/Bgrljt4Np+0p5WBpRnepk0WFmrPvYT58CtgAR/Ms5EqD/0xZtvTk+WEoVO6p5UoWQlyQJ08SMqnrKF867hU8j2zi5jHxx5a+iJfwKIbjUH8ZnjPeVGYscObU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asBwIPhk; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7b7828bf7bcso1391521b3a.2
        for <bpf@vger.kernel.org>; Fri, 12 Dec 2025 06:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765551324; x=1766156124; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CvSMLYRCI7FGGrv1VvEOWRLqxkT2P6HKocSPJ7Ce8do=;
        b=asBwIPhkEJAT1E0W87FlVOEmT2euLyX6TsB/zSUzvtkaFaJOpviLqB6yhcgQHhsxLR
         PDhBaO3pIrDujM6LqG0hH/yS1VIrVYyG3jf8PIrSeMCFPECPC8hwg3wM2Axm8Kz1jkE6
         BcYRDFiiFXw/aLKVCFfgSfFZozHPQVU3QVVT0uGR2bz/UXjy7d9LSN+9b0o9YUTIibP0
         zIb0dubwTT59ZramlbemlmmQuN4OvfAGeCPGKoA/XoteQIteOgjfYSb3J+LY8xMqnY6X
         yheOitodI48JiMyMASuM3V7UzbWvwUeZcjHQ/mcGFJm7vbn6c1jaqFgwdpIVFb5B+XFy
         AYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765551324; x=1766156124;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CvSMLYRCI7FGGrv1VvEOWRLqxkT2P6HKocSPJ7Ce8do=;
        b=nSEs0nWk6AgFypZqdm3cRY4JK0oaJKcj8SRBoPfGROgxrrvQD+AgxFWVdHtyxOHuut
         hpt37xEzw5wHsEEKvyPi1PI/+vfFVq9gktjSUJGB+hqivlEs1CttdYLhUUSm3BhrxK+X
         1j1vGyrADkyNBVe5Tom5rw2zpgxC/b9W2Lzrr0e659vco4Sf6VAI1+TJz6YHCxweFp/g
         U9aAWwdAvHzGP2E6DB/zC8CyCnDVNh0ORm1j8Xb8mwmxCF8h3pQvo0bV+4LZQerOkdtx
         JNSBt+4DDV012VcwnJBK/ruBgJCP1UNCVYv9fEgMMu30AnXsK/z8L8sKTmb5KyBlCnl7
         zTuw==
X-Forwarded-Encrypted: i=1; AJvYcCWhM9UkJvS9GnFS35zldDSEGXEqOBrgkJ0UFGTz8ukBTQ+TMHQMIJj/iz8tWQcfpECTYfM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb3qAm0F3S1wlE0wmvmV+H7DECEeOoz93C+ctSDTBLJlkPeBvz
	OZWJdTJUzJy3zdWMBg14l8eFZP/ePG1Te3qZw5YJDw8//VYSPJa6e/jx
X-Gm-Gg: AY/fxX4RXxEWQXGtzBo7c1jdmJRRf7/6U6dr7REvAU+338dlxmZ7cAryRd8l+TekrTA
	ArklpNTTbPK+70JXxXKorE7oMg8Pyn1AgQzaq5BmZ28IiH6K1z5/DWPhQihgUVFV/iqKnCLNvN7
	o1KnF5Gb1y3RUJgB9/M4zA8aLG4hnE8uXSSBZdd/6Pw756Bd1C73K+hsDwvJIcB96L4h0GvGzZP
	tuTSLtTaD9Dq3eBhL1Gzwug/TnxYvvWvuQ1TbR1ijCa7xGCd9Jo6VVx/vWN59E5djhsxcdkWkd7
	mENrPV+6nxZDp9H/c2puSKthMORAS/HrQu3rcFaR7oc+rPjd/KaScOMQP/kpqIS9bwkvsBr2z1p
	6CfUfpiJO6Y4YcUv9jBb7UY9gJF0gA7+HejuDBpfrFO89uu6NkBBacWlF6QZX5CLNfcOxJPEAjU
	yMI8GtUt298yM8rSFBG57kFgO3qENHBGTm/PBkQjkCOfTmYriLD9cmChBgiVkRGQ==
X-Google-Smtp-Source: AGHT+IEnEfbhmuFJejhSrHRsP2vFcnIf4LTdOfYMGBlR2nivB9zvqThLbwABOMFmHR2efdEvzh2BbQ==
X-Received: by 2002:a05:6a00:600a:b0:7b8:8d43:fcd1 with SMTP id d2e1a72fcca58-7f6674462fdmr2118708b3a.9.1765551323631;
        Fri, 12 Dec 2025 06:55:23 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f4c:210:5402:1cf7:eb53:9399? ([2001:ee0:4f4c:210:5402:1cf7:eb53:9399])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c54815cdsm5555931b3a.61.2025.12.12.06.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Dec 2025 06:55:23 -0800 (PST)
Message-ID: <207b7274-83f6-41d4-8446-ddb1ecd0a25a@gmail.com>
Date: Fri, 12 Dec 2025 21:55:16 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio-net: enable all napis before scheduling refill
 work
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20251208153419.18196-1-minhquangbui99@gmail.com>
 <CACGkMEvtKVeoTMrGG0gZOrNKY=m-DGChVcM0TYcqx6-Ap+FY8w@mail.gmail.com>
 <66d9f44c-295e-4b62-86ae-a0aff5f062bb@gmail.com>
 <CACGkMEuF0rNYcSSUCdAgsW2Xfen9NGZHNxXpkO2Mt0a4zQJDqQ@mail.gmail.com>
 <c83c386e-96a6-4f9f-8047-23ce866ed320@gmail.com>
 <CACGkMEv7XpKsfN3soR9GijY-DLqwuOdYp+48ye5jweNpho8vow@mail.gmail.com>
 <6281cd92-10aa-4182-a456-81538cff822a@gmail.com>
 <CACGkMEvt2Fc274kysuPx4865RzBgu=TMNr1TwMQjRNeDp7D8VA@mail.gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CACGkMEvt2Fc274kysuPx4865RzBgu=TMNr1TwMQjRNeDp7D8VA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/12/25 13:48, Jason Wang wrote:
> On Thu, Dec 11, 2025 at 11:04 PM Bui Quang Minh
> <minhquangbui99@gmail.com> wrote:
>> On 12/11/25 14:27, Jason Wang wrote:
>>> On Wed, Dec 10, 2025 at 11:33 PM Bui Quang Minh
>>> <minhquangbui99@gmail.com> wrote:
>>>> On 12/10/25 12:45, Jason Wang wrote:
>>>>> On Tue, Dec 9, 2025 at 11:23 PM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>>>>>> On 12/9/25 11:30, Jason Wang wrote:
>>>>>>> On Mon, Dec 8, 2025 at 11:35 PM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>>>>>>>> Calling napi_disable() on an already disabled napi can cause the
>>>>>>>> deadlock. In commit 4bc12818b363 ("virtio-net: disable delayed refill
>>>>>>>> when pausing rx"), to avoid the deadlock, when pausing the RX in
>>>>>>>> virtnet_rx_pause[_all](), we disable and cancel the delayed refill work.
>>>>>>>> However, in the virtnet_rx_resume_all(), we enable the delayed refill
>>>>>>>> work too early before enabling all the receive queue napis.
>>>>>>>>
>>>>>>>> The deadlock can be reproduced by running
>>>>>>>> selftests/drivers/net/hw/xsk_reconfig.py with multiqueue virtio-net
>>>>>>>> device and inserting a cond_resched() inside the for loop in
>>>>>>>> virtnet_rx_resume_all() to increase the success rate. Because the worker
>>>>>>>> processing the delayed refilled work runs on the same CPU as
>>>>>>>> virtnet_rx_resume_all(), a reschedule is needed to cause the deadlock.
>>>>>>>> In real scenario, the contention on netdev_lock can cause the
>>>>>>>> reschedule.
>>>>>>>>
>>>>>>>> This fixes the deadlock by ensuring all receive queue's napis are
>>>>>>>> enabled before we enable the delayed refill work in
>>>>>>>> virtnet_rx_resume_all() and virtnet_open().
>>>>>>>>
>>>>>>>> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
>>>>>>>> Reported-by: Paolo Abeni <pabeni@redhat.com>
>>>>>>>> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
>>>>>>>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>>>>>>>> ---
>>>>>>>>      drivers/net/virtio_net.c | 59 +++++++++++++++++++---------------------
>>>>>>>>      1 file changed, 28 insertions(+), 31 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>>>>>> index 8e04adb57f52..f2b1ea65767d 100644
>>>>>>>> --- a/drivers/net/virtio_net.c
>>>>>>>> +++ b/drivers/net/virtio_net.c
>>>>>>>> @@ -2858,6 +2858,20 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
>>>>>>>>             return err != -ENOMEM;
>>>>>>>>      }
>>>>>>>>
>>>>>>>> +static void virtnet_rx_refill_all(struct virtnet_info *vi)
>>>>>>>> +{
>>>>>>>> +       bool schedule_refill = false;
>>>>>>>> +       int i;
>>>>>>>> +
>>>>>>>> +       enable_delayed_refill(vi);
>>>>>>> This seems to be still racy?
>>>>>>>
>>>>>>> For example, in virtnet_open() we had:
>>>>>>>
>>>>>>> static int virtnet_open(struct net_device *dev)
>>>>>>> {
>>>>>>>             struct virtnet_info *vi = netdev_priv(dev);
>>>>>>>             int i, err;
>>>>>>>
>>>>>>>             for (i = 0; i < vi->max_queue_pairs; i++) {
>>>>>>>                     err = virtnet_enable_queue_pair(vi, i);
>>>>>>>                     if (err < 0)
>>>>>>>                             goto err_enable_qp;
>>>>>>>             }
>>>>>>>
>>>>>>>             virtnet_rx_refill_all(vi);
>>>>>>>
>>>>>>> So NAPI and refill work is enabled in this case, so the refill work
>>>>>>> could be scheduled and run at the same time?
>>>>>> Yes, that's what we expect. We must ensure that refill work is scheduled
>>>>>> only when all NAPIs are enabled. The deadlock happens when refill work
>>>>>> is scheduled but there are still disabled RX NAPIs.
>>>>> Just to make sure we are on the same page, I meant, after refill work
>>>>> is enabled, rq0 is NAPI is enabled, in this case the refill work could
>>>>> be triggered by the rq0's NAPI so we may end up in the refill work
>>>>> that it tries to disable rq1's NAPI while holding the netdev lock.
>>>> I don't quite get your point. The current deadlock scenario is this
>>>>
>>>> virtnet_rx_resume_all
>>>> napi_enable(rq0) (the rq1 napi is still disabled)
>>>> enable_refill_work
>>>>
>>>> refill_work
>>>> napi_disable(rq0) -> still okay
>>>> napi_enable(rq0) -> still okay
>>>> napi_disable(rq1)
>>>> -> hold netdev_lock
>>>>        -> stuck inside the while loop in napi_disable_locked
>>>>                while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
>>>>                    usleep_range(20, 200);
>>>>                    val = READ_ONCE(n->state);
>>>>                }
>>>>
>>>>
>>>> napi_enable(rq1)
>>>> -> stuck while trying to acquire the netdev_lock
>>>>
>>>> The problem is that we must not call napi_disable() on an already
>>>> disabled NAPI (rq1's NAPI in the example).
>>>>
>>>> In the new virtnet_open
>>>>
>>>> static int virtnet_open(struct net_device *dev)
>>>> {
>>>>             struct virtnet_info *vi = netdev_priv(dev);
>>>>             int i, err;
>>>>
>>>>             // Note that at this point, refill work is still disabled, vi->refill_enabled == false,
>>>>             // so even if virtnet_receive is called, the refill_work will not be scheduled.
>>>>             for (i = 0; i < vi->max_queue_pairs; i++) {
>>>>                     err = virtnet_enable_queue_pair(vi, i);
>>>>                     if (err < 0)
>>>>                             goto err_enable_qp;
>>>>             }
>>>>
>>>>             // Here all RX NAPIs are enabled so it's safe to enable refill work again
>>>>             virtnet_rx_refill_all(vi);
>>>>
>>> I meant this part:
>>>
>>> +static void virtnet_rx_refill_all(struct virtnet_info *vi)
>>> +{
>>> +       bool schedule_refill = false;
>>> +       int i;
>>> +
>>> +       enable_delayed_refill(vi);
>>>
>>> refill_work could run here.
>> I don't see how this can trigger the current deadlock race. However, I
>> see that this code is racy, the try_fill_recv function is not safe to
>> concurrently executed on the same receive queue. So there is a
>> requirement that we need to call try_fill_recv before enabling napi. Is
>> it what you mean?
> Exactly, I meant it's racy.

Okay, I'll fix it in the next version.

Thanks,
Quang Minh.


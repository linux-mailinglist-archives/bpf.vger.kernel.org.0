Return-Path: <bpf+bounces-76470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8C8CB6454
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 16:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D7ED30136DA
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 15:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995A32D77E9;
	Thu, 11 Dec 2025 15:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/3FbWWc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E245296BB7
	for <bpf@vger.kernel.org>; Thu, 11 Dec 2025 15:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765465475; cv=none; b=WKiLJiAhgDYS32kfTYSrjTVl2lk6uXToyRYgkmGfyFeoEW4PrbCqv1lmbekLhl+Wrn8/KCJ6ll7vqcfcltGG5vlp27vOnvkrpH2cVzmTc+YRzRk86C143sgfhme31ZF0qiRgBfb+ayCjXfLj2vZJPy5axjkldfOHcczNmGqWoHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765465475; c=relaxed/simple;
	bh=BHz3xcbiNKi6kN2GjKxGbF0MGFW5yOnSwwfsylgU5cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PrD4nKVRLMq/XgQFqBwSuPCpISwAXhuNdAQMW2uvrLg8W8aAR55MC/N5bXYAq1Qu59fBeCCR7iESV+Bv6vqHJE160y2q/ZquLJpCSYgbsXYjcQ9p9eRDgnxnfkn1TWKYz4xkOLRjasg1yreHlGoo9aWxVi0zXzd+nb95+ejMso8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/3FbWWc; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so182768b3a.0
        for <bpf@vger.kernel.org>; Thu, 11 Dec 2025 07:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765465472; x=1766070272; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QGiOaxxeedYSgO7KsDHaFkoLTRKOhWXoKaus+BgsSis=;
        b=k/3FbWWcPeZjA11G8NakVceLqCa927GzenD+CQf6b9tQV6ugl5ZvPYiRzMv1hBXrli
         +5bIsiuKmCI5UYxRdT1qL+HcokhbXQdPGrS1NbtDoYBvDUcXgjWdvSDOnGkjBrpuPAry
         pd2QczxWguowsDsmXxkUuHNO4wyPeL9FHwbYAjpsXqjhf6xRTIOb1eKjlr3rsLhJNFC2
         bLUuV3WOjvcsOBUC+BYa/eVcg+nrWxfVAHUL3byVr5U2hJ+mPfxHw7hnVvTXgx8XrH7T
         ziFPKdW+9jRTT0NMaqCTZGdUowspdEWQx9JresLirlNaZLelUwes3ahiGD+nQJgpiLjv
         NUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765465472; x=1766070272;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QGiOaxxeedYSgO7KsDHaFkoLTRKOhWXoKaus+BgsSis=;
        b=ANommK0ojSLQN0QkehmCYsydP3CIQwrcGaF4rA3NMsRBqxYKynfjuDh+4lxRTv01VG
         WRx7TGJ5zAVk34e0K6FVUoUt/7NQ6OjH8nUiSnm0KFwsVWA4TnyvYMy8Fe2C62bC3EAR
         I7Y7/e3MM4Rmv3W78erLVmIH+bDGZf7/xTcstB5+evP9HSMCmJe0pcbBw5zki9PG4HDa
         YVISwbsaw1TJt7mvSmal5+ZX0jhlIFb0KNA/5AMnxJw5Zs/EW03OKOHSc3xoImSxJD5+
         DZzVW2NmI1XJXA6x5MctoWqUNBqDZDTbayTSYx8ZErI3yd08skK6+cytajkhL/6ibfAe
         EF1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXoYUHQe421M3ihR7JjUQnA3psdC/KjXwZbPeToB3ZcgizXSLSL3kymFFsU2HSUjc6FnIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE8O+66i8xbVatQBTFfVOBKiiEg2Djh17mJMJDbsjB1j+rvSFJ
	wYBH5vAhj+zw5kQ3jgCDefzQkDgY/Z1njaj/kxQQT8wbuWSeRSGMctZp
X-Gm-Gg: AY/fxX4n0UzZtAaTXKlMpfgSicuzKy4tRgVcyhqXcKmk68Zs+HNZbQtCNSuR5b8qPIx
	IUt4dWHVK9kHY1a7iK+8runQl9r6dN4Aw5EY8penoiH5zirNXTzfTmByC3Ekew/vEtglrp9XMyf
	kjR04TS1kspT8pNP/QGnGZfDiJJD0VrQWtH7ZToxGLCrnhMZ6dMOpLw3DzyMJ83+SQF3s8qFglS
	ATiCzZO41r+49pl5wnGzrUQOHdOVA251o+4FzyJXc578vPqS8w+9MpTMQPLQ0YOF0rnbF2Yybgh
	Yqkv1Dtqbfd69XJ/UyZj0v1pHP4ZwcYn1JcShDxJ43qmcLJHO5rIsKhYuF5JV1Jfb2AbFuxkuPw
	7hO7+gprkdUYIwstFPpLlx7kLKYRTF1ZxwDVoyVytjU4YCG8PEFAItQlvmzV7CN2TSHuU6SbqQ/
	MIF7aKnHHHz3ANtx9Nje+yas2LzTOvQ3kxsq6BvTU5Bdgnp29vpzfFo1v6RvYhuw==
X-Google-Smtp-Source: AGHT+IEDIDXduddojC2oF/NtI7nTuLQKy8+7uwAI70KDBtBUQRB3kFaFndB46SIt3slBE1QS+pBD5w==
X-Received: by 2002:a05:6a20:158b:b0:352:3695:fa64 with SMTP id adf61e73a8af0-366e2450a28mr5947102637.37.1765465471013;
        Thu, 11 Dec 2025 07:04:31 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f4c:210:6f73:e1bc:9239:c004? ([2001:ee0:4f4c:210:6f73:e1bc:9239:c004])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2b8e0fb4sm2619107a12.25.2025.12.11.07.04.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Dec 2025 07:04:30 -0800 (PST)
Message-ID: <6281cd92-10aa-4182-a456-81538cff822a@gmail.com>
Date: Thu, 11 Dec 2025 22:04:23 +0700
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
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CACGkMEv7XpKsfN3soR9GijY-DLqwuOdYp+48ye5jweNpho8vow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/11/25 14:27, Jason Wang wrote:
> On Wed, Dec 10, 2025 at 11:33 PM Bui Quang Minh
> <minhquangbui99@gmail.com> wrote:
>> On 12/10/25 12:45, Jason Wang wrote:
>>> On Tue, Dec 9, 2025 at 11:23 PM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>>>> On 12/9/25 11:30, Jason Wang wrote:
>>>>> On Mon, Dec 8, 2025 at 11:35 PM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>>>>>> Calling napi_disable() on an already disabled napi can cause the
>>>>>> deadlock. In commit 4bc12818b363 ("virtio-net: disable delayed refill
>>>>>> when pausing rx"), to avoid the deadlock, when pausing the RX in
>>>>>> virtnet_rx_pause[_all](), we disable and cancel the delayed refill work.
>>>>>> However, in the virtnet_rx_resume_all(), we enable the delayed refill
>>>>>> work too early before enabling all the receive queue napis.
>>>>>>
>>>>>> The deadlock can be reproduced by running
>>>>>> selftests/drivers/net/hw/xsk_reconfig.py with multiqueue virtio-net
>>>>>> device and inserting a cond_resched() inside the for loop in
>>>>>> virtnet_rx_resume_all() to increase the success rate. Because the worker
>>>>>> processing the delayed refilled work runs on the same CPU as
>>>>>> virtnet_rx_resume_all(), a reschedule is needed to cause the deadlock.
>>>>>> In real scenario, the contention on netdev_lock can cause the
>>>>>> reschedule.
>>>>>>
>>>>>> This fixes the deadlock by ensuring all receive queue's napis are
>>>>>> enabled before we enable the delayed refill work in
>>>>>> virtnet_rx_resume_all() and virtnet_open().
>>>>>>
>>>>>> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
>>>>>> Reported-by: Paolo Abeni <pabeni@redhat.com>
>>>>>> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
>>>>>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>>>>>> ---
>>>>>>     drivers/net/virtio_net.c | 59 +++++++++++++++++++---------------------
>>>>>>     1 file changed, 28 insertions(+), 31 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>>>> index 8e04adb57f52..f2b1ea65767d 100644
>>>>>> --- a/drivers/net/virtio_net.c
>>>>>> +++ b/drivers/net/virtio_net.c
>>>>>> @@ -2858,6 +2858,20 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
>>>>>>            return err != -ENOMEM;
>>>>>>     }
>>>>>>
>>>>>> +static void virtnet_rx_refill_all(struct virtnet_info *vi)
>>>>>> +{
>>>>>> +       bool schedule_refill = false;
>>>>>> +       int i;
>>>>>> +
>>>>>> +       enable_delayed_refill(vi);
>>>>> This seems to be still racy?
>>>>>
>>>>> For example, in virtnet_open() we had:
>>>>>
>>>>> static int virtnet_open(struct net_device *dev)
>>>>> {
>>>>>            struct virtnet_info *vi = netdev_priv(dev);
>>>>>            int i, err;
>>>>>
>>>>>            for (i = 0; i < vi->max_queue_pairs; i++) {
>>>>>                    err = virtnet_enable_queue_pair(vi, i);
>>>>>                    if (err < 0)
>>>>>                            goto err_enable_qp;
>>>>>            }
>>>>>
>>>>>            virtnet_rx_refill_all(vi);
>>>>>
>>>>> So NAPI and refill work is enabled in this case, so the refill work
>>>>> could be scheduled and run at the same time?
>>>> Yes, that's what we expect. We must ensure that refill work is scheduled
>>>> only when all NAPIs are enabled. The deadlock happens when refill work
>>>> is scheduled but there are still disabled RX NAPIs.
>>> Just to make sure we are on the same page, I meant, after refill work
>>> is enabled, rq0 is NAPI is enabled, in this case the refill work could
>>> be triggered by the rq0's NAPI so we may end up in the refill work
>>> that it tries to disable rq1's NAPI while holding the netdev lock.
>> I don't quite get your point. The current deadlock scenario is this
>>
>> virtnet_rx_resume_all
>> napi_enable(rq0) (the rq1 napi is still disabled)
>> enable_refill_work
>>
>> refill_work
>> napi_disable(rq0) -> still okay
>> napi_enable(rq0) -> still okay
>> napi_disable(rq1)
>> -> hold netdev_lock
>>       -> stuck inside the while loop in napi_disable_locked
>>               while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
>>                   usleep_range(20, 200);
>>                   val = READ_ONCE(n->state);
>>               }
>>
>>
>> napi_enable(rq1)
>> -> stuck while trying to acquire the netdev_lock
>>
>> The problem is that we must not call napi_disable() on an already
>> disabled NAPI (rq1's NAPI in the example).
>>
>> In the new virtnet_open
>>
>> static int virtnet_open(struct net_device *dev)
>> {
>>            struct virtnet_info *vi = netdev_priv(dev);
>>            int i, err;
>>
>>            // Note that at this point, refill work is still disabled, vi->refill_enabled == false,
>>            // so even if virtnet_receive is called, the refill_work will not be scheduled.
>>            for (i = 0; i < vi->max_queue_pairs; i++) {
>>                    err = virtnet_enable_queue_pair(vi, i);
>>                    if (err < 0)
>>                            goto err_enable_qp;
>>            }
>>
>>            // Here all RX NAPIs are enabled so it's safe to enable refill work again
>>            virtnet_rx_refill_all(vi);
>>
> I meant this part:
>
> +static void virtnet_rx_refill_all(struct virtnet_info *vi)
> +{
> +       bool schedule_refill = false;
> +       int i;
> +
> +       enable_delayed_refill(vi);
>
> refill_work could run here.

I don't see how this can trigger the current deadlock race. However, I 
see that this code is racy, the try_fill_recv function is not safe to 
concurrently executed on the same receive queue. So there is a 
requirement that we need to call try_fill_recv before enabling napi. Is 
it what you mean?

>
> +       for (i = 0; i < vi->curr_queue_pairs; i++)
> +               if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> +                       schedule_refill = true;
> +
>
> I think it can be fixed by moving enable_delayed_refill() here.
>
> +       if (schedule_refill)
> +               schedule_delayed_work(&vi->refill, 0);
> +}

Thanks,
Quang Minh.




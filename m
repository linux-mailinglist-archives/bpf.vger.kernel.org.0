Return-Path: <bpf+bounces-76048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7F3CA4319
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 16:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74D7A31C8C2C
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 15:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62F82D73B5;
	Thu,  4 Dec 2025 15:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpJY+GbT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231872D73A5
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764860916; cv=none; b=UQexs/YwWENgUTjkpemWijKjH8GJW2STr2pFVR8lDieuEvna4L0o3cuRvnQd7VyJLGYaUm7FfQLFcmuqCJKyefIjz5vFhIpBlAne3ILQdbusPqePvWtQ6Tc0WLKr2U0Ssv+KvRCbvEQ/j4oDuxSsb4OCACaNQIEg1xrMPzT6EQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764860916; c=relaxed/simple;
	bh=mow+fg3+RlIbDNumBSEnGyZekiI5a4ukShUjLnnu0Js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IrnMfK9yvrZUovi3Oj9l7uADJPrG1hN4LwxIi1sSirNSKK0dd+E3ZxwzjNp4aqpKdeHD7sbv8J88Ge9NiufyH0MXxIPuZhoGdm6Cu8euDgpzCEeVxsvr7Xuwqjvd8pw3JoqOs/kUx/DpvuoRVZ3ZaT6KoZ4EaQ72gqb0pdRs29c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpJY+GbT; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7b6dd81e2d4so1077792b3a.0
        for <bpf@vger.kernel.org>; Thu, 04 Dec 2025 07:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764860913; x=1765465713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t1iqQ0ov45xjnCibqFJmGxUgMKunIGbHn1CsgPvUOa0=;
        b=EpJY+GbT2GuIEWdtU0ZHL742loWruVKtuTyFoCR8XRNym3OZBw4Yk5zRe6sd7P8XME
         1NLacDQsksq4E1UckNBW7dbFes5qLwbXNZsmrhPIDkAs3uUhapi9Syd30ucWM5N80u0S
         yab9GrQboMOSjBO4dSaLOpKaS9St1IZcKFadd9azjKPFWQE98mFYJ5u2aIm715Hm+yHJ
         NuAICmdYffQudeH8KmIOFwXXGS8/UbcrNlncWZe1nLHdJ84Fy+7a7TP7zjjoM2k3z971
         j/lq5R9MBymtH2gcTwy6ZOdY4dyVMBGGMCEwA15RBG65EZ0veXzKfx5lqTg+clEpFicT
         xQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764860913; x=1765465713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t1iqQ0ov45xjnCibqFJmGxUgMKunIGbHn1CsgPvUOa0=;
        b=ZCJlXJBoSihUJ5R9aduNZKK70fLJniV5LsIsW00xz5cP3saN1OfTesogy32DVRmCAS
         0d+QQU6uKXgqzek/rQkeyqM8Dege2RilpnsNRUEuTramvVb/r/izHxhuXwVXmg6cu/4u
         g/YY8WYHTThFoggLNwNakXPQbq6H5/yqZgN5BIMacENhtOeQXYXedBaKrJNdO0uPfJPv
         sVNn/UrguGJxCOnrvnJv2/5yxSd+Cltz9go3zTqVy7O8YjAiKvfJLIf0eoR7OIFy1lVz
         v7i7Xxm3slSkk3TbEB2o/hl1gzzHfZm8qoa8exk0Klzxd3Ixay/XGMGnUwjpQ+DMQNvD
         dzCg==
X-Forwarded-Encrypted: i=1; AJvYcCVryslmw/FcGZZTwn51ImoGywrjmG1LpaiFp2G78k53onSvCDnT2T8JjwjCsFVmUpY/cIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDhPSrnqa7A02DO4Ex2zwlEnDxYFOEDakolUM82UE/jiGdllHE
	nGbIvqzV7c0Iy1gLXotTcuK1kc2gwGkPagzJwYuj7fc2oCgN3lEyW9UA
X-Gm-Gg: ASbGnctpjBzAsACLil/tbhhvdWR/d1bI563smwwISWxyp08GbNzqsmdYUlqTom7txqw
	enzFHfN59A/rBrwOmLKyoX3fHZXQqY28IL2pS83lCsyMFiC97Qb9T/xAFXqA0WMgCgychMZmmdh
	nOnVHEhIXs04rJf1p04R51lhJ6S1TGfJzP+JnU5PamklDjQ30Vcux28fHVLGcSVDERTIT/Ep4fq
	o4xdowBZbm3W7xXAnjNxPUgmMfnYWeeJxANMcAD+knW/4drBsqF1XzKXGBo03JNTrYe1GBLUhNy
	157PUx+ZWaPjjVonjkVKmWUKP++OJKC+F9IRAyHvTRVaAIoRvo+QmcJf6qsufL6pXg+lGAlhtnP
	+35LQhn2534NZHToiodwHLdTAMaLo36ZRUhzkFM5k8RYdyC44HyGV3pKj8N8SZtanL/wK9drYKA
	EuTxSk3dY1jWTCZBmVUPzwJJm0mck4cnELYB9XedQWgBL5yZxqNvmNckAhh0zp1g==
X-Google-Smtp-Source: AGHT+IGT33HgCqLOZfJ01RgUk00qwFrULoYZQaMW53xI5BI0UsjXz8kyxp1vtyO+ouK42MOcyxdiSA==
X-Received: by 2002:a05:6a20:3ca6:b0:34e:1009:4222 with SMTP id adf61e73a8af0-363f5e95146mr8047704637.51.1764860912867;
        Thu, 04 Dec 2025 07:08:32 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f4c:210:c2bc:6984:75c5:9339? ([2001:ee0:4f4c:210:c2bc:6984:75c5:9339])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf686b3b5a9sm2145622a12.9.2025.12.04.07.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 07:08:32 -0800 (PST)
Message-ID: <eabd665c-b14d-4281-9307-2348791d3a77@gmail.com>
Date: Thu, 4 Dec 2025 22:08:25 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] virtio_net: gate delayed refill scheduling
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org
References: <40af2b73239850e7bf1a81abb71ee99f1b563b9c.1764226734.git.mst@redhat.com>
 <a61dc7ee-d00b-41b4-b6fd-8a5152c3eae3@gmail.com>
 <CACGkMEuJFVUDQ7SKt93mCVkbDHxK+A74Bs9URpdGR+0mtjxmAg@mail.gmail.com>
 <a9718b11-76d5-4228-9256-6a4dee90c302@gmail.com>
 <CACGkMEvFzYiRNxMdJ9xNPcZmotY-9pD+bfF4BD5z+HnaAt1zug@mail.gmail.com>
 <faad67c7-8b25-4516-ab37-3b154ee4d0cf@gmail.com>
 <CACGkMEtpARauj6GSZu+iY3Lx=c+rq_C019r4E-eisx2mujB6=A@mail.gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CACGkMEtpARauj6GSZu+iY3Lx=c+rq_C019r4E-eisx2mujB6=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/3/25 13:37, Jason Wang wrote:
> On Tue, Dec 2, 2025 at 11:29 PM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>> On 12/2/25 13:03, Jason Wang wrote:
>>> On Mon, Dec 1, 2025 at 11:04 PM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>>>> On 11/28/25 09:20, Jason Wang wrote:
>>>>> On Fri, Nov 28, 2025 at 1:47 AM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>>>>>> I think the the requeue in refill_work is not the problem here. In
>>>>>> virtnet_rx_pause[_all](), we use cancel_work_sync() which is safe to
>>>>>> use "even if the work re-queues itself". AFAICS, cancel_work_sync()
>>>>>> will disable work -> flush work -> enable again. So if the work requeue
>>>>>> itself in flush work, the requeue will fail because the work is already
>>>>>> disabled.
>>>>> Right.
>>>>>
>>>>>> I think what triggers the deadlock here is a bug in
>>>>>> virtnet_rx_resume_all(). virtnet_rx_resume_all() calls to
>>>>>> __virtnet_rx_resume() which calls napi_enable() and may schedule
>>>>>> refill. It schedules the refill work right after napi_enable the first
>>>>>> receive queue. The correct way must be napi_enable all receive queues
>>>>>> before scheduling refill work.
>>>>> So what you meant is that the napi_disable() is called for a queue
>>>>> whose NAPI has been disabled?
>>>>>
>>>>> cpu0] enable_delayed_refill()
>>>>> cpu0] napi_enable(queue0)
>>>>> cpu0] schedule_delayed_work(&vi->refill)
>>>>> cpu1] napi_disable(queue0)
>>>>> cpu1] napi_enable(queue0)
>>>>> cpu1] napi_disable(queue1)
>>>>>
>>>>> In this case cpu1 waits forever while holding the netdev lock. This
>>>>> looks like a bug since the netdev_lock 413f0271f3966 ("net: protect
>>>>> NAPI enablement with netdev_lock()")?
>>>> Yes, I've tried to fix it in 4bc12818b363 ("virtio-net: disable delayed
>>>> refill when pausing rx"), but it has flaws.
>>> I wonder if a simplified version is just restoring the behaviour
>>> before 413f0271f3966 by using napi_enable_locked() but maybe I miss
>>> something.
>> As far as I understand, before 413f0271f3966 ("net: protect NAPI
>> enablement with netdev_lock()"), the napi is protected by the
> I guess you meant napi enable/disable actually.
>
>> rtnl_lock(). But in the refill_work, we don't acquire the rtnl_lock(),
> Any reason we need to hold rtnl_lock() there?

Correct me if I'm wrong here. Before 413f0271f3966 ("net: protect NAPI 
enablement with netdev_lock()"), napi_disable and napi_enable are not 
safe to be called concurrently.

The example race is

napi_disable -> napi_save_config -> write to n->config->defer_hard_irqs
napi_enable -> napi_restore_config -> read n->config->defer_hard_irqs

In refill_work, we don't hold any locks so the race scenario can happen.

Maybe I misunderstand what you mean by restoring the behavior before 
413f0271f3966. Do you mean that we use this pattern

     In virtnet_xdp_se;

     netdev_lock(dev);
     virtnet_rx_pause_all()
         -> napi_disable_locked

     virtnet_rx_resume_all()
         -> napi_disable_locked
     netdev_unlock(dev);

And in other places where we pause the rx too. It will hold the 
netdev_lock during the time napi is disabled so that even when 
refill_work happens concurrently, napi_disable cannot acquire the 
netdev_lock and gets stuck inside.


>
>> so it seems like we will have race condition before 413f0271f3966 ("net:
>> protect NAPI enablement with netdev_lock()").
>>
>> Thanks,
>> Quang Minh.
>>
> Thanks
>

Thanks,
Quang Minh.


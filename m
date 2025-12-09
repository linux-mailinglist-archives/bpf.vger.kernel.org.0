Return-Path: <bpf+bounces-76372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08564CB064B
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 16:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB37230B9BFA
	for <lists+bpf@lfdr.de>; Tue,  9 Dec 2025 15:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B6A2FFDD8;
	Tue,  9 Dec 2025 15:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dq659yd9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BE02D3A60
	for <bpf@vger.kernel.org>; Tue,  9 Dec 2025 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765293820; cv=none; b=ogWA2j407dv/ipLOArUc36CeJWKixD2lm442kmDaWOEHFs+aSMOA7Zw0PIdWsWn8VhDYv9FW5Q1NKKI/cenVt2HDDs9v9QqEUsY3nhdz10rBIXrv7dqkp9Hj7oveqJr6BJmdbYFqd+XXvEfZ95BMif5Nl/5kM8DXl/eVbDyA/2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765293820; c=relaxed/simple;
	bh=JD5hyBpJAaNJ7sYgl/UrQWHJjtabTdl0L4UaYY83N+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FySR78/SL/msz0GHVpB+4JcfiP3FESIjisLWZKGjfDh1YeZG6oa3pMzqGN7yiyOERcWW7KsWWuU+W92W6cn/MUaYOxkPbpBPcdNQTJXl5/1VBucBAh+jji8NsCd99jt0M1HG3Ax4R4tgI4ZFfkt6lUQlSxNGkwXWW2HVzHxv4rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dq659yd9; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7ba55660769so4938425b3a.1
        for <bpf@vger.kernel.org>; Tue, 09 Dec 2025 07:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765293817; x=1765898617; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W7DbZ+8N23FwouofrnDLigkDHoe3CUpkkU2pOJ+ToVI=;
        b=dq659yd9spEH0AGlJjSXLFg6yLammOn6b7Fash88SM1EoPff0OUXVC+Ah/d/EPfwqm
         YE8eERQNhpwarsHnbSftuNxhg54x80TAfSHqYgMqe/pGXRHo/XmVDBto3IaQdG0XROzn
         vKIr8nyQbVjI3fxamkeWdzYSi7qzNWRd2/u48xE8O18sY2T88KQBMJjwXOP1x4hcm/le
         Wrttm7XMiFG7E6THyTguFmi3pSdYEZSOfyo/++qQD4c7QIhaTGHRH1kOMN9w6AQk3EzV
         Uljw8GebCdczwbGV2kp0WQW3xe2T8DF4JN2wa3Ohfmb1PbWK61JiNvrr3vqXlGRYsJ6k
         BpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765293817; x=1765898617;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7DbZ+8N23FwouofrnDLigkDHoe3CUpkkU2pOJ+ToVI=;
        b=thajJb6WjRZgD97kOccTjLa/o3pupccVVHu3wyitbVmK3ofUkx44+y/yPd3if50mDq
         9XuNgQxm9FWZf2uZIZECzpNcZeEzRczLSHB2Qg9TllzYszIHwepqk99xOBQin7kcBjjp
         lMYVdbNYxNJ+vfjJQPJ8VytW39K2wO4xgYwUNHekSigYMCgEfz6/Me2NzejKD1IYMuhN
         2EJGZg897xk7knjxydF9xbY1fDTia4OZGbIvKUSFT5haIws+VPxO0tW/4HlDBv30z3WG
         DQvivKTkUwk5YCBNiPzq1cr8uHAJ331+j5CSdgmYFtVjzdWNueXUpHV5tZ/c+zdjdHGa
         5WRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGFIuliwvdCp2Jh4L5kLdqnBG/lWJGwa0juzDp6ZwPasF9Cm7PB9MsMA4CxhunMJY2+wc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+hs//qJ9y2jlJpHGAmH6VtMIiTsxi4NcvkzjyWjM0OSJ3pdw8
	xVcG4H0asWOp+WZ8ZJEmkyR/I4sZJHGbnBLBRFm3Nc8SeC1ClbFnGwc3
X-Gm-Gg: ASbGncsc+TWTciSnOitfc4RSKwh6M2bTAo/qFg2U6RJc3A0Gzh8queW5JbTIL4NWns5
	rKQFq6npCYrfOBukJqok4mjF03r9EjJDvSLpFOgmT8pEoxBto+XAzeWwkqdwrNVU1P3kP8xdeli
	9xGSIo7X8EHUIK4xrfWJqMt+64nZMSkBu46kOCp9YRgSAXZVu8voGwS8xzNHqFjRdfsHt6lsNGl
	18tmhjkamG3Z6zF4s0kmy6EuOrbVfuzWGM+DixScH+hOn3YaI8ChGpbk54fcLAhbxOoL1slIbew
	tJp2U8nyrLOsWaAwYKqTEXvku/Dlp33bm6k6e6EpkPCwfJwKG6tasPI7Spvt+Bq5GqJTQTfOWji
	/3KxMepFktis8yTSDbRPggLneSF86DfudBEonTTMJ9fvA+X6tHznjlXBh/qe5BiWOfYZN7yAy+3
	cpiisefIFQoN7Qx5lLS4IsSskHO7WRmgO0t3UjVaNxbjZVqFGIAqpq8cZxqlBP
X-Google-Smtp-Source: AGHT+IFN5sdylXJLxCHNNsv6xbK8xt8uPVU4i306NX8HPuK5V8M26O/oWPXK67LxkxgltqZUNhCZqw==
X-Received: by 2002:a05:6a00:1703:b0:7e8:4471:8d1 with SMTP id d2e1a72fcca58-7e8c786662bmr9491026b3a.50.1765293817283;
        Tue, 09 Dec 2025 07:23:37 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f4c:210:e7d6:7fa4:50a3:fa14? ([2001:ee0:4f4c:210:e7d6:7fa4:50a3:fa14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ed2cd65ad1sm6229403b3a.56.2025.12.09.07.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 07:23:36 -0800 (PST)
Message-ID: <66d9f44c-295e-4b62-86ae-a0aff5f062bb@gmail.com>
Date: Tue, 9 Dec 2025 22:23:30 +0700
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
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CACGkMEvtKVeoTMrGG0gZOrNKY=m-DGChVcM0TYcqx6-Ap+FY8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/9/25 11:30, Jason Wang wrote:
> On Mon, Dec 8, 2025 at 11:35 PM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>> Calling napi_disable() on an already disabled napi can cause the
>> deadlock. In commit 4bc12818b363 ("virtio-net: disable delayed refill
>> when pausing rx"), to avoid the deadlock, when pausing the RX in
>> virtnet_rx_pause[_all](), we disable and cancel the delayed refill work.
>> However, in the virtnet_rx_resume_all(), we enable the delayed refill
>> work too early before enabling all the receive queue napis.
>>
>> The deadlock can be reproduced by running
>> selftests/drivers/net/hw/xsk_reconfig.py with multiqueue virtio-net
>> device and inserting a cond_resched() inside the for loop in
>> virtnet_rx_resume_all() to increase the success rate. Because the worker
>> processing the delayed refilled work runs on the same CPU as
>> virtnet_rx_resume_all(), a reschedule is needed to cause the deadlock.
>> In real scenario, the contention on netdev_lock can cause the
>> reschedule.
>>
>> This fixes the deadlock by ensuring all receive queue's napis are
>> enabled before we enable the delayed refill work in
>> virtnet_rx_resume_all() and virtnet_open().
>>
>> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
>> Reported-by: Paolo Abeni <pabeni@redhat.com>
>> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>>   drivers/net/virtio_net.c | 59 +++++++++++++++++++---------------------
>>   1 file changed, 28 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 8e04adb57f52..f2b1ea65767d 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -2858,6 +2858,20 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
>>          return err != -ENOMEM;
>>   }
>>
>> +static void virtnet_rx_refill_all(struct virtnet_info *vi)
>> +{
>> +       bool schedule_refill = false;
>> +       int i;
>> +
>> +       enable_delayed_refill(vi);
> This seems to be still racy?
>
> For example, in virtnet_open() we had:
>
> static int virtnet_open(struct net_device *dev)
> {
>          struct virtnet_info *vi = netdev_priv(dev);
>          int i, err;
>
>          for (i = 0; i < vi->max_queue_pairs; i++) {
>                  err = virtnet_enable_queue_pair(vi, i);
>                  if (err < 0)
>                          goto err_enable_qp;
>          }
>
>          virtnet_rx_refill_all(vi);
>
> So NAPI and refill work is enabled in this case, so the refill work
> could be scheduled and run at the same time?

Yes, that's what we expect. We must ensure that refill work is scheduled 
only when all NAPIs are enabled. The deadlock happens when refill work 
is scheduled but there are still disabled RX NAPIs.

Thanks,
Quang Minh.



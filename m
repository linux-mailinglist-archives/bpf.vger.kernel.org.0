Return-Path: <bpf+bounces-59636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBFFACE014
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 16:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FAA33A7D28
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 14:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62452290DA6;
	Wed,  4 Jun 2025 14:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQ6cHHDv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4BE290D8B;
	Wed,  4 Jun 2025 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749046643; cv=none; b=QzUdKQrSoVt4kyq/pYHGdqp9IrCOW0DEb1Vml8z/SqsSE+JSk58/EJn9cv/GpSWt07fsD9tYb5ZBdxMhzsYkh2+1rmSRjnmB5Anb4Km5lW/TiUn3wtGO/DO4659al2WdLm7kYqok2uhj8cOhP57Bo4zjaEAnRvNLqQXTkbcGJnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749046643; c=relaxed/simple;
	bh=Nnuyl9wD25Z9WoJOMjCag6e7edZarcfbMnxn+kgonFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qE5L/4RGsSdfrZ9OXHdJ6ARln2k76NiIjAKN5lAM3lolt5v2Cykt9iti2QDJWeXrocYxhsXHAY87HX5Uv/xejLCDtc2qs0zMcBZ3DVVBpnsDbS6aRr+lsL2CDM65eKXoZgMTNsxqlayJVnaLDP4N9tEzwixaCABIH4GrypY3QXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQ6cHHDv; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-234b9dfb842so65165595ad.1;
        Wed, 04 Jun 2025 07:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749046642; x=1749651442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cbNMtoTuh7H5yqZEP3R1sHyOOtxrJsRVIWBb21IBiJI=;
        b=DQ6cHHDvTraqcsf/V6XzWpJh0wRCZ6GNIGeAJlTc6gB8vmEs+9HrytmMwZ6d6MPoNz
         6nx4pq17I4nvMDF4VT03hfRi0coR4lDO74O7kNOvkAHszEZ/PjS6DGAvUXXlksNj6Y4k
         uPRaKp3c40nc9Vzs03noNcHewp1YYYU/N4xSQswOfh+ppeevaVrrlSGePBHCzvqh/s80
         RvWPdoarWGGlAI2pxELJGa6CqUGP+ON+BPGQZ57XTo9TJkytNif0aiKxkucpnRIMmQOE
         6dlASWoZN22/7EZlk5qt8NEq+a/pf269bI9MdgUpr9qzxYancwjNH6ZOcvkX31HjqlIU
         MitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749046642; x=1749651442;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cbNMtoTuh7H5yqZEP3R1sHyOOtxrJsRVIWBb21IBiJI=;
        b=kIWwDmzCJJi83MHjz9rwsfYHdOuZNFVZ0Y4qYGUKhsIsDxl9LZpLsXaJzDOZX0Hedn
         qlbTqHif3FV7JDAy424q8ZAKa69u3iFxHL3svAOAAW2w73dm8I8Hz8fMtmPTWrVlmXWS
         DPIecgnDvCE3n2QnZQqqdZQg5TBhMsJl2dtShQRN7L+sQGAV9wVJwM5aSoQCubjvqqxW
         M5Qfu/JFZ2EIh+oMui3cQ1LeW18m6h8MudLH4GMUj/zceqe636QxAMBUoNyre5K2+PQA
         inY8QkxVLivViTmUA8b4OQpcLUg65l9DdxKAPKXbcsCxGTa25sJsODBIwFW6FO+Wy4BR
         9Zkg==
X-Forwarded-Encrypted: i=1; AJvYcCUgRXznLIKqF+5EqTW72JdD9xksl0ueeCZBv+P33pRlk/cAka4/0CMXh+IZUPwDOMVRI7U=@vger.kernel.org, AJvYcCVCcvT5xW+9quX2/ZAklhtt6Yegn4KB2uD7sprd5GFHutR+hXX6FNLE2KRXd1fvJJn+ZZnw7gbV@vger.kernel.org, AJvYcCXpQO0Yf0k85sqPoUMq/+3Iwy+ZOibUP3s55M6c2rL/GRM4nOHraJMcaVqU9YX3KF7Emc4mQ9YZxDxVzNJq@vger.kernel.org
X-Gm-Message-State: AOJu0YxDVJqeHqbG6AdDrfZf2Sxwk3Lt5f1NTqdzujYLIUvAnG1BQoNU
	VgFWhe6mBSe5Wpo2txBoOaArEhIaR2lMzD+bAoSGSwigRskHRM2o3LIP
X-Gm-Gg: ASbGncuyMJncbv2+MqxPv4tW0yo0qbAe4Cy1rNuuCud+9BNWYjwFxjzmCsD2Au0oZ8X
	WGz+KQ9hMAIntKiB+Duv290NDAfNzXe6kmWBOV+bT41WSuK3cftQmYg+LT39CzQm5iTqvu8CpzE
	mVZaN+Fsu5jwiQzs+S8t8lXrgDD8sM+JdBZuqXLO+UIS9eGEf9mZ2kpbb57LiCUgo28ok7iE5jR
	g4ukmov13oPXHzHD6b0SeSR4a3me3MIdz6pNXYW5H25dk778RUYHth/zHomw6V5rtB3WFhWhu4V
	yVaJVJqG1F/uJ1l9LBtBhzVM+LbHzAQmvsDGrh8QRMZqjE/THthfkdf4AtZqK9lCDlZBAkw4ib9
	wJ5feSnlnjKa38ypp/b+HZuvT1y5HGw==
X-Google-Smtp-Source: AGHT+IE828D8E7wNAmkp2vuWIY7rdgflYp7evYs/pZp1n9PqsG0ZfmxYtWnexCMgGjwdtHSFbk9D6Q==
X-Received: by 2002:a17:902:c94d:b0:234:bca7:2920 with SMTP id d9443c01a7336-235e11c91abmr48459595ad.24.1749046641673;
        Wed, 04 Jun 2025 07:17:21 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:8915:1d85:9b14:f198? ([2001:ee0:4f0e:fb30:8915:1d85:9b14:f198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bd93f7sm103883575ad.95.2025.06.04.07.17.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 07:17:21 -0700 (PDT)
Message-ID: <0bc8547d-aa8f-4d96-9191-fd52d1bec74e@gmail.com>
Date: Wed, 4 Jun 2025 21:17:09 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio-net: drop the multi-buffer XDP packet in
 zerocopy
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
References: <20250603150613.83802-1-minhquangbui99@gmail.com>
 <CACGkMEuHDLJiw=VdX38xqkaS-FJPTAU6+XUNwfGkNZGfp+6tKg@mail.gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CACGkMEuHDLJiw=VdX38xqkaS-FJPTAU6+XUNwfGkNZGfp+6tKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/4/25 07:37, Jason Wang wrote:
> On Tue, Jun 3, 2025 at 11:07 PM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>> In virtio-net, we have not yet supported multi-buffer XDP packet in
>> zerocopy mode when there is a binding XDP program. However, in that
>> case, when receiving multi-buffer XDP packet, we skip the XDP program
>> and return XDP_PASS. As a result, the packet is passed to normal network
>> stack which is an incorrect behavior. This commit instead returns
>> XDP_DROP in that case.
>>
>> Fixes: 99c861b44eb1 ("virtio_net: xsk: rx: support recv merge mode")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>>   drivers/net/virtio_net.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index e53ba600605a..4c35324d6e5b 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -1309,9 +1309,14 @@ static struct sk_buff *virtnet_receive_xsk_merge(struct net_device *dev, struct
>>          ret = XDP_PASS;
> It would be simpler to just assign XDP_DROP here?
>
> Or if you wish to stick to the way, we can simply remove this assignment.

This XDP_PASS is returned for the case when there is no XDP program 
binding (!prog).

>
>>          rcu_read_lock();
>>          prog = rcu_dereference(rq->xdp_prog);
>> -       /* TODO: support multi buffer. */
>> -       if (prog && num_buf == 1)
>> -               ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, stats);
>> +       if (prog) {
>> +               /* TODO: support multi buffer. */
>> +               if (num_buf == 1)
>> +                       ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit,
>> +                                                 stats);
>> +               else
>> +                       ret = XDP_DROP;
>> +       }
>>          rcu_read_unlock();
>>
>>          switch (ret) {
>> --
>> 2.43.0
>>
> Thanks
>


Thanks,
Quang Minh.




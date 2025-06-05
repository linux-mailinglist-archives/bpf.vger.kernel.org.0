Return-Path: <bpf+bounces-59756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC567ACF1F3
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 16:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43A981885FDC
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 14:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA1327B51C;
	Thu,  5 Jun 2025 14:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pi/GTs2I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8136027B4EE;
	Thu,  5 Jun 2025 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749133514; cv=none; b=ZaTQ42bAhS8LrU+KLToB7ppD5rR37v/ZO2wUInTioLY8bCpXQ2F+4u7oj/OZ0Jqpu5V6KSsd6Bio49NVKT10WOv7CuMA14anvt3KF2OAMOJw+oXonY74X84UMm9ZWCjjkY8W+oTg9v6OpslV+NC1GU3CmtqnswtNv7IEohgJSQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749133514; c=relaxed/simple;
	bh=X600dW54IagONIXRnn2TcBhMfRUF8CY7hzPPC9iyc/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Soxz+agPFV1YleUn8ip5Vjx2Bawk3OojEqVM2omgLEn0eE6cPszm9LSndZX0qOjT6EGXOPICOUjk1vVVNfMarkBrM5h/PnS7+D9bha46Po6Ffg3tH7+7b30Ozrx/lyEYDv7dzvbfwJT8YZsNQQbUPLHqSI7fxfa98C0bBI6iZYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pi/GTs2I; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7426c44e014so1031967b3a.3;
        Thu, 05 Jun 2025 07:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749133512; x=1749738312; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gqic3Vsyj4bzSmL05WQaZvcda3GIaM4YL+rFO5Ane1s=;
        b=Pi/GTs2IvN8OwPkdYTnlGne0go3cLQMyf3p/XMhJM4aZxXhFoF+RKUyiilz8ehpWep
         g4OWm5VBR6Afe24I8JT633CW+ZAaVG1e86kKcVhMTqirrqg2OyYpup/WHQ/CzfX6ck/v
         X5u14Q6YD9sIOYZZzXSBP9U6vLfopkexY79x5KoM66ily1P4GFRqP52PUasbtUSbd3RV
         ssxYbVpXPgblwpqhfujE4ogjp3pHq399fP824FQWDKrvRuiLysrXA/C3lMYtFT7Z/nk2
         iJtOtx1i72fgCJGM5S+HDn9l0qMMvTngmTzjsNM+BgTmur42euyDleAuBBbEA9y7y51f
         sUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749133512; x=1749738312;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gqic3Vsyj4bzSmL05WQaZvcda3GIaM4YL+rFO5Ane1s=;
        b=h7Xksn78F6Y6qD2q7cMekg9QfkffzRqKRHNzZXqICcBLgoLbqv84Q5lRDsAmlrfmnp
         WgL1M8d8ehGX5s1J8KBnyQHfghh65bQNQHrOxbbt+67Pk4FYmudP1un4gbtmEQ14QCff
         6ZcbWeAx/Xxxm+IutuXoKAcQatwJZJGBet8iZlQy0hCw+IaaTOrpESl49NvjMft8u7y3
         mnCHm8SlsBfDUnTiXXHhRo7wzHwr2MPDHX06eWENkbgpZtYI1b04MDuiYyPaJssr+ffh
         4BL6Iw9JD22V9mRHOy1QFRqRqw1k6OrNhbQKUFLSZNv4iVs35qnqd56g8sP7TXm/hO7C
         ovqA==
X-Forwarded-Encrypted: i=1; AJvYcCU080ShRva8+cLV/172TLvvqkhydyf0KQ1OiG82cx94hj6lY5zXa2VpX0UrY9TvB45xrPM=@vger.kernel.org, AJvYcCVZzrYWtXBuXLBRNB2jqTaiCyKTczsSBxFl8nHp8fC89XepTNnvC5ix6nAA0+6quLFGVlyUK0RO@vger.kernel.org, AJvYcCVqljEmaHa+a0dqdsa7LUO8AedRZEmE2wSC+aG9Sfg3w/13Nkmoh9bBmk9qAw/fOaixefRLof1TmZeozUSW@vger.kernel.org
X-Gm-Message-State: AOJu0YwxoDJOC2ETv7/WOTm7XAz2Ubm8HaUZvPuOCzhPNmPnsYEDNhWo
	cAgbsh99qPxXlB4+JluhvJ5XIKzP6e2RQLwSj9eviXsLIgT7ozFHBEvg
X-Gm-Gg: ASbGnculQQCEYbkWAXZcbcCTyoejAUITTXuNIPt3yEnv2BP2GKSysovNtNVqfj2EHyS
	vTCTMMt78aGha6NweJDIK4EyUQM93W4nZCT+N/AuQadY2+MHd4AgXluCkRqHVM5lvTVkjBA8lOV
	Ar9gdtCTjpUPYpLlVS4u+JTHk0/3plL5ttzKRklVFluX8Y/NFwSJpHQXPC+I+GE30mCdCv50hq6
	ZOFPjgsUCSo1YOYQK6JBlEbMvNGac2hZT3PYgGQRmzWEZahd/mCZ3FRApT+IbKsBIg+9xrIFWwE
	7kVLC/Y4t6XQVtPthp6E+/vmjDrhIaGPgxfZameScalpcYGYEWLhpuxdbM2uTHuFdYQmQ9z/h3p
	Gj0BQzfgs2Gtr23TcGZYuuBGQjOQ=
X-Google-Smtp-Source: AGHT+IH4vL0ow3LtCX+mnTgMUIKUpP6tlNeWjyc30axYR85Pz7Znrto5PFXe7BtNog4L00G5ukEv0w==
X-Received: by 2002:a05:6a00:13a2:b0:736:5e28:cfba with SMTP id d2e1a72fcca58-7480d023dc6mr9016645b3a.18.1749133511687;
        Thu, 05 Jun 2025 07:25:11 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:fe1:cf75:ee2d:d934? ([2001:ee0:4f0e:fb30:fe1:cf75:ee2d:d934])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afeabad9sm13367104b3a.51.2025.06.05.07.25.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 07:25:11 -0700 (PDT)
Message-ID: <099a66e1-c271-488c-8997-daf07602d16b@gmail.com>
Date: Thu, 5 Jun 2025 21:25:03 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio-net: drop the multi-buffer XDP packet in
 zerocopy
To: Zvi Effron <zeffron@riotgames.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
References: <20250603150613.83802-1-minhquangbui99@gmail.com>
 <CAC1LvL0xTSv9sBRYnD-ykDqQr+Reg7yB0uwAR158-+aAm1J1Ew@mail.gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CAC1LvL0xTSv9sBRYnD-ykDqQr+Reg7yB0uwAR158-+aAm1J1Ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/4/25 23:55, Zvi Effron wrote:
> On Tue, Jun 3, 2025 at 8:09 AM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>> In virtio-net, we have not yet supported multi-buffer XDP packet in
>> zerocopy mode when there is a binding XDP program. However, in that
>> case, when receiving multi-buffer XDP packet, we skip the XDP program
>> and return XDP_PASS. As a result, the packet is passed to normal network
>> stack which is an incorrect behavior. This commit instead returns
>> XDP_DROP in that case.
> Does it make more sense to return XDP_ABORTED? This seems like an unexpected
> exception case to me, but I'm not familiar enough with virtio-net's multibuffer
> support.

The following code after this treats XDP_DROP and XDP_ABORTED in the 
same way. I don't have strong opinion between these 2 values here. We 
may add a call to trace_xdp_exception in case we want XDP_ABORTED here.

Thanks,
Quang Minh.

>
>> Fixes: 99c861b44eb1 ("virtio_net: xsk: rx: support recv merge mode")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>> drivers/net/virtio_net.c | 11 ++++++++---
>> 1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index e53ba600605a..4c35324d6e5b 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -1309,9 +1309,14 @@ static struct sk_buff *virtnet_receive_xsk_merge(struct net_device *dev, struct
>> ret = XDP_PASS;
>> rcu_read_lock();
>> prog = rcu_dereference(rq->xdp_prog);
>> - /* TODO: support multi buffer. */
>> - if (prog && num_buf == 1)
>> - ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, stats);
>> + if (prog) {
>> + /* TODO: support multi buffer. */
>> + if (num_buf == 1)
>> + ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit,
>> + stats);
>> + else
>> + ret = XDP_DROP;
>> + }
>> rcu_read_unlock();
>>
>> switch (ret) {
>> --
>> 2.43.0
>>
>>



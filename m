Return-Path: <bpf+bounces-60608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75395AD9259
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 18:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FE573BF4AA
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 15:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F7420459A;
	Fri, 13 Jun 2025 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgH6HZMH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41AA18DB29;
	Fri, 13 Jun 2025 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749830328; cv=none; b=tycHGQaLTd9A776LpwUOgC2gWyIo/XYHZIr9f9EUY1CSWtKkmoUfonnp2eSArCECKbak9fEtjeM3R2wVBI3xhBTkIq7fmCCZud1HhQuHBa7gWYLR3AjlVNGX4rMoZ/NS05U8QsH1mtd/1241CBStLvao/Sk85FKrvSX3WwkBEFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749830328; c=relaxed/simple;
	bh=jHspmyvQYxNtlI9sxlSzz47M3IR/Dsvnejhvt4pQ7kY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MvG3TzwaGfJMouHlNBAgUEmfUY72w0wH8fNUfU8vSO3PNofDsN4EHHqkjLc/MqJ4fNhCw0DkzrMWtsxur0LNAzOOl/hgYmpzXI4BNfDINbgr8oynS9+ZYdAth99ri+STUC3u/2I4GUlu03OR9V4jSgFELDQ+z/ESUR7laccpdUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgH6HZMH; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2363e973db1so28656495ad.0;
        Fri, 13 Jun 2025 08:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749830326; x=1750435126; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QN6pByW5k+1ZTsCPCBrvGzfPYIjlhF9IzLERSPXHg6s=;
        b=KgH6HZMHJPKd7am8AKvo+fR21YSu5m6+D/mbvvdHBi/JJ3+APBUooSsDKpffEyUn3o
         C2ag0K781o16uJRukEeI8WxprkmPevaf3CgsUyGCMfvtmnVNNSBlebvUFHU8iPSIxE+0
         tjEO7MUgt0G4NM2/XMQSQ6hOw8E5ZV70mkS8OYo/oRL7Apzr8nQ6MjX54zGhEfNQyacq
         8eVMNj19Ltgl4lB9Tbkvb+l0JhkYdmHwvTcUKScgPHUGkKYy670GtP2evR02wIdmHh6D
         CwZk7I5lVlHJ3nAcxdVej5LzQJUjpUOTS0W7APn6QASjsD6I+96oK7gcHuGCHFmtf2Tu
         nqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749830326; x=1750435126;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QN6pByW5k+1ZTsCPCBrvGzfPYIjlhF9IzLERSPXHg6s=;
        b=T3v1PViZrLguQIdqxWWC+WCcKAsEXNSoCCn135hx7juUewpijdDhOJr+L4/8+0/a2N
         Q5nzhL4NGrpAv+lo6f3Lt60EZ+QctjaWkHrn7PS5QUf6oSZcx7xXB9bhfFrz3ZZBbSUd
         X5qfstNrdxQ+0B7HOPJQjXJFUbYN7WoNKlzNIxCrmjOSM3mwiIFOxIsVpzq24EsufP7t
         pHN+HXgmOmQGLtGMDcxtglH00CCK7PH7AE/TPjDs1E6MdnsIu2NWMB/LTCDuvJlFOnZl
         QNwYLj8Wz5aF2xUTnotErBY3WkTE1Kw1bmImQ4ejVaaVNzqshPrR/Gdu+90dIA7qvtLq
         dlKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPXd7nFpXcFwl/fUIjsfDCKhCmIc/A1gZXBl3AyPDkAWZfAGD8pE2+14aDoZHSrGEfPFh70cmm@vger.kernel.org, AJvYcCVjW6EkAtFjTCP8tksYfQXlSVXbvO3r/rI/KgNklydjWmxUqmBr5FpsnTW4Dw+cagH3gAPl0Hxewic7C0H/@vger.kernel.org, AJvYcCVzAFVn/OblS2MvsQr9SVq7sTg6YNupoEAVwxDxGcZJprL9cm5PaT6r74n7ruiNBbtWGE3hP7Hd@vger.kernel.org, AJvYcCXTmQCLG53wApwcRgH3hSqJV9poOO6WtoLEu4Y/RZ2LyoPBRUdz3T3CIgRIkSPLA7bPJMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw768hJdx2p/YPzfuhhtCWSZZZc0UULB8TpSYMySB30JDriZgmg
	RISRD5CCok1F1Z7Guhx6TkZba71xH6xaa+YmAlUzufJ/vqc98FlhKOsETx0cTw==
X-Gm-Gg: ASbGnct/LMkD/VuCAMMIqIMKP4SMGDKj5FlJZhnIdv25UKBN7PKrPeOLI7lTkj6TES4
	Oatu2dnkhwixVJSJnUujwz8/jU7HOF91PrYuS3pv2ulw1wHKmkboUvLqeNOwHkF1qfoBVeDmsXs
	cZXWeBu3JpSfuzQGIvGZH3hD8N8kczUIwX/ab1bjmOSyiBu8DrLuAz9c52I4hq4X9RrIbLt8A3D
	FoV/APEFleNUhQ5PYYvRs1yHq7sPINybylFqGT57NGj4Jq/mxHzzyARk+HinyTc8yMqQsG/t31z
	YpIinJ6zWXuMEDCuxXi9HgjZ8yq0sx+kNsBovcLvptinn2C7b/YILvPbU4W1G9+k/UVdxr/HeBE
	6Mq6+DW9GV3dr1gQGoYvM/XwGuFm8/LExSu581LPj
X-Google-Smtp-Source: AGHT+IE49Pb69AIw0IS9/8YqLJ7V6KI3z9sFVxvTeTw1vDhGs4tCHtUAJ+SZdvTjEVwhLWGuNznZpQ==
X-Received: by 2002:a17:903:320b:b0:231:ad5a:fe9c with SMTP id d9443c01a7336-2366ae41407mr2879835ad.15.1749830326267;
        Fri, 13 Jun 2025 08:58:46 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:3762:5a1d:19b5:ad26? ([2001:ee0:4f0e:fb30:3762:5a1d:19b5:ad26])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de78176sm15999775ad.96.2025.06.13.08.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jun 2025 08:58:45 -0700 (PDT)
Message-ID: <9dd17a20-b5b8-4385-9a61-d9647da337a9@gmail.com>
Date: Fri, 13 Jun 2025 22:58:38 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio-net: drop the multi-buffer XDP packet in
 zerocopy
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
References: <20250603150613.83802-1-minhquangbui99@gmail.com>
 <dd087fdf-5d6c-4015-bed3-29760002f859@redhat.com>
 <f6d7610b-abfe-415d-adf8-08ce791e4e72@gmail.com>
 <20250605074810.2b3b2637@kernel.org>
 <f073b150-b2e9-43db-aa61-87eee4755a2f@gmail.com>
 <20250609095824.414cffa1@kernel.org>
 <e2de0cd8-6ee2-4dab-9d41-cfe5e85d796d@gmail.com>
 <20250610133750.7c43e634@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20250610133750.7c43e634@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/11/25 03:37, Jakub Kicinski wrote:
> On Tue, 10 Jun 2025 22:18:32 +0700 Bui Quang Minh wrote:
>>>> Furthermore, we are in the zerocopy so we cannot linearize by
>>>> allocating a large enough buffer to cover the whole frame then copy the
>>>> frame data to it. That's not zerocopy anymore. Also, XDP socket zerocopy
>>>> receive has assumption that the packet it receives must from the umem
>>>> pool. AFAIK, the generic XDP path is for copy mode only.
>>> Generic XDP == do_xdp_generic(), here I think you mean the normal XDP
>>> patch in the virtio driver? If so then no, XDP is very much not
>>> expected to copy each frame before processing.
>> Yes, I mean generic XDP = do_xdp_generic(). I mean that we can linearize
>> the frame if needed (like in netif_skb_check_for_xdp()) in copy mode for
>> XDP socket but not in zerocopy mode.
> Okay, I meant the copies in the driver - virtio calls
> xdp_linearize_page() in a few places, for normal XDP.
>
>>> This is only slightly related to you patch but while we talk about
>>> multi-buf - in the netdev CI the test which sends ping while XDP
>>> multi-buf program is attached is really flaky :(
>>> https://netdev.bots.linux.dev/contest.html?executor=vmksft-drv-hw&test=ping-py.ping-test-xdp-native-mb&ld-cases=1
>> metal-drv-hw means the NETIF is the real NIC, right?
> The "metal" in the name refers to the AWS instance type that hosts
> the runner. The test runs in a VM over virtio, more details:
> https://github.com/linux-netdev/nipa/wiki/Running-driver-tests-on-virtio

I've figured out the problem. When the test fails, in mergeable_xdp_get_buf

         xdp_room = SKB_DATA_ALIGN(XDP_PACKET_HEADROOM +
                       sizeof(struct skb_shared_info));
         if (*len + xdp_room > PAGE_SIZE)
             return NULL;

*len + xdp_room > PAGE_SIZE and NULL is returned, so the packet is 
dropped. This case happens when add_recvbuf_mergeable is called when XDP 
program is not loaded, so it does not reserve space for 
XDP_PACKET_HEADROOM and struct skb_shared_info. But when the vhost uses 
that buffer and send back to virtio-net, XDP program is loaded. The code 
has the assumption that XDP frag cannot exceed PAGE_SIZE which I think 
is not correct anymore. Due to that assumption, when the frame data + 
XDP_PACKET_HEADROOM + sizeof(struct skb_shared_info) > PAGE_SIZE, the 
code does not build xdp_buff but drops the frame. xdp_linearize_page has 
the same assumption. As I don't think the assumption is correct anymore, 
the fix might be allocating a big enough buffer to build xdp_buff.

Thanks,
Quang Minh.


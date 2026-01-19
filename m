Return-Path: <bpf+bounces-79455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA719D3ABA9
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 15:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FC8130A2134
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 14:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3578337A490;
	Mon, 19 Jan 2026 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="k1nj3N+m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA61376BF8
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 14:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832452; cv=none; b=sfLZk4zZAEfffLxTpKx1jGpGmtXAs9MNkOqjXd2+rp3DZv8NrTMJNGFk3TYtL5t3q7tnpqmP95QrbdGabRrkzKzvA6ZEhJsijmetNCWmGpqKTnvl6iIFbreAdH86nPjlIYt4y+UEVaBuGtiXMA2JuGSetgYQRvCl6ZvztT4JC3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832452; c=relaxed/simple;
	bh=SjLVpqnt8fk7vWyU2EsGa/I8aVJJEULwCucQR6RT43M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u9/4o0dC79cGRI0eIqd9/Lx5ll9VHIivV9STV5SE5HKRFBfGlneXNT9KcdgXFVNVS1vysi49+RRcwUTWiy3kNMYp0mWnxwbo794bJJIVnGPSQO/+KlPgU4pPK3CnmPKU78UDaJIwxqP6A07ISuOQGIOwrwVb0Rau8JziI00+5ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=k1nj3N+m; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4801c731d0aso24581255e9.1
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 06:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1768832449; x=1769437249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1koJv5Jon1nq0jP88QFYFGf43MZ4yFVhQZFKEqlvTNE=;
        b=k1nj3N+m0TPlG/ixQP3XQtdiG/xPROfgPrqEjsfG3n9SO3I4VXGKorKkFMrvb4/XMW
         2tEKKGfoMf4wYklHIgLwqcg5EHbUBBx46e5Fa4gludbBmG5xHRgKI8m/CJNfvv25nPQj
         L69QgJSFLuJ9XpfEJ/WvuzKyt803vmfE8o03UHfDfBmDm9xo/QwOLTcDeYNBVqoMtpaP
         IylzmIIKiSWV3+a7bIHwQuZu0VC3n3nNPKX+RHZgHN3PiqOREc4/p8RkXD1VR/pR9rk7
         YUEFQCQWi36MBkV+IIjI1/1KFVhF7zoNuqdMiPULTixEjj5pBON76ZkA+h0VjZAP8sRW
         8Arg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768832449; x=1769437249;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1koJv5Jon1nq0jP88QFYFGf43MZ4yFVhQZFKEqlvTNE=;
        b=r3jPv8NuAKajw5O//t2O0/+rWMF/QV7efLs5HqCM48G3wX8ZrGVLUrwjoi2IrkjpxM
         X9UUmzPSeGnZqv8J7uNWTxGIxNqzDzWixe5WaZoy1DVrIOGRGDYPqS7j5oYqY63GP9QH
         yUQ/iHK4iilaQ/PVMtg1o2uGEz+xrsy95jhh3hO1HNzNB+RLLNhk/33OSofcIVjcdx3v
         kh1H7UcTlOvI4reLXttVEagmt+XV7j6Zg1MGyNPqdXQSv1un49CogkfMFMCa+5DXvyCI
         dSLNxmtYd3tWa5sALL03qxVGUL5kljAIVFZbQgMPDH4Njjkz/4BhUKGDLDjePCAgtC9S
         kWOQ==
X-Gm-Message-State: AOJu0YxP0QgeQTGACxw3KK+7ZmVFUM8VRGni51kTSOakNDAwAPPfnjzS
	NzYHcioMjIsLeR0PeJ8j/y/sU5rS990WLkBrXCbDqjFjtqLVEr9hS67kxthRpvNE0KI=
X-Gm-Gg: AY/fxX5e7yepc/ZT/MHh4T6rFwGKh2rPnfnuqsv2bJeyW1V+jYPV3JOR2VBp7gynXMi
	CCs9ec2JTJKHKTUphCtW4Bm+P95PKh7LJU3Sx9aNi5qvbD/khYrT1O89l95Ew2IayEOjWae8CuM
	+3uZp98RRDNsY1oSkCsH8K65qJmZP1DO/AX9g6cr6WwE2tvN3JeDpvzCe/hiaayz5aMOAi81jdK
	Jo35qEmvaRjWvkXlwMS4wwNVHChPPA2ickyhXPQEKjbmt8ybHhCl9MQ4b+EydqIX/R3LoMGJ1d3
	tjkakXHDW58z3QBm63KvEg/oCYedztjLGj8ahN4Wg5wk1WgbWwN680MdQwywclqDDdYWM/QHNIC
	IkUZhCxt18DDIDNGOWLmEfe0RnA8KhmcLmvpyiVe67MA3/0YJDZi7SAZ7zaGMyNdYmtKOREZlqt
	RG2tHlYo0Zx0y1LNR52f5APbrZzHwGAfZyJzcUzeBGwCPB9cIvBFDV0U6edxIQa6N3wcuMeQ==
X-Received: by 2002:a05:600c:3554:b0:47a:8154:33e3 with SMTP id 5b1f17b1804b1-4801e34cac0mr129291445e9.28.1768832449115;
        Mon, 19 Jan 2026 06:20:49 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f428b954esm250582025e9.7.2026.01.19.06.20.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 06:20:48 -0800 (PST)
Message-ID: <3f9e1db9-71c9-4df4-88c1-4fc54d962682@blackwall.org>
Date: Mon, 19 Jan 2026 16:20:47 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 02/16] net: Implement
 netdev_nl_queue_create_doit
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-3-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260115082603.219152-3-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/01/2026 10:25, Daniel Borkmann wrote:
> Implement netdev_nl_queue_create_doit which creates a new rx queue in a
> virtual netdev and then leases it to a rx queue in a physical netdev.
> 
> Example with ynl client:
> 
>    # ./pyynl/cli.py \
>        --spec ~/netlink/specs/netdev.yaml \
>        --do queue-create \
>        --json '{"ifindex": 8, "type": "rx", "lease": {"ifindex": 4, "queue": {"type": "rx", "id": 15}}}'
>    {'id': 1}
> 
> Note that the netdevice locking order is always from the virtual to
> the physical device.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>   include/net/netdev_queues.h   |  19 ++++-
>   include/net/netdev_rx_queue.h |   9 ++-
>   include/net/xdp_sock_drv.h    |   2 +-
>   net/core/dev.c                |   7 ++
>   net/core/dev.h                |   2 +
>   net/core/netdev-genl.c        | 146 +++++++++++++++++++++++++++++++++-
>   net/core/netdev_queues.c      |  57 +++++++++++++
>   net/core/netdev_rx_queue.c    |  46 ++++++++++-
>   net/xdp/xsk.c                 |   2 +-
>   9 files changed, 278 insertions(+), 12 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>



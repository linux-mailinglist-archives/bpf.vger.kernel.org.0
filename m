Return-Path: <bpf+bounces-71704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C189BBFBA10
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 13:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 55ADF3518F7
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 11:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DAE3346BA;
	Wed, 22 Oct 2025 11:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="L3z7L7HM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2893370F9
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 11:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761132240; cv=none; b=bX05pxYSSoYqSK3S5mk3qdzz5rEo0E7UqSvAK54xzbQwzpL5GM0C2V6e+qufYRbmYq7J/6NGjiiNnrr4P5h+RYRIITJ5zXTfIm9sY6DXDejpTgCtw6IAGqrcHxIkEwIry7lqcyiGIbf27AaInPGlFfSKCRZh5t9rYY+3UBqwoPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761132240; c=relaxed/simple;
	bh=N8BmnloG0Liu8m1fUat9M/14n031gTIHE7qF3n1sd8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m/dVKpEsHo9zJqaU8m0dcZtXQ5UknYVxhVX2G6uU4hCiC/97F+lds+Cg6iBgdXlHkmAXivEAda4xuSCRyLp/Hh9GJvvWUpcEWxxKLKjM/2AsWODme/3sgqynufhYzD911ZszIsvxaRw6NXxi254geZIKNbdQnYgjXO9zsa0Y4Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=L3z7L7HM; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3b27b50090so1248102866b.0
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 04:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1761132237; x=1761737037; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cAAu3r6hLvvmVj2HX3mdxxnwYRVWton/8389KmKNzus=;
        b=L3z7L7HMeVw8sIFe1c8lpiXMSuQHiocT74qtFW/NRCXIN407s79BDKAmVUpIz6dfBQ
         qmk7RaHd+iCj67pQZHZb2HY4SiccfORHkBitg8mycvcFDf6WrUq/h97tWNX2a0G3xBRa
         uSDbzYdDAhmhbmSDJAMNovjBM/ZFX0r6niKtmCRyDybrnfnmEKCgrW4JzOyHvQ6qg46O
         bRarbHmWQXhmGPu2tOLD/ObniUItVqzRPgEl+6cY8wfcNdX8CYVVc9v2l3fBwndKumwq
         BuyLmhZygSI7WkC6EJ8OEY1+vdQ00f2YR0v88SvQmrYGnhIWvA/DtNElsO/ktDNM/A7a
         8n2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761132237; x=1761737037;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cAAu3r6hLvvmVj2HX3mdxxnwYRVWton/8389KmKNzus=;
        b=ngnwCqPcFwEIaHB4raP3vrLxDctl5jUhDPgiKgvOOZvOXiNammc7JnRHVXwR/QuhNb
         VYYu42tXFsk8LPoHgYIvIfyEeI0L90h9VApJG1yNSkNNxMBOtDWOAYOmXAeFnEK4F0+W
         OzkWfEquHIlBPcw1wzwr2wAy6f2I7FE7ywBT9NGyFTAogl3H8P9bBasekIg5Ma6Kv9mN
         DIZVywzW0Ux4d2Y68TIkYS49WlVq8/42GG1jTFwMoWk6Jd/4Yc3WdpYoDftGbcZsYEmd
         tcKmQolV3tT85I9zsiEbxrzEDyswBxMxzwJwZRcDAJE0QQ4B/n7t14QJ5jTv0kRYWN+E
         zUaw==
X-Gm-Message-State: AOJu0YylPb48YaD9AqmXyVyPN25A2UNU6aCLPozMACCRZqgaScP2d2HM
	LRfIKQTbOVAWUQHh70zQdEzbvQd81ovPD54deuROKt6FHnZDXpTNNVotg+t4ZQDNkL0=
X-Gm-Gg: ASbGnctcSvxOHkMh48aBbxzai3XGSMOAmeTno8u6R5e+NGKfLYmCCXyBJA+v8Fj7k95
	vW3udoSdkQ/j4btGHqDOR1llqKB3wEB6Wv+HTwfhchv+JnpDxvVOivIPX7bCtTUSxhP+GKcWMcT
	545OEcrzCdXrPmFj1mmR7c5FXvFuXlqsj8cQfc4S1YH0hOZNSUmnka7/gAEmm8skOanZTdgiIDi
	tY7irvgTJeRkacxw1WkS9I06QNg05yYKv9Uefk7KhLPpUw5Vpuo54RAiRYI16Ag//guk/ipDhcx
	1d6jt4kKBTT2TWqoLsiC0IonGib87qHF4u3hROUtsRlX68Hs7HTbV28dTi+c4EZCdS97KUq0iuw
	ajCxx4ZcY93FM3xaKDQb1bHnXbeJ12waQZcrpgWEDfD9TKXG+DLr2i/AUoj+OFDYzISVbD3TsH2
	HoLWflK5kw0RTdn706G18wdmY7h2eDCWjh
X-Google-Smtp-Source: AGHT+IGy1yjjle6fjE97Lwgq8boy26Ux0Rfpas8YJC9FueCoulD9ANNrqWANmWoQ6Hf7OOi2Hpo4ow==
X-Received: by 2002:a17:907:c11:b0:b3d:9261:ff1b with SMTP id a640c23a62f3a-b6472d5bb36mr2156880366b.5.1761132237361;
        Wed, 22 Oct 2025 04:23:57 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e83914fasm1302205066b.20.2025.10.22.04.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 04:23:56 -0700 (PDT)
Message-ID: <0dd28272-6131-4fe2-aa32-df315a6c4a0f@blackwall.org>
Date: Wed, 22 Oct 2025 14:23:55 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 03/15] net: Add peer info to queue-get
 response
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20251020162355.136118-1-daniel@iogearbox.net>
 <20251020162355.136118-4-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20251020162355.136118-4-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 19:23, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Add a nested peer field to the queue-get response that returns the peered
> ifindex and queue id.
> 
> Example with ynl client:
> 
>   # ip netns exec foo ./pyynl/cli.py \
>       --spec ~/netlink/specs/netdev.yaml \
>       --do queue-get \
>       --json '{"ifindex": 3, "id": 1, "type": "rx"}'
>   {'id': 1, 'ifindex': 3, 'peer': {'id': 15, 'ifindex': 4, 'netns-id': 21}, 'type': 'rx'}
> 
> Note that the caller of netdev_nl_queue_fill_one() holds the netdevice
> lock. For the queue-get we do not lock both devices. When queues get
> {un,}peered, both devices are locked, thus if netdev_rx_queue_peered()
> returns true, the peer pointer points to a valid device. The netns-id
> is fetched via peernet2id_alloc() similarly as done in OVS.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  Documentation/netlink/specs/netdev.yaml | 24 ++++++++++++++++++
>  include/net/netdev_rx_queue.h           |  3 +++
>  include/uapi/linux/netdev.h             | 10 ++++++++
>  net/core/netdev-genl.c                  | 33 +++++++++++++++++++++++--
>  net/core/netdev_rx_queue.c              |  8 ++++++
>  tools/include/uapi/linux/netdev.h       | 10 ++++++++
>  6 files changed, 86 insertions(+), 2 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


Return-Path: <bpf+bounces-55218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E273A7A140
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 12:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14FEF3B750F
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 10:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FF924BBF3;
	Thu,  3 Apr 2025 10:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwN3+68V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D121F4CBA;
	Thu,  3 Apr 2025 10:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743677016; cv=none; b=j2NW4gv1Bx/tFSMeMntu82tiAmamTOb25OB9RgumKlfkMsJzjQoarB6X9G419V2IDGjkcEDbPwatXZUCmLeF85E8Thb4Z9jSp3PI830s1wiW+7jz13hQOaNeeqRF4YRSFhVtayX+vMIQA9sZIpsZXVo8jTrxN34+D+97pb4RvAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743677016; c=relaxed/simple;
	bh=BnDJa1NQQgaQiyi+V0Ba6o9o2I6eOeRoTuZjMFY/ckE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iUzRVXFQf2NilfkQT89ULipLSdjferi3oYEl2vpxcA79QvLDIl7ODN8zqS9Wti528Lbm6DZs2SHN7N0CtNAHEI5Tpmr/tMmq7Qw0VbnFmjBxhirBSzBkvX0U9p/AAPP2fj150ZnaeUFE7pn7APmpm8KcWa3CRTE4xfuIb+fpR9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwN3+68V; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-736b350a22cso585955b3a.1;
        Thu, 03 Apr 2025 03:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743677014; x=1744281814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XKfPpP5X7BAGuDFo2uD9oJkA83aeZkArrNDesmfrThk=;
        b=IwN3+68VtAnEcYhnRXG0Mmoa92k6uJM9FpJEPqoS/bITgyfQWOtk4fxp7CxD6Z2UOg
         qtnm0zUT66QEVrqER8FNiM0GCIYbEJvtJr6aE7yVcvxr+0kF2aTCDYKptgE94EawMAXE
         X8KHUvnmiVBt6ECI1CrMc2ZpNCUaLd/yXQs+advW3P0FUX5dJgENRBKYAof8weF/sF5B
         suoU93xZaoX6wHUNLd6mR+gAXAUylKbQmtGhEDMXWXumPFA+W2yFdXv3nqmSGTsIdkVT
         odhtFmnu/I7pJYSJvHN6r3s2Aj6IF0QTepimLClyKRUKV3x3WdwrAxl2XDYVvpxD1DHT
         zahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743677014; x=1744281814;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XKfPpP5X7BAGuDFo2uD9oJkA83aeZkArrNDesmfrThk=;
        b=Z2iZObPc9jTLHfkrMp97EXy56gC3aibEEsVzW2pTV8zEvtTGMzcwzznqJoNrtLrwSM
         ewfFKsrvTePpxLikcEXwWbKrbqAZQ8XGfu6VayRuj8xJ5YT8OzbSk7UQNNEK6T8xPC7v
         iiE4mL3O3hpx0PRHmYfsewjPbdrnUIziG0b9pjCB58wZfU8XBR5BmxJR1ydMtEvarwr9
         vxGnGqFEvlhlh6vVEVmZJZiIcfoVUb1FS5wP4361Cyps0Kpxa6UclwIZRuDbUL2lLCut
         tL1KvqyyRAqWaL1GoZP+PEWAqVFb1S1HPxmPibu1jWK/MjjTFdcGrBrXXUo+/juWU27T
         Q1sw==
X-Forwarded-Encrypted: i=1; AJvYcCUqB7Uz/SLahjPzd8FBOSAHQjeb1UMZrfweXpwKSDtwlfNc9UzNzyloUFVC9lj2KbJliMBewi0iaGZGysXR@vger.kernel.org, AJvYcCW4T6SxcA9J1oURZbu1qbVrZOfdptTiCUOVBdl9lMmNZeVgwl+vQztBCHvhY2xV2rPqrs0=@vger.kernel.org, AJvYcCWgnOnP66K77iY8bWVhd/ZiHl2eglhUnm7Hmh/XHNVUB/81mXoMi1XoGapY7otPfZSD0Skdrwrs@vger.kernel.org
X-Gm-Message-State: AOJu0YxILkt1DwLZds4oXiT9Oq4qG8N0Pd0HlID2O95JS9nMOieq+Sdo
	1Os+okRdZzzqY1sz5gtTpXTgXiqVHnW1hQ1eEsDLVU31lMkny0L9
X-Gm-Gg: ASbGncuAdaVmrejkWSjkPX5ARAZIUiaFSLuDSv9ilSxR/eGuq2DtbzFcbItnqCube/6
	wvUY2cVslREZ3k5EqxXvui3MB4bimjrxAxdHTmDV1W3botOktjaIIhVLq0eDvasd6U5kWGf6JR3
	AB9CtcOprkp+MdOLtMmRXbDL+D60RgtHnZlGTi2FyD8+fkiaRbIbJb5TnTYrqqTcdY+W+vUcygL
	yk2QQMn1zak/cH6648K8kwZw5y5PyZqvrgPg0A1Wa37gJ91ujcADX9SsBtpltTD/RyNd7vkz58m
	rpziL/reBoBVoWrZJgAnWadr8t9uwr0GpdUSodL9OSyfP4BERX2DoyyhD1PiuwayCHND9TIbDH5
	2JlKTLLii8oLVmzi5Wba6Auw=
X-Google-Smtp-Source: AGHT+IHkcCi0YR0D+hOGCuMNoTiX/WY5jnF7Ek8IM7ApPidPGWeW9JEmR3voupoks8wnoR3rCxGzhw==
X-Received: by 2002:a05:6a00:399d:b0:736:53bc:f1ab with SMTP id d2e1a72fcca58-739d9e96e15mr2649550b3a.12.1743677014350;
        Thu, 03 Apr 2025 03:43:34 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f4e:bd30:2142:e08e:e207:d31c? ([2001:ee0:4f4e:bd30:2142:e08e:e207:d31c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d9805a00sm1144603b3a.81.2025.04.03.03.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 03:43:33 -0700 (PDT)
Message-ID: <8aad5ff9-6eab-411d-9569-9a2303561ac0@gmail.com>
Date: Thu, 3 Apr 2025 17:43:26 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-net: disable delayed refill when setting up xdp
To: virtualization@lists.linux.dev
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250402054210.67623-1-minhquangbui99@gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20250402054210.67623-1-minhquangbui99@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/2/25 12:42, Bui Quang Minh wrote:
> When setting up XDP for a running interface, we call napi_disable() on
> the receive queue's napi. In delayed refill_work, it also calls
> napi_disable() on the receive queue's napi. This can leads to deadlock
> when napi_disable() is called on an already disabled napi. This commit
> fixes this by disabling future and cancelling all inflight delayed
> refill works before calling napi_disabled() in virtnet_xdp_set.
>
> Fixes: 4941d472bf95 ("virtio-net: do not reset during XDP set")
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>   drivers/net/virtio_net.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7e4617216a4b..33406d59efe2 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -5956,6 +5956,15 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>   	if (!prog && !old_prog)
>   		return 0;
>   
> +	/*
> +	 * Make sure refill_work does not run concurrently to
> +	 * avoid napi_disable race which leads to deadlock.
> +	 */
> +	if (netif_running(dev)) {
> +		disable_delayed_refill(vi);
> +		cancel_delayed_work_sync(&vi->refill);
> +	}
> +
>   	if (prog)
>   		bpf_prog_add(prog, vi->max_queue_pairs - 1);
>   
> @@ -6004,6 +6013,8 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>   			virtnet_napi_tx_enable(&vi->sq[i]);
>   		}
>   	}
> +	if (netif_running(dev))
> +		enable_delayed_refill(vi);
While doing some testing, it look likes that we must call try_fill_recv 
to resume the rx path. I'll do more testing and send a new v2 patch.
>   
>   	return 0;
>   
> @@ -6019,6 +6030,7 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>   			virtnet_napi_enable(&vi->rq[i]);
>   			virtnet_napi_tx_enable(&vi->sq[i]);
>   		}
> +		enable_delayed_refill(vi);
>   	}
>   	if (prog)
>   		bpf_prog_sub(prog, vi->max_queue_pairs - 1);




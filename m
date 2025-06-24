Return-Path: <bpf+bounces-61362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E05EAE6211
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 12:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EA924C15F6
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 10:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25A1284685;
	Tue, 24 Jun 2025 10:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OrI5DA8H"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22D61ACEDA
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 10:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750760281; cv=none; b=SZTHbl/FTUj7yTmbUnIMKjUhS8OPyswFPPXXh7ie3JgdpKsMbeaQpa3iacuEQ30RZKV2iFuB+fCoJOfOgMyqX3J9A9G6QvsRtS0L6tog4Kr7pkinvSyOLLP0fzOfikR+Q341niMiWPvygHHaHyWZ3I2k7g9CmKajctc+B0FBoe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750760281; c=relaxed/simple;
	bh=yxsot7li7aWDbMpJ2M7l364+PdHRsIkunx/znJIFHqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L08W8nNgA6D82qqVWJDXcSXu3gG5l8cE96NUlA2vBUw5LEorXDnCC6tJ/J5ygkYLyiqvJFbwAvvgDTP9MuKXqTe+fSXYM3aGhpN4qkb9h7JjooJpaRT4mJmg/iMDjsJ5Dw+a47oThLbVCb9pzh4tH6qDegRiDWupFLlnr1hQcZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OrI5DA8H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750760278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Ln5HyZtk161hcYqwhzfMAZcN7gULO9uaQ38rDIrK1c=;
	b=OrI5DA8HTTgU616DVfh8LjHprq3PBVscNX2h0uz39bJ7fpMPMnsAwSFooGpn81NEXqmJZs
	MOtPkpGwVmO+370np92LOyG5VRc4MJhFq1XDy8IqYjx6lHjZTUNgo7IBr+klvtQ6vAh29W
	sKQJrAePY70O3Uldt7FQjvLJuTm+4gQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-2OmWgMYMNo-fMS9QM0ZOcg-1; Tue, 24 Jun 2025 06:17:57 -0400
X-MC-Unique: 2OmWgMYMNo-fMS9QM0ZOcg-1
X-Mimecast-MFC-AGG-ID: 2OmWgMYMNo-fMS9QM0ZOcg_1750760276
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a578958000so1888292f8f.3
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 03:17:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750760276; x=1751365076;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ln5HyZtk161hcYqwhzfMAZcN7gULO9uaQ38rDIrK1c=;
        b=pAT4fhUoFg5WvjCjV8+HMcrvvEJGvrkGYIlBDsOWjM3ChJNXN/JLwUX4dX0WJT5CR+
         CIBEDtPsa79BK5+P9nX9Abmi3WLRdsp31Gui5WPQ890LwGfxGFhjASaiQoqkTmxyAjVu
         ZtBVUzGW5MeCHSUV7oIwELh3C7inFrOuiY6G68bXfAIquE7XQGeR7uZsAvVeOfnAQ09j
         gPLMOM2jVMU/29CVN0egqegm8gYmisUAra9w5BXakrNGzGd0z5wklNrfJUMxxY/2qCgD
         uaJ+ImKL3cH9Ub6dy37f6JpHABCeuliBUB27DvntRbmktZj3/EPOUx1pzQvhQcf2m6/8
         W5iA==
X-Forwarded-Encrypted: i=1; AJvYcCW346FyxS7rM8c0GQOYX3ZtvNDbKuLifv2YabLlAiCAFwNdTkieKeOEiAUIUDWPmgCXQ6g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq1LI/hCU569zWEeODq8gxrFUjkeaYSw7T5ZxlhsNNFIvr/kj9
	+dxIcJ2IJCSg3Czy7/3R2IYXbI8AaU69gGZkO9NrK+7wNukUyr9FMt3c/uOedKKYLGuBWYqwPsy
	2/4vKm+G/Um6hemnvzLKdtCbofGDrdQDudQ7VY1WwsxjIjfjke70Vkg==
X-Gm-Gg: ASbGncsyJ8nxPiQUfKYuSuXlE6t/KCnZhGosUkMl8NrQ4OuI8ZNnW3hSzazzw7l/pXB
	shzNtJlJ9KgkrAKJNVd+yQEy1Ds6r+Ygqf2Ij82bcbQX6oZTlljGZiSE7Ps+49xN2jc3xEgjMST
	eEUAMICI8poMvBu2fr+rc+EodHo2oPZx1Fp09bjJ7PTB5IXFU6HXOT90CVZ7mmQ1U6o3VZVXw8Y
	Y2aIBWvVoEbktTBokrri4lzF2Ygi9asvE5Bg5lMOsEb6ANvHqVGbo0bMR8JTSuort9+COtNG40s
	J6WSTVRds0QhS9Gjo2rPdzq9smlWAg==
X-Received: by 2002:a05:6000:2008:b0:3a4:f902:3872 with SMTP id ffacd0b85a97d-3a6d129da9fmr11398666f8f.19.1750760275756;
        Tue, 24 Jun 2025 03:17:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC4ngUxIcnD6ERbm/m/k7RkxkipdZ9Ie1YqBmuu6Vuw2RA4r/70TZrgIw6mV8PBPv7d8OamQ==
X-Received: by 2002:a05:6000:2008:b0:3a4:f902:3872 with SMTP id ffacd0b85a97d-3a6d129da9fmr11398635f8f.19.1750760275245;
        Tue, 24 Jun 2025 03:17:55 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2445:d510::f39? ([2a0d:3344:2445:d510::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535e97adf3sm169365045e9.8.2025.06.24.03.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 03:17:54 -0700 (PDT)
Message-ID: <e6654755-3aa1-4f4b-a6ab-c7568d8a5d4e@redhat.com>
Date: Tue, 24 Jun 2025 12:17:53 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] virtio-net: xsk: rx: move the xdp->data
 adjustment to buf_to_xdp()
To: Bui Quang Minh <minhquangbui99@gmail.com>, netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250621144952.32469-1-minhquangbui99@gmail.com>
 <20250621144952.32469-3-minhquangbui99@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250621144952.32469-3-minhquangbui99@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/21/25 4:49 PM, Bui Quang Minh wrote:
> This commit does not do any functional changes. It moves xdp->data
> adjustment for buffer other than first buffer to buf_to_xdp() helper so
> that the xdp_buff adjustment does not scatter over different functions.
> 
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 1eb237cd5d0b..4e942ea1bfa3 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1159,7 +1159,19 @@ static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
>  		return NULL;
>  	}
>  
> -	xsk_buff_set_size(xdp, len);
> +	if (first_buf) {
> +		xsk_buff_set_size(xdp, len);
> +	} else {
> +		/* This is the same as xsk_buff_set_size but with the adjusted
> +		 * xdp->data.
> +		 */
> +		xdp->data = xdp->data_hard_start + XDP_PACKET_HEADROOM;
> +		xdp->data -= vi->hdr_len;
> +		xdp->data_meta = xdp->data;
> +		xdp->data_end = xdp->data + len;
> +		xdp->flags = 0;
> +	}
> +
>  	xsk_buff_dma_sync_for_cpu(xdp);
>  
>  	return xdp;
> @@ -1284,7 +1296,7 @@ static int xsk_append_merge_buffer(struct virtnet_info *vi,
>  			goto err;
>  		}
>  
> -		memcpy(buf, xdp->data - vi->hdr_len, len);
> +		memcpy(buf, xdp->data, len);
>  
>  		xsk_buff_free(xdp);
>  

I'm unsure if this change is in the right direction because it almost
open-code the existing xsk_buff_set_size() helper - any changes there
should be reflected here, too.

Also AFAICS xdp->data will now carry a different value, and I guess such
change is user-visible from the attached xdp program. The commit message
should at least mentions such fact.

Thanks,

Paolo



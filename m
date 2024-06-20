Return-Path: <bpf+bounces-32583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9CF9101E4
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 12:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3803A1C21837
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 10:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70621AB8FF;
	Thu, 20 Jun 2024 10:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GOt/rE1k"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AC71AB8F1
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 10:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718880391; cv=none; b=tKTo6HBAAT75aYHT4QwWT1rp/0sVRNkrd0pn2k9HRrQ6iM28P9Lt5YJZ0FoMhiSd3M4rybjvD0JIowrmF96ddKJQJVUKfJbK0Y+NPeSaUsW3xIjW2gkE/4jRS69UJ+HOoKBF7wXTJHso/cGgkehYznWdNs0XkhjgzArBu/AMheg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718880391; c=relaxed/simple;
	bh=1MKi6pqON4noBtSa/+vZx4Vwkat8miqqSSJV1BsMeAE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rirWzGSQ9ARNKCFFOPR9Rz3a9s/DsdL+0QMXYZwWlVCVJiQ6G3OZhM2E3Yx5xpGUKRtaWYZdYB7IEFL75ezAab7L/aIQO3cvxaCK1A2jUR6so/ZRf1A1x58pgYql6/VcgcVEPQsIrpOVsNHkq1iNEPHRxH8BP5ypbCtLiuNsCLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GOt/rE1k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718880389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hyKDOuZKlo9qA1q7MCjg8nMzbWwvDftmXmKUuebooBY=;
	b=GOt/rE1khhBD+cj6wTDnpJU7+inv02MhNlEadrqoBVPWsly1ExJhdtQQd4jgrWW7N5HSax
	dQP75/OeIrPkq/gfvKlDOYPct+0hpdf1cx/dS+ye90BJ4LcoMDvfLSTdOiK6drfWz9jot6
	sMFpqDIKwpnjhkzL3AEHCjmtwdkQJIk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-Gz5ostqBPXuBxdIWshxo-g-1; Thu, 20 Jun 2024 06:46:27 -0400
X-MC-Unique: Gz5ostqBPXuBxdIWshxo-g-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4217f4b7355so1268975e9.3
        for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 03:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718880386; x=1719485186;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hyKDOuZKlo9qA1q7MCjg8nMzbWwvDftmXmKUuebooBY=;
        b=i1BtWRSSi2LriofJfQHuvJYwXooroC9I/qwLkbrtiJ4jxVw3N77hMwaeQmCrD6Gag3
         Hr6/nO/d63oS9XNHG7acsqy/aBeF5AA1huH+ks+sp32W1tXZ5z+wCA6K8QEgBy1LGJWk
         3yLpejZLaexLk5mk8b7XKQg/8tooFtqnnbQ5nx3y+VkjQ1KAW2Z90LlYPKizSOsxXa1I
         wZnwxl4L+Kqkk1qV6l33cemNLx82CFCfTv3ZkswBuQxbsrWiyfjJYMNRET8rZZFGoMMC
         9pAAFgMxhAB6cLHydQV9cxs0uSq7jQsR3zjR/OQQ975pu+Ywn14o/fcn9+VuRZDwrbkX
         rsYA==
X-Forwarded-Encrypted: i=1; AJvYcCXUgmjM6BTn04s6M3yZNXXm5jPa2dx5hvdp/nQHLtYWKd+C3jwltoc3DBP0T8S5S4sZzZiKKDat46keC1ZrYoGmlxuR
X-Gm-Message-State: AOJu0YyKxlRitTsqOOW3TeKEVthHGOIB5iDNhxoUGeBiS9D8dNPttuyv
	YGdRz9ZgcAt+/ivUCYQ0iFm60YclCYnlfwYIoYUciAF+gzyb1j5ZxG+UaYtQqaIProZUKGRksbX
	6z4MEb8TKvGyGHoaM53KFEFAsMVMMo73IDh9811ZbkULX2skkaA==
X-Received: by 2002:a05:600c:5125:b0:422:78c:82f9 with SMTP id 5b1f17b1804b1-4247529bba1mr34106955e9.3.1718880386424;
        Thu, 20 Jun 2024 03:46:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEp0W4aG0Ml3cUXixrRkYQNOtJoc6lxcXOLd5GLpUUmvSxX6TYTAw6JZWZZRagJcnAY5F28g==
X-Received: by 2002:a05:600c:5125:b0:422:78c:82f9 with SMTP id 5b1f17b1804b1-4247529bba1mr34106725e9.3.1718880386011;
        Thu, 20 Jun 2024 03:46:26 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b0b7:b110::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0c5485sm21327575e9.21.2024.06.20.03.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 03:46:25 -0700 (PDT)
Message-ID: <38db3facdfefbefecd367ccce2e9b094d0b0314d.camel@redhat.com>
Subject: Re: [PATCH net-next v6 10/10] virtio_net: xsk: rx: free the unused
 xsk buffer
From: Paolo Abeni <pabeni@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
  Eugenio =?ISO-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>,  virtualization@lists.linux.dev,
 bpf@vger.kernel.org
Date: Thu, 20 Jun 2024 12:46:24 +0200
In-Reply-To: <20240618075643.24867-11-xuanzhuo@linux.alibaba.com>
References: <20240618075643.24867-1-xuanzhuo@linux.alibaba.com>
	 <20240618075643.24867-11-xuanzhuo@linux.alibaba.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-18 at 15:56 +0800, Xuan Zhuo wrote:
> Release the xsk buffer, when the queue is releasing or the queue is
> resizing.
>=20
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index cfa106aa8039..33695b86bd99 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -967,6 +967,11 @@ static void virtnet_rq_unmap_free_buf(struct virtque=
ue *vq, void *buf)
> =20
>  	rq =3D &vi->rq[i];
> =20
> +	if (rq->xsk.pool) {
> +		xsk_buff_free((struct xdp_buff *)buf);
> +		return;
> +	}
> +
>  	if (!vi->big_packets || vi->mergeable_rx_bufs)
>  		virtnet_rq_unmap(rq, buf, 0);


I'm under the impression this should be squashed in a previous patch,
likely "virtio_net: xsk: bind/unbind xsk for rx"

Thanks,

Paolo



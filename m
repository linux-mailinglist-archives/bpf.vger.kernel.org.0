Return-Path: <bpf+bounces-32578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F1B910157
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 12:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FB651C21360
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 10:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E731AAE0C;
	Thu, 20 Jun 2024 10:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQl/yvqn"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179331A8C28
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 10:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718878853; cv=none; b=pkn5jGJuymC26upju+7D1JXn1L0wCiy7xfWpnj+u/RBPLAXdlM1wOS1KPznfu/Htmy2Kt3qoe83PLzUQyf9FWhHMyTaGmOxU5iMiOaVdN2oiUYqhnXf72kKa1jOPsZP/H6WNNVD/MwyfAvR/0QfgSRhp6i9lalWBA3g/F81YkOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718878853; c=relaxed/simple;
	bh=yHiNLBf2HaTYaG+JKche1uFg/Nl1mBxro+Ev0gfNwNg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OzGyEDzxY2Xj+a+Q4yXnTkNNa3vs1cl8L2JvvyiJHSDlhdoF+bOaPpdORCoNZq13ziCvYkGMToOUTmZZ0Q3fSC4cFKqNrShexfL64GBbzMw9Uo94fYKEE6ObQgG0i5pF9GqPx787UpELXoX0Zpu3DuLWXCnAz/5pyN7MBDqShJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QQl/yvqn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718878851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=doeZzZgMg0C1MhSn62H08XIInC3nAwcvpGw3Aktx0Zk=;
	b=QQl/yvqn/h1h+69Lyl2VlgO4j4qApkfSUy1a7Nl6di1flon9N+VYPIE11RFCDBS6FU6yMP
	0izWbTyDNqyBUrk7YaZqrKunWIO5uOb+lzvuIam9ZAMsYvwjLcI1Ro0lIGT+kbURFvlsVj
	MIC3V7vRYdcpr3cBtMHZxPOs5MgXIa4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-XomyCFURN6mFekWn6r0e4Q-1; Thu, 20 Jun 2024 06:20:48 -0400
X-MC-Unique: XomyCFURN6mFekWn6r0e4Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-421920de031so1265845e9.0
        for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 03:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718878847; x=1719483647;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=doeZzZgMg0C1MhSn62H08XIInC3nAwcvpGw3Aktx0Zk=;
        b=QSLiaFpgMEyH0DN6KgZAwBi+9RNKehRWBhNU9XkXeTkKzQ8RATnDWOl5nctIA8bwXj
         Aj2bqlG3vxR7HFpH5aZXdVFWHjGwB3EFJfE+G2KLwCyQIkXz9Tt6qpVOu9yyNJUdG+G9
         3mI3nMkqbpi+jNqv7mMa9cMgB/rNWYP5BS34qZIfUcnZtnHG0fpdh0dKhK/1KQd84jVs
         D2fPCTeO/7UgXo7ylxo4dEbqiugSC6+iNc/399akzp2tzkjk9sBQGDe7c/rK3qQwdhJ/
         ijGJE8bkhkVrID+1CYya6Ld921Wud91IwK+WATCxuJYN/HD9qQtPrm5bvXeHN9gXM/uA
         squA==
X-Forwarded-Encrypted: i=1; AJvYcCWCsYyLqcSPCknd5C05N9coGSiFZuVO+wRa38jCqZnJ0yXH3dQTr7Tjwc7EN8bmuUtCnAIw1Ctq50Qe2H5v3sqehz8E
X-Gm-Message-State: AOJu0Ywc3kHG79U+97fWHLc3el2rUh+uRcSUIfXfopOVxsifacOjTEKr
	rCMRqShJUgJ5j8WnCHRM6oBq4flNI8FQA6PP/okgQf2cF8peVR++47Rz2VPhxr0KsSvZ8DbYtYw
	YUTkiDqOKSXH7vYPjxCGdjt1ttWpEni9YIAfHlHBKRRF47ngqIw==
X-Received: by 2002:a05:600c:511d:b0:423:445:4aad with SMTP id 5b1f17b1804b1-42475016e88mr35681455e9.0.1718878846930;
        Thu, 20 Jun 2024 03:20:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFV4/Rcl9kCDoWNGsxPLqkw/FELky+0wJBIrIbAGOmhEFKuOljMvUlHhojAQKG12CMNKPEYRw==
X-Received: by 2002:a05:600c:511d:b0:423:445:4aad with SMTP id 5b1f17b1804b1-42475016e88mr35681245e9.0.1718878846575;
        Thu, 20 Jun 2024 03:20:46 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b0b7:b110::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d208e08sm20779235e9.35.2024.06.20.03.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 03:20:46 -0700 (PDT)
Message-ID: <3554649e61063491cc3a04222c7dff68d46c2f99.camel@redhat.com>
Subject: Re: [PATCH net-next v6 07/10] virtio_net: xsk: rx: support fill
 with xsk buffer
From: Paolo Abeni <pabeni@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
  Eugenio =?ISO-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>,  virtualization@lists.linux.dev,
 bpf@vger.kernel.org
Date: Thu, 20 Jun 2024 12:20:44 +0200
In-Reply-To: <20240618075643.24867-8-xuanzhuo@linux.alibaba.com>
References: <20240618075643.24867-1-xuanzhuo@linux.alibaba.com>
	 <20240618075643.24867-8-xuanzhuo@linux.alibaba.com>
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

Hi,

On Tue, 2024-06-18 at 15:56 +0800, Xuan Zhuo wrote:
> @@ -1032,6 +1034,53 @@ static void check_sq_full_and_disable(struct virtn=
et_info *vi,
>  	}
>  }
> =20
> +static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len=
)
> +{
> +	sg->dma_address =3D addr;
> +	sg->length =3D len;
> +}
> +
> +static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct recei=
ve_queue *rq,
> +				   struct xsk_buff_pool *pool, gfp_t gfp)
> +{
> +	struct xdp_buff **xsk_buffs;
> +	dma_addr_t addr;
> +	u32 len, i;
> +	int err =3D 0;

Minor nit: the reverse xmas tree order is based on the full line len,
should be:
	int err =3D 0;
	u32 len, i;

[...]
> @@ -2226,6 +2281,7 @@ static bool try_fill_recv(struct virtnet_info *vi, =
struct receive_queue *rq,
>  		u64_stats_update_end_irqrestore(&rq->stats.syncp, flags);
>  	}
> =20
> +	oom =3D err =3D=3D -ENOMEM;
>  	return !oom;

Minor nit: 'oom' is used only in the above to lines. You could drop
such variable and just:
	return err !=3D -ENOMEM;

Please _do not_ repost just for the above, but please include such
changes if you should repost for other reasons.

Also try to include a detailed changelog in each patch after the tag
area and a '---' separator, it will simplify the review process.

Thanks,

Paolo



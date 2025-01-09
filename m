Return-Path: <bpf+bounces-48396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 943F8A07912
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 15:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6DC43A0579
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 14:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53B821A447;
	Thu,  9 Jan 2025 14:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXifWnlF"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF186219EA5
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736432664; cv=none; b=AH6RkF9XTBeWePQVXSJnS7odBacrcQExTa6SEMp68JRpGUIjlJoQmOqXWXqorV6TP8BFA/n+avj8qYyIs3b+9VKcuuOdgP+bLTg0L3TVT+VYVlCuuvIvxS8PxTGjw7hcR1cceh9rX28Osp9obBi/6mRkFxrJMAxuhOLhK0l19Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736432664; c=relaxed/simple;
	bh=BsBmAgBcFrV1F7gJtGOm76TOesx/AwJFuyx0ecANoW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W6jV9O0eyQGJ5T1UqphBO08vQ/GFvhdyWv9Dvq8yQ4I+6PP0EsCSQq0t9ygX8ivFjkXGUjtSLxdY4geIKZsyf37SApQcGHKBNIt6lVxJajME8DmO+ehRkgMWJ0gFCFAKUxTx+r3kxECxPD1SRWRpSdHY2hsUFkSVQ1/v6i/2joQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VXifWnlF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736432661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pPqqR/zrDDptX7kSZzx5HpX81ITM6fqj1FdNU937MfI=;
	b=VXifWnlF4OLkKti/EhhA4UvsV/cAJ2GsjZIcUUQUeEa5ZI98/jtpNfBh/Zz6dgfgSSeNb1
	BMnN9E1jzzGA7QgUB5zhvad8OYNrIkwRnvwRfLwa/S1uI7pdEStxsVyQ0hdem/7SyzWJYh
	gu0a+h/JwhysyegneHW5ar+Qys2t+ZA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-1kWkrK80PfqPCrmC2IYqrA-1; Thu, 09 Jan 2025 09:24:20 -0500
X-MC-Unique: 1kWkrK80PfqPCrmC2IYqrA-1
X-Mimecast-MFC-AGG-ID: 1kWkrK80PfqPCrmC2IYqrA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4361d4e8359so8503645e9.3
        for <bpf@vger.kernel.org>; Thu, 09 Jan 2025 06:24:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736432659; x=1737037459;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pPqqR/zrDDptX7kSZzx5HpX81ITM6fqj1FdNU937MfI=;
        b=PeRI6Oq7hG24HyvieGGQx1EGwBilLZGZ6xVnlv0D8KeIzeHR49/SuwMy30NAnRgFMY
         VDUGF3RpHOZCCVIVyUpsFLYDhnF4L1ApaeRjYAnaP7HuwJqMI3Bob5Td1O0mZL0QLN4I
         olc3DauCdBIqqD7wMwpiCXyVHLNt5Sxy3xCwO7sKeGZswxu6JgDagQVXP6rmMXQeviEM
         Eo4xd/YsPB4YuC7TeYxF79Pu9pVfZJGnYejk+Jjp/ksBI3VcaooY2f9Vw71wdF3Qp2Cy
         zjf/Ga+5f3v6KbR0ZVs2J3Ay3YydX0qHcOkewdNMzPXQcW+zTgIznoM+PRA7OoQYyrz5
         v0/g==
X-Forwarded-Encrypted: i=1; AJvYcCWORjVMlNOLnnvVvTowTJnhxjLTvfuMCThZ+OBi2PwPEqyBCxaVy0yTreEd92Neq/1QiBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Zqw2HHqbLIKhv3PFtdW9qF5LH+4AkDOopUiFDEPlOzK3e5vU
	qJ9HlKb+eiO2bQaYbJK83c6It6Jzxq3ZfplmdU1kvDscKDiOkCYFwmVztCvPXoJbeTrb20yWN7v
	HbrRvJAeL0s+4xUOMsIzRYa+LWF9c3Jj0r3chvSGNQnltFl/1xw==
X-Gm-Gg: ASbGnctaiCQ4vvoTTlWjuvj+Rr4Gsw4bh9R4e+TKgoiQkfZ72DBTpHS72eKulwhwQjT
	3l7xWF1V4Fqah5PRnvXG7yFXPMHcWclYDXBrw7d/e1U0ekbPqqsCdlNZaIb0tBSH+i6FoWB1dQL
	NovNmD2f2Y0ggYHqtOW2hQJz1w82F5ZJoRjGVRlVwVZYj6ipO0opV2ZQ62T/G7ZLQFmUmReQarT
	wRD+EJmmcLVfU7lNPQ90pMVhzyl/uJTQxRuGPHYgUVzDgFfDg4CEdychU9oLOo93Ub5+BWjyTWj
	lExqQPL3
X-Received: by 2002:a05:600c:5ca:b0:436:ed38:5c7f with SMTP id 5b1f17b1804b1-436ed385da5mr12957835e9.12.1736432659221;
        Thu, 09 Jan 2025 06:24:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHj2gONdsOaPhPeatt8x1sJkwEGpoKEyq3qgNjTYRdLaHAyc2JgMZwwYoSXDwup/atZgnClrw==
X-Received: by 2002:a05:600c:5ca:b0:436:ed38:5c7f with SMTP id 5b1f17b1804b1-436ed385da5mr12957535e9.12.1736432658844;
        Thu, 09 Jan 2025 06:24:18 -0800 (PST)
Received: from [192.168.88.253] (146-241-2-244.dyn.eolo.it. [146.241.2.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9dc895esm22430345e9.13.2025.01.09.06.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 06:24:18 -0800 (PST)
Message-ID: <4669c0e0-9ba3-4215-a937-efaad3f71754@redhat.com>
Date: Thu, 9 Jan 2025 15:24:16 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/8] net: gro: decouple GRO from the NAPI
 layer
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250107152940.26530-1-aleksander.lobakin@intel.com>
 <20250107152940.26530-2-aleksander.lobakin@intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250107152940.26530-2-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/25 4:29 PM, Alexander Lobakin wrote:
> @@ -623,21 +622,21 @@ static gro_result_t napi_skb_finish(struct napi_struct *napi,
>  	return ret;
>  }
>  
> -gro_result_t napi_gro_receive(struct napi_struct *napi, struct sk_buff *skb)
> +gro_result_t gro_receive_skb(struct gro_node *gro, struct sk_buff *skb)
>  {
>  	gro_result_t ret;
>  
> -	skb_mark_napi_id(skb, napi);
> +	__skb_mark_napi_id(skb, gro->napi_id);

Is this the only place where gro->napi_id is needed? If so, what about
moving skb_mark_napi_id() in napi_gro_receive() and remove such field?

/P



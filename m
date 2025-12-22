Return-Path: <bpf+bounces-77288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4B4CD5E7C
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 13:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2A7F30433FE
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 11:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E2C316909;
	Mon, 22 Dec 2025 11:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CYaLTHIV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xf6lSbHc"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC88306D2A
	for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 11:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766404689; cv=none; b=UOUl+Bs05ZwG/h0u2QvHP9KMzvRS0Q+ipuKiJt6O1esqHbbOX5KHiZttpOFT5Kyhf30V0n8Av9JMWm+G9buPJadL9n0w4lex4bOyuzt+URTiW7GfLqvPcFuUT/d+kPmaxEm7ksm8AaE7fQ30F18qnmeG2YJ1teHvO+5Ve9p2dzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766404689; c=relaxed/simple;
	bh=Y6ymdBuHFXIFtcbNCFI8HRsRKRMfhKrlCr8RRBNi/EA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bHUrTHTHi5S/jPaNbxP9wGbE3yVOFcSh3GUyqdmHna9rTLOJqi9Tp/TL0B436e+xvtxfOO7f6whk7590gsWTOSBk/Bb7q5WgcOLp6WQjJyDL4yWob5p8qd9r6O7d2U2OvKZbpLQy897rjdnGDk6dsqprmePy5KR+WbWZRWoiF8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CYaLTHIV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xf6lSbHc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766404686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Utvi1mro76oUopcgneS5kZCr+uX6+hRQVjhQCjl3EU=;
	b=CYaLTHIV8LQfge9t21aIxBhEAN3yW1WAZHiiVHy6suK1KQR6qNnthKj6Vv5zCDqS3QPbHy
	dX4RzWFwdA4YKCNcrOBhAX39ogm9B09RtBTDxXaxzQnr4IVzfH674NOOylH3BpmnvRz2ox
	h9OEvbtT5Yw/NKHBppWmAKtIOO7a78w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-F1hoi91tNOOJrg0vB45_ZQ-1; Mon, 22 Dec 2025 06:58:05 -0500
X-MC-Unique: F1hoi91tNOOJrg0vB45_ZQ-1
X-Mimecast-MFC-AGG-ID: F1hoi91tNOOJrg0vB45_ZQ_1766404684
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477c49f273fso51717725e9.3
        for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 03:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766404684; x=1767009484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Utvi1mro76oUopcgneS5kZCr+uX6+hRQVjhQCjl3EU=;
        b=Xf6lSbHcqs8PwhcR1lyLwqwMf/d6Z07bHbnL9X2uvUwxbRHYueNypM97DgKrUnv7j8
         PDSohSNnP4IuUcel5KtSPUfR/38vgqKHmI4vml5s3lLOU2qlD7J7yCApm21ucwXtzXFd
         ehY1NCJt12R9Ns3HnLHWqNjsOpxQvsG8UNCTfs44zcMAIJf8JmpxW/LoMs4AZGEe1LP4
         W0w/4xjM3HqQ28sASnhXzc1XUEtaWlwqnFA50Tz7Bb4pA3VifgJGSRI2WOU3tMu6I4ol
         Y+DDudotp+7LXM1Oz5sfEkD9dEp1q1q4XZjWXovZF18l185Aea5mhiQilqVKE2u6uUyx
         uY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766404684; x=1767009484;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Utvi1mro76oUopcgneS5kZCr+uX6+hRQVjhQCjl3EU=;
        b=TbUOAK6xUB6qn7M/6v3szxbzTtYGfNH2z8rw8MTetRRCzExBwKvvt8es7cKlb7so7o
         xjNSSLxzWbu68munjYVhfH6ZM+cxAegv1tYKiKg4x+2o0NKcveCUBZ5D0KVDMIAMTaub
         So6nG+4f5WIguj/omitnD9jbY49Lv6qYgALKjAoWKKnsGfM1ovtBVudWQnuyUQmyvNrk
         d+OCAXQR3B+zk0rZLurJtS7rMKcd2EqCctYgo1907iCiGs3V8bvWBi5Ua8LzxLZlrCtc
         Q8ZXtUa4qgcyoaaPf+5amqrsGKZ2ycun5sUUuG3L3UPpNDYbUGJyYLJqEC6UCfGye/7k
         6jzw==
X-Forwarded-Encrypted: i=1; AJvYcCVt16LyiCRnN37n13qmrfJWBNSTzzV3TupiiiGLRAqmnJiASeU7zjDDggRchhLq6gk73t0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Xb54fj0d/zxuSLlK4pfGATzohQqGOzse6KI0j+tKry2lUPfC
	7vLEmu3i+TnjhUMC7UFpr21BwfBeedl1ML1n93O2jLqqZIbdmWVSN9hNfPO0yu0ypSzhS7JqIMr
	Jd1LJZ4InGJKQI+iKJidhulbUW2dLDx5kiU1FT/2NXccr/MctPe7AkA==
X-Gm-Gg: AY/fxX7Jljj7QnxZJaUFzWwLBtZBhG9AVtYKkazPlp2MKtEEKh3YBLKdrUXve4kmONn
	AnFR3sT2Zt/ZLgWOA5yYlEU7LUQwL4+sqBZ+TkgudRtcqiYw/SclrU7c6O3tVVLK5YYV31FQOjm
	WcDr/GHTfjtokFY8BnhyE9v/kVdVR+Gu8IhHb53hWbJLvc1rhkOAstqZCo4KOZaK00FPEOq49pB
	fsgkpP2EwnbiRfINRieRuKOZuYK9WeaUzmvsEVEvLPr8qaas6FMY92424iK6eW3GyOJFR9CS9/b
	bzvmGErcuvj9M6E22B+OlPUWGezKDIUrSCrmNz7R9yclK6mQGui0ayjhpCKxpoOjvVGpfU78Rgn
	AcVuDeMdIL/lu
X-Received: by 2002:a05:600c:8208:b0:47b:d949:9ba9 with SMTP id 5b1f17b1804b1-47d19566f0dmr103621335e9.13.1766404684291;
        Mon, 22 Dec 2025 03:58:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeV6Qm1+Tt8w1qhLiA6tTt299NR05W/UxteZMkGMX6sQ+7Yl9QWOwxUWib7gajoXvCn4TXoQ==
X-Received: by 2002:a05:600c:8208:b0:47b:d949:9ba9 with SMTP id 5b1f17b1804b1-47d19566f0dmr103621055e9.13.1766404683858;
        Mon, 22 Dec 2025 03:58:03 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eab2721sm21593237f8f.39.2025.12.22.03.58.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 03:58:03 -0800 (PST)
Message-ID: <8e69a404-18bf-4c91-a6c7-59d5ae831591@redhat.com>
Date: Mon, 22 Dec 2025 12:58:01 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] virtio-net: enable all napis before scheduling
 refill work
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Bui Quang Minh <minhquangbui99@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
References: <20251212152741.11656-1-minhquangbui99@gmail.com>
 <CACGkMEtzXmfDhiQiq=5qPGXG+rJcxGkWk0CZ4X_2cnr2UVH+eQ@mail.gmail.com>
 <3f5613e9-ccd0-4096-afc3-67ee94f6f660@gmail.com>
 <CACGkMEs+Mse7nhPPiqbd2doeGtPD2QD3BM_cztr6e=VfuiobHQ@mail.gmail.com>
 <5434a67e-dd6e-4cd1-870b-fdd32ad34a28@gmail.com>
 <20251221084218-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251221084218-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/21/25 2:42 PM, Michael S. Tsirkin wrote:
> On Fri, Dec 19, 2025 at 12:03:29PM +0700, Bui Quang Minh wrote:
>> On 12/17/25 09:58, Jason Wang wrote:
>>> On Wed, Dec 17, 2025 at 12:23 AM Bui Quang Minh
>>> <minhquangbui99@gmail.com> wrote:
>>>> I think we can unconditionally schedule the delayed refill after
>>>> enabling all the RX NAPIs (don't check the boolean schedule_refill
>>>> anymore) to ensure that we will have refill work. We can still keep the
>>>> try_fill_recv here to fill the receive buffer earlier in normal case.
>>>> What do you think?
>>> Or we can have a reill_pending
>>
>> Okay, let me implement this in the next version.
>>
>>> but basically I think we need something
>>> that is much more simple. That is, using a per rq work instead of a
>>> global one?
>>
>> I think we can leave this in a net-next patch later.
>>
>> Thanks,
>> Quang Minh
> 
> i am not sure per rq is not simpler than this pile of tricks.
FWIW, I agree with Michael: the diffstat of the current patch is quite
scaring, I don't think a per RQ work would be significantly larger, but
should be significantly simpler to review and maintain.

I suggest doing directly the per RQ work implementation.

Thanks!

Paolo



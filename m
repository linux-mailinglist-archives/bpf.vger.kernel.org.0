Return-Path: <bpf+bounces-59721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87310ACEE43
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 13:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E4E63AB1D9
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 11:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96589217664;
	Thu,  5 Jun 2025 11:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUJUQRaE"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A00F28E17
	for <bpf@vger.kernel.org>; Thu,  5 Jun 2025 11:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749121392; cv=none; b=OXUcAZeOpJr/bHNV+8UnFptzP2DYdUEteHjAKKKRZulXZJbx9JvT2adf/Sw/Dw5f0YeJKRyejOHi3G3KZzTvEqSB7TqZvuYUstPOruqWk8v0B/HO07rvLape3ooyh5p5lstTge9rfyKemQrGtCEBkKQVDIf5nnDQv1GggguQexI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749121392; c=relaxed/simple;
	bh=5iVRkX4FSgcRxi/CvcNtolFKz6k8kFco9qX1fh/s/lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=seYRyTx9kC6HlMBISkmiwEb0X75ACcJkXxv6kY9/AjGykNz8EGZ4wsNm5nVVBr5t+d7izewq0iOlU1jEHo8/eWXXTVdajIfbDVpLAqgbuz/AoaABRR4QuxsJC3av3W4C0RkK/QAfnEpn/beWNEfT/VzH2+RvktymMdlTCSQghHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XUJUQRaE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749121389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t/iNd4rCLMH3G4cLnw5oDzeODmTZrxz5jMOWbyZxDPY=;
	b=XUJUQRaEJTUdQYD2qx1MPkdyzhLQ9y8MjiHQrDqIWIlt+ww6FOYUbg8iOh/OVrJsha0heB
	SOkFWwpRMtzL0qiEIoTQXBr1H8nnnqc5+tKuqAjnF/vBwXl43QCBlzKd9c9QHSvqiVCpSw
	SAsU5iW83mlbl1fxzsQhBsdQNXWTD5s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151--k4t6KdhPsCQornCijXhOw-1; Thu, 05 Jun 2025 07:03:08 -0400
X-MC-Unique: -k4t6KdhPsCQornCijXhOw-1
X-Mimecast-MFC-AGG-ID: -k4t6KdhPsCQornCijXhOw_1749121387
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f6ff23ccso472611f8f.2
        for <bpf@vger.kernel.org>; Thu, 05 Jun 2025 04:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749121387; x=1749726187;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t/iNd4rCLMH3G4cLnw5oDzeODmTZrxz5jMOWbyZxDPY=;
        b=Q9KQ2Co/p+pM43REGF5gp9j0cwlqSd7J3wS4RWB8YRWsoonzPQf247c3cXvgR0zraq
         evCdumwRtpBAjSbfggk60oudOJ+rYV+wlGBSKqJCg5DsBBMsLWYQTcl+sJSZkQo5FEVZ
         H7EZthgZzfArsrCiCOl1DvwxzS1WLD9uyV9251hx2/EapzkyfRJMx/LdNIjdBQWFbeLE
         O9CIn178ccKGw7u6uSM7iEqM3Q+Y3Mv7N4MmHzCZu8xHK+aU9fe1o1vN4qPVU7HQo/zs
         FWWETN5E6Ajh0ElFbSluapFsE97DEfpuBADyKh5Ge6sAiu9SkWA2rXIivHrzFTN+Lc/j
         pPaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8AlUu+lXqA5LGjuY5mk6at2s2crN6A9DJILIzyJb3+Xs+Szts/Tt2pBQKtRU8pZ74Nf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt6rVVRZgFfA5btSd30wI9B/XnvVV/Zxq2BeQItQhExvvK90s7
	8ePWTRmdFd0lnIJUEZCjklejxlOaRLEkeRn2xJp4dXfYw4MHmYXfN9uSZM5s+34NF/gDIYoDtrj
	7mn9k1LNn6LaOCbId6rBlzwK6tgo3QQqh2DyHffldYLxwGyu7c8dbvA==
X-Gm-Gg: ASbGncugJ++XQhShI6P2SaT+tXV3Vtp6zZt/uL8iEO5JN4I1sJV/6mI5iKjVm981L+Z
	lvLVyeY4rm+q0Z8wmuKb8qA1LmkMYv1wcDXk7WU/iOVTmK1j8CbSauGYMQSlbQZyWpiGhyphCkz
	7rE983ZmZI/x68E/B9p5ZTXMB30i+OmkWNESiTtaHbIXvLJy4iidY1ulSPLj6xEirxTuL8TaDOC
	l3tDQORlLS7dMCn/AtkMrYKA2E9Qn8Mg2XXqANMXCTSFOMcGxtpSJckYvIqxrA+QU535qqtai9h
	pNBXlqLfk9zE8oOhaW8=
X-Received: by 2002:a05:6000:4387:b0:3a5:2949:6c24 with SMTP id ffacd0b85a97d-3a529496f56mr1757616f8f.51.1749121384668;
        Thu, 05 Jun 2025 04:03:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdGUXYZXrNIrCyhAh0tp1ScDeHW0FOJjHuHj6Po7K6huTF1gR9wGCaSTi+dFD3HnrC0pmIFw==
X-Received: by 2002:a05:6000:4387:b0:3a5:2949:6c24 with SMTP id ffacd0b85a97d-3a529496f56mr1757543f8f.51.1749121383960;
        Thu, 05 Jun 2025 04:03:03 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cced:ed10::f39? ([2a0d:3341:cced:ed10::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451f990cfe3sm20995275e9.23.2025.06.05.04.03.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 04:03:03 -0700 (PDT)
Message-ID: <dd087fdf-5d6c-4015-bed3-29760002f859@redhat.com>
Date: Thu, 5 Jun 2025 13:03:01 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio-net: drop the multi-buffer XDP packet in
 zerocopy
To: Bui Quang Minh <minhquangbui99@gmail.com>, netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
References: <20250603150613.83802-1-minhquangbui99@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250603150613.83802-1-minhquangbui99@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/25 5:06 PM, Bui Quang Minh wrote:
> In virtio-net, we have not yet supported multi-buffer XDP packet in
> zerocopy mode when there is a binding XDP program. However, in that
> case, when receiving multi-buffer XDP packet, we skip the XDP program
> and return XDP_PASS. As a result, the packet is passed to normal network
> stack which is an incorrect behavior. 

Why? AFAICS the multi-buffer mode depends on features negotiation, which
is not controlled by the VM user.

Let's suppose the user wants to attach an XDP program to do some per
packet stats accounting. That suddenly would cause drop packets
depending on conditions not controlled by the (guest) user. It looks
wrong to me.

XDP_ABORTED looks like a better choice.

/P



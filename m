Return-Path: <bpf+bounces-59872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58821AD0635
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 17:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 694511885DF9
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 15:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CEE28A1CE;
	Fri,  6 Jun 2025 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NW9nvpxe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51865289801;
	Fri,  6 Jun 2025 15:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749224943; cv=none; b=SlwTT0kdBa83VR/RJjThsoyOIzXuJNe5L6VGpZoZKIj2r9FLsZPxoDmp+EPCXBOGZX30xdoFV5PKneGkrd/VyCiYfBkQFqJQsTMDGSVKgvlp47otz3lbFC2xwZ+P7Hyo0gr8BkIXDr1g/TpOxTjHWm1AVy4bLzYh75htl1nNZss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749224943; c=relaxed/simple;
	bh=qteTWSdXmGXbvSh/VWtVvDyFhQzDEAd2cyVRYJIO0yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Su3JyLeECc9POlaqsV9NX0mmffc6oUpvIirGytxKxBJdXwaDIi95Q0A2Hs79ilI6ebuxGfUXr1n1Xwe3wbtxYTucZHwzZYjE5eDMO2934KS23fp+hzgtKA597hKMjHNEllwl0P6hlKZO1kgBVQ/sjd8Do/0gQ403xKfGfMRXBI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NW9nvpxe; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3122368d7cfso1909446a91.1;
        Fri, 06 Jun 2025 08:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749224941; x=1749829741; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SFAXCqQFrPjFZs7s5flyQDRDOg704B5o+gINoyafWfw=;
        b=NW9nvpxeAQP5ozos0dNMFjHsOTDiHhdYnfFRH5y1LXmTH6P+GQBmavLMlYGU+UunS1
         dx/9ZTX9qlvIen5rJDoEr2CXjZ4KGcZB/OJJL+XaTEf6PLxFZREjbCyi91q3CafQeXse
         SLELgwWo9HWSH7hqRcNH11fuMGOUiRldPyHpgqHybibseAqzqk4e+VPLipDl/SbxVnyN
         GQffJNiJnGmOgMGg1FYlWYN9auyOkf1V4wDZeNVTl2OvexSZxRuNv7OtrdcfPIqY0dPA
         6AXACvLe5NZbMGw/d/CAWPQRRtHcoSuanMQmHpAFxULAFAIpOM+Cj2HedtotFwExwKse
         KQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749224941; x=1749829741;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SFAXCqQFrPjFZs7s5flyQDRDOg704B5o+gINoyafWfw=;
        b=IK1f7+fkfSZf8+x0Od3jjyQhV2w/xAAUtfTZQu7NKxdRpT50iA+Wh5cgypyZV4oeiU
         3HdZaT2Fj7infffm+6EOeuFaWmFJazcCKnjF/nra0M8NnIwMD1r/tjQPa+3xZyh4Bsrn
         m/h3dv1bhN8RxLehpjiiL3NtdSGzwW6KqKd5NRryJ0cs3Q0Au9taYvyv0/zclHkUZx60
         E/aqqSaifp8D87U2ltyFQRN5vgNik2cusRACSDKuRUEtlGOKIziQYF2na5gO29HtlJbq
         FpLIC1s6axLnFWJEXwXq+krUncbfFRguF0/NppxmDUvtcQhrpval14725zVqzP0cGEKE
         kR+w==
X-Forwarded-Encrypted: i=1; AJvYcCV8inONVebNTMWFS1+jxo9bIYBi4c4AcKuCFhreyDSg2mWspDzJtI4U2YqwOsI7dTxTOoM=@vger.kernel.org, AJvYcCW/LL05J10mLnP/BYgqStfgz/INlTnZdDd53W8ShtzcbskgsLHbATBVYrcqSuhoMbYM9JF3NBxRgt+OqJnc@vger.kernel.org, AJvYcCWjCAG8g4RmS/wzUdPNQmpLTpS1wB3pCbLt5GibjD0wBroDlEJLHMSCFvxTAFs51Hz2NaLt0hRB@vger.kernel.org, AJvYcCWrdoseY7tsDAWVhKDXYAFMV7X6VffmJoufiusExI3nfMdqAorpfehwBX84aGTdYOVNV+nTrtYa@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ5jYDd+1BxHKRc3i5P1n1FMRbPKlLP4wF2vpw9ot5CAfIZXkc
	2Ug/lJx9jMeWVxAzs2NOpnxt+eYk63VNg1QlLxWeZBzfcCczySLhWLA+
X-Gm-Gg: ASbGncsU4LcebNuK3HsVUbOkQePPdccZiN4wjr0V7A/XEEJ5We9eOvckS9ip91mnZKl
	AG2JAJb28czfo4d9Z7/4PtmaLarvZs03KgKcXoTdE9X/B7rd09j+JneAJatIvB4vrPHW4YH3Nbq
	wmZFjIow6iBMxBqDtfqj1W+U+pjW8J5wZAm0nq6otio7I2bT+EOJCdY7GcCMtUEUyYk/Uvnq/0R
	hwHegOb8DhgfZ+pAsAhCO5yrOQOjNw+G3MtZ3GpCA6kNGJeIUrYyfOmyuN/KOdsmbb2c6WmOmmf
	kzx0KUUJaaEde+AN3qhFfmm2JkkFHLuNyxD7cslC0xrg23i0MGLOF/bE29NkGObfP232M0dNd7X
	Wita23ATLZrhE3lFkRr7X33s7pqpndPFlEPcbDH8y
X-Google-Smtp-Source: AGHT+IHG/4StZ2v8LodTRZ+tFEEY1GEgtwGds0NXN4+D7wj3obn0sPwJ9Edgk7OM0j71WGZIu3Rb6w==
X-Received: by 2002:a17:90b:4b09:b0:313:2adc:b4c4 with SMTP id 98e67ed59e1d1-31347678bbcmr5917844a91.24.1749224941467;
        Fri, 06 Jun 2025 08:49:01 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:e7b6:944a:261d:ef5a? ([2001:ee0:4f0e:fb30:e7b6:944a:261d:ef5a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236032fcf53sm13827705ad.129.2025.06.06.08.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jun 2025 08:49:00 -0700 (PDT)
Message-ID: <f073b150-b2e9-43db-aa61-87eee4755a2f@gmail.com>
Date: Fri, 6 Jun 2025 22:48:53 +0700
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
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20250605074810.2b3b2637@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/5/25 21:48, Jakub Kicinski wrote:
> On Thu, 5 Jun 2025 21:33:26 +0700 Bui Quang Minh wrote:
>> On 6/5/25 18:03, Paolo Abeni wrote:
>>> On 6/3/25 5:06 PM, Bui Quang Minh wrote:
>>>> In virtio-net, we have not yet supported multi-buffer XDP packet in
>>>> zerocopy mode when there is a binding XDP program. However, in that
>>>> case, when receiving multi-buffer XDP packet, we skip the XDP program
>>>> and return XDP_PASS. As a result, the packet is passed to normal network
>>>> stack which is an incorrect behavior.
>>> Why? AFAICS the multi-buffer mode depends on features negotiation, which
>>> is not controlled by the VM user.
>>>
>>> Let's suppose the user wants to attach an XDP program to do some per
>>> packet stats accounting. That suddenly would cause drop packets
>>> depending on conditions not controlled by the (guest) user. It looks
>>> wrong to me.
>> But currently, if a multi-buffer packet arrives, it will not go through
>> XDP program so it doesn't increase the stats but still goes to network
>> stack. So I think it's not a correct behavior.
> Sounds fair, but at a glance the normal XDP path seems to be trying to
> linearize the frame. Can we not try to flatten the frame here?
> If it's simply to long for the chunk size that's a frame length error,
> right?

Here we are in the zerocopy path, so the buffers for the frame to fill 
in are allocated from XDP socket's umem. And if the frame spans across 
multiple buffers then the total frame size is larger than the chunk 
size. Furthermore, we are in the zerocopy so we cannot linearize by 
allocating a large enough buffer to cover the whole frame then copy the 
frame data to it. That's not zerocopy anymore. Also, XDP socket zerocopy 
receive has assumption that the packet it receives must from the umem 
pool. AFAIK, the generic XDP path is for copy mode only.

Thanks,
Quang Minh.



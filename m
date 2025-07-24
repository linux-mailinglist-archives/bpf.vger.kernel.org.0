Return-Path: <bpf+bounces-64244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C62CB10779
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 12:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C55803ADAE5
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 10:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DE525FA05;
	Thu, 24 Jul 2025 10:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bTjpcpdW"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9FC25F7BF
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 10:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753351896; cv=none; b=F+qB2lcH5rQgxj1PO1cFNM9QFKh12wBnW4vFfJerPuvMl5quNBkYj2EYr6WtwKatuo1CgrT8eFmqf4nt6O+NFxIX07LvuxAi2EMX0q/t5L/cJhYpkLRqeU+EFgwvUdnVuUNa2sInFZaAoBpIZUGYktg5NLPd+cvVF4TNkVRF2jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753351896; c=relaxed/simple;
	bh=X4LxTS5i+PxsXL1VybcAeYqmFr4xbvNvNF5oA121biY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FRtv8bofnL9xa0VxfibSW5A89itLJEQ5N+Adn2JP2kpx/opIbB0c9lqrj4p+p8UEeuzO7pUwTe8V9gZK8rkvRjUINdG4GIif2/cM5LBZl6lwy6ZK/iR1xFwmw+66uQVFLr2EWunyXcYw4uCA56IKOpL3PWtI6mBNZfWlsBWz0VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bTjpcpdW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753351892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pS9NCCf2Sfvw3i8ZJqrYBibPyYM/pNsOcOcTrtQHKAc=;
	b=bTjpcpdW46GLbJsp9xV9qvxzf5eAKu0H4Yjjgy+SGXcuW1Tg5+Vyn7cI29czwMijtxUMfh
	F0vSDJfbRp3grs1TOdn4g8Gsd4WiU8UcPksxKZk0GJIx6yvh+3xl+C9MxaYXjuhECU9J40
	CwCbxHtSYyLOWEsgVO1hzDONcWZd51g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-EC5wkThUNsS2CAaEMtnlmw-1; Thu, 24 Jul 2025 06:11:30 -0400
X-MC-Unique: EC5wkThUNsS2CAaEMtnlmw-1
X-Mimecast-MFC-AGG-ID: EC5wkThUNsS2CAaEMtnlmw_1753351890
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso5021485e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 03:11:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753351890; x=1753956690;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pS9NCCf2Sfvw3i8ZJqrYBibPyYM/pNsOcOcTrtQHKAc=;
        b=vhjK3BFePVlzFv4mRGjp0ShkEgB8m7mnX8jo1rKYnQ2d0V+/hd4jhCuZlPLchXdnrK
         kVA7YRwZEazJM0V0QvWlNuwbCx6YXmCCXo/sC9DeEit25ef/SpREUp3cXbOQ+amUOpCQ
         tjm6bbNvwnJLfra2Vl+rasVcjhrAM8P/OSL6YGPyHrlrW372zo7D+P+oeR/bSNtJqVYX
         1uzv2BQNHadLiDzbTOyX/nt3M99XLXurNUjGRu9VCWWg3QTJg1EwZ+u8WamtunEmCMIt
         C6WjyRF0/ml4zS0TI6j3qXj3httLB0xKBxm+QXgUPG1nhp5OnBmCy4VFhMfSk++ZsHf+
         Zy7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDjJQOkohhdfzbCFi7c/EBppHlPmMRuPA3HAfOCa/DEaAJ2ZfbvdkCY9VT+hdrHOoHDIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOF8z8zf2WbTusnYvG28InBk5tK09eSYktVVlGlGhV42mv2Xq+
	jcnOVw482TAe3h2Bgq4zJuH7ljlHEthap0MVp3ynWlrTjdwl+ki6jb2l9XWKodAxQS2Cf5B37tB
	ETItwMVQXUGJnP8+nbAiipR0GU63ZFiXCNmwPrOazQHtaPHhniYC0ZQ==
X-Gm-Gg: ASbGnct18I2wovWmeaimg4TTgXhBn8AFBUOYSc7DpzZwKrR+FOh9d80xdG3fG076/nz
	U2tJKzxWlEI/7HLKN6s08miF96IOcPoejm9KUxdzvADyGIxzqRZg5Z+yLABB/FoRxT0gvS0DNnL
	NBOghfEXJPPfsytwU5S9uFtT9Ot4wKMA+I8szLqSyKmcMgoa7EhF41cddMljPPqb5JU3K9u9p+I
	e/yn56fZTrtfMgt1KhF9DYP57e7kdNe1dKDWS74MJzPeV3KhVFLM2QdoAStAbzC1vrazSHZGlDY
	OiRRAtpMab8FBsZsxdl16DZP4ndSsBbFdxqYfUseSz7BiuuSB8q/a6YmW6gdxHE7z9Kv7RYDRTi
	hhj/mmYhFoSQ=
X-Received: by 2002:a05:600c:c170:b0:456:189e:223a with SMTP id 5b1f17b1804b1-45870550e93mr14438285e9.10.1753351889710;
        Thu, 24 Jul 2025 03:11:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBMjObt5JtHA4ACAHGVVyxZl3C3/PraQ2IGfSAMKpvhEeAUO7+x8UElb4i59tY0tQI1hNZGQ==
X-Received: by 2002:a05:600c:c170:b0:456:189e:223a with SMTP id 5b1f17b1804b1-45870550e93mr14437705e9.10.1753351889187;
        Thu, 24 Jul 2025 03:11:29 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45870568fb1sm14407255e9.27.2025.07.24.03.11.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 03:11:28 -0700 (PDT)
Message-ID: <77ce8301-38e5-4d13-9b76-0d731f8b6a7e@redhat.com>
Date: Thu, 24 Jul 2025 12:11:25 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] [PATCH] net: otx2: handle NULL returned by
 xdp_convert_buff_to_frame()
To: Geethasowjanya Akula <gakula@marvell.com>,
 Chenyuan Yang <chenyuan0y@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
 Hariprasad Kelam <hkelam@marvell.com>, Bharat Bhushan
 <bbhushan2@marvell.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "ast@kernel.org" <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "hawk@kernel.org" <hawk@kernel.org>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
 "sdf@fomichev.me" <sdf@fomichev.me>, Suman Ghosh <sumang@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "zzjas98@gmail.com" <zzjas98@gmail.com>
References: <20250723003243.1245357-1-chenyuan0y@gmail.com>
 <CH0PR18MB43399E06C1EDC7DE70AE7170CD5FA@CH0PR18MB4339.namprd18.prod.outlook.com>
 <CH0PR18MB4339EE7E08DBD7A4F6E3EA72CD5FA@CH0PR18MB4339.namprd18.prod.outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CH0PR18MB4339EE7E08DBD7A4F6E3EA72CD5FA@CH0PR18MB4339.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/25 5:36 AM, Geethasowjanya Akula wrote:
>> -----Original Message-----
>> From: Geethasowjanya Akula
>> Sent: Wednesday, July 23, 2025 8:59 AM
>> To: Chenyuan Yang <chenyuan0y@gmail.com>; Sunil Kovvuri Goutham
>> <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
>> <sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>; Bharat
>> Bhushan <bbhushan2@marvell.com>; andrew+netdev@lunn.ch;
>> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
>> pabeni@redhat.com; ast@kernel.org; daniel@iogearbox.net;
>> hawk@kernel.org; john.fastabend@gmail.com; sdf@fomichev.me; Suman
>> Ghosh <sumang@marvell.com>
>> Cc: netdev@vger.kernel.org; bpf@vger.kernel.org; zzjas98@gmail.com
>> Subject: RE: [EXTERNAL] [PATCH] net: otx2: handle NULL returned by
>> xdp_convert_buff_to_frame()
>>
>>
>>
>>> -----Original Message-----
>>> From: Chenyuan Yang <chenyuan0y@gmail.com>
>>> Sent: Wednesday, July 23, 2025 6:03 AM
>>> To: Sunil Kovvuri Goutham <sgoutham@marvell.com>; Geethasowjanya
>> Akula
>>> <gakula@marvell.com>; Subbaraya Sundeep Bhatta <sbhatta@marvell.com>;
>>> Hariprasad Kelam <hkelam@marvell.com>; Bharat Bhushan
>>> <bbhushan2@marvell.com>; andrew+netdev@lunn.ch;
>> davem@davemloft.net;
>>> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
>>> ast@kernel.org; daniel@iogearbox.net; hawk@kernel.org;
>>> john.fastabend@gmail.com; sdf@fomichev.me; Suman Ghosh
>>> <sumang@marvell.com>
>>> Cc: netdev@vger.kernel.org; bpf@vger.kernel.org; zzjas98@gmail.com;
>>> Chenyuan Yang <chenyuan0y@gmail.com>
>>> Subject: [EXTERNAL] [PATCH] net: otx2: handle NULL returned by
>>> xdp_convert_buff_to_frame()
>>>
>>> The xdp_convert_buff_to_frame() function can return NULL when there is
>>> insufficient headroom in the buffer to store the xdp_frame structure or
>>> when the driver didn't reserve enough tailroom for skb_shared_info.
>>>
>>> Currently, the otx2 driver does not check for this NULL return value in
>>> two critical paths within otx2_xdp_rcv_pkt_handler():
>>>
>>> 1. XDP_TX case: Passes potentially NULL xdpf to otx2_xdp_sq_append_pkt()
>> 2.
>>> XDP_REDIRECT error path: Calls xdp_return_frame() with potentially NULL
>>>
>>> This can lead to kernel crashes due to NULL pointer dereference.
>>>
>>> Fix by adding proper NULL checks in both paths. For XDP_TX, return
>>> false to indicate packet should be dropped. For XDP_REDIRECT error
>>> path, only call
>>> xdp_return_frame() if conversion succeeded, otherwise manually free the
>>> page.
>>>
>>> Please correct me if any error path is incorrect.
>>>
>>> This is similar to the commit cc3628dcd851
>>> ("xen-netfront: handle NULL returned by xdp_convert_buff_to_frame()").
>>>
>>> Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
>>> Fixes: 94c80f748873 ("octeontx2-pf: use xdp_return_frame() to free xdp
>>> buffers")
>>> ---
>>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c | 8 +++++++-
>>> 1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
>>> b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
>>> index 99ace381cc78..0c4c050b174a 100644
>>> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
>>> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
>>> @@ -1534,6 +1534,9 @@ static bool otx2_xdp_rcv_pkt_handler(struct
>>> otx2_nic *pfvf,
>>> 		qidx += pfvf->hw.tx_queues;
>>> 		cq->pool_ptrs++;
>>> 		xdpf = xdp_convert_buff_to_frame(&xdp);
>>> +		if (unlikely(!xdpf))
>>> +			return false;
>>> +
>>> 		return otx2_xdp_sq_append_pkt(pfvf, xdpf,
>>> 					      cqe->sg.seg_addr,
>>> 					      cqe->sg.seg_size,
>>> @@ -1558,7 +1561,10 @@ static bool otx2_xdp_rcv_pkt_handler(struct
>>> otx2_nic *pfvf,
>>> 		otx2_dma_unmap_page(pfvf, iova, pfvf->rbsize,
>>> 				    DMA_FROM_DEVICE);
>>> 		xdpf = xdp_convert_buff_to_frame(&xdp);
>>> -		xdp_return_frame(xdpf);
>>> +		if (likely(xdpf))
>>> +			xdp_return_frame(xdpf);
>>> +		else
>>> +			put_page(page);
>> Thanks for the fix. Given that the page is already freed, returning true in this
>> case makes sense.
> This change might not be directly related to the current patch, though. You can either 
> include it here or we can submit a follow-up patch to address it.

If I read correctly, returning false as the current patch is doing, will
make the later code in otx2_rcv_pkt_handler() unconditionally use the
just freed page.

I think returning true after put_page() is strictly necessary.

/P



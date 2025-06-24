Return-Path: <bpf+bounces-61381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C86AE69FE
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 17:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 155F93A6800
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 14:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B23291C1A;
	Tue, 24 Jun 2025 14:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QprMSxdd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90016291C09;
	Tue, 24 Jun 2025 14:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750777138; cv=none; b=T63diG9/054KrmNlSEfl7xA9HKcSn9dDOVVo0oourdIqh6eH4FvlqNGzHlaaZiFutpXEF3Y2vgMQVtmOCffVRhVXCYEY8BOxLfEL/uHbpr1NJd4F7V23ccs+JSNGLYrOSLvJx7fjJdv7Ti5cOixFCRM2N8t7palsPu+wdaKnkTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750777138; c=relaxed/simple;
	bh=loG2cx3ZGfP/J061ElEISkikcZshIqrgMfBBB4m1POc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cw8xGu1xn7F1XTVQ4kXLl0d8hxrd6HFx+yIgduR5Jkr2YzH9rAnyKGKcx+t+KunDHu0G+7rQ+h5NXi10xQUsCO4jy0csK9AWtaITA8lzQicUc0ir4jyJxeo1+xdNYSw4vvB9GcYkI/dZUrrYHVh6y+x/0liywQWmPH+TJyQn3DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QprMSxdd; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b34a8f69862so535872a12.2;
        Tue, 24 Jun 2025 07:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750777136; x=1751381936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DFS9CMumjJJISBCLnrgNW43kLYsugAi5o9ZdE09jh+0=;
        b=QprMSxddNhwgDiDOuwf1QyW23XFMbQAVqMIPZK5xdyx/PMf/ELKbXlDjv9AOenVGyo
         v7Y0t/kIJwJ9F54L+tyw7VCstM44ZWUZ/7q3dlL/b+ZRc/NbG561y64hPew0EdYIyVit
         v5gT7Tk5B/0syOl3fYaa4MtV/M2MbGJqvtzxQHxF0FPmL+mAuPbMcYMDhtSRQYfFEcOt
         RdtvL+Y/EGVf7t7mkbL0lvwnxcficSqqiX8gi0kUruaZxcV/FJl1KXQYK6sahJfUsoiC
         A1LHtl2BQREf2WniaY/xpQFQuxnYQ2PQiIuVFMEWAAKP0ZyZIVnomdEV50XOLJM0Bjjz
         CUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750777136; x=1751381936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DFS9CMumjJJISBCLnrgNW43kLYsugAi5o9ZdE09jh+0=;
        b=ah951wEq86ZaQKJiM673Qw2rGysc436+VtrIP389M9y49AAb6B8RTE1RkagGB5YgMp
         lpcOLnR7Y070/9IyRkk5tq4WmSEDEOzW5tmML24iNfEtIt5ef4hix/mz+pYyPwjDQK9O
         k0yb/3xgCdly1nNorNKNc2hQbmoir78NzrKvsK6YjSpatDHkamx3VSjhioyZ4i+ibdbb
         FyzAy3xQYMMY4Ak2Kw+eJqn42vMYlhgsNvnyElR+CCMmt0IMkRRCFuOWsFnIO2uXybJa
         U/1nSTTAIEQovvz0Hjl2wwcHURMdjERH10gbXcCjCjG+aiq0uKkmuMn0NR6EAvWynryc
         4GOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrEj6gDoS/fbLOs3/n10N76ciUQnkOyBkF55Be5E9VgOw+3f3qOCF6+cnvNG9AdhitraY=@vger.kernel.org, AJvYcCXNnuIFP82c++WPwziVT58lcyvcF13JuVa7zA8GLz32Cd6NKTYZ8T49HUWRJWeeYb+sEzxd4zPv3un6EK6d@vger.kernel.org, AJvYcCXOnHCMV9hTjhCKRGPrG/3SLTAbNjMk4W4+abfcs2jXyLjEHBnxSPpsyjPKtD9DGmy1cDn4IAut@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0mSKVJf3MUHZZb62lVDaoa4cYP8s0zC/7Ek1V5+q4wJfdjDHE
	83ssxl7/FL+8cV8ugltAJLUd4a0CWeN9mkVwu5b56mCFVjrs9alEIsn4
X-Gm-Gg: ASbGnct1+Nc73J2qWUvfrFOhqRqiJAxOL3+kFL7laRqPtD4FjXWb/ifOBcnmIStqaky
	3MqDs2nKMvx+KG7OFZbg6WCBPgH/nRYuBjLQ4iYuQS6kOoLrZQvPj/6mNp3U72u4i7I6h5Q8oHl
	n3vQHUpHJ/fDa7YDSSWZ3djxG/F6qOkxRl7sR7/3iMakS2BMWMeLwxxHfQkJfrqx1HkaGI1tXtu
	NRNsV3gPZDdQYqL2sa8bxrVL3OJMSL1aSWA5mz3s1yGJ/I+E5rFI+smI8+tC+jJTSlC+wmrQkyr
	pKLsMmeCRW3CKYF6nU6Nm4mC5Gk5/yMDL3Bg1ABbgKp0GqoG/Md8d+2RmnoKI9hD7Wo+9dOESSW
	pdXbwX5WhSBxuJtjmXeXT0emskUAv93ROqfCDKCQN
X-Google-Smtp-Source: AGHT+IF+qbX1Ip+UnixDoMvVlniOQVuJKKO8aqdN56Jco+7UYSwZVb5AUVnkERXoLBP1nfjqvA8V0w==
X-Received: by 2002:a05:6a21:684:b0:218:9b3e:e8bd with SMTP id adf61e73a8af0-22026dca74dmr26352327637.10.1750777135577;
        Tue, 24 Jun 2025 07:58:55 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:1f60:cc25:9268:94fb? ([2001:ee0:4f0e:fb30:1f60:cc25:9268:94fb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749b5e21799sm2122923b3a.51.2025.06.24.07.58.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 07:58:55 -0700 (PDT)
Message-ID: <ffb4b02e-fadb-4697-b001-7d879ca3b6de@gmail.com>
Date: Tue, 24 Jun 2025 21:58:47 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] virtio-net: xsk: rx: move the xdp->data
 adjustment to buf_to_xdp()
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
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
 <e6654755-3aa1-4f4b-a6ab-c7568d8a5d4e@redhat.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <e6654755-3aa1-4f4b-a6ab-c7568d8a5d4e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/24/25 17:17, Paolo Abeni wrote:
> On 6/21/25 4:49 PM, Bui Quang Minh wrote:
>> This commit does not do any functional changes. It moves xdp->data
>> adjustment for buffer other than first buffer to buf_to_xdp() helper so
>> that the xdp_buff adjustment does not scatter over different functions.
>>
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>>   drivers/net/virtio_net.c | 16 ++++++++++++++--
>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 1eb237cd5d0b..4e942ea1bfa3 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -1159,7 +1159,19 @@ static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
>>   		return NULL;
>>   	}
>>   
>> -	xsk_buff_set_size(xdp, len);
>> +	if (first_buf) {
>> +		xsk_buff_set_size(xdp, len);
>> +	} else {
>> +		/* This is the same as xsk_buff_set_size but with the adjusted
>> +		 * xdp->data.
>> +		 */
>> +		xdp->data = xdp->data_hard_start + XDP_PACKET_HEADROOM;
>> +		xdp->data -= vi->hdr_len;
>> +		xdp->data_meta = xdp->data;
>> +		xdp->data_end = xdp->data + len;
>> +		xdp->flags = 0;
>> +	}
>> +
>>   	xsk_buff_dma_sync_for_cpu(xdp);
>>   
>>   	return xdp;
>> @@ -1284,7 +1296,7 @@ static int xsk_append_merge_buffer(struct virtnet_info *vi,
>>   			goto err;
>>   		}
>>   
>> -		memcpy(buf, xdp->data - vi->hdr_len, len);
>> +		memcpy(buf, xdp->data, len);
>>   
>>   		xsk_buff_free(xdp);
>>   
> I'm unsure if this change is in the right direction because it almost
> open-code the existing xsk_buff_set_size() helper - any changes there
> should be reflected here, too.
>
> Also AFAICS xdp->data will now carry a different value, and I guess such
> change is user-visible from the attached xdp program. The commit message
> should at least mentions such fact.

The else path in buf_to_xdp is only triggered when it's called in 
xsk_append_merge_buffer. That's also the reason of the memcpy line 
change in xsk_append_merge_buffer. xsk_append_merge_buffer will allocate 
frag and copy xdp_buff's data to that frag. Previously, after 
buf_to_xdp, the xdp->data does not point to correct place yet so when 
memcpy, we need to copy from xdp->data - vi->hdr_len. With this change, 
we will adjust xdp->data = xdp->data - vi->hdr_len right in buf_to_xdp 
and also adjust other fields (xdp->data_end) to the correct place too. 
So I don't think there is a functional change in this commit.

Thanks,
Quang Minh.




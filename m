Return-Path: <bpf+bounces-26882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E233D8A61A8
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 05:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EEF01C225DC
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 03:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCFE1946F;
	Tue, 16 Apr 2024 03:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nk+LRTTz"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0AD2D60A
	for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 03:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237791; cv=none; b=B1xQQ5oQ7FZY352JHFa7CZTfOkPwafzeBExHSI/w3tz7nUDvSvUDIOViz234HGPMQ8A0YS2CwFhMaQyf6SG7QCKroE63fotuhLTsbtHQouUgN/u4+n165OMOqOq3gK6UTd9ekF+lVQpgNY5R1NDL1bxuReMuwbUN0xEcvw1wdNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237791; c=relaxed/simple;
	bh=icURpqdcCO5hioqD2HKbq4WbHyCbWmJ53hHNaMbWgXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QcZ8URsYD2oQvoVyHJ3SKv/TOL4mVhtQDh03mVc5UOfsXQFDW5nDhzvN6/YyMnnhL7P9heJVn+1u5rLh9AfGRLamDd6ypgG1f6VS8r+YM438EoBElyXnUvQZ1CIkPpsrk1cD3pMohmTjc3ipb6tT1twsbabT2SlmkjH3iS/rHO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nk+LRTTz; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <39a68b12-a921-471b-83ff-6d59b21aa4a9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713237786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IT6mU3vsFYZfPO29Ba208cDF9yPdDkZj8JsIVVX4xUw=;
	b=nk+LRTTzPVCAvGvAVfZpEabrayYbsRJNEFA/dmnxPYZ9ZuGa01lKXBydj6qsiEfb/GDaXG
	om4cH+uI7HDo1WPgdhiEVTimOwtGrAUk3LnruCwIThfO67uUqsm26aQ9n5/eZSdeUrhG0E
	CgmFaaaUyPWXxPz1nIrMMsVa8zypacc=
Date: Mon, 15 Apr 2024 20:22:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: No direct copy from ctx to map possible, why?
Content-Language: en-GB
To: Fabian Pfitzner <f.pfitzner@tu-braunschweig.de>, bpf@vger.kernel.org
References: <36c8d494-e1cf-4361-8187-05abe4698791@tu-braunschweig.de>
 <4f62fa70-ac50-41ff-a685-db6c8aefb017@linux.dev>
 <6d224ee5-ca50-44a9-882e-074710bf8477@tu-braunschweig.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <6d224ee5-ca50-44a9-882e-074710bf8477@tu-braunschweig.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 4/15/24 1:25 PM, Fabian Pfitzner wrote:
>> Looks like you intend to copy packet data. So from the above, 
>> 'expected=fp,pkt,pkt_meta...', you can just put the first argument
>> with xdp->data, right? 
> Yes, I intend to copy packet data. What do you mean by "first 
> argument"? I'd like to put the whole data that is depicted by 
> xdp->data into a map that stores them as raw bytes (by using a char 
> array as map element to store the data).

Sorry, typo. 'first argument' should be 'third argument'.

>
>> Verifer rejects to 'ctx' since 'ctx' contents are subject to verifier 
>> rewrite. So actual 'ctx' contents/layouts may not match uapi definition. 
> Sorry but I do not understand what you mean by "subject to verifier 
> rewrite". What kind of rewrite happens when using the ctx as argument? 
> Furthermore, am I correct that you assume that the uapi may dictate 
> the structure of the data that can be stored in a map? How is it 
> different to the case when first storing it on the stack and then 
> putting it into a map?

The UAPI xdp_md struct:

struct xdp_md {
         __u32 data;
         __u32 data_end;
         __u32 data_meta;
         /* Below access go through struct xdp_rxq_info */
         __u32 ingress_ifindex; /* rxq->dev->ifindex */
         __u32 rx_queue_index;  /* rxq->queue_index  */

         __u32 egress_ifindex;  /* txq->dev->ifindex */
};

The actual kernel representation of xdp_md:

struct xdp_buff {
         void *data;
         void *data_end;
         void *data_meta;
         void *data_hard_start;
         struct xdp_rxq_info *rxq;
         struct xdp_txq_info *txq;
         u32 frame_sz; /* frame size to deduce data_hard_end/reserved 
tailroom*/
         u32 flags; /* supported values defined in xdp_buff_flags */
};

You can see they are quite different. So to use pointee of 'ctx' as the key, we
need to allocate a space of sizeof(struct_md) to the stack and copy necessary
stuff to that structure. For example, xdp_md->ingress_ifindex = xdp_buff->rxq->dev->ifindex, etc.
Some fields actually does not make sense for copying, e.g., data/data_end/data_meta in 64bit
architecture. Since stack allocation is needed any way, so disabling ctx and requires
user explicit using stack make sense (if they want to use *ctx as map update value).

In your particular example, since you intend to copy xdp_md->data, you can directly
access that from xdp_md->data pointer, there is no need to copy ctx which is not
what you want.

>
> On 4/15/24 6:01 PM, Yonghong Song wrote:
>>
>> On 4/14/24 2:34 PM, Fabian Pfitzner wrote:
>>> Hello,
>>>
>>> is there a specific reason why it is not allowed to copy data from 
>>> ctx directly into a map via the bpf_map_update_elem helper?
>>> I develop a XDP program where I need to store incoming packets 
>>> (including the whole payload) into a map in order to buffer them.
>>> I thought I could simply put them into a map via the mentioned 
>>> helper function, but the verifier complains about expecting another 
>>> type as "ctx" (R3 type=ctx expected=fp, pkt, pkt_meta, .....).
>>
>> Looks like you intend to copy packet data. So from the above, 
>> 'expected=fp,pkt,pkt_meta...', you can just put the first argument
>> with xdp->data, right?
>> Verifer rejects to 'ctx' since 'ctx' contents are subject to verifier 
>> rewrite. So actual 'ctx' contents/layouts may not match uapi definition.
>>
>>>
>>> I was able to circumvent this error by first putting the packet onto 
>>> the stack (via xdp->data) and then write it into the map.
>>> The only limitation with this is that I cannot store packets larger 
>>> than 512 bytes due to the maximum stack size.
>>>
>>> I was also able to circumvent this by slicing chunks, that are 
>>> smaller than 512 bytes, out of the packet so that I can use the 
>>> stack as a clipboard before putting them into the map. This is a 
>>> really ugly solution, but I have not found a better one yet.
>>>
>>> So my question is: Why does this limitation exist? I am not sure if 
>>> its only related to XDP programs as this restriction is defined 
>>> inside of the bpf_map_update_elem_proto struct (arg3_type restricts 
>>> this), so I think it is a general limitation that affects all 
>>> program types.
>>>
>>> Best regards,
>>> Fabian Pfitzner
>>>
>>>
>>>
>>>
>


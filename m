Return-Path: <bpf+bounces-61109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F294AE0C6B
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 20:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDB6D1BC7BC8
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 18:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537782FA647;
	Thu, 19 Jun 2025 18:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HOrGDUZk"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC582F94B3
	for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 18:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750356309; cv=none; b=dPGqP6VO3RjR2vyxDcqSfr83bYMx1SRCHp6M3aZDiS3+fn2faU34GzMkDUHdkJmi+AaF7s9gZPBK91eEJbDRjorsdnGg2Y/19DlrmWQcUetH+NLEFg8+yP4LdtThahjdXWE31ecivbC/kpSGPRWvstV4JBCGlkGhjdWSHO2tLPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750356309; c=relaxed/simple;
	bh=jwLl+WRCpnXgsUZfsWM9Rm+syq7zWVUVpf8lr7JoJBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WvC8vePm4n1uzdP2pktmQ9I3Ny3mk0aZcqFridH34aZ6DCevfyxk1DMm+/94IhkGMSujRzC5a2rxywPhp/EUhwGpw8iv8PWwiHouxiST+j4mC5LjEMm3NvM225LAHIGT6jglNB/3xVx39svJ5/33Z2VsCPYh6z64h88MjPGNFDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HOrGDUZk; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c8540b80-2903-4e31-a4ee-93278475d232@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750356302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/AA9pP65LDF7GL+tu9xGVrwHSP7XgCAdMcGekVUTwBY=;
	b=HOrGDUZkbJ0/PQsjmkJnMOhudSPam7BtOuG1k4lcADplW2WHiXvb3QpJRPL0PTUSiUM/ck
	/HyKzCjICUU/vHeFezr1LnjlPpFZcyTfdAL39zBCNWLS9KXQxbTOPnUsw9S00IYRQztwBh
	JhvlI/SqVgK2IqpvAECBo2xBzqNhrcM=
Date: Thu, 19 Jun 2025 11:04:57 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_dynptr_memset() kfunc
To: Eduard Zingerman <eddyz87@gmail.com>,
 Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, andrii@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 mykolal@fb.com, kernel-team@meta.com
References: <20250618223310.3684760-1-isolodrai@meta.com>
 <b35ce32e-a5e7-4589-ab16-d931194a32bb@gmail.com>
 <45390c6c-bd2a-4962-8222-1ad346f9908c@linux.dev>
 <7852f30ba177dc5b811bb0840ca0f301df2a8b58.camel@gmail.com>
 <7e7e4056-e2b8-41a5-a6b2-a2fbe0a94f4c@linux.dev>
 <50c2f252620107b6fa6642e281a91db444b032c5.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <50c2f252620107b6fa6642e281a91db444b032c5.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/19/25 10:57 AM, Eduard Zingerman wrote:
> On Thu, 2025-06-19 at 10:55 -0700, Ihor Solodrai wrote:
> 
> [...]
> 
>>> I think Mykyta has kernel/trace/bpf_trace.c:__bpf_dynptr_copy_str() in mind.
>>
>> Thanks for the pointer. So it looks like memset can use
>> bpf_dynptr_slice_rdwr() to handle xdp/skb cases. Something like:
>>
>>       void *ptr = bpf_dynptr_slice_rdwr(&dynptr, 0, buffer, sizeof(buffer));
>>       if (!ptr)
>>           return -EINVAL;
>>
>>       memset(ptr, val, n);
>>
>>       if (ptr == buffer)
>>           bpf_dynptr_write(&dynptr, 0, buffer, sizeof(buffer), 0);
>>
>>
> 
> I think so. In a loop.

But allocating and copying buffers for memset...

It should be possible to walk through fragments like
net/core/filter.c:bpf_xdp_copy_buf does.

Any reasons it's a bad idea?

> 



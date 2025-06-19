Return-Path: <bpf+bounces-61107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD68AE0C2C
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 19:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5ECC3B6579
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 17:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE56128D8D9;
	Thu, 19 Jun 2025 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m95zovZk"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FB328CF74
	for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 17:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750355758; cv=none; b=Q8RTC4Vn9XW0QdLLr/e8YMPPs3A318Lr7gVcFp5drHAboMaemW5yURS0oLAx6TvCd+SCwjzJX5FrzJoZ2O1jO+3OPCyjlapkTeC7TEpX/IZdJ+UFbyhcWBeC+zT0eJUpION1So2si7WkysV9qLPrQNbl2a8h8UE8dJQcqm9RZEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750355758; c=relaxed/simple;
	bh=SYjKbPsZzWTBPQPSXyX+CXzx5n5UoGWPVDeE3a2YoPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eem4q9MTOLJ/agWOCLwCkCjhuMwTVIARCxRnlHoQPVke0WKBM+fF9vPUnoVhPogi4b6J/pg41xO3pFU1XIJbDhfhkfoFUM9SLk8Pu/2bGer51TDt6HfFf7mOJK/UjleYTDTfsPeU9/tdZ3L2lj1kvKvUo2cwS/5qBcPp8/pVRwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m95zovZk; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7e7e4056-e2b8-41a5-a6b2-a2fbe0a94f4c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750355754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EtgKYGBD8XnCA4CkCmGywoXIEBd2GbqL6X0bRSIikNg=;
	b=m95zovZkH/B5W19xWC5cj8LhnlawottZq3MH/S44erR8gbzI5rX/TfJ0nYjq0QQ1ENIMNK
	4NKFwgYiV5W5G3Y4tHm5++esO+xCqNOY49J3ubLtTlNuieOyFXkMTz/nyJHRkcVMkxmAX6
	zy4lMUceWQXI8KXMdwBeX6Ou5d/std4=
Date: Thu, 19 Jun 2025 10:55:49 -0700
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <7852f30ba177dc5b811bb0840ca0f301df2a8b58.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/19/25 10:19 AM, Eduard Zingerman wrote:
> On Thu, 2025-06-19 at 10:09 -0700, Ihor Solodrai wrote:
> 
> [...]
> 
>> But then, does memset even make sense for xdp/skb buffers?
> 
> Why not?

I was thinking that in a BPF program you'd usually be reading xdp/skb
and not writing to it, especially not via memset. But never mind, I am
likely wrong.

> 
>> Maybe -ENOTSUPP is more appropriate?
>>
>> I'd appreciate any hints.
> 
> I think Mykyta has kernel/trace/bpf_trace.c:__bpf_dynptr_copy_str() in mind.

Thanks for the pointer. So it looks like memset can use
bpf_dynptr_slice_rdwr() to handle xdp/skb cases. Something like:

     void *ptr = bpf_dynptr_slice_rdwr(&dynptr, 0, buffer, sizeof(buffer));
     if (!ptr)
         return -EINVAL;

     memset(ptr, val, n);

     if (ptr == buffer)
         bpf_dynptr_write(&dynptr, 0, buffer, sizeof(buffer), 0);


> 



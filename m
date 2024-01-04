Return-Path: <bpf+bounces-18977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8528239FA
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 02:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 549C1B24143
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 01:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EED6A47;
	Thu,  4 Jan 2024 01:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bvUo284y"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC5517FF
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 01:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <841935e8-f075-4fc4-9f1b-3451ad6e1f98@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704330029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C8cZZ65nxuDVST1mRAUfU4KfY5+1nffLc/7+zliKh5A=;
	b=bvUo284ynge+xVHDnJynAJ2TxstucRpt8egnmso8BIlkTV6uLbmGZfNkVH5w3Om90J6azN
	qa6dIpYkx3C/uMOw+7wlJrhPLDtZ4SEQRMk52UK1XW9nkzWkaILIM8pxn9Uj1y2+GvZIRl
	TRxKFnR4FFRM9ZXqfkdYA7AUqHGjeW8=
Date: Wed, 3 Jan 2024 17:00:21 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 1/5] bpf: sockmap, fix proto update hook to avoid dup
 calls
Content-Language: en-US
To: Jakub Sitnicki <jakub@cloudflare.com>,
 John Fastabend <john.fastabend@gmail.com>
Cc: rivendell7@gmail.com, kuniyu@amazon.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20231221232327.43678-1-john.fastabend@gmail.com>
 <20231221232327.43678-2-john.fastabend@gmail.com>
 <87zfxoueqe.fsf@cloudflare.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <87zfxoueqe.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/2/24 4:00 AM, Jakub Sitnicki wrote:
> On Thu, Dec 21, 2023 at 03:23 PM -08, John Fastabend wrote:
>> When sockets are added to a sockmap or sockhash we allocate and init a
>> psock. Then update the proto ops with sock_map_init_proto the flow is
>>
>>    sock_hash_update_common
>>      sock_map_link
>>        psock = sock_map_psock_get_checked() <-returns existing psock
>>        sock_map_init_proto(sk, psock)       <- updates sk_proto
>>
>> If the socket is already in a map this results in the sock_map_init_proto
>> being called multiple times on the same socket. We do this because when
>> a socket is added to multiple maps this might result in a new set of BPF
>> programs being attached to the socket requiring an updated ops struct.
>>
>> This creates a rule where it must be safe to call psock_update_sk_prot
>> multiple times. When we added a fix for UAF through unix sockets in patch
>> 4dd9a38a753fc we broke this rule by adding a sock_hold in that path
>> to ensure the sock is not released. The result is if a af_unix stream sock
>> is placed in multiple maps it results in a memory leak because we call
>> sock_hold multiple times with only a single sock_put on it.
>>
>> Fixes: 4dd9a38a753fc ("bpf: sockmap, fix proto update hook to avoid dup calls")

The Fixes tag looks wrong ;)

I changed it to

Fixes: 8866730aed51 ("bpf, sockmap: af_unix stream sockets need to hold ref for 
pair sock")

>> Rebported-by: Xingwei Lee <xrivendell7@gmail.com>
> 
> Nit: Typo ^

yep. fixed.

Also added the missing "test_sockmap_pass_prog__destroy(skel)" to the 
sockmap_basic.c selftest.

Applied. Thanks for the fixes and the review.



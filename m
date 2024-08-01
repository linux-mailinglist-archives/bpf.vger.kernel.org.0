Return-Path: <bpf+bounces-36188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B505B943ACB
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 02:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6F5B1C21C80
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 00:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C745442067;
	Thu,  1 Aug 2024 00:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vjsaqGan"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E533D3B3
	for <bpf@vger.kernel.org>; Thu,  1 Aug 2024 00:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471079; cv=none; b=nqAYannfNUjwl1lXvrCp7Hjn6IbqekVzJAzF57kPZRN7BB16y4gUD5wCSsAJCqD46uzPWwvMHATjuHLIgPU3oRleNqTtvjR9iQIGmBTwEq7PCtS/vIJMZmTGL0/d4dpQ5/Qzd5uwmzQKsQpqDmVcJIw9c9HwtNOExmht555D9Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471079; c=relaxed/simple;
	bh=85OgHUdyCqY0ItNZ3IJZahu52+G0epiQ+yJHAn3o3xw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gv8b991GRXcdSXLorphJB6thGigHSd0cd7RG65bw7+7eAyGTJ5QhunpsIoOaxfERuHu2UCAraOAsO1r4DcS14iOrqUyHMGFCUZBAE5IxkBjKZrzyPXiicpC/SaNYsHxmVScVsEbPc2WiVf4y7Y5wvPolROw8U6vmaRyt7MhX1oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vjsaqGan; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <945a08e5-08fe-4906-a7df-ff4886ec99c0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722471074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NGo4GK0pzsPplOdHCGKkrO1tFXNojZBQvx88ssfDSrM=;
	b=vjsaqGanBRjh0b2i7tX3s8qdIIupca0hoVnDmySTzErmr2k+qN8868tc8gVU0iVnTtAvmS
	eA+NweMeYmm/qtq/yvQauI/8LRH0M6KJakdFLmkLNRZEUnI6NW6qeeHkfcVT0n6RrjWClq
	LOdN1P9TlSVrdGj4sv6/ofwaXf56gsY=
Date: Wed, 31 Jul 2024 17:11:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next 0/4] Support bpf_kptr_xchg into local kptr
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 alexei.starovoitov@gmail.com, martin.lau@kernel.org, sinquersw@gmail.com,
 davemarchevsky@fb.com, Amery Hung <amery.hung@bytedance.com>
References: <20240728030115.3970543-1-amery.hung@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20240728030115.3970543-1-amery.hung@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/27/24 8:01 PM, Amery Hung wrote:
> This series allows stashing kptr into local kptr. Currently, kptrs are
> only allowed to be stashed into map value with bpf_kptr_xchg(). A
> motivating use case of this series is to enable adding referenced kptr to
> bpf_rbtree or bpf_list by using allocated object as graph node and the
> storage of referenced kptr. For example, a bpf qdisc [0] enqueuing a
> referenced kptr to a struct sk_buff* to a bpf_list serving as a fifo:
> 
>      struct skb_node {
>              struct sk_buff __kptr *skb;
>              struct bpf_list_node node;
>      };
> 
>      private(A) struct bpf_spin_lock fifo_lock;
>      private(A) struct bpf_list_head fifo __contains(skb_node, node);
> 
>      /* In Qdisc_ops.enqueue */
>      struct skb_node *skbn;
> 
>      skbn = bpf_obj_new(typeof(*skbn));
>      if (!skbn)
>          goto drop;
> 
>      /* skb is a referenced kptr to struct sk_buff acquired earilier
>       * but not shown in this code snippet.
>       */
>      skb = bpf_kptr_xchg(&skbn->skb, skb);
>      if (skb)
>          /* should not happen; do something below releasing skb to
>           * satisfy the verifier */
>      	...
>      
>      bpf_spin_lock(&fifo_lock);
>      bpf_list_push_back(&fifo, &skbn->node);
>      bpf_spin_unlock(&fifo_lock);
> 
> The implementation first searches for BPF_KPTR when generating program
> BTF. Then, we teach the verifier that the detination argument of
> bpf_kptr_xchg() can be local kptr, and use the btf_record in program BTF
> to check against the source argument.
> 
> This series is mostly developed by Dave, who kindly helped and sent me
> the patchset. The selftests in bpf qdisc (WIP) relies on this series to
> work.

The set lgtm. With the doc fix in the bpf_kptr_xchg, you can carry my Ack.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>



Return-Path: <bpf+bounces-46824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C9E9F04CC
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 07:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906AE188B5FE
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 06:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C038918C32C;
	Fri, 13 Dec 2024 06:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="px9b5b89"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DD517DFEC;
	Fri, 13 Dec 2024 06:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734071339; cv=none; b=gi43yPMRxj3pVCSQPS4uVt7T43NkhntTzPYz6enG33TJw48F3L2Mo8Tnh3lv/lrJK4ekYtgN9dlo7y4Jh9d+IslplJjTdToxaQzWcG61WQq2iw0tfTRH8WZtVplTo/OMXN+GMOxInftvKAjX0jtRK5IK2zK0c35e4AGQd/lkb4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734071339; c=relaxed/simple;
	bh=GT9KHxhT7dWBtl1fCwn5oG7rssg5BSs2VONzKFsXwk4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=K6C+PLaqNe4tFXof/0gAyyg5PcPxJzsiS3mkigQfpTjUuQUf7avBWinhQ3U2RYQIQhHEiB69twLJrv8Ucw7JVHWkXZ46kp8cljakUqHiM0dSrQSa5/qNqCgJ7uno2wgIf5PnsLaK/lXJKuCRepCyQ+5qzNUCHeFzDfrVGzExS0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=px9b5b89; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <eba3a270-7d0d-424d-91be-296224d51539@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734071334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+9NBkHKV1KyNgihAh7rpYI4AJ9VXtHm+P9snLeFIj/0=;
	b=px9b5b89YwV+AKBC27BcUAd9z5CjaZwQztaBDewWHYXPiw032LWxGL4gnbVuU2U6mxJWQo
	62op9asNEOt0J16W1x59NSHDDOmgN2DCQAbV6ZWTyWTQemRUGmfJzFRdT1E8PabRZRQLRu
	sz+PYRkE2INN7GcR94GWu90HJynKsm0=
Date: Thu, 12 Dec 2024 22:28:41 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 07/11] net-timestamp: support hwtstamp print
 for bpf extension
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
 <20241207173803.90744-8-kerneljasonxing@gmail.com>
 <a3abb0b6-cd94-46f6-b996-f90da7e790b9@linux.dev>
Content-Language: en-US
In-Reply-To: <a3abb0b6-cd94-46f6-b996-f90da7e790b9@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 12/12/24 3:25 PM, Martin KaFai Lau wrote:
> A more subtle thing for the hwtstamps case is, afaik the bpf prog will not be 
> called. All drivers are still only testing SKBTX_HW_TSTAMP instead of testing
> (SKBTX_HW_TSTAMP | SKBTX_BPF).
> 
> There are a lot of drivers to change though. A quick thought is to rename the 
> existing SKBTX_HW_TSTAMP (e.g. __SKBTX_HW_TSTAMP = 1 << 0) and define 
> SKBTX_HW_TSTAMP like:
> 
> #define SKBTX_HW_TSTAMP (__SKBTX_HW_TSTAMP | SKBTX_BPF)
> 
> Then change some of the existing skb_shinfo(skb)->tx_flags "setting" site to use 
> __SKBTX_HW_TSTAMP instead. e.g. in __sock_tx_timestamp(). Not very pretty but 
> may be still better than changing many drivers. May be there is a better way...
> 
> While talking about where to test the SKBTX_BPF bit, I wonder if the new 
> skb_tstamp_is_set() is needed. For the non SKBTX_HW_TSTAMP case, the number of 
> tx_flags testing sites should be limited, so should be easy to add the SKBTX_BPF 
> bit test. e.g. at the __dev_queue_xmit, test "if (unlikely(skb_shinfo(skb)- 
>  >tx_flags & (SKBTX_SCHED_TSTAMP | SKBTX_BPF)))". Patch 6 has also tested the 
> bpf specific bit at tcp_ack_tstamp() before calling the __skb_tstamp_tx().
> 
> At the beginning of __skb_tstamp_tx(), do something like this:
> 
> void __skb_tstamp_tx(struct sk_buff *orig_skb,
>               const struct sk_buff *ack_skb,
>               struct skb_shared_hwtstamps *hwtstamps,
>               struct sock *sk, int tstype)
> {
>      if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
>          unlikely(skb_shinfo(skb)->tx_flags & SKBTX_BPF))
>          __skb_tstamp_tx_bpf(sk, orig_skb, hwtstamps, tstype);
> 
>      if (unlikely(!(skb_shinfo(skb)->tx_flags & ~SKBTX_BPF)))

This is not enough. I was wrong here. The test in skb_tstamp_is_set() is needed 
when SKBTX_BPF is not set.

>          return;



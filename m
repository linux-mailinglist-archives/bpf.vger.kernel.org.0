Return-Path: <bpf+bounces-48511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E58A084FC
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 02:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D973168D90
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 01:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A9413F43A;
	Fri, 10 Jan 2025 01:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="whqpLzeZ"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2138441AAC
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 01:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736473436; cv=none; b=kZ8nRLVPlc1RkFzlmbgFa2G6OWOz4Uk58Wz55zdYNd9EqKDZxtjM3E3CFdlpr5YP0bmqbqyoP6g4ST6HqqODeA/HVzoR7vD+f37hn3KhigRO9qrt/P2BGnNtvTzhHughn0TaDHrSMBacLuNjcJkTSmFP0aZG52d7L65Af7SBwhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736473436; c=relaxed/simple;
	bh=8JnBP19d9w1bWLjuAow8jNbFkDHO6o1yW3KwujPpU/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=stqPWHLwN9ZmHDvT1JDCgUsCQoNfL22g0vZYxBBOuttuwu87xebKvj7CqHxKDc8YnXSCyTniCpcg+0pGIRGNUFoN9XQCTQNkro+05hUY0oO5eIeXgXaDboY1FwlbTaYQZKXHQvO04S8xY7kinfT64XtUTju7QuJTKQ+vS4TXlSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=whqpLzeZ; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1292dc51-4ca1-45c0-8a7c-78d325530531@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736473432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a8R/Ifde+clfmwPosLqJI0YLaYlt8evsINovbOJnMUI=;
	b=whqpLzeZ0b3io7r3H8+VPXwqX086ELdKF07/Rg7x0tV8D2X+y54PIx8+djO6aNe2zzKslx
	1RndiKgkT/ShCAoFVhESctSBFkRR0crg/gNzBb2l6mdckzbYrUZtzxYy4w+8PjQgXC76Ef
	kkq8IIeLbUBLs7MTO0ONKX1Ilx3nIaE=
Date: Thu, 9 Jan 2025 17:43:46 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 00/14] bpf qdisc
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, alexei.starovoitov@gmail.com, martin.lau@kernel.org,
 sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us,
 stfomichev@gmail.com, ekarani.silvestre@ccc.ufcg.edu.br,
 yangpeihao@sjtu.edu.cn, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
References: <20241220195619.2022866-1-amery.hung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241220195619.2022866-1-amery.hung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 12/20/24 11:55 AM, Amery Hung wrote:
> The implementation of bpf_fq is fairly complex and slightly different from
> fq so later we only compare the two fifo qdiscs. bpf_fq implements the
> same fair queueing algorithm in fq, but without flow hash collision
> avoidance and garbage collection of inactive flows. bpf_fifo uses a single

For hash collision, I think you meant >1 tcp_socks having the same hash in patch 
14? This probably could be detected by adding the sk pointer value to the 
bpf-map key? not asking to change patch 14 though.

For garbage collection, I think patch 14 has it but yes it is iterating the bpf 
map, so not as quick as doing gc while searching for the sk in the rbtree. I 
think the only missing piece is being able to iterate the bpf_rb_root, i.e. able 
to directly search left and right of a bpf_rb_node.

> bpf_list as a queue instead of three queues for different priorities in
> pfifo_fast. The time complexity of fifo however should be similar since the
> queue selection time is negligible.
> 
> Test setup:
> 
>      client -> qdisc ------------->  server
>      ~~~~~~~~~~~~~~~                 ~~~~~~
>      nested VM1 @ DC1               VM2 @ DC2
> 
> Throghput: iperf3 -t 600, 5 times
> 
>        Qdisc        Average (GBits/sec)
>      ----------     -------------------
>      pfifo_fast       12.52 ± 0.26
>      bpf_fifo         11.72 ± 0.32
>      fq               10.24 ± 0.13
>      bpf_fq           11.92 ± 0.64
> 
> Latency: sockperf pp --tcp -t 600, 5 times
> 
>        Qdisc        Average (usec)
>      ----------     --------------
>      pfifo_fast      244.58 ± 7.93
>      bpf_fifo        244.92 ± 15.22
>      fq              234.30 ± 19.25
>      bpf_fq          221.34 ± 10.76
> 
> Looking at the two fifo qdiscs, the 6.4% drop in throughput in the bpf
> implementatioin is consistent with previous observation (v8 throughput
> test on a loopback device). This should be able to be mitigated by
> supporting adding skb to bpf_list or bpf_rbtree directly in the future.
> 
> * Clean up skb in bpf qdisc during reset *
> 
> The current implementation relies on bpf qdisc implementors to correctly
> release skbs in queues (bpf graphs or maps) in .reset, which might not be
> a safe thing to do. The solution as Martin has suggested would be
> supporting private data in struct_ops. This can also help simplifying
> implementation of qdisc that works with mq. For examples, qdiscs in the
> selftest mostly use global data. Therefore, even if user add multiple
> qdisc instances under mq, they would still share the same queue.

Although not as nice as priv_data, I think mq setup with a dedicated queue can 
be done with bpf map-in-map.

For the cleanup part, it is similar to how the bpf kptr is cleaned up, either 
the bpf program frees it or the bpf infra will eventually clean it up during the 
bpf map destruction.

For priv_data, I think it could be a useful addition to the bpf_struct_ops. 
Meaning it should also work for struct_ops other than Qdisc_ops. Then all 
destruction and free could be done more automatically and seamlessly.

imo, the above improvements can be iterated later on top of the core pieces of 
this set.



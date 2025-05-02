Return-Path: <bpf+bounces-57176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C09AA67AE
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 02:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F825179042
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 00:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D467423B0;
	Fri,  2 May 2025 00:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ieSWIZNb"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463DE33DB
	for <bpf@vger.kernel.org>; Fri,  2 May 2025 00:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746144850; cv=none; b=u9fasrzqk/un7/DOrB7MbvjsBiyX1ogHHXCW6s880/0omGBWaHU+5H19G1C7D9jvrM1fY4U23KxuYj+meltF9zdt5EK78FU4LNY0J/kOnbl1XOMA1reHH0HpwfJ3ARRxGl4sdjBt/+8oH46VmlyZjq/AkjM92Gqz0qy+RPt2yT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746144850; c=relaxed/simple;
	bh=VQLRhFRdfvWzZQ7KcRtiX4AJZdrlr3vdVrdSRB/ywE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LVKWFMMUpi46nBr2WMvDWID6AXT2JIsETPyAUDVCCKtFwv42rhFAZmyAK9Olht10WMVlBwKJAks1tXPJTPC7hmoRpT3GnY5slt1KD+KGxLJhJPEb+xYJeGpoRaHlyMN9TIA4eGCM0w/8nCA9eOsEph+NCKmQu3axq5hCH9H8xJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ieSWIZNb; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <507f8523-74ac-4250-a9d2-3942e11b6f74@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746144835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=31Typsk0NogO5wM4BwN5w2BYXQgCrT3yMVuwvKtrTvE=;
	b=ieSWIZNbyhCG5hc6Oe1P1D1/jLFmdEb63T9T2vRu4nSuUkTbm7ka6ZreCSd7RJ4Ub+Jpr5
	ik6QZxW9W97W2lvB/5VfeIre4fA0cq8kE3bf4qMB8KEt4uMwqPRY4oX8R64a2Xo4Hn5rpd
	7XSAX6dWbfzXqntYSxrXN6f7m9nini8=
Date: Thu, 1 May 2025 17:13:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next/net v1 3/5] bpf: net_sched: Make some Qdisc_ops
 ops mandatory
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, xiyou.wangcong@gmail.com, kernel-team@meta.com
References: <20250501223025.569020-1-ameryhung@gmail.com>
 <20250501223025.569020-4-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250501223025.569020-4-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/1/25 3:30 PM, Amery Hung wrote:
> The patch makes all currently supported Qdisc_ops (i.e., .enqueue,
> .dequeue, .init, .reser, and .destroy) mandatory.

s/reser/reset/.

> 
> Make .init, .reset and .destroy mandatory as bpf qdisc relies on prologue
> and epilogue to check attach points and correctly initialize/cleanup
> resources. The prologue/epilogue will only be generated for an struct_ops
> operator only if users implement the operator.
> 
> Make .enqueue and .dequeue mandatory as bpf qdisc infra does not provide
> a default data path.
> 
> Fixes: Fixes: c8240344956e ("bpf: net_sched: Support implementation of Qdisc_ops in bpf")
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>   net/sched/bpf_qdisc.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
> index a8efc3ff2b7e..7ea8b54b2ab1 100644
> --- a/net/sched/bpf_qdisc.c
> +++ b/net/sched/bpf_qdisc.c
> @@ -395,6 +395,17 @@ static void bpf_qdisc_unreg(void *kdata, struct bpf_link *link)
>   	return unregister_qdisc(kdata);
>   }
>   
> +static int bpf_qdisc_validate(void *kdata)
> +{
> +	struct Qdisc_ops *ops = (struct Qdisc_ops *)kdata;
> +
> +	if (!ops->enqueue || !ops->dequeue || !ops->init ||
> +	    !ops->reset || !ops->destroy)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>   static int Qdisc_ops__enqueue(struct sk_buff *skb__ref, struct Qdisc *sch,
>   			      struct sk_buff **to_free)
>   {
> @@ -432,6 +443,7 @@ static struct bpf_struct_ops bpf_Qdisc_ops = {
>   	.verifier_ops = &bpf_qdisc_verifier_ops,
>   	.reg = bpf_qdisc_reg,
>   	.unreg = bpf_qdisc_unreg,
> +	.validate = bpf_qdisc_validate,
>   	.init_member = bpf_qdisc_init_member,
>   	.init = bpf_qdisc_init,
>   	.name = "Qdisc_ops",



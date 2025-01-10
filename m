Return-Path: <bpf+bounces-48495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F86A08402
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 01:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 370AF162D71
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 00:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957B429CF0;
	Fri, 10 Jan 2025 00:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OB4kyZij"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4677C38DD6
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 00:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736468909; cv=none; b=YZ5iqVLY80DGFlZe7uP2K9qAdbUo9GGZjJdNxkqx5Vb9iFQIUTlpoL0H/w0dADihyo525+urw261xp/aB/7cb2EOasLRTsa+g0A3trGmZYt4bBj95EVnr64uxBf7GvlspCS5ORBd42s9EDq/DwjvycRglCpmFvlBy/uVkUECyTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736468909; c=relaxed/simple;
	bh=H7H+E1zQIOwIrg3Sj1sOWdKQeVZ5YLM60Lk74uL/Lso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M4cRSq3oQ1zPdyvP8G6R2cjYvgUMBnZPmMXziGBnU1nFi2RFghDm02qJb8n80d4skB0qdfwNVG5Xt2QKFlfqgwmPoNgmpPNRPjO1nD94WrHBdrUg8opXTZnQfM8KUoYkEgCfK9w4YOuPvtwNDTCKTdQ5JcZPzPVSlYxMkc/gUWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OB4kyZij; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <06c1d122-f145-4461-9597-13f5b45367b6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736468905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SqkvwdFA/zLCFS4qjtqosqWbhjFndiwKtnK3xGz1uXs=;
	b=OB4kyZijSkPeQJHq8Fl+CEI6PsNnS1bCyJ+EE4KCe1ThlrMMLsvsyfZm9Cq8fCjmACxpq0
	3nKHNP4QtC++EKZY2rOTRAbC0WD3AJRsVHLiYEoDlJOd45XyOdLeslox23FOCsWv5Mm2Mn
	ukNwReuHIf/aIEuEpggKjpkkHhqhvyw=
Date: Thu, 9 Jan 2025 16:28:20 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 05/14] bpf: net_sched: Support implementation
 of Qdisc_ops in bpf
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, alexei.starovoitov@gmail.com, martin.lau@kernel.org,
 sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us,
 stfomichev@gmail.com, ekarani.silvestre@ccc.ufcg.edu.br,
 yangpeihao@sjtu.edu.cn, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
References: <20241220195619.2022866-1-amery.hung@gmail.com>
 <20241220195619.2022866-6-amery.hung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241220195619.2022866-6-amery.hung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/20/24 11:55 AM, Amery Hung wrote:
> +static const struct bpf_func_proto *
> +bpf_qdisc_get_func_proto(enum bpf_func_id func_id,
> +			 const struct bpf_prog *prog)
> +{
> +	switch (func_id) {
> +	case BPF_FUNC_tail_call:

Since it needs a respin, a comment will be useful here to explain why tail_call 
is excluded.

> +		return NULL;
> +	default:
> +		return bpf_base_func_proto(func_id, prog);
> +	}
> +}



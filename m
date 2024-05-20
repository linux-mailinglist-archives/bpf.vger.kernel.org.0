Return-Path: <bpf+bounces-30069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5BB8CA53F
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 01:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3FCA281C31
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 23:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9ED81386BD;
	Mon, 20 May 2024 23:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MTdmrQfE"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BC94C3D0
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 23:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716249209; cv=none; b=pbqv4NbyMz9r0xySc1AzTfMFN4PBBjQWcHiZeI/b0ebE7bYyWHXdP6O/GuBXeGBfhx8xnr/f3sdP4TXNKQL6QZnozF+qczLjjTLdDq3TRtklIIFl6UOVUi6uqu4BcE35Nearj+vxMEzaWft6EeRg1xJ7H2JZpBL29pKSP+YTns4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716249209; c=relaxed/simple;
	bh=x+EKiowODG5X+fkqOSbqrJoIHtEXFXTbIPAPqy4yU3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gZDnHXUaIOfMCoGVygeKfO/vIDINNS1fHu9pel/VpAAGX6Vo3aCW+uDZ4uZ05eivRP637KCSGEV/q6q9XQ+TQZ9aGRIWb/9ZH7PhnxfRNpaZiAx4a7Q2lws/aDDkULlxliCTMcaVsDpcds6hY/Mk+5sr+lqc2B1f3R7rc8ZD3+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MTdmrQfE; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: brad@faucet.nz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716249204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IG3pDjesBduiqqkxCNEFP3pxyRLYTneq5hI70cFf9HY=;
	b=MTdmrQfEmestsFfWkLhC7ayTjwN+7sZBz1w/BYhhzAwVvC3X50MA7HutkGqSppNqmvnTIh
	Qc5KkB2oUpEyQYcGYLUZgSy2Eu7OKF/Bch/X5Bv/bHqe8ulbI9g9SSyNewkQkwvDus3Aox
	iHRn/KIpQntNqnyso2GgowrZLrOINAI=
X-Envelope-To: lorenzo@kernel.org
X-Envelope-To: memxor@gmail.com
X-Envelope-To: pablo@netfilter.org
X-Envelope-To: davem@davemloft.net
X-Envelope-To: kuba@kernel.org
X-Envelope-To: pabeni@redhat.com
X-Envelope-To: ast@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: andrii@kernel.org
X-Envelope-To: song@kernel.org
X-Envelope-To: john.fastabend@gmail.com
X-Envelope-To: sdf@google.com
X-Envelope-To: jolsa@kernel.org
X-Envelope-To: netfilter-devel@vger.kernel.org
X-Envelope-To: coreteam@netfilter.org
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: bpf@vger.kernel.org
Message-ID: <e160d17a-cc09-4548-9542-84886a40fe3d@linux.dev>
Date: Mon, 20 May 2024 16:52:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Update tests for new ct
 zone opts for nf_conntrack kfuncs
To: Brad Cowie <brad@faucet.nz>
Cc: lorenzo@kernel.org, memxor@gmail.com, pablo@netfilter.org,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
 john.fastabend@gmail.com, sdf@google.com, jolsa@kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20240508043033.52311-1-brad@faucet.nz>
 <20240508050450.88356-1-brad@faucet.nz>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240508050450.88356-1-brad@faucet.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/7/24 10:04 PM, Brad Cowie wrote:
> @@ -84,16 +102,6 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
>   	else
>   		test_einval_bpf_tuple = opts_def.error;
>   
> -	opts_def.reserved[0] = 1;
> -	ct = lookup_fn(ctx, &bpf_tuple, sizeof(bpf_tuple.ipv4), &opts_def,
> -		       sizeof(opts_def));
> -	opts_def.reserved[0] = 0;
> -	opts_def.l4proto = IPPROTO_TCP;
> -	if (ct)
> -		bpf_ct_release(ct);
> -	else
> -		test_einval_reserved = opts_def.error;
> -
>   	opts_def.netns_id = -2;
>   	ct = lookup_fn(ctx, &bpf_tuple, sizeof(bpf_tuple.ipv4), &opts_def,

This non-zero reserved[0] test is still valid and useful. How about create a new 
test_einval_reserved_new for testing the new struct?

pw-bot: cr

[ Sorry for the delay. I have some backlog. ].


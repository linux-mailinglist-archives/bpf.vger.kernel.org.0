Return-Path: <bpf+bounces-64229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFDEB0FE84
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 03:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 580E8189C1B5
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 01:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628377261B;
	Thu, 24 Jul 2025 01:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W0esKhkm"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B0C14286
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 01:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753322108; cv=none; b=pyuQNkH0JR7MhiyvTW5cORQZQ1nNctEYnj3dMbwviEQzLz0yymhubnDy0Nk9LFlP2shgjFJMq2neVAqvjEGWDHIpQhiUO2wWrnGahhb1RJs1P/qBFkIQVhQM5KA05xhUkFhqu/8PQ1WYN731r4t2WYapcHDoj8mDZmTfKIZhOjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753322108; c=relaxed/simple;
	bh=ERYptIooa6KVqJDSuiuJ1j1cS6DJrh2n44YU1dp15C8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RdflId4ndmbCMQZR9hI+BaHGgw1drPNHINL7Jeb3BEYEv3Vw/FyKiMQFv+raLzN05QwBi9lQ9JfwEiClRkxZMhNYuKMHDSfiC0kx9fAEBv7aPewpqd0r5/48yFU6JnEcZ4I+RCn0dURcGrzdAdqED8zKOu/2m06CRyOxfE75cPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W0esKhkm; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <00a19156-cf90-48ca-be91-6c218b317044@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753322101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dKuQF9X8Irn5130fOMdphl2+d/j6lxb9FyrQnQYALog=;
	b=W0esKhkm9fSTfe41Mh1DxLnwU5r7t+z2ExW+zg8kd3+CGZZQPRTQ2O1X9RQqkuHWru6Y/h
	VryOgi/ZXU1TNbCpX265lteUjWp22o454H5dZs8a4wv7c6ViQaYbKba5qtv03E51FYKtAH
	Gt6hyjRoj2HhoEVmj14mysWOqUgYPVU=
Date: Wed, 23 Jul 2025 18:54:53 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 1/8] bpf: Add dynptr type for skb metadata
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Arthur Fabre <arthur@arthurfabre.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Jesse Brandeburg <jbrandeburg@cloudflare.com>,
 Joanne Koong <joannelkoong@gmail.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <thoiland@redhat.com>, Yan Zhai <yan@cloudflare.com>,
 kernel-team@cloudflare.com, netdev@vger.kernel.org,
 Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org
References: <20250723-skb-metadata-thru-dynptr-v4-0-a0fed48bcd37@cloudflare.com>
 <20250723-skb-metadata-thru-dynptr-v4-1-a0fed48bcd37@cloudflare.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250723-skb-metadata-thru-dynptr-v4-1-a0fed48bcd37@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/23/25 10:36 AM, Jakub Sitnicki wrote:
> More importantly, it abstracts away the fact where the storage for the
> custom metadata lives, which opens up the way to persist the metadata by
> relocating it as the skb travels through the network stack layers.
> 
> A notable difference between the skb and the skb_meta dynptr is that writes
> to the skb_meta dynptr don't invalidate either skb or skb_meta dynptr
> slices, since they cannot lead to a skb->head reallocation.

There is not much visibility on how the metadata will be relocated, so trying to 
think out loud. The "no invalidation after bpf_dynptr_write(&meta_dynptr, ..." 
behavior will be hard to change in the future. Will this still hold in the 
future when the metadata can be preserved?

Also, following up on Kuba's point about clone skb, what if the bpf prog wants 
to write metadata to a clone skb in the future by using bpf_dynptr_write?


Return-Path: <bpf+bounces-36981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E216994FB1D
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 03:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C98728246C
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 01:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D53D125B9;
	Tue, 13 Aug 2024 01:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNC79f9S"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E78C1173F;
	Tue, 13 Aug 2024 01:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723512790; cv=none; b=lCGe7l/eZi8c9QVkULbL1dEv9Uk4e4tV+cgsZM3X3yp9/YNyNoAeVibrQY3HS2cGHe5gMa1MupM58OhlGtLPw50LVY8bQWM+6r2BkN7p5KYQJU3LwnU7MciG4FBqNaYObKYq0MEOyCFVAg6yA6ibX8JYT4BjJhp1KlWAMRZLrKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723512790; c=relaxed/simple;
	bh=QnIqOdRlXgAHdeoAf7GYTXyIHrTOC2FQsadg/IU5oao=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cyJfrCjT7rIfXdKIZWfCTBCOkGn10fwN9OyuzbP5DAWEXyQuwDUG/MNCz/eTjD3WXR7DSk9RWalylyJDWg94O7tUlxE5NjjN/5F1myRGvJ6U5mDEhuYE7ZdZ9qw3znUNKTiMJ3wbl4U2ZfdUZKrUsFXKX7qra/n6HebOHZeZP/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNC79f9S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB440C4AF0D;
	Tue, 13 Aug 2024 01:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723512789;
	bh=QnIqOdRlXgAHdeoAf7GYTXyIHrTOC2FQsadg/IU5oao=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JNC79f9SFF/uTToB2JU5w06EhaOeyvBP1g+a/QkZXX2U0zndkfsnqanPW1WnIOy7N
	 pWjeXgr+S1MQ1I2CxuyT7h4MVKYWy1XkQIyYFkZbLcJgjVem9BBNE7hApxsUbyIW4D
	 fotFmXmg0jMSQV3xTFvwDxwOFsCOEnqk9fKzDnjzuLhLmJD4drMzpg4SNxPqOtaq9x
	 PZss4uxEzxQPR/zqAs/apU3pqdkhPMTQHUSv/Tq03DI6AXO6eqzVAC3/c/42rgWpzp
	 G/FolFxrX4CGGBzSNe23OLdLUnyqEKQcDD61xkxxfO0bajuAd7AxN3WQT8yyd31864
	 EH8vANEWrqFmA==
Date: Mon, 12 Aug 2024 18:33:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, Lorenzo Bianconi
 <lorenzo.bianconi@redhat.com>, Alexander Lobakin
 <alexandr.lobakin@intel.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Larysa Zaremba <larysa.zaremba@intel.com>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
 "toke@redhat.com" <toke@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, "Jesse Brandeburg"
 <jesse.brandeburg@intel.com>, John Fastabend <john.fastabend@gmail.com>,
 Yajun Deng <yajun.deng@linux.dev>, "Willem de Bruijn" <willemb@google.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <xdp-hints@xdp-project.net>
Subject: Re: [xdp-hints] Re: [PATCH RFC bpf-next 32/52] bpf, cpumap: switch
 to GRO from netif_receive_skb_list()
Message-ID: <20240812183307.0b6fbd60@kernel.org>
In-Reply-To: <99662019-7e9b-410d-99fe-a85d04af215c@intel.com>
References: <20220628194812.1453059-1-alexandr.lobakin@intel.com>
	<20220628194812.1453059-33-alexandr.lobakin@intel.com>
	<cadda351-6e93-4568-ba26-21a760bf9a57@app.fastmail.com>
	<ZrRPbtKk7RMXHfhH@lore-rh-laptop>
	<54aab7ec-80e9-44fd-8249-fe0cabda0393@intel.com>
	<308fd4f1-83a9-4b74-a482-216c8211a028@app.fastmail.com>
	<99662019-7e9b-410d-99fe-a85d04af215c@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Aug 2024 14:20:25 +0200 Alexander Lobakin wrote:
> But I think one solution could be:
> 
> 1. We create some generic structure for cpumap, like
> 
> struct cpumap_meta {
> 	u32 magic;
> 	u32 hash;
> }
> 
> 2. We add such check in the cpumap code
> 
> 	if (xdpf->metalen == sizeof(struct cpumap_meta) &&
> 	    <here we check magic>)
> 		skb->hash = meta->hash;
> 
> 3. In XDP prog, you call Rx hints kfuncs when they're available, obtain
> RSS hash and then put it in the struct cpumap_meta as XDP frame metadata.

I wonder what the overhead of skb metadata allocation is in practice.
With Eric's "return skb to the CPU of origin" we can feed the lockless
skb cache one the right CPU, and also feed the lockless page pool
cache. I wonder if batched RFS wouldn't be faster than the XDP thing
that requires all the groundwork.


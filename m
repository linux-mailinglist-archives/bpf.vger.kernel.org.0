Return-Path: <bpf+bounces-38893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9781196C138
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 16:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39DE61F28EC8
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 14:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D2F1DC758;
	Wed,  4 Sep 2024 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHhQdDf5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B5B1DA615;
	Wed,  4 Sep 2024 14:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461443; cv=none; b=g4exwinoF8cZsioZ91MTIdlqNp/+55t6YV4i3D7tZ3D2nyXkosrz91zasuaD5TQ1YpNYSjzCPxLlQwdlpOgRhwwkr3jpy3viS9mdZBd5ffOUk/m8Qg9Ut1znCy/k0YekqyDS48LeZu/m/n6bYRbudebsf0rDot8wDLKgfOA13tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461443; c=relaxed/simple;
	bh=ukeqxhO1obIwTHM5ZY+i9YNkjOAtmi1Vi+FHIuSy0Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=deHT1sohVHcpOn+6AQfWXAAIVh1DqwiXqOIzcE4+wAJsa+rgpClltFBpfmLooMwj2olEu2YZRwO+Log6yi2rWvjWAMO9cUO8MZ/mOlHZxE/WwD99dqJ/CwZ2VQlThqrLPJUn9+NdHcIzJesQdKTi7qO0yANmJO0W7eZduTlnRF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHhQdDf5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECEAC4CEC2;
	Wed,  4 Sep 2024 14:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725461443;
	bh=ukeqxhO1obIwTHM5ZY+i9YNkjOAtmi1Vi+FHIuSy0Gs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rHhQdDf5HiQKlFFtvv7GfMt/ybYoitidJAyQVBuqEc2VONvmxLoo4EdS3CW8vEEic
	 IrCD1N7Llr5k8MSj89UGWuyt7FO0ZgT78MLvNRnXlmHZq7nfsi4uEi8OWVuqHhPWeh
	 /hEBRO3HcdRBdwDc322Va2p676UqsYpx5NMFImAOFwavnYiAd5zOfU0hiMBrw6eeSd
	 w9qpwt/29S4H/QKwjMW48F/yfxaJ2zKYvqnBk32wv5BJ5yt4BxSTUO4AzdQwkae3VU
	 c4oXRSeP6PPIBaZdO8Khbd2JmqsbUdiKak7Z0U+zzHe3Ng2JUQolrJ9FGVa4/hfDBH
	 yalW/53ytbF+Q==
Date: Wed, 4 Sep 2024 07:50:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, John Fastabend
 <john.fastabend@gmail.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 0/9] bpf: cpumap: enable GRO for XDP_PASS
 frames
Message-ID: <20240904075041.2467995c@kernel.org>
In-Reply-To: <f23131c1-aae2-4c04-a60e-801ed1970be8@intel.com>
References: <20240830162508.1009458-1-aleksander.lobakin@intel.com>
	<20240903135158.7031a3ab@kernel.org>
	<f23131c1-aae2-4c04-a60e-801ed1970be8@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Sep 2024 15:13:54 +0200 Alexander Lobakin wrote:
> > Could you try to use the backlog NAPI? Allocating a fake netdev and
> > using NAPI as a threading abstraction feels like an abuse. Maybe try
> > to factor out the necessary bits? What we want is using the per-cpu 
> > caches, and feeding GRO. None of the IRQ related NAPI functionality
> > fits in here.  
> 
> Lorenzo will try as he wrote. I can only add that in my old tree, I
> factored out GRO bits and used them here just as you wrote. The perf was
> the same, but the diffstat was several hundred lines only to factor out
> stuff, while here the actual switch to NAPI removes more lines than
> adds, also custom kthread logic is gone etc. It just looks way more
> elegant and simple.

Once again we seem to be arguing whether lower LoC is equivalent to
better code? :) If we can use backlog NAPI it hopefully won't be as
long. Maybe other, better approaches are within reach, too.

> I could say that gro_cells also "abuses" NAPI the same way, don't you
> think?

"same way"? :] Does it allocate a fake netdev, use NAPI as a threading
abstraction or add extra fields to napi_struct ? 
If other maintainers disagree I won't be upset, but I'm worried
that letting NAPI grow into some generic SW abstraction with broad 
use cases will hinder the ongoing queue config efforts.

> But nobody ever objected :>


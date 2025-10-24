Return-Path: <bpf+bounces-71977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C4BC0416B
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 04:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC9C43B79B4
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 02:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA3423909C;
	Fri, 24 Oct 2025 02:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d78CWoEo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581DE222590;
	Fri, 24 Oct 2025 02:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761271733; cv=none; b=TxOvo4cKS4zog2AeBUAVWnXQZJjPtyJNg1rBzHIApks+k453IzFR84HAeyw3ZtYc3qyB9OX0Wx24JPe1JwNphh9BuvSXvPakvjcjX3mO9QbQWtUQnHEIqPeTMbgf7JWZVhgSRhPLOke6TFX3bOkOtwKL7e0ALsBVKtuxrioVlPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761271733; c=relaxed/simple;
	bh=xdb0qdmUX2sKmoaupBQ4qSQ0D/Kl54pOe1oxYSzbZU0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LIxz2ymW25G9b8SqZuuqAWqw2wYE8aeMXTv8x/mCSs6K98zyGosZ9+3LV6/YMDnFtawpfrV2g8/10DowAY0zx2DHOY6O8SdEqqt2oFUqLk/JsO0HtASqeswvzLIurkFKIZQYTP+vzc6hWDYqYWNjXN/ifZm4pIoJUh2Txegt6SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d78CWoEo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D70DC4CEE7;
	Fri, 24 Oct 2025 02:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761271732;
	bh=xdb0qdmUX2sKmoaupBQ4qSQ0D/Kl54pOe1oxYSzbZU0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d78CWoEogpxSuy5vVn7RfkcQ5IpGal6BxAIFRDVh6o15RtVt5ygsBbt0ae5asJE8X
	 KihKsQAfIkOJmrheKdYSqyOwr5W5Wvv8a5UivzkxGQCz3EMzOMqQFl5Hy23I5QkmBi
	 MaA+ktaq4xa/nmqdOihE7D/a1WhnQ60HaSXCxx0sqXFw/UBPhW3iLQK6PEdbptuIuv
	 tqYub7yPpz5GZw1C3Es0Cv84tVT5XxqUTNqpoV8+0ve/7KK6cE8JMidDhokdarD0nV
	 ZZ8uR4tgt37tOHGcqihAi1rmh1WPPbto1uau/s4y+UcIFhV0mPKKMOsAhBrhRFMr3Q
	 VNWl6/lNryhlg==
Date: Thu, 23 Oct 2025 19:08:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, davem@davemloft.net, razor@blackwall.org,
 willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
 martin.lau@kernel.org, jordan@jrife.io, maciej.fijalkowski@intel.com,
 magnus.karlsson@intel.com, dw@davidwei.uk, toke@redhat.com,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v3 02/15] net: Implement
 netdev_nl_bind_queue_doit
Message-ID: <20251023190851.435e2afa@kernel.org>
In-Reply-To: <34c1e9d1-bfc1-48f9-a0ce-78762574fa10@iogearbox.net>
References: <20251020162355.136118-1-daniel@iogearbox.net>
	<20251020162355.136118-3-daniel@iogearbox.net>
	<412f4b9a-61bb-4ac8-9069-16a62338bd87@redhat.com>
	<34c1e9d1-bfc1-48f9-a0ce-78762574fa10@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Oct 2025 14:48:15 +0200 Daniel Borkmann wrote:
> On 10/23/25 12:27 PM, Paolo Abeni wrote:
> > On 10/20/25 6:23 PM, Daniel Borkmann wrote:  
> >> +	if (!src_dev->dev.parent) {
> >> +		err = -EOPNOTSUPP;
> >> +		NL_SET_ERR_MSG(info->extack,
> >> +			       "Source device is a virtual device");
> >> +		goto err_unlock_src_dev;
> >> +	}  
> > 
> > Is this check strictly needed? I think that if we relax it, it could be
> > simpler to create all-virtual selftests.  
> It is needed given we need to always ensure lock ordering for the two devices,
> that is, the order is always from the virtual to the physical device.

You do seem to be taking the lock before you check if the device was
the type you expected tho.


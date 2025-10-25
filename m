Return-Path: <bpf+bounces-72176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A841C087B5
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 02:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A9223B8B87
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 00:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CC91F4168;
	Sat, 25 Oct 2025 00:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCm1ENVv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CA91E633C;
	Sat, 25 Oct 2025 00:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761353644; cv=none; b=nHUsVXunNWJUXfY/Ak8m1XoHGE9wMCBx9h7nt21WL+bRkCYisJOnWI0amxqBsSZx+YvyX+8Uxwhgz579ZofLSMk6ODJdDfw/c/ud2fEkSQXA7tMP9BuAMhOw4fhc647Y9gC1pa7PC0Hm/QBRjem/Qrk3u4/q+Bov6KLPQhwdiDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761353644; c=relaxed/simple;
	bh=mDTG24SA/D6Zl2v+cxxSNFpswm6/adPBv6yaf/7vO8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rBrvW/TP7/smQPH2wfTRiB1WkD7Mfx9YyqzHaCL/LcZDKlBKE+ps3nnxqxQIslg+cEW68n231/385+CocxkGrAI/nge4ue0OWKepFJc7yLr7V/4GQzdA5VIRu2QHxPElUo7XGuCxZCQQGgph5Gs9sqjT8bjEQHQIZcvu46PAQ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCm1ENVv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE681C4CEF1;
	Sat, 25 Oct 2025 00:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761353643;
	bh=mDTG24SA/D6Zl2v+cxxSNFpswm6/adPBv6yaf/7vO8Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QCm1ENVvbA0/KJyuOBvSRd9yC/waAyYd73az37Pd5i1iSz5cQTqVw7DuxPjAd8yGk
	 QkzhCkhargWJHnZgTvbydoi4OyJ7kdm9toOeG8RqWh6xSGEI9JPImV1tSubQVbtySt
	 HX1I8y9KcAnQm8bcKSEWliknJ9ZzeH4gI1oyRbSZMTQQce/fiKiAozssLvGlAc4A34
	 NSJOZz0jJG7rkKk2oQWJxr+B/W01vMz2x/WGyN0v3ACCV+h0it4/nv01wAmqZYqRwV
	 RbYzuzl5CU7ihTYEzZ3GhUYJ1cSKl91EdR+HLH9fAKTUp7RKIGXo3sz66mH6IYy+WT
	 ekAPR773bV4Ww==
Date: Fri, 24 Oct 2025 17:54:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, makita.toshiaki@lab.ntt.co.jp, Eric Dumazet
 <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, ihor.solodrai@linux.dev,
 toshiaki.makita1@gmail.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH net V1 2/3] veth: stop and start all TX queue in netdev
 down/up
Message-ID: <20251024175402.397c05a9@kernel.org>
In-Reply-To: <176123157775.2281302.5972243809904783041.stgit@firesoul>
References: <176123150256.2281302.7000617032469740443.stgit@firesoul>
	<176123157775.2281302.5972243809904783041.stgit@firesoul>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Oct 2025 16:59:37 +0200 Jesper Dangaard Brouer wrote:
> The veth driver started manipulating TXQ states in commit
> dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring
> to reduce TX drops").
> 
> Other drivers manipulating TXQ states takes care of stopping
> and starting TXQs in NDOs.  Thus, adding this to veth .ndo_open
> and .ndo_stop.

Kinda, but taking a device up or down resets the qdisc, IIRC.

So stopping the qdisc for real drivers is mostly a way to make sure
that there's nothing entering the xmit handler as the driver dismantles
its state.

I'm not sure if this is an official rule, but I'm under the impression
that stopping the queues or carrier loss (and
netif_tx_stop_all_queues(peer) in close() is stopping peer's Tx queue
on carrier loss) is inadvisable as it may lead to old packets getting
transmitted when carrier comes back.

IOW based on the commit msg - I'm not sure this patch is needed..


Return-Path: <bpf+bounces-58188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A55AB6BA9
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 14:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99FB57B1254
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 12:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF8D2797A4;
	Wed, 14 May 2025 12:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXLNPOWS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062E7276024;
	Wed, 14 May 2025 12:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747226643; cv=none; b=rND89FGYlfQwXrcRG3jGeTdnZNJf1IoibSH6o8wxPO7uPq7Rh8zmcgDqtFFzo+U0HQX4iFyPGyb95HBgAQBhD5nAqMbiA/N7CoXxDjpc7ujPGMqFsaAESmH3aBx/kieoXSQv3NA44EMGpsKn7y1UadPq8n16S2j85EXpn98f/8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747226643; c=relaxed/simple;
	bh=LaaTtL18gYkBpKfIHtsydTFx7f5yvQp0LLx6M5Yb+oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ht2u0HMmj4bhaLVvxzq3laA+pxUxerCPQ74UT4ILSe60adr9BF+zuCG16gYWi/Va0WwVVmAHIdDNryc9sUcQjzex53ioG+VIUdGZAKjj/4g701qnpb+Gx8TB5prqzi+x8Hy7ZX9/1m+jK8L8A5o8mefjPzqidHzyJ0hq4T+9Wkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXLNPOWS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A097FC4CEE9;
	Wed, 14 May 2025 12:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747226642;
	bh=LaaTtL18gYkBpKfIHtsydTFx7f5yvQp0LLx6M5Yb+oE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oXLNPOWSAhm109xi76EG+tT1v3fLCNJ5/mYufcpeH8SRgSgX7WAuTF4QjmQEpFY6M
	 YjDHc7+XIIviZ9Fx2tK1tLEHmGjesKHFgnd2G0kYg11hM0i5hPmJbuanwA0w/ZIyIC
	 d9zhTuNpCR1Iu5brbAXQzxJUDzyv1i4Y6CB1Tngx7NlQtwJrImsLLXVmW56RCUY1O0
	 NzSh2vdv1EZRjE3JJzP0JddOzN0zCDo0yI+NqXFdWkgev9dr7NQJOUM4JZK8RKDmbU
	 1tFSHeDtFFIpoDU5KdwlYUaQ2oKcLV+hM6qp4dz1QaZeQZ1iaK+D379YfwLmOHKARs
	 vLFbl4boVh4+g==
Date: Wed, 14 May 2025 13:43:55 +0100
From: Simon Horman <horms@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	decui@microsoft.com, stephen@networkplumber.org, kys@microsoft.com,
	paulros@microsoft.com, olaf@aepfle.de, vkuznets@redhat.com,
	davem@davemloft.net, wei.liu@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, leon@kernel.org,
	longli@microsoft.com, ssengar@linux.microsoft.com,
	linux-rdma@vger.kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
	hawk@kernel.org, tglx@linutronix.de,
	shradhagupta@linux.microsoft.com, andrew+netdev@lunn.ch,
	kotaranov@microsoft.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next,v3] net: mana: Add handler for hardware
 servicing events
Message-ID: <20250514124355.GK3339421@horms.kernel.org>
References: <1747079874-9445-1-git-send-email-haiyangz@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1747079874-9445-1-git-send-email-haiyangz@microsoft.com>

On Mon, May 12, 2025 at 12:57:54PM -0700, Haiyang Zhang wrote:
> To collaborate with hardware servicing events, upon receiving the special
> EQE notification from the HW channel, remove the devices on this bus.
> Then, after a waiting period based on the device specs, rescan the parent
> bus to recover the devices.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

Reviewed-by: Simon Horman <horms@kernel.org>



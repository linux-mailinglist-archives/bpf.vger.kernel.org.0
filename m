Return-Path: <bpf+bounces-72651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A90C17644
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 00:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4CD8400C74
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 23:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FBF36B96F;
	Tue, 28 Oct 2025 23:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcxC+VpR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A3F280033;
	Tue, 28 Oct 2025 23:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761695079; cv=none; b=cpqGieIfHy+rdK814oGNGBhqJMfUS41h+tLqAvDAOLaBviKwXCNULNjxYk0+PDg9ZD9HHUV0gp7DA7GiVNCJLNRuJcqyfnBeVbq+LrpKmooWMEmTHG0TOId4AALuBcSeNsuV7zIWYL69JUtGR60Mv5Y4pdb1GMBEXx/v3OLdfJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761695079; c=relaxed/simple;
	bh=XV5KEoN5jVwlWM4qV2jaupzENzhi6N4X0KoX4O9lcMI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EjKrohds+hF8n/XtOGz9rffjetlkQYBuXzKq7kWcaqXe07KKAABdsmG1aqynA6dRGNOFYcg/jtpECYJ6KjdlCJFFouo+1oyeYcHb5XMKLtbc4b76/n59YaX2gbEEKzl23hn2Lhms37U1Ew7O3Vz3Z/admfTK02EdDSR0f8DK8F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcxC+VpR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0722FC4CEE7;
	Tue, 28 Oct 2025 23:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761695078;
	bh=XV5KEoN5jVwlWM4qV2jaupzENzhi6N4X0KoX4O9lcMI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qcxC+VpRGSxvjnAptq7vMQhAjA3xm8GK7cR2b0MYTw44nGtUNN+s3VNU1kIlmc1Wl
	 UxLIWGbgBpHFj7akzF3LBarMQSVU2N0EjOtcfU6Bh+29lneFI84Y2R07cX9nrsaibi
	 3LUGa0zyU5pnDJYgR8ep81+varLgqxGgw6yHggaE6dCfloGHcR/RusaEdUcU+vWLuK
	 FVfJpCo7eR3c2Zapx0I6k8OLdVAc5CirrF9ASiqvgMKWCVZEykxkobE32DKh9i6gQw
	 RPx8XsjiJm4snCgnT3ZsLhUqdqny9iwyJraXmeQUMXmIUFseDzrVaPOwye+q9plFEz
	 PpYEOkY1MlcJw==
Date: Tue, 28 Oct 2025 16:44:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, toke@redhat.com,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v3 02/15] net: Implement
 netdev_nl_bind_queue_doit
Message-ID: <20251028164437.20b48513@kernel.org>
In-Reply-To: <77a3eb52-b0e0-440e-80a0-6e89322e33e9@davidwei.uk>
References: <20251020162355.136118-1-daniel@iogearbox.net>
	<20251020162355.136118-3-daniel@iogearbox.net>
	<412f4b9a-61bb-4ac8-9069-16a62338bd87@redhat.com>
	<34c1e9d1-bfc1-48f9-a0ce-78762574fa10@iogearbox.net>
	<20251023190851.435e2afa@kernel.org>
	<77a3eb52-b0e0-440e-80a0-6e89322e33e9@davidwei.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Oct 2025 14:59:05 -0700 David Wei wrote:
> On 2025-10-23 19:08, Jakub Kicinski wrote:
> > On Thu, 23 Oct 2025 14:48:15 +0200 Daniel Borkmann wrote:  
> >> It is needed given we need to always ensure lock ordering for the two devices,
> >> that is, the order is always from the virtual to the physical device.  
> > 
> > You do seem to be taking the lock before you check if the device was
> > the type you expected tho.  
> 
> I believe this is okay. Let's say we have two netdevs, A that is real
> and B that is virtual. 

Now imagine they are both virtual.

> User calls netdev_nl_bind_queue_doit() twice in
> two different contexts, 1 with the correct order (A as src, B as dst)
> and 2 with the incorrect order (B as src, A as dst). We always try to
> lock dst first, then src.
> 
>          1                 2
> lock(dst == B)
>                    lock(dst == A)
>                    is not virtual...
>                    unlock(A)
> lock(src == A)
> 
> 
>          1                 2
>                    lock(dst == A)
> lock(dst == B)
>                    is not virtual...
>                    unlock(A)
> lock(src == A)
> 
> The check will prevent ABBA by never taking that final lock to complete
> the cycle. Please check and lmk if I'm off, stuff like this makes my
> brain hurt.



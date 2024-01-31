Return-Path: <bpf+bounces-20876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B889844D51
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 00:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEEF91C23088
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 23:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110723A8D5;
	Wed, 31 Jan 2024 23:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6ywVkNp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E143B282;
	Wed, 31 Jan 2024 23:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706744866; cv=none; b=dGOOSevYAld62KJdCKM/HY2KTWDVi4oNQ15QRVm4KeFhXDthFk3fmVKkVhGGfCzxPY69UmhS0nvXTrWDwyi9E/SDTahg6IbDOGVJfkbjUJ6A4f3dHkho+B84Gazc9hZoWWbaygOTdq9Vf3UnIN9b6GfcQO2E+j88qqqC6WjLi8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706744866; c=relaxed/simple;
	bh=klr52ezqptjRjXQWKQ6Jaw/sO5CEiJK4VNMcJb+fi2k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JahNqWian7nuxleEvJsw1n59iB7pU8or1uMlEQfO6/Bktfv+S0C4fnI38dC6R3qhg0M3vuEDEc+TJwXple9QXy7JKnoPzmBmGY07KCDJGREILJaOvcGGoonjnBAW3EFtYrQ5OrxkJ1+Bxyrry/a49GXsssA/jBuJpOEm6pCENCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6ywVkNp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F5F2C433F1;
	Wed, 31 Jan 2024 23:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706744865;
	bh=klr52ezqptjRjXQWKQ6Jaw/sO5CEiJK4VNMcJb+fi2k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q6ywVkNp7F89Heuxq/7LOD8ejD3u40gk6zTZUyZ41VmBNfaVhX8yoB37nROjt3Cgw
	 QjVYg8T4+9VWB6fXyGEL5c/Vcloz35lo+6k44WUHMh5/obC1oO5Vrioo5+PwnKd8WR
	 mvQmgMwp4Chi5jzMS7aZ5PPP1nsd5S7fpspbYZCEBIoMssJUTKLQFkp1mALWkLpAoS
	 IaBa1FMeYRvQcwDNd++wWDUEycj+j3GkxySxsi8d4Wvbw2lNGDO5vsEgyaAdjG462l
	 hvZNiWzmXBwm8YDrWdH0VKRW7pn6dyfGoV+xzIrBBiQCTI7QvjncxKdIZuUs6r84TY
	 OAWAIVk0YIEhw==
Date: Wed, 31 Jan 2024 15:47:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 bpf@vger.kernel.org, toke@redhat.com, willemdebruijn.kernel@gmail.com,
 jasowang@redhat.com, sdf@google.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org
Subject: Re: [PATCH v6 net-next 3/5] xdp: add multi-buff support for xdp
 running in generic mode
Message-ID: <20240131154740.615966a9@kernel.org>
In-Reply-To: <c93dce1f78bd383c117311e4d53e2766264f6759.1706451150.git.lorenzo@kernel.org>
References: <cover.1706451150.git.lorenzo@kernel.org>
	<c93dce1f78bd383c117311e4d53e2766264f6759.1706451150.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jan 2024 15:20:39 +0100 Lorenzo Bianconi wrote:
> +#if IS_ENABLED(CONFIG_PAGE_POOL)
> +static int
> +netif_skb_segment_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
> +			  struct bpf_prog *prog)

nit: doesn't look all that related to a netif, I'd put it in skbuff.c


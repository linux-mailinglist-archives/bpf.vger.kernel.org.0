Return-Path: <bpf+bounces-59051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B50DEAC5F0B
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 04:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 849C6163395
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 02:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859511B0F33;
	Wed, 28 May 2025 02:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQoOz927"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BDEFC0E;
	Wed, 28 May 2025 02:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748397792; cv=none; b=kw5b8qE3Tn0aNcp7lPlW3tfkjfJQfpA7d0olpXVMam4s6ZzgiB3d5aBc3lxxk3kar0lbhWIgJArpT8nTegD7EeBpum3dcD1t3m2gXlV3TVTSx1HgHMU1B8cAbEFC8yuyvWeB6oveAQ49h80f0XzpxaLdLF4tNgOE/s98emIA1Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748397792; c=relaxed/simple;
	bh=4bNcE+GOAtdNFHh9ntSssHO+eAymso7Znpvgf96aQGY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L9lInRR2Hp2J5u2RFUKfNjZFhSd0/Eq6q71gasKNasSKT3fOaDarRh+Bh8xVMoadSTrHVbxcIo1f2YMmo8Bx2Ek+sltnRAsKKxsoUw6+tJAMEMpUZ8XRBtaBda+5+xUiQJXv9A/8o78dAkXwjjg7cNR+mCxNs3jP/+sJ8+BMWOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQoOz927; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA62C4CEE9;
	Wed, 28 May 2025 02:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748397791;
	bh=4bNcE+GOAtdNFHh9ntSssHO+eAymso7Znpvgf96aQGY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mQoOz927XJBb7vAnobFLu30P8GTg7L69jJbi7Qv4YgAum6hsn65W3n4l2lNF6cHGb
	 iNwycAL/06AFFtjWmE9r2rvoiHHqc0Ei25IjALsYxwFEhTawnG18P9AwT3hYohENhf
	 WcFTp30zHKjkKSizstag88hrkwmWpnFHeKDKSwHYUPhC8369+ubKMsipHwpS4uWHBQ
	 XZtWl+bP+Mi/GkgnFGJqtnUeIthcfTjgrjKm03UbAYZNRLkfrfapLQlQRNWeUXYU04
	 +ddSuW/knhCuxBjkGaJiXG+W+p9qTIH9UiKknUP39JyL/PrmjziMtf56x9exEGs2Dd
	 KN3875FXKuatQ==
Date: Tue, 27 May 2025 19:03:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, Alexander Lobakin
 <aleksander.lobakin@intel.com>, maciej.fijalkowski@intel.com,
 magnus.karlsson@intel.com, michal.kubiak@intel.com,
 przemyslaw.kitszel@intel.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH net-next 03/16] libeth: xdp: add XDP_TX buffers sending
Message-ID: <20250527190309.156f3047@kernel.org>
In-Reply-To: <20250520205920.2134829-4-anthony.l.nguyen@intel.com>
References: <20250520205920.2134829-1-anthony.l.nguyen@intel.com>
	<20250520205920.2134829-4-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 May 2025 13:59:04 -0700 Tony Nguyen wrote:
> +	if (sinfo || !netmem_is_net_iov(netmem)) {
> +		const struct page_pool *pp = __netmem_get_pp(netmem);
> +
> +		dma_sync_single_for_device(pp->p.dev, desc.addr, desc.len,
> +					   DMA_BIDIRECTIONAL);
> +	}

How can we get an unreadable netmem into the XDP Tx path?


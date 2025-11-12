Return-Path: <bpf+bounces-74263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DCEC50315
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 02:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56E21898CB8
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 01:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9757C23EA96;
	Wed, 12 Nov 2025 01:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+z+PaYF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E4822541C;
	Wed, 12 Nov 2025 01:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762910546; cv=none; b=lVqMMK02mP0t6cDCS+MrrB+zMEYRskfqoUfDYqPFACx5aTyKXXBpOpZOZFkhAWCtN/YD31uIDKFPMNZwp5WVvF1PflJzCg1Vr83bzZyVAp+HXlU9PhXWngIDGyLumTypak9xoV00hekd1QzwMEc+LX91n5dCzb1TMeNH4xH72QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762910546; c=relaxed/simple;
	bh=8/VZ+Pk/P0ERSzhincVBgh2q/b+XJHdh5AweNfrSb6U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dz//hbOQ6HlUjPqSKrPuGL1PXOFv9mgGZxZ7VlBnh/x+tP1YMQcripjwZX4yta+wO27QrnXmWprrkUe41zAe8JiUa/UB+ckY+o4zfQmisw3a17alZrbmrsiSZ0ogvmSxvQBv3uo/u6CA89xgo7+vNs0l/QS8nfvW51rrQStFlc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+z+PaYF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0AA7C116D0;
	Wed, 12 Nov 2025 01:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762910545;
	bh=8/VZ+Pk/P0ERSzhincVBgh2q/b+XJHdh5AweNfrSb6U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V+z+PaYFSEegQbz2sIv90WFvfwnTwzaKfAEoJxj4Iud8QJbhPr3scWC5OBttLucJ3
	 U/IY6GAVE9/wz90Rbi4M6sN/B0B0ryuqF6r6WOGO/lQWVTbMSU5IaieOh7NsvgzJFV
	 X6fwRXWFIboRJvLjM8EfccXuIkYs1Ch2SHXYHQWlt19BSODk32Kh1Qdkwl297yZSoz
	 ONFZ9dihyNO09wQzcSqr5QrqYsc0R/f8wvXUlG4spynFr8cvOCykT15iwdjNQ0WJqG
	 PAkeJAg0U+TCt6BKu6KJFzEFONFKqJh7Pqo1AtSDXwYyELJT2srDydnHAO438kV92S
	 B+KrhG7K7YAQA==
Date: Tue, 11 Nov 2025 17:22:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, srk@ti.com,
 Meghana Malladi <m-malladi@ti.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH net-next v2 7/7] net: ethernet: ti: am65-cpsw: Fix
 clearing of irq_disabled flag in rx_poll
Message-ID: <20251111172223.6c3b24a4@kernel.org>
In-Reply-To: <20251109-am65-cpsw-xdp-zc-v2-7-858f60a09d12@kernel.org>
References: <20251109-am65-cpsw-xdp-zc-v2-0-858f60a09d12@kernel.org>
	<20251109-am65-cpsw-xdp-zc-v2-7-858f60a09d12@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 09 Nov 2025 23:37:57 +0200 Roger Quadros wrote:
> In am65_cpsw_nuss_rx_poll() there is a possibility that irq_disabled flag
> is cleared but the IRQ is not enabled.
> 
> This patch fixes by that by clearing irq_disabled flag right when enabling
> the irq.
> 
> Fixes: da70d184a8c3 ("net: ethernet: ti: am65-cpsw: Introduce multi queue Rx")
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

This looks independent from the series, it needs to go to net.
-- 
pw-bot: cr


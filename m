Return-Path: <bpf+bounces-78643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D29BD16682
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 04:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C867301F3E5
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 03:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F74301489;
	Tue, 13 Jan 2026 03:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxCxXi1Y"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C232BEFFB;
	Tue, 13 Jan 2026 03:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768273738; cv=none; b=WfSa9RKQvFAkqIr9uSxHiK850VOMcEHTasya0Xj2GKU7+Lia8jvXKIKT95LLfKV/z7NgK4birtLmevzfHGhIVtsUFFZ1EguNIqzatQ7sQAw/18VgtgWjJwKpebi4LLoicOHI/VXNd55bZTBQRikBcQRTP2PQp8HUSxbBbdIzja8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768273738; c=relaxed/simple;
	bh=5xE/UzPxx8Afb98pxY1v4ktqur7bu8ogwAB86SInQLY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ArrMDQgb/X0+NYG7iJGlP9X490wQcEs8dKZ5XIoZQjFCb3VpW+723XLoJjNwroSjBbNCIy7sLAMAcH/AVvvAOAcoh5JaPnpaBMvUa6h2Ft9iWhaR3B+AEaDIRt6lvmdSUGOIklnmGlEkCSMCIhvBaz0IkoyjovCY6danmwiaO00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxCxXi1Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40EF2C116D0;
	Tue, 13 Jan 2026 03:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768273738;
	bh=5xE/UzPxx8Afb98pxY1v4ktqur7bu8ogwAB86SInQLY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TxCxXi1YYxnJS0sw3EBgIsVaZR29gHP1MwekE7jvJ7HN9K66f3ba7l45ZqRcdA4uf
	 nuDNomQ8sQtAOoCE2XaXl2oNobHXeldazE0BSB7OPo16sSaF6+gh+d+3na5Oaq6oLO
	 +lNZWxelFszTDqaj2FTYJ9qL8I4dN/0VSFpCXMgDETBmJequQVEQA0lO2kXvpvp2fH
	 neG7Lf84hS1pPM0GbkHOpvFjmkCeniqNDr94VipaKGmg5nEwR7Ec1Wp3mH+RsqzP0E
	 0tUFv8j3TPBbUaoqIZDcO4V0p3YIPFLWreWrRrHIwGWWgfRVN2RrsoBdaRQQUvsz1m
	 azzkhf9CVTgkA==
Date: Mon, 12 Jan 2026 19:08:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Michael Chan <michael.chan@broadcom.com>, Pavan
 Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
 <mbloch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org,
 kernel-team@cloudflare.com
Subject: Re: [PATCH net-next 00/10] Call skb_metadata_set when skb->data
 points past metadata
Message-ID: <20260112190856.3ff91f8d@kernel.org>
In-Reply-To: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 Jan 2026 22:05:14 +0100 Jakub Sitnicki wrote:
> This series is split out of [1] following discussion with Jakub.
> 
> To copy XDP metadata into an skb extension when skb_metadata_set() is
> called, we need to locate the metadata contents.

"When skb_metadata_set() is called"? I think that may cause perf
regressions unless we merge major optimizations at the same time?
Should we defer touching the drivers until we have a PoC and some
idea whether allocating the extension right away is manageable or 
we are better off doing it via a kfunc in TC (after GRO)?
To be clear putting the metadata in an extension right away would
indeed be much cleaner, just not sure how much of the perf hit we 
can optimize away..


Return-Path: <bpf+bounces-69868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD89BA523E
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 22:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3703F4E2E61
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 20:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C14286D76;
	Fri, 26 Sep 2025 20:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCIwwv8T"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EB6285C95;
	Fri, 26 Sep 2025 20:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758920046; cv=none; b=mibc7PPhBK0zdBntnGWeZLJ0dNriWm+dFMld96bqLn/vOTDAnmtHnNYWRwNez2lV0wEGNH9nQxqC28jeisO0/lm1g2RJl/1IkEKVYXgLOuGHop7Se4zYfiXDKY2nB127XfRiiCveeHFxtcYVKG+MXQn/2VtcwQWz8U9pHu1HnuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758920046; c=relaxed/simple;
	bh=BNIIL5rASv1lGqe7ivNL96+oeSFG6am2hpjlcg9rBpo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O9gv7Ap9Yr86KIIwKtUZ2YJghYWXY8j0DCghMvFYQoK0IaEiz6NEqTnHTGdtmexoBjFaUnbAwy6/kNjKuV/YFdLJwgSthOrwDpnp4XVTTmY8nJJClq5OCXHSXBKYuLm5jnJxEgYXQJy7lyTJw7ZCEmMbA0SDgI93Gi3a3zotMYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCIwwv8T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296BCC4CEF4;
	Fri, 26 Sep 2025 20:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758920046;
	bh=BNIIL5rASv1lGqe7ivNL96+oeSFG6am2hpjlcg9rBpo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tCIwwv8TfZuCnyw6dP7Leu3PUJE6VzxJv7l4y2BqVsRh6ieoo/SWbx2IC8wCLn3Ac
	 KjpXqbZU5dKCJnSqkaDrja7ACC9Hs7V19eiHFpbmMj7kYStfmmqorG43m6JtGbnw9f
	 QG9cqFvE1czcg5ccLF6A6HxZkXrbdPiodaBqPCJ5VHKRa2/5ZLn4nTKvCC8o2FnYmB
	 dONRNbL5uB0FGD/JjbGWS3b7D3/XVjnlIpnpzC6URxd0qiuPKIncnVZ/OgAT3/W+tL
	 Lz1YzoaTzVJ4pJG03OVvksR/qnYdNYYoe/qZuUWm1hxwz42fB3pZ/Hp/cehRcTrmsh
	 B7rMdHv7TRtYA==
Date: Fri, 26 Sep 2025 13:54:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 netdev@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kerneljasonxing@gmail.com
Subject: Re: [PATCH v2 bpf-next 0/3] xsk: refactors around generic xmit side
Message-ID: <20250926135405.6e137316@kernel.org>
In-Reply-To: <13ddb0d3-7441-43d9-b8e4-2c8f4acf99bf@linux.dev>
References: <20250925160009.2474816-1-maciej.fijalkowski@intel.com>
	<13ddb0d3-7441-43d9-b8e4-2c8f4acf99bf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Sep 2025 12:48:34 -0700 Martin KaFai Lau wrote:
> On 9/25/25 9:00 AM, Maciej Fijalkowski wrote:
> > this small patchset is about refactoring code around xsk_build_skb() as
> > it became pretty heavy. Generic xmit is a bit hard to follow so here are
> > three clean ups to start with making this code more friendly.  
> 
> Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
> 
> Hi Jakub, the bpf-next/net tree is currently empty for the upcoming merge 
> window. Could you help by taking it directly to the net-next tree?
> or I can also take it to bpf-next/master.

Hah, I applied it before finishing reading the email and discovering
the "or" :) So applied to net-next :)


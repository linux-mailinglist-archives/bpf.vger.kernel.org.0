Return-Path: <bpf+bounces-72096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BE5C06845
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 15:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A1DF44FEFCD
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 13:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCA631D393;
	Fri, 24 Oct 2025 13:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8XCfICT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D7A25228D;
	Fri, 24 Oct 2025 13:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761312773; cv=none; b=ZrMr114idn3wXrroXk1bWuiawMd1p/euIMIwhKYG/Ro6g+QUz49X8Po+pNf1ce4cBvOn1eTbgwi5kVhrNGANk5qbrI2ycG27Yo2A+NHZkh9NJwiihcqeGsjajslM9t9laiN0o+su0I34J7PVVoBVHhFSX8TnjDZLwdCX8NTN33M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761312773; c=relaxed/simple;
	bh=Ub/SzXqEkrMzXonGiygykcjrzWHljqBtpbwwn81m8f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJ3PGHVuC4v7BHPdgXa3MMu2RfaXFvt7BQhnpBGsayBTRnfqwghoWkN0uUoNKGWbdbI76NN6fX+vcfIlMOORz8I6h64wj5KBvahP1DoIk8NF30E8uJHzQoKXnZBXJmnmJrR8+sDgotZWNExmmaCRat7ooIpkDd2J5UnE12lp/h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8XCfICT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123D6C4CEF1;
	Fri, 24 Oct 2025 13:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761312772;
	bh=Ub/SzXqEkrMzXonGiygykcjrzWHljqBtpbwwn81m8f4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u8XCfICTh+qlamBi+NTrX2O8xYYsYiAWB5qoWHzv++nlgx9HXI1EOgDOBXzhUqSLu
	 cDq88+4qDS35CNNiuetK688I2568NAtXsGPHFxJYNqc8IyHqZfX9Xk+l/MIca3Cn2H
	 kSXAeSM8fRS0/yQwRexMtp+TUpyNY1hLSYHpxPA53kQTbySX3gro6mrc1Zek6n+3uD
	 GaNYEz9yE9Xa0o3bsKkzniwEBBYlRADhA0ScwKkPpdczvFq/WelF/9PJOo99/+VKHR
	 i3nphcX9edwDS+KzYh7E1f4a4enxvixs5ZtnBmOLgCgmMRo69GUmrl4ZCJq0tzlFXd
	 ehf3t26E+rG1g==
Date: Fri, 24 Oct 2025 14:32:47 +0100
From: Simon Horman <horms@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to,
	willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v3 7/9] xsk: support batch xmit main logic
Message-ID: <aPt__0JeH9lW-1yd@horms.kernel.org>
References: <20251021131209.41491-1-kerneljasonxing@gmail.com>
 <20251021131209.41491-8-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021131209.41491-8-kerneljasonxing@gmail.com>

On Tue, Oct 21, 2025 at 09:12:07PM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> This function __xsk_generic_xmit_batch() is the core function in batches
> xmit, implement a batch version of __xsk_generic_xmit().
> 
> The whole logic is divided into sections:
> 1. check if we have enough available slots in tx ring and completion
>    ring.
> 2. read descriptors from tx ring into pool->tx_descs in batches
> 3. reserve enough slots in completion ring to avoid backpressure
> 4. allocate and build skbs in batches
> 5. send all the possible packets in batches at one time
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Hi Jason,

__xsk_generic_xmit_batch is defined in this patch, but not used
until the next one. Which results in a transient warning when
building with W=1.

Perhaps it's just as well to squash this patch into the following patch?

...


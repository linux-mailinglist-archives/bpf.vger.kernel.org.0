Return-Path: <bpf+bounces-61159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9CEAE193F
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 12:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00DE03BEF3F
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 10:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6048E280002;
	Fri, 20 Jun 2025 10:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSBzQbBT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B072AF07;
	Fri, 20 Jun 2025 10:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750416680; cv=none; b=ac3mwiZ1Pv9ogmpwjDHBf/X+aoZgJRWRh56wIWDqkhd/XzOIRqZ9IAgvT2ZT7zdi58TGP4gSdXZjTP+aKR5/o1SYZlETm8ygr7WAMvJreeTaT8I/NKIR9KD+hubYqNh/ktYNi6nrpe6KjtKL3b8lH1bLtttMeo6ymzKZiZ4Pz3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750416680; c=relaxed/simple;
	bh=xJpDu3YPjXRnNpdNI//n/GTlpYebqH9RGK2+XQwqJKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3POHfocaOyGbsJLVRRbjU0QTVpwZsOokJcbEryNz7te3M7P4ffeM4eZM9wAL48efrasIhcv6notClTlULWVIm3/zirZaFcvCJqHR+YGUbj7p+oK/U/Wo7dCPatI+0SveUnDBnDFvRMoSLMyfd0vhQFiDdprZ8B6FIuL7bkm0yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSBzQbBT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105D3C4CEE3;
	Fri, 20 Jun 2025 10:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750416680;
	bh=xJpDu3YPjXRnNpdNI//n/GTlpYebqH9RGK2+XQwqJKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uSBzQbBT5RcFquiP0m0RCt4BVGKVEtivSyIWS7FGOlhNBoKceRDp9CYfkinY164sk
	 FHxPDvkoin9HzeFLb1cL1Nl4h0lE0R4kzqOWw67goC+9O8xYoFQYncRiteyvOG6TI6
	 U5ayR2w32UIxDMN2hLcIHglljW0B0wFYCV+Ozyq40tsfm3CJpTCOpjT0twXTBmZTzJ
	 Tkk/HwhQiysMgcTRvJeQdUHz54t0nlqivJ8esmQj+yzSCVa513TCtUuc9pyiu0Simz
	 MyzfVt13D5njUILeeQEtoALdN9QQ8YYTXyN+b2sNROx2zD1Z/Lcb0UTE1Ze3zPQIsF
	 kN6XEhTBYx+tw==
Date: Fri, 20 Jun 2025 11:51:14 +0100
From: Simon Horman <horms@kernel.org>
To: Brett Creeley <bcreeley@amd.com>
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Taehee Yoo <ap420073@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net v3] ethernet: ionic: Fix DMA mapping tests
Message-ID: <20250620105114.GH194429@horms.kernel.org>
References: <20250619094538.283723-2-fourier.thomas@gmail.com>
 <bb84f844-ac16-4a35-9abf-614bbf576551@amd.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb84f844-ac16-4a35-9abf-614bbf576551@amd.com>

On Thu, Jun 19, 2025 at 03:28:06PM -0700, Brett Creeley wrote:
> 
> 
> On 6/19/2025 2:45 AM, Thomas Fourier wrote:
> > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > 
> > 
> > Change error values of `ionic_tx_map_single()` and `ionic_tx_map_frag()`
> > from 0 to `DMA_MAPPING_ERROR` to prevent collision with 0 as a valid
> > address.
> > 
> > This also fixes the use of `dma_mapping_error()` to test against 0 in
> > `ionic_xdp_post_frame()`
> > 
> > Fixes: 0f3154e6bcb3 ("ionic: Add Tx and Rx handling")
> 
> I'm not sure the Fixes commit above should be in the list. Functionally it's
> correct, except there being multiple calls to dma_mapping_error() on the
> same dma_addr.
> 
> Other than the minor nit above the commit looks good. Thanks again for
> fixing this.
> 
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>

Hi Brett and Thomas,

Maybe I misunderstand things, if so I apologise.

If this patch fixes a bug - e.g. the may observe a system crash -
then it should be targeted at net and have a Fixes tag. Where the
Fixes tag generally cites the first commit in which the user may
experience the bug.

If, on the other hand, this does not fix a bug then the patch
should be targeted at net-next and should not have a Fixes tag.

In that case, commits may be cited using following form in
the commit message (before the Signed-off-by and other tags).
And, unlike tags, it may be line wrapped.

commit 0f3154e6bcb3 ("ionic: Add Tx and Rx handling")

E.g.: This was introduce by commit 0f3154e6bcb3 ("ionic: Add Tx and Rx
handling").

I hope this helps. If not, sorry for the noise.

...


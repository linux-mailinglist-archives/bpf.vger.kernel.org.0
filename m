Return-Path: <bpf+bounces-73532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2A0C336C0
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 00:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1827434D6A8
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 23:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EA434B1AF;
	Tue,  4 Nov 2025 23:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NitVMveQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ADD72605;
	Tue,  4 Nov 2025 23:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762300110; cv=none; b=GhKBSGsVuka/ALU8sZIbsb+/jDt2ZuBH0rgepxpE2g8dE920BRgMZdvqtDF6Wa70AXyh/1+hv7fyGannMBcAAnZ0vDe//IB+oSDxKD4oxxzeCBGgv6kCVfkVtbCJNXgycZ4HpaapK3X6jVuedck0p9TDVvmDvZ2XvWD0IFGBsuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762300110; c=relaxed/simple;
	bh=Q2/QncbSe1650Y8pwvQWHnA5DpeavIeF6BYxviBnp1I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rCmLp9Tp2VcwcTiNfZJpNoclkIiZumNc8nNLaC1eLyXdkm8FiSRdW8/Y5mcVbpibeiiOi5IP9xpU2qbOh4GLVhW46jlDk0r/1KnMotLNqaChARZuqTnZGpBKtYY4/f7Iqy6En65S91+LAu0wtxILXHgo8owm4xYjJ67Oz9Vt5WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NitVMveQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E23C4CEF7;
	Tue,  4 Nov 2025 23:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762300110;
	bh=Q2/QncbSe1650Y8pwvQWHnA5DpeavIeF6BYxviBnp1I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NitVMveQvbt1i533gsvJWGVaHAnqN/0sBwsYa/Uj4lT1tXlWsD+c9rFs04/3twCP6
	 hZiAPAEqAx1dsVqmhmLijeiZidxoJv5WKRme4Qbe5uRKVjpPlLhiLdHatBcnqX9CZB
	 kUjOfrDt5nZ/Z0GrQRC9cEePN8uSu2ae7AsOmk2o1ZcHcsNoMu/kJH0jpEQpzHd9zn
	 iSYE+Or3T3HRGVUm/YyU/YgeUs2nfFRKJYdDSVXolI8tOf5+H0OEfZ1iTQ3kdV46Ch
	 rpZfegPYodVRzcnAva0IC6+e8QXTnGqMr+xVEHPg4ZezsNQbQhSrohuqPqC9hubz5u
	 24ZSXGiVLaOXA==
Date: Tue, 4 Nov 2025 15:48:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Meghana Malladi <m-malladi@ti.com>
Cc: Paolo Abeni <pabeni@redhat.com>, <horms@kernel.org>,
 <namcao@linutronix.de>, <vadim.fedorenko@linux.dev>,
 <jacob.e.keller@intel.com>, <christian.koenig@amd.com>,
 <sumit.semwal@linaro.org>, <sdf@fomichev.me>, <john.fastabend@gmail.com>,
 <hawk@kernel.org>, <daniel@iogearbox.net>, <ast@kernel.org>,
 <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
 <linaro-mm-sig@lists.linaro.org>, <dri-devel@lists.freedesktop.org>,
 <linux-media@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: Re: [EXTERNAL] Re: [PATCH net-next v4 2/6] net: ti: icssg-prueth:
 Add XSK pool helpers
Message-ID: <20251104154828.7aa20642@kernel.org>
In-Reply-To: <c792f4da-3385-4c14-a625-e31b09675c32@ti.com>
References: <20251023093927.1878411-1-m-malladi@ti.com>
	<20251023093927.1878411-3-m-malladi@ti.com>
	<05efdc9a-8704-476e-8179-1a9fc0ada749@redhat.com>
	<ba1b48dc-b544-4c4b-be8a-d39b104cda21@ti.com>
	<c792f4da-3385-4c14-a625-e31b09675c32@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Nov 2025 14:23:24 +0530 Meghana Malladi wrote:
> > I tried honoring Jakub's comment to avoid freeing the rx memory wherever 
> > necessary.
> > 
> > "In case of icssg driver, freeing the rx memory is necessary as the
> > rx descriptor memory is owned by the cppi dma controller and can be
> > mapped to a single memory model (pages/xdp buffers) at a given time.
> > In order to remap it, the memory needs to be freed and reallocated."
> 
> Just to make sure we are on the same page, does the above explanation 
> make sense to you or do you want me to make any changes in this series 
> for v5 ?

No. Based on your reply below you seem to understand what is being
asked, so you're expected to do it.

> >> I think you should:
> >> - stop the H/W from processing incoming packets,
> >> - spool all the pending packets
> >> - attach/detach the xsk_pool
> >> - refill the ring
> >> - re-enable the H/W
> > 
> > Current implementation follows the same sequence:
> > 1. Does a channel teardown -> stop incoming traffic
> > 2. free the rx descriptors from free queue and completion queue -> spool 
> > all pending packets/descriptors
> > 3. attach/detach the xsk pool
> > 4. allocate rx descriptors and fill the freeq after mapping them to the 
> > correct memory buffers -> refill the ring
> > 5. restart the NAPI - re-enable the H/W to recv the traffic
> > 
> > I am still working on skipping 2 and 4 steps but this will be a long 
> > shot. Need to make sure all corner cases are getting covered. If this 
> > approach looks doable without causing any regressions I might post it as 
> > a followup patch later in the future.


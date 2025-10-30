Return-Path: <bpf+bounces-73034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBD1C20E8F
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 16:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C19EA461316
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 15:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F60363B82;
	Thu, 30 Oct 2025 15:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPOkELgo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEF83126DE;
	Thu, 30 Oct 2025 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761837921; cv=none; b=GzmvyA2/je83acNonwzlXIdAu5pgPaJHqtyY0YFRch5KzGPPeURkCAZcZ9RRlCCqITaONl3My0XylaKihJXPjcwS73ncXGgPnQADZiuTk7b1530RVmaMLRdOCQT2tmjcRprJPQumQ4xLfZN3/wnCOZygUPZyJd60vjQNWDcurJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761837921; c=relaxed/simple;
	bh=rVj0mmo+D/FS9xgUYHTrULZTWgmWZ6swyh8aUSSb9so=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CzBj5DkxguUFla7wlYnuORsBiGPps7EIKfpP0QQgTcnyhGx92GV5UujaSTt0BxytvkFufa4jESnrDxms5HswhBB3JqlnpbETOzgY6LKjh0MunAEyIivr8/SUnPy/4FGcHxv77NNDlwOMfRtzTxLGTei+Igs+sM158jhw73BLSi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPOkELgo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EFA7C4CEF8;
	Thu, 30 Oct 2025 15:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761837921;
	bh=rVj0mmo+D/FS9xgUYHTrULZTWgmWZ6swyh8aUSSb9so=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nPOkELgoVBmqDLPHdmStpHtdtOc/Xqy1xONmjGiS5n1dEy5Z9lsQN+ej4b1jbO6RL
	 3Qha8fn1SJO8Cd1FLa7BZn+96ULX3ADZcksQJkb6Y4dD56Q8kRCvNe5V3BdoHRFVBk
	 0IhwkTGVkvMkJUvB+SCUIhrXy//JGxQZZNFPC86sC+zm8Vz71WFblqo3C0JicdKZ0f
	 Ym4A5sAuraGYWej3NGH4wUE0Yg4prInvErugU0PioRroiD7gbuyu2F5C52J3MGLrFx
	 eN4fgYEKo7QDIEpnSBg6/4Wx0pRp/Gfg3FjXOvxoQh5SaRXZ0rbtnNPJjoj8XCgErM
	 /VKCieJ90/zFw==
Date: Thu, 30 Oct 2025 08:25:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <hawk@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
 <aleksander.lobakin@intel.com>, <ilias.apalodimas@linaro.org>,
 <toke@redhat.com>, <lorenzo@kernel.org>,
 <syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, Octavian Purdila <tavip@google.com>
Subject: Re: [PATCH v5 bpf 1/2] xdp: introduce xdp_convert_skb_to_buff()
Message-ID: <20251030082519.5db297f3@kernel.org>
In-Reply-To: <aQNWlB5UL+rK8ZE5@boxer>
References: <20251029221315.2694841-1-maciej.fijalkowski@intel.com>
	<20251029221315.2694841-2-maciej.fijalkowski@intel.com>
	<20251029165020.26b5dd90@kernel.org>
	<aQNWlB5UL+rK8ZE5@boxer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Oct 2025 13:14:16 +0100 Maciej Fijalkowski wrote:
> On Wed, Oct 29, 2025 at 04:50:20PM -0700, Jakub Kicinski wrote:
> > On Wed, 29 Oct 2025 23:13:14 +0100 Maciej Fijalkowski wrote:  
> > > +	xdp->rxq->mem.type = skb->pp_recycle ? MEM_TYPE_PAGE_POOL :
> > > +					       MEM_TYPE_PAGE_SHARED;  
> > 
> > You really need to stop sending patches before I had a chance 
> > to reply :/ And this is wrong.  
> 
> Why do you say so?
> 
> netif_receive_generic_xdp()
> 	netif_skb_check_for_xdp()
> 	skb_cow_data_for_xdp() failed
> 		go through skb linearize path
> 			returned skb data is backed by kmalloc, not page_pool,
> 			means mem type for this particular xdp_buff has to be
> 			MEM_TYPE_PAGE_SHARED
> 
> Are we on the same page now?

No, I think I already covered this, maybe you disagreed and I missed it.

The mem_type set here is expected to be used only for freeing pages. 
XDP can only free fagments (when pkt is trimmed), it cannot free the
head from under the skb. So only fragments matter here, we can ignore
the head.


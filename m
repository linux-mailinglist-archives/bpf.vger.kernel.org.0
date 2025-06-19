Return-Path: <bpf+bounces-61091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE336AE0A5A
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 17:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B77223A4FB8
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 15:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8307F215F53;
	Thu, 19 Jun 2025 15:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAZF1CAT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4477494;
	Thu, 19 Jun 2025 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750346763; cv=none; b=YUrGDNILZjK9EUUrm0aR2wXNxSaD6RR5rbUjtNF984Y4Esp7+uGwrXS+WvQ4qB/SBYy3yTpoe23kCxPgqSGl+waZJy82DuOjBKpIqOM7ISXlwXnsiTR6DY7GHZYalKQ5yXkwf0hXs1Pbp92thbmjhC8Zx1r+iImk73RMzTuDgJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750346763; c=relaxed/simple;
	bh=un6tvBy8UgIsmggAAGQTIqboNDym9ssERw/2WamhE+M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EcVAgiTFJTgnVZ4s3YH1msKds+DBQgliiO5B45tYflBCSstDO6wDrZhKNGdR02eJOiXl9kgGnao63I1UWiI4IkY4tLrdr4MXnzulyKDyWxG6wZ+4TFeX4WN8IR/D8EWp0YSu2RjsiQpXr9BX6uQVyu43bVsWflO2iQ/S3nWLt3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAZF1CAT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DBCC4CEEA;
	Thu, 19 Jun 2025 15:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750346762;
	bh=un6tvBy8UgIsmggAAGQTIqboNDym9ssERw/2WamhE+M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KAZF1CATh+Fk7ABgx1rAsdVd2Ilstb0aPIU9Wpx62AEM3GFmaGhNFe5cq8CWSc2u3
	 8wdf4iAmdQfc8Q43NNA22Q7j2gwwKPq0uJAaD13DUctLAlndev4gjvJbxBp7//sXhH
	 5nDQTIQIFQEALIrj0z/N6ayQeHLPRbwtgQqb0ksQXBF2Q1nsbiRwBbwVyHVv95109g
	 xdhxQ8X3XNt52lab1qbcUBPTJiTfZkqQxJCWTonNc6E/VzJTt3bWFqNr0+PwJIER/B
	 Ihj0Wm+GdjHeZs62Xodoh4oPJM1Yr++BMH51Dy5e+NangO15Pl9bgelCieuphnHUS5
	 SwPqRb6CLrfEQ==
Date: Thu, 19 Jun 2025 08:26:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net 1/2] virtio-net: xsk: rx: fix the frame's length
 check
Message-ID: <20250619082601.3e5b6251@kernel.org>
In-Reply-To: <9a38a134-3ce8-4c91-a7e7-2a162cbf3b7c@gmail.com>
References: <20250615151333.10644-1-minhquangbui99@gmail.com>
	<20250615151333.10644-2-minhquangbui99@gmail.com>
	<20250618191111.29e6136e@kernel.org>
	<9a38a134-3ce8-4c91-a7e7-2a162cbf3b7c@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Jun 2025 21:17:03 +0700 Bui Quang Minh wrote:
> > I think Michael mention he's AFK so while we wait could you fix this
> > kdoc? I'm not sure whether the kdoc is really necessary here, but if
> > you want to keep it you have to document the return value:
> >
> > Warning: drivers/net/virtio_net.c:1141 No description found for return value of 'buf_to_xdp'  
> 
> I want to add kdoc to clarify that the @len must be without virtio 
> header's length. I'll fix it in the next version.

If that's the case I'd personally limit the doc to:

/* Note that @len is the length of received data without virtio header */

but up to you, it's quite subjective.


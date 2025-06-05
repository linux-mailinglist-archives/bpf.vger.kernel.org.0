Return-Path: <bpf+bounces-59759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E9CACF24B
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 16:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8CCD1740B8
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 14:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B08198E91;
	Thu,  5 Jun 2025 14:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGab23I0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A965579E;
	Thu,  5 Jun 2025 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749134893; cv=none; b=gzhTvvYRVsthuskTrO+0462BhiI1wqDPES4imD6rJKUCjCvbSJWBccYd1FDQyfiiaQhS4fwnv68Wkizq296lh6muH2vMP86riN+ivFdJQmJUp8i9R527lRvpbQZMbOh+3YvTYPlSMe5OnKn1P90DDAKpZqbvATslJ2XZHDu4jko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749134893; c=relaxed/simple;
	bh=Z9qAJGLQQv676iCt71fLSBP6A+2/vHn5xobquYtYIfI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gCWhJ4wQ8UR/UwpXMVZSP/iZyQo0gFKYiknAcQxpaviOATEKxGZ/o7GpirfCpa170aHxPAitiLmy/NAe/RjLdrjLLusg0j4Kmp8AfxaBwjxpAch/0CqKfr4ouRQmPr0VZH/HpeJHYMV4cOs55bBvZIHw5oKb5Ojeid0IMKrG/Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGab23I0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7620C4CEE7;
	Thu,  5 Jun 2025 14:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749134892;
	bh=Z9qAJGLQQv676iCt71fLSBP6A+2/vHn5xobquYtYIfI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nGab23I0PMYXdHEJbNc9+NTTmuwaNE1wXUHhCD0MWeldUB2G6KMYq+gzfpc+2xWSD
	 rlYykcOx0itpSgXUEWsuUDrhIb3gzCTOPLHiG+F5synrox9BdZoqPYVNHL3QrksGl8
	 Ov7m/KsfOXtj6uLYBYBm2vSTF0bqnpaeOWzTn7xb6dwdSQ7PZ2fepmTNiefZGTM84T
	 9Mzy+J1yv+s4mbNmWpG09y/CyQfpxGksuEWn0FT6KxfA9+d2eMjGSWpXQKv9S2x7eh
	 cvwXQBJ2SAwJKotSnzj2p9AzC6hdtM4907f1x8fvcP5aeVZRUwdiDGKYDiwf17k5Lk
	 iQisCMpg6/nug==
Date: Thu, 5 Jun 2025 07:48:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] virtio-net: drop the multi-buffer XDP packet in
 zerocopy
Message-ID: <20250605074810.2b3b2637@kernel.org>
In-Reply-To: <f6d7610b-abfe-415d-adf8-08ce791e4e72@gmail.com>
References: <20250603150613.83802-1-minhquangbui99@gmail.com>
	<dd087fdf-5d6c-4015-bed3-29760002f859@redhat.com>
	<f6d7610b-abfe-415d-adf8-08ce791e4e72@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Jun 2025 21:33:26 +0700 Bui Quang Minh wrote:
> On 6/5/25 18:03, Paolo Abeni wrote:
> > On 6/3/25 5:06 PM, Bui Quang Minh wrote:  
> >> In virtio-net, we have not yet supported multi-buffer XDP packet in
> >> zerocopy mode when there is a binding XDP program. However, in that
> >> case, when receiving multi-buffer XDP packet, we skip the XDP program
> >> and return XDP_PASS. As a result, the packet is passed to normal network
> >> stack which is an incorrect behavior.  
> > Why? AFAICS the multi-buffer mode depends on features negotiation, which
> > is not controlled by the VM user.
> >
> > Let's suppose the user wants to attach an XDP program to do some per
> > packet stats accounting. That suddenly would cause drop packets
> > depending on conditions not controlled by the (guest) user. It looks
> > wrong to me.  
> 
> But currently, if a multi-buffer packet arrives, it will not go through 
> XDP program so it doesn't increase the stats but still goes to network 
> stack. So I think it's not a correct behavior.

Sounds fair, but at a glance the normal XDP path seems to be trying to
linearize the frame. Can we not try to flatten the frame here?
If it's simply to long for the chunk size that's a frame length error,
right?


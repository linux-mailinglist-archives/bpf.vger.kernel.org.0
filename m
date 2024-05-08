Return-Path: <bpf+bounces-29088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3758C00CC
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 17:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D4DD1C215FC
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 15:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9448126F3A;
	Wed,  8 May 2024 15:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hv7rDTLH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544A61A2C05;
	Wed,  8 May 2024 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715181602; cv=none; b=WEF2vigJkz4MawjidLzcHttVEovk7+UrGA5lKvzPahbHk8u750A7r8OwaTkZinY/Co/efPG7HU3PLSNstAJm+pMmOo73Ebp3W2ZA5TFbdcW4lSnr1AGddOFE3UOYV3tRoEkrQBOFmD1ipYx9rEhYCv9FpO3yCt4uraJyOKK3eKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715181602; c=relaxed/simple;
	bh=kPkA9p7uZs1VyeX10od+xbCvAiD3OqwenuDPcZ6dfeg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HsQznUK9oXayVkN5zvaOSwbyJB4mjUDc8etVZ06pYghPl845I9pmxkPLsST1QPE3TIYrAYW7cr2CvoQgRqwlVOGH6xSlWM/eI223NaPFHgpC86euAwvDfhF4BvYDrG5J7oNVlifK0gWWQgb7aVf575xM+pjbKi9SZnhnk5zQwcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hv7rDTLH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5115BC113CC;
	Wed,  8 May 2024 15:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715181601;
	bh=kPkA9p7uZs1VyeX10od+xbCvAiD3OqwenuDPcZ6dfeg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hv7rDTLHrcFLeA+kc75PxtnGB+/1C149EkYbwJoC6QJhT2kY77UTruqDPYDhniKNh
	 AC2jmRlQ6a3WcJwql/Kwa7dnFN1TTtRaswNL8MYpxuidODebY1Ej6YtZatbyRKXKIr
	 sDC4BEmeTWWRC7oHCKj2XjJ2juIKuCqrX8GQZ4NGM+M5y6YFLG1HI5qvlcZKmowTeC
	 r/IG77OY9dZ2TdsFK0mWqHwIPFIlho6w8WpFcFcIdiOlv3dLMndAigICQlU8WiRqF5
	 X7nwlzMrlJcKp3YuQhJtOAE5sQdl9qsPWc3ICse+xXNaddUUpsqfQzM/BOE3W1t4sx
	 EOjxhIZ+cK1iA==
Date: Wed, 8 May 2024 08:20:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 bpf@vger.kernel.org
Subject: Re: [PATCH net-next 0/7] virtnet_net: prepare for af-xdp
Message-ID: <20240508082000.4938fb56@kernel.org>
In-Reply-To: <20240508085308.GA1736038@kernel.org>
References: <20240508080514.99458-1-xuanzhuo@linux.alibaba.com>
	<20240508085308.GA1736038@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 May 2024 09:53:08 +0100 Simon Horman wrote:
> On Wed, May 08, 2024 at 04:05:07PM +0800, Xuan Zhuo wrote:
> > This patch set prepares for supporting af-xdp zerocopy.
> > There is no feature change in this patch set.
> > I just want to reduce the patch num of the final patch set,
> > so I split the patch set.
> > 
> > #1-#3 add independent directory for virtio-net
> > #4-#7 do some refactor, the sub-functions will be used by the subsequent commits  
> 
> Hi Xuan Zhuo,
> 
> This patch is targeted at net-next,
> but unfortunately it does not apply to current net-next.
> Please rebase and repost taking care to observe the 24h rule.

Also - is this going to conflict with your premapped DMA work in the
vhost tree? If it does - just wait, please, the merge window is in 
a week..


Return-Path: <bpf+bounces-30989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 702C38D586C
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 03:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8EFFB234BB
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 01:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3CC5381B;
	Fri, 31 May 2024 01:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8SufgHQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33276FB8;
	Fri, 31 May 2024 01:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717120520; cv=none; b=QT/15cOXGBwYuFSR8vTDjdyAgXfl/GUOXtaaUXu2fxhyOFtiVwbH5RB9f0mLftJV4FbSim2U9qrAmHmIeQuJfcxA9zBBqIa2JWtbzycF5JQmyu9+G3xMxZsXVR5HkqpIpAnr0qtB5V+KtTrzvg9ZAL/pqteZijAC8c6bQrCbPK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717120520; c=relaxed/simple;
	bh=1IEQyz7p2hoNqq0GaMDs8SEsMKNwfC4DjSefuB3cLeo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nMQMNmTvW3Iaskgcz27ljKebLUTIaBnamU6LTThWMj5kjqEw/iGupL8gIyOwsfSDMtnuJL6IzBr+ncOE1iOo0n5EO/qaneamZARnErzjxF8T0GTUsJR1csK4lucjN5EGk9Ugb1KKo2rhWV7ExPGWFty65YTHWnCF2FH7nsVYr88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8SufgHQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4870C2BBFC;
	Fri, 31 May 2024 01:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717120519;
	bh=1IEQyz7p2hoNqq0GaMDs8SEsMKNwfC4DjSefuB3cLeo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D8SufgHQAJrT7YILEQ8D46+6vJp6Z2RgCH+LSBu2l/CMMotbixxcFDGFNJm2m6OBo
	 7NGXKF2mo+eDzGCB2GbkMZyaW+BB3KIJJ3UfBslypPwaExa+7P0Qw4nuWPyiKL9194
	 xWCFkT6xhpq49FFrt6ndSYYvy+6HSMtWwmSViMkdLtIq+qBZJ2zNYtb6+xkJZGOBmE
	 8IaPvL6yKOXiUojAcTWbAqOllr3b1k6O6pBMe8Bgm6r7daHQHCBV4gOGbg/ziMDDOp
	 U4ETALNWtGex0fAXUJsLuKN/UHjZbBHa0LVqu8LhteOe9slhYpcS0h5b9fMjC19QTw
	 XMGdXhmxRLsRA==
Date: Thu, 30 May 2024 18:55:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Eugenio =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 bpf@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next v2 00/12] virtnet_net: prepare for af-xdp
Message-ID: <20240530185517.33ba5daa@kernel.org>
In-Reply-To: <1717119614.404968-1-xuanzhuo@linux.alibaba.com>
References: <20240530112406.94452-1-xuanzhuo@linux.alibaba.com>
	<20240530075003-mutt-send-email-mst@kernel.org>
	<1717070084.6955814-1-xuanzhuo@linux.alibaba.com>
	<1717119614.404968-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 May 2024 09:40:14 +0800 Xuan Zhuo wrote:
> On Thu, 30 May 2024 19:54:44 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > On Thu, 30 May 2024 07:53:17 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:  
> > > It's great that you are working on this but
> > > I'd like to see the actual use of this first.  
> >
> >
> > For me, that is easy. But how should we do, if we use one patch set,
> > then the commit number maybe 26, that exceeds 15 (limit of the net next).  
> 
> Hi, Jakub
> 
> There will be a huge patch set (about 25) to support AF-XDP for virtio-net.
> Can I just post this huge patch set if the maintainers of virtio-net agree?

First of all, I see you posted v2 within 4 hours of v1, without really
waiting for Michael to reply. So I guess that 15 patch rule is not the
only one you intend to break?

On v1 Michael asked you to not do the rename, and start with AF_XDP
support. Why don't you do that instead of asking me if you can break
more rules?
-- 
pw-bot: cr


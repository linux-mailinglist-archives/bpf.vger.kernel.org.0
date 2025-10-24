Return-Path: <bpf+bounces-72155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F8CC07FF2
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 22:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F03271B85873
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 20:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8034E2E7650;
	Fri, 24 Oct 2025 20:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0I5GQ4Q"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0E3280035;
	Fri, 24 Oct 2025 20:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761336611; cv=none; b=qMxD0NZbGQPhFSRrdptrcUUv852+1+3SCjAu6/nSu3WzzPfkyTo9lRHJ3FwTAjH/+HrxQfbZ8LN5NZimRTrR0cPFxkyq7ox3Q14q9G6gLiK2mdoD3iIpBP1g9wXvvVwNuaW6nA4r4QlGpTPHxGgg4+vdcJmMyWhYVCDas9n87UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761336611; c=relaxed/simple;
	bh=JQSU/ULQM8PBnWSpjIk9v6tBF2mGFNWAoyLqlJyQWXU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dEGDNUlTeGuUkfqDXjEjNer1KqCO8TYX65ybqoFCgkVkJSUPFGbYBewqlsz+Y96PVqYpuO47Rl+Njx097pB0NkZc/gg/SlezvYGFCbrhqIONzE7x41uZsyvD3E3se7nHD6mW8QV5/6sK5IFucyol4AeQmaWjzQI7h+stB9A82hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0I5GQ4Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A598FC113D0;
	Fri, 24 Oct 2025 20:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761336606;
	bh=JQSU/ULQM8PBnWSpjIk9v6tBF2mGFNWAoyLqlJyQWXU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L0I5GQ4QNFgF8wXcvID7rKQS1G86cYzoDxpMiYokgHOy/NOttUv1wKdaqiPCq5Rgo
	 6Uo41aKtiFSz+ukGDYuo2lB0LNZ05O5r+GT0kNNN1Gf0X/7Ng1DNPbVXHShzmCKKwU
	 koB0CVpEjNQhH13l2COh8Zktlx30FeEWUGYX3ryutqscV5xo4AkozIretykwUblwMI
	 sGZxYWWBk+eKkDqSJns6VXfVH6KR41Uni3IXha0pFWrJltgJ7VDbJmxYldVCzsJE38
	 g2mEM3pL6mXGb49lpo3OmPoHUdu+6lzaJ1ZRgbQeZtEZC14LW4UN+mmTeM/h276LJ7
	 T9flFDDCxr1fw==
Date: Fri, 24 Oct 2025 13:10:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ankit Garg <nktgrg@google.com>
Cc: Joshua Washington <joshwash@google.com>, netdev@vger.kernel.org,
 Harshitha Ramamurthy <hramamurthy@google.com>, Jordan Rhee
 <jordanrhee@google.com>, Willem de Bruijn <willemb@google.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Praveen
 Kaligineedi <pkaligineedi@google.com>, Ziwei Xiao <ziweixiao@google.com>,
 open list <linux-kernel@vger.kernel.org>, "open list:XDP (eXpress Data
 Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 2/3] gve: Allow ethtool to configure rx_buf_len
Message-ID: <20251024131004.01e1bce7@kernel.org>
In-Reply-To: <CAJcM6BFTb+ASBwO+5sMfLZyyO4+MhWKp3AweXMJrgis9P7ygag@mail.gmail.com>
References: <20251022182301.1005777-1-joshwash@google.com>
	<20251022182301.1005777-3-joshwash@google.com>
	<20251023171445.2d470bb3@kernel.org>
	<CAJcM6BFTb+ASBwO+5sMfLZyyO4+MhWKp3AweXMJrgis9P7ygag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Oct 2025 11:17:04 -0700 Ankit Garg wrote:
> > Please plumb extack thru to here. It's inside struct netdev_bpf
> 
> Using extack just for this log will make it inconsistent with other
> logs in this method. Would it be okay if I send a fast follow patch to
> use exstack in this method and others?

Could you make it part of this series, tho?


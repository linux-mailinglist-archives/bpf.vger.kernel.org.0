Return-Path: <bpf+bounces-69647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3C0B9CD28
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 02:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA2B716D06C
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 00:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D0A747F;
	Thu, 25 Sep 2025 00:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcwMnP+f"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A181367;
	Thu, 25 Sep 2025 00:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758758960; cv=none; b=RV9+H7DPYLtRkHXg6NVbZy76JL+yU/zFOD63ML0EVlpiDrwDcZp5tFwIw9df5/V8ucGWswcceA2t9E7nbkBj/DVBn1grMITVdfURiwyD1EUN2A2qEUmqK9Zm5xvIE/17xzBGGDIVOxUkwDgiv10NEPv+U0AwD42vbSmrzQJNgT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758758960; c=relaxed/simple;
	bh=zXw5DYxwpEjeQXD/5cFfmv69GmzKNfiIIaJv56tI04M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cRlRHHCQWygkSwZox1YBRCDq5FBYOYrv0IWdteP7WISuQrq698kpE8drdYD1wsyopek/i3V4mq9WTZv5qnMPRE0rB9b8zLQVA4AwcOE0n6D6DI1vtvJDWBUMwyPozFNNYVccd1eaKedTKi3W7ydK/FjdKsVElvkx3uJhtwkqcgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcwMnP+f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB108C4CEE7;
	Thu, 25 Sep 2025 00:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758758956;
	bh=zXw5DYxwpEjeQXD/5cFfmv69GmzKNfiIIaJv56tI04M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DcwMnP+fSTTIt6L/+/KYWD65ImSA1ZyK84T8BFjldMZStL68YdKe0cLtbRVC7y+1o
	 0x87AVC4yQVu+Qtg2Pl1x2+GwCmkzklr+WF2ZrcA0OsAykBRWCxqYYLalOVP2o9Mxb
	 HnxFgM1GdMLKnbO1BzHkzCAAV9Z9rVUqpdKqOiq/D4eIQCTNYBURM5jE/ElHYS7utZ
	 sy1oRohUrz14S1yzl3pt6TtnEX7jQqQnA/nCfHKMjk31FOEDAfPgKt+QrkEUfQvqOf
	 +x2+ss6HLzrRZaKsE1FmCl//jCxNptXigCUDsY6MN5xjY6g71c34Li5873B5ZzNOZO
	 UGMqy6Jo2+0dg==
Date: Wed, 24 Sep 2025 17:09:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Octavian Purdila <tavip@google.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, uniyu@google.com,
 ahmed.zaki@intel.com, aleksander.lobakin@intel.com, toke@redhat.com,
 lorenzo@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com
Subject: Re: [PATCH net] xdp: use multi-buff only if receive queue supports
 page pool
Message-ID: <20250924170914.20aac680@kernel.org>
In-Reply-To: <20250924060843.2280499-1-tavip@google.com>
References: <20250924060843.2280499-1-tavip@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 06:08:42 +0000 Octavian Purdila wrote:
> When a BPF program that supports BPF_F_XDP_HAS_FRAGS is issuing
> bpf_xdp_adjust_tail and a large packet is injected via /dev/net/tun a
> crash occurs due to detecting a bad page state (page_pool leak).
> 
> This is because xdp_buff does not record the type of memory and
> instead relies on the netdev receive queue xdp info. Since the TUN/TAP
> driver is using a MEM_TYPE_PAGE_SHARED memory model buffer, shrinking
> will eventually call page_frag_free. But with current multi-buff
> support for BPF_F_XDP_HAS_FRAGS programs buffers are allocated via the
> page pool.
> 
> To fix this issue check that the receive queue memory mode is of
> MEM_TYPE_PAGE_POOL before using multi-buffs.

This can also happen on veth, right? And veth re-stamps the Rx queues.


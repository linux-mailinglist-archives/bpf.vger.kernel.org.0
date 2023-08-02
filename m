Return-Path: <bpf+bounces-6677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEAB76C3EF
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 06:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C953281B38
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 04:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870CE1868;
	Wed,  2 Aug 2023 04:10:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C1F15B8;
	Wed,  2 Aug 2023 04:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87B80C433CB;
	Wed,  2 Aug 2023 04:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690949425;
	bh=CJd8mXJemcfMooHI8Zob7wc84xGAUX83lz4AkkEYPn0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RHqxP+1Pf+J/w1tyl+oG3Hw34WIGv4VviX6VcXmfi7SjAXq8kzHmIIuH9bxUnhxNR
	 l3CV6ckJ3WdtvxDa4LbRgVPLsQQR4dcIkG3etf6UyYGcxjsMGEldWDsjDPRjnf68AV
	 8ieGB/Yo3U0QTUHPgXCjRghletohS7Jxbgqu96HbLRZiEF8kACAEN2NqmWAR7hEk+P
	 nr9nPs/H/L+b1DdtY9x4QLkv4WqXOaCPFzyTzpAVjQ9RRkaXPsD8CXycu+0yf55iMk
	 LW+Tfl7qvzkMDJ6mHiPfgdHAhislOt4nQWr76i2h4dMEKE4Vl4d7bllvTWt06vgY8L
	 ABS7y6UxUxLqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 718AAC691F0;
	Wed,  2 Aug 2023 04:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V5 0/3] virtio_net: add per queue interrupt
 coalescing support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169094942545.31458.1603309182544531344.git-patchwork-notify@kernel.org>
Date: Wed, 02 Aug 2023 04:10:25 +0000
References: <20230731070656.96411-1-gavinl@nvidia.com>
In-Reply-To: <20230731070656.96411-1-gavinl@nvidia.com>
To: Gavin Li <gavinl@nvidia.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, jiri@nvidia.com, dtatulea@nvidia.com,
 gavi@nvidia.com, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 31 Jul 2023 10:06:53 +0300 you wrote:
> Currently, coalescing parameters are grouped for all transmit and receive
> virtqueues. This patch series add support to set or get the parameters for
> a specified virtqueue.
> 
> When the traffic between virtqueues is unbalanced, for example, one virtqueue
> is busy and another virtqueue is idle, then it will be very useful to
> control coalescing parameters at the virtqueue granularity.
> 
> [...]

Here is the summary with links:
  - [net-next,V5,1/3] virtio_net: extract interrupt coalescing settings to a structure
    https://git.kernel.org/netdev/net-next/c/308d7982dcdc
  - [net-next,V5,2/3] virtio_net: support per queue interrupt coalesce command
    https://git.kernel.org/netdev/net-next/c/394bd87764b6
  - [net-next,V5,3/3] virtio_net: enable per queue interrupt coalesce feature
    https://git.kernel.org/netdev/net-next/c/8af3bf668382

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <bpf+bounces-28241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA268B6EAC
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 11:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53C4E1F20F94
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 09:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AFF12882D;
	Tue, 30 Apr 2024 09:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJfpqiGd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7084A22618;
	Tue, 30 Apr 2024 09:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714470033; cv=none; b=dBKxhO5GoStztb+J70VxhW0TqxfWd9Gv0Z5QBb3Gekh3v6+DQUX5PkJ9FjU/LQW+aplesh+4bS7Gh1L0PrNrctd/WcTp8UWaiUM7FiVhztaC0jhxyBtmh2moR0aHhrQHVeVgDC6jB90h2HahG50jvxV0J46e5Y6AZRl9rtiFMKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714470033; c=relaxed/simple;
	bh=xR8ABvK2FjKgC5HeLW0NTCb2SyyQtugwt+6zGS947s4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G3SKDkWlwGQG6ieXRgapo3U+9ZpUi0GIZFvfZ2rDqZyrRSVDKCUbqiqvk86vyRNxB6PjflfbSZjjkLH/VURqDsgG9gl+yYnhYeNLusVXiVs4hhDzEHpcudO5xdvbCNHuF/WM0CmC7Z1MXd8XpmLd+qPFyGLyEzu8ajr0JibZSaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJfpqiGd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9CA7C4AF14;
	Tue, 30 Apr 2024 09:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714470031;
	bh=xR8ABvK2FjKgC5HeLW0NTCb2SyyQtugwt+6zGS947s4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qJfpqiGd2YHRjq49mU+llr8tzBXvTG0jTK+84tcRCW7HpTsLf7cohBrwk9vW7ujNu
	 j4F/2khs/YjvDg3p2sojX4qtqFsMWavNspP9Bu1aMatm+U1kx1VhBLpENj+C2rL6nI
	 SnJc0h2cvb9DPdzYKqRwVLMKkBzfax7PnozH2fklAtK346zqrcTh95Q6x2d3sBwWrC
	 5Piy7avmZ0Zapm+az+m/xFfIeyme36CmGDFIQ8Pdwatx6zolCR75SacyfKLpSLbeZI
	 eg9cM8J5ONJ/rC0UoWk1N3vcGZITGQj+ZXifYTkxfOt5eEKkMYPRdRj5xqOz1SbRGA
	 Y4F0Ouk+9dw4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C70C8C433E9;
	Tue, 30 Apr 2024 09:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 0/8] virtio-net: support device stats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171447003181.1656.10069538136883769865.git-patchwork-notify@kernel.org>
Date: Tue, 30 Apr 2024 09:40:31 +0000
References: <20240426033928.77778-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240426033928.77778-1-xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@google.com, amritha.nambiar@intel.com,
 larysa.zaremba@intel.com, sridhar.samudrala@intel.com,
 maciej.fijalkowski@intel.com, virtualization@lists.linux.dev,
 bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 26 Apr 2024 11:39:20 +0800 you wrote:
> As the spec:
> 
> https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82
> 
> The virtio net supports to get device stats.
> 
> Please review.
> 
> [...]

Here is the summary with links:
  - [net-next,v7,1/8] virtio_net: introduce ability to get reply info from device
    https://git.kernel.org/netdev/net-next/c/aff5b0e605b0
  - [net-next,v7,2/8] virtio_net: introduce device stats feature and structures
    https://git.kernel.org/netdev/net-next/c/34cfe8722136
  - [net-next,v7,3/8] virtio_net: remove "_queue" from ethtool -S
    https://git.kernel.org/netdev/net-next/c/de6df26ffced
  - [net-next,v7,4/8] virtio_net: support device stats
    https://git.kernel.org/netdev/net-next/c/941168f8b40e
  - [net-next,v7,5/8] virtio_net: device stats helpers support driver stats
    https://git.kernel.org/netdev/net-next/c/d86769b9d23c
  - [net-next,v7,6/8] virtio_net: add the total stats field
    https://git.kernel.org/netdev/net-next/c/d806e1ff79e6
  - [net-next,v7,7/8] netdev: add queue stats
    https://git.kernel.org/netdev/net-next/c/0cfe71f45f42
  - [net-next,v7,8/8] virtio-net: support queue stat
    https://git.kernel.org/netdev/net-next/c/d888f04c09bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




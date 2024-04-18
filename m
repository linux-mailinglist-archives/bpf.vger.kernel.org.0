Return-Path: <bpf+bounces-27136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A77AC8A9967
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 14:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DABC1F224BB
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 12:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D331607B3;
	Thu, 18 Apr 2024 12:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsE8oFd8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE0615FA73;
	Thu, 18 Apr 2024 12:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713441627; cv=none; b=L3hDqzDSTjFkTc03J0PUBLtJ/GcPwhUoHgq/4rXsb93QOOuNAuUsl45JWLLj5EerF0z016yhOYs+b2ju6RW0RJYkHs4mWVrleC5bL9LvjPz8wiIg+0GIBcFR4xEocvP8+S7ucJA3S9abPGI3J9NtBQUKpgL9NXii0a6tHAEbnik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713441627; c=relaxed/simple;
	bh=rPo9TthMK0P4N7lbHMc8ZTypT0fcxu/5EakHFagFdPw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KMHv/Wfkv8Cs1Wv8xdBWc/3rgPr7qgjDBBJ33ebXXjaARBIWWuV7DtU9u9XbB8wKGeCyezsi95xN3IEmSXDz0Gp9zumNIZmiTbIfpu6brofxBZOxPSydVH117UDLFiyZuOT5swi4dornUPDn6E68ftqRTdedKVHcFF+3YXWG4k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsE8oFd8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98EC7C3277B;
	Thu, 18 Apr 2024 12:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713441626;
	bh=rPo9TthMK0P4N7lbHMc8ZTypT0fcxu/5EakHFagFdPw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SsE8oFd838ll1K02ZjVTbqrQJOkzGmjzz06UHcj2iPQUd4gA7FMHMk6VUKJPuiSxM
	 kIhur93C12Kl/w3VWURjhSkahh/MRNb/dv/86fDtc7dzNptizPL5L0YjZS1BVDQTiA
	 90O0UWENFnBlzIUVmAHmjLjqH6WtQEmC5WUvR0rQ+b6LkpR8BtozpbjUHzJwpuPFrf
	 oZy256On18Rk/dLKYys5F7xA727mNbF79QgiXj69YzLMSnU+zhHbrsJG9ur4Ei20O9
	 zGR8H/E5SMR+ng/r4O3iMXnbKlkYxIdA7wAs5nO9FlT1CPnfLUHyUJ3nALkf0HA3p/
	 bQw2jKgQ7Ll4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 80884C4361B;
	Thu, 18 Apr 2024 12:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v9] virtio_net: Support RX hash XDP hint
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171344162652.14598.2419133299959560356.git-patchwork-notify@kernel.org>
Date: Thu, 18 Apr 2024 12:00:26 +0000
References: <20240417071822.27831-1-liangchen.linux@gmail.com>
In-Reply-To: <20240417071822.27831-1-liangchen.linux@gmail.com>
To: Liang Chen <liangchen.linux@gmail.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 hengqi@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hawk@kernel.org,
 john.fastabend@gmail.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 17 Apr 2024 15:18:22 +0800 you wrote:
> The RSS hash report is a feature that's part of the virtio specification.
> Currently, virtio backends like qemu, vdpa (mlx5), and potentially vhost
> (still a work in progress as per [1]) support this feature. While the
> capability to obtain the RSS hash has been enabled in the normal path,
> it's currently missing in the XDP path. Therefore, we are introducing
> XDP hints through kfuncs to allow XDP programs to access the RSS hash.
> 
> [...]

Here is the summary with links:
  - [net-next,v9] virtio_net: Support RX hash XDP hint
    https://git.kernel.org/netdev/net-next/c/aa37f8916d20

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




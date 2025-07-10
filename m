Return-Path: <bpf+bounces-62869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EA4AFF695
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 03:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41AF57B40AC
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 01:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A32E27EFEB;
	Thu, 10 Jul 2025 01:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nr0CpFpE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA80542AB4;
	Thu, 10 Jul 2025 01:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752112784; cv=none; b=GtBI5cmcxZkK6+rVFGHIuVln5zQibIysRLKXfhAzS+h6Dq0M+2nf3MB12sxpkoUiEZ5ayqhMOyu9RbKpq/H6C8E/13trPiFLSYxjSYx9JJfBkoba+NSI/mOHZRwdnxfCXShH0wQtlmBXioOIJzuJPpbldwgPnvXyl44tLDEiwkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752112784; c=relaxed/simple;
	bh=O1GCpSX4Cy7TfdvPuHa0WAkHsRBKX3c4B8Ue3NoFr0A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RvlFoLq9iID4GSyayxUG+eBhaRIVLabiFWZrId46pEbbCN3E0scvEl9cyWC383ngMKrBoSOb/sDRAt/l04TdjqJ4CiygIiHZlVweJlHR6/itnfXW8DLqOAfM1u30S73ELXOkNdL/+82yn62QR8RCXsdCXyyb174/S1Q+Y4lbqeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nr0CpFpE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487C2C4CEEF;
	Thu, 10 Jul 2025 01:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752112784;
	bh=O1GCpSX4Cy7TfdvPuHa0WAkHsRBKX3c4B8Ue3NoFr0A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Nr0CpFpE8GCvAnhxFtSjNe3bTavh40kVkR48wpHR/4H5OtN2opcLyzC8VnqlZ1jpo
	 Gz55DJyDS6oESF7vZiO2UIE7ytMKPNw5k5lf/oeqRqTChHaE2zYmj3vEhcMh3jpczV
	 swNwK9KRgG8Dc/wska3rxMlwJIXbWQb9qXHi8bKT7816PvMNHNPm/hTSxZco1kDaxw
	 PrK5/dfqkxiwGImCNPs8BKNNu7U25eISF7awQg7ckKOYpkrVeWScHD5IOtmiVSek3S
	 uRo6PsBAYa6nSdlALWKd0HATCyID2ECs3LUafwt0OPKFvu1OBHB+kUgHgo8VayAAfM
	 50X5TU1zQat8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id DEC94383B261;
	Thu, 10 Jul 2025 02:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] virtio-net: xsk: rx: move the xdp->data
 adjustment
 to buf_to_xdp()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175211280676.957497.383613725548170335.git-patchwork-notify@kernel.org>
Date: Thu, 10 Jul 2025 02:00:06 +0000
References: <20250705075515.34260-1-minhquangbui99@gmail.com>
In-Reply-To: <20250705075515.34260-1-minhquangbui99@gmail.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  5 Jul 2025 14:55:14 +0700 you wrote:
> This commit does not do any functional changes. It moves xdp->data
> adjustment for buffer other than first buffer to buf_to_xdp() helper so
> that the xdp_buff adjustment does not scatter over different functions.
> 
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] virtio-net: xsk: rx: move the xdp->data adjustment to buf_to_xdp()
    https://git.kernel.org/netdev/net-next/c/f47e8f618c7d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




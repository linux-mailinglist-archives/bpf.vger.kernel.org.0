Return-Path: <bpf+bounces-62247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FEFAF6EF2
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 11:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 545AE52627B
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 09:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25EC2D7812;
	Thu,  3 Jul 2025 09:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXV+6bY3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F01291C37;
	Thu,  3 Jul 2025 09:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751535586; cv=none; b=KvV9Vc7ecvNH2yED/91VXO9V0unBdNO1GwezI0ekwV3MUs8wDF2b7G/YxgjOAmUAaiJwEpYanRK24MsEG8MmNgVHr06nQj/opgYgR/AQXr/S54o6jJhenKfIZNXGjMoKw1lTt36fxjsCUGbTiyg5CqCtpYvPb5m6n+lntAGbLI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751535586; c=relaxed/simple;
	bh=ODf9SeJXknLRDbICjYsDqcjPJruZILYsOHMug+ircg0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ujrwOoIsp7OVUFbIaphY9kxJmrKS7KRq2zlOxDN+d0/qAB3cuPAufAzieopxI+3LkVFwk4I4s5xYCG+w4Tsi/ZHdC28f+Ta8NzPyhfEpP1uf6v//UsKhQCp0LceX49UU/tdEMrXFxB34YnoEdPWM1Acootkjgos5VjhBIWAtNw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXV+6bY3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66C6C4CEE3;
	Thu,  3 Jul 2025 09:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751535583;
	bh=ODf9SeJXknLRDbICjYsDqcjPJruZILYsOHMug+ircg0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GXV+6bY3MEwhu3tRKgKfyLwKCxNQBGfhs7i5IfgfFcqtzPbtUCdGpSYuLpF0/z+oq
	 v0I0AknKHPj7X3zNynSLuB8jzwpWdr89a7ceCsOVTtYeuHFVWqC9r1q1fusVXsaXA+
	 YqUvHUCycJ2kxW9t+NfV3daWE82+3+VIBie2ny+Xj0B9HleaFqdpgLXVuIyiDkr64Q
	 ZmVOrtu5uF60Onkph8XM8DYMHoagyZVVpeS8X6VFBujaRijSrWT+x6nUCmkf7acKx/
	 CTp59st/6lbRWHLn2Iz2K29gtkxU70fE713L+BQzunMzxYHVBzxEhmq47JVCEuxvGj
	 MDAuhQyA8rizQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F42383B273;
	Thu,  3 Jul 2025 09:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] virtio-net: xsk: rx: fix the frame's length
 check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175153560802.1029220.2379425113852015641.git-patchwork-notify@kernel.org>
Date: Thu, 03 Jul 2025 09:40:08 +0000
References: <20250630151315.86722-1-minhquangbui99@gmail.com>
In-Reply-To: <20250630151315.86722-1-minhquangbui99@gmail.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 30 Jun 2025 22:13:13 +0700 you wrote:
> Hi everyone,
> 
> This series contains 2 patches for the zerocopy XDP receive path in virtio
> net
> - Patch 1: there is a difference between first buffer and the following
> buffers in this receive path. While the first buffer contains virtio
> header, the following ones do not. So the length of the remaining region
> for frame data is also different in 2 cases. The current maximum frame's
> length check is only correct for the following buffers not the first one.
> - Patch 2: no functional change. The tricky xdp->data adjustment due to
> the above difference is moved to buf_to_xdp() so that this helper contains
> all logic to build xdp_buff and the tricky adjustment does not scatter
> over different functions.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] virtio-net: xsk: rx: fix the frame's length check
    https://git.kernel.org/netdev/net/c/5177373c3131
  - [net,v3,2/2] virtio-net: xsk: rx: move the xdp->data adjustment to buf_to_xdp()
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




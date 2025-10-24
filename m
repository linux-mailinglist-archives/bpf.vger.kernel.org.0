Return-Path: <bpf+bounces-71975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A34C04041
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 03:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A1884F5F40
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 01:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238461DE2A0;
	Fri, 24 Oct 2025 01:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugsVxT2k"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D51A1C3F36;
	Fri, 24 Oct 2025 01:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761268829; cv=none; b=pXMcOniz3A+LGObMzv1pei+WR+ct/37okOQTGpPfEWsH4GiZMBDFJ1ZH1zUOn7UiPUrBMOdhPyiI6QoQqCTHHsJOZ5C58DXIC+sdWcXxqiZGtZAhSB7INPbNa399ObmnAqaFVmTK96Xwkd3NOv6EEIVks4wPzjuBaJ5JAhqTgOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761268829; c=relaxed/simple;
	bh=aARtou9nCbXC3uTPpXL2tm/ef62gFzMMXNs0ouEQbCE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LTeocaNZEtVDUF6HcA2acdMu578CtT+aU2DFEPeSVRpHd/a+gkmDFE+zzDhNGZZNm9ftVuTqRQjnXnMA5KNwf5o/C4g2aW+74UXJid4KPu1GAqWWAQgu2VnmNuuggsI0lYTOcXuSft/zPEapn9E8DqXqj3hbmSR9zz5YLf+Q23Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugsVxT2k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E22EC4CEFF;
	Fri, 24 Oct 2025 01:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761268829;
	bh=aARtou9nCbXC3uTPpXL2tm/ef62gFzMMXNs0ouEQbCE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ugsVxT2kXj1753qRfcMkCY+0nXjbm560Z7NaAnyAX80OJtA471rlfPdPClo8IZgK7
	 d/YRt+MrCbMwTAJ7vKhwOsj2sxoE5k4JD9zm78kfxSh+XQpA++KJSY2uIsLASVZVjS
	 hrEODT98yXvclbh6Csme44+Jb2Fums/NU8Ub12YSg9i+fnWC3gVCaCKMncgBWBz4Fi
	 v0oAcw4Ts8dkKcEeiDW9jNsKuYm/IYu+3C5ihdmtRuhEL0a5mkuoz1FqXXXnVIqm2v
	 IoH311DNVA4eeKtNvDeM9xskFsp+Ks9eEWfn5McXklvlOezGMG5g/CMMhsa/jMHvKt
	 6UEf62F23U+og==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 89DB63809A38;
	Fri, 24 Oct 2025 01:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] virtio-net: drop the multi-buffer XDP packet in
 zerocopy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176126880925.3310205.7564806694016358052.git-patchwork-notify@kernel.org>
Date: Fri, 24 Oct 2025 01:20:09 +0000
References: <20251022155630.49272-1-minhquangbui99@gmail.com>
In-Reply-To: <20251022155630.49272-1-minhquangbui99@gmail.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Oct 2025 22:56:30 +0700 you wrote:
> In virtio-net, we have not yet supported multi-buffer XDP packet in
> zerocopy mode when there is a binding XDP program. However, in that
> case, when receiving multi-buffer XDP packet, we skip the XDP program
> and return XDP_PASS. As a result, the packet is passed to normal network
> stack which is an incorrect behavior (e.g. a XDP program for packet
> count is installed, multi-buffer XDP packet arrives and does go through
> XDP program. As a result, the packet count does not increase but the
> packet is still received from network stack).This commit instead returns
> XDP_ABORTED in that case.
> 
> [...]

Here is the summary with links:
  - [net,v2] virtio-net: drop the multi-buffer XDP packet in zerocopy
    https://git.kernel.org/netdev/net/c/1ab665817448

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




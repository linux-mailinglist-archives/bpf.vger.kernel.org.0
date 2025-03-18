Return-Path: <bpf+bounces-54294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F41A1A67191
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 11:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D42E03B3121
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 10:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F892080F6;
	Tue, 18 Mar 2025 10:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDkPUGRi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E59935957;
	Tue, 18 Mar 2025 10:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294398; cv=none; b=QYvnu/X2l11fBACk2YsAhufCd5BN4O16WvVTP+Vg1BC2fMUEZ0IkVy0sMjIPgvIDORxr91IiMja0ZFXdloR368hh47B5XrKvNGh7PxO3EavnLwNonsrXFb9b9XA4JeePNXa74iH70VqZK2uGT/pPaglA8IoVIUfrAokKho2FjQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294398; c=relaxed/simple;
	bh=yc7zqx+OxHv/IMqY+YNnetE41OylMpiIkl27mOUynxk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gvwZ6gY4m9v5Xknz1bS45DmKL0cD2VvQ4tS23GKxQSCt/x+cBGnxm5LFElRa1Wg7ARt1LY1nalRQVxGVjQ3NpXc617hFYYu1b71/jrcPxCyJuQhRfDuXpXVZnrOGL4+JyU2m4BbEyeEHxEPuiGOtDPvKWDwLT3kPS47aS0plmPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDkPUGRi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0897AC4CEDD;
	Tue, 18 Mar 2025 10:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294398;
	bh=yc7zqx+OxHv/IMqY+YNnetE41OylMpiIkl27mOUynxk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KDkPUGRiJ1Z1Z4939QldG0X+WQJ32AAH8VVKBRgDn7GS5TEL+Vk5TzHy02/y2y2MW
	 lo4V13l4jzCvbF7Oz6vre7pTrZK+ma463zONSqpo1GuDk74YtXww/kiz/zXataRUN3
	 2cOXu1mI2e2wKePXUzCc7krtViYPza3X90ajyJwEljbOLz8swOyWtFSiAKMr8tFwep
	 B8HNZiISLOqWRThdQDp4WT+pdZF90CbDR2XY3UPJOhIW0/8+vRZvjWIeVu967d/NC1
	 +4UrvaS0zWZi/fFmfCNSs0yUI37ohbhJijVQ03m49B5Qqj77eCgfeLk2itb1eB5bQU
	 Sr+QZuSWfDLiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCFE380DBE8;
	Tue, 18 Mar 2025 10:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net, v2] net: mana: Support holes in device list reply msg
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174229443352.4121686.16390383301229886639.git-patchwork-notify@kernel.org>
Date: Tue, 18 Mar 2025 10:40:33 +0000
References: <1741723974-1534-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1741723974-1534-1-git-send-email-haiyangz@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, decui@microsoft.com,
 stephen@networkplumber.org, kys@microsoft.com, paulros@microsoft.com,
 olaf@aepfle.de, vkuznets@redhat.com, davem@davemloft.net, wei.liu@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, leon@kernel.org,
 longli@microsoft.com, ssengar@linux.microsoft.com,
 linux-rdma@vger.kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 bpf@vger.kernel.org, ast@kernel.org, hawk@kernel.org, tglx@linutronix.de,
 shradhagupta@linux.microsoft.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 11 Mar 2025 13:12:54 -0700 you wrote:
> According to GDMA protocol, holes (zeros) are allowed at the beginning
> or middle of the gdma_list_devices_resp message. The existing code
> cannot properly handle this, and may miss some devices in the list.
> 
> To fix, scan the entire list until the num_of_devs are found, or until
> the end of the list.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: mana: Support holes in device list reply msg
    https://git.kernel.org/netdev/net/c/2fc8a346625e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




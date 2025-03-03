Return-Path: <bpf+bounces-53125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E8DA4CE87
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 23:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D195618879C9
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 22:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBB8236A8E;
	Mon,  3 Mar 2025 22:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A90lqZc0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3B4212B2F;
	Mon,  3 Mar 2025 22:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741041598; cv=none; b=JxsSwsYQ2BpPHrEzUKFdrX9778wd2KZaigwlmvJtm5i0q2Aht3QCBJ3tbSRXCKQxm9NxErSJ0Mgyv17nA8OFbN6baZpPEuaIUT2g77uJwLGJLcvM0SzYNVL79sD2xIhYJjzhSet97wNHi0fko3rvkR3yxOcpRQnNhOw7eSDuM9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741041598; c=relaxed/simple;
	bh=dNjQ+Gtua5eX7r+UCvQQi9mBxp6eDZm379eQznEbG7s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g2yYEPn4eo1UgYjTqo/qAQJqzXhMaEn0cczEIIjSDiUgsvE8rqSn6zxFv/P/N621LLEo64+X1prQPu0dSvxIVoaZV0UPyAwS8cjvATvxftLemyK+A3/bsp02KapdRUupRQF11P4/Ui9IQ3WY3qpZOGdK8GD1/jvYh4WrPNUe3/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A90lqZc0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE49BC4CEE6;
	Mon,  3 Mar 2025 22:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741041597;
	bh=dNjQ+Gtua5eX7r+UCvQQi9mBxp6eDZm379eQznEbG7s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A90lqZc0bnnS9p0MLFJrL/aFLHvI1TNPZAdcoSleQJNMFQg3lDM/vvJnOEGOTbMAV
	 hC4SnArUMZAr2Ji99DoGq2YRGavcsm370Y8M28glJyqsq3VjjhDSNjRWwRaNXKbIDW
	 2wuYzgYwLGSe3wTi9ZRwIiS6Kikd41rOuTAPVuhKOeKSO38613oq0viBtssAj1Twg1
	 S70rQ7oFPEVwab4RKBPJdmJGvBwP+46iSTImhO4ai2L/57Ei6wUcYZ6S/4D/Vjzqnf
	 Ym13PB33q6BSHumNBsTIPIi6mBk8g53Pc1HFocnKHWqm01PKO7g2WMWD4i5B2y6hv7
	 w9Am9unPN8FZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE8B53809A8F;
	Mon,  3 Mar 2025 22:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] xsk: fix __xsk_generic_xmit() error code when cq is
 full
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174104163051.3740022.6320098625451049670.git-patchwork-notify@kernel.org>
Date: Mon, 03 Mar 2025 22:40:30 +0000
References: <20250227081052.4096337-1-wangliang74@huawei.com>
In-Reply-To: <20250227081052.4096337-1-wangliang74@huawei.com>
To: Wang Liang <wangliang74@huawei.com>
Cc: bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 yuehaibing@huawei.com, zhangchangzhong@huawei.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu, 27 Feb 2025 16:10:52 +0800 you wrote:
> When the cq reservation is failed, the error code is not set which is
> initialized to zero in __xsk_generic_xmit(). That means the packet is not
> send successfully but sendto() return ok.
> 
> Considering the impact on uapi, return -EAGAIN is a good idea. The cq is
> full usually because it is not released in time, try to send msg again is
> appropriate.
> 
> [...]

Here is the summary with links:
  - [net,v2] xsk: fix __xsk_generic_xmit() error code when cq is full
    https://git.kernel.org/bpf/bpf/c/6ccf6adb05d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




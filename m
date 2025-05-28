Return-Path: <bpf+bounces-59127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A0BAC621E
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 08:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 905F29E6071
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 06:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D4F244663;
	Wed, 28 May 2025 06:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MG+tGgO7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B0D1F1507;
	Wed, 28 May 2025 06:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748414394; cv=none; b=LkSuJW/NHE2XSofv0lwclFHmcT+OLc7pjeZ8PqcxJ8P1T9t5d/LA9b2ct7H8SXc0/m+DaIH4AcBvPt7QY4PMLZQtVBlvZNE7mRweILsepFzCsnBraW5HLAfbyk+iMX7FkS0C70c0DWTaH/pzqPauWodGVgLnJJZm1R2wmeOhmS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748414394; c=relaxed/simple;
	bh=6kzdFimLYbbRrahrMQogfiYEoFCwuFBfTY0KaSQMewI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pw82rP/MCnUel3y6MI2Ah/cCszXsFNQszSLFS0YYSbFibo3sW1J9yXTIQAGI+Ua92NjTwlNpHTBZJLfpB2VgXhcPg7B0K3qOGnQyjPeuYpwnFwXP8y2wYdF3uDrtlcHdG6yU0aT9EK4EvvBHUJYfxP9dnKtGWJKfAeFFY5d6IQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MG+tGgO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241BDC4CEE7;
	Wed, 28 May 2025 06:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748414394;
	bh=6kzdFimLYbbRrahrMQogfiYEoFCwuFBfTY0KaSQMewI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MG+tGgO7sqNV/yoBBf6BNGKaSykvoPPK/2rnCDFcR2diBn0X1IFuoJwDrfXzT9g6m
	 ZCyr7FLMKDa+SncilWAC5M8bbDHwWl6KgXt/558Lu3TSKMRyW8SsHiqT3oOt0jfMy6
	 G5DDDN3onCt2A7zHa+ys2XnIbNanZDCZFxTFLdgbQdIiyOgBAMHTvdk2QPViesvU5X
	 F5RN72EAP4PGtSDlqSEfueV1AqZ9J3ec1XYzk1m2Im9R++WC012/q7hy86TgnZTuXR
	 5f5d/R7MVAMRW21LPoH4rM3CP/I8eE3pGuNIU+F9xqj0hoC1giT5Tglum4xVdeaPsK
	 QIintSI4oQ5Bw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D6039F1DE4;
	Wed, 28 May 2025 06:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next,v2] net: mana: Add support for Multi Vports on Bare
 metal
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174841442825.1926848.6843941704832885467.git-patchwork-notify@kernel.org>
Date: Wed, 28 May 2025 06:40:28 +0000
References: <1747671636-5810-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1747671636-5810-1-git-send-email-haiyangz@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, decui@microsoft.com,
 stephen@networkplumber.org, kys@microsoft.com, paulros@microsoft.com,
 olaf@aepfle.de, vkuznets@redhat.com, davem@davemloft.net, wei.liu@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, leon@kernel.org,
 longli@microsoft.com, ssengar@linux.microsoft.com,
 linux-rdma@vger.kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 bpf@vger.kernel.org, ast@kernel.org, hawk@kernel.org, tglx@linutronix.de,
 shradhagupta@linux.microsoft.com, andrew+netdev@lunn.ch,
 kotaranov@microsoft.com, horms@kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 19 May 2025 09:20:36 -0700 you wrote:
> To support Multi Vports on Bare metal, increase the device config response
> version. And, skip the register HW vport, and register filter steps, when
> the Bare metal hostmode is set.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
> v2:
>   Updated comments as suggested by ALOK TIWARI.
>   Fixed the version check.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: mana: Add support for Multi Vports on Bare metal
    https://git.kernel.org/netdev/net-next/c/290e5d3c49f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




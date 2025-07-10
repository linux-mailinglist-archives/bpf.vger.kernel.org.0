Return-Path: <bpf+bounces-62917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7B6B002BC
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 14:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4DDB1C423C6
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 13:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86893269B1C;
	Thu, 10 Jul 2025 12:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2yUjAa4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F7B2676F4;
	Thu, 10 Jul 2025 12:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752152387; cv=none; b=pfHXvQ4STAmiOcBDld/MrrBFoAjAHT3bRqSJQF3s+h8CR1SIBNMD5KuxlWDEHxnmVqk7/WHyePoa/ghCbcJuT2CqihvukT5Q6Oxbtg8kkcaD/lDkxPEwH4vxglvPFBxbWw2YCDFLye5qW11cHf+l2Eflef2aWtrwxf/i0nZB47o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752152387; c=relaxed/simple;
	bh=OrcljsrB+SHvpR+WG7scq2CLWrj6Y1V0ANxGwane/Iw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Mq2YuAppa2F6ZU2LoYaAHHUBAjDo/siED1Kvhxm7F0PN4fk59aWECpYKh8QxkJEFAL8+Rrga7NChbJmk5Jy8agUmlx95yXsdhxskuKo9x9f1c7qGMgr8foGAppFEoAsi/kLa+IZIgnT+VwVkUwBZnVPKtar4FpmI/QGK9QHOtIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2yUjAa4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FB6C4CEE3;
	Thu, 10 Jul 2025 12:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752152386;
	bh=OrcljsrB+SHvpR+WG7scq2CLWrj6Y1V0ANxGwane/Iw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d2yUjAa4cfYfbqyFEgnvG60ZuA8v9JdDUjWAcRCVBcWSAYJIwASkFzm7zwbzYxgkW
	 sP52P8izbkQQuTwEJLI0MRDCX9c094h0PW7bRHNpYA7AbaHQ8mKp+oHILDhPok5OG+
	 qC1VBIjvic2U2utDJqn7tcRhoAMbp7H01C/VthizeYqTWE073BoYBUE8KQs8Zravlp
	 K8/Uezgxi9LP05pZBk6DMUABi+GAN5toXExGdy0XQh/6n3DMK0hXLf2+8bMiLpFe2v
	 0xWCmbmfc+rWthZT6OUQ672BN3jaJFGXuXVp5qlaiLmpcb5SmxJUPK3832Mxsj3O2W
	 5k465lXcaSfPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFA1383B261;
	Thu, 10 Jul 2025 13:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8] net: xsk: introduce XDP_MAX_TX_SKB_BUDGET
 setsockopt
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175215240882.1484624.14924595067604417783.git-patchwork-notify@kernel.org>
Date: Thu, 10 Jul 2025 13:00:08 +0000
References: <20250704160138.48677-1-kerneljasonxing@gmail.com>
In-Reply-To: <20250704160138.48677-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, joe@dama.to, willemdebruijn.kernel@gmail.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, kernelxing@tencent.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat,  5 Jul 2025 00:01:38 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> This patch provides a setsockopt method to let applications leverage to
> adjust how many descs to be handled at most in one send syscall. It
> mitigates the situation where the default value (32) that is too small
> leads to higher frequency of triggering send syscall.
> 
> [...]

Here is the summary with links:
  - [net-next,v8] net: xsk: introduce XDP_MAX_TX_SKB_BUDGET setsockopt
    https://git.kernel.org/netdev/net-next/c/45e359be1ce8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




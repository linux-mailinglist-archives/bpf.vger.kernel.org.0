Return-Path: <bpf+bounces-47725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4159FEC35
	for <lists+bpf@lfdr.de>; Tue, 31 Dec 2024 02:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61F791883172
	for <lists+bpf@lfdr.de>; Tue, 31 Dec 2024 01:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C00B1339A4;
	Tue, 31 Dec 2024 01:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASI7cQKA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDECB77102;
	Tue, 31 Dec 2024 01:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735609809; cv=none; b=p46PLlSVRF3CadvnnWX1Ho7pH69JUN+ria8fp57KCzi+z7Y5qObZzvMhs8p1wQkLQlrT2/kzUYn9gN7CftnFFDeUz7CAmlXpc897tWGdvrByKCgb2dQy6Qze1kWz+j/S1V23cGzcVSClEWCxgW3FQo3n06WSntVdz4zV9yEWic4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735609809; c=relaxed/simple;
	bh=ValXDmuvempSMVWdKZlqskyJtgIEV/Azfll+e48iKfU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PkSAxX9t9VQ7oQ4r7VwnNmUuC4uEn298ymTzJ5ElItw61IK9oBnb6ntQn63ADsBbMFlywt6O+RMJo98Jp7uhD6yldwqd7I0U2aU3NFHpaSADbvuhZC/yA3oOr+mmIyoYrWH/pe1dvrG3cc6czlz4yecbLQiPKKdm4iCxXUKf0cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASI7cQKA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A771EC4CED2;
	Tue, 31 Dec 2024 01:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735609808;
	bh=ValXDmuvempSMVWdKZlqskyJtgIEV/Azfll+e48iKfU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ASI7cQKATyqRSX4N0ZNduZ+AStfuwgBcN62r1cavS+6duxvZUQH4/jrSeiZMeZdwl
	 hBas4NyyKnVP6ANdEJEuRyfYf7eHho4Xa/L/pETghUikNhKDLR/ESQ1x6WX5hwngVj
	 KSw+9jOzzQ1RuBWetLQcE2z3lDt4y5PHeV54FX8PWWf2pkKhlWYH4VQk86Nr/v++DL
	 AbECjiZoKMZ5Ox3qdlofLirWc6cNFL0uBSaMWa8E1Kr8sPAa2jyU1Zauc13g1q0/hr
	 sneixT80n1Td74LpqttYrGROJXiFwa5lPk2GpNaCBdLZ9O0O2gQMKgemAq45wL4NiH
	 OVrO7W1PCO/Zw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF3B380A964;
	Tue, 31 Dec 2024 01:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] gve: trigger RX NAPI instead of TX NAPI in gve_xsk_wakeup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173560982825.1484600.10568371889170047273.git-patchwork-notify@kernel.org>
Date: Tue, 31 Dec 2024 01:50:28 +0000
References: <20241221032807.302244-1-pkaligineedi@google.com>
In-Reply-To: <20241221032807.302244-1-pkaligineedi@google.com>
To: Praveen Kaligineedi <pkaligineedi@google.com>
Cc: netdev@vger.kernel.org, jeroendb@google.com, shailend@google.com,
 willemb@google.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 hramamurthy@google.com, joshwash@google.com, ziweixiao@google.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 20 Dec 2024 19:28:06 -0800 you wrote:
> From: Joshua Washington <joshwash@google.com>
> 
> Commit ba0925c34e0f ("gve: process XSK TX descriptors as part of RX NAPI")
> moved XSK TX processing to be part of the RX NAPI. However, that commit
> did not include triggering the RX NAPI in gve_xsk_wakeup. This is
> necessary because the TX NAPI only processes TX completions, meaning
> that a TX wakeup would not actually trigger XSK descriptor processing.
> Also, the branch on XDP_WAKEUP_TX was supposed to have been removed, as
> the NAPI should be scheduled whether the wakeup is for RX or TX.
> 
> [...]

Here is the summary with links:
  - [net] gve: trigger RX NAPI instead of TX NAPI in gve_xsk_wakeup
    https://git.kernel.org/netdev/net/c/fb3a9a1165ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




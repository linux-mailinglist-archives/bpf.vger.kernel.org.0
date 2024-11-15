Return-Path: <bpf+bounces-44922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1109CD5DF
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 04:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B24E2832E0
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 03:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFE616A956;
	Fri, 15 Nov 2024 03:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nv4K74NE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76E14D9FB;
	Fri, 15 Nov 2024 03:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731641424; cv=none; b=DiXQq5ue+k/KeBCWrMNXYVg88Wx0ysdra4znxmUCzIRCqGXEskmvPp7IXbc2U6EKso7jp73bpmTzBtA76kJ8+lhxiXJ/d/PykMcuOfUeYjPod3U3R8aIabBBx51r80LULsSTFXZt/qIemrnG0Q0tK1kggVzttIlkj230ySUFVY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731641424; c=relaxed/simple;
	bh=+ufclaApr/0BR4iWbKqH2pyYxQdUe4d8Ad3IQrgrroE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LZeBnqF74RnnZtzC4RBORh83O/euIrSeDr9uu7IFQZUuyKVukm1a4ELczIi3MsaItuBat9nvg3FxDZSoocDw3S+Smogdoi5xoUUMtBd5NHhHl0E7LhKVo0afCbyTptZy1M+1h6MHQK0sQEgETcbL6v+wzcMjHeep4Ip7/PVIVFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nv4K74NE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211D0C4CECD;
	Fri, 15 Nov 2024 03:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731641424;
	bh=+ufclaApr/0BR4iWbKqH2pyYxQdUe4d8Ad3IQrgrroE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Nv4K74NEoU0XEauLu8mLEjZ9XjIf/qtIAudVKkatj1GWEAHmiZqfe5HCUsm8n8pAA
	 RMgk4I7OO2xRuUO53hN8TemJ3AuUSihUPC8oUlud+xf5Smh/xlTecPPGcX4rP8Wgzm
	 5pdpBoBpJ5AgTobehBZqLqdlt0DTpgtEfDTXBs8rTMHKZA4LaucAIU1DG1+f7J+xx/
	 sRyKWJurMLmal9qv/p3ljcvrLvReuJAvPu3Lmnju8CZTLKax6hEjG4V+ifxvC5w7z4
	 d4hffNewVj9rqpns2R82J9aU2n1yOuZL3BaCDrIUC85k8C+4gcyJY2f18F4NhZziZq
	 fWALOXAFvYIeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE213809A80;
	Fri, 15 Nov 2024 03:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] ipv4: Prepare bpf helpers to .flowi4_tos
 conversion.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173164143473.2139249.2172625891763389024.git-patchwork-notify@kernel.org>
Date: Fri, 15 Nov 2024 03:30:34 +0000
References: <cover.1731064982.git.gnault@redhat.com>
In-Reply-To: <cover.1731064982.git.gnault@redhat.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, horms@kernel.org,
 martin.lau@linux.dev, daniel@iogearbox.net, john.fastabend@gmail.com,
 ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, idosch@nvidia.com, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 8 Nov 2024 17:47:09 +0100 you wrote:
> Continue the process of making a dscp_t variable available when setting
> .flowi4_tos. This series focuses on the BPF helpers that initialise a
> struct flowi4 manually.
> 
> The objective is to eventually convert .flowi4_tos to dscp_t, (to get
> type annotation and prevent ECN bits from interfering with DSCP).
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] bpf: ipv4: Prepare __bpf_redirect_neigh_v4() to future .flowi4_tos conversion.
    https://git.kernel.org/netdev/net-next/c/bfe086be5c4c
  - [net-next,2/2] bpf: lwtunnel: Prepare bpf_lwt_xmit_reroute() to future .flowi4_tos conversion.
    https://git.kernel.org/netdev/net-next/c/dab9c6307161

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




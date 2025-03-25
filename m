Return-Path: <bpf+bounces-54726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B63A70BD4
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 22:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73A5E3B3849
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 20:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A488266B63;
	Tue, 25 Mar 2025 21:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWam9zvs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D4426657E;
	Tue, 25 Mar 2025 21:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742936405; cv=none; b=BxDMRBO71NjfKLW/VtGR77OyL7aKKyJI8xQkLNT48vc5dkiSqkwOpsuXKTo18L3zq9N/HBqY61zBcGd4obmJzozY5Z7gGAxZrOOGNOza6yK/xUWo0uZyeMrTT2ugAI2MKbq/+xiUYj1ybE4VGu7xPfpmcrK+7Ez436vv8FfRGpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742936405; c=relaxed/simple;
	bh=fWYb5K2CCFNO3O08idm+GIX3h6tXaRuK9KnpwjztTNE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DHN80EAcjukt2vtJkG/jnhWH9+WJ3frHpF0P2XD07PzXzFwGbpAFQEU/SWSI+re6w0BwVDtoY7ZWH/I7K0s07LTyIgdPbvOgu4J6oezWtLJW/TSSerLqbQRJpN4TGAWbMX6O4sdL8O/t7chKh0zMbbL+NUiWwDnbNV3LkZWtnMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWam9zvs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D79FC4CEE4;
	Tue, 25 Mar 2025 21:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742936405;
	bh=fWYb5K2CCFNO3O08idm+GIX3h6tXaRuK9KnpwjztTNE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WWam9zvs0YKR9kT1/zklAteKXkdnZTZydx+aEiXu3waNuFjwj3BM7inEDxvC/Sxsv
	 3fD7rpfQ9VIV36YZIw8Vh52S48QcHloYpptehPg3VsWYoBzP0jk/bat6ataCpIXAn0
	 NTWMu/u4cOM9RzF/sXpbiJ8dlrFBgSZQzvBoSvR6LzLdq/bEWAp9OgKEzu2MbSBeAD
	 2Qawk/li6bzWOKwAq2n9WEonYMMgZtjkLYiYQ1qc05X80mj2Az1ZOG0RTZ3MguS9We
	 h0LNXF4mxz+B0c5Kk4WmJiPOyI9RGP3KUwt6cvs2boOXzZkBDWrpvOUfQRRwXjEo0m
	 tndBdnhcXkJ6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF0E380DBFC;
	Tue, 25 Mar 2025 21:00:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] Basic XDP Support for DQO RDA Queue Format
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174293644127.727243.10787781606337409305.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 21:00:41 +0000
References: <20250321002910.1343422-1-hramamurthy@google.com>
In-Reply-To: <20250321002910.1343422-1-hramamurthy@google.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, jeroendb@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, pkaligineedi@google.com, willemb@google.com,
 ziweixiao@google.com, joshwash@google.com, horms@kernel.org,
 shailend@google.com, bcf@google.com, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Mar 2025 00:29:04 +0000 you wrote:
> From: Joshua Washington <joshwash@google.com>
> 
> This patch series updates the GVE XDP infrastructure and introduces
> XDP_PASS and XDP_DROP support for the DQO RDA queue format.
> 
> The infrastructure changes of note include an allocation path refactor
> for XDP queues, and a unification of RX buffer sizes across queue
> formats.
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] gve: remove xdp_xsk_done and xdp_xsk_wakeup statistics
    https://git.kernel.org/netdev/net-next/c/c2b900958535
  - [net-next,2/6] gve: introduce config-based allocation for XDP
    https://git.kernel.org/netdev/net-next/c/542a58f1b090
  - [net-next,3/6] gve: update GQ RX to use buf_size
    https://git.kernel.org/netdev/net-next/c/57a070c2672b
  - [net-next,4/6] gve: merge packet buffer size fields
    https://git.kernel.org/netdev/net-next/c/904effd02df7
  - [net-next,5/6] gve: update XDP allocation path support RX buffer posting
    https://git.kernel.org/netdev/net-next/c/346fb86ddd86
  - [net-next,6/6] gve: add XDP DROP and PASS support for DQ
    https://git.kernel.org/netdev/net-next/c/293b49361f91

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




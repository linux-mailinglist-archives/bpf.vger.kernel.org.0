Return-Path: <bpf+bounces-75171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B49DC74A77
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 15:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 7792E2AC35
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 14:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E1F30AAAD;
	Thu, 20 Nov 2025 14:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLuz7Hmi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBDE2F619D;
	Thu, 20 Nov 2025 14:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763650245; cv=none; b=kn/AePOfMnkFCQOHKoZHtu9egh+0BLKo8y+WtC7cJ9jE3E41SlC0mlmMyvGJR0QucGTbqvY2nBjJTG7d8J3ua96OOBXVZPMTyS3DITGIFG5vyGnOqakx7jKzhBIrtixmKDFXCmO3QlYsrNGQMMyyE6hpatjzOUjwADq9IDtGBU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763650245; c=relaxed/simple;
	bh=WfYdhiV/Pe6fKmjDC/PPLOZ1XVBwj9BgyydH6NExDPc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eiXWay03cVp6eYldtdjxhcopLHs1XjcJkL9pgD30RvDC1tcz68OSaMEDxMDd0kwau4FzyIrh+pTDfNtBesnA3X42XeuZPkq7RfNvEhUs9Whz9n9EsrnhMcJs5TvgdGSfI7tJscUZscWCzymrlxRjP9xaEF8coZYJT3tRbh87btQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLuz7Hmi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC36BC113D0;
	Thu, 20 Nov 2025 14:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763650245;
	bh=WfYdhiV/Pe6fKmjDC/PPLOZ1XVBwj9BgyydH6NExDPc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uLuz7HmisFSvKUfPjRnjUH2BO2TI/R4njwjGlmetfjSxeVjq5xabhQZCOwGDEZzGo
	 uwYNzxrAjraIfwUgSc4OG7b//lSjiQw21fgUuGTseSi0PR9idm0Jpyj5wIjwiwa7/+
	 u7r+Xl3EQgVAxK3RqRVSqN9E0GsuXaetUEawXqPM9bbJqj4SENqxU1BdRoBv8ln9yw
	 of3jHF9QyJn21SkFsjUMkjDUmoTDNGYsvlIzwoFQ5oa6+2tbDXeljv8zwJj+n/qTkY
	 Gy+4xkYQyLt/39hpIPySCTXOinp3bQ8q81bqAaw4hSDFfS6Q1EFWRFnwdAZOmOeure
	 08Ye8ZSuW6rFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F2D39FEB75;
	Thu, 20 Nov 2025 14:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] YNL CLI --list-attrs argument
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176365021029.1654378.15223154509378467974.git-patchwork-notify@kernel.org>
Date: Thu, 20 Nov 2025 14:50:10 +0000
References: <20251118143208.2380814-1-gal@nvidia.com>
In-Reply-To: <20251118143208.2380814-1-gal@nvidia.com>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 donald.hunter@gmail.com, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 18 Nov 2025 16:32:05 +0200 you wrote:
> While experimenting with the YNL CLI, I found the process of going back
> and forth to examine the YAML spec files in order to figure out how to
> use each command quite tiring.
> 
> The addition of --list-attrs helps by providing all information needed
> directly in the tool. I figured others would likely find it useful as
> well.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] tools: ynl: cli: Add --list-attrs option to show operation attributes
    https://git.kernel.org/netdev/net-next/c/2a2d5a3392b6
  - [net-next,v2,2/3] tools: ynl: cli: Parse nested attributes in --list-attrs output
    https://git.kernel.org/netdev/net-next/c/bc1bc1b357cd
  - [net-next,v2,3/3] tools: ynl: cli: Display enum values in --list-attrs output
    https://git.kernel.org/netdev/net-next/c/6c10f1a1c08a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




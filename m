Return-Path: <bpf+bounces-52501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 672A2A43F68
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 13:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC9E19C093B
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 12:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90502686AE;
	Tue, 25 Feb 2025 12:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeeQTGRN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647E4267F79;
	Tue, 25 Feb 2025 12:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740486601; cv=none; b=loi6IOZQbjet8rZ9FS8rt/IxHxjGr9t0vP2OcTGyfckwFXFTZuHLdeR12H9D5ZB5GbdJ3rjA8fa2vlxWt6CqsT8f6RG3eprOBrrpSFDjeKtC9T5/xS/lb90BoB+etqU0psfr4k7ylegi6pld12HnWRbWkhBH+RMSHOiwxt1Kx18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740486601; c=relaxed/simple;
	bh=XW++pQBAsxBSIdf5lR6Pzeu7mCFc5KfkHsVWatPr7xY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AVyFFPXbM36ThFQQUGdi0MN//NUm2za5+dyoDrfslBdTX1MMOatFL+BnbWzWEtFaEcfSzGxJmY9/RQEoiRC7Iti5ip7aOLTvxFKtmsKoEC8/gUl7qXzl7QXnrp2OOdBoawpQMIzV7cblBMuWGK0Ekvkc9DHcwl4HHFtqTxYlqdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QeeQTGRN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D661AC4CEE6;
	Tue, 25 Feb 2025 12:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740486600;
	bh=XW++pQBAsxBSIdf5lR6Pzeu7mCFc5KfkHsVWatPr7xY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QeeQTGRNf8ilQEL/BUq6EgWqHOHZbEGh+/gMGjZOjkwVlHz/Y7uhEcpsXa/qAxYIL
	 /KuhjjGoyjw+H26qgwk2v/rGZHYVrKufYRgKaoIC/8N3kY6GP43YhPMbmMABqiOEKc
	 X+sI4O1IYvMwCNMc0WBMm++4CgvqnFv/AQ8b3MSXFCQlN/q5BbOmyaR+3dnqzWjLob
	 30SaHquotf2hRdfufJccdJkG2jD+da/51hRN9XmTImqzilg/1EJ9sQdm7M6JWdGnIL
	 tjL0hDWudGjHEvLsqcRd1bgOGDu3W+zClB4pKvaqv7XSDeg8tVfXILzDhMNRmb1IpJ
	 RPIelKAGbkcCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD60380CEDC;
	Tue, 25 Feb 2025 12:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 net] ipvs: Always clear ipvs_property flag in
 skb_scrub_packet()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174048663224.4155054.13422794267665315194.git-patchwork-notify@kernel.org>
Date: Tue, 25 Feb 2025 12:30:32 +0000
References: <20250222033518.126087-1-lulie@linux.alibaba.com>
In-Reply-To: <20250222033518.126087-1-lulie@linux.alibaba.com>
To: Philo Lu <lulie@linux.alibaba.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, asml.silence@gmail.com,
 willemb@google.com, almasrymina@google.com, chopps@labn.net,
 aleksander.lobakin@intel.com, nicolas.dichtel@6wind.com,
 dust.li@linux.alibaba.com, hustcat@gmail.com, ja@ssi.bg, horms@verge.net.au,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 22 Feb 2025 11:35:18 +0800 you wrote:
> We found an issue when using bpf_redirect with ipvs NAT mode after
> commit ff70202b2d1a ("dev_forward_skb: do not scrub skb mark within
> the same name space"). Particularly, we use bpf_redirect to return
> the skb directly back to the netif it comes from, i.e., xnet is
> false in skb_scrub_packet(), and then ipvs_property is preserved
> and SNAT is skipped in the rx path.
> 
> [...]

Here is the summary with links:
  - [PATCHv2,net] ipvs: Always clear ipvs_property flag in skb_scrub_packet()
    https://git.kernel.org/netdev/net/c/de2c211868b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <bpf+bounces-56217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 680E3A93024
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 04:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2854119E7F6D
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 02:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70608268C6C;
	Fri, 18 Apr 2025 02:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nq8Y86hY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E862B268C51;
	Fri, 18 Apr 2025 02:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744944626; cv=none; b=jGP3JqXw3qw4wyiJzqBX8wONw7Reo2yUkzuNcDx4wiEGlCkftnjd7xf+ePHIUEgoJ7ewwbS1LRVb2CRGSvuv9EQgKiL9prT2Vp05rzArxtg7LW3oNJectX60GRyRWqB1NShxzYXK+VnG+4aHiR5bJOic00V99wII28/Ks3fz1y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744944626; c=relaxed/simple;
	bh=NCrrF8oEUQFiyv6e5pjViUCdkeZXnp9kziUWt5djFmc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X0av0kM4w3q8wBN9f3uF4/Edi38xiBZEYSg4lmPGIxKKfw267azhmoCLEREy/3yIlsiJpvBshSTffsMO28zacJTcjZQtWXEOwOItiHPdamElAWA+DGm2aHhhfo5mz/GKGBPvqpjGlWT7hStlj6Nf2DtsrJQpLqJSvNTIg1CJBJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nq8Y86hY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B96C4CEEA;
	Fri, 18 Apr 2025 02:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744944625;
	bh=NCrrF8oEUQFiyv6e5pjViUCdkeZXnp9kziUWt5djFmc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nq8Y86hY21lMxi0fcQyz/HHIar5s6PsBfpjIBpeTAjns23mQ4pvZ86LTOeQ+MOAb5
	 Ob2wXXaxZ9p2D/EY4jJ19xqu5Io27u2dTY7SO44oWGpLNw87+fdHQ+zmL3kLzxyV5p
	 N+h/fkrFKB1YpWvMh7hXD/xR2XlU+Qg1a1uSqaiZOmm9wmL7kJnFv0fW92polkUkaE
	 pkPa3Q2+1Zi+DwzU5y4OQqXw1lPlFD/fy+FwMLxMDQxgWFfLdRD8UNDiqxZV42RJ4/
	 yWnsUZyJyHkC+ZVXibkdpkzONQqYpndyBqAEXXMhfos1FOAx9GOLuYe7NlZXvHV/m8
	 YalFFEwCdcjJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC39380AAEB;
	Fri, 18 Apr 2025 02:51:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: add UAPI to the header guard in various network
 headers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174494466324.88264.13705902827230140149.git-patchwork-notify@kernel.org>
Date: Fri, 18 Apr 2025 02:51:03 +0000
References: <20250416200840.1338195-1-kuba@kernel.org>
In-Reply-To: <20250416200840.1338195-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 m.grzeschik@pengutronix.de, jv@jvosburgh.net,
 willemdebruijn.kernel@gmail.com, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, nhorman@tuxdriver.com, kernelxing@tencent.com,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 idosch@nvidia.com, gnault@redhat.com, petrm@nvidia.com, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Apr 2025 13:08:40 -0700 you wrote:
> fib_rule, ip6_tunnel, and a whole lot of if_* headers lack the customary
> _UAPI in the header guard. Without it YNL build can't protect from in tree
> and system headers both getting included. YNL doesn't need most of these
> but it's annoying to have to fix them one by one.
> 
> Note that header installation strips this _UAPI prefix so this should
> result in no change to the end user.
> 
> [...]

Here is the summary with links:
  - [net-next] net: add UAPI to the header guard in various network headers
    https://git.kernel.org/netdev/net-next/c/8066e388be48

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




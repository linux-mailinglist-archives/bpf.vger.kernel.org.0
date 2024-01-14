Return-Path: <bpf+bounces-19516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5A682D07B
	for <lists+bpf@lfdr.de>; Sun, 14 Jan 2024 13:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABC9C1C20C96
	for <lists+bpf@lfdr.de>; Sun, 14 Jan 2024 12:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E092D2100;
	Sun, 14 Jan 2024 12:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIguNuli"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C43520E6;
	Sun, 14 Jan 2024 12:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7583C43390;
	Sun, 14 Jan 2024 12:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705234824;
	bh=lQbD6Qa2k8PmsWRKY/NauPY86qM9T5apEyrjudWa0Ws=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CIguNulikzIgh+8X16LQlOsEFpO3py3v+BKqjZpjQKqqFeTiBOuMYH4rmpO7pkZX6
	 aEE+6krtcAf5L2EUu/rHRxOkOkNsRx+k8AeJCKh85b8yE+UZ+DkgxWPfgoHxWz/Et9
	 ztAbQkdM7ZJ6iXleDpuFXvfllBN+pseZqDNpmm9X82nE+Fie+aOrq9z0SnYKHzlO/R
	 GETkvaSwtkEKh43yeKnnN4qaANVlq9mSep2Q1BFzhKGVSelYcCYcf4TEXEasDtG8H8
	 ouEc+oArH0N/M5ctIA7hioGlhOT0QcA7YuygrGCIR/CiOkmb0XN9bsMZGUFbJ7PdYl
	 6JaO5i0CiWhhg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C53A2D8C96D;
	Sun, 14 Jan 2024 12:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] tls fixes for SPLICE with more hint 
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170523482480.13495.3024622886395212564.git-patchwork-notify@kernel.org>
Date: Sun, 14 Jan 2024 12:20:24 +0000
References: <20240113003258.67899-1-john.fastabend@gmail.com>
In-Reply-To: <20240113003258.67899-1-john.fastabend@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org, eadavis@qq.com, kuba@kernel.org,
 bpf@vger.kernel.org, borisp@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 12 Jan 2024 16:32:56 -0800 you wrote:
> Syzbot found a splat where it tried to splice data over a tls socket
> with the more hint and sending greater than the number of frags that
> fit in a msg scatterlist. This resulted in an error where we do not
> correctly send the data when the msg sg is full. The more flag being
> just a hint not a strict contract. This then results in the syzbot
> warning on the next send.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: tls, fix WARNIING in __sk_msg_free
    https://git.kernel.org/netdev/net/c/dc9dfc8dc629
  - [net,v2,2/2] net: tls, add test to capture error on large splice
    https://git.kernel.org/netdev/net/c/034ea1305e65

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




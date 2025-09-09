Return-Path: <bpf+bounces-67930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6969B5057A
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 20:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BA22544EE7
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 18:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA863009C8;
	Tue,  9 Sep 2025 18:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKw3j8j4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BADD2FE058;
	Tue,  9 Sep 2025 18:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757443205; cv=none; b=DpN844JAO6vbwsZBOVHal9Ejcu/PWPGSbGxcgcnjwJSW2jW75QtDUFzzs2ziym4a37WwqMk24gr5Fl4v7Uzo95e5VBDliBkhOCDZbC8Q8HrTYDTBLqsFhiP1f4QGf62ZdeD9ltTXrpbCwb4QBtTullm1XjBTVL9hC+g6mViOWbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757443205; c=relaxed/simple;
	bh=PchiFOwhbqw7D9/OZgHdd/CFts5oOrpgTSmWhdLgFn0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fXHYicN6yJQHMJMvveUyXNPkfNfIyFT4CIpYNb+ePPNL2BGDwcv5ZMN8yGBnv1Qe5kfp3Bl4359t5+/yfaY//QvwgJgQW3lcwoZlXC0xXYAc127clYU/bZiPYG0tielBJkM0eK1qXBjfXqojs5ZnkR5lofhUvuKRA6L87EaHEzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKw3j8j4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF067C4CEF4;
	Tue,  9 Sep 2025 18:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757443204;
	bh=PchiFOwhbqw7D9/OZgHdd/CFts5oOrpgTSmWhdLgFn0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VKw3j8j4PayhVVylenEF+EPLzmBmWULdvNlNd+WgmOctqWGsAMpV3RJvp47KfdZ7/
	 d5wxJykyzP2cU+MKJioYrsxgpp8Q6jPiJy7+RkJKD7Qui3KeHPLNOzDojd99a5SYZv
	 1rdCt1QUsyMCd4Jg9cuXWfGFClEAGtfShDIN+aP5XzIadIxegJ5ivcA/Mrqm9b8iMr
	 gm/km+RErjUAW3mUl6y9eYHRQJOZ3W/wK3lAPMEZL6svWTeCOblKs+S77kMGJ2Ht41
	 NGbYNARpRJBXdOnFRDL4j8xh0FghlomrYXHnTghhPEWoUXzypKYZak7IBKi0hBzanS
	 Y9JuIT20dIzvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EF8383BF69;
	Tue,  9 Sep 2025 18:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v9 bpf] xsk: fix immature cq descriptor production
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175744320802.783799.462112296366148200.git-patchwork-notify@kernel.org>
Date: Tue, 09 Sep 2025 18:40:08 +0000
References: <20250904194907.2342177-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20250904194907.2342177-1-maciej.fijalkowski@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, kerneljasonxing@gmail.com,
 aleksander.lobakin@intel.com, e.kubanski@partner.samsung.com, sdf@fomichev.me

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  4 Sep 2025 21:49:07 +0200 you wrote:
> Eryk reported an issue that I have put under Closes: tag, related to
> umem addrs being prematurely produced onto pool's completion queue.
> Let us make the skb's destructor responsible for producing all addrs
> that given skb used.
> 
> Commit from fixes tag introduced the buggy behavior, it was not broken
> from day 1, but rather when xsk multi-buffer got introduced.
> 
> [...]

Here is the summary with links:
  - [v9,bpf] xsk: fix immature cq descriptor production
    https://git.kernel.org/bpf/bpf/c/3753d4f6d9d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




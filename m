Return-Path: <bpf+bounces-10177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E58B7A25BC
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 20:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36A521C20AA0
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 18:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065EB18E16;
	Fri, 15 Sep 2023 18:30:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFFC1CA87;
	Fri, 15 Sep 2023 18:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C4D3C433C7;
	Fri, 15 Sep 2023 18:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694802626;
	bh=3+Nd44tLesiA3LjD2Yq9hTCFHTz8f3aOJUWyctFb5SU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o3ncf5r2K/Y7cfdBI90tkzGwIdjDcw3z01Q5kYk4GPDk90rN7ZmJSNwHV3MWTuSeJ
	 G8gT0nNT1UDvyWxCR4YBid91mHAww23P6Pzki4qeS4S261K/aBT+tF3wi9Yhpgjiyz
	 N1OBDxX/DVbnT7b6/5bhCRCN1GMRIXIp7MsWgrEjlEECY4yUpwwWdF5ykgRwW15IT7
	 K2A2ripmeFdXPN6WoLX+eh+oBqVEOTeELxTCV+/GJSs2TgZ7TLxeIXLHJq6KX1HPEG
	 LpwAFXYLk6eWoO7yqSWPAmeVW+TZ+5RcZSctf2yO5oGj2IMTrYkvclZC13SRL6Fkiv
	 KOrn7S1Gelnfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D843E22AF2;
	Fri, 15 Sep 2023 18:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/3] bpf: expose information about netdev
 xdp-metadata kfunc support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169480262604.8216.11189407228519547054.git-patchwork-notify@kernel.org>
Date: Fri, 15 Sep 2023 18:30:26 +0000
References: <20230913171350.369987-1-sdf@google.com>
In-Reply-To: <20230913171350.369987-1-sdf@google.com>
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, netdev@vger.kernel.org, willemb@google.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 13 Sep 2023 10:13:47 -0700 you wrote:
> Extend netdev netlink family to expose the bitmask with the
> kfuncs that the device implements. The source of truth is the
> device's xdp_metadata_ops. There is some amount of auto-generated
> netlink boilerplate; the change itself is super minimal.
> 
> v2:
> - add netdev->xdp_metadata_ops NULL check when dumping to netlink (Martin)
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/3] bpf: make it easier to add new metadata kfunc
    https://git.kernel.org/bpf/bpf-next/c/fc45c5b642db
  - [bpf-next,v2,2/3] bpf: expose information about supported xdp metadata kfunc
    https://git.kernel.org/bpf/bpf-next/c/a9c2a608549b
  - [bpf-next,v2,3/3] tools: ynl: extend netdev sample to dump xdp-rx-metadata-features
    https://git.kernel.org/bpf/bpf-next/c/0c6c9b105ee9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




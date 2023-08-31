Return-Path: <bpf+bounces-9046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D1678EC00
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 13:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35921C20AC2
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 11:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E969D9447;
	Thu, 31 Aug 2023 11:30:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C4079F8;
	Thu, 31 Aug 2023 11:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8C14C433C9;
	Thu, 31 Aug 2023 11:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693481422;
	bh=l/xmGcjTrZn01wQ7wkssLR0SULEJ/6R+gjsgXFPxtmE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XEbPc3ktM/FX8M0hVcsyflh4AA9teuAnLhGPvSTP3T8cfEfcvQ+ZKj8ANuKcmRLv1
	 vAhk19hMS+PghIq0kNI2DetydLEZim9WbDPZfDDwBveVfMlcjGuBIxpHq6zdcQMogz
	 JrzuuiYeNIKXfb+K+j2ps1L92dsuYwLPANI0YOgDX+56O0XFw6C7G8XzLbK+8p44LU
	 TOipSZKufxr6KtdkvAIXeXVEoomQzk6EKZIa/pDqrJK88yXimADDAecHAjPl0pu1zx
	 IGVD6zQWeDMJ7r+QhI9BVXvokVg56uf/6J0ixkd/vPA3tCsBm8YSie7POwh2YpahpB
	 Hhzd591teDJbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D05AE29F3D;
	Thu, 31 Aug 2023 11:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] xsk: fix xsk_diag use-after-free error during socket
 cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169348142263.21678.2348219156838047969.git-patchwork-notify@kernel.org>
Date: Thu, 31 Aug 2023 11:30:22 +0000
References: <20230831100119.17408-1-magnus.karlsson@gmail.com>
In-Reply-To: <20230831100119.17408-1-magnus.karlsson@gmail.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: magnus.karlsson@intel.com, bjorn@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, netdev@vger.kernel.org, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, bpf@vger.kernel.org,
 syzbot+822d1359297e2694f873@syzkaller.appspotmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 31 Aug 2023 12:01:17 +0200 you wrote:
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Fix a use-after-free error that is possible if the xsk_diag interface
> is used after the socket has been unbound from the device. This can
> happen either due to the socket being closed or the device
> disappearing. In the early days of AF_XDP, the way we tested that a
> socket was not bound to a device was to simply check if the netdevice
> pointer in the xsk socket structure was NULL. Later, a better system
> was introduced by having an explicit state variable in the xsk socket
> struct. For example, the state of a socket that is on the way to being
> closed and has been unbound from the device is XSK_UNBOUND.
> 
> [...]

Here is the summary with links:
  - [bpf,v2] xsk: fix xsk_diag use-after-free error during socket cleanup
    https://git.kernel.org/bpf/bpf/c/3e019d8a05a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




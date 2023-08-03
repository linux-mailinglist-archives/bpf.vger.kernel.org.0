Return-Path: <bpf+bounces-6876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5351576EEA7
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 17:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83D371C215A0
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 15:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CC924167;
	Thu,  3 Aug 2023 15:50:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A62C182C8;
	Thu,  3 Aug 2023 15:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 037D9C433C9;
	Thu,  3 Aug 2023 15:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691077822;
	bh=1MwiL4otavjcKt/Qk1VABOkNTQFCqDDe9I/0ikejFLc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pGyTci8TaOdKemx0Cpo5P/UMGs4nDkAv1yrLLrLiOfIt6/voSno/teRHzrOeGyU1E
	 XOVKI0BWeJLUdIzM8UgQg4Yo91nlWldRgl9bT0ZNdIxy1nlWyibeFwHna4/hcOF5JZ
	 eDkM88++w6fdQFEK1cdxS3aRfGzKec3897WXIrVdLdv6bSHOTinhQnQKLivNamjtlK
	 /HtVKy38Uq/Gv54JojKoVz0gZJO6Dh4dJHpydgvVd69rKyZcXfYDTsB2fUbwu0BEhk
	 1UsokQ6H9+yLHYuhXx5nxbwVD1HUUaq6fahtdpGsevb8ZsWeD10DFFN8sTjUAn7K6N
	 +jPYEg9kkahqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D909EC43168;
	Thu,  3 Aug 2023 15:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/3] net: struct netdev_rx_queue and xdp.h
 reshuffling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169107782188.9546.10766689854084289247.git-patchwork-notify@kernel.org>
Date: Thu, 03 Aug 2023 15:50:21 +0000
References: <20230803010230.1755386-1-kuba@kernel.org>
In-Reply-To: <20230803010230.1755386-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: ast@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 hawk@kernel.org, amritha.nambiar@intel.com, aleksander.lobakin@intel.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed,  2 Aug 2023 18:02:27 -0700 you wrote:
> While poking at struct netdev_rx_queue I got annoyed by
> the huge rebuild times. I split it out from netdevice.h
> and then realized that it was the main reason we included
> xdp.h in there. So I removed that dependency as well.
> 
> This gives us very pleasant build times for both xdp.h
> and struct netdev_rx_queue changes.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/3] eth: add missing xdp.h includes in drivers
    https://git.kernel.org/bpf/bpf-next/c/92272ec4107e
  - [bpf-next,v2,2/3] net: move struct netdev_rx_queue out of netdevice.h
    https://git.kernel.org/bpf/bpf-next/c/49e47a5b6145
  - [bpf-next,v2,3/3] net: invert the netdevice.h vs xdp.h dependency
    https://git.kernel.org/bpf/bpf-next/c/680ee0456a57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




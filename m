Return-Path: <bpf+bounces-56121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB71DA9195A
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 12:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5101619E3E38
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 10:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6375722D7B9;
	Thu, 17 Apr 2025 10:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uniyKtCW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D631F1CAA97;
	Thu, 17 Apr 2025 10:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744885799; cv=none; b=kML2fjVVSS1+NUzGaX99Lm/4xrznRSB40DAO9n2pA4Zp/xP3rXArCq5wAlwXUseKBh5dg2LScjSM5Ub7meN4ye8OJgJHQ3I5sCmbvwNCd92yoK7UBOML2TzMTkELvP2cB4wSYz5w2XxL/tZCTR2tSSefJ5icpgZ5c6XjyjZ2Mu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744885799; c=relaxed/simple;
	bh=L5TNFNCZpdgfPBk8qeoQJb7+QsGbPtI7TchHnfcbQNU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qcG6uy5THOhqaNtz4Pb7xjsKLhNQTl728FI+gx+nYaDOi7gD9wC1R5+pjAOCsdvorQf3fEMuEufm57MDYQd44jEUGOU11C6MMAFaHTm47MpC8zT/nIWHfSHY5Uyfi69zeRN1Atqr27kYnSGlEk6ElFh0K4Rig6YyXwZ7dUqJWXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uniyKtCW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DDEDC4CEE4;
	Thu, 17 Apr 2025 10:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744885798;
	bh=L5TNFNCZpdgfPBk8qeoQJb7+QsGbPtI7TchHnfcbQNU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uniyKtCWsLKK16Ju1bjUvXKSGXeCqgHUMzg1TNc286Rzwr7Lp5j0SscODw4pAXa6N
	 1v2jxCLsgYolN3IKD6dBiqS3Ok+haDxTViJR/eCTLnS8wwiYSmco7ueUgSTMweIihs
	 +WyX2b8KF+Ta8RRaqAZFIJ5hLlZjHT5dQAL28iodHsY149mL4gxSlDICY1+lZZjD6v
	 aKzRta9RFXjVu9Iyi97ILJMjAX7saeh1MXav44JDMKTeiNayxc/l6OgC+JVMTy7fcU
	 Em5SiAc649kjGF5GmR/fe7c4wK/FX8JbrQQQoTC+8vUUoQUtDbDncnUP1/W7taFRdh
	 sjCHZRYpfJQwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71884380664C;
	Thu, 17 Apr 2025 10:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/3] Bug fixes from XDP and perout series
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174488583626.4024823.6954419136495228052.git-patchwork-notify@kernel.org>
Date: Thu, 17 Apr 2025 10:30:36 +0000
References: <20250415090543.717991-1-m-malladi@ti.com>
In-Reply-To: <20250415090543.717991-1-m-malladi@ti.com>
To: Meghana Malladi <m-malladi@ti.com>
Cc: dan.carpenter@linaro.org, javier.carrasco.cruz@gmail.com,
 diogo.ivo@siemens.com, horms@kernel.org, jacob.e.keller@intel.com,
 john.fastabend@gmail.com, hawk@kernel.org, daniel@iogearbox.net,
 ast@kernel.org, richardcochran@gmail.com, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com, vigneshr@ti.com,
 rogerq@kernel.org, danishanwar@ti.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 15 Apr 2025 14:35:40 +0530 you wrote:
> This patch series consists of bug fixes from the XDP series:
> 1. Fixes a kernel warning that occurs when bringing down the
>    network interface.
> 2. Resolves a potential NULL pointer dereference in the
>    emac_xmit_xdp_frame() function.
> 3. Resolves a potential NULL pointer dereference in the
>    icss_iep_perout_enable() function
> 
> [...]

Here is the summary with links:
  - [net,v4,1/3] net: ti: icssg-prueth: Fix kernel warning while bringing down network interface
    https://git.kernel.org/netdev/net/c/75bc74446644
  - [net,v4,2/3] net: ti: icssg-prueth: Fix possible NULL pointer dereference inside emac_xmit_xdp_frame()
    https://git.kernel.org/netdev/net/c/8ed2fa661350
  - [net,v4,3/3] net: ti: icss-iep: Fix possible NULL pointer dereference for perout request
    https://git.kernel.org/netdev/net/c/7349c9e99793

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




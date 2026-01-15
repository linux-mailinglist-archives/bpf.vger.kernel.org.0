Return-Path: <bpf+bounces-79011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8EAD237B9
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 10:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AEBE9305D41B
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 09:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343D435B15A;
	Thu, 15 Jan 2026 09:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGwIUrXR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42E1194C96;
	Thu, 15 Jan 2026 09:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768469027; cv=none; b=PX+IyGYYAU2GvsbcciB82BcsfGf3syN6C3tV+NyuJ0eahMOz2IIa5Tqz/HhYPmtq+ZaTfcnz2eLPd+qE7qOvUhugaXt6ppDONr3rvrE2D6t/3jM1esbYoZ+KEdP3rxE4V5gqxSD1gbGDBq1TM8SSVMeZw5oQ8Hw9qKjbzhWtJsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768469027; c=relaxed/simple;
	bh=h2C8GS4B5R+zl9Ic1fwxBUSRiRgkPgN6nrgFZ7HBRYM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ndFBEGguEiKrBUawL6xeL7Mdi8vLBzc2eQMfKcHnCqWgxetSpQuEkRHfFnkLLNoety4Ofww+NBOsRKGAo/GGfVZQc8zkc6EGnj57ExMChO5tXJBXPxDcc6Rwre1OVaVS95Nx9S47Gc7Cglyv0ZXxaryYbtsFFzfyhGbS6NGzre4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGwIUrXR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9627BC116D0;
	Thu, 15 Jan 2026 09:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768469027;
	bh=h2C8GS4B5R+zl9Ic1fwxBUSRiRgkPgN6nrgFZ7HBRYM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nGwIUrXRaPyJjh6hrx5iKlm2MwLh7bXrFRfJGNEoAKM570IZVAr1/G2XuAZKJEldG
	 yj8aeXntl2bK+DuToNB+Q8zObAmIsHlxScUlndCgubmcmbLtHYLcE77UARgVOP/cF2
	 9/dp/BH8bI706hVFxlVobOhfaxjFYwLeAfb59g1Cbo6Ib8v9lPNMnUU1UVPm7chz/I
	 51bZiXk1JXwD+avd4hPbF0xhLN8ZtGY5ftuaHyZqs1gxDZDqSvUNiaL7WJvekn+GDe
	 AqiXxU6N2a5j2hw7Vs7HxLYSjBfaNmzKlQTPY5wtTxWWdsMUKz4KkedHkgmdltw3Jy
	 LFYQrL3M4FzYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 30FD6380A957;
	Thu, 15 Jan 2026 09:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/2] xsk: move cq_cached_prod_lock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176846882001.3904091.1019126327553342462.git-patchwork-notify@kernel.org>
Date: Thu, 15 Jan 2026 09:20:20 +0000
References: <20260104012125.44003-1-kerneljasonxing@gmail.com>
In-Reply-To: <20260104012125.44003-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 kernelxing@tencent.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun,  4 Jan 2026 09:21:23 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Move cq_cached_prod_lock to avoid touching new cacheline.
> 
> ---
> V6
> Link: https://lore.kernel.org/all/20251216025047.67553-1-kerneljasonxing@gmail.com/
> 1. only rebase
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/2] xsk: advance cq/fq check when shared umem is used
    https://git.kernel.org/netdev/net-next/c/cee715d907d0
  - [net-next,v6,2/2] xsk: move cq_cached_prod_lock to avoid touching a cacheline in sending path
    https://git.kernel.org/netdev/net-next/c/a2cb2e23b2bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




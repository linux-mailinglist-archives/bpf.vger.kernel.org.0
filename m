Return-Path: <bpf+bounces-69869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF00BA5265
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 23:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A1653B30C1
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 21:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC5B296BAB;
	Fri, 26 Sep 2025 21:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBkHZtBo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CDE21E091;
	Fri, 26 Sep 2025 21:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758920417; cv=none; b=tTDX/wsoQ3tz86EYZdXzMUHs/YYjNzWqFi+YYOREJXoP3jpbOq2PaebRv1w1hdmQrww/eHtvw9bQ3sPjCoJFP64ltzrrGDqK9Uydu88Lpv2a3jfADys6Royevc5u+zhSdI1O6nyYincGFITfjSqZ3/MxWWzAqW1zDrHCQCF+D7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758920417; c=relaxed/simple;
	bh=7ArHnNtl1PML20GRqCIWgo7GaVTsFQAMXHTb4XLzZsE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mmcej772wWMNx0zm8JHirV27rQ8xt46W7aDA4SvW7gDBAM4hQPDIXz9efN1DnuqWOyXOwPIYqa5sMcBtXInQuoY72ey6LZCxm5fDVXmyFpLrlTQT/f3laUDYA2XH9KHCl1hYlqK0j0wtWlGZ0OJ8IUFbSlOEMnnzTDGC26KFCSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBkHZtBo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419E0C4CEF4;
	Fri, 26 Sep 2025 21:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758920416;
	bh=7ArHnNtl1PML20GRqCIWgo7GaVTsFQAMXHTb4XLzZsE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OBkHZtBoLdC5UFVtXwQ2aVOHBue0w6rxE06AmhTMyg9tTC4R1DN5301j5vdrl87ri
	 RyPW8FgNPoDRFjmQiwFijc7YpkDNbm0Hps/j++bMgGDNZiJBbfYN4EkJhlGQ354LZ7
	 M4TXoBuxOTLepdDKKZuJGOGPq6N4MmWsRb7z6GwtgQ2pEF+luVEtFeDmPj1GlzDPfH
	 xShBI1xoGM3gX2XE33kOoMYACfJarCF1CgLO/BIgl0EpXzAQcjMcSP8noGOPqOoPv6
	 O8qLClTgvXsCDoG5YU20gBi1RRSEsaaQ0KE5LXlTyV4Vl9HfR/w0B0GYJyIcRD0wo1
	 aPSdIRt4Y4sQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADED539D0C3F;
	Fri, 26 Sep 2025 21:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/3] xsk: refactors around generic xmit side
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175892041150.56561.621186869561086072.git-patchwork-notify@kernel.org>
Date: Fri, 26 Sep 2025 21:00:11 +0000
References: <20250925160009.2474816-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20250925160009.2474816-1-maciej.fijalkowski@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, kerneljasonxing@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Sep 2025 18:00:06 +0200 you wrote:
> Hi,
> 
> this small patchset is about refactoring code around xsk_build_skb() as
> it became pretty heavy. Generic xmit is a bit hard to follow so here are
> three clean ups to start with making this code more friendly.
> 
> Thanks,
> Maciej
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/3] xsk: avoid overwriting skb fields for multi-buffer traffic
    https://git.kernel.org/netdev/net-next/c/c30d084960cf
  - [v2,bpf-next,2/3] xsk: remove @first_frag from xsk_build_skb()
    https://git.kernel.org/netdev/net-next/c/6b9c129c2f93
  - [v2,bpf-next,3/3] xsk: wrap generic metadata handling onto separate function
    https://git.kernel.org/netdev/net-next/c/30c3055f9c0d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




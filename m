Return-Path: <bpf+bounces-58732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7DBAC1047
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 17:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3156500F68
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 15:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82267299AAF;
	Thu, 22 May 2025 15:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aj1a/czU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05826299942;
	Thu, 22 May 2025 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747929003; cv=none; b=ekI0P4HFlAYjQUU7v2gwP9VrR9vw41nGAYkmN/UrVR3nF9xyIM2eSyHWYfJ3Irqla7Ni4gN8DE16lf4ijA5gKJJzgRg51TL+vlnmefMbh9TWYFMeES/RfSNt0CizSc4Yj6KFVbkB7bOOz1w9BEIEcgHWmk4w57I5vByzfW9KI14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747929003; c=relaxed/simple;
	bh=YFkSw5Sgc2QNbxUSWjiPgmK5KbfsFH5dk2bRNp2Aiu8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MO+aEH2C5PcWsSMfChtLs67EBpod8ev7zJ8L475t0EosHMVMmuwYZNj3fPVnwcPDsKE8eyizChJ0/22weaRD8S2osPKQKOU857T5u+u5Xa54FkAYaOURxG8dQD0YRpKC8TP+qAGH0tGSKJW4TqfXMJoWBrIOsE3jWVJWXBU/qTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aj1a/czU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B782C4CEE4;
	Thu, 22 May 2025 15:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747929002;
	bh=YFkSw5Sgc2QNbxUSWjiPgmK5KbfsFH5dk2bRNp2Aiu8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Aj1a/czUCBPGm7VhLzaEK3vk/J6V+/z9NqTkdh/h6mcUrkH4RXioIEgbE7xzml0if
	 LsW26YZuvUEW4uZtJbepWGyGsJrzFPlezYbvDtSCePIXpHGzec4ADSIpVaSOFKIJyk
	 jhi4LZIhR1P7jhc1DM/Ht1Vnuaz+2IUP8DNCv2F6xEdegT96FazDLQz0GIovBh0cFb
	 Pdyr9SuTUYua+W3qrggtZJ2YLdyfF1sJai7b0S6BWYdNXnxzAuL5KUmAh77kUlRh7e
	 rImf+z7Jk1Uz8DWT0KsyViCWHgKYOSBB6gjOtsOmYVNPt/m/GUE3AYYfLJlC/w9eP2
	 ajGaCjhONfUAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340783805D89;
	Thu, 22 May 2025 15:50:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] eth: bnxt: fix deadlock when xdp is attached or
 detached
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174792903799.2925590.1720080745754415485.git-patchwork-notify@kernel.org>
Date: Thu, 22 May 2025 15:50:37 +0000
References: <20250520071155.2462843-1-ap420073@gmail.com>
In-Reply-To: <20250520071155.2462843-1-ap420073@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com, sdf@fomichev.me,
 netdev@vger.kernel.org, bpf@vger.kernel.org, jdamato@fastly.com,
 martin.lau@kernel.org, hramamurthy@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 May 2025 07:11:55 +0000 you wrote:
> When xdp is attached or detached, dev->ndo_bpf() is called by
> do_setlink(), and it acquires netdev_lock() if needed.
> Unlike other drivers, the bnxt driver is protected by netdev_lock while
> xdp is attached/detached because it sets dev->request_ops_lock to true.
> 
> So, the bnxt_xdp(), that is callback of ->ndo_bpf should not acquire
> netdev_lock().
> But the xdp_features_{set | clear}_redirect_target() was changed to
> acquire netdev_lock() internally.
> It causes a deadlock.
> To fix this problem, bnxt driver should use
> xdp_features_{set | clear}_redirect_target_locked() instead.
> 
> [...]

Here is the summary with links:
  - [net-next] eth: bnxt: fix deadlock when xdp is attached or detached
    https://git.kernel.org/netdev/net-next/c/db807e5ef8ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




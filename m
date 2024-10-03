Return-Path: <bpf+bounces-40885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 518C898FA13
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 00:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2411E281C6F
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 22:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42ABA1CF2A4;
	Thu,  3 Oct 2024 22:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eznuAcvl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FCB1CCEDC;
	Thu,  3 Oct 2024 22:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727995828; cv=none; b=NOuAWuwAlsyHxUdMRGIvu8xxC2qEI8yO/OrCDVStliweSMndaKnV3cz5MjZY0siLcb2xKKP3xsxpUQsTvhUD+zzlNlf659osD7LR7hMwBe6p5tRMGFhfqc6NtdLFoZTg8Yu2l+jy0hdgezsYMF2CxkX+SzKXfqe7aYbtfo7sOj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727995828; c=relaxed/simple;
	bh=N76ffPwh7vhzdVjn6ChswXpK5tc7FNqz8Sg0rAqMMIQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Yz/J8XSCdxgmSFvsS8fOlkSMjmulT3HSfY+N8gcpH72CgPvxlUeReTDpAo5dTs/i5G88V3qNL9TJCjNk/1EL6QXp+K8yI46rn5tJGQJ2u7D9/IpEqhWQzD3gPyRUpOJO34RzSSVcuIlixgpleksE5YpSpTeW/rrHHac5v85uhCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eznuAcvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0BDC4CEC5;
	Thu,  3 Oct 2024 22:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727995828;
	bh=N76ffPwh7vhzdVjn6ChswXpK5tc7FNqz8Sg0rAqMMIQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eznuAcvlRv8W+A/E65+yQt5KNVDUuJKOB/LcpIHoLo0Cw1uFdhhrZZw8czhB6Mkqy
	 72/L61jHh+dne8YUammEI91zMZExkWFuI1AZNjo3PKMY+cuGU5LOUWmyr1V4BMiYV+
	 +03FUNbni7T0xp+VOP12ri4YfDWPNveTEjXnXF3cgH6MVPfB78cGnMAajaRdNlaRhi
	 vQQzL9ob4Mglq0bNLgA9cV0Po63ME8DyeRfD10jWBkjLPfr9lSEqSBLZYuBzAY1xpq
	 /M8xeeVWPKPPhPrvavQvlk0ChMsgplv76u7WiCGL4I5ZsUjNFoqmMVP/VvuhCb1xet
	 1IT2E5WD8nF+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB18F3803263;
	Thu,  3 Oct 2024 22:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sfc: Don't invoke xdp_do_flush() from netpoll.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172799583176.2017964.8627494683961349191.git-patchwork-notify@kernel.org>
Date: Thu, 03 Oct 2024 22:50:31 +0000
References: <20241002125837.utOcRo6Y@linutronix.de>
In-Reply-To: <20241002125837.utOcRo6Y@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com, bpf@vger.kernel.org,
 davem@davemloft.net, toke@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 ecree.xilinx@gmail.com, edumazet@google.com, kuba@kernel.org,
 hawk@kernel.org, john.fastabend@gmail.com, habetsm.xilinx@gmail.com,
 pabeni@redhat.com, tglx@linutronix.de, mon@unformed.ru

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 2 Oct 2024 14:58:37 +0200 you wrote:
> Yury reported a crash in the sfc driver originated from
> netpoll_send_udp(). The netconsole sends a message and then netpoll
> invokes the driver's NAPI function with a budget of zero. It is
> dedicated to allow driver to free TX resources, that it may have used
> while sending the packet.
> 
> In the netpoll case the driver invokes xdp_do_flush() unconditionally,
> leading to crash because bpf_net_context was never assigned.
> 
> [...]

Here is the summary with links:
  - [net] sfc: Don't invoke xdp_do_flush() from netpoll.
    https://git.kernel.org/netdev/net/c/55e802468e1d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




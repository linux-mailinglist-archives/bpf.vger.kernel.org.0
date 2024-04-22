Return-Path: <bpf+bounces-27359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66A28AC6C9
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 10:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64CAB280E70
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 08:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB6E51037;
	Mon, 22 Apr 2024 08:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0UXkCpL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F192502B5;
	Mon, 22 Apr 2024 08:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713774048; cv=none; b=FVs7r+wdbWBJoZx+6n+4XlrS3n0DoC08ogdBh/7msUBXbfVSOjJ0QIY8nmHF1qwSTDheoxCeNs3TNB4tl8i+5gVPFqAK6mr+zsbjT3AppjeD6MmkTUz0yy/ATnk6wZ1XQmJO5Vgz6p4UzEqFdL9UYvLemAwz6C2JHvE3bc2W0CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713774048; c=relaxed/simple;
	bh=t0DOOsocfHerAlw/n3+cFXRIjJHObO9gKBXKpBvM4go=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nwwx15yuL6laNBTeiW/B0qL4Ouhd5ilgFagh5NU51njnc+tPF62JecvePiigw6F8Ge4LGjwMOahj0SgMKxEL3nDdAuJsLFsu0o5a2z+YF2vzO0D2Owj7x0d11x375s8MtITPCkGL9IYWY8B5xcAwXuRlAizDPtYNqwfewlhLj1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0UXkCpL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DFD9CC32786;
	Mon, 22 Apr 2024 08:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713774048;
	bh=t0DOOsocfHerAlw/n3+cFXRIjJHObO9gKBXKpBvM4go=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t0UXkCpLpj4IcyJaCJjywgbcr1T7CsiAw5il393dtJUthZSpdvCfbFRgfZBZB0SNf
	 zVK7JHHO4b/vPBVOTfTW5EgTjUUrcGEiwc2HrkX8Al9MfQyEUWAkhK9lMG6Czn+DC2
	 wBx7c+9S7cWcWRpPwRkPWeOwiNMv4xcvEwYAMOkyFn8ADcFnJUMllTjhyte2v/I2eM
	 CRWHksE1OB49K8M7hKBDjvpWUCaZNs3dVlYagZdqDVyz3+uKh1Zkevom7TQCthk8gD
	 BqIPgEm63c/S3Bl0yzdQ6HovgfSXxC+0RPIoHl/MZK4PyrGY+lpikvE0v4BTH/7vbT
	 EgPpXEv9kCLoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D2426C433A2;
	Mon, 22 Apr 2024 08:20:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: ti: am65-cpsw: Fix xdp_rxq error
 for disabled port
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171377404785.21182.10578807051583062281.git-patchwork-notify@kernel.org>
Date: Mon, 22 Apr 2024 08:20:47 +0000
References: <20240418-am65-cpsw-am62a-crash-v1-1-81d710cbc11b@baylibre.com>
In-Reply-To: <20240418-am65-cpsw-am62a-crash-v1-1-81d710cbc11b@baylibre.com>
To: Julien Panis <jpanis@baylibre.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, jacob.e.keller@intel.com, s-vadapalli@ti.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 18 Apr 2024 17:34:55 +0200 you wrote:
> When an ethX port is disabled in the device tree, an error is returned
> by xdp_rxq_info_reg() function while transitioning the CPSW device to
> the up state. The message 'Missing net_device from driver' is output.
> 
> This patch fixes the issue by registering xdp_rxq info only if ethX
> port is enabled (i.e. ndev pointer is not NULL).
> 
> [...]

Here is the summary with links:
  - [net-next] net: ethernet: ti: am65-cpsw: Fix xdp_rxq error for disabled port
    https://git.kernel.org/netdev/net-next/c/80b7aae9e3b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <bpf+bounces-39417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B517C972D4F
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 11:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78321C244BC
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 09:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CCB188935;
	Tue, 10 Sep 2024 09:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DandZEhc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B1C186289;
	Tue, 10 Sep 2024 09:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725960031; cv=none; b=p1OA5UdNTBOv5/WTeKza5NCrYC2DBFW93mQZInEJ+GeEhMxDw0KxCMZKMS0stPlqHUqLayyu93oVsKH00VFWdZWDnG+YW6B/pEXWMLYFlIdQEbOQGnFGx5n+hubKoZYdRydDyElmnvJ6FjQemvwRQJglBfKGw+8+Hpc4niXKFyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725960031; c=relaxed/simple;
	bh=rnuCrS753BduIzY9Zaq6w0W8UNk9xrU+v2yRFq64zj4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qbOmiOgx1wjmAdeFEb80ksSnGwewyrMLf68kc7ut49kBTjKFtjCEmLK3Ip5Yi3GGLrJypCkljPScGFletASb/r+cHT6BHHCvwm8hBmQ94x75Ao+5UPytZlVa4H41+iCAKCei5qp95IhSytx+akTSrPcUh9ONJaw8bbMCMKKkSQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DandZEhc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329D9C4CEC6;
	Tue, 10 Sep 2024 09:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725960030;
	bh=rnuCrS753BduIzY9Zaq6w0W8UNk9xrU+v2yRFq64zj4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DandZEhcH8Nei9cSSd2BZCCTlwu2Z3mjmAZGVzw6RbILGE18lZbBNgXJcn0Kr3vJO
	 YnWcVkTeDdaFf9QoekStBwJZixH5NVqqzAmUgAtTvsevGwrfBDXSzcnyd9Aeo6VgdH
	 CwI76ee2l8g130Z8YG5N2jYMD1FU60eo9qI/IeaYVcgAD855HtK8kuNz8ocGUEewa1
	 3gOZj5stf/sdZUjHbn2PeipU/rEkVK3Lj/dm1v+o4Cb0ETf3CHDlsxAnkgJXUom0Hn
	 mHohAdLFCH8lkW3jVHRnJxywPw6sZVXmxj81AS1wGiqCenI1o3Ftab0lcRCCLEISr/
	 FJNf64x5rrVvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7142E3806654;
	Tue, 10 Sep 2024 09:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/12] net: lan966x: use the newly introduced FDMA
 library
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172596003126.183148.4876801824053155515.git-patchwork-notify@kernel.org>
Date: Tue, 10 Sep 2024 09:20:31 +0000
References: <20240905-fdma-lan966x-v1-0-e083f8620165@microchip.com>
In-Reply-To: <20240905-fdma-lan966x-v1-0-e083f8620165@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 5 Sep 2024 10:06:28 +0200 you wrote:
> This patch series is the second of a 2-part series [1], that adds a new
> common FDMA library for Microchip switch chips Sparx5 and lan966x. These
> chips share the same FDMA engine, and as such will benefit from a common
> library with a common implementation.  This also has the benefit of
> removing a lot of open-coded bookkeeping and duplicate code for the two
> drivers.
> 
> [...]

Here is the summary with links:
  - [net-next,01/12] net: lan966x: select FDMA library
    https://git.kernel.org/netdev/net-next/c/63acda75801f
  - [net-next,02/12] net: lan966x: use FDMA library symbols
    https://git.kernel.org/netdev/net-next/c/1dfe4ca8cb4a
  - [net-next,03/12] net: lan966x: replace a few variables with new equivalent ones
    https://git.kernel.org/netdev/net-next/c/8274d40eafa3
  - [net-next,04/12] net: lan966x: use the FDMA library for allocation of rx buffers
    https://git.kernel.org/netdev/net-next/c/01a70754327b
  - [net-next,05/12] net: lan966x: use FDMA library for adding DCB's in the rx path
    https://git.kernel.org/netdev/net-next/c/2b5a09e67b72
  - [net-next,06/12] net: lan966x: use library helper for freeing rx buffers
    https://git.kernel.org/netdev/net-next/c/f51293b3ea89
  - [net-next,07/12] net: lan966x: use the FDMA library for allocation of tx buffers
    https://git.kernel.org/netdev/net-next/c/df2ddc1458c3
  - [net-next,08/12] net: lan966x: use FDMA library for adding DCB's in the tx path
    https://git.kernel.org/netdev/net-next/c/29cc3a66a81d
  - [net-next,09/12] net: lan966x: use library helper for freeing tx buffers
    https://git.kernel.org/netdev/net-next/c/8cdd0bd02283
  - [net-next,10/12] net: lan966x: ditch tx->last_in_use variable
    https://git.kernel.org/netdev/net-next/c/c06fef96c7d5
  - [net-next,11/12] net: lan966x: use a few FDMA helpers throughout
    https://git.kernel.org/netdev/net-next/c/9fbc5719f6aa
  - [net-next,12/12] net: lan966x: refactor buffer reload function
    https://git.kernel.org/netdev/net-next/c/89ba464fcf54

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




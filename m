Return-Path: <bpf+bounces-60777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B13EADBCDE
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 00:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC088176B9F
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 22:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71D91E1C22;
	Mon, 16 Jun 2025 22:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oY5tAgJ0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8EF226CF6;
	Mon, 16 Jun 2025 22:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750113027; cv=none; b=eenEVfO9k9+7MfLp/E7uwiQL4VpsMsiVSmOs7JhEl/NwsBucgyVPaAA9tXZYu8B5jmlRtYHi3SRFGYhLmRfCDAzIGbVypupfP5a/xkgVlkQRuyOYWVeZW68AldHcWRy6EGQ7KrMZksFLUUsIUCUVrhe7eZPycuj54fQUflsoBaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750113027; c=relaxed/simple;
	bh=WDVZv9EE6mS6jDvaajlm3u4/ZSWgLXQxQ1N6upZKKn0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KzoS4lTlO52FZ3y8PgOBxpzkD3NhktDi6ndpDV0M7X0MpeIWea9P0U6XlLAUwbyOJzmKwBI3z3tXRKwUuZ7fknuY34XMgHJ13EXhEPpdyJKyvvKgrVVi9dTDUXTQEvv4w1UGiUAMXI13LP6q86KR/G2lPTKlx+TYlit4jLhQdzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oY5tAgJ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56C0C4CEEF;
	Mon, 16 Jun 2025 22:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750113027;
	bh=WDVZv9EE6mS6jDvaajlm3u4/ZSWgLXQxQ1N6upZKKn0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oY5tAgJ03t9L79RFF2nY/cl8ZB738UveLK+CGHvVPahajhd5CYC89lhzvjmHHrdcb
	 nSraE+dF8VoIibrQia8RRZZxnvXgAA1eP73sxuf3asMPqksGdwRX1urDQ5+GKVDzh/
	 F9P1aMg6oMOVWyLTuolVpKTJzq+N/oAMGOQydyubD/yUSyXRT3z5AhKxqTNL1O1Nfg
	 Lr//oXonVACnP6KVzBqzcae29hjOnvXIB5UrbHpEQVxtWcvP0d/rjDRA0GzIMTbNJH
	 jTjhMKE7RSABpVQ9ARIM038fImgSblT/IPxZxTmUObsNLvqmTEoNsJ28x/DUmkBdkT
	 9t7vTTyWaHHSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEE038111D8;
	Mon, 16 Jun 2025 22:30:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next,v8] net: mana: Add handler for hardware servicing
 events
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175011305549.2535792.9878725373600359262.git-patchwork-notify@kernel.org>
Date: Mon, 16 Jun 2025 22:30:55 +0000
References: <1749834034-18498-1-git-send-email-haiyangz@linux.microsoft.com>
In-Reply-To: <1749834034-18498-1-git-send-email-haiyangz@linux.microsoft.com>
To: Haiyang Zhang <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 haiyangz@microsoft.com, decui@microsoft.com, stephen@networkplumber.org,
 kys@microsoft.com, paulros@microsoft.com, olaf@aepfle.de,
 vkuznets@redhat.com, davem@davemloft.net, wei.liu@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, leon@kernel.org,
 longli@microsoft.com, ssengar@linux.microsoft.com,
 linux-rdma@vger.kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 bpf@vger.kernel.org, ast@kernel.org, hawk@kernel.org, tglx@linutronix.de,
 shradhagupta@linux.microsoft.com, andrew+netdev@lunn.ch,
 kotaranov@microsoft.com, horms@kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Jun 2025 10:00:34 -0700 you wrote:
> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> To collaborate with hardware servicing events, upon receiving the special
> EQE notification from the HW channel, remove the devices on this bus.
> Then, after a waiting period based on the device specs, rescan the parent
> bus to recover the devices.
> 
> [...]

Here is the summary with links:
  - [net-next,v8] net: mana: Add handler for hardware servicing events
    https://git.kernel.org/netdev/net-next/c/7768c5f41733

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




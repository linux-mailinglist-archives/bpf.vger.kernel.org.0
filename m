Return-Path: <bpf+bounces-54857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCB1A74BDC
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 15:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4D8A1B6477A
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 13:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B0335976;
	Fri, 28 Mar 2025 13:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfs0gsXc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6251E51FC;
	Fri, 28 Mar 2025 13:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743169800; cv=none; b=gHV4mED3qYT/PidC8tEv4MXHe6ZLS/Qbhpith7/hbU5/9DWAraqW48DVrdXNM+L2TdcQy5DInv+WfcusKEDu0cYvgdzuU70AayC94jRloUQFjMKl/+ha7kpgdeuSwyY6YkY3bmleqeF68Q8+Tmpq42Cb+QYBCIcTdgCz393Q+JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743169800; c=relaxed/simple;
	bh=C/HNgQvzhzwSU4z9n3OmsK4Y3PL+bnZxFxCh03wYSoI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HqrzbQXL2ISvzhBns0z2E6L1Q13JfKgbFX+FcKB/WKzNW/EBTBQJ4tmIajQHsurIj/qWUbyju25uGBOizqkh6YIjaZe8lIU7/6qeYwdO6JLKCB0dwQFMJBTLy4JhiwiqaXWIECm//bjqwTBDZ8N3pFAS//98yeTrmodxNk+JJs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfs0gsXc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E433DC4CEE5;
	Fri, 28 Mar 2025 13:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743169800;
	bh=C/HNgQvzhzwSU4z9n3OmsK4Y3PL+bnZxFxCh03wYSoI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hfs0gsXcXpmka9qXcE42QLJgacdYBgUs4uLYnnOSg9YeRIwY+WMUcDRpbvoVFoHgy
	 iI2BcDbSpHr+muZtqouOI32PGmJwxMSBmA+Qe13O/9uJgYrxjzyp5O5fi6kYvQzSAf
	 ATIyY4VGK6w+5ygbYt+Z1jZUukVG5Awwb9v7kjAWDjLSF5pl1ZjpJoVepeFB/sPeWu
	 uAplwDNI503p0TBGzG+09RQpy7Fcb1QA1iSPJ8G8q7H+gtvDaR9/SXE4i70cTQmY5f
	 O+IO6sWZse43D26ins2bMPxLDtuOoBTzho3hYIWqhtbdjSe5DskzMN3rR+3WQncWh5
	 p0Tjt82p+DvYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DFE380AA66;
	Fri, 28 Mar 2025 13:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net,v2] net: mana: Switch to page pool for jumbo frames
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174316983630.2839333.18097886988344438965.git-patchwork-notify@kernel.org>
Date: Fri, 28 Mar 2025 13:50:36 +0000
References: <1742920357-27263-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1742920357-27263-1-git-send-email-haiyangz@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, decui@microsoft.com,
 stephen@networkplumber.org, kys@microsoft.com, paulros@microsoft.com,
 olaf@aepfle.de, vkuznets@redhat.com, davem@davemloft.net, wei.liu@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, leon@kernel.org,
 longli@microsoft.com, ssengar@linux.microsoft.com,
 linux-rdma@vger.kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 bpf@vger.kernel.org, ast@kernel.org, hawk@kernel.org, tglx@linutronix.de,
 shradhagupta@linux.microsoft.com, jesse.brandeburg@intel.com,
 andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Mar 2025 09:32:37 -0700 you wrote:
> Frag allocators, such as netdev_alloc_frag(), were not designed to
> work for fragsz > PAGE_SIZE.
> 
> So, switch to page pool for jumbo frames instead of using page frag
> allocators. This driver is using page pool for smaller MTUs already.
> 
> Cc: stable@vger.kernel.org
> Fixes: 80f6215b450e ("net: mana: Add support for jumbo frame")
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: mana: Switch to page pool for jumbo frames
    https://git.kernel.org/netdev/net/c/fa37a8849634

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <bpf+bounces-73409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBA4C2EDD1
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 02:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EDB71888D4A
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 01:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABDB22A1E1;
	Tue,  4 Nov 2025 01:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="po5OyuyF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F89A219E8D;
	Tue,  4 Nov 2025 01:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762220442; cv=none; b=VdubnsE/jql2D76c/TplvmqEwMKQW+VoRgi1VG32vnG4Sm6mDNPJEYtVMuz0gASUsBL+1/8MVxwve5BtmbgUHAZH6s1TMq8Ah7wBJ1B7pGQMZLXNoZwqOvYaODeo/AwXCbz+KS7lWu75MBJhc0Ts/MRJtHhWeSKgucvQeHchdVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762220442; c=relaxed/simple;
	bh=VJ2F9710N8l9Zd8t0xRKF/S4f0Ehk5s7Di7kmYu+X60=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=feKaEe+OjZdhfzMLOB15hxUzkPqor3MxHlVHOHYA85iISadJ+rjhkUHY9YdtIeG4CCxzSs3mvA4kQBgB1aTljrpFPlGdsHOFFmZZYCm9E+bmHDCsPwkX7Sdb1CjlOFcL9TpII+LHF8mo55aN3zSIog5yPHs4Kn3PYCs9z2ClMNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=po5OyuyF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE63FC4CEE7;
	Tue,  4 Nov 2025 01:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762220441;
	bh=VJ2F9710N8l9Zd8t0xRKF/S4f0Ehk5s7Di7kmYu+X60=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=po5OyuyFGBjPDMOOGtgNqhCJ+aILDuOqrzw0f+f47ozjmWoS/3zQTiwCQ8TrUdp0o
	 ryA1ReymuLrn+QOpFL9YkUCTXs0BC8J05DoZgbJlYxlry8FuwMP2cUx4WDtFcfw1gr
	 HqELcKMgOSB3KvLT/YenNo6T7sdvDPydawnOjnw7nUSBRLnIJ/qEC9jSF8VomST6m0
	 RMVanrVmrOYRx2q4vskpJD/1qjThBw3+l2v+64ymKoRTgfqyB4C012lBiP2LAjPmvA
	 hB2iy1OtKATm7J4CihbAxToddUj8Bb6MoOp7e6V2cF5YEPD2PASsOBw4Ixp7I0l78k
	 T2iXqdO4U71oQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D853809A8A;
	Tue,  4 Nov 2025 01:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-pf: Fix devm_kcalloc() error checking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176222041599.2285814.11616778386384057545.git-patchwork-notify@kernel.org>
Date: Tue, 04 Nov 2025 01:40:15 +0000
References: <aQYKkrGA12REb2sj@stanley.mountain>
In-Reply-To: <aQYKkrGA12REb2sj@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: sumang@marvell.com, sgoutham@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, hkelam@marvell.com, bbhushan2@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 1 Nov 2025 16:26:42 +0300 you wrote:
> The devm_kcalloc() function never return error pointers, it returns NULL
> on failure.  Also delete the netdev_err() printk.  These allocation
> functions already have debug output built-in some the extra error message
> is not required.
> 
> Fixes: efabce290151 ("octeontx2-pf: AF_XDP zero copy receive support")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-pf: Fix devm_kcalloc() error checking
    https://git.kernel.org/netdev/net/c/2e25935ed24d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




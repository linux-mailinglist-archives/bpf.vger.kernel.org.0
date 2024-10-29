Return-Path: <bpf+bounces-43451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9B39B56F3
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 00:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C58891F22C7A
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 23:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8517B20B210;
	Tue, 29 Oct 2024 23:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7g3uzD6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFBE190665;
	Tue, 29 Oct 2024 23:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244625; cv=none; b=F5NEO4itz67XfuVpW8D9ewGg7yxxv/VNaqHhLdv7354qKrm8SjbbHuysY0YMuPBHZAqy3RdYyqUiTBc8XXJVzrDS/hlql8l/Mdyzq2BHKt1BKsAPJFnoqflfYciWPNYYTBFL0W8WByQN80W/Fc1MN2S8/liNYMMNgEf1tcysOUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244625; c=relaxed/simple;
	bh=WW3mdSM3TRIghHeyfr3oDUaW5LxYvDMSqojUnsWX6KU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HHGd6zX1h8S9ZAzoJRb6lPCi/HvZ9b9OhLYN3ecXt0/vifWzoUJ3YtGYZp8XoKmFhNWIp4Vn9RfGzjRqXBS0VcDPVVnunfChqlvsmCXZEvigBtC5o67DYClNWG+bOv3q/yyeBlmny/svIZYgEFOmalgVyghZfJZStFB1+sdMDXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7g3uzD6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75345C4CEE6;
	Tue, 29 Oct 2024 23:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730244624;
	bh=WW3mdSM3TRIghHeyfr3oDUaW5LxYvDMSqojUnsWX6KU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R7g3uzD6Ns+qmTU1Mjt7FtAZxBYqgbyyfpt6ntGNpsEfUCmsUHzTK25G9lNT7DttE
	 iq0QQVYZCx8udrwva0ai4phjSQKVylglw7M7+BKMV9CjZirzSjQ06lR+ygkPd10UmE
	 7DaZCh9dSidr0YSv8wb73zkj/LOCmw2D+NCPgg4Ztaz0+2qcXrifFuMyKtdBvMf8mP
	 LuIcBfNrS438JP0P2zz8xfdAag2coUSlWXTUWLRinNzteANG5bpSRaZY/eW064+09Y
	 7CboYpby8kFblM9avipC24c67e8AvEp9swkW1+7gdISpQ+FxEDM7GQr2vUNukTS518
	 cWtnvb7DaJFbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F1B380AC00;
	Tue, 29 Oct 2024 23:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: marvell: use ethtool string helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173024463202.852400.15927674620572906785.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 23:30:32 +0000
References: <20241024195833.176843-1-rosenp@gmail.com>
In-Reply-To: <20241024195833.176843-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, marcin.s.wojtas@gmail.com, linux@armlinux.org.uk,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vburru@marvell.com, sedara@marvell.com,
 srasheed@marvell.com, sburla@marvell.com, sgoutham@marvell.com,
 gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
 mlindner@marvell.com, stephen@networkplumber.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 jacob.e.keller@intel.com, sd@queasysnail.net, horms@kernel.org,
 almasrymina@google.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Oct 2024 12:58:33 -0700 you wrote:
> The latter is the preferred way to copy ethtool strings.
> 
> Avoids manually incrementing the pointer. Cleans up the code quite well.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 39 ++++------
>  .../marvell/octeon_ep/octep_ethtool.c         | 31 +++-----
>  .../marvell/octeon_ep_vf/octep_vf_ethtool.c   | 31 +++-----
>  .../marvell/octeontx2/nic/otx2_ethtool.c      | 78 +++++++------------
>  drivers/net/ethernet/marvell/skge.c           |  3 +-
>  drivers/net/ethernet/marvell/sky2.c           |  3 +-
>  6 files changed, 68 insertions(+), 117 deletions(-)

Here is the summary with links:
  - [net-next] net: marvell: use ethtool string helpers
    https://git.kernel.org/netdev/net-next/c/2d7dfe2d0ba7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




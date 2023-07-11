Return-Path: <bpf+bounces-4733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D130B74E960
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 10:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D650F2813B7
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 08:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285AE174F3;
	Tue, 11 Jul 2023 08:50:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D3D5246;
	Tue, 11 Jul 2023 08:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88CDDC433C9;
	Tue, 11 Jul 2023 08:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689065421;
	bh=/k5olDGpbnyZ4n9IScGnO/ghFsMW4z+IdHliHFazRfY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QQdaVSMQf4Cl2d1URQhv/st9xBAGVyHlQnIRt+bNnJON7uqdHNVD1T6FxqBY7s+Vf
	 a2zcnX0dkaZBEYvxMgbS1H21aLNWqAfsdhs/IeCborE4VgQZ5Zu3W1cYJ9T9I+lHkL
	 vDi6be6VxrsmJUd1yA+UX+4kYRDmWh8UBK2EFqI5atIu2nXPkE+uoezEc0vjS0IA1v
	 8DEa0uMpjD2fTBdbLyMOCZ6a0Kr7h3urVQpvFd7aTWP6Mq/WkhlX6cSMpywmnkDMSx
	 m7nqPLZL5A1azKj/Tad4gi8k4Tw5/DMFdj2ThNB33pS8WUwRHrRwr6cESa/aNPXuT9
	 9S82HvLTXZGSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69161C4167B;
	Tue, 11 Jul 2023 08:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 net 0/4] net: fec: fix some issues of ndo_xdp_xmit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168906542142.15715.5308120032595362444.git-patchwork-notify@kernel.org>
Date: Tue, 11 Jul 2023 08:50:21 +0000
References: <20230706081012.2278063-1-wei.fang@nxp.com>
In-Reply-To: <20230706081012.2278063-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
 netdev@vger.kernel.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  6 Jul 2023 16:10:08 +0800 you wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> We encountered some issues when testing the ndo_xdp_xmit() interface
> of the fec driver on i.MX8MP and i.MX93 platforms. These issues are
> easy to reproduce, and the specific reproduction steps are as follows.
> 
> step1: The ethernet port of a board (board A) is connected to the EQOS
> port of i.MX8MP/i.MX93, and the FEC port of i.MX8MP/i.MX93 is connected
> to another ethernet port, such as a switch port.
> 
> [...]

Here is the summary with links:
  - [V2,net,1/4] net: fec: dynamically set the NETDEV_XDP_ACT_NDO_XMIT feature of XDP
    https://git.kernel.org/netdev/net/c/be7ecbe7ec7d
  - [V2,net,2/4] net: fec: recycle pages for transmitted XDP frames
    https://git.kernel.org/netdev/net/c/20f797399035
  - [V2,net,3/4] net: fec: increase the size of tx ring and update tx_wake_threshold
    https://git.kernel.org/netdev/net/c/56b3c6ba53d0
  - [V2,net,4/4] net: fec: use netdev_err_once() instead of netdev_err()
    https://git.kernel.org/netdev/net/c/84a109471987

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




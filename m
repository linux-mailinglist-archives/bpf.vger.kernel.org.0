Return-Path: <bpf+bounces-33977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C64B5928FA6
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 02:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02371B24DE5
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 00:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82F32595;
	Sat,  6 Jul 2024 00:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n26SePRf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537F236B;
	Sat,  6 Jul 2024 00:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720224632; cv=none; b=DzV6UNnheEzaX9FKYiJlufGctRpsp9hnSrxD+r4nb3cgY6WDqC+DIMcKpV9R0WBrX84x+vMhFM6NZlnURN7sD+tXmPrQgWxr9m7lfFm2EhVbcIgDC7F25wf4w590A6Wk6roGZnI/AuM/ltcjix/3XNM0ITSu8W9npREW6ZLxJpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720224632; c=relaxed/simple;
	bh=bLGujo4OqmUKJc33fuX1ynAS8onK3FEEXVmFJ0zu/I8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YYHrYTY+aNTVSIC5djRDOcYzkzuTmtUuoHKid5qTUlbizf0RMUidmeh5o581bU7qjTJAY9pDFBOFXJEyS5JTSKAG3NvFH8o8wim6eE3iP3G/VJBmfcHI26/T+s4QyPyWRfMa5bxTHo7J3moGm0/6pLo5Bhi9QygK4EClxRuaIwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n26SePRf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6242C4AF0B;
	Sat,  6 Jul 2024 00:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720224631;
	bh=bLGujo4OqmUKJc33fuX1ynAS8onK3FEEXVmFJ0zu/I8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n26SePRfDneerwWeVwWkbyPDd3YQimba9jNDLjlu8Jwe30mNycIquPPEWIlLziz8O
	 1yGrwPt158UO6Lkyj5vBEOue16HEBhqkSCBfMP+trAF1YlDDXr+z7kz9deGAPaXFgg
	 6Lk0RdXhCSdmIEZp2iKS9TSvLjfsFyepdXyiEIZQXT2V/O/3CPPlio+HoboXSz4Jh3
	 nyFW2yIz1nsV/c2XyWImEGj89qAUVz/eDvwun4WpwrHmR7Fz7qA9Y8EJCcOrfOTEpx
	 qpmZC41nYE4hUi7uw/FKAmxBIEXMtwjSvoYpRrcp1hHck1DrA+/S63ZN0fywZmvPVr
	 bksFS6Pprw/TQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A565FC43612;
	Sat,  6 Jul 2024 00:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next] tun: Assign missing bpf_net_context.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172022463167.12418.6553278827173243534.git-patchwork-notify@kernel.org>
Date: Sat, 06 Jul 2024 00:10:31 +0000
References: <20240704144815.j8xQda5r@linutronix.de>
In-Reply-To: <20240704144815.j8xQda5r@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: kuba@kernel.org, syzbot+08811615f0e17bc6708b@syzkaller.appspotmail.com,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, eddyz87@gmail.com, haoluo@google.com, hawk@kernel.org,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org,
 sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com,
 yonghong.song@linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 4 Jul 2024 16:48:15 +0200 you wrote:
> During the introduction of struct bpf_net_context handling for
> XDP-redirect, the tun driver has been missed.
> Jakub also pointed out that there is another call chain to
> do_xdp_generic() originating from netif_receive_skb() and drivers may
> use it outside from the NAPI context.
> 
> Set the bpf_net_context before invoking BPF XDP program within the TUN
> driver. Set the bpf_net_context also in do_xdp_generic() if a xdp
> program is available.
> 
> [...]

Here is the summary with links:
  - [v3,net-next] tun: Assign missing bpf_net_context.
    https://git.kernel.org/netdev/net-next/c/fecef4cd42c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




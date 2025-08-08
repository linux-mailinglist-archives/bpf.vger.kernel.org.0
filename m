Return-Path: <bpf+bounces-65282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47646B1EFE1
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 22:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 992163BD4DF
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 20:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E144230D08;
	Fri,  8 Aug 2025 20:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGp0sq6Y"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90D44A11;
	Fri,  8 Aug 2025 20:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754686195; cv=none; b=EzIFBYFFXwVDhBwCXQvEmQ31YK/MReuskTGoxxHXcLRc0pKea0J+WN7ZeW6i8j0EJgWxCEfiY1WxKEwo0rgWNHziNa386oFiM0Rr2rZjRUCpR1RHA2UsJpMW1y+6Fv9jl5ArY/sRrYltEPTiCWUNQqhARSmsu5EEieY+vCPv4NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754686195; c=relaxed/simple;
	bh=gquh5a5l+8bXFMOP0OQWM/c/nUYiRwI9NqJrbJZLcEA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k2N0FyAyA9lYYKFeTgQ2mapMf29Us0pV5nViLuSM9AMmk9ipPKJo50ShlllMDlqMOpl/+KYY8fFKF4hvwB1iWfTeJPozGYDPsoe1/Qef+6yMkyvaha83N9SpbjRTghHx67X2wvK4pLLBC/Oy9EO6bqMwpVcX/GHrfMePXA3fn/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGp0sq6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9C6C4CEED;
	Fri,  8 Aug 2025 20:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754686195;
	bh=gquh5a5l+8bXFMOP0OQWM/c/nUYiRwI9NqJrbJZLcEA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RGp0sq6YQVF5fOjetz7ilXb130JJKk8ZT/rz2/m8nnbZ67PMjOKf7b83UJ/pP7ksy
	 ry06tU3/MhpG1SpJs7ddyjsxnM4y4O9rqB5FSBmjWCnu60qiCIXIFbwTli9cJ/hQ0L
	 4fUiuV/i5jxRYBX63CBK4BKVil1SdFgbtAkuXgFwahsnjLEHmlK48ZHhMWORJglgdO
	 dUOk3jsGmSrL5bLqxtYRDp+nxWcE26UsCLJS9zgwFVARFF+OgGSi4TGVKdEkTo9VEI
	 sTQ9fIzGMHBhfrHybozqBxFrlGWOOtKtTSGYcKQ2ZZ0qf91JEoQUT2HmWmcbgXUgNz
	 VNOuZmhXyGwgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE27383BF5A;
	Fri,  8 Aug 2025 20:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] net: lapbether: ignore ops-locked netdevs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175468620854.263488.4481510843319056617.git-patchwork-notify@kernel.org>
Date: Fri, 08 Aug 2025 20:50:08 +0000
References: <20250806213726.1383379-1-sdf@fomichev.me>
In-Reply-To: <20250806213726.1383379-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, ms@dev.tdt.de,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, aleksander.lobakin@intel.com,
 linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org, bpf@vger.kernel.org,
 syzbot+e67ea9c235b13b4f0020@syzkaller.appspotmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 Aug 2025 14:37:25 -0700 you wrote:
> Syzkaller managed to trigger lock dependency in xsk_notify via
> register_netdevice. As discussed in [0], using register_netdevice
> in the notifiers is problematic so skip adding lapbeth for ops-locked
> devices.
> 
>        xsk_notifier+0xa4/0x280 net/xdp/xsk.c:1645
>        notifier_call_chain+0xbc/0x410 kernel/notifier.c:85
>        call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2230
>        call_netdevice_notifiers_extack net/core/dev.c:2268 [inline]
>        call_netdevice_notifiers net/core/dev.c:2282 [inline]
>        unregister_netdevice_many_notify+0xf9d/0x2700 net/core/dev.c:12077
>        unregister_netdevice_many net/core/dev.c:12140 [inline]
>        unregister_netdevice_queue+0x305/0x3f0 net/core/dev.c:11984
>        register_netdevice+0x18f1/0x2270 net/core/dev.c:11149
>        lapbeth_new_device drivers/net/wan/lapbether.c:420 [inline]
>        lapbeth_device_event+0x5b1/0xbe0 drivers/net/wan/lapbether.c:462
>        notifier_call_chain+0xbc/0x410 kernel/notifier.c:85
>        call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2230
>        call_netdevice_notifiers_extack net/core/dev.c:2268 [inline]
>        call_netdevice_notifiers net/core/dev.c:2282 [inline]
>        __dev_notify_flags+0x12c/0x2e0 net/core/dev.c:9497
>        netif_change_flags+0x108/0x160 net/core/dev.c:9526
>        dev_change_flags+0xba/0x250 net/core/dev_api.c:68
>        devinet_ioctl+0x11d5/0x1f50 net/ipv4/devinet.c:1200
>        inet_ioctl+0x3a7/0x3f0 net/ipv4/af_inet.c:1001
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: lapbether: ignore ops-locked netdevs
    https://git.kernel.org/netdev/net/c/53898ebabe84
  - [net,2/2] hamradio: ignore ops-locked netdevs
    https://git.kernel.org/netdev/net/c/c64237960819

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




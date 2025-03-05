Return-Path: <bpf+bounces-53263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D662A4F344
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 02:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B0816ED7A
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 01:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2B7139CF2;
	Wed,  5 Mar 2025 01:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skucHruF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55A45228;
	Wed,  5 Mar 2025 01:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741136999; cv=none; b=dNHHCRQAqm+yCUgLyUjncsJ6KwLHz0yR66+uyHfLagCiYSdGN47MxIv+/4CL0m7wD2WfGjRA9OM4yrrRZWKaJ8Vz3pqir19XW74b/WMhPn0tKF920hbbwLixUdLQHCaARNzYb0/JIsnX98HeL2hPExCUEzavgg3WhJDtQiMCo5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741136999; c=relaxed/simple;
	bh=oRu4ENvt5IO9ShjHhUpiGMnLQIYnQAofJB58ttqXE7c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t2A77PI5TyJ0G0/gnX6Llj1el362DMfxTzlMgICeZvvx+QHT11LpXOpS7vE8THY/a5fokED9WNJ08CMquD9wY2tz6RcWREnC054mLS1U9hjmvpuV8kasg1p9emyC6vUUAXfKkx2/cuywUTbE6dTHxbCzj0dRwiy1v8ybsf8xuRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skucHruF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064E0C4CEE5;
	Wed,  5 Mar 2025 01:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741136999;
	bh=oRu4ENvt5IO9ShjHhUpiGMnLQIYnQAofJB58ttqXE7c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=skucHruF5uipXBnKaegjV66QTN65SNZJ7h+UT9MiCm7WhrRpQ89Yd9VxH/lSiKG2o
	 +Ap6hL3tyJ8Zb0bec9HG9WwKoqkmnzda6J096DadF9VTfjeXLctyIe1wHzaTyUibxD
	 SJHmaDtuTBux0bVwxRe1sOcsFvTRnCKHYbSHEDYvmWq9TbM+eoKx72Taq7VZx+/jFf
	 k+8qUo9P+yZdtc8tuz58/VXRn/K/s7npgHmMolkoGxBo0UgvMz1ADOJBHyd/CIJ8E8
	 wPA/aHw6xxhIRT+Q/KNVwPlXJPmCuKPKBpq1uO5Rux1ZZFH4uTCH4WmU20cx4tBxhk
	 wau7SjCLTTv2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C89380CFEB;
	Wed,  5 Mar 2025 01:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5] ppp: Fix KMSAN uninit-value warning with bpf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174113703200.354590.6042068788472875055.git-patchwork-notify@kernel.org>
Date: Wed, 05 Mar 2025 01:10:32 +0000
References: <20250228141408.393864-1-jiayuan.chen@linux.dev>
In-Reply-To: <20250228141408.393864-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: horms@kernel.org, kuba@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, ricardo@marliere.net,
 viro@zeniv.linux.org.uk, dmantipov@yandex.ru, aleksander.lobakin@intel.com,
 linux-ppp@vger.kernel.org, linux-kernel@vger.kernel.org, mrpre@163.com,
 paulus@samba.org, syzbot+853242d9c9917165d791@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Feb 2025 22:14:08 +0800 you wrote:
> Syzbot caught an "KMSAN: uninit-value" warning [1], which is caused by the
> ppp driver not initializing a 2-byte header when using socket filter.
> 
> The following code can generate a PPP filter BPF program:
> '''
> struct bpf_program fp;
> pcap_t *handle;
> handle = pcap_open_dead(DLT_PPP_PPPD, 65535);
> pcap_compile(handle, &fp, "ip and outbound", 0, 0);
> bpf_dump(&fp, 1);
> '''
> Its output is:
> '''
> (000) ldh [2]
> (001) jeq #0x21 jt 2 jf 5
> (002) ldb [0]
> (003) jeq #0x1 jt 4 jf 5
> (004) ret #65535
> (005) ret #0
> '''
> Wen can find similar code at the following link:
> https://github.com/ppp-project/ppp/blob/master/pppd/options.c#L1680
> The maintainer of this code repository is also the original maintainer
> of the ppp driver.
> 
> [...]

Here is the summary with links:
  - [net-next,v5] ppp: Fix KMSAN uninit-value warning with bpf
    https://git.kernel.org/netdev/net/c/4c2d14c40a68

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




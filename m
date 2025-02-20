Return-Path: <bpf+bounces-52110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF74AA3E7C1
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 23:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10B18422D2A
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 22:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206EC264A6E;
	Thu, 20 Feb 2025 22:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCJ5zAqk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983741C5D67;
	Thu, 20 Feb 2025 22:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740091804; cv=none; b=bfKDBwFC6KgdFoSyCr9TLuC5JkvL+8tgSF1bDlS8fxLP8mQwhcecMLzMP9+yseT01WTga8APlKeOeHbfyzCHGtk2HaBFaj+EIwsYGczdmJXg6kTDNEx4ja9QJ/U0gsj5eOfLTxF8XrpCk1EKGZrEHP6jJaN7fRx3TisZm414CGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740091804; c=relaxed/simple;
	bh=q/VpeOd87uiSFjqNCfspr2LpWPGa0Kqyk7Obefw35Wg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gc6LsLb31FPuthX3QTNQYB92vxyFj7QS6H6nHfhxJR84zxUozwbZKMnAYLDfl9+HH5Nzci/KplOvQb3njYKzaQ+4G1TYG+HLFBmzelzLvkDCigIARGipQQLbzLVfOo2unvuQgFYJwztbpSgwExCf2Z+w5Eo9QJJzzfFZcSY3caI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCJ5zAqk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0989EC4CED1;
	Thu, 20 Feb 2025 22:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740091804;
	bh=q/VpeOd87uiSFjqNCfspr2LpWPGa0Kqyk7Obefw35Wg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qCJ5zAqkYbf1MLYRGP/2t1iRk6xjiEsgVKaNngGqqLoC3rGu6hLAHsTHySaZ95faX
	 7lrFSBVXSZB/DSdoNArzOIsZFLoGF+1N3pGd5haO5aHJBACZh2NCx1ZmcYu1K5YJcr
	 4qlWqfJD0uiNv0P38eUKJmVQgZZS28ATLeJdl2cAyKaS2RUQe4FiBaTxpVwMzFUTdw
	 EyEHUdF/4haPxtiSs/sbmhw0krNtw+NEDD0naWuvE4OlZo0yYpo2OTc6BPcJZaC3Lf
	 QA0P7Wxrg1Op/NbYuVPrk+APZ3PnLj4DyV0pz4R6I61kgRX43Zh33QDtvTN2ik/Ig5
	 M0ZGLFmd07/cg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB628380CEE2;
	Thu, 20 Feb 2025 22:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v13 00/12] net-timestamp: bpf extension to equip
 applications transparently
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174009183478.1502593.975755252949089833.git-patchwork-notify@kernel.org>
Date: Thu, 20 Feb 2025 22:50:34 +0000
References: <20250220072940.99994-1-kerneljasonxing@gmail.com>
In-Reply-To: <20250220072940.99994-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 ykolal@fb.com, bpf@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (net)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu, 20 Feb 2025 15:29:28 +0800 you wrote:
> "Timestamping is key to debugging network stack latency. With
> SO_TIMESTAMPING, bugs that are otherwise incorrectly assumed to be
> network issues can be attributed to the kernel." This is extracted
> from the talk "SO_TIMESTAMPING: Powering Fleetwide RPC Monitoring"
> addressed by Willem de Bruijn at netdevconf 0x17).
> 
> There are a few areas that need optimization with the consideration of
> easier use and less performance impact, which I highlighted and mainly
> discussed at netconf 2024 with Willem de Bruijn and John Fastabend:
> uAPI compatibility, extra system call overhead, and the need for
> application modification. I initially managed to solve these issues
> by writing a kernel module that hooks various key functions. However,
> this approach is not suitable for the next kernel release. Therefore,
> a BPF extension was proposed. During recent period, Martin KaFai Lau
> provides invaluable suggestions about BPF along the way. Many thanks
> here!
> 
> [...]

Here is the summary with links:
  - [bpf-next,v13,01/12] bpf: add networking timestamping support to bpf_get/setsockopt()
    (no matching commit)
  - [bpf-next,v13,02/12] bpf: prepare the sock_ops ctx and call bpf prog for TX timestamping
    https://git.kernel.org/bpf/bpf-next/c/df600f3b1d79
  - [bpf-next,v13,03/12] bpf: prevent unsafe access to the sock fields in the BPF timestamping callback
    https://git.kernel.org/bpf/bpf-next/c/fd93eaffb3f9
  - [bpf-next,v13,04/12] bpf: disable unsafe helpers in TX timestamping callbacks
    https://git.kernel.org/bpf/bpf-next/c/2958624b2530
  - [bpf-next,v13,05/12] net-timestamp: prepare for isolating two modes of SO_TIMESTAMPING
    https://git.kernel.org/bpf/bpf-next/c/aa290f93a4af
  - [bpf-next,v13,06/12] bpf: add BPF_SOCK_OPS_TSTAMP_SCHED_CB callback
    https://git.kernel.org/bpf/bpf-next/c/6b98ec7e882a
  - [bpf-next,v13,07/12] bpf: add BPF_SOCK_OPS_TSTAMP_SND_SW_CB callback
    https://git.kernel.org/bpf/bpf-next/c/ecebb17ad818
  - [bpf-next,v13,08/12] bpf: add BPF_SOCK_OPS_TSTAMP_SND_HW_CB callback
    https://git.kernel.org/bpf/bpf-next/c/2deaf7f42b8c
  - [bpf-next,v13,09/12] bpf: add BPF_SOCK_OPS_TSTAMP_ACK_CB callback
    https://git.kernel.org/bpf/bpf-next/c/b3b81e6b009d
  - [bpf-next,v13,10/12] bpf: add BPF_SOCK_OPS_TSTAMP_SENDMSG_CB callback
    https://git.kernel.org/bpf/bpf-next/c/c9525d240c81
  - [bpf-next,v13,11/12] bpf: support selective sampling for bpf timestamping
    https://git.kernel.org/bpf/bpf-next/c/59422464266f
  - [bpf-next,v13,12/12] selftests/bpf: add simple bpf tests in the tx path for timestamping feature
    https://git.kernel.org/bpf/bpf-next/c/f4924aec58dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




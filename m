Return-Path: <bpf+bounces-30603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 013DA8CF0E9
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 20:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB9F01F220EE
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 18:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A41127B75;
	Sat, 25 May 2024 18:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wq5swo+y"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE239F9F8;
	Sat, 25 May 2024 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716660029; cv=none; b=oReGF/A2541Xa5MqGNXIpI4xPbazSx0koK4e6kWW8hhKbz17vO57azVEb8OnAMMeKGYHnEzB5n0/Jk0UpUrX8JHqyWc0N1J1L1BHC+nmdOXHnU1cO4uUah1Gsr9WJsAj10uHwm1mUeP5CUolluXjueU/vd3cUhqK+d7GXj8Mi2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716660029; c=relaxed/simple;
	bh=+uGOgBVQQ6lxanu4HN4YBy/qqNx6xjUTKUHCj1lbs0I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kashH5u8Okj9wblrLBUY47pKXFr8OlMHs8xokkHAPPyS3C6JSZzBmuqbTrpzrDaorGgpu7SxsVe24VtWhUKOmiV+OtZYZmwQKGpjklSRF3A3NR9TiIqRJiRdB4WMbJ2LydyY3hYIj2s7CoJ0QAszRxzJI1JWUFqmefkhhuwDBQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wq5swo+y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A84BC2BD11;
	Sat, 25 May 2024 18:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716660028;
	bh=+uGOgBVQQ6lxanu4HN4YBy/qqNx6xjUTKUHCj1lbs0I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Wq5swo+y45jV+A/pHAZK5jWLzBl1vhYUVEG3aMBuz4EM4MJF/E3JWP3MMRNYb3Ci9
	 3gM27PT2lDOKieivcsCL0q/1TMwJ/8MRFTgILPJjfS3OC9+az5kAoZVMpW4hiPVo83
	 FF1h5IiBVjdoBRSTu4BCQCNKNn0Vd/69MQxReftk5ikl6duDOT77sfxh3o11DO1o2e
	 8IaiGUKLjv33bZQl9YuSN1cnSD10ZqyjYxeX4EhYClC2vG/LRFJ2z+iU/5G6hv/QJ9
	 M0gE8lLOMuhk8Q2zCbzbTeb2Lg/bEoqVfWLf97RPRIJ5oCX5LdjduywVxGuPAA8Bjl
	 jZyTCfwAq8Yww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5FC56C43617;
	Sat, 25 May 2024 18:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 1/4] netkit: Fix setting mac address in l2 mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171666002838.16446.5017256831702997477.git-patchwork-notify@kernel.org>
Date: Sat, 25 May 2024 18:00:28 +0000
References: <20240524163619.26001-1-daniel@iogearbox.net>
In-Reply-To: <20240524163619.26001-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: martin.lau@kernel.org, razor@blackwall.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 24 May 2024 18:36:16 +0200 you wrote:
> When running Cilium connectivity test suite with netkit in L2 mode, we
> found that it is expected to be able to specify a custom MAC address for
> the devices, in particular, cilium-cni obtains the specified MAC address
> by querying the endpoint and sets the MAC address of the interface inside
> the Pod. Thus, fix the missing support in netkit for L2 mode.
> 
> Fixes: 35dfaad7188c ("netkit, bpf: Add bpf programmable net device")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/4] netkit: Fix setting mac address in l2 mode
    https://git.kernel.org/bpf/bpf/c/d6fe532b7499
  - [bpf,v2,2/4] netkit: Fix pkt_type override upon netkit pass verdict
    https://git.kernel.org/bpf/bpf/c/3998d184267d
  - [bpf,v2,3/4] selftests/bpf: Add netkit tests for mac address
    https://git.kernel.org/bpf/bpf/c/998ffeb2738e
  - [bpf,v2,4/4] selftests/bpf: Add netkit test for pkt_type
    https://git.kernel.org/bpf/bpf/c/95348e463eab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




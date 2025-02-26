Return-Path: <bpf+bounces-52671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 972A4A4681C
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 18:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A61EE3A8635
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 17:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AE32253E6;
	Wed, 26 Feb 2025 17:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvRpst1V"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F7922424B;
	Wed, 26 Feb 2025 17:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740590997; cv=none; b=NPyQVy88KT7fbgqik62c6cm5nkzKjCHRo7Wa5K1+ZtSZ1oSEDWq2f8f9GSCuhbx9KcVmk7P0KnKYKUd42LYqJYRyM8nnnuwO3tGsOU3BcwYI6go2nljfUscUys5xFMZmGD/QVU3t4gHVzL9DNY+07PDXsKIDVQvmSJrrSD+rzh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740590997; c=relaxed/simple;
	bh=Hj4t0cQEjdORfh1b2i83by0Y4X95j6IlNiRzoavYl9c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N60aBxnOy66AFcGLCGfCZRU/2IWXFLuJeXEhRMA7L2R2GqGJ1FJ5oapO5AWUF+vtou510Qesbv9feIdAs4353FADQ5ZHQyKbY+21Erpz6POnlDGLHu3jYMDp2nGjZSWaU2pGe/tKi86tPmIjp7CoUFjAWexTCtRhRP3Uwn0p6w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvRpst1V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE16C4CEE2;
	Wed, 26 Feb 2025 17:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740590996;
	bh=Hj4t0cQEjdORfh1b2i83by0Y4X95j6IlNiRzoavYl9c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uvRpst1VD84T2EohW5apc6SOrcKLM4XKZnHFE9YiDvTAsPLUGo6v0jW4kp/1ChhKA
	 nT2QtPr8yZKCp+ni+QQQq9xYaB4/82/T/djsPRZmBkovvh5hfnhY/Qs8Tj442oy1yz
	 lNjP/o8uNqYTnnxrrXE206ZMGwxvjlNbOiv0Y9EibluXVEoWuJY9Njk38G0Ud0Y3ar
	 Hi5KWLIEw0g6NEQZyhiDaaseLwqzMGge5odZllMvBo7l81tsKuj9j1F1/hBFR0DzFc
	 QF/BOeUnGEU+CjphIbIb5hkZFvHMzfXQV4LQ11hK0Ds2hMQ6yDlwBuCrwq/+F1M6XD
	 HeqQgS/qp7EMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB04E380CFDF;
	Wed, 26 Feb 2025 17:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v3] ip: link: netkit: Support scrub options
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174059102877.785655.17312250100114507598.git-patchwork-notify@kernel.org>
Date: Wed, 26 Feb 2025 17:30:28 +0000
References: <20250226170615.2237516-1-jordan@jrife.io>
In-Reply-To: <20250226170615.2237516-1-jordan@jrife.io>
To: Jordan Rife <jordan@jrife.io>
Cc: daniel@iogearbox.net, razor@blackwall.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, stephen@networkplumber.org, dsahern@kernel.org

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed, 26 Feb 2025 09:06:13 -0800 you wrote:
> Add "scrub" option to configure IFLA_NETKIT_SCRUB and
> IFLA_NETKIT_PEER_SCRUB when setting up a link. Add "scrub" and
> "peer scrub" to device details as well when printing.
> 
> $ sudo ./ip/ip link add jordan type netkit scrub default peer scrub none
> $ ./ip/ip -details link show jordan
> 43: jordan@nk0: <BROADCAST,MULTICAST,NOARP,M-DOWN> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>     link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
>     netkit mode l3 type primary policy forward peer policy forward scrub default peer scrub none numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 524280 tso_max_segs 65535 gro_max_size 65536 gso_ipv4_max_size 65536 gro_ipv4_max_size 65536
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v3] ip: link: netkit: Support scrub options
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=3eddcf2dfc05

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




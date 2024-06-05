Return-Path: <bpf+bounces-31424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0278FC888
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 12:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA40028363F
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 10:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A47190481;
	Wed,  5 Jun 2024 10:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAAcd3H6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C7618FDDF;
	Wed,  5 Jun 2024 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717581631; cv=none; b=ULHEjva4RNcqTvcuxn3eu3Liss3xQBeRrlZr0nkV9NQrr0Uq2vXrWKV/jM2QGjsd2EIWH2p0thILT9vS0T+cB5Ho8coyN0+jKc+DdzyVCsN2gCiH1yuTUNfT/t+YWX0uSVvlynGwJ4FZEaT03QezKu0O1tBHkOuUyYRQiIn6qhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717581631; c=relaxed/simple;
	bh=V+FMW2fJa+68pVpNJIzkd3aueJVnJyq2tJ1HMpHrUW0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HVTwwYbtMtIKdqITSctJ9+WTf2u0Y7bEQr12WW7O1WPWH+t6WjY4V7MKnqZNWtD6d6rtkWB1VUw1HzkoiKTVwCksMZBADS0wzCxqo5Z0NmXZE8OdFTXD7UpJbMyx+pN4osWTHkj7lsI8QX9RQXDXBuuVjcDV6VCpNIx4REwwZEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAAcd3H6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8EBFCC4AF0A;
	Wed,  5 Jun 2024 10:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717581630;
	bh=V+FMW2fJa+68pVpNJIzkd3aueJVnJyq2tJ1HMpHrUW0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eAAcd3H6m47M0Weu2LNlupm8Jg8BKkPkHN9CyIV4JZ/0+dJMFjuI6ZBvCsClAPjJB
	 /kNm9/jtC8Vx/eLAu3fXtX3Q1g/rnDATBSpELIr45XPQcm024Gwt4nSAScxNQOKloe
	 nstDH9hlrrx9JuzhD4gWQOU/3LyXkMHo+slX11wjTksdTXCXR8i1y+jmQ7/GMJPlX1
	 CNPaWremPNmKgypEGe6AG8uW1TzJUNXLfGecSJAmHbHbCCgjB9SaKmvSFUaL++CGuS
	 aoQ1W7eoEXYdS23MTTSwJmF/qIp7gX3yYTRnE03Hk/kDJThGEp5KnZ0JW8uSA0LUlK
	 KemGf+PLYRs9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 76B0BC4332C;
	Wed,  5 Jun 2024 10:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] vxlan: Fix regression when dropping packets due to
 invalid src addresses
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171758163048.24633.17235199662445713297.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jun 2024 10:00:30 +0000
References: <20240603085926.7918-1-daniel@iogearbox.net>
In-Reply-To: <20240603085926.7918-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, mail@david-bauer.net,
 idosch@nvidia.com, razor@blackwall.org, martin.lau@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  3 Jun 2024 10:59:26 +0200 you wrote:
> Commit f58f45c1e5b9 ("vxlan: drop packets from invalid src-address")
> has recently been added to vxlan mainly in the context of source
> address snooping/learning so that when it is enabled, an entry in the
> FDB is not being created for an invalid address for the corresponding
> tunnel endpoint.
> 
> Before commit f58f45c1e5b9 vxlan was similarly behaving as geneve in
> that it passed through whichever macs were set in the L2 header. It
> turns out that this change in behavior breaks setups, for example,
> Cilium with netkit in L3 mode for Pods as well as tunnel mode has been
> passing before the change in f58f45c1e5b9 for both vxlan and geneve.
> After mentioned change it is only passing for geneve as in case of
> vxlan packets are dropped due to vxlan_set_mac() returning false as
> source and destination macs are zero which for E/W traffic via tunnel
> is totally fine.
> 
> [...]

Here is the summary with links:
  - [v2,net] vxlan: Fix regression when dropping packets due to invalid src addresses
    https://git.kernel.org/netdev/net/c/1cd4bc987abb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <bpf+bounces-49526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC186A198FE
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 20:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF8643ACF67
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 19:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540A02163BC;
	Wed, 22 Jan 2025 19:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izObgMbJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB32A21518C;
	Wed, 22 Jan 2025 19:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737572781; cv=none; b=q59qthiSwe7sL+//5qrlWJ2MK/pr25MEh8trtVDyEf1sm2UfjprGL+kg5cq82OjFslNvRSeA0n9/nx4Cw33HjG1hkMB764CBVYacvweQmUt1zpM0Q35cHO+ZgXYtnPhHXT2/vdzhQ2AE6b6FJ1M51c4chWHiZzZZAVDEfVqNBg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737572781; c=relaxed/simple;
	bh=hhZmQ80KMi2K3r5BhEizbk8P3ylxqjrd/b5kjlu8E1c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pXTh9pgfFevUoiEL0BqTQo/ir+Trott6mt78hWLN1F47c940t/W2AOv1cfh++IGqtNh/kmznFY+vOH/9VdOfgsmulhvUwQV3+15xkMvhw+GyKeBnnUEqd44MkeI935YX/MajKQWWSonuom8yplHa9aktAB014+NTMmu9w7s8mwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izObgMbJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1D3C4CED2;
	Wed, 22 Jan 2025 19:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737572781;
	bh=hhZmQ80KMi2K3r5BhEizbk8P3ylxqjrd/b5kjlu8E1c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=izObgMbJkIMd+a8wiSrSaVZQFk5oFZIGkBW5CfxkjolftuTxu+8tr89vDX2xUwADc
	 2h/9YN1yZKd1d0/g2dlTB2+sjhrP0uIugdNrRSEcPYEwO5eNcjyhNAnOTjadZRyyXi
	 xzEkX3mB5qGbuJ8n0M4Z+X1gEn89C2GYpY17tEsf8HF9SqP7uRpYAlkb32kdnANv6e
	 feqwvU6PEP1b9sAJwJ39Tl9IkkIu+SDwUTzpkzxCMWEncwAtkLDa01oXfFrxlSuhZi
	 34W/qa9hjvtnMbV1aG+3m0gmTPt58QxHeCf/RdYu8kl3tEgpk6agqFMQij9BGAZVPW
	 o9CHolT/sacVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFA9380AA62;
	Wed, 22 Jan 2025 19:06:46 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250121125748.37808-1-pabeni@redhat.com>
References: <20250121125748.37808-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250121125748.37808-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.14
X-PR-Tracked-Commit-Id: cf33d96f50903214226b379b3f10d1f262dae018
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0ad9617c78acbc71373fb341a6f75d4012b01d69
Message-Id: <173757280565.783272.14009973682494742496.pr-tracker-bot@kernel.org>
Date: Wed, 22 Jan 2025 19:06:45 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 21 Jan 2025 13:57:48 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0ad9617c78acbc71373fb341a6f75d4012b01d69

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


Return-Path: <bpf+bounces-70262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC86BB5A3C
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 01:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC2BC4EA5B6
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 23:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185B22C11E4;
	Thu,  2 Oct 2025 23:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhuPB5dM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C992C08D1;
	Thu,  2 Oct 2025 23:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759449098; cv=none; b=MCSySroZDGTEokk+yxnEP7f0rEw8Ach08vBkupmJjKGG2765NLZG6bmT8Q6fdeElAxZq2YOQNMmRCXt/ITFZfq/KbQK6lI4gSjTk5ShMq2YLoTtJnfEYuuZQySa96+R35nqTnbrikMv1I9EBVO68HVaWpD43fhJY8+b1mgFDcRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759449098; c=relaxed/simple;
	bh=agbz1y5G9uuwFk/Z2DZ7stvM+ukx0jV0WZbYDrD8RDk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dK9GWt2DVKjw8Idz0a4ZqZBEXMM5OHNjL/YIvAZzSk++RUZsWIuw/nujW94hYoeHj5JIBCBnYOGCdYhLbGeeQ0HZBh9ZFTC9tYKOzHuD4C33MKm80sI4IsH1Sj1THhIGWB5+T58o48FZTW/JmsLVTJwtoyIQp7RIlQnLsxczkO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhuPB5dM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F3DC4CEFA;
	Thu,  2 Oct 2025 23:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759449098;
	bh=agbz1y5G9uuwFk/Z2DZ7stvM+ukx0jV0WZbYDrD8RDk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HhuPB5dMSWOtFNMv+Ef8ZcqU66crEL/rbf6wgE4cC9HbQB7Sel1pEW45ovugJT7+I
	 V7y7S/vKhIA/eznuZ50OhNGvxBbEiPwukkVJ19oKsCiQ2oYCT8Yj5vKs5JbSsS0aWR
	 /do8FZXG4n5h9M8akS+4kx4/qr69XP6+FJpy+vXjAD6bWQ1SAhpEuFisoKXZ1zCEHg
	 z2fl6JUL4nmME0Pf96TJ7Z068i2QHI2TqNU1pr3mErKXFJCjY6Dhifdbek62FDBGcl
	 A93LbLn9rsOHDGagIUQtItZihWG3gVHUXyfXnnYnAium/l0aAlCaLD+pTLk4eCISUn
	 BrGA6OONSDmCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71FF139D0C1A;
	Thu,  2 Oct 2025 23:51:31 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251001131156.27805-1-pabeni@redhat.com>
References: <20251001131156.27805-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251001131156.27805-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.18
X-PR-Tracked-Commit-Id: f1455695d2d99894b65db233877acac9a0e120b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 07fdad3a93756b872da7b53647715c48d0f4a2d0
Message-Id: <175944909005.3515818.5407831437099985687.pr-tracker-bot@kernel.org>
Date: Thu, 02 Oct 2025 23:51:30 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Wed,  1 Oct 2025 15:11:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/07fdad3a93756b872da7b53647715c48d0f4a2d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


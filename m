Return-Path: <bpf+bounces-19371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 802E382B4C0
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 19:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6371F28EFB
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 18:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C13453E3D;
	Thu, 11 Jan 2024 18:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdY7ZZCa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEEC53816;
	Thu, 11 Jan 2024 18:28:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4084EC433F1;
	Thu, 11 Jan 2024 18:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704997735;
	bh=4aGcqMK/V5dD7XBvdzd9k6jev900k7daZdY5FAr2B7k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GdY7ZZCauGLFZFX0VX9Vg+/26COAWpI5BssIHZXh47T/xdhZ8ivVVOkpU4gXYY2oX
	 xtUIsWk0Os2nqX3B9akQP23ivK2wxS60IcR1q7F4M+pIqNY0SGweeRZGsbW5aPx7bD
	 FoczlfeXkzyLLPRiwvkn8WkEUBhMrjvAVv14+QqFj1ydapVaRD6EUD64r8uV0XORb1
	 dCwK3F8TxO/MQx3Ohhpzx7gKBNrL+HB/H7CqoMn4FqL1BdWOeguDQWMr1M4nYdz4ZD
	 5fd9SxapyY/wAFasG49ID9dyfFd2bacKK3z4tHB1cI8oZtR7IUfYgMGTTbRH3ciftO
	 pCWMOtPcKkzTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2FCBCDFC698;
	Thu, 11 Jan 2024 18:28:55 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240109162323.427562-1-pabeni@redhat.com>
References: <20240109162323.427562-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240109162323.427562-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.8
X-PR-Tracked-Commit-Id: a7fe0881d9b78d402bbd9067dd4503a57c57a1d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3e7aeb78ab01c2c2f0e1f784e5ddec88fcd3d106
Message-Id: <170499773518.335.12508178869407488578.pr-tracker-bot@kernel.org>
Date: Thu, 11 Jan 2024 18:28:55 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Tue,  9 Jan 2024 17:23:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3e7aeb78ab01c2c2f0e1f784e5ddec88fcd3d106

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


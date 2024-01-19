Return-Path: <bpf+bounces-19870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D73832362
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 03:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1989285FE1
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 02:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9358C4C85;
	Fri, 19 Jan 2024 02:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvmD4a/P"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161763D60;
	Fri, 19 Jan 2024 02:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705632008; cv=none; b=Tu550jhx52itJJWbw3+2HBAGKiiOp9/jVs+amd5wAN3UFMotVsqAYBqoIxGbjgq0QaCgJKJ7Q2yfN4ZkBKD8c4SWeJ1cwDv+Be1p7oz2jm2bQbBColSFoYbvYW1Dihbg2n2k0NX7VHBO/FC9B1N5GRiYwq+P8UCi/vy4TP7GPSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705632008; c=relaxed/simple;
	bh=gNk8EjuPwE6pWzdQFnXNNSZWVdsly5YNUbDjzAa5LVQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ogvydpQ6c+iHHzhDNqhk+8Q9+PiOWesC5C8WKFVfVmDhq1gA6qNzgSUKlgcEnC9zUB+yF66/EYcABDnTQMggoxgZTWUZrRPVy906hHqJFnFswHzdz3oUMej9MLE/AMRVAn/N+II93Y7sxvTYZ/lluE9Rna+boKP9jIPODlM5Xz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvmD4a/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D997CC433C7;
	Fri, 19 Jan 2024 02:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705632007;
	bh=gNk8EjuPwE6pWzdQFnXNNSZWVdsly5YNUbDjzAa5LVQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uvmD4a/P6XvTFzQ00IVpQgzy96klxpu1i01U5OqLIxnS3YYNeUdy2u7NzAwQtEc/b
	 shIq/+LndPxN/vLwN8GKXD/p7w2Y7X4J7zP+upZRoxT78blsAmtYFCIl7+mHvcCAuu
	 gBiM9TgcQHNnREeuj9puJ+kllsgmU94E96AJgfarDy9HsA8LoJYYDOIGvw59GOY+J0
	 dlE4xZ4kF2cNqhKlK1hQh91DYQ83ccjraNZEbWYtTCm5XmhnilRA8Gbi7vKbdQgCN4
	 uV+SX0zy/G2lzqUHk2ei4FXw049DzHSwSvsYyRMf8QMIbnxghDv6hxPdSJeTdXkE2S
	 z5Q1BbPanvScQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AADF8D8C987;
	Fri, 19 Jan 2024 02:40:07 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240118220116.2146136-1-kuba@kernel.org>
References: <20240118220116.2146136-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240118220116.2146136-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.8-rc1
X-PR-Tracked-Commit-Id: 925781a471d8156011e8f8c1baf61bbe020dac55
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 736b5545d39ca59d4332a60e56cc8a1a5e264a8e
Message-Id: <170563200766.16016.9453278464087717812.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jan 2024 02:40:07 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com, bpf@vger.kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Jan 2024 14:01:16 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/736b5545d39ca59d4332a60e56cc8a1a5e264a8e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


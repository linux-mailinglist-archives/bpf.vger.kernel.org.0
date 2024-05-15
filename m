Return-Path: <bpf+bounces-29722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8C28C5F71
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 05:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE016B2285C
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 03:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88BF383AC;
	Wed, 15 May 2024 03:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AiN3loh4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BCB38385;
	Wed, 15 May 2024 03:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715744408; cv=none; b=p2XW0wGthwwGGLH/KbQqSj5aVK1Autu7lIeQXXKrRIfgvL68oc3JsbVmMkXNidp5AHqFY5ADlBqCFuZAGP9Jm12SNqjo0w+0bsp97w6878AWJxA4dPDlkcvbX5LuTNlYPWBneoc0ddP5eYZIIcV+tsy2u2x/Wu5xPdUCxChtYb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715744408; c=relaxed/simple;
	bh=eRyinLyBO5VmS12XuvHIK9YTDcTFmjkmDfNekCkbe+E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MRL+i0CH7LDBR+8u9DdlG7oPRAReyYO6nKOIuk3ZG7sQEzN1l3h8Uy+bfoEbAfuzZ7g4m9h0vjcp3qw5zM8ozYZkSMvEBVqcLR6V+j7XEhaWS7aen1ipMrLHPvnYn+P58PVseKMvRDNDdVeIXJd+YvwrrL68VGI0HwW8aucB3EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AiN3loh4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C17EC2BD11;
	Wed, 15 May 2024 03:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715744408;
	bh=eRyinLyBO5VmS12XuvHIK9YTDcTFmjkmDfNekCkbe+E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AiN3loh4iMCpyP0FEsn0rxnZKIz8mwdNGf9q+mxohg6sNiKyNnTjfUqvN5GyB/bYH
	 DcM6mM5Fjwazl3qf72VIJFdxpw1Lqi3jQ11lorntvGBgXqwqTbykEZEvvA5RoRieD2
	 8050Spr1KRV6ug/HBNlZb8fMcIRzQL993iUIfPaSo8W+N74D+wvwP+MwG2lxIRhp7r
	 owuITocRB9e2Wyt08eg0JdeaDvu+RLDsjfjMrmb/nGeA652nSRDhHV5zy4KNk1gs1A
	 sehg9eKAf1Ok/qT0v3jEazQWlePD0QDRT9yXrJ1RqtPjpWtrBTCLJhgvYVJgPpP0pw
	 aKJ4xFqKW7bHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33999C00446;
	Wed, 15 May 2024 03:40:08 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240514231155.1004295-1-kuba@kernel.org>
References: <20240514231155.1004295-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240514231155.1004295-1-kuba@kernel.org>
X-PR-Tracked-Remote: https://lore.kernel.org/all/20240506112810.02ae6c17@canb.auug.org.au/ net/core/page_pool.c
X-PR-Tracked-Commit-Id: 654de42f3fc6edc29d743c1dbcd1424f7793f63d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b294a1f35616977caddaddf3e9d28e576a1adbc
Message-Id: <171574440818.1524.7000388870113013915.pr-tracker-bot@kernel.org>
Date: Wed, 15 May 2024 03:40:08 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com, bpf@vger.kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 14 May 2024 16:11:55 -0700:

> https://lore.kernel.org/all/20240506112810.02ae6c17@canb.auug.org.au/ net/core/page_pool.c

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b294a1f35616977caddaddf3e9d28e576a1adbc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


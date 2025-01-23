Return-Path: <bpf+bounces-49577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CDBA1A7B8
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 17:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA6D83AB112
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 16:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13A2212D94;
	Thu, 23 Jan 2025 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCk0ELXo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55223211A01;
	Thu, 23 Jan 2025 16:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737649211; cv=none; b=tTFz+chQ/bXYbuWi2zPgAewG7EPCDhjnPsLQvi1esuMIzbtT/YNaG2vkWqFIH+8xbgpUNXas2JVbkqIRuXwrh6QFZtOCvf93JPnT6rWyDG/qOaq7IkONB2+SNJiKjln8LPv/6GDilhEuQaNHHt2kh7r5vOyIbDJqFEcu/UTgGf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737649211; c=relaxed/simple;
	bh=lXjObilW38zTMWV9g6LZTxDQvHihLR5kuK8qU7Yrm6o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gn8ngmAIDEqTV4cqg+TRSuLKm34DJLGHEfIwdA4dRSkJJ1CTzcr6L4xD3H8VhPQ318ok3QmwTyZ4rPyc6elcbrZ8aaFEczY40AbWbae2RkmPfZoocOvFNKiulY3PFNj+HOc5yPgrmaPdIYdh8z6nFES74IpqL3eeiONT98Cuq18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCk0ELXo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2378C4CEDD;
	Thu, 23 Jan 2025 16:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737649210;
	bh=lXjObilW38zTMWV9g6LZTxDQvHihLR5kuK8qU7Yrm6o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bCk0ELXoz9ylLPDLlOoxR/kmkCFPbM83S5Q2TYHXt+HZyVYJy8kv6cps06U1R306a
	 c9mAYKoqWaBTfAALpoIz9uFYoTOm8qfBoquRj5YW4tjgzVrh+/0lKfiDXwoMcORAAL
	 Vdlv8/0aELgyUqJQrSuKnQHpqzPRVDrhI0TwhR2SKDzXzxtE2VukuoQw5xihUj/Dc5
	 6mxbNgLEnMMLTOvnJo1vVQGqnabpLHI+8URx4eJkLw1J8GTp0EmWaUXncmNwtTr3Y8
	 ui/ZwxAOIx0EroCGZduwnmRGwCDjzxx/Cjjtt7TBu3iy2H2fAJUKPN6KDZUOXDa+jL
	 ztxwQM2vU1Zkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9E96B380AA7A;
	Thu, 23 Jan 2025 16:20:36 +0000 (UTC)
Subject: Re: [GIT PULL] BPF changes for v6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250121003755.71163-1-alexei.starovoitov@gmail.com>
References: <20250121003755.71163-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250121003755.71163-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-6.14
X-PR-Tracked-Commit-Id: 3f3c2f0cf669ff28b995b3d6b820ab870c2aa9d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d0d106a2bd21499901299160744e5fe9f4c83ddb
Message-Id: <173764923540.1408734.8208133174193516411.pr-tracker-bot@kernel.org>
Date: Thu, 23 Jan 2025 16:20:35 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 20 Jan 2025 16:37:55 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-6.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d0d106a2bd21499901299160744e5fe9f4c83ddb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


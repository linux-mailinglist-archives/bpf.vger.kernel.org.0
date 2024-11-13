Return-Path: <bpf+bounces-44779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BFF9C7A40
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 18:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6631B3196D
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 17:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9252022ED;
	Wed, 13 Nov 2024 17:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cm91Zimk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197BE1632FD;
	Wed, 13 Nov 2024 17:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731518344; cv=none; b=pUZpDa4NjF7QUcJUorV/Fx1mc0fuBcNwiciLXnk2g4EBjmOTVAFmigtSVTh1guZasukCivT1vIGJUHm1PBi9sFXwzAC348uQcj5ibErUpSf3fs9NworEZsZ0GUCWaqfKAP2dLBP+gc4Sb5IzZZWUId0lXtNt4ntwC/jYLBCL71A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731518344; c=relaxed/simple;
	bh=eTYbVJIlt9pjDfQQC/rqZPZIrsQ0kAelz2j0zUwZgs8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QEaNFffurws/m2yfUoCJ839F99gIVJnnQFqj71BN5fn9HydCjnDiam6zwy2Q/XpGeTo+tcnWVIoB9PEWC1UNQw/6kEefzl0Tn2PJB4I9GlCmrezFqG3MkrZpMShiUrtkSfCC8OP1atlgueBwLANo6puD8OvId3PZB9Sbo57qE68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cm91Zimk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD01C4CEED;
	Wed, 13 Nov 2024 17:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731518343;
	bh=eTYbVJIlt9pjDfQQC/rqZPZIrsQ0kAelz2j0zUwZgs8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Cm91ZimkU6i/o90xLDL4T5a8HUs7va+wIwNovkw59iFTOSge72pvLLGrXkYHpmqxZ
	 bapVuUrSVlE2X/gcWc4E2rW84v/zPBmjUB6VDBi9pvh44UheSRFjW1IqHdcUOMibs1
	 jqr3ihFbaEeOA5jVsoZ1R7Zz1Wkfnys+5fZXSK+tAgKj6ZQZWEK+10IiAzRrrI9FcA
	 B5jgTH6mF3cmOPCZ9ivz6gkI4vPjfdHnwrg9AN3bBZdUmdTwfHleCsVF/f1VoKZeQH
	 k0bFPVQKHExolieM7H0EsZyVuhAtW981EKBdNNd0qUZPnRdWdxu5eQZwRco66fWRJI
	 4eMvbf48OIViA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CD63809A80;
	Wed, 13 Nov 2024 17:19:15 +0000 (UTC)
Subject: Re: [GIT PULL] bpf for v6.12-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241113030640.24492-1-daniel@iogearbox.net>
References: <20241113030640.24492-1-daniel@iogearbox.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241113030640.24492-1-daniel@iogearbox.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: fb86c42a2a5d44e849ddfbc98b8d2f4f40d36ee3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9f8e716d46c68112484a23d1742d9ec725e082fc
Message-Id: <173151835375.1293865.15470561655588494554.pr-tracker-bot@kernel.org>
Date: Wed, 13 Nov 2024 17:19:13 +0000
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 13 Nov 2024 04:06:40 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9f8e716d46c68112484a23d1742d9ec725e082fc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


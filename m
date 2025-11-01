Return-Path: <bpf+bounces-73221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CD7C275A8
	for <lists+bpf@lfdr.de>; Sat, 01 Nov 2025 02:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CBEA3BA57E
	for <lists+bpf@lfdr.de>; Sat,  1 Nov 2025 01:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D1F1F874C;
	Sat,  1 Nov 2025 01:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsEUczBZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1847224F3
	for <bpf@vger.kernel.org>; Sat,  1 Nov 2025 01:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761961689; cv=none; b=reCeYIGcdiT1HsifCfA4h0INDuKkbMGUDL1IOq4HNofgwjBhGD/ltq0+W1m7QIk8momEB5kmB3URofALlQNPMxLIj4AnSFKYqQ7ZPxglIMqlEH2xFHCAOR9JAfN9GFOha4KOrvKt5DgFiJLqzSmFSHerA5C4SjN8kHcB3p8XOFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761961689; c=relaxed/simple;
	bh=DE+Dh6AFcRMxxJGhvHg8AEBq99X+gsvQUQOrWgyF7Qc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=g0OTzmgO7uQLJ3fOtZWYX75MmvQDBzbo1C5MEuETc0lYEL/8xnKZudt93dsCZmoe0e25wsJGFXjYjZukORu4WB0rVxrF8wqlJVMPrzIEXTAugOwUHlel+fklQqKFFchbqBCCzYFDbfut6diitBR98JEStsSjI/H2oFxB1SnOguY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsEUczBZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450C4C4CEE7;
	Sat,  1 Nov 2025 01:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761961689;
	bh=DE+Dh6AFcRMxxJGhvHg8AEBq99X+gsvQUQOrWgyF7Qc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GsEUczBZ/yfM33oB/SqlZlT/UVQt+ras4SwMnfehUtPzj7Stq9nEJrxvWoOrcgv7C
	 Q55ypAqMjXrZBIkHA1AF3xrZE7dVa7L1iahy8Su/9rensa3vWq1RwTkiRZI+0meQOK
	 hz4DXCa4II9yFaWwp7gd/a3o0CAbw0CLfmkEEG7Q72NGzc1tEzbWmbvRV/39yeMAAL
	 5nxi8nVZcyLe0/+gt29ZuRoxxIA0o0a89ALzRoUcMybxKyT3dWsXLlqmH3ciw24lUa
	 FdvA6QMqw92WbBTn8IRyJiOPmB+bgNwsaSKMeRXUP6gFtB9ILr6uaezVzhQXn65IOT
	 TlzXL94RZLjYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 711493809A00;
	Sat,  1 Nov 2025 01:47:46 +0000 (UTC)
Subject: Re: [GIT PULL] BPF fixes for 6.18-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251101004014.80682-1-alexei.starovoitov@gmail.com>
References: <20251101004014.80682-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251101004014.80682-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: be708ed300e1ebd32978b4092b909f0d9be0958f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ba36dd5ee6fd4643ebbf6ee6eefcecf0b07e35c7
Message-Id: <176196166497.690622.687239242310740333.pr-tracker-bot@kernel.org>
Date: Sat, 01 Nov 2025 01:47:44 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 31 Oct 2025 17:40:14 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ba36dd5ee6fd4643ebbf6ee6eefcecf0b07e35c7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


Return-Path: <bpf+bounces-76650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65872CC0627
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 01:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEB4F3029B8D
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 00:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D75269CE1;
	Tue, 16 Dec 2025 00:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZff/+3l"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578A92248B8;
	Tue, 16 Dec 2025 00:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765846434; cv=none; b=q8/Mm7GDbXzjAkRTVflLAZ8WRv2Snc18xLZh0FIviS8flrNG/MukvpyZhmUZqAuh+c7BP8nnSKBdnIMutKl39fxugqXYpgwSELb2LH3faUEJvFsHwDGlK9adkocgQrnq7NYblARkxyWF6h6pgwpCb0cxmU5LcERBPeV54tEygMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765846434; c=relaxed/simple;
	bh=KVybdq2V+565NkdvIZa4ZXWTv3pqp1aoH6+zdj49hO8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bf8mRoQ7zsQjtb0IfCgHW+HyQBGnAkjRbgikNHRGtyDQEoXRXFcwuJM6G4GHmqlSAVWYnOtryD/TsjD07UQ7yU0BXe8HW39Y78PgiOD41jvU731Q1jojwTFQ0Oj49i95WNRiacsqKteoSeF2ieOZ0KLac/+xoXjdRA/3N0W66n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZff/+3l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73A2C4CEF5;
	Tue, 16 Dec 2025 00:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765846434;
	bh=KVybdq2V+565NkdvIZa4ZXWTv3pqp1aoH6+zdj49hO8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gZff/+3lrh30ypg/VcLwZ8dRm0LNcxTDJ/Mx1GXevfJSAU6NFwEpZdQTp2J6ONVPd
	 +AdQwfUX76x71Y4SSX4BrmlVOasK87yGpCFZvB1HBuGm/PeH/V5Btry53nccgykKoy
	 cKJIgtKxyNg36L/XJwFtJVik0BkDLCKZZsThmyoAh69+GI3eGTSaNGgT4AHRavSmvs
	 e1OsiNZlUvbzr8wq30dL8qzKmfmUNRbLCypjy/Au26sc+kebX+Vx41y8he60N8SSKU
	 WSgGgtuAnEq0r69RkNJjQF2xDDdsmEzO9kJeBl5zFdG0TBSXZiEjaJMFdUgIjABEwy
	 snfQFZiawb5Hw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B6D0380AAFA;
	Tue, 16 Dec 2025 00:50:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH V3 0/6] block: ignore __blkdev_issue_discard()
 ret value
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <176584624503.387072.9496719293644511831.git-patchwork-notify@kernel.org>
Date: Tue, 16 Dec 2025 00:50:45 +0000
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
In-Reply-To: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
 song@kernel.org, yukuai@fnnas.com, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, jaegeuk@kernel.org, chao@kernel.org, cem@kernel.org,
 dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 bpf@vger.kernel.org, linux-xfs@vger.kernel.org

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Mikulas Patocka <mpatocka@redhat.com>:

On Mon, 24 Nov 2025 15:48:00 -0800 you wrote:
> Hi,
> 
> __blkdev_issue_discard() only returns value 0, that makes post call
> error checking code dead. This patch series revmoes this dead code at
> all the call sites and adjust the callers.
> 
> Please note that it doesn't change the return type of the function from
> int to void in this series, it will be done once this series gets merged
> smoothly.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,V3,1/6] block: ignore discard return value
    (no matching commit)
  - [f2fs-dev,V3,2/6] md: ignore discard return value
    (no matching commit)
  - [f2fs-dev,V3,3/6] dm: ignore discard return value
    https://git.kernel.org/jaegeuk/f2fs/c/f4412c7d5a5a
  - [f2fs-dev,V3,4/6] nvmet: ignore discard return value
    (no matching commit)
  - [f2fs-dev,V3,5/6] f2fs: ignore discard return value
    (no matching commit)
  - [f2fs-dev,V3,6/6] xfs: ignore discard return value
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




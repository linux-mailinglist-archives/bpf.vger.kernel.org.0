Return-Path: <bpf+bounces-76376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5EDCB0B80
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 18:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB2C231111A2
	for <lists+bpf@lfdr.de>; Tue,  9 Dec 2025 17:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A237832E735;
	Tue,  9 Dec 2025 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuUNgvto"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CAF32E69C;
	Tue,  9 Dec 2025 17:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765300913; cv=none; b=GaTcqqYlYJI+4LPZGEwJgX0IAsTxVi6l+/7QxlSBNSPOavj+CZ2wixcOLRqXab2mNjHETEyBXbsluEiq5O3yd81fX5KQdbHGx2ZUfKlJ7j2COfVaZ7bT9MkVBdz0nbdHLZQ+JpV5unXTbMR+mJPQgMt4HN6qhsTiT1sNM/aRhCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765300913; c=relaxed/simple;
	bh=4D7MGFxeRJTDY1I7TVqNGOxjKxHrYX8Xu/NQUp33yQY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Oe4fkSenS4PIzKTSb2Gkz1cRIqcRZpIGr77TjfmkYn1924SCgyHmutcejW8t3mFhUt+d0uSmocf1npBiZOzF0ucSUcgDG8qqt78bDHLLpNuciVMv3j9F2R1hn0oh/oeMPotPuFqXKkQzPemtpLBXwHCty9YSiSBS4AjJHlzSIY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuUNgvto; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2988C4CEF5;
	Tue,  9 Dec 2025 17:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765300912;
	bh=4D7MGFxeRJTDY1I7TVqNGOxjKxHrYX8Xu/NQUp33yQY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZuUNgvto237oQlEXMdNAwfCle3hrlKfTdWltwxprsJTDwDSOdfrCe6Lc0w70aYteg
	 USDyX2OxNMDGgtWaUvicOUoeIciT2t7tAOw3WDlhOMzTKJeRy4m0i+RWtaUBFa7E/C
	 Fh64065DCj12G8NmPeComkTbsyqVXopIMgdcUxuhBpB7h2CHxjNtePOG2zHBH1ffFn
	 jYf9fNs4YEVS13NGMzinskDsNMCoWsCgmTtfmDYOQcD1Rw43ZeZ7C07/EiBlJbd9QX
	 ILeieRrStbLL0RC69ydyLES/kPMYSQcagtEyRshqmJjUXuvmVrcEofuvPcdhc/bh6r
	 wr318dPlMkLHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2AFB3808200;
	Tue,  9 Dec 2025 17:18:48 +0000 (UTC)
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
 <176530072781.4018985.3920629164173659180.git-patchwork-notify@kernel.org>
Date: Tue, 09 Dec 2025 17:18:47 +0000
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
by Jens Axboe <axboe@kernel.dk>:

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
    https://git.kernel.org/jaegeuk/f2fs/c/7d09a8e25121
  - [f2fs-dev,V3,2/6] md: ignore discard return value
    (no matching commit)
  - [f2fs-dev,V3,3/6] dm: ignore discard return value
    (no matching commit)
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




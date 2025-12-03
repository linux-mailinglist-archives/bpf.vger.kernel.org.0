Return-Path: <bpf+bounces-75992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A400ECA1C06
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 23:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62CA230A5EBD
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 21:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77989313292;
	Wed,  3 Dec 2025 21:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeYW0Uky"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB7B3090E6;
	Wed,  3 Dec 2025 21:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764798787; cv=none; b=gZmZnc66W/8T9C+BdjpoyFtxnOMIC3D59RY6WQ5xq/wTDbu79AP4erpuwI+ruasLvskOlGqCuXaMwDXfqaMUFSiq9JCiSkkhhuT7w7z4lQ5YAebL6fIcwG5cDytV1YazKKuTZn37AY0EQiD3nGwR13mL1MyXf9HFPBQy32PyhqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764798787; c=relaxed/simple;
	bh=FFk0BICWZ0s9eg+EWRAL/A8moz5Z/8tPM+4OoOw4t0c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kUvLlrTraxXpam27xiz3Cb1Lr8lLFaoOeLVL6//1DUPhfxm6fL3D8qrksDPD5XYFjHdWUcOzBUQd/ExOpaJpzFIl7JsnCWiHyWUm/oSp7bAylD/sIFaE5qgoO72OtakvREdqjZt1ZrqmpHBwlCJwZLcLT8/iTzLq0H9Gx2LRqdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeYW0Uky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABF8C4CEF5;
	Wed,  3 Dec 2025 21:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764798786;
	bh=FFk0BICWZ0s9eg+EWRAL/A8moz5Z/8tPM+4OoOw4t0c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VeYW0UkyuCwbiBS6GRQIS4qLICBiVyT5vCPL9NSbIU2AsyhMfKJ0O6UOsBhbWt6Gy
	 t7OG96Mx+yOrltCQyVBwsFqX+YaPUVrJ+vWUeSd+WVBPXhyAB9Hggez6ODy6dFYYui
	 ZpaMIqHYB5Eiv2d9dM4l3tiqJxDj5tDxZNo23QAaoGlwyhvON5tTsqIKBIM+SYJAbL
	 WpzHUkIUck112Sr4cYs5KtgpwZcOFe8HykPGjTzRMFJWOF8SMIVxOrnf6S6gAUF/L0
	 53SEym27LIuvDbTfdtDbyEw2FZA2ECa7B7byH54yqXJ5EbCTxX5aWDGUhcWEpmAOnq
	 yvG5vq/6EsOOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B59AA3AA9A81;
	Wed,  3 Dec 2025 21:50:06 +0000 (UTC)
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
 <176479860568.93351.11152980224844433705.git-patchwork-notify@kernel.org>
Date: Wed, 03 Dec 2025 21:50:05 +0000
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
by Jaegeuk Kim <jaegeuk@kernel.org>:

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
    (no matching commit)
  - [f2fs-dev,V3,4/6] nvmet: ignore discard return value
    (no matching commit)
  - [f2fs-dev,V3,5/6] f2fs: ignore discard return value
    https://git.kernel.org/jaegeuk/f2fs/c/807e755c468a
  - [f2fs-dev,V3,6/6] xfs: ignore discard return value
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




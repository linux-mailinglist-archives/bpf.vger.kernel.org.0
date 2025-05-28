Return-Path: <bpf+bounces-59215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7C9AC7451
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 01:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D383D7B262D
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 23:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A76221FCD;
	Wed, 28 May 2025 23:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFTwx0Pt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36A0207A20;
	Wed, 28 May 2025 23:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748473859; cv=none; b=S/eHzTzH1A9pcBiUE4WluPfY5krtejvaDj3Mo5LBT2nvMk9Kn7qF7dlzT8Lvuq+PTj5viOK3z1xaebpdOV98IPA0qKPfxH2DYPvsDIT+ZbpYRtg8E0aKcEAOGNNxgf2J1t19/IO028b9KMq4gpOD2s1epQjGsYafvt9rXdf5Cqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748473859; c=relaxed/simple;
	bh=rD9viY/DG0/Xhfu3NnGSB8z+CLOAFynyY56DwZAum+o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EdUuRwKdPC1cZuo3SASrcHIuV2fy+J3HyvXUjvarhNMTYL9qwEGsx/jZ2AV4lbNoGno9BQI2VM/6IXkpxB6Z/jffXNbXKsVXlAWMYa9M4GCQ1dPMr8pHC/PugO3t5FZhmQMYoggvpcxWV5AskLqwR0+IixY+M1k/Q8nCmkr+13Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFTwx0Pt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44763C4CEE7;
	Wed, 28 May 2025 23:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748473859;
	bh=rD9viY/DG0/Xhfu3NnGSB8z+CLOAFynyY56DwZAum+o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LFTwx0Pt4YOIMqbIita26pSLAi7QIm45hnmCJVZmgQt9c2wKs15H/hSDRN9ZDdB7y
	 FvbFKX5QyeCS7O6zBK+pdJ9pZnyIKEdW1UbweXFCnA/n+loYBeARIBj7WKyYVnc87X
	 1rWi/srsOkKkweX9depAtcnxL397XPhqFXw/scteI32eXl/nyN7ZGLgx+exMZzCRaC
	 Gqqvd3B6CDUibDfs68lfx9QdKM8AK6k6wl42bT48jB2M2c1ogX1vipRtDzemwKPtJ4
	 ZUSRDO/Pjgi4KAPYSXhfqCvX+XoJgjfgxdk8vT1yjliGiUTMhXYwVfuLa4nWV2OX2W
	 m3NDykzbUr6wQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71C5D3822D1A;
	Wed, 28 May 2025 23:11:34 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250528135941.50128-1-pabeni@redhat.com>
References: <20250528135941.50128-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250528135941.50128-1-pabeni@redhat.com>
X-PR-Tracked-Remote: https://lore.kernel.org/linux-next/20250507124900.4dad50d4@canb.auug.org.au/ net/unix/af_unix.c
X-PR-Tracked-Commit-Id: f6bd8faeb113c8ab783466bc5bc1a5442ae85176
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b98f357dadd6ea613a435fbaef1a5dd7b35fd21
Message-Id: <174847389332.2659935.14730504771528218357.pr-tracker-bot@kernel.org>
Date: Wed, 28 May 2025 23:11:33 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 28 May 2025 15:59:41 +0200:

> https://lore.kernel.org/linux-next/20250507124900.4dad50d4@canb.auug.org.au/ net/unix/af_unix.c

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b98f357dadd6ea613a435fbaef1a5dd7b35fd21

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


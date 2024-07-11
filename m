Return-Path: <bpf+bounces-34522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4ED692E25F
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 10:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5B211C2191C
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 08:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042D115ADA0;
	Thu, 11 Jul 2024 08:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxmkJYMB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E33E15AAC8
	for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 08:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686655; cv=none; b=FZUU8hY7tP6Lue02MKim0oS4pYvQeWj1cPtbfaxaVPKenBZCmxjwCX9Fp//qObLXU7xIp7rfgvVdF4AW/en1TFArzFJx858eM2fjEajFvqYor1+vV1cDWN7t+jmdWG/fYINKRLfko89xSirLox/CM+MsZ3vEDcZEzLy+JfIlcNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686655; c=relaxed/simple;
	bh=KlkfNv2oTQvJLiUw0YmuSJ0y0w3OhEf3xMYXrZ0muL0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lcbqIXV1mYT62RtRp2yZvPA2wjw2Y6jrH3DYR3v62LxH9lO/Gzdq/lIBDfbiYL/oHC7NxbWHs/VLg2QLV279S4RjMHAw6H7qwhsEKkzUA1EzMbanZb8S84ynTJS4olyDQ5Igp81PTvl6N0ZQOC/w4XCJgaW9fugQfna09CQj8UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxmkJYMB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E028AC4AF07;
	Thu, 11 Jul 2024 08:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720686655;
	bh=KlkfNv2oTQvJLiUw0YmuSJ0y0w3OhEf3xMYXrZ0muL0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JxmkJYMB/e55FEShdrz/SLh+1vEOCwJliWWhg4dI3m553MGKxYZRq4xaEB9Q8PUuE
	 Z+uHuEQp7RRpCsC741OvjdYgyqs281lYVk7y5f0XFFAdV0wuX/OTa2hZXLWhLBliOr
	 In8d4N0G3eq2amDhaULKaKhUS+ndzEx0VS8qHTBHKRAnp/ZyKITrggN6Kh2JUb5EIZ
	 7MaV8f/8LYBsIG4+hgh267vkoBmPlCtpjIyJCASWnIY6u4JL8+87QjyFAISbbVuDmW
	 /vxPszCADuYYbHoFChLpO19g0pQEYyln0KHB47h4lcRO+fgHt+FKc9PO7qlT4ZOZkN
	 knjRyABuUtYEg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0110DAE95C;
	Thu, 11 Jul 2024 08:30:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] selftests/bpf: Add timer lockup selftest
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172068665484.28697.1248288880571248017.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jul 2024 08:30:54 +0000
References: <20240711052709.2148616-1-memxor@gmail.com>
In-Reply-To: <20240711052709.2148616-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, dohyunkim@google.com,
 neelnatu@google.com, brho@google.com, htejun@gmail.com, void@manifault.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 11 Jul 2024 05:27:09 +0000 you wrote:
> Add a selftest that tries to trigger a situation where two timer
> callbacks are attempting to cancel each other's timer. By running them
> continuously, we hit a condition where both run in parallel and cancel
> each other. Without the fix in the previous patch, this would cause a
> lockup as hrtimer_cancel on either side will wait for forward progress
> from the callback.
> 
> [...]

Here is the summary with links:
  - [bpf,v2] selftests/bpf: Add timer lockup selftest
    https://git.kernel.org/bpf/bpf/c/50bd5a0c658d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




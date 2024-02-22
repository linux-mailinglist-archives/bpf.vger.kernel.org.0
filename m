Return-Path: <bpf+bounces-22512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6AE85FECA
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 18:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A03A2B27815
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 17:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E302154BEC;
	Thu, 22 Feb 2024 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVz6ED8x"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35251E488
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621828; cv=none; b=GAuJidgSDcy7OJpvO/YgutJIOIU4fs52GTJbdkFxqP/xaJvMFrJfHYL259tTydDbU9N7akQQtO2qzjqSWrgGKcGJ9IcdJ4Vxh/LrrgDBn2TaLz7gEv1OOjO5y+SMk1PUdghPj1BbpnbL+XlkCTa4tC4+DS2z9mcZ0TgNhQJTPB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621828; c=relaxed/simple;
	bh=J1WBwVuToE+BEDKLKvJTqvzjIXci7zrlc4Gs8wbwExc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PNU3iE3KUjqHg7IXojRREH+/671If8ZnHqWVM4KEhyakO0MyVrHv31C/E85RqG9xmd81oSifA1ywDtX0iIXzEG/N78riyYGMe+UuOFX+PGWvYF4l9hCwk6MBBGgf/NWCvHsGTk/mO+Gyy9rgWeRDyZXnWqMVbGBCBnwSGXAL7r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVz6ED8x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C078BC433C7;
	Thu, 22 Feb 2024 17:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708621827;
	bh=J1WBwVuToE+BEDKLKvJTqvzjIXci7zrlc4Gs8wbwExc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QVz6ED8xioix/VDYmJgxBTS3l3bEY1bF6NDcOU4p5HPUgP8PFcMeHo/tVyxjNlFgO
	 d0Ea7mW0M9L6u1FgvLQqG1slZob+0sB3Zh/Cr2Vq61JV+eYDexBwN7POj6JCk8Cg8K
	 Dvg/k41/b5f+zM/NkDpU/SHpCKnsHA8bFZ3nfFgiCCqyeOa0JcGmwwVLNyHsirmZRG
	 CpZztSyDVVIDxOdkVvuikcAe7nNOrn0inDdFWQvjYWqOQsID7Z85CfFntTvBr2sYTT
	 VN0hmWnfwey2YXecV0Lt6pQIwxdD89k0nPNyS9fTMdzMIZvx8G1nulZmPLV8y2KGEI
	 tKviqRg3AOBgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF3DFD84BBB;
	Thu, 22 Feb 2024 17:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3 0/2] check bpf_func_state->callback_depth when pruning
 states
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170862182771.10220.3181097083078946216.git-patchwork-notify@kernel.org>
Date: Thu, 22 Feb 2024 17:10:27 +0000
References: <20240222154121.6991-1-eddyz87@gmail.com>
In-Reply-To: <20240222154121.6991-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, kuniyu@amazon.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 22 Feb 2024 17:41:19 +0200 you wrote:
> This patch-set fixes bug in states pruning logic hit in mailing list
> discussion [0]. The details of the fix are in patch #1.
> 
> The main idea for the fix belongs to Yonghong Song,
> mine contribution is merely in review and test cases.
> 
> There are some changes in verification performance:
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/2] bpf: check bpf_func_state->callback_depth when pruning states
    https://git.kernel.org/bpf/bpf/c/f31f0fe3d738
  - [bpf,v3,2/2] selftests/bpf: test case for callback_depth states pruning logic
    https://git.kernel.org/bpf/bpf/c/2861d07c5289

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




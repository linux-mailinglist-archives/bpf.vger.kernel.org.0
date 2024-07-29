Return-Path: <bpf+bounces-35948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE24F940009
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 23:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEDF91C22285
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 21:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB1918D4A2;
	Mon, 29 Jul 2024 21:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGMrxDG6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A4218A950;
	Mon, 29 Jul 2024 21:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722287156; cv=none; b=sxLEX0tmb6iZU6ivnd8kddqvlD0EIPGpRObh766uzfpfV8kRBr05qTUIu9vYjcIf4WbjAYNVM69uhBHCylN91zJo1+JpOX7pXf7O2Squo+2zxFSNQZ/YnQZhTuaROMGYNytgG+dOlNtWUbkOGf5TpDp/XVSqqikeXQ0IK2UIgds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722287156; c=relaxed/simple;
	bh=9KEBf1gMgWnuUI+aXq5hB2A7zmN4iS47InfwOB9EUrY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F457GUBjMXyE373eFuUajjGu0dm5/KCSQgn1rDymdq+h3elHvx5HolvVjCzhHScHdz2X+3NvwckmIFDRQ3+GlMLoRqSFP7C9L7jVu7MOFxxsBoJexDxpTyefH9bCJ/s4ZdEfN9ob0zCK56X4+O/lXvd3dh86iyMW+5Jgqgijt1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGMrxDG6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17EA0C4AF07;
	Mon, 29 Jul 2024 21:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722287156;
	bh=9KEBf1gMgWnuUI+aXq5hB2A7zmN4iS47InfwOB9EUrY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RGMrxDG67YuT36Zba3lj6NHWDKx2+XbbUePB2+6LZNKOXQPsTF2Ik/C8Ow1vTeErM
	 ovACDoOuu7K6TOZ3xt3okhRo+oF3RyQonASJWS2DkWSgD70nt2bvRWp9el4aKZxGIL
	 cFmzmGACdv9acwl94PttsR9b4KrbkpVMHpeZQC2gWyI0fE1fPtoU64UyoV4q21Haer
	 2/Dh3dj7tyKLnbtyNPECBf/xI/hb4x/mJNQboKyfsfxA70n2ZAB5qYi/8rW9aSM/N+
	 QXY/qnxmLW9JRr+4hWkSoP/n9K5wxZFzYaYwhJL3cMRCKNZUUyyK4kiGLqNL0L5pc4
	 kXbz5iGcN/mvg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0936C43338;
	Mon, 29 Jul 2024 21:05:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] selftests/bpf: Filter out _GNU_SOURCE when compiling
 test_cpp
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172228715598.20810.4070818820406138421.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jul 2024 21:05:55 +0000
References: <20240725214029.1760809-1-sdf@fomichev.me>
In-Reply-To: <20240725214029.1760809-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
 haoluo@google.com, jolsa@kernel.org, kuba@kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 25 Jul 2024 14:40:29 -0700 you wrote:
> Jakub reports build failures when merging linux/master with net tree:
> 
> CXX      test_cpp
> In file included from <built-in>:454:
> <command line>:2:9: error: '_GNU_SOURCE' macro redefined [-Werror,-Wmacro-redefined]
>     2 | #define _GNU_SOURCE
>       |         ^
> <built-in>:445:9: note: previous definition is here
>   445 | #define _GNU_SOURCE 1
> 
> [...]

Here is the summary with links:
  - [bpf] selftests/bpf: Filter out _GNU_SOURCE when compiling test_cpp
    https://git.kernel.org/bpf/bpf/c/41c24102af7b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




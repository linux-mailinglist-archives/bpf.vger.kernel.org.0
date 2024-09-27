Return-Path: <bpf+bounces-40436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEE9988B61
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 22:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 055031F22566
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 20:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D7A1C3F2F;
	Fri, 27 Sep 2024 20:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umW6Zzo8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3184E1C3F23
	for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 20:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727469634; cv=none; b=SAI7bE0SHuZpDOcGR3dAwm9CkRkzzrcMOBhbYm0MfVySYn9bF9onIiPm2MmcjyQOjf+x+cMQnEgHbWIdCp197RRvXzJDqUyGWEIuGIRvG0O52v6VE8wSK3B6F0EWBp6zJrMWO8rl6B8PAoCeSi8H1EXtSMr9ra4EGgm72lELHB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727469634; c=relaxed/simple;
	bh=pIj3xkHSAw+f1E9whcuFl44Wva37X7BTLr2eBTmhsAU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U4rT9BfnL5XSn6bhd2ZCJBN6B/8Yg9MGiiMAsq25PCwUUa+e+5ERZBMN9n0CLlCO5bWEnk8bnGMaQAj8wUIUN3RR/h9Q4Jq+fDh8GxdgyOtTJksv429ZXk2ozwS6/+80/Yfy3gVIHZl0pB57BI6X+tFYBlgvgr4alLnuzzyP2OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umW6Zzo8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C909DC4CEC9;
	Fri, 27 Sep 2024 20:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727469633;
	bh=pIj3xkHSAw+f1E9whcuFl44Wva37X7BTLr2eBTmhsAU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=umW6Zzo8R5f9FLhcFc7BlLz9n70ny1wcvSdGjExW42H7NKR5GCLWTesM9/vWwBpAU
	 MZiFseyQ3eMgQOy6ZptEUP4RqFuMAUTKmuOIs9P4e9cJz2FUR4z6UHtjQUQuPztroV
	 3RBDfOA6zm5cjZYVP8NfjXx2FTsRJMeY/BOBpLz463fJLN7n+xRhChCC5YZYskVM1t
	 WtgIxkiezXeGz+XjszEJnBq/FW4DsOcrJyYPtQgfYiZRXCgBstDpn+CuJzUkAt9S0u
	 JsN19PLNymE1KhltALTCJVY+CkuwQlwsPZAjJU70xYMKHAhDK/bKxpqfgS+5OSWfgM
	 iOIqfJb78oL9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2463809A80;
	Fri, 27 Sep 2024 20:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tools/bpf:remove unused variable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172746963650.2077014.737000917798388061.git-patchwork-notify@kernel.org>
Date: Fri, 27 Sep 2024 20:40:36 +0000
References: <20240925100005.3989-1-zhujun2@cmss.chinamobile.com>
In-Reply-To: <20240925100005.3989-1-zhujun2@cmss.chinamobile.com>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 25 Sep 2024 03:00:05 -0700 you wrote:
> This variable is never referenced in the code, just remove it.
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>  tools/bpf/runqslower/runqslower.bpf.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - tools/bpf:remove unused variable
    https://git.kernel.org/bpf/bpf-next/c/fc7a391998b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




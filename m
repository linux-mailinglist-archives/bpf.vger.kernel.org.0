Return-Path: <bpf+bounces-53515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F650A55992
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 23:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0096B3AF5FC
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 22:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC01727602D;
	Thu,  6 Mar 2025 22:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/xZ67jG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656B01FCFFE
	for <bpf@vger.kernel.org>; Thu,  6 Mar 2025 22:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741299599; cv=none; b=mmwYeNzlvrfrVfZI0LkDB/jVWv/KpXqOtLyczQ4UdQDiWgO6JYHrJEYiiJn0M/YLuFzVATAIbNoYVEUMywYmSGoGhlXthW0zScOYkSaryIKW7oWTGpHcFuwGP6/MZBYobKYkkM/mUF5y0tCpduHjSDSDIy9x9bbzUQwV94kkYB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741299599; c=relaxed/simple;
	bh=FHD5TMfjzHOosyl5kKPX44KXFnH1Bx0aUNgjKPK9xYU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aQGlj5SqvqpLNfwmlXVAR9nKWZofwWUcmwDwocoFfVCGrWgXw4KkR+z0w1jG9fnCmjj8qU1qYiSmj/6m2IBb865RuhwQYJLk4YHoGeyL19+aHAOmJQOE1ENDOANdSM9RO8cH9z8a+zxeqPI0QIK/Y9W4xHI4NBKnmnDsI2euMTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/xZ67jG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F58C4CEE0;
	Thu,  6 Mar 2025 22:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741299598;
	bh=FHD5TMfjzHOosyl5kKPX44KXFnH1Bx0aUNgjKPK9xYU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C/xZ67jGs0+4QdZ459j/ewfqFAX7E0vlRX4Al2LmcrYDQAPcR8kpmlJxZEQJ/kgKh
	 uat0Trzd6co0QBgXspQ3T89hPWUBX2zyxseprZBWOTpFXx71x7DbgttjPdivCAsGA8
	 Q63e5iUucyA9R/rTvBIM9kdwxDp6rSpVMCrbMpfGVFNpw3cA4+8ZpRdNSqIrMAR6q3
	 Oam8/WjePACZFgodXkPzE++tQc4l9fBPtPXobllTvcFEKxxIW6TfLv1vlU+MhoSvZL
	 UIRDFbSSPz0HBAeDkjvz9InS2E7U9pJcqHfplsrcjmpIpL5N9JNaPBYIrA7lTxBnNT
	 Z3Y149w75wLlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D1C380CEE6;
	Thu,  6 Mar 2025 22:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 1/3] selftests/bpf: Clean up call sites of
 stdio_restore()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174129963226.1798157.3601232573248239109.git-patchwork-notify@kernel.org>
Date: Thu, 06 Mar 2025 22:20:32 +0000
References: <20250305182057.2802606-1-ameryhung@gmail.com>
In-Reply-To: <20250305182057.2802606-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 alexei.starovoitov@gmail.com, martin.lau@kernel.org, eddyz87@gmail.com,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed,  5 Mar 2025 10:20:55 -0800 you wrote:
> reset_affinity() and save_ns() are only called in run_one_test(). There is
> no need to call stdio_restore() in reset_affinity() and save_ns() if
> stdio_restore() is moved right after a test finishes in run_one_test().
> 
> Also remove an unnecessary check of env.stdout_saved in crash_handler()
> by moving env.stdout_saved assignment to the beginning of main().
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/3] selftests/bpf: Clean up call sites of stdio_restore()
    https://git.kernel.org/bpf/bpf-next/c/5cb4077d3ae8
  - [bpf-next,v5,2/3] selftests/bpf: Allow assigning traffic monitor print function
    (no matching commit)
  - [bpf-next,v5,3/3] selftests/bpf: Fix dangling stdout seen by traffic monitor thread
    https://git.kernel.org/bpf/bpf-next/c/15bfc10814b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




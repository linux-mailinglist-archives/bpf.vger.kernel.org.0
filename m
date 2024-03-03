Return-Path: <bpf+bounces-23264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 893A186F3C9
	for <lists+bpf@lfdr.de>; Sun,  3 Mar 2024 06:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C44211C20E16
	for <lists+bpf@lfdr.de>; Sun,  3 Mar 2024 05:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87798BE8;
	Sun,  3 Mar 2024 05:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osmSV6JL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E1B79DC
	for <bpf@vger.kernel.org>; Sun,  3 Mar 2024 05:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709445030; cv=none; b=mWjz2Gs5erO3WuOwCKv7eM5KSMqvjdNA1cA57rZgAIbqVCgULEaB97/3cQcFKInhvNxam6qy6imerJKFxuLvcWMvIDlZWXe6Z9FIfXrtSfeK2QObKRi0UTBxvCpC8NTY8YEM8vsF7bLP2WQSQOzzK5AfU0V1dEJsogZCdxGBUM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709445030; c=relaxed/simple;
	bh=UzWvbOd/h6ZcoOVWe9pcT0vzLOAgF/1IBV/UUSRIwNU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GBmsAAaRT/adguE8mdoRbEDc0N25HT1xr5JmN+lrXZnuUR3jvsp6eufxOAc3f1et74lT/H2yPEnlNR0MQ0GVVhF2z60GOs4koBRMjORHLE3sYDbRvFNTy3Bj14edc1QsLdWsK/sMmTEMCYd0MWDxVqlKSMtZ9u9BhLuudXvOGN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osmSV6JL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0BDEC43390;
	Sun,  3 Mar 2024 05:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709445029;
	bh=UzWvbOd/h6ZcoOVWe9pcT0vzLOAgF/1IBV/UUSRIwNU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=osmSV6JLjX0uGaalJwjKwCVdNrRFwgWpgoKWCN6SPawSlD7szteaUfSB4w2ciX2oO
	 O3x6zvEKESXzNzGipQwY0LRuANXKfhSEXGfVJbte/zfUQReDcZBhp7mfG0eVTeV6K7
	 KCifnxAk0Wn8fd+GgUD2kfhL7Ju5ULlIlvr5dr90BES/j1hSzgownVVO0tYC+NM1cX
	 xFmjeWp1JREUNgCJKJRet/qG/UBojM3QnIZBoBabazfDnsbfOrLxOKa3CeN+gzIrs0
	 iLAueYE3WjQYJnp2fxObOpRHFAhfEDenxl3m7b8q1UXqLoEeMGDQs4vkEhveaJmnSZ
	 +Pbc7J8ciSHMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8AE85D8C9A2;
	Sun,  3 Mar 2024 05:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf,docs: Rename legacy conformance group to packet
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170944502956.27671.2810776626875161279.git-patchwork-notify@kernel.org>
Date: Sun, 03 Mar 2024 05:50:29 +0000
References: <20240302012229.16452-1-dthaler1968@gmail.com>
In-Reply-To: <20240302012229.16452-1-dthaler1968@gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org, dthaler1968@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  1 Mar 2024 17:22:29 -0800 you wrote:
> There could be other legacy conformance groups in the future,
> so use a more descriptive name.  The status of the conformance
> group in the IANA registry is what designates it as legacy,
> not the name of the group.
> 
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf,docs: Rename legacy conformance group to packet
    https://git.kernel.org/bpf/bpf-next/c/2e0405f125b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




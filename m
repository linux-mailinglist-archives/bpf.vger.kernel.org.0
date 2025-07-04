Return-Path: <bpf+bounces-62364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A5EAF85A7
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 04:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EC114A77EA
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 02:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374DE1DF247;
	Fri,  4 Jul 2025 02:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHjJqLsz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B400C1DDA34
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 02:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751596819; cv=none; b=j95ejlmQoWsNPEiHwPLECOfIC0XOig+B7UVGbNWK5Cv7Bzq5tlsbgfZzaei/Ail5S8sWSquoZjcFkMMj7XLZPGJalZ2Veexg0RwvRzrmkdFmvHtoVnWr2ukJVjfKlfxHYca1XbM2p4qD1aW6nZSVlxjOJnAv9PabPFpOc9/dMm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751596819; c=relaxed/simple;
	bh=d64e7tVqdgMTKnVI9lPkoxIPYp275S47KOOQNSx+Z0c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lPgJQTxQNnYSLWa3eHSbCoCB3+vHYvJBkEMPXXvSKDJ8xQOQ8LejKmMqFVT3/6VIPiykqk/XFl/bJ0pB6glYtyQ2Ak3UasENUVHwzUT9SPMfgytJfOHTBxunFCAqmdXTkerX3/yiH8o3OXRWM3ydqJrA9/vHcVEpsuXKBZuJuxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHjJqLsz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51BBFC4CEF0;
	Fri,  4 Jul 2025 02:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751596816;
	bh=d64e7tVqdgMTKnVI9lPkoxIPYp275S47KOOQNSx+Z0c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DHjJqLszpVntNcRjCLZRUjeUAvWeNKVpJ+YWuQhgNAWN9LpWGjEy62m+b9C9Z1sAx
	 DpClTGxGznFapKoPGrYpz7XcCUEErZdi+GY3yWwdoNeQMCw/vJeGHAOrGMpTsFm5jR
	 Qi9zAhM98J6NRWOLIposV+wvWoX1jr40RG7tHpguushZGDy/tSgqpGAQUfw/XPAY+A
	 Pieco5aa7wQItipmfHBZF0pQ7qGxU1yWZert6WjupJoBfdRSNRvGTqKELlx/BvRlTr
	 sjk2V9dvnjNesYLRqfkUKW9UTB4wWAhA1Z9/JrnSoUuSXMJVsTGWKYGt0OXwGP4uF2
	 it7sv9Ga3Yg8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC59383BA01;
	Fri,  4 Jul 2025 02:40:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] bpf: Avoid warning on unexpected map for
 tail
 call
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175159684049.1682876.6755694378907316920.git-patchwork-notify@kernel.org>
Date: Fri, 04 Jul 2025 02:40:40 +0000
References: 
 <1f395b74e73022e47e04a31735f258babf305420.1751578055.git.paul.chaignon@gmail.com>
In-Reply-To: 
 <1f395b74e73022e47e04a31735f258babf305420.1751578055.git.paul.chaignon@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 3 Jul 2025 23:35:09 +0200 you wrote:
> Before handling the tail call in record_func_key(), we check that the
> map is of the expected type and log a verifier error if it isn't. Such
> an error however doesn't indicate anything wrong with the verifier. The
> check for map<>func compatibility is done after record_func_key(), by
> check_map_func_compatibility().
> 
> Therefore, this patch logs the error as a typical reject instead of a
> verifier error.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Avoid warning on unexpected map for tail call
    https://git.kernel.org/bpf/bpf-next/c/032547272eb0
  - [bpf-next,2/2] selftests/bpf: Negative test case for tail call map
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




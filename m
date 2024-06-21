Return-Path: <bpf+bounces-32749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BC5912C84
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 19:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CD361C23D42
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 17:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD2C168483;
	Fri, 21 Jun 2024 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHbxrbZx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FBA1C14
	for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718991630; cv=none; b=s/KWRWz3eVcf4Ji/WPPNRsluL/NSoq6+9qcnlt0uEOFpShDq8bBYs/5/9/NYMtb/4CuV2WVwLWh5tJcRqd0+x6pibPZVk63Wv+2dvO2wLxsGEDjGDS1/kOHal/0uJs7IYI2t74wsmbQpddKBHoHYvS52Ny9BrbLMEw648m2M3Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718991630; c=relaxed/simple;
	bh=xWCe/eRJH5n+f7D56mrTAoag6g/10QoFHrmDz8kGPqs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gauND0rPShvCvKeAv8GinzrMTnkbvWwFHW4zjpOKjTy1lRmu2JBh5WTTjADspwS/gPPuM5r5hVuctEgBw+NQViAyS5WaPyjavieZuUA2UBB/16evrrDZM/IJVRs4UkbquobjgQIgBjFepTbxjrYPvZBJ9YVOmupfPUufXCh7S/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHbxrbZx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94875C32781;
	Fri, 21 Jun 2024 17:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718991629;
	bh=xWCe/eRJH5n+f7D56mrTAoag6g/10QoFHrmDz8kGPqs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iHbxrbZxaYVenvBL3NKIODek7pxgwDiMPOLTHTBG718hTJ3YdqD2LenTMgKK/5SJX
	 xq+FDvWI6O+J4PVt5mmUa3n/O9vWTRD/0UJu60Zps2PkUHWoWo3j+UvoJUYKzp14nT
	 WarqnJFGibdgcLTgew8gI3VuTb+IPnW19Skk0QLIPQfT5c8+4TCbrzkgT2eetwSn+u
	 sbN97rudHbegdTi2RfzLPTYtQCb58sbAhzLg4LxNm56ihO0+nmLZW844ox4lNBjxnI
	 qt68cCwM1p7Z6s4PrOgHRLA7MSOcsEBN824dt19rhMJsM8Lfy+59infnOt/Wp+O+id
	 qdTWgLkDDh0Cw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7DC00C4332D;
	Fri, 21 Jun 2024 17:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Change bpf_session_cookie return value to __u64
 *
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171899162951.31009.9951440790233334654.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jun 2024 17:40:29 +0000
References: <20240619081624.1620152-1-jolsa@kernel.org>
In-Reply-To: <20240619081624.1620152-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
 haoluo@google.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 19 Jun 2024 10:16:24 +0200 you wrote:
> This reverts [1] and changes return value for bpf_session_cookie
> in bpf selftests. Having long * might lead to problems on 32-bit
> architectures.
> 
> Fixes: 2b8dd87332cd ("bpf: Make bpf_session_cookie() kfunc return long *")
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Change bpf_session_cookie return value to __u64 *
    https://git.kernel.org/bpf/bpf-next/c/717d6313bba1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




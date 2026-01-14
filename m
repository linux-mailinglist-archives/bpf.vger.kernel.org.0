Return-Path: <bpf+bounces-78835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB87D1C49C
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 04:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DBCF13002D36
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 03:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0002D73A6;
	Wed, 14 Jan 2026 03:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HD4Xz2Pw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E875284896
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 03:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768362217; cv=none; b=o4EzEPwM/13XI/h21gbwAP1248zrL+rU2Nna87iJVcCQMJM02AVNXqs6BT2JQX6aS2AE/0uvFrLfd4d0wkGGlEZkyqtN1jN0JRzGp0YspsucTDIsySrIuo8ptMOn5+1eWVdmmSJO7Q9ovgYqtrLjCRohmDXt1J+6oOxKErPnyrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768362217; c=relaxed/simple;
	bh=HF0lUnXpTmy4o5uL75eZvbqH2A0SFqflmNG9l/Ke+ek=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TKj6h1H3sUsmA5LI+WZwZxlYHTgAr3gmJ5FcdI1dW98AnNC8/EgkU20FSmcMW7VfM8/EcwIzYUj08+tAi56rqKsK5WpdnFyjcXRnw55x2+iZQWuMALJGxFtaDqqtw0/+ErB1R2rGvTAiZtrC10BbJTZs7ux8egJFpnM1rUzP0g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HD4Xz2Pw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D212AC4CEF7;
	Wed, 14 Jan 2026 03:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768362216;
	bh=HF0lUnXpTmy4o5uL75eZvbqH2A0SFqflmNG9l/Ke+ek=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HD4Xz2PwlnyIm396H2+7sHjIbeblEba9EXcHKG4P2M6SAyJCOgfeAS8fpMh5eBGCv
	 eqJ0EMJXWDLcz/9zZN3rgSdq6dc8Z4l5PK30cFxtJd+wG2HS55hnkM1MrwaEMAZDZ6
	 GS2FjBEWG85d5v1mZdvL37m+zsqRo+w1agx4B2bUobGcLjU7kggy0CBHKKaQuTh0tL
	 YEXsjKE1bgjDQlm59d98ZeMKFaCWglmEJFahE7LewI8u+EWLkjvp1J6ZALJcBdPL86
	 gqrUULxAsyWyUiKVP9OBYOu99NTKMgM8/tWePLgI+A5LskJt8aDZ2ffpVJJboKjy95
	 hlam1voh+z9uw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B7AD3808200;
	Wed, 14 Jan 2026 03:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] properly load insn array values with offsets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176836201004.2575016.983479775559992595.git-patchwork-notify@kernel.org>
Date: Wed, 14 Jan 2026 03:40:10 +0000
References: <20260111153047.8388-1-a.s.protopopov@gmail.com>
In-Reply-To: <20260111153047.8388-1-a.s.protopopov@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 11 Jan 2026 15:30:44 +0000 you wrote:
> As was reported by the BPF CI bot in [1] the direct address
> of an instruction array returned by map_direct_value_addr()
> is incorrect if the offset is non-zero. Fix this bug and
> add selftests.
> 
> Also (commit 2), return EACCES instead of EINVAL when offsets
> aren't correct.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] bpf: insn array: return proper address for non-zero offsets
    https://git.kernel.org/bpf/bpf-next/c/e3bd7bdf5ffe
  - [bpf-next,2/3] bpf: insn array: return EACCES for incorrect map access
    https://git.kernel.org/bpf/bpf-next/c/7e525860e725
  - [bpf-next,3/3] selftests/bpf: add tests for loading map values with offsets
    https://git.kernel.org/bpf/bpf-next/c/c656807675e0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




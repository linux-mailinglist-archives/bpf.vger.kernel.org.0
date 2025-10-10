Return-Path: <bpf+bounces-70769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B3DBCE34D
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 20:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 96709351939
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 18:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C88680604;
	Fri, 10 Oct 2025 18:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5WdI/xq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E752B21CC61
	for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 18:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760120422; cv=none; b=DLRLjwPWE56A9euJrTgp8en+Z0tlVwbtI0GqDjXHvJoVVimhEgYp5NdINK/AFBb0/C+bwUxnhY40dNpzY570c6XKXQ5f9jQigYJdOoPwX0buaQLJ/kZXEEYdtAThSPiHgU0iX9nThcncMI9768280jkOQoDmBqcKx3Z1dcXqyps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760120422; c=relaxed/simple;
	bh=Iej66zE4EVx5SLpM8hNCaltvQG3Fo3guI33wI5wXAx0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PWopob3z0mmr/tLn48JUCg+M8ZosUBLy0fQjdySiKmsigDOMgFDoDtafyIKkWUZo6zzjMMgUt7yAAURUqz+KmYY+xACogwdO1GYOkesS58e7vcW1Kkx2PUnB31RcDtIZ9DI0nvqq4opCzrn059JTnpBMvLAY9fSbX8MPxk7nfYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5WdI/xq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E7EC4CEF1;
	Fri, 10 Oct 2025 18:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760120421;
	bh=Iej66zE4EVx5SLpM8hNCaltvQG3Fo3guI33wI5wXAx0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D5WdI/xqgJ+8tX07vA1hjHYswtXwZTwQqgqS6ZpnbQ1ncPFdE3Rf4xrs1m5Edp+oY
	 BQXmB30wJ2pRpQYEVopAqMppjFpb7wxJ5jQK5JP3UiRbNoFIOe5HPql6lQ+mtPMn/h
	 mQrrvTCrDmwhD9bBby1SD2B+t7SHkWUz26AgtZMcaqqKir9bTj+BJXVJP/D/sY5s4b
	 A0F3H4iUhEhZM2ZZzAxHZZ8zl45bEqXq/WNtFkaxRQ5cpR0M3tRxV6wWiYsXYzGPBg
	 QhsQKJXLFJodqt+fKd3ANtcGfQZkMfPC6ZJSCqzoq3TWuYJWlclm5dsi4hkywFu43w
	 QHVw6oaE/56nA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34AC33809A00;
	Fri, 10 Oct 2025 18:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 1/3] bpf: verifier: refactor bpf_wq handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176012040902.1071702.17971777784759538744.git-patchwork-notify@kernel.org>
Date: Fri, 10 Oct 2025 18:20:09 +0000
References: <20251010164606.147298-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20251010164606.147298-1-mykyta.yatsenko5@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, yatsenko@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 10 Oct 2025 17:46:04 +0100 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Move bpf_wq map-field validation into the common helper by adding a
> BPF_WORKQUEUE case that maps to record->wq_off, and switch
> process_wq_func() to use it instead of doing its own offset math.
> 
> Fix handling maps with no BTF and non-constant offsets for the bpf_wq.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/3] bpf: verifier: refactor bpf_wq handling
    https://git.kernel.org/bpf/bpf-next/c/5f8d41172931
  - [bpf-next,v4,2/3] selftests/bpf: add bpf_wq tests
    https://git.kernel.org/bpf/bpf-next/c/bca2b74ea9a8
  - [bpf-next,v4,3/3] bpf: extract internal structs helpers
    https://git.kernel.org/bpf/bpf-next/c/4c97c4b149a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




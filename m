Return-Path: <bpf+bounces-29103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1089A8C0270
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 19:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1615B20A75
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 17:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A81DF71;
	Wed,  8 May 2024 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbwwUmmC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3138828
	for <bpf@vger.kernel.org>; Wed,  8 May 2024 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715187631; cv=none; b=J3bvQtTA8czk+PvOp4DJDOaRYmMwNAexo+xr5mlaskn+iphHr8+O2pmpt8yHv4NlfGm/UgSwRLvfAHLxtr51YscTKN5Ipc2o0+64AGvXE8yn7rbMffTeTSIHTknFR2zMbjmtsihPBfkIaxRCgjUEF5k8eXx7X3tHHJ1dyuB77FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715187631; c=relaxed/simple;
	bh=SwNPI9B+dJcvCuleLNEFvid7uclJPe4YXd9JvIMr+qU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DwNJ677EaKEHMaMeHz2qmLEqVDfE/i3qh5WpGqXewK6jEvLm/Ro9zAf1Q1DF65z9m4aAFozHC4oCtsjLXkHj39jda9Xr4k4+sq1coitvJjmwaKSxtS2P/Sv8kFLBuK40kQVpREZ4oBwbK8gvcFZhMkik0d0V/FQXz/sz6BLLOfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbwwUmmC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE7C7C2BD11;
	Wed,  8 May 2024 17:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715187630;
	bh=SwNPI9B+dJcvCuleLNEFvid7uclJPe4YXd9JvIMr+qU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AbwwUmmClIzuzTt78p32FXnkgq8ZN3Enyd4H47RrrTp2rRcCN8mFsamUtwMfQyF+L
	 v2Iu3OkA30q7my0x0SYq5lLEaobDGgUN+MDzS5dYl5xsFZ7pxLq2TAEfKnoaj2UKJp
	 oWINA7JumhXO5lNANxsCMc0tw9pZ0jHCvdzsf5TGFbS99Moei8TBRfsLM51Cp8zm7Z
	 RinAjGIeSn4/j8Dlz8YVt2Z6BbgrLkG4TJwIt6YD64iEl4y3tFXZi6oKzjesNX+ARE
	 hZ6F2l/wz/TQaRFR8hEuKqMCd6FrcA6MZ3MSOJvqAMTK+K1FdtkiMBb7lOTbPO3nr/
	 fGhv2BU2XN9lw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BC0E0C43331;
	Wed,  8 May 2024 17:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next V2] bpf: avoid uninitialized warnings in
 verifier_global_subprogs.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171518763076.20768.13274880727599956792.git-patchwork-notify@kernel.org>
Date: Wed, 08 May 2024 17:00:30 +0000
References: <20240507184756.1772-1-jose.marchesi@oracle.com>
In-Reply-To: <20240507184756.1772-1-jose.marchesi@oracle.com>
To: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, david.faust@oracle.com, cupertino.miranda@oracle.com,
 yonghong.song@linux.dev, eddyz87@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  7 May 2024 20:47:56 +0200 you wrote:
> [Changes from V1:
> - The warning to disable is -Wmaybe-uninitialized, not -Wuninitialized.
> - This warning is only supported in GCC.]
> 
> The BPF selftest verifier_global_subprogs.c contains code that
> purposedly performs out of bounds access to memory, to check whether
> the kernel verifier is able to catch them.  For example:
> 
> [...]

Here is the summary with links:
  - [bpf-next,V2] bpf: avoid uninitialized warnings in verifier_global_subprogs.c
    https://git.kernel.org/bpf/bpf-next/c/cd3fc3b97821

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




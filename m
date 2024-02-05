Return-Path: <bpf+bounces-21255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A1D84A991
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 23:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B952C28F201
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 22:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7C428E22;
	Mon,  5 Feb 2024 22:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/Xy5boo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA81481AE
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 22:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707173427; cv=none; b=GSFGeDtpwvSoTzzNQcq4FZj/kjziVRuRNT04p1H9N/MmSo1Hm5xhvvCphquzg9MiPYtCd4NPdCBCR3sSgyHXTU0Wq73yzYNZnGPhkPTmDzjZd56Abh8ujS7i+m67cjwzB6D1hifXJZpaHBo2y9OwNx7GNLJXi3aEkxVTRYjRAh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707173427; c=relaxed/simple;
	bh=rAHOKP8KtPbTXvStvIJYx3dDZxTDJvu9UXUS4gjrPHE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KskwXXYvT92nq4pp0CAJ17H3xe7LYlq6+q9xpOwn55ePbexNRmObgFbzUTGoT08D7L6+e+6orPltjolVxda3RMwrgLWLa7UcN19mwItGQlNyeCbsUVVBi/9CtUjivivhyDLQh4sC+tWJxEO6tZWp5QuL78HgyBAudnv1ctqvkOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/Xy5boo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5409C43390;
	Mon,  5 Feb 2024 22:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707173426;
	bh=rAHOKP8KtPbTXvStvIJYx3dDZxTDJvu9UXUS4gjrPHE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V/Xy5boob9A1cnxkQVIlKUYfQ5B6IwhPtlYape7CxKaBM9HlFiWebV/JFKxyLgmv0
	 KN0r+a8ip35/cvwW24+dpudmwEPT/WmPij/cevEU4qj4GL2U2SJqMuL0FmR/RDez7g
	 3Tkl2mMvyNxddpeeBvXUxKtQt+Itn/OYGrX0HwJZjub7LTMjcEkfJddNKDYmHsxrHH
	 DoI+SPEj+MFuvfGWKyR3eEEvlg7L7qK7RYYoYDytruBisJcVf7NsIS88ZVmpKV99Y9
	 G39mpfCGprxUCinMvpieuJeDy/VElO5WKYC78RdD76I9ZDWqiIkH0YxV3wad1O0yS5
	 H6TPHu4BvHWEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C9C5FE2F2ED;
	Mon,  5 Feb 2024 22:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] bpf,
 docs: Expand set of initial conformance groups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170717342682.31346.9551666326456032641.git-patchwork-notify@kernel.org>
Date: Mon, 05 Feb 2024 22:50:26 +0000
References: <20240202221110.3872-1-dthaler1968@gmail.com>
In-Reply-To: <20240202221110.3872-1-dthaler1968@gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org, dthaler1968@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  2 Feb 2024 14:11:10 -0800 you wrote:
> This patch attempts to update the ISA specification according
> to the latest mailing list discussion about conformance groups,
> in a way that is intended to be consistent with IANA registry
> processes and IETF 118 WG meeting discussion.
> 
> It does the following:
> * Split basic into base32 and base64 for 32-bit vs 64-bit base
>   instructions
> * Split division/multiplication/modulo instructions out of base groups
> * Split atomic instructions out of base groups
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] bpf, docs: Expand set of initial conformance groups
    https://git.kernel.org/bpf/bpf-next/c/2d9a925d0fbf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <bpf+bounces-47998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49537A03031
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 20:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BFF8163A09
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 19:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2EA1DF25C;
	Mon,  6 Jan 2025 19:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYYBiHWR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB05C1DED5A
	for <bpf@vger.kernel.org>; Mon,  6 Jan 2025 19:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736190608; cv=none; b=lRj6KUapbCELKgXPd7qpGgzXXhFV45AIknSIzOzrU1o9fDFET70HgUfk5VrSeMup6RN6iGF6JqYj4dUE0ahFP+/Z9ffI5BnvvFcEIu8TsXHvD6o0xUOIdHFkKBYe7ON48BZKxHusiJfI5vOa9YmzkqX6lOGA6tnnXPPeabsLlBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736190608; c=relaxed/simple;
	bh=j5h/nWbd2uzAjPsUcasofHbO5mXvgmxIkxtko9ewQzw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f37+XXCmL9nq+0GCoHZK5OIFxOjy/v1eE0fw5SAdlAonWrEUnvUft6CR6gvhkH6OkZXq48/ZVnHoMRbztbxpDlLkRQY3AzPjV8uLWk/qfPi97wH8h/aCK1NKIJSgxOgfohmwtZoX9aRFO5evELlcw4CHIMCnwitM/ZNZEaQsfew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYYBiHWR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54191C4CEDF;
	Mon,  6 Jan 2025 19:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736190608;
	bh=j5h/nWbd2uzAjPsUcasofHbO5mXvgmxIkxtko9ewQzw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dYYBiHWRWZ/tg+QUr1kagWxsVR2Sr2vRWn0XT/aA5sTuDlbQr/52oJgv1hGgYJnhs
	 ibRYJGrL3DargYbJoKQuOFLCXKb1addHJ2aavnP1wmP4XZzi38GAJTClERznNhrgf1
	 Wr5JrSPwVG+3AHIzLpSrLDLq6hKD92tMClxS9RGg5d7/tR8/kVZ+mWS9OG4Xk4LKmD
	 wXGhFZSmCLVAN3uRTnDnNgOyjEhq7mYVacoJJIu1vbLEK/lHl6kPGOP66IiS92oOc/
	 J2ea+mEwZjBruQz45mLhgIT35o4Ri9rstfFoXswL4SFkfVu7xGYjkfcMvgzvaAoiJ8
	 D3pnx2kufGj0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD59380A97E;
	Mon,  6 Jan 2025 19:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] bpf: Allow bpf_for/bpf_repeat while holding spin
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173619062952.3592870.1339065672417521709.git-patchwork-notify@kernel.org>
Date: Mon, 06 Jan 2025 19:10:29 +0000
References: <20250104202528.882482-1-emil@etsalapatis.com>
In-Reply-To: <20250104202528.882482-1-emil@etsalapatis.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat,  4 Jan 2025 15:25:26 -0500 you wrote:
> From: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
> 
> In BPF programs, kfunc calls while holding a lock are not allowed
> because kfuncs may sleep by default. The exception to this rule are the
> functions in special_kfunc_list, which are guaranteed to not sleep. The
> bpf_iter_num_* functions used by the bpf_for and bpf_repeat macros make
> no function calls themselves, and as such are guaranteed to not sleep.
> Add them to special_kfunc_list to allow them within BPF spinlock
> critical sections.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] bpf: Allow bpf_for/bpf_repeat calls while holding a spinlock
    https://git.kernel.org/bpf/bpf-next/c/512816403ece
  - [v2,2/2] selftests/bpf: test bpf_for within spin lock section
    https://git.kernel.org/bpf/bpf-next/c/87091dd986db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




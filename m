Return-Path: <bpf+bounces-43919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1A09BBD30
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 19:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F9251F24131
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 18:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68401CACDE;
	Mon,  4 Nov 2024 18:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/+cmR3q"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562D118622;
	Mon,  4 Nov 2024 18:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730744421; cv=none; b=SFsrF3x/XVLsgJpgsRFkDXO2mMBeB9Js1z018SqpXxvM2yGBwNiFDpfI7k88KwKdrDduxd2pXX+TyaY4mugj8JOGwWOYse1YTY5dfLIboynv5gG62fgRU7Pv7OnmiLvzVjjJE9OTYMh820vo7pQxk8xxg3by94YxhHoTIcYwrUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730744421; c=relaxed/simple;
	bh=F8uElrZ+VNqFVI4ghXyedghQ3+1P4dRl46TdxjZcbsI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nC/uBcovsiLfh7vmALKu04F/uyH38yYoi0uyvm3lrCcJcXT5p7uoF1cIddNTOwoYFKZV/z0SGHMuZ3BdB5Wa/fzY7WXfg798hioA0XO7KdtsWHPYL+CzBlILYtckchNzXIhhO9o5LesKirnE1TJpwdg94vvgYXYQoCyKeT0ZLCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/+cmR3q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223E2C4CED0;
	Mon,  4 Nov 2024 18:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730744421;
	bh=F8uElrZ+VNqFVI4ghXyedghQ3+1P4dRl46TdxjZcbsI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C/+cmR3qfr07UOvk1RRZItg58ksIHU0Y+B6ZU6/7aMIVclTDUwsFNH5jxa0WqD6cW
	 ZMtAKbXuVpp1uZ7fqk7NwRRtm0025nUrxHDyvl0g0zv1zKQYK18sAQXGgQWUc49k31
	 naDd1Fv9SEN4imQeEe8Egs9goCpH3hQG9JvU1xmCeK59skyd71lFt/KR1UOJDneneJ
	 rbfaa6dkzZ0AkHl0iut39Y658+VQN6X9LyW3by8kSBc8a6a+ETpuxsW0aJihRe/PIP
	 oNXSuZwRTAuppVQh/OoB+w+DOkDhyFOYgPlZ4UOX8z+oj7/hkOvNC/BYRlSYU9HK/w
	 IXz49mHSglSTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC1B13805CC0;
	Mon,  4 Nov 2024 18:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] include: btf: Guard inline function with CONFIG_BPF_SYSCALL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173074442976.4161292.16386221719545154098.git-patchwork-notify@kernel.org>
Date: Mon, 04 Nov 2024 18:20:29 +0000
References: <20241104060300.421403-1-alistair.francis@wdc.com>
In-Reply-To: <20241104060300.421403-1-alistair.francis@wdc.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, jolsa@kernel.org,
 haoluo@google.com, sdf@fomichev.me, kpsingh@kernel.org,
 john.fastabend@gmail.com, yonghong.song@linux.dev, alistair.francis@wdc.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  4 Nov 2024 16:03:00 +1000 you wrote:
> The static inline btf_type_is_struct_ptr() function calls
> btf_type_skip_modifiers() which is guarded by CONFIG_BPF_SYSCALL.
> btf_type_is_struct_ptr() is also only called by CONFIG_BPF_SYSCALL
> ifdef code, so let's only expose btf_type_is_struct_ptr() if
> CONFIG_BPF_SYSCALL is defined.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> 
> [...]

Here is the summary with links:
  - include: btf: Guard inline function with CONFIG_BPF_SYSCALL
    https://git.kernel.org/bpf/bpf-next/c/9a783139614f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




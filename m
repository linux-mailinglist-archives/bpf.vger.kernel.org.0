Return-Path: <bpf+bounces-79352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F48D38993
	for <lists+bpf@lfdr.de>; Sat, 17 Jan 2026 00:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4CAC2303EB40
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 23:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1443030E0D8;
	Fri, 16 Jan 2026 23:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtVT/2M5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905B53019B2
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 23:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768604618; cv=none; b=tWNFL8KXVRJqmQaESytg3jmThtCvVfeQgSvxjOcG/b4afNTfdnOUrmHssg7f8h9BRROKkz31bPElHY7xOnwVSKOX9wWVznEVw0jMLbetLW5sWK223YT3jn0f2Aabq9bkd+tU/HMMSu+rV4DMVjtexz4RAnWBUNqzzuWmMx2ETZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768604618; c=relaxed/simple;
	bh=Vkh+UwJp56ptH+RYuyODSoFzZHmOgI8ICQhazry++y0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l70yomcfq9DDNB4NfLOvOPz3p0kmaQtzOMN4enRNFX1O8mQIDFf47K4ohj1K6EDzBr6QsDYuFpcwtRJVNUGTMkCeTUGKeRkqf6Is29c74QaNhZAJORUx0exFkgrV6bxIWRlbpEpk7GdcyBieNOXgl8TSQCMoQlbI+5lFPZD2vg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtVT/2M5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56160C116C6;
	Fri, 16 Jan 2026 23:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768604618;
	bh=Vkh+UwJp56ptH+RYuyODSoFzZHmOgI8ICQhazry++y0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dtVT/2M5SjvFHRhVw0CLkeoOPQgA66wfbV69q/gOVV++5MLoQkzMJV2YzAt7pjaUH
	 hjeyEn4ITYDWeM2p+FfNUEX/TtCgATN/DVLz4hCdWJYgATHiM9w55JHIAe0560xqM7
	 JKwJ2/79iuUDZwXskax4gucyRedOx3BGKASbHd104QAjZ2Z7nWUFdUir8/h4lrBBch
	 NSMc9sf0NVAQKpqT8F04QXTza7azR+6I9w+HdBIs1qndDqDo/O96YTT03d2xE41WaA
	 BhOR0PRIbZ0n6is+1WrGMGHNEN1tg3+22l4gB4TY/p/pe4fWl+Bxnus7DWHB1wwn8k
	 iiWTRSBGN7/tA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2AFE380CECB;
	Fri, 16 Jan 2026 23:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] selftests/bpf: Support when CONFIG_VXLAN=m
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176860440952.828763.9055728043184297613.git-patchwork-notify@kernel.org>
Date: Fri, 16 Jan 2026 23:00:09 +0000
References: <20260115163457.146267-1-alan.maguire@oracle.com>
In-Reply-To: <20260115163457.146267-1-alan.maguire@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 alexis.lothore@bootlin.com, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 15 Jan 2026 16:34:57 +0000 you wrote:
> If CONFIG_VXLAN is 'm', struct vxlanhdr will not be in vmlinux.h.
> Add a ___local variant to support cases where vxlan is a module.
> 
> Fixes: 8517b1abe5ea ("selftests/bpf: Integrate test_tc_tunnel.sh tests into test_progs")
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  .../selftests/bpf/progs/test_tc_tunnel.c      | 21 ++++++++++++-------
>  1 file changed, 13 insertions(+), 8 deletions(-)

Here is the summary with links:
  - [bpf] selftests/bpf: Support when CONFIG_VXLAN=m
    https://git.kernel.org/bpf/bpf-next/c/47d440d0a5bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




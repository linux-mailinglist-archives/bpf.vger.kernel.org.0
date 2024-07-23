Return-Path: <bpf+bounces-35428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E631B93A813
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 22:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 157A41C225DE
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 20:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50E6143C4B;
	Tue, 23 Jul 2024 20:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYbbJSAp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2457B13C823;
	Tue, 23 Jul 2024 20:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721766636; cv=none; b=QXnjbZ2ANe8ounoprhdIP0eH+TjH6WMgn7jWWdAo2epvQsP/Xtfn1oH27S7CmG0u2nNkT744mPETQ+VsxITo+4TIuQKEEhTg4YFu4OyKQyD/Zfc69aEhccuevoI/D/oGPYxAJXYyHZrtOgIH4KxCdxDUPVSyXolLRI7h8oCjqLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721766636; c=relaxed/simple;
	bh=l8Nlo0+S0lvry3MI5IHMaoyWT4SOOKiV/71Ugpz0nXY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T7pVcZVPaBSQga9FlYrmXWJ6PhEXr4jcNTPD3KWBBzVjDgztxB8IiZR5EdCZZNPIceyx9jrP5Y8lscaP6oA471VmkKG1IuC8QqM/ReFKvmIHTVeaZS+jbzAWNsvmjvLjgwoyBK+zFc3oZlxfwLhw2W05hmnNnefsnp8M3/HWAmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYbbJSAp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5104C4AF0E;
	Tue, 23 Jul 2024 20:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721766635;
	bh=l8Nlo0+S0lvry3MI5IHMaoyWT4SOOKiV/71Ugpz0nXY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lYbbJSApwul5V5kh8UkmFOUjvQLVNnord/3nHffW839bjSZWYOnBNQeC8fEBObRhb
	 fDrW0skgmUjImX5+FPwAdtaNN7sR6sd+SiamDNmOhaz6UnVTB+K6as1kPuANHlGZqC
	 b1Cy8WSQWHGq5nADLeJofozNNPS/vZ28vJcLLqlEzUBv3UI0iYfging5yvLXp92QxO
	 bAzi3Dvlh1AoyArJMyvPFhQmYUbJWWJ7i9EqS4sc/BQzmyn7rDggsnZVqcHDwh4Jfs
	 /lovifW2/scRc/sd2/vL1OV+uBjokSFzTaPzwIm7WLx9oYPM48zM+QwM7RtTrePjqN
	 xcd+1wpr/DNAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C5C2C43140;
	Tue, 23 Jul 2024 20:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] selftests/bpf: fix compilation failure when
 CONFIG_NET_FOU!=y
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172176663563.27466.768477846355169392.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jul 2024 20:30:35 +0000
References: <20240723071031.3389423-1-asavkov@redhat.com>
In-Reply-To: <20240723071031.3389423-1-asavkov@redhat.com>
To: Artem Savkov <asavkov@redhat.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 23 Jul 2024 09:10:31 +0200 you wrote:
> Without CONFIG_NET_FOU bpf selftests are unable to build because of
> missing definitions. Add ___local versions of struct bpf_fou_encap and
> enum bpf_fou_encap_type to fix the issue.
> 
> Signed-off-by: Artem Savkov <asavkov@redhat.com>
> 
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] selftests/bpf: fix compilation failure when CONFIG_NET_FOU!=y
    https://git.kernel.org/bpf/bpf-next/c/c67b2a6f3b84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <bpf+bounces-11556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1147BBE97
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 20:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 776F81C209A9
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 18:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE2137C87;
	Fri,  6 Oct 2023 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8Du0YO7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C586E2AB3B
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 18:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D26CC433CB;
	Fri,  6 Oct 2023 18:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696616428;
	bh=mX9XAvg1k8szLzkED8DMJsitLEGM236WzCfmwriOQ/8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D8Du0YO7lHhuV660RCeJZOt/cMfSd6Hqdzf/v0otyH4d3RKG6Vd8eqVvyg1bogM0Y
	 1kBiuTdorc1J9c85E7uPVGQTTXLq1c4HBZBvpG+F3joAMJazgWSAcohEp52y/8MheE
	 fizll02lGczU95eVz1I2MwmDLxXWiUvdQFxoHCxoDZo6rQ+7IbUaX84iosLf6+/LvI
	 vqJUNOxL1JnOid1zZX4OPaTp98ci23YunhJoo/MG9nFOgp6F++9Gih5v4VJUuroY1p
	 jPm+C9V6GvlA6v6eikWT1eny5lV4uzaezfF11rkJVXVk7WmiQUe84XjQdd9cwSq9HC
	 rnFY2foZDZ1Jg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2FF1DE22AE3;
	Fri,  6 Oct 2023 18:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 1/3] selftests/bpf: fix compiler warnings reported
 in -O2 mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169661642819.9586.14987488513242535218.git-patchwork-notify@kernel.org>
Date: Fri, 06 Oct 2023 18:20:28 +0000
References: <20231006175744.3136675-1-andrii@kernel.org>
In-Reply-To: <20231006175744.3136675-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com, jolsa@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 6 Oct 2023 10:57:42 -0700 you wrote:
> Fix a bunch of potentially unitialized variable usage warnings that are
> reported by GCC in -O2 mode. Also silence overzealous stringop-truncation
> class of warnings.
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/3] selftests/bpf: fix compiler warnings reported in -O2 mode
    https://git.kernel.org/bpf/bpf-next/c/925a01577ea5
  - [v2,bpf-next,2/3] selftests/bpf: support building selftests in optimized -O2 mode
    https://git.kernel.org/bpf/bpf-next/c/46475cc0dded
  - [v2,bpf-next,3/3] selftests/bpf: don't truncate #test/subtest field
    https://git.kernel.org/bpf/bpf-next/c/0af3aace5b91

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




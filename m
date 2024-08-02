Return-Path: <bpf+bounces-36313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6809463E9
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 21:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE651C20D95
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 19:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCAD24B28;
	Fri,  2 Aug 2024 19:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPxy6wFL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE60A1ABEA5
	for <bpf@vger.kernel.org>; Fri,  2 Aug 2024 19:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722627032; cv=none; b=C49eQiIbqR/U835Pu+U3nDFqi3LH0npc5hZIhSEvd2e+SbmqsVuLW85vwFclfnPjgt1+0gC73fcRmmJrcX+72BTrU0tEkkkc4BhZ03vvXW/NXmclH+/GLVM1hf7k8rvAcvmmWriKqFMc32/XcjHG/0rjdyH5IMyd7GPYdudrKGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722627032; c=relaxed/simple;
	bh=PgM65/nXcDvWPwxoM6zb/kSzEk8VYZ/lLNE6RSRq5eg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M66wTZBg1MlfOnn+jENRB1naxwOqHhV2n6HUFA0yUT5iPSPXTR58IrKC/aH9KfX0h2bBmD8P0/Bh8ur1glcINT2GC8sRBmHGEI+m+OYjsk/VTY5XuNLQR2MsWZZf4cPM95jNXzjFnoLfwvdBziiULoL41OMAQES2JT7nSGsr6ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPxy6wFL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FE0AC4AF0A;
	Fri,  2 Aug 2024 19:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722627031;
	bh=PgM65/nXcDvWPwxoM6zb/kSzEk8VYZ/lLNE6RSRq5eg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NPxy6wFLrFwR7w75l7GVNUtobJ7FE0urSMmReKRc+CsbxMoAboAIl1DT2ueBR+FuG
	 T8nAunWm0kaBg1mSw3Ux7P81sKB3ybnAXMd06hw/AisfY/zbm/u9vYY/4h5x5BlW9/
	 L+fSqAEUaLsQ0nPSca6VuRJQsxghJTP81o3r6QSRbtaM2cUpfGwaTLMhrHabcEQLGD
	 tYWZiExZlCGbepV9RSw/jX9o38/JImIPEN+FAuwaFO4z/MJuRHy9aY/mWNkg9N90YA
	 s3vSpcpzLq36g2nuayKoaANTTEMwljmV+RuaZAkm4yIEm4+yKZP5PNkN4aZ9xNb13N
	 6zjsopZ4hGGbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5EB69D0C60A;
	Fri,  2 Aug 2024 19:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix a btf_dump selftest failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172262703138.21946.6081334647905402907.git-patchwork-notify@kernel.org>
Date: Fri, 02 Aug 2024 19:30:31 +0000
References: <20240802185434.1749056-1-yonghong.song@linux.dev>
In-Reply-To: <20240802185434.1749056-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org,
 kuba@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri,  2 Aug 2024 11:54:34 -0700 you wrote:
> Jakub reported bpf selftest "btf_dump" failure after forwarding to
> v6.11-rc1 with netdev.
>   Error: #33 btf_dump
>   Error: #33/15 btf_dump/btf_dump: var_data
>     btf_dump_data:FAIL:find type id unexpected find type id: actual -2 < expected 0
> 
> The reason for the failure is due to
>   commit 94ede2a3e913 ("profiling: remove stale percpu flip buffer variables")
> where percpu static variable "cpu_profile_flip" is removed.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix a btf_dump selftest failure
    https://git.kernel.org/bpf/bpf-next/c/3d650ab5e7d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



